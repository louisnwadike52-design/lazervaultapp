// This is a generated file - do not edit.
//
// Generated from id_pay.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/timestamp.pb.dart' as $1;
import 'id_pay.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'id_pay.pbenum.dart';

/// Models
class IDPay extends $pb.GeneratedMessage {
  factory IDPay({
    $core.String? id,
    $core.String? payId,
    $core.String? creatorId,
    $core.String? creatorName,
    $core.String? creatorUsername,
    IDPayType? type,
    IDPayAmountMode? amountMode,
    $core.double? amount,
    $core.double? minAmount,
    $core.double? maxAmount,
    $core.String? currency,
    $core.String? description,
    IDPayStatus? status,
    $1.Timestamp? expiresAt,
    $1.Timestamp? createdAt,
    $core.double? totalReceived,
    $core.int? paymentCount,
    $core.bool? neverExpires,
    $core.String? organizationId,
    $core.String? organizationName,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (payId != null) result.payId = payId;
    if (creatorId != null) result.creatorId = creatorId;
    if (creatorName != null) result.creatorName = creatorName;
    if (creatorUsername != null) result.creatorUsername = creatorUsername;
    if (type != null) result.type = type;
    if (amountMode != null) result.amountMode = amountMode;
    if (amount != null) result.amount = amount;
    if (minAmount != null) result.minAmount = minAmount;
    if (maxAmount != null) result.maxAmount = maxAmount;
    if (currency != null) result.currency = currency;
    if (description != null) result.description = description;
    if (status != null) result.status = status;
    if (expiresAt != null) result.expiresAt = expiresAt;
    if (createdAt != null) result.createdAt = createdAt;
    if (totalReceived != null) result.totalReceived = totalReceived;
    if (paymentCount != null) result.paymentCount = paymentCount;
    if (neverExpires != null) result.neverExpires = neverExpires;
    if (organizationId != null) result.organizationId = organizationId;
    if (organizationName != null) result.organizationName = organizationName;
    return result;
  }

  IDPay._();

  factory IDPay.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory IDPay.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'IDPay',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'id_pay'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'payId')
    ..aOS(3, _omitFieldNames ? '' : 'creatorId')
    ..aOS(4, _omitFieldNames ? '' : 'creatorName')
    ..aOS(5, _omitFieldNames ? '' : 'creatorUsername')
    ..e<IDPayType>(6, _omitFieldNames ? '' : 'type', $pb.PbFieldType.OE,
        defaultOrMaker: IDPayType.ID_PAY_TYPE_UNSPECIFIED,
        valueOf: IDPayType.valueOf,
        enumValues: IDPayType.values)
    ..e<IDPayAmountMode>(
        7, _omitFieldNames ? '' : 'amountMode', $pb.PbFieldType.OE,
        defaultOrMaker: IDPayAmountMode.ID_PAY_AMOUNT_UNSPECIFIED,
        valueOf: IDPayAmountMode.valueOf,
        enumValues: IDPayAmountMode.values)
    ..a<$core.double>(8, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..a<$core.double>(9, _omitFieldNames ? '' : 'minAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(
        10, _omitFieldNames ? '' : 'maxAmount', $pb.PbFieldType.OD)
    ..aOS(11, _omitFieldNames ? '' : 'currency')
    ..aOS(12, _omitFieldNames ? '' : 'description')
    ..e<IDPayStatus>(13, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: IDPayStatus.ID_PAY_STATUS_UNSPECIFIED,
        valueOf: IDPayStatus.valueOf,
        enumValues: IDPayStatus.values)
    ..aOM<$1.Timestamp>(14, _omitFieldNames ? '' : 'expiresAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(15, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $1.Timestamp.create)
    ..a<$core.double>(
        16, _omitFieldNames ? '' : 'totalReceived', $pb.PbFieldType.OD)
    ..a<$core.int>(
        17, _omitFieldNames ? '' : 'paymentCount', $pb.PbFieldType.O3)
    ..aOB(18, _omitFieldNames ? '' : 'neverExpires')
    ..aOS(19, _omitFieldNames ? '' : 'organizationId')
    ..aOS(20, _omitFieldNames ? '' : 'organizationName')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  IDPay clone() => IDPay()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  IDPay copyWith(void Function(IDPay) updates) =>
      super.copyWith((message) => updates(message as IDPay)) as IDPay;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static IDPay create() => IDPay._();
  @$core.override
  IDPay createEmptyInstance() => create();
  static $pb.PbList<IDPay> createRepeated() => $pb.PbList<IDPay>();
  @$core.pragma('dart2js:noInline')
  static IDPay getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<IDPay>(create);
  static IDPay? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get payId => $_getSZ(1);
  @$pb.TagNumber(2)
  set payId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPayId() => $_has(1);
  @$pb.TagNumber(2)
  void clearPayId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get creatorId => $_getSZ(2);
  @$pb.TagNumber(3)
  set creatorId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCreatorId() => $_has(2);
  @$pb.TagNumber(3)
  void clearCreatorId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get creatorName => $_getSZ(3);
  @$pb.TagNumber(4)
  set creatorName($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCreatorName() => $_has(3);
  @$pb.TagNumber(4)
  void clearCreatorName() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get creatorUsername => $_getSZ(4);
  @$pb.TagNumber(5)
  set creatorUsername($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasCreatorUsername() => $_has(4);
  @$pb.TagNumber(5)
  void clearCreatorUsername() => $_clearField(5);

  @$pb.TagNumber(6)
  IDPayType get type => $_getN(5);
  @$pb.TagNumber(6)
  set type(IDPayType value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasType() => $_has(5);
  @$pb.TagNumber(6)
  void clearType() => $_clearField(6);

  @$pb.TagNumber(7)
  IDPayAmountMode get amountMode => $_getN(6);
  @$pb.TagNumber(7)
  set amountMode(IDPayAmountMode value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasAmountMode() => $_has(6);
  @$pb.TagNumber(7)
  void clearAmountMode() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.double get amount => $_getN(7);
  @$pb.TagNumber(8)
  set amount($core.double value) => $_setDouble(7, value);
  @$pb.TagNumber(8)
  $core.bool hasAmount() => $_has(7);
  @$pb.TagNumber(8)
  void clearAmount() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.double get minAmount => $_getN(8);
  @$pb.TagNumber(9)
  set minAmount($core.double value) => $_setDouble(8, value);
  @$pb.TagNumber(9)
  $core.bool hasMinAmount() => $_has(8);
  @$pb.TagNumber(9)
  void clearMinAmount() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.double get maxAmount => $_getN(9);
  @$pb.TagNumber(10)
  set maxAmount($core.double value) => $_setDouble(9, value);
  @$pb.TagNumber(10)
  $core.bool hasMaxAmount() => $_has(9);
  @$pb.TagNumber(10)
  void clearMaxAmount() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get currency => $_getSZ(10);
  @$pb.TagNumber(11)
  set currency($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasCurrency() => $_has(10);
  @$pb.TagNumber(11)
  void clearCurrency() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get description => $_getSZ(11);
  @$pb.TagNumber(12)
  set description($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasDescription() => $_has(11);
  @$pb.TagNumber(12)
  void clearDescription() => $_clearField(12);

  @$pb.TagNumber(13)
  IDPayStatus get status => $_getN(12);
  @$pb.TagNumber(13)
  set status(IDPayStatus value) => $_setField(13, value);
  @$pb.TagNumber(13)
  $core.bool hasStatus() => $_has(12);
  @$pb.TagNumber(13)
  void clearStatus() => $_clearField(13);

  @$pb.TagNumber(14)
  $1.Timestamp get expiresAt => $_getN(13);
  @$pb.TagNumber(14)
  set expiresAt($1.Timestamp value) => $_setField(14, value);
  @$pb.TagNumber(14)
  $core.bool hasExpiresAt() => $_has(13);
  @$pb.TagNumber(14)
  void clearExpiresAt() => $_clearField(14);
  @$pb.TagNumber(14)
  $1.Timestamp ensureExpiresAt() => $_ensure(13);

  @$pb.TagNumber(15)
  $1.Timestamp get createdAt => $_getN(14);
  @$pb.TagNumber(15)
  set createdAt($1.Timestamp value) => $_setField(15, value);
  @$pb.TagNumber(15)
  $core.bool hasCreatedAt() => $_has(14);
  @$pb.TagNumber(15)
  void clearCreatedAt() => $_clearField(15);
  @$pb.TagNumber(15)
  $1.Timestamp ensureCreatedAt() => $_ensure(14);

  @$pb.TagNumber(16)
  $core.double get totalReceived => $_getN(15);
  @$pb.TagNumber(16)
  set totalReceived($core.double value) => $_setDouble(15, value);
  @$pb.TagNumber(16)
  $core.bool hasTotalReceived() => $_has(15);
  @$pb.TagNumber(16)
  void clearTotalReceived() => $_clearField(16);

  @$pb.TagNumber(17)
  $core.int get paymentCount => $_getIZ(16);
  @$pb.TagNumber(17)
  set paymentCount($core.int value) => $_setSignedInt32(16, value);
  @$pb.TagNumber(17)
  $core.bool hasPaymentCount() => $_has(16);
  @$pb.TagNumber(17)
  void clearPaymentCount() => $_clearField(17);

  @$pb.TagNumber(18)
  $core.bool get neverExpires => $_getBF(17);
  @$pb.TagNumber(18)
  set neverExpires($core.bool value) => $_setBool(17, value);
  @$pb.TagNumber(18)
  $core.bool hasNeverExpires() => $_has(17);
  @$pb.TagNumber(18)
  void clearNeverExpires() => $_clearField(18);

  @$pb.TagNumber(19)
  $core.String get organizationId => $_getSZ(18);
  @$pb.TagNumber(19)
  set organizationId($core.String value) => $_setString(18, value);
  @$pb.TagNumber(19)
  $core.bool hasOrganizationId() => $_has(18);
  @$pb.TagNumber(19)
  void clearOrganizationId() => $_clearField(19);

  @$pb.TagNumber(20)
  $core.String get organizationName => $_getSZ(19);
  @$pb.TagNumber(20)
  set organizationName($core.String value) => $_setString(19, value);
  @$pb.TagNumber(20)
  $core.bool hasOrganizationName() => $_has(19);
  @$pb.TagNumber(20)
  void clearOrganizationName() => $_clearField(20);
}

class IDPayTransaction extends $pb.GeneratedMessage {
  factory IDPayTransaction({
    $core.String? id,
    $core.String? payId,
    $core.String? payerId,
    $core.String? payerName,
    $core.String? payerUsername,
    $core.String? recipientId,
    $core.String? recipientName,
    $core.double? amount,
    $core.String? currency,
    $core.String? reference,
    $core.String? status,
    $1.Timestamp? createdAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (payId != null) result.payId = payId;
    if (payerId != null) result.payerId = payerId;
    if (payerName != null) result.payerName = payerName;
    if (payerUsername != null) result.payerUsername = payerUsername;
    if (recipientId != null) result.recipientId = recipientId;
    if (recipientName != null) result.recipientName = recipientName;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    if (reference != null) result.reference = reference;
    if (status != null) result.status = status;
    if (createdAt != null) result.createdAt = createdAt;
    return result;
  }

  IDPayTransaction._();

  factory IDPayTransaction.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory IDPayTransaction.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'IDPayTransaction',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'id_pay'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'payId')
    ..aOS(3, _omitFieldNames ? '' : 'payerId')
    ..aOS(4, _omitFieldNames ? '' : 'payerName')
    ..aOS(5, _omitFieldNames ? '' : 'payerUsername')
    ..aOS(6, _omitFieldNames ? '' : 'recipientId')
    ..aOS(7, _omitFieldNames ? '' : 'recipientName')
    ..a<$core.double>(8, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(9, _omitFieldNames ? '' : 'currency')
    ..aOS(10, _omitFieldNames ? '' : 'reference')
    ..aOS(11, _omitFieldNames ? '' : 'status')
    ..aOM<$1.Timestamp>(12, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  IDPayTransaction clone() => IDPayTransaction()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  IDPayTransaction copyWith(void Function(IDPayTransaction) updates) =>
      super.copyWith((message) => updates(message as IDPayTransaction))
          as IDPayTransaction;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static IDPayTransaction create() => IDPayTransaction._();
  @$core.override
  IDPayTransaction createEmptyInstance() => create();
  static $pb.PbList<IDPayTransaction> createRepeated() =>
      $pb.PbList<IDPayTransaction>();
  @$core.pragma('dart2js:noInline')
  static IDPayTransaction getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<IDPayTransaction>(create);
  static IDPayTransaction? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get payId => $_getSZ(1);
  @$pb.TagNumber(2)
  set payId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPayId() => $_has(1);
  @$pb.TagNumber(2)
  void clearPayId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get payerId => $_getSZ(2);
  @$pb.TagNumber(3)
  set payerId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPayerId() => $_has(2);
  @$pb.TagNumber(3)
  void clearPayerId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get payerName => $_getSZ(3);
  @$pb.TagNumber(4)
  set payerName($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPayerName() => $_has(3);
  @$pb.TagNumber(4)
  void clearPayerName() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get payerUsername => $_getSZ(4);
  @$pb.TagNumber(5)
  set payerUsername($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasPayerUsername() => $_has(4);
  @$pb.TagNumber(5)
  void clearPayerUsername() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get recipientId => $_getSZ(5);
  @$pb.TagNumber(6)
  set recipientId($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasRecipientId() => $_has(5);
  @$pb.TagNumber(6)
  void clearRecipientId() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get recipientName => $_getSZ(6);
  @$pb.TagNumber(7)
  set recipientName($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasRecipientName() => $_has(6);
  @$pb.TagNumber(7)
  void clearRecipientName() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.double get amount => $_getN(7);
  @$pb.TagNumber(8)
  set amount($core.double value) => $_setDouble(7, value);
  @$pb.TagNumber(8)
  $core.bool hasAmount() => $_has(7);
  @$pb.TagNumber(8)
  void clearAmount() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get currency => $_getSZ(8);
  @$pb.TagNumber(9)
  set currency($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasCurrency() => $_has(8);
  @$pb.TagNumber(9)
  void clearCurrency() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get reference => $_getSZ(9);
  @$pb.TagNumber(10)
  set reference($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasReference() => $_has(9);
  @$pb.TagNumber(10)
  void clearReference() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get status => $_getSZ(10);
  @$pb.TagNumber(11)
  set status($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasStatus() => $_has(10);
  @$pb.TagNumber(11)
  void clearStatus() => $_clearField(11);

  @$pb.TagNumber(12)
  $1.Timestamp get createdAt => $_getN(11);
  @$pb.TagNumber(12)
  set createdAt($1.Timestamp value) => $_setField(12, value);
  @$pb.TagNumber(12)
  $core.bool hasCreatedAt() => $_has(11);
  @$pb.TagNumber(12)
  void clearCreatedAt() => $_clearField(12);
  @$pb.TagNumber(12)
  $1.Timestamp ensureCreatedAt() => $_ensure(11);
}

class IDPayOrganization extends $pb.GeneratedMessage {
  factory IDPayOrganization({
    $core.String? id,
    $core.String? creatorId,
    $core.String? name,
    $core.String? description,
    $core.String? logoUrl,
    $core.String? accountId,
    $core.double? totalReceived,
    $core.int? totalPaymentCount,
    $core.int? activeIdPayCount,
    $1.Timestamp? createdAt,
    $1.Timestamp? updatedAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (creatorId != null) result.creatorId = creatorId;
    if (name != null) result.name = name;
    if (description != null) result.description = description;
    if (logoUrl != null) result.logoUrl = logoUrl;
    if (accountId != null) result.accountId = accountId;
    if (totalReceived != null) result.totalReceived = totalReceived;
    if (totalPaymentCount != null) result.totalPaymentCount = totalPaymentCount;
    if (activeIdPayCount != null) result.activeIdPayCount = activeIdPayCount;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    return result;
  }

  IDPayOrganization._();

  factory IDPayOrganization.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory IDPayOrganization.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'IDPayOrganization',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'id_pay'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'creatorId')
    ..aOS(3, _omitFieldNames ? '' : 'name')
    ..aOS(4, _omitFieldNames ? '' : 'description')
    ..aOS(5, _omitFieldNames ? '' : 'logoUrl')
    ..aOS(6, _omitFieldNames ? '' : 'accountId')
    ..a<$core.double>(
        7, _omitFieldNames ? '' : 'totalReceived', $pb.PbFieldType.OD)
    ..a<$core.int>(
        8, _omitFieldNames ? '' : 'totalPaymentCount', $pb.PbFieldType.O3)
    ..a<$core.int>(
        9, _omitFieldNames ? '' : 'activeIdPayCount', $pb.PbFieldType.O3)
    ..aOM<$1.Timestamp>(10, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(11, _omitFieldNames ? '' : 'updatedAt',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  IDPayOrganization clone() => IDPayOrganization()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  IDPayOrganization copyWith(void Function(IDPayOrganization) updates) =>
      super.copyWith((message) => updates(message as IDPayOrganization))
          as IDPayOrganization;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static IDPayOrganization create() => IDPayOrganization._();
  @$core.override
  IDPayOrganization createEmptyInstance() => create();
  static $pb.PbList<IDPayOrganization> createRepeated() =>
      $pb.PbList<IDPayOrganization>();
  @$core.pragma('dart2js:noInline')
  static IDPayOrganization getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<IDPayOrganization>(create);
  static IDPayOrganization? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get creatorId => $_getSZ(1);
  @$pb.TagNumber(2)
  set creatorId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCreatorId() => $_has(1);
  @$pb.TagNumber(2)
  void clearCreatorId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(3)
  set name($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get description => $_getSZ(3);
  @$pb.TagNumber(4)
  set description($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDescription() => $_has(3);
  @$pb.TagNumber(4)
  void clearDescription() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get logoUrl => $_getSZ(4);
  @$pb.TagNumber(5)
  set logoUrl($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasLogoUrl() => $_has(4);
  @$pb.TagNumber(5)
  void clearLogoUrl() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get accountId => $_getSZ(5);
  @$pb.TagNumber(6)
  set accountId($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasAccountId() => $_has(5);
  @$pb.TagNumber(6)
  void clearAccountId() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.double get totalReceived => $_getN(6);
  @$pb.TagNumber(7)
  set totalReceived($core.double value) => $_setDouble(6, value);
  @$pb.TagNumber(7)
  $core.bool hasTotalReceived() => $_has(6);
  @$pb.TagNumber(7)
  void clearTotalReceived() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.int get totalPaymentCount => $_getIZ(7);
  @$pb.TagNumber(8)
  set totalPaymentCount($core.int value) => $_setSignedInt32(7, value);
  @$pb.TagNumber(8)
  $core.bool hasTotalPaymentCount() => $_has(7);
  @$pb.TagNumber(8)
  void clearTotalPaymentCount() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.int get activeIdPayCount => $_getIZ(8);
  @$pb.TagNumber(9)
  set activeIdPayCount($core.int value) => $_setSignedInt32(8, value);
  @$pb.TagNumber(9)
  $core.bool hasActiveIdPayCount() => $_has(8);
  @$pb.TagNumber(9)
  void clearActiveIdPayCount() => $_clearField(9);

  @$pb.TagNumber(10)
  $1.Timestamp get createdAt => $_getN(9);
  @$pb.TagNumber(10)
  set createdAt($1.Timestamp value) => $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasCreatedAt() => $_has(9);
  @$pb.TagNumber(10)
  void clearCreatedAt() => $_clearField(10);
  @$pb.TagNumber(10)
  $1.Timestamp ensureCreatedAt() => $_ensure(9);

  @$pb.TagNumber(11)
  $1.Timestamp get updatedAt => $_getN(10);
  @$pb.TagNumber(11)
  set updatedAt($1.Timestamp value) => $_setField(11, value);
  @$pb.TagNumber(11)
  $core.bool hasUpdatedAt() => $_has(10);
  @$pb.TagNumber(11)
  void clearUpdatedAt() => $_clearField(11);
  @$pb.TagNumber(11)
  $1.Timestamp ensureUpdatedAt() => $_ensure(10);
}

/// Request/Response messages
class CreateIDPayRequest extends $pb.GeneratedMessage {
  factory CreateIDPayRequest({
    IDPayType? type,
    IDPayAmountMode? amountMode,
    $core.double? amount,
    $core.String? currency,
    $core.double? minAmount,
    $core.double? maxAmount,
    $core.String? description,
    $core.int? validityMinutes,
    $core.String? recipientAccountId,
    $core.bool? neverExpires,
    $core.String? organizationId,
  }) {
    final result = create();
    if (type != null) result.type = type;
    if (amountMode != null) result.amountMode = amountMode;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    if (minAmount != null) result.minAmount = minAmount;
    if (maxAmount != null) result.maxAmount = maxAmount;
    if (description != null) result.description = description;
    if (validityMinutes != null) result.validityMinutes = validityMinutes;
    if (recipientAccountId != null)
      result.recipientAccountId = recipientAccountId;
    if (neverExpires != null) result.neverExpires = neverExpires;
    if (organizationId != null) result.organizationId = organizationId;
    return result;
  }

  CreateIDPayRequest._();

  factory CreateIDPayRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateIDPayRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateIDPayRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'id_pay'),
      createEmptyInstance: create)
    ..e<IDPayType>(1, _omitFieldNames ? '' : 'type', $pb.PbFieldType.OE,
        defaultOrMaker: IDPayType.ID_PAY_TYPE_UNSPECIFIED,
        valueOf: IDPayType.valueOf,
        enumValues: IDPayType.values)
    ..e<IDPayAmountMode>(
        2, _omitFieldNames ? '' : 'amountMode', $pb.PbFieldType.OE,
        defaultOrMaker: IDPayAmountMode.ID_PAY_AMOUNT_UNSPECIFIED,
        valueOf: IDPayAmountMode.valueOf,
        enumValues: IDPayAmountMode.values)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(4, _omitFieldNames ? '' : 'currency')
    ..a<$core.double>(5, _omitFieldNames ? '' : 'minAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(6, _omitFieldNames ? '' : 'maxAmount', $pb.PbFieldType.OD)
    ..aOS(7, _omitFieldNames ? '' : 'description')
    ..a<$core.int>(
        8, _omitFieldNames ? '' : 'validityMinutes', $pb.PbFieldType.O3)
    ..aOS(9, _omitFieldNames ? '' : 'recipientAccountId')
    ..aOB(10, _omitFieldNames ? '' : 'neverExpires')
    ..aOS(11, _omitFieldNames ? '' : 'organizationId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateIDPayRequest clone() => CreateIDPayRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateIDPayRequest copyWith(void Function(CreateIDPayRequest) updates) =>
      super.copyWith((message) => updates(message as CreateIDPayRequest))
          as CreateIDPayRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateIDPayRequest create() => CreateIDPayRequest._();
  @$core.override
  CreateIDPayRequest createEmptyInstance() => create();
  static $pb.PbList<CreateIDPayRequest> createRepeated() =>
      $pb.PbList<CreateIDPayRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateIDPayRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateIDPayRequest>(create);
  static CreateIDPayRequest? _defaultInstance;

  @$pb.TagNumber(1)
  IDPayType get type => $_getN(0);
  @$pb.TagNumber(1)
  set type(IDPayType value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => $_clearField(1);

  @$pb.TagNumber(2)
  IDPayAmountMode get amountMode => $_getN(1);
  @$pb.TagNumber(2)
  set amountMode(IDPayAmountMode value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasAmountMode() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmountMode() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get amount => $_getN(2);
  @$pb.TagNumber(3)
  set amount($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get currency => $_getSZ(3);
  @$pb.TagNumber(4)
  set currency($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCurrency() => $_has(3);
  @$pb.TagNumber(4)
  void clearCurrency() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get minAmount => $_getN(4);
  @$pb.TagNumber(5)
  set minAmount($core.double value) => $_setDouble(4, value);
  @$pb.TagNumber(5)
  $core.bool hasMinAmount() => $_has(4);
  @$pb.TagNumber(5)
  void clearMinAmount() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.double get maxAmount => $_getN(5);
  @$pb.TagNumber(6)
  set maxAmount($core.double value) => $_setDouble(5, value);
  @$pb.TagNumber(6)
  $core.bool hasMaxAmount() => $_has(5);
  @$pb.TagNumber(6)
  void clearMaxAmount() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get description => $_getSZ(6);
  @$pb.TagNumber(7)
  set description($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasDescription() => $_has(6);
  @$pb.TagNumber(7)
  void clearDescription() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.int get validityMinutes => $_getIZ(7);
  @$pb.TagNumber(8)
  set validityMinutes($core.int value) => $_setSignedInt32(7, value);
  @$pb.TagNumber(8)
  $core.bool hasValidityMinutes() => $_has(7);
  @$pb.TagNumber(8)
  void clearValidityMinutes() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get recipientAccountId => $_getSZ(8);
  @$pb.TagNumber(9)
  set recipientAccountId($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasRecipientAccountId() => $_has(8);
  @$pb.TagNumber(9)
  void clearRecipientAccountId() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.bool get neverExpires => $_getBF(9);
  @$pb.TagNumber(10)
  set neverExpires($core.bool value) => $_setBool(9, value);
  @$pb.TagNumber(10)
  $core.bool hasNeverExpires() => $_has(9);
  @$pb.TagNumber(10)
  void clearNeverExpires() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get organizationId => $_getSZ(10);
  @$pb.TagNumber(11)
  set organizationId($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasOrganizationId() => $_has(10);
  @$pb.TagNumber(11)
  void clearOrganizationId() => $_clearField(11);
}

class CreateIDPayResponse extends $pb.GeneratedMessage {
  factory CreateIDPayResponse({
    IDPay? idPay,
    $core.String? message,
  }) {
    final result = create();
    if (idPay != null) result.idPay = idPay;
    if (message != null) result.message = message;
    return result;
  }

  CreateIDPayResponse._();

  factory CreateIDPayResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateIDPayResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateIDPayResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'id_pay'),
      createEmptyInstance: create)
    ..aOM<IDPay>(1, _omitFieldNames ? '' : 'idPay', subBuilder: IDPay.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateIDPayResponse clone() => CreateIDPayResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateIDPayResponse copyWith(void Function(CreateIDPayResponse) updates) =>
      super.copyWith((message) => updates(message as CreateIDPayResponse))
          as CreateIDPayResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateIDPayResponse create() => CreateIDPayResponse._();
  @$core.override
  CreateIDPayResponse createEmptyInstance() => create();
  static $pb.PbList<CreateIDPayResponse> createRepeated() =>
      $pb.PbList<CreateIDPayResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateIDPayResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateIDPayResponse>(create);
  static CreateIDPayResponse? _defaultInstance;

  @$pb.TagNumber(1)
  IDPay get idPay => $_getN(0);
  @$pb.TagNumber(1)
  set idPay(IDPay value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasIdPay() => $_has(0);
  @$pb.TagNumber(1)
  void clearIdPay() => $_clearField(1);
  @$pb.TagNumber(1)
  IDPay ensureIdPay() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);
}

class LookupIDPayRequest extends $pb.GeneratedMessage {
  factory LookupIDPayRequest({
    $core.String? payId,
  }) {
    final result = create();
    if (payId != null) result.payId = payId;
    return result;
  }

  LookupIDPayRequest._();

  factory LookupIDPayRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory LookupIDPayRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LookupIDPayRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'id_pay'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'payId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LookupIDPayRequest clone() => LookupIDPayRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LookupIDPayRequest copyWith(void Function(LookupIDPayRequest) updates) =>
      super.copyWith((message) => updates(message as LookupIDPayRequest))
          as LookupIDPayRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LookupIDPayRequest create() => LookupIDPayRequest._();
  @$core.override
  LookupIDPayRequest createEmptyInstance() => create();
  static $pb.PbList<LookupIDPayRequest> createRepeated() =>
      $pb.PbList<LookupIDPayRequest>();
  @$core.pragma('dart2js:noInline')
  static LookupIDPayRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LookupIDPayRequest>(create);
  static LookupIDPayRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get payId => $_getSZ(0);
  @$pb.TagNumber(1)
  set payId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPayId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayId() => $_clearField(1);
}

class LookupIDPayResponse extends $pb.GeneratedMessage {
  factory LookupIDPayResponse({
    IDPay? idPay,
    IDPayOrganization? organization,
  }) {
    final result = create();
    if (idPay != null) result.idPay = idPay;
    if (organization != null) result.organization = organization;
    return result;
  }

  LookupIDPayResponse._();

  factory LookupIDPayResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory LookupIDPayResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LookupIDPayResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'id_pay'),
      createEmptyInstance: create)
    ..aOM<IDPay>(1, _omitFieldNames ? '' : 'idPay', subBuilder: IDPay.create)
    ..aOM<IDPayOrganization>(2, _omitFieldNames ? '' : 'organization',
        subBuilder: IDPayOrganization.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LookupIDPayResponse clone() => LookupIDPayResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LookupIDPayResponse copyWith(void Function(LookupIDPayResponse) updates) =>
      super.copyWith((message) => updates(message as LookupIDPayResponse))
          as LookupIDPayResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LookupIDPayResponse create() => LookupIDPayResponse._();
  @$core.override
  LookupIDPayResponse createEmptyInstance() => create();
  static $pb.PbList<LookupIDPayResponse> createRepeated() =>
      $pb.PbList<LookupIDPayResponse>();
  @$core.pragma('dart2js:noInline')
  static LookupIDPayResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LookupIDPayResponse>(create);
  static LookupIDPayResponse? _defaultInstance;

  @$pb.TagNumber(1)
  IDPay get idPay => $_getN(0);
  @$pb.TagNumber(1)
  set idPay(IDPay value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasIdPay() => $_has(0);
  @$pb.TagNumber(1)
  void clearIdPay() => $_clearField(1);
  @$pb.TagNumber(1)
  IDPay ensureIdPay() => $_ensure(0);

  @$pb.TagNumber(2)
  IDPayOrganization get organization => $_getN(1);
  @$pb.TagNumber(2)
  set organization(IDPayOrganization value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasOrganization() => $_has(1);
  @$pb.TagNumber(2)
  void clearOrganization() => $_clearField(2);
  @$pb.TagNumber(2)
  IDPayOrganization ensureOrganization() => $_ensure(1);
}

class PayIDPayRequest extends $pb.GeneratedMessage {
  factory PayIDPayRequest({
    $core.String? payId,
    $core.double? amount,
    $core.String? transactionPin,
    $core.String? sourceAccountId,
    $core.String? idempotencyKey,
  }) {
    final result = create();
    if (payId != null) result.payId = payId;
    if (amount != null) result.amount = amount;
    if (transactionPin != null) result.transactionPin = transactionPin;
    if (sourceAccountId != null) result.sourceAccountId = sourceAccountId;
    if (idempotencyKey != null) result.idempotencyKey = idempotencyKey;
    return result;
  }

  PayIDPayRequest._();

  factory PayIDPayRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PayIDPayRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PayIDPayRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'id_pay'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'payId')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(3, _omitFieldNames ? '' : 'transactionPin')
    ..aOS(4, _omitFieldNames ? '' : 'sourceAccountId')
    ..aOS(5, _omitFieldNames ? '' : 'idempotencyKey')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PayIDPayRequest clone() => PayIDPayRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PayIDPayRequest copyWith(void Function(PayIDPayRequest) updates) =>
      super.copyWith((message) => updates(message as PayIDPayRequest))
          as PayIDPayRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PayIDPayRequest create() => PayIDPayRequest._();
  @$core.override
  PayIDPayRequest createEmptyInstance() => create();
  static $pb.PbList<PayIDPayRequest> createRepeated() =>
      $pb.PbList<PayIDPayRequest>();
  @$core.pragma('dart2js:noInline')
  static PayIDPayRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PayIDPayRequest>(create);
  static PayIDPayRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get payId => $_getSZ(0);
  @$pb.TagNumber(1)
  set payId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPayId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get amount => $_getN(1);
  @$pb.TagNumber(2)
  set amount($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get transactionPin => $_getSZ(2);
  @$pb.TagNumber(3)
  set transactionPin($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTransactionPin() => $_has(2);
  @$pb.TagNumber(3)
  void clearTransactionPin() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get sourceAccountId => $_getSZ(3);
  @$pb.TagNumber(4)
  set sourceAccountId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasSourceAccountId() => $_has(3);
  @$pb.TagNumber(4)
  void clearSourceAccountId() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get idempotencyKey => $_getSZ(4);
  @$pb.TagNumber(5)
  set idempotencyKey($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasIdempotencyKey() => $_has(4);
  @$pb.TagNumber(5)
  void clearIdempotencyKey() => $_clearField(5);
}

class PayIDPayResponse extends $pb.GeneratedMessage {
  factory PayIDPayResponse({
    IDPayTransaction? transaction,
    $core.double? newBalance,
    $core.String? message,
  }) {
    final result = create();
    if (transaction != null) result.transaction = transaction;
    if (newBalance != null) result.newBalance = newBalance;
    if (message != null) result.message = message;
    return result;
  }

  PayIDPayResponse._();

  factory PayIDPayResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PayIDPayResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PayIDPayResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'id_pay'),
      createEmptyInstance: create)
    ..aOM<IDPayTransaction>(1, _omitFieldNames ? '' : 'transaction',
        subBuilder: IDPayTransaction.create)
    ..a<$core.double>(
        2, _omitFieldNames ? '' : 'newBalance', $pb.PbFieldType.OD)
    ..aOS(3, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PayIDPayResponse clone() => PayIDPayResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PayIDPayResponse copyWith(void Function(PayIDPayResponse) updates) =>
      super.copyWith((message) => updates(message as PayIDPayResponse))
          as PayIDPayResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PayIDPayResponse create() => PayIDPayResponse._();
  @$core.override
  PayIDPayResponse createEmptyInstance() => create();
  static $pb.PbList<PayIDPayResponse> createRepeated() =>
      $pb.PbList<PayIDPayResponse>();
  @$core.pragma('dart2js:noInline')
  static PayIDPayResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PayIDPayResponse>(create);
  static PayIDPayResponse? _defaultInstance;

  @$pb.TagNumber(1)
  IDPayTransaction get transaction => $_getN(0);
  @$pb.TagNumber(1)
  set transaction(IDPayTransaction value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasTransaction() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransaction() => $_clearField(1);
  @$pb.TagNumber(1)
  IDPayTransaction ensureTransaction() => $_ensure(0);

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
}

class GetMyIDPaysRequest extends $pb.GeneratedMessage {
  factory GetMyIDPaysRequest({
    $core.int? limit,
    $core.int? offset,
    IDPayStatus? statusFilter,
  }) {
    final result = create();
    if (limit != null) result.limit = limit;
    if (offset != null) result.offset = offset;
    if (statusFilter != null) result.statusFilter = statusFilter;
    return result;
  }

  GetMyIDPaysRequest._();

  factory GetMyIDPaysRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMyIDPaysRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMyIDPaysRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'id_pay'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'offset', $pb.PbFieldType.O3)
    ..e<IDPayStatus>(
        3, _omitFieldNames ? '' : 'statusFilter', $pb.PbFieldType.OE,
        defaultOrMaker: IDPayStatus.ID_PAY_STATUS_UNSPECIFIED,
        valueOf: IDPayStatus.valueOf,
        enumValues: IDPayStatus.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyIDPaysRequest clone() => GetMyIDPaysRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyIDPaysRequest copyWith(void Function(GetMyIDPaysRequest) updates) =>
      super.copyWith((message) => updates(message as GetMyIDPaysRequest))
          as GetMyIDPaysRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMyIDPaysRequest create() => GetMyIDPaysRequest._();
  @$core.override
  GetMyIDPaysRequest createEmptyInstance() => create();
  static $pb.PbList<GetMyIDPaysRequest> createRepeated() =>
      $pb.PbList<GetMyIDPaysRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMyIDPaysRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetMyIDPaysRequest>(create);
  static GetMyIDPaysRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get limit => $_getIZ(0);
  @$pb.TagNumber(1)
  set limit($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasLimit() => $_has(0);
  @$pb.TagNumber(1)
  void clearLimit() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get offset => $_getIZ(1);
  @$pb.TagNumber(2)
  set offset($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasOffset() => $_has(1);
  @$pb.TagNumber(2)
  void clearOffset() => $_clearField(2);

  @$pb.TagNumber(3)
  IDPayStatus get statusFilter => $_getN(2);
  @$pb.TagNumber(3)
  set statusFilter(IDPayStatus value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasStatusFilter() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatusFilter() => $_clearField(3);
}

class GetMyIDPaysResponse extends $pb.GeneratedMessage {
  factory GetMyIDPaysResponse({
    $core.Iterable<IDPay>? idPays,
    $core.int? total,
  }) {
    final result = create();
    if (idPays != null) result.idPays.addAll(idPays);
    if (total != null) result.total = total;
    return result;
  }

  GetMyIDPaysResponse._();

  factory GetMyIDPaysResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMyIDPaysResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMyIDPaysResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'id_pay'),
      createEmptyInstance: create)
    ..pc<IDPay>(1, _omitFieldNames ? '' : 'idPays', $pb.PbFieldType.PM,
        subBuilder: IDPay.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyIDPaysResponse clone() => GetMyIDPaysResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyIDPaysResponse copyWith(void Function(GetMyIDPaysResponse) updates) =>
      super.copyWith((message) => updates(message as GetMyIDPaysResponse))
          as GetMyIDPaysResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMyIDPaysResponse create() => GetMyIDPaysResponse._();
  @$core.override
  GetMyIDPaysResponse createEmptyInstance() => create();
  static $pb.PbList<GetMyIDPaysResponse> createRepeated() =>
      $pb.PbList<GetMyIDPaysResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMyIDPaysResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetMyIDPaysResponse>(create);
  static GetMyIDPaysResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<IDPay> get idPays => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);
}

class GetIDPayTransactionsRequest extends $pb.GeneratedMessage {
  factory GetIDPayTransactionsRequest({
    $core.String? payId,
    $core.int? limit,
    $core.int? offset,
  }) {
    final result = create();
    if (payId != null) result.payId = payId;
    if (limit != null) result.limit = limit;
    if (offset != null) result.offset = offset;
    return result;
  }

  GetIDPayTransactionsRequest._();

  factory GetIDPayTransactionsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetIDPayTransactionsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetIDPayTransactionsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'id_pay'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'payId')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetIDPayTransactionsRequest clone() =>
      GetIDPayTransactionsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetIDPayTransactionsRequest copyWith(
          void Function(GetIDPayTransactionsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetIDPayTransactionsRequest))
          as GetIDPayTransactionsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetIDPayTransactionsRequest create() =>
      GetIDPayTransactionsRequest._();
  @$core.override
  GetIDPayTransactionsRequest createEmptyInstance() => create();
  static $pb.PbList<GetIDPayTransactionsRequest> createRepeated() =>
      $pb.PbList<GetIDPayTransactionsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetIDPayTransactionsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetIDPayTransactionsRequest>(create);
  static GetIDPayTransactionsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get payId => $_getSZ(0);
  @$pb.TagNumber(1)
  set payId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPayId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayId() => $_clearField(1);

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

class GetIDPayTransactionsResponse extends $pb.GeneratedMessage {
  factory GetIDPayTransactionsResponse({
    $core.Iterable<IDPayTransaction>? transactions,
    $core.int? total,
  }) {
    final result = create();
    if (transactions != null) result.transactions.addAll(transactions);
    if (total != null) result.total = total;
    return result;
  }

  GetIDPayTransactionsResponse._();

  factory GetIDPayTransactionsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetIDPayTransactionsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetIDPayTransactionsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'id_pay'),
      createEmptyInstance: create)
    ..pc<IDPayTransaction>(
        1, _omitFieldNames ? '' : 'transactions', $pb.PbFieldType.PM,
        subBuilder: IDPayTransaction.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetIDPayTransactionsResponse clone() =>
      GetIDPayTransactionsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetIDPayTransactionsResponse copyWith(
          void Function(GetIDPayTransactionsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetIDPayTransactionsResponse))
          as GetIDPayTransactionsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetIDPayTransactionsResponse create() =>
      GetIDPayTransactionsResponse._();
  @$core.override
  GetIDPayTransactionsResponse createEmptyInstance() => create();
  static $pb.PbList<GetIDPayTransactionsResponse> createRepeated() =>
      $pb.PbList<GetIDPayTransactionsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetIDPayTransactionsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetIDPayTransactionsResponse>(create);
  static GetIDPayTransactionsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<IDPayTransaction> get transactions => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);
}

class CancelIDPayRequest extends $pb.GeneratedMessage {
  factory CancelIDPayRequest({
    $core.String? id,
  }) {
    final result = create();
    if (id != null) result.id = id;
    return result;
  }

  CancelIDPayRequest._();

  factory CancelIDPayRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CancelIDPayRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CancelIDPayRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'id_pay'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CancelIDPayRequest clone() => CancelIDPayRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CancelIDPayRequest copyWith(void Function(CancelIDPayRequest) updates) =>
      super.copyWith((message) => updates(message as CancelIDPayRequest))
          as CancelIDPayRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CancelIDPayRequest create() => CancelIDPayRequest._();
  @$core.override
  CancelIDPayRequest createEmptyInstance() => create();
  static $pb.PbList<CancelIDPayRequest> createRepeated() =>
      $pb.PbList<CancelIDPayRequest>();
  @$core.pragma('dart2js:noInline')
  static CancelIDPayRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CancelIDPayRequest>(create);
  static CancelIDPayRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);
}

class CancelIDPayResponse extends $pb.GeneratedMessage {
  factory CancelIDPayResponse({
    $core.String? message,
  }) {
    final result = create();
    if (message != null) result.message = message;
    return result;
  }

  CancelIDPayResponse._();

  factory CancelIDPayResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CancelIDPayResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CancelIDPayResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'id_pay'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CancelIDPayResponse clone() => CancelIDPayResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CancelIDPayResponse copyWith(void Function(CancelIDPayResponse) updates) =>
      super.copyWith((message) => updates(message as CancelIDPayResponse))
          as CancelIDPayResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CancelIDPayResponse create() => CancelIDPayResponse._();
  @$core.override
  CancelIDPayResponse createEmptyInstance() => create();
  static $pb.PbList<CancelIDPayResponse> createRepeated() =>
      $pb.PbList<CancelIDPayResponse>();
  @$core.pragma('dart2js:noInline')
  static CancelIDPayResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CancelIDPayResponse>(create);
  static CancelIDPayResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get message => $_getSZ(0);
  @$pb.TagNumber(1)
  set message($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMessage() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessage() => $_clearField(1);
}

class GetIDPayDetailsRequest extends $pb.GeneratedMessage {
  factory GetIDPayDetailsRequest({
    $core.String? id,
  }) {
    final result = create();
    if (id != null) result.id = id;
    return result;
  }

  GetIDPayDetailsRequest._();

  factory GetIDPayDetailsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetIDPayDetailsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetIDPayDetailsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'id_pay'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetIDPayDetailsRequest clone() =>
      GetIDPayDetailsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetIDPayDetailsRequest copyWith(
          void Function(GetIDPayDetailsRequest) updates) =>
      super.copyWith((message) => updates(message as GetIDPayDetailsRequest))
          as GetIDPayDetailsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetIDPayDetailsRequest create() => GetIDPayDetailsRequest._();
  @$core.override
  GetIDPayDetailsRequest createEmptyInstance() => create();
  static $pb.PbList<GetIDPayDetailsRequest> createRepeated() =>
      $pb.PbList<GetIDPayDetailsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetIDPayDetailsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetIDPayDetailsRequest>(create);
  static GetIDPayDetailsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);
}

class GetIDPayDetailsResponse extends $pb.GeneratedMessage {
  factory GetIDPayDetailsResponse({
    IDPay? idPay,
  }) {
    final result = create();
    if (idPay != null) result.idPay = idPay;
    return result;
  }

  GetIDPayDetailsResponse._();

  factory GetIDPayDetailsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetIDPayDetailsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetIDPayDetailsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'id_pay'),
      createEmptyInstance: create)
    ..aOM<IDPay>(1, _omitFieldNames ? '' : 'idPay', subBuilder: IDPay.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetIDPayDetailsResponse clone() =>
      GetIDPayDetailsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetIDPayDetailsResponse copyWith(
          void Function(GetIDPayDetailsResponse) updates) =>
      super.copyWith((message) => updates(message as GetIDPayDetailsResponse))
          as GetIDPayDetailsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetIDPayDetailsResponse create() => GetIDPayDetailsResponse._();
  @$core.override
  GetIDPayDetailsResponse createEmptyInstance() => create();
  static $pb.PbList<GetIDPayDetailsResponse> createRepeated() =>
      $pb.PbList<GetIDPayDetailsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetIDPayDetailsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetIDPayDetailsResponse>(create);
  static GetIDPayDetailsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  IDPay get idPay => $_getN(0);
  @$pb.TagNumber(1)
  set idPay(IDPay value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasIdPay() => $_has(0);
  @$pb.TagNumber(1)
  void clearIdPay() => $_clearField(1);
  @$pb.TagNumber(1)
  IDPay ensureIdPay() => $_ensure(0);
}

/// Organization request/response messages
class CreateOrganizationRequest extends $pb.GeneratedMessage {
  factory CreateOrganizationRequest({
    $core.String? name,
    $core.String? description,
    $core.String? logoUrl,
    $core.String? accountId,
  }) {
    final result = create();
    if (name != null) result.name = name;
    if (description != null) result.description = description;
    if (logoUrl != null) result.logoUrl = logoUrl;
    if (accountId != null) result.accountId = accountId;
    return result;
  }

  CreateOrganizationRequest._();

  factory CreateOrganizationRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateOrganizationRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateOrganizationRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'id_pay'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOS(2, _omitFieldNames ? '' : 'description')
    ..aOS(3, _omitFieldNames ? '' : 'logoUrl')
    ..aOS(4, _omitFieldNames ? '' : 'accountId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateOrganizationRequest clone() =>
      CreateOrganizationRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateOrganizationRequest copyWith(
          void Function(CreateOrganizationRequest) updates) =>
      super.copyWith((message) => updates(message as CreateOrganizationRequest))
          as CreateOrganizationRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateOrganizationRequest create() => CreateOrganizationRequest._();
  @$core.override
  CreateOrganizationRequest createEmptyInstance() => create();
  static $pb.PbList<CreateOrganizationRequest> createRepeated() =>
      $pb.PbList<CreateOrganizationRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateOrganizationRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateOrganizationRequest>(create);
  static CreateOrganizationRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get description => $_getSZ(1);
  @$pb.TagNumber(2)
  set description($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDescription() => $_has(1);
  @$pb.TagNumber(2)
  void clearDescription() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get logoUrl => $_getSZ(2);
  @$pb.TagNumber(3)
  set logoUrl($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasLogoUrl() => $_has(2);
  @$pb.TagNumber(3)
  void clearLogoUrl() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get accountId => $_getSZ(3);
  @$pb.TagNumber(4)
  set accountId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAccountId() => $_has(3);
  @$pb.TagNumber(4)
  void clearAccountId() => $_clearField(4);
}

class CreateOrganizationResponse extends $pb.GeneratedMessage {
  factory CreateOrganizationResponse({
    IDPayOrganization? organization,
    $core.String? message,
  }) {
    final result = create();
    if (organization != null) result.organization = organization;
    if (message != null) result.message = message;
    return result;
  }

  CreateOrganizationResponse._();

  factory CreateOrganizationResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateOrganizationResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateOrganizationResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'id_pay'),
      createEmptyInstance: create)
    ..aOM<IDPayOrganization>(1, _omitFieldNames ? '' : 'organization',
        subBuilder: IDPayOrganization.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateOrganizationResponse clone() =>
      CreateOrganizationResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateOrganizationResponse copyWith(
          void Function(CreateOrganizationResponse) updates) =>
      super.copyWith(
              (message) => updates(message as CreateOrganizationResponse))
          as CreateOrganizationResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateOrganizationResponse create() => CreateOrganizationResponse._();
  @$core.override
  CreateOrganizationResponse createEmptyInstance() => create();
  static $pb.PbList<CreateOrganizationResponse> createRepeated() =>
      $pb.PbList<CreateOrganizationResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateOrganizationResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateOrganizationResponse>(create);
  static CreateOrganizationResponse? _defaultInstance;

  @$pb.TagNumber(1)
  IDPayOrganization get organization => $_getN(0);
  @$pb.TagNumber(1)
  set organization(IDPayOrganization value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasOrganization() => $_has(0);
  @$pb.TagNumber(1)
  void clearOrganization() => $_clearField(1);
  @$pb.TagNumber(1)
  IDPayOrganization ensureOrganization() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);
}

class GetMyOrganizationsRequest extends $pb.GeneratedMessage {
  factory GetMyOrganizationsRequest({
    $core.String? accountId,
    $core.int? limit,
    $core.int? offset,
  }) {
    final result = create();
    if (accountId != null) result.accountId = accountId;
    if (limit != null) result.limit = limit;
    if (offset != null) result.offset = offset;
    return result;
  }

  GetMyOrganizationsRequest._();

  factory GetMyOrganizationsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMyOrganizationsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMyOrganizationsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'id_pay'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountId')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyOrganizationsRequest clone() =>
      GetMyOrganizationsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyOrganizationsRequest copyWith(
          void Function(GetMyOrganizationsRequest) updates) =>
      super.copyWith((message) => updates(message as GetMyOrganizationsRequest))
          as GetMyOrganizationsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMyOrganizationsRequest create() => GetMyOrganizationsRequest._();
  @$core.override
  GetMyOrganizationsRequest createEmptyInstance() => create();
  static $pb.PbList<GetMyOrganizationsRequest> createRepeated() =>
      $pb.PbList<GetMyOrganizationsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMyOrganizationsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetMyOrganizationsRequest>(create);
  static GetMyOrganizationsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => $_clearField(1);

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

class GetMyOrganizationsResponse extends $pb.GeneratedMessage {
  factory GetMyOrganizationsResponse({
    $core.Iterable<IDPayOrganization>? organizations,
    $core.int? total,
  }) {
    final result = create();
    if (organizations != null) result.organizations.addAll(organizations);
    if (total != null) result.total = total;
    return result;
  }

  GetMyOrganizationsResponse._();

  factory GetMyOrganizationsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMyOrganizationsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMyOrganizationsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'id_pay'),
      createEmptyInstance: create)
    ..pc<IDPayOrganization>(
        1, _omitFieldNames ? '' : 'organizations', $pb.PbFieldType.PM,
        subBuilder: IDPayOrganization.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyOrganizationsResponse clone() =>
      GetMyOrganizationsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyOrganizationsResponse copyWith(
          void Function(GetMyOrganizationsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetMyOrganizationsResponse))
          as GetMyOrganizationsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMyOrganizationsResponse create() => GetMyOrganizationsResponse._();
  @$core.override
  GetMyOrganizationsResponse createEmptyInstance() => create();
  static $pb.PbList<GetMyOrganizationsResponse> createRepeated() =>
      $pb.PbList<GetMyOrganizationsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMyOrganizationsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetMyOrganizationsResponse>(create);
  static GetMyOrganizationsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<IDPayOrganization> get organizations => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);
}

class UpdateOrganizationRequest extends $pb.GeneratedMessage {
  factory UpdateOrganizationRequest({
    $core.String? id,
    $core.String? name,
    $core.String? description,
    $core.String? logoUrl,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (description != null) result.description = description;
    if (logoUrl != null) result.logoUrl = logoUrl;
    return result;
  }

  UpdateOrganizationRequest._();

  factory UpdateOrganizationRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateOrganizationRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateOrganizationRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'id_pay'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..aOS(4, _omitFieldNames ? '' : 'logoUrl')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateOrganizationRequest clone() =>
      UpdateOrganizationRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateOrganizationRequest copyWith(
          void Function(UpdateOrganizationRequest) updates) =>
      super.copyWith((message) => updates(message as UpdateOrganizationRequest))
          as UpdateOrganizationRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateOrganizationRequest create() => UpdateOrganizationRequest._();
  @$core.override
  UpdateOrganizationRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateOrganizationRequest> createRepeated() =>
      $pb.PbList<UpdateOrganizationRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateOrganizationRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateOrganizationRequest>(create);
  static UpdateOrganizationRequest? _defaultInstance;

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
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get logoUrl => $_getSZ(3);
  @$pb.TagNumber(4)
  set logoUrl($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasLogoUrl() => $_has(3);
  @$pb.TagNumber(4)
  void clearLogoUrl() => $_clearField(4);
}

class UpdateOrganizationResponse extends $pb.GeneratedMessage {
  factory UpdateOrganizationResponse({
    IDPayOrganization? organization,
  }) {
    final result = create();
    if (organization != null) result.organization = organization;
    return result;
  }

  UpdateOrganizationResponse._();

  factory UpdateOrganizationResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateOrganizationResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateOrganizationResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'id_pay'),
      createEmptyInstance: create)
    ..aOM<IDPayOrganization>(1, _omitFieldNames ? '' : 'organization',
        subBuilder: IDPayOrganization.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateOrganizationResponse clone() =>
      UpdateOrganizationResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateOrganizationResponse copyWith(
          void Function(UpdateOrganizationResponse) updates) =>
      super.copyWith(
              (message) => updates(message as UpdateOrganizationResponse))
          as UpdateOrganizationResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateOrganizationResponse create() => UpdateOrganizationResponse._();
  @$core.override
  UpdateOrganizationResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateOrganizationResponse> createRepeated() =>
      $pb.PbList<UpdateOrganizationResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateOrganizationResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateOrganizationResponse>(create);
  static UpdateOrganizationResponse? _defaultInstance;

  @$pb.TagNumber(1)
  IDPayOrganization get organization => $_getN(0);
  @$pb.TagNumber(1)
  set organization(IDPayOrganization value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasOrganization() => $_has(0);
  @$pb.TagNumber(1)
  void clearOrganization() => $_clearField(1);
  @$pb.TagNumber(1)
  IDPayOrganization ensureOrganization() => $_ensure(0);
}

class DeleteOrganizationRequest extends $pb.GeneratedMessage {
  factory DeleteOrganizationRequest({
    $core.String? id,
  }) {
    final result = create();
    if (id != null) result.id = id;
    return result;
  }

  DeleteOrganizationRequest._();

  factory DeleteOrganizationRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeleteOrganizationRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteOrganizationRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'id_pay'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteOrganizationRequest clone() =>
      DeleteOrganizationRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteOrganizationRequest copyWith(
          void Function(DeleteOrganizationRequest) updates) =>
      super.copyWith((message) => updates(message as DeleteOrganizationRequest))
          as DeleteOrganizationRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteOrganizationRequest create() => DeleteOrganizationRequest._();
  @$core.override
  DeleteOrganizationRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteOrganizationRequest> createRepeated() =>
      $pb.PbList<DeleteOrganizationRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteOrganizationRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteOrganizationRequest>(create);
  static DeleteOrganizationRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);
}

class DeleteOrganizationResponse extends $pb.GeneratedMessage {
  factory DeleteOrganizationResponse({
    $core.String? message,
  }) {
    final result = create();
    if (message != null) result.message = message;
    return result;
  }

  DeleteOrganizationResponse._();

  factory DeleteOrganizationResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeleteOrganizationResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteOrganizationResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'id_pay'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteOrganizationResponse clone() =>
      DeleteOrganizationResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteOrganizationResponse copyWith(
          void Function(DeleteOrganizationResponse) updates) =>
      super.copyWith(
              (message) => updates(message as DeleteOrganizationResponse))
          as DeleteOrganizationResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteOrganizationResponse create() => DeleteOrganizationResponse._();
  @$core.override
  DeleteOrganizationResponse createEmptyInstance() => create();
  static $pb.PbList<DeleteOrganizationResponse> createRepeated() =>
      $pb.PbList<DeleteOrganizationResponse>();
  @$core.pragma('dart2js:noInline')
  static DeleteOrganizationResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteOrganizationResponse>(create);
  static DeleteOrganizationResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get message => $_getSZ(0);
  @$pb.TagNumber(1)
  set message($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMessage() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessage() => $_clearField(1);
}

class GetOrganizationDetailsRequest extends $pb.GeneratedMessage {
  factory GetOrganizationDetailsRequest({
    $core.String? id,
  }) {
    final result = create();
    if (id != null) result.id = id;
    return result;
  }

  GetOrganizationDetailsRequest._();

  factory GetOrganizationDetailsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetOrganizationDetailsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetOrganizationDetailsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'id_pay'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetOrganizationDetailsRequest clone() =>
      GetOrganizationDetailsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetOrganizationDetailsRequest copyWith(
          void Function(GetOrganizationDetailsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetOrganizationDetailsRequest))
          as GetOrganizationDetailsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetOrganizationDetailsRequest create() =>
      GetOrganizationDetailsRequest._();
  @$core.override
  GetOrganizationDetailsRequest createEmptyInstance() => create();
  static $pb.PbList<GetOrganizationDetailsRequest> createRepeated() =>
      $pb.PbList<GetOrganizationDetailsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetOrganizationDetailsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetOrganizationDetailsRequest>(create);
  static GetOrganizationDetailsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);
}

class GetOrganizationDetailsResponse extends $pb.GeneratedMessage {
  factory GetOrganizationDetailsResponse({
    IDPayOrganization? organization,
    $core.Iterable<IDPay>? idPays,
    $core.double? totalPaidOut,
  }) {
    final result = create();
    if (organization != null) result.organization = organization;
    if (idPays != null) result.idPays.addAll(idPays);
    if (totalPaidOut != null) result.totalPaidOut = totalPaidOut;
    return result;
  }

  GetOrganizationDetailsResponse._();

  factory GetOrganizationDetailsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetOrganizationDetailsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetOrganizationDetailsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'id_pay'),
      createEmptyInstance: create)
    ..aOM<IDPayOrganization>(1, _omitFieldNames ? '' : 'organization',
        subBuilder: IDPayOrganization.create)
    ..pc<IDPay>(2, _omitFieldNames ? '' : 'idPays', $pb.PbFieldType.PM,
        subBuilder: IDPay.create)
    ..a<$core.double>(
        3, _omitFieldNames ? '' : 'totalPaidOut', $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetOrganizationDetailsResponse clone() =>
      GetOrganizationDetailsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetOrganizationDetailsResponse copyWith(
          void Function(GetOrganizationDetailsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetOrganizationDetailsResponse))
          as GetOrganizationDetailsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetOrganizationDetailsResponse create() =>
      GetOrganizationDetailsResponse._();
  @$core.override
  GetOrganizationDetailsResponse createEmptyInstance() => create();
  static $pb.PbList<GetOrganizationDetailsResponse> createRepeated() =>
      $pb.PbList<GetOrganizationDetailsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetOrganizationDetailsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetOrganizationDetailsResponse>(create);
  static GetOrganizationDetailsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  IDPayOrganization get organization => $_getN(0);
  @$pb.TagNumber(1)
  set organization(IDPayOrganization value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasOrganization() => $_has(0);
  @$pb.TagNumber(1)
  void clearOrganization() => $_clearField(1);
  @$pb.TagNumber(1)
  IDPayOrganization ensureOrganization() => $_ensure(0);

  @$pb.TagNumber(2)
  $pb.PbList<IDPay> get idPays => $_getList(1);

  @$pb.TagNumber(3)
  $core.double get totalPaidOut => $_getN(2);
  @$pb.TagNumber(3)
  set totalPaidOut($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTotalPaidOut() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalPaidOut() => $_clearField(3);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
