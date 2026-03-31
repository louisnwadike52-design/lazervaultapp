//
//  Generated code. Do not modify.
//  source: qr_pay.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/timestamp.pb.dart' as $1;
import 'qr_pay.pbenum.dart';

export 'qr_pay.pbenum.dart';

/// Models
class QRCode extends $pb.GeneratedMessage {
  factory QRCode({
    $core.String? id,
    $core.String? userId,
    $core.String? username,
    $core.String? fullName,
    $core.String? qrCode,
    $core.double? amount,
    $core.String? currency,
    $core.String? description,
    QRType? qrType,
    QRStatus? status,
    $1.Timestamp? createdAt,
    $1.Timestamp? expiresAt,
    $1.Timestamp? paidAt,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (userId != null) {
      $result.userId = userId;
    }
    if (username != null) {
      $result.username = username;
    }
    if (fullName != null) {
      $result.fullName = fullName;
    }
    if (qrCode != null) {
      $result.qrCode = qrCode;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (description != null) {
      $result.description = description;
    }
    if (qrType != null) {
      $result.qrType = qrType;
    }
    if (status != null) {
      $result.status = status;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    if (expiresAt != null) {
      $result.expiresAt = expiresAt;
    }
    if (paidAt != null) {
      $result.paidAt = paidAt;
    }
    return $result;
  }
  QRCode._() : super();
  factory QRCode.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory QRCode.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'QRCode', package: const $pb.PackageName(_omitMessageNames ? '' : 'qr_pay'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'username')
    ..aOS(4, _omitFieldNames ? '' : 'fullName')
    ..aOS(5, _omitFieldNames ? '' : 'qrCode')
    ..a<$core.double>(6, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(7, _omitFieldNames ? '' : 'currency')
    ..aOS(8, _omitFieldNames ? '' : 'description')
    ..e<QRType>(9, _omitFieldNames ? '' : 'qrType', $pb.PbFieldType.OE, defaultOrMaker: QRType.QR_TYPE_DYNAMIC, valueOf: QRType.valueOf, enumValues: QRType.values)
    ..e<QRStatus>(10, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: QRStatus.QR_STATUS_PENDING, valueOf: QRStatus.valueOf, enumValues: QRStatus.values)
    ..aOM<$1.Timestamp>(11, _omitFieldNames ? '' : 'createdAt', subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(12, _omitFieldNames ? '' : 'expiresAt', subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(13, _omitFieldNames ? '' : 'paidAt', subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  QRCode clone() => QRCode()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  QRCode copyWith(void Function(QRCode) updates) => super.copyWith((message) => updates(message as QRCode)) as QRCode;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static QRCode create() => QRCode._();
  QRCode createEmptyInstance() => create();
  static $pb.PbList<QRCode> createRepeated() => $pb.PbList<QRCode>();
  @$core.pragma('dart2js:noInline')
  static QRCode getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<QRCode>(create);
  static QRCode? _defaultInstance;

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
  $core.String get username => $_getSZ(2);
  @$pb.TagNumber(3)
  set username($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasUsername() => $_has(2);
  @$pb.TagNumber(3)
  void clearUsername() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get fullName => $_getSZ(3);
  @$pb.TagNumber(4)
  set fullName($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasFullName() => $_has(3);
  @$pb.TagNumber(4)
  void clearFullName() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get qrCode => $_getSZ(4);
  @$pb.TagNumber(5)
  set qrCode($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasQrCode() => $_has(4);
  @$pb.TagNumber(5)
  void clearQrCode() => clearField(5);

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
  $core.String get description => $_getSZ(7);
  @$pb.TagNumber(8)
  set description($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasDescription() => $_has(7);
  @$pb.TagNumber(8)
  void clearDescription() => clearField(8);

  @$pb.TagNumber(9)
  QRType get qrType => $_getN(8);
  @$pb.TagNumber(9)
  set qrType(QRType v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasQrType() => $_has(8);
  @$pb.TagNumber(9)
  void clearQrType() => clearField(9);

  @$pb.TagNumber(10)
  QRStatus get status => $_getN(9);
  @$pb.TagNumber(10)
  set status(QRStatus v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasStatus() => $_has(9);
  @$pb.TagNumber(10)
  void clearStatus() => clearField(10);

  @$pb.TagNumber(11)
  $1.Timestamp get createdAt => $_getN(10);
  @$pb.TagNumber(11)
  set createdAt($1.Timestamp v) { setField(11, v); }
  @$pb.TagNumber(11)
  $core.bool hasCreatedAt() => $_has(10);
  @$pb.TagNumber(11)
  void clearCreatedAt() => clearField(11);
  @$pb.TagNumber(11)
  $1.Timestamp ensureCreatedAt() => $_ensure(10);

  @$pb.TagNumber(12)
  $1.Timestamp get expiresAt => $_getN(11);
  @$pb.TagNumber(12)
  set expiresAt($1.Timestamp v) { setField(12, v); }
  @$pb.TagNumber(12)
  $core.bool hasExpiresAt() => $_has(11);
  @$pb.TagNumber(12)
  void clearExpiresAt() => clearField(12);
  @$pb.TagNumber(12)
  $1.Timestamp ensureExpiresAt() => $_ensure(11);

  @$pb.TagNumber(13)
  $1.Timestamp get paidAt => $_getN(12);
  @$pb.TagNumber(13)
  set paidAt($1.Timestamp v) { setField(13, v); }
  @$pb.TagNumber(13)
  $core.bool hasPaidAt() => $_has(12);
  @$pb.TagNumber(13)
  void clearPaidAt() => clearField(13);
  @$pb.TagNumber(13)
  $1.Timestamp ensurePaidAt() => $_ensure(12);
}

class QRTransaction extends $pb.GeneratedMessage {
  factory QRTransaction({
    $core.String? id,
    $core.String? qrId,
    $core.String? payerId,
    $core.String? payerUsername,
    $core.String? payerName,
    $core.String? recipientId,
    $core.String? recipientUsername,
    $core.String? recipientName,
    $core.double? amount,
    $core.String? currency,
    $core.String? description,
    $core.String? referenceNumber,
    QRStatus? status,
    $1.Timestamp? createdAt,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (qrId != null) {
      $result.qrId = qrId;
    }
    if (payerId != null) {
      $result.payerId = payerId;
    }
    if (payerUsername != null) {
      $result.payerUsername = payerUsername;
    }
    if (payerName != null) {
      $result.payerName = payerName;
    }
    if (recipientId != null) {
      $result.recipientId = recipientId;
    }
    if (recipientUsername != null) {
      $result.recipientUsername = recipientUsername;
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
    if (description != null) {
      $result.description = description;
    }
    if (referenceNumber != null) {
      $result.referenceNumber = referenceNumber;
    }
    if (status != null) {
      $result.status = status;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    return $result;
  }
  QRTransaction._() : super();
  factory QRTransaction.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory QRTransaction.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'QRTransaction', package: const $pb.PackageName(_omitMessageNames ? '' : 'qr_pay'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'qrId')
    ..aOS(3, _omitFieldNames ? '' : 'payerId')
    ..aOS(4, _omitFieldNames ? '' : 'payerUsername')
    ..aOS(5, _omitFieldNames ? '' : 'payerName')
    ..aOS(6, _omitFieldNames ? '' : 'recipientId')
    ..aOS(7, _omitFieldNames ? '' : 'recipientUsername')
    ..aOS(8, _omitFieldNames ? '' : 'recipientName')
    ..a<$core.double>(9, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(10, _omitFieldNames ? '' : 'currency')
    ..aOS(11, _omitFieldNames ? '' : 'description')
    ..aOS(12, _omitFieldNames ? '' : 'referenceNumber')
    ..e<QRStatus>(13, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: QRStatus.QR_STATUS_PENDING, valueOf: QRStatus.valueOf, enumValues: QRStatus.values)
    ..aOM<$1.Timestamp>(14, _omitFieldNames ? '' : 'createdAt', subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  QRTransaction clone() => QRTransaction()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  QRTransaction copyWith(void Function(QRTransaction) updates) => super.copyWith((message) => updates(message as QRTransaction)) as QRTransaction;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static QRTransaction create() => QRTransaction._();
  QRTransaction createEmptyInstance() => create();
  static $pb.PbList<QRTransaction> createRepeated() => $pb.PbList<QRTransaction>();
  @$core.pragma('dart2js:noInline')
  static QRTransaction getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<QRTransaction>(create);
  static QRTransaction? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get qrId => $_getSZ(1);
  @$pb.TagNumber(2)
  set qrId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasQrId() => $_has(1);
  @$pb.TagNumber(2)
  void clearQrId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get payerId => $_getSZ(2);
  @$pb.TagNumber(3)
  set payerId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPayerId() => $_has(2);
  @$pb.TagNumber(3)
  void clearPayerId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get payerUsername => $_getSZ(3);
  @$pb.TagNumber(4)
  set payerUsername($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPayerUsername() => $_has(3);
  @$pb.TagNumber(4)
  void clearPayerUsername() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get payerName => $_getSZ(4);
  @$pb.TagNumber(5)
  set payerName($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasPayerName() => $_has(4);
  @$pb.TagNumber(5)
  void clearPayerName() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get recipientId => $_getSZ(5);
  @$pb.TagNumber(6)
  set recipientId($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasRecipientId() => $_has(5);
  @$pb.TagNumber(6)
  void clearRecipientId() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get recipientUsername => $_getSZ(6);
  @$pb.TagNumber(7)
  set recipientUsername($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasRecipientUsername() => $_has(6);
  @$pb.TagNumber(7)
  void clearRecipientUsername() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get recipientName => $_getSZ(7);
  @$pb.TagNumber(8)
  set recipientName($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasRecipientName() => $_has(7);
  @$pb.TagNumber(8)
  void clearRecipientName() => clearField(8);

  @$pb.TagNumber(9)
  $core.double get amount => $_getN(8);
  @$pb.TagNumber(9)
  set amount($core.double v) { $_setDouble(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasAmount() => $_has(8);
  @$pb.TagNumber(9)
  void clearAmount() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get currency => $_getSZ(9);
  @$pb.TagNumber(10)
  set currency($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasCurrency() => $_has(9);
  @$pb.TagNumber(10)
  void clearCurrency() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get description => $_getSZ(10);
  @$pb.TagNumber(11)
  set description($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasDescription() => $_has(10);
  @$pb.TagNumber(11)
  void clearDescription() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get referenceNumber => $_getSZ(11);
  @$pb.TagNumber(12)
  set referenceNumber($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasReferenceNumber() => $_has(11);
  @$pb.TagNumber(12)
  void clearReferenceNumber() => clearField(12);

  @$pb.TagNumber(13)
  QRStatus get status => $_getN(12);
  @$pb.TagNumber(13)
  set status(QRStatus v) { setField(13, v); }
  @$pb.TagNumber(13)
  $core.bool hasStatus() => $_has(12);
  @$pb.TagNumber(13)
  void clearStatus() => clearField(13);

  @$pb.TagNumber(14)
  $1.Timestamp get createdAt => $_getN(13);
  @$pb.TagNumber(14)
  set createdAt($1.Timestamp v) { setField(14, v); }
  @$pb.TagNumber(14)
  $core.bool hasCreatedAt() => $_has(13);
  @$pb.TagNumber(14)
  void clearCreatedAt() => clearField(14);
  @$pb.TagNumber(14)
  $1.Timestamp ensureCreatedAt() => $_ensure(13);
}

/// Request/Response messages
class GenerateQRRequest extends $pb.GeneratedMessage {
  factory GenerateQRRequest({
    $core.double? amount,
    $core.String? currency,
    $core.String? description,
    QRType? qrType,
    $core.int? validityMinutes,
  }) {
    final $result = create();
    if (amount != null) {
      $result.amount = amount;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (description != null) {
      $result.description = description;
    }
    if (qrType != null) {
      $result.qrType = qrType;
    }
    if (validityMinutes != null) {
      $result.validityMinutes = validityMinutes;
    }
    return $result;
  }
  GenerateQRRequest._() : super();
  factory GenerateQRRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GenerateQRRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GenerateQRRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'qr_pay'), createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(2, _omitFieldNames ? '' : 'currency')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..e<QRType>(4, _omitFieldNames ? '' : 'qrType', $pb.PbFieldType.OE, defaultOrMaker: QRType.QR_TYPE_DYNAMIC, valueOf: QRType.valueOf, enumValues: QRType.values)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'validityMinutes', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GenerateQRRequest clone() => GenerateQRRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GenerateQRRequest copyWith(void Function(GenerateQRRequest) updates) => super.copyWith((message) => updates(message as GenerateQRRequest)) as GenerateQRRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GenerateQRRequest create() => GenerateQRRequest._();
  GenerateQRRequest createEmptyInstance() => create();
  static $pb.PbList<GenerateQRRequest> createRepeated() => $pb.PbList<GenerateQRRequest>();
  @$core.pragma('dart2js:noInline')
  static GenerateQRRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GenerateQRRequest>(create);
  static GenerateQRRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get amount => $_getN(0);
  @$pb.TagNumber(1)
  set amount($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAmount() => $_has(0);
  @$pb.TagNumber(1)
  void clearAmount() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get currency => $_getSZ(1);
  @$pb.TagNumber(2)
  set currency($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCurrency() => $_has(1);
  @$pb.TagNumber(2)
  void clearCurrency() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => clearField(3);

  @$pb.TagNumber(4)
  QRType get qrType => $_getN(3);
  @$pb.TagNumber(4)
  set qrType(QRType v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasQrType() => $_has(3);
  @$pb.TagNumber(4)
  void clearQrType() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get validityMinutes => $_getIZ(4);
  @$pb.TagNumber(5)
  set validityMinutes($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasValidityMinutes() => $_has(4);
  @$pb.TagNumber(5)
  void clearValidityMinutes() => clearField(5);
}

class GenerateQRResponse extends $pb.GeneratedMessage {
  factory GenerateQRResponse({
    QRCode? qrCode,
    $core.String? qrData,
    $core.String? message,
  }) {
    final $result = create();
    if (qrCode != null) {
      $result.qrCode = qrCode;
    }
    if (qrData != null) {
      $result.qrData = qrData;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  GenerateQRResponse._() : super();
  factory GenerateQRResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GenerateQRResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GenerateQRResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'qr_pay'), createEmptyInstance: create)
    ..aOM<QRCode>(1, _omitFieldNames ? '' : 'qrCode', subBuilder: QRCode.create)
    ..aOS(2, _omitFieldNames ? '' : 'qrData')
    ..aOS(3, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GenerateQRResponse clone() => GenerateQRResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GenerateQRResponse copyWith(void Function(GenerateQRResponse) updates) => super.copyWith((message) => updates(message as GenerateQRResponse)) as GenerateQRResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GenerateQRResponse create() => GenerateQRResponse._();
  GenerateQRResponse createEmptyInstance() => create();
  static $pb.PbList<GenerateQRResponse> createRepeated() => $pb.PbList<GenerateQRResponse>();
  @$core.pragma('dart2js:noInline')
  static GenerateQRResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GenerateQRResponse>(create);
  static GenerateQRResponse? _defaultInstance;

  @$pb.TagNumber(1)
  QRCode get qrCode => $_getN(0);
  @$pb.TagNumber(1)
  set qrCode(QRCode v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasQrCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearQrCode() => clearField(1);
  @$pb.TagNumber(1)
  QRCode ensureQrCode() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get qrData => $_getSZ(1);
  @$pb.TagNumber(2)
  set qrData($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasQrData() => $_has(1);
  @$pb.TagNumber(2)
  void clearQrData() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => clearField(3);
}

class GetQRDetailsRequest extends $pb.GeneratedMessage {
  factory GetQRDetailsRequest({
    $core.String? qrCode,
  }) {
    final $result = create();
    if (qrCode != null) {
      $result.qrCode = qrCode;
    }
    return $result;
  }
  GetQRDetailsRequest._() : super();
  factory GetQRDetailsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetQRDetailsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetQRDetailsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'qr_pay'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'qrCode')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetQRDetailsRequest clone() => GetQRDetailsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetQRDetailsRequest copyWith(void Function(GetQRDetailsRequest) updates) => super.copyWith((message) => updates(message as GetQRDetailsRequest)) as GetQRDetailsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetQRDetailsRequest create() => GetQRDetailsRequest._();
  GetQRDetailsRequest createEmptyInstance() => create();
  static $pb.PbList<GetQRDetailsRequest> createRepeated() => $pb.PbList<GetQRDetailsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetQRDetailsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetQRDetailsRequest>(create);
  static GetQRDetailsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get qrCode => $_getSZ(0);
  @$pb.TagNumber(1)
  set qrCode($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasQrCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearQrCode() => clearField(1);
}

class GetQRDetailsResponse extends $pb.GeneratedMessage {
  factory GetQRDetailsResponse({
    QRCode? qrCode,
  }) {
    final $result = create();
    if (qrCode != null) {
      $result.qrCode = qrCode;
    }
    return $result;
  }
  GetQRDetailsResponse._() : super();
  factory GetQRDetailsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetQRDetailsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetQRDetailsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'qr_pay'), createEmptyInstance: create)
    ..aOM<QRCode>(1, _omitFieldNames ? '' : 'qrCode', subBuilder: QRCode.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetQRDetailsResponse clone() => GetQRDetailsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetQRDetailsResponse copyWith(void Function(GetQRDetailsResponse) updates) => super.copyWith((message) => updates(message as GetQRDetailsResponse)) as GetQRDetailsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetQRDetailsResponse create() => GetQRDetailsResponse._();
  GetQRDetailsResponse createEmptyInstance() => create();
  static $pb.PbList<GetQRDetailsResponse> createRepeated() => $pb.PbList<GetQRDetailsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetQRDetailsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetQRDetailsResponse>(create);
  static GetQRDetailsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  QRCode get qrCode => $_getN(0);
  @$pb.TagNumber(1)
  set qrCode(QRCode v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasQrCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearQrCode() => clearField(1);
  @$pb.TagNumber(1)
  QRCode ensureQrCode() => $_ensure(0);
}

class ProcessQRPaymentRequest extends $pb.GeneratedMessage {
  factory ProcessQRPaymentRequest({
    $core.String? qrCode,
    $core.String? sourceAccountId,
    $core.double? amount,
    $core.String? transactionPin,
    $core.String? idempotencyKey,
  }) {
    final $result = create();
    if (qrCode != null) {
      $result.qrCode = qrCode;
    }
    if (sourceAccountId != null) {
      $result.sourceAccountId = sourceAccountId;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (transactionPin != null) {
      $result.transactionPin = transactionPin;
    }
    if (idempotencyKey != null) {
      $result.idempotencyKey = idempotencyKey;
    }
    return $result;
  }
  ProcessQRPaymentRequest._() : super();
  factory ProcessQRPaymentRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProcessQRPaymentRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ProcessQRPaymentRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'qr_pay'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'qrCode')
    ..aOS(2, _omitFieldNames ? '' : 'sourceAccountId')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(4, _omitFieldNames ? '' : 'transactionPin')
    ..aOS(5, _omitFieldNames ? '' : 'idempotencyKey')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProcessQRPaymentRequest clone() => ProcessQRPaymentRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProcessQRPaymentRequest copyWith(void Function(ProcessQRPaymentRequest) updates) => super.copyWith((message) => updates(message as ProcessQRPaymentRequest)) as ProcessQRPaymentRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ProcessQRPaymentRequest create() => ProcessQRPaymentRequest._();
  ProcessQRPaymentRequest createEmptyInstance() => create();
  static $pb.PbList<ProcessQRPaymentRequest> createRepeated() => $pb.PbList<ProcessQRPaymentRequest>();
  @$core.pragma('dart2js:noInline')
  static ProcessQRPaymentRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProcessQRPaymentRequest>(create);
  static ProcessQRPaymentRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get qrCode => $_getSZ(0);
  @$pb.TagNumber(1)
  set qrCode($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasQrCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearQrCode() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get sourceAccountId => $_getSZ(1);
  @$pb.TagNumber(2)
  set sourceAccountId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSourceAccountId() => $_has(1);
  @$pb.TagNumber(2)
  void clearSourceAccountId() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get amount => $_getN(2);
  @$pb.TagNumber(3)
  set amount($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get transactionPin => $_getSZ(3);
  @$pb.TagNumber(4)
  set transactionPin($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTransactionPin() => $_has(3);
  @$pb.TagNumber(4)
  void clearTransactionPin() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get idempotencyKey => $_getSZ(4);
  @$pb.TagNumber(5)
  set idempotencyKey($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasIdempotencyKey() => $_has(4);
  @$pb.TagNumber(5)
  void clearIdempotencyKey() => clearField(5);
}

class ProcessQRPaymentResponse extends $pb.GeneratedMessage {
  factory ProcessQRPaymentResponse({
    QRTransaction? transaction,
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
  ProcessQRPaymentResponse._() : super();
  factory ProcessQRPaymentResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProcessQRPaymentResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ProcessQRPaymentResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'qr_pay'), createEmptyInstance: create)
    ..aOM<QRTransaction>(1, _omitFieldNames ? '' : 'transaction', subBuilder: QRTransaction.create)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'newBalance', $pb.PbFieldType.OD)
    ..aOS(3, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProcessQRPaymentResponse clone() => ProcessQRPaymentResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProcessQRPaymentResponse copyWith(void Function(ProcessQRPaymentResponse) updates) => super.copyWith((message) => updates(message as ProcessQRPaymentResponse)) as ProcessQRPaymentResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ProcessQRPaymentResponse create() => ProcessQRPaymentResponse._();
  ProcessQRPaymentResponse createEmptyInstance() => create();
  static $pb.PbList<ProcessQRPaymentResponse> createRepeated() => $pb.PbList<ProcessQRPaymentResponse>();
  @$core.pragma('dart2js:noInline')
  static ProcessQRPaymentResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProcessQRPaymentResponse>(create);
  static ProcessQRPaymentResponse? _defaultInstance;

  @$pb.TagNumber(1)
  QRTransaction get transaction => $_getN(0);
  @$pb.TagNumber(1)
  set transaction(QRTransaction v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasTransaction() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransaction() => clearField(1);
  @$pb.TagNumber(1)
  QRTransaction ensureTransaction() => $_ensure(0);

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

class GetMyGeneratedQRCodesRequest extends $pb.GeneratedMessage {
  factory GetMyGeneratedQRCodesRequest({
    $core.int? limit,
    $core.int? offset,
    QRStatus? statusFilter,
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
  GetMyGeneratedQRCodesRequest._() : super();
  factory GetMyGeneratedQRCodesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMyGeneratedQRCodesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetMyGeneratedQRCodesRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'qr_pay'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'offset', $pb.PbFieldType.O3)
    ..e<QRStatus>(3, _omitFieldNames ? '' : 'statusFilter', $pb.PbFieldType.OE, defaultOrMaker: QRStatus.QR_STATUS_PENDING, valueOf: QRStatus.valueOf, enumValues: QRStatus.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMyGeneratedQRCodesRequest clone() => GetMyGeneratedQRCodesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMyGeneratedQRCodesRequest copyWith(void Function(GetMyGeneratedQRCodesRequest) updates) => super.copyWith((message) => updates(message as GetMyGeneratedQRCodesRequest)) as GetMyGeneratedQRCodesRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMyGeneratedQRCodesRequest create() => GetMyGeneratedQRCodesRequest._();
  GetMyGeneratedQRCodesRequest createEmptyInstance() => create();
  static $pb.PbList<GetMyGeneratedQRCodesRequest> createRepeated() => $pb.PbList<GetMyGeneratedQRCodesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMyGeneratedQRCodesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMyGeneratedQRCodesRequest>(create);
  static GetMyGeneratedQRCodesRequest? _defaultInstance;

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
  QRStatus get statusFilter => $_getN(2);
  @$pb.TagNumber(3)
  set statusFilter(QRStatus v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasStatusFilter() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatusFilter() => clearField(3);
}

class GetMyGeneratedQRCodesResponse extends $pb.GeneratedMessage {
  factory GetMyGeneratedQRCodesResponse({
    $core.Iterable<QRCode>? qrCodes,
    $core.int? total,
  }) {
    final $result = create();
    if (qrCodes != null) {
      $result.qrCodes.addAll(qrCodes);
    }
    if (total != null) {
      $result.total = total;
    }
    return $result;
  }
  GetMyGeneratedQRCodesResponse._() : super();
  factory GetMyGeneratedQRCodesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMyGeneratedQRCodesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetMyGeneratedQRCodesResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'qr_pay'), createEmptyInstance: create)
    ..pc<QRCode>(1, _omitFieldNames ? '' : 'qrCodes', $pb.PbFieldType.PM, subBuilder: QRCode.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMyGeneratedQRCodesResponse clone() => GetMyGeneratedQRCodesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMyGeneratedQRCodesResponse copyWith(void Function(GetMyGeneratedQRCodesResponse) updates) => super.copyWith((message) => updates(message as GetMyGeneratedQRCodesResponse)) as GetMyGeneratedQRCodesResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMyGeneratedQRCodesResponse create() => GetMyGeneratedQRCodesResponse._();
  GetMyGeneratedQRCodesResponse createEmptyInstance() => create();
  static $pb.PbList<GetMyGeneratedQRCodesResponse> createRepeated() => $pb.PbList<GetMyGeneratedQRCodesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMyGeneratedQRCodesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMyGeneratedQRCodesResponse>(create);
  static GetMyGeneratedQRCodesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<QRCode> get qrCodes => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => clearField(2);
}

class GetMyQRPaymentsRequest extends $pb.GeneratedMessage {
  factory GetMyQRPaymentsRequest({
    $core.int? limit,
    $core.int? offset,
  }) {
    final $result = create();
    if (limit != null) {
      $result.limit = limit;
    }
    if (offset != null) {
      $result.offset = offset;
    }
    return $result;
  }
  GetMyQRPaymentsRequest._() : super();
  factory GetMyQRPaymentsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMyQRPaymentsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetMyQRPaymentsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'qr_pay'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMyQRPaymentsRequest clone() => GetMyQRPaymentsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMyQRPaymentsRequest copyWith(void Function(GetMyQRPaymentsRequest) updates) => super.copyWith((message) => updates(message as GetMyQRPaymentsRequest)) as GetMyQRPaymentsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMyQRPaymentsRequest create() => GetMyQRPaymentsRequest._();
  GetMyQRPaymentsRequest createEmptyInstance() => create();
  static $pb.PbList<GetMyQRPaymentsRequest> createRepeated() => $pb.PbList<GetMyQRPaymentsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMyQRPaymentsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMyQRPaymentsRequest>(create);
  static GetMyQRPaymentsRequest? _defaultInstance;

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
}

class GetMyQRPaymentsResponse extends $pb.GeneratedMessage {
  factory GetMyQRPaymentsResponse({
    $core.Iterable<QRTransaction>? transactions,
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
  GetMyQRPaymentsResponse._() : super();
  factory GetMyQRPaymentsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMyQRPaymentsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetMyQRPaymentsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'qr_pay'), createEmptyInstance: create)
    ..pc<QRTransaction>(1, _omitFieldNames ? '' : 'transactions', $pb.PbFieldType.PM, subBuilder: QRTransaction.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMyQRPaymentsResponse clone() => GetMyQRPaymentsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMyQRPaymentsResponse copyWith(void Function(GetMyQRPaymentsResponse) updates) => super.copyWith((message) => updates(message as GetMyQRPaymentsResponse)) as GetMyQRPaymentsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMyQRPaymentsResponse create() => GetMyQRPaymentsResponse._();
  GetMyQRPaymentsResponse createEmptyInstance() => create();
  static $pb.PbList<GetMyQRPaymentsResponse> createRepeated() => $pb.PbList<GetMyQRPaymentsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMyQRPaymentsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMyQRPaymentsResponse>(create);
  static GetMyQRPaymentsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<QRTransaction> get transactions => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => clearField(2);
}

class CancelQRRequest extends $pb.GeneratedMessage {
  factory CancelQRRequest({
    $core.String? qrId,
  }) {
    final $result = create();
    if (qrId != null) {
      $result.qrId = qrId;
    }
    return $result;
  }
  CancelQRRequest._() : super();
  factory CancelQRRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CancelQRRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CancelQRRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'qr_pay'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'qrId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CancelQRRequest clone() => CancelQRRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CancelQRRequest copyWith(void Function(CancelQRRequest) updates) => super.copyWith((message) => updates(message as CancelQRRequest)) as CancelQRRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CancelQRRequest create() => CancelQRRequest._();
  CancelQRRequest createEmptyInstance() => create();
  static $pb.PbList<CancelQRRequest> createRepeated() => $pb.PbList<CancelQRRequest>();
  @$core.pragma('dart2js:noInline')
  static CancelQRRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CancelQRRequest>(create);
  static CancelQRRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get qrId => $_getSZ(0);
  @$pb.TagNumber(1)
  set qrId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasQrId() => $_has(0);
  @$pb.TagNumber(1)
  void clearQrId() => clearField(1);
}

class CancelQRResponse extends $pb.GeneratedMessage {
  factory CancelQRResponse({
    $core.String? message,
  }) {
    final $result = create();
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  CancelQRResponse._() : super();
  factory CancelQRResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CancelQRResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CancelQRResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'qr_pay'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CancelQRResponse clone() => CancelQRResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CancelQRResponse copyWith(void Function(CancelQRResponse) updates) => super.copyWith((message) => updates(message as CancelQRResponse)) as CancelQRResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CancelQRResponse create() => CancelQRResponse._();
  CancelQRResponse createEmptyInstance() => create();
  static $pb.PbList<CancelQRResponse> createRepeated() => $pb.PbList<CancelQRResponse>();
  @$core.pragma('dart2js:noInline')
  static CancelQRResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CancelQRResponse>(create);
  static CancelQRResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get message => $_getSZ(0);
  @$pb.TagNumber(1)
  set message($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMessage() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessage() => clearField(1);
}

class GetQRTransactionReceiptRequest extends $pb.GeneratedMessage {
  factory GetQRTransactionReceiptRequest({
    $core.String? transactionId,
  }) {
    final $result = create();
    if (transactionId != null) {
      $result.transactionId = transactionId;
    }
    return $result;
  }
  GetQRTransactionReceiptRequest._() : super();
  factory GetQRTransactionReceiptRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetQRTransactionReceiptRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetQRTransactionReceiptRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'qr_pay'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'transactionId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetQRTransactionReceiptRequest clone() => GetQRTransactionReceiptRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetQRTransactionReceiptRequest copyWith(void Function(GetQRTransactionReceiptRequest) updates) => super.copyWith((message) => updates(message as GetQRTransactionReceiptRequest)) as GetQRTransactionReceiptRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetQRTransactionReceiptRequest create() => GetQRTransactionReceiptRequest._();
  GetQRTransactionReceiptRequest createEmptyInstance() => create();
  static $pb.PbList<GetQRTransactionReceiptRequest> createRepeated() => $pb.PbList<GetQRTransactionReceiptRequest>();
  @$core.pragma('dart2js:noInline')
  static GetQRTransactionReceiptRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetQRTransactionReceiptRequest>(create);
  static GetQRTransactionReceiptRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get transactionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set transactionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTransactionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransactionId() => clearField(1);
}

class GetQRTransactionReceiptResponse extends $pb.GeneratedMessage {
  factory GetQRTransactionReceiptResponse({
    QRTransaction? transaction,
  }) {
    final $result = create();
    if (transaction != null) {
      $result.transaction = transaction;
    }
    return $result;
  }
  GetQRTransactionReceiptResponse._() : super();
  factory GetQRTransactionReceiptResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetQRTransactionReceiptResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetQRTransactionReceiptResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'qr_pay'), createEmptyInstance: create)
    ..aOM<QRTransaction>(1, _omitFieldNames ? '' : 'transaction', subBuilder: QRTransaction.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetQRTransactionReceiptResponse clone() => GetQRTransactionReceiptResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetQRTransactionReceiptResponse copyWith(void Function(GetQRTransactionReceiptResponse) updates) => super.copyWith((message) => updates(message as GetQRTransactionReceiptResponse)) as GetQRTransactionReceiptResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetQRTransactionReceiptResponse create() => GetQRTransactionReceiptResponse._();
  GetQRTransactionReceiptResponse createEmptyInstance() => create();
  static $pb.PbList<GetQRTransactionReceiptResponse> createRepeated() => $pb.PbList<GetQRTransactionReceiptResponse>();
  @$core.pragma('dart2js:noInline')
  static GetQRTransactionReceiptResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetQRTransactionReceiptResponse>(create);
  static GetQRTransactionReceiptResponse? _defaultInstance;

  @$pb.TagNumber(1)
  QRTransaction get transaction => $_getN(0);
  @$pb.TagNumber(1)
  set transaction(QRTransaction v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasTransaction() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransaction() => clearField(1);
  @$pb.TagNumber(1)
  QRTransaction ensureTransaction() => $_ensure(0);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
