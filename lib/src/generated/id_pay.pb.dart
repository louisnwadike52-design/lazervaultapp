//
//  Generated code. Do not modify.
//  source: id_pay.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/timestamp.pb.dart' as $1;
import 'id_pay.pbenum.dart';

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
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (payId != null) {
      $result.payId = payId;
    }
    if (creatorId != null) {
      $result.creatorId = creatorId;
    }
    if (creatorName != null) {
      $result.creatorName = creatorName;
    }
    if (creatorUsername != null) {
      $result.creatorUsername = creatorUsername;
    }
    if (type != null) {
      $result.type = type;
    }
    if (amountMode != null) {
      $result.amountMode = amountMode;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (minAmount != null) {
      $result.minAmount = minAmount;
    }
    if (maxAmount != null) {
      $result.maxAmount = maxAmount;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (description != null) {
      $result.description = description;
    }
    if (status != null) {
      $result.status = status;
    }
    if (expiresAt != null) {
      $result.expiresAt = expiresAt;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    if (totalReceived != null) {
      $result.totalReceived = totalReceived;
    }
    if (paymentCount != null) {
      $result.paymentCount = paymentCount;
    }
    return $result;
  }
  IDPay._() : super();
  factory IDPay.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory IDPay.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'IDPay', package: const $pb.PackageName(_omitMessageNames ? '' : 'id_pay'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'payId')
    ..aOS(3, _omitFieldNames ? '' : 'creatorId')
    ..aOS(4, _omitFieldNames ? '' : 'creatorName')
    ..aOS(5, _omitFieldNames ? '' : 'creatorUsername')
    ..e<IDPayType>(6, _omitFieldNames ? '' : 'type', $pb.PbFieldType.OE, defaultOrMaker: IDPayType.ID_PAY_TYPE_UNSPECIFIED, valueOf: IDPayType.valueOf, enumValues: IDPayType.values)
    ..e<IDPayAmountMode>(7, _omitFieldNames ? '' : 'amountMode', $pb.PbFieldType.OE, defaultOrMaker: IDPayAmountMode.ID_PAY_AMOUNT_UNSPECIFIED, valueOf: IDPayAmountMode.valueOf, enumValues: IDPayAmountMode.values)
    ..a<$core.double>(8, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..a<$core.double>(9, _omitFieldNames ? '' : 'minAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(10, _omitFieldNames ? '' : 'maxAmount', $pb.PbFieldType.OD)
    ..aOS(11, _omitFieldNames ? '' : 'currency')
    ..aOS(12, _omitFieldNames ? '' : 'description')
    ..e<IDPayStatus>(13, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: IDPayStatus.ID_PAY_STATUS_UNSPECIFIED, valueOf: IDPayStatus.valueOf, enumValues: IDPayStatus.values)
    ..aOM<$1.Timestamp>(14, _omitFieldNames ? '' : 'expiresAt', subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(15, _omitFieldNames ? '' : 'createdAt', subBuilder: $1.Timestamp.create)
    ..a<$core.double>(16, _omitFieldNames ? '' : 'totalReceived', $pb.PbFieldType.OD)
    ..a<$core.int>(17, _omitFieldNames ? '' : 'paymentCount', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  IDPay clone() => IDPay()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  IDPay copyWith(void Function(IDPay) updates) => super.copyWith((message) => updates(message as IDPay)) as IDPay;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static IDPay create() => IDPay._();
  IDPay createEmptyInstance() => create();
  static $pb.PbList<IDPay> createRepeated() => $pb.PbList<IDPay>();
  @$core.pragma('dart2js:noInline')
  static IDPay getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<IDPay>(create);
  static IDPay? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get payId => $_getSZ(1);
  @$pb.TagNumber(2)
  set payId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPayId() => $_has(1);
  @$pb.TagNumber(2)
  void clearPayId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get creatorId => $_getSZ(2);
  @$pb.TagNumber(3)
  set creatorId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCreatorId() => $_has(2);
  @$pb.TagNumber(3)
  void clearCreatorId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get creatorName => $_getSZ(3);
  @$pb.TagNumber(4)
  set creatorName($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCreatorName() => $_has(3);
  @$pb.TagNumber(4)
  void clearCreatorName() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get creatorUsername => $_getSZ(4);
  @$pb.TagNumber(5)
  set creatorUsername($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasCreatorUsername() => $_has(4);
  @$pb.TagNumber(5)
  void clearCreatorUsername() => clearField(5);

  @$pb.TagNumber(6)
  IDPayType get type => $_getN(5);
  @$pb.TagNumber(6)
  set type(IDPayType v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasType() => $_has(5);
  @$pb.TagNumber(6)
  void clearType() => clearField(6);

  @$pb.TagNumber(7)
  IDPayAmountMode get amountMode => $_getN(6);
  @$pb.TagNumber(7)
  set amountMode(IDPayAmountMode v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasAmountMode() => $_has(6);
  @$pb.TagNumber(7)
  void clearAmountMode() => clearField(7);

  @$pb.TagNumber(8)
  $core.double get amount => $_getN(7);
  @$pb.TagNumber(8)
  set amount($core.double v) { $_setDouble(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasAmount() => $_has(7);
  @$pb.TagNumber(8)
  void clearAmount() => clearField(8);

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
  $core.String get currency => $_getSZ(10);
  @$pb.TagNumber(11)
  set currency($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasCurrency() => $_has(10);
  @$pb.TagNumber(11)
  void clearCurrency() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get description => $_getSZ(11);
  @$pb.TagNumber(12)
  set description($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasDescription() => $_has(11);
  @$pb.TagNumber(12)
  void clearDescription() => clearField(12);

  @$pb.TagNumber(13)
  IDPayStatus get status => $_getN(12);
  @$pb.TagNumber(13)
  set status(IDPayStatus v) { setField(13, v); }
  @$pb.TagNumber(13)
  $core.bool hasStatus() => $_has(12);
  @$pb.TagNumber(13)
  void clearStatus() => clearField(13);

  @$pb.TagNumber(14)
  $1.Timestamp get expiresAt => $_getN(13);
  @$pb.TagNumber(14)
  set expiresAt($1.Timestamp v) { setField(14, v); }
  @$pb.TagNumber(14)
  $core.bool hasExpiresAt() => $_has(13);
  @$pb.TagNumber(14)
  void clearExpiresAt() => clearField(14);
  @$pb.TagNumber(14)
  $1.Timestamp ensureExpiresAt() => $_ensure(13);

  @$pb.TagNumber(15)
  $1.Timestamp get createdAt => $_getN(14);
  @$pb.TagNumber(15)
  set createdAt($1.Timestamp v) { setField(15, v); }
  @$pb.TagNumber(15)
  $core.bool hasCreatedAt() => $_has(14);
  @$pb.TagNumber(15)
  void clearCreatedAt() => clearField(15);
  @$pb.TagNumber(15)
  $1.Timestamp ensureCreatedAt() => $_ensure(14);

  @$pb.TagNumber(16)
  $core.double get totalReceived => $_getN(15);
  @$pb.TagNumber(16)
  set totalReceived($core.double v) { $_setDouble(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasTotalReceived() => $_has(15);
  @$pb.TagNumber(16)
  void clearTotalReceived() => clearField(16);

  @$pb.TagNumber(17)
  $core.int get paymentCount => $_getIZ(16);
  @$pb.TagNumber(17)
  set paymentCount($core.int v) { $_setSignedInt32(16, v); }
  @$pb.TagNumber(17)
  $core.bool hasPaymentCount() => $_has(16);
  @$pb.TagNumber(17)
  void clearPaymentCount() => clearField(17);
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
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (payId != null) {
      $result.payId = payId;
    }
    if (payerId != null) {
      $result.payerId = payerId;
    }
    if (payerName != null) {
      $result.payerName = payerName;
    }
    if (payerUsername != null) {
      $result.payerUsername = payerUsername;
    }
    if (recipientId != null) {
      $result.recipientId = recipientId;
    }
    if (recipientName != null) {
      $result.recipientName = recipientName;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (reference != null) {
      $result.reference = reference;
    }
    if (status != null) {
      $result.status = status;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    return $result;
  }
  IDPayTransaction._() : super();
  factory IDPayTransaction.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory IDPayTransaction.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'IDPayTransaction', package: const $pb.PackageName(_omitMessageNames ? '' : 'id_pay'), createEmptyInstance: create)
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
    ..aOM<$1.Timestamp>(12, _omitFieldNames ? '' : 'createdAt', subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  IDPayTransaction clone() => IDPayTransaction()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  IDPayTransaction copyWith(void Function(IDPayTransaction) updates) => super.copyWith((message) => updates(message as IDPayTransaction)) as IDPayTransaction;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static IDPayTransaction create() => IDPayTransaction._();
  IDPayTransaction createEmptyInstance() => create();
  static $pb.PbList<IDPayTransaction> createRepeated() => $pb.PbList<IDPayTransaction>();
  @$core.pragma('dart2js:noInline')
  static IDPayTransaction getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<IDPayTransaction>(create);
  static IDPayTransaction? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get payId => $_getSZ(1);
  @$pb.TagNumber(2)
  set payId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPayId() => $_has(1);
  @$pb.TagNumber(2)
  void clearPayId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get payerId => $_getSZ(2);
  @$pb.TagNumber(3)
  set payerId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPayerId() => $_has(2);
  @$pb.TagNumber(3)
  void clearPayerId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get payerName => $_getSZ(3);
  @$pb.TagNumber(4)
  set payerName($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPayerName() => $_has(3);
  @$pb.TagNumber(4)
  void clearPayerName() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get payerUsername => $_getSZ(4);
  @$pb.TagNumber(5)
  set payerUsername($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasPayerUsername() => $_has(4);
  @$pb.TagNumber(5)
  void clearPayerUsername() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get recipientId => $_getSZ(5);
  @$pb.TagNumber(6)
  set recipientId($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasRecipientId() => $_has(5);
  @$pb.TagNumber(6)
  void clearRecipientId() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get recipientName => $_getSZ(6);
  @$pb.TagNumber(7)
  set recipientName($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasRecipientName() => $_has(6);
  @$pb.TagNumber(7)
  void clearRecipientName() => clearField(7);

  @$pb.TagNumber(8)
  $core.double get amount => $_getN(7);
  @$pb.TagNumber(8)
  set amount($core.double v) { $_setDouble(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasAmount() => $_has(7);
  @$pb.TagNumber(8)
  void clearAmount() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get currency => $_getSZ(8);
  @$pb.TagNumber(9)
  set currency($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasCurrency() => $_has(8);
  @$pb.TagNumber(9)
  void clearCurrency() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get reference => $_getSZ(9);
  @$pb.TagNumber(10)
  set reference($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasReference() => $_has(9);
  @$pb.TagNumber(10)
  void clearReference() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get status => $_getSZ(10);
  @$pb.TagNumber(11)
  set status($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasStatus() => $_has(10);
  @$pb.TagNumber(11)
  void clearStatus() => clearField(11);

  @$pb.TagNumber(12)
  $1.Timestamp get createdAt => $_getN(11);
  @$pb.TagNumber(12)
  set createdAt($1.Timestamp v) { setField(12, v); }
  @$pb.TagNumber(12)
  $core.bool hasCreatedAt() => $_has(11);
  @$pb.TagNumber(12)
  void clearCreatedAt() => clearField(12);
  @$pb.TagNumber(12)
  $1.Timestamp ensureCreatedAt() => $_ensure(11);
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
  }) {
    final $result = create();
    if (type != null) {
      $result.type = type;
    }
    if (amountMode != null) {
      $result.amountMode = amountMode;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (minAmount != null) {
      $result.minAmount = minAmount;
    }
    if (maxAmount != null) {
      $result.maxAmount = maxAmount;
    }
    if (description != null) {
      $result.description = description;
    }
    if (validityMinutes != null) {
      $result.validityMinutes = validityMinutes;
    }
    if (recipientAccountId != null) {
      $result.recipientAccountId = recipientAccountId;
    }
    return $result;
  }
  CreateIDPayRequest._() : super();
  factory CreateIDPayRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateIDPayRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateIDPayRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'id_pay'), createEmptyInstance: create)
    ..e<IDPayType>(1, _omitFieldNames ? '' : 'type', $pb.PbFieldType.OE, defaultOrMaker: IDPayType.ID_PAY_TYPE_UNSPECIFIED, valueOf: IDPayType.valueOf, enumValues: IDPayType.values)
    ..e<IDPayAmountMode>(2, _omitFieldNames ? '' : 'amountMode', $pb.PbFieldType.OE, defaultOrMaker: IDPayAmountMode.ID_PAY_AMOUNT_UNSPECIFIED, valueOf: IDPayAmountMode.valueOf, enumValues: IDPayAmountMode.values)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(4, _omitFieldNames ? '' : 'currency')
    ..a<$core.double>(5, _omitFieldNames ? '' : 'minAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(6, _omitFieldNames ? '' : 'maxAmount', $pb.PbFieldType.OD)
    ..aOS(7, _omitFieldNames ? '' : 'description')
    ..a<$core.int>(8, _omitFieldNames ? '' : 'validityMinutes', $pb.PbFieldType.O3)
    ..aOS(9, _omitFieldNames ? '' : 'recipientAccountId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateIDPayRequest clone() => CreateIDPayRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateIDPayRequest copyWith(void Function(CreateIDPayRequest) updates) => super.copyWith((message) => updates(message as CreateIDPayRequest)) as CreateIDPayRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateIDPayRequest create() => CreateIDPayRequest._();
  CreateIDPayRequest createEmptyInstance() => create();
  static $pb.PbList<CreateIDPayRequest> createRepeated() => $pb.PbList<CreateIDPayRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateIDPayRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateIDPayRequest>(create);
  static CreateIDPayRequest? _defaultInstance;

  @$pb.TagNumber(1)
  IDPayType get type => $_getN(0);
  @$pb.TagNumber(1)
  set type(IDPayType v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => clearField(1);

  @$pb.TagNumber(2)
  IDPayAmountMode get amountMode => $_getN(1);
  @$pb.TagNumber(2)
  set amountMode(IDPayAmountMode v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasAmountMode() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmountMode() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get amount => $_getN(2);
  @$pb.TagNumber(3)
  set amount($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get currency => $_getSZ(3);
  @$pb.TagNumber(4)
  set currency($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCurrency() => $_has(3);
  @$pb.TagNumber(4)
  void clearCurrency() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get minAmount => $_getN(4);
  @$pb.TagNumber(5)
  set minAmount($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasMinAmount() => $_has(4);
  @$pb.TagNumber(5)
  void clearMinAmount() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get maxAmount => $_getN(5);
  @$pb.TagNumber(6)
  set maxAmount($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasMaxAmount() => $_has(5);
  @$pb.TagNumber(6)
  void clearMaxAmount() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get description => $_getSZ(6);
  @$pb.TagNumber(7)
  set description($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasDescription() => $_has(6);
  @$pb.TagNumber(7)
  void clearDescription() => clearField(7);

  @$pb.TagNumber(8)
  $core.int get validityMinutes => $_getIZ(7);
  @$pb.TagNumber(8)
  set validityMinutes($core.int v) { $_setSignedInt32(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasValidityMinutes() => $_has(7);
  @$pb.TagNumber(8)
  void clearValidityMinutes() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get recipientAccountId => $_getSZ(8);
  @$pb.TagNumber(9)
  set recipientAccountId($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasRecipientAccountId() => $_has(8);
  @$pb.TagNumber(9)
  void clearRecipientAccountId() => clearField(9);
}

class CreateIDPayResponse extends $pb.GeneratedMessage {
  factory CreateIDPayResponse({
    IDPay? idPay,
    $core.String? message,
  }) {
    final $result = create();
    if (idPay != null) {
      $result.idPay = idPay;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  CreateIDPayResponse._() : super();
  factory CreateIDPayResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateIDPayResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateIDPayResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'id_pay'), createEmptyInstance: create)
    ..aOM<IDPay>(1, _omitFieldNames ? '' : 'idPay', subBuilder: IDPay.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateIDPayResponse clone() => CreateIDPayResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateIDPayResponse copyWith(void Function(CreateIDPayResponse) updates) => super.copyWith((message) => updates(message as CreateIDPayResponse)) as CreateIDPayResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateIDPayResponse create() => CreateIDPayResponse._();
  CreateIDPayResponse createEmptyInstance() => create();
  static $pb.PbList<CreateIDPayResponse> createRepeated() => $pb.PbList<CreateIDPayResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateIDPayResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateIDPayResponse>(create);
  static CreateIDPayResponse? _defaultInstance;

  @$pb.TagNumber(1)
  IDPay get idPay => $_getN(0);
  @$pb.TagNumber(1)
  set idPay(IDPay v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasIdPay() => $_has(0);
  @$pb.TagNumber(1)
  void clearIdPay() => clearField(1);
  @$pb.TagNumber(1)
  IDPay ensureIdPay() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

class LookupIDPayRequest extends $pb.GeneratedMessage {
  factory LookupIDPayRequest({
    $core.String? payId,
  }) {
    final $result = create();
    if (payId != null) {
      $result.payId = payId;
    }
    return $result;
  }
  LookupIDPayRequest._() : super();
  factory LookupIDPayRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LookupIDPayRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'LookupIDPayRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'id_pay'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'payId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LookupIDPayRequest clone() => LookupIDPayRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LookupIDPayRequest copyWith(void Function(LookupIDPayRequest) updates) => super.copyWith((message) => updates(message as LookupIDPayRequest)) as LookupIDPayRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LookupIDPayRequest create() => LookupIDPayRequest._();
  LookupIDPayRequest createEmptyInstance() => create();
  static $pb.PbList<LookupIDPayRequest> createRepeated() => $pb.PbList<LookupIDPayRequest>();
  @$core.pragma('dart2js:noInline')
  static LookupIDPayRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LookupIDPayRequest>(create);
  static LookupIDPayRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get payId => $_getSZ(0);
  @$pb.TagNumber(1)
  set payId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPayId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayId() => clearField(1);
}

class LookupIDPayResponse extends $pb.GeneratedMessage {
  factory LookupIDPayResponse({
    IDPay? idPay,
  }) {
    final $result = create();
    if (idPay != null) {
      $result.idPay = idPay;
    }
    return $result;
  }
  LookupIDPayResponse._() : super();
  factory LookupIDPayResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LookupIDPayResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'LookupIDPayResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'id_pay'), createEmptyInstance: create)
    ..aOM<IDPay>(1, _omitFieldNames ? '' : 'idPay', subBuilder: IDPay.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LookupIDPayResponse clone() => LookupIDPayResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LookupIDPayResponse copyWith(void Function(LookupIDPayResponse) updates) => super.copyWith((message) => updates(message as LookupIDPayResponse)) as LookupIDPayResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LookupIDPayResponse create() => LookupIDPayResponse._();
  LookupIDPayResponse createEmptyInstance() => create();
  static $pb.PbList<LookupIDPayResponse> createRepeated() => $pb.PbList<LookupIDPayResponse>();
  @$core.pragma('dart2js:noInline')
  static LookupIDPayResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LookupIDPayResponse>(create);
  static LookupIDPayResponse? _defaultInstance;

  @$pb.TagNumber(1)
  IDPay get idPay => $_getN(0);
  @$pb.TagNumber(1)
  set idPay(IDPay v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasIdPay() => $_has(0);
  @$pb.TagNumber(1)
  void clearIdPay() => clearField(1);
  @$pb.TagNumber(1)
  IDPay ensureIdPay() => $_ensure(0);
}

class PayIDPayRequest extends $pb.GeneratedMessage {
  factory PayIDPayRequest({
    $core.String? payId,
    $core.double? amount,
    $core.String? transactionPin,
    $core.String? sourceAccountId,
    $core.String? idempotencyKey,
  }) {
    final $result = create();
    if (payId != null) {
      $result.payId = payId;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (transactionPin != null) {
      $result.transactionPin = transactionPin;
    }
    if (sourceAccountId != null) {
      $result.sourceAccountId = sourceAccountId;
    }
    if (idempotencyKey != null) {
      $result.idempotencyKey = idempotencyKey;
    }
    return $result;
  }
  PayIDPayRequest._() : super();
  factory PayIDPayRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PayIDPayRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PayIDPayRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'id_pay'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'payId')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(3, _omitFieldNames ? '' : 'transactionPin')
    ..aOS(4, _omitFieldNames ? '' : 'sourceAccountId')
    ..aOS(5, _omitFieldNames ? '' : 'idempotencyKey')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PayIDPayRequest clone() => PayIDPayRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PayIDPayRequest copyWith(void Function(PayIDPayRequest) updates) => super.copyWith((message) => updates(message as PayIDPayRequest)) as PayIDPayRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PayIDPayRequest create() => PayIDPayRequest._();
  PayIDPayRequest createEmptyInstance() => create();
  static $pb.PbList<PayIDPayRequest> createRepeated() => $pb.PbList<PayIDPayRequest>();
  @$core.pragma('dart2js:noInline')
  static PayIDPayRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PayIDPayRequest>(create);
  static PayIDPayRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get payId => $_getSZ(0);
  @$pb.TagNumber(1)
  set payId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPayId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayId() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get amount => $_getN(1);
  @$pb.TagNumber(2)
  set amount($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get transactionPin => $_getSZ(2);
  @$pb.TagNumber(3)
  set transactionPin($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTransactionPin() => $_has(2);
  @$pb.TagNumber(3)
  void clearTransactionPin() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get sourceAccountId => $_getSZ(3);
  @$pb.TagNumber(4)
  set sourceAccountId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasSourceAccountId() => $_has(3);
  @$pb.TagNumber(4)
  void clearSourceAccountId() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get idempotencyKey => $_getSZ(4);
  @$pb.TagNumber(5)
  set idempotencyKey($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasIdempotencyKey() => $_has(4);
  @$pb.TagNumber(5)
  void clearIdempotencyKey() => clearField(5);
}

class PayIDPayResponse extends $pb.GeneratedMessage {
  factory PayIDPayResponse({
    IDPayTransaction? transaction,
    $core.double? newBalance,
    $core.String? message,
  }) {
    final $result = create();
    if (transaction != null) {
      $result.transaction = transaction;
    }
    if (newBalance != null) {
      $result.newBalance = newBalance;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  PayIDPayResponse._() : super();
  factory PayIDPayResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PayIDPayResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PayIDPayResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'id_pay'), createEmptyInstance: create)
    ..aOM<IDPayTransaction>(1, _omitFieldNames ? '' : 'transaction', subBuilder: IDPayTransaction.create)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'newBalance', $pb.PbFieldType.OD)
    ..aOS(3, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PayIDPayResponse clone() => PayIDPayResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PayIDPayResponse copyWith(void Function(PayIDPayResponse) updates) => super.copyWith((message) => updates(message as PayIDPayResponse)) as PayIDPayResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PayIDPayResponse create() => PayIDPayResponse._();
  PayIDPayResponse createEmptyInstance() => create();
  static $pb.PbList<PayIDPayResponse> createRepeated() => $pb.PbList<PayIDPayResponse>();
  @$core.pragma('dart2js:noInline')
  static PayIDPayResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PayIDPayResponse>(create);
  static PayIDPayResponse? _defaultInstance;

  @$pb.TagNumber(1)
  IDPayTransaction get transaction => $_getN(0);
  @$pb.TagNumber(1)
  set transaction(IDPayTransaction v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasTransaction() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransaction() => clearField(1);
  @$pb.TagNumber(1)
  IDPayTransaction ensureTransaction() => $_ensure(0);

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

class GetMyIDPaysRequest extends $pb.GeneratedMessage {
  factory GetMyIDPaysRequest({
    $core.int? limit,
    $core.int? offset,
    IDPayStatus? statusFilter,
  }) {
    final $result = create();
    if (limit != null) {
      $result.limit = limit;
    }
    if (offset != null) {
      $result.offset = offset;
    }
    if (statusFilter != null) {
      $result.statusFilter = statusFilter;
    }
    return $result;
  }
  GetMyIDPaysRequest._() : super();
  factory GetMyIDPaysRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMyIDPaysRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetMyIDPaysRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'id_pay'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'offset', $pb.PbFieldType.O3)
    ..e<IDPayStatus>(3, _omitFieldNames ? '' : 'statusFilter', $pb.PbFieldType.OE, defaultOrMaker: IDPayStatus.ID_PAY_STATUS_UNSPECIFIED, valueOf: IDPayStatus.valueOf, enumValues: IDPayStatus.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMyIDPaysRequest clone() => GetMyIDPaysRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMyIDPaysRequest copyWith(void Function(GetMyIDPaysRequest) updates) => super.copyWith((message) => updates(message as GetMyIDPaysRequest)) as GetMyIDPaysRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMyIDPaysRequest create() => GetMyIDPaysRequest._();
  GetMyIDPaysRequest createEmptyInstance() => create();
  static $pb.PbList<GetMyIDPaysRequest> createRepeated() => $pb.PbList<GetMyIDPaysRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMyIDPaysRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMyIDPaysRequest>(create);
  static GetMyIDPaysRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get limit => $_getIZ(0);
  @$pb.TagNumber(1)
  set limit($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLimit() => $_has(0);
  @$pb.TagNumber(1)
  void clearLimit() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get offset => $_getIZ(1);
  @$pb.TagNumber(2)
  set offset($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasOffset() => $_has(1);
  @$pb.TagNumber(2)
  void clearOffset() => clearField(2);

  @$pb.TagNumber(3)
  IDPayStatus get statusFilter => $_getN(2);
  @$pb.TagNumber(3)
  set statusFilter(IDPayStatus v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasStatusFilter() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatusFilter() => clearField(3);
}

class GetMyIDPaysResponse extends $pb.GeneratedMessage {
  factory GetMyIDPaysResponse({
    $core.Iterable<IDPay>? idPays,
    $core.int? total,
  }) {
    final $result = create();
    if (idPays != null) {
      $result.idPays.addAll(idPays);
    }
    if (total != null) {
      $result.total = total;
    }
    return $result;
  }
  GetMyIDPaysResponse._() : super();
  factory GetMyIDPaysResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMyIDPaysResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetMyIDPaysResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'id_pay'), createEmptyInstance: create)
    ..pc<IDPay>(1, _omitFieldNames ? '' : 'idPays', $pb.PbFieldType.PM, subBuilder: IDPay.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMyIDPaysResponse clone() => GetMyIDPaysResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMyIDPaysResponse copyWith(void Function(GetMyIDPaysResponse) updates) => super.copyWith((message) => updates(message as GetMyIDPaysResponse)) as GetMyIDPaysResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMyIDPaysResponse create() => GetMyIDPaysResponse._();
  GetMyIDPaysResponse createEmptyInstance() => create();
  static $pb.PbList<GetMyIDPaysResponse> createRepeated() => $pb.PbList<GetMyIDPaysResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMyIDPaysResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMyIDPaysResponse>(create);
  static GetMyIDPaysResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<IDPay> get idPays => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => clearField(2);
}

class GetIDPayTransactionsRequest extends $pb.GeneratedMessage {
  factory GetIDPayTransactionsRequest({
    $core.String? payId,
    $core.int? limit,
    $core.int? offset,
  }) {
    final $result = create();
    if (payId != null) {
      $result.payId = payId;
    }
    if (limit != null) {
      $result.limit = limit;
    }
    if (offset != null) {
      $result.offset = offset;
    }
    return $result;
  }
  GetIDPayTransactionsRequest._() : super();
  factory GetIDPayTransactionsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetIDPayTransactionsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetIDPayTransactionsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'id_pay'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'payId')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetIDPayTransactionsRequest clone() => GetIDPayTransactionsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetIDPayTransactionsRequest copyWith(void Function(GetIDPayTransactionsRequest) updates) => super.copyWith((message) => updates(message as GetIDPayTransactionsRequest)) as GetIDPayTransactionsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetIDPayTransactionsRequest create() => GetIDPayTransactionsRequest._();
  GetIDPayTransactionsRequest createEmptyInstance() => create();
  static $pb.PbList<GetIDPayTransactionsRequest> createRepeated() => $pb.PbList<GetIDPayTransactionsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetIDPayTransactionsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetIDPayTransactionsRequest>(create);
  static GetIDPayTransactionsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get payId => $_getSZ(0);
  @$pb.TagNumber(1)
  set payId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPayId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayId() => clearField(1);

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

class GetIDPayTransactionsResponse extends $pb.GeneratedMessage {
  factory GetIDPayTransactionsResponse({
    $core.Iterable<IDPayTransaction>? transactions,
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
  GetIDPayTransactionsResponse._() : super();
  factory GetIDPayTransactionsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetIDPayTransactionsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetIDPayTransactionsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'id_pay'), createEmptyInstance: create)
    ..pc<IDPayTransaction>(1, _omitFieldNames ? '' : 'transactions', $pb.PbFieldType.PM, subBuilder: IDPayTransaction.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetIDPayTransactionsResponse clone() => GetIDPayTransactionsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetIDPayTransactionsResponse copyWith(void Function(GetIDPayTransactionsResponse) updates) => super.copyWith((message) => updates(message as GetIDPayTransactionsResponse)) as GetIDPayTransactionsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetIDPayTransactionsResponse create() => GetIDPayTransactionsResponse._();
  GetIDPayTransactionsResponse createEmptyInstance() => create();
  static $pb.PbList<GetIDPayTransactionsResponse> createRepeated() => $pb.PbList<GetIDPayTransactionsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetIDPayTransactionsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetIDPayTransactionsResponse>(create);
  static GetIDPayTransactionsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<IDPayTransaction> get transactions => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => clearField(2);
}

class CancelIDPayRequest extends $pb.GeneratedMessage {
  factory CancelIDPayRequest({
    $core.String? id,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    return $result;
  }
  CancelIDPayRequest._() : super();
  factory CancelIDPayRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CancelIDPayRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CancelIDPayRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'id_pay'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CancelIDPayRequest clone() => CancelIDPayRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CancelIDPayRequest copyWith(void Function(CancelIDPayRequest) updates) => super.copyWith((message) => updates(message as CancelIDPayRequest)) as CancelIDPayRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CancelIDPayRequest create() => CancelIDPayRequest._();
  CancelIDPayRequest createEmptyInstance() => create();
  static $pb.PbList<CancelIDPayRequest> createRepeated() => $pb.PbList<CancelIDPayRequest>();
  @$core.pragma('dart2js:noInline')
  static CancelIDPayRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CancelIDPayRequest>(create);
  static CancelIDPayRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);
}

class CancelIDPayResponse extends $pb.GeneratedMessage {
  factory CancelIDPayResponse({
    $core.String? message,
  }) {
    final $result = create();
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  CancelIDPayResponse._() : super();
  factory CancelIDPayResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CancelIDPayResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CancelIDPayResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'id_pay'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CancelIDPayResponse clone() => CancelIDPayResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CancelIDPayResponse copyWith(void Function(CancelIDPayResponse) updates) => super.copyWith((message) => updates(message as CancelIDPayResponse)) as CancelIDPayResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CancelIDPayResponse create() => CancelIDPayResponse._();
  CancelIDPayResponse createEmptyInstance() => create();
  static $pb.PbList<CancelIDPayResponse> createRepeated() => $pb.PbList<CancelIDPayResponse>();
  @$core.pragma('dart2js:noInline')
  static CancelIDPayResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CancelIDPayResponse>(create);
  static CancelIDPayResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get message => $_getSZ(0);
  @$pb.TagNumber(1)
  set message($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMessage() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessage() => clearField(1);
}

class GetIDPayDetailsRequest extends $pb.GeneratedMessage {
  factory GetIDPayDetailsRequest({
    $core.String? id,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    return $result;
  }
  GetIDPayDetailsRequest._() : super();
  factory GetIDPayDetailsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetIDPayDetailsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetIDPayDetailsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'id_pay'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetIDPayDetailsRequest clone() => GetIDPayDetailsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetIDPayDetailsRequest copyWith(void Function(GetIDPayDetailsRequest) updates) => super.copyWith((message) => updates(message as GetIDPayDetailsRequest)) as GetIDPayDetailsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetIDPayDetailsRequest create() => GetIDPayDetailsRequest._();
  GetIDPayDetailsRequest createEmptyInstance() => create();
  static $pb.PbList<GetIDPayDetailsRequest> createRepeated() => $pb.PbList<GetIDPayDetailsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetIDPayDetailsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetIDPayDetailsRequest>(create);
  static GetIDPayDetailsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);
}

class GetIDPayDetailsResponse extends $pb.GeneratedMessage {
  factory GetIDPayDetailsResponse({
    IDPay? idPay,
  }) {
    final $result = create();
    if (idPay != null) {
      $result.idPay = idPay;
    }
    return $result;
  }
  GetIDPayDetailsResponse._() : super();
  factory GetIDPayDetailsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetIDPayDetailsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetIDPayDetailsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'id_pay'), createEmptyInstance: create)
    ..aOM<IDPay>(1, _omitFieldNames ? '' : 'idPay', subBuilder: IDPay.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetIDPayDetailsResponse clone() => GetIDPayDetailsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetIDPayDetailsResponse copyWith(void Function(GetIDPayDetailsResponse) updates) => super.copyWith((message) => updates(message as GetIDPayDetailsResponse)) as GetIDPayDetailsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetIDPayDetailsResponse create() => GetIDPayDetailsResponse._();
  GetIDPayDetailsResponse createEmptyInstance() => create();
  static $pb.PbList<GetIDPayDetailsResponse> createRepeated() => $pb.PbList<GetIDPayDetailsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetIDPayDetailsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetIDPayDetailsResponse>(create);
  static GetIDPayDetailsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  IDPay get idPay => $_getN(0);
  @$pb.TagNumber(1)
  set idPay(IDPay v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasIdPay() => $_has(0);
  @$pb.TagNumber(1)
  void clearIdPay() => clearField(1);
  @$pb.TagNumber(1)
  IDPay ensureIdPay() => $_ensure(0);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
