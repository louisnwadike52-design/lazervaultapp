//
//  Generated code. Do not modify.
//  source: split_bill.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/timestamp.pb.dart' as $1;
import 'split_bill.pbenum.dart';

export 'split_bill.pbenum.dart';

class SplitBill extends $pb.GeneratedMessage {
  factory SplitBill({
    $core.String? id,
    $core.String? creatorId,
    $core.String? creatorUsername,
    $core.String? creatorName,
    $core.double? totalAmount,
    $core.double? creatorShare,
    $core.String? currency,
    $core.String? description,
    SplitMethod? splitMethod,
    SplitBillStatus? status,
    $core.String? reference,
    $core.int? totalParticipants,
    $core.int? paidCount,
    $core.double? paidAmount,
    $core.Iterable<SplitBillParticipant>? participants,
    $1.Timestamp? createdAt,
    $1.Timestamp? updatedAt,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (creatorId != null) {
      $result.creatorId = creatorId;
    }
    if (creatorUsername != null) {
      $result.creatorUsername = creatorUsername;
    }
    if (creatorName != null) {
      $result.creatorName = creatorName;
    }
    if (totalAmount != null) {
      $result.totalAmount = totalAmount;
    }
    if (creatorShare != null) {
      $result.creatorShare = creatorShare;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (description != null) {
      $result.description = description;
    }
    if (splitMethod != null) {
      $result.splitMethod = splitMethod;
    }
    if (status != null) {
      $result.status = status;
    }
    if (reference != null) {
      $result.reference = reference;
    }
    if (totalParticipants != null) {
      $result.totalParticipants = totalParticipants;
    }
    if (paidCount != null) {
      $result.paidCount = paidCount;
    }
    if (paidAmount != null) {
      $result.paidAmount = paidAmount;
    }
    if (participants != null) {
      $result.participants.addAll(participants);
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      $result.updatedAt = updatedAt;
    }
    return $result;
  }
  SplitBill._() : super();
  factory SplitBill.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SplitBill.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SplitBill', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'creatorId')
    ..aOS(3, _omitFieldNames ? '' : 'creatorUsername')
    ..aOS(4, _omitFieldNames ? '' : 'creatorName')
    ..a<$core.double>(5, _omitFieldNames ? '' : 'totalAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(6, _omitFieldNames ? '' : 'creatorShare', $pb.PbFieldType.OD)
    ..aOS(7, _omitFieldNames ? '' : 'currency')
    ..aOS(8, _omitFieldNames ? '' : 'description')
    ..e<SplitMethod>(9, _omitFieldNames ? '' : 'splitMethod', $pb.PbFieldType.OE, defaultOrMaker: SplitMethod.SPLIT_METHOD_EQUAL, valueOf: SplitMethod.valueOf, enumValues: SplitMethod.values)
    ..e<SplitBillStatus>(10, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: SplitBillStatus.SPLIT_BILL_STATUS_ACTIVE, valueOf: SplitBillStatus.valueOf, enumValues: SplitBillStatus.values)
    ..aOS(11, _omitFieldNames ? '' : 'reference')
    ..a<$core.int>(12, _omitFieldNames ? '' : 'totalParticipants', $pb.PbFieldType.O3)
    ..a<$core.int>(13, _omitFieldNames ? '' : 'paidCount', $pb.PbFieldType.O3)
    ..a<$core.double>(14, _omitFieldNames ? '' : 'paidAmount', $pb.PbFieldType.OD)
    ..pc<SplitBillParticipant>(15, _omitFieldNames ? '' : 'participants', $pb.PbFieldType.PM, subBuilder: SplitBillParticipant.create)
    ..aOM<$1.Timestamp>(16, _omitFieldNames ? '' : 'createdAt', subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(17, _omitFieldNames ? '' : 'updatedAt', subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SplitBill clone() => SplitBill()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SplitBill copyWith(void Function(SplitBill) updates) => super.copyWith((message) => updates(message as SplitBill)) as SplitBill;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SplitBill create() => SplitBill._();
  SplitBill createEmptyInstance() => create();
  static $pb.PbList<SplitBill> createRepeated() => $pb.PbList<SplitBill>();
  @$core.pragma('dart2js:noInline')
  static SplitBill getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SplitBill>(create);
  static SplitBill? _defaultInstance;

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
  $core.String get creatorUsername => $_getSZ(2);
  @$pb.TagNumber(3)
  set creatorUsername($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCreatorUsername() => $_has(2);
  @$pb.TagNumber(3)
  void clearCreatorUsername() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get creatorName => $_getSZ(3);
  @$pb.TagNumber(4)
  set creatorName($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCreatorName() => $_has(3);
  @$pb.TagNumber(4)
  void clearCreatorName() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get totalAmount => $_getN(4);
  @$pb.TagNumber(5)
  set totalAmount($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTotalAmount() => $_has(4);
  @$pb.TagNumber(5)
  void clearTotalAmount() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get creatorShare => $_getN(5);
  @$pb.TagNumber(6)
  set creatorShare($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasCreatorShare() => $_has(5);
  @$pb.TagNumber(6)
  void clearCreatorShare() => clearField(6);

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
  SplitMethod get splitMethod => $_getN(8);
  @$pb.TagNumber(9)
  set splitMethod(SplitMethod v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasSplitMethod() => $_has(8);
  @$pb.TagNumber(9)
  void clearSplitMethod() => clearField(9);

  @$pb.TagNumber(10)
  SplitBillStatus get status => $_getN(9);
  @$pb.TagNumber(10)
  set status(SplitBillStatus v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasStatus() => $_has(9);
  @$pb.TagNumber(10)
  void clearStatus() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get reference => $_getSZ(10);
  @$pb.TagNumber(11)
  set reference($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasReference() => $_has(10);
  @$pb.TagNumber(11)
  void clearReference() => clearField(11);

  @$pb.TagNumber(12)
  $core.int get totalParticipants => $_getIZ(11);
  @$pb.TagNumber(12)
  set totalParticipants($core.int v) { $_setSignedInt32(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasTotalParticipants() => $_has(11);
  @$pb.TagNumber(12)
  void clearTotalParticipants() => clearField(12);

  @$pb.TagNumber(13)
  $core.int get paidCount => $_getIZ(12);
  @$pb.TagNumber(13)
  set paidCount($core.int v) { $_setSignedInt32(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasPaidCount() => $_has(12);
  @$pb.TagNumber(13)
  void clearPaidCount() => clearField(13);

  @$pb.TagNumber(14)
  $core.double get paidAmount => $_getN(13);
  @$pb.TagNumber(14)
  set paidAmount($core.double v) { $_setDouble(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasPaidAmount() => $_has(13);
  @$pb.TagNumber(14)
  void clearPaidAmount() => clearField(14);

  @$pb.TagNumber(15)
  $core.List<SplitBillParticipant> get participants => $_getList(14);

  @$pb.TagNumber(16)
  $1.Timestamp get createdAt => $_getN(15);
  @$pb.TagNumber(16)
  set createdAt($1.Timestamp v) { setField(16, v); }
  @$pb.TagNumber(16)
  $core.bool hasCreatedAt() => $_has(15);
  @$pb.TagNumber(16)
  void clearCreatedAt() => clearField(16);
  @$pb.TagNumber(16)
  $1.Timestamp ensureCreatedAt() => $_ensure(15);

  @$pb.TagNumber(17)
  $1.Timestamp get updatedAt => $_getN(16);
  @$pb.TagNumber(17)
  set updatedAt($1.Timestamp v) { setField(17, v); }
  @$pb.TagNumber(17)
  $core.bool hasUpdatedAt() => $_has(16);
  @$pb.TagNumber(17)
  void clearUpdatedAt() => clearField(17);
  @$pb.TagNumber(17)
  $1.Timestamp ensureUpdatedAt() => $_ensure(16);
}

class SplitBillParticipant extends $pb.GeneratedMessage {
  factory SplitBillParticipant({
    $core.String? id,
    $core.String? splitBillId,
    $core.String? userId,
    $core.String? username,
    $core.String? displayName,
    $core.double? amount,
    $core.double? percentage,
    SplitBillParticipantStatus? status,
    $core.String? transactionReference,
    $1.Timestamp? paidAt,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (splitBillId != null) {
      $result.splitBillId = splitBillId;
    }
    if (userId != null) {
      $result.userId = userId;
    }
    if (username != null) {
      $result.username = username;
    }
    if (displayName != null) {
      $result.displayName = displayName;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (percentage != null) {
      $result.percentage = percentage;
    }
    if (status != null) {
      $result.status = status;
    }
    if (transactionReference != null) {
      $result.transactionReference = transactionReference;
    }
    if (paidAt != null) {
      $result.paidAt = paidAt;
    }
    return $result;
  }
  SplitBillParticipant._() : super();
  factory SplitBillParticipant.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SplitBillParticipant.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SplitBillParticipant', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'splitBillId')
    ..aOS(3, _omitFieldNames ? '' : 'userId')
    ..aOS(4, _omitFieldNames ? '' : 'username')
    ..aOS(5, _omitFieldNames ? '' : 'displayName')
    ..a<$core.double>(6, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..a<$core.double>(7, _omitFieldNames ? '' : 'percentage', $pb.PbFieldType.OD)
    ..e<SplitBillParticipantStatus>(8, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: SplitBillParticipantStatus.SPLIT_BILL_PARTICIPANT_STATUS_PENDING, valueOf: SplitBillParticipantStatus.valueOf, enumValues: SplitBillParticipantStatus.values)
    ..aOS(9, _omitFieldNames ? '' : 'transactionReference')
    ..aOM<$1.Timestamp>(10, _omitFieldNames ? '' : 'paidAt', subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SplitBillParticipant clone() => SplitBillParticipant()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SplitBillParticipant copyWith(void Function(SplitBillParticipant) updates) => super.copyWith((message) => updates(message as SplitBillParticipant)) as SplitBillParticipant;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SplitBillParticipant create() => SplitBillParticipant._();
  SplitBillParticipant createEmptyInstance() => create();
  static $pb.PbList<SplitBillParticipant> createRepeated() => $pb.PbList<SplitBillParticipant>();
  @$core.pragma('dart2js:noInline')
  static SplitBillParticipant getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SplitBillParticipant>(create);
  static SplitBillParticipant? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get splitBillId => $_getSZ(1);
  @$pb.TagNumber(2)
  set splitBillId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSplitBillId() => $_has(1);
  @$pb.TagNumber(2)
  void clearSplitBillId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get userId => $_getSZ(2);
  @$pb.TagNumber(3)
  set userId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasUserId() => $_has(2);
  @$pb.TagNumber(3)
  void clearUserId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get username => $_getSZ(3);
  @$pb.TagNumber(4)
  set username($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasUsername() => $_has(3);
  @$pb.TagNumber(4)
  void clearUsername() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get displayName => $_getSZ(4);
  @$pb.TagNumber(5)
  set displayName($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasDisplayName() => $_has(4);
  @$pb.TagNumber(5)
  void clearDisplayName() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get amount => $_getN(5);
  @$pb.TagNumber(6)
  set amount($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasAmount() => $_has(5);
  @$pb.TagNumber(6)
  void clearAmount() => clearField(6);

  @$pb.TagNumber(7)
  $core.double get percentage => $_getN(6);
  @$pb.TagNumber(7)
  set percentage($core.double v) { $_setDouble(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasPercentage() => $_has(6);
  @$pb.TagNumber(7)
  void clearPercentage() => clearField(7);

  @$pb.TagNumber(8)
  SplitBillParticipantStatus get status => $_getN(7);
  @$pb.TagNumber(8)
  set status(SplitBillParticipantStatus v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasStatus() => $_has(7);
  @$pb.TagNumber(8)
  void clearStatus() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get transactionReference => $_getSZ(8);
  @$pb.TagNumber(9)
  set transactionReference($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasTransactionReference() => $_has(8);
  @$pb.TagNumber(9)
  void clearTransactionReference() => clearField(9);

  @$pb.TagNumber(10)
  $1.Timestamp get paidAt => $_getN(9);
  @$pb.TagNumber(10)
  set paidAt($1.Timestamp v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasPaidAt() => $_has(9);
  @$pb.TagNumber(10)
  void clearPaidAt() => clearField(10);
  @$pb.TagNumber(10)
  $1.Timestamp ensurePaidAt() => $_ensure(9);
}

class SplitBillParticipantInput extends $pb.GeneratedMessage {
  factory SplitBillParticipantInput({
    $core.String? username,
    $core.double? amount,
    $core.double? percentage,
  }) {
    final $result = create();
    if (username != null) {
      $result.username = username;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (percentage != null) {
      $result.percentage = percentage;
    }
    return $result;
  }
  SplitBillParticipantInput._() : super();
  factory SplitBillParticipantInput.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SplitBillParticipantInput.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SplitBillParticipantInput', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'username')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'percentage', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SplitBillParticipantInput clone() => SplitBillParticipantInput()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SplitBillParticipantInput copyWith(void Function(SplitBillParticipantInput) updates) => super.copyWith((message) => updates(message as SplitBillParticipantInput)) as SplitBillParticipantInput;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SplitBillParticipantInput create() => SplitBillParticipantInput._();
  SplitBillParticipantInput createEmptyInstance() => create();
  static $pb.PbList<SplitBillParticipantInput> createRepeated() => $pb.PbList<SplitBillParticipantInput>();
  @$core.pragma('dart2js:noInline')
  static SplitBillParticipantInput getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SplitBillParticipantInput>(create);
  static SplitBillParticipantInput? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get username => $_getSZ(0);
  @$pb.TagNumber(1)
  set username($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUsername() => $_has(0);
  @$pb.TagNumber(1)
  void clearUsername() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get amount => $_getN(1);
  @$pb.TagNumber(2)
  set amount($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get percentage => $_getN(2);
  @$pb.TagNumber(3)
  set percentage($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPercentage() => $_has(2);
  @$pb.TagNumber(3)
  void clearPercentage() => clearField(3);
}

class SplitBillTransaction extends $pb.GeneratedMessage {
  factory SplitBillTransaction({
    $core.String? id,
    $core.String? payerId,
    $core.String? payerUsername,
    $core.String? payerName,
    $core.String? recipientId,
    $core.String? recipientUsername,
    $core.String? recipientName,
    $core.double? amount,
    $core.String? currency,
    $core.String? description,
    $core.String? status,
    $core.String? reference,
    $1.Timestamp? createdAt,
    $1.Timestamp? completedAt,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
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
    if (status != null) {
      $result.status = status;
    }
    if (reference != null) {
      $result.reference = reference;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    if (completedAt != null) {
      $result.completedAt = completedAt;
    }
    return $result;
  }
  SplitBillTransaction._() : super();
  factory SplitBillTransaction.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SplitBillTransaction.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SplitBillTransaction', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'payerId')
    ..aOS(3, _omitFieldNames ? '' : 'payerUsername')
    ..aOS(4, _omitFieldNames ? '' : 'payerName')
    ..aOS(5, _omitFieldNames ? '' : 'recipientId')
    ..aOS(6, _omitFieldNames ? '' : 'recipientUsername')
    ..aOS(7, _omitFieldNames ? '' : 'recipientName')
    ..a<$core.double>(8, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(9, _omitFieldNames ? '' : 'currency')
    ..aOS(10, _omitFieldNames ? '' : 'description')
    ..aOS(11, _omitFieldNames ? '' : 'status')
    ..aOS(12, _omitFieldNames ? '' : 'reference')
    ..aOM<$1.Timestamp>(13, _omitFieldNames ? '' : 'createdAt', subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(14, _omitFieldNames ? '' : 'completedAt', subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SplitBillTransaction clone() => SplitBillTransaction()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SplitBillTransaction copyWith(void Function(SplitBillTransaction) updates) => super.copyWith((message) => updates(message as SplitBillTransaction)) as SplitBillTransaction;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SplitBillTransaction create() => SplitBillTransaction._();
  SplitBillTransaction createEmptyInstance() => create();
  static $pb.PbList<SplitBillTransaction> createRepeated() => $pb.PbList<SplitBillTransaction>();
  @$core.pragma('dart2js:noInline')
  static SplitBillTransaction getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SplitBillTransaction>(create);
  static SplitBillTransaction? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get payerId => $_getSZ(1);
  @$pb.TagNumber(2)
  set payerId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPayerId() => $_has(1);
  @$pb.TagNumber(2)
  void clearPayerId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get payerUsername => $_getSZ(2);
  @$pb.TagNumber(3)
  set payerUsername($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPayerUsername() => $_has(2);
  @$pb.TagNumber(3)
  void clearPayerUsername() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get payerName => $_getSZ(3);
  @$pb.TagNumber(4)
  set payerName($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPayerName() => $_has(3);
  @$pb.TagNumber(4)
  void clearPayerName() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get recipientId => $_getSZ(4);
  @$pb.TagNumber(5)
  set recipientId($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasRecipientId() => $_has(4);
  @$pb.TagNumber(5)
  void clearRecipientId() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get recipientUsername => $_getSZ(5);
  @$pb.TagNumber(6)
  set recipientUsername($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasRecipientUsername() => $_has(5);
  @$pb.TagNumber(6)
  void clearRecipientUsername() => clearField(6);

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
  $core.String get description => $_getSZ(9);
  @$pb.TagNumber(10)
  set description($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasDescription() => $_has(9);
  @$pb.TagNumber(10)
  void clearDescription() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get status => $_getSZ(10);
  @$pb.TagNumber(11)
  set status($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasStatus() => $_has(10);
  @$pb.TagNumber(11)
  void clearStatus() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get reference => $_getSZ(11);
  @$pb.TagNumber(12)
  set reference($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasReference() => $_has(11);
  @$pb.TagNumber(12)
  void clearReference() => clearField(12);

  @$pb.TagNumber(13)
  $1.Timestamp get createdAt => $_getN(12);
  @$pb.TagNumber(13)
  set createdAt($1.Timestamp v) { setField(13, v); }
  @$pb.TagNumber(13)
  $core.bool hasCreatedAt() => $_has(12);
  @$pb.TagNumber(13)
  void clearCreatedAt() => clearField(13);
  @$pb.TagNumber(13)
  $1.Timestamp ensureCreatedAt() => $_ensure(12);

  @$pb.TagNumber(14)
  $1.Timestamp get completedAt => $_getN(13);
  @$pb.TagNumber(14)
  set completedAt($1.Timestamp v) { setField(14, v); }
  @$pb.TagNumber(14)
  $core.bool hasCompletedAt() => $_has(13);
  @$pb.TagNumber(14)
  void clearCompletedAt() => clearField(14);
  @$pb.TagNumber(14)
  $1.Timestamp ensureCompletedAt() => $_ensure(13);
}

class CreateSplitBillRequest extends $pb.GeneratedMessage {
  factory CreateSplitBillRequest({
    $core.double? totalAmount,
    $core.String? currency,
    $core.String? description,
    SplitMethod? splitMethod,
    $core.double? creatorShare,
    $core.Iterable<SplitBillParticipantInput>? participants,
  }) {
    final $result = create();
    if (totalAmount != null) {
      $result.totalAmount = totalAmount;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (description != null) {
      $result.description = description;
    }
    if (splitMethod != null) {
      $result.splitMethod = splitMethod;
    }
    if (creatorShare != null) {
      $result.creatorShare = creatorShare;
    }
    if (participants != null) {
      $result.participants.addAll(participants);
    }
    return $result;
  }
  CreateSplitBillRequest._() : super();
  factory CreateSplitBillRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateSplitBillRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateSplitBillRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'totalAmount', $pb.PbFieldType.OD)
    ..aOS(2, _omitFieldNames ? '' : 'currency')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..e<SplitMethod>(4, _omitFieldNames ? '' : 'splitMethod', $pb.PbFieldType.OE, defaultOrMaker: SplitMethod.SPLIT_METHOD_EQUAL, valueOf: SplitMethod.valueOf, enumValues: SplitMethod.values)
    ..a<$core.double>(5, _omitFieldNames ? '' : 'creatorShare', $pb.PbFieldType.OD)
    ..pc<SplitBillParticipantInput>(6, _omitFieldNames ? '' : 'participants', $pb.PbFieldType.PM, subBuilder: SplitBillParticipantInput.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateSplitBillRequest clone() => CreateSplitBillRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateSplitBillRequest copyWith(void Function(CreateSplitBillRequest) updates) => super.copyWith((message) => updates(message as CreateSplitBillRequest)) as CreateSplitBillRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateSplitBillRequest create() => CreateSplitBillRequest._();
  CreateSplitBillRequest createEmptyInstance() => create();
  static $pb.PbList<CreateSplitBillRequest> createRepeated() => $pb.PbList<CreateSplitBillRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateSplitBillRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateSplitBillRequest>(create);
  static CreateSplitBillRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get totalAmount => $_getN(0);
  @$pb.TagNumber(1)
  set totalAmount($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTotalAmount() => $_has(0);
  @$pb.TagNumber(1)
  void clearTotalAmount() => clearField(1);

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
  SplitMethod get splitMethod => $_getN(3);
  @$pb.TagNumber(4)
  set splitMethod(SplitMethod v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasSplitMethod() => $_has(3);
  @$pb.TagNumber(4)
  void clearSplitMethod() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get creatorShare => $_getN(4);
  @$pb.TagNumber(5)
  set creatorShare($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasCreatorShare() => $_has(4);
  @$pb.TagNumber(5)
  void clearCreatorShare() => clearField(5);

  @$pb.TagNumber(6)
  $core.List<SplitBillParticipantInput> get participants => $_getList(5);
}

class CreateSplitBillResponse extends $pb.GeneratedMessage {
  factory CreateSplitBillResponse({
    $core.bool? success,
    $core.String? message,
    SplitBill? splitBill,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (message != null) {
      $result.message = message;
    }
    if (splitBill != null) {
      $result.splitBill = splitBill;
    }
    return $result;
  }
  CreateSplitBillResponse._() : super();
  factory CreateSplitBillResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateSplitBillResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateSplitBillResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<SplitBill>(3, _omitFieldNames ? '' : 'splitBill', subBuilder: SplitBill.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateSplitBillResponse clone() => CreateSplitBillResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateSplitBillResponse copyWith(void Function(CreateSplitBillResponse) updates) => super.copyWith((message) => updates(message as CreateSplitBillResponse)) as CreateSplitBillResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateSplitBillResponse create() => CreateSplitBillResponse._();
  CreateSplitBillResponse createEmptyInstance() => create();
  static $pb.PbList<CreateSplitBillResponse> createRepeated() => $pb.PbList<CreateSplitBillResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateSplitBillResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateSplitBillResponse>(create);
  static CreateSplitBillResponse? _defaultInstance;

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
  SplitBill get splitBill => $_getN(2);
  @$pb.TagNumber(3)
  set splitBill(SplitBill v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasSplitBill() => $_has(2);
  @$pb.TagNumber(3)
  void clearSplitBill() => clearField(3);
  @$pb.TagNumber(3)
  SplitBill ensureSplitBill() => $_ensure(2);
}

class GetSplitBillRequest extends $pb.GeneratedMessage {
  factory GetSplitBillRequest({
    $core.String? splitBillId,
  }) {
    final $result = create();
    if (splitBillId != null) {
      $result.splitBillId = splitBillId;
    }
    return $result;
  }
  GetSplitBillRequest._() : super();
  factory GetSplitBillRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetSplitBillRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetSplitBillRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'splitBillId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetSplitBillRequest clone() => GetSplitBillRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetSplitBillRequest copyWith(void Function(GetSplitBillRequest) updates) => super.copyWith((message) => updates(message as GetSplitBillRequest)) as GetSplitBillRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSplitBillRequest create() => GetSplitBillRequest._();
  GetSplitBillRequest createEmptyInstance() => create();
  static $pb.PbList<GetSplitBillRequest> createRepeated() => $pb.PbList<GetSplitBillRequest>();
  @$core.pragma('dart2js:noInline')
  static GetSplitBillRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetSplitBillRequest>(create);
  static GetSplitBillRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get splitBillId => $_getSZ(0);
  @$pb.TagNumber(1)
  set splitBillId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSplitBillId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSplitBillId() => clearField(1);
}

class GetSplitBillResponse extends $pb.GeneratedMessage {
  factory GetSplitBillResponse({
    $core.bool? success,
    $core.String? message,
    SplitBill? splitBill,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (message != null) {
      $result.message = message;
    }
    if (splitBill != null) {
      $result.splitBill = splitBill;
    }
    return $result;
  }
  GetSplitBillResponse._() : super();
  factory GetSplitBillResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetSplitBillResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetSplitBillResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<SplitBill>(3, _omitFieldNames ? '' : 'splitBill', subBuilder: SplitBill.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetSplitBillResponse clone() => GetSplitBillResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetSplitBillResponse copyWith(void Function(GetSplitBillResponse) updates) => super.copyWith((message) => updates(message as GetSplitBillResponse)) as GetSplitBillResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSplitBillResponse create() => GetSplitBillResponse._();
  GetSplitBillResponse createEmptyInstance() => create();
  static $pb.PbList<GetSplitBillResponse> createRepeated() => $pb.PbList<GetSplitBillResponse>();
  @$core.pragma('dart2js:noInline')
  static GetSplitBillResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetSplitBillResponse>(create);
  static GetSplitBillResponse? _defaultInstance;

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
  SplitBill get splitBill => $_getN(2);
  @$pb.TagNumber(3)
  set splitBill(SplitBill v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasSplitBill() => $_has(2);
  @$pb.TagNumber(3)
  void clearSplitBill() => clearField(3);
  @$pb.TagNumber(3)
  SplitBill ensureSplitBill() => $_ensure(2);
}

class GetMySplitBillsRequest extends $pb.GeneratedMessage {
  factory GetMySplitBillsRequest({
    $core.int? page,
    $core.int? limit,
    SplitBillStatus? status,
  }) {
    final $result = create();
    if (page != null) {
      $result.page = page;
    }
    if (limit != null) {
      $result.limit = limit;
    }
    if (status != null) {
      $result.status = status;
    }
    return $result;
  }
  GetMySplitBillsRequest._() : super();
  factory GetMySplitBillsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMySplitBillsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetMySplitBillsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..e<SplitBillStatus>(3, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: SplitBillStatus.SPLIT_BILL_STATUS_ACTIVE, valueOf: SplitBillStatus.valueOf, enumValues: SplitBillStatus.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMySplitBillsRequest clone() => GetMySplitBillsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMySplitBillsRequest copyWith(void Function(GetMySplitBillsRequest) updates) => super.copyWith((message) => updates(message as GetMySplitBillsRequest)) as GetMySplitBillsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMySplitBillsRequest create() => GetMySplitBillsRequest._();
  GetMySplitBillsRequest createEmptyInstance() => create();
  static $pb.PbList<GetMySplitBillsRequest> createRepeated() => $pb.PbList<GetMySplitBillsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMySplitBillsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMySplitBillsRequest>(create);
  static GetMySplitBillsRequest? _defaultInstance;

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

  @$pb.TagNumber(3)
  SplitBillStatus get status => $_getN(2);
  @$pb.TagNumber(3)
  set status(SplitBillStatus v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasStatus() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatus() => clearField(3);
}

class GetSplitBillsResponse extends $pb.GeneratedMessage {
  factory GetSplitBillsResponse({
    $core.Iterable<SplitBill>? splitBills,
    $core.int? total,
    $core.int? page,
    $core.int? totalPages,
  }) {
    final $result = create();
    if (splitBills != null) {
      $result.splitBills.addAll(splitBills);
    }
    if (total != null) {
      $result.total = total;
    }
    if (page != null) {
      $result.page = page;
    }
    if (totalPages != null) {
      $result.totalPages = totalPages;
    }
    return $result;
  }
  GetSplitBillsResponse._() : super();
  factory GetSplitBillsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetSplitBillsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetSplitBillsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pc<SplitBill>(1, _omitFieldNames ? '' : 'splitBills', $pb.PbFieldType.PM, subBuilder: SplitBill.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'totalPages', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetSplitBillsResponse clone() => GetSplitBillsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetSplitBillsResponse copyWith(void Function(GetSplitBillsResponse) updates) => super.copyWith((message) => updates(message as GetSplitBillsResponse)) as GetSplitBillsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSplitBillsResponse create() => GetSplitBillsResponse._();
  GetSplitBillsResponse createEmptyInstance() => create();
  static $pb.PbList<GetSplitBillsResponse> createRepeated() => $pb.PbList<GetSplitBillsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetSplitBillsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetSplitBillsResponse>(create);
  static GetSplitBillsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<SplitBill> get splitBills => $_getList(0);

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
  $core.int get totalPages => $_getIZ(3);
  @$pb.TagNumber(4)
  set totalPages($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTotalPages() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalPages() => clearField(4);
}

class PaySplitBillShareRequest extends $pb.GeneratedMessage {
  factory PaySplitBillShareRequest({
    $core.String? splitBillId,
    $core.String? sourceAccountId,
    $core.String? transactionPin,
  }) {
    final $result = create();
    if (splitBillId != null) {
      $result.splitBillId = splitBillId;
    }
    if (sourceAccountId != null) {
      $result.sourceAccountId = sourceAccountId;
    }
    if (transactionPin != null) {
      $result.transactionPin = transactionPin;
    }
    return $result;
  }
  PaySplitBillShareRequest._() : super();
  factory PaySplitBillShareRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PaySplitBillShareRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PaySplitBillShareRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'splitBillId')
    ..aOS(2, _omitFieldNames ? '' : 'sourceAccountId')
    ..aOS(3, _omitFieldNames ? '' : 'transactionPin')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PaySplitBillShareRequest clone() => PaySplitBillShareRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PaySplitBillShareRequest copyWith(void Function(PaySplitBillShareRequest) updates) => super.copyWith((message) => updates(message as PaySplitBillShareRequest)) as PaySplitBillShareRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PaySplitBillShareRequest create() => PaySplitBillShareRequest._();
  PaySplitBillShareRequest createEmptyInstance() => create();
  static $pb.PbList<PaySplitBillShareRequest> createRepeated() => $pb.PbList<PaySplitBillShareRequest>();
  @$core.pragma('dart2js:noInline')
  static PaySplitBillShareRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PaySplitBillShareRequest>(create);
  static PaySplitBillShareRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get splitBillId => $_getSZ(0);
  @$pb.TagNumber(1)
  set splitBillId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSplitBillId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSplitBillId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get sourceAccountId => $_getSZ(1);
  @$pb.TagNumber(2)
  set sourceAccountId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSourceAccountId() => $_has(1);
  @$pb.TagNumber(2)
  void clearSourceAccountId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get transactionPin => $_getSZ(2);
  @$pb.TagNumber(3)
  set transactionPin($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTransactionPin() => $_has(2);
  @$pb.TagNumber(3)
  void clearTransactionPin() => clearField(3);
}

class PaySplitBillShareResponse extends $pb.GeneratedMessage {
  factory PaySplitBillShareResponse({
    $core.bool? success,
    $core.String? message,
    SplitBillTransaction? transaction,
    SplitBill? splitBill,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (message != null) {
      $result.message = message;
    }
    if (transaction != null) {
      $result.transaction = transaction;
    }
    if (splitBill != null) {
      $result.splitBill = splitBill;
    }
    return $result;
  }
  PaySplitBillShareResponse._() : super();
  factory PaySplitBillShareResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PaySplitBillShareResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PaySplitBillShareResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<SplitBillTransaction>(3, _omitFieldNames ? '' : 'transaction', subBuilder: SplitBillTransaction.create)
    ..aOM<SplitBill>(4, _omitFieldNames ? '' : 'splitBill', subBuilder: SplitBill.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PaySplitBillShareResponse clone() => PaySplitBillShareResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PaySplitBillShareResponse copyWith(void Function(PaySplitBillShareResponse) updates) => super.copyWith((message) => updates(message as PaySplitBillShareResponse)) as PaySplitBillShareResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PaySplitBillShareResponse create() => PaySplitBillShareResponse._();
  PaySplitBillShareResponse createEmptyInstance() => create();
  static $pb.PbList<PaySplitBillShareResponse> createRepeated() => $pb.PbList<PaySplitBillShareResponse>();
  @$core.pragma('dart2js:noInline')
  static PaySplitBillShareResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PaySplitBillShareResponse>(create);
  static PaySplitBillShareResponse? _defaultInstance;

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
  SplitBillTransaction get transaction => $_getN(2);
  @$pb.TagNumber(3)
  set transaction(SplitBillTransaction v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasTransaction() => $_has(2);
  @$pb.TagNumber(3)
  void clearTransaction() => clearField(3);
  @$pb.TagNumber(3)
  SplitBillTransaction ensureTransaction() => $_ensure(2);

  @$pb.TagNumber(4)
  SplitBill get splitBill => $_getN(3);
  @$pb.TagNumber(4)
  set splitBill(SplitBill v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasSplitBill() => $_has(3);
  @$pb.TagNumber(4)
  void clearSplitBill() => clearField(4);
  @$pb.TagNumber(4)
  SplitBill ensureSplitBill() => $_ensure(3);
}

class CancelSplitBillRequest extends $pb.GeneratedMessage {
  factory CancelSplitBillRequest({
    $core.String? splitBillId,
  }) {
    final $result = create();
    if (splitBillId != null) {
      $result.splitBillId = splitBillId;
    }
    return $result;
  }
  CancelSplitBillRequest._() : super();
  factory CancelSplitBillRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CancelSplitBillRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CancelSplitBillRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'splitBillId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CancelSplitBillRequest clone() => CancelSplitBillRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CancelSplitBillRequest copyWith(void Function(CancelSplitBillRequest) updates) => super.copyWith((message) => updates(message as CancelSplitBillRequest)) as CancelSplitBillRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CancelSplitBillRequest create() => CancelSplitBillRequest._();
  CancelSplitBillRequest createEmptyInstance() => create();
  static $pb.PbList<CancelSplitBillRequest> createRepeated() => $pb.PbList<CancelSplitBillRequest>();
  @$core.pragma('dart2js:noInline')
  static CancelSplitBillRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CancelSplitBillRequest>(create);
  static CancelSplitBillRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get splitBillId => $_getSZ(0);
  @$pb.TagNumber(1)
  set splitBillId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSplitBillId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSplitBillId() => clearField(1);
}

class CancelSplitBillResponse extends $pb.GeneratedMessage {
  factory CancelSplitBillResponse({
    $core.bool? success,
    $core.String? message,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  CancelSplitBillResponse._() : super();
  factory CancelSplitBillResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CancelSplitBillResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CancelSplitBillResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CancelSplitBillResponse clone() => CancelSplitBillResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CancelSplitBillResponse copyWith(void Function(CancelSplitBillResponse) updates) => super.copyWith((message) => updates(message as CancelSplitBillResponse)) as CancelSplitBillResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CancelSplitBillResponse create() => CancelSplitBillResponse._();
  CancelSplitBillResponse createEmptyInstance() => create();
  static $pb.PbList<CancelSplitBillResponse> createRepeated() => $pb.PbList<CancelSplitBillResponse>();
  @$core.pragma('dart2js:noInline')
  static CancelSplitBillResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CancelSplitBillResponse>(create);
  static CancelSplitBillResponse? _defaultInstance;

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

class DeclineSplitBillShareRequest extends $pb.GeneratedMessage {
  factory DeclineSplitBillShareRequest({
    $core.String? splitBillId,
    $core.String? reason,
  }) {
    final $result = create();
    if (splitBillId != null) {
      $result.splitBillId = splitBillId;
    }
    if (reason != null) {
      $result.reason = reason;
    }
    return $result;
  }
  DeclineSplitBillShareRequest._() : super();
  factory DeclineSplitBillShareRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeclineSplitBillShareRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DeclineSplitBillShareRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'splitBillId')
    ..aOS(2, _omitFieldNames ? '' : 'reason')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeclineSplitBillShareRequest clone() => DeclineSplitBillShareRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeclineSplitBillShareRequest copyWith(void Function(DeclineSplitBillShareRequest) updates) => super.copyWith((message) => updates(message as DeclineSplitBillShareRequest)) as DeclineSplitBillShareRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeclineSplitBillShareRequest create() => DeclineSplitBillShareRequest._();
  DeclineSplitBillShareRequest createEmptyInstance() => create();
  static $pb.PbList<DeclineSplitBillShareRequest> createRepeated() => $pb.PbList<DeclineSplitBillShareRequest>();
  @$core.pragma('dart2js:noInline')
  static DeclineSplitBillShareRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeclineSplitBillShareRequest>(create);
  static DeclineSplitBillShareRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get splitBillId => $_getSZ(0);
  @$pb.TagNumber(1)
  set splitBillId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSplitBillId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSplitBillId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get reason => $_getSZ(1);
  @$pb.TagNumber(2)
  set reason($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasReason() => $_has(1);
  @$pb.TagNumber(2)
  void clearReason() => clearField(2);
}

class DeclineSplitBillShareResponse extends $pb.GeneratedMessage {
  factory DeclineSplitBillShareResponse({
    $core.bool? success,
    $core.String? message,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  DeclineSplitBillShareResponse._() : super();
  factory DeclineSplitBillShareResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeclineSplitBillShareResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DeclineSplitBillShareResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeclineSplitBillShareResponse clone() => DeclineSplitBillShareResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeclineSplitBillShareResponse copyWith(void Function(DeclineSplitBillShareResponse) updates) => super.copyWith((message) => updates(message as DeclineSplitBillShareResponse)) as DeclineSplitBillShareResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeclineSplitBillShareResponse create() => DeclineSplitBillShareResponse._();
  DeclineSplitBillShareResponse createEmptyInstance() => create();
  static $pb.PbList<DeclineSplitBillShareResponse> createRepeated() => $pb.PbList<DeclineSplitBillShareResponse>();
  @$core.pragma('dart2js:noInline')
  static DeclineSplitBillShareResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeclineSplitBillShareResponse>(create);
  static DeclineSplitBillShareResponse? _defaultInstance;

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

class SendSplitBillReminderRequest extends $pb.GeneratedMessage {
  factory SendSplitBillReminderRequest({
    $core.String? splitBillId,
  }) {
    final $result = create();
    if (splitBillId != null) {
      $result.splitBillId = splitBillId;
    }
    return $result;
  }
  SendSplitBillReminderRequest._() : super();
  factory SendSplitBillReminderRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SendSplitBillReminderRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SendSplitBillReminderRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'splitBillId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SendSplitBillReminderRequest clone() => SendSplitBillReminderRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SendSplitBillReminderRequest copyWith(void Function(SendSplitBillReminderRequest) updates) => super.copyWith((message) => updates(message as SendSplitBillReminderRequest)) as SendSplitBillReminderRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SendSplitBillReminderRequest create() => SendSplitBillReminderRequest._();
  SendSplitBillReminderRequest createEmptyInstance() => create();
  static $pb.PbList<SendSplitBillReminderRequest> createRepeated() => $pb.PbList<SendSplitBillReminderRequest>();
  @$core.pragma('dart2js:noInline')
  static SendSplitBillReminderRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SendSplitBillReminderRequest>(create);
  static SendSplitBillReminderRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get splitBillId => $_getSZ(0);
  @$pb.TagNumber(1)
  set splitBillId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSplitBillId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSplitBillId() => clearField(1);
}

class SendSplitBillReminderResponse extends $pb.GeneratedMessage {
  factory SendSplitBillReminderResponse({
    $core.bool? success,
    $core.String? message,
    $core.int? remindersSent,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (message != null) {
      $result.message = message;
    }
    if (remindersSent != null) {
      $result.remindersSent = remindersSent;
    }
    return $result;
  }
  SendSplitBillReminderResponse._() : super();
  factory SendSplitBillReminderResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SendSplitBillReminderResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SendSplitBillReminderResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'remindersSent', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SendSplitBillReminderResponse clone() => SendSplitBillReminderResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SendSplitBillReminderResponse copyWith(void Function(SendSplitBillReminderResponse) updates) => super.copyWith((message) => updates(message as SendSplitBillReminderResponse)) as SendSplitBillReminderResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SendSplitBillReminderResponse create() => SendSplitBillReminderResponse._();
  SendSplitBillReminderResponse createEmptyInstance() => create();
  static $pb.PbList<SendSplitBillReminderResponse> createRepeated() => $pb.PbList<SendSplitBillReminderResponse>();
  @$core.pragma('dart2js:noInline')
  static SendSplitBillReminderResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SendSplitBillReminderResponse>(create);
  static SendSplitBillReminderResponse? _defaultInstance;

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
  $core.int get remindersSent => $_getIZ(2);
  @$pb.TagNumber(3)
  set remindersSent($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasRemindersSent() => $_has(2);
  @$pb.TagNumber(3)
  void clearRemindersSent() => clearField(3);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
