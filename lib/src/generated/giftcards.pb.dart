///
//  Generated code. Do not modify.
//  source: giftcards.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class GiftCard extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GiftCard', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountId')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'brandId')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'brandName')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cardNumber')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pin')
    ..a<$core.double>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'originalAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currentBalance', $pb.PbFieldType.OD)
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..aOS(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'purchaseDate')
    ..aOS(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'expiryDate')
    ..aOS(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recipientEmail')
    ..aOS(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recipientName')
    ..aOS(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOS(17, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'qrCode')
    ..aOS(18, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'metadata')
    ..aOS(19, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt')
    ..aOS(20, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedAt')
    ..hasRequiredFields = false
  ;

  GiftCard._() : super();
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
    if (cardNumber != null) {
      _result.cardNumber = cardNumber;
    }
    if (pin != null) {
      _result.pin = pin;
    }
    if (originalAmount != null) {
      _result.originalAmount = originalAmount;
    }
    if (currentBalance != null) {
      _result.currentBalance = currentBalance;
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
    if (qrCode != null) {
      _result.qrCode = qrCode;
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
}

class BuyGiftCardResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'BuyGiftCardResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOM<GiftCard>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'giftCard', subBuilder: GiftCard.create)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'newBalance', $pb.PbFieldType.OD)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  BuyGiftCardResponse._() : super();
  factory BuyGiftCardResponse({
    GiftCard? giftCard,
    $core.double? newBalance,
    $core.String? message,
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
}

class RedeemGiftCardRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RedeemGiftCardRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cardNumber')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cardPin')
    ..hasRequiredFields = false
  ;

  RedeemGiftCardRequest._() : super();
  factory RedeemGiftCardRequest({
    $core.String? accountId,
    $core.String? cardNumber,
    $core.String? cardPin,
  }) {
    final _result = create();
    if (accountId != null) {
      _result.accountId = accountId;
    }
    if (cardNumber != null) {
      _result.cardNumber = cardNumber;
    }
    if (cardPin != null) {
      _result.cardPin = cardPin;
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RedeemGiftCardResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOM<GiftCard>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'giftCard', subBuilder: GiftCard.create)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amountRedeemed', $pb.PbFieldType.OD)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'newBalance', $pb.PbFieldType.OD)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  RedeemGiftCardResponse._() : super();
  factory RedeemGiftCardResponse({
    GiftCard? giftCard,
    $core.double? amountRedeemed,
    $core.double? newBalance,
    $core.String? message,
  }) {
    final _result = create();
    if (giftCard != null) {
      _result.giftCard = giftCard;
    }
    if (amountRedeemed != null) {
      _result.amountRedeemed = amountRedeemed;
    }
    if (newBalance != null) {
      _result.newBalance = newBalance;
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
}

class TransferGiftCardResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TransferGiftCardResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
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

class GetGiftCardBalanceRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetGiftCardBalanceRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cardNumber')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cardPin')
    ..hasRequiredFields = false
  ;

  GetGiftCardBalanceRequest._() : super();
  factory GetGiftCardBalanceRequest({
    $core.String? cardNumber,
    $core.String? cardPin,
  }) {
    final _result = create();
    if (cardNumber != null) {
      _result.cardNumber = cardNumber;
    }
    if (cardPin != null) {
      _result.cardPin = cardPin;
    }
    return _result;
  }
  factory GetGiftCardBalanceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetGiftCardBalanceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetGiftCardBalanceRequest clone() => GetGiftCardBalanceRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetGiftCardBalanceRequest copyWith(void Function(GetGiftCardBalanceRequest) updates) => super.copyWith((message) => updates(message as GetGiftCardBalanceRequest)) as GetGiftCardBalanceRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetGiftCardBalanceResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..a<$core.double>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'balance', $pb.PbFieldType.OD)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'brandName')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'expiryDate')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..hasRequiredFields = false
  ;

  GetGiftCardBalanceResponse._() : super();
  factory GetGiftCardBalanceResponse({
    $core.double? balance,
    $core.String? brandName,
    $core.String? expiryDate,
    $core.String? status,
  }) {
    final _result = create();
    if (balance != null) {
      _result.balance = balance;
    }
    if (brandName != null) {
      _result.brandName = brandName;
    }
    if (expiryDate != null) {
      _result.expiryDate = expiryDate;
    }
    if (status != null) {
      _result.status = status;
    }
    return _result;
  }
  factory GetGiftCardBalanceResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetGiftCardBalanceResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetGiftCardBalanceResponse clone() => GetGiftCardBalanceResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetGiftCardBalanceResponse copyWith(void Function(GetGiftCardBalanceResponse) updates) => super.copyWith((message) => updates(message as GetGiftCardBalanceResponse)) as GetGiftCardBalanceResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetGiftCardBrandsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'category')
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'activeOnly')
    ..hasRequiredFields = false
  ;

  GetGiftCardBrandsRequest._() : super();
  factory GetGiftCardBrandsRequest({
    $core.String? category,
    $core.bool? activeOnly,
  }) {
    final _result = create();
    if (category != null) {
      _result.category = category;
    }
    if (activeOnly != null) {
      _result.activeOnly = activeOnly;
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
}

class GetGiftCardBrandsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetGiftCardBrandsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..pc<GiftCardBrand>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'brands', $pb.PbFieldType.PM, subBuilder: GiftCardBrand.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetGiftCardBrandsResponse._() : super();
  factory GetGiftCardBrandsResponse({
    $core.Iterable<GiftCardBrand>? brands,
    $core.int? total,
  }) {
    final _result = create();
    if (brands != null) {
      _result.brands.addAll(brands);
    }
    if (total != null) {
      _result.total = total;
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

