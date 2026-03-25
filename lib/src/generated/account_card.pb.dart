// This is a generated file - do not edit.
//
// Generated from account_card.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/timestamp.pb.dart' as $1;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

/// Represents a specific card linked to an account
class AccountCard extends $pb.GeneratedMessage {
  factory AccountCard({
    $fixnum.Int64? id,
    $core.String? uuid,
    $fixnum.Int64? accountId,
    $fixnum.Int64? userId,
    $core.String? cardHolderName,
    $core.String? brand,
    $core.String? last4,
    $core.String? cardExpiry,
    $core.bool? isActive,
    $core.bool? isDefault,
    $core.String? cardType,
    $core.String? cardNickname,
    $core.double? spendingLimit,
    $core.double? remainingLimit,
    $1.Timestamp? expiresAt,
    $core.int? usageCount,
    $core.int? maxUsageCount,
    $core.String? currency,
    $core.String? billingAddress,
    $core.String? status,
    $core.String? frozenReason,
    $1.Timestamp? lastUsedAt,
    $1.Timestamp? createdAt,
    $1.Timestamp? updatedAt,
    $core.String? cardNumber,
    $core.String? cvv,
    $core.String? cardPin,
    $core.String? shippingAddress,
    $core.String? shippingStatus,
    $core.String? trackingNumber,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (uuid != null) result.uuid = uuid;
    if (accountId != null) result.accountId = accountId;
    if (userId != null) result.userId = userId;
    if (cardHolderName != null) result.cardHolderName = cardHolderName;
    if (brand != null) result.brand = brand;
    if (last4 != null) result.last4 = last4;
    if (cardExpiry != null) result.cardExpiry = cardExpiry;
    if (isActive != null) result.isActive = isActive;
    if (isDefault != null) result.isDefault = isDefault;
    if (cardType != null) result.cardType = cardType;
    if (cardNickname != null) result.cardNickname = cardNickname;
    if (spendingLimit != null) result.spendingLimit = spendingLimit;
    if (remainingLimit != null) result.remainingLimit = remainingLimit;
    if (expiresAt != null) result.expiresAt = expiresAt;
    if (usageCount != null) result.usageCount = usageCount;
    if (maxUsageCount != null) result.maxUsageCount = maxUsageCount;
    if (currency != null) result.currency = currency;
    if (billingAddress != null) result.billingAddress = billingAddress;
    if (status != null) result.status = status;
    if (frozenReason != null) result.frozenReason = frozenReason;
    if (lastUsedAt != null) result.lastUsedAt = lastUsedAt;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    if (cardNumber != null) result.cardNumber = cardNumber;
    if (cvv != null) result.cvv = cvv;
    if (cardPin != null) result.cardPin = cardPin;
    if (shippingAddress != null) result.shippingAddress = shippingAddress;
    if (shippingStatus != null) result.shippingStatus = shippingStatus;
    if (trackingNumber != null) result.trackingNumber = trackingNumber;
    return result;
  }

  AccountCard._();

  factory AccountCard.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AccountCard.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AccountCard',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(2, _omitFieldNames ? '' : 'uuid')
    ..a<$fixnum.Int64>(
        3, _omitFieldNames ? '' : 'accountId', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(4, _omitFieldNames ? '' : 'userId', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(5, _omitFieldNames ? '' : 'cardHolderName')
    ..aOS(6, _omitFieldNames ? '' : 'brand')
    ..aOS(7, _omitFieldNames ? '' : 'last4')
    ..aOS(8, _omitFieldNames ? '' : 'cardExpiry')
    ..aOB(9, _omitFieldNames ? '' : 'isActive')
    ..aOB(10, _omitFieldNames ? '' : 'isDefault')
    ..aOS(11, _omitFieldNames ? '' : 'cardType')
    ..aOS(12, _omitFieldNames ? '' : 'cardNickname')
    ..a<$core.double>(
        13, _omitFieldNames ? '' : 'spendingLimit', $pb.PbFieldType.OD)
    ..a<$core.double>(
        14, _omitFieldNames ? '' : 'remainingLimit', $pb.PbFieldType.OD)
    ..aOM<$1.Timestamp>(15, _omitFieldNames ? '' : 'expiresAt',
        subBuilder: $1.Timestamp.create)
    ..a<$core.int>(16, _omitFieldNames ? '' : 'usageCount', $pb.PbFieldType.O3)
    ..a<$core.int>(
        17, _omitFieldNames ? '' : 'maxUsageCount', $pb.PbFieldType.O3)
    ..aOS(18, _omitFieldNames ? '' : 'currency')
    ..aOS(19, _omitFieldNames ? '' : 'billingAddress')
    ..aOS(20, _omitFieldNames ? '' : 'status')
    ..aOS(21, _omitFieldNames ? '' : 'frozenReason')
    ..aOM<$1.Timestamp>(22, _omitFieldNames ? '' : 'lastUsedAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(23, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(24, _omitFieldNames ? '' : 'updatedAt',
        subBuilder: $1.Timestamp.create)
    ..aOS(25, _omitFieldNames ? '' : 'cardNumber')
    ..aOS(26, _omitFieldNames ? '' : 'cvv')
    ..aOS(27, _omitFieldNames ? '' : 'cardPin')
    ..aOS(28, _omitFieldNames ? '' : 'shippingAddress')
    ..aOS(29, _omitFieldNames ? '' : 'shippingStatus')
    ..aOS(30, _omitFieldNames ? '' : 'trackingNumber')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AccountCard clone() => AccountCard()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AccountCard copyWith(void Function(AccountCard) updates) =>
      super.copyWith((message) => updates(message as AccountCard))
          as AccountCard;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AccountCard create() => AccountCard._();
  @$core.override
  AccountCard createEmptyInstance() => create();
  static $pb.PbList<AccountCard> createRepeated() => $pb.PbList<AccountCard>();
  @$core.pragma('dart2js:noInline')
  static AccountCard getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AccountCard>(create);
  static AccountCard? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get id => $_getI64(0);
  @$pb.TagNumber(1)
  set id($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get uuid => $_getSZ(1);
  @$pb.TagNumber(2)
  set uuid($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUuid() => $_has(1);
  @$pb.TagNumber(2)
  void clearUuid() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get accountId => $_getI64(2);
  @$pb.TagNumber(3)
  set accountId($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAccountId() => $_has(2);
  @$pb.TagNumber(3)
  void clearAccountId() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get userId => $_getI64(3);
  @$pb.TagNumber(4)
  set userId($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasUserId() => $_has(3);
  @$pb.TagNumber(4)
  void clearUserId() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get cardHolderName => $_getSZ(4);
  @$pb.TagNumber(5)
  set cardHolderName($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasCardHolderName() => $_has(4);
  @$pb.TagNumber(5)
  void clearCardHolderName() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get brand => $_getSZ(5);
  @$pb.TagNumber(6)
  set brand($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasBrand() => $_has(5);
  @$pb.TagNumber(6)
  void clearBrand() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get last4 => $_getSZ(6);
  @$pb.TagNumber(7)
  set last4($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasLast4() => $_has(6);
  @$pb.TagNumber(7)
  void clearLast4() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get cardExpiry => $_getSZ(7);
  @$pb.TagNumber(8)
  set cardExpiry($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasCardExpiry() => $_has(7);
  @$pb.TagNumber(8)
  void clearCardExpiry() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.bool get isActive => $_getBF(8);
  @$pb.TagNumber(9)
  set isActive($core.bool value) => $_setBool(8, value);
  @$pb.TagNumber(9)
  $core.bool hasIsActive() => $_has(8);
  @$pb.TagNumber(9)
  void clearIsActive() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.bool get isDefault => $_getBF(9);
  @$pb.TagNumber(10)
  set isDefault($core.bool value) => $_setBool(9, value);
  @$pb.TagNumber(10)
  $core.bool hasIsDefault() => $_has(9);
  @$pb.TagNumber(10)
  void clearIsDefault() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get cardType => $_getSZ(10);
  @$pb.TagNumber(11)
  set cardType($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasCardType() => $_has(10);
  @$pb.TagNumber(11)
  void clearCardType() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get cardNickname => $_getSZ(11);
  @$pb.TagNumber(12)
  set cardNickname($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasCardNickname() => $_has(11);
  @$pb.TagNumber(12)
  void clearCardNickname() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.double get spendingLimit => $_getN(12);
  @$pb.TagNumber(13)
  set spendingLimit($core.double value) => $_setDouble(12, value);
  @$pb.TagNumber(13)
  $core.bool hasSpendingLimit() => $_has(12);
  @$pb.TagNumber(13)
  void clearSpendingLimit() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.double get remainingLimit => $_getN(13);
  @$pb.TagNumber(14)
  set remainingLimit($core.double value) => $_setDouble(13, value);
  @$pb.TagNumber(14)
  $core.bool hasRemainingLimit() => $_has(13);
  @$pb.TagNumber(14)
  void clearRemainingLimit() => $_clearField(14);

  @$pb.TagNumber(15)
  $1.Timestamp get expiresAt => $_getN(14);
  @$pb.TagNumber(15)
  set expiresAt($1.Timestamp value) => $_setField(15, value);
  @$pb.TagNumber(15)
  $core.bool hasExpiresAt() => $_has(14);
  @$pb.TagNumber(15)
  void clearExpiresAt() => $_clearField(15);
  @$pb.TagNumber(15)
  $1.Timestamp ensureExpiresAt() => $_ensure(14);

  @$pb.TagNumber(16)
  $core.int get usageCount => $_getIZ(15);
  @$pb.TagNumber(16)
  set usageCount($core.int value) => $_setSignedInt32(15, value);
  @$pb.TagNumber(16)
  $core.bool hasUsageCount() => $_has(15);
  @$pb.TagNumber(16)
  void clearUsageCount() => $_clearField(16);

  @$pb.TagNumber(17)
  $core.int get maxUsageCount => $_getIZ(16);
  @$pb.TagNumber(17)
  set maxUsageCount($core.int value) => $_setSignedInt32(16, value);
  @$pb.TagNumber(17)
  $core.bool hasMaxUsageCount() => $_has(16);
  @$pb.TagNumber(17)
  void clearMaxUsageCount() => $_clearField(17);

  @$pb.TagNumber(18)
  $core.String get currency => $_getSZ(17);
  @$pb.TagNumber(18)
  set currency($core.String value) => $_setString(17, value);
  @$pb.TagNumber(18)
  $core.bool hasCurrency() => $_has(17);
  @$pb.TagNumber(18)
  void clearCurrency() => $_clearField(18);

  @$pb.TagNumber(19)
  $core.String get billingAddress => $_getSZ(18);
  @$pb.TagNumber(19)
  set billingAddress($core.String value) => $_setString(18, value);
  @$pb.TagNumber(19)
  $core.bool hasBillingAddress() => $_has(18);
  @$pb.TagNumber(19)
  void clearBillingAddress() => $_clearField(19);

  @$pb.TagNumber(20)
  $core.String get status => $_getSZ(19);
  @$pb.TagNumber(20)
  set status($core.String value) => $_setString(19, value);
  @$pb.TagNumber(20)
  $core.bool hasStatus() => $_has(19);
  @$pb.TagNumber(20)
  void clearStatus() => $_clearField(20);

  @$pb.TagNumber(21)
  $core.String get frozenReason => $_getSZ(20);
  @$pb.TagNumber(21)
  set frozenReason($core.String value) => $_setString(20, value);
  @$pb.TagNumber(21)
  $core.bool hasFrozenReason() => $_has(20);
  @$pb.TagNumber(21)
  void clearFrozenReason() => $_clearField(21);

  @$pb.TagNumber(22)
  $1.Timestamp get lastUsedAt => $_getN(21);
  @$pb.TagNumber(22)
  set lastUsedAt($1.Timestamp value) => $_setField(22, value);
  @$pb.TagNumber(22)
  $core.bool hasLastUsedAt() => $_has(21);
  @$pb.TagNumber(22)
  void clearLastUsedAt() => $_clearField(22);
  @$pb.TagNumber(22)
  $1.Timestamp ensureLastUsedAt() => $_ensure(21);

  @$pb.TagNumber(23)
  $1.Timestamp get createdAt => $_getN(22);
  @$pb.TagNumber(23)
  set createdAt($1.Timestamp value) => $_setField(23, value);
  @$pb.TagNumber(23)
  $core.bool hasCreatedAt() => $_has(22);
  @$pb.TagNumber(23)
  void clearCreatedAt() => $_clearField(23);
  @$pb.TagNumber(23)
  $1.Timestamp ensureCreatedAt() => $_ensure(22);

  @$pb.TagNumber(24)
  $1.Timestamp get updatedAt => $_getN(23);
  @$pb.TagNumber(24)
  set updatedAt($1.Timestamp value) => $_setField(24, value);
  @$pb.TagNumber(24)
  $core.bool hasUpdatedAt() => $_has(23);
  @$pb.TagNumber(24)
  void clearUpdatedAt() => $_clearField(24);
  @$pb.TagNumber(24)
  $1.Timestamp ensureUpdatedAt() => $_ensure(23);

  @$pb.TagNumber(25)
  $core.String get cardNumber => $_getSZ(24);
  @$pb.TagNumber(25)
  set cardNumber($core.String value) => $_setString(24, value);
  @$pb.TagNumber(25)
  $core.bool hasCardNumber() => $_has(24);
  @$pb.TagNumber(25)
  void clearCardNumber() => $_clearField(25);

  @$pb.TagNumber(26)
  $core.String get cvv => $_getSZ(25);
  @$pb.TagNumber(26)
  set cvv($core.String value) => $_setString(25, value);
  @$pb.TagNumber(26)
  $core.bool hasCvv() => $_has(25);
  @$pb.TagNumber(26)
  void clearCvv() => $_clearField(26);

  @$pb.TagNumber(27)
  $core.String get cardPin => $_getSZ(26);
  @$pb.TagNumber(27)
  set cardPin($core.String value) => $_setString(26, value);
  @$pb.TagNumber(27)
  $core.bool hasCardPin() => $_has(26);
  @$pb.TagNumber(27)
  void clearCardPin() => $_clearField(27);

  @$pb.TagNumber(28)
  $core.String get shippingAddress => $_getSZ(27);
  @$pb.TagNumber(28)
  set shippingAddress($core.String value) => $_setString(27, value);
  @$pb.TagNumber(28)
  $core.bool hasShippingAddress() => $_has(27);
  @$pb.TagNumber(28)
  void clearShippingAddress() => $_clearField(28);

  @$pb.TagNumber(29)
  $core.String get shippingStatus => $_getSZ(28);
  @$pb.TagNumber(29)
  set shippingStatus($core.String value) => $_setString(28, value);
  @$pb.TagNumber(29)
  $core.bool hasShippingStatus() => $_has(28);
  @$pb.TagNumber(29)
  void clearShippingStatus() => $_clearField(29);

  @$pb.TagNumber(30)
  $core.String get trackingNumber => $_getSZ(29);
  @$pb.TagNumber(30)
  set trackingNumber($core.String value) => $_setString(29, value);
  @$pb.TagNumber(30)
  $core.bool hasTrackingNumber() => $_has(29);
  @$pb.TagNumber(30)
  void clearTrackingNumber() => $_clearField(30);
}

/// Card transaction message
class CardTransaction extends $pb.GeneratedMessage {
  factory CardTransaction({
    $fixnum.Int64? id,
    $core.String? uuid,
    $fixnum.Int64? cardId,
    $fixnum.Int64? userId,
    $fixnum.Int64? accountId,
    $core.double? amount,
    $core.String? currency,
    $core.String? merchantName,
    $core.String? merchantCategory,
    $core.String? transactionType,
    $core.String? status,
    $core.String? declineReason,
    $core.String? authorizationCode,
    $core.String? description,
    $1.Timestamp? transactionDate,
    $1.Timestamp? settledAt,
    $1.Timestamp? createdAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (uuid != null) result.uuid = uuid;
    if (cardId != null) result.cardId = cardId;
    if (userId != null) result.userId = userId;
    if (accountId != null) result.accountId = accountId;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    if (merchantName != null) result.merchantName = merchantName;
    if (merchantCategory != null) result.merchantCategory = merchantCategory;
    if (transactionType != null) result.transactionType = transactionType;
    if (status != null) result.status = status;
    if (declineReason != null) result.declineReason = declineReason;
    if (authorizationCode != null) result.authorizationCode = authorizationCode;
    if (description != null) result.description = description;
    if (transactionDate != null) result.transactionDate = transactionDate;
    if (settledAt != null) result.settledAt = settledAt;
    if (createdAt != null) result.createdAt = createdAt;
    return result;
  }

  CardTransaction._();

  factory CardTransaction.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CardTransaction.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CardTransaction',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(2, _omitFieldNames ? '' : 'uuid')
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'cardId', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(4, _omitFieldNames ? '' : 'userId', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(
        5, _omitFieldNames ? '' : 'accountId', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.double>(6, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(7, _omitFieldNames ? '' : 'currency')
    ..aOS(8, _omitFieldNames ? '' : 'merchantName')
    ..aOS(9, _omitFieldNames ? '' : 'merchantCategory')
    ..aOS(10, _omitFieldNames ? '' : 'transactionType')
    ..aOS(11, _omitFieldNames ? '' : 'status')
    ..aOS(12, _omitFieldNames ? '' : 'declineReason')
    ..aOS(13, _omitFieldNames ? '' : 'authorizationCode')
    ..aOS(14, _omitFieldNames ? '' : 'description')
    ..aOM<$1.Timestamp>(15, _omitFieldNames ? '' : 'transactionDate',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(16, _omitFieldNames ? '' : 'settledAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(17, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CardTransaction clone() => CardTransaction()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CardTransaction copyWith(void Function(CardTransaction) updates) =>
      super.copyWith((message) => updates(message as CardTransaction))
          as CardTransaction;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CardTransaction create() => CardTransaction._();
  @$core.override
  CardTransaction createEmptyInstance() => create();
  static $pb.PbList<CardTransaction> createRepeated() =>
      $pb.PbList<CardTransaction>();
  @$core.pragma('dart2js:noInline')
  static CardTransaction getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CardTransaction>(create);
  static CardTransaction? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get id => $_getI64(0);
  @$pb.TagNumber(1)
  set id($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get uuid => $_getSZ(1);
  @$pb.TagNumber(2)
  set uuid($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUuid() => $_has(1);
  @$pb.TagNumber(2)
  void clearUuid() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get cardId => $_getI64(2);
  @$pb.TagNumber(3)
  set cardId($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCardId() => $_has(2);
  @$pb.TagNumber(3)
  void clearCardId() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get userId => $_getI64(3);
  @$pb.TagNumber(4)
  set userId($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasUserId() => $_has(3);
  @$pb.TagNumber(4)
  void clearUserId() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get accountId => $_getI64(4);
  @$pb.TagNumber(5)
  set accountId($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasAccountId() => $_has(4);
  @$pb.TagNumber(5)
  void clearAccountId() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.double get amount => $_getN(5);
  @$pb.TagNumber(6)
  set amount($core.double value) => $_setDouble(5, value);
  @$pb.TagNumber(6)
  $core.bool hasAmount() => $_has(5);
  @$pb.TagNumber(6)
  void clearAmount() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get currency => $_getSZ(6);
  @$pb.TagNumber(7)
  set currency($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasCurrency() => $_has(6);
  @$pb.TagNumber(7)
  void clearCurrency() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get merchantName => $_getSZ(7);
  @$pb.TagNumber(8)
  set merchantName($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasMerchantName() => $_has(7);
  @$pb.TagNumber(8)
  void clearMerchantName() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get merchantCategory => $_getSZ(8);
  @$pb.TagNumber(9)
  set merchantCategory($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasMerchantCategory() => $_has(8);
  @$pb.TagNumber(9)
  void clearMerchantCategory() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get transactionType => $_getSZ(9);
  @$pb.TagNumber(10)
  set transactionType($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasTransactionType() => $_has(9);
  @$pb.TagNumber(10)
  void clearTransactionType() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get status => $_getSZ(10);
  @$pb.TagNumber(11)
  set status($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasStatus() => $_has(10);
  @$pb.TagNumber(11)
  void clearStatus() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get declineReason => $_getSZ(11);
  @$pb.TagNumber(12)
  set declineReason($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasDeclineReason() => $_has(11);
  @$pb.TagNumber(12)
  void clearDeclineReason() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.String get authorizationCode => $_getSZ(12);
  @$pb.TagNumber(13)
  set authorizationCode($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasAuthorizationCode() => $_has(12);
  @$pb.TagNumber(13)
  void clearAuthorizationCode() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.String get description => $_getSZ(13);
  @$pb.TagNumber(14)
  set description($core.String value) => $_setString(13, value);
  @$pb.TagNumber(14)
  $core.bool hasDescription() => $_has(13);
  @$pb.TagNumber(14)
  void clearDescription() => $_clearField(14);

  @$pb.TagNumber(15)
  $1.Timestamp get transactionDate => $_getN(14);
  @$pb.TagNumber(15)
  set transactionDate($1.Timestamp value) => $_setField(15, value);
  @$pb.TagNumber(15)
  $core.bool hasTransactionDate() => $_has(14);
  @$pb.TagNumber(15)
  void clearTransactionDate() => $_clearField(15);
  @$pb.TagNumber(15)
  $1.Timestamp ensureTransactionDate() => $_ensure(14);

  @$pb.TagNumber(16)
  $1.Timestamp get settledAt => $_getN(15);
  @$pb.TagNumber(16)
  set settledAt($1.Timestamp value) => $_setField(16, value);
  @$pb.TagNumber(16)
  $core.bool hasSettledAt() => $_has(15);
  @$pb.TagNumber(16)
  void clearSettledAt() => $_clearField(16);
  @$pb.TagNumber(16)
  $1.Timestamp ensureSettledAt() => $_ensure(15);

  @$pb.TagNumber(17)
  $1.Timestamp get createdAt => $_getN(16);
  @$pb.TagNumber(17)
  set createdAt($1.Timestamp value) => $_setField(17, value);
  @$pb.TagNumber(17)
  $core.bool hasCreatedAt() => $_has(16);
  @$pb.TagNumber(17)
  void clearCreatedAt() => $_clearField(17);
  @$pb.TagNumber(17)
  $1.Timestamp ensureCreatedAt() => $_ensure(16);
}

/// Create virtual card request
class CreateVirtualCardRequest extends $pb.GeneratedMessage {
  factory CreateVirtualCardRequest({
    $fixnum.Int64? accountId,
    $core.String? cardNickname,
    $core.String? currency,
    $core.String? billingAddress,
  }) {
    final result = create();
    if (accountId != null) result.accountId = accountId;
    if (cardNickname != null) result.cardNickname = cardNickname;
    if (currency != null) result.currency = currency;
    if (billingAddress != null) result.billingAddress = billingAddress;
    return result;
  }

  CreateVirtualCardRequest._();

  factory CreateVirtualCardRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateVirtualCardRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateVirtualCardRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..a<$fixnum.Int64>(
        1, _omitFieldNames ? '' : 'accountId', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(2, _omitFieldNames ? '' : 'cardNickname')
    ..aOS(3, _omitFieldNames ? '' : 'currency')
    ..aOS(4, _omitFieldNames ? '' : 'billingAddress')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateVirtualCardRequest clone() =>
      CreateVirtualCardRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateVirtualCardRequest copyWith(
          void Function(CreateVirtualCardRequest) updates) =>
      super.copyWith((message) => updates(message as CreateVirtualCardRequest))
          as CreateVirtualCardRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateVirtualCardRequest create() => CreateVirtualCardRequest._();
  @$core.override
  CreateVirtualCardRequest createEmptyInstance() => create();
  static $pb.PbList<CreateVirtualCardRequest> createRepeated() =>
      $pb.PbList<CreateVirtualCardRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateVirtualCardRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateVirtualCardRequest>(create);
  static CreateVirtualCardRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get accountId => $_getI64(0);
  @$pb.TagNumber(1)
  set accountId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get cardNickname => $_getSZ(1);
  @$pb.TagNumber(2)
  set cardNickname($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCardNickname() => $_has(1);
  @$pb.TagNumber(2)
  void clearCardNickname() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get currency => $_getSZ(2);
  @$pb.TagNumber(3)
  set currency($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCurrency() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrency() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get billingAddress => $_getSZ(3);
  @$pb.TagNumber(4)
  set billingAddress($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasBillingAddress() => $_has(3);
  @$pb.TagNumber(4)
  void clearBillingAddress() => $_clearField(4);
}

/// Create virtual card response
class CreateVirtualCardResponse extends $pb.GeneratedMessage {
  factory CreateVirtualCardResponse({
    AccountCard? card,
  }) {
    final result = create();
    if (card != null) result.card = card;
    return result;
  }

  CreateVirtualCardResponse._();

  factory CreateVirtualCardResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateVirtualCardResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateVirtualCardResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<AccountCard>(1, _omitFieldNames ? '' : 'card',
        subBuilder: AccountCard.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateVirtualCardResponse clone() =>
      CreateVirtualCardResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateVirtualCardResponse copyWith(
          void Function(CreateVirtualCardResponse) updates) =>
      super.copyWith((message) => updates(message as CreateVirtualCardResponse))
          as CreateVirtualCardResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateVirtualCardResponse create() => CreateVirtualCardResponse._();
  @$core.override
  CreateVirtualCardResponse createEmptyInstance() => create();
  static $pb.PbList<CreateVirtualCardResponse> createRepeated() =>
      $pb.PbList<CreateVirtualCardResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateVirtualCardResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateVirtualCardResponse>(create);
  static CreateVirtualCardResponse? _defaultInstance;

  @$pb.TagNumber(1)
  AccountCard get card => $_getN(0);
  @$pb.TagNumber(1)
  set card(AccountCard value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasCard() => $_has(0);
  @$pb.TagNumber(1)
  void clearCard() => $_clearField(1);
  @$pb.TagNumber(1)
  AccountCard ensureCard() => $_ensure(0);
}

/// Create disposable card request
class CreateDisposableCardRequest extends $pb.GeneratedMessage {
  factory CreateDisposableCardRequest({
    $fixnum.Int64? accountId,
    $core.String? cardNickname,
    $core.double? spendingLimit,
    $core.String? currency,
    $core.int? maxUsageCount,
    $core.int? expiresInHours,
    $core.String? billingAddress,
  }) {
    final result = create();
    if (accountId != null) result.accountId = accountId;
    if (cardNickname != null) result.cardNickname = cardNickname;
    if (spendingLimit != null) result.spendingLimit = spendingLimit;
    if (currency != null) result.currency = currency;
    if (maxUsageCount != null) result.maxUsageCount = maxUsageCount;
    if (expiresInHours != null) result.expiresInHours = expiresInHours;
    if (billingAddress != null) result.billingAddress = billingAddress;
    return result;
  }

  CreateDisposableCardRequest._();

  factory CreateDisposableCardRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateDisposableCardRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateDisposableCardRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..a<$fixnum.Int64>(
        1, _omitFieldNames ? '' : 'accountId', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(2, _omitFieldNames ? '' : 'cardNickname')
    ..a<$core.double>(
        3, _omitFieldNames ? '' : 'spendingLimit', $pb.PbFieldType.OD)
    ..aOS(4, _omitFieldNames ? '' : 'currency')
    ..a<$core.int>(
        5, _omitFieldNames ? '' : 'maxUsageCount', $pb.PbFieldType.O3)
    ..a<$core.int>(
        6, _omitFieldNames ? '' : 'expiresInHours', $pb.PbFieldType.O3)
    ..aOS(7, _omitFieldNames ? '' : 'billingAddress')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateDisposableCardRequest clone() =>
      CreateDisposableCardRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateDisposableCardRequest copyWith(
          void Function(CreateDisposableCardRequest) updates) =>
      super.copyWith(
              (message) => updates(message as CreateDisposableCardRequest))
          as CreateDisposableCardRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateDisposableCardRequest create() =>
      CreateDisposableCardRequest._();
  @$core.override
  CreateDisposableCardRequest createEmptyInstance() => create();
  static $pb.PbList<CreateDisposableCardRequest> createRepeated() =>
      $pb.PbList<CreateDisposableCardRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateDisposableCardRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateDisposableCardRequest>(create);
  static CreateDisposableCardRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get accountId => $_getI64(0);
  @$pb.TagNumber(1)
  set accountId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get cardNickname => $_getSZ(1);
  @$pb.TagNumber(2)
  set cardNickname($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCardNickname() => $_has(1);
  @$pb.TagNumber(2)
  void clearCardNickname() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get spendingLimit => $_getN(2);
  @$pb.TagNumber(3)
  set spendingLimit($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSpendingLimit() => $_has(2);
  @$pb.TagNumber(3)
  void clearSpendingLimit() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get currency => $_getSZ(3);
  @$pb.TagNumber(4)
  set currency($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCurrency() => $_has(3);
  @$pb.TagNumber(4)
  void clearCurrency() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get maxUsageCount => $_getIZ(4);
  @$pb.TagNumber(5)
  set maxUsageCount($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasMaxUsageCount() => $_has(4);
  @$pb.TagNumber(5)
  void clearMaxUsageCount() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.int get expiresInHours => $_getIZ(5);
  @$pb.TagNumber(6)
  set expiresInHours($core.int value) => $_setSignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasExpiresInHours() => $_has(5);
  @$pb.TagNumber(6)
  void clearExpiresInHours() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get billingAddress => $_getSZ(6);
  @$pb.TagNumber(7)
  set billingAddress($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasBillingAddress() => $_has(6);
  @$pb.TagNumber(7)
  void clearBillingAddress() => $_clearField(7);
}

/// Create disposable card response
class CreateDisposableCardResponse extends $pb.GeneratedMessage {
  factory CreateDisposableCardResponse({
    AccountCard? card,
  }) {
    final result = create();
    if (card != null) result.card = card;
    return result;
  }

  CreateDisposableCardResponse._();

  factory CreateDisposableCardResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateDisposableCardResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateDisposableCardResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<AccountCard>(1, _omitFieldNames ? '' : 'card',
        subBuilder: AccountCard.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateDisposableCardResponse clone() =>
      CreateDisposableCardResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateDisposableCardResponse copyWith(
          void Function(CreateDisposableCardResponse) updates) =>
      super.copyWith(
              (message) => updates(message as CreateDisposableCardResponse))
          as CreateDisposableCardResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateDisposableCardResponse create() =>
      CreateDisposableCardResponse._();
  @$core.override
  CreateDisposableCardResponse createEmptyInstance() => create();
  static $pb.PbList<CreateDisposableCardResponse> createRepeated() =>
      $pb.PbList<CreateDisposableCardResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateDisposableCardResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateDisposableCardResponse>(create);
  static CreateDisposableCardResponse? _defaultInstance;

  @$pb.TagNumber(1)
  AccountCard get card => $_getN(0);
  @$pb.TagNumber(1)
  set card(AccountCard value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasCard() => $_has(0);
  @$pb.TagNumber(1)
  void clearCard() => $_clearField(1);
  @$pb.TagNumber(1)
  AccountCard ensureCard() => $_ensure(0);
}

/// Get all cards for user
class GetUserCardsRequest extends $pb.GeneratedMessage {
  factory GetUserCardsRequest({
    $core.String? cardTypeFilter,
    $core.String? statusFilter,
  }) {
    final result = create();
    if (cardTypeFilter != null) result.cardTypeFilter = cardTypeFilter;
    if (statusFilter != null) result.statusFilter = statusFilter;
    return result;
  }

  GetUserCardsRequest._();

  factory GetUserCardsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetUserCardsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUserCardsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'cardTypeFilter')
    ..aOS(2, _omitFieldNames ? '' : 'statusFilter')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserCardsRequest clone() => GetUserCardsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserCardsRequest copyWith(void Function(GetUserCardsRequest) updates) =>
      super.copyWith((message) => updates(message as GetUserCardsRequest))
          as GetUserCardsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserCardsRequest create() => GetUserCardsRequest._();
  @$core.override
  GetUserCardsRequest createEmptyInstance() => create();
  static $pb.PbList<GetUserCardsRequest> createRepeated() =>
      $pb.PbList<GetUserCardsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetUserCardsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetUserCardsRequest>(create);
  static GetUserCardsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get cardTypeFilter => $_getSZ(0);
  @$pb.TagNumber(1)
  set cardTypeFilter($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCardTypeFilter() => $_has(0);
  @$pb.TagNumber(1)
  void clearCardTypeFilter() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get statusFilter => $_getSZ(1);
  @$pb.TagNumber(2)
  set statusFilter($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasStatusFilter() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatusFilter() => $_clearField(2);
}

/// Get all cards response
class GetUserCardsResponse extends $pb.GeneratedMessage {
  factory GetUserCardsResponse({
    $core.Iterable<AccountCard>? cards,
    CardStatistics? statistics,
  }) {
    final result = create();
    if (cards != null) result.cards.addAll(cards);
    if (statistics != null) result.statistics = statistics;
    return result;
  }

  GetUserCardsResponse._();

  factory GetUserCardsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetUserCardsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUserCardsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<AccountCard>(1, _omitFieldNames ? '' : 'cards', $pb.PbFieldType.PM,
        subBuilder: AccountCard.create)
    ..aOM<CardStatistics>(2, _omitFieldNames ? '' : 'statistics',
        subBuilder: CardStatistics.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserCardsResponse clone() =>
      GetUserCardsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserCardsResponse copyWith(void Function(GetUserCardsResponse) updates) =>
      super.copyWith((message) => updates(message as GetUserCardsResponse))
          as GetUserCardsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserCardsResponse create() => GetUserCardsResponse._();
  @$core.override
  GetUserCardsResponse createEmptyInstance() => create();
  static $pb.PbList<GetUserCardsResponse> createRepeated() =>
      $pb.PbList<GetUserCardsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetUserCardsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetUserCardsResponse>(create);
  static GetUserCardsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<AccountCard> get cards => $_getList(0);

  @$pb.TagNumber(2)
  CardStatistics get statistics => $_getN(1);
  @$pb.TagNumber(2)
  set statistics(CardStatistics value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasStatistics() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatistics() => $_clearField(2);
  @$pb.TagNumber(2)
  CardStatistics ensureStatistics() => $_ensure(1);
}

/// Card statistics
class CardStatistics extends $pb.GeneratedMessage {
  factory CardStatistics({
    $core.int? totalCards,
    $core.int? activeCards,
    $core.int? virtualCards,
    $core.int? disposableCards,
    $core.int? frozenCards,
    $core.double? totalSpendingLimit,
    $core.double? totalRemainingLimit,
  }) {
    final result = create();
    if (totalCards != null) result.totalCards = totalCards;
    if (activeCards != null) result.activeCards = activeCards;
    if (virtualCards != null) result.virtualCards = virtualCards;
    if (disposableCards != null) result.disposableCards = disposableCards;
    if (frozenCards != null) result.frozenCards = frozenCards;
    if (totalSpendingLimit != null)
      result.totalSpendingLimit = totalSpendingLimit;
    if (totalRemainingLimit != null)
      result.totalRemainingLimit = totalRemainingLimit;
    return result;
  }

  CardStatistics._();

  factory CardStatistics.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CardStatistics.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CardStatistics',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'totalCards', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'activeCards', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'virtualCards', $pb.PbFieldType.O3)
    ..a<$core.int>(
        4, _omitFieldNames ? '' : 'disposableCards', $pb.PbFieldType.O3)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'frozenCards', $pb.PbFieldType.O3)
    ..a<$core.double>(
        6, _omitFieldNames ? '' : 'totalSpendingLimit', $pb.PbFieldType.OD)
    ..a<$core.double>(
        7, _omitFieldNames ? '' : 'totalRemainingLimit', $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CardStatistics clone() => CardStatistics()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CardStatistics copyWith(void Function(CardStatistics) updates) =>
      super.copyWith((message) => updates(message as CardStatistics))
          as CardStatistics;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CardStatistics create() => CardStatistics._();
  @$core.override
  CardStatistics createEmptyInstance() => create();
  static $pb.PbList<CardStatistics> createRepeated() =>
      $pb.PbList<CardStatistics>();
  @$core.pragma('dart2js:noInline')
  static CardStatistics getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CardStatistics>(create);
  static CardStatistics? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get totalCards => $_getIZ(0);
  @$pb.TagNumber(1)
  set totalCards($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTotalCards() => $_has(0);
  @$pb.TagNumber(1)
  void clearTotalCards() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get activeCards => $_getIZ(1);
  @$pb.TagNumber(2)
  set activeCards($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasActiveCards() => $_has(1);
  @$pb.TagNumber(2)
  void clearActiveCards() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get virtualCards => $_getIZ(2);
  @$pb.TagNumber(3)
  set virtualCards($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasVirtualCards() => $_has(2);
  @$pb.TagNumber(3)
  void clearVirtualCards() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get disposableCards => $_getIZ(3);
  @$pb.TagNumber(4)
  set disposableCards($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDisposableCards() => $_has(3);
  @$pb.TagNumber(4)
  void clearDisposableCards() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get frozenCards => $_getIZ(4);
  @$pb.TagNumber(5)
  set frozenCards($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasFrozenCards() => $_has(4);
  @$pb.TagNumber(5)
  void clearFrozenCards() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.double get totalSpendingLimit => $_getN(5);
  @$pb.TagNumber(6)
  set totalSpendingLimit($core.double value) => $_setDouble(5, value);
  @$pb.TagNumber(6)
  $core.bool hasTotalSpendingLimit() => $_has(5);
  @$pb.TagNumber(6)
  void clearTotalSpendingLimit() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.double get totalRemainingLimit => $_getN(6);
  @$pb.TagNumber(7)
  set totalRemainingLimit($core.double value) => $_setDouble(6, value);
  @$pb.TagNumber(7)
  $core.bool hasTotalRemainingLimit() => $_has(6);
  @$pb.TagNumber(7)
  void clearTotalRemainingLimit() => $_clearField(7);
}

/// Get card details request
class GetCardDetailsRequest extends $pb.GeneratedMessage {
  factory GetCardDetailsRequest({
    $core.String? cardUuid,
    $core.bool? includeFullDetails,
  }) {
    final result = create();
    if (cardUuid != null) result.cardUuid = cardUuid;
    if (includeFullDetails != null)
      result.includeFullDetails = includeFullDetails;
    return result;
  }

  GetCardDetailsRequest._();

  factory GetCardDetailsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetCardDetailsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetCardDetailsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'cardUuid')
    ..aOB(2, _omitFieldNames ? '' : 'includeFullDetails')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCardDetailsRequest clone() =>
      GetCardDetailsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCardDetailsRequest copyWith(
          void Function(GetCardDetailsRequest) updates) =>
      super.copyWith((message) => updates(message as GetCardDetailsRequest))
          as GetCardDetailsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetCardDetailsRequest create() => GetCardDetailsRequest._();
  @$core.override
  GetCardDetailsRequest createEmptyInstance() => create();
  static $pb.PbList<GetCardDetailsRequest> createRepeated() =>
      $pb.PbList<GetCardDetailsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetCardDetailsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetCardDetailsRequest>(create);
  static GetCardDetailsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get cardUuid => $_getSZ(0);
  @$pb.TagNumber(1)
  set cardUuid($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCardUuid() => $_has(0);
  @$pb.TagNumber(1)
  void clearCardUuid() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get includeFullDetails => $_getBF(1);
  @$pb.TagNumber(2)
  set includeFullDetails($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasIncludeFullDetails() => $_has(1);
  @$pb.TagNumber(2)
  void clearIncludeFullDetails() => $_clearField(2);
}

/// Get card details response
class GetCardDetailsResponse extends $pb.GeneratedMessage {
  factory GetCardDetailsResponse({
    AccountCard? card,
    $core.Iterable<CardTransaction>? recentTransactions,
  }) {
    final result = create();
    if (card != null) result.card = card;
    if (recentTransactions != null)
      result.recentTransactions.addAll(recentTransactions);
    return result;
  }

  GetCardDetailsResponse._();

  factory GetCardDetailsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetCardDetailsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetCardDetailsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<AccountCard>(1, _omitFieldNames ? '' : 'card',
        subBuilder: AccountCard.create)
    ..pc<CardTransaction>(
        2, _omitFieldNames ? '' : 'recentTransactions', $pb.PbFieldType.PM,
        subBuilder: CardTransaction.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCardDetailsResponse clone() =>
      GetCardDetailsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCardDetailsResponse copyWith(
          void Function(GetCardDetailsResponse) updates) =>
      super.copyWith((message) => updates(message as GetCardDetailsResponse))
          as GetCardDetailsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetCardDetailsResponse create() => GetCardDetailsResponse._();
  @$core.override
  GetCardDetailsResponse createEmptyInstance() => create();
  static $pb.PbList<GetCardDetailsResponse> createRepeated() =>
      $pb.PbList<GetCardDetailsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetCardDetailsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetCardDetailsResponse>(create);
  static GetCardDetailsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  AccountCard get card => $_getN(0);
  @$pb.TagNumber(1)
  set card(AccountCard value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasCard() => $_has(0);
  @$pb.TagNumber(1)
  void clearCard() => $_clearField(1);
  @$pb.TagNumber(1)
  AccountCard ensureCard() => $_ensure(0);

  @$pb.TagNumber(2)
  $pb.PbList<CardTransaction> get recentTransactions => $_getList(1);
}

/// Freeze card request
class FreezeCardRequest extends $pb.GeneratedMessage {
  factory FreezeCardRequest({
    $core.String? cardUuid,
    $core.String? reason,
  }) {
    final result = create();
    if (cardUuid != null) result.cardUuid = cardUuid;
    if (reason != null) result.reason = reason;
    return result;
  }

  FreezeCardRequest._();

  factory FreezeCardRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FreezeCardRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FreezeCardRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'cardUuid')
    ..aOS(2, _omitFieldNames ? '' : 'reason')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FreezeCardRequest clone() => FreezeCardRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FreezeCardRequest copyWith(void Function(FreezeCardRequest) updates) =>
      super.copyWith((message) => updates(message as FreezeCardRequest))
          as FreezeCardRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FreezeCardRequest create() => FreezeCardRequest._();
  @$core.override
  FreezeCardRequest createEmptyInstance() => create();
  static $pb.PbList<FreezeCardRequest> createRepeated() =>
      $pb.PbList<FreezeCardRequest>();
  @$core.pragma('dart2js:noInline')
  static FreezeCardRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FreezeCardRequest>(create);
  static FreezeCardRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get cardUuid => $_getSZ(0);
  @$pb.TagNumber(1)
  set cardUuid($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCardUuid() => $_has(0);
  @$pb.TagNumber(1)
  void clearCardUuid() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get reason => $_getSZ(1);
  @$pb.TagNumber(2)
  set reason($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasReason() => $_has(1);
  @$pb.TagNumber(2)
  void clearReason() => $_clearField(2);
}

/// Freeze card response
class FreezeCardResponse extends $pb.GeneratedMessage {
  factory FreezeCardResponse({
    AccountCard? card,
  }) {
    final result = create();
    if (card != null) result.card = card;
    return result;
  }

  FreezeCardResponse._();

  factory FreezeCardResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FreezeCardResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FreezeCardResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<AccountCard>(1, _omitFieldNames ? '' : 'card',
        subBuilder: AccountCard.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FreezeCardResponse clone() => FreezeCardResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FreezeCardResponse copyWith(void Function(FreezeCardResponse) updates) =>
      super.copyWith((message) => updates(message as FreezeCardResponse))
          as FreezeCardResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FreezeCardResponse create() => FreezeCardResponse._();
  @$core.override
  FreezeCardResponse createEmptyInstance() => create();
  static $pb.PbList<FreezeCardResponse> createRepeated() =>
      $pb.PbList<FreezeCardResponse>();
  @$core.pragma('dart2js:noInline')
  static FreezeCardResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FreezeCardResponse>(create);
  static FreezeCardResponse? _defaultInstance;

  @$pb.TagNumber(1)
  AccountCard get card => $_getN(0);
  @$pb.TagNumber(1)
  set card(AccountCard value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasCard() => $_has(0);
  @$pb.TagNumber(1)
  void clearCard() => $_clearField(1);
  @$pb.TagNumber(1)
  AccountCard ensureCard() => $_ensure(0);
}

/// Unfreeze card request
class UnfreezeCardRequest extends $pb.GeneratedMessage {
  factory UnfreezeCardRequest({
    $core.String? cardUuid,
  }) {
    final result = create();
    if (cardUuid != null) result.cardUuid = cardUuid;
    return result;
  }

  UnfreezeCardRequest._();

  factory UnfreezeCardRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UnfreezeCardRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UnfreezeCardRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'cardUuid')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UnfreezeCardRequest clone() => UnfreezeCardRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UnfreezeCardRequest copyWith(void Function(UnfreezeCardRequest) updates) =>
      super.copyWith((message) => updates(message as UnfreezeCardRequest))
          as UnfreezeCardRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UnfreezeCardRequest create() => UnfreezeCardRequest._();
  @$core.override
  UnfreezeCardRequest createEmptyInstance() => create();
  static $pb.PbList<UnfreezeCardRequest> createRepeated() =>
      $pb.PbList<UnfreezeCardRequest>();
  @$core.pragma('dart2js:noInline')
  static UnfreezeCardRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UnfreezeCardRequest>(create);
  static UnfreezeCardRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get cardUuid => $_getSZ(0);
  @$pb.TagNumber(1)
  set cardUuid($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCardUuid() => $_has(0);
  @$pb.TagNumber(1)
  void clearCardUuid() => $_clearField(1);
}

/// Unfreeze card response
class UnfreezeCardResponse extends $pb.GeneratedMessage {
  factory UnfreezeCardResponse({
    AccountCard? card,
  }) {
    final result = create();
    if (card != null) result.card = card;
    return result;
  }

  UnfreezeCardResponse._();

  factory UnfreezeCardResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UnfreezeCardResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UnfreezeCardResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<AccountCard>(1, _omitFieldNames ? '' : 'card',
        subBuilder: AccountCard.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UnfreezeCardResponse clone() =>
      UnfreezeCardResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UnfreezeCardResponse copyWith(void Function(UnfreezeCardResponse) updates) =>
      super.copyWith((message) => updates(message as UnfreezeCardResponse))
          as UnfreezeCardResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UnfreezeCardResponse create() => UnfreezeCardResponse._();
  @$core.override
  UnfreezeCardResponse createEmptyInstance() => create();
  static $pb.PbList<UnfreezeCardResponse> createRepeated() =>
      $pb.PbList<UnfreezeCardResponse>();
  @$core.pragma('dart2js:noInline')
  static UnfreezeCardResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UnfreezeCardResponse>(create);
  static UnfreezeCardResponse? _defaultInstance;

  @$pb.TagNumber(1)
  AccountCard get card => $_getN(0);
  @$pb.TagNumber(1)
  set card(AccountCard value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasCard() => $_has(0);
  @$pb.TagNumber(1)
  void clearCard() => $_clearField(1);
  @$pb.TagNumber(1)
  AccountCard ensureCard() => $_ensure(0);
}

/// Cancel card request
class CancelCardRequest extends $pb.GeneratedMessage {
  factory CancelCardRequest({
    $core.String? cardUuid,
    $core.String? reason,
  }) {
    final result = create();
    if (cardUuid != null) result.cardUuid = cardUuid;
    if (reason != null) result.reason = reason;
    return result;
  }

  CancelCardRequest._();

  factory CancelCardRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CancelCardRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CancelCardRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'cardUuid')
    ..aOS(2, _omitFieldNames ? '' : 'reason')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CancelCardRequest clone() => CancelCardRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CancelCardRequest copyWith(void Function(CancelCardRequest) updates) =>
      super.copyWith((message) => updates(message as CancelCardRequest))
          as CancelCardRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CancelCardRequest create() => CancelCardRequest._();
  @$core.override
  CancelCardRequest createEmptyInstance() => create();
  static $pb.PbList<CancelCardRequest> createRepeated() =>
      $pb.PbList<CancelCardRequest>();
  @$core.pragma('dart2js:noInline')
  static CancelCardRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CancelCardRequest>(create);
  static CancelCardRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get cardUuid => $_getSZ(0);
  @$pb.TagNumber(1)
  set cardUuid($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCardUuid() => $_has(0);
  @$pb.TagNumber(1)
  void clearCardUuid() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get reason => $_getSZ(1);
  @$pb.TagNumber(2)
  set reason($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasReason() => $_has(1);
  @$pb.TagNumber(2)
  void clearReason() => $_clearField(2);
}

/// Cancel card response
class CancelCardResponse extends $pb.GeneratedMessage {
  factory CancelCardResponse({
    $core.bool? success,
    $core.String? message,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    return result;
  }

  CancelCardResponse._();

  factory CancelCardResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CancelCardResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CancelCardResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CancelCardResponse clone() => CancelCardResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CancelCardResponse copyWith(void Function(CancelCardResponse) updates) =>
      super.copyWith((message) => updates(message as CancelCardResponse))
          as CancelCardResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CancelCardResponse create() => CancelCardResponse._();
  @$core.override
  CancelCardResponse createEmptyInstance() => create();
  static $pb.PbList<CancelCardResponse> createRepeated() =>
      $pb.PbList<CancelCardResponse>();
  @$core.pragma('dart2js:noInline')
  static CancelCardResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CancelCardResponse>(create);
  static CancelCardResponse? _defaultInstance;

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

/// Update card nickname request
class UpdateCardNicknameRequest extends $pb.GeneratedMessage {
  factory UpdateCardNicknameRequest({
    $core.String? cardUuid,
    $core.String? nickname,
  }) {
    final result = create();
    if (cardUuid != null) result.cardUuid = cardUuid;
    if (nickname != null) result.nickname = nickname;
    return result;
  }

  UpdateCardNicknameRequest._();

  factory UpdateCardNicknameRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateCardNicknameRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateCardNicknameRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'cardUuid')
    ..aOS(2, _omitFieldNames ? '' : 'nickname')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateCardNicknameRequest clone() =>
      UpdateCardNicknameRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateCardNicknameRequest copyWith(
          void Function(UpdateCardNicknameRequest) updates) =>
      super.copyWith((message) => updates(message as UpdateCardNicknameRequest))
          as UpdateCardNicknameRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateCardNicknameRequest create() => UpdateCardNicknameRequest._();
  @$core.override
  UpdateCardNicknameRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateCardNicknameRequest> createRepeated() =>
      $pb.PbList<UpdateCardNicknameRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateCardNicknameRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateCardNicknameRequest>(create);
  static UpdateCardNicknameRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get cardUuid => $_getSZ(0);
  @$pb.TagNumber(1)
  set cardUuid($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCardUuid() => $_has(0);
  @$pb.TagNumber(1)
  void clearCardUuid() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get nickname => $_getSZ(1);
  @$pb.TagNumber(2)
  set nickname($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNickname() => $_has(1);
  @$pb.TagNumber(2)
  void clearNickname() => $_clearField(2);
}

/// Update card nickname response
class UpdateCardNicknameResponse extends $pb.GeneratedMessage {
  factory UpdateCardNicknameResponse({
    AccountCard? card,
  }) {
    final result = create();
    if (card != null) result.card = card;
    return result;
  }

  UpdateCardNicknameResponse._();

  factory UpdateCardNicknameResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateCardNicknameResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateCardNicknameResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<AccountCard>(1, _omitFieldNames ? '' : 'card',
        subBuilder: AccountCard.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateCardNicknameResponse clone() =>
      UpdateCardNicknameResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateCardNicknameResponse copyWith(
          void Function(UpdateCardNicknameResponse) updates) =>
      super.copyWith(
              (message) => updates(message as UpdateCardNicknameResponse))
          as UpdateCardNicknameResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateCardNicknameResponse create() => UpdateCardNicknameResponse._();
  @$core.override
  UpdateCardNicknameResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateCardNicknameResponse> createRepeated() =>
      $pb.PbList<UpdateCardNicknameResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateCardNicknameResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateCardNicknameResponse>(create);
  static UpdateCardNicknameResponse? _defaultInstance;

  @$pb.TagNumber(1)
  AccountCard get card => $_getN(0);
  @$pb.TagNumber(1)
  set card(AccountCard value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasCard() => $_has(0);
  @$pb.TagNumber(1)
  void clearCard() => $_clearField(1);
  @$pb.TagNumber(1)
  AccountCard ensureCard() => $_ensure(0);
}

/// Update card spending limit request (for disposable cards)
class UpdateCardSpendingLimitRequest extends $pb.GeneratedMessage {
  factory UpdateCardSpendingLimitRequest({
    $core.String? cardUuid,
    $core.double? newLimit,
  }) {
    final result = create();
    if (cardUuid != null) result.cardUuid = cardUuid;
    if (newLimit != null) result.newLimit = newLimit;
    return result;
  }

  UpdateCardSpendingLimitRequest._();

  factory UpdateCardSpendingLimitRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateCardSpendingLimitRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateCardSpendingLimitRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'cardUuid')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'newLimit', $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateCardSpendingLimitRequest clone() =>
      UpdateCardSpendingLimitRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateCardSpendingLimitRequest copyWith(
          void Function(UpdateCardSpendingLimitRequest) updates) =>
      super.copyWith(
              (message) => updates(message as UpdateCardSpendingLimitRequest))
          as UpdateCardSpendingLimitRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateCardSpendingLimitRequest create() =>
      UpdateCardSpendingLimitRequest._();
  @$core.override
  UpdateCardSpendingLimitRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateCardSpendingLimitRequest> createRepeated() =>
      $pb.PbList<UpdateCardSpendingLimitRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateCardSpendingLimitRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateCardSpendingLimitRequest>(create);
  static UpdateCardSpendingLimitRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get cardUuid => $_getSZ(0);
  @$pb.TagNumber(1)
  set cardUuid($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCardUuid() => $_has(0);
  @$pb.TagNumber(1)
  void clearCardUuid() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get newLimit => $_getN(1);
  @$pb.TagNumber(2)
  set newLimit($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNewLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearNewLimit() => $_clearField(2);
}

/// Update card spending limit response
class UpdateCardSpendingLimitResponse extends $pb.GeneratedMessage {
  factory UpdateCardSpendingLimitResponse({
    AccountCard? card,
  }) {
    final result = create();
    if (card != null) result.card = card;
    return result;
  }

  UpdateCardSpendingLimitResponse._();

  factory UpdateCardSpendingLimitResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateCardSpendingLimitResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateCardSpendingLimitResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<AccountCard>(1, _omitFieldNames ? '' : 'card',
        subBuilder: AccountCard.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateCardSpendingLimitResponse clone() =>
      UpdateCardSpendingLimitResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateCardSpendingLimitResponse copyWith(
          void Function(UpdateCardSpendingLimitResponse) updates) =>
      super.copyWith(
              (message) => updates(message as UpdateCardSpendingLimitResponse))
          as UpdateCardSpendingLimitResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateCardSpendingLimitResponse create() =>
      UpdateCardSpendingLimitResponse._();
  @$core.override
  UpdateCardSpendingLimitResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateCardSpendingLimitResponse> createRepeated() =>
      $pb.PbList<UpdateCardSpendingLimitResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateCardSpendingLimitResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateCardSpendingLimitResponse>(
          create);
  static UpdateCardSpendingLimitResponse? _defaultInstance;

  @$pb.TagNumber(1)
  AccountCard get card => $_getN(0);
  @$pb.TagNumber(1)
  set card(AccountCard value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasCard() => $_has(0);
  @$pb.TagNumber(1)
  void clearCard() => $_clearField(1);
  @$pb.TagNumber(1)
  AccountCard ensureCard() => $_ensure(0);
}

/// Get card transactions request
class GetCardTransactionsRequest extends $pb.GeneratedMessage {
  factory GetCardTransactionsRequest({
    $core.String? cardUuid,
    $core.int? page,
    $core.int? limit,
  }) {
    final result = create();
    if (cardUuid != null) result.cardUuid = cardUuid;
    if (page != null) result.page = page;
    if (limit != null) result.limit = limit;
    return result;
  }

  GetCardTransactionsRequest._();

  factory GetCardTransactionsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetCardTransactionsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetCardTransactionsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'cardUuid')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCardTransactionsRequest clone() =>
      GetCardTransactionsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCardTransactionsRequest copyWith(
          void Function(GetCardTransactionsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetCardTransactionsRequest))
          as GetCardTransactionsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetCardTransactionsRequest create() => GetCardTransactionsRequest._();
  @$core.override
  GetCardTransactionsRequest createEmptyInstance() => create();
  static $pb.PbList<GetCardTransactionsRequest> createRepeated() =>
      $pb.PbList<GetCardTransactionsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetCardTransactionsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetCardTransactionsRequest>(create);
  static GetCardTransactionsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get cardUuid => $_getSZ(0);
  @$pb.TagNumber(1)
  set cardUuid($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCardUuid() => $_has(0);
  @$pb.TagNumber(1)
  void clearCardUuid() => $_clearField(1);

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

/// Get card transactions response
class GetCardTransactionsResponse extends $pb.GeneratedMessage {
  factory GetCardTransactionsResponse({
    $core.Iterable<CardTransaction>? transactions,
    $core.int? totalCount,
    $core.int? currentPage,
    $core.int? totalPages,
  }) {
    final result = create();
    if (transactions != null) result.transactions.addAll(transactions);
    if (totalCount != null) result.totalCount = totalCount;
    if (currentPage != null) result.currentPage = currentPage;
    if (totalPages != null) result.totalPages = totalPages;
    return result;
  }

  GetCardTransactionsResponse._();

  factory GetCardTransactionsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetCardTransactionsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetCardTransactionsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<CardTransaction>(
        1, _omitFieldNames ? '' : 'transactions', $pb.PbFieldType.PM,
        subBuilder: CardTransaction.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'totalCount', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'currentPage', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'totalPages', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCardTransactionsResponse clone() =>
      GetCardTransactionsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCardTransactionsResponse copyWith(
          void Function(GetCardTransactionsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetCardTransactionsResponse))
          as GetCardTransactionsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetCardTransactionsResponse create() =>
      GetCardTransactionsResponse._();
  @$core.override
  GetCardTransactionsResponse createEmptyInstance() => create();
  static $pb.PbList<GetCardTransactionsResponse> createRepeated() =>
      $pb.PbList<GetCardTransactionsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetCardTransactionsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetCardTransactionsResponse>(create);
  static GetCardTransactionsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<CardTransaction> get transactions => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get totalCount => $_getIZ(1);
  @$pb.TagNumber(2)
  set totalCount($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotalCount() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalCount() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get currentPage => $_getIZ(2);
  @$pb.TagNumber(3)
  set currentPage($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCurrentPage() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrentPage() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get totalPages => $_getIZ(3);
  @$pb.TagNumber(4)
  set totalPages($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTotalPages() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalPages() => $_clearField(4);
}

/// Set default card request
class SetDefaultCardRequest extends $pb.GeneratedMessage {
  factory SetDefaultCardRequest({
    $core.String? cardUuid,
  }) {
    final result = create();
    if (cardUuid != null) result.cardUuid = cardUuid;
    return result;
  }

  SetDefaultCardRequest._();

  factory SetDefaultCardRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SetDefaultCardRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SetDefaultCardRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'cardUuid')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetDefaultCardRequest clone() =>
      SetDefaultCardRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetDefaultCardRequest copyWith(
          void Function(SetDefaultCardRequest) updates) =>
      super.copyWith((message) => updates(message as SetDefaultCardRequest))
          as SetDefaultCardRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SetDefaultCardRequest create() => SetDefaultCardRequest._();
  @$core.override
  SetDefaultCardRequest createEmptyInstance() => create();
  static $pb.PbList<SetDefaultCardRequest> createRepeated() =>
      $pb.PbList<SetDefaultCardRequest>();
  @$core.pragma('dart2js:noInline')
  static SetDefaultCardRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SetDefaultCardRequest>(create);
  static SetDefaultCardRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get cardUuid => $_getSZ(0);
  @$pb.TagNumber(1)
  set cardUuid($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCardUuid() => $_has(0);
  @$pb.TagNumber(1)
  void clearCardUuid() => $_clearField(1);
}

/// Set default card response
class SetDefaultCardResponse extends $pb.GeneratedMessage {
  factory SetDefaultCardResponse({
    AccountCard? card,
  }) {
    final result = create();
    if (card != null) result.card = card;
    return result;
  }

  SetDefaultCardResponse._();

  factory SetDefaultCardResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SetDefaultCardResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SetDefaultCardResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<AccountCard>(1, _omitFieldNames ? '' : 'card',
        subBuilder: AccountCard.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetDefaultCardResponse clone() =>
      SetDefaultCardResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetDefaultCardResponse copyWith(
          void Function(SetDefaultCardResponse) updates) =>
      super.copyWith((message) => updates(message as SetDefaultCardResponse))
          as SetDefaultCardResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SetDefaultCardResponse create() => SetDefaultCardResponse._();
  @$core.override
  SetDefaultCardResponse createEmptyInstance() => create();
  static $pb.PbList<SetDefaultCardResponse> createRepeated() =>
      $pb.PbList<SetDefaultCardResponse>();
  @$core.pragma('dart2js:noInline')
  static SetDefaultCardResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SetDefaultCardResponse>(create);
  static SetDefaultCardResponse? _defaultInstance;

  @$pb.TagNumber(1)
  AccountCard get card => $_getN(0);
  @$pb.TagNumber(1)
  set card(AccountCard value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasCard() => $_has(0);
  @$pb.TagNumber(1)
  void clearCard() => $_clearField(1);
  @$pb.TagNumber(1)
  AccountCard ensureCard() => $_ensure(0);
}

/// Request physical card
class RequestPhysicalCardRequest extends $pb.GeneratedMessage {
  factory RequestPhysicalCardRequest({
    $fixnum.Int64? accountId,
    $core.String? cardNickname,
    $core.String? currency,
    $core.String? billingAddress,
    $core.String? shippingAddress,
  }) {
    final result = create();
    if (accountId != null) result.accountId = accountId;
    if (cardNickname != null) result.cardNickname = cardNickname;
    if (currency != null) result.currency = currency;
    if (billingAddress != null) result.billingAddress = billingAddress;
    if (shippingAddress != null) result.shippingAddress = shippingAddress;
    return result;
  }

  RequestPhysicalCardRequest._();

  factory RequestPhysicalCardRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RequestPhysicalCardRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RequestPhysicalCardRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..a<$fixnum.Int64>(
        1, _omitFieldNames ? '' : 'accountId', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(2, _omitFieldNames ? '' : 'cardNickname')
    ..aOS(3, _omitFieldNames ? '' : 'currency')
    ..aOS(4, _omitFieldNames ? '' : 'billingAddress')
    ..aOS(5, _omitFieldNames ? '' : 'shippingAddress')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RequestPhysicalCardRequest clone() =>
      RequestPhysicalCardRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RequestPhysicalCardRequest copyWith(
          void Function(RequestPhysicalCardRequest) updates) =>
      super.copyWith(
              (message) => updates(message as RequestPhysicalCardRequest))
          as RequestPhysicalCardRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RequestPhysicalCardRequest create() => RequestPhysicalCardRequest._();
  @$core.override
  RequestPhysicalCardRequest createEmptyInstance() => create();
  static $pb.PbList<RequestPhysicalCardRequest> createRepeated() =>
      $pb.PbList<RequestPhysicalCardRequest>();
  @$core.pragma('dart2js:noInline')
  static RequestPhysicalCardRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RequestPhysicalCardRequest>(create);
  static RequestPhysicalCardRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get accountId => $_getI64(0);
  @$pb.TagNumber(1)
  set accountId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get cardNickname => $_getSZ(1);
  @$pb.TagNumber(2)
  set cardNickname($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCardNickname() => $_has(1);
  @$pb.TagNumber(2)
  void clearCardNickname() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get currency => $_getSZ(2);
  @$pb.TagNumber(3)
  set currency($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCurrency() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrency() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get billingAddress => $_getSZ(3);
  @$pb.TagNumber(4)
  set billingAddress($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasBillingAddress() => $_has(3);
  @$pb.TagNumber(4)
  void clearBillingAddress() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get shippingAddress => $_getSZ(4);
  @$pb.TagNumber(5)
  set shippingAddress($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasShippingAddress() => $_has(4);
  @$pb.TagNumber(5)
  void clearShippingAddress() => $_clearField(5);
}

class RequestPhysicalCardResponse extends $pb.GeneratedMessage {
  factory RequestPhysicalCardResponse({
    AccountCard? card,
  }) {
    final result = create();
    if (card != null) result.card = card;
    return result;
  }

  RequestPhysicalCardResponse._();

  factory RequestPhysicalCardResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RequestPhysicalCardResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RequestPhysicalCardResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<AccountCard>(1, _omitFieldNames ? '' : 'card',
        subBuilder: AccountCard.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RequestPhysicalCardResponse clone() =>
      RequestPhysicalCardResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RequestPhysicalCardResponse copyWith(
          void Function(RequestPhysicalCardResponse) updates) =>
      super.copyWith(
              (message) => updates(message as RequestPhysicalCardResponse))
          as RequestPhysicalCardResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RequestPhysicalCardResponse create() =>
      RequestPhysicalCardResponse._();
  @$core.override
  RequestPhysicalCardResponse createEmptyInstance() => create();
  static $pb.PbList<RequestPhysicalCardResponse> createRepeated() =>
      $pb.PbList<RequestPhysicalCardResponse>();
  @$core.pragma('dart2js:noInline')
  static RequestPhysicalCardResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RequestPhysicalCardResponse>(create);
  static RequestPhysicalCardResponse? _defaultInstance;

  @$pb.TagNumber(1)
  AccountCard get card => $_getN(0);
  @$pb.TagNumber(1)
  set card(AccountCard value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasCard() => $_has(0);
  @$pb.TagNumber(1)
  void clearCard() => $_clearField(1);
  @$pb.TagNumber(1)
  AccountCard ensureCard() => $_ensure(0);
}

/// Set card PIN
class SetCardPINRequest extends $pb.GeneratedMessage {
  factory SetCardPINRequest({
    $core.String? cardUuid,
    $core.String? pin,
  }) {
    final result = create();
    if (cardUuid != null) result.cardUuid = cardUuid;
    if (pin != null) result.pin = pin;
    return result;
  }

  SetCardPINRequest._();

  factory SetCardPINRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SetCardPINRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SetCardPINRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'cardUuid')
    ..aOS(2, _omitFieldNames ? '' : 'pin')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetCardPINRequest clone() => SetCardPINRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetCardPINRequest copyWith(void Function(SetCardPINRequest) updates) =>
      super.copyWith((message) => updates(message as SetCardPINRequest))
          as SetCardPINRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SetCardPINRequest create() => SetCardPINRequest._();
  @$core.override
  SetCardPINRequest createEmptyInstance() => create();
  static $pb.PbList<SetCardPINRequest> createRepeated() =>
      $pb.PbList<SetCardPINRequest>();
  @$core.pragma('dart2js:noInline')
  static SetCardPINRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SetCardPINRequest>(create);
  static SetCardPINRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get cardUuid => $_getSZ(0);
  @$pb.TagNumber(1)
  set cardUuid($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCardUuid() => $_has(0);
  @$pb.TagNumber(1)
  void clearCardUuid() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get pin => $_getSZ(1);
  @$pb.TagNumber(2)
  set pin($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPin() => $_has(1);
  @$pb.TagNumber(2)
  void clearPin() => $_clearField(2);
}

class SetCardPINResponse extends $pb.GeneratedMessage {
  factory SetCardPINResponse({
    $core.bool? success,
    $core.String? message,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    return result;
  }

  SetCardPINResponse._();

  factory SetCardPINResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SetCardPINResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SetCardPINResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetCardPINResponse clone() => SetCardPINResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetCardPINResponse copyWith(void Function(SetCardPINResponse) updates) =>
      super.copyWith((message) => updates(message as SetCardPINResponse))
          as SetCardPINResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SetCardPINResponse create() => SetCardPINResponse._();
  @$core.override
  SetCardPINResponse createEmptyInstance() => create();
  static $pb.PbList<SetCardPINResponse> createRepeated() =>
      $pb.PbList<SetCardPINResponse>();
  @$core.pragma('dart2js:noInline')
  static SetCardPINResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SetCardPINResponse>(create);
  static SetCardPINResponse? _defaultInstance;

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

/// Reveal card PIN (requires transaction PIN verification upstream)
class RevealCardPINRequest extends $pb.GeneratedMessage {
  factory RevealCardPINRequest({
    $core.String? cardUuid,
  }) {
    final result = create();
    if (cardUuid != null) result.cardUuid = cardUuid;
    return result;
  }

  RevealCardPINRequest._();

  factory RevealCardPINRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RevealCardPINRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RevealCardPINRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'cardUuid')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RevealCardPINRequest clone() =>
      RevealCardPINRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RevealCardPINRequest copyWith(void Function(RevealCardPINRequest) updates) =>
      super.copyWith((message) => updates(message as RevealCardPINRequest))
          as RevealCardPINRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RevealCardPINRequest create() => RevealCardPINRequest._();
  @$core.override
  RevealCardPINRequest createEmptyInstance() => create();
  static $pb.PbList<RevealCardPINRequest> createRepeated() =>
      $pb.PbList<RevealCardPINRequest>();
  @$core.pragma('dart2js:noInline')
  static RevealCardPINRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RevealCardPINRequest>(create);
  static RevealCardPINRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get cardUuid => $_getSZ(0);
  @$pb.TagNumber(1)
  set cardUuid($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCardUuid() => $_has(0);
  @$pb.TagNumber(1)
  void clearCardUuid() => $_clearField(1);
}

class RevealCardPINResponse extends $pb.GeneratedMessage {
  factory RevealCardPINResponse({
    $core.String? cardPin,
  }) {
    final result = create();
    if (cardPin != null) result.cardPin = cardPin;
    return result;
  }

  RevealCardPINResponse._();

  factory RevealCardPINResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RevealCardPINResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RevealCardPINResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'cardPin')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RevealCardPINResponse clone() =>
      RevealCardPINResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RevealCardPINResponse copyWith(
          void Function(RevealCardPINResponse) updates) =>
      super.copyWith((message) => updates(message as RevealCardPINResponse))
          as RevealCardPINResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RevealCardPINResponse create() => RevealCardPINResponse._();
  @$core.override
  RevealCardPINResponse createEmptyInstance() => create();
  static $pb.PbList<RevealCardPINResponse> createRepeated() =>
      $pb.PbList<RevealCardPINResponse>();
  @$core.pragma('dart2js:noInline')
  static RevealCardPINResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RevealCardPINResponse>(create);
  static RevealCardPINResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get cardPin => $_getSZ(0);
  @$pb.TagNumber(1)
  set cardPin($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCardPin() => $_has(0);
  @$pb.TagNumber(1)
  void clearCardPin() => $_clearField(1);
}

/// Reveal full card details (requires transaction PIN verification upstream)
class RevealFullCardDetailsRequest extends $pb.GeneratedMessage {
  factory RevealFullCardDetailsRequest({
    $core.String? cardUuid,
  }) {
    final result = create();
    if (cardUuid != null) result.cardUuid = cardUuid;
    return result;
  }

  RevealFullCardDetailsRequest._();

  factory RevealFullCardDetailsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RevealFullCardDetailsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RevealFullCardDetailsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'cardUuid')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RevealFullCardDetailsRequest clone() =>
      RevealFullCardDetailsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RevealFullCardDetailsRequest copyWith(
          void Function(RevealFullCardDetailsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as RevealFullCardDetailsRequest))
          as RevealFullCardDetailsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RevealFullCardDetailsRequest create() =>
      RevealFullCardDetailsRequest._();
  @$core.override
  RevealFullCardDetailsRequest createEmptyInstance() => create();
  static $pb.PbList<RevealFullCardDetailsRequest> createRepeated() =>
      $pb.PbList<RevealFullCardDetailsRequest>();
  @$core.pragma('dart2js:noInline')
  static RevealFullCardDetailsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RevealFullCardDetailsRequest>(create);
  static RevealFullCardDetailsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get cardUuid => $_getSZ(0);
  @$pb.TagNumber(1)
  set cardUuid($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCardUuid() => $_has(0);
  @$pb.TagNumber(1)
  void clearCardUuid() => $_clearField(1);
}

class RevealFullCardDetailsResponse extends $pb.GeneratedMessage {
  factory RevealFullCardDetailsResponse({
    AccountCard? card,
  }) {
    final result = create();
    if (card != null) result.card = card;
    return result;
  }

  RevealFullCardDetailsResponse._();

  factory RevealFullCardDetailsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RevealFullCardDetailsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RevealFullCardDetailsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<AccountCard>(1, _omitFieldNames ? '' : 'card',
        subBuilder: AccountCard.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RevealFullCardDetailsResponse clone() =>
      RevealFullCardDetailsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RevealFullCardDetailsResponse copyWith(
          void Function(RevealFullCardDetailsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as RevealFullCardDetailsResponse))
          as RevealFullCardDetailsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RevealFullCardDetailsResponse create() =>
      RevealFullCardDetailsResponse._();
  @$core.override
  RevealFullCardDetailsResponse createEmptyInstance() => create();
  static $pb.PbList<RevealFullCardDetailsResponse> createRepeated() =>
      $pb.PbList<RevealFullCardDetailsResponse>();
  @$core.pragma('dart2js:noInline')
  static RevealFullCardDetailsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RevealFullCardDetailsResponse>(create);
  static RevealFullCardDetailsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  AccountCard get card => $_getN(0);
  @$pb.TagNumber(1)
  set card(AccountCard value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasCard() => $_has(0);
  @$pb.TagNumber(1)
  void clearCard() => $_clearField(1);
  @$pb.TagNumber(1)
  AccountCard ensureCard() => $_ensure(0);
}

/// Fund card request
class FundCardRequest extends $pb.GeneratedMessage {
  factory FundCardRequest({
    $core.String? cardUuid,
    $core.double? amount,
  }) {
    final result = create();
    if (cardUuid != null) result.cardUuid = cardUuid;
    if (amount != null) result.amount = amount;
    return result;
  }

  FundCardRequest._();

  factory FundCardRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FundCardRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FundCardRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'cardUuid')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FundCardRequest clone() => FundCardRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FundCardRequest copyWith(void Function(FundCardRequest) updates) =>
      super.copyWith((message) => updates(message as FundCardRequest))
          as FundCardRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FundCardRequest create() => FundCardRequest._();
  @$core.override
  FundCardRequest createEmptyInstance() => create();
  static $pb.PbList<FundCardRequest> createRepeated() =>
      $pb.PbList<FundCardRequest>();
  @$core.pragma('dart2js:noInline')
  static FundCardRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FundCardRequest>(create);
  static FundCardRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get cardUuid => $_getSZ(0);
  @$pb.TagNumber(1)
  set cardUuid($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCardUuid() => $_has(0);
  @$pb.TagNumber(1)
  void clearCardUuid() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get amount => $_getN(1);
  @$pb.TagNumber(2)
  set amount($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => $_clearField(2);
}

class FundCardResponse extends $pb.GeneratedMessage {
  factory FundCardResponse({
    AccountCard? card,
  }) {
    final result = create();
    if (card != null) result.card = card;
    return result;
  }

  FundCardResponse._();

  factory FundCardResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FundCardResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FundCardResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<AccountCard>(1, _omitFieldNames ? '' : 'card',
        subBuilder: AccountCard.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FundCardResponse clone() => FundCardResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FundCardResponse copyWith(void Function(FundCardResponse) updates) =>
      super.copyWith((message) => updates(message as FundCardResponse))
          as FundCardResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FundCardResponse create() => FundCardResponse._();
  @$core.override
  FundCardResponse createEmptyInstance() => create();
  static $pb.PbList<FundCardResponse> createRepeated() =>
      $pb.PbList<FundCardResponse>();
  @$core.pragma('dart2js:noInline')
  static FundCardResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FundCardResponse>(create);
  static FundCardResponse? _defaultInstance;

  @$pb.TagNumber(1)
  AccountCard get card => $_getN(0);
  @$pb.TagNumber(1)
  set card(AccountCard value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasCard() => $_has(0);
  @$pb.TagNumber(1)
  void clearCard() => $_clearField(1);
  @$pb.TagNumber(1)
  AccountCard ensureCard() => $_ensure(0);
}

/// Withdraw from card request
class WithdrawFromCardRequest extends $pb.GeneratedMessage {
  factory WithdrawFromCardRequest({
    $core.String? cardUuid,
    $core.double? amount,
  }) {
    final result = create();
    if (cardUuid != null) result.cardUuid = cardUuid;
    if (amount != null) result.amount = amount;
    return result;
  }

  WithdrawFromCardRequest._();

  factory WithdrawFromCardRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory WithdrawFromCardRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'WithdrawFromCardRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'cardUuid')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WithdrawFromCardRequest clone() =>
      WithdrawFromCardRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WithdrawFromCardRequest copyWith(
          void Function(WithdrawFromCardRequest) updates) =>
      super.copyWith((message) => updates(message as WithdrawFromCardRequest))
          as WithdrawFromCardRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WithdrawFromCardRequest create() => WithdrawFromCardRequest._();
  @$core.override
  WithdrawFromCardRequest createEmptyInstance() => create();
  static $pb.PbList<WithdrawFromCardRequest> createRepeated() =>
      $pb.PbList<WithdrawFromCardRequest>();
  @$core.pragma('dart2js:noInline')
  static WithdrawFromCardRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<WithdrawFromCardRequest>(create);
  static WithdrawFromCardRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get cardUuid => $_getSZ(0);
  @$pb.TagNumber(1)
  set cardUuid($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCardUuid() => $_has(0);
  @$pb.TagNumber(1)
  void clearCardUuid() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get amount => $_getN(1);
  @$pb.TagNumber(2)
  set amount($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => $_clearField(2);
}

class WithdrawFromCardResponse extends $pb.GeneratedMessage {
  factory WithdrawFromCardResponse({
    AccountCard? card,
  }) {
    final result = create();
    if (card != null) result.card = card;
    return result;
  }

  WithdrawFromCardResponse._();

  factory WithdrawFromCardResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory WithdrawFromCardResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'WithdrawFromCardResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<AccountCard>(1, _omitFieldNames ? '' : 'card',
        subBuilder: AccountCard.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WithdrawFromCardResponse clone() =>
      WithdrawFromCardResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WithdrawFromCardResponse copyWith(
          void Function(WithdrawFromCardResponse) updates) =>
      super.copyWith((message) => updates(message as WithdrawFromCardResponse))
          as WithdrawFromCardResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WithdrawFromCardResponse create() => WithdrawFromCardResponse._();
  @$core.override
  WithdrawFromCardResponse createEmptyInstance() => create();
  static $pb.PbList<WithdrawFromCardResponse> createRepeated() =>
      $pb.PbList<WithdrawFromCardResponse>();
  @$core.pragma('dart2js:noInline')
  static WithdrawFromCardResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<WithdrawFromCardResponse>(create);
  static WithdrawFromCardResponse? _defaultInstance;

  @$pb.TagNumber(1)
  AccountCard get card => $_getN(0);
  @$pb.TagNumber(1)
  set card(AccountCard value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasCard() => $_has(0);
  @$pb.TagNumber(1)
  void clearCard() => $_clearField(1);
  @$pb.TagNumber(1)
  AccountCard ensureCard() => $_ensure(0);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
