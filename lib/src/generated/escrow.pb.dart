// This is a generated file - do not edit.
//
// Generated from escrow.proto.

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

/// ===== Core entity =====
class Deal extends $pb.GeneratedMessage {
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
    $core.String? offerId,
    $core.String? offerDirection,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (reference != null) result.reference = reference;
    if (buyerUserId != null) result.buyerUserId = buyerUserId;
    if (buyerAccountId != null) result.buyerAccountId = buyerAccountId;
    if (buyerName != null) result.buyerName = buyerName;
    if (sellerUserId != null) result.sellerUserId = sellerUserId;
    if (sellerAccountId != null) result.sellerAccountId = sellerAccountId;
    if (sellerName != null) result.sellerName = sellerName;
    if (title != null) result.title = title;
    if (description != null) result.description = description;
    if (currency != null) result.currency = currency;
    if (amount != null) result.amount = amount;
    if (fee != null) result.fee = fee;
    if (feePayer != null) result.feePayer = feePayer;
    if (buyerTotal != null) result.buyerTotal = buyerTotal;
    if (sellerNet != null) result.sellerNet = sellerNet;
    if (status != null) result.status = status;
    if (fraudScore != null) result.fraudScore = fraudScore;
    if (fraudFlags != null) result.fraudFlags.addAll(fraudFlags);
    if (requiresAdminReview != null)
      result.requiresAdminReview = requiresAdminReview;
    if (deliveryNote != null) result.deliveryNote = deliveryNote;
    if (deadlineAt != null) result.deadlineAt = deadlineAt;
    if (fundedAt != null) result.fundedAt = fundedAt;
    if (deliveredAt != null) result.deliveredAt = deliveredAt;
    if (releasedAt != null) result.releasedAt = releasedAt;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    if (events != null) result.events.addAll(events);
    if (buyerItemImageUrl != null) result.buyerItemImageUrl = buyerItemImageUrl;
    if (sellerProofImageUrl != null)
      result.sellerProofImageUrl = sellerProofImageUrl;
    if (attachments != null) result.attachments.addAll(attachments);
    if (refundRequest != null) result.refundRequest = refundRequest;
    if (offerId != null) result.offerId = offerId;
    if (offerDirection != null) result.offerDirection = offerDirection;
    return result;
  }

  Deal._();

  factory Deal.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Deal.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Deal',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'escrow'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'reference')
    ..aOS(3, _omitFieldNames ? '' : 'buyerUserId')
    ..aOS(4, _omitFieldNames ? '' : 'buyerAccountId')
    ..aOS(5, _omitFieldNames ? '' : 'buyerName')
    ..aOS(6, _omitFieldNames ? '' : 'sellerUserId')
    ..aOS(7, _omitFieldNames ? '' : 'sellerAccountId')
    ..aOS(8, _omitFieldNames ? '' : 'sellerName')
    ..aOS(9, _omitFieldNames ? '' : 'title')
    ..aOS(10, _omitFieldNames ? '' : 'description')
    ..aOS(11, _omitFieldNames ? '' : 'currency')
    ..a<$core.double>(12, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..a<$core.double>(13, _omitFieldNames ? '' : 'fee', $pb.PbFieldType.OD)
    ..aOS(14, _omitFieldNames ? '' : 'feePayer')
    ..a<$core.double>(
        15, _omitFieldNames ? '' : 'buyerTotal', $pb.PbFieldType.OD)
    ..a<$core.double>(
        16, _omitFieldNames ? '' : 'sellerNet', $pb.PbFieldType.OD)
    ..aOS(17, _omitFieldNames ? '' : 'status')
    ..a<$core.int>(18, _omitFieldNames ? '' : 'fraudScore', $pb.PbFieldType.O3)
    ..pPS(19, _omitFieldNames ? '' : 'fraudFlags')
    ..aOB(20, _omitFieldNames ? '' : 'requiresAdminReview')
    ..aOS(21, _omitFieldNames ? '' : 'deliveryNote')
    ..aOM<$1.Timestamp>(22, _omitFieldNames ? '' : 'deadlineAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(23, _omitFieldNames ? '' : 'fundedAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(24, _omitFieldNames ? '' : 'deliveredAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(25, _omitFieldNames ? '' : 'releasedAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(26, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(27, _omitFieldNames ? '' : 'updatedAt',
        subBuilder: $1.Timestamp.create)
    ..pc<DealEvent>(28, _omitFieldNames ? '' : 'events', $pb.PbFieldType.PM,
        subBuilder: DealEvent.create)
    ..aOS(29, _omitFieldNames ? '' : 'buyerItemImageUrl')
    ..aOS(30, _omitFieldNames ? '' : 'sellerProofImageUrl')
    ..pc<Attachment>(
        31, _omitFieldNames ? '' : 'attachments', $pb.PbFieldType.PM,
        subBuilder: Attachment.create)
    ..aOM<RefundRequest>(32, _omitFieldNames ? '' : 'refundRequest',
        subBuilder: RefundRequest.create)
    ..aOS(33, _omitFieldNames ? '' : 'offerId')
    ..aOS(34, _omitFieldNames ? '' : 'offerDirection')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Deal clone() => Deal()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Deal copyWith(void Function(Deal) updates) =>
      super.copyWith((message) => updates(message as Deal)) as Deal;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Deal create() => Deal._();
  @$core.override
  Deal createEmptyInstance() => create();
  static $pb.PbList<Deal> createRepeated() => $pb.PbList<Deal>();
  @$core.pragma('dart2js:noInline')
  static Deal getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Deal>(create);
  static Deal? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get reference => $_getSZ(1);
  @$pb.TagNumber(2)
  set reference($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasReference() => $_has(1);
  @$pb.TagNumber(2)
  void clearReference() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get buyerUserId => $_getSZ(2);
  @$pb.TagNumber(3)
  set buyerUserId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasBuyerUserId() => $_has(2);
  @$pb.TagNumber(3)
  void clearBuyerUserId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get buyerAccountId => $_getSZ(3);
  @$pb.TagNumber(4)
  set buyerAccountId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasBuyerAccountId() => $_has(3);
  @$pb.TagNumber(4)
  void clearBuyerAccountId() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get buyerName => $_getSZ(4);
  @$pb.TagNumber(5)
  set buyerName($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasBuyerName() => $_has(4);
  @$pb.TagNumber(5)
  void clearBuyerName() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get sellerUserId => $_getSZ(5);
  @$pb.TagNumber(6)
  set sellerUserId($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasSellerUserId() => $_has(5);
  @$pb.TagNumber(6)
  void clearSellerUserId() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get sellerAccountId => $_getSZ(6);
  @$pb.TagNumber(7)
  set sellerAccountId($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasSellerAccountId() => $_has(6);
  @$pb.TagNumber(7)
  void clearSellerAccountId() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get sellerName => $_getSZ(7);
  @$pb.TagNumber(8)
  set sellerName($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasSellerName() => $_has(7);
  @$pb.TagNumber(8)
  void clearSellerName() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get title => $_getSZ(8);
  @$pb.TagNumber(9)
  set title($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasTitle() => $_has(8);
  @$pb.TagNumber(9)
  void clearTitle() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get description => $_getSZ(9);
  @$pb.TagNumber(10)
  set description($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasDescription() => $_has(9);
  @$pb.TagNumber(10)
  void clearDescription() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get currency => $_getSZ(10);
  @$pb.TagNumber(11)
  set currency($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasCurrency() => $_has(10);
  @$pb.TagNumber(11)
  void clearCurrency() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.double get amount => $_getN(11);
  @$pb.TagNumber(12)
  set amount($core.double value) => $_setDouble(11, value);
  @$pb.TagNumber(12)
  $core.bool hasAmount() => $_has(11);
  @$pb.TagNumber(12)
  void clearAmount() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.double get fee => $_getN(12);
  @$pb.TagNumber(13)
  set fee($core.double value) => $_setDouble(12, value);
  @$pb.TagNumber(13)
  $core.bool hasFee() => $_has(12);
  @$pb.TagNumber(13)
  void clearFee() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.String get feePayer => $_getSZ(13);
  @$pb.TagNumber(14)
  set feePayer($core.String value) => $_setString(13, value);
  @$pb.TagNumber(14)
  $core.bool hasFeePayer() => $_has(13);
  @$pb.TagNumber(14)
  void clearFeePayer() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.double get buyerTotal => $_getN(14);
  @$pb.TagNumber(15)
  set buyerTotal($core.double value) => $_setDouble(14, value);
  @$pb.TagNumber(15)
  $core.bool hasBuyerTotal() => $_has(14);
  @$pb.TagNumber(15)
  void clearBuyerTotal() => $_clearField(15);

  @$pb.TagNumber(16)
  $core.double get sellerNet => $_getN(15);
  @$pb.TagNumber(16)
  set sellerNet($core.double value) => $_setDouble(15, value);
  @$pb.TagNumber(16)
  $core.bool hasSellerNet() => $_has(15);
  @$pb.TagNumber(16)
  void clearSellerNet() => $_clearField(16);

  @$pb.TagNumber(17)
  $core.String get status => $_getSZ(16);
  @$pb.TagNumber(17)
  set status($core.String value) => $_setString(16, value);
  @$pb.TagNumber(17)
  $core.bool hasStatus() => $_has(16);
  @$pb.TagNumber(17)
  void clearStatus() => $_clearField(17);

  @$pb.TagNumber(18)
  $core.int get fraudScore => $_getIZ(17);
  @$pb.TagNumber(18)
  set fraudScore($core.int value) => $_setSignedInt32(17, value);
  @$pb.TagNumber(18)
  $core.bool hasFraudScore() => $_has(17);
  @$pb.TagNumber(18)
  void clearFraudScore() => $_clearField(18);

  @$pb.TagNumber(19)
  $pb.PbList<$core.String> get fraudFlags => $_getList(18);

  @$pb.TagNumber(20)
  $core.bool get requiresAdminReview => $_getBF(19);
  @$pb.TagNumber(20)
  set requiresAdminReview($core.bool value) => $_setBool(19, value);
  @$pb.TagNumber(20)
  $core.bool hasRequiresAdminReview() => $_has(19);
  @$pb.TagNumber(20)
  void clearRequiresAdminReview() => $_clearField(20);

  @$pb.TagNumber(21)
  $core.String get deliveryNote => $_getSZ(20);
  @$pb.TagNumber(21)
  set deliveryNote($core.String value) => $_setString(20, value);
  @$pb.TagNumber(21)
  $core.bool hasDeliveryNote() => $_has(20);
  @$pb.TagNumber(21)
  void clearDeliveryNote() => $_clearField(21);

  @$pb.TagNumber(22)
  $1.Timestamp get deadlineAt => $_getN(21);
  @$pb.TagNumber(22)
  set deadlineAt($1.Timestamp value) => $_setField(22, value);
  @$pb.TagNumber(22)
  $core.bool hasDeadlineAt() => $_has(21);
  @$pb.TagNumber(22)
  void clearDeadlineAt() => $_clearField(22);
  @$pb.TagNumber(22)
  $1.Timestamp ensureDeadlineAt() => $_ensure(21);

  @$pb.TagNumber(23)
  $1.Timestamp get fundedAt => $_getN(22);
  @$pb.TagNumber(23)
  set fundedAt($1.Timestamp value) => $_setField(23, value);
  @$pb.TagNumber(23)
  $core.bool hasFundedAt() => $_has(22);
  @$pb.TagNumber(23)
  void clearFundedAt() => $_clearField(23);
  @$pb.TagNumber(23)
  $1.Timestamp ensureFundedAt() => $_ensure(22);

  @$pb.TagNumber(24)
  $1.Timestamp get deliveredAt => $_getN(23);
  @$pb.TagNumber(24)
  set deliveredAt($1.Timestamp value) => $_setField(24, value);
  @$pb.TagNumber(24)
  $core.bool hasDeliveredAt() => $_has(23);
  @$pb.TagNumber(24)
  void clearDeliveredAt() => $_clearField(24);
  @$pb.TagNumber(24)
  $1.Timestamp ensureDeliveredAt() => $_ensure(23);

  @$pb.TagNumber(25)
  $1.Timestamp get releasedAt => $_getN(24);
  @$pb.TagNumber(25)
  set releasedAt($1.Timestamp value) => $_setField(25, value);
  @$pb.TagNumber(25)
  $core.bool hasReleasedAt() => $_has(24);
  @$pb.TagNumber(25)
  void clearReleasedAt() => $_clearField(25);
  @$pb.TagNumber(25)
  $1.Timestamp ensureReleasedAt() => $_ensure(24);

  @$pb.TagNumber(26)
  $1.Timestamp get createdAt => $_getN(25);
  @$pb.TagNumber(26)
  set createdAt($1.Timestamp value) => $_setField(26, value);
  @$pb.TagNumber(26)
  $core.bool hasCreatedAt() => $_has(25);
  @$pb.TagNumber(26)
  void clearCreatedAt() => $_clearField(26);
  @$pb.TagNumber(26)
  $1.Timestamp ensureCreatedAt() => $_ensure(25);

  @$pb.TagNumber(27)
  $1.Timestamp get updatedAt => $_getN(26);
  @$pb.TagNumber(27)
  set updatedAt($1.Timestamp value) => $_setField(27, value);
  @$pb.TagNumber(27)
  $core.bool hasUpdatedAt() => $_has(26);
  @$pb.TagNumber(27)
  void clearUpdatedAt() => $_clearField(27);
  @$pb.TagNumber(27)
  $1.Timestamp ensureUpdatedAt() => $_ensure(26);

  @$pb.TagNumber(28)
  $pb.PbList<DealEvent> get events => $_getList(27);

  /// Image the BUYER uploaded of the product/service they want (storage-service
  /// public URL). Shown on the deal detail + admin so both parties + admin see
  /// exactly what the deal is for.
  @$pb.TagNumber(29)
  $core.String get buyerItemImageUrl => $_getSZ(28);
  @$pb.TagNumber(29)
  set buyerItemImageUrl($core.String value) => $_setString(28, value);
  @$pb.TagNumber(29)
  $core.bool hasBuyerItemImageUrl() => $_has(28);
  @$pb.TagNumber(29)
  void clearBuyerItemImageUrl() => $_clearField(29);

  /// Image the SELLER uploaded as proof of what was sold/delivered (storage
  /// public URL), attached when they mark the deal delivered.
  @$pb.TagNumber(30)
  $core.String get sellerProofImageUrl => $_getSZ(29);
  @$pb.TagNumber(30)
  set sellerProofImageUrl($core.String value) => $_setString(29, value);
  @$pb.TagNumber(30)
  $core.bool hasSellerProofImageUrl() => $_has(29);
  @$pb.TagNumber(30)
  void clearSellerProofImageUrl() => $_clearField(30);

  /// Full evidence gallery: every image/video attached to the deal across all
  /// purposes (deal item, delivery proof, dispute/refund evidence). Populated on
  /// GetDeal. The two scalar *_image_url fields above stay as the primary thumbnails.
  @$pb.TagNumber(31)
  $pb.PbList<Attachment> get attachments => $_getList(30);

  /// Open refund request, if the deal is in REFUND_REQUESTED (populated on GetDeal).
  @$pb.TagNumber(32)
  RefundRequest get refundRequest => $_getN(31);
  @$pb.TagNumber(32)
  set refundRequest(RefundRequest value) => $_setField(32, value);
  @$pb.TagNumber(32)
  $core.bool hasRefundRequest() => $_has(31);
  @$pb.TagNumber(32)
  void clearRefundRequest() => $_clearField(32);
  @$pb.TagNumber(32)
  RefundRequest ensureRefundRequest() => $_ensure(31);

  /// Offer this deal was funded from (two-sided offers flow); empty for legacy
  /// one-shot CreateDeal deals.
  @$pb.TagNumber(33)
  $core.String get offerId => $_getSZ(32);
  @$pb.TagNumber(33)
  set offerId($core.String value) => $_setString(32, value);
  @$pb.TagNumber(33)
  $core.bool hasOfferId() => $_has(32);
  @$pb.TagNumber(33)
  void clearOfferId() => $_clearField(33);

  @$pb.TagNumber(34)
  $core.String get offerDirection => $_getSZ(33);
  @$pb.TagNumber(34)
  set offerDirection($core.String value) => $_setString(33, value);
  @$pb.TagNumber(34)
  $core.bool hasOfferDirection() => $_has(33);
  @$pb.TagNumber(34)
  void clearOfferDirection() => $_clearField(34);
}

/// A single piece of media (image or video) attached to a deal.
class Attachment extends $pb.GeneratedMessage {
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
    final result = create();
    if (id != null) result.id = id;
    if (purpose != null) result.purpose = purpose;
    if (mediaKind != null) result.mediaKind = mediaKind;
    if (url != null) result.url = url;
    if (contentType != null) result.contentType = contentType;
    if (sizeBytes != null) result.sizeBytes = sizeBytes;
    if (durationSeconds != null) result.durationSeconds = durationSeconds;
    if (uploadedBy != null) result.uploadedBy = uploadedBy;
    if (actorRole != null) result.actorRole = actorRole;
    if (createdAt != null) result.createdAt = createdAt;
    return result;
  }

  Attachment._();

  factory Attachment.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Attachment.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Attachment',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'escrow'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'purpose')
    ..aOS(3, _omitFieldNames ? '' : 'mediaKind')
    ..aOS(4, _omitFieldNames ? '' : 'url')
    ..aOS(5, _omitFieldNames ? '' : 'contentType')
    ..aInt64(6, _omitFieldNames ? '' : 'sizeBytes')
    ..a<$core.int>(
        7, _omitFieldNames ? '' : 'durationSeconds', $pb.PbFieldType.O3)
    ..aOS(8, _omitFieldNames ? '' : 'uploadedBy')
    ..aOS(9, _omitFieldNames ? '' : 'actorRole')
    ..aOM<$1.Timestamp>(10, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Attachment clone() => Attachment()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Attachment copyWith(void Function(Attachment) updates) =>
      super.copyWith((message) => updates(message as Attachment)) as Attachment;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Attachment create() => Attachment._();
  @$core.override
  Attachment createEmptyInstance() => create();
  static $pb.PbList<Attachment> createRepeated() => $pb.PbList<Attachment>();
  @$core.pragma('dart2js:noInline')
  static Attachment getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Attachment>(create);
  static Attachment? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get purpose => $_getSZ(1);
  @$pb.TagNumber(2)
  set purpose($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPurpose() => $_has(1);
  @$pb.TagNumber(2)
  void clearPurpose() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get mediaKind => $_getSZ(2);
  @$pb.TagNumber(3)
  set mediaKind($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMediaKind() => $_has(2);
  @$pb.TagNumber(3)
  void clearMediaKind() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get url => $_getSZ(3);
  @$pb.TagNumber(4)
  set url($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasUrl() => $_has(3);
  @$pb.TagNumber(4)
  void clearUrl() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get contentType => $_getSZ(4);
  @$pb.TagNumber(5)
  set contentType($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasContentType() => $_has(4);
  @$pb.TagNumber(5)
  void clearContentType() => $_clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get sizeBytes => $_getI64(5);
  @$pb.TagNumber(6)
  set sizeBytes($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasSizeBytes() => $_has(5);
  @$pb.TagNumber(6)
  void clearSizeBytes() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.int get durationSeconds => $_getIZ(6);
  @$pb.TagNumber(7)
  set durationSeconds($core.int value) => $_setSignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasDurationSeconds() => $_has(6);
  @$pb.TagNumber(7)
  void clearDurationSeconds() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get uploadedBy => $_getSZ(7);
  @$pb.TagNumber(8)
  set uploadedBy($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasUploadedBy() => $_has(7);
  @$pb.TagNumber(8)
  void clearUploadedBy() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get actorRole => $_getSZ(8);
  @$pb.TagNumber(9)
  set actorRole($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasActorRole() => $_has(8);
  @$pb.TagNumber(9)
  void clearActorRole() => $_clearField(9);

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
}

/// A buyer's post-delivery refund request and its lifecycle.
class RefundRequest extends $pb.GeneratedMessage {
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
    final result = create();
    if (id != null) result.id = id;
    if (dealId != null) result.dealId = dealId;
    if (requestedBy != null) result.requestedBy = requestedBy;
    if (reason != null) result.reason = reason;
    if (status != null) result.status = status;
    if (responseDeadlineAt != null)
      result.responseDeadlineAt = responseDeadlineAt;
    if (respondedBy != null) result.respondedBy = respondedBy;
    if (responseNote != null) result.responseNote = responseNote;
    if (respondedAt != null) result.respondedAt = respondedAt;
    if (createdAt != null) result.createdAt = createdAt;
    if (attachments != null) result.attachments.addAll(attachments);
    return result;
  }

  RefundRequest._();

  factory RefundRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RefundRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RefundRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'escrow'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'dealId')
    ..aOS(3, _omitFieldNames ? '' : 'requestedBy')
    ..aOS(4, _omitFieldNames ? '' : 'reason')
    ..aOS(5, _omitFieldNames ? '' : 'status')
    ..aOM<$1.Timestamp>(6, _omitFieldNames ? '' : 'responseDeadlineAt',
        subBuilder: $1.Timestamp.create)
    ..aOS(7, _omitFieldNames ? '' : 'respondedBy')
    ..aOS(8, _omitFieldNames ? '' : 'responseNote')
    ..aOM<$1.Timestamp>(9, _omitFieldNames ? '' : 'respondedAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(10, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $1.Timestamp.create)
    ..pc<Attachment>(
        11, _omitFieldNames ? '' : 'attachments', $pb.PbFieldType.PM,
        subBuilder: Attachment.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RefundRequest clone() => RefundRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RefundRequest copyWith(void Function(RefundRequest) updates) =>
      super.copyWith((message) => updates(message as RefundRequest))
          as RefundRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RefundRequest create() => RefundRequest._();
  @$core.override
  RefundRequest createEmptyInstance() => create();
  static $pb.PbList<RefundRequest> createRepeated() =>
      $pb.PbList<RefundRequest>();
  @$core.pragma('dart2js:noInline')
  static RefundRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RefundRequest>(create);
  static RefundRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get dealId => $_getSZ(1);
  @$pb.TagNumber(2)
  set dealId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDealId() => $_has(1);
  @$pb.TagNumber(2)
  void clearDealId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get requestedBy => $_getSZ(2);
  @$pb.TagNumber(3)
  set requestedBy($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasRequestedBy() => $_has(2);
  @$pb.TagNumber(3)
  void clearRequestedBy() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get reason => $_getSZ(3);
  @$pb.TagNumber(4)
  set reason($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasReason() => $_has(3);
  @$pb.TagNumber(4)
  void clearReason() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get status => $_getSZ(4);
  @$pb.TagNumber(5)
  set status($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasStatus() => $_has(4);
  @$pb.TagNumber(5)
  void clearStatus() => $_clearField(5);

  @$pb.TagNumber(6)
  $1.Timestamp get responseDeadlineAt => $_getN(5);
  @$pb.TagNumber(6)
  set responseDeadlineAt($1.Timestamp value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasResponseDeadlineAt() => $_has(5);
  @$pb.TagNumber(6)
  void clearResponseDeadlineAt() => $_clearField(6);
  @$pb.TagNumber(6)
  $1.Timestamp ensureResponseDeadlineAt() => $_ensure(5);

  @$pb.TagNumber(7)
  $core.String get respondedBy => $_getSZ(6);
  @$pb.TagNumber(7)
  set respondedBy($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasRespondedBy() => $_has(6);
  @$pb.TagNumber(7)
  void clearRespondedBy() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get responseNote => $_getSZ(7);
  @$pb.TagNumber(8)
  set responseNote($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasResponseNote() => $_has(7);
  @$pb.TagNumber(8)
  void clearResponseNote() => $_clearField(8);

  @$pb.TagNumber(9)
  $1.Timestamp get respondedAt => $_getN(8);
  @$pb.TagNumber(9)
  set respondedAt($1.Timestamp value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasRespondedAt() => $_has(8);
  @$pb.TagNumber(9)
  void clearRespondedAt() => $_clearField(9);
  @$pb.TagNumber(9)
  $1.Timestamp ensureRespondedAt() => $_ensure(8);

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
  $pb.PbList<Attachment> get attachments => $_getList(10);
}

class DealEvent extends $pb.GeneratedMessage {
  factory DealEvent({
    $core.String? id,
    $core.String? dealId,
    $core.String? eventType,
    $core.String? actor,
    $core.String? detail,
    $1.Timestamp? createdAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (dealId != null) result.dealId = dealId;
    if (eventType != null) result.eventType = eventType;
    if (actor != null) result.actor = actor;
    if (detail != null) result.detail = detail;
    if (createdAt != null) result.createdAt = createdAt;
    return result;
  }

  DealEvent._();

  factory DealEvent.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DealEvent.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DealEvent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'escrow'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'dealId')
    ..aOS(3, _omitFieldNames ? '' : 'eventType')
    ..aOS(4, _omitFieldNames ? '' : 'actor')
    ..aOS(5, _omitFieldNames ? '' : 'detail')
    ..aOM<$1.Timestamp>(6, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DealEvent clone() => DealEvent()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DealEvent copyWith(void Function(DealEvent) updates) =>
      super.copyWith((message) => updates(message as DealEvent)) as DealEvent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DealEvent create() => DealEvent._();
  @$core.override
  DealEvent createEmptyInstance() => create();
  static $pb.PbList<DealEvent> createRepeated() => $pb.PbList<DealEvent>();
  @$core.pragma('dart2js:noInline')
  static DealEvent getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DealEvent>(create);
  static DealEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get dealId => $_getSZ(1);
  @$pb.TagNumber(2)
  set dealId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDealId() => $_has(1);
  @$pb.TagNumber(2)
  void clearDealId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get eventType => $_getSZ(2);
  @$pb.TagNumber(3)
  set eventType($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasEventType() => $_has(2);
  @$pb.TagNumber(3)
  void clearEventType() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get actor => $_getSZ(3);
  @$pb.TagNumber(4)
  set actor($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasActor() => $_has(3);
  @$pb.TagNumber(4)
  void clearActor() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get detail => $_getSZ(4);
  @$pb.TagNumber(5)
  set detail($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasDetail() => $_has(4);
  @$pb.TagNumber(5)
  void clearDetail() => $_clearField(5);

  @$pb.TagNumber(6)
  $1.Timestamp get createdAt => $_getN(5);
  @$pb.TagNumber(6)
  set createdAt($1.Timestamp value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasCreatedAt() => $_has(5);
  @$pb.TagNumber(6)
  void clearCreatedAt() => $_clearField(6);
  @$pb.TagNumber(6)
  $1.Timestamp ensureCreatedAt() => $_ensure(5);
}

/// ===== Requests / responses =====
class CreateDealRequest extends $pb.GeneratedMessage {
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
    final result = create();
    if (buyerAccountId != null) result.buyerAccountId = buyerAccountId;
    if (sellerQuery != null) result.sellerQuery = sellerQuery;
    if (title != null) result.title = title;
    if (description != null) result.description = description;
    if (amount != null) result.amount = amount;
    if (deadlineDays != null) result.deadlineDays = deadlineDays;
    if (transactionId != null) result.transactionId = transactionId;
    if (verificationToken != null) result.verificationToken = verificationToken;
    if (idempotencyKey != null) result.idempotencyKey = idempotencyKey;
    if (buyerItemImageUrl != null) result.buyerItemImageUrl = buyerItemImageUrl;
    return result;
  }

  CreateDealRequest._();

  factory CreateDealRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateDealRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateDealRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'escrow'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'buyerAccountId')
    ..aOS(2, _omitFieldNames ? '' : 'sellerQuery')
    ..aOS(3, _omitFieldNames ? '' : 'title')
    ..aOS(4, _omitFieldNames ? '' : 'description')
    ..a<$core.double>(5, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..a<$core.int>(6, _omitFieldNames ? '' : 'deadlineDays', $pb.PbFieldType.O3)
    ..aOS(7, _omitFieldNames ? '' : 'transactionId')
    ..aOS(8, _omitFieldNames ? '' : 'verificationToken')
    ..aOS(9, _omitFieldNames ? '' : 'idempotencyKey')
    ..aOS(10, _omitFieldNames ? '' : 'buyerItemImageUrl')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateDealRequest clone() => CreateDealRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateDealRequest copyWith(void Function(CreateDealRequest) updates) =>
      super.copyWith((message) => updates(message as CreateDealRequest))
          as CreateDealRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateDealRequest create() => CreateDealRequest._();
  @$core.override
  CreateDealRequest createEmptyInstance() => create();
  static $pb.PbList<CreateDealRequest> createRepeated() =>
      $pb.PbList<CreateDealRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateDealRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateDealRequest>(create);
  static CreateDealRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get buyerAccountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set buyerAccountId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasBuyerAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearBuyerAccountId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get sellerQuery => $_getSZ(1);
  @$pb.TagNumber(2)
  set sellerQuery($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSellerQuery() => $_has(1);
  @$pb.TagNumber(2)
  void clearSellerQuery() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get title => $_getSZ(2);
  @$pb.TagNumber(3)
  set title($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTitle() => $_has(2);
  @$pb.TagNumber(3)
  void clearTitle() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get description => $_getSZ(3);
  @$pb.TagNumber(4)
  set description($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDescription() => $_has(3);
  @$pb.TagNumber(4)
  void clearDescription() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get amount => $_getN(4);
  @$pb.TagNumber(5)
  set amount($core.double value) => $_setDouble(4, value);
  @$pb.TagNumber(5)
  $core.bool hasAmount() => $_has(4);
  @$pb.TagNumber(5)
  void clearAmount() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.int get deadlineDays => $_getIZ(5);
  @$pb.TagNumber(6)
  set deadlineDays($core.int value) => $_setSignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasDeadlineDays() => $_has(5);
  @$pb.TagNumber(6)
  void clearDeadlineDays() => $_clearField(6);

  /// PIN verification (single-use token from TransactionPinService), like tag-pay.
  @$pb.TagNumber(7)
  $core.String get transactionId => $_getSZ(6);
  @$pb.TagNumber(7)
  set transactionId($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasTransactionId() => $_has(6);
  @$pb.TagNumber(7)
  void clearTransactionId() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get verificationToken => $_getSZ(7);
  @$pb.TagNumber(8)
  set verificationToken($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasVerificationToken() => $_has(7);
  @$pb.TagNumber(8)
  void clearVerificationToken() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get idempotencyKey => $_getSZ(8);
  @$pb.TagNumber(9)
  set idempotencyKey($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasIdempotencyKey() => $_has(8);
  @$pb.TagNumber(9)
  void clearIdempotencyKey() => $_clearField(9);

  /// Buyer's uploaded image of the product/service (storage public URL). Optional.
  @$pb.TagNumber(10)
  $core.String get buyerItemImageUrl => $_getSZ(9);
  @$pb.TagNumber(10)
  set buyerItemImageUrl($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasBuyerItemImageUrl() => $_has(9);
  @$pb.TagNumber(10)
  void clearBuyerItemImageUrl() => $_clearField(10);
}

class ListMyDealsRequest extends $pb.GeneratedMessage {
  factory ListMyDealsRequest({
    $core.String? role,
    $core.String? status,
    $core.int? page,
    $core.int? limit,
  }) {
    final result = create();
    if (role != null) result.role = role;
    if (status != null) result.status = status;
    if (page != null) result.page = page;
    if (limit != null) result.limit = limit;
    return result;
  }

  ListMyDealsRequest._();

  factory ListMyDealsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListMyDealsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListMyDealsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'escrow'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'role')
    ..aOS(2, _omitFieldNames ? '' : 'status')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListMyDealsRequest clone() => ListMyDealsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListMyDealsRequest copyWith(void Function(ListMyDealsRequest) updates) =>
      super.copyWith((message) => updates(message as ListMyDealsRequest))
          as ListMyDealsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListMyDealsRequest create() => ListMyDealsRequest._();
  @$core.override
  ListMyDealsRequest createEmptyInstance() => create();
  static $pb.PbList<ListMyDealsRequest> createRepeated() =>
      $pb.PbList<ListMyDealsRequest>();
  @$core.pragma('dart2js:noInline')
  static ListMyDealsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListMyDealsRequest>(create);
  static ListMyDealsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get role => $_getSZ(0);
  @$pb.TagNumber(1)
  set role($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRole() => $_has(0);
  @$pb.TagNumber(1)
  void clearRole() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get status => $_getSZ(1);
  @$pb.TagNumber(2)
  set status($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get page => $_getIZ(2);
  @$pb.TagNumber(3)
  set page($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPage() => $_has(2);
  @$pb.TagNumber(3)
  void clearPage() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get limit => $_getIZ(3);
  @$pb.TagNumber(4)
  set limit($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasLimit() => $_has(3);
  @$pb.TagNumber(4)
  void clearLimit() => $_clearField(4);
}

class ListDealsResponse extends $pb.GeneratedMessage {
  factory ListDealsResponse({
    $core.Iterable<Deal>? deals,
    $core.int? total,
  }) {
    final result = create();
    if (deals != null) result.deals.addAll(deals);
    if (total != null) result.total = total;
    return result;
  }

  ListDealsResponse._();

  factory ListDealsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListDealsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListDealsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'escrow'),
      createEmptyInstance: create)
    ..pc<Deal>(1, _omitFieldNames ? '' : 'deals', $pb.PbFieldType.PM,
        subBuilder: Deal.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListDealsResponse clone() => ListDealsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListDealsResponse copyWith(void Function(ListDealsResponse) updates) =>
      super.copyWith((message) => updates(message as ListDealsResponse))
          as ListDealsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListDealsResponse create() => ListDealsResponse._();
  @$core.override
  ListDealsResponse createEmptyInstance() => create();
  static $pb.PbList<ListDealsResponse> createRepeated() =>
      $pb.PbList<ListDealsResponse>();
  @$core.pragma('dart2js:noInline')
  static ListDealsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListDealsResponse>(create);
  static ListDealsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Deal> get deals => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);
}

class GetDealRequest extends $pb.GeneratedMessage {
  factory GetDealRequest({
    $core.String? dealId,
  }) {
    final result = create();
    if (dealId != null) result.dealId = dealId;
    return result;
  }

  GetDealRequest._();

  factory GetDealRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetDealRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetDealRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'escrow'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'dealId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetDealRequest clone() => GetDealRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetDealRequest copyWith(void Function(GetDealRequest) updates) =>
      super.copyWith((message) => updates(message as GetDealRequest))
          as GetDealRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetDealRequest create() => GetDealRequest._();
  @$core.override
  GetDealRequest createEmptyInstance() => create();
  static $pb.PbList<GetDealRequest> createRepeated() =>
      $pb.PbList<GetDealRequest>();
  @$core.pragma('dart2js:noInline')
  static GetDealRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetDealRequest>(create);
  static GetDealRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get dealId => $_getSZ(0);
  @$pb.TagNumber(1)
  set dealId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDealId() => $_has(0);
  @$pb.TagNumber(1)
  void clearDealId() => $_clearField(1);
}

class DealResponse extends $pb.GeneratedMessage {
  factory DealResponse({
    Deal? deal,
    $core.String? message,
  }) {
    final result = create();
    if (deal != null) result.deal = deal;
    if (message != null) result.message = message;
    return result;
  }

  DealResponse._();

  factory DealResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DealResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DealResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'escrow'),
      createEmptyInstance: create)
    ..aOM<Deal>(1, _omitFieldNames ? '' : 'deal', subBuilder: Deal.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DealResponse clone() => DealResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DealResponse copyWith(void Function(DealResponse) updates) =>
      super.copyWith((message) => updates(message as DealResponse))
          as DealResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DealResponse create() => DealResponse._();
  @$core.override
  DealResponse createEmptyInstance() => create();
  static $pb.PbList<DealResponse> createRepeated() =>
      $pb.PbList<DealResponse>();
  @$core.pragma('dart2js:noInline')
  static DealResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DealResponse>(create);
  static DealResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Deal get deal => $_getN(0);
  @$pb.TagNumber(1)
  set deal(Deal value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasDeal() => $_has(0);
  @$pb.TagNumber(1)
  void clearDeal() => $_clearField(1);
  @$pb.TagNumber(1)
  Deal ensureDeal() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);
}

class MarkDeliveredRequest extends $pb.GeneratedMessage {
  factory MarkDeliveredRequest({
    $core.String? dealId,
    $core.String? deliveryNote,
    $core.String? sellerProofImageUrl,
  }) {
    final result = create();
    if (dealId != null) result.dealId = dealId;
    if (deliveryNote != null) result.deliveryNote = deliveryNote;
    if (sellerProofImageUrl != null)
      result.sellerProofImageUrl = sellerProofImageUrl;
    return result;
  }

  MarkDeliveredRequest._();

  factory MarkDeliveredRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MarkDeliveredRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MarkDeliveredRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'escrow'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'dealId')
    ..aOS(2, _omitFieldNames ? '' : 'deliveryNote')
    ..aOS(3, _omitFieldNames ? '' : 'sellerProofImageUrl')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MarkDeliveredRequest clone() =>
      MarkDeliveredRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MarkDeliveredRequest copyWith(void Function(MarkDeliveredRequest) updates) =>
      super.copyWith((message) => updates(message as MarkDeliveredRequest))
          as MarkDeliveredRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MarkDeliveredRequest create() => MarkDeliveredRequest._();
  @$core.override
  MarkDeliveredRequest createEmptyInstance() => create();
  static $pb.PbList<MarkDeliveredRequest> createRepeated() =>
      $pb.PbList<MarkDeliveredRequest>();
  @$core.pragma('dart2js:noInline')
  static MarkDeliveredRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MarkDeliveredRequest>(create);
  static MarkDeliveredRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get dealId => $_getSZ(0);
  @$pb.TagNumber(1)
  set dealId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDealId() => $_has(0);
  @$pb.TagNumber(1)
  void clearDealId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get deliveryNote => $_getSZ(1);
  @$pb.TagNumber(2)
  set deliveryNote($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDeliveryNote() => $_has(1);
  @$pb.TagNumber(2)
  void clearDeliveryNote() => $_clearField(2);

  /// Seller's uploaded proof-of-delivery image (storage public URL). Optional.
  /// Kept for the primary thumbnail; extra images/video go via AddAttachment.
  @$pb.TagNumber(3)
  $core.String get sellerProofImageUrl => $_getSZ(2);
  @$pb.TagNumber(3)
  set sellerProofImageUrl($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSellerProofImageUrl() => $_has(2);
  @$pb.TagNumber(3)
  void clearSellerProofImageUrl() => $_clearField(3);
}

class ValidateReleaseRequest extends $pb.GeneratedMessage {
  factory ValidateReleaseRequest({
    $core.String? dealId,
    $core.String? transactionId,
    $core.String? verificationToken,
    $core.String? idempotencyKey,
  }) {
    final result = create();
    if (dealId != null) result.dealId = dealId;
    if (transactionId != null) result.transactionId = transactionId;
    if (verificationToken != null) result.verificationToken = verificationToken;
    if (idempotencyKey != null) result.idempotencyKey = idempotencyKey;
    return result;
  }

  ValidateReleaseRequest._();

  factory ValidateReleaseRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ValidateReleaseRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ValidateReleaseRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'escrow'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'dealId')
    ..aOS(2, _omitFieldNames ? '' : 'transactionId')
    ..aOS(3, _omitFieldNames ? '' : 'verificationToken')
    ..aOS(4, _omitFieldNames ? '' : 'idempotencyKey')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ValidateReleaseRequest clone() =>
      ValidateReleaseRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ValidateReleaseRequest copyWith(
          void Function(ValidateReleaseRequest) updates) =>
      super.copyWith((message) => updates(message as ValidateReleaseRequest))
          as ValidateReleaseRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ValidateReleaseRequest create() => ValidateReleaseRequest._();
  @$core.override
  ValidateReleaseRequest createEmptyInstance() => create();
  static $pb.PbList<ValidateReleaseRequest> createRepeated() =>
      $pb.PbList<ValidateReleaseRequest>();
  @$core.pragma('dart2js:noInline')
  static ValidateReleaseRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ValidateReleaseRequest>(create);
  static ValidateReleaseRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get dealId => $_getSZ(0);
  @$pb.TagNumber(1)
  set dealId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDealId() => $_has(0);
  @$pb.TagNumber(1)
  void clearDealId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get transactionId => $_getSZ(1);
  @$pb.TagNumber(2)
  set transactionId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTransactionId() => $_has(1);
  @$pb.TagNumber(2)
  void clearTransactionId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get verificationToken => $_getSZ(2);
  @$pb.TagNumber(3)
  set verificationToken($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasVerificationToken() => $_has(2);
  @$pb.TagNumber(3)
  void clearVerificationToken() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get idempotencyKey => $_getSZ(3);
  @$pb.TagNumber(4)
  set idempotencyKey($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasIdempotencyKey() => $_has(3);
  @$pb.TagNumber(4)
  void clearIdempotencyKey() => $_clearField(4);
}

class CancelDealRequest extends $pb.GeneratedMessage {
  factory CancelDealRequest({
    $core.String? dealId,
    $core.String? reason,
    $core.String? idempotencyKey,
  }) {
    final result = create();
    if (dealId != null) result.dealId = dealId;
    if (reason != null) result.reason = reason;
    if (idempotencyKey != null) result.idempotencyKey = idempotencyKey;
    return result;
  }

  CancelDealRequest._();

  factory CancelDealRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CancelDealRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CancelDealRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'escrow'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'dealId')
    ..aOS(2, _omitFieldNames ? '' : 'reason')
    ..aOS(3, _omitFieldNames ? '' : 'idempotencyKey')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CancelDealRequest clone() => CancelDealRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CancelDealRequest copyWith(void Function(CancelDealRequest) updates) =>
      super.copyWith((message) => updates(message as CancelDealRequest))
          as CancelDealRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CancelDealRequest create() => CancelDealRequest._();
  @$core.override
  CancelDealRequest createEmptyInstance() => create();
  static $pb.PbList<CancelDealRequest> createRepeated() =>
      $pb.PbList<CancelDealRequest>();
  @$core.pragma('dart2js:noInline')
  static CancelDealRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CancelDealRequest>(create);
  static CancelDealRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get dealId => $_getSZ(0);
  @$pb.TagNumber(1)
  set dealId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDealId() => $_has(0);
  @$pb.TagNumber(1)
  void clearDealId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get reason => $_getSZ(1);
  @$pb.TagNumber(2)
  set reason($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasReason() => $_has(1);
  @$pb.TagNumber(2)
  void clearReason() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get idempotencyKey => $_getSZ(2);
  @$pb.TagNumber(3)
  set idempotencyKey($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasIdempotencyKey() => $_has(2);
  @$pb.TagNumber(3)
  void clearIdempotencyKey() => $_clearField(3);
}

class OpenDisputeRequest extends $pb.GeneratedMessage {
  factory OpenDisputeRequest({
    $core.String? dealId,
    $core.String? reason,
    $core.String? evidenceUrl,
  }) {
    final result = create();
    if (dealId != null) result.dealId = dealId;
    if (reason != null) result.reason = reason;
    if (evidenceUrl != null) result.evidenceUrl = evidenceUrl;
    return result;
  }

  OpenDisputeRequest._();

  factory OpenDisputeRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory OpenDisputeRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'OpenDisputeRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'escrow'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'dealId')
    ..aOS(2, _omitFieldNames ? '' : 'reason')
    ..aOS(3, _omitFieldNames ? '' : 'evidenceUrl')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  OpenDisputeRequest clone() => OpenDisputeRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  OpenDisputeRequest copyWith(void Function(OpenDisputeRequest) updates) =>
      super.copyWith((message) => updates(message as OpenDisputeRequest))
          as OpenDisputeRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static OpenDisputeRequest create() => OpenDisputeRequest._();
  @$core.override
  OpenDisputeRequest createEmptyInstance() => create();
  static $pb.PbList<OpenDisputeRequest> createRepeated() =>
      $pb.PbList<OpenDisputeRequest>();
  @$core.pragma('dart2js:noInline')
  static OpenDisputeRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<OpenDisputeRequest>(create);
  static OpenDisputeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get dealId => $_getSZ(0);
  @$pb.TagNumber(1)
  set dealId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDealId() => $_has(0);
  @$pb.TagNumber(1)
  void clearDealId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get reason => $_getSZ(1);
  @$pb.TagNumber(2)
  set reason($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasReason() => $_has(1);
  @$pb.TagNumber(2)
  void clearReason() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get evidenceUrl => $_getSZ(2);
  @$pb.TagNumber(3)
  set evidenceUrl($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasEvidenceUrl() => $_has(2);
  @$pb.TagNumber(3)
  void clearEvidenceUrl() => $_clearField(3);
}

class QuoteFeeRequest extends $pb.GeneratedMessage {
  factory QuoteFeeRequest({
    $core.double? amount,
    $core.String? currency,
  }) {
    final result = create();
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    return result;
  }

  QuoteFeeRequest._();

  factory QuoteFeeRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory QuoteFeeRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'QuoteFeeRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'escrow'),
      createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(2, _omitFieldNames ? '' : 'currency')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  QuoteFeeRequest clone() => QuoteFeeRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  QuoteFeeRequest copyWith(void Function(QuoteFeeRequest) updates) =>
      super.copyWith((message) => updates(message as QuoteFeeRequest))
          as QuoteFeeRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static QuoteFeeRequest create() => QuoteFeeRequest._();
  @$core.override
  QuoteFeeRequest createEmptyInstance() => create();
  static $pb.PbList<QuoteFeeRequest> createRepeated() =>
      $pb.PbList<QuoteFeeRequest>();
  @$core.pragma('dart2js:noInline')
  static QuoteFeeRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<QuoteFeeRequest>(create);
  static QuoteFeeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get amount => $_getN(0);
  @$pb.TagNumber(1)
  set amount($core.double value) => $_setDouble(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAmount() => $_has(0);
  @$pb.TagNumber(1)
  void clearAmount() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get currency => $_getSZ(1);
  @$pb.TagNumber(2)
  set currency($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCurrency() => $_has(1);
  @$pb.TagNumber(2)
  void clearCurrency() => $_clearField(2);
}

class QuoteFeeResponse extends $pb.GeneratedMessage {
  factory QuoteFeeResponse({
    $core.double? amount,
    $core.double? fee,
    $core.String? feePayer,
    $core.double? buyerTotal,
    $core.double? sellerNet,
  }) {
    final result = create();
    if (amount != null) result.amount = amount;
    if (fee != null) result.fee = fee;
    if (feePayer != null) result.feePayer = feePayer;
    if (buyerTotal != null) result.buyerTotal = buyerTotal;
    if (sellerNet != null) result.sellerNet = sellerNet;
    return result;
  }

  QuoteFeeResponse._();

  factory QuoteFeeResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory QuoteFeeResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'QuoteFeeResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'escrow'),
      createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'fee', $pb.PbFieldType.OD)
    ..aOS(3, _omitFieldNames ? '' : 'feePayer')
    ..a<$core.double>(
        4, _omitFieldNames ? '' : 'buyerTotal', $pb.PbFieldType.OD)
    ..a<$core.double>(5, _omitFieldNames ? '' : 'sellerNet', $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  QuoteFeeResponse clone() => QuoteFeeResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  QuoteFeeResponse copyWith(void Function(QuoteFeeResponse) updates) =>
      super.copyWith((message) => updates(message as QuoteFeeResponse))
          as QuoteFeeResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static QuoteFeeResponse create() => QuoteFeeResponse._();
  @$core.override
  QuoteFeeResponse createEmptyInstance() => create();
  static $pb.PbList<QuoteFeeResponse> createRepeated() =>
      $pb.PbList<QuoteFeeResponse>();
  @$core.pragma('dart2js:noInline')
  static QuoteFeeResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<QuoteFeeResponse>(create);
  static QuoteFeeResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get amount => $_getN(0);
  @$pb.TagNumber(1)
  set amount($core.double value) => $_setDouble(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAmount() => $_has(0);
  @$pb.TagNumber(1)
  void clearAmount() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get fee => $_getN(1);
  @$pb.TagNumber(2)
  set fee($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasFee() => $_has(1);
  @$pb.TagNumber(2)
  void clearFee() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get feePayer => $_getSZ(2);
  @$pb.TagNumber(3)
  set feePayer($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasFeePayer() => $_has(2);
  @$pb.TagNumber(3)
  void clearFeePayer() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get buyerTotal => $_getN(3);
  @$pb.TagNumber(4)
  set buyerTotal($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasBuyerTotal() => $_has(3);
  @$pb.TagNumber(4)
  void clearBuyerTotal() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get sellerNet => $_getN(4);
  @$pb.TagNumber(5)
  set sellerNet($core.double value) => $_setDouble(4, value);
  @$pb.TagNumber(5)
  $core.bool hasSellerNet() => $_has(4);
  @$pb.TagNumber(5)
  void clearSellerNet() => $_clearField(5);
}

class AddAttachmentRequest extends $pb.GeneratedMessage {
  factory AddAttachmentRequest({
    $core.String? dealId,
    $core.String? purpose,
    $core.String? mediaKind,
    $core.String? url,
    $core.String? contentType,
    $fixnum.Int64? sizeBytes,
    $core.int? durationSeconds,
  }) {
    final result = create();
    if (dealId != null) result.dealId = dealId;
    if (purpose != null) result.purpose = purpose;
    if (mediaKind != null) result.mediaKind = mediaKind;
    if (url != null) result.url = url;
    if (contentType != null) result.contentType = contentType;
    if (sizeBytes != null) result.sizeBytes = sizeBytes;
    if (durationSeconds != null) result.durationSeconds = durationSeconds;
    return result;
  }

  AddAttachmentRequest._();

  factory AddAttachmentRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AddAttachmentRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AddAttachmentRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'escrow'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'dealId')
    ..aOS(2, _omitFieldNames ? '' : 'purpose')
    ..aOS(3, _omitFieldNames ? '' : 'mediaKind')
    ..aOS(4, _omitFieldNames ? '' : 'url')
    ..aOS(5, _omitFieldNames ? '' : 'contentType')
    ..aInt64(6, _omitFieldNames ? '' : 'sizeBytes')
    ..a<$core.int>(
        7, _omitFieldNames ? '' : 'durationSeconds', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddAttachmentRequest clone() =>
      AddAttachmentRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddAttachmentRequest copyWith(void Function(AddAttachmentRequest) updates) =>
      super.copyWith((message) => updates(message as AddAttachmentRequest))
          as AddAttachmentRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddAttachmentRequest create() => AddAttachmentRequest._();
  @$core.override
  AddAttachmentRequest createEmptyInstance() => create();
  static $pb.PbList<AddAttachmentRequest> createRepeated() =>
      $pb.PbList<AddAttachmentRequest>();
  @$core.pragma('dart2js:noInline')
  static AddAttachmentRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AddAttachmentRequest>(create);
  static AddAttachmentRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get dealId => $_getSZ(0);
  @$pb.TagNumber(1)
  set dealId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDealId() => $_has(0);
  @$pb.TagNumber(1)
  void clearDealId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get purpose => $_getSZ(1);
  @$pb.TagNumber(2)
  set purpose($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPurpose() => $_has(1);
  @$pb.TagNumber(2)
  void clearPurpose() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get mediaKind => $_getSZ(2);
  @$pb.TagNumber(3)
  set mediaKind($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMediaKind() => $_has(2);
  @$pb.TagNumber(3)
  void clearMediaKind() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get url => $_getSZ(3);
  @$pb.TagNumber(4)
  set url($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasUrl() => $_has(3);
  @$pb.TagNumber(4)
  void clearUrl() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get contentType => $_getSZ(4);
  @$pb.TagNumber(5)
  set contentType($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasContentType() => $_has(4);
  @$pb.TagNumber(5)
  void clearContentType() => $_clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get sizeBytes => $_getI64(5);
  @$pb.TagNumber(6)
  set sizeBytes($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasSizeBytes() => $_has(5);
  @$pb.TagNumber(6)
  void clearSizeBytes() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.int get durationSeconds => $_getIZ(6);
  @$pb.TagNumber(7)
  set durationSeconds($core.int value) => $_setSignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasDurationSeconds() => $_has(6);
  @$pb.TagNumber(7)
  void clearDurationSeconds() => $_clearField(7);
}

class AttachmentResponse extends $pb.GeneratedMessage {
  factory AttachmentResponse({
    Attachment? attachment,
    $core.String? message,
  }) {
    final result = create();
    if (attachment != null) result.attachment = attachment;
    if (message != null) result.message = message;
    return result;
  }

  AttachmentResponse._();

  factory AttachmentResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AttachmentResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AttachmentResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'escrow'),
      createEmptyInstance: create)
    ..aOM<Attachment>(1, _omitFieldNames ? '' : 'attachment',
        subBuilder: Attachment.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AttachmentResponse clone() => AttachmentResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AttachmentResponse copyWith(void Function(AttachmentResponse) updates) =>
      super.copyWith((message) => updates(message as AttachmentResponse))
          as AttachmentResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AttachmentResponse create() => AttachmentResponse._();
  @$core.override
  AttachmentResponse createEmptyInstance() => create();
  static $pb.PbList<AttachmentResponse> createRepeated() =>
      $pb.PbList<AttachmentResponse>();
  @$core.pragma('dart2js:noInline')
  static AttachmentResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AttachmentResponse>(create);
  static AttachmentResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Attachment get attachment => $_getN(0);
  @$pb.TagNumber(1)
  set attachment(Attachment value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasAttachment() => $_has(0);
  @$pb.TagNumber(1)
  void clearAttachment() => $_clearField(1);
  @$pb.TagNumber(1)
  Attachment ensureAttachment() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);
}

class RequestRefundRequest extends $pb.GeneratedMessage {
  factory RequestRefundRequest({
    $core.String? dealId,
    $core.String? reason,
  }) {
    final result = create();
    if (dealId != null) result.dealId = dealId;
    if (reason != null) result.reason = reason;
    return result;
  }

  RequestRefundRequest._();

  factory RequestRefundRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RequestRefundRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RequestRefundRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'escrow'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'dealId')
    ..aOS(2, _omitFieldNames ? '' : 'reason')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RequestRefundRequest clone() =>
      RequestRefundRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RequestRefundRequest copyWith(void Function(RequestRefundRequest) updates) =>
      super.copyWith((message) => updates(message as RequestRefundRequest))
          as RequestRefundRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RequestRefundRequest create() => RequestRefundRequest._();
  @$core.override
  RequestRefundRequest createEmptyInstance() => create();
  static $pb.PbList<RequestRefundRequest> createRepeated() =>
      $pb.PbList<RequestRefundRequest>();
  @$core.pragma('dart2js:noInline')
  static RequestRefundRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RequestRefundRequest>(create);
  static RequestRefundRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get dealId => $_getSZ(0);
  @$pb.TagNumber(1)
  set dealId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDealId() => $_has(0);
  @$pb.TagNumber(1)
  void clearDealId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get reason => $_getSZ(1);
  @$pb.TagNumber(2)
  set reason($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasReason() => $_has(1);
  @$pb.TagNumber(2)
  void clearReason() => $_clearField(2);
}

class RespondRefundRequest extends $pb.GeneratedMessage {
  factory RespondRefundRequest({
    $core.String? dealId,
    $core.bool? accept,
    $core.String? note,
  }) {
    final result = create();
    if (dealId != null) result.dealId = dealId;
    if (accept != null) result.accept = accept;
    if (note != null) result.note = note;
    return result;
  }

  RespondRefundRequest._();

  factory RespondRefundRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RespondRefundRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RespondRefundRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'escrow'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'dealId')
    ..aOB(2, _omitFieldNames ? '' : 'accept')
    ..aOS(3, _omitFieldNames ? '' : 'note')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RespondRefundRequest clone() =>
      RespondRefundRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RespondRefundRequest copyWith(void Function(RespondRefundRequest) updates) =>
      super.copyWith((message) => updates(message as RespondRefundRequest))
          as RespondRefundRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RespondRefundRequest create() => RespondRefundRequest._();
  @$core.override
  RespondRefundRequest createEmptyInstance() => create();
  static $pb.PbList<RespondRefundRequest> createRepeated() =>
      $pb.PbList<RespondRefundRequest>();
  @$core.pragma('dart2js:noInline')
  static RespondRefundRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RespondRefundRequest>(create);
  static RespondRefundRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get dealId => $_getSZ(0);
  @$pb.TagNumber(1)
  set dealId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDealId() => $_has(0);
  @$pb.TagNumber(1)
  void clearDealId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get accept => $_getBF(1);
  @$pb.TagNumber(2)
  set accept($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAccept() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccept() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get note => $_getSZ(2);
  @$pb.TagNumber(3)
  set note($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasNote() => $_has(2);
  @$pb.TagNumber(3)
  void clearNote() => $_clearField(3);
}

/// Offer is a listing (sell_offer) or purchase request (buy_request) awaiting
/// mutual agreement. Status: OPEN → AWAITING_FUNDING (buy_request accept) →
/// CONVERTED (funded → deal_id) | DECLINED | CANCELLED | EXPIRED.
/// The share token is NEVER exposed here — the creator receives it once from
/// CreateOffer; anyone else only ever consumes it via GetOfferByShareToken.
class Offer extends $pb.GeneratedMessage {
  factory Offer({
    $core.String? id,
    $core.String? reference,
    $core.String? direction,
    $core.String? creatorUserId,
    $core.String? creatorName,
    $core.String? counterpartyUserId,
    $core.String? counterpartyName,
    $core.String? title,
    $core.String? description,
    $core.double? amount,
    $core.String? currency,
    $core.String? feePayerMode,
    $core.int? deliveryDeadlineDays,
    $core.String? status,
    $core.String? declineReason,
    $1.Timestamp? expiresAt,
    $1.Timestamp? fundingDeadlineAt,
    $core.String? dealId,
    $1.Timestamp? acceptedAt,
    $1.Timestamp? createdAt,
    $core.Iterable<Attachment>? attachments,
    $core.bool? viewerIsCreator,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (reference != null) result.reference = reference;
    if (direction != null) result.direction = direction;
    if (creatorUserId != null) result.creatorUserId = creatorUserId;
    if (creatorName != null) result.creatorName = creatorName;
    if (counterpartyUserId != null)
      result.counterpartyUserId = counterpartyUserId;
    if (counterpartyName != null) result.counterpartyName = counterpartyName;
    if (title != null) result.title = title;
    if (description != null) result.description = description;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    if (feePayerMode != null) result.feePayerMode = feePayerMode;
    if (deliveryDeadlineDays != null)
      result.deliveryDeadlineDays = deliveryDeadlineDays;
    if (status != null) result.status = status;
    if (declineReason != null) result.declineReason = declineReason;
    if (expiresAt != null) result.expiresAt = expiresAt;
    if (fundingDeadlineAt != null) result.fundingDeadlineAt = fundingDeadlineAt;
    if (dealId != null) result.dealId = dealId;
    if (acceptedAt != null) result.acceptedAt = acceptedAt;
    if (createdAt != null) result.createdAt = createdAt;
    if (attachments != null) result.attachments.addAll(attachments);
    if (viewerIsCreator != null) result.viewerIsCreator = viewerIsCreator;
    return result;
  }

  Offer._();

  factory Offer.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Offer.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Offer',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'escrow'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'reference')
    ..aOS(3, _omitFieldNames ? '' : 'direction')
    ..aOS(4, _omitFieldNames ? '' : 'creatorUserId')
    ..aOS(5, _omitFieldNames ? '' : 'creatorName')
    ..aOS(6, _omitFieldNames ? '' : 'counterpartyUserId')
    ..aOS(7, _omitFieldNames ? '' : 'counterpartyName')
    ..aOS(8, _omitFieldNames ? '' : 'title')
    ..aOS(9, _omitFieldNames ? '' : 'description')
    ..a<$core.double>(10, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(11, _omitFieldNames ? '' : 'currency')
    ..aOS(12, _omitFieldNames ? '' : 'feePayerMode')
    ..a<$core.int>(
        13, _omitFieldNames ? '' : 'deliveryDeadlineDays', $pb.PbFieldType.O3)
    ..aOS(14, _omitFieldNames ? '' : 'status')
    ..aOS(15, _omitFieldNames ? '' : 'declineReason')
    ..aOM<$1.Timestamp>(16, _omitFieldNames ? '' : 'expiresAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(17, _omitFieldNames ? '' : 'fundingDeadlineAt',
        subBuilder: $1.Timestamp.create)
    ..aOS(18, _omitFieldNames ? '' : 'dealId')
    ..aOM<$1.Timestamp>(19, _omitFieldNames ? '' : 'acceptedAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(20, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $1.Timestamp.create)
    ..pc<Attachment>(
        21, _omitFieldNames ? '' : 'attachments', $pb.PbFieldType.PM,
        subBuilder: Attachment.create)
    ..aOB(22, _omitFieldNames ? '' : 'viewerIsCreator')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Offer clone() => Offer()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Offer copyWith(void Function(Offer) updates) =>
      super.copyWith((message) => updates(message as Offer)) as Offer;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Offer create() => Offer._();
  @$core.override
  Offer createEmptyInstance() => create();
  static $pb.PbList<Offer> createRepeated() => $pb.PbList<Offer>();
  @$core.pragma('dart2js:noInline')
  static Offer getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Offer>(create);
  static Offer? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get reference => $_getSZ(1);
  @$pb.TagNumber(2)
  set reference($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasReference() => $_has(1);
  @$pb.TagNumber(2)
  void clearReference() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get direction => $_getSZ(2);
  @$pb.TagNumber(3)
  set direction($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDirection() => $_has(2);
  @$pb.TagNumber(3)
  void clearDirection() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get creatorUserId => $_getSZ(3);
  @$pb.TagNumber(4)
  set creatorUserId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCreatorUserId() => $_has(3);
  @$pb.TagNumber(4)
  void clearCreatorUserId() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get creatorName => $_getSZ(4);
  @$pb.TagNumber(5)
  set creatorName($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasCreatorName() => $_has(4);
  @$pb.TagNumber(5)
  void clearCreatorName() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get counterpartyUserId => $_getSZ(5);
  @$pb.TagNumber(6)
  set counterpartyUserId($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasCounterpartyUserId() => $_has(5);
  @$pb.TagNumber(6)
  void clearCounterpartyUserId() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get counterpartyName => $_getSZ(6);
  @$pb.TagNumber(7)
  set counterpartyName($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasCounterpartyName() => $_has(6);
  @$pb.TagNumber(7)
  void clearCounterpartyName() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get title => $_getSZ(7);
  @$pb.TagNumber(8)
  set title($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasTitle() => $_has(7);
  @$pb.TagNumber(8)
  void clearTitle() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get description => $_getSZ(8);
  @$pb.TagNumber(9)
  set description($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasDescription() => $_has(8);
  @$pb.TagNumber(9)
  void clearDescription() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.double get amount => $_getN(9);
  @$pb.TagNumber(10)
  set amount($core.double value) => $_setDouble(9, value);
  @$pb.TagNumber(10)
  $core.bool hasAmount() => $_has(9);
  @$pb.TagNumber(10)
  void clearAmount() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get currency => $_getSZ(10);
  @$pb.TagNumber(11)
  set currency($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasCurrency() => $_has(10);
  @$pb.TagNumber(11)
  void clearCurrency() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get feePayerMode => $_getSZ(11);
  @$pb.TagNumber(12)
  set feePayerMode($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasFeePayerMode() => $_has(11);
  @$pb.TagNumber(12)
  void clearFeePayerMode() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.int get deliveryDeadlineDays => $_getIZ(12);
  @$pb.TagNumber(13)
  set deliveryDeadlineDays($core.int value) => $_setSignedInt32(12, value);
  @$pb.TagNumber(13)
  $core.bool hasDeliveryDeadlineDays() => $_has(12);
  @$pb.TagNumber(13)
  void clearDeliveryDeadlineDays() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.String get status => $_getSZ(13);
  @$pb.TagNumber(14)
  set status($core.String value) => $_setString(13, value);
  @$pb.TagNumber(14)
  $core.bool hasStatus() => $_has(13);
  @$pb.TagNumber(14)
  void clearStatus() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.String get declineReason => $_getSZ(14);
  @$pb.TagNumber(15)
  set declineReason($core.String value) => $_setString(14, value);
  @$pb.TagNumber(15)
  $core.bool hasDeclineReason() => $_has(14);
  @$pb.TagNumber(15)
  void clearDeclineReason() => $_clearField(15);

  @$pb.TagNumber(16)
  $1.Timestamp get expiresAt => $_getN(15);
  @$pb.TagNumber(16)
  set expiresAt($1.Timestamp value) => $_setField(16, value);
  @$pb.TagNumber(16)
  $core.bool hasExpiresAt() => $_has(15);
  @$pb.TagNumber(16)
  void clearExpiresAt() => $_clearField(16);
  @$pb.TagNumber(16)
  $1.Timestamp ensureExpiresAt() => $_ensure(15);

  @$pb.TagNumber(17)
  $1.Timestamp get fundingDeadlineAt => $_getN(16);
  @$pb.TagNumber(17)
  set fundingDeadlineAt($1.Timestamp value) => $_setField(17, value);
  @$pb.TagNumber(17)
  $core.bool hasFundingDeadlineAt() => $_has(16);
  @$pb.TagNumber(17)
  void clearFundingDeadlineAt() => $_clearField(17);
  @$pb.TagNumber(17)
  $1.Timestamp ensureFundingDeadlineAt() => $_ensure(16);

  @$pb.TagNumber(18)
  $core.String get dealId => $_getSZ(17);
  @$pb.TagNumber(18)
  set dealId($core.String value) => $_setString(17, value);
  @$pb.TagNumber(18)
  $core.bool hasDealId() => $_has(17);
  @$pb.TagNumber(18)
  void clearDealId() => $_clearField(18);

  @$pb.TagNumber(19)
  $1.Timestamp get acceptedAt => $_getN(18);
  @$pb.TagNumber(19)
  set acceptedAt($1.Timestamp value) => $_setField(19, value);
  @$pb.TagNumber(19)
  $core.bool hasAcceptedAt() => $_has(18);
  @$pb.TagNumber(19)
  void clearAcceptedAt() => $_clearField(19);
  @$pb.TagNumber(19)
  $1.Timestamp ensureAcceptedAt() => $_ensure(18);

  @$pb.TagNumber(20)
  $1.Timestamp get createdAt => $_getN(19);
  @$pb.TagNumber(20)
  set createdAt($1.Timestamp value) => $_setField(20, value);
  @$pb.TagNumber(20)
  $core.bool hasCreatedAt() => $_has(19);
  @$pb.TagNumber(20)
  void clearCreatedAt() => $_clearField(20);
  @$pb.TagNumber(20)
  $1.Timestamp ensureCreatedAt() => $_ensure(19);

  @$pb.TagNumber(21)
  $pb.PbList<Attachment> get attachments => $_getList(20);

  /// True when the caller is the creator (convenience for role-aware UI).
  @$pb.TagNumber(22)
  $core.bool get viewerIsCreator => $_getBF(21);
  @$pb.TagNumber(22)
  set viewerIsCreator($core.bool value) => $_setBool(21, value);
  @$pb.TagNumber(22)
  $core.bool hasViewerIsCreator() => $_has(21);
  @$pb.TagNumber(22)
  void clearViewerIsCreator() => $_clearField(22);
}

class CreateOfferRequest extends $pb.GeneratedMessage {
  factory CreateOfferRequest({
    $core.String? direction,
    $core.String? counterpartyQuery,
    $core.String? title,
    $core.String? description,
    $core.double? amount,
    $core.String? currency,
    $core.String? feePayerPreference,
    $core.int? deliveryDeadlineDays,
  }) {
    final result = create();
    if (direction != null) result.direction = direction;
    if (counterpartyQuery != null) result.counterpartyQuery = counterpartyQuery;
    if (title != null) result.title = title;
    if (description != null) result.description = description;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    if (feePayerPreference != null)
      result.feePayerPreference = feePayerPreference;
    if (deliveryDeadlineDays != null)
      result.deliveryDeadlineDays = deliveryDeadlineDays;
    return result;
  }

  CreateOfferRequest._();

  factory CreateOfferRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateOfferRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateOfferRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'escrow'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'direction')
    ..aOS(2, _omitFieldNames ? '' : 'counterpartyQuery')
    ..aOS(3, _omitFieldNames ? '' : 'title')
    ..aOS(4, _omitFieldNames ? '' : 'description')
    ..a<$core.double>(5, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(6, _omitFieldNames ? '' : 'currency')
    ..aOS(7, _omitFieldNames ? '' : 'feePayerPreference')
    ..a<$core.int>(
        8, _omitFieldNames ? '' : 'deliveryDeadlineDays', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateOfferRequest clone() => CreateOfferRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateOfferRequest copyWith(void Function(CreateOfferRequest) updates) =>
      super.copyWith((message) => updates(message as CreateOfferRequest))
          as CreateOfferRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateOfferRequest create() => CreateOfferRequest._();
  @$core.override
  CreateOfferRequest createEmptyInstance() => create();
  static $pb.PbList<CreateOfferRequest> createRepeated() =>
      $pb.PbList<CreateOfferRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateOfferRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateOfferRequest>(create);
  static CreateOfferRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get direction => $_getSZ(0);
  @$pb.TagNumber(1)
  set direction($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDirection() => $_has(0);
  @$pb.TagNumber(1)
  void clearDirection() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get counterpartyQuery => $_getSZ(1);
  @$pb.TagNumber(2)
  set counterpartyQuery($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCounterpartyQuery() => $_has(1);
  @$pb.TagNumber(2)
  void clearCounterpartyQuery() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get title => $_getSZ(2);
  @$pb.TagNumber(3)
  set title($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTitle() => $_has(2);
  @$pb.TagNumber(3)
  void clearTitle() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get description => $_getSZ(3);
  @$pb.TagNumber(4)
  set description($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDescription() => $_has(3);
  @$pb.TagNumber(4)
  void clearDescription() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get amount => $_getN(4);
  @$pb.TagNumber(5)
  set amount($core.double value) => $_setDouble(4, value);
  @$pb.TagNumber(5)
  $core.bool hasAmount() => $_has(4);
  @$pb.TagNumber(5)
  void clearAmount() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get currency => $_getSZ(5);
  @$pb.TagNumber(6)
  set currency($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasCurrency() => $_has(5);
  @$pb.TagNumber(6)
  void clearCurrency() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get feePayerPreference => $_getSZ(6);
  @$pb.TagNumber(7)
  set feePayerPreference($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasFeePayerPreference() => $_has(6);
  @$pb.TagNumber(7)
  void clearFeePayerPreference() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.int get deliveryDeadlineDays => $_getIZ(7);
  @$pb.TagNumber(8)
  set deliveryDeadlineDays($core.int value) => $_setSignedInt32(7, value);
  @$pb.TagNumber(8)
  $core.bool hasDeliveryDeadlineDays() => $_has(7);
  @$pb.TagNumber(8)
  void clearDeliveryDeadlineDays() => $_clearField(8);
}

/// share_url_token is returned ONLY here, once, to the creator.
class OfferResponse extends $pb.GeneratedMessage {
  factory OfferResponse({
    Offer? offer,
    $core.String? message,
    $core.String? shareUrlToken,
  }) {
    final result = create();
    if (offer != null) result.offer = offer;
    if (message != null) result.message = message;
    if (shareUrlToken != null) result.shareUrlToken = shareUrlToken;
    return result;
  }

  OfferResponse._();

  factory OfferResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory OfferResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'OfferResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'escrow'),
      createEmptyInstance: create)
    ..aOM<Offer>(1, _omitFieldNames ? '' : 'offer', subBuilder: Offer.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOS(3, _omitFieldNames ? '' : 'shareUrlToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  OfferResponse clone() => OfferResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  OfferResponse copyWith(void Function(OfferResponse) updates) =>
      super.copyWith((message) => updates(message as OfferResponse))
          as OfferResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static OfferResponse create() => OfferResponse._();
  @$core.override
  OfferResponse createEmptyInstance() => create();
  static $pb.PbList<OfferResponse> createRepeated() =>
      $pb.PbList<OfferResponse>();
  @$core.pragma('dart2js:noInline')
  static OfferResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<OfferResponse>(create);
  static OfferResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Offer get offer => $_getN(0);
  @$pb.TagNumber(1)
  set offer(Offer value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasOffer() => $_has(0);
  @$pb.TagNumber(1)
  void clearOffer() => $_clearField(1);
  @$pb.TagNumber(1)
  Offer ensureOffer() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get shareUrlToken => $_getSZ(2);
  @$pb.TagNumber(3)
  set shareUrlToken($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasShareUrlToken() => $_has(2);
  @$pb.TagNumber(3)
  void clearShareUrlToken() => $_clearField(3);
}

class GetOfferRequest extends $pb.GeneratedMessage {
  factory GetOfferRequest({
    $core.String? offerId,
  }) {
    final result = create();
    if (offerId != null) result.offerId = offerId;
    return result;
  }

  GetOfferRequest._();

  factory GetOfferRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetOfferRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetOfferRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'escrow'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'offerId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetOfferRequest clone() => GetOfferRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetOfferRequest copyWith(void Function(GetOfferRequest) updates) =>
      super.copyWith((message) => updates(message as GetOfferRequest))
          as GetOfferRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetOfferRequest create() => GetOfferRequest._();
  @$core.override
  GetOfferRequest createEmptyInstance() => create();
  static $pb.PbList<GetOfferRequest> createRepeated() =>
      $pb.PbList<GetOfferRequest>();
  @$core.pragma('dart2js:noInline')
  static GetOfferRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetOfferRequest>(create);
  static GetOfferRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get offerId => $_getSZ(0);
  @$pb.TagNumber(1)
  set offerId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasOfferId() => $_has(0);
  @$pb.TagNumber(1)
  void clearOfferId() => $_clearField(1);
}

class GetOfferByShareTokenRequest extends $pb.GeneratedMessage {
  factory GetOfferByShareTokenRequest({
    $core.String? shareToken,
  }) {
    final result = create();
    if (shareToken != null) result.shareToken = shareToken;
    return result;
  }

  GetOfferByShareTokenRequest._();

  factory GetOfferByShareTokenRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetOfferByShareTokenRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetOfferByShareTokenRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'escrow'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'shareToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetOfferByShareTokenRequest clone() =>
      GetOfferByShareTokenRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetOfferByShareTokenRequest copyWith(
          void Function(GetOfferByShareTokenRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetOfferByShareTokenRequest))
          as GetOfferByShareTokenRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetOfferByShareTokenRequest create() =>
      GetOfferByShareTokenRequest._();
  @$core.override
  GetOfferByShareTokenRequest createEmptyInstance() => create();
  static $pb.PbList<GetOfferByShareTokenRequest> createRepeated() =>
      $pb.PbList<GetOfferByShareTokenRequest>();
  @$core.pragma('dart2js:noInline')
  static GetOfferByShareTokenRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetOfferByShareTokenRequest>(create);
  static GetOfferByShareTokenRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get shareToken => $_getSZ(0);
  @$pb.TagNumber(1)
  set shareToken($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasShareToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearShareToken() => $_clearField(1);
}

class ListMyOffersRequest extends $pb.GeneratedMessage {
  factory ListMyOffersRequest({
    $core.String? role,
    $core.String? status,
    $core.int? page,
    $core.int? limit,
  }) {
    final result = create();
    if (role != null) result.role = role;
    if (status != null) result.status = status;
    if (page != null) result.page = page;
    if (limit != null) result.limit = limit;
    return result;
  }

  ListMyOffersRequest._();

  factory ListMyOffersRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListMyOffersRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListMyOffersRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'escrow'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'role')
    ..aOS(2, _omitFieldNames ? '' : 'status')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListMyOffersRequest clone() => ListMyOffersRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListMyOffersRequest copyWith(void Function(ListMyOffersRequest) updates) =>
      super.copyWith((message) => updates(message as ListMyOffersRequest))
          as ListMyOffersRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListMyOffersRequest create() => ListMyOffersRequest._();
  @$core.override
  ListMyOffersRequest createEmptyInstance() => create();
  static $pb.PbList<ListMyOffersRequest> createRepeated() =>
      $pb.PbList<ListMyOffersRequest>();
  @$core.pragma('dart2js:noInline')
  static ListMyOffersRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListMyOffersRequest>(create);
  static ListMyOffersRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get role => $_getSZ(0);
  @$pb.TagNumber(1)
  set role($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRole() => $_has(0);
  @$pb.TagNumber(1)
  void clearRole() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get status => $_getSZ(1);
  @$pb.TagNumber(2)
  set status($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get page => $_getIZ(2);
  @$pb.TagNumber(3)
  set page($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPage() => $_has(2);
  @$pb.TagNumber(3)
  void clearPage() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get limit => $_getIZ(3);
  @$pb.TagNumber(4)
  set limit($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasLimit() => $_has(3);
  @$pb.TagNumber(4)
  void clearLimit() => $_clearField(4);
}

class ListOffersResponse extends $pb.GeneratedMessage {
  factory ListOffersResponse({
    $core.Iterable<Offer>? offers,
    $core.int? total,
  }) {
    final result = create();
    if (offers != null) result.offers.addAll(offers);
    if (total != null) result.total = total;
    return result;
  }

  ListOffersResponse._();

  factory ListOffersResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListOffersResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListOffersResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'escrow'),
      createEmptyInstance: create)
    ..pc<Offer>(1, _omitFieldNames ? '' : 'offers', $pb.PbFieldType.PM,
        subBuilder: Offer.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListOffersResponse clone() => ListOffersResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListOffersResponse copyWith(void Function(ListOffersResponse) updates) =>
      super.copyWith((message) => updates(message as ListOffersResponse))
          as ListOffersResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListOffersResponse create() => ListOffersResponse._();
  @$core.override
  ListOffersResponse createEmptyInstance() => create();
  static $pb.PbList<ListOffersResponse> createRepeated() =>
      $pb.PbList<ListOffersResponse>();
  @$core.pragma('dart2js:noInline')
  static ListOffersResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListOffersResponse>(create);
  static ListOffersResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Offer> get offers => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);
}

class RespondOfferRequest extends $pb.GeneratedMessage {
  factory RespondOfferRequest({
    $core.String? offerId,
    $core.bool? accept,
    $core.String? note,
  }) {
    final result = create();
    if (offerId != null) result.offerId = offerId;
    if (accept != null) result.accept = accept;
    if (note != null) result.note = note;
    return result;
  }

  RespondOfferRequest._();

  factory RespondOfferRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RespondOfferRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RespondOfferRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'escrow'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'offerId')
    ..aOB(2, _omitFieldNames ? '' : 'accept')
    ..aOS(3, _omitFieldNames ? '' : 'note')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RespondOfferRequest clone() => RespondOfferRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RespondOfferRequest copyWith(void Function(RespondOfferRequest) updates) =>
      super.copyWith((message) => updates(message as RespondOfferRequest))
          as RespondOfferRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RespondOfferRequest create() => RespondOfferRequest._();
  @$core.override
  RespondOfferRequest createEmptyInstance() => create();
  static $pb.PbList<RespondOfferRequest> createRepeated() =>
      $pb.PbList<RespondOfferRequest>();
  @$core.pragma('dart2js:noInline')
  static RespondOfferRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RespondOfferRequest>(create);
  static RespondOfferRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get offerId => $_getSZ(0);
  @$pb.TagNumber(1)
  set offerId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasOfferId() => $_has(0);
  @$pb.TagNumber(1)
  void clearOfferId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get accept => $_getBF(1);
  @$pb.TagNumber(2)
  set accept($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAccept() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccept() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get note => $_getSZ(2);
  @$pb.TagNumber(3)
  set note($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasNote() => $_has(2);
  @$pb.TagNumber(3)
  void clearNote() => $_clearField(3);
}

class FundOfferRequest extends $pb.GeneratedMessage {
  factory FundOfferRequest({
    $core.String? offerId,
    $core.String? buyerAccountId,
    $core.String? transactionId,
    $core.String? verificationToken,
    $core.String? idempotencyKey,
  }) {
    final result = create();
    if (offerId != null) result.offerId = offerId;
    if (buyerAccountId != null) result.buyerAccountId = buyerAccountId;
    if (transactionId != null) result.transactionId = transactionId;
    if (verificationToken != null) result.verificationToken = verificationToken;
    if (idempotencyKey != null) result.idempotencyKey = idempotencyKey;
    return result;
  }

  FundOfferRequest._();

  factory FundOfferRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FundOfferRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FundOfferRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'escrow'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'offerId')
    ..aOS(2, _omitFieldNames ? '' : 'buyerAccountId')
    ..aOS(3, _omitFieldNames ? '' : 'transactionId')
    ..aOS(4, _omitFieldNames ? '' : 'verificationToken')
    ..aOS(5, _omitFieldNames ? '' : 'idempotencyKey')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FundOfferRequest clone() => FundOfferRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FundOfferRequest copyWith(void Function(FundOfferRequest) updates) =>
      super.copyWith((message) => updates(message as FundOfferRequest))
          as FundOfferRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FundOfferRequest create() => FundOfferRequest._();
  @$core.override
  FundOfferRequest createEmptyInstance() => create();
  static $pb.PbList<FundOfferRequest> createRepeated() =>
      $pb.PbList<FundOfferRequest>();
  @$core.pragma('dart2js:noInline')
  static FundOfferRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FundOfferRequest>(create);
  static FundOfferRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get offerId => $_getSZ(0);
  @$pb.TagNumber(1)
  set offerId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasOfferId() => $_has(0);
  @$pb.TagNumber(1)
  void clearOfferId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get buyerAccountId => $_getSZ(1);
  @$pb.TagNumber(2)
  set buyerAccountId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasBuyerAccountId() => $_has(1);
  @$pb.TagNumber(2)
  void clearBuyerAccountId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get transactionId => $_getSZ(2);
  @$pb.TagNumber(3)
  set transactionId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTransactionId() => $_has(2);
  @$pb.TagNumber(3)
  void clearTransactionId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get verificationToken => $_getSZ(3);
  @$pb.TagNumber(4)
  set verificationToken($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasVerificationToken() => $_has(3);
  @$pb.TagNumber(4)
  void clearVerificationToken() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get idempotencyKey => $_getSZ(4);
  @$pb.TagNumber(5)
  set idempotencyKey($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasIdempotencyKey() => $_has(4);
  @$pb.TagNumber(5)
  void clearIdempotencyKey() => $_clearField(5);
}

class CancelOfferRequest extends $pb.GeneratedMessage {
  factory CancelOfferRequest({
    $core.String? offerId,
  }) {
    final result = create();
    if (offerId != null) result.offerId = offerId;
    return result;
  }

  CancelOfferRequest._();

  factory CancelOfferRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CancelOfferRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CancelOfferRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'escrow'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'offerId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CancelOfferRequest clone() => CancelOfferRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CancelOfferRequest copyWith(void Function(CancelOfferRequest) updates) =>
      super.copyWith((message) => updates(message as CancelOfferRequest))
          as CancelOfferRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CancelOfferRequest create() => CancelOfferRequest._();
  @$core.override
  CancelOfferRequest createEmptyInstance() => create();
  static $pb.PbList<CancelOfferRequest> createRepeated() =>
      $pb.PbList<CancelOfferRequest>();
  @$core.pragma('dart2js:noInline')
  static CancelOfferRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CancelOfferRequest>(create);
  static CancelOfferRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get offerId => $_getSZ(0);
  @$pb.TagNumber(1)
  set offerId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasOfferId() => $_has(0);
  @$pb.TagNumber(1)
  void clearOfferId() => $_clearField(1);
}

class AddOfferAttachmentRequest extends $pb.GeneratedMessage {
  factory AddOfferAttachmentRequest({
    $core.String? offerId,
    $core.String? mediaKind,
    $core.String? url,
    $core.String? contentType,
    $fixnum.Int64? sizeBytes,
    $core.int? durationSeconds,
  }) {
    final result = create();
    if (offerId != null) result.offerId = offerId;
    if (mediaKind != null) result.mediaKind = mediaKind;
    if (url != null) result.url = url;
    if (contentType != null) result.contentType = contentType;
    if (sizeBytes != null) result.sizeBytes = sizeBytes;
    if (durationSeconds != null) result.durationSeconds = durationSeconds;
    return result;
  }

  AddOfferAttachmentRequest._();

  factory AddOfferAttachmentRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AddOfferAttachmentRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AddOfferAttachmentRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'escrow'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'offerId')
    ..aOS(2, _omitFieldNames ? '' : 'mediaKind')
    ..aOS(3, _omitFieldNames ? '' : 'url')
    ..aOS(4, _omitFieldNames ? '' : 'contentType')
    ..aInt64(5, _omitFieldNames ? '' : 'sizeBytes')
    ..a<$core.int>(
        6, _omitFieldNames ? '' : 'durationSeconds', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddOfferAttachmentRequest clone() =>
      AddOfferAttachmentRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddOfferAttachmentRequest copyWith(
          void Function(AddOfferAttachmentRequest) updates) =>
      super.copyWith((message) => updates(message as AddOfferAttachmentRequest))
          as AddOfferAttachmentRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddOfferAttachmentRequest create() => AddOfferAttachmentRequest._();
  @$core.override
  AddOfferAttachmentRequest createEmptyInstance() => create();
  static $pb.PbList<AddOfferAttachmentRequest> createRepeated() =>
      $pb.PbList<AddOfferAttachmentRequest>();
  @$core.pragma('dart2js:noInline')
  static AddOfferAttachmentRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AddOfferAttachmentRequest>(create);
  static AddOfferAttachmentRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get offerId => $_getSZ(0);
  @$pb.TagNumber(1)
  set offerId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasOfferId() => $_has(0);
  @$pb.TagNumber(1)
  void clearOfferId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get mediaKind => $_getSZ(1);
  @$pb.TagNumber(2)
  set mediaKind($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMediaKind() => $_has(1);
  @$pb.TagNumber(2)
  void clearMediaKind() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get url => $_getSZ(2);
  @$pb.TagNumber(3)
  set url($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasUrl() => $_has(2);
  @$pb.TagNumber(3)
  void clearUrl() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get contentType => $_getSZ(3);
  @$pb.TagNumber(4)
  set contentType($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasContentType() => $_has(3);
  @$pb.TagNumber(4)
  void clearContentType() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get sizeBytes => $_getI64(4);
  @$pb.TagNumber(5)
  set sizeBytes($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasSizeBytes() => $_has(4);
  @$pb.TagNumber(5)
  void clearSizeBytes() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.int get durationSeconds => $_getIZ(5);
  @$pb.TagNumber(6)
  set durationSeconds($core.int value) => $_setSignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasDurationSeconds() => $_has(5);
  @$pb.TagNumber(6)
  void clearDurationSeconds() => $_clearField(6);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
