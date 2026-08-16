///
//  Generated code. Do not modify.
//  source: escrow.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/timestamp.pb.dart' as $1;

class Deal extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Deal', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'escrow'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reference')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'buyerUserId')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'buyerAccountId')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'buyerName')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sellerUserId')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sellerAccountId')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sellerName')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'title')
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..a<$core.double>(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..a<$core.double>(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fee', $pb.PbFieldType.OD)
    ..aOS(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'feePayer')
    ..a<$core.double>(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'buyerTotal', $pb.PbFieldType.OD)
    ..a<$core.double>(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sellerNet', $pb.PbFieldType.OD)
    ..aOS(17, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..a<$core.int>(18, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fraudScore', $pb.PbFieldType.O3)
    ..pPS(19, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fraudFlags')
    ..aOB(20, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'requiresAdminReview')
    ..aOS(21, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'deliveryNote')
    ..aOM<$1.Timestamp>(22, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'deadlineAt', subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(23, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fundedAt', subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(24, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'deliveredAt', subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(25, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'releasedAt', subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(26, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(27, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedAt', subBuilder: $1.Timestamp.create)
    ..pc<DealEvent>(28, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'events', $pb.PbFieldType.PM, subBuilder: DealEvent.create)
    ..aOS(29, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'buyerItemImageUrl')
    ..aOS(30, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sellerProofImageUrl')
    ..pc<Attachment>(31, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'attachments', $pb.PbFieldType.PM, subBuilder: Attachment.create)
    ..aOM<RefundRequest>(32, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'refundRequest', subBuilder: RefundRequest.create)
    ..hasRequiredFields = false
  ;

  Deal._() : super();
  factory Deal({
    $core.String? id,
    $core.String? reference,
    $core.String? buyerUserId,
    $core.String? buyerAccountId,
    $core.String? buyerName,
    $core.String? sellerUserId,
    $core.String? sellerAccountId,
    $core.String? sellerName,
    $core.String? title,
    $core.String? description,
    $core.String? currency,
    $core.double? amount,
    $core.double? fee,
    $core.String? feePayer,
    $core.double? buyerTotal,
    $core.double? sellerNet,
    $core.String? status,
    $core.int? fraudScore,
    $core.Iterable<$core.String>? fraudFlags,
    $core.bool? requiresAdminReview,
    $core.String? deliveryNote,
    $1.Timestamp? deadlineAt,
    $1.Timestamp? fundedAt,
    $1.Timestamp? deliveredAt,
    $1.Timestamp? releasedAt,
    $1.Timestamp? createdAt,
    $1.Timestamp? updatedAt,
    $core.Iterable<DealEvent>? events,
    $core.String? buyerItemImageUrl,
    $core.String? sellerProofImageUrl,
    $core.Iterable<Attachment>? attachments,
    RefundRequest? refundRequest,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (reference != null) {
      _result.reference = reference;
    }
    if (buyerUserId != null) {
      _result.buyerUserId = buyerUserId;
    }
    if (buyerAccountId != null) {
      _result.buyerAccountId = buyerAccountId;
    }
    if (buyerName != null) {
      _result.buyerName = buyerName;
    }
    if (sellerUserId != null) {
      _result.sellerUserId = sellerUserId;
    }
    if (sellerAccountId != null) {
      _result.sellerAccountId = sellerAccountId;
    }
    if (sellerName != null) {
      _result.sellerName = sellerName;
    }
    if (title != null) {
      _result.title = title;
    }
    if (description != null) {
      _result.description = description;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (fee != null) {
      _result.fee = fee;
    }
    if (feePayer != null) {
      _result.feePayer = feePayer;
    }
    if (buyerTotal != null) {
      _result.buyerTotal = buyerTotal;
    }
    if (sellerNet != null) {
      _result.sellerNet = sellerNet;
    }
    if (status != null) {
      _result.status = status;
    }
    if (fraudScore != null) {
      _result.fraudScore = fraudScore;
    }
    if (fraudFlags != null) {
      _result.fraudFlags.addAll(fraudFlags);
    }
    if (requiresAdminReview != null) {
      _result.requiresAdminReview = requiresAdminReview;
    }
    if (deliveryNote != null) {
      _result.deliveryNote = deliveryNote;
    }
    if (deadlineAt != null) {
      _result.deadlineAt = deadlineAt;
    }
    if (fundedAt != null) {
      _result.fundedAt = fundedAt;
    }
    if (deliveredAt != null) {
      _result.deliveredAt = deliveredAt;
    }
    if (releasedAt != null) {
      _result.releasedAt = releasedAt;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      _result.updatedAt = updatedAt;
    }
    if (events != null) {
      _result.events.addAll(events);
    }
    if (buyerItemImageUrl != null) {
      _result.buyerItemImageUrl = buyerItemImageUrl;
    }
    if (sellerProofImageUrl != null) {
      _result.sellerProofImageUrl = sellerProofImageUrl;
    }
    if (attachments != null) {
      _result.attachments.addAll(attachments);
    }
    if (refundRequest != null) {
      _result.refundRequest = refundRequest;
    }
    return _result;
  }
  factory Deal.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Deal.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Deal clone() => Deal()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Deal copyWith(void Function(Deal) updates) => super.copyWith((message) => updates(message as Deal)) as Deal; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Deal create() => Deal._();
  Deal createEmptyInstance() => create();
  static $pb.PbList<Deal> createRepeated() => $pb.PbList<Deal>();
  @$core.pragma('dart2js:noInline')
  static Deal getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Deal>(create);
  static Deal? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get reference => $_getSZ(1);
  @$pb.TagNumber(2)
  set reference($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasReference() => $_has(1);
  @$pb.TagNumber(2)
  void clearReference() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get buyerUserId => $_getSZ(2);
  @$pb.TagNumber(3)
  set buyerUserId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasBuyerUserId() => $_has(2);
  @$pb.TagNumber(3)
  void clearBuyerUserId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get buyerAccountId => $_getSZ(3);
  @$pb.TagNumber(4)
  set buyerAccountId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasBuyerAccountId() => $_has(3);
  @$pb.TagNumber(4)
  void clearBuyerAccountId() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get buyerName => $_getSZ(4);
  @$pb.TagNumber(5)
  set buyerName($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasBuyerName() => $_has(4);
  @$pb.TagNumber(5)
  void clearBuyerName() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get sellerUserId => $_getSZ(5);
  @$pb.TagNumber(6)
  set sellerUserId($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasSellerUserId() => $_has(5);
  @$pb.TagNumber(6)
  void clearSellerUserId() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get sellerAccountId => $_getSZ(6);
  @$pb.TagNumber(7)
  set sellerAccountId($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasSellerAccountId() => $_has(6);
  @$pb.TagNumber(7)
  void clearSellerAccountId() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get sellerName => $_getSZ(7);
  @$pb.TagNumber(8)
  set sellerName($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasSellerName() => $_has(7);
  @$pb.TagNumber(8)
  void clearSellerName() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get title => $_getSZ(8);
  @$pb.TagNumber(9)
  set title($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasTitle() => $_has(8);
  @$pb.TagNumber(9)
  void clearTitle() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get description => $_getSZ(9);
  @$pb.TagNumber(10)
  set description($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasDescription() => $_has(9);
  @$pb.TagNumber(10)
  void clearDescription() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get currency => $_getSZ(10);
  @$pb.TagNumber(11)
  set currency($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasCurrency() => $_has(10);
  @$pb.TagNumber(11)
  void clearCurrency() => clearField(11);

  @$pb.TagNumber(12)
  $core.double get amount => $_getN(11);
  @$pb.TagNumber(12)
  set amount($core.double v) { $_setDouble(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasAmount() => $_has(11);
  @$pb.TagNumber(12)
  void clearAmount() => clearField(12);

  @$pb.TagNumber(13)
  $core.double get fee => $_getN(12);
  @$pb.TagNumber(13)
  set fee($core.double v) { $_setDouble(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasFee() => $_has(12);
  @$pb.TagNumber(13)
  void clearFee() => clearField(13);

  @$pb.TagNumber(14)
  $core.String get feePayer => $_getSZ(13);
  @$pb.TagNumber(14)
  set feePayer($core.String v) { $_setString(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasFeePayer() => $_has(13);
  @$pb.TagNumber(14)
  void clearFeePayer() => clearField(14);

  @$pb.TagNumber(15)
  $core.double get buyerTotal => $_getN(14);
  @$pb.TagNumber(15)
  set buyerTotal($core.double v) { $_setDouble(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasBuyerTotal() => $_has(14);
  @$pb.TagNumber(15)
  void clearBuyerTotal() => clearField(15);

  @$pb.TagNumber(16)
  $core.double get sellerNet => $_getN(15);
  @$pb.TagNumber(16)
  set sellerNet($core.double v) { $_setDouble(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasSellerNet() => $_has(15);
  @$pb.TagNumber(16)
  void clearSellerNet() => clearField(16);

  @$pb.TagNumber(17)
  $core.String get status => $_getSZ(16);
  @$pb.TagNumber(17)
  set status($core.String v) { $_setString(16, v); }
  @$pb.TagNumber(17)
  $core.bool hasStatus() => $_has(16);
  @$pb.TagNumber(17)
  void clearStatus() => clearField(17);

  @$pb.TagNumber(18)
  $core.int get fraudScore => $_getIZ(17);
  @$pb.TagNumber(18)
  set fraudScore($core.int v) { $_setSignedInt32(17, v); }
  @$pb.TagNumber(18)
  $core.bool hasFraudScore() => $_has(17);
  @$pb.TagNumber(18)
  void clearFraudScore() => clearField(18);

  @$pb.TagNumber(19)
  $core.List<$core.String> get fraudFlags => $_getList(18);

  @$pb.TagNumber(20)
  $core.bool get requiresAdminReview => $_getBF(19);
  @$pb.TagNumber(20)
  set requiresAdminReview($core.bool v) { $_setBool(19, v); }
  @$pb.TagNumber(20)
  $core.bool hasRequiresAdminReview() => $_has(19);
  @$pb.TagNumber(20)
  void clearRequiresAdminReview() => clearField(20);

  @$pb.TagNumber(21)
  $core.String get deliveryNote => $_getSZ(20);
  @$pb.TagNumber(21)
  set deliveryNote($core.String v) { $_setString(20, v); }
  @$pb.TagNumber(21)
  $core.bool hasDeliveryNote() => $_has(20);
  @$pb.TagNumber(21)
  void clearDeliveryNote() => clearField(21);

  @$pb.TagNumber(22)
  $1.Timestamp get deadlineAt => $_getN(21);
  @$pb.TagNumber(22)
  set deadlineAt($1.Timestamp v) { setField(22, v); }
  @$pb.TagNumber(22)
  $core.bool hasDeadlineAt() => $_has(21);
  @$pb.TagNumber(22)
  void clearDeadlineAt() => clearField(22);
  @$pb.TagNumber(22)
  $1.Timestamp ensureDeadlineAt() => $_ensure(21);

  @$pb.TagNumber(23)
  $1.Timestamp get fundedAt => $_getN(22);
  @$pb.TagNumber(23)
  set fundedAt($1.Timestamp v) { setField(23, v); }
  @$pb.TagNumber(23)
  $core.bool hasFundedAt() => $_has(22);
  @$pb.TagNumber(23)
  void clearFundedAt() => clearField(23);
  @$pb.TagNumber(23)
  $1.Timestamp ensureFundedAt() => $_ensure(22);

  @$pb.TagNumber(24)
  $1.Timestamp get deliveredAt => $_getN(23);
  @$pb.TagNumber(24)
  set deliveredAt($1.Timestamp v) { setField(24, v); }
  @$pb.TagNumber(24)
  $core.bool hasDeliveredAt() => $_has(23);
  @$pb.TagNumber(24)
  void clearDeliveredAt() => clearField(24);
  @$pb.TagNumber(24)
  $1.Timestamp ensureDeliveredAt() => $_ensure(23);

  @$pb.TagNumber(25)
  $1.Timestamp get releasedAt => $_getN(24);
  @$pb.TagNumber(25)
  set releasedAt($1.Timestamp v) { setField(25, v); }
  @$pb.TagNumber(25)
  $core.bool hasReleasedAt() => $_has(24);
  @$pb.TagNumber(25)
  void clearReleasedAt() => clearField(25);
  @$pb.TagNumber(25)
  $1.Timestamp ensureReleasedAt() => $_ensure(24);

  @$pb.TagNumber(26)
  $1.Timestamp get createdAt => $_getN(25);
  @$pb.TagNumber(26)
  set createdAt($1.Timestamp v) { setField(26, v); }
  @$pb.TagNumber(26)
  $core.bool hasCreatedAt() => $_has(25);
  @$pb.TagNumber(26)
  void clearCreatedAt() => clearField(26);
  @$pb.TagNumber(26)
  $1.Timestamp ensureCreatedAt() => $_ensure(25);

  @$pb.TagNumber(27)
  $1.Timestamp get updatedAt => $_getN(26);
  @$pb.TagNumber(27)
  set updatedAt($1.Timestamp v) { setField(27, v); }
  @$pb.TagNumber(27)
  $core.bool hasUpdatedAt() => $_has(26);
  @$pb.TagNumber(27)
  void clearUpdatedAt() => clearField(27);
  @$pb.TagNumber(27)
  $1.Timestamp ensureUpdatedAt() => $_ensure(26);

  @$pb.TagNumber(28)
  $core.List<DealEvent> get events => $_getList(27);

  @$pb.TagNumber(29)
  $core.String get buyerItemImageUrl => $_getSZ(28);
  @$pb.TagNumber(29)
  set buyerItemImageUrl($core.String v) { $_setString(28, v); }
  @$pb.TagNumber(29)
  $core.bool hasBuyerItemImageUrl() => $_has(28);
  @$pb.TagNumber(29)
  void clearBuyerItemImageUrl() => clearField(29);

  @$pb.TagNumber(30)
  $core.String get sellerProofImageUrl => $_getSZ(29);
  @$pb.TagNumber(30)
  set sellerProofImageUrl($core.String v) { $_setString(29, v); }
  @$pb.TagNumber(30)
  $core.bool hasSellerProofImageUrl() => $_has(29);
  @$pb.TagNumber(30)
  void clearSellerProofImageUrl() => clearField(30);

  @$pb.TagNumber(31)
  $core.List<Attachment> get attachments => $_getList(30);

  @$pb.TagNumber(32)
  RefundRequest get refundRequest => $_getN(31);
  @$pb.TagNumber(32)
  set refundRequest(RefundRequest v) { setField(32, v); }
  @$pb.TagNumber(32)
  $core.bool hasRefundRequest() => $_has(31);
  @$pb.TagNumber(32)
  void clearRefundRequest() => clearField(32);
  @$pb.TagNumber(32)
  RefundRequest ensureRefundRequest() => $_ensure(31);
}

class Attachment extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Attachment', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'escrow'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'purpose')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'mediaKind')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'url')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'contentType')
    ..aInt64(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sizeBytes')
    ..a<$core.int>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'durationSeconds', $pb.PbFieldType.O3)
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'uploadedBy')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'actorRole')
    ..aOM<$1.Timestamp>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false
  ;

  Attachment._() : super();
  factory Attachment({
    $core.String? id,
    $core.String? purpose,
    $core.String? mediaKind,
    $core.String? url,
    $core.String? contentType,
    $fixnum.Int64? sizeBytes,
    $core.int? durationSeconds,
    $core.String? uploadedBy,
    $core.String? actorRole,
    $1.Timestamp? createdAt,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (purpose != null) {
      _result.purpose = purpose;
    }
    if (mediaKind != null) {
      _result.mediaKind = mediaKind;
    }
    if (url != null) {
      _result.url = url;
    }
    if (contentType != null) {
      _result.contentType = contentType;
    }
    if (sizeBytes != null) {
      _result.sizeBytes = sizeBytes;
    }
    if (durationSeconds != null) {
      _result.durationSeconds = durationSeconds;
    }
    if (uploadedBy != null) {
      _result.uploadedBy = uploadedBy;
    }
    if (actorRole != null) {
      _result.actorRole = actorRole;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    return _result;
  }
  factory Attachment.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Attachment.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Attachment clone() => Attachment()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Attachment copyWith(void Function(Attachment) updates) => super.copyWith((message) => updates(message as Attachment)) as Attachment; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Attachment create() => Attachment._();
  Attachment createEmptyInstance() => create();
  static $pb.PbList<Attachment> createRepeated() => $pb.PbList<Attachment>();
  @$core.pragma('dart2js:noInline')
  static Attachment getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Attachment>(create);
  static Attachment? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get purpose => $_getSZ(1);
  @$pb.TagNumber(2)
  set purpose($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPurpose() => $_has(1);
  @$pb.TagNumber(2)
  void clearPurpose() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get mediaKind => $_getSZ(2);
  @$pb.TagNumber(3)
  set mediaKind($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMediaKind() => $_has(2);
  @$pb.TagNumber(3)
  void clearMediaKind() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get url => $_getSZ(3);
  @$pb.TagNumber(4)
  set url($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasUrl() => $_has(3);
  @$pb.TagNumber(4)
  void clearUrl() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get contentType => $_getSZ(4);
  @$pb.TagNumber(5)
  set contentType($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasContentType() => $_has(4);
  @$pb.TagNumber(5)
  void clearContentType() => clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get sizeBytes => $_getI64(5);
  @$pb.TagNumber(6)
  set sizeBytes($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasSizeBytes() => $_has(5);
  @$pb.TagNumber(6)
  void clearSizeBytes() => clearField(6);

  @$pb.TagNumber(7)
  $core.int get durationSeconds => $_getIZ(6);
  @$pb.TagNumber(7)
  set durationSeconds($core.int v) { $_setSignedInt32(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasDurationSeconds() => $_has(6);
  @$pb.TagNumber(7)
  void clearDurationSeconds() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get uploadedBy => $_getSZ(7);
  @$pb.TagNumber(8)
  set uploadedBy($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasUploadedBy() => $_has(7);
  @$pb.TagNumber(8)
  void clearUploadedBy() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get actorRole => $_getSZ(8);
  @$pb.TagNumber(9)
  set actorRole($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasActorRole() => $_has(8);
  @$pb.TagNumber(9)
  void clearActorRole() => clearField(9);

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
}

class RefundRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RefundRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'escrow'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dealId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'requestedBy')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reason')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..aOM<$1.Timestamp>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'responseDeadlineAt', subBuilder: $1.Timestamp.create)
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'respondedBy')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'responseNote')
    ..aOM<$1.Timestamp>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'respondedAt', subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $1.Timestamp.create)
    ..pc<Attachment>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'attachments', $pb.PbFieldType.PM, subBuilder: Attachment.create)
    ..hasRequiredFields = false
  ;

  RefundRequest._() : super();
  factory RefundRequest({
    $core.String? id,
    $core.String? dealId,
    $core.String? requestedBy,
    $core.String? reason,
    $core.String? status,
    $1.Timestamp? responseDeadlineAt,
    $core.String? respondedBy,
    $core.String? responseNote,
    $1.Timestamp? respondedAt,
    $1.Timestamp? createdAt,
    $core.Iterable<Attachment>? attachments,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (dealId != null) {
      _result.dealId = dealId;
    }
    if (requestedBy != null) {
      _result.requestedBy = requestedBy;
    }
    if (reason != null) {
      _result.reason = reason;
    }
    if (status != null) {
      _result.status = status;
    }
    if (responseDeadlineAt != null) {
      _result.responseDeadlineAt = responseDeadlineAt;
    }
    if (respondedBy != null) {
      _result.respondedBy = respondedBy;
    }
    if (responseNote != null) {
      _result.responseNote = responseNote;
    }
    if (respondedAt != null) {
      _result.respondedAt = respondedAt;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (attachments != null) {
      _result.attachments.addAll(attachments);
    }
    return _result;
  }
  factory RefundRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RefundRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RefundRequest clone() => RefundRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RefundRequest copyWith(void Function(RefundRequest) updates) => super.copyWith((message) => updates(message as RefundRequest)) as RefundRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RefundRequest create() => RefundRequest._();
  RefundRequest createEmptyInstance() => create();
  static $pb.PbList<RefundRequest> createRepeated() => $pb.PbList<RefundRequest>();
  @$core.pragma('dart2js:noInline')
  static RefundRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RefundRequest>(create);
  static RefundRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get dealId => $_getSZ(1);
  @$pb.TagNumber(2)
  set dealId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasDealId() => $_has(1);
  @$pb.TagNumber(2)
  void clearDealId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get requestedBy => $_getSZ(2);
  @$pb.TagNumber(3)
  set requestedBy($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasRequestedBy() => $_has(2);
  @$pb.TagNumber(3)
  void clearRequestedBy() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get reason => $_getSZ(3);
  @$pb.TagNumber(4)
  set reason($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasReason() => $_has(3);
  @$pb.TagNumber(4)
  void clearReason() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get status => $_getSZ(4);
  @$pb.TagNumber(5)
  set status($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasStatus() => $_has(4);
  @$pb.TagNumber(5)
  void clearStatus() => clearField(5);

  @$pb.TagNumber(6)
  $1.Timestamp get responseDeadlineAt => $_getN(5);
  @$pb.TagNumber(6)
  set responseDeadlineAt($1.Timestamp v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasResponseDeadlineAt() => $_has(5);
  @$pb.TagNumber(6)
  void clearResponseDeadlineAt() => clearField(6);
  @$pb.TagNumber(6)
  $1.Timestamp ensureResponseDeadlineAt() => $_ensure(5);

  @$pb.TagNumber(7)
  $core.String get respondedBy => $_getSZ(6);
  @$pb.TagNumber(7)
  set respondedBy($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasRespondedBy() => $_has(6);
  @$pb.TagNumber(7)
  void clearRespondedBy() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get responseNote => $_getSZ(7);
  @$pb.TagNumber(8)
  set responseNote($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasResponseNote() => $_has(7);
  @$pb.TagNumber(8)
  void clearResponseNote() => clearField(8);

  @$pb.TagNumber(9)
  $1.Timestamp get respondedAt => $_getN(8);
  @$pb.TagNumber(9)
  set respondedAt($1.Timestamp v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasRespondedAt() => $_has(8);
  @$pb.TagNumber(9)
  void clearRespondedAt() => clearField(9);
  @$pb.TagNumber(9)
  $1.Timestamp ensureRespondedAt() => $_ensure(8);

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
  $core.List<Attachment> get attachments => $_getList(10);
}

class DealEvent extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DealEvent', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'escrow'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dealId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'eventType')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'actor')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'detail')
    ..aOM<$1.Timestamp>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false
  ;

  DealEvent._() : super();
  factory DealEvent({
    $core.String? id,
    $core.String? dealId,
    $core.String? eventType,
    $core.String? actor,
    $core.String? detail,
    $1.Timestamp? createdAt,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (dealId != null) {
      _result.dealId = dealId;
    }
    if (eventType != null) {
      _result.eventType = eventType;
    }
    if (actor != null) {
      _result.actor = actor;
    }
    if (detail != null) {
      _result.detail = detail;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    return _result;
  }
  factory DealEvent.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DealEvent.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DealEvent clone() => DealEvent()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DealEvent copyWith(void Function(DealEvent) updates) => super.copyWith((message) => updates(message as DealEvent)) as DealEvent; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DealEvent create() => DealEvent._();
  DealEvent createEmptyInstance() => create();
  static $pb.PbList<DealEvent> createRepeated() => $pb.PbList<DealEvent>();
  @$core.pragma('dart2js:noInline')
  static DealEvent getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DealEvent>(create);
  static DealEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get dealId => $_getSZ(1);
  @$pb.TagNumber(2)
  set dealId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasDealId() => $_has(1);
  @$pb.TagNumber(2)
  void clearDealId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get eventType => $_getSZ(2);
  @$pb.TagNumber(3)
  set eventType($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasEventType() => $_has(2);
  @$pb.TagNumber(3)
  void clearEventType() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get actor => $_getSZ(3);
  @$pb.TagNumber(4)
  set actor($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasActor() => $_has(3);
  @$pb.TagNumber(4)
  void clearActor() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get detail => $_getSZ(4);
  @$pb.TagNumber(5)
  set detail($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasDetail() => $_has(4);
  @$pb.TagNumber(5)
  void clearDetail() => clearField(5);

  @$pb.TagNumber(6)
  $1.Timestamp get createdAt => $_getN(5);
  @$pb.TagNumber(6)
  set createdAt($1.Timestamp v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasCreatedAt() => $_has(5);
  @$pb.TagNumber(6)
  void clearCreatedAt() => clearField(6);
  @$pb.TagNumber(6)
  $1.Timestamp ensureCreatedAt() => $_ensure(5);
}

class CreateDealRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateDealRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'escrow'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'buyerAccountId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sellerQuery')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'title')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..a<$core.int>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'deadlineDays', $pb.PbFieldType.O3)
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionId')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'verificationToken')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'idempotencyKey')
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'buyerItemImageUrl')
    ..hasRequiredFields = false
  ;

  CreateDealRequest._() : super();
  factory CreateDealRequest({
    $core.String? buyerAccountId,
    $core.String? sellerQuery,
    $core.String? title,
    $core.String? description,
    $core.double? amount,
    $core.int? deadlineDays,
    $core.String? transactionId,
    $core.String? verificationToken,
    $core.String? idempotencyKey,
    $core.String? buyerItemImageUrl,
  }) {
    final _result = create();
    if (buyerAccountId != null) {
      _result.buyerAccountId = buyerAccountId;
    }
    if (sellerQuery != null) {
      _result.sellerQuery = sellerQuery;
    }
    if (title != null) {
      _result.title = title;
    }
    if (description != null) {
      _result.description = description;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (deadlineDays != null) {
      _result.deadlineDays = deadlineDays;
    }
    if (transactionId != null) {
      _result.transactionId = transactionId;
    }
    if (verificationToken != null) {
      _result.verificationToken = verificationToken;
    }
    if (idempotencyKey != null) {
      _result.idempotencyKey = idempotencyKey;
    }
    if (buyerItemImageUrl != null) {
      _result.buyerItemImageUrl = buyerItemImageUrl;
    }
    return _result;
  }
  factory CreateDealRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateDealRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateDealRequest clone() => CreateDealRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateDealRequest copyWith(void Function(CreateDealRequest) updates) => super.copyWith((message) => updates(message as CreateDealRequest)) as CreateDealRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateDealRequest create() => CreateDealRequest._();
  CreateDealRequest createEmptyInstance() => create();
  static $pb.PbList<CreateDealRequest> createRepeated() => $pb.PbList<CreateDealRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateDealRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateDealRequest>(create);
  static CreateDealRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get buyerAccountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set buyerAccountId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasBuyerAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearBuyerAccountId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get sellerQuery => $_getSZ(1);
  @$pb.TagNumber(2)
  set sellerQuery($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSellerQuery() => $_has(1);
  @$pb.TagNumber(2)
  void clearSellerQuery() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get title => $_getSZ(2);
  @$pb.TagNumber(3)
  set title($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTitle() => $_has(2);
  @$pb.TagNumber(3)
  void clearTitle() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get description => $_getSZ(3);
  @$pb.TagNumber(4)
  set description($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasDescription() => $_has(3);
  @$pb.TagNumber(4)
  void clearDescription() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get amount => $_getN(4);
  @$pb.TagNumber(5)
  set amount($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasAmount() => $_has(4);
  @$pb.TagNumber(5)
  void clearAmount() => clearField(5);

  @$pb.TagNumber(6)
  $core.int get deadlineDays => $_getIZ(5);
  @$pb.TagNumber(6)
  set deadlineDays($core.int v) { $_setSignedInt32(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasDeadlineDays() => $_has(5);
  @$pb.TagNumber(6)
  void clearDeadlineDays() => clearField(6);

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

  @$pb.TagNumber(9)
  $core.String get idempotencyKey => $_getSZ(8);
  @$pb.TagNumber(9)
  set idempotencyKey($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasIdempotencyKey() => $_has(8);
  @$pb.TagNumber(9)
  void clearIdempotencyKey() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get buyerItemImageUrl => $_getSZ(9);
  @$pb.TagNumber(10)
  set buyerItemImageUrl($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasBuyerItemImageUrl() => $_has(9);
  @$pb.TagNumber(10)
  void clearBuyerItemImageUrl() => clearField(10);
}

class ListMyDealsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ListMyDealsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'escrow'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'role')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  ListMyDealsRequest._() : super();
  factory ListMyDealsRequest({
    $core.String? role,
    $core.String? status,
    $core.int? page,
    $core.int? limit,
  }) {
    final _result = create();
    if (role != null) {
      _result.role = role;
    }
    if (status != null) {
      _result.status = status;
    }
    if (page != null) {
      _result.page = page;
    }
    if (limit != null) {
      _result.limit = limit;
    }
    return _result;
  }
  factory ListMyDealsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListMyDealsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListMyDealsRequest clone() => ListMyDealsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListMyDealsRequest copyWith(void Function(ListMyDealsRequest) updates) => super.copyWith((message) => updates(message as ListMyDealsRequest)) as ListMyDealsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ListMyDealsRequest create() => ListMyDealsRequest._();
  ListMyDealsRequest createEmptyInstance() => create();
  static $pb.PbList<ListMyDealsRequest> createRepeated() => $pb.PbList<ListMyDealsRequest>();
  @$core.pragma('dart2js:noInline')
  static ListMyDealsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListMyDealsRequest>(create);
  static ListMyDealsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get role => $_getSZ(0);
  @$pb.TagNumber(1)
  set role($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRole() => $_has(0);
  @$pb.TagNumber(1)
  void clearRole() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get status => $_getSZ(1);
  @$pb.TagNumber(2)
  set status($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get page => $_getIZ(2);
  @$pb.TagNumber(3)
  set page($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPage() => $_has(2);
  @$pb.TagNumber(3)
  void clearPage() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get limit => $_getIZ(3);
  @$pb.TagNumber(4)
  set limit($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasLimit() => $_has(3);
  @$pb.TagNumber(4)
  void clearLimit() => clearField(4);
}

class ListDealsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ListDealsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'escrow'), createEmptyInstance: create)
    ..pc<Deal>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'deals', $pb.PbFieldType.PM, subBuilder: Deal.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  ListDealsResponse._() : super();
  factory ListDealsResponse({
    $core.Iterable<Deal>? deals,
    $core.int? total,
  }) {
    final _result = create();
    if (deals != null) {
      _result.deals.addAll(deals);
    }
    if (total != null) {
      _result.total = total;
    }
    return _result;
  }
  factory ListDealsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListDealsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListDealsResponse clone() => ListDealsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListDealsResponse copyWith(void Function(ListDealsResponse) updates) => super.copyWith((message) => updates(message as ListDealsResponse)) as ListDealsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ListDealsResponse create() => ListDealsResponse._();
  ListDealsResponse createEmptyInstance() => create();
  static $pb.PbList<ListDealsResponse> createRepeated() => $pb.PbList<ListDealsResponse>();
  @$core.pragma('dart2js:noInline')
  static ListDealsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListDealsResponse>(create);
  static ListDealsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Deal> get deals => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => clearField(2);
}

class GetDealRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetDealRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'escrow'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dealId')
    ..hasRequiredFields = false
  ;

  GetDealRequest._() : super();
  factory GetDealRequest({
    $core.String? dealId,
  }) {
    final _result = create();
    if (dealId != null) {
      _result.dealId = dealId;
    }
    return _result;
  }
  factory GetDealRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetDealRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetDealRequest clone() => GetDealRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetDealRequest copyWith(void Function(GetDealRequest) updates) => super.copyWith((message) => updates(message as GetDealRequest)) as GetDealRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetDealRequest create() => GetDealRequest._();
  GetDealRequest createEmptyInstance() => create();
  static $pb.PbList<GetDealRequest> createRepeated() => $pb.PbList<GetDealRequest>();
  @$core.pragma('dart2js:noInline')
  static GetDealRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetDealRequest>(create);
  static GetDealRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get dealId => $_getSZ(0);
  @$pb.TagNumber(1)
  set dealId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDealId() => $_has(0);
  @$pb.TagNumber(1)
  void clearDealId() => clearField(1);
}

class DealResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DealResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'escrow'), createEmptyInstance: create)
    ..aOM<Deal>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'deal', subBuilder: Deal.create)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  DealResponse._() : super();
  factory DealResponse({
    Deal? deal,
    $core.String? message,
  }) {
    final _result = create();
    if (deal != null) {
      _result.deal = deal;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory DealResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DealResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DealResponse clone() => DealResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DealResponse copyWith(void Function(DealResponse) updates) => super.copyWith((message) => updates(message as DealResponse)) as DealResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DealResponse create() => DealResponse._();
  DealResponse createEmptyInstance() => create();
  static $pb.PbList<DealResponse> createRepeated() => $pb.PbList<DealResponse>();
  @$core.pragma('dart2js:noInline')
  static DealResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DealResponse>(create);
  static DealResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Deal get deal => $_getN(0);
  @$pb.TagNumber(1)
  set deal(Deal v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasDeal() => $_has(0);
  @$pb.TagNumber(1)
  void clearDeal() => clearField(1);
  @$pb.TagNumber(1)
  Deal ensureDeal() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

class MarkDeliveredRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MarkDeliveredRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'escrow'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dealId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'deliveryNote')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sellerProofImageUrl')
    ..hasRequiredFields = false
  ;

  MarkDeliveredRequest._() : super();
  factory MarkDeliveredRequest({
    $core.String? dealId,
    $core.String? deliveryNote,
    $core.String? sellerProofImageUrl,
  }) {
    final _result = create();
    if (dealId != null) {
      _result.dealId = dealId;
    }
    if (deliveryNote != null) {
      _result.deliveryNote = deliveryNote;
    }
    if (sellerProofImageUrl != null) {
      _result.sellerProofImageUrl = sellerProofImageUrl;
    }
    return _result;
  }
  factory MarkDeliveredRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MarkDeliveredRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MarkDeliveredRequest clone() => MarkDeliveredRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MarkDeliveredRequest copyWith(void Function(MarkDeliveredRequest) updates) => super.copyWith((message) => updates(message as MarkDeliveredRequest)) as MarkDeliveredRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MarkDeliveredRequest create() => MarkDeliveredRequest._();
  MarkDeliveredRequest createEmptyInstance() => create();
  static $pb.PbList<MarkDeliveredRequest> createRepeated() => $pb.PbList<MarkDeliveredRequest>();
  @$core.pragma('dart2js:noInline')
  static MarkDeliveredRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MarkDeliveredRequest>(create);
  static MarkDeliveredRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get dealId => $_getSZ(0);
  @$pb.TagNumber(1)
  set dealId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDealId() => $_has(0);
  @$pb.TagNumber(1)
  void clearDealId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get deliveryNote => $_getSZ(1);
  @$pb.TagNumber(2)
  set deliveryNote($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasDeliveryNote() => $_has(1);
  @$pb.TagNumber(2)
  void clearDeliveryNote() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get sellerProofImageUrl => $_getSZ(2);
  @$pb.TagNumber(3)
  set sellerProofImageUrl($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSellerProofImageUrl() => $_has(2);
  @$pb.TagNumber(3)
  void clearSellerProofImageUrl() => clearField(3);
}

class ValidateReleaseRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ValidateReleaseRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'escrow'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dealId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'verificationToken')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'idempotencyKey')
    ..hasRequiredFields = false
  ;

  ValidateReleaseRequest._() : super();
  factory ValidateReleaseRequest({
    $core.String? dealId,
    $core.String? transactionId,
    $core.String? verificationToken,
    $core.String? idempotencyKey,
  }) {
    final _result = create();
    if (dealId != null) {
      _result.dealId = dealId;
    }
    if (transactionId != null) {
      _result.transactionId = transactionId;
    }
    if (verificationToken != null) {
      _result.verificationToken = verificationToken;
    }
    if (idempotencyKey != null) {
      _result.idempotencyKey = idempotencyKey;
    }
    return _result;
  }
  factory ValidateReleaseRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ValidateReleaseRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ValidateReleaseRequest clone() => ValidateReleaseRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ValidateReleaseRequest copyWith(void Function(ValidateReleaseRequest) updates) => super.copyWith((message) => updates(message as ValidateReleaseRequest)) as ValidateReleaseRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ValidateReleaseRequest create() => ValidateReleaseRequest._();
  ValidateReleaseRequest createEmptyInstance() => create();
  static $pb.PbList<ValidateReleaseRequest> createRepeated() => $pb.PbList<ValidateReleaseRequest>();
  @$core.pragma('dart2js:noInline')
  static ValidateReleaseRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ValidateReleaseRequest>(create);
  static ValidateReleaseRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get dealId => $_getSZ(0);
  @$pb.TagNumber(1)
  set dealId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDealId() => $_has(0);
  @$pb.TagNumber(1)
  void clearDealId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get transactionId => $_getSZ(1);
  @$pb.TagNumber(2)
  set transactionId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTransactionId() => $_has(1);
  @$pb.TagNumber(2)
  void clearTransactionId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get verificationToken => $_getSZ(2);
  @$pb.TagNumber(3)
  set verificationToken($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasVerificationToken() => $_has(2);
  @$pb.TagNumber(3)
  void clearVerificationToken() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get idempotencyKey => $_getSZ(3);
  @$pb.TagNumber(4)
  set idempotencyKey($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasIdempotencyKey() => $_has(3);
  @$pb.TagNumber(4)
  void clearIdempotencyKey() => clearField(4);
}

class CancelDealRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CancelDealRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'escrow'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dealId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reason')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'idempotencyKey')
    ..hasRequiredFields = false
  ;

  CancelDealRequest._() : super();
  factory CancelDealRequest({
    $core.String? dealId,
    $core.String? reason,
    $core.String? idempotencyKey,
  }) {
    final _result = create();
    if (dealId != null) {
      _result.dealId = dealId;
    }
    if (reason != null) {
      _result.reason = reason;
    }
    if (idempotencyKey != null) {
      _result.idempotencyKey = idempotencyKey;
    }
    return _result;
  }
  factory CancelDealRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CancelDealRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CancelDealRequest clone() => CancelDealRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CancelDealRequest copyWith(void Function(CancelDealRequest) updates) => super.copyWith((message) => updates(message as CancelDealRequest)) as CancelDealRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CancelDealRequest create() => CancelDealRequest._();
  CancelDealRequest createEmptyInstance() => create();
  static $pb.PbList<CancelDealRequest> createRepeated() => $pb.PbList<CancelDealRequest>();
  @$core.pragma('dart2js:noInline')
  static CancelDealRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CancelDealRequest>(create);
  static CancelDealRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get dealId => $_getSZ(0);
  @$pb.TagNumber(1)
  set dealId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDealId() => $_has(0);
  @$pb.TagNumber(1)
  void clearDealId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get reason => $_getSZ(1);
  @$pb.TagNumber(2)
  set reason($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasReason() => $_has(1);
  @$pb.TagNumber(2)
  void clearReason() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get idempotencyKey => $_getSZ(2);
  @$pb.TagNumber(3)
  set idempotencyKey($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasIdempotencyKey() => $_has(2);
  @$pb.TagNumber(3)
  void clearIdempotencyKey() => clearField(3);
}

class OpenDisputeRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'OpenDisputeRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'escrow'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dealId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reason')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'evidenceUrl')
    ..hasRequiredFields = false
  ;

  OpenDisputeRequest._() : super();
  factory OpenDisputeRequest({
    $core.String? dealId,
    $core.String? reason,
    $core.String? evidenceUrl,
  }) {
    final _result = create();
    if (dealId != null) {
      _result.dealId = dealId;
    }
    if (reason != null) {
      _result.reason = reason;
    }
    if (evidenceUrl != null) {
      _result.evidenceUrl = evidenceUrl;
    }
    return _result;
  }
  factory OpenDisputeRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory OpenDisputeRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  OpenDisputeRequest clone() => OpenDisputeRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  OpenDisputeRequest copyWith(void Function(OpenDisputeRequest) updates) => super.copyWith((message) => updates(message as OpenDisputeRequest)) as OpenDisputeRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static OpenDisputeRequest create() => OpenDisputeRequest._();
  OpenDisputeRequest createEmptyInstance() => create();
  static $pb.PbList<OpenDisputeRequest> createRepeated() => $pb.PbList<OpenDisputeRequest>();
  @$core.pragma('dart2js:noInline')
  static OpenDisputeRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<OpenDisputeRequest>(create);
  static OpenDisputeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get dealId => $_getSZ(0);
  @$pb.TagNumber(1)
  set dealId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDealId() => $_has(0);
  @$pb.TagNumber(1)
  void clearDealId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get reason => $_getSZ(1);
  @$pb.TagNumber(2)
  set reason($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasReason() => $_has(1);
  @$pb.TagNumber(2)
  void clearReason() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get evidenceUrl => $_getSZ(2);
  @$pb.TagNumber(3)
  set evidenceUrl($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasEvidenceUrl() => $_has(2);
  @$pb.TagNumber(3)
  void clearEvidenceUrl() => clearField(3);
}

class QuoteFeeRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'QuoteFeeRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'escrow'), createEmptyInstance: create)
    ..a<$core.double>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..hasRequiredFields = false
  ;

  QuoteFeeRequest._() : super();
  factory QuoteFeeRequest({
    $core.double? amount,
    $core.String? currency,
  }) {
    final _result = create();
    if (amount != null) {
      _result.amount = amount;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    return _result;
  }
  factory QuoteFeeRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory QuoteFeeRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  QuoteFeeRequest clone() => QuoteFeeRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  QuoteFeeRequest copyWith(void Function(QuoteFeeRequest) updates) => super.copyWith((message) => updates(message as QuoteFeeRequest)) as QuoteFeeRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static QuoteFeeRequest create() => QuoteFeeRequest._();
  QuoteFeeRequest createEmptyInstance() => create();
  static $pb.PbList<QuoteFeeRequest> createRepeated() => $pb.PbList<QuoteFeeRequest>();
  @$core.pragma('dart2js:noInline')
  static QuoteFeeRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<QuoteFeeRequest>(create);
  static QuoteFeeRequest? _defaultInstance;

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
}

class QuoteFeeResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'QuoteFeeResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'escrow'), createEmptyInstance: create)
    ..a<$core.double>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fee', $pb.PbFieldType.OD)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'feePayer')
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'buyerTotal', $pb.PbFieldType.OD)
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sellerNet', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  QuoteFeeResponse._() : super();
  factory QuoteFeeResponse({
    $core.double? amount,
    $core.double? fee,
    $core.String? feePayer,
    $core.double? buyerTotal,
    $core.double? sellerNet,
  }) {
    final _result = create();
    if (amount != null) {
      _result.amount = amount;
    }
    if (fee != null) {
      _result.fee = fee;
    }
    if (feePayer != null) {
      _result.feePayer = feePayer;
    }
    if (buyerTotal != null) {
      _result.buyerTotal = buyerTotal;
    }
    if (sellerNet != null) {
      _result.sellerNet = sellerNet;
    }
    return _result;
  }
  factory QuoteFeeResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory QuoteFeeResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  QuoteFeeResponse clone() => QuoteFeeResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  QuoteFeeResponse copyWith(void Function(QuoteFeeResponse) updates) => super.copyWith((message) => updates(message as QuoteFeeResponse)) as QuoteFeeResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static QuoteFeeResponse create() => QuoteFeeResponse._();
  QuoteFeeResponse createEmptyInstance() => create();
  static $pb.PbList<QuoteFeeResponse> createRepeated() => $pb.PbList<QuoteFeeResponse>();
  @$core.pragma('dart2js:noInline')
  static QuoteFeeResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<QuoteFeeResponse>(create);
  static QuoteFeeResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get amount => $_getN(0);
  @$pb.TagNumber(1)
  set amount($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAmount() => $_has(0);
  @$pb.TagNumber(1)
  void clearAmount() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get fee => $_getN(1);
  @$pb.TagNumber(2)
  set fee($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasFee() => $_has(1);
  @$pb.TagNumber(2)
  void clearFee() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get feePayer => $_getSZ(2);
  @$pb.TagNumber(3)
  set feePayer($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasFeePayer() => $_has(2);
  @$pb.TagNumber(3)
  void clearFeePayer() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get buyerTotal => $_getN(3);
  @$pb.TagNumber(4)
  set buyerTotal($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasBuyerTotal() => $_has(3);
  @$pb.TagNumber(4)
  void clearBuyerTotal() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get sellerNet => $_getN(4);
  @$pb.TagNumber(5)
  set sellerNet($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasSellerNet() => $_has(4);
  @$pb.TagNumber(5)
  void clearSellerNet() => clearField(5);
}

class AddAttachmentRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AddAttachmentRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'escrow'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dealId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'purpose')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'mediaKind')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'url')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'contentType')
    ..aInt64(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sizeBytes')
    ..a<$core.int>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'durationSeconds', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  AddAttachmentRequest._() : super();
  factory AddAttachmentRequest({
    $core.String? dealId,
    $core.String? purpose,
    $core.String? mediaKind,
    $core.String? url,
    $core.String? contentType,
    $fixnum.Int64? sizeBytes,
    $core.int? durationSeconds,
  }) {
    final _result = create();
    if (dealId != null) {
      _result.dealId = dealId;
    }
    if (purpose != null) {
      _result.purpose = purpose;
    }
    if (mediaKind != null) {
      _result.mediaKind = mediaKind;
    }
    if (url != null) {
      _result.url = url;
    }
    if (contentType != null) {
      _result.contentType = contentType;
    }
    if (sizeBytes != null) {
      _result.sizeBytes = sizeBytes;
    }
    if (durationSeconds != null) {
      _result.durationSeconds = durationSeconds;
    }
    return _result;
  }
  factory AddAttachmentRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddAttachmentRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddAttachmentRequest clone() => AddAttachmentRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddAttachmentRequest copyWith(void Function(AddAttachmentRequest) updates) => super.copyWith((message) => updates(message as AddAttachmentRequest)) as AddAttachmentRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AddAttachmentRequest create() => AddAttachmentRequest._();
  AddAttachmentRequest createEmptyInstance() => create();
  static $pb.PbList<AddAttachmentRequest> createRepeated() => $pb.PbList<AddAttachmentRequest>();
  @$core.pragma('dart2js:noInline')
  static AddAttachmentRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddAttachmentRequest>(create);
  static AddAttachmentRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get dealId => $_getSZ(0);
  @$pb.TagNumber(1)
  set dealId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDealId() => $_has(0);
  @$pb.TagNumber(1)
  void clearDealId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get purpose => $_getSZ(1);
  @$pb.TagNumber(2)
  set purpose($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPurpose() => $_has(1);
  @$pb.TagNumber(2)
  void clearPurpose() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get mediaKind => $_getSZ(2);
  @$pb.TagNumber(3)
  set mediaKind($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMediaKind() => $_has(2);
  @$pb.TagNumber(3)
  void clearMediaKind() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get url => $_getSZ(3);
  @$pb.TagNumber(4)
  set url($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasUrl() => $_has(3);
  @$pb.TagNumber(4)
  void clearUrl() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get contentType => $_getSZ(4);
  @$pb.TagNumber(5)
  set contentType($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasContentType() => $_has(4);
  @$pb.TagNumber(5)
  void clearContentType() => clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get sizeBytes => $_getI64(5);
  @$pb.TagNumber(6)
  set sizeBytes($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasSizeBytes() => $_has(5);
  @$pb.TagNumber(6)
  void clearSizeBytes() => clearField(6);

  @$pb.TagNumber(7)
  $core.int get durationSeconds => $_getIZ(6);
  @$pb.TagNumber(7)
  set durationSeconds($core.int v) { $_setSignedInt32(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasDurationSeconds() => $_has(6);
  @$pb.TagNumber(7)
  void clearDurationSeconds() => clearField(7);
}

class AttachmentResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AttachmentResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'escrow'), createEmptyInstance: create)
    ..aOM<Attachment>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'attachment', subBuilder: Attachment.create)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  AttachmentResponse._() : super();
  factory AttachmentResponse({
    Attachment? attachment,
    $core.String? message,
  }) {
    final _result = create();
    if (attachment != null) {
      _result.attachment = attachment;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory AttachmentResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AttachmentResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AttachmentResponse clone() => AttachmentResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AttachmentResponse copyWith(void Function(AttachmentResponse) updates) => super.copyWith((message) => updates(message as AttachmentResponse)) as AttachmentResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AttachmentResponse create() => AttachmentResponse._();
  AttachmentResponse createEmptyInstance() => create();
  static $pb.PbList<AttachmentResponse> createRepeated() => $pb.PbList<AttachmentResponse>();
  @$core.pragma('dart2js:noInline')
  static AttachmentResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AttachmentResponse>(create);
  static AttachmentResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Attachment get attachment => $_getN(0);
  @$pb.TagNumber(1)
  set attachment(Attachment v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasAttachment() => $_has(0);
  @$pb.TagNumber(1)
  void clearAttachment() => clearField(1);
  @$pb.TagNumber(1)
  Attachment ensureAttachment() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

class RequestRefundRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RequestRefundRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'escrow'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dealId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reason')
    ..hasRequiredFields = false
  ;

  RequestRefundRequest._() : super();
  factory RequestRefundRequest({
    $core.String? dealId,
    $core.String? reason,
  }) {
    final _result = create();
    if (dealId != null) {
      _result.dealId = dealId;
    }
    if (reason != null) {
      _result.reason = reason;
    }
    return _result;
  }
  factory RequestRefundRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RequestRefundRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RequestRefundRequest clone() => RequestRefundRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RequestRefundRequest copyWith(void Function(RequestRefundRequest) updates) => super.copyWith((message) => updates(message as RequestRefundRequest)) as RequestRefundRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RequestRefundRequest create() => RequestRefundRequest._();
  RequestRefundRequest createEmptyInstance() => create();
  static $pb.PbList<RequestRefundRequest> createRepeated() => $pb.PbList<RequestRefundRequest>();
  @$core.pragma('dart2js:noInline')
  static RequestRefundRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RequestRefundRequest>(create);
  static RequestRefundRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get dealId => $_getSZ(0);
  @$pb.TagNumber(1)
  set dealId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDealId() => $_has(0);
  @$pb.TagNumber(1)
  void clearDealId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get reason => $_getSZ(1);
  @$pb.TagNumber(2)
  set reason($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasReason() => $_has(1);
  @$pb.TagNumber(2)
  void clearReason() => clearField(2);
}

class RespondRefundRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RespondRefundRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'escrow'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dealId')
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accept')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'note')
    ..hasRequiredFields = false
  ;

  RespondRefundRequest._() : super();
  factory RespondRefundRequest({
    $core.String? dealId,
    $core.bool? accept,
    $core.String? note,
  }) {
    final _result = create();
    if (dealId != null) {
      _result.dealId = dealId;
    }
    if (accept != null) {
      _result.accept = accept;
    }
    if (note != null) {
      _result.note = note;
    }
    return _result;
  }
  factory RespondRefundRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RespondRefundRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RespondRefundRequest clone() => RespondRefundRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RespondRefundRequest copyWith(void Function(RespondRefundRequest) updates) => super.copyWith((message) => updates(message as RespondRefundRequest)) as RespondRefundRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RespondRefundRequest create() => RespondRefundRequest._();
  RespondRefundRequest createEmptyInstance() => create();
  static $pb.PbList<RespondRefundRequest> createRepeated() => $pb.PbList<RespondRefundRequest>();
  @$core.pragma('dart2js:noInline')
  static RespondRefundRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RespondRefundRequest>(create);
  static RespondRefundRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get dealId => $_getSZ(0);
  @$pb.TagNumber(1)
  set dealId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDealId() => $_has(0);
  @$pb.TagNumber(1)
  void clearDealId() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get accept => $_getBF(1);
  @$pb.TagNumber(2)
  set accept($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAccept() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccept() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get note => $_getSZ(2);
  @$pb.TagNumber(3)
  set note($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasNote() => $_has(2);
  @$pb.TagNumber(3)
  void clearNote() => clearField(3);
}

