///
//  Generated code. Do not modify.
//  source: tag_pay.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/timestamp.pb.dart' as $26;

import 'tag_pay.pbenum.dart';

export 'tag_pay.pbenum.dart';

class TagPay extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TagPay', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'tagPay')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'displayName')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'avatarUrl')
    ..aOB(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isActive')
    ..aOM<$26.Timestamp>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $26.Timestamp.create)
    ..aOM<$26.Timestamp>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedAt', subBuilder: $26.Timestamp.create)
    ..hasRequiredFields = false
  ;

  TagPay._() : super();
  factory TagPay({
    $core.String? id,
    $core.String? userId,
    $core.String? tagPay,
    $core.String? displayName,
    $core.String? avatarUrl,
    $core.bool? isActive,
    $26.Timestamp? createdAt,
    $26.Timestamp? updatedAt,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    if (tagPay != null) {
      _result.tagPay = tagPay;
    }
    if (displayName != null) {
      _result.displayName = displayName;
    }
    if (avatarUrl != null) {
      _result.avatarUrl = avatarUrl;
    }
    if (isActive != null) {
      _result.isActive = isActive;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      _result.updatedAt = updatedAt;
    }
    return _result;
  }
  factory TagPay.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TagPay.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TagPay clone() => TagPay()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TagPay copyWith(void Function(TagPay) updates) => super.copyWith((message) => updates(message as TagPay)) as TagPay; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TagPay create() => TagPay._();
  TagPay createEmptyInstance() => create();
  static $pb.PbList<TagPay> createRepeated() => $pb.PbList<TagPay>();
  @$core.pragma('dart2js:noInline')
  static TagPay getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TagPay>(create);
  static TagPay? _defaultInstance;

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
  $core.String get tagPay => $_getSZ(2);
  @$pb.TagNumber(3)
  set tagPay($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTagPay() => $_has(2);
  @$pb.TagNumber(3)
  void clearTagPay() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get displayName => $_getSZ(3);
  @$pb.TagNumber(4)
  set displayName($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasDisplayName() => $_has(3);
  @$pb.TagNumber(4)
  void clearDisplayName() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get avatarUrl => $_getSZ(4);
  @$pb.TagNumber(5)
  set avatarUrl($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasAvatarUrl() => $_has(4);
  @$pb.TagNumber(5)
  void clearAvatarUrl() => clearField(5);

  @$pb.TagNumber(6)
  $core.bool get isActive => $_getBF(5);
  @$pb.TagNumber(6)
  set isActive($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasIsActive() => $_has(5);
  @$pb.TagNumber(6)
  void clearIsActive() => clearField(6);

  @$pb.TagNumber(7)
  $26.Timestamp get createdAt => $_getN(6);
  @$pb.TagNumber(7)
  set createdAt($26.Timestamp v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasCreatedAt() => $_has(6);
  @$pb.TagNumber(7)
  void clearCreatedAt() => clearField(7);
  @$pb.TagNumber(7)
  $26.Timestamp ensureCreatedAt() => $_ensure(6);

  @$pb.TagNumber(8)
  $26.Timestamp get updatedAt => $_getN(7);
  @$pb.TagNumber(8)
  set updatedAt($26.Timestamp v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasUpdatedAt() => $_has(7);
  @$pb.TagNumber(8)
  void clearUpdatedAt() => clearField(8);
  @$pb.TagNumber(8)
  $26.Timestamp ensureUpdatedAt() => $_ensure(7);
}

class TagPayTransaction extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TagPayTransaction', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'senderId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'senderTagPay')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'senderName')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'receiverId')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'receiverTagPay')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'receiverName')
    ..a<$core.double>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..e<TagPayTransactionStatus>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: TagPayTransactionStatus.TAG_PAY_TRANSACTION_STATUS_PENDING, valueOf: TagPayTransactionStatus.valueOf, enumValues: TagPayTransactionStatus.values)
    ..e<TagPayTransactionType>(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type', $pb.PbFieldType.OE, defaultOrMaker: TagPayTransactionType.TAG_PAY_TRANSACTION_TYPE_SEND, valueOf: TagPayTransactionType.valueOf, enumValues: TagPayTransactionType.values)
    ..aOS(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'referenceNumber')
    ..aOM<$26.Timestamp>(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $26.Timestamp.create)
    ..aOM<$26.Timestamp>(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'completedAt', subBuilder: $26.Timestamp.create)
    ..hasRequiredFields = false
  ;

  TagPayTransaction._() : super();
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
    $26.Timestamp? createdAt,
    $26.Timestamp? completedAt,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (senderId != null) {
      _result.senderId = senderId;
    }
    if (senderTagPay != null) {
      _result.senderTagPay = senderTagPay;
    }
    if (senderName != null) {
      _result.senderName = senderName;
    }
    if (receiverId != null) {
      _result.receiverId = receiverId;
    }
    if (receiverTagPay != null) {
      _result.receiverTagPay = receiverTagPay;
    }
    if (receiverName != null) {
      _result.receiverName = receiverName;
    }
    if (amount != null) {
      _result.amount = amount;
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
    if (type != null) {
      _result.type = type;
    }
    if (referenceNumber != null) {
      _result.referenceNumber = referenceNumber;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (completedAt != null) {
      _result.completedAt = completedAt;
    }
    return _result;
  }
  factory TagPayTransaction.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TagPayTransaction.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TagPayTransaction clone() => TagPayTransaction()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TagPayTransaction copyWith(void Function(TagPayTransaction) updates) => super.copyWith((message) => updates(message as TagPayTransaction)) as TagPayTransaction; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TagPayTransaction create() => TagPayTransaction._();
  TagPayTransaction createEmptyInstance() => create();
  static $pb.PbList<TagPayTransaction> createRepeated() => $pb.PbList<TagPayTransaction>();
  @$core.pragma('dart2js:noInline')
  static TagPayTransaction getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TagPayTransaction>(create);
  static TagPayTransaction? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get senderId => $_getSZ(1);
  @$pb.TagNumber(2)
  set senderId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSenderId() => $_has(1);
  @$pb.TagNumber(2)
  void clearSenderId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get senderTagPay => $_getSZ(2);
  @$pb.TagNumber(3)
  set senderTagPay($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSenderTagPay() => $_has(2);
  @$pb.TagNumber(3)
  void clearSenderTagPay() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get senderName => $_getSZ(3);
  @$pb.TagNumber(4)
  set senderName($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasSenderName() => $_has(3);
  @$pb.TagNumber(4)
  void clearSenderName() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get receiverId => $_getSZ(4);
  @$pb.TagNumber(5)
  set receiverId($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasReceiverId() => $_has(4);
  @$pb.TagNumber(5)
  void clearReceiverId() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get receiverTagPay => $_getSZ(5);
  @$pb.TagNumber(6)
  set receiverTagPay($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasReceiverTagPay() => $_has(5);
  @$pb.TagNumber(6)
  void clearReceiverTagPay() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get receiverName => $_getSZ(6);
  @$pb.TagNumber(7)
  set receiverName($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasReceiverName() => $_has(6);
  @$pb.TagNumber(7)
  void clearReceiverName() => clearField(7);

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
  TagPayTransactionStatus get status => $_getN(10);
  @$pb.TagNumber(11)
  set status(TagPayTransactionStatus v) { setField(11, v); }
  @$pb.TagNumber(11)
  $core.bool hasStatus() => $_has(10);
  @$pb.TagNumber(11)
  void clearStatus() => clearField(11);

  @$pb.TagNumber(12)
  TagPayTransactionType get type => $_getN(11);
  @$pb.TagNumber(12)
  set type(TagPayTransactionType v) { setField(12, v); }
  @$pb.TagNumber(12)
  $core.bool hasType() => $_has(11);
  @$pb.TagNumber(12)
  void clearType() => clearField(12);

  @$pb.TagNumber(13)
  $core.String get referenceNumber => $_getSZ(12);
  @$pb.TagNumber(13)
  set referenceNumber($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasReferenceNumber() => $_has(12);
  @$pb.TagNumber(13)
  void clearReferenceNumber() => clearField(13);

  @$pb.TagNumber(14)
  $26.Timestamp get createdAt => $_getN(13);
  @$pb.TagNumber(14)
  set createdAt($26.Timestamp v) { setField(14, v); }
  @$pb.TagNumber(14)
  $core.bool hasCreatedAt() => $_has(13);
  @$pb.TagNumber(14)
  void clearCreatedAt() => clearField(14);
  @$pb.TagNumber(14)
  $26.Timestamp ensureCreatedAt() => $_ensure(13);

  @$pb.TagNumber(15)
  $26.Timestamp get completedAt => $_getN(14);
  @$pb.TagNumber(15)
  set completedAt($26.Timestamp v) { setField(15, v); }
  @$pb.TagNumber(15)
  $core.bool hasCompletedAt() => $_has(14);
  @$pb.TagNumber(15)
  void clearCompletedAt() => clearField(15);
  @$pb.TagNumber(15)
  $26.Timestamp ensureCompletedAt() => $_ensure(14);
}

class MoneyRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MoneyRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'requesterId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'requesterTagPay')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'requesterName')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'requesteeId')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'requesteeTagPay')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'requesteeName')
    ..a<$core.double>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..e<MoneyRequestStatus>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: MoneyRequestStatus.MONEY_REQUEST_STATUS_PENDING, valueOf: MoneyRequestStatus.valueOf, enumValues: MoneyRequestStatus.values)
    ..aOM<$26.Timestamp>(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $26.Timestamp.create)
    ..aOM<$26.Timestamp>(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'respondedAt', subBuilder: $26.Timestamp.create)
    ..aOM<$26.Timestamp>(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'expiresAt', subBuilder: $26.Timestamp.create)
    ..hasRequiredFields = false
  ;

  MoneyRequest._() : super();
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
    $26.Timestamp? createdAt,
    $26.Timestamp? respondedAt,
    $26.Timestamp? expiresAt,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (requesterId != null) {
      _result.requesterId = requesterId;
    }
    if (requesterTagPay != null) {
      _result.requesterTagPay = requesterTagPay;
    }
    if (requesterName != null) {
      _result.requesterName = requesterName;
    }
    if (requesteeId != null) {
      _result.requesteeId = requesteeId;
    }
    if (requesteeTagPay != null) {
      _result.requesteeTagPay = requesteeTagPay;
    }
    if (requesteeName != null) {
      _result.requesteeName = requesteeName;
    }
    if (amount != null) {
      _result.amount = amount;
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
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (respondedAt != null) {
      _result.respondedAt = respondedAt;
    }
    if (expiresAt != null) {
      _result.expiresAt = expiresAt;
    }
    return _result;
  }
  factory MoneyRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MoneyRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MoneyRequest clone() => MoneyRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MoneyRequest copyWith(void Function(MoneyRequest) updates) => super.copyWith((message) => updates(message as MoneyRequest)) as MoneyRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MoneyRequest create() => MoneyRequest._();
  MoneyRequest createEmptyInstance() => create();
  static $pb.PbList<MoneyRequest> createRepeated() => $pb.PbList<MoneyRequest>();
  @$core.pragma('dart2js:noInline')
  static MoneyRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MoneyRequest>(create);
  static MoneyRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get requesterId => $_getSZ(1);
  @$pb.TagNumber(2)
  set requesterId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasRequesterId() => $_has(1);
  @$pb.TagNumber(2)
  void clearRequesterId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get requesterTagPay => $_getSZ(2);
  @$pb.TagNumber(3)
  set requesterTagPay($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasRequesterTagPay() => $_has(2);
  @$pb.TagNumber(3)
  void clearRequesterTagPay() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get requesterName => $_getSZ(3);
  @$pb.TagNumber(4)
  set requesterName($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasRequesterName() => $_has(3);
  @$pb.TagNumber(4)
  void clearRequesterName() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get requesteeId => $_getSZ(4);
  @$pb.TagNumber(5)
  set requesteeId($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasRequesteeId() => $_has(4);
  @$pb.TagNumber(5)
  void clearRequesteeId() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get requesteeTagPay => $_getSZ(5);
  @$pb.TagNumber(6)
  set requesteeTagPay($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasRequesteeTagPay() => $_has(5);
  @$pb.TagNumber(6)
  void clearRequesteeTagPay() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get requesteeName => $_getSZ(6);
  @$pb.TagNumber(7)
  set requesteeName($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasRequesteeName() => $_has(6);
  @$pb.TagNumber(7)
  void clearRequesteeName() => clearField(7);

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
  MoneyRequestStatus get status => $_getN(10);
  @$pb.TagNumber(11)
  set status(MoneyRequestStatus v) { setField(11, v); }
  @$pb.TagNumber(11)
  $core.bool hasStatus() => $_has(10);
  @$pb.TagNumber(11)
  void clearStatus() => clearField(11);

  @$pb.TagNumber(12)
  $26.Timestamp get createdAt => $_getN(11);
  @$pb.TagNumber(12)
  set createdAt($26.Timestamp v) { setField(12, v); }
  @$pb.TagNumber(12)
  $core.bool hasCreatedAt() => $_has(11);
  @$pb.TagNumber(12)
  void clearCreatedAt() => clearField(12);
  @$pb.TagNumber(12)
  $26.Timestamp ensureCreatedAt() => $_ensure(11);

  @$pb.TagNumber(13)
  $26.Timestamp get respondedAt => $_getN(12);
  @$pb.TagNumber(13)
  set respondedAt($26.Timestamp v) { setField(13, v); }
  @$pb.TagNumber(13)
  $core.bool hasRespondedAt() => $_has(12);
  @$pb.TagNumber(13)
  void clearRespondedAt() => clearField(13);
  @$pb.TagNumber(13)
  $26.Timestamp ensureRespondedAt() => $_ensure(12);

  @$pb.TagNumber(14)
  $26.Timestamp get expiresAt => $_getN(13);
  @$pb.TagNumber(14)
  set expiresAt($26.Timestamp v) { setField(14, v); }
  @$pb.TagNumber(14)
  $core.bool hasExpiresAt() => $_has(13);
  @$pb.TagNumber(14)
  void clearExpiresAt() => clearField(14);
  @$pb.TagNumber(14)
  $26.Timestamp ensureExpiresAt() => $_ensure(13);
}

class UserTag extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UserTag', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'taggerId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'taggerTagPay')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'taggerName')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'taggedUserId')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'taggedUserTagPay')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'taggedUserName')
    ..a<$core.double>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..e<TagStatus>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: TagStatus.TAG_STATUS_PENDING, valueOf: TagStatus.valueOf, enumValues: TagStatus.values)
    ..aOM<$26.Timestamp>(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $26.Timestamp.create)
    ..aOM<$26.Timestamp>(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'paidAt', subBuilder: $26.Timestamp.create)
    ..hasRequiredFields = false
  ;

  UserTag._() : super();
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
    $26.Timestamp? createdAt,
    $26.Timestamp? paidAt,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (taggerId != null) {
      _result.taggerId = taggerId;
    }
    if (taggerTagPay != null) {
      _result.taggerTagPay = taggerTagPay;
    }
    if (taggerName != null) {
      _result.taggerName = taggerName;
    }
    if (taggedUserId != null) {
      _result.taggedUserId = taggedUserId;
    }
    if (taggedUserTagPay != null) {
      _result.taggedUserTagPay = taggedUserTagPay;
    }
    if (taggedUserName != null) {
      _result.taggedUserName = taggedUserName;
    }
    if (amount != null) {
      _result.amount = amount;
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
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (paidAt != null) {
      _result.paidAt = paidAt;
    }
    return _result;
  }
  factory UserTag.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UserTag.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UserTag clone() => UserTag()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UserTag copyWith(void Function(UserTag) updates) => super.copyWith((message) => updates(message as UserTag)) as UserTag; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UserTag create() => UserTag._();
  UserTag createEmptyInstance() => create();
  static $pb.PbList<UserTag> createRepeated() => $pb.PbList<UserTag>();
  @$core.pragma('dart2js:noInline')
  static UserTag getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UserTag>(create);
  static UserTag? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get taggerId => $_getSZ(1);
  @$pb.TagNumber(2)
  set taggerId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTaggerId() => $_has(1);
  @$pb.TagNumber(2)
  void clearTaggerId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get taggerTagPay => $_getSZ(2);
  @$pb.TagNumber(3)
  set taggerTagPay($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTaggerTagPay() => $_has(2);
  @$pb.TagNumber(3)
  void clearTaggerTagPay() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get taggerName => $_getSZ(3);
  @$pb.TagNumber(4)
  set taggerName($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTaggerName() => $_has(3);
  @$pb.TagNumber(4)
  void clearTaggerName() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get taggedUserId => $_getSZ(4);
  @$pb.TagNumber(5)
  set taggedUserId($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTaggedUserId() => $_has(4);
  @$pb.TagNumber(5)
  void clearTaggedUserId() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get taggedUserTagPay => $_getSZ(5);
  @$pb.TagNumber(6)
  set taggedUserTagPay($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasTaggedUserTagPay() => $_has(5);
  @$pb.TagNumber(6)
  void clearTaggedUserTagPay() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get taggedUserName => $_getSZ(6);
  @$pb.TagNumber(7)
  set taggedUserName($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasTaggedUserName() => $_has(6);
  @$pb.TagNumber(7)
  void clearTaggedUserName() => clearField(7);

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
  TagStatus get status => $_getN(10);
  @$pb.TagNumber(11)
  set status(TagStatus v) { setField(11, v); }
  @$pb.TagNumber(11)
  $core.bool hasStatus() => $_has(10);
  @$pb.TagNumber(11)
  void clearStatus() => clearField(11);

  @$pb.TagNumber(12)
  $26.Timestamp get createdAt => $_getN(11);
  @$pb.TagNumber(12)
  set createdAt($26.Timestamp v) { setField(12, v); }
  @$pb.TagNumber(12)
  $core.bool hasCreatedAt() => $_has(11);
  @$pb.TagNumber(12)
  void clearCreatedAt() => clearField(12);
  @$pb.TagNumber(12)
  $26.Timestamp ensureCreatedAt() => $_ensure(11);

  @$pb.TagNumber(13)
  $26.Timestamp get paidAt => $_getN(12);
  @$pb.TagNumber(13)
  set paidAt($26.Timestamp v) { setField(13, v); }
  @$pb.TagNumber(13)
  $core.bool hasPaidAt() => $_has(12);
  @$pb.TagNumber(13)
  void clearPaidAt() => clearField(13);
  @$pb.TagNumber(13)
  $26.Timestamp ensurePaidAt() => $_ensure(12);
}

class CreateTagPayRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateTagPayRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'tagPay')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'displayName')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'avatarUrl')
    ..hasRequiredFields = false
  ;

  CreateTagPayRequest._() : super();
  factory CreateTagPayRequest({
    $core.String? tagPay,
    $core.String? displayName,
    $core.String? avatarUrl,
  }) {
    final _result = create();
    if (tagPay != null) {
      _result.tagPay = tagPay;
    }
    if (displayName != null) {
      _result.displayName = displayName;
    }
    if (avatarUrl != null) {
      _result.avatarUrl = avatarUrl;
    }
    return _result;
  }
  factory CreateTagPayRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateTagPayRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateTagPayRequest clone() => CreateTagPayRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateTagPayRequest copyWith(void Function(CreateTagPayRequest) updates) => super.copyWith((message) => updates(message as CreateTagPayRequest)) as CreateTagPayRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateTagPayRequest create() => CreateTagPayRequest._();
  CreateTagPayRequest createEmptyInstance() => create();
  static $pb.PbList<CreateTagPayRequest> createRepeated() => $pb.PbList<CreateTagPayRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateTagPayRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateTagPayRequest>(create);
  static CreateTagPayRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get tagPay => $_getSZ(0);
  @$pb.TagNumber(1)
  set tagPay($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTagPay() => $_has(0);
  @$pb.TagNumber(1)
  void clearTagPay() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get displayName => $_getSZ(1);
  @$pb.TagNumber(2)
  set displayName($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasDisplayName() => $_has(1);
  @$pb.TagNumber(2)
  void clearDisplayName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get avatarUrl => $_getSZ(2);
  @$pb.TagNumber(3)
  set avatarUrl($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAvatarUrl() => $_has(2);
  @$pb.TagNumber(3)
  void clearAvatarUrl() => clearField(3);
}

class CreateTagPayResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateTagPayResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOM<TagPay>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'tagPay', subBuilder: TagPay.create)
    ..hasRequiredFields = false
  ;

  CreateTagPayResponse._() : super();
  factory CreateTagPayResponse({
    $core.bool? success,
    $core.String? message,
    TagPay? tagPay,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (tagPay != null) {
      _result.tagPay = tagPay;
    }
    return _result;
  }
  factory CreateTagPayResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateTagPayResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateTagPayResponse clone() => CreateTagPayResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateTagPayResponse copyWith(void Function(CreateTagPayResponse) updates) => super.copyWith((message) => updates(message as CreateTagPayResponse)) as CreateTagPayResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateTagPayResponse create() => CreateTagPayResponse._();
  CreateTagPayResponse createEmptyInstance() => create();
  static $pb.PbList<CreateTagPayResponse> createRepeated() => $pb.PbList<CreateTagPayResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateTagPayResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateTagPayResponse>(create);
  static CreateTagPayResponse? _defaultInstance;

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
  TagPay get tagPay => $_getN(2);
  @$pb.TagNumber(3)
  set tagPay(TagPay v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasTagPay() => $_has(2);
  @$pb.TagNumber(3)
  void clearTagPay() => clearField(3);
  @$pb.TagNumber(3)
  TagPay ensureTagPay() => $_ensure(2);
}

class GetTagPayRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetTagPayRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'tagPay')
    ..hasRequiredFields = false
  ;

  GetTagPayRequest._() : super();
  factory GetTagPayRequest({
    $core.String? tagPay,
  }) {
    final _result = create();
    if (tagPay != null) {
      _result.tagPay = tagPay;
    }
    return _result;
  }
  factory GetTagPayRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTagPayRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetTagPayRequest clone() => GetTagPayRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetTagPayRequest copyWith(void Function(GetTagPayRequest) updates) => super.copyWith((message) => updates(message as GetTagPayRequest)) as GetTagPayRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetTagPayRequest create() => GetTagPayRequest._();
  GetTagPayRequest createEmptyInstance() => create();
  static $pb.PbList<GetTagPayRequest> createRepeated() => $pb.PbList<GetTagPayRequest>();
  @$core.pragma('dart2js:noInline')
  static GetTagPayRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetTagPayRequest>(create);
  static GetTagPayRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get tagPay => $_getSZ(0);
  @$pb.TagNumber(1)
  set tagPay($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTagPay() => $_has(0);
  @$pb.TagNumber(1)
  void clearTagPay() => clearField(1);
}

class GetTagPayResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetTagPayResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOM<TagPay>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'tagPay', subBuilder: TagPay.create)
    ..hasRequiredFields = false
  ;

  GetTagPayResponse._() : super();
  factory GetTagPayResponse({
    $core.bool? success,
    $core.String? message,
    TagPay? tagPay,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (tagPay != null) {
      _result.tagPay = tagPay;
    }
    return _result;
  }
  factory GetTagPayResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTagPayResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetTagPayResponse clone() => GetTagPayResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetTagPayResponse copyWith(void Function(GetTagPayResponse) updates) => super.copyWith((message) => updates(message as GetTagPayResponse)) as GetTagPayResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetTagPayResponse create() => GetTagPayResponse._();
  GetTagPayResponse createEmptyInstance() => create();
  static $pb.PbList<GetTagPayResponse> createRepeated() => $pb.PbList<GetTagPayResponse>();
  @$core.pragma('dart2js:noInline')
  static GetTagPayResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetTagPayResponse>(create);
  static GetTagPayResponse? _defaultInstance;

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
  TagPay get tagPay => $_getN(2);
  @$pb.TagNumber(3)
  set tagPay(TagPay v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasTagPay() => $_has(2);
  @$pb.TagNumber(3)
  void clearTagPay() => clearField(3);
  @$pb.TagNumber(3)
  TagPay ensureTagPay() => $_ensure(2);
}

class CheckTagPayAvailabilityRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CheckTagPayAvailabilityRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'tagPay')
    ..hasRequiredFields = false
  ;

  CheckTagPayAvailabilityRequest._() : super();
  factory CheckTagPayAvailabilityRequest({
    $core.String? tagPay,
  }) {
    final _result = create();
    if (tagPay != null) {
      _result.tagPay = tagPay;
    }
    return _result;
  }
  factory CheckTagPayAvailabilityRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CheckTagPayAvailabilityRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CheckTagPayAvailabilityRequest clone() => CheckTagPayAvailabilityRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CheckTagPayAvailabilityRequest copyWith(void Function(CheckTagPayAvailabilityRequest) updates) => super.copyWith((message) => updates(message as CheckTagPayAvailabilityRequest)) as CheckTagPayAvailabilityRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CheckTagPayAvailabilityRequest create() => CheckTagPayAvailabilityRequest._();
  CheckTagPayAvailabilityRequest createEmptyInstance() => create();
  static $pb.PbList<CheckTagPayAvailabilityRequest> createRepeated() => $pb.PbList<CheckTagPayAvailabilityRequest>();
  @$core.pragma('dart2js:noInline')
  static CheckTagPayAvailabilityRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CheckTagPayAvailabilityRequest>(create);
  static CheckTagPayAvailabilityRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get tagPay => $_getSZ(0);
  @$pb.TagNumber(1)
  set tagPay($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTagPay() => $_has(0);
  @$pb.TagNumber(1)
  void clearTagPay() => clearField(1);
}

class CheckTagPayAvailabilityResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CheckTagPayAvailabilityResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'available')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..pPS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'suggestions')
    ..hasRequiredFields = false
  ;

  CheckTagPayAvailabilityResponse._() : super();
  factory CheckTagPayAvailabilityResponse({
    $core.bool? available,
    $core.String? message,
    $core.Iterable<$core.String>? suggestions,
  }) {
    final _result = create();
    if (available != null) {
      _result.available = available;
    }
    if (message != null) {
      _result.message = message;
    }
    if (suggestions != null) {
      _result.suggestions.addAll(suggestions);
    }
    return _result;
  }
  factory CheckTagPayAvailabilityResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CheckTagPayAvailabilityResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CheckTagPayAvailabilityResponse clone() => CheckTagPayAvailabilityResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CheckTagPayAvailabilityResponse copyWith(void Function(CheckTagPayAvailabilityResponse) updates) => super.copyWith((message) => updates(message as CheckTagPayAvailabilityResponse)) as CheckTagPayAvailabilityResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CheckTagPayAvailabilityResponse create() => CheckTagPayAvailabilityResponse._();
  CheckTagPayAvailabilityResponse createEmptyInstance() => create();
  static $pb.PbList<CheckTagPayAvailabilityResponse> createRepeated() => $pb.PbList<CheckTagPayAvailabilityResponse>();
  @$core.pragma('dart2js:noInline')
  static CheckTagPayAvailabilityResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CheckTagPayAvailabilityResponse>(create);
  static CheckTagPayAvailabilityResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get available => $_getBF(0);
  @$pb.TagNumber(1)
  set available($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAvailable() => $_has(0);
  @$pb.TagNumber(1)
  void clearAvailable() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.String> get suggestions => $_getList(2);
}

class SearchTagPayRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SearchTagPayRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'query')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  SearchTagPayRequest._() : super();
  factory SearchTagPayRequest({
    $core.String? query,
    $core.int? limit,
  }) {
    final _result = create();
    if (query != null) {
      _result.query = query;
    }
    if (limit != null) {
      _result.limit = limit;
    }
    return _result;
  }
  factory SearchTagPayRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SearchTagPayRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SearchTagPayRequest clone() => SearchTagPayRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SearchTagPayRequest copyWith(void Function(SearchTagPayRequest) updates) => super.copyWith((message) => updates(message as SearchTagPayRequest)) as SearchTagPayRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SearchTagPayRequest create() => SearchTagPayRequest._();
  SearchTagPayRequest createEmptyInstance() => create();
  static $pb.PbList<SearchTagPayRequest> createRepeated() => $pb.PbList<SearchTagPayRequest>();
  @$core.pragma('dart2js:noInline')
  static SearchTagPayRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SearchTagPayRequest>(create);
  static SearchTagPayRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get query => $_getSZ(0);
  @$pb.TagNumber(1)
  set query($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasQuery() => $_has(0);
  @$pb.TagNumber(1)
  void clearQuery() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get limit => $_getIZ(1);
  @$pb.TagNumber(2)
  set limit($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearLimit() => clearField(2);
}

class SearchTagPayResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SearchTagPayResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<TagPay>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'results', $pb.PbFieldType.PM, subBuilder: TagPay.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  SearchTagPayResponse._() : super();
  factory SearchTagPayResponse({
    $core.Iterable<TagPay>? results,
    $core.int? total,
  }) {
    final _result = create();
    if (results != null) {
      _result.results.addAll(results);
    }
    if (total != null) {
      _result.total = total;
    }
    return _result;
  }
  factory SearchTagPayResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SearchTagPayResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SearchTagPayResponse clone() => SearchTagPayResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SearchTagPayResponse copyWith(void Function(SearchTagPayResponse) updates) => super.copyWith((message) => updates(message as SearchTagPayResponse)) as SearchTagPayResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SearchTagPayResponse create() => SearchTagPayResponse._();
  SearchTagPayResponse createEmptyInstance() => create();
  static $pb.PbList<SearchTagPayResponse> createRepeated() => $pb.PbList<SearchTagPayResponse>();
  @$core.pragma('dart2js:noInline')
  static SearchTagPayResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SearchTagPayResponse>(create);
  static SearchTagPayResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<TagPay> get results => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => clearField(2);
}

class SendMoneyTagPayRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SendMoneyTagPayRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'receiverTagPay')
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sourceAccountId')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionPin')
    ..hasRequiredFields = false
  ;

  SendMoneyTagPayRequest._() : super();
  factory SendMoneyTagPayRequest({
    $core.String? receiverTagPay,
    $core.double? amount,
    $core.String? currency,
    $core.String? description,
    $core.String? sourceAccountId,
    $core.String? transactionPin,
  }) {
    final _result = create();
    if (receiverTagPay != null) {
      _result.receiverTagPay = receiverTagPay;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (description != null) {
      _result.description = description;
    }
    if (sourceAccountId != null) {
      _result.sourceAccountId = sourceAccountId;
    }
    if (transactionPin != null) {
      _result.transactionPin = transactionPin;
    }
    return _result;
  }
  factory SendMoneyTagPayRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SendMoneyTagPayRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SendMoneyTagPayRequest clone() => SendMoneyTagPayRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SendMoneyTagPayRequest copyWith(void Function(SendMoneyTagPayRequest) updates) => super.copyWith((message) => updates(message as SendMoneyTagPayRequest)) as SendMoneyTagPayRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SendMoneyTagPayRequest create() => SendMoneyTagPayRequest._();
  SendMoneyTagPayRequest createEmptyInstance() => create();
  static $pb.PbList<SendMoneyTagPayRequest> createRepeated() => $pb.PbList<SendMoneyTagPayRequest>();
  @$core.pragma('dart2js:noInline')
  static SendMoneyTagPayRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SendMoneyTagPayRequest>(create);
  static SendMoneyTagPayRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get receiverTagPay => $_getSZ(0);
  @$pb.TagNumber(1)
  set receiverTagPay($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasReceiverTagPay() => $_has(0);
  @$pb.TagNumber(1)
  void clearReceiverTagPay() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get amount => $_getN(1);
  @$pb.TagNumber(2)
  set amount($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get currency => $_getSZ(2);
  @$pb.TagNumber(3)
  set currency($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCurrency() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrency() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get description => $_getSZ(3);
  @$pb.TagNumber(4)
  set description($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasDescription() => $_has(3);
  @$pb.TagNumber(4)
  void clearDescription() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get sourceAccountId => $_getSZ(4);
  @$pb.TagNumber(5)
  set sourceAccountId($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasSourceAccountId() => $_has(4);
  @$pb.TagNumber(5)
  void clearSourceAccountId() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get transactionPin => $_getSZ(5);
  @$pb.TagNumber(6)
  set transactionPin($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasTransactionPin() => $_has(5);
  @$pb.TagNumber(6)
  void clearTransactionPin() => clearField(6);
}

class SendMoneyTagPayResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SendMoneyTagPayResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOM<TagPayTransaction>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transaction', subBuilder: TagPayTransaction.create)
    ..hasRequiredFields = false
  ;

  SendMoneyTagPayResponse._() : super();
  factory SendMoneyTagPayResponse({
    $core.bool? success,
    $core.String? message,
    TagPayTransaction? transaction,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (transaction != null) {
      _result.transaction = transaction;
    }
    return _result;
  }
  factory SendMoneyTagPayResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SendMoneyTagPayResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SendMoneyTagPayResponse clone() => SendMoneyTagPayResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SendMoneyTagPayResponse copyWith(void Function(SendMoneyTagPayResponse) updates) => super.copyWith((message) => updates(message as SendMoneyTagPayResponse)) as SendMoneyTagPayResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SendMoneyTagPayResponse create() => SendMoneyTagPayResponse._();
  SendMoneyTagPayResponse createEmptyInstance() => create();
  static $pb.PbList<SendMoneyTagPayResponse> createRepeated() => $pb.PbList<SendMoneyTagPayResponse>();
  @$core.pragma('dart2js:noInline')
  static SendMoneyTagPayResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SendMoneyTagPayResponse>(create);
  static SendMoneyTagPayResponse? _defaultInstance;

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
  TagPayTransaction get transaction => $_getN(2);
  @$pb.TagNumber(3)
  set transaction(TagPayTransaction v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasTransaction() => $_has(2);
  @$pb.TagNumber(3)
  void clearTransaction() => clearField(3);
  @$pb.TagNumber(3)
  TagPayTransaction ensureTransaction() => $_ensure(2);
}

class RequestMoneyTagPayRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RequestMoneyTagPayRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'requesteeTagPay')
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..hasRequiredFields = false
  ;

  RequestMoneyTagPayRequest._() : super();
  factory RequestMoneyTagPayRequest({
    $core.String? requesteeTagPay,
    $core.double? amount,
    $core.String? currency,
    $core.String? description,
  }) {
    final _result = create();
    if (requesteeTagPay != null) {
      _result.requesteeTagPay = requesteeTagPay;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (description != null) {
      _result.description = description;
    }
    return _result;
  }
  factory RequestMoneyTagPayRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RequestMoneyTagPayRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RequestMoneyTagPayRequest clone() => RequestMoneyTagPayRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RequestMoneyTagPayRequest copyWith(void Function(RequestMoneyTagPayRequest) updates) => super.copyWith((message) => updates(message as RequestMoneyTagPayRequest)) as RequestMoneyTagPayRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RequestMoneyTagPayRequest create() => RequestMoneyTagPayRequest._();
  RequestMoneyTagPayRequest createEmptyInstance() => create();
  static $pb.PbList<RequestMoneyTagPayRequest> createRepeated() => $pb.PbList<RequestMoneyTagPayRequest>();
  @$core.pragma('dart2js:noInline')
  static RequestMoneyTagPayRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RequestMoneyTagPayRequest>(create);
  static RequestMoneyTagPayRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get requesteeTagPay => $_getSZ(0);
  @$pb.TagNumber(1)
  set requesteeTagPay($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRequesteeTagPay() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequesteeTagPay() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get amount => $_getN(1);
  @$pb.TagNumber(2)
  set amount($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get currency => $_getSZ(2);
  @$pb.TagNumber(3)
  set currency($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCurrency() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrency() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get description => $_getSZ(3);
  @$pb.TagNumber(4)
  set description($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasDescription() => $_has(3);
  @$pb.TagNumber(4)
  void clearDescription() => clearField(4);
}

class RequestMoneyTagPayResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RequestMoneyTagPayResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOM<MoneyRequest>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'moneyRequest', subBuilder: MoneyRequest.create)
    ..hasRequiredFields = false
  ;

  RequestMoneyTagPayResponse._() : super();
  factory RequestMoneyTagPayResponse({
    $core.bool? success,
    $core.String? message,
    MoneyRequest? moneyRequest,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (moneyRequest != null) {
      _result.moneyRequest = moneyRequest;
    }
    return _result;
  }
  factory RequestMoneyTagPayResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RequestMoneyTagPayResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RequestMoneyTagPayResponse clone() => RequestMoneyTagPayResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RequestMoneyTagPayResponse copyWith(void Function(RequestMoneyTagPayResponse) updates) => super.copyWith((message) => updates(message as RequestMoneyTagPayResponse)) as RequestMoneyTagPayResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RequestMoneyTagPayResponse create() => RequestMoneyTagPayResponse._();
  RequestMoneyTagPayResponse createEmptyInstance() => create();
  static $pb.PbList<RequestMoneyTagPayResponse> createRepeated() => $pb.PbList<RequestMoneyTagPayResponse>();
  @$core.pragma('dart2js:noInline')
  static RequestMoneyTagPayResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RequestMoneyTagPayResponse>(create);
  static RequestMoneyTagPayResponse? _defaultInstance;

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
  MoneyRequest get moneyRequest => $_getN(2);
  @$pb.TagNumber(3)
  set moneyRequest(MoneyRequest v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasMoneyRequest() => $_has(2);
  @$pb.TagNumber(3)
  void clearMoneyRequest() => clearField(3);
  @$pb.TagNumber(3)
  MoneyRequest ensureMoneyRequest() => $_ensure(2);
}

class GetTagPayTransactionsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetTagPayTransactionsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..e<TagPayTransactionType>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type', $pb.PbFieldType.OE, defaultOrMaker: TagPayTransactionType.TAG_PAY_TRANSACTION_TYPE_SEND, valueOf: TagPayTransactionType.valueOf, enumValues: TagPayTransactionType.values)
    ..hasRequiredFields = false
  ;

  GetTagPayTransactionsRequest._() : super();
  factory GetTagPayTransactionsRequest({
    $core.int? page,
    $core.int? limit,
    TagPayTransactionType? type,
  }) {
    final _result = create();
    if (page != null) {
      _result.page = page;
    }
    if (limit != null) {
      _result.limit = limit;
    }
    if (type != null) {
      _result.type = type;
    }
    return _result;
  }
  factory GetTagPayTransactionsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTagPayTransactionsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetTagPayTransactionsRequest clone() => GetTagPayTransactionsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetTagPayTransactionsRequest copyWith(void Function(GetTagPayTransactionsRequest) updates) => super.copyWith((message) => updates(message as GetTagPayTransactionsRequest)) as GetTagPayTransactionsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetTagPayTransactionsRequest create() => GetTagPayTransactionsRequest._();
  GetTagPayTransactionsRequest createEmptyInstance() => create();
  static $pb.PbList<GetTagPayTransactionsRequest> createRepeated() => $pb.PbList<GetTagPayTransactionsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetTagPayTransactionsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetTagPayTransactionsRequest>(create);
  static GetTagPayTransactionsRequest? _defaultInstance;

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
  TagPayTransactionType get type => $_getN(2);
  @$pb.TagNumber(3)
  set type(TagPayTransactionType v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasType() => $_has(2);
  @$pb.TagNumber(3)
  void clearType() => clearField(3);
}

class GetTagPayTransactionsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetTagPayTransactionsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<TagPayTransaction>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactions', $pb.PbFieldType.PM, subBuilder: TagPayTransaction.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'total', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalPages', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetTagPayTransactionsResponse._() : super();
  factory GetTagPayTransactionsResponse({
    $core.Iterable<TagPayTransaction>? transactions,
    $core.int? total,
    $core.int? page,
    $core.int? totalPages,
  }) {
    final _result = create();
    if (transactions != null) {
      _result.transactions.addAll(transactions);
    }
    if (total != null) {
      _result.total = total;
    }
    if (page != null) {
      _result.page = page;
    }
    if (totalPages != null) {
      _result.totalPages = totalPages;
    }
    return _result;
  }
  factory GetTagPayTransactionsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTagPayTransactionsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetTagPayTransactionsResponse clone() => GetTagPayTransactionsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetTagPayTransactionsResponse copyWith(void Function(GetTagPayTransactionsResponse) updates) => super.copyWith((message) => updates(message as GetTagPayTransactionsResponse)) as GetTagPayTransactionsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetTagPayTransactionsResponse create() => GetTagPayTransactionsResponse._();
  GetTagPayTransactionsResponse createEmptyInstance() => create();
  static $pb.PbList<GetTagPayTransactionsResponse> createRepeated() => $pb.PbList<GetTagPayTransactionsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetTagPayTransactionsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetTagPayTransactionsResponse>(create);
  static GetTagPayTransactionsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<TagPayTransaction> get transactions => $_getList(0);

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

class AcceptMoneyRequestRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AcceptMoneyRequestRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'requestId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sourceAccountId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionPin')
    ..hasRequiredFields = false
  ;

  AcceptMoneyRequestRequest._() : super();
  factory AcceptMoneyRequestRequest({
    $core.String? requestId,
    $core.String? sourceAccountId,
    $core.String? transactionPin,
  }) {
    final _result = create();
    if (requestId != null) {
      _result.requestId = requestId;
    }
    if (sourceAccountId != null) {
      _result.sourceAccountId = sourceAccountId;
    }
    if (transactionPin != null) {
      _result.transactionPin = transactionPin;
    }
    return _result;
  }
  factory AcceptMoneyRequestRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AcceptMoneyRequestRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AcceptMoneyRequestRequest clone() => AcceptMoneyRequestRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AcceptMoneyRequestRequest copyWith(void Function(AcceptMoneyRequestRequest) updates) => super.copyWith((message) => updates(message as AcceptMoneyRequestRequest)) as AcceptMoneyRequestRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AcceptMoneyRequestRequest create() => AcceptMoneyRequestRequest._();
  AcceptMoneyRequestRequest createEmptyInstance() => create();
  static $pb.PbList<AcceptMoneyRequestRequest> createRepeated() => $pb.PbList<AcceptMoneyRequestRequest>();
  @$core.pragma('dart2js:noInline')
  static AcceptMoneyRequestRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AcceptMoneyRequestRequest>(create);
  static AcceptMoneyRequestRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get requestId => $_getSZ(0);
  @$pb.TagNumber(1)
  set requestId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRequestId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequestId() => clearField(1);

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

class AcceptMoneyRequestResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AcceptMoneyRequestResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOM<TagPayTransaction>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transaction', subBuilder: TagPayTransaction.create)
    ..hasRequiredFields = false
  ;

  AcceptMoneyRequestResponse._() : super();
  factory AcceptMoneyRequestResponse({
    $core.bool? success,
    $core.String? message,
    TagPayTransaction? transaction,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (transaction != null) {
      _result.transaction = transaction;
    }
    return _result;
  }
  factory AcceptMoneyRequestResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AcceptMoneyRequestResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AcceptMoneyRequestResponse clone() => AcceptMoneyRequestResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AcceptMoneyRequestResponse copyWith(void Function(AcceptMoneyRequestResponse) updates) => super.copyWith((message) => updates(message as AcceptMoneyRequestResponse)) as AcceptMoneyRequestResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AcceptMoneyRequestResponse create() => AcceptMoneyRequestResponse._();
  AcceptMoneyRequestResponse createEmptyInstance() => create();
  static $pb.PbList<AcceptMoneyRequestResponse> createRepeated() => $pb.PbList<AcceptMoneyRequestResponse>();
  @$core.pragma('dart2js:noInline')
  static AcceptMoneyRequestResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AcceptMoneyRequestResponse>(create);
  static AcceptMoneyRequestResponse? _defaultInstance;

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
  TagPayTransaction get transaction => $_getN(2);
  @$pb.TagNumber(3)
  set transaction(TagPayTransaction v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasTransaction() => $_has(2);
  @$pb.TagNumber(3)
  void clearTransaction() => clearField(3);
  @$pb.TagNumber(3)
  TagPayTransaction ensureTransaction() => $_ensure(2);
}

class DeclineMoneyRequestRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DeclineMoneyRequestRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'requestId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reason')
    ..hasRequiredFields = false
  ;

  DeclineMoneyRequestRequest._() : super();
  factory DeclineMoneyRequestRequest({
    $core.String? requestId,
    $core.String? reason,
  }) {
    final _result = create();
    if (requestId != null) {
      _result.requestId = requestId;
    }
    if (reason != null) {
      _result.reason = reason;
    }
    return _result;
  }
  factory DeclineMoneyRequestRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeclineMoneyRequestRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeclineMoneyRequestRequest clone() => DeclineMoneyRequestRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeclineMoneyRequestRequest copyWith(void Function(DeclineMoneyRequestRequest) updates) => super.copyWith((message) => updates(message as DeclineMoneyRequestRequest)) as DeclineMoneyRequestRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DeclineMoneyRequestRequest create() => DeclineMoneyRequestRequest._();
  DeclineMoneyRequestRequest createEmptyInstance() => create();
  static $pb.PbList<DeclineMoneyRequestRequest> createRepeated() => $pb.PbList<DeclineMoneyRequestRequest>();
  @$core.pragma('dart2js:noInline')
  static DeclineMoneyRequestRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeclineMoneyRequestRequest>(create);
  static DeclineMoneyRequestRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get requestId => $_getSZ(0);
  @$pb.TagNumber(1)
  set requestId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRequestId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequestId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get reason => $_getSZ(1);
  @$pb.TagNumber(2)
  set reason($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasReason() => $_has(1);
  @$pb.TagNumber(2)
  void clearReason() => clearField(2);
}

class DeclineMoneyRequestResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DeclineMoneyRequestResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  DeclineMoneyRequestResponse._() : super();
  factory DeclineMoneyRequestResponse({
    $core.bool? success,
    $core.String? message,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory DeclineMoneyRequestResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeclineMoneyRequestResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeclineMoneyRequestResponse clone() => DeclineMoneyRequestResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeclineMoneyRequestResponse copyWith(void Function(DeclineMoneyRequestResponse) updates) => super.copyWith((message) => updates(message as DeclineMoneyRequestResponse)) as DeclineMoneyRequestResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DeclineMoneyRequestResponse create() => DeclineMoneyRequestResponse._();
  DeclineMoneyRequestResponse createEmptyInstance() => create();
  static $pb.PbList<DeclineMoneyRequestResponse> createRepeated() => $pb.PbList<DeclineMoneyRequestResponse>();
  @$core.pragma('dart2js:noInline')
  static DeclineMoneyRequestResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeclineMoneyRequestResponse>(create);
  static DeclineMoneyRequestResponse? _defaultInstance;

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

class GetPendingMoneyRequestsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetPendingMoneyRequestsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'incoming')
    ..hasRequiredFields = false
  ;

  GetPendingMoneyRequestsRequest._() : super();
  factory GetPendingMoneyRequestsRequest({
    $core.int? page,
    $core.int? limit,
    $core.bool? incoming,
  }) {
    final _result = create();
    if (page != null) {
      _result.page = page;
    }
    if (limit != null) {
      _result.limit = limit;
    }
    if (incoming != null) {
      _result.incoming = incoming;
    }
    return _result;
  }
  factory GetPendingMoneyRequestsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPendingMoneyRequestsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPendingMoneyRequestsRequest clone() => GetPendingMoneyRequestsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPendingMoneyRequestsRequest copyWith(void Function(GetPendingMoneyRequestsRequest) updates) => super.copyWith((message) => updates(message as GetPendingMoneyRequestsRequest)) as GetPendingMoneyRequestsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetPendingMoneyRequestsRequest create() => GetPendingMoneyRequestsRequest._();
  GetPendingMoneyRequestsRequest createEmptyInstance() => create();
  static $pb.PbList<GetPendingMoneyRequestsRequest> createRepeated() => $pb.PbList<GetPendingMoneyRequestsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetPendingMoneyRequestsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetPendingMoneyRequestsRequest>(create);
  static GetPendingMoneyRequestsRequest? _defaultInstance;

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
  $core.bool get incoming => $_getBF(2);
  @$pb.TagNumber(3)
  set incoming($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasIncoming() => $_has(2);
  @$pb.TagNumber(3)
  void clearIncoming() => clearField(3);
}

class GetPendingMoneyRequestsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetPendingMoneyRequestsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<MoneyRequest>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'requests', $pb.PbFieldType.PM, subBuilder: MoneyRequest.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'total', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalPages', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetPendingMoneyRequestsResponse._() : super();
  factory GetPendingMoneyRequestsResponse({
    $core.Iterable<MoneyRequest>? requests,
    $core.int? total,
    $core.int? page,
    $core.int? totalPages,
  }) {
    final _result = create();
    if (requests != null) {
      _result.requests.addAll(requests);
    }
    if (total != null) {
      _result.total = total;
    }
    if (page != null) {
      _result.page = page;
    }
    if (totalPages != null) {
      _result.totalPages = totalPages;
    }
    return _result;
  }
  factory GetPendingMoneyRequestsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPendingMoneyRequestsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPendingMoneyRequestsResponse clone() => GetPendingMoneyRequestsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPendingMoneyRequestsResponse copyWith(void Function(GetPendingMoneyRequestsResponse) updates) => super.copyWith((message) => updates(message as GetPendingMoneyRequestsResponse)) as GetPendingMoneyRequestsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetPendingMoneyRequestsResponse create() => GetPendingMoneyRequestsResponse._();
  GetPendingMoneyRequestsResponse createEmptyInstance() => create();
  static $pb.PbList<GetPendingMoneyRequestsResponse> createRepeated() => $pb.PbList<GetPendingMoneyRequestsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetPendingMoneyRequestsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetPendingMoneyRequestsResponse>(create);
  static GetPendingMoneyRequestsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<MoneyRequest> get requests => $_getList(0);

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

class CreateTagRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateTagRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'taggedUserTagPay')
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..hasRequiredFields = false
  ;

  CreateTagRequest._() : super();
  factory CreateTagRequest({
    $core.String? taggedUserTagPay,
    $core.double? amount,
    $core.String? currency,
    $core.String? description,
  }) {
    final _result = create();
    if (taggedUserTagPay != null) {
      _result.taggedUserTagPay = taggedUserTagPay;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (description != null) {
      _result.description = description;
    }
    return _result;
  }
  factory CreateTagRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateTagRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateTagRequest clone() => CreateTagRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateTagRequest copyWith(void Function(CreateTagRequest) updates) => super.copyWith((message) => updates(message as CreateTagRequest)) as CreateTagRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateTagRequest create() => CreateTagRequest._();
  CreateTagRequest createEmptyInstance() => create();
  static $pb.PbList<CreateTagRequest> createRepeated() => $pb.PbList<CreateTagRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateTagRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateTagRequest>(create);
  static CreateTagRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get taggedUserTagPay => $_getSZ(0);
  @$pb.TagNumber(1)
  set taggedUserTagPay($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTaggedUserTagPay() => $_has(0);
  @$pb.TagNumber(1)
  void clearTaggedUserTagPay() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get amount => $_getN(1);
  @$pb.TagNumber(2)
  set amount($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get currency => $_getSZ(2);
  @$pb.TagNumber(3)
  set currency($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCurrency() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrency() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get description => $_getSZ(3);
  @$pb.TagNumber(4)
  set description($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasDescription() => $_has(3);
  @$pb.TagNumber(4)
  void clearDescription() => clearField(4);
}

class CreateTagResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateTagResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOM<UserTag>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'tag', subBuilder: UserTag.create)
    ..hasRequiredFields = false
  ;

  CreateTagResponse._() : super();
  factory CreateTagResponse({
    $core.bool? success,
    $core.String? message,
    UserTag? tag,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (tag != null) {
      _result.tag = tag;
    }
    return _result;
  }
  factory CreateTagResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateTagResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateTagResponse clone() => CreateTagResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateTagResponse copyWith(void Function(CreateTagResponse) updates) => super.copyWith((message) => updates(message as CreateTagResponse)) as CreateTagResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateTagResponse create() => CreateTagResponse._();
  CreateTagResponse createEmptyInstance() => create();
  static $pb.PbList<CreateTagResponse> createRepeated() => $pb.PbList<CreateTagResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateTagResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateTagResponse>(create);
  static CreateTagResponse? _defaultInstance;

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
  UserTag get tag => $_getN(2);
  @$pb.TagNumber(3)
  set tag(UserTag v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasTag() => $_has(2);
  @$pb.TagNumber(3)
  void clearTag() => clearField(3);
  @$pb.TagNumber(3)
  UserTag ensureTag() => $_ensure(2);
}

class GetMyTagsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetMyTagsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..e<TagStatus>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: TagStatus.TAG_STATUS_PENDING, valueOf: TagStatus.valueOf, enumValues: TagStatus.values)
    ..hasRequiredFields = false
  ;

  GetMyTagsRequest._() : super();
  factory GetMyTagsRequest({
    $core.int? page,
    $core.int? limit,
    TagStatus? status,
  }) {
    final _result = create();
    if (page != null) {
      _result.page = page;
    }
    if (limit != null) {
      _result.limit = limit;
    }
    if (status != null) {
      _result.status = status;
    }
    return _result;
  }
  factory GetMyTagsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMyTagsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMyTagsRequest clone() => GetMyTagsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMyTagsRequest copyWith(void Function(GetMyTagsRequest) updates) => super.copyWith((message) => updates(message as GetMyTagsRequest)) as GetMyTagsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetMyTagsRequest create() => GetMyTagsRequest._();
  GetMyTagsRequest createEmptyInstance() => create();
  static $pb.PbList<GetMyTagsRequest> createRepeated() => $pb.PbList<GetMyTagsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMyTagsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMyTagsRequest>(create);
  static GetMyTagsRequest? _defaultInstance;

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
  TagStatus get status => $_getN(2);
  @$pb.TagNumber(3)
  set status(TagStatus v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasStatus() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatus() => clearField(3);
}

class GetMyTagsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetMyTagsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<UserTag>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'tags', $pb.PbFieldType.PM, subBuilder: UserTag.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'total', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalPages', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetMyTagsResponse._() : super();
  factory GetMyTagsResponse({
    $core.Iterable<UserTag>? tags,
    $core.int? total,
    $core.int? page,
    $core.int? totalPages,
  }) {
    final _result = create();
    if (tags != null) {
      _result.tags.addAll(tags);
    }
    if (total != null) {
      _result.total = total;
    }
    if (page != null) {
      _result.page = page;
    }
    if (totalPages != null) {
      _result.totalPages = totalPages;
    }
    return _result;
  }
  factory GetMyTagsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMyTagsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMyTagsResponse clone() => GetMyTagsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMyTagsResponse copyWith(void Function(GetMyTagsResponse) updates) => super.copyWith((message) => updates(message as GetMyTagsResponse)) as GetMyTagsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetMyTagsResponse create() => GetMyTagsResponse._();
  GetMyTagsResponse createEmptyInstance() => create();
  static $pb.PbList<GetMyTagsResponse> createRepeated() => $pb.PbList<GetMyTagsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMyTagsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMyTagsResponse>(create);
  static GetMyTagsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<UserTag> get tags => $_getList(0);

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

class PayTagRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PayTagRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'tagId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sourceAccountId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionPin')
    ..hasRequiredFields = false
  ;

  PayTagRequest._() : super();
  factory PayTagRequest({
    $core.String? tagId,
    $core.String? sourceAccountId,
    $core.String? transactionPin,
  }) {
    final _result = create();
    if (tagId != null) {
      _result.tagId = tagId;
    }
    if (sourceAccountId != null) {
      _result.sourceAccountId = sourceAccountId;
    }
    if (transactionPin != null) {
      _result.transactionPin = transactionPin;
    }
    return _result;
  }
  factory PayTagRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PayTagRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PayTagRequest clone() => PayTagRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PayTagRequest copyWith(void Function(PayTagRequest) updates) => super.copyWith((message) => updates(message as PayTagRequest)) as PayTagRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PayTagRequest create() => PayTagRequest._();
  PayTagRequest createEmptyInstance() => create();
  static $pb.PbList<PayTagRequest> createRepeated() => $pb.PbList<PayTagRequest>();
  @$core.pragma('dart2js:noInline')
  static PayTagRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PayTagRequest>(create);
  static PayTagRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get tagId => $_getSZ(0);
  @$pb.TagNumber(1)
  set tagId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTagId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTagId() => clearField(1);

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

class PayTagResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PayTagResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOM<TagPayTransaction>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transaction', subBuilder: TagPayTransaction.create)
    ..hasRequiredFields = false
  ;

  PayTagResponse._() : super();
  factory PayTagResponse({
    $core.bool? success,
    $core.String? message,
    TagPayTransaction? transaction,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (transaction != null) {
      _result.transaction = transaction;
    }
    return _result;
  }
  factory PayTagResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PayTagResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PayTagResponse clone() => PayTagResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PayTagResponse copyWith(void Function(PayTagResponse) updates) => super.copyWith((message) => updates(message as PayTagResponse)) as PayTagResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PayTagResponse create() => PayTagResponse._();
  PayTagResponse createEmptyInstance() => create();
  static $pb.PbList<PayTagResponse> createRepeated() => $pb.PbList<PayTagResponse>();
  @$core.pragma('dart2js:noInline')
  static PayTagResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PayTagResponse>(create);
  static PayTagResponse? _defaultInstance;

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
  TagPayTransaction get transaction => $_getN(2);
  @$pb.TagNumber(3)
  set transaction(TagPayTransaction v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasTransaction() => $_has(2);
  @$pb.TagNumber(3)
  void clearTransaction() => clearField(3);
  @$pb.TagNumber(3)
  TagPayTransaction ensureTransaction() => $_ensure(2);
}

class SearchUsersForTagRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SearchUsersForTagRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'query')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  SearchUsersForTagRequest._() : super();
  factory SearchUsersForTagRequest({
    $core.String? query,
    $core.int? limit,
  }) {
    final _result = create();
    if (query != null) {
      _result.query = query;
    }
    if (limit != null) {
      _result.limit = limit;
    }
    return _result;
  }
  factory SearchUsersForTagRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SearchUsersForTagRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SearchUsersForTagRequest clone() => SearchUsersForTagRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SearchUsersForTagRequest copyWith(void Function(SearchUsersForTagRequest) updates) => super.copyWith((message) => updates(message as SearchUsersForTagRequest)) as SearchUsersForTagRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SearchUsersForTagRequest create() => SearchUsersForTagRequest._();
  SearchUsersForTagRequest createEmptyInstance() => create();
  static $pb.PbList<SearchUsersForTagRequest> createRepeated() => $pb.PbList<SearchUsersForTagRequest>();
  @$core.pragma('dart2js:noInline')
  static SearchUsersForTagRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SearchUsersForTagRequest>(create);
  static SearchUsersForTagRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get query => $_getSZ(0);
  @$pb.TagNumber(1)
  set query($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasQuery() => $_has(0);
  @$pb.TagNumber(1)
  void clearQuery() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get limit => $_getIZ(1);
  @$pb.TagNumber(2)
  set limit($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearLimit() => clearField(2);
}

class UserSearchResult extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UserSearchResult', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'username')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'firstName')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lastName')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'email')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'profilePicture')
    ..hasRequiredFields = false
  ;

  UserSearchResult._() : super();
  factory UserSearchResult({
    $core.String? userId,
    $core.String? username,
    $core.String? firstName,
    $core.String? lastName,
    $core.String? email,
    $core.String? profilePicture,
  }) {
    final _result = create();
    if (userId != null) {
      _result.userId = userId;
    }
    if (username != null) {
      _result.username = username;
    }
    if (firstName != null) {
      _result.firstName = firstName;
    }
    if (lastName != null) {
      _result.lastName = lastName;
    }
    if (email != null) {
      _result.email = email;
    }
    if (profilePicture != null) {
      _result.profilePicture = profilePicture;
    }
    return _result;
  }
  factory UserSearchResult.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UserSearchResult.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UserSearchResult clone() => UserSearchResult()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UserSearchResult copyWith(void Function(UserSearchResult) updates) => super.copyWith((message) => updates(message as UserSearchResult)) as UserSearchResult; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UserSearchResult create() => UserSearchResult._();
  UserSearchResult createEmptyInstance() => create();
  static $pb.PbList<UserSearchResult> createRepeated() => $pb.PbList<UserSearchResult>();
  @$core.pragma('dart2js:noInline')
  static UserSearchResult getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UserSearchResult>(create);
  static UserSearchResult? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get username => $_getSZ(1);
  @$pb.TagNumber(2)
  set username($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUsername() => $_has(1);
  @$pb.TagNumber(2)
  void clearUsername() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get firstName => $_getSZ(2);
  @$pb.TagNumber(3)
  set firstName($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasFirstName() => $_has(2);
  @$pb.TagNumber(3)
  void clearFirstName() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get lastName => $_getSZ(3);
  @$pb.TagNumber(4)
  set lastName($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasLastName() => $_has(3);
  @$pb.TagNumber(4)
  void clearLastName() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get email => $_getSZ(4);
  @$pb.TagNumber(5)
  set email($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasEmail() => $_has(4);
  @$pb.TagNumber(5)
  void clearEmail() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get profilePicture => $_getSZ(5);
  @$pb.TagNumber(6)
  set profilePicture($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasProfilePicture() => $_has(5);
  @$pb.TagNumber(6)
  void clearProfilePicture() => clearField(6);
}

class SearchUsersForTagResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SearchUsersForTagResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<UserSearchResult>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'users', $pb.PbFieldType.PM, subBuilder: UserSearchResult.create)
    ..hasRequiredFields = false
  ;

  SearchUsersForTagResponse._() : super();
  factory SearchUsersForTagResponse({
    $core.Iterable<UserSearchResult>? users,
  }) {
    final _result = create();
    if (users != null) {
      _result.users.addAll(users);
    }
    return _result;
  }
  factory SearchUsersForTagResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SearchUsersForTagResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SearchUsersForTagResponse clone() => SearchUsersForTagResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SearchUsersForTagResponse copyWith(void Function(SearchUsersForTagResponse) updates) => super.copyWith((message) => updates(message as SearchUsersForTagResponse)) as SearchUsersForTagResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SearchUsersForTagResponse create() => SearchUsersForTagResponse._();
  SearchUsersForTagResponse createEmptyInstance() => create();
  static $pb.PbList<SearchUsersForTagResponse> createRepeated() => $pb.PbList<SearchUsersForTagResponse>();
  @$core.pragma('dart2js:noInline')
  static SearchUsersForTagResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SearchUsersForTagResponse>(create);
  static SearchUsersForTagResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<UserSearchResult> get users => $_getList(0);
}

