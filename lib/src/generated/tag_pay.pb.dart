// This is a generated file - do not edit.
//
// Generated from tag_pay.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/timestamp.pb.dart' as $1;
import 'tag_pay.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'tag_pay.pbenum.dart';

/// Tag Pay Entity
class TagPay extends $pb.GeneratedMessage {
  factory TagPay({
    $core.String? id,
    $core.String? userId,
    $core.String? tagPay,
    $core.String? displayName,
    $core.String? avatarUrl,
    $core.bool? isActive,
    $1.Timestamp? createdAt,
    $1.Timestamp? updatedAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (userId != null) result.userId = userId;
    if (tagPay != null) result.tagPay = tagPay;
    if (displayName != null) result.displayName = displayName;
    if (avatarUrl != null) result.avatarUrl = avatarUrl;
    if (isActive != null) result.isActive = isActive;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    return result;
  }

  TagPay._();

  factory TagPay.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TagPay.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TagPay',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'tagPay')
    ..aOS(4, _omitFieldNames ? '' : 'displayName')
    ..aOS(5, _omitFieldNames ? '' : 'avatarUrl')
    ..aOB(6, _omitFieldNames ? '' : 'isActive')
    ..aOM<$1.Timestamp>(7, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(8, _omitFieldNames ? '' : 'updatedAt',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TagPay clone() => TagPay()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TagPay copyWith(void Function(TagPay) updates) =>
      super.copyWith((message) => updates(message as TagPay)) as TagPay;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TagPay create() => TagPay._();
  @$core.override
  TagPay createEmptyInstance() => create();
  static $pb.PbList<TagPay> createRepeated() => $pb.PbList<TagPay>();
  @$core.pragma('dart2js:noInline')
  static TagPay getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TagPay>(create);
  static TagPay? _defaultInstance;

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
  $core.String get tagPay => $_getSZ(2);
  @$pb.TagNumber(3)
  set tagPay($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTagPay() => $_has(2);
  @$pb.TagNumber(3)
  void clearTagPay() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get displayName => $_getSZ(3);
  @$pb.TagNumber(4)
  set displayName($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDisplayName() => $_has(3);
  @$pb.TagNumber(4)
  void clearDisplayName() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get avatarUrl => $_getSZ(4);
  @$pb.TagNumber(5)
  set avatarUrl($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasAvatarUrl() => $_has(4);
  @$pb.TagNumber(5)
  void clearAvatarUrl() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.bool get isActive => $_getBF(5);
  @$pb.TagNumber(6)
  set isActive($core.bool value) => $_setBool(5, value);
  @$pb.TagNumber(6)
  $core.bool hasIsActive() => $_has(5);
  @$pb.TagNumber(6)
  void clearIsActive() => $_clearField(6);

  @$pb.TagNumber(7)
  $1.Timestamp get createdAt => $_getN(6);
  @$pb.TagNumber(7)
  set createdAt($1.Timestamp value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasCreatedAt() => $_has(6);
  @$pb.TagNumber(7)
  void clearCreatedAt() => $_clearField(7);
  @$pb.TagNumber(7)
  $1.Timestamp ensureCreatedAt() => $_ensure(6);

  @$pb.TagNumber(8)
  $1.Timestamp get updatedAt => $_getN(7);
  @$pb.TagNumber(8)
  set updatedAt($1.Timestamp value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasUpdatedAt() => $_has(7);
  @$pb.TagNumber(8)
  void clearUpdatedAt() => $_clearField(8);
  @$pb.TagNumber(8)
  $1.Timestamp ensureUpdatedAt() => $_ensure(7);
}

/// Tag Pay Transaction
class TagPayTransaction extends $pb.GeneratedMessage {
  factory TagPayTransaction({
    $core.String? id,
    $core.String? senderId,
    $core.String? senderTagPay,
    $core.String? senderName,
    $core.String? receiverId,
    $core.String? receiverTagPay,
    $core.String? receiverName,
    $core.double? amount,
    $core.String? currency,
    $core.String? description,
    TagPayTransactionStatus? status,
    TagPayTransactionType? type,
    $core.String? referenceNumber,
    $1.Timestamp? createdAt,
    $1.Timestamp? completedAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (senderId != null) result.senderId = senderId;
    if (senderTagPay != null) result.senderTagPay = senderTagPay;
    if (senderName != null) result.senderName = senderName;
    if (receiverId != null) result.receiverId = receiverId;
    if (receiverTagPay != null) result.receiverTagPay = receiverTagPay;
    if (receiverName != null) result.receiverName = receiverName;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    if (description != null) result.description = description;
    if (status != null) result.status = status;
    if (type != null) result.type = type;
    if (referenceNumber != null) result.referenceNumber = referenceNumber;
    if (createdAt != null) result.createdAt = createdAt;
    if (completedAt != null) result.completedAt = completedAt;
    return result;
  }

  TagPayTransaction._();

  factory TagPayTransaction.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TagPayTransaction.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TagPayTransaction',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'senderId')
    ..aOS(3, _omitFieldNames ? '' : 'senderTagPay')
    ..aOS(4, _omitFieldNames ? '' : 'senderName')
    ..aOS(5, _omitFieldNames ? '' : 'receiverId')
    ..aOS(6, _omitFieldNames ? '' : 'receiverTagPay')
    ..aOS(7, _omitFieldNames ? '' : 'receiverName')
    ..a<$core.double>(8, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(9, _omitFieldNames ? '' : 'currency')
    ..aOS(10, _omitFieldNames ? '' : 'description')
    ..e<TagPayTransactionStatus>(
        11, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker:
            TagPayTransactionStatus.TAG_PAY_TRANSACTION_STATUS_PENDING,
        valueOf: TagPayTransactionStatus.valueOf,
        enumValues: TagPayTransactionStatus.values)
    ..e<TagPayTransactionType>(
        12, _omitFieldNames ? '' : 'type', $pb.PbFieldType.OE,
        defaultOrMaker: TagPayTransactionType.TAG_PAY_TRANSACTION_TYPE_SEND,
        valueOf: TagPayTransactionType.valueOf,
        enumValues: TagPayTransactionType.values)
    ..aOS(13, _omitFieldNames ? '' : 'referenceNumber')
    ..aOM<$1.Timestamp>(14, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(15, _omitFieldNames ? '' : 'completedAt',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TagPayTransaction clone() => TagPayTransaction()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TagPayTransaction copyWith(void Function(TagPayTransaction) updates) =>
      super.copyWith((message) => updates(message as TagPayTransaction))
          as TagPayTransaction;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TagPayTransaction create() => TagPayTransaction._();
  @$core.override
  TagPayTransaction createEmptyInstance() => create();
  static $pb.PbList<TagPayTransaction> createRepeated() =>
      $pb.PbList<TagPayTransaction>();
  @$core.pragma('dart2js:noInline')
  static TagPayTransaction getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TagPayTransaction>(create);
  static TagPayTransaction? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get senderId => $_getSZ(1);
  @$pb.TagNumber(2)
  set senderId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSenderId() => $_has(1);
  @$pb.TagNumber(2)
  void clearSenderId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get senderTagPay => $_getSZ(2);
  @$pb.TagNumber(3)
  set senderTagPay($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSenderTagPay() => $_has(2);
  @$pb.TagNumber(3)
  void clearSenderTagPay() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get senderName => $_getSZ(3);
  @$pb.TagNumber(4)
  set senderName($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasSenderName() => $_has(3);
  @$pb.TagNumber(4)
  void clearSenderName() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get receiverId => $_getSZ(4);
  @$pb.TagNumber(5)
  set receiverId($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasReceiverId() => $_has(4);
  @$pb.TagNumber(5)
  void clearReceiverId() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get receiverTagPay => $_getSZ(5);
  @$pb.TagNumber(6)
  set receiverTagPay($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasReceiverTagPay() => $_has(5);
  @$pb.TagNumber(6)
  void clearReceiverTagPay() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get receiverName => $_getSZ(6);
  @$pb.TagNumber(7)
  set receiverName($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasReceiverName() => $_has(6);
  @$pb.TagNumber(7)
  void clearReceiverName() => $_clearField(7);

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
  TagPayTransactionStatus get status => $_getN(10);
  @$pb.TagNumber(11)
  set status(TagPayTransactionStatus value) => $_setField(11, value);
  @$pb.TagNumber(11)
  $core.bool hasStatus() => $_has(10);
  @$pb.TagNumber(11)
  void clearStatus() => $_clearField(11);

  @$pb.TagNumber(12)
  TagPayTransactionType get type => $_getN(11);
  @$pb.TagNumber(12)
  set type(TagPayTransactionType value) => $_setField(12, value);
  @$pb.TagNumber(12)
  $core.bool hasType() => $_has(11);
  @$pb.TagNumber(12)
  void clearType() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.String get referenceNumber => $_getSZ(12);
  @$pb.TagNumber(13)
  set referenceNumber($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasReferenceNumber() => $_has(12);
  @$pb.TagNumber(13)
  void clearReferenceNumber() => $_clearField(13);

  @$pb.TagNumber(14)
  $1.Timestamp get createdAt => $_getN(13);
  @$pb.TagNumber(14)
  set createdAt($1.Timestamp value) => $_setField(14, value);
  @$pb.TagNumber(14)
  $core.bool hasCreatedAt() => $_has(13);
  @$pb.TagNumber(14)
  void clearCreatedAt() => $_clearField(14);
  @$pb.TagNumber(14)
  $1.Timestamp ensureCreatedAt() => $_ensure(13);

  @$pb.TagNumber(15)
  $1.Timestamp get completedAt => $_getN(14);
  @$pb.TagNumber(15)
  set completedAt($1.Timestamp value) => $_setField(15, value);
  @$pb.TagNumber(15)
  $core.bool hasCompletedAt() => $_has(14);
  @$pb.TagNumber(15)
  void clearCompletedAt() => $_clearField(15);
  @$pb.TagNumber(15)
  $1.Timestamp ensureCompletedAt() => $_ensure(14);
}

/// Money Request Entity
class MoneyRequest extends $pb.GeneratedMessage {
  factory MoneyRequest({
    $core.String? id,
    $core.String? requesterId,
    $core.String? requesterTagPay,
    $core.String? requesterName,
    $core.String? requesteeId,
    $core.String? requesteeTagPay,
    $core.String? requesteeName,
    $core.double? amount,
    $core.String? currency,
    $core.String? description,
    MoneyRequestStatus? status,
    $1.Timestamp? createdAt,
    $1.Timestamp? respondedAt,
    $1.Timestamp? expiresAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (requesterId != null) result.requesterId = requesterId;
    if (requesterTagPay != null) result.requesterTagPay = requesterTagPay;
    if (requesterName != null) result.requesterName = requesterName;
    if (requesteeId != null) result.requesteeId = requesteeId;
    if (requesteeTagPay != null) result.requesteeTagPay = requesteeTagPay;
    if (requesteeName != null) result.requesteeName = requesteeName;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    if (description != null) result.description = description;
    if (status != null) result.status = status;
    if (createdAt != null) result.createdAt = createdAt;
    if (respondedAt != null) result.respondedAt = respondedAt;
    if (expiresAt != null) result.expiresAt = expiresAt;
    return result;
  }

  MoneyRequest._();

  factory MoneyRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MoneyRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MoneyRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'requesterId')
    ..aOS(3, _omitFieldNames ? '' : 'requesterTagPay')
    ..aOS(4, _omitFieldNames ? '' : 'requesterName')
    ..aOS(5, _omitFieldNames ? '' : 'requesteeId')
    ..aOS(6, _omitFieldNames ? '' : 'requesteeTagPay')
    ..aOS(7, _omitFieldNames ? '' : 'requesteeName')
    ..a<$core.double>(8, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(9, _omitFieldNames ? '' : 'currency')
    ..aOS(10, _omitFieldNames ? '' : 'description')
    ..e<MoneyRequestStatus>(
        11, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: MoneyRequestStatus.MONEY_REQUEST_STATUS_PENDING,
        valueOf: MoneyRequestStatus.valueOf,
        enumValues: MoneyRequestStatus.values)
    ..aOM<$1.Timestamp>(12, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(13, _omitFieldNames ? '' : 'respondedAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(14, _omitFieldNames ? '' : 'expiresAt',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MoneyRequest clone() => MoneyRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MoneyRequest copyWith(void Function(MoneyRequest) updates) =>
      super.copyWith((message) => updates(message as MoneyRequest))
          as MoneyRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MoneyRequest create() => MoneyRequest._();
  @$core.override
  MoneyRequest createEmptyInstance() => create();
  static $pb.PbList<MoneyRequest> createRepeated() =>
      $pb.PbList<MoneyRequest>();
  @$core.pragma('dart2js:noInline')
  static MoneyRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MoneyRequest>(create);
  static MoneyRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get requesterId => $_getSZ(1);
  @$pb.TagNumber(2)
  set requesterId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRequesterId() => $_has(1);
  @$pb.TagNumber(2)
  void clearRequesterId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get requesterTagPay => $_getSZ(2);
  @$pb.TagNumber(3)
  set requesterTagPay($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasRequesterTagPay() => $_has(2);
  @$pb.TagNumber(3)
  void clearRequesterTagPay() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get requesterName => $_getSZ(3);
  @$pb.TagNumber(4)
  set requesterName($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasRequesterName() => $_has(3);
  @$pb.TagNumber(4)
  void clearRequesterName() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get requesteeId => $_getSZ(4);
  @$pb.TagNumber(5)
  set requesteeId($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasRequesteeId() => $_has(4);
  @$pb.TagNumber(5)
  void clearRequesteeId() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get requesteeTagPay => $_getSZ(5);
  @$pb.TagNumber(6)
  set requesteeTagPay($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasRequesteeTagPay() => $_has(5);
  @$pb.TagNumber(6)
  void clearRequesteeTagPay() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get requesteeName => $_getSZ(6);
  @$pb.TagNumber(7)
  set requesteeName($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasRequesteeName() => $_has(6);
  @$pb.TagNumber(7)
  void clearRequesteeName() => $_clearField(7);

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
  MoneyRequestStatus get status => $_getN(10);
  @$pb.TagNumber(11)
  set status(MoneyRequestStatus value) => $_setField(11, value);
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

  @$pb.TagNumber(13)
  $1.Timestamp get respondedAt => $_getN(12);
  @$pb.TagNumber(13)
  set respondedAt($1.Timestamp value) => $_setField(13, value);
  @$pb.TagNumber(13)
  $core.bool hasRespondedAt() => $_has(12);
  @$pb.TagNumber(13)
  void clearRespondedAt() => $_clearField(13);
  @$pb.TagNumber(13)
  $1.Timestamp ensureRespondedAt() => $_ensure(12);

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
}

/// User Tag Entity
class UserTag extends $pb.GeneratedMessage {
  factory UserTag({
    $core.String? id,
    $core.String? taggerId,
    $core.String? taggerTagPay,
    $core.String? taggerName,
    $core.String? taggedUserId,
    $core.String? taggedUserTagPay,
    $core.String? taggedUserName,
    $core.double? amount,
    $core.String? currency,
    $core.String? description,
    TagStatus? status,
    $1.Timestamp? createdAt,
    $1.Timestamp? paidAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (taggerId != null) result.taggerId = taggerId;
    if (taggerTagPay != null) result.taggerTagPay = taggerTagPay;
    if (taggerName != null) result.taggerName = taggerName;
    if (taggedUserId != null) result.taggedUserId = taggedUserId;
    if (taggedUserTagPay != null) result.taggedUserTagPay = taggedUserTagPay;
    if (taggedUserName != null) result.taggedUserName = taggedUserName;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    if (description != null) result.description = description;
    if (status != null) result.status = status;
    if (createdAt != null) result.createdAt = createdAt;
    if (paidAt != null) result.paidAt = paidAt;
    return result;
  }

  UserTag._();

  factory UserTag.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UserTag.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UserTag',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'taggerId')
    ..aOS(3, _omitFieldNames ? '' : 'taggerTagPay')
    ..aOS(4, _omitFieldNames ? '' : 'taggerName')
    ..aOS(5, _omitFieldNames ? '' : 'taggedUserId')
    ..aOS(6, _omitFieldNames ? '' : 'taggedUserTagPay')
    ..aOS(7, _omitFieldNames ? '' : 'taggedUserName')
    ..a<$core.double>(8, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(9, _omitFieldNames ? '' : 'currency')
    ..aOS(10, _omitFieldNames ? '' : 'description')
    ..e<TagStatus>(11, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: TagStatus.TAG_STATUS_PENDING,
        valueOf: TagStatus.valueOf,
        enumValues: TagStatus.values)
    ..aOM<$1.Timestamp>(12, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(13, _omitFieldNames ? '' : 'paidAt',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserTag clone() => UserTag()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserTag copyWith(void Function(UserTag) updates) =>
      super.copyWith((message) => updates(message as UserTag)) as UserTag;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UserTag create() => UserTag._();
  @$core.override
  UserTag createEmptyInstance() => create();
  static $pb.PbList<UserTag> createRepeated() => $pb.PbList<UserTag>();
  @$core.pragma('dart2js:noInline')
  static UserTag getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UserTag>(create);
  static UserTag? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get taggerId => $_getSZ(1);
  @$pb.TagNumber(2)
  set taggerId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTaggerId() => $_has(1);
  @$pb.TagNumber(2)
  void clearTaggerId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get taggerTagPay => $_getSZ(2);
  @$pb.TagNumber(3)
  set taggerTagPay($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTaggerTagPay() => $_has(2);
  @$pb.TagNumber(3)
  void clearTaggerTagPay() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get taggerName => $_getSZ(3);
  @$pb.TagNumber(4)
  set taggerName($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTaggerName() => $_has(3);
  @$pb.TagNumber(4)
  void clearTaggerName() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get taggedUserId => $_getSZ(4);
  @$pb.TagNumber(5)
  set taggedUserId($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTaggedUserId() => $_has(4);
  @$pb.TagNumber(5)
  void clearTaggedUserId() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get taggedUserTagPay => $_getSZ(5);
  @$pb.TagNumber(6)
  set taggedUserTagPay($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasTaggedUserTagPay() => $_has(5);
  @$pb.TagNumber(6)
  void clearTaggedUserTagPay() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get taggedUserName => $_getSZ(6);
  @$pb.TagNumber(7)
  set taggedUserName($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasTaggedUserName() => $_has(6);
  @$pb.TagNumber(7)
  void clearTaggedUserName() => $_clearField(7);

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
  TagStatus get status => $_getN(10);
  @$pb.TagNumber(11)
  set status(TagStatus value) => $_setField(11, value);
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

  @$pb.TagNumber(13)
  $1.Timestamp get paidAt => $_getN(12);
  @$pb.TagNumber(13)
  set paidAt($1.Timestamp value) => $_setField(13, value);
  @$pb.TagNumber(13)
  $core.bool hasPaidAt() => $_has(12);
  @$pb.TagNumber(13)
  void clearPaidAt() => $_clearField(13);
  @$pb.TagNumber(13)
  $1.Timestamp ensurePaidAt() => $_ensure(12);
}

/// Request/Response messages
class CreateTagPayRequest extends $pb.GeneratedMessage {
  factory CreateTagPayRequest({
    $core.String? tagPay,
    $core.String? displayName,
    $core.String? avatarUrl,
  }) {
    final result = create();
    if (tagPay != null) result.tagPay = tagPay;
    if (displayName != null) result.displayName = displayName;
    if (avatarUrl != null) result.avatarUrl = avatarUrl;
    return result;
  }

  CreateTagPayRequest._();

  factory CreateTagPayRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateTagPayRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateTagPayRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'tagPay')
    ..aOS(2, _omitFieldNames ? '' : 'displayName')
    ..aOS(3, _omitFieldNames ? '' : 'avatarUrl')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateTagPayRequest clone() => CreateTagPayRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateTagPayRequest copyWith(void Function(CreateTagPayRequest) updates) =>
      super.copyWith((message) => updates(message as CreateTagPayRequest))
          as CreateTagPayRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateTagPayRequest create() => CreateTagPayRequest._();
  @$core.override
  CreateTagPayRequest createEmptyInstance() => create();
  static $pb.PbList<CreateTagPayRequest> createRepeated() =>
      $pb.PbList<CreateTagPayRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateTagPayRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateTagPayRequest>(create);
  static CreateTagPayRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get tagPay => $_getSZ(0);
  @$pb.TagNumber(1)
  set tagPay($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTagPay() => $_has(0);
  @$pb.TagNumber(1)
  void clearTagPay() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get displayName => $_getSZ(1);
  @$pb.TagNumber(2)
  set displayName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDisplayName() => $_has(1);
  @$pb.TagNumber(2)
  void clearDisplayName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get avatarUrl => $_getSZ(2);
  @$pb.TagNumber(3)
  set avatarUrl($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAvatarUrl() => $_has(2);
  @$pb.TagNumber(3)
  void clearAvatarUrl() => $_clearField(3);
}

class CreateTagPayResponse extends $pb.GeneratedMessage {
  factory CreateTagPayResponse({
    $core.bool? success,
    $core.String? message,
    TagPay? tagPay,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (tagPay != null) result.tagPay = tagPay;
    return result;
  }

  CreateTagPayResponse._();

  factory CreateTagPayResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateTagPayResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateTagPayResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<TagPay>(3, _omitFieldNames ? '' : 'tagPay', subBuilder: TagPay.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateTagPayResponse clone() =>
      CreateTagPayResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateTagPayResponse copyWith(void Function(CreateTagPayResponse) updates) =>
      super.copyWith((message) => updates(message as CreateTagPayResponse))
          as CreateTagPayResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateTagPayResponse create() => CreateTagPayResponse._();
  @$core.override
  CreateTagPayResponse createEmptyInstance() => create();
  static $pb.PbList<CreateTagPayResponse> createRepeated() =>
      $pb.PbList<CreateTagPayResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateTagPayResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateTagPayResponse>(create);
  static CreateTagPayResponse? _defaultInstance;

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
  TagPay get tagPay => $_getN(2);
  @$pb.TagNumber(3)
  set tagPay(TagPay value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasTagPay() => $_has(2);
  @$pb.TagNumber(3)
  void clearTagPay() => $_clearField(3);
  @$pb.TagNumber(3)
  TagPay ensureTagPay() => $_ensure(2);
}

class GetTagPayRequest extends $pb.GeneratedMessage {
  factory GetTagPayRequest({
    $core.String? tagPay,
  }) {
    final result = create();
    if (tagPay != null) result.tagPay = tagPay;
    return result;
  }

  GetTagPayRequest._();

  factory GetTagPayRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTagPayRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetTagPayRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'tagPay')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTagPayRequest clone() => GetTagPayRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTagPayRequest copyWith(void Function(GetTagPayRequest) updates) =>
      super.copyWith((message) => updates(message as GetTagPayRequest))
          as GetTagPayRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTagPayRequest create() => GetTagPayRequest._();
  @$core.override
  GetTagPayRequest createEmptyInstance() => create();
  static $pb.PbList<GetTagPayRequest> createRepeated() =>
      $pb.PbList<GetTagPayRequest>();
  @$core.pragma('dart2js:noInline')
  static GetTagPayRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetTagPayRequest>(create);
  static GetTagPayRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get tagPay => $_getSZ(0);
  @$pb.TagNumber(1)
  set tagPay($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTagPay() => $_has(0);
  @$pb.TagNumber(1)
  void clearTagPay() => $_clearField(1);
}

class GetTagPayResponse extends $pb.GeneratedMessage {
  factory GetTagPayResponse({
    $core.bool? success,
    $core.String? message,
    TagPay? tagPay,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (tagPay != null) result.tagPay = tagPay;
    return result;
  }

  GetTagPayResponse._();

  factory GetTagPayResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTagPayResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetTagPayResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<TagPay>(3, _omitFieldNames ? '' : 'tagPay', subBuilder: TagPay.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTagPayResponse clone() => GetTagPayResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTagPayResponse copyWith(void Function(GetTagPayResponse) updates) =>
      super.copyWith((message) => updates(message as GetTagPayResponse))
          as GetTagPayResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTagPayResponse create() => GetTagPayResponse._();
  @$core.override
  GetTagPayResponse createEmptyInstance() => create();
  static $pb.PbList<GetTagPayResponse> createRepeated() =>
      $pb.PbList<GetTagPayResponse>();
  @$core.pragma('dart2js:noInline')
  static GetTagPayResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetTagPayResponse>(create);
  static GetTagPayResponse? _defaultInstance;

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
  TagPay get tagPay => $_getN(2);
  @$pb.TagNumber(3)
  set tagPay(TagPay value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasTagPay() => $_has(2);
  @$pb.TagNumber(3)
  void clearTagPay() => $_clearField(3);
  @$pb.TagNumber(3)
  TagPay ensureTagPay() => $_ensure(2);
}

class CheckTagPayAvailabilityRequest extends $pb.GeneratedMessage {
  factory CheckTagPayAvailabilityRequest({
    $core.String? tagPay,
  }) {
    final result = create();
    if (tagPay != null) result.tagPay = tagPay;
    return result;
  }

  CheckTagPayAvailabilityRequest._();

  factory CheckTagPayAvailabilityRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CheckTagPayAvailabilityRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CheckTagPayAvailabilityRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'tagPay')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CheckTagPayAvailabilityRequest clone() =>
      CheckTagPayAvailabilityRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CheckTagPayAvailabilityRequest copyWith(
          void Function(CheckTagPayAvailabilityRequest) updates) =>
      super.copyWith(
              (message) => updates(message as CheckTagPayAvailabilityRequest))
          as CheckTagPayAvailabilityRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CheckTagPayAvailabilityRequest create() =>
      CheckTagPayAvailabilityRequest._();
  @$core.override
  CheckTagPayAvailabilityRequest createEmptyInstance() => create();
  static $pb.PbList<CheckTagPayAvailabilityRequest> createRepeated() =>
      $pb.PbList<CheckTagPayAvailabilityRequest>();
  @$core.pragma('dart2js:noInline')
  static CheckTagPayAvailabilityRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CheckTagPayAvailabilityRequest>(create);
  static CheckTagPayAvailabilityRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get tagPay => $_getSZ(0);
  @$pb.TagNumber(1)
  set tagPay($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTagPay() => $_has(0);
  @$pb.TagNumber(1)
  void clearTagPay() => $_clearField(1);
}

class CheckTagPayAvailabilityResponse extends $pb.GeneratedMessage {
  factory CheckTagPayAvailabilityResponse({
    $core.bool? available,
    $core.String? message,
    $core.Iterable<$core.String>? suggestions,
  }) {
    final result = create();
    if (available != null) result.available = available;
    if (message != null) result.message = message;
    if (suggestions != null) result.suggestions.addAll(suggestions);
    return result;
  }

  CheckTagPayAvailabilityResponse._();

  factory CheckTagPayAvailabilityResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CheckTagPayAvailabilityResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CheckTagPayAvailabilityResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'available')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..pPS(3, _omitFieldNames ? '' : 'suggestions')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CheckTagPayAvailabilityResponse clone() =>
      CheckTagPayAvailabilityResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CheckTagPayAvailabilityResponse copyWith(
          void Function(CheckTagPayAvailabilityResponse) updates) =>
      super.copyWith(
              (message) => updates(message as CheckTagPayAvailabilityResponse))
          as CheckTagPayAvailabilityResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CheckTagPayAvailabilityResponse create() =>
      CheckTagPayAvailabilityResponse._();
  @$core.override
  CheckTagPayAvailabilityResponse createEmptyInstance() => create();
  static $pb.PbList<CheckTagPayAvailabilityResponse> createRepeated() =>
      $pb.PbList<CheckTagPayAvailabilityResponse>();
  @$core.pragma('dart2js:noInline')
  static CheckTagPayAvailabilityResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CheckTagPayAvailabilityResponse>(
          create);
  static CheckTagPayAvailabilityResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get available => $_getBF(0);
  @$pb.TagNumber(1)
  set available($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAvailable() => $_has(0);
  @$pb.TagNumber(1)
  void clearAvailable() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);

  @$pb.TagNumber(3)
  $pb.PbList<$core.String> get suggestions => $_getList(2);
}

class SearchTagPayRequest extends $pb.GeneratedMessage {
  factory SearchTagPayRequest({
    $core.String? query,
    $core.int? limit,
  }) {
    final result = create();
    if (query != null) result.query = query;
    if (limit != null) result.limit = limit;
    return result;
  }

  SearchTagPayRequest._();

  factory SearchTagPayRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SearchTagPayRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SearchTagPayRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'query')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchTagPayRequest clone() => SearchTagPayRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchTagPayRequest copyWith(void Function(SearchTagPayRequest) updates) =>
      super.copyWith((message) => updates(message as SearchTagPayRequest))
          as SearchTagPayRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SearchTagPayRequest create() => SearchTagPayRequest._();
  @$core.override
  SearchTagPayRequest createEmptyInstance() => create();
  static $pb.PbList<SearchTagPayRequest> createRepeated() =>
      $pb.PbList<SearchTagPayRequest>();
  @$core.pragma('dart2js:noInline')
  static SearchTagPayRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SearchTagPayRequest>(create);
  static SearchTagPayRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get query => $_getSZ(0);
  @$pb.TagNumber(1)
  set query($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasQuery() => $_has(0);
  @$pb.TagNumber(1)
  void clearQuery() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get limit => $_getIZ(1);
  @$pb.TagNumber(2)
  set limit($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearLimit() => $_clearField(2);
}

class SearchTagPayResponse extends $pb.GeneratedMessage {
  factory SearchTagPayResponse({
    $core.Iterable<TagPay>? results,
    $core.int? total,
  }) {
    final result = create();
    if (results != null) result.results.addAll(results);
    if (total != null) result.total = total;
    return result;
  }

  SearchTagPayResponse._();

  factory SearchTagPayResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SearchTagPayResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SearchTagPayResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<TagPay>(1, _omitFieldNames ? '' : 'results', $pb.PbFieldType.PM,
        subBuilder: TagPay.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchTagPayResponse clone() =>
      SearchTagPayResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchTagPayResponse copyWith(void Function(SearchTagPayResponse) updates) =>
      super.copyWith((message) => updates(message as SearchTagPayResponse))
          as SearchTagPayResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SearchTagPayResponse create() => SearchTagPayResponse._();
  @$core.override
  SearchTagPayResponse createEmptyInstance() => create();
  static $pb.PbList<SearchTagPayResponse> createRepeated() =>
      $pb.PbList<SearchTagPayResponse>();
  @$core.pragma('dart2js:noInline')
  static SearchTagPayResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SearchTagPayResponse>(create);
  static SearchTagPayResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<TagPay> get results => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);
}

class SendMoneyTagPayRequest extends $pb.GeneratedMessage {
  factory SendMoneyTagPayRequest({
    $core.String? receiverTagPay,
    $core.double? amount,
    $core.String? currency,
    $core.String? description,
    $core.String? sourceAccountId,
    $core.String? transactionPin,
  }) {
    final result = create();
    if (receiverTagPay != null) result.receiverTagPay = receiverTagPay;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    if (description != null) result.description = description;
    if (sourceAccountId != null) result.sourceAccountId = sourceAccountId;
    if (transactionPin != null) result.transactionPin = transactionPin;
    return result;
  }

  SendMoneyTagPayRequest._();

  factory SendMoneyTagPayRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SendMoneyTagPayRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SendMoneyTagPayRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'receiverTagPay')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(3, _omitFieldNames ? '' : 'currency')
    ..aOS(4, _omitFieldNames ? '' : 'description')
    ..aOS(5, _omitFieldNames ? '' : 'sourceAccountId')
    ..aOS(6, _omitFieldNames ? '' : 'transactionPin')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SendMoneyTagPayRequest clone() =>
      SendMoneyTagPayRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SendMoneyTagPayRequest copyWith(
          void Function(SendMoneyTagPayRequest) updates) =>
      super.copyWith((message) => updates(message as SendMoneyTagPayRequest))
          as SendMoneyTagPayRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SendMoneyTagPayRequest create() => SendMoneyTagPayRequest._();
  @$core.override
  SendMoneyTagPayRequest createEmptyInstance() => create();
  static $pb.PbList<SendMoneyTagPayRequest> createRepeated() =>
      $pb.PbList<SendMoneyTagPayRequest>();
  @$core.pragma('dart2js:noInline')
  static SendMoneyTagPayRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SendMoneyTagPayRequest>(create);
  static SendMoneyTagPayRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get receiverTagPay => $_getSZ(0);
  @$pb.TagNumber(1)
  set receiverTagPay($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasReceiverTagPay() => $_has(0);
  @$pb.TagNumber(1)
  void clearReceiverTagPay() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get amount => $_getN(1);
  @$pb.TagNumber(2)
  set amount($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get currency => $_getSZ(2);
  @$pb.TagNumber(3)
  set currency($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCurrency() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrency() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get description => $_getSZ(3);
  @$pb.TagNumber(4)
  set description($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDescription() => $_has(3);
  @$pb.TagNumber(4)
  void clearDescription() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get sourceAccountId => $_getSZ(4);
  @$pb.TagNumber(5)
  set sourceAccountId($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasSourceAccountId() => $_has(4);
  @$pb.TagNumber(5)
  void clearSourceAccountId() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get transactionPin => $_getSZ(5);
  @$pb.TagNumber(6)
  set transactionPin($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasTransactionPin() => $_has(5);
  @$pb.TagNumber(6)
  void clearTransactionPin() => $_clearField(6);
}

class SendMoneyTagPayResponse extends $pb.GeneratedMessage {
  factory SendMoneyTagPayResponse({
    $core.bool? success,
    $core.String? message,
    TagPayTransaction? transaction,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (transaction != null) result.transaction = transaction;
    return result;
  }

  SendMoneyTagPayResponse._();

  factory SendMoneyTagPayResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SendMoneyTagPayResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SendMoneyTagPayResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<TagPayTransaction>(3, _omitFieldNames ? '' : 'transaction',
        subBuilder: TagPayTransaction.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SendMoneyTagPayResponse clone() =>
      SendMoneyTagPayResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SendMoneyTagPayResponse copyWith(
          void Function(SendMoneyTagPayResponse) updates) =>
      super.copyWith((message) => updates(message as SendMoneyTagPayResponse))
          as SendMoneyTagPayResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SendMoneyTagPayResponse create() => SendMoneyTagPayResponse._();
  @$core.override
  SendMoneyTagPayResponse createEmptyInstance() => create();
  static $pb.PbList<SendMoneyTagPayResponse> createRepeated() =>
      $pb.PbList<SendMoneyTagPayResponse>();
  @$core.pragma('dart2js:noInline')
  static SendMoneyTagPayResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SendMoneyTagPayResponse>(create);
  static SendMoneyTagPayResponse? _defaultInstance;

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
  TagPayTransaction get transaction => $_getN(2);
  @$pb.TagNumber(3)
  set transaction(TagPayTransaction value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasTransaction() => $_has(2);
  @$pb.TagNumber(3)
  void clearTransaction() => $_clearField(3);
  @$pb.TagNumber(3)
  TagPayTransaction ensureTransaction() => $_ensure(2);
}

class RequestMoneyTagPayRequest extends $pb.GeneratedMessage {
  factory RequestMoneyTagPayRequest({
    $core.String? requesteeTagPay,
    $core.double? amount,
    $core.String? currency,
    $core.String? description,
  }) {
    final result = create();
    if (requesteeTagPay != null) result.requesteeTagPay = requesteeTagPay;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    if (description != null) result.description = description;
    return result;
  }

  RequestMoneyTagPayRequest._();

  factory RequestMoneyTagPayRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RequestMoneyTagPayRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RequestMoneyTagPayRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'requesteeTagPay')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(3, _omitFieldNames ? '' : 'currency')
    ..aOS(4, _omitFieldNames ? '' : 'description')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RequestMoneyTagPayRequest clone() =>
      RequestMoneyTagPayRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RequestMoneyTagPayRequest copyWith(
          void Function(RequestMoneyTagPayRequest) updates) =>
      super.copyWith((message) => updates(message as RequestMoneyTagPayRequest))
          as RequestMoneyTagPayRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RequestMoneyTagPayRequest create() => RequestMoneyTagPayRequest._();
  @$core.override
  RequestMoneyTagPayRequest createEmptyInstance() => create();
  static $pb.PbList<RequestMoneyTagPayRequest> createRepeated() =>
      $pb.PbList<RequestMoneyTagPayRequest>();
  @$core.pragma('dart2js:noInline')
  static RequestMoneyTagPayRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RequestMoneyTagPayRequest>(create);
  static RequestMoneyTagPayRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get requesteeTagPay => $_getSZ(0);
  @$pb.TagNumber(1)
  set requesteeTagPay($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRequesteeTagPay() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequesteeTagPay() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get amount => $_getN(1);
  @$pb.TagNumber(2)
  set amount($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get currency => $_getSZ(2);
  @$pb.TagNumber(3)
  set currency($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCurrency() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrency() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get description => $_getSZ(3);
  @$pb.TagNumber(4)
  set description($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDescription() => $_has(3);
  @$pb.TagNumber(4)
  void clearDescription() => $_clearField(4);
}

class RequestMoneyTagPayResponse extends $pb.GeneratedMessage {
  factory RequestMoneyTagPayResponse({
    $core.bool? success,
    $core.String? message,
    MoneyRequest? moneyRequest,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (moneyRequest != null) result.moneyRequest = moneyRequest;
    return result;
  }

  RequestMoneyTagPayResponse._();

  factory RequestMoneyTagPayResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RequestMoneyTagPayResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RequestMoneyTagPayResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<MoneyRequest>(3, _omitFieldNames ? '' : 'moneyRequest',
        subBuilder: MoneyRequest.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RequestMoneyTagPayResponse clone() =>
      RequestMoneyTagPayResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RequestMoneyTagPayResponse copyWith(
          void Function(RequestMoneyTagPayResponse) updates) =>
      super.copyWith(
              (message) => updates(message as RequestMoneyTagPayResponse))
          as RequestMoneyTagPayResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RequestMoneyTagPayResponse create() => RequestMoneyTagPayResponse._();
  @$core.override
  RequestMoneyTagPayResponse createEmptyInstance() => create();
  static $pb.PbList<RequestMoneyTagPayResponse> createRepeated() =>
      $pb.PbList<RequestMoneyTagPayResponse>();
  @$core.pragma('dart2js:noInline')
  static RequestMoneyTagPayResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RequestMoneyTagPayResponse>(create);
  static RequestMoneyTagPayResponse? _defaultInstance;

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
  MoneyRequest get moneyRequest => $_getN(2);
  @$pb.TagNumber(3)
  set moneyRequest(MoneyRequest value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasMoneyRequest() => $_has(2);
  @$pb.TagNumber(3)
  void clearMoneyRequest() => $_clearField(3);
  @$pb.TagNumber(3)
  MoneyRequest ensureMoneyRequest() => $_ensure(2);
}

class GetTagPayTransactionsRequest extends $pb.GeneratedMessage {
  factory GetTagPayTransactionsRequest({
    $core.int? page,
    $core.int? limit,
    TagPayTransactionType? type,
  }) {
    final result = create();
    if (page != null) result.page = page;
    if (limit != null) result.limit = limit;
    if (type != null) result.type = type;
    return result;
  }

  GetTagPayTransactionsRequest._();

  factory GetTagPayTransactionsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTagPayTransactionsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetTagPayTransactionsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..e<TagPayTransactionType>(
        3, _omitFieldNames ? '' : 'type', $pb.PbFieldType.OE,
        defaultOrMaker: TagPayTransactionType.TAG_PAY_TRANSACTION_TYPE_SEND,
        valueOf: TagPayTransactionType.valueOf,
        enumValues: TagPayTransactionType.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTagPayTransactionsRequest clone() =>
      GetTagPayTransactionsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTagPayTransactionsRequest copyWith(
          void Function(GetTagPayTransactionsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetTagPayTransactionsRequest))
          as GetTagPayTransactionsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTagPayTransactionsRequest create() =>
      GetTagPayTransactionsRequest._();
  @$core.override
  GetTagPayTransactionsRequest createEmptyInstance() => create();
  static $pb.PbList<GetTagPayTransactionsRequest> createRepeated() =>
      $pb.PbList<GetTagPayTransactionsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetTagPayTransactionsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetTagPayTransactionsRequest>(create);
  static GetTagPayTransactionsRequest? _defaultInstance;

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
  TagPayTransactionType get type => $_getN(2);
  @$pb.TagNumber(3)
  set type(TagPayTransactionType value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasType() => $_has(2);
  @$pb.TagNumber(3)
  void clearType() => $_clearField(3);
}

class GetTagPayTransactionsResponse extends $pb.GeneratedMessage {
  factory GetTagPayTransactionsResponse({
    $core.Iterable<TagPayTransaction>? transactions,
    $core.int? total,
    $core.int? page,
    $core.int? totalPages,
  }) {
    final result = create();
    if (transactions != null) result.transactions.addAll(transactions);
    if (total != null) result.total = total;
    if (page != null) result.page = page;
    if (totalPages != null) result.totalPages = totalPages;
    return result;
  }

  GetTagPayTransactionsResponse._();

  factory GetTagPayTransactionsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTagPayTransactionsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetTagPayTransactionsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<TagPayTransaction>(
        1, _omitFieldNames ? '' : 'transactions', $pb.PbFieldType.PM,
        subBuilder: TagPayTransaction.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'totalPages', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTagPayTransactionsResponse clone() =>
      GetTagPayTransactionsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTagPayTransactionsResponse copyWith(
          void Function(GetTagPayTransactionsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetTagPayTransactionsResponse))
          as GetTagPayTransactionsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTagPayTransactionsResponse create() =>
      GetTagPayTransactionsResponse._();
  @$core.override
  GetTagPayTransactionsResponse createEmptyInstance() => create();
  static $pb.PbList<GetTagPayTransactionsResponse> createRepeated() =>
      $pb.PbList<GetTagPayTransactionsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetTagPayTransactionsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetTagPayTransactionsResponse>(create);
  static GetTagPayTransactionsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<TagPayTransaction> get transactions => $_getList(0);

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

class AcceptMoneyRequestRequest extends $pb.GeneratedMessage {
  factory AcceptMoneyRequestRequest({
    $core.String? requestId,
    $core.String? sourceAccountId,
    $core.String? transactionPin,
  }) {
    final result = create();
    if (requestId != null) result.requestId = requestId;
    if (sourceAccountId != null) result.sourceAccountId = sourceAccountId;
    if (transactionPin != null) result.transactionPin = transactionPin;
    return result;
  }

  AcceptMoneyRequestRequest._();

  factory AcceptMoneyRequestRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AcceptMoneyRequestRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AcceptMoneyRequestRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'requestId')
    ..aOS(2, _omitFieldNames ? '' : 'sourceAccountId')
    ..aOS(3, _omitFieldNames ? '' : 'transactionPin')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AcceptMoneyRequestRequest clone() =>
      AcceptMoneyRequestRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AcceptMoneyRequestRequest copyWith(
          void Function(AcceptMoneyRequestRequest) updates) =>
      super.copyWith((message) => updates(message as AcceptMoneyRequestRequest))
          as AcceptMoneyRequestRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AcceptMoneyRequestRequest create() => AcceptMoneyRequestRequest._();
  @$core.override
  AcceptMoneyRequestRequest createEmptyInstance() => create();
  static $pb.PbList<AcceptMoneyRequestRequest> createRepeated() =>
      $pb.PbList<AcceptMoneyRequestRequest>();
  @$core.pragma('dart2js:noInline')
  static AcceptMoneyRequestRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AcceptMoneyRequestRequest>(create);
  static AcceptMoneyRequestRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get requestId => $_getSZ(0);
  @$pb.TagNumber(1)
  set requestId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRequestId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequestId() => $_clearField(1);

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

class AcceptMoneyRequestResponse extends $pb.GeneratedMessage {
  factory AcceptMoneyRequestResponse({
    $core.bool? success,
    $core.String? message,
    TagPayTransaction? transaction,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (transaction != null) result.transaction = transaction;
    return result;
  }

  AcceptMoneyRequestResponse._();

  factory AcceptMoneyRequestResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AcceptMoneyRequestResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AcceptMoneyRequestResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<TagPayTransaction>(3, _omitFieldNames ? '' : 'transaction',
        subBuilder: TagPayTransaction.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AcceptMoneyRequestResponse clone() =>
      AcceptMoneyRequestResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AcceptMoneyRequestResponse copyWith(
          void Function(AcceptMoneyRequestResponse) updates) =>
      super.copyWith(
              (message) => updates(message as AcceptMoneyRequestResponse))
          as AcceptMoneyRequestResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AcceptMoneyRequestResponse create() => AcceptMoneyRequestResponse._();
  @$core.override
  AcceptMoneyRequestResponse createEmptyInstance() => create();
  static $pb.PbList<AcceptMoneyRequestResponse> createRepeated() =>
      $pb.PbList<AcceptMoneyRequestResponse>();
  @$core.pragma('dart2js:noInline')
  static AcceptMoneyRequestResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AcceptMoneyRequestResponse>(create);
  static AcceptMoneyRequestResponse? _defaultInstance;

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
  TagPayTransaction get transaction => $_getN(2);
  @$pb.TagNumber(3)
  set transaction(TagPayTransaction value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasTransaction() => $_has(2);
  @$pb.TagNumber(3)
  void clearTransaction() => $_clearField(3);
  @$pb.TagNumber(3)
  TagPayTransaction ensureTransaction() => $_ensure(2);
}

class DeclineMoneyRequestRequest extends $pb.GeneratedMessage {
  factory DeclineMoneyRequestRequest({
    $core.String? requestId,
    $core.String? reason,
  }) {
    final result = create();
    if (requestId != null) result.requestId = requestId;
    if (reason != null) result.reason = reason;
    return result;
  }

  DeclineMoneyRequestRequest._();

  factory DeclineMoneyRequestRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeclineMoneyRequestRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeclineMoneyRequestRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'requestId')
    ..aOS(2, _omitFieldNames ? '' : 'reason')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeclineMoneyRequestRequest clone() =>
      DeclineMoneyRequestRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeclineMoneyRequestRequest copyWith(
          void Function(DeclineMoneyRequestRequest) updates) =>
      super.copyWith(
              (message) => updates(message as DeclineMoneyRequestRequest))
          as DeclineMoneyRequestRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeclineMoneyRequestRequest create() => DeclineMoneyRequestRequest._();
  @$core.override
  DeclineMoneyRequestRequest createEmptyInstance() => create();
  static $pb.PbList<DeclineMoneyRequestRequest> createRepeated() =>
      $pb.PbList<DeclineMoneyRequestRequest>();
  @$core.pragma('dart2js:noInline')
  static DeclineMoneyRequestRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeclineMoneyRequestRequest>(create);
  static DeclineMoneyRequestRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get requestId => $_getSZ(0);
  @$pb.TagNumber(1)
  set requestId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRequestId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequestId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get reason => $_getSZ(1);
  @$pb.TagNumber(2)
  set reason($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasReason() => $_has(1);
  @$pb.TagNumber(2)
  void clearReason() => $_clearField(2);
}

class DeclineMoneyRequestResponse extends $pb.GeneratedMessage {
  factory DeclineMoneyRequestResponse({
    $core.bool? success,
    $core.String? message,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    return result;
  }

  DeclineMoneyRequestResponse._();

  factory DeclineMoneyRequestResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeclineMoneyRequestResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeclineMoneyRequestResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeclineMoneyRequestResponse clone() =>
      DeclineMoneyRequestResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeclineMoneyRequestResponse copyWith(
          void Function(DeclineMoneyRequestResponse) updates) =>
      super.copyWith(
              (message) => updates(message as DeclineMoneyRequestResponse))
          as DeclineMoneyRequestResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeclineMoneyRequestResponse create() =>
      DeclineMoneyRequestResponse._();
  @$core.override
  DeclineMoneyRequestResponse createEmptyInstance() => create();
  static $pb.PbList<DeclineMoneyRequestResponse> createRepeated() =>
      $pb.PbList<DeclineMoneyRequestResponse>();
  @$core.pragma('dart2js:noInline')
  static DeclineMoneyRequestResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeclineMoneyRequestResponse>(create);
  static DeclineMoneyRequestResponse? _defaultInstance;

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

class GetPendingMoneyRequestsRequest extends $pb.GeneratedMessage {
  factory GetPendingMoneyRequestsRequest({
    $core.int? page,
    $core.int? limit,
    $core.bool? incoming,
  }) {
    final result = create();
    if (page != null) result.page = page;
    if (limit != null) result.limit = limit;
    if (incoming != null) result.incoming = incoming;
    return result;
  }

  GetPendingMoneyRequestsRequest._();

  factory GetPendingMoneyRequestsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetPendingMoneyRequestsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetPendingMoneyRequestsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..aOB(3, _omitFieldNames ? '' : 'incoming')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPendingMoneyRequestsRequest clone() =>
      GetPendingMoneyRequestsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPendingMoneyRequestsRequest copyWith(
          void Function(GetPendingMoneyRequestsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetPendingMoneyRequestsRequest))
          as GetPendingMoneyRequestsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPendingMoneyRequestsRequest create() =>
      GetPendingMoneyRequestsRequest._();
  @$core.override
  GetPendingMoneyRequestsRequest createEmptyInstance() => create();
  static $pb.PbList<GetPendingMoneyRequestsRequest> createRepeated() =>
      $pb.PbList<GetPendingMoneyRequestsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetPendingMoneyRequestsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetPendingMoneyRequestsRequest>(create);
  static GetPendingMoneyRequestsRequest? _defaultInstance;

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
  $core.bool get incoming => $_getBF(2);
  @$pb.TagNumber(3)
  set incoming($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasIncoming() => $_has(2);
  @$pb.TagNumber(3)
  void clearIncoming() => $_clearField(3);
}

class GetPendingMoneyRequestsResponse extends $pb.GeneratedMessage {
  factory GetPendingMoneyRequestsResponse({
    $core.Iterable<MoneyRequest>? requests,
    $core.int? total,
    $core.int? page,
    $core.int? totalPages,
  }) {
    final result = create();
    if (requests != null) result.requests.addAll(requests);
    if (total != null) result.total = total;
    if (page != null) result.page = page;
    if (totalPages != null) result.totalPages = totalPages;
    return result;
  }

  GetPendingMoneyRequestsResponse._();

  factory GetPendingMoneyRequestsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetPendingMoneyRequestsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetPendingMoneyRequestsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<MoneyRequest>(1, _omitFieldNames ? '' : 'requests', $pb.PbFieldType.PM,
        subBuilder: MoneyRequest.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'totalPages', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPendingMoneyRequestsResponse clone() =>
      GetPendingMoneyRequestsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPendingMoneyRequestsResponse copyWith(
          void Function(GetPendingMoneyRequestsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetPendingMoneyRequestsResponse))
          as GetPendingMoneyRequestsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPendingMoneyRequestsResponse create() =>
      GetPendingMoneyRequestsResponse._();
  @$core.override
  GetPendingMoneyRequestsResponse createEmptyInstance() => create();
  static $pb.PbList<GetPendingMoneyRequestsResponse> createRepeated() =>
      $pb.PbList<GetPendingMoneyRequestsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetPendingMoneyRequestsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetPendingMoneyRequestsResponse>(
          create);
  static GetPendingMoneyRequestsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<MoneyRequest> get requests => $_getList(0);

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

class CreateTagRequest extends $pb.GeneratedMessage {
  factory CreateTagRequest({
    $core.String? taggedUserTagPay,
    $core.double? amount,
    $core.String? currency,
    $core.String? description,
  }) {
    final result = create();
    if (taggedUserTagPay != null) result.taggedUserTagPay = taggedUserTagPay;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    if (description != null) result.description = description;
    return result;
  }

  CreateTagRequest._();

  factory CreateTagRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateTagRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateTagRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'taggedUserTagPay')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(3, _omitFieldNames ? '' : 'currency')
    ..aOS(4, _omitFieldNames ? '' : 'description')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateTagRequest clone() => CreateTagRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateTagRequest copyWith(void Function(CreateTagRequest) updates) =>
      super.copyWith((message) => updates(message as CreateTagRequest))
          as CreateTagRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateTagRequest create() => CreateTagRequest._();
  @$core.override
  CreateTagRequest createEmptyInstance() => create();
  static $pb.PbList<CreateTagRequest> createRepeated() =>
      $pb.PbList<CreateTagRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateTagRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateTagRequest>(create);
  static CreateTagRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get taggedUserTagPay => $_getSZ(0);
  @$pb.TagNumber(1)
  set taggedUserTagPay($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTaggedUserTagPay() => $_has(0);
  @$pb.TagNumber(1)
  void clearTaggedUserTagPay() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get amount => $_getN(1);
  @$pb.TagNumber(2)
  set amount($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get currency => $_getSZ(2);
  @$pb.TagNumber(3)
  set currency($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCurrency() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrency() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get description => $_getSZ(3);
  @$pb.TagNumber(4)
  set description($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDescription() => $_has(3);
  @$pb.TagNumber(4)
  void clearDescription() => $_clearField(4);
}

class CreateTagResponse extends $pb.GeneratedMessage {
  factory CreateTagResponse({
    $core.bool? success,
    $core.String? message,
    UserTag? tag,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (tag != null) result.tag = tag;
    return result;
  }

  CreateTagResponse._();

  factory CreateTagResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateTagResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateTagResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<UserTag>(3, _omitFieldNames ? '' : 'tag', subBuilder: UserTag.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateTagResponse clone() => CreateTagResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateTagResponse copyWith(void Function(CreateTagResponse) updates) =>
      super.copyWith((message) => updates(message as CreateTagResponse))
          as CreateTagResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateTagResponse create() => CreateTagResponse._();
  @$core.override
  CreateTagResponse createEmptyInstance() => create();
  static $pb.PbList<CreateTagResponse> createRepeated() =>
      $pb.PbList<CreateTagResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateTagResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateTagResponse>(create);
  static CreateTagResponse? _defaultInstance;

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
  UserTag get tag => $_getN(2);
  @$pb.TagNumber(3)
  set tag(UserTag value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasTag() => $_has(2);
  @$pb.TagNumber(3)
  void clearTag() => $_clearField(3);
  @$pb.TagNumber(3)
  UserTag ensureTag() => $_ensure(2);
}

class GetMyTagsRequest extends $pb.GeneratedMessage {
  factory GetMyTagsRequest({
    $core.int? page,
    $core.int? limit,
    TagStatus? status,
  }) {
    final result = create();
    if (page != null) result.page = page;
    if (limit != null) result.limit = limit;
    if (status != null) result.status = status;
    return result;
  }

  GetMyTagsRequest._();

  factory GetMyTagsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMyTagsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMyTagsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..e<TagStatus>(3, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: TagStatus.TAG_STATUS_PENDING,
        valueOf: TagStatus.valueOf,
        enumValues: TagStatus.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyTagsRequest clone() => GetMyTagsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyTagsRequest copyWith(void Function(GetMyTagsRequest) updates) =>
      super.copyWith((message) => updates(message as GetMyTagsRequest))
          as GetMyTagsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMyTagsRequest create() => GetMyTagsRequest._();
  @$core.override
  GetMyTagsRequest createEmptyInstance() => create();
  static $pb.PbList<GetMyTagsRequest> createRepeated() =>
      $pb.PbList<GetMyTagsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMyTagsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetMyTagsRequest>(create);
  static GetMyTagsRequest? _defaultInstance;

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
  TagStatus get status => $_getN(2);
  @$pb.TagNumber(3)
  set status(TagStatus value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasStatus() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatus() => $_clearField(3);
}

class GetMyTagsResponse extends $pb.GeneratedMessage {
  factory GetMyTagsResponse({
    $core.Iterable<UserTag>? tags,
    $core.int? total,
    $core.int? page,
    $core.int? totalPages,
  }) {
    final result = create();
    if (tags != null) result.tags.addAll(tags);
    if (total != null) result.total = total;
    if (page != null) result.page = page;
    if (totalPages != null) result.totalPages = totalPages;
    return result;
  }

  GetMyTagsResponse._();

  factory GetMyTagsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMyTagsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMyTagsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<UserTag>(1, _omitFieldNames ? '' : 'tags', $pb.PbFieldType.PM,
        subBuilder: UserTag.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'totalPages', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyTagsResponse clone() => GetMyTagsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyTagsResponse copyWith(void Function(GetMyTagsResponse) updates) =>
      super.copyWith((message) => updates(message as GetMyTagsResponse))
          as GetMyTagsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMyTagsResponse create() => GetMyTagsResponse._();
  @$core.override
  GetMyTagsResponse createEmptyInstance() => create();
  static $pb.PbList<GetMyTagsResponse> createRepeated() =>
      $pb.PbList<GetMyTagsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMyTagsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetMyTagsResponse>(create);
  static GetMyTagsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<UserTag> get tags => $_getList(0);

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

class PayTagRequest extends $pb.GeneratedMessage {
  factory PayTagRequest({
    $core.String? tagId,
    $core.String? sourceAccountId,
    $core.String? transactionPin,
  }) {
    final result = create();
    if (tagId != null) result.tagId = tagId;
    if (sourceAccountId != null) result.sourceAccountId = sourceAccountId;
    if (transactionPin != null) result.transactionPin = transactionPin;
    return result;
  }

  PayTagRequest._();

  factory PayTagRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PayTagRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PayTagRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'tagId')
    ..aOS(2, _omitFieldNames ? '' : 'sourceAccountId')
    ..aOS(3, _omitFieldNames ? '' : 'transactionPin')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PayTagRequest clone() => PayTagRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PayTagRequest copyWith(void Function(PayTagRequest) updates) =>
      super.copyWith((message) => updates(message as PayTagRequest))
          as PayTagRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PayTagRequest create() => PayTagRequest._();
  @$core.override
  PayTagRequest createEmptyInstance() => create();
  static $pb.PbList<PayTagRequest> createRepeated() =>
      $pb.PbList<PayTagRequest>();
  @$core.pragma('dart2js:noInline')
  static PayTagRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PayTagRequest>(create);
  static PayTagRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get tagId => $_getSZ(0);
  @$pb.TagNumber(1)
  set tagId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTagId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTagId() => $_clearField(1);

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

class PayTagResponse extends $pb.GeneratedMessage {
  factory PayTagResponse({
    $core.bool? success,
    $core.String? message,
    TagPayTransaction? transaction,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (transaction != null) result.transaction = transaction;
    return result;
  }

  PayTagResponse._();

  factory PayTagResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PayTagResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PayTagResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<TagPayTransaction>(3, _omitFieldNames ? '' : 'transaction',
        subBuilder: TagPayTransaction.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PayTagResponse clone() => PayTagResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PayTagResponse copyWith(void Function(PayTagResponse) updates) =>
      super.copyWith((message) => updates(message as PayTagResponse))
          as PayTagResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PayTagResponse create() => PayTagResponse._();
  @$core.override
  PayTagResponse createEmptyInstance() => create();
  static $pb.PbList<PayTagResponse> createRepeated() =>
      $pb.PbList<PayTagResponse>();
  @$core.pragma('dart2js:noInline')
  static PayTagResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PayTagResponse>(create);
  static PayTagResponse? _defaultInstance;

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
  TagPayTransaction get transaction => $_getN(2);
  @$pb.TagNumber(3)
  set transaction(TagPayTransaction value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasTransaction() => $_has(2);
  @$pb.TagNumber(3)
  void clearTransaction() => $_clearField(3);
  @$pb.TagNumber(3)
  TagPayTransaction ensureTransaction() => $_ensure(2);
}

class SearchUsersForTagRequest extends $pb.GeneratedMessage {
  factory SearchUsersForTagRequest({
    $core.String? query,
    $core.int? limit,
  }) {
    final result = create();
    if (query != null) result.query = query;
    if (limit != null) result.limit = limit;
    return result;
  }

  SearchUsersForTagRequest._();

  factory SearchUsersForTagRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SearchUsersForTagRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SearchUsersForTagRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'query')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchUsersForTagRequest clone() =>
      SearchUsersForTagRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchUsersForTagRequest copyWith(
          void Function(SearchUsersForTagRequest) updates) =>
      super.copyWith((message) => updates(message as SearchUsersForTagRequest))
          as SearchUsersForTagRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SearchUsersForTagRequest create() => SearchUsersForTagRequest._();
  @$core.override
  SearchUsersForTagRequest createEmptyInstance() => create();
  static $pb.PbList<SearchUsersForTagRequest> createRepeated() =>
      $pb.PbList<SearchUsersForTagRequest>();
  @$core.pragma('dart2js:noInline')
  static SearchUsersForTagRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SearchUsersForTagRequest>(create);
  static SearchUsersForTagRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get query => $_getSZ(0);
  @$pb.TagNumber(1)
  set query($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasQuery() => $_has(0);
  @$pb.TagNumber(1)
  void clearQuery() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get limit => $_getIZ(1);
  @$pb.TagNumber(2)
  set limit($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearLimit() => $_clearField(2);
}

class UserSearchResult extends $pb.GeneratedMessage {
  factory UserSearchResult({
    $core.String? userId,
    $core.String? username,
    $core.String? firstName,
    $core.String? lastName,
    $core.String? email,
    $core.String? profilePicture,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    if (username != null) result.username = username;
    if (firstName != null) result.firstName = firstName;
    if (lastName != null) result.lastName = lastName;
    if (email != null) result.email = email;
    if (profilePicture != null) result.profilePicture = profilePicture;
    return result;
  }

  UserSearchResult._();

  factory UserSearchResult.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UserSearchResult.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UserSearchResult',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'username')
    ..aOS(3, _omitFieldNames ? '' : 'firstName')
    ..aOS(4, _omitFieldNames ? '' : 'lastName')
    ..aOS(5, _omitFieldNames ? '' : 'email')
    ..aOS(6, _omitFieldNames ? '' : 'profilePicture')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserSearchResult clone() => UserSearchResult()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserSearchResult copyWith(void Function(UserSearchResult) updates) =>
      super.copyWith((message) => updates(message as UserSearchResult))
          as UserSearchResult;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UserSearchResult create() => UserSearchResult._();
  @$core.override
  UserSearchResult createEmptyInstance() => create();
  static $pb.PbList<UserSearchResult> createRepeated() =>
      $pb.PbList<UserSearchResult>();
  @$core.pragma('dart2js:noInline')
  static UserSearchResult getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UserSearchResult>(create);
  static UserSearchResult? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get username => $_getSZ(1);
  @$pb.TagNumber(2)
  set username($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUsername() => $_has(1);
  @$pb.TagNumber(2)
  void clearUsername() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get firstName => $_getSZ(2);
  @$pb.TagNumber(3)
  set firstName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasFirstName() => $_has(2);
  @$pb.TagNumber(3)
  void clearFirstName() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get lastName => $_getSZ(3);
  @$pb.TagNumber(4)
  set lastName($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasLastName() => $_has(3);
  @$pb.TagNumber(4)
  void clearLastName() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get email => $_getSZ(4);
  @$pb.TagNumber(5)
  set email($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasEmail() => $_has(4);
  @$pb.TagNumber(5)
  void clearEmail() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get profilePicture => $_getSZ(5);
  @$pb.TagNumber(6)
  set profilePicture($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasProfilePicture() => $_has(5);
  @$pb.TagNumber(6)
  void clearProfilePicture() => $_clearField(6);
}

class SearchUsersForTagResponse extends $pb.GeneratedMessage {
  factory SearchUsersForTagResponse({
    $core.Iterable<UserSearchResult>? users,
  }) {
    final result = create();
    if (users != null) result.users.addAll(users);
    return result;
  }

  SearchUsersForTagResponse._();

  factory SearchUsersForTagResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SearchUsersForTagResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SearchUsersForTagResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<UserSearchResult>(
        1, _omitFieldNames ? '' : 'users', $pb.PbFieldType.PM,
        subBuilder: UserSearchResult.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchUsersForTagResponse clone() =>
      SearchUsersForTagResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchUsersForTagResponse copyWith(
          void Function(SearchUsersForTagResponse) updates) =>
      super.copyWith((message) => updates(message as SearchUsersForTagResponse))
          as SearchUsersForTagResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SearchUsersForTagResponse create() => SearchUsersForTagResponse._();
  @$core.override
  SearchUsersForTagResponse createEmptyInstance() => create();
  static $pb.PbList<SearchUsersForTagResponse> createRepeated() =>
      $pb.PbList<SearchUsersForTagResponse>();
  @$core.pragma('dart2js:noInline')
  static SearchUsersForTagResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SearchUsersForTagResponse>(create);
  static SearchUsersForTagResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<UserSearchResult> get users => $_getList(0);
}

class BatchCreateTagsRequest extends $pb.GeneratedMessage {
  factory BatchCreateTagsRequest({
    $core.Iterable<$core.String>? taggedUserTagPays,
    $core.double? amount,
    $core.String? currency,
    $core.String? description,
  }) {
    final result = create();
    if (taggedUserTagPays != null)
      result.taggedUserTagPays.addAll(taggedUserTagPays);
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    if (description != null) result.description = description;
    return result;
  }

  BatchCreateTagsRequest._();

  factory BatchCreateTagsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory BatchCreateTagsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BatchCreateTagsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'taggedUserTagPays')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(3, _omitFieldNames ? '' : 'currency')
    ..aOS(4, _omitFieldNames ? '' : 'description')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BatchCreateTagsRequest clone() =>
      BatchCreateTagsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BatchCreateTagsRequest copyWith(
          void Function(BatchCreateTagsRequest) updates) =>
      super.copyWith((message) => updates(message as BatchCreateTagsRequest))
          as BatchCreateTagsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BatchCreateTagsRequest create() => BatchCreateTagsRequest._();
  @$core.override
  BatchCreateTagsRequest createEmptyInstance() => create();
  static $pb.PbList<BatchCreateTagsRequest> createRepeated() =>
      $pb.PbList<BatchCreateTagsRequest>();
  @$core.pragma('dart2js:noInline')
  static BatchCreateTagsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BatchCreateTagsRequest>(create);
  static BatchCreateTagsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$core.String> get taggedUserTagPays => $_getList(0);

  @$pb.TagNumber(2)
  $core.double get amount => $_getN(1);
  @$pb.TagNumber(2)
  set amount($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get currency => $_getSZ(2);
  @$pb.TagNumber(3)
  set currency($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCurrency() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrency() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get description => $_getSZ(3);
  @$pb.TagNumber(4)
  set description($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDescription() => $_has(3);
  @$pb.TagNumber(4)
  void clearDescription() => $_clearField(4);
}

class BatchCreateTagsResponse extends $pb.GeneratedMessage {
  factory BatchCreateTagsResponse({
    $core.bool? success,
    $core.String? message,
    $core.Iterable<UserTag>? tags,
    $core.Iterable<$core.String>? failedUsers,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (tags != null) result.tags.addAll(tags);
    if (failedUsers != null) result.failedUsers.addAll(failedUsers);
    return result;
  }

  BatchCreateTagsResponse._();

  factory BatchCreateTagsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory BatchCreateTagsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BatchCreateTagsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..pc<UserTag>(3, _omitFieldNames ? '' : 'tags', $pb.PbFieldType.PM,
        subBuilder: UserTag.create)
    ..pPS(4, _omitFieldNames ? '' : 'failedUsers')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BatchCreateTagsResponse clone() =>
      BatchCreateTagsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BatchCreateTagsResponse copyWith(
          void Function(BatchCreateTagsResponse) updates) =>
      super.copyWith((message) => updates(message as BatchCreateTagsResponse))
          as BatchCreateTagsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BatchCreateTagsResponse create() => BatchCreateTagsResponse._();
  @$core.override
  BatchCreateTagsResponse createEmptyInstance() => create();
  static $pb.PbList<BatchCreateTagsResponse> createRepeated() =>
      $pb.PbList<BatchCreateTagsResponse>();
  @$core.pragma('dart2js:noInline')
  static BatchCreateTagsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BatchCreateTagsResponse>(create);
  static BatchCreateTagsResponse? _defaultInstance;

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
  $pb.PbList<UserTag> get tags => $_getList(2);

  @$pb.TagNumber(4)
  $pb.PbList<$core.String> get failedUsers => $_getList(3);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
