///
//  Generated code. Do not modify.
//  source: id_pay.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/timestamp.pb.dart' as $1;

import 'id_pay.pbenum.dart';

export 'id_pay.pbenum.dart';

class IDPay extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'IDPay', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'id_pay'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'creatorId')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'creatorName')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'creatorUsername')
    ..e<IDPayType>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type', $pb.PbFieldType.OE, defaultOrMaker: IDPayType.ID_PAY_TYPE_UNSPECIFIED, valueOf: IDPayType.valueOf, enumValues: IDPayType.values)
    ..e<IDPayAmountMode>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amountMode', $pb.PbFieldType.OE, defaultOrMaker: IDPayAmountMode.ID_PAY_AMOUNT_UNSPECIFIED, valueOf: IDPayAmountMode.valueOf, enumValues: IDPayAmountMode.values)
    ..a<$core.double>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..a<$core.double>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'minAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'maxAmount', $pb.PbFieldType.OD)
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOS(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..e<IDPayStatus>(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: IDPayStatus.ID_PAY_STATUS_UNSPECIFIED, valueOf: IDPayStatus.valueOf, enumValues: IDPayStatus.values)
    ..aOM<$1.Timestamp>(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'expiresAt', subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $1.Timestamp.create)
    ..a<$core.double>(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalReceived', $pb.PbFieldType.OD)
    ..a<$core.int>(17, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'paymentCount', $pb.PbFieldType.O3)
    ..aOB(18, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'neverExpires')
    ..aOS(19, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'organizationId')
    ..aOS(20, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'organizationName')
    ..hasRequiredFields = false
  ;

  IDPay._() : super();
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
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (payId != null) {
      _result.payId = payId;
    }
    if (creatorId != null) {
      _result.creatorId = creatorId;
    }
    if (creatorName != null) {
      _result.creatorName = creatorName;
    }
    if (creatorUsername != null) {
      _result.creatorUsername = creatorUsername;
    }
    if (type != null) {
      _result.type = type;
    }
    if (amountMode != null) {
      _result.amountMode = amountMode;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (minAmount != null) {
      _result.minAmount = minAmount;
    }
    if (maxAmount != null) {
      _result.maxAmount = maxAmount;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (description != null) {
      _result.description = description;
    }
    if (status != null) {
      _result.status = status;
    }
    if (expiresAt != null) {
      _result.expiresAt = expiresAt;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (totalReceived != null) {
      _result.totalReceived = totalReceived;
    }
    if (paymentCount != null) {
      _result.paymentCount = paymentCount;
    }
    if (neverExpires != null) {
      _result.neverExpires = neverExpires;
    }
    if (organizationId != null) {
      _result.organizationId = organizationId;
    }
    if (organizationName != null) {
      _result.organizationName = organizationName;
    }
    return _result;
  }
  factory IDPay.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory IDPay.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  IDPay clone() => IDPay()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  IDPay copyWith(void Function(IDPay) updates) => super.copyWith((message) => updates(message as IDPay)) as IDPay; // ignore: deprecated_member_use
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

  @$pb.TagNumber(18)
  $core.bool get neverExpires => $_getBF(17);
  @$pb.TagNumber(18)
  set neverExpires($core.bool v) { $_setBool(17, v); }
  @$pb.TagNumber(18)
  $core.bool hasNeverExpires() => $_has(17);
  @$pb.TagNumber(18)
  void clearNeverExpires() => clearField(18);

  @$pb.TagNumber(19)
  $core.String get organizationId => $_getSZ(18);
  @$pb.TagNumber(19)
  set organizationId($core.String v) { $_setString(18, v); }
  @$pb.TagNumber(19)
  $core.bool hasOrganizationId() => $_has(18);
  @$pb.TagNumber(19)
  void clearOrganizationId() => clearField(19);

  @$pb.TagNumber(20)
  $core.String get organizationName => $_getSZ(19);
  @$pb.TagNumber(20)
  set organizationName($core.String v) { $_setString(19, v); }
  @$pb.TagNumber(20)
  $core.bool hasOrganizationName() => $_has(19);
  @$pb.TagNumber(20)
  void clearOrganizationName() => clearField(20);
}

class IDPayTransaction extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'IDPayTransaction', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'id_pay'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payerId')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payerName')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payerUsername')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recipientId')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recipientName')
    ..a<$core.double>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reference')
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..aOM<$1.Timestamp>(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false
  ;

  IDPayTransaction._() : super();
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
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (payId != null) {
      _result.payId = payId;
    }
    if (payerId != null) {
      _result.payerId = payerId;
    }
    if (payerName != null) {
      _result.payerName = payerName;
    }
    if (payerUsername != null) {
      _result.payerUsername = payerUsername;
    }
    if (recipientId != null) {
      _result.recipientId = recipientId;
    }
    if (recipientName != null) {
      _result.recipientName = recipientName;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (reference != null) {
      _result.reference = reference;
    }
    if (status != null) {
      _result.status = status;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    return _result;
  }
  factory IDPayTransaction.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory IDPayTransaction.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  IDPayTransaction clone() => IDPayTransaction()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  IDPayTransaction copyWith(void Function(IDPayTransaction) updates) => super.copyWith((message) => updates(message as IDPayTransaction)) as IDPayTransaction; // ignore: deprecated_member_use
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

class IDPayOrganization extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'IDPayOrganization', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'id_pay'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'creatorId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'logoUrl')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountId')
    ..a<$core.double>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalReceived', $pb.PbFieldType.OD)
    ..a<$core.int>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalPaymentCount', $pb.PbFieldType.O3)
    ..a<$core.int>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'activeIdPayCount', $pb.PbFieldType.O3)
    ..aOM<$1.Timestamp>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedAt', subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false
  ;

  IDPayOrganization._() : super();
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
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (creatorId != null) {
      _result.creatorId = creatorId;
    }
    if (name != null) {
      _result.name = name;
    }
    if (description != null) {
      _result.description = description;
    }
    if (logoUrl != null) {
      _result.logoUrl = logoUrl;
    }
    if (accountId != null) {
      _result.accountId = accountId;
    }
    if (totalReceived != null) {
      _result.totalReceived = totalReceived;
    }
    if (totalPaymentCount != null) {
      _result.totalPaymentCount = totalPaymentCount;
    }
    if (activeIdPayCount != null) {
      _result.activeIdPayCount = activeIdPayCount;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      _result.updatedAt = updatedAt;
    }
    return _result;
  }
  factory IDPayOrganization.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory IDPayOrganization.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  IDPayOrganization clone() => IDPayOrganization()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  IDPayOrganization copyWith(void Function(IDPayOrganization) updates) => super.copyWith((message) => updates(message as IDPayOrganization)) as IDPayOrganization; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static IDPayOrganization create() => IDPayOrganization._();
  IDPayOrganization createEmptyInstance() => create();
  static $pb.PbList<IDPayOrganization> createRepeated() => $pb.PbList<IDPayOrganization>();
  @$core.pragma('dart2js:noInline')
  static IDPayOrganization getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<IDPayOrganization>(create);
  static IDPayOrganization? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get creatorId => $_getSZ(1);
  @$pb.TagNumber(2)
  set creatorId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCreatorId() => $_has(1);
  @$pb.TagNumber(2)
  void clearCreatorId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(3)
  set name($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get description => $_getSZ(3);
  @$pb.TagNumber(4)
  set description($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasDescription() => $_has(3);
  @$pb.TagNumber(4)
  void clearDescription() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get logoUrl => $_getSZ(4);
  @$pb.TagNumber(5)
  set logoUrl($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasLogoUrl() => $_has(4);
  @$pb.TagNumber(5)
  void clearLogoUrl() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get accountId => $_getSZ(5);
  @$pb.TagNumber(6)
  set accountId($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasAccountId() => $_has(5);
  @$pb.TagNumber(6)
  void clearAccountId() => clearField(6);

  @$pb.TagNumber(7)
  $core.double get totalReceived => $_getN(6);
  @$pb.TagNumber(7)
  set totalReceived($core.double v) { $_setDouble(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasTotalReceived() => $_has(6);
  @$pb.TagNumber(7)
  void clearTotalReceived() => clearField(7);

  @$pb.TagNumber(8)
  $core.int get totalPaymentCount => $_getIZ(7);
  @$pb.TagNumber(8)
  set totalPaymentCount($core.int v) { $_setSignedInt32(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasTotalPaymentCount() => $_has(7);
  @$pb.TagNumber(8)
  void clearTotalPaymentCount() => clearField(8);

  @$pb.TagNumber(9)
  $core.int get activeIdPayCount => $_getIZ(8);
  @$pb.TagNumber(9)
  set activeIdPayCount($core.int v) { $_setSignedInt32(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasActiveIdPayCount() => $_has(8);
  @$pb.TagNumber(9)
  void clearActiveIdPayCount() => clearField(9);

  @$pb.TagNumber(10)
  $1.Timestamp get createdAt => $_getN(9);
  @$pb.TagNumber(10)
  set createdAt($1.Timestamp v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasCreatedAt() => $_has(9);
  @$pb.TagNumber(10)
  void clearCreatedAt() => clearField(10);
  @$pb.TagNumber(10)
  $1.Timestamp ensureCreatedAt() => $_ensure(9);

  @$pb.TagNumber(11)
  $1.Timestamp get updatedAt => $_getN(10);
  @$pb.TagNumber(11)
  set updatedAt($1.Timestamp v) { setField(11, v); }
  @$pb.TagNumber(11)
  $core.bool hasUpdatedAt() => $_has(10);
  @$pb.TagNumber(11)
  void clearUpdatedAt() => clearField(11);
  @$pb.TagNumber(11)
  $1.Timestamp ensureUpdatedAt() => $_ensure(10);
}

class CreateIDPayRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateIDPayRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'id_pay'), createEmptyInstance: create)
    ..e<IDPayType>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type', $pb.PbFieldType.OE, defaultOrMaker: IDPayType.ID_PAY_TYPE_UNSPECIFIED, valueOf: IDPayType.valueOf, enumValues: IDPayType.values)
    ..e<IDPayAmountMode>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amountMode', $pb.PbFieldType.OE, defaultOrMaker: IDPayAmountMode.ID_PAY_AMOUNT_UNSPECIFIED, valueOf: IDPayAmountMode.valueOf, enumValues: IDPayAmountMode.values)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'minAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'maxAmount', $pb.PbFieldType.OD)
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..a<$core.int>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'validityMinutes', $pb.PbFieldType.O3)
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recipientAccountId')
    ..aOB(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'neverExpires')
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'organizationId')
    ..hasRequiredFields = false
  ;

  CreateIDPayRequest._() : super();
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
    final _result = create();
    if (type != null) {
      _result.type = type;
    }
    if (amountMode != null) {
      _result.amountMode = amountMode;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (minAmount != null) {
      _result.minAmount = minAmount;
    }
    if (maxAmount != null) {
      _result.maxAmount = maxAmount;
    }
    if (description != null) {
      _result.description = description;
    }
    if (validityMinutes != null) {
      _result.validityMinutes = validityMinutes;
    }
    if (recipientAccountId != null) {
      _result.recipientAccountId = recipientAccountId;
    }
    if (neverExpires != null) {
      _result.neverExpires = neverExpires;
    }
    if (organizationId != null) {
      _result.organizationId = organizationId;
    }
    return _result;
  }
  factory CreateIDPayRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateIDPayRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateIDPayRequest clone() => CreateIDPayRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateIDPayRequest copyWith(void Function(CreateIDPayRequest) updates) => super.copyWith((message) => updates(message as CreateIDPayRequest)) as CreateIDPayRequest; // ignore: deprecated_member_use
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

  @$pb.TagNumber(10)
  $core.bool get neverExpires => $_getBF(9);
  @$pb.TagNumber(10)
  set neverExpires($core.bool v) { $_setBool(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasNeverExpires() => $_has(9);
  @$pb.TagNumber(10)
  void clearNeverExpires() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get organizationId => $_getSZ(10);
  @$pb.TagNumber(11)
  set organizationId($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasOrganizationId() => $_has(10);
  @$pb.TagNumber(11)
  void clearOrganizationId() => clearField(11);
}

class CreateIDPayResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateIDPayResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'id_pay'), createEmptyInstance: create)
    ..aOM<IDPay>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'idPay', subBuilder: IDPay.create)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  CreateIDPayResponse._() : super();
  factory CreateIDPayResponse({
    IDPay? idPay,
    $core.String? message,
  }) {
    final _result = create();
    if (idPay != null) {
      _result.idPay = idPay;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory CreateIDPayResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateIDPayResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateIDPayResponse clone() => CreateIDPayResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateIDPayResponse copyWith(void Function(CreateIDPayResponse) updates) => super.copyWith((message) => updates(message as CreateIDPayResponse)) as CreateIDPayResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'LookupIDPayRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'id_pay'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payId')
    ..hasRequiredFields = false
  ;

  LookupIDPayRequest._() : super();
  factory LookupIDPayRequest({
    $core.String? payId,
  }) {
    final _result = create();
    if (payId != null) {
      _result.payId = payId;
    }
    return _result;
  }
  factory LookupIDPayRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LookupIDPayRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LookupIDPayRequest clone() => LookupIDPayRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LookupIDPayRequest copyWith(void Function(LookupIDPayRequest) updates) => super.copyWith((message) => updates(message as LookupIDPayRequest)) as LookupIDPayRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'LookupIDPayResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'id_pay'), createEmptyInstance: create)
    ..aOM<IDPay>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'idPay', subBuilder: IDPay.create)
    ..aOM<IDPayOrganization>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'organization', subBuilder: IDPayOrganization.create)
    ..hasRequiredFields = false
  ;

  LookupIDPayResponse._() : super();
  factory LookupIDPayResponse({
    IDPay? idPay,
    IDPayOrganization? organization,
  }) {
    final _result = create();
    if (idPay != null) {
      _result.idPay = idPay;
    }
    if (organization != null) {
      _result.organization = organization;
    }
    return _result;
  }
  factory LookupIDPayResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LookupIDPayResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LookupIDPayResponse clone() => LookupIDPayResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LookupIDPayResponse copyWith(void Function(LookupIDPayResponse) updates) => super.copyWith((message) => updates(message as LookupIDPayResponse)) as LookupIDPayResponse; // ignore: deprecated_member_use
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

  @$pb.TagNumber(2)
  IDPayOrganization get organization => $_getN(1);
  @$pb.TagNumber(2)
  set organization(IDPayOrganization v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasOrganization() => $_has(1);
  @$pb.TagNumber(2)
  void clearOrganization() => clearField(2);
  @$pb.TagNumber(2)
  IDPayOrganization ensureOrganization() => $_ensure(1);
}

class PayIDPayRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PayIDPayRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'id_pay'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payId')
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionPin')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sourceAccountId')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'idempotencyKey')
    ..hasRequiredFields = false
  ;

  PayIDPayRequest._() : super();
  factory PayIDPayRequest({
    $core.String? payId,
    $core.double? amount,
    $core.String? transactionPin,
    $core.String? sourceAccountId,
    $core.String? idempotencyKey,
  }) {
    final _result = create();
    if (payId != null) {
      _result.payId = payId;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (transactionPin != null) {
      _result.transactionPin = transactionPin;
    }
    if (sourceAccountId != null) {
      _result.sourceAccountId = sourceAccountId;
    }
    if (idempotencyKey != null) {
      _result.idempotencyKey = idempotencyKey;
    }
    return _result;
  }
  factory PayIDPayRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PayIDPayRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PayIDPayRequest clone() => PayIDPayRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PayIDPayRequest copyWith(void Function(PayIDPayRequest) updates) => super.copyWith((message) => updates(message as PayIDPayRequest)) as PayIDPayRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PayIDPayResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'id_pay'), createEmptyInstance: create)
    ..aOM<IDPayTransaction>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transaction', subBuilder: IDPayTransaction.create)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'newBalance', $pb.PbFieldType.OD)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  PayIDPayResponse._() : super();
  factory PayIDPayResponse({
    IDPayTransaction? transaction,
    $core.double? newBalance,
    $core.String? message,
  }) {
    final _result = create();
    if (transaction != null) {
      _result.transaction = transaction;
    }
    if (newBalance != null) {
      _result.newBalance = newBalance;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory PayIDPayResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PayIDPayResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PayIDPayResponse clone() => PayIDPayResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PayIDPayResponse copyWith(void Function(PayIDPayResponse) updates) => super.copyWith((message) => updates(message as PayIDPayResponse)) as PayIDPayResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetMyIDPaysRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'id_pay'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'offset', $pb.PbFieldType.O3)
    ..e<IDPayStatus>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'statusFilter', $pb.PbFieldType.OE, defaultOrMaker: IDPayStatus.ID_PAY_STATUS_UNSPECIFIED, valueOf: IDPayStatus.valueOf, enumValues: IDPayStatus.values)
    ..hasRequiredFields = false
  ;

  GetMyIDPaysRequest._() : super();
  factory GetMyIDPaysRequest({
    $core.int? limit,
    $core.int? offset,
    IDPayStatus? statusFilter,
  }) {
    final _result = create();
    if (limit != null) {
      _result.limit = limit;
    }
    if (offset != null) {
      _result.offset = offset;
    }
    if (statusFilter != null) {
      _result.statusFilter = statusFilter;
    }
    return _result;
  }
  factory GetMyIDPaysRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMyIDPaysRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMyIDPaysRequest clone() => GetMyIDPaysRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMyIDPaysRequest copyWith(void Function(GetMyIDPaysRequest) updates) => super.copyWith((message) => updates(message as GetMyIDPaysRequest)) as GetMyIDPaysRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetMyIDPaysResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'id_pay'), createEmptyInstance: create)
    ..pc<IDPay>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'idPays', $pb.PbFieldType.PM, subBuilder: IDPay.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetMyIDPaysResponse._() : super();
  factory GetMyIDPaysResponse({
    $core.Iterable<IDPay>? idPays,
    $core.int? total,
  }) {
    final _result = create();
    if (idPays != null) {
      _result.idPays.addAll(idPays);
    }
    if (total != null) {
      _result.total = total;
    }
    return _result;
  }
  factory GetMyIDPaysResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMyIDPaysResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMyIDPaysResponse clone() => GetMyIDPaysResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMyIDPaysResponse copyWith(void Function(GetMyIDPaysResponse) updates) => super.copyWith((message) => updates(message as GetMyIDPaysResponse)) as GetMyIDPaysResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetIDPayTransactionsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'id_pay'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payId')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetIDPayTransactionsRequest._() : super();
  factory GetIDPayTransactionsRequest({
    $core.String? payId,
    $core.int? limit,
    $core.int? offset,
  }) {
    final _result = create();
    if (payId != null) {
      _result.payId = payId;
    }
    if (limit != null) {
      _result.limit = limit;
    }
    if (offset != null) {
      _result.offset = offset;
    }
    return _result;
  }
  factory GetIDPayTransactionsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetIDPayTransactionsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetIDPayTransactionsRequest clone() => GetIDPayTransactionsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetIDPayTransactionsRequest copyWith(void Function(GetIDPayTransactionsRequest) updates) => super.copyWith((message) => updates(message as GetIDPayTransactionsRequest)) as GetIDPayTransactionsRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetIDPayTransactionsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'id_pay'), createEmptyInstance: create)
    ..pc<IDPayTransaction>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactions', $pb.PbFieldType.PM, subBuilder: IDPayTransaction.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetIDPayTransactionsResponse._() : super();
  factory GetIDPayTransactionsResponse({
    $core.Iterable<IDPayTransaction>? transactions,
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
  factory GetIDPayTransactionsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetIDPayTransactionsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetIDPayTransactionsResponse clone() => GetIDPayTransactionsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetIDPayTransactionsResponse copyWith(void Function(GetIDPayTransactionsResponse) updates) => super.copyWith((message) => updates(message as GetIDPayTransactionsResponse)) as GetIDPayTransactionsResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CancelIDPayRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'id_pay'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..hasRequiredFields = false
  ;

  CancelIDPayRequest._() : super();
  factory CancelIDPayRequest({
    $core.String? id,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    return _result;
  }
  factory CancelIDPayRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CancelIDPayRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CancelIDPayRequest clone() => CancelIDPayRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CancelIDPayRequest copyWith(void Function(CancelIDPayRequest) updates) => super.copyWith((message) => updates(message as CancelIDPayRequest)) as CancelIDPayRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CancelIDPayResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'id_pay'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  CancelIDPayResponse._() : super();
  factory CancelIDPayResponse({
    $core.String? message,
  }) {
    final _result = create();
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory CancelIDPayResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CancelIDPayResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CancelIDPayResponse clone() => CancelIDPayResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CancelIDPayResponse copyWith(void Function(CancelIDPayResponse) updates) => super.copyWith((message) => updates(message as CancelIDPayResponse)) as CancelIDPayResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetIDPayDetailsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'id_pay'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..hasRequiredFields = false
  ;

  GetIDPayDetailsRequest._() : super();
  factory GetIDPayDetailsRequest({
    $core.String? id,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    return _result;
  }
  factory GetIDPayDetailsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetIDPayDetailsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetIDPayDetailsRequest clone() => GetIDPayDetailsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetIDPayDetailsRequest copyWith(void Function(GetIDPayDetailsRequest) updates) => super.copyWith((message) => updates(message as GetIDPayDetailsRequest)) as GetIDPayDetailsRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetIDPayDetailsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'id_pay'), createEmptyInstance: create)
    ..aOM<IDPay>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'idPay', subBuilder: IDPay.create)
    ..hasRequiredFields = false
  ;

  GetIDPayDetailsResponse._() : super();
  factory GetIDPayDetailsResponse({
    IDPay? idPay,
  }) {
    final _result = create();
    if (idPay != null) {
      _result.idPay = idPay;
    }
    return _result;
  }
  factory GetIDPayDetailsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetIDPayDetailsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetIDPayDetailsResponse clone() => GetIDPayDetailsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetIDPayDetailsResponse copyWith(void Function(GetIDPayDetailsResponse) updates) => super.copyWith((message) => updates(message as GetIDPayDetailsResponse)) as GetIDPayDetailsResponse; // ignore: deprecated_member_use
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

class CreateOrganizationRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateOrganizationRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'id_pay'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'logoUrl')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountId')
    ..hasRequiredFields = false
  ;

  CreateOrganizationRequest._() : super();
  factory CreateOrganizationRequest({
    $core.String? name,
    $core.String? description,
    $core.String? logoUrl,
    $core.String? accountId,
  }) {
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    if (description != null) {
      _result.description = description;
    }
    if (logoUrl != null) {
      _result.logoUrl = logoUrl;
    }
    if (accountId != null) {
      _result.accountId = accountId;
    }
    return _result;
  }
  factory CreateOrganizationRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateOrganizationRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateOrganizationRequest clone() => CreateOrganizationRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateOrganizationRequest copyWith(void Function(CreateOrganizationRequest) updates) => super.copyWith((message) => updates(message as CreateOrganizationRequest)) as CreateOrganizationRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateOrganizationRequest create() => CreateOrganizationRequest._();
  CreateOrganizationRequest createEmptyInstance() => create();
  static $pb.PbList<CreateOrganizationRequest> createRepeated() => $pb.PbList<CreateOrganizationRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateOrganizationRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateOrganizationRequest>(create);
  static CreateOrganizationRequest? _defaultInstance;

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

  @$pb.TagNumber(3)
  $core.String get logoUrl => $_getSZ(2);
  @$pb.TagNumber(3)
  set logoUrl($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasLogoUrl() => $_has(2);
  @$pb.TagNumber(3)
  void clearLogoUrl() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get accountId => $_getSZ(3);
  @$pb.TagNumber(4)
  set accountId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasAccountId() => $_has(3);
  @$pb.TagNumber(4)
  void clearAccountId() => clearField(4);
}

class CreateOrganizationResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateOrganizationResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'id_pay'), createEmptyInstance: create)
    ..aOM<IDPayOrganization>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'organization', subBuilder: IDPayOrganization.create)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  CreateOrganizationResponse._() : super();
  factory CreateOrganizationResponse({
    IDPayOrganization? organization,
    $core.String? message,
  }) {
    final _result = create();
    if (organization != null) {
      _result.organization = organization;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory CreateOrganizationResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateOrganizationResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateOrganizationResponse clone() => CreateOrganizationResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateOrganizationResponse copyWith(void Function(CreateOrganizationResponse) updates) => super.copyWith((message) => updates(message as CreateOrganizationResponse)) as CreateOrganizationResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateOrganizationResponse create() => CreateOrganizationResponse._();
  CreateOrganizationResponse createEmptyInstance() => create();
  static $pb.PbList<CreateOrganizationResponse> createRepeated() => $pb.PbList<CreateOrganizationResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateOrganizationResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateOrganizationResponse>(create);
  static CreateOrganizationResponse? _defaultInstance;

  @$pb.TagNumber(1)
  IDPayOrganization get organization => $_getN(0);
  @$pb.TagNumber(1)
  set organization(IDPayOrganization v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasOrganization() => $_has(0);
  @$pb.TagNumber(1)
  void clearOrganization() => clearField(1);
  @$pb.TagNumber(1)
  IDPayOrganization ensureOrganization() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

class GetMyOrganizationsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetMyOrganizationsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'id_pay'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountId')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetMyOrganizationsRequest._() : super();
  factory GetMyOrganizationsRequest({
    $core.String? accountId,
    $core.int? limit,
    $core.int? offset,
  }) {
    final _result = create();
    if (accountId != null) {
      _result.accountId = accountId;
    }
    if (limit != null) {
      _result.limit = limit;
    }
    if (offset != null) {
      _result.offset = offset;
    }
    return _result;
  }
  factory GetMyOrganizationsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMyOrganizationsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMyOrganizationsRequest clone() => GetMyOrganizationsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMyOrganizationsRequest copyWith(void Function(GetMyOrganizationsRequest) updates) => super.copyWith((message) => updates(message as GetMyOrganizationsRequest)) as GetMyOrganizationsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetMyOrganizationsRequest create() => GetMyOrganizationsRequest._();
  GetMyOrganizationsRequest createEmptyInstance() => create();
  static $pb.PbList<GetMyOrganizationsRequest> createRepeated() => $pb.PbList<GetMyOrganizationsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMyOrganizationsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMyOrganizationsRequest>(create);
  static GetMyOrganizationsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => clearField(1);

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

class GetMyOrganizationsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetMyOrganizationsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'id_pay'), createEmptyInstance: create)
    ..pc<IDPayOrganization>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'organizations', $pb.PbFieldType.PM, subBuilder: IDPayOrganization.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetMyOrganizationsResponse._() : super();
  factory GetMyOrganizationsResponse({
    $core.Iterable<IDPayOrganization>? organizations,
    $core.int? total,
  }) {
    final _result = create();
    if (organizations != null) {
      _result.organizations.addAll(organizations);
    }
    if (total != null) {
      _result.total = total;
    }
    return _result;
  }
  factory GetMyOrganizationsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMyOrganizationsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMyOrganizationsResponse clone() => GetMyOrganizationsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMyOrganizationsResponse copyWith(void Function(GetMyOrganizationsResponse) updates) => super.copyWith((message) => updates(message as GetMyOrganizationsResponse)) as GetMyOrganizationsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetMyOrganizationsResponse create() => GetMyOrganizationsResponse._();
  GetMyOrganizationsResponse createEmptyInstance() => create();
  static $pb.PbList<GetMyOrganizationsResponse> createRepeated() => $pb.PbList<GetMyOrganizationsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMyOrganizationsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMyOrganizationsResponse>(create);
  static GetMyOrganizationsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<IDPayOrganization> get organizations => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => clearField(2);
}

class UpdateOrganizationRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateOrganizationRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'id_pay'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'logoUrl')
    ..hasRequiredFields = false
  ;

  UpdateOrganizationRequest._() : super();
  factory UpdateOrganizationRequest({
    $core.String? id,
    $core.String? name,
    $core.String? description,
    $core.String? logoUrl,
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
    if (logoUrl != null) {
      _result.logoUrl = logoUrl;
    }
    return _result;
  }
  factory UpdateOrganizationRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateOrganizationRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateOrganizationRequest clone() => UpdateOrganizationRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateOrganizationRequest copyWith(void Function(UpdateOrganizationRequest) updates) => super.copyWith((message) => updates(message as UpdateOrganizationRequest)) as UpdateOrganizationRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UpdateOrganizationRequest create() => UpdateOrganizationRequest._();
  UpdateOrganizationRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateOrganizationRequest> createRepeated() => $pb.PbList<UpdateOrganizationRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateOrganizationRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateOrganizationRequest>(create);
  static UpdateOrganizationRequest? _defaultInstance;

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
  $core.String get logoUrl => $_getSZ(3);
  @$pb.TagNumber(4)
  set logoUrl($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasLogoUrl() => $_has(3);
  @$pb.TagNumber(4)
  void clearLogoUrl() => clearField(4);
}

class UpdateOrganizationResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateOrganizationResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'id_pay'), createEmptyInstance: create)
    ..aOM<IDPayOrganization>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'organization', subBuilder: IDPayOrganization.create)
    ..hasRequiredFields = false
  ;

  UpdateOrganizationResponse._() : super();
  factory UpdateOrganizationResponse({
    IDPayOrganization? organization,
  }) {
    final _result = create();
    if (organization != null) {
      _result.organization = organization;
    }
    return _result;
  }
  factory UpdateOrganizationResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateOrganizationResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateOrganizationResponse clone() => UpdateOrganizationResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateOrganizationResponse copyWith(void Function(UpdateOrganizationResponse) updates) => super.copyWith((message) => updates(message as UpdateOrganizationResponse)) as UpdateOrganizationResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UpdateOrganizationResponse create() => UpdateOrganizationResponse._();
  UpdateOrganizationResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateOrganizationResponse> createRepeated() => $pb.PbList<UpdateOrganizationResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateOrganizationResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateOrganizationResponse>(create);
  static UpdateOrganizationResponse? _defaultInstance;

  @$pb.TagNumber(1)
  IDPayOrganization get organization => $_getN(0);
  @$pb.TagNumber(1)
  set organization(IDPayOrganization v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasOrganization() => $_has(0);
  @$pb.TagNumber(1)
  void clearOrganization() => clearField(1);
  @$pb.TagNumber(1)
  IDPayOrganization ensureOrganization() => $_ensure(0);
}

class DeleteOrganizationRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DeleteOrganizationRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'id_pay'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..hasRequiredFields = false
  ;

  DeleteOrganizationRequest._() : super();
  factory DeleteOrganizationRequest({
    $core.String? id,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    return _result;
  }
  factory DeleteOrganizationRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteOrganizationRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteOrganizationRequest clone() => DeleteOrganizationRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteOrganizationRequest copyWith(void Function(DeleteOrganizationRequest) updates) => super.copyWith((message) => updates(message as DeleteOrganizationRequest)) as DeleteOrganizationRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DeleteOrganizationRequest create() => DeleteOrganizationRequest._();
  DeleteOrganizationRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteOrganizationRequest> createRepeated() => $pb.PbList<DeleteOrganizationRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteOrganizationRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteOrganizationRequest>(create);
  static DeleteOrganizationRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);
}

class DeleteOrganizationResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DeleteOrganizationResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'id_pay'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  DeleteOrganizationResponse._() : super();
  factory DeleteOrganizationResponse({
    $core.String? message,
  }) {
    final _result = create();
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory DeleteOrganizationResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteOrganizationResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteOrganizationResponse clone() => DeleteOrganizationResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteOrganizationResponse copyWith(void Function(DeleteOrganizationResponse) updates) => super.copyWith((message) => updates(message as DeleteOrganizationResponse)) as DeleteOrganizationResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DeleteOrganizationResponse create() => DeleteOrganizationResponse._();
  DeleteOrganizationResponse createEmptyInstance() => create();
  static $pb.PbList<DeleteOrganizationResponse> createRepeated() => $pb.PbList<DeleteOrganizationResponse>();
  @$core.pragma('dart2js:noInline')
  static DeleteOrganizationResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteOrganizationResponse>(create);
  static DeleteOrganizationResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get message => $_getSZ(0);
  @$pb.TagNumber(1)
  set message($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMessage() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessage() => clearField(1);
}

class GetOrganizationDetailsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetOrganizationDetailsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'id_pay'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..hasRequiredFields = false
  ;

  GetOrganizationDetailsRequest._() : super();
  factory GetOrganizationDetailsRequest({
    $core.String? id,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    return _result;
  }
  factory GetOrganizationDetailsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetOrganizationDetailsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetOrganizationDetailsRequest clone() => GetOrganizationDetailsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetOrganizationDetailsRequest copyWith(void Function(GetOrganizationDetailsRequest) updates) => super.copyWith((message) => updates(message as GetOrganizationDetailsRequest)) as GetOrganizationDetailsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetOrganizationDetailsRequest create() => GetOrganizationDetailsRequest._();
  GetOrganizationDetailsRequest createEmptyInstance() => create();
  static $pb.PbList<GetOrganizationDetailsRequest> createRepeated() => $pb.PbList<GetOrganizationDetailsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetOrganizationDetailsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetOrganizationDetailsRequest>(create);
  static GetOrganizationDetailsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);
}

class GetOrganizationDetailsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetOrganizationDetailsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'id_pay'), createEmptyInstance: create)
    ..aOM<IDPayOrganization>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'organization', subBuilder: IDPayOrganization.create)
    ..pc<IDPay>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'idPays', $pb.PbFieldType.PM, subBuilder: IDPay.create)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalPaidOut', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  GetOrganizationDetailsResponse._() : super();
  factory GetOrganizationDetailsResponse({
    IDPayOrganization? organization,
    $core.Iterable<IDPay>? idPays,
    $core.double? totalPaidOut,
  }) {
    final _result = create();
    if (organization != null) {
      _result.organization = organization;
    }
    if (idPays != null) {
      _result.idPays.addAll(idPays);
    }
    if (totalPaidOut != null) {
      _result.totalPaidOut = totalPaidOut;
    }
    return _result;
  }
  factory GetOrganizationDetailsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetOrganizationDetailsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetOrganizationDetailsResponse clone() => GetOrganizationDetailsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetOrganizationDetailsResponse copyWith(void Function(GetOrganizationDetailsResponse) updates) => super.copyWith((message) => updates(message as GetOrganizationDetailsResponse)) as GetOrganizationDetailsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetOrganizationDetailsResponse create() => GetOrganizationDetailsResponse._();
  GetOrganizationDetailsResponse createEmptyInstance() => create();
  static $pb.PbList<GetOrganizationDetailsResponse> createRepeated() => $pb.PbList<GetOrganizationDetailsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetOrganizationDetailsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetOrganizationDetailsResponse>(create);
  static GetOrganizationDetailsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  IDPayOrganization get organization => $_getN(0);
  @$pb.TagNumber(1)
  set organization(IDPayOrganization v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasOrganization() => $_has(0);
  @$pb.TagNumber(1)
  void clearOrganization() => clearField(1);
  @$pb.TagNumber(1)
  IDPayOrganization ensureOrganization() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.List<IDPay> get idPays => $_getList(1);

  @$pb.TagNumber(3)
  $core.double get totalPaidOut => $_getN(2);
  @$pb.TagNumber(3)
  set totalPaidOut($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTotalPaidOut() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalPaidOut() => clearField(3);
}

