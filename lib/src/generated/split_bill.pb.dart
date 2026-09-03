// This is a generated file - do not edit.
//
// Generated from split_bill.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/timestamp.pb.dart' as $1;
import 'split_bill.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

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
    $core.String? receiverType,
    $core.String? receiverName,
    $core.String? receiverAccountMasked,
    $core.String? settlementStatus,
    $core.double? withdrawalFee,
    $core.String? title,
    $core.String? receiverBankName,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (creatorId != null) result.creatorId = creatorId;
    if (creatorUsername != null) result.creatorUsername = creatorUsername;
    if (creatorName != null) result.creatorName = creatorName;
    if (totalAmount != null) result.totalAmount = totalAmount;
    if (creatorShare != null) result.creatorShare = creatorShare;
    if (currency != null) result.currency = currency;
    if (description != null) result.description = description;
    if (splitMethod != null) result.splitMethod = splitMethod;
    if (status != null) result.status = status;
    if (reference != null) result.reference = reference;
    if (totalParticipants != null) result.totalParticipants = totalParticipants;
    if (paidCount != null) result.paidCount = paidCount;
    if (paidAmount != null) result.paidAmount = paidAmount;
    if (participants != null) result.participants.addAll(participants);
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    if (receiverType != null) result.receiverType = receiverType;
    if (receiverName != null) result.receiverName = receiverName;
    if (receiverAccountMasked != null)
      result.receiverAccountMasked = receiverAccountMasked;
    if (settlementStatus != null) result.settlementStatus = settlementStatus;
    if (withdrawalFee != null) result.withdrawalFee = withdrawalFee;
    if (title != null) result.title = title;
    if (receiverBankName != null) result.receiverBankName = receiverBankName;
    return result;
  }

  SplitBill._();

  factory SplitBill.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SplitBill.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SplitBill',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'split_bill'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'creatorId')
    ..aOS(3, _omitFieldNames ? '' : 'creatorUsername')
    ..aOS(4, _omitFieldNames ? '' : 'creatorName')
    ..a<$core.double>(
        5, _omitFieldNames ? '' : 'totalAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(
        6, _omitFieldNames ? '' : 'creatorShare', $pb.PbFieldType.OD)
    ..aOS(7, _omitFieldNames ? '' : 'currency')
    ..aOS(8, _omitFieldNames ? '' : 'description')
    ..e<SplitMethod>(
        9, _omitFieldNames ? '' : 'splitMethod', $pb.PbFieldType.OE,
        defaultOrMaker: SplitMethod.SPLIT_METHOD_EQUAL,
        valueOf: SplitMethod.valueOf,
        enumValues: SplitMethod.values)
    ..e<SplitBillStatus>(
        10, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: SplitBillStatus.SPLIT_BILL_STATUS_ACTIVE,
        valueOf: SplitBillStatus.valueOf,
        enumValues: SplitBillStatus.values)
    ..aOS(11, _omitFieldNames ? '' : 'reference')
    ..a<$core.int>(
        12, _omitFieldNames ? '' : 'totalParticipants', $pb.PbFieldType.O3)
    ..a<$core.int>(13, _omitFieldNames ? '' : 'paidCount', $pb.PbFieldType.O3)
    ..a<$core.double>(
        14, _omitFieldNames ? '' : 'paidAmount', $pb.PbFieldType.OD)
    ..pc<SplitBillParticipant>(
        15, _omitFieldNames ? '' : 'participants', $pb.PbFieldType.PM,
        subBuilder: SplitBillParticipant.create)
    ..aOM<$1.Timestamp>(16, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(17, _omitFieldNames ? '' : 'updatedAt',
        subBuilder: $1.Timestamp.create)
    ..aOS(18, _omitFieldNames ? '' : 'receiverType')
    ..aOS(19, _omitFieldNames ? '' : 'receiverName')
    ..aOS(20, _omitFieldNames ? '' : 'receiverAccountMasked')
    ..aOS(21, _omitFieldNames ? '' : 'settlementStatus')
    ..a<$core.double>(
        22, _omitFieldNames ? '' : 'withdrawalFee', $pb.PbFieldType.OD)
    ..aOS(23, _omitFieldNames ? '' : 'title')
    ..aOS(24, _omitFieldNames ? '' : 'receiverBankName')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SplitBill clone() => SplitBill()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SplitBill copyWith(void Function(SplitBill) updates) =>
      super.copyWith((message) => updates(message as SplitBill)) as SplitBill;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SplitBill create() => SplitBill._();
  @$core.override
  SplitBill createEmptyInstance() => create();
  static $pb.PbList<SplitBill> createRepeated() => $pb.PbList<SplitBill>();
  @$core.pragma('dart2js:noInline')
  static SplitBill getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SplitBill>(create);
  static SplitBill? _defaultInstance;

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
  $core.String get creatorUsername => $_getSZ(2);
  @$pb.TagNumber(3)
  set creatorUsername($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCreatorUsername() => $_has(2);
  @$pb.TagNumber(3)
  void clearCreatorUsername() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get creatorName => $_getSZ(3);
  @$pb.TagNumber(4)
  set creatorName($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCreatorName() => $_has(3);
  @$pb.TagNumber(4)
  void clearCreatorName() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get totalAmount => $_getN(4);
  @$pb.TagNumber(5)
  set totalAmount($core.double value) => $_setDouble(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTotalAmount() => $_has(4);
  @$pb.TagNumber(5)
  void clearTotalAmount() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.double get creatorShare => $_getN(5);
  @$pb.TagNumber(6)
  set creatorShare($core.double value) => $_setDouble(5, value);
  @$pb.TagNumber(6)
  $core.bool hasCreatorShare() => $_has(5);
  @$pb.TagNumber(6)
  void clearCreatorShare() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get currency => $_getSZ(6);
  @$pb.TagNumber(7)
  set currency($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasCurrency() => $_has(6);
  @$pb.TagNumber(7)
  void clearCurrency() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get description => $_getSZ(7);
  @$pb.TagNumber(8)
  set description($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasDescription() => $_has(7);
  @$pb.TagNumber(8)
  void clearDescription() => $_clearField(8);

  @$pb.TagNumber(9)
  SplitMethod get splitMethod => $_getN(8);
  @$pb.TagNumber(9)
  set splitMethod(SplitMethod value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasSplitMethod() => $_has(8);
  @$pb.TagNumber(9)
  void clearSplitMethod() => $_clearField(9);

  @$pb.TagNumber(10)
  SplitBillStatus get status => $_getN(9);
  @$pb.TagNumber(10)
  set status(SplitBillStatus value) => $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasStatus() => $_has(9);
  @$pb.TagNumber(10)
  void clearStatus() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get reference => $_getSZ(10);
  @$pb.TagNumber(11)
  set reference($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasReference() => $_has(10);
  @$pb.TagNumber(11)
  void clearReference() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.int get totalParticipants => $_getIZ(11);
  @$pb.TagNumber(12)
  set totalParticipants($core.int value) => $_setSignedInt32(11, value);
  @$pb.TagNumber(12)
  $core.bool hasTotalParticipants() => $_has(11);
  @$pb.TagNumber(12)
  void clearTotalParticipants() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.int get paidCount => $_getIZ(12);
  @$pb.TagNumber(13)
  set paidCount($core.int value) => $_setSignedInt32(12, value);
  @$pb.TagNumber(13)
  $core.bool hasPaidCount() => $_has(12);
  @$pb.TagNumber(13)
  void clearPaidCount() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.double get paidAmount => $_getN(13);
  @$pb.TagNumber(14)
  set paidAmount($core.double value) => $_setDouble(13, value);
  @$pb.TagNumber(14)
  $core.bool hasPaidAmount() => $_has(13);
  @$pb.TagNumber(14)
  void clearPaidAmount() => $_clearField(14);

  @$pb.TagNumber(15)
  $pb.PbList<SplitBillParticipant> get participants => $_getList(14);

  @$pb.TagNumber(16)
  $1.Timestamp get createdAt => $_getN(15);
  @$pb.TagNumber(16)
  set createdAt($1.Timestamp value) => $_setField(16, value);
  @$pb.TagNumber(16)
  $core.bool hasCreatedAt() => $_has(15);
  @$pb.TagNumber(16)
  void clearCreatedAt() => $_clearField(16);
  @$pb.TagNumber(16)
  $1.Timestamp ensureCreatedAt() => $_ensure(15);

  @$pb.TagNumber(17)
  $1.Timestamp get updatedAt => $_getN(16);
  @$pb.TagNumber(17)
  set updatedAt($1.Timestamp value) => $_setField(17, value);
  @$pb.TagNumber(17)
  $core.bool hasUpdatedAt() => $_has(16);
  @$pb.TagNumber(17)
  void clearUpdatedAt() => $_clearField(17);
  @$pb.TagNumber(17)
  $1.Timestamp ensureUpdatedAt() => $_ensure(16);

  /// Receiver (third-party payee). receiver_type: "" (legacy → creator),
  /// "internal_user", or "external_bank". co-payers pay their share TO this receiver.
  @$pb.TagNumber(18)
  $core.String get receiverType => $_getSZ(17);
  @$pb.TagNumber(18)
  set receiverType($core.String value) => $_setString(17, value);
  @$pb.TagNumber(18)
  $core.bool hasReceiverType() => $_has(17);
  @$pb.TagNumber(18)
  void clearReceiverType() => $_clearField(18);

  @$pb.TagNumber(19)
  $core.String get receiverName => $_getSZ(18);
  @$pb.TagNumber(19)
  set receiverName($core.String value) => $_setString(18, value);
  @$pb.TagNumber(19)
  $core.bool hasReceiverName() => $_has(18);
  @$pb.TagNumber(19)
  void clearReceiverName() => $_clearField(19);

  @$pb.TagNumber(20)
  $core.String get receiverAccountMasked => $_getSZ(19);
  @$pb.TagNumber(20)
  set receiverAccountMasked($core.String value) => $_setString(19, value);
  @$pb.TagNumber(20)
  $core.bool hasReceiverAccountMasked() => $_has(19);
  @$pb.TagNumber(20)
  void clearReceiverAccountMasked() => $_clearField(20);

  @$pb.TagNumber(21)
  $core.String get settlementStatus => $_getSZ(20);
  @$pb.TagNumber(21)
  set settlementStatus($core.String value) => $_setString(20, value);
  @$pb.TagNumber(21)
  $core.bool hasSettlementStatus() => $_has(20);
  @$pb.TagNumber(21)
  void clearSettlementStatus() => $_clearField(21);

  @$pb.TagNumber(22)
  $core.double get withdrawalFee => $_getN(21);
  @$pb.TagNumber(22)
  set withdrawalFee($core.double value) => $_setDouble(21, value);
  @$pb.TagNumber(22)
  $core.bool hasWithdrawalFee() => $_has(21);
  @$pb.TagNumber(22)
  void clearWithdrawalFee() => $_clearField(22);

  @$pb.TagNumber(23)
  $core.String get title => $_getSZ(22);
  @$pb.TagNumber(23)
  set title($core.String value) => $_setString(22, value);
  @$pb.TagNumber(23)
  $core.bool hasTitle() => $_has(22);
  @$pb.TagNumber(23)
  void clearTitle() => $_clearField(23);

  /// Destination bank for an external_bank receiver, snapshotted at creation.
  /// Without it a receipt can only say "Paid to <name> •••• 1234", which does not
  /// identify where the money went — the same name and last-4 can exist at two
  /// banks, and a dispute is resolved on the bank. Empty for internal/legacy.
  @$pb.TagNumber(24)
  $core.String get receiverBankName => $_getSZ(23);
  @$pb.TagNumber(24)
  set receiverBankName($core.String value) => $_setString(23, value);
  @$pb.TagNumber(24)
  $core.bool hasReceiverBankName() => $_has(23);
  @$pb.TagNumber(24)
  void clearReceiverBankName() => $_clearField(24);
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
    $core.bool? isCreator,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (splitBillId != null) result.splitBillId = splitBillId;
    if (userId != null) result.userId = userId;
    if (username != null) result.username = username;
    if (displayName != null) result.displayName = displayName;
    if (amount != null) result.amount = amount;
    if (percentage != null) result.percentage = percentage;
    if (status != null) result.status = status;
    if (transactionReference != null)
      result.transactionReference = transactionReference;
    if (paidAt != null) result.paidAt = paidAt;
    if (isCreator != null) result.isCreator = isCreator;
    return result;
  }

  SplitBillParticipant._();

  factory SplitBillParticipant.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SplitBillParticipant.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SplitBillParticipant',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'split_bill'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'splitBillId')
    ..aOS(3, _omitFieldNames ? '' : 'userId')
    ..aOS(4, _omitFieldNames ? '' : 'username')
    ..aOS(5, _omitFieldNames ? '' : 'displayName')
    ..a<$core.double>(6, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..a<$core.double>(
        7, _omitFieldNames ? '' : 'percentage', $pb.PbFieldType.OD)
    ..e<SplitBillParticipantStatus>(
        8, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker:
            SplitBillParticipantStatus.SPLIT_BILL_PARTICIPANT_STATUS_PENDING,
        valueOf: SplitBillParticipantStatus.valueOf,
        enumValues: SplitBillParticipantStatus.values)
    ..aOS(9, _omitFieldNames ? '' : 'transactionReference')
    ..aOM<$1.Timestamp>(10, _omitFieldNames ? '' : 'paidAt',
        subBuilder: $1.Timestamp.create)
    ..aOB(11, _omitFieldNames ? '' : 'isCreator')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SplitBillParticipant clone() =>
      SplitBillParticipant()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SplitBillParticipant copyWith(void Function(SplitBillParticipant) updates) =>
      super.copyWith((message) => updates(message as SplitBillParticipant))
          as SplitBillParticipant;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SplitBillParticipant create() => SplitBillParticipant._();
  @$core.override
  SplitBillParticipant createEmptyInstance() => create();
  static $pb.PbList<SplitBillParticipant> createRepeated() =>
      $pb.PbList<SplitBillParticipant>();
  @$core.pragma('dart2js:noInline')
  static SplitBillParticipant getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SplitBillParticipant>(create);
  static SplitBillParticipant? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get splitBillId => $_getSZ(1);
  @$pb.TagNumber(2)
  set splitBillId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSplitBillId() => $_has(1);
  @$pb.TagNumber(2)
  void clearSplitBillId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get userId => $_getSZ(2);
  @$pb.TagNumber(3)
  set userId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasUserId() => $_has(2);
  @$pb.TagNumber(3)
  void clearUserId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get username => $_getSZ(3);
  @$pb.TagNumber(4)
  set username($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasUsername() => $_has(3);
  @$pb.TagNumber(4)
  void clearUsername() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get displayName => $_getSZ(4);
  @$pb.TagNumber(5)
  set displayName($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasDisplayName() => $_has(4);
  @$pb.TagNumber(5)
  void clearDisplayName() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.double get amount => $_getN(5);
  @$pb.TagNumber(6)
  set amount($core.double value) => $_setDouble(5, value);
  @$pb.TagNumber(6)
  $core.bool hasAmount() => $_has(5);
  @$pb.TagNumber(6)
  void clearAmount() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.double get percentage => $_getN(6);
  @$pb.TagNumber(7)
  set percentage($core.double value) => $_setDouble(6, value);
  @$pb.TagNumber(7)
  $core.bool hasPercentage() => $_has(6);
  @$pb.TagNumber(7)
  void clearPercentage() => $_clearField(7);

  @$pb.TagNumber(8)
  SplitBillParticipantStatus get status => $_getN(7);
  @$pb.TagNumber(8)
  set status(SplitBillParticipantStatus value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasStatus() => $_has(7);
  @$pb.TagNumber(8)
  void clearStatus() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get transactionReference => $_getSZ(8);
  @$pb.TagNumber(9)
  set transactionReference($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasTransactionReference() => $_has(8);
  @$pb.TagNumber(9)
  void clearTransactionReference() => $_clearField(9);

  @$pb.TagNumber(10)
  $1.Timestamp get paidAt => $_getN(9);
  @$pb.TagNumber(10)
  set paidAt($1.Timestamp value) => $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasPaidAt() => $_has(9);
  @$pb.TagNumber(10)
  void clearPaidAt() => $_clearField(10);
  @$pb.TagNumber(10)
  $1.Timestamp ensurePaidAt() => $_ensure(9);

  @$pb.TagNumber(11)
  $core.bool get isCreator => $_getBF(10);
  @$pb.TagNumber(11)
  set isCreator($core.bool value) => $_setBool(10, value);
  @$pb.TagNumber(11)
  $core.bool hasIsCreator() => $_has(10);
  @$pb.TagNumber(11)
  void clearIsCreator() => $_clearField(11);
}

class SplitBillParticipantInput extends $pb.GeneratedMessage {
  factory SplitBillParticipantInput({
    $core.String? username,
    $core.double? amount,
    $core.double? percentage,
    $core.String? userId,
    $core.String? displayName,
  }) {
    final result = create();
    if (username != null) result.username = username;
    if (amount != null) result.amount = amount;
    if (percentage != null) result.percentage = percentage;
    if (userId != null) result.userId = userId;
    if (displayName != null) result.displayName = displayName;
    return result;
  }

  SplitBillParticipantInput._();

  factory SplitBillParticipantInput.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SplitBillParticipantInput.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SplitBillParticipantInput',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'split_bill'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'username')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..a<$core.double>(
        3, _omitFieldNames ? '' : 'percentage', $pb.PbFieldType.OD)
    ..aOS(4, _omitFieldNames ? '' : 'userId')
    ..aOS(5, _omitFieldNames ? '' : 'displayName')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SplitBillParticipantInput clone() =>
      SplitBillParticipantInput()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SplitBillParticipantInput copyWith(
          void Function(SplitBillParticipantInput) updates) =>
      super.copyWith((message) => updates(message as SplitBillParticipantInput))
          as SplitBillParticipantInput;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SplitBillParticipantInput create() => SplitBillParticipantInput._();
  @$core.override
  SplitBillParticipantInput createEmptyInstance() => create();
  static $pb.PbList<SplitBillParticipantInput> createRepeated() =>
      $pb.PbList<SplitBillParticipantInput>();
  @$core.pragma('dart2js:noInline')
  static SplitBillParticipantInput getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SplitBillParticipantInput>(create);
  static SplitBillParticipantInput? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get username => $_getSZ(0);
  @$pb.TagNumber(1)
  set username($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUsername() => $_has(0);
  @$pb.TagNumber(1)
  void clearUsername() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get amount => $_getN(1);
  @$pb.TagNumber(2)
  set amount($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get percentage => $_getN(2);
  @$pb.TagNumber(3)
  set percentage($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPercentage() => $_has(2);
  @$pb.TagNumber(3)
  void clearPercentage() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get userId => $_getSZ(3);
  @$pb.TagNumber(4)
  set userId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasUserId() => $_has(3);
  @$pb.TagNumber(4)
  void clearUserId() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get displayName => $_getSZ(4);
  @$pb.TagNumber(5)
  set displayName($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasDisplayName() => $_has(4);
  @$pb.TagNumber(5)
  void clearDisplayName() => $_clearField(5);
}

/// ReceiverInput selects where co-payers' money goes. When absent, the receiver
/// defaults to the creator (legacy behaviour).
class ReceiverInput extends $pb.GeneratedMessage {
  factory ReceiverInput({
    $core.String? type,
    $core.String? username,
    $core.String? bankCode,
    $core.String? accountNumber,
    $core.String? userId,
    $core.String? displayName,
    $core.String? bankName,
  }) {
    final result = create();
    if (type != null) result.type = type;
    if (username != null) result.username = username;
    if (bankCode != null) result.bankCode = bankCode;
    if (accountNumber != null) result.accountNumber = accountNumber;
    if (userId != null) result.userId = userId;
    if (displayName != null) result.displayName = displayName;
    if (bankName != null) result.bankName = bankName;
    return result;
  }

  ReceiverInput._();

  factory ReceiverInput.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ReceiverInput.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ReceiverInput',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'split_bill'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'type')
    ..aOS(2, _omitFieldNames ? '' : 'username')
    ..aOS(3, _omitFieldNames ? '' : 'bankCode')
    ..aOS(4, _omitFieldNames ? '' : 'accountNumber')
    ..aOS(5, _omitFieldNames ? '' : 'userId')
    ..aOS(6, _omitFieldNames ? '' : 'displayName')
    ..aOS(7, _omitFieldNames ? '' : 'bankName')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReceiverInput clone() => ReceiverInput()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReceiverInput copyWith(void Function(ReceiverInput) updates) =>
      super.copyWith((message) => updates(message as ReceiverInput))
          as ReceiverInput;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ReceiverInput create() => ReceiverInput._();
  @$core.override
  ReceiverInput createEmptyInstance() => create();
  static $pb.PbList<ReceiverInput> createRepeated() =>
      $pb.PbList<ReceiverInput>();
  @$core.pragma('dart2js:noInline')
  static ReceiverInput getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ReceiverInput>(create);
  static ReceiverInput? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get type => $_getSZ(0);
  @$pb.TagNumber(1)
  set type($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get username => $_getSZ(1);
  @$pb.TagNumber(2)
  set username($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUsername() => $_has(1);
  @$pb.TagNumber(2)
  void clearUsername() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get bankCode => $_getSZ(2);
  @$pb.TagNumber(3)
  set bankCode($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasBankCode() => $_has(2);
  @$pb.TagNumber(3)
  void clearBankCode() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get accountNumber => $_getSZ(3);
  @$pb.TagNumber(4)
  set accountNumber($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAccountNumber() => $_has(3);
  @$pb.TagNumber(4)
  void clearAccountNumber() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get userId => $_getSZ(4);
  @$pb.TagNumber(5)
  set userId($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasUserId() => $_has(4);
  @$pb.TagNumber(5)
  void clearUserId() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get displayName => $_getSZ(5);
  @$pb.TagNumber(6)
  set displayName($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasDisplayName() => $_has(5);
  @$pb.TagNumber(6)
  void clearDisplayName() => $_clearField(6);

  /// external_bank: display label for bank_code. The client already has it from
  /// the bank picker; sending it avoids a bank-directory lookup server-side.
  /// Untrusted display data — never used for routing, which uses bank_code.
  @$pb.TagNumber(7)
  $core.String get bankName => $_getSZ(6);
  @$pb.TagNumber(7)
  set bankName($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasBankName() => $_has(6);
  @$pb.TagNumber(7)
  void clearBankName() => $_clearField(7);
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
    final result = create();
    if (id != null) result.id = id;
    if (payerId != null) result.payerId = payerId;
    if (payerUsername != null) result.payerUsername = payerUsername;
    if (payerName != null) result.payerName = payerName;
    if (recipientId != null) result.recipientId = recipientId;
    if (recipientUsername != null) result.recipientUsername = recipientUsername;
    if (recipientName != null) result.recipientName = recipientName;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    if (description != null) result.description = description;
    if (status != null) result.status = status;
    if (reference != null) result.reference = reference;
    if (createdAt != null) result.createdAt = createdAt;
    if (completedAt != null) result.completedAt = completedAt;
    return result;
  }

  SplitBillTransaction._();

  factory SplitBillTransaction.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SplitBillTransaction.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SplitBillTransaction',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'split_bill'),
      createEmptyInstance: create)
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
    ..aOM<$1.Timestamp>(13, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(14, _omitFieldNames ? '' : 'completedAt',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SplitBillTransaction clone() =>
      SplitBillTransaction()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SplitBillTransaction copyWith(void Function(SplitBillTransaction) updates) =>
      super.copyWith((message) => updates(message as SplitBillTransaction))
          as SplitBillTransaction;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SplitBillTransaction create() => SplitBillTransaction._();
  @$core.override
  SplitBillTransaction createEmptyInstance() => create();
  static $pb.PbList<SplitBillTransaction> createRepeated() =>
      $pb.PbList<SplitBillTransaction>();
  @$core.pragma('dart2js:noInline')
  static SplitBillTransaction getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SplitBillTransaction>(create);
  static SplitBillTransaction? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get payerId => $_getSZ(1);
  @$pb.TagNumber(2)
  set payerId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPayerId() => $_has(1);
  @$pb.TagNumber(2)
  void clearPayerId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get payerUsername => $_getSZ(2);
  @$pb.TagNumber(3)
  set payerUsername($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPayerUsername() => $_has(2);
  @$pb.TagNumber(3)
  void clearPayerUsername() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get payerName => $_getSZ(3);
  @$pb.TagNumber(4)
  set payerName($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPayerName() => $_has(3);
  @$pb.TagNumber(4)
  void clearPayerName() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get recipientId => $_getSZ(4);
  @$pb.TagNumber(5)
  set recipientId($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasRecipientId() => $_has(4);
  @$pb.TagNumber(5)
  void clearRecipientId() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get recipientUsername => $_getSZ(5);
  @$pb.TagNumber(6)
  set recipientUsername($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasRecipientUsername() => $_has(5);
  @$pb.TagNumber(6)
  void clearRecipientUsername() => $_clearField(6);

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
  $core.String get description => $_getSZ(9);
  @$pb.TagNumber(10)
  set description($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasDescription() => $_has(9);
  @$pb.TagNumber(10)
  void clearDescription() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get status => $_getSZ(10);
  @$pb.TagNumber(11)
  set status($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasStatus() => $_has(10);
  @$pb.TagNumber(11)
  void clearStatus() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get reference => $_getSZ(11);
  @$pb.TagNumber(12)
  set reference($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasReference() => $_has(11);
  @$pb.TagNumber(12)
  void clearReference() => $_clearField(12);

  @$pb.TagNumber(13)
  $1.Timestamp get createdAt => $_getN(12);
  @$pb.TagNumber(13)
  set createdAt($1.Timestamp value) => $_setField(13, value);
  @$pb.TagNumber(13)
  $core.bool hasCreatedAt() => $_has(12);
  @$pb.TagNumber(13)
  void clearCreatedAt() => $_clearField(13);
  @$pb.TagNumber(13)
  $1.Timestamp ensureCreatedAt() => $_ensure(12);

  @$pb.TagNumber(14)
  $1.Timestamp get completedAt => $_getN(13);
  @$pb.TagNumber(14)
  set completedAt($1.Timestamp value) => $_setField(14, value);
  @$pb.TagNumber(14)
  $core.bool hasCompletedAt() => $_has(13);
  @$pb.TagNumber(14)
  void clearCompletedAt() => $_clearField(14);
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
    ReceiverInput? receiver,
    $core.bool? includeSelfAsCopayer,
    $core.String? title,
  }) {
    final result = create();
    if (totalAmount != null) result.totalAmount = totalAmount;
    if (currency != null) result.currency = currency;
    if (description != null) result.description = description;
    if (splitMethod != null) result.splitMethod = splitMethod;
    if (creatorShare != null) result.creatorShare = creatorShare;
    if (participants != null) result.participants.addAll(participants);
    if (receiver != null) result.receiver = receiver;
    if (includeSelfAsCopayer != null)
      result.includeSelfAsCopayer = includeSelfAsCopayer;
    if (title != null) result.title = title;
    return result;
  }

  CreateSplitBillRequest._();

  factory CreateSplitBillRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateSplitBillRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateSplitBillRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'split_bill'),
      createEmptyInstance: create)
    ..a<$core.double>(
        1, _omitFieldNames ? '' : 'totalAmount', $pb.PbFieldType.OD)
    ..aOS(2, _omitFieldNames ? '' : 'currency')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..e<SplitMethod>(
        4, _omitFieldNames ? '' : 'splitMethod', $pb.PbFieldType.OE,
        defaultOrMaker: SplitMethod.SPLIT_METHOD_EQUAL,
        valueOf: SplitMethod.valueOf,
        enumValues: SplitMethod.values)
    ..a<$core.double>(
        5, _omitFieldNames ? '' : 'creatorShare', $pb.PbFieldType.OD)
    ..pc<SplitBillParticipantInput>(
        6, _omitFieldNames ? '' : 'participants', $pb.PbFieldType.PM,
        subBuilder: SplitBillParticipantInput.create)
    ..aOM<ReceiverInput>(7, _omitFieldNames ? '' : 'receiver',
        subBuilder: ReceiverInput.create)
    ..aOB(8, _omitFieldNames ? '' : 'includeSelfAsCopayer')
    ..aOS(9, _omitFieldNames ? '' : 'title')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateSplitBillRequest clone() =>
      CreateSplitBillRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateSplitBillRequest copyWith(
          void Function(CreateSplitBillRequest) updates) =>
      super.copyWith((message) => updates(message as CreateSplitBillRequest))
          as CreateSplitBillRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateSplitBillRequest create() => CreateSplitBillRequest._();
  @$core.override
  CreateSplitBillRequest createEmptyInstance() => create();
  static $pb.PbList<CreateSplitBillRequest> createRepeated() =>
      $pb.PbList<CreateSplitBillRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateSplitBillRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateSplitBillRequest>(create);
  static CreateSplitBillRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get totalAmount => $_getN(0);
  @$pb.TagNumber(1)
  set totalAmount($core.double value) => $_setDouble(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTotalAmount() => $_has(0);
  @$pb.TagNumber(1)
  void clearTotalAmount() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get currency => $_getSZ(1);
  @$pb.TagNumber(2)
  set currency($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCurrency() => $_has(1);
  @$pb.TagNumber(2)
  void clearCurrency() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => $_clearField(3);

  @$pb.TagNumber(4)
  SplitMethod get splitMethod => $_getN(3);
  @$pb.TagNumber(4)
  set splitMethod(SplitMethod value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasSplitMethod() => $_has(3);
  @$pb.TagNumber(4)
  void clearSplitMethod() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get creatorShare => $_getN(4);
  @$pb.TagNumber(5)
  set creatorShare($core.double value) => $_setDouble(4, value);
  @$pb.TagNumber(5)
  $core.bool hasCreatorShare() => $_has(4);
  @$pb.TagNumber(5)
  void clearCreatorShare() => $_clearField(5);

  @$pb.TagNumber(6)
  $pb.PbList<SplitBillParticipantInput> get participants => $_getList(5);

  @$pb.TagNumber(7)
  ReceiverInput get receiver => $_getN(6);
  @$pb.TagNumber(7)
  set receiver(ReceiverInput value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasReceiver() => $_has(6);
  @$pb.TagNumber(7)
  void clearReceiver() => $_clearField(7);
  @$pb.TagNumber(7)
  ReceiverInput ensureReceiver() => $_ensure(6);

  @$pb.TagNumber(8)
  $core.bool get includeSelfAsCopayer => $_getBF(7);
  @$pb.TagNumber(8)
  set includeSelfAsCopayer($core.bool value) => $_setBool(7, value);
  @$pb.TagNumber(8)
  $core.bool hasIncludeSelfAsCopayer() => $_has(7);
  @$pb.TagNumber(8)
  void clearIncludeSelfAsCopayer() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get title => $_getSZ(8);
  @$pb.TagNumber(9)
  set title($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasTitle() => $_has(8);
  @$pb.TagNumber(9)
  void clearTitle() => $_clearField(9);
}

class CreateSplitBillResponse extends $pb.GeneratedMessage {
  factory CreateSplitBillResponse({
    $core.bool? success,
    $core.String? message,
    SplitBill? splitBill,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (splitBill != null) result.splitBill = splitBill;
    return result;
  }

  CreateSplitBillResponse._();

  factory CreateSplitBillResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateSplitBillResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateSplitBillResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'split_bill'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<SplitBill>(3, _omitFieldNames ? '' : 'splitBill',
        subBuilder: SplitBill.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateSplitBillResponse clone() =>
      CreateSplitBillResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateSplitBillResponse copyWith(
          void Function(CreateSplitBillResponse) updates) =>
      super.copyWith((message) => updates(message as CreateSplitBillResponse))
          as CreateSplitBillResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateSplitBillResponse create() => CreateSplitBillResponse._();
  @$core.override
  CreateSplitBillResponse createEmptyInstance() => create();
  static $pb.PbList<CreateSplitBillResponse> createRepeated() =>
      $pb.PbList<CreateSplitBillResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateSplitBillResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateSplitBillResponse>(create);
  static CreateSplitBillResponse? _defaultInstance;

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
  SplitBill get splitBill => $_getN(2);
  @$pb.TagNumber(3)
  set splitBill(SplitBill value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasSplitBill() => $_has(2);
  @$pb.TagNumber(3)
  void clearSplitBill() => $_clearField(3);
  @$pb.TagNumber(3)
  SplitBill ensureSplitBill() => $_ensure(2);
}

class GetSplitBillRequest extends $pb.GeneratedMessage {
  factory GetSplitBillRequest({
    $core.String? splitBillId,
  }) {
    final result = create();
    if (splitBillId != null) result.splitBillId = splitBillId;
    return result;
  }

  GetSplitBillRequest._();

  factory GetSplitBillRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetSplitBillRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetSplitBillRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'split_bill'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'splitBillId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSplitBillRequest clone() => GetSplitBillRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSplitBillRequest copyWith(void Function(GetSplitBillRequest) updates) =>
      super.copyWith((message) => updates(message as GetSplitBillRequest))
          as GetSplitBillRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSplitBillRequest create() => GetSplitBillRequest._();
  @$core.override
  GetSplitBillRequest createEmptyInstance() => create();
  static $pb.PbList<GetSplitBillRequest> createRepeated() =>
      $pb.PbList<GetSplitBillRequest>();
  @$core.pragma('dart2js:noInline')
  static GetSplitBillRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetSplitBillRequest>(create);
  static GetSplitBillRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get splitBillId => $_getSZ(0);
  @$pb.TagNumber(1)
  set splitBillId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSplitBillId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSplitBillId() => $_clearField(1);
}

class GetSplitBillResponse extends $pb.GeneratedMessage {
  factory GetSplitBillResponse({
    $core.bool? success,
    $core.String? message,
    SplitBill? splitBill,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (splitBill != null) result.splitBill = splitBill;
    return result;
  }

  GetSplitBillResponse._();

  factory GetSplitBillResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetSplitBillResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetSplitBillResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'split_bill'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<SplitBill>(3, _omitFieldNames ? '' : 'splitBill',
        subBuilder: SplitBill.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSplitBillResponse clone() =>
      GetSplitBillResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSplitBillResponse copyWith(void Function(GetSplitBillResponse) updates) =>
      super.copyWith((message) => updates(message as GetSplitBillResponse))
          as GetSplitBillResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSplitBillResponse create() => GetSplitBillResponse._();
  @$core.override
  GetSplitBillResponse createEmptyInstance() => create();
  static $pb.PbList<GetSplitBillResponse> createRepeated() =>
      $pb.PbList<GetSplitBillResponse>();
  @$core.pragma('dart2js:noInline')
  static GetSplitBillResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetSplitBillResponse>(create);
  static GetSplitBillResponse? _defaultInstance;

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
  SplitBill get splitBill => $_getN(2);
  @$pb.TagNumber(3)
  set splitBill(SplitBill value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasSplitBill() => $_has(2);
  @$pb.TagNumber(3)
  void clearSplitBill() => $_clearField(3);
  @$pb.TagNumber(3)
  SplitBill ensureSplitBill() => $_ensure(2);
}

class GetMySplitBillsRequest extends $pb.GeneratedMessage {
  factory GetMySplitBillsRequest({
    $core.int? page,
    $core.int? limit,
    SplitBillStatus? status,
  }) {
    final result = create();
    if (page != null) result.page = page;
    if (limit != null) result.limit = limit;
    if (status != null) result.status = status;
    return result;
  }

  GetMySplitBillsRequest._();

  factory GetMySplitBillsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMySplitBillsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMySplitBillsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'split_bill'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..e<SplitBillStatus>(3, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: SplitBillStatus.SPLIT_BILL_STATUS_ACTIVE,
        valueOf: SplitBillStatus.valueOf,
        enumValues: SplitBillStatus.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMySplitBillsRequest clone() =>
      GetMySplitBillsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMySplitBillsRequest copyWith(
          void Function(GetMySplitBillsRequest) updates) =>
      super.copyWith((message) => updates(message as GetMySplitBillsRequest))
          as GetMySplitBillsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMySplitBillsRequest create() => GetMySplitBillsRequest._();
  @$core.override
  GetMySplitBillsRequest createEmptyInstance() => create();
  static $pb.PbList<GetMySplitBillsRequest> createRepeated() =>
      $pb.PbList<GetMySplitBillsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMySplitBillsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetMySplitBillsRequest>(create);
  static GetMySplitBillsRequest? _defaultInstance;

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

  @$pb.TagNumber(3)
  SplitBillStatus get status => $_getN(2);
  @$pb.TagNumber(3)
  set status(SplitBillStatus value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasStatus() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatus() => $_clearField(3);
}

class GetSplitBillsResponse extends $pb.GeneratedMessage {
  factory GetSplitBillsResponse({
    $core.Iterable<SplitBill>? splitBills,
    $core.int? total,
    $core.int? page,
    $core.int? totalPages,
  }) {
    final result = create();
    if (splitBills != null) result.splitBills.addAll(splitBills);
    if (total != null) result.total = total;
    if (page != null) result.page = page;
    if (totalPages != null) result.totalPages = totalPages;
    return result;
  }

  GetSplitBillsResponse._();

  factory GetSplitBillsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetSplitBillsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetSplitBillsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'split_bill'),
      createEmptyInstance: create)
    ..pc<SplitBill>(1, _omitFieldNames ? '' : 'splitBills', $pb.PbFieldType.PM,
        subBuilder: SplitBill.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'totalPages', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSplitBillsResponse clone() =>
      GetSplitBillsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSplitBillsResponse copyWith(
          void Function(GetSplitBillsResponse) updates) =>
      super.copyWith((message) => updates(message as GetSplitBillsResponse))
          as GetSplitBillsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSplitBillsResponse create() => GetSplitBillsResponse._();
  @$core.override
  GetSplitBillsResponse createEmptyInstance() => create();
  static $pb.PbList<GetSplitBillsResponse> createRepeated() =>
      $pb.PbList<GetSplitBillsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetSplitBillsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetSplitBillsResponse>(create);
  static GetSplitBillsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<SplitBill> get splitBills => $_getList(0);

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
  $core.int get totalPages => $_getIZ(3);
  @$pb.TagNumber(4)
  set totalPages($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTotalPages() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalPages() => $_clearField(4);
}

class PaySplitBillShareRequest extends $pb.GeneratedMessage {
  factory PaySplitBillShareRequest({
    $core.String? splitBillId,
    $core.String? sourceAccountId,
    $core.String? transactionPin,
  }) {
    final result = create();
    if (splitBillId != null) result.splitBillId = splitBillId;
    if (sourceAccountId != null) result.sourceAccountId = sourceAccountId;
    if (transactionPin != null) result.transactionPin = transactionPin;
    return result;
  }

  PaySplitBillShareRequest._();

  factory PaySplitBillShareRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PaySplitBillShareRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PaySplitBillShareRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'split_bill'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'splitBillId')
    ..aOS(2, _omitFieldNames ? '' : 'sourceAccountId')
    ..aOS(3, _omitFieldNames ? '' : 'transactionPin')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PaySplitBillShareRequest clone() =>
      PaySplitBillShareRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PaySplitBillShareRequest copyWith(
          void Function(PaySplitBillShareRequest) updates) =>
      super.copyWith((message) => updates(message as PaySplitBillShareRequest))
          as PaySplitBillShareRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PaySplitBillShareRequest create() => PaySplitBillShareRequest._();
  @$core.override
  PaySplitBillShareRequest createEmptyInstance() => create();
  static $pb.PbList<PaySplitBillShareRequest> createRepeated() =>
      $pb.PbList<PaySplitBillShareRequest>();
  @$core.pragma('dart2js:noInline')
  static PaySplitBillShareRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PaySplitBillShareRequest>(create);
  static PaySplitBillShareRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get splitBillId => $_getSZ(0);
  @$pb.TagNumber(1)
  set splitBillId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSplitBillId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSplitBillId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get sourceAccountId => $_getSZ(1);
  @$pb.TagNumber(2)
  set sourceAccountId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSourceAccountId() => $_has(1);
  @$pb.TagNumber(2)
  void clearSourceAccountId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get transactionPin => $_getSZ(2);
  @$pb.TagNumber(3)
  set transactionPin($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTransactionPin() => $_has(2);
  @$pb.TagNumber(3)
  void clearTransactionPin() => $_clearField(3);
}

class PaySplitBillShareResponse extends $pb.GeneratedMessage {
  factory PaySplitBillShareResponse({
    $core.bool? success,
    $core.String? message,
    SplitBillTransaction? transaction,
    SplitBill? splitBill,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (transaction != null) result.transaction = transaction;
    if (splitBill != null) result.splitBill = splitBill;
    return result;
  }

  PaySplitBillShareResponse._();

  factory PaySplitBillShareResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PaySplitBillShareResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PaySplitBillShareResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'split_bill'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<SplitBillTransaction>(3, _omitFieldNames ? '' : 'transaction',
        subBuilder: SplitBillTransaction.create)
    ..aOM<SplitBill>(4, _omitFieldNames ? '' : 'splitBill',
        subBuilder: SplitBill.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PaySplitBillShareResponse clone() =>
      PaySplitBillShareResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PaySplitBillShareResponse copyWith(
          void Function(PaySplitBillShareResponse) updates) =>
      super.copyWith((message) => updates(message as PaySplitBillShareResponse))
          as PaySplitBillShareResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PaySplitBillShareResponse create() => PaySplitBillShareResponse._();
  @$core.override
  PaySplitBillShareResponse createEmptyInstance() => create();
  static $pb.PbList<PaySplitBillShareResponse> createRepeated() =>
      $pb.PbList<PaySplitBillShareResponse>();
  @$core.pragma('dart2js:noInline')
  static PaySplitBillShareResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PaySplitBillShareResponse>(create);
  static PaySplitBillShareResponse? _defaultInstance;

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
  SplitBillTransaction get transaction => $_getN(2);
  @$pb.TagNumber(3)
  set transaction(SplitBillTransaction value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasTransaction() => $_has(2);
  @$pb.TagNumber(3)
  void clearTransaction() => $_clearField(3);
  @$pb.TagNumber(3)
  SplitBillTransaction ensureTransaction() => $_ensure(2);

  @$pb.TagNumber(4)
  SplitBill get splitBill => $_getN(3);
  @$pb.TagNumber(4)
  set splitBill(SplitBill value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasSplitBill() => $_has(3);
  @$pb.TagNumber(4)
  void clearSplitBill() => $_clearField(4);
  @$pb.TagNumber(4)
  SplitBill ensureSplitBill() => $_ensure(3);
}

class CancelSplitBillRequest extends $pb.GeneratedMessage {
  factory CancelSplitBillRequest({
    $core.String? splitBillId,
  }) {
    final result = create();
    if (splitBillId != null) result.splitBillId = splitBillId;
    return result;
  }

  CancelSplitBillRequest._();

  factory CancelSplitBillRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CancelSplitBillRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CancelSplitBillRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'split_bill'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'splitBillId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CancelSplitBillRequest clone() =>
      CancelSplitBillRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CancelSplitBillRequest copyWith(
          void Function(CancelSplitBillRequest) updates) =>
      super.copyWith((message) => updates(message as CancelSplitBillRequest))
          as CancelSplitBillRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CancelSplitBillRequest create() => CancelSplitBillRequest._();
  @$core.override
  CancelSplitBillRequest createEmptyInstance() => create();
  static $pb.PbList<CancelSplitBillRequest> createRepeated() =>
      $pb.PbList<CancelSplitBillRequest>();
  @$core.pragma('dart2js:noInline')
  static CancelSplitBillRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CancelSplitBillRequest>(create);
  static CancelSplitBillRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get splitBillId => $_getSZ(0);
  @$pb.TagNumber(1)
  set splitBillId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSplitBillId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSplitBillId() => $_clearField(1);
}

class CancelSplitBillResponse extends $pb.GeneratedMessage {
  factory CancelSplitBillResponse({
    $core.bool? success,
    $core.String? message,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    return result;
  }

  CancelSplitBillResponse._();

  factory CancelSplitBillResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CancelSplitBillResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CancelSplitBillResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'split_bill'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CancelSplitBillResponse clone() =>
      CancelSplitBillResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CancelSplitBillResponse copyWith(
          void Function(CancelSplitBillResponse) updates) =>
      super.copyWith((message) => updates(message as CancelSplitBillResponse))
          as CancelSplitBillResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CancelSplitBillResponse create() => CancelSplitBillResponse._();
  @$core.override
  CancelSplitBillResponse createEmptyInstance() => create();
  static $pb.PbList<CancelSplitBillResponse> createRepeated() =>
      $pb.PbList<CancelSplitBillResponse>();
  @$core.pragma('dart2js:noInline')
  static CancelSplitBillResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CancelSplitBillResponse>(create);
  static CancelSplitBillResponse? _defaultInstance;

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

class DeclineSplitBillShareRequest extends $pb.GeneratedMessage {
  factory DeclineSplitBillShareRequest({
    $core.String? splitBillId,
    $core.String? reason,
  }) {
    final result = create();
    if (splitBillId != null) result.splitBillId = splitBillId;
    if (reason != null) result.reason = reason;
    return result;
  }

  DeclineSplitBillShareRequest._();

  factory DeclineSplitBillShareRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeclineSplitBillShareRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeclineSplitBillShareRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'split_bill'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'splitBillId')
    ..aOS(2, _omitFieldNames ? '' : 'reason')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeclineSplitBillShareRequest clone() =>
      DeclineSplitBillShareRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeclineSplitBillShareRequest copyWith(
          void Function(DeclineSplitBillShareRequest) updates) =>
      super.copyWith(
              (message) => updates(message as DeclineSplitBillShareRequest))
          as DeclineSplitBillShareRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeclineSplitBillShareRequest create() =>
      DeclineSplitBillShareRequest._();
  @$core.override
  DeclineSplitBillShareRequest createEmptyInstance() => create();
  static $pb.PbList<DeclineSplitBillShareRequest> createRepeated() =>
      $pb.PbList<DeclineSplitBillShareRequest>();
  @$core.pragma('dart2js:noInline')
  static DeclineSplitBillShareRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeclineSplitBillShareRequest>(create);
  static DeclineSplitBillShareRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get splitBillId => $_getSZ(0);
  @$pb.TagNumber(1)
  set splitBillId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSplitBillId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSplitBillId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get reason => $_getSZ(1);
  @$pb.TagNumber(2)
  set reason($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasReason() => $_has(1);
  @$pb.TagNumber(2)
  void clearReason() => $_clearField(2);
}

class DeclineSplitBillShareResponse extends $pb.GeneratedMessage {
  factory DeclineSplitBillShareResponse({
    $core.bool? success,
    $core.String? message,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    return result;
  }

  DeclineSplitBillShareResponse._();

  factory DeclineSplitBillShareResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeclineSplitBillShareResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeclineSplitBillShareResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'split_bill'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeclineSplitBillShareResponse clone() =>
      DeclineSplitBillShareResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeclineSplitBillShareResponse copyWith(
          void Function(DeclineSplitBillShareResponse) updates) =>
      super.copyWith(
              (message) => updates(message as DeclineSplitBillShareResponse))
          as DeclineSplitBillShareResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeclineSplitBillShareResponse create() =>
      DeclineSplitBillShareResponse._();
  @$core.override
  DeclineSplitBillShareResponse createEmptyInstance() => create();
  static $pb.PbList<DeclineSplitBillShareResponse> createRepeated() =>
      $pb.PbList<DeclineSplitBillShareResponse>();
  @$core.pragma('dart2js:noInline')
  static DeclineSplitBillShareResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeclineSplitBillShareResponse>(create);
  static DeclineSplitBillShareResponse? _defaultInstance;

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

class SendSplitBillReminderRequest extends $pb.GeneratedMessage {
  factory SendSplitBillReminderRequest({
    $core.String? splitBillId,
    $core.Iterable<$core.String>? participantUserIds,
  }) {
    final result = create();
    if (splitBillId != null) result.splitBillId = splitBillId;
    if (participantUserIds != null)
      result.participantUserIds.addAll(participantUserIds);
    return result;
  }

  SendSplitBillReminderRequest._();

  factory SendSplitBillReminderRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SendSplitBillReminderRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SendSplitBillReminderRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'split_bill'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'splitBillId')
    ..pPS(2, _omitFieldNames ? '' : 'participantUserIds')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SendSplitBillReminderRequest clone() =>
      SendSplitBillReminderRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SendSplitBillReminderRequest copyWith(
          void Function(SendSplitBillReminderRequest) updates) =>
      super.copyWith(
              (message) => updates(message as SendSplitBillReminderRequest))
          as SendSplitBillReminderRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SendSplitBillReminderRequest create() =>
      SendSplitBillReminderRequest._();
  @$core.override
  SendSplitBillReminderRequest createEmptyInstance() => create();
  static $pb.PbList<SendSplitBillReminderRequest> createRepeated() =>
      $pb.PbList<SendSplitBillReminderRequest>();
  @$core.pragma('dart2js:noInline')
  static SendSplitBillReminderRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SendSplitBillReminderRequest>(create);
  static SendSplitBillReminderRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get splitBillId => $_getSZ(0);
  @$pb.TagNumber(1)
  set splitBillId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSplitBillId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSplitBillId() => $_clearField(1);

  /// Optional: remind only these participants (by user id). Empty → remind ALL
  /// unpaid (pending) participants. Non-pending ids in the list are ignored.
  @$pb.TagNumber(2)
  $pb.PbList<$core.String> get participantUserIds => $_getList(1);
}

class SendSplitBillReminderResponse extends $pb.GeneratedMessage {
  factory SendSplitBillReminderResponse({
    $core.bool? success,
    $core.String? message,
    $core.int? remindersSent,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (remindersSent != null) result.remindersSent = remindersSent;
    return result;
  }

  SendSplitBillReminderResponse._();

  factory SendSplitBillReminderResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SendSplitBillReminderResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SendSplitBillReminderResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'split_bill'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..a<$core.int>(
        3, _omitFieldNames ? '' : 'remindersSent', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SendSplitBillReminderResponse clone() =>
      SendSplitBillReminderResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SendSplitBillReminderResponse copyWith(
          void Function(SendSplitBillReminderResponse) updates) =>
      super.copyWith(
              (message) => updates(message as SendSplitBillReminderResponse))
          as SendSplitBillReminderResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SendSplitBillReminderResponse create() =>
      SendSplitBillReminderResponse._();
  @$core.override
  SendSplitBillReminderResponse createEmptyInstance() => create();
  static $pb.PbList<SendSplitBillReminderResponse> createRepeated() =>
      $pb.PbList<SendSplitBillReminderResponse>();
  @$core.pragma('dart2js:noInline')
  static SendSplitBillReminderResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SendSplitBillReminderResponse>(create);
  static SendSplitBillReminderResponse? _defaultInstance;

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
  $core.int get remindersSent => $_getIZ(2);
  @$pb.TagNumber(3)
  set remindersSent($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasRemindersSent() => $_has(2);
  @$pb.TagNumber(3)
  void clearRemindersSent() => $_clearField(3);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
