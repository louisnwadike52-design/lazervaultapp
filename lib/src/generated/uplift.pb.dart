// This is a generated file - do not edit.
//
// Generated from uplift.proto.

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
import 'uplift.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'uplift.pbenum.dart';

class UpliftUserMessage extends $pb.GeneratedMessage {
  factory UpliftUserMessage({
    $fixnum.Int64? userId,
    $core.String? username,
    $core.String? firstName,
    $core.String? lastName,
    $core.String? displayName,
    $core.String? profilePicture,
    $core.bool? verified,
    $core.String? userUuid,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    if (username != null) result.username = username;
    if (firstName != null) result.firstName = firstName;
    if (lastName != null) result.lastName = lastName;
    if (displayName != null) result.displayName = displayName;
    if (profilePicture != null) result.profilePicture = profilePicture;
    if (verified != null) result.verified = verified;
    if (userUuid != null) result.userUuid = userUuid;
    return result;
  }

  UpliftUserMessage._();

  factory UpliftUserMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpliftUserMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpliftUserMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'userId', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(2, _omitFieldNames ? '' : 'username')
    ..aOS(3, _omitFieldNames ? '' : 'firstName')
    ..aOS(4, _omitFieldNames ? '' : 'lastName')
    ..aOS(5, _omitFieldNames ? '' : 'displayName')
    ..aOS(6, _omitFieldNames ? '' : 'profilePicture')
    ..aOB(7, _omitFieldNames ? '' : 'verified')
    ..aOS(8, _omitFieldNames ? '' : 'userUuid')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpliftUserMessage clone() => UpliftUserMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpliftUserMessage copyWith(void Function(UpliftUserMessage) updates) =>
      super.copyWith((message) => updates(message as UpliftUserMessage))
          as UpliftUserMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpliftUserMessage create() => UpliftUserMessage._();
  @$core.override
  UpliftUserMessage createEmptyInstance() => create();
  static $pb.PbList<UpliftUserMessage> createRepeated() =>
      $pb.PbList<UpliftUserMessage>();
  @$core.pragma('dart2js:noInline')
  static UpliftUserMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpliftUserMessage>(create);
  static UpliftUserMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get userId => $_getI64(0);
  @$pb.TagNumber(1)
  set userId($fixnum.Int64 value) => $_setInt64(0, value);
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
  $core.String get displayName => $_getSZ(4);
  @$pb.TagNumber(5)
  set displayName($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasDisplayName() => $_has(4);
  @$pb.TagNumber(5)
  void clearDisplayName() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get profilePicture => $_getSZ(5);
  @$pb.TagNumber(6)
  set profilePicture($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasProfilePicture() => $_has(5);
  @$pb.TagNumber(6)
  void clearProfilePicture() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.bool get verified => $_getBF(6);
  @$pb.TagNumber(7)
  set verified($core.bool value) => $_setBool(6, value);
  @$pb.TagNumber(7)
  $core.bool hasVerified() => $_has(6);
  @$pb.TagNumber(7)
  void clearVerified() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get userUuid => $_getSZ(7);
  @$pb.TagNumber(8)
  set userUuid($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasUserUuid() => $_has(7);
  @$pb.TagNumber(8)
  void clearUserUuid() => $_clearField(8);
}

class UpliftFundMessage extends $pb.GeneratedMessage {
  factory UpliftFundMessage({
    $core.String? id,
    $core.String? upliftCode,
    $fixnum.Int64? funderUserId,
    UpliftUserMessage? funder,
    $core.String? title,
    $core.String? description,
    $core.String? story,
    $core.String? category,
    $core.String? currency,
    $fixnum.Int64? perBusinessCap,
    $core.int? targetCount,
    $fixnum.Int64? committedPool,
    $fixnum.Int64? releasedTotal,
    $fixnum.Int64? refundedTotal,
    $core.String? escrowAccountId,
    UpliftFundStatus? status,
    UpliftFundVisibility? visibility,
    $core.String? coverImageUrl,
    $core.Iterable<$core.String>? gallery,
    $1.Timestamp? applicationDeadline,
    $1.Timestamp? fundingDeadline,
    $core.int? applicationCount,
    $core.int? selectedCount,
    $core.int? endorsementCount,
    $core.String? metadata,
    $1.Timestamp? createdAt,
    $1.Timestamp? updatedAt,
    $core.String? cancelReason,
    $1.Timestamp? cancelledAt,
    $fixnum.Int64? escrowAvailable,
    $core.bool? isFunder,
    $core.String? myApplicationId,
    UpliftApplicationStatus? myApplicationStatus,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (upliftCode != null) result.upliftCode = upliftCode;
    if (funderUserId != null) result.funderUserId = funderUserId;
    if (funder != null) result.funder = funder;
    if (title != null) result.title = title;
    if (description != null) result.description = description;
    if (story != null) result.story = story;
    if (category != null) result.category = category;
    if (currency != null) result.currency = currency;
    if (perBusinessCap != null) result.perBusinessCap = perBusinessCap;
    if (targetCount != null) result.targetCount = targetCount;
    if (committedPool != null) result.committedPool = committedPool;
    if (releasedTotal != null) result.releasedTotal = releasedTotal;
    if (refundedTotal != null) result.refundedTotal = refundedTotal;
    if (escrowAccountId != null) result.escrowAccountId = escrowAccountId;
    if (status != null) result.status = status;
    if (visibility != null) result.visibility = visibility;
    if (coverImageUrl != null) result.coverImageUrl = coverImageUrl;
    if (gallery != null) result.gallery.addAll(gallery);
    if (applicationDeadline != null)
      result.applicationDeadline = applicationDeadline;
    if (fundingDeadline != null) result.fundingDeadline = fundingDeadline;
    if (applicationCount != null) result.applicationCount = applicationCount;
    if (selectedCount != null) result.selectedCount = selectedCount;
    if (endorsementCount != null) result.endorsementCount = endorsementCount;
    if (metadata != null) result.metadata = metadata;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    if (cancelReason != null) result.cancelReason = cancelReason;
    if (cancelledAt != null) result.cancelledAt = cancelledAt;
    if (escrowAvailable != null) result.escrowAvailable = escrowAvailable;
    if (isFunder != null) result.isFunder = isFunder;
    if (myApplicationId != null) result.myApplicationId = myApplicationId;
    if (myApplicationStatus != null)
      result.myApplicationStatus = myApplicationStatus;
    return result;
  }

  UpliftFundMessage._();

  factory UpliftFundMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpliftFundMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpliftFundMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'upliftCode')
    ..a<$fixnum.Int64>(
        3, _omitFieldNames ? '' : 'funderUserId', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<UpliftUserMessage>(4, _omitFieldNames ? '' : 'funder',
        subBuilder: UpliftUserMessage.create)
    ..aOS(5, _omitFieldNames ? '' : 'title')
    ..aOS(6, _omitFieldNames ? '' : 'description')
    ..aOS(7, _omitFieldNames ? '' : 'story')
    ..aOS(8, _omitFieldNames ? '' : 'category')
    ..aOS(9, _omitFieldNames ? '' : 'currency')
    ..a<$fixnum.Int64>(
        10, _omitFieldNames ? '' : 'perBusinessCap', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(11, _omitFieldNames ? '' : 'targetCount', $pb.PbFieldType.O3)
    ..a<$fixnum.Int64>(
        12, _omitFieldNames ? '' : 'committedPool', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(
        13, _omitFieldNames ? '' : 'releasedTotal', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(
        14, _omitFieldNames ? '' : 'refundedTotal', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(15, _omitFieldNames ? '' : 'escrowAccountId')
    ..e<UpliftFundStatus>(
        16, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: UpliftFundStatus.UPLIFT_FUND_STATUS_UNSPECIFIED,
        valueOf: UpliftFundStatus.valueOf,
        enumValues: UpliftFundStatus.values)
    ..e<UpliftFundVisibility>(
        17, _omitFieldNames ? '' : 'visibility', $pb.PbFieldType.OE,
        defaultOrMaker: UpliftFundVisibility.UPLIFT_FUND_VISIBILITY_UNSPECIFIED,
        valueOf: UpliftFundVisibility.valueOf,
        enumValues: UpliftFundVisibility.values)
    ..aOS(18, _omitFieldNames ? '' : 'coverImageUrl')
    ..pPS(19, _omitFieldNames ? '' : 'gallery')
    ..aOM<$1.Timestamp>(20, _omitFieldNames ? '' : 'applicationDeadline',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(21, _omitFieldNames ? '' : 'fundingDeadline',
        subBuilder: $1.Timestamp.create)
    ..a<$core.int>(
        22, _omitFieldNames ? '' : 'applicationCount', $pb.PbFieldType.O3)
    ..a<$core.int>(
        23, _omitFieldNames ? '' : 'selectedCount', $pb.PbFieldType.O3)
    ..a<$core.int>(
        24, _omitFieldNames ? '' : 'endorsementCount', $pb.PbFieldType.O3)
    ..aOS(25, _omitFieldNames ? '' : 'metadata')
    ..aOM<$1.Timestamp>(26, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(27, _omitFieldNames ? '' : 'updatedAt',
        subBuilder: $1.Timestamp.create)
    ..aOS(28, _omitFieldNames ? '' : 'cancelReason')
    ..aOM<$1.Timestamp>(29, _omitFieldNames ? '' : 'cancelledAt',
        subBuilder: $1.Timestamp.create)
    ..a<$fixnum.Int64>(
        30, _omitFieldNames ? '' : 'escrowAvailable', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOB(31, _omitFieldNames ? '' : 'isFunder')
    ..aOS(32, _omitFieldNames ? '' : 'myApplicationId')
    ..e<UpliftApplicationStatus>(
        33, _omitFieldNames ? '' : 'myApplicationStatus', $pb.PbFieldType.OE,
        defaultOrMaker:
            UpliftApplicationStatus.UPLIFT_APPLICATION_STATUS_UNSPECIFIED,
        valueOf: UpliftApplicationStatus.valueOf,
        enumValues: UpliftApplicationStatus.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpliftFundMessage clone() => UpliftFundMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpliftFundMessage copyWith(void Function(UpliftFundMessage) updates) =>
      super.copyWith((message) => updates(message as UpliftFundMessage))
          as UpliftFundMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpliftFundMessage create() => UpliftFundMessage._();
  @$core.override
  UpliftFundMessage createEmptyInstance() => create();
  static $pb.PbList<UpliftFundMessage> createRepeated() =>
      $pb.PbList<UpliftFundMessage>();
  @$core.pragma('dart2js:noInline')
  static UpliftFundMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpliftFundMessage>(create);
  static UpliftFundMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get upliftCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set upliftCode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUpliftCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearUpliftCode() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get funderUserId => $_getI64(2);
  @$pb.TagNumber(3)
  set funderUserId($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasFunderUserId() => $_has(2);
  @$pb.TagNumber(3)
  void clearFunderUserId() => $_clearField(3);

  @$pb.TagNumber(4)
  UpliftUserMessage get funder => $_getN(3);
  @$pb.TagNumber(4)
  set funder(UpliftUserMessage value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasFunder() => $_has(3);
  @$pb.TagNumber(4)
  void clearFunder() => $_clearField(4);
  @$pb.TagNumber(4)
  UpliftUserMessage ensureFunder() => $_ensure(3);

  @$pb.TagNumber(5)
  $core.String get title => $_getSZ(4);
  @$pb.TagNumber(5)
  set title($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTitle() => $_has(4);
  @$pb.TagNumber(5)
  void clearTitle() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get description => $_getSZ(5);
  @$pb.TagNumber(6)
  set description($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasDescription() => $_has(5);
  @$pb.TagNumber(6)
  void clearDescription() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get story => $_getSZ(6);
  @$pb.TagNumber(7)
  set story($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasStory() => $_has(6);
  @$pb.TagNumber(7)
  void clearStory() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get category => $_getSZ(7);
  @$pb.TagNumber(8)
  set category($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasCategory() => $_has(7);
  @$pb.TagNumber(8)
  void clearCategory() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get currency => $_getSZ(8);
  @$pb.TagNumber(9)
  set currency($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasCurrency() => $_has(8);
  @$pb.TagNumber(9)
  void clearCurrency() => $_clearField(9);

  @$pb.TagNumber(10)
  $fixnum.Int64 get perBusinessCap => $_getI64(9);
  @$pb.TagNumber(10)
  set perBusinessCap($fixnum.Int64 value) => $_setInt64(9, value);
  @$pb.TagNumber(10)
  $core.bool hasPerBusinessCap() => $_has(9);
  @$pb.TagNumber(10)
  void clearPerBusinessCap() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.int get targetCount => $_getIZ(10);
  @$pb.TagNumber(11)
  set targetCount($core.int value) => $_setSignedInt32(10, value);
  @$pb.TagNumber(11)
  $core.bool hasTargetCount() => $_has(10);
  @$pb.TagNumber(11)
  void clearTargetCount() => $_clearField(11);

  @$pb.TagNumber(12)
  $fixnum.Int64 get committedPool => $_getI64(11);
  @$pb.TagNumber(12)
  set committedPool($fixnum.Int64 value) => $_setInt64(11, value);
  @$pb.TagNumber(12)
  $core.bool hasCommittedPool() => $_has(11);
  @$pb.TagNumber(12)
  void clearCommittedPool() => $_clearField(12);

  @$pb.TagNumber(13)
  $fixnum.Int64 get releasedTotal => $_getI64(12);
  @$pb.TagNumber(13)
  set releasedTotal($fixnum.Int64 value) => $_setInt64(12, value);
  @$pb.TagNumber(13)
  $core.bool hasReleasedTotal() => $_has(12);
  @$pb.TagNumber(13)
  void clearReleasedTotal() => $_clearField(13);

  @$pb.TagNumber(14)
  $fixnum.Int64 get refundedTotal => $_getI64(13);
  @$pb.TagNumber(14)
  set refundedTotal($fixnum.Int64 value) => $_setInt64(13, value);
  @$pb.TagNumber(14)
  $core.bool hasRefundedTotal() => $_has(13);
  @$pb.TagNumber(14)
  void clearRefundedTotal() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.String get escrowAccountId => $_getSZ(14);
  @$pb.TagNumber(15)
  set escrowAccountId($core.String value) => $_setString(14, value);
  @$pb.TagNumber(15)
  $core.bool hasEscrowAccountId() => $_has(14);
  @$pb.TagNumber(15)
  void clearEscrowAccountId() => $_clearField(15);

  @$pb.TagNumber(16)
  UpliftFundStatus get status => $_getN(15);
  @$pb.TagNumber(16)
  set status(UpliftFundStatus value) => $_setField(16, value);
  @$pb.TagNumber(16)
  $core.bool hasStatus() => $_has(15);
  @$pb.TagNumber(16)
  void clearStatus() => $_clearField(16);

  @$pb.TagNumber(17)
  UpliftFundVisibility get visibility => $_getN(16);
  @$pb.TagNumber(17)
  set visibility(UpliftFundVisibility value) => $_setField(17, value);
  @$pb.TagNumber(17)
  $core.bool hasVisibility() => $_has(16);
  @$pb.TagNumber(17)
  void clearVisibility() => $_clearField(17);

  @$pb.TagNumber(18)
  $core.String get coverImageUrl => $_getSZ(17);
  @$pb.TagNumber(18)
  set coverImageUrl($core.String value) => $_setString(17, value);
  @$pb.TagNumber(18)
  $core.bool hasCoverImageUrl() => $_has(17);
  @$pb.TagNumber(18)
  void clearCoverImageUrl() => $_clearField(18);

  @$pb.TagNumber(19)
  $pb.PbList<$core.String> get gallery => $_getList(18);

  @$pb.TagNumber(20)
  $1.Timestamp get applicationDeadline => $_getN(19);
  @$pb.TagNumber(20)
  set applicationDeadline($1.Timestamp value) => $_setField(20, value);
  @$pb.TagNumber(20)
  $core.bool hasApplicationDeadline() => $_has(19);
  @$pb.TagNumber(20)
  void clearApplicationDeadline() => $_clearField(20);
  @$pb.TagNumber(20)
  $1.Timestamp ensureApplicationDeadline() => $_ensure(19);

  @$pb.TagNumber(21)
  $1.Timestamp get fundingDeadline => $_getN(20);
  @$pb.TagNumber(21)
  set fundingDeadline($1.Timestamp value) => $_setField(21, value);
  @$pb.TagNumber(21)
  $core.bool hasFundingDeadline() => $_has(20);
  @$pb.TagNumber(21)
  void clearFundingDeadline() => $_clearField(21);
  @$pb.TagNumber(21)
  $1.Timestamp ensureFundingDeadline() => $_ensure(20);

  @$pb.TagNumber(22)
  $core.int get applicationCount => $_getIZ(21);
  @$pb.TagNumber(22)
  set applicationCount($core.int value) => $_setSignedInt32(21, value);
  @$pb.TagNumber(22)
  $core.bool hasApplicationCount() => $_has(21);
  @$pb.TagNumber(22)
  void clearApplicationCount() => $_clearField(22);

  @$pb.TagNumber(23)
  $core.int get selectedCount => $_getIZ(22);
  @$pb.TagNumber(23)
  set selectedCount($core.int value) => $_setSignedInt32(22, value);
  @$pb.TagNumber(23)
  $core.bool hasSelectedCount() => $_has(22);
  @$pb.TagNumber(23)
  void clearSelectedCount() => $_clearField(23);

  @$pb.TagNumber(24)
  $core.int get endorsementCount => $_getIZ(23);
  @$pb.TagNumber(24)
  set endorsementCount($core.int value) => $_setSignedInt32(23, value);
  @$pb.TagNumber(24)
  $core.bool hasEndorsementCount() => $_has(23);
  @$pb.TagNumber(24)
  void clearEndorsementCount() => $_clearField(24);

  @$pb.TagNumber(25)
  $core.String get metadata => $_getSZ(24);
  @$pb.TagNumber(25)
  set metadata($core.String value) => $_setString(24, value);
  @$pb.TagNumber(25)
  $core.bool hasMetadata() => $_has(24);
  @$pb.TagNumber(25)
  void clearMetadata() => $_clearField(25);

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

  /// Cancellation context
  @$pb.TagNumber(28)
  $core.String get cancelReason => $_getSZ(27);
  @$pb.TagNumber(28)
  set cancelReason($core.String value) => $_setString(27, value);
  @$pb.TagNumber(28)
  $core.bool hasCancelReason() => $_has(27);
  @$pb.TagNumber(28)
  void clearCancelReason() => $_clearField(28);

  @$pb.TagNumber(29)
  $1.Timestamp get cancelledAt => $_getN(28);
  @$pb.TagNumber(29)
  set cancelledAt($1.Timestamp value) => $_setField(29, value);
  @$pb.TagNumber(29)
  $core.bool hasCancelledAt() => $_has(28);
  @$pb.TagNumber(29)
  void clearCancelledAt() => $_clearField(29);
  @$pb.TagNumber(29)
  $1.Timestamp ensureCancelledAt() => $_ensure(28);

  /// Escrow available (committed - released - refunded - allocated-to-offers)
  @$pb.TagNumber(30)
  $fixnum.Int64 get escrowAvailable => $_getI64(29);
  @$pb.TagNumber(30)
  set escrowAvailable($fixnum.Int64 value) => $_setInt64(29, value);
  @$pb.TagNumber(30)
  $core.bool hasEscrowAvailable() => $_has(29);
  @$pb.TagNumber(30)
  void clearEscrowAvailable() => $_clearField(30);

  /// Convenience for the current caller's relationship to this fund
  @$pb.TagNumber(31)
  $core.bool get isFunder => $_getBF(30);
  @$pb.TagNumber(31)
  set isFunder($core.bool value) => $_setBool(30, value);
  @$pb.TagNumber(31)
  $core.bool hasIsFunder() => $_has(30);
  @$pb.TagNumber(31)
  void clearIsFunder() => $_clearField(31);

  @$pb.TagNumber(32)
  $core.String get myApplicationId => $_getSZ(31);
  @$pb.TagNumber(32)
  set myApplicationId($core.String value) => $_setString(31, value);
  @$pb.TagNumber(32)
  $core.bool hasMyApplicationId() => $_has(31);
  @$pb.TagNumber(32)
  void clearMyApplicationId() => $_clearField(32);

  @$pb.TagNumber(33)
  UpliftApplicationStatus get myApplicationStatus => $_getN(32);
  @$pb.TagNumber(33)
  set myApplicationStatus(UpliftApplicationStatus value) =>
      $_setField(33, value);
  @$pb.TagNumber(33)
  $core.bool hasMyApplicationStatus() => $_has(32);
  @$pb.TagNumber(33)
  void clearMyApplicationStatus() => $_clearField(33);
}

class UpliftApplicationMessage extends $pb.GeneratedMessage {
  factory UpliftApplicationMessage({
    $core.String? id,
    $core.String? fundId,
    $fixnum.Int64? applicantUserId,
    UpliftUserMessage? applicant,
    $core.String? businessName,
    $core.String? businessCategory,
    $core.String? pitch,
    $fixnum.Int64? requestedAmount,
    $fixnum.Int64? approvedAmount,
    UpliftApplicationStatus? status,
    $core.Iterable<$core.String>? images,
    $core.Iterable<$core.String>? docUrls,
    $core.int? endorsementCount,
    $core.bool? viewerHasEndorsed,
    $core.String? businessAccountId,
    $1.Timestamp? offerExpiresAt,
    $core.String? rejectReason,
    $core.Iterable<UpliftMilestoneMessage>? milestones,
    $1.Timestamp? createdAt,
    $1.Timestamp? updatedAt,
    $core.String? fundTitle,
    $core.String? currency,
    $core.int? proposedEquityPct,
    $core.int? agreedEquityPct,
    $core.String? equityNote,
    $core.String? investmentType,
    $fixnum.Int64? counterAmount,
    $core.int? counterEquityPct,
    $core.String? counterNote,
    $core.bool? hasCounter,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (fundId != null) result.fundId = fundId;
    if (applicantUserId != null) result.applicantUserId = applicantUserId;
    if (applicant != null) result.applicant = applicant;
    if (businessName != null) result.businessName = businessName;
    if (businessCategory != null) result.businessCategory = businessCategory;
    if (pitch != null) result.pitch = pitch;
    if (requestedAmount != null) result.requestedAmount = requestedAmount;
    if (approvedAmount != null) result.approvedAmount = approvedAmount;
    if (status != null) result.status = status;
    if (images != null) result.images.addAll(images);
    if (docUrls != null) result.docUrls.addAll(docUrls);
    if (endorsementCount != null) result.endorsementCount = endorsementCount;
    if (viewerHasEndorsed != null) result.viewerHasEndorsed = viewerHasEndorsed;
    if (businessAccountId != null) result.businessAccountId = businessAccountId;
    if (offerExpiresAt != null) result.offerExpiresAt = offerExpiresAt;
    if (rejectReason != null) result.rejectReason = rejectReason;
    if (milestones != null) result.milestones.addAll(milestones);
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    if (fundTitle != null) result.fundTitle = fundTitle;
    if (currency != null) result.currency = currency;
    if (proposedEquityPct != null) result.proposedEquityPct = proposedEquityPct;
    if (agreedEquityPct != null) result.agreedEquityPct = agreedEquityPct;
    if (equityNote != null) result.equityNote = equityNote;
    if (investmentType != null) result.investmentType = investmentType;
    if (counterAmount != null) result.counterAmount = counterAmount;
    if (counterEquityPct != null) result.counterEquityPct = counterEquityPct;
    if (counterNote != null) result.counterNote = counterNote;
    if (hasCounter != null) result.hasCounter = hasCounter;
    return result;
  }

  UpliftApplicationMessage._();

  factory UpliftApplicationMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpliftApplicationMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpliftApplicationMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'fundId')
    ..a<$fixnum.Int64>(
        3, _omitFieldNames ? '' : 'applicantUserId', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<UpliftUserMessage>(4, _omitFieldNames ? '' : 'applicant',
        subBuilder: UpliftUserMessage.create)
    ..aOS(5, _omitFieldNames ? '' : 'businessName')
    ..aOS(6, _omitFieldNames ? '' : 'businessCategory')
    ..aOS(7, _omitFieldNames ? '' : 'pitch')
    ..a<$fixnum.Int64>(
        8, _omitFieldNames ? '' : 'requestedAmount', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(
        9, _omitFieldNames ? '' : 'approvedAmount', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..e<UpliftApplicationStatus>(
        10, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker:
            UpliftApplicationStatus.UPLIFT_APPLICATION_STATUS_UNSPECIFIED,
        valueOf: UpliftApplicationStatus.valueOf,
        enumValues: UpliftApplicationStatus.values)
    ..pPS(11, _omitFieldNames ? '' : 'images')
    ..pPS(12, _omitFieldNames ? '' : 'docUrls')
    ..a<$core.int>(
        13, _omitFieldNames ? '' : 'endorsementCount', $pb.PbFieldType.O3)
    ..aOB(14, _omitFieldNames ? '' : 'viewerHasEndorsed')
    ..aOS(15, _omitFieldNames ? '' : 'businessAccountId')
    ..aOM<$1.Timestamp>(16, _omitFieldNames ? '' : 'offerExpiresAt',
        subBuilder: $1.Timestamp.create)
    ..aOS(17, _omitFieldNames ? '' : 'rejectReason')
    ..pc<UpliftMilestoneMessage>(
        18, _omitFieldNames ? '' : 'milestones', $pb.PbFieldType.PM,
        subBuilder: UpliftMilestoneMessage.create)
    ..aOM<$1.Timestamp>(19, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(20, _omitFieldNames ? '' : 'updatedAt',
        subBuilder: $1.Timestamp.create)
    ..aOS(21, _omitFieldNames ? '' : 'fundTitle')
    ..aOS(22, _omitFieldNames ? '' : 'currency')
    ..a<$core.int>(
        23, _omitFieldNames ? '' : 'proposedEquityPct', $pb.PbFieldType.OU3)
    ..a<$core.int>(
        24, _omitFieldNames ? '' : 'agreedEquityPct', $pb.PbFieldType.OU3)
    ..aOS(25, _omitFieldNames ? '' : 'equityNote')
    ..aOS(26, _omitFieldNames ? '' : 'investmentType')
    ..a<$fixnum.Int64>(
        27, _omitFieldNames ? '' : 'counterAmount', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(
        28, _omitFieldNames ? '' : 'counterEquityPct', $pb.PbFieldType.OU3)
    ..aOS(29, _omitFieldNames ? '' : 'counterNote')
    ..aOB(30, _omitFieldNames ? '' : 'hasCounter')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpliftApplicationMessage clone() =>
      UpliftApplicationMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpliftApplicationMessage copyWith(
          void Function(UpliftApplicationMessage) updates) =>
      super.copyWith((message) => updates(message as UpliftApplicationMessage))
          as UpliftApplicationMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpliftApplicationMessage create() => UpliftApplicationMessage._();
  @$core.override
  UpliftApplicationMessage createEmptyInstance() => create();
  static $pb.PbList<UpliftApplicationMessage> createRepeated() =>
      $pb.PbList<UpliftApplicationMessage>();
  @$core.pragma('dart2js:noInline')
  static UpliftApplicationMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpliftApplicationMessage>(create);
  static UpliftApplicationMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get fundId => $_getSZ(1);
  @$pb.TagNumber(2)
  set fundId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasFundId() => $_has(1);
  @$pb.TagNumber(2)
  void clearFundId() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get applicantUserId => $_getI64(2);
  @$pb.TagNumber(3)
  set applicantUserId($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasApplicantUserId() => $_has(2);
  @$pb.TagNumber(3)
  void clearApplicantUserId() => $_clearField(3);

  @$pb.TagNumber(4)
  UpliftUserMessage get applicant => $_getN(3);
  @$pb.TagNumber(4)
  set applicant(UpliftUserMessage value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasApplicant() => $_has(3);
  @$pb.TagNumber(4)
  void clearApplicant() => $_clearField(4);
  @$pb.TagNumber(4)
  UpliftUserMessage ensureApplicant() => $_ensure(3);

  @$pb.TagNumber(5)
  $core.String get businessName => $_getSZ(4);
  @$pb.TagNumber(5)
  set businessName($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasBusinessName() => $_has(4);
  @$pb.TagNumber(5)
  void clearBusinessName() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get businessCategory => $_getSZ(5);
  @$pb.TagNumber(6)
  set businessCategory($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasBusinessCategory() => $_has(5);
  @$pb.TagNumber(6)
  void clearBusinessCategory() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get pitch => $_getSZ(6);
  @$pb.TagNumber(7)
  set pitch($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasPitch() => $_has(6);
  @$pb.TagNumber(7)
  void clearPitch() => $_clearField(7);

  @$pb.TagNumber(8)
  $fixnum.Int64 get requestedAmount => $_getI64(7);
  @$pb.TagNumber(8)
  set requestedAmount($fixnum.Int64 value) => $_setInt64(7, value);
  @$pb.TagNumber(8)
  $core.bool hasRequestedAmount() => $_has(7);
  @$pb.TagNumber(8)
  void clearRequestedAmount() => $_clearField(8);

  @$pb.TagNumber(9)
  $fixnum.Int64 get approvedAmount => $_getI64(8);
  @$pb.TagNumber(9)
  set approvedAmount($fixnum.Int64 value) => $_setInt64(8, value);
  @$pb.TagNumber(9)
  $core.bool hasApprovedAmount() => $_has(8);
  @$pb.TagNumber(9)
  void clearApprovedAmount() => $_clearField(9);

  @$pb.TagNumber(10)
  UpliftApplicationStatus get status => $_getN(9);
  @$pb.TagNumber(10)
  set status(UpliftApplicationStatus value) => $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasStatus() => $_has(9);
  @$pb.TagNumber(10)
  void clearStatus() => $_clearField(10);

  @$pb.TagNumber(11)
  $pb.PbList<$core.String> get images => $_getList(10);

  @$pb.TagNumber(12)
  $pb.PbList<$core.String> get docUrls => $_getList(11);

  @$pb.TagNumber(13)
  $core.int get endorsementCount => $_getIZ(12);
  @$pb.TagNumber(13)
  set endorsementCount($core.int value) => $_setSignedInt32(12, value);
  @$pb.TagNumber(13)
  $core.bool hasEndorsementCount() => $_has(12);
  @$pb.TagNumber(13)
  void clearEndorsementCount() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.bool get viewerHasEndorsed => $_getBF(13);
  @$pb.TagNumber(14)
  set viewerHasEndorsed($core.bool value) => $_setBool(13, value);
  @$pb.TagNumber(14)
  $core.bool hasViewerHasEndorsed() => $_has(13);
  @$pb.TagNumber(14)
  void clearViewerHasEndorsed() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.String get businessAccountId => $_getSZ(14);
  @$pb.TagNumber(15)
  set businessAccountId($core.String value) => $_setString(14, value);
  @$pb.TagNumber(15)
  $core.bool hasBusinessAccountId() => $_has(14);
  @$pb.TagNumber(15)
  void clearBusinessAccountId() => $_clearField(15);

  @$pb.TagNumber(16)
  $1.Timestamp get offerExpiresAt => $_getN(15);
  @$pb.TagNumber(16)
  set offerExpiresAt($1.Timestamp value) => $_setField(16, value);
  @$pb.TagNumber(16)
  $core.bool hasOfferExpiresAt() => $_has(15);
  @$pb.TagNumber(16)
  void clearOfferExpiresAt() => $_clearField(16);
  @$pb.TagNumber(16)
  $1.Timestamp ensureOfferExpiresAt() => $_ensure(15);

  @$pb.TagNumber(17)
  $core.String get rejectReason => $_getSZ(16);
  @$pb.TagNumber(17)
  set rejectReason($core.String value) => $_setString(16, value);
  @$pb.TagNumber(17)
  $core.bool hasRejectReason() => $_has(16);
  @$pb.TagNumber(17)
  void clearRejectReason() => $_clearField(17);

  @$pb.TagNumber(18)
  $pb.PbList<UpliftMilestoneMessage> get milestones => $_getList(17);

  @$pb.TagNumber(19)
  $1.Timestamp get createdAt => $_getN(18);
  @$pb.TagNumber(19)
  set createdAt($1.Timestamp value) => $_setField(19, value);
  @$pb.TagNumber(19)
  $core.bool hasCreatedAt() => $_has(18);
  @$pb.TagNumber(19)
  void clearCreatedAt() => $_clearField(19);
  @$pb.TagNumber(19)
  $1.Timestamp ensureCreatedAt() => $_ensure(18);

  @$pb.TagNumber(20)
  $1.Timestamp get updatedAt => $_getN(19);
  @$pb.TagNumber(20)
  set updatedAt($1.Timestamp value) => $_setField(20, value);
  @$pb.TagNumber(20)
  $core.bool hasUpdatedAt() => $_has(19);
  @$pb.TagNumber(20)
  void clearUpdatedAt() => $_clearField(20);
  @$pb.TagNumber(20)
  $1.Timestamp ensureUpdatedAt() => $_ensure(19);

  /// Denormalized fund context for list rendering
  @$pb.TagNumber(21)
  $core.String get fundTitle => $_getSZ(20);
  @$pb.TagNumber(21)
  set fundTitle($core.String value) => $_setString(20, value);
  @$pb.TagNumber(21)
  $core.bool hasFundTitle() => $_has(20);
  @$pb.TagNumber(21)
  void clearFundTitle() => $_clearField(21);

  @$pb.TagNumber(22)
  $core.String get currency => $_getSZ(21);
  @$pb.TagNumber(22)
  set currency($core.String value) => $_setString(21, value);
  @$pb.TagNumber(22)
  $core.bool hasCurrency() => $_has(21);
  @$pb.TagNumber(22)
  void clearCurrency() => $_clearField(22);

  @$pb.TagNumber(23)
  $core.int get proposedEquityPct => $_getIZ(22);
  @$pb.TagNumber(23)
  set proposedEquityPct($core.int value) => $_setUnsignedInt32(22, value);
  @$pb.TagNumber(23)
  $core.bool hasProposedEquityPct() => $_has(22);
  @$pb.TagNumber(23)
  void clearProposedEquityPct() => $_clearField(23);

  @$pb.TagNumber(24)
  $core.int get agreedEquityPct => $_getIZ(23);
  @$pb.TagNumber(24)
  set agreedEquityPct($core.int value) => $_setUnsignedInt32(23, value);
  @$pb.TagNumber(24)
  $core.bool hasAgreedEquityPct() => $_has(23);
  @$pb.TagNumber(24)
  void clearAgreedEquityPct() => $_clearField(24);

  @$pb.TagNumber(25)
  $core.String get equityNote => $_getSZ(24);
  @$pb.TagNumber(25)
  set equityNote($core.String value) => $_setString(24, value);
  @$pb.TagNumber(25)
  $core.bool hasEquityNote() => $_has(24);
  @$pb.TagNumber(25)
  void clearEquityNote() => $_clearField(25);

  @$pb.TagNumber(26)
  $core.String get investmentType => $_getSZ(25);
  @$pb.TagNumber(26)
  set investmentType($core.String value) => $_setString(25, value);
  @$pb.TagNumber(26)
  $core.bool hasInvestmentType() => $_has(25);
  @$pb.TagNumber(26)
  void clearInvestmentType() => $_clearField(26);

  @$pb.TagNumber(27)
  $fixnum.Int64 get counterAmount => $_getI64(26);
  @$pb.TagNumber(27)
  set counterAmount($fixnum.Int64 value) => $_setInt64(26, value);
  @$pb.TagNumber(27)
  $core.bool hasCounterAmount() => $_has(26);
  @$pb.TagNumber(27)
  void clearCounterAmount() => $_clearField(27);

  @$pb.TagNumber(28)
  $core.int get counterEquityPct => $_getIZ(27);
  @$pb.TagNumber(28)
  set counterEquityPct($core.int value) => $_setUnsignedInt32(27, value);
  @$pb.TagNumber(28)
  $core.bool hasCounterEquityPct() => $_has(27);
  @$pb.TagNumber(28)
  void clearCounterEquityPct() => $_clearField(28);

  @$pb.TagNumber(29)
  $core.String get counterNote => $_getSZ(28);
  @$pb.TagNumber(29)
  set counterNote($core.String value) => $_setString(28, value);
  @$pb.TagNumber(29)
  $core.bool hasCounterNote() => $_has(28);
  @$pb.TagNumber(29)
  void clearCounterNote() => $_clearField(29);

  @$pb.TagNumber(30)
  $core.bool get hasCounter => $_getBF(29);
  @$pb.TagNumber(30)
  set hasCounter($core.bool value) => $_setBool(29, value);
  @$pb.TagNumber(30)
  $core.bool hasHasCounter() => $_has(29);
  @$pb.TagNumber(30)
  void clearHasCounter() => $_clearField(30);
}

class UpliftMilestoneMessage extends $pb.GeneratedMessage {
  factory UpliftMilestoneMessage({
    $core.String? id,
    $core.String? applicationId,
    $core.String? fundId,
    $core.int? sequence,
    $core.String? title,
    $core.String? description,
    $fixnum.Int64? amount,
    UpliftMilestoneStatus? status,
    $core.Iterable<$core.String>? evidence,
    $core.String? evidenceNote,
    $core.String? rejectReason,
    $core.String? releaseId,
    $1.Timestamp? approvedAt,
    $1.Timestamp? releasedAt,
    $1.Timestamp? createdAt,
    $1.Timestamp? updatedAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (applicationId != null) result.applicationId = applicationId;
    if (fundId != null) result.fundId = fundId;
    if (sequence != null) result.sequence = sequence;
    if (title != null) result.title = title;
    if (description != null) result.description = description;
    if (amount != null) result.amount = amount;
    if (status != null) result.status = status;
    if (evidence != null) result.evidence.addAll(evidence);
    if (evidenceNote != null) result.evidenceNote = evidenceNote;
    if (rejectReason != null) result.rejectReason = rejectReason;
    if (releaseId != null) result.releaseId = releaseId;
    if (approvedAt != null) result.approvedAt = approvedAt;
    if (releasedAt != null) result.releasedAt = releasedAt;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    return result;
  }

  UpliftMilestoneMessage._();

  factory UpliftMilestoneMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpliftMilestoneMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpliftMilestoneMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'applicationId')
    ..aOS(3, _omitFieldNames ? '' : 'fundId')
    ..a<$core.int>(4, _omitFieldNames ? '' : 'sequence', $pb.PbFieldType.O3)
    ..aOS(5, _omitFieldNames ? '' : 'title')
    ..aOS(6, _omitFieldNames ? '' : 'description')
    ..a<$fixnum.Int64>(7, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..e<UpliftMilestoneStatus>(
        8, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker:
            UpliftMilestoneStatus.UPLIFT_MILESTONE_STATUS_UNSPECIFIED,
        valueOf: UpliftMilestoneStatus.valueOf,
        enumValues: UpliftMilestoneStatus.values)
    ..pPS(9, _omitFieldNames ? '' : 'evidence')
    ..aOS(10, _omitFieldNames ? '' : 'evidenceNote')
    ..aOS(11, _omitFieldNames ? '' : 'rejectReason')
    ..aOS(12, _omitFieldNames ? '' : 'releaseId')
    ..aOM<$1.Timestamp>(13, _omitFieldNames ? '' : 'approvedAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(14, _omitFieldNames ? '' : 'releasedAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(15, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(16, _omitFieldNames ? '' : 'updatedAt',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpliftMilestoneMessage clone() =>
      UpliftMilestoneMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpliftMilestoneMessage copyWith(
          void Function(UpliftMilestoneMessage) updates) =>
      super.copyWith((message) => updates(message as UpliftMilestoneMessage))
          as UpliftMilestoneMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpliftMilestoneMessage create() => UpliftMilestoneMessage._();
  @$core.override
  UpliftMilestoneMessage createEmptyInstance() => create();
  static $pb.PbList<UpliftMilestoneMessage> createRepeated() =>
      $pb.PbList<UpliftMilestoneMessage>();
  @$core.pragma('dart2js:noInline')
  static UpliftMilestoneMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpliftMilestoneMessage>(create);
  static UpliftMilestoneMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get applicationId => $_getSZ(1);
  @$pb.TagNumber(2)
  set applicationId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasApplicationId() => $_has(1);
  @$pb.TagNumber(2)
  void clearApplicationId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get fundId => $_getSZ(2);
  @$pb.TagNumber(3)
  set fundId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasFundId() => $_has(2);
  @$pb.TagNumber(3)
  void clearFundId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get sequence => $_getIZ(3);
  @$pb.TagNumber(4)
  set sequence($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasSequence() => $_has(3);
  @$pb.TagNumber(4)
  void clearSequence() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get title => $_getSZ(4);
  @$pb.TagNumber(5)
  set title($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTitle() => $_has(4);
  @$pb.TagNumber(5)
  void clearTitle() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get description => $_getSZ(5);
  @$pb.TagNumber(6)
  set description($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasDescription() => $_has(5);
  @$pb.TagNumber(6)
  void clearDescription() => $_clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get amount => $_getI64(6);
  @$pb.TagNumber(7)
  set amount($fixnum.Int64 value) => $_setInt64(6, value);
  @$pb.TagNumber(7)
  $core.bool hasAmount() => $_has(6);
  @$pb.TagNumber(7)
  void clearAmount() => $_clearField(7);

  @$pb.TagNumber(8)
  UpliftMilestoneStatus get status => $_getN(7);
  @$pb.TagNumber(8)
  set status(UpliftMilestoneStatus value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasStatus() => $_has(7);
  @$pb.TagNumber(8)
  void clearStatus() => $_clearField(8);

  @$pb.TagNumber(9)
  $pb.PbList<$core.String> get evidence => $_getList(8);

  @$pb.TagNumber(10)
  $core.String get evidenceNote => $_getSZ(9);
  @$pb.TagNumber(10)
  set evidenceNote($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasEvidenceNote() => $_has(9);
  @$pb.TagNumber(10)
  void clearEvidenceNote() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get rejectReason => $_getSZ(10);
  @$pb.TagNumber(11)
  set rejectReason($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasRejectReason() => $_has(10);
  @$pb.TagNumber(11)
  void clearRejectReason() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get releaseId => $_getSZ(11);
  @$pb.TagNumber(12)
  set releaseId($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasReleaseId() => $_has(11);
  @$pb.TagNumber(12)
  void clearReleaseId() => $_clearField(12);

  @$pb.TagNumber(13)
  $1.Timestamp get approvedAt => $_getN(12);
  @$pb.TagNumber(13)
  set approvedAt($1.Timestamp value) => $_setField(13, value);
  @$pb.TagNumber(13)
  $core.bool hasApprovedAt() => $_has(12);
  @$pb.TagNumber(13)
  void clearApprovedAt() => $_clearField(13);
  @$pb.TagNumber(13)
  $1.Timestamp ensureApprovedAt() => $_ensure(12);

  @$pb.TagNumber(14)
  $1.Timestamp get releasedAt => $_getN(13);
  @$pb.TagNumber(14)
  set releasedAt($1.Timestamp value) => $_setField(14, value);
  @$pb.TagNumber(14)
  $core.bool hasReleasedAt() => $_has(13);
  @$pb.TagNumber(14)
  void clearReleasedAt() => $_clearField(14);
  @$pb.TagNumber(14)
  $1.Timestamp ensureReleasedAt() => $_ensure(13);

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
  $1.Timestamp get updatedAt => $_getN(15);
  @$pb.TagNumber(16)
  set updatedAt($1.Timestamp value) => $_setField(16, value);
  @$pb.TagNumber(16)
  $core.bool hasUpdatedAt() => $_has(15);
  @$pb.TagNumber(16)
  void clearUpdatedAt() => $_clearField(16);
  @$pb.TagNumber(16)
  $1.Timestamp ensureUpdatedAt() => $_ensure(15);
}

class UpliftMilestoneReleaseRecord extends $pb.GeneratedMessage {
  factory UpliftMilestoneReleaseRecord({
    $core.String? id,
    $core.String? milestoneId,
    $core.String? applicationId,
    $core.String? fundId,
    $core.String? businessAccountId,
    $fixnum.Int64? amount,
    $core.String? status,
    $core.int? attemptCount,
    $core.String? lastError,
    $core.String? debitReference,
    $core.String? creditReference,
    $core.String? createdAt,
    $core.String? updatedAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (milestoneId != null) result.milestoneId = milestoneId;
    if (applicationId != null) result.applicationId = applicationId;
    if (fundId != null) result.fundId = fundId;
    if (businessAccountId != null) result.businessAccountId = businessAccountId;
    if (amount != null) result.amount = amount;
    if (status != null) result.status = status;
    if (attemptCount != null) result.attemptCount = attemptCount;
    if (lastError != null) result.lastError = lastError;
    if (debitReference != null) result.debitReference = debitReference;
    if (creditReference != null) result.creditReference = creditReference;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    return result;
  }

  UpliftMilestoneReleaseRecord._();

  factory UpliftMilestoneReleaseRecord.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpliftMilestoneReleaseRecord.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpliftMilestoneReleaseRecord',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'milestoneId')
    ..aOS(3, _omitFieldNames ? '' : 'applicationId')
    ..aOS(4, _omitFieldNames ? '' : 'fundId')
    ..aOS(5, _omitFieldNames ? '' : 'businessAccountId')
    ..a<$fixnum.Int64>(6, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(7, _omitFieldNames ? '' : 'status')
    ..a<$core.int>(8, _omitFieldNames ? '' : 'attemptCount', $pb.PbFieldType.O3)
    ..aOS(9, _omitFieldNames ? '' : 'lastError')
    ..aOS(10, _omitFieldNames ? '' : 'debitReference')
    ..aOS(11, _omitFieldNames ? '' : 'creditReference')
    ..aOS(12, _omitFieldNames ? '' : 'createdAt')
    ..aOS(13, _omitFieldNames ? '' : 'updatedAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpliftMilestoneReleaseRecord clone() =>
      UpliftMilestoneReleaseRecord()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpliftMilestoneReleaseRecord copyWith(
          void Function(UpliftMilestoneReleaseRecord) updates) =>
      super.copyWith(
              (message) => updates(message as UpliftMilestoneReleaseRecord))
          as UpliftMilestoneReleaseRecord;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpliftMilestoneReleaseRecord create() =>
      UpliftMilestoneReleaseRecord._();
  @$core.override
  UpliftMilestoneReleaseRecord createEmptyInstance() => create();
  static $pb.PbList<UpliftMilestoneReleaseRecord> createRepeated() =>
      $pb.PbList<UpliftMilestoneReleaseRecord>();
  @$core.pragma('dart2js:noInline')
  static UpliftMilestoneReleaseRecord getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpliftMilestoneReleaseRecord>(create);
  static UpliftMilestoneReleaseRecord? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get milestoneId => $_getSZ(1);
  @$pb.TagNumber(2)
  set milestoneId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMilestoneId() => $_has(1);
  @$pb.TagNumber(2)
  void clearMilestoneId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get applicationId => $_getSZ(2);
  @$pb.TagNumber(3)
  set applicationId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasApplicationId() => $_has(2);
  @$pb.TagNumber(3)
  void clearApplicationId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get fundId => $_getSZ(3);
  @$pb.TagNumber(4)
  set fundId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasFundId() => $_has(3);
  @$pb.TagNumber(4)
  void clearFundId() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get businessAccountId => $_getSZ(4);
  @$pb.TagNumber(5)
  set businessAccountId($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasBusinessAccountId() => $_has(4);
  @$pb.TagNumber(5)
  void clearBusinessAccountId() => $_clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get amount => $_getI64(5);
  @$pb.TagNumber(6)
  set amount($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasAmount() => $_has(5);
  @$pb.TagNumber(6)
  void clearAmount() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get status => $_getSZ(6);
  @$pb.TagNumber(7)
  set status($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasStatus() => $_has(6);
  @$pb.TagNumber(7)
  void clearStatus() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.int get attemptCount => $_getIZ(7);
  @$pb.TagNumber(8)
  set attemptCount($core.int value) => $_setSignedInt32(7, value);
  @$pb.TagNumber(8)
  $core.bool hasAttemptCount() => $_has(7);
  @$pb.TagNumber(8)
  void clearAttemptCount() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get lastError => $_getSZ(8);
  @$pb.TagNumber(9)
  set lastError($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasLastError() => $_has(8);
  @$pb.TagNumber(9)
  void clearLastError() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get debitReference => $_getSZ(9);
  @$pb.TagNumber(10)
  set debitReference($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasDebitReference() => $_has(9);
  @$pb.TagNumber(10)
  void clearDebitReference() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get creditReference => $_getSZ(10);
  @$pb.TagNumber(11)
  set creditReference($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasCreditReference() => $_has(10);
  @$pb.TagNumber(11)
  void clearCreditReference() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get createdAt => $_getSZ(11);
  @$pb.TagNumber(12)
  set createdAt($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasCreatedAt() => $_has(11);
  @$pb.TagNumber(12)
  void clearCreatedAt() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.String get updatedAt => $_getSZ(12);
  @$pb.TagNumber(13)
  set updatedAt($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasUpdatedAt() => $_has(12);
  @$pb.TagNumber(13)
  void clearUpdatedAt() => $_clearField(13);
}

class UpliftEscrowRefundRecord extends $pb.GeneratedMessage {
  factory UpliftEscrowRefundRecord({
    $core.String? id,
    $core.String? fundId,
    $fixnum.Int64? amount,
    $core.String? status,
    $core.int? attemptCount,
    $core.String? lastError,
    $core.String? reason,
    $core.String? createdAt,
    $core.String? updatedAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (fundId != null) result.fundId = fundId;
    if (amount != null) result.amount = amount;
    if (status != null) result.status = status;
    if (attemptCount != null) result.attemptCount = attemptCount;
    if (lastError != null) result.lastError = lastError;
    if (reason != null) result.reason = reason;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    return result;
  }

  UpliftEscrowRefundRecord._();

  factory UpliftEscrowRefundRecord.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpliftEscrowRefundRecord.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpliftEscrowRefundRecord',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'fundId')
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(4, _omitFieldNames ? '' : 'status')
    ..a<$core.int>(5, _omitFieldNames ? '' : 'attemptCount', $pb.PbFieldType.O3)
    ..aOS(6, _omitFieldNames ? '' : 'lastError')
    ..aOS(7, _omitFieldNames ? '' : 'reason')
    ..aOS(8, _omitFieldNames ? '' : 'createdAt')
    ..aOS(9, _omitFieldNames ? '' : 'updatedAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpliftEscrowRefundRecord clone() =>
      UpliftEscrowRefundRecord()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpliftEscrowRefundRecord copyWith(
          void Function(UpliftEscrowRefundRecord) updates) =>
      super.copyWith((message) => updates(message as UpliftEscrowRefundRecord))
          as UpliftEscrowRefundRecord;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpliftEscrowRefundRecord create() => UpliftEscrowRefundRecord._();
  @$core.override
  UpliftEscrowRefundRecord createEmptyInstance() => create();
  static $pb.PbList<UpliftEscrowRefundRecord> createRepeated() =>
      $pb.PbList<UpliftEscrowRefundRecord>();
  @$core.pragma('dart2js:noInline')
  static UpliftEscrowRefundRecord getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpliftEscrowRefundRecord>(create);
  static UpliftEscrowRefundRecord? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get fundId => $_getSZ(1);
  @$pb.TagNumber(2)
  set fundId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasFundId() => $_has(1);
  @$pb.TagNumber(2)
  void clearFundId() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get amount => $_getI64(2);
  @$pb.TagNumber(3)
  set amount($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get status => $_getSZ(3);
  @$pb.TagNumber(4)
  set status($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasStatus() => $_has(3);
  @$pb.TagNumber(4)
  void clearStatus() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get attemptCount => $_getIZ(4);
  @$pb.TagNumber(5)
  set attemptCount($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasAttemptCount() => $_has(4);
  @$pb.TagNumber(5)
  void clearAttemptCount() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get lastError => $_getSZ(5);
  @$pb.TagNumber(6)
  set lastError($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasLastError() => $_has(5);
  @$pb.TagNumber(6)
  void clearLastError() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get reason => $_getSZ(6);
  @$pb.TagNumber(7)
  set reason($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasReason() => $_has(6);
  @$pb.TagNumber(7)
  void clearReason() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get createdAt => $_getSZ(7);
  @$pb.TagNumber(8)
  set createdAt($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasCreatedAt() => $_has(7);
  @$pb.TagNumber(8)
  void clearCreatedAt() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get updatedAt => $_getSZ(8);
  @$pb.TagNumber(9)
  set updatedAt($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasUpdatedAt() => $_has(8);
  @$pb.TagNumber(9)
  void clearUpdatedAt() => $_clearField(9);
}

class UpliftReceiptMessage extends $pb.GeneratedMessage {
  factory UpliftReceiptMessage({
    $core.String? id,
    $core.String? referenceId,
    $core.String? referenceType,
    $core.String? fundId,
    $core.String? fundTitle,
    $fixnum.Int64? amount,
    $core.String? currency,
    $core.String? receiptNumber,
    $core.String? receiptData,
    $1.Timestamp? generatedAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (referenceId != null) result.referenceId = referenceId;
    if (referenceType != null) result.referenceType = referenceType;
    if (fundId != null) result.fundId = fundId;
    if (fundTitle != null) result.fundTitle = fundTitle;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    if (receiptNumber != null) result.receiptNumber = receiptNumber;
    if (receiptData != null) result.receiptData = receiptData;
    if (generatedAt != null) result.generatedAt = generatedAt;
    return result;
  }

  UpliftReceiptMessage._();

  factory UpliftReceiptMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpliftReceiptMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpliftReceiptMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'referenceId')
    ..aOS(3, _omitFieldNames ? '' : 'referenceType')
    ..aOS(4, _omitFieldNames ? '' : 'fundId')
    ..aOS(5, _omitFieldNames ? '' : 'fundTitle')
    ..a<$fixnum.Int64>(6, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(7, _omitFieldNames ? '' : 'currency')
    ..aOS(8, _omitFieldNames ? '' : 'receiptNumber')
    ..aOS(9, _omitFieldNames ? '' : 'receiptData')
    ..aOM<$1.Timestamp>(10, _omitFieldNames ? '' : 'generatedAt',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpliftReceiptMessage clone() =>
      UpliftReceiptMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpliftReceiptMessage copyWith(void Function(UpliftReceiptMessage) updates) =>
      super.copyWith((message) => updates(message as UpliftReceiptMessage))
          as UpliftReceiptMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpliftReceiptMessage create() => UpliftReceiptMessage._();
  @$core.override
  UpliftReceiptMessage createEmptyInstance() => create();
  static $pb.PbList<UpliftReceiptMessage> createRepeated() =>
      $pb.PbList<UpliftReceiptMessage>();
  @$core.pragma('dart2js:noInline')
  static UpliftReceiptMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpliftReceiptMessage>(create);
  static UpliftReceiptMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get referenceId => $_getSZ(1);
  @$pb.TagNumber(2)
  set referenceId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasReferenceId() => $_has(1);
  @$pb.TagNumber(2)
  void clearReferenceId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get referenceType => $_getSZ(2);
  @$pb.TagNumber(3)
  set referenceType($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasReferenceType() => $_has(2);
  @$pb.TagNumber(3)
  void clearReferenceType() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get fundId => $_getSZ(3);
  @$pb.TagNumber(4)
  set fundId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasFundId() => $_has(3);
  @$pb.TagNumber(4)
  void clearFundId() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get fundTitle => $_getSZ(4);
  @$pb.TagNumber(5)
  set fundTitle($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasFundTitle() => $_has(4);
  @$pb.TagNumber(5)
  void clearFundTitle() => $_clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get amount => $_getI64(5);
  @$pb.TagNumber(6)
  set amount($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasAmount() => $_has(5);
  @$pb.TagNumber(6)
  void clearAmount() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get currency => $_getSZ(6);
  @$pb.TagNumber(7)
  set currency($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasCurrency() => $_has(6);
  @$pb.TagNumber(7)
  void clearCurrency() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get receiptNumber => $_getSZ(7);
  @$pb.TagNumber(8)
  set receiptNumber($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasReceiptNumber() => $_has(7);
  @$pb.TagNumber(8)
  void clearReceiptNumber() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get receiptData => $_getSZ(8);
  @$pb.TagNumber(9)
  set receiptData($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasReceiptData() => $_has(8);
  @$pb.TagNumber(9)
  void clearReceiptData() => $_clearField(9);

  @$pb.TagNumber(10)
  $1.Timestamp get generatedAt => $_getN(9);
  @$pb.TagNumber(10)
  set generatedAt($1.Timestamp value) => $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasGeneratedAt() => $_has(9);
  @$pb.TagNumber(10)
  void clearGeneratedAt() => $_clearField(10);
  @$pb.TagNumber(10)
  $1.Timestamp ensureGeneratedAt() => $_ensure(9);
}

class UpliftPaginationInfo extends $pb.GeneratedMessage {
  factory UpliftPaginationInfo({
    $core.int? currentPage,
    $core.int? totalPages,
    $core.int? totalItems,
    $core.int? itemsPerPage,
    $core.bool? hasNext,
    $core.bool? hasPrev,
  }) {
    final result = create();
    if (currentPage != null) result.currentPage = currentPage;
    if (totalPages != null) result.totalPages = totalPages;
    if (totalItems != null) result.totalItems = totalItems;
    if (itemsPerPage != null) result.itemsPerPage = itemsPerPage;
    if (hasNext != null) result.hasNext = hasNext;
    if (hasPrev != null) result.hasPrev = hasPrev;
    return result;
  }

  UpliftPaginationInfo._();

  factory UpliftPaginationInfo.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpliftPaginationInfo.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpliftPaginationInfo',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'currentPage', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'totalPages', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'totalItems', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'itemsPerPage', $pb.PbFieldType.O3)
    ..aOB(5, _omitFieldNames ? '' : 'hasNext')
    ..aOB(6, _omitFieldNames ? '' : 'hasPrev')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpliftPaginationInfo clone() =>
      UpliftPaginationInfo()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpliftPaginationInfo copyWith(void Function(UpliftPaginationInfo) updates) =>
      super.copyWith((message) => updates(message as UpliftPaginationInfo))
          as UpliftPaginationInfo;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpliftPaginationInfo create() => UpliftPaginationInfo._();
  @$core.override
  UpliftPaginationInfo createEmptyInstance() => create();
  static $pb.PbList<UpliftPaginationInfo> createRepeated() =>
      $pb.PbList<UpliftPaginationInfo>();
  @$core.pragma('dart2js:noInline')
  static UpliftPaginationInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpliftPaginationInfo>(create);
  static UpliftPaginationInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get currentPage => $_getIZ(0);
  @$pb.TagNumber(1)
  set currentPage($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCurrentPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearCurrentPage() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get totalPages => $_getIZ(1);
  @$pb.TagNumber(2)
  set totalPages($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotalPages() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalPages() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get totalItems => $_getIZ(2);
  @$pb.TagNumber(3)
  set totalItems($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTotalItems() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalItems() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get itemsPerPage => $_getIZ(3);
  @$pb.TagNumber(4)
  set itemsPerPage($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasItemsPerPage() => $_has(3);
  @$pb.TagNumber(4)
  void clearItemsPerPage() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.bool get hasNext => $_getBF(4);
  @$pb.TagNumber(5)
  set hasNext($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasHasNext() => $_has(4);
  @$pb.TagNumber(5)
  void clearHasNext() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.bool get hasPrev => $_getBF(5);
  @$pb.TagNumber(6)
  set hasPrev($core.bool value) => $_setBool(5, value);
  @$pb.TagNumber(6)
  $core.bool hasHasPrev() => $_has(5);
  @$pb.TagNumber(6)
  void clearHasPrev() => $_clearField(6);
}

class CreateUpliftFundRequest extends $pb.GeneratedMessage {
  factory CreateUpliftFundRequest({
    $core.String? title,
    $core.String? description,
    $core.String? story,
    $core.String? category,
    $core.String? currency,
    $fixnum.Int64? perBusinessCap,
    $core.int? targetCount,
    $1.Timestamp? applicationDeadline,
    $1.Timestamp? fundingDeadline,
    $core.String? coverImageUrl,
    $core.Iterable<$core.String>? gallery,
    UpliftFundVisibility? visibility,
    $core.String? metadata,
    $core.bool? publishNow,
  }) {
    final result = create();
    if (title != null) result.title = title;
    if (description != null) result.description = description;
    if (story != null) result.story = story;
    if (category != null) result.category = category;
    if (currency != null) result.currency = currency;
    if (perBusinessCap != null) result.perBusinessCap = perBusinessCap;
    if (targetCount != null) result.targetCount = targetCount;
    if (applicationDeadline != null)
      result.applicationDeadline = applicationDeadline;
    if (fundingDeadline != null) result.fundingDeadline = fundingDeadline;
    if (coverImageUrl != null) result.coverImageUrl = coverImageUrl;
    if (gallery != null) result.gallery.addAll(gallery);
    if (visibility != null) result.visibility = visibility;
    if (metadata != null) result.metadata = metadata;
    if (publishNow != null) result.publishNow = publishNow;
    return result;
  }

  CreateUpliftFundRequest._();

  factory CreateUpliftFundRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateUpliftFundRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateUpliftFundRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'title')
    ..aOS(2, _omitFieldNames ? '' : 'description')
    ..aOS(3, _omitFieldNames ? '' : 'story')
    ..aOS(4, _omitFieldNames ? '' : 'category')
    ..aOS(5, _omitFieldNames ? '' : 'currency')
    ..a<$fixnum.Int64>(
        6, _omitFieldNames ? '' : 'perBusinessCap', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(7, _omitFieldNames ? '' : 'targetCount', $pb.PbFieldType.O3)
    ..aOM<$1.Timestamp>(8, _omitFieldNames ? '' : 'applicationDeadline',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(9, _omitFieldNames ? '' : 'fundingDeadline',
        subBuilder: $1.Timestamp.create)
    ..aOS(10, _omitFieldNames ? '' : 'coverImageUrl')
    ..pPS(11, _omitFieldNames ? '' : 'gallery')
    ..e<UpliftFundVisibility>(
        12, _omitFieldNames ? '' : 'visibility', $pb.PbFieldType.OE,
        defaultOrMaker: UpliftFundVisibility.UPLIFT_FUND_VISIBILITY_UNSPECIFIED,
        valueOf: UpliftFundVisibility.valueOf,
        enumValues: UpliftFundVisibility.values)
    ..aOS(13, _omitFieldNames ? '' : 'metadata')
    ..aOB(14, _omitFieldNames ? '' : 'publishNow')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateUpliftFundRequest clone() =>
      CreateUpliftFundRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateUpliftFundRequest copyWith(
          void Function(CreateUpliftFundRequest) updates) =>
      super.copyWith((message) => updates(message as CreateUpliftFundRequest))
          as CreateUpliftFundRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateUpliftFundRequest create() => CreateUpliftFundRequest._();
  @$core.override
  CreateUpliftFundRequest createEmptyInstance() => create();
  static $pb.PbList<CreateUpliftFundRequest> createRepeated() =>
      $pb.PbList<CreateUpliftFundRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateUpliftFundRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateUpliftFundRequest>(create);
  static CreateUpliftFundRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get title => $_getSZ(0);
  @$pb.TagNumber(1)
  set title($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTitle() => $_has(0);
  @$pb.TagNumber(1)
  void clearTitle() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get description => $_getSZ(1);
  @$pb.TagNumber(2)
  set description($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDescription() => $_has(1);
  @$pb.TagNumber(2)
  void clearDescription() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get story => $_getSZ(2);
  @$pb.TagNumber(3)
  set story($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasStory() => $_has(2);
  @$pb.TagNumber(3)
  void clearStory() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get category => $_getSZ(3);
  @$pb.TagNumber(4)
  set category($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCategory() => $_has(3);
  @$pb.TagNumber(4)
  void clearCategory() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get currency => $_getSZ(4);
  @$pb.TagNumber(5)
  set currency($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasCurrency() => $_has(4);
  @$pb.TagNumber(5)
  void clearCurrency() => $_clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get perBusinessCap => $_getI64(5);
  @$pb.TagNumber(6)
  set perBusinessCap($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasPerBusinessCap() => $_has(5);
  @$pb.TagNumber(6)
  void clearPerBusinessCap() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.int get targetCount => $_getIZ(6);
  @$pb.TagNumber(7)
  set targetCount($core.int value) => $_setSignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasTargetCount() => $_has(6);
  @$pb.TagNumber(7)
  void clearTargetCount() => $_clearField(7);

  @$pb.TagNumber(8)
  $1.Timestamp get applicationDeadline => $_getN(7);
  @$pb.TagNumber(8)
  set applicationDeadline($1.Timestamp value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasApplicationDeadline() => $_has(7);
  @$pb.TagNumber(8)
  void clearApplicationDeadline() => $_clearField(8);
  @$pb.TagNumber(8)
  $1.Timestamp ensureApplicationDeadline() => $_ensure(7);

  @$pb.TagNumber(9)
  $1.Timestamp get fundingDeadline => $_getN(8);
  @$pb.TagNumber(9)
  set fundingDeadline($1.Timestamp value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasFundingDeadline() => $_has(8);
  @$pb.TagNumber(9)
  void clearFundingDeadline() => $_clearField(9);
  @$pb.TagNumber(9)
  $1.Timestamp ensureFundingDeadline() => $_ensure(8);

  @$pb.TagNumber(10)
  $core.String get coverImageUrl => $_getSZ(9);
  @$pb.TagNumber(10)
  set coverImageUrl($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasCoverImageUrl() => $_has(9);
  @$pb.TagNumber(10)
  void clearCoverImageUrl() => $_clearField(10);

  @$pb.TagNumber(11)
  $pb.PbList<$core.String> get gallery => $_getList(10);

  @$pb.TagNumber(12)
  UpliftFundVisibility get visibility => $_getN(11);
  @$pb.TagNumber(12)
  set visibility(UpliftFundVisibility value) => $_setField(12, value);
  @$pb.TagNumber(12)
  $core.bool hasVisibility() => $_has(11);
  @$pb.TagNumber(12)
  void clearVisibility() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.String get metadata => $_getSZ(12);
  @$pb.TagNumber(13)
  set metadata($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasMetadata() => $_has(12);
  @$pb.TagNumber(13)
  void clearMetadata() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.bool get publishNow => $_getBF(13);
  @$pb.TagNumber(14)
  set publishNow($core.bool value) => $_setBool(13, value);
  @$pb.TagNumber(14)
  $core.bool hasPublishNow() => $_has(13);
  @$pb.TagNumber(14)
  void clearPublishNow() => $_clearField(14);
}

class CreateUpliftFundResponse extends $pb.GeneratedMessage {
  factory CreateUpliftFundResponse({
    UpliftFundMessage? fund,
  }) {
    final result = create();
    if (fund != null) result.fund = fund;
    return result;
  }

  CreateUpliftFundResponse._();

  factory CreateUpliftFundResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateUpliftFundResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateUpliftFundResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<UpliftFundMessage>(1, _omitFieldNames ? '' : 'fund',
        subBuilder: UpliftFundMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateUpliftFundResponse clone() =>
      CreateUpliftFundResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateUpliftFundResponse copyWith(
          void Function(CreateUpliftFundResponse) updates) =>
      super.copyWith((message) => updates(message as CreateUpliftFundResponse))
          as CreateUpliftFundResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateUpliftFundResponse create() => CreateUpliftFundResponse._();
  @$core.override
  CreateUpliftFundResponse createEmptyInstance() => create();
  static $pb.PbList<CreateUpliftFundResponse> createRepeated() =>
      $pb.PbList<CreateUpliftFundResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateUpliftFundResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateUpliftFundResponse>(create);
  static CreateUpliftFundResponse? _defaultInstance;

  @$pb.TagNumber(1)
  UpliftFundMessage get fund => $_getN(0);
  @$pb.TagNumber(1)
  set fund(UpliftFundMessage value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasFund() => $_has(0);
  @$pb.TagNumber(1)
  void clearFund() => $_clearField(1);
  @$pb.TagNumber(1)
  UpliftFundMessage ensureFund() => $_ensure(0);
}

class UpdateUpliftFundRequest extends $pb.GeneratedMessage {
  factory UpdateUpliftFundRequest({
    $core.String? fundId,
    $core.String? title,
    $core.String? description,
    $core.String? story,
    $core.String? category,
    $fixnum.Int64? perBusinessCap,
    $core.int? targetCount,
    $1.Timestamp? applicationDeadline,
    $1.Timestamp? fundingDeadline,
    $core.String? coverImageUrl,
    $core.Iterable<$core.String>? gallery,
    UpliftFundVisibility? visibility,
    $core.String? metadata,
  }) {
    final result = create();
    if (fundId != null) result.fundId = fundId;
    if (title != null) result.title = title;
    if (description != null) result.description = description;
    if (story != null) result.story = story;
    if (category != null) result.category = category;
    if (perBusinessCap != null) result.perBusinessCap = perBusinessCap;
    if (targetCount != null) result.targetCount = targetCount;
    if (applicationDeadline != null)
      result.applicationDeadline = applicationDeadline;
    if (fundingDeadline != null) result.fundingDeadline = fundingDeadline;
    if (coverImageUrl != null) result.coverImageUrl = coverImageUrl;
    if (gallery != null) result.gallery.addAll(gallery);
    if (visibility != null) result.visibility = visibility;
    if (metadata != null) result.metadata = metadata;
    return result;
  }

  UpdateUpliftFundRequest._();

  factory UpdateUpliftFundRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateUpliftFundRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateUpliftFundRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'fundId')
    ..aOS(2, _omitFieldNames ? '' : 'title')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..aOS(4, _omitFieldNames ? '' : 'story')
    ..aOS(5, _omitFieldNames ? '' : 'category')
    ..a<$fixnum.Int64>(
        6, _omitFieldNames ? '' : 'perBusinessCap', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(7, _omitFieldNames ? '' : 'targetCount', $pb.PbFieldType.O3)
    ..aOM<$1.Timestamp>(8, _omitFieldNames ? '' : 'applicationDeadline',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(9, _omitFieldNames ? '' : 'fundingDeadline',
        subBuilder: $1.Timestamp.create)
    ..aOS(10, _omitFieldNames ? '' : 'coverImageUrl')
    ..pPS(11, _omitFieldNames ? '' : 'gallery')
    ..e<UpliftFundVisibility>(
        12, _omitFieldNames ? '' : 'visibility', $pb.PbFieldType.OE,
        defaultOrMaker: UpliftFundVisibility.UPLIFT_FUND_VISIBILITY_UNSPECIFIED,
        valueOf: UpliftFundVisibility.valueOf,
        enumValues: UpliftFundVisibility.values)
    ..aOS(13, _omitFieldNames ? '' : 'metadata')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateUpliftFundRequest clone() =>
      UpdateUpliftFundRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateUpliftFundRequest copyWith(
          void Function(UpdateUpliftFundRequest) updates) =>
      super.copyWith((message) => updates(message as UpdateUpliftFundRequest))
          as UpdateUpliftFundRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateUpliftFundRequest create() => UpdateUpliftFundRequest._();
  @$core.override
  UpdateUpliftFundRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateUpliftFundRequest> createRepeated() =>
      $pb.PbList<UpdateUpliftFundRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateUpliftFundRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateUpliftFundRequest>(create);
  static UpdateUpliftFundRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get fundId => $_getSZ(0);
  @$pb.TagNumber(1)
  set fundId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFundId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFundId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get title => $_getSZ(1);
  @$pb.TagNumber(2)
  set title($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTitle() => $_has(1);
  @$pb.TagNumber(2)
  void clearTitle() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get story => $_getSZ(3);
  @$pb.TagNumber(4)
  set story($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasStory() => $_has(3);
  @$pb.TagNumber(4)
  void clearStory() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get category => $_getSZ(4);
  @$pb.TagNumber(5)
  set category($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasCategory() => $_has(4);
  @$pb.TagNumber(5)
  void clearCategory() => $_clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get perBusinessCap => $_getI64(5);
  @$pb.TagNumber(6)
  set perBusinessCap($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasPerBusinessCap() => $_has(5);
  @$pb.TagNumber(6)
  void clearPerBusinessCap() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.int get targetCount => $_getIZ(6);
  @$pb.TagNumber(7)
  set targetCount($core.int value) => $_setSignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasTargetCount() => $_has(6);
  @$pb.TagNumber(7)
  void clearTargetCount() => $_clearField(7);

  @$pb.TagNumber(8)
  $1.Timestamp get applicationDeadline => $_getN(7);
  @$pb.TagNumber(8)
  set applicationDeadline($1.Timestamp value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasApplicationDeadline() => $_has(7);
  @$pb.TagNumber(8)
  void clearApplicationDeadline() => $_clearField(8);
  @$pb.TagNumber(8)
  $1.Timestamp ensureApplicationDeadline() => $_ensure(7);

  @$pb.TagNumber(9)
  $1.Timestamp get fundingDeadline => $_getN(8);
  @$pb.TagNumber(9)
  set fundingDeadline($1.Timestamp value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasFundingDeadline() => $_has(8);
  @$pb.TagNumber(9)
  void clearFundingDeadline() => $_clearField(9);
  @$pb.TagNumber(9)
  $1.Timestamp ensureFundingDeadline() => $_ensure(8);

  @$pb.TagNumber(10)
  $core.String get coverImageUrl => $_getSZ(9);
  @$pb.TagNumber(10)
  set coverImageUrl($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasCoverImageUrl() => $_has(9);
  @$pb.TagNumber(10)
  void clearCoverImageUrl() => $_clearField(10);

  @$pb.TagNumber(11)
  $pb.PbList<$core.String> get gallery => $_getList(10);

  @$pb.TagNumber(12)
  UpliftFundVisibility get visibility => $_getN(11);
  @$pb.TagNumber(12)
  set visibility(UpliftFundVisibility value) => $_setField(12, value);
  @$pb.TagNumber(12)
  $core.bool hasVisibility() => $_has(11);
  @$pb.TagNumber(12)
  void clearVisibility() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.String get metadata => $_getSZ(12);
  @$pb.TagNumber(13)
  set metadata($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasMetadata() => $_has(12);
  @$pb.TagNumber(13)
  void clearMetadata() => $_clearField(13);
}

class UpdateUpliftFundResponse extends $pb.GeneratedMessage {
  factory UpdateUpliftFundResponse({
    UpliftFundMessage? fund,
  }) {
    final result = create();
    if (fund != null) result.fund = fund;
    return result;
  }

  UpdateUpliftFundResponse._();

  factory UpdateUpliftFundResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateUpliftFundResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateUpliftFundResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<UpliftFundMessage>(1, _omitFieldNames ? '' : 'fund',
        subBuilder: UpliftFundMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateUpliftFundResponse clone() =>
      UpdateUpliftFundResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateUpliftFundResponse copyWith(
          void Function(UpdateUpliftFundResponse) updates) =>
      super.copyWith((message) => updates(message as UpdateUpliftFundResponse))
          as UpdateUpliftFundResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateUpliftFundResponse create() => UpdateUpliftFundResponse._();
  @$core.override
  UpdateUpliftFundResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateUpliftFundResponse> createRepeated() =>
      $pb.PbList<UpdateUpliftFundResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateUpliftFundResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateUpliftFundResponse>(create);
  static UpdateUpliftFundResponse? _defaultInstance;

  @$pb.TagNumber(1)
  UpliftFundMessage get fund => $_getN(0);
  @$pb.TagNumber(1)
  set fund(UpliftFundMessage value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasFund() => $_has(0);
  @$pb.TagNumber(1)
  void clearFund() => $_clearField(1);
  @$pb.TagNumber(1)
  UpliftFundMessage ensureFund() => $_ensure(0);
}

class PublishUpliftFundRequest extends $pb.GeneratedMessage {
  factory PublishUpliftFundRequest({
    $core.String? fundId,
  }) {
    final result = create();
    if (fundId != null) result.fundId = fundId;
    return result;
  }

  PublishUpliftFundRequest._();

  factory PublishUpliftFundRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PublishUpliftFundRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PublishUpliftFundRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'fundId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PublishUpliftFundRequest clone() =>
      PublishUpliftFundRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PublishUpliftFundRequest copyWith(
          void Function(PublishUpliftFundRequest) updates) =>
      super.copyWith((message) => updates(message as PublishUpliftFundRequest))
          as PublishUpliftFundRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PublishUpliftFundRequest create() => PublishUpliftFundRequest._();
  @$core.override
  PublishUpliftFundRequest createEmptyInstance() => create();
  static $pb.PbList<PublishUpliftFundRequest> createRepeated() =>
      $pb.PbList<PublishUpliftFundRequest>();
  @$core.pragma('dart2js:noInline')
  static PublishUpliftFundRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PublishUpliftFundRequest>(create);
  static PublishUpliftFundRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get fundId => $_getSZ(0);
  @$pb.TagNumber(1)
  set fundId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFundId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFundId() => $_clearField(1);
}

class PublishUpliftFundResponse extends $pb.GeneratedMessage {
  factory PublishUpliftFundResponse({
    UpliftFundMessage? fund,
  }) {
    final result = create();
    if (fund != null) result.fund = fund;
    return result;
  }

  PublishUpliftFundResponse._();

  factory PublishUpliftFundResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PublishUpliftFundResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PublishUpliftFundResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<UpliftFundMessage>(1, _omitFieldNames ? '' : 'fund',
        subBuilder: UpliftFundMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PublishUpliftFundResponse clone() =>
      PublishUpliftFundResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PublishUpliftFundResponse copyWith(
          void Function(PublishUpliftFundResponse) updates) =>
      super.copyWith((message) => updates(message as PublishUpliftFundResponse))
          as PublishUpliftFundResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PublishUpliftFundResponse create() => PublishUpliftFundResponse._();
  @$core.override
  PublishUpliftFundResponse createEmptyInstance() => create();
  static $pb.PbList<PublishUpliftFundResponse> createRepeated() =>
      $pb.PbList<PublishUpliftFundResponse>();
  @$core.pragma('dart2js:noInline')
  static PublishUpliftFundResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PublishUpliftFundResponse>(create);
  static PublishUpliftFundResponse? _defaultInstance;

  @$pb.TagNumber(1)
  UpliftFundMessage get fund => $_getN(0);
  @$pb.TagNumber(1)
  set fund(UpliftFundMessage value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasFund() => $_has(0);
  @$pb.TagNumber(1)
  void clearFund() => $_clearField(1);
  @$pb.TagNumber(1)
  UpliftFundMessage ensureFund() => $_ensure(0);
}

class GetUpliftFundRequest extends $pb.GeneratedMessage {
  factory GetUpliftFundRequest({
    $core.String? fundId,
  }) {
    final result = create();
    if (fundId != null) result.fundId = fundId;
    return result;
  }

  GetUpliftFundRequest._();

  factory GetUpliftFundRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetUpliftFundRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUpliftFundRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'fundId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUpliftFundRequest clone() =>
      GetUpliftFundRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUpliftFundRequest copyWith(void Function(GetUpliftFundRequest) updates) =>
      super.copyWith((message) => updates(message as GetUpliftFundRequest))
          as GetUpliftFundRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUpliftFundRequest create() => GetUpliftFundRequest._();
  @$core.override
  GetUpliftFundRequest createEmptyInstance() => create();
  static $pb.PbList<GetUpliftFundRequest> createRepeated() =>
      $pb.PbList<GetUpliftFundRequest>();
  @$core.pragma('dart2js:noInline')
  static GetUpliftFundRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetUpliftFundRequest>(create);
  static GetUpliftFundRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get fundId => $_getSZ(0);
  @$pb.TagNumber(1)
  set fundId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFundId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFundId() => $_clearField(1);
}

class GetUpliftFundResponse extends $pb.GeneratedMessage {
  factory GetUpliftFundResponse({
    UpliftFundMessage? fund,
  }) {
    final result = create();
    if (fund != null) result.fund = fund;
    return result;
  }

  GetUpliftFundResponse._();

  factory GetUpliftFundResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetUpliftFundResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUpliftFundResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<UpliftFundMessage>(1, _omitFieldNames ? '' : 'fund',
        subBuilder: UpliftFundMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUpliftFundResponse clone() =>
      GetUpliftFundResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUpliftFundResponse copyWith(
          void Function(GetUpliftFundResponse) updates) =>
      super.copyWith((message) => updates(message as GetUpliftFundResponse))
          as GetUpliftFundResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUpliftFundResponse create() => GetUpliftFundResponse._();
  @$core.override
  GetUpliftFundResponse createEmptyInstance() => create();
  static $pb.PbList<GetUpliftFundResponse> createRepeated() =>
      $pb.PbList<GetUpliftFundResponse>();
  @$core.pragma('dart2js:noInline')
  static GetUpliftFundResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetUpliftFundResponse>(create);
  static GetUpliftFundResponse? _defaultInstance;

  @$pb.TagNumber(1)
  UpliftFundMessage get fund => $_getN(0);
  @$pb.TagNumber(1)
  set fund(UpliftFundMessage value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasFund() => $_has(0);
  @$pb.TagNumber(1)
  void clearFund() => $_clearField(1);
  @$pb.TagNumber(1)
  UpliftFundMessage ensureFund() => $_ensure(0);
}

class ListUpliftFundsRequest extends $pb.GeneratedMessage {
  factory ListUpliftFundsRequest({
    $core.int? page,
    $core.int? pageSize,
    $core.String? status,
    $core.String? category,
    $core.String? query,
  }) {
    final result = create();
    if (page != null) result.page = page;
    if (pageSize != null) result.pageSize = pageSize;
    if (status != null) result.status = status;
    if (category != null) result.category = category;
    if (query != null) result.query = query;
    return result;
  }

  ListUpliftFundsRequest._();

  factory ListUpliftFundsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListUpliftFundsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListUpliftFundsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOS(3, _omitFieldNames ? '' : 'status')
    ..aOS(4, _omitFieldNames ? '' : 'category')
    ..aOS(5, _omitFieldNames ? '' : 'query')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListUpliftFundsRequest clone() =>
      ListUpliftFundsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListUpliftFundsRequest copyWith(
          void Function(ListUpliftFundsRequest) updates) =>
      super.copyWith((message) => updates(message as ListUpliftFundsRequest))
          as ListUpliftFundsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListUpliftFundsRequest create() => ListUpliftFundsRequest._();
  @$core.override
  ListUpliftFundsRequest createEmptyInstance() => create();
  static $pb.PbList<ListUpliftFundsRequest> createRepeated() =>
      $pb.PbList<ListUpliftFundsRequest>();
  @$core.pragma('dart2js:noInline')
  static ListUpliftFundsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListUpliftFundsRequest>(create);
  static ListUpliftFundsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get page => $_getIZ(0);
  @$pb.TagNumber(1)
  set page($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearPage() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get pageSize => $_getIZ(1);
  @$pb.TagNumber(2)
  set pageSize($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPageSize() => $_has(1);
  @$pb.TagNumber(2)
  void clearPageSize() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get status => $_getSZ(2);
  @$pb.TagNumber(3)
  set status($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasStatus() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatus() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get category => $_getSZ(3);
  @$pb.TagNumber(4)
  set category($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCategory() => $_has(3);
  @$pb.TagNumber(4)
  void clearCategory() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get query => $_getSZ(4);
  @$pb.TagNumber(5)
  set query($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasQuery() => $_has(4);
  @$pb.TagNumber(5)
  void clearQuery() => $_clearField(5);
}

class ListUpliftFundsResponse extends $pb.GeneratedMessage {
  factory ListUpliftFundsResponse({
    $core.Iterable<UpliftFundMessage>? funds,
    UpliftPaginationInfo? pagination,
  }) {
    final result = create();
    if (funds != null) result.funds.addAll(funds);
    if (pagination != null) result.pagination = pagination;
    return result;
  }

  ListUpliftFundsResponse._();

  factory ListUpliftFundsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListUpliftFundsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListUpliftFundsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<UpliftFundMessage>(
        1, _omitFieldNames ? '' : 'funds', $pb.PbFieldType.PM,
        subBuilder: UpliftFundMessage.create)
    ..aOM<UpliftPaginationInfo>(2, _omitFieldNames ? '' : 'pagination',
        subBuilder: UpliftPaginationInfo.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListUpliftFundsResponse clone() =>
      ListUpliftFundsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListUpliftFundsResponse copyWith(
          void Function(ListUpliftFundsResponse) updates) =>
      super.copyWith((message) => updates(message as ListUpliftFundsResponse))
          as ListUpliftFundsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListUpliftFundsResponse create() => ListUpliftFundsResponse._();
  @$core.override
  ListUpliftFundsResponse createEmptyInstance() => create();
  static $pb.PbList<ListUpliftFundsResponse> createRepeated() =>
      $pb.PbList<ListUpliftFundsResponse>();
  @$core.pragma('dart2js:noInline')
  static ListUpliftFundsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListUpliftFundsResponse>(create);
  static ListUpliftFundsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<UpliftFundMessage> get funds => $_getList(0);

  @$pb.TagNumber(2)
  UpliftPaginationInfo get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination(UpliftPaginationInfo value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => $_clearField(2);
  @$pb.TagNumber(2)
  UpliftPaginationInfo ensurePagination() => $_ensure(1);
}

class GetMyUpliftFundsRequest extends $pb.GeneratedMessage {
  factory GetMyUpliftFundsRequest({
    $core.int? page,
    $core.int? pageSize,
    $core.String? status,
  }) {
    final result = create();
    if (page != null) result.page = page;
    if (pageSize != null) result.pageSize = pageSize;
    if (status != null) result.status = status;
    return result;
  }

  GetMyUpliftFundsRequest._();

  factory GetMyUpliftFundsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMyUpliftFundsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMyUpliftFundsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOS(3, _omitFieldNames ? '' : 'status')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyUpliftFundsRequest clone() =>
      GetMyUpliftFundsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyUpliftFundsRequest copyWith(
          void Function(GetMyUpliftFundsRequest) updates) =>
      super.copyWith((message) => updates(message as GetMyUpliftFundsRequest))
          as GetMyUpliftFundsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMyUpliftFundsRequest create() => GetMyUpliftFundsRequest._();
  @$core.override
  GetMyUpliftFundsRequest createEmptyInstance() => create();
  static $pb.PbList<GetMyUpliftFundsRequest> createRepeated() =>
      $pb.PbList<GetMyUpliftFundsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMyUpliftFundsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetMyUpliftFundsRequest>(create);
  static GetMyUpliftFundsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get page => $_getIZ(0);
  @$pb.TagNumber(1)
  set page($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearPage() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get pageSize => $_getIZ(1);
  @$pb.TagNumber(2)
  set pageSize($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPageSize() => $_has(1);
  @$pb.TagNumber(2)
  void clearPageSize() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get status => $_getSZ(2);
  @$pb.TagNumber(3)
  set status($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasStatus() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatus() => $_clearField(3);
}

class GetMyUpliftFundsResponse extends $pb.GeneratedMessage {
  factory GetMyUpliftFundsResponse({
    $core.Iterable<UpliftFundMessage>? funds,
    UpliftPaginationInfo? pagination,
  }) {
    final result = create();
    if (funds != null) result.funds.addAll(funds);
    if (pagination != null) result.pagination = pagination;
    return result;
  }

  GetMyUpliftFundsResponse._();

  factory GetMyUpliftFundsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMyUpliftFundsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMyUpliftFundsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<UpliftFundMessage>(
        1, _omitFieldNames ? '' : 'funds', $pb.PbFieldType.PM,
        subBuilder: UpliftFundMessage.create)
    ..aOM<UpliftPaginationInfo>(2, _omitFieldNames ? '' : 'pagination',
        subBuilder: UpliftPaginationInfo.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyUpliftFundsResponse clone() =>
      GetMyUpliftFundsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyUpliftFundsResponse copyWith(
          void Function(GetMyUpliftFundsResponse) updates) =>
      super.copyWith((message) => updates(message as GetMyUpliftFundsResponse))
          as GetMyUpliftFundsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMyUpliftFundsResponse create() => GetMyUpliftFundsResponse._();
  @$core.override
  GetMyUpliftFundsResponse createEmptyInstance() => create();
  static $pb.PbList<GetMyUpliftFundsResponse> createRepeated() =>
      $pb.PbList<GetMyUpliftFundsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMyUpliftFundsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetMyUpliftFundsResponse>(create);
  static GetMyUpliftFundsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<UpliftFundMessage> get funds => $_getList(0);

  @$pb.TagNumber(2)
  UpliftPaginationInfo get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination(UpliftPaginationInfo value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => $_clearField(2);
  @$pb.TagNumber(2)
  UpliftPaginationInfo ensurePagination() => $_ensure(1);
}

class PauseUpliftFundRequest extends $pb.GeneratedMessage {
  factory PauseUpliftFundRequest({
    $core.String? fundId,
    $core.bool? resume,
  }) {
    final result = create();
    if (fundId != null) result.fundId = fundId;
    if (resume != null) result.resume = resume;
    return result;
  }

  PauseUpliftFundRequest._();

  factory PauseUpliftFundRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PauseUpliftFundRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PauseUpliftFundRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'fundId')
    ..aOB(2, _omitFieldNames ? '' : 'resume')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PauseUpliftFundRequest clone() =>
      PauseUpliftFundRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PauseUpliftFundRequest copyWith(
          void Function(PauseUpliftFundRequest) updates) =>
      super.copyWith((message) => updates(message as PauseUpliftFundRequest))
          as PauseUpliftFundRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PauseUpliftFundRequest create() => PauseUpliftFundRequest._();
  @$core.override
  PauseUpliftFundRequest createEmptyInstance() => create();
  static $pb.PbList<PauseUpliftFundRequest> createRepeated() =>
      $pb.PbList<PauseUpliftFundRequest>();
  @$core.pragma('dart2js:noInline')
  static PauseUpliftFundRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PauseUpliftFundRequest>(create);
  static PauseUpliftFundRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get fundId => $_getSZ(0);
  @$pb.TagNumber(1)
  set fundId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFundId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFundId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get resume => $_getBF(1);
  @$pb.TagNumber(2)
  set resume($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasResume() => $_has(1);
  @$pb.TagNumber(2)
  void clearResume() => $_clearField(2);
}

class PauseUpliftFundResponse extends $pb.GeneratedMessage {
  factory PauseUpliftFundResponse({
    UpliftFundMessage? fund,
  }) {
    final result = create();
    if (fund != null) result.fund = fund;
    return result;
  }

  PauseUpliftFundResponse._();

  factory PauseUpliftFundResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PauseUpliftFundResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PauseUpliftFundResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<UpliftFundMessage>(1, _omitFieldNames ? '' : 'fund',
        subBuilder: UpliftFundMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PauseUpliftFundResponse clone() =>
      PauseUpliftFundResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PauseUpliftFundResponse copyWith(
          void Function(PauseUpliftFundResponse) updates) =>
      super.copyWith((message) => updates(message as PauseUpliftFundResponse))
          as PauseUpliftFundResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PauseUpliftFundResponse create() => PauseUpliftFundResponse._();
  @$core.override
  PauseUpliftFundResponse createEmptyInstance() => create();
  static $pb.PbList<PauseUpliftFundResponse> createRepeated() =>
      $pb.PbList<PauseUpliftFundResponse>();
  @$core.pragma('dart2js:noInline')
  static PauseUpliftFundResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PauseUpliftFundResponse>(create);
  static PauseUpliftFundResponse? _defaultInstance;

  @$pb.TagNumber(1)
  UpliftFundMessage get fund => $_getN(0);
  @$pb.TagNumber(1)
  set fund(UpliftFundMessage value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasFund() => $_has(0);
  @$pb.TagNumber(1)
  void clearFund() => $_clearField(1);
  @$pb.TagNumber(1)
  UpliftFundMessage ensureFund() => $_ensure(0);
}

class CancelUpliftFundRequest extends $pb.GeneratedMessage {
  factory CancelUpliftFundRequest({
    $core.String? fundId,
    $core.String? reason,
    $core.String? transactionPin,
    $core.String? transactionId,
  }) {
    final result = create();
    if (fundId != null) result.fundId = fundId;
    if (reason != null) result.reason = reason;
    if (transactionPin != null) result.transactionPin = transactionPin;
    if (transactionId != null) result.transactionId = transactionId;
    return result;
  }

  CancelUpliftFundRequest._();

  factory CancelUpliftFundRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CancelUpliftFundRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CancelUpliftFundRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'fundId')
    ..aOS(2, _omitFieldNames ? '' : 'reason')
    ..aOS(3, _omitFieldNames ? '' : 'transactionPin')
    ..aOS(4, _omitFieldNames ? '' : 'transactionId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CancelUpliftFundRequest clone() =>
      CancelUpliftFundRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CancelUpliftFundRequest copyWith(
          void Function(CancelUpliftFundRequest) updates) =>
      super.copyWith((message) => updates(message as CancelUpliftFundRequest))
          as CancelUpliftFundRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CancelUpliftFundRequest create() => CancelUpliftFundRequest._();
  @$core.override
  CancelUpliftFundRequest createEmptyInstance() => create();
  static $pb.PbList<CancelUpliftFundRequest> createRepeated() =>
      $pb.PbList<CancelUpliftFundRequest>();
  @$core.pragma('dart2js:noInline')
  static CancelUpliftFundRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CancelUpliftFundRequest>(create);
  static CancelUpliftFundRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get fundId => $_getSZ(0);
  @$pb.TagNumber(1)
  set fundId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFundId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFundId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get reason => $_getSZ(1);
  @$pb.TagNumber(2)
  set reason($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasReason() => $_has(1);
  @$pb.TagNumber(2)
  void clearReason() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get transactionPin => $_getSZ(2);
  @$pb.TagNumber(3)
  set transactionPin($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTransactionPin() => $_has(2);
  @$pb.TagNumber(3)
  void clearTransactionPin() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get transactionId => $_getSZ(3);
  @$pb.TagNumber(4)
  set transactionId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTransactionId() => $_has(3);
  @$pb.TagNumber(4)
  void clearTransactionId() => $_clearField(4);
}

class CancelUpliftFundResponse extends $pb.GeneratedMessage {
  factory CancelUpliftFundResponse({
    UpliftFundMessage? fund,
    $fixnum.Int64? refundAmount,
    $core.int? applicationsRejected,
    $core.String? message,
  }) {
    final result = create();
    if (fund != null) result.fund = fund;
    if (refundAmount != null) result.refundAmount = refundAmount;
    if (applicationsRejected != null)
      result.applicationsRejected = applicationsRejected;
    if (message != null) result.message = message;
    return result;
  }

  CancelUpliftFundResponse._();

  factory CancelUpliftFundResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CancelUpliftFundResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CancelUpliftFundResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<UpliftFundMessage>(1, _omitFieldNames ? '' : 'fund',
        subBuilder: UpliftFundMessage.create)
    ..a<$fixnum.Int64>(
        2, _omitFieldNames ? '' : 'refundAmount', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(
        3, _omitFieldNames ? '' : 'applicationsRejected', $pb.PbFieldType.O3)
    ..aOS(4, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CancelUpliftFundResponse clone() =>
      CancelUpliftFundResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CancelUpliftFundResponse copyWith(
          void Function(CancelUpliftFundResponse) updates) =>
      super.copyWith((message) => updates(message as CancelUpliftFundResponse))
          as CancelUpliftFundResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CancelUpliftFundResponse create() => CancelUpliftFundResponse._();
  @$core.override
  CancelUpliftFundResponse createEmptyInstance() => create();
  static $pb.PbList<CancelUpliftFundResponse> createRepeated() =>
      $pb.PbList<CancelUpliftFundResponse>();
  @$core.pragma('dart2js:noInline')
  static CancelUpliftFundResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CancelUpliftFundResponse>(create);
  static CancelUpliftFundResponse? _defaultInstance;

  @$pb.TagNumber(1)
  UpliftFundMessage get fund => $_getN(0);
  @$pb.TagNumber(1)
  set fund(UpliftFundMessage value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasFund() => $_has(0);
  @$pb.TagNumber(1)
  void clearFund() => $_clearField(1);
  @$pb.TagNumber(1)
  UpliftFundMessage ensureFund() => $_ensure(0);

  @$pb.TagNumber(2)
  $fixnum.Int64 get refundAmount => $_getI64(1);
  @$pb.TagNumber(2)
  set refundAmount($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRefundAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearRefundAmount() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get applicationsRejected => $_getIZ(2);
  @$pb.TagNumber(3)
  set applicationsRejected($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasApplicationsRejected() => $_has(2);
  @$pb.TagNumber(3)
  void clearApplicationsRejected() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get message => $_getSZ(3);
  @$pb.TagNumber(4)
  set message($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMessage() => $_has(3);
  @$pb.TagNumber(4)
  void clearMessage() => $_clearField(4);
}

class CommitUpliftPoolRequest extends $pb.GeneratedMessage {
  factory CommitUpliftPoolRequest({
    $core.String? fundId,
    $fixnum.Int64? amount,
    $core.String? sourceAccountId,
    $core.String? transactionPin,
    $core.String? transactionId,
  }) {
    final result = create();
    if (fundId != null) result.fundId = fundId;
    if (amount != null) result.amount = amount;
    if (sourceAccountId != null) result.sourceAccountId = sourceAccountId;
    if (transactionPin != null) result.transactionPin = transactionPin;
    if (transactionId != null) result.transactionId = transactionId;
    return result;
  }

  CommitUpliftPoolRequest._();

  factory CommitUpliftPoolRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CommitUpliftPoolRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CommitUpliftPoolRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'fundId')
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(3, _omitFieldNames ? '' : 'sourceAccountId')
    ..aOS(4, _omitFieldNames ? '' : 'transactionPin')
    ..aOS(5, _omitFieldNames ? '' : 'transactionId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CommitUpliftPoolRequest clone() =>
      CommitUpliftPoolRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CommitUpliftPoolRequest copyWith(
          void Function(CommitUpliftPoolRequest) updates) =>
      super.copyWith((message) => updates(message as CommitUpliftPoolRequest))
          as CommitUpliftPoolRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CommitUpliftPoolRequest create() => CommitUpliftPoolRequest._();
  @$core.override
  CommitUpliftPoolRequest createEmptyInstance() => create();
  static $pb.PbList<CommitUpliftPoolRequest> createRepeated() =>
      $pb.PbList<CommitUpliftPoolRequest>();
  @$core.pragma('dart2js:noInline')
  static CommitUpliftPoolRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CommitUpliftPoolRequest>(create);
  static CommitUpliftPoolRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get fundId => $_getSZ(0);
  @$pb.TagNumber(1)
  set fundId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFundId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFundId() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get amount => $_getI64(1);
  @$pb.TagNumber(2)
  set amount($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get sourceAccountId => $_getSZ(2);
  @$pb.TagNumber(3)
  set sourceAccountId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSourceAccountId() => $_has(2);
  @$pb.TagNumber(3)
  void clearSourceAccountId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get transactionPin => $_getSZ(3);
  @$pb.TagNumber(4)
  set transactionPin($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTransactionPin() => $_has(3);
  @$pb.TagNumber(4)
  void clearTransactionPin() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get transactionId => $_getSZ(4);
  @$pb.TagNumber(5)
  set transactionId($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTransactionId() => $_has(4);
  @$pb.TagNumber(5)
  void clearTransactionId() => $_clearField(5);
}

class CommitUpliftPoolResponse extends $pb.GeneratedMessage {
  factory CommitUpliftPoolResponse({
    UpliftFundMessage? fund,
    $fixnum.Int64? committedPool,
    $fixnum.Int64? escrowAvailable,
    $core.String? message,
  }) {
    final result = create();
    if (fund != null) result.fund = fund;
    if (committedPool != null) result.committedPool = committedPool;
    if (escrowAvailable != null) result.escrowAvailable = escrowAvailable;
    if (message != null) result.message = message;
    return result;
  }

  CommitUpliftPoolResponse._();

  factory CommitUpliftPoolResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CommitUpliftPoolResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CommitUpliftPoolResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<UpliftFundMessage>(1, _omitFieldNames ? '' : 'fund',
        subBuilder: UpliftFundMessage.create)
    ..a<$fixnum.Int64>(
        2, _omitFieldNames ? '' : 'committedPool', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(
        3, _omitFieldNames ? '' : 'escrowAvailable', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(4, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CommitUpliftPoolResponse clone() =>
      CommitUpliftPoolResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CommitUpliftPoolResponse copyWith(
          void Function(CommitUpliftPoolResponse) updates) =>
      super.copyWith((message) => updates(message as CommitUpliftPoolResponse))
          as CommitUpliftPoolResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CommitUpliftPoolResponse create() => CommitUpliftPoolResponse._();
  @$core.override
  CommitUpliftPoolResponse createEmptyInstance() => create();
  static $pb.PbList<CommitUpliftPoolResponse> createRepeated() =>
      $pb.PbList<CommitUpliftPoolResponse>();
  @$core.pragma('dart2js:noInline')
  static CommitUpliftPoolResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CommitUpliftPoolResponse>(create);
  static CommitUpliftPoolResponse? _defaultInstance;

  @$pb.TagNumber(1)
  UpliftFundMessage get fund => $_getN(0);
  @$pb.TagNumber(1)
  set fund(UpliftFundMessage value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasFund() => $_has(0);
  @$pb.TagNumber(1)
  void clearFund() => $_clearField(1);
  @$pb.TagNumber(1)
  UpliftFundMessage ensureFund() => $_ensure(0);

  @$pb.TagNumber(2)
  $fixnum.Int64 get committedPool => $_getI64(1);
  @$pb.TagNumber(2)
  set committedPool($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCommittedPool() => $_has(1);
  @$pb.TagNumber(2)
  void clearCommittedPool() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get escrowAvailable => $_getI64(2);
  @$pb.TagNumber(3)
  set escrowAvailable($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasEscrowAvailable() => $_has(2);
  @$pb.TagNumber(3)
  void clearEscrowAvailable() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get message => $_getSZ(3);
  @$pb.TagNumber(4)
  set message($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMessage() => $_has(3);
  @$pb.TagNumber(4)
  void clearMessage() => $_clearField(4);
}

class GetUpliftEscrowBalanceRequest extends $pb.GeneratedMessage {
  factory GetUpliftEscrowBalanceRequest({
    $core.String? fundId,
  }) {
    final result = create();
    if (fundId != null) result.fundId = fundId;
    return result;
  }

  GetUpliftEscrowBalanceRequest._();

  factory GetUpliftEscrowBalanceRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetUpliftEscrowBalanceRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUpliftEscrowBalanceRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'fundId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUpliftEscrowBalanceRequest clone() =>
      GetUpliftEscrowBalanceRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUpliftEscrowBalanceRequest copyWith(
          void Function(GetUpliftEscrowBalanceRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetUpliftEscrowBalanceRequest))
          as GetUpliftEscrowBalanceRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUpliftEscrowBalanceRequest create() =>
      GetUpliftEscrowBalanceRequest._();
  @$core.override
  GetUpliftEscrowBalanceRequest createEmptyInstance() => create();
  static $pb.PbList<GetUpliftEscrowBalanceRequest> createRepeated() =>
      $pb.PbList<GetUpliftEscrowBalanceRequest>();
  @$core.pragma('dart2js:noInline')
  static GetUpliftEscrowBalanceRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetUpliftEscrowBalanceRequest>(create);
  static GetUpliftEscrowBalanceRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get fundId => $_getSZ(0);
  @$pb.TagNumber(1)
  set fundId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFundId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFundId() => $_clearField(1);
}

class GetUpliftEscrowBalanceResponse extends $pb.GeneratedMessage {
  factory GetUpliftEscrowBalanceResponse({
    $core.String? fundId,
    $core.String? escrowAccountId,
    $fixnum.Int64? committedPool,
    $fixnum.Int64? releasedTotal,
    $fixnum.Int64? refundedTotal,
    $fixnum.Int64? balance,
    $fixnum.Int64? available,
    $core.String? currency,
  }) {
    final result = create();
    if (fundId != null) result.fundId = fundId;
    if (escrowAccountId != null) result.escrowAccountId = escrowAccountId;
    if (committedPool != null) result.committedPool = committedPool;
    if (releasedTotal != null) result.releasedTotal = releasedTotal;
    if (refundedTotal != null) result.refundedTotal = refundedTotal;
    if (balance != null) result.balance = balance;
    if (available != null) result.available = available;
    if (currency != null) result.currency = currency;
    return result;
  }

  GetUpliftEscrowBalanceResponse._();

  factory GetUpliftEscrowBalanceResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetUpliftEscrowBalanceResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUpliftEscrowBalanceResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'fundId')
    ..aOS(2, _omitFieldNames ? '' : 'escrowAccountId')
    ..a<$fixnum.Int64>(
        3, _omitFieldNames ? '' : 'committedPool', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(
        4, _omitFieldNames ? '' : 'releasedTotal', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(
        5, _omitFieldNames ? '' : 'refundedTotal', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(6, _omitFieldNames ? '' : 'balance', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(
        7, _omitFieldNames ? '' : 'available', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(8, _omitFieldNames ? '' : 'currency')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUpliftEscrowBalanceResponse clone() =>
      GetUpliftEscrowBalanceResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUpliftEscrowBalanceResponse copyWith(
          void Function(GetUpliftEscrowBalanceResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetUpliftEscrowBalanceResponse))
          as GetUpliftEscrowBalanceResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUpliftEscrowBalanceResponse create() =>
      GetUpliftEscrowBalanceResponse._();
  @$core.override
  GetUpliftEscrowBalanceResponse createEmptyInstance() => create();
  static $pb.PbList<GetUpliftEscrowBalanceResponse> createRepeated() =>
      $pb.PbList<GetUpliftEscrowBalanceResponse>();
  @$core.pragma('dart2js:noInline')
  static GetUpliftEscrowBalanceResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetUpliftEscrowBalanceResponse>(create);
  static GetUpliftEscrowBalanceResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get fundId => $_getSZ(0);
  @$pb.TagNumber(1)
  set fundId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFundId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFundId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get escrowAccountId => $_getSZ(1);
  @$pb.TagNumber(2)
  set escrowAccountId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasEscrowAccountId() => $_has(1);
  @$pb.TagNumber(2)
  void clearEscrowAccountId() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get committedPool => $_getI64(2);
  @$pb.TagNumber(3)
  set committedPool($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCommittedPool() => $_has(2);
  @$pb.TagNumber(3)
  void clearCommittedPool() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get releasedTotal => $_getI64(3);
  @$pb.TagNumber(4)
  set releasedTotal($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasReleasedTotal() => $_has(3);
  @$pb.TagNumber(4)
  void clearReleasedTotal() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get refundedTotal => $_getI64(4);
  @$pb.TagNumber(5)
  set refundedTotal($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasRefundedTotal() => $_has(4);
  @$pb.TagNumber(5)
  void clearRefundedTotal() => $_clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get balance => $_getI64(5);
  @$pb.TagNumber(6)
  set balance($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasBalance() => $_has(5);
  @$pb.TagNumber(6)
  void clearBalance() => $_clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get available => $_getI64(6);
  @$pb.TagNumber(7)
  set available($fixnum.Int64 value) => $_setInt64(6, value);
  @$pb.TagNumber(7)
  $core.bool hasAvailable() => $_has(6);
  @$pb.TagNumber(7)
  void clearAvailable() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get currency => $_getSZ(7);
  @$pb.TagNumber(8)
  set currency($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasCurrency() => $_has(7);
  @$pb.TagNumber(8)
  void clearCurrency() => $_clearField(8);
}

class ApplyToUpliftFundRequest extends $pb.GeneratedMessage {
  factory ApplyToUpliftFundRequest({
    $core.String? fundId,
    $core.String? businessName,
    $core.String? businessCategory,
    $core.String? pitch,
    $fixnum.Int64? requestedAmount,
    $core.Iterable<$core.String>? images,
    $core.Iterable<$core.String>? docUrls,
    $core.String? businessAccountId,
    $core.int? proposedEquityPct,
    $core.String? equityNote,
  }) {
    final result = create();
    if (fundId != null) result.fundId = fundId;
    if (businessName != null) result.businessName = businessName;
    if (businessCategory != null) result.businessCategory = businessCategory;
    if (pitch != null) result.pitch = pitch;
    if (requestedAmount != null) result.requestedAmount = requestedAmount;
    if (images != null) result.images.addAll(images);
    if (docUrls != null) result.docUrls.addAll(docUrls);
    if (businessAccountId != null) result.businessAccountId = businessAccountId;
    if (proposedEquityPct != null) result.proposedEquityPct = proposedEquityPct;
    if (equityNote != null) result.equityNote = equityNote;
    return result;
  }

  ApplyToUpliftFundRequest._();

  factory ApplyToUpliftFundRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ApplyToUpliftFundRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ApplyToUpliftFundRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'fundId')
    ..aOS(2, _omitFieldNames ? '' : 'businessName')
    ..aOS(3, _omitFieldNames ? '' : 'businessCategory')
    ..aOS(4, _omitFieldNames ? '' : 'pitch')
    ..a<$fixnum.Int64>(
        5, _omitFieldNames ? '' : 'requestedAmount', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..pPS(6, _omitFieldNames ? '' : 'images')
    ..pPS(7, _omitFieldNames ? '' : 'docUrls')
    ..aOS(8, _omitFieldNames ? '' : 'businessAccountId')
    ..a<$core.int>(
        9, _omitFieldNames ? '' : 'proposedEquityPct', $pb.PbFieldType.OU3)
    ..aOS(10, _omitFieldNames ? '' : 'equityNote')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ApplyToUpliftFundRequest clone() =>
      ApplyToUpliftFundRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ApplyToUpliftFundRequest copyWith(
          void Function(ApplyToUpliftFundRequest) updates) =>
      super.copyWith((message) => updates(message as ApplyToUpliftFundRequest))
          as ApplyToUpliftFundRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ApplyToUpliftFundRequest create() => ApplyToUpliftFundRequest._();
  @$core.override
  ApplyToUpliftFundRequest createEmptyInstance() => create();
  static $pb.PbList<ApplyToUpliftFundRequest> createRepeated() =>
      $pb.PbList<ApplyToUpliftFundRequest>();
  @$core.pragma('dart2js:noInline')
  static ApplyToUpliftFundRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ApplyToUpliftFundRequest>(create);
  static ApplyToUpliftFundRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get fundId => $_getSZ(0);
  @$pb.TagNumber(1)
  set fundId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFundId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFundId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get businessName => $_getSZ(1);
  @$pb.TagNumber(2)
  set businessName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasBusinessName() => $_has(1);
  @$pb.TagNumber(2)
  void clearBusinessName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get businessCategory => $_getSZ(2);
  @$pb.TagNumber(3)
  set businessCategory($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasBusinessCategory() => $_has(2);
  @$pb.TagNumber(3)
  void clearBusinessCategory() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get pitch => $_getSZ(3);
  @$pb.TagNumber(4)
  set pitch($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPitch() => $_has(3);
  @$pb.TagNumber(4)
  void clearPitch() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get requestedAmount => $_getI64(4);
  @$pb.TagNumber(5)
  set requestedAmount($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasRequestedAmount() => $_has(4);
  @$pb.TagNumber(5)
  void clearRequestedAmount() => $_clearField(5);

  @$pb.TagNumber(6)
  $pb.PbList<$core.String> get images => $_getList(5);

  @$pb.TagNumber(7)
  $pb.PbList<$core.String> get docUrls => $_getList(6);

  @$pb.TagNumber(8)
  $core.String get businessAccountId => $_getSZ(7);
  @$pb.TagNumber(8)
  set businessAccountId($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasBusinessAccountId() => $_has(7);
  @$pb.TagNumber(8)
  void clearBusinessAccountId() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.int get proposedEquityPct => $_getIZ(8);
  @$pb.TagNumber(9)
  set proposedEquityPct($core.int value) => $_setUnsignedInt32(8, value);
  @$pb.TagNumber(9)
  $core.bool hasProposedEquityPct() => $_has(8);
  @$pb.TagNumber(9)
  void clearProposedEquityPct() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get equityNote => $_getSZ(9);
  @$pb.TagNumber(10)
  set equityNote($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasEquityNote() => $_has(9);
  @$pb.TagNumber(10)
  void clearEquityNote() => $_clearField(10);
}

class ApplyToUpliftFundResponse extends $pb.GeneratedMessage {
  factory ApplyToUpliftFundResponse({
    UpliftApplicationMessage? application,
  }) {
    final result = create();
    if (application != null) result.application = application;
    return result;
  }

  ApplyToUpliftFundResponse._();

  factory ApplyToUpliftFundResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ApplyToUpliftFundResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ApplyToUpliftFundResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<UpliftApplicationMessage>(1, _omitFieldNames ? '' : 'application',
        subBuilder: UpliftApplicationMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ApplyToUpliftFundResponse clone() =>
      ApplyToUpliftFundResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ApplyToUpliftFundResponse copyWith(
          void Function(ApplyToUpliftFundResponse) updates) =>
      super.copyWith((message) => updates(message as ApplyToUpliftFundResponse))
          as ApplyToUpliftFundResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ApplyToUpliftFundResponse create() => ApplyToUpliftFundResponse._();
  @$core.override
  ApplyToUpliftFundResponse createEmptyInstance() => create();
  static $pb.PbList<ApplyToUpliftFundResponse> createRepeated() =>
      $pb.PbList<ApplyToUpliftFundResponse>();
  @$core.pragma('dart2js:noInline')
  static ApplyToUpliftFundResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ApplyToUpliftFundResponse>(create);
  static ApplyToUpliftFundResponse? _defaultInstance;

  @$pb.TagNumber(1)
  UpliftApplicationMessage get application => $_getN(0);
  @$pb.TagNumber(1)
  set application(UpliftApplicationMessage value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasApplication() => $_has(0);
  @$pb.TagNumber(1)
  void clearApplication() => $_clearField(1);
  @$pb.TagNumber(1)
  UpliftApplicationMessage ensureApplication() => $_ensure(0);
}

class WithdrawUpliftApplicationRequest extends $pb.GeneratedMessage {
  factory WithdrawUpliftApplicationRequest({
    $core.String? applicationId,
    $core.String? reason,
  }) {
    final result = create();
    if (applicationId != null) result.applicationId = applicationId;
    if (reason != null) result.reason = reason;
    return result;
  }

  WithdrawUpliftApplicationRequest._();

  factory WithdrawUpliftApplicationRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory WithdrawUpliftApplicationRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'WithdrawUpliftApplicationRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'applicationId')
    ..aOS(2, _omitFieldNames ? '' : 'reason')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WithdrawUpliftApplicationRequest clone() =>
      WithdrawUpliftApplicationRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WithdrawUpliftApplicationRequest copyWith(
          void Function(WithdrawUpliftApplicationRequest) updates) =>
      super.copyWith(
              (message) => updates(message as WithdrawUpliftApplicationRequest))
          as WithdrawUpliftApplicationRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WithdrawUpliftApplicationRequest create() =>
      WithdrawUpliftApplicationRequest._();
  @$core.override
  WithdrawUpliftApplicationRequest createEmptyInstance() => create();
  static $pb.PbList<WithdrawUpliftApplicationRequest> createRepeated() =>
      $pb.PbList<WithdrawUpliftApplicationRequest>();
  @$core.pragma('dart2js:noInline')
  static WithdrawUpliftApplicationRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<WithdrawUpliftApplicationRequest>(
          create);
  static WithdrawUpliftApplicationRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get applicationId => $_getSZ(0);
  @$pb.TagNumber(1)
  set applicationId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasApplicationId() => $_has(0);
  @$pb.TagNumber(1)
  void clearApplicationId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get reason => $_getSZ(1);
  @$pb.TagNumber(2)
  set reason($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasReason() => $_has(1);
  @$pb.TagNumber(2)
  void clearReason() => $_clearField(2);
}

class WithdrawUpliftApplicationResponse extends $pb.GeneratedMessage {
  factory WithdrawUpliftApplicationResponse({
    UpliftApplicationMessage? application,
  }) {
    final result = create();
    if (application != null) result.application = application;
    return result;
  }

  WithdrawUpliftApplicationResponse._();

  factory WithdrawUpliftApplicationResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory WithdrawUpliftApplicationResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'WithdrawUpliftApplicationResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<UpliftApplicationMessage>(1, _omitFieldNames ? '' : 'application',
        subBuilder: UpliftApplicationMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WithdrawUpliftApplicationResponse clone() =>
      WithdrawUpliftApplicationResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WithdrawUpliftApplicationResponse copyWith(
          void Function(WithdrawUpliftApplicationResponse) updates) =>
      super.copyWith((message) =>
              updates(message as WithdrawUpliftApplicationResponse))
          as WithdrawUpliftApplicationResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WithdrawUpliftApplicationResponse create() =>
      WithdrawUpliftApplicationResponse._();
  @$core.override
  WithdrawUpliftApplicationResponse createEmptyInstance() => create();
  static $pb.PbList<WithdrawUpliftApplicationResponse> createRepeated() =>
      $pb.PbList<WithdrawUpliftApplicationResponse>();
  @$core.pragma('dart2js:noInline')
  static WithdrawUpliftApplicationResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<WithdrawUpliftApplicationResponse>(
          create);
  static WithdrawUpliftApplicationResponse? _defaultInstance;

  @$pb.TagNumber(1)
  UpliftApplicationMessage get application => $_getN(0);
  @$pb.TagNumber(1)
  set application(UpliftApplicationMessage value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasApplication() => $_has(0);
  @$pb.TagNumber(1)
  void clearApplication() => $_clearField(1);
  @$pb.TagNumber(1)
  UpliftApplicationMessage ensureApplication() => $_ensure(0);
}

class GetUpliftApplicationRequest extends $pb.GeneratedMessage {
  factory GetUpliftApplicationRequest({
    $core.String? applicationId,
  }) {
    final result = create();
    if (applicationId != null) result.applicationId = applicationId;
    return result;
  }

  GetUpliftApplicationRequest._();

  factory GetUpliftApplicationRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetUpliftApplicationRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUpliftApplicationRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'applicationId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUpliftApplicationRequest clone() =>
      GetUpliftApplicationRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUpliftApplicationRequest copyWith(
          void Function(GetUpliftApplicationRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetUpliftApplicationRequest))
          as GetUpliftApplicationRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUpliftApplicationRequest create() =>
      GetUpliftApplicationRequest._();
  @$core.override
  GetUpliftApplicationRequest createEmptyInstance() => create();
  static $pb.PbList<GetUpliftApplicationRequest> createRepeated() =>
      $pb.PbList<GetUpliftApplicationRequest>();
  @$core.pragma('dart2js:noInline')
  static GetUpliftApplicationRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetUpliftApplicationRequest>(create);
  static GetUpliftApplicationRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get applicationId => $_getSZ(0);
  @$pb.TagNumber(1)
  set applicationId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasApplicationId() => $_has(0);
  @$pb.TagNumber(1)
  void clearApplicationId() => $_clearField(1);
}

class GetUpliftApplicationResponse extends $pb.GeneratedMessage {
  factory GetUpliftApplicationResponse({
    UpliftApplicationMessage? application,
  }) {
    final result = create();
    if (application != null) result.application = application;
    return result;
  }

  GetUpliftApplicationResponse._();

  factory GetUpliftApplicationResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetUpliftApplicationResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUpliftApplicationResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<UpliftApplicationMessage>(1, _omitFieldNames ? '' : 'application',
        subBuilder: UpliftApplicationMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUpliftApplicationResponse clone() =>
      GetUpliftApplicationResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUpliftApplicationResponse copyWith(
          void Function(GetUpliftApplicationResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetUpliftApplicationResponse))
          as GetUpliftApplicationResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUpliftApplicationResponse create() =>
      GetUpliftApplicationResponse._();
  @$core.override
  GetUpliftApplicationResponse createEmptyInstance() => create();
  static $pb.PbList<GetUpliftApplicationResponse> createRepeated() =>
      $pb.PbList<GetUpliftApplicationResponse>();
  @$core.pragma('dart2js:noInline')
  static GetUpliftApplicationResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetUpliftApplicationResponse>(create);
  static GetUpliftApplicationResponse? _defaultInstance;

  @$pb.TagNumber(1)
  UpliftApplicationMessage get application => $_getN(0);
  @$pb.TagNumber(1)
  set application(UpliftApplicationMessage value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasApplication() => $_has(0);
  @$pb.TagNumber(1)
  void clearApplication() => $_clearField(1);
  @$pb.TagNumber(1)
  UpliftApplicationMessage ensureApplication() => $_ensure(0);
}

class ListUpliftApplicationsRequest extends $pb.GeneratedMessage {
  factory ListUpliftApplicationsRequest({
    $core.String? fundId,
    $core.bool? mineOnly,
    $core.String? status,
    $core.int? page,
    $core.int? pageSize,
    $core.String? sortBy,
  }) {
    final result = create();
    if (fundId != null) result.fundId = fundId;
    if (mineOnly != null) result.mineOnly = mineOnly;
    if (status != null) result.status = status;
    if (page != null) result.page = page;
    if (pageSize != null) result.pageSize = pageSize;
    if (sortBy != null) result.sortBy = sortBy;
    return result;
  }

  ListUpliftApplicationsRequest._();

  factory ListUpliftApplicationsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListUpliftApplicationsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListUpliftApplicationsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'fundId')
    ..aOB(2, _omitFieldNames ? '' : 'mineOnly')
    ..aOS(3, _omitFieldNames ? '' : 'status')
    ..a<$core.int>(4, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOS(6, _omitFieldNames ? '' : 'sortBy')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListUpliftApplicationsRequest clone() =>
      ListUpliftApplicationsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListUpliftApplicationsRequest copyWith(
          void Function(ListUpliftApplicationsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as ListUpliftApplicationsRequest))
          as ListUpliftApplicationsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListUpliftApplicationsRequest create() =>
      ListUpliftApplicationsRequest._();
  @$core.override
  ListUpliftApplicationsRequest createEmptyInstance() => create();
  static $pb.PbList<ListUpliftApplicationsRequest> createRepeated() =>
      $pb.PbList<ListUpliftApplicationsRequest>();
  @$core.pragma('dart2js:noInline')
  static ListUpliftApplicationsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListUpliftApplicationsRequest>(create);
  static ListUpliftApplicationsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get fundId => $_getSZ(0);
  @$pb.TagNumber(1)
  set fundId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFundId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFundId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get mineOnly => $_getBF(1);
  @$pb.TagNumber(2)
  set mineOnly($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMineOnly() => $_has(1);
  @$pb.TagNumber(2)
  void clearMineOnly() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get status => $_getSZ(2);
  @$pb.TagNumber(3)
  set status($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasStatus() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatus() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get page => $_getIZ(3);
  @$pb.TagNumber(4)
  set page($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPage() => $_has(3);
  @$pb.TagNumber(4)
  void clearPage() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get pageSize => $_getIZ(4);
  @$pb.TagNumber(5)
  set pageSize($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasPageSize() => $_has(4);
  @$pb.TagNumber(5)
  void clearPageSize() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get sortBy => $_getSZ(5);
  @$pb.TagNumber(6)
  set sortBy($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasSortBy() => $_has(5);
  @$pb.TagNumber(6)
  void clearSortBy() => $_clearField(6);
}

class ListUpliftApplicationsResponse extends $pb.GeneratedMessage {
  factory ListUpliftApplicationsResponse({
    $core.Iterable<UpliftApplicationMessage>? applications,
    UpliftPaginationInfo? pagination,
  }) {
    final result = create();
    if (applications != null) result.applications.addAll(applications);
    if (pagination != null) result.pagination = pagination;
    return result;
  }

  ListUpliftApplicationsResponse._();

  factory ListUpliftApplicationsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListUpliftApplicationsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListUpliftApplicationsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<UpliftApplicationMessage>(
        1, _omitFieldNames ? '' : 'applications', $pb.PbFieldType.PM,
        subBuilder: UpliftApplicationMessage.create)
    ..aOM<UpliftPaginationInfo>(2, _omitFieldNames ? '' : 'pagination',
        subBuilder: UpliftPaginationInfo.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListUpliftApplicationsResponse clone() =>
      ListUpliftApplicationsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListUpliftApplicationsResponse copyWith(
          void Function(ListUpliftApplicationsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as ListUpliftApplicationsResponse))
          as ListUpliftApplicationsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListUpliftApplicationsResponse create() =>
      ListUpliftApplicationsResponse._();
  @$core.override
  ListUpliftApplicationsResponse createEmptyInstance() => create();
  static $pb.PbList<ListUpliftApplicationsResponse> createRepeated() =>
      $pb.PbList<ListUpliftApplicationsResponse>();
  @$core.pragma('dart2js:noInline')
  static ListUpliftApplicationsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListUpliftApplicationsResponse>(create);
  static ListUpliftApplicationsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<UpliftApplicationMessage> get applications => $_getList(0);

  @$pb.TagNumber(2)
  UpliftPaginationInfo get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination(UpliftPaginationInfo value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => $_clearField(2);
  @$pb.TagNumber(2)
  UpliftPaginationInfo ensurePagination() => $_ensure(1);
}

class EndorseUpliftApplicationRequest extends $pb.GeneratedMessage {
  factory EndorseUpliftApplicationRequest({
    $core.String? applicationId,
    $core.bool? remove,
  }) {
    final result = create();
    if (applicationId != null) result.applicationId = applicationId;
    if (remove != null) result.remove = remove;
    return result;
  }

  EndorseUpliftApplicationRequest._();

  factory EndorseUpliftApplicationRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory EndorseUpliftApplicationRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EndorseUpliftApplicationRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'applicationId')
    ..aOB(2, _omitFieldNames ? '' : 'remove')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EndorseUpliftApplicationRequest clone() =>
      EndorseUpliftApplicationRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EndorseUpliftApplicationRequest copyWith(
          void Function(EndorseUpliftApplicationRequest) updates) =>
      super.copyWith(
              (message) => updates(message as EndorseUpliftApplicationRequest))
          as EndorseUpliftApplicationRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EndorseUpliftApplicationRequest create() =>
      EndorseUpliftApplicationRequest._();
  @$core.override
  EndorseUpliftApplicationRequest createEmptyInstance() => create();
  static $pb.PbList<EndorseUpliftApplicationRequest> createRepeated() =>
      $pb.PbList<EndorseUpliftApplicationRequest>();
  @$core.pragma('dart2js:noInline')
  static EndorseUpliftApplicationRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EndorseUpliftApplicationRequest>(
          create);
  static EndorseUpliftApplicationRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get applicationId => $_getSZ(0);
  @$pb.TagNumber(1)
  set applicationId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasApplicationId() => $_has(0);
  @$pb.TagNumber(1)
  void clearApplicationId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get remove => $_getBF(1);
  @$pb.TagNumber(2)
  set remove($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRemove() => $_has(1);
  @$pb.TagNumber(2)
  void clearRemove() => $_clearField(2);
}

class EndorseUpliftApplicationResponse extends $pb.GeneratedMessage {
  factory EndorseUpliftApplicationResponse({
    $core.String? applicationId,
    $core.int? endorsementCount,
    $core.bool? endorsed,
  }) {
    final result = create();
    if (applicationId != null) result.applicationId = applicationId;
    if (endorsementCount != null) result.endorsementCount = endorsementCount;
    if (endorsed != null) result.endorsed = endorsed;
    return result;
  }

  EndorseUpliftApplicationResponse._();

  factory EndorseUpliftApplicationResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory EndorseUpliftApplicationResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EndorseUpliftApplicationResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'applicationId')
    ..a<$core.int>(
        2, _omitFieldNames ? '' : 'endorsementCount', $pb.PbFieldType.O3)
    ..aOB(3, _omitFieldNames ? '' : 'endorsed')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EndorseUpliftApplicationResponse clone() =>
      EndorseUpliftApplicationResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EndorseUpliftApplicationResponse copyWith(
          void Function(EndorseUpliftApplicationResponse) updates) =>
      super.copyWith(
              (message) => updates(message as EndorseUpliftApplicationResponse))
          as EndorseUpliftApplicationResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EndorseUpliftApplicationResponse create() =>
      EndorseUpliftApplicationResponse._();
  @$core.override
  EndorseUpliftApplicationResponse createEmptyInstance() => create();
  static $pb.PbList<EndorseUpliftApplicationResponse> createRepeated() =>
      $pb.PbList<EndorseUpliftApplicationResponse>();
  @$core.pragma('dart2js:noInline')
  static EndorseUpliftApplicationResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EndorseUpliftApplicationResponse>(
          create);
  static EndorseUpliftApplicationResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get applicationId => $_getSZ(0);
  @$pb.TagNumber(1)
  set applicationId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasApplicationId() => $_has(0);
  @$pb.TagNumber(1)
  void clearApplicationId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get endorsementCount => $_getIZ(1);
  @$pb.TagNumber(2)
  set endorsementCount($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasEndorsementCount() => $_has(1);
  @$pb.TagNumber(2)
  void clearEndorsementCount() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.bool get endorsed => $_getBF(2);
  @$pb.TagNumber(3)
  set endorsed($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasEndorsed() => $_has(2);
  @$pb.TagNumber(3)
  void clearEndorsed() => $_clearField(3);
}

class ReviewUpliftApplicationRequest extends $pb.GeneratedMessage {
  factory ReviewUpliftApplicationRequest({
    $core.String? applicationId,
    $core.String? action,
    $core.String? reason,
  }) {
    final result = create();
    if (applicationId != null) result.applicationId = applicationId;
    if (action != null) result.action = action;
    if (reason != null) result.reason = reason;
    return result;
  }

  ReviewUpliftApplicationRequest._();

  factory ReviewUpliftApplicationRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ReviewUpliftApplicationRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ReviewUpliftApplicationRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'applicationId')
    ..aOS(2, _omitFieldNames ? '' : 'action')
    ..aOS(3, _omitFieldNames ? '' : 'reason')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReviewUpliftApplicationRequest clone() =>
      ReviewUpliftApplicationRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReviewUpliftApplicationRequest copyWith(
          void Function(ReviewUpliftApplicationRequest) updates) =>
      super.copyWith(
              (message) => updates(message as ReviewUpliftApplicationRequest))
          as ReviewUpliftApplicationRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ReviewUpliftApplicationRequest create() =>
      ReviewUpliftApplicationRequest._();
  @$core.override
  ReviewUpliftApplicationRequest createEmptyInstance() => create();
  static $pb.PbList<ReviewUpliftApplicationRequest> createRepeated() =>
      $pb.PbList<ReviewUpliftApplicationRequest>();
  @$core.pragma('dart2js:noInline')
  static ReviewUpliftApplicationRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ReviewUpliftApplicationRequest>(create);
  static ReviewUpliftApplicationRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get applicationId => $_getSZ(0);
  @$pb.TagNumber(1)
  set applicationId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasApplicationId() => $_has(0);
  @$pb.TagNumber(1)
  void clearApplicationId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get action => $_getSZ(1);
  @$pb.TagNumber(2)
  set action($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAction() => $_has(1);
  @$pb.TagNumber(2)
  void clearAction() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get reason => $_getSZ(2);
  @$pb.TagNumber(3)
  set reason($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasReason() => $_has(2);
  @$pb.TagNumber(3)
  void clearReason() => $_clearField(3);
}

class ReviewUpliftApplicationResponse extends $pb.GeneratedMessage {
  factory ReviewUpliftApplicationResponse({
    UpliftApplicationMessage? application,
  }) {
    final result = create();
    if (application != null) result.application = application;
    return result;
  }

  ReviewUpliftApplicationResponse._();

  factory ReviewUpliftApplicationResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ReviewUpliftApplicationResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ReviewUpliftApplicationResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<UpliftApplicationMessage>(1, _omitFieldNames ? '' : 'application',
        subBuilder: UpliftApplicationMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReviewUpliftApplicationResponse clone() =>
      ReviewUpliftApplicationResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReviewUpliftApplicationResponse copyWith(
          void Function(ReviewUpliftApplicationResponse) updates) =>
      super.copyWith(
              (message) => updates(message as ReviewUpliftApplicationResponse))
          as ReviewUpliftApplicationResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ReviewUpliftApplicationResponse create() =>
      ReviewUpliftApplicationResponse._();
  @$core.override
  ReviewUpliftApplicationResponse createEmptyInstance() => create();
  static $pb.PbList<ReviewUpliftApplicationResponse> createRepeated() =>
      $pb.PbList<ReviewUpliftApplicationResponse>();
  @$core.pragma('dart2js:noInline')
  static ReviewUpliftApplicationResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ReviewUpliftApplicationResponse>(
          create);
  static ReviewUpliftApplicationResponse? _defaultInstance;

  @$pb.TagNumber(1)
  UpliftApplicationMessage get application => $_getN(0);
  @$pb.TagNumber(1)
  set application(UpliftApplicationMessage value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasApplication() => $_has(0);
  @$pb.TagNumber(1)
  void clearApplication() => $_clearField(1);
  @$pb.TagNumber(1)
  UpliftApplicationMessage ensureApplication() => $_ensure(0);
}

class UpliftMilestonePlanInput extends $pb.GeneratedMessage {
  factory UpliftMilestonePlanInput({
    $core.int? sequence,
    $core.String? title,
    $core.String? description,
    $fixnum.Int64? amount,
  }) {
    final result = create();
    if (sequence != null) result.sequence = sequence;
    if (title != null) result.title = title;
    if (description != null) result.description = description;
    if (amount != null) result.amount = amount;
    return result;
  }

  UpliftMilestonePlanInput._();

  factory UpliftMilestonePlanInput.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpliftMilestonePlanInput.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpliftMilestonePlanInput',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'sequence', $pb.PbFieldType.O3)
    ..aOS(2, _omitFieldNames ? '' : 'title')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..a<$fixnum.Int64>(4, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpliftMilestonePlanInput clone() =>
      UpliftMilestonePlanInput()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpliftMilestonePlanInput copyWith(
          void Function(UpliftMilestonePlanInput) updates) =>
      super.copyWith((message) => updates(message as UpliftMilestonePlanInput))
          as UpliftMilestonePlanInput;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpliftMilestonePlanInput create() => UpliftMilestonePlanInput._();
  @$core.override
  UpliftMilestonePlanInput createEmptyInstance() => create();
  static $pb.PbList<UpliftMilestonePlanInput> createRepeated() =>
      $pb.PbList<UpliftMilestonePlanInput>();
  @$core.pragma('dart2js:noInline')
  static UpliftMilestonePlanInput getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpliftMilestonePlanInput>(create);
  static UpliftMilestonePlanInput? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get sequence => $_getIZ(0);
  @$pb.TagNumber(1)
  set sequence($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSequence() => $_has(0);
  @$pb.TagNumber(1)
  void clearSequence() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get title => $_getSZ(1);
  @$pb.TagNumber(2)
  set title($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTitle() => $_has(1);
  @$pb.TagNumber(2)
  void clearTitle() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get amount => $_getI64(3);
  @$pb.TagNumber(4)
  set amount($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearAmount() => $_clearField(4);
}

class SelectUpliftApplicationRequest extends $pb.GeneratedMessage {
  factory SelectUpliftApplicationRequest({
    $core.String? applicationId,
    $fixnum.Int64? approvedAmount,
    $core.Iterable<UpliftMilestonePlanInput>? milestones,
    $core.int? offerExpiryHours,
    $core.String? note,
    $core.int? equityPct,
  }) {
    final result = create();
    if (applicationId != null) result.applicationId = applicationId;
    if (approvedAmount != null) result.approvedAmount = approvedAmount;
    if (milestones != null) result.milestones.addAll(milestones);
    if (offerExpiryHours != null) result.offerExpiryHours = offerExpiryHours;
    if (note != null) result.note = note;
    if (equityPct != null) result.equityPct = equityPct;
    return result;
  }

  SelectUpliftApplicationRequest._();

  factory SelectUpliftApplicationRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SelectUpliftApplicationRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SelectUpliftApplicationRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'applicationId')
    ..a<$fixnum.Int64>(
        2, _omitFieldNames ? '' : 'approvedAmount', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..pc<UpliftMilestonePlanInput>(
        3, _omitFieldNames ? '' : 'milestones', $pb.PbFieldType.PM,
        subBuilder: UpliftMilestonePlanInput.create)
    ..a<$core.int>(
        4, _omitFieldNames ? '' : 'offerExpiryHours', $pb.PbFieldType.O3)
    ..aOS(5, _omitFieldNames ? '' : 'note')
    ..a<$core.int>(6, _omitFieldNames ? '' : 'equityPct', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SelectUpliftApplicationRequest clone() =>
      SelectUpliftApplicationRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SelectUpliftApplicationRequest copyWith(
          void Function(SelectUpliftApplicationRequest) updates) =>
      super.copyWith(
              (message) => updates(message as SelectUpliftApplicationRequest))
          as SelectUpliftApplicationRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SelectUpliftApplicationRequest create() =>
      SelectUpliftApplicationRequest._();
  @$core.override
  SelectUpliftApplicationRequest createEmptyInstance() => create();
  static $pb.PbList<SelectUpliftApplicationRequest> createRepeated() =>
      $pb.PbList<SelectUpliftApplicationRequest>();
  @$core.pragma('dart2js:noInline')
  static SelectUpliftApplicationRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SelectUpliftApplicationRequest>(create);
  static SelectUpliftApplicationRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get applicationId => $_getSZ(0);
  @$pb.TagNumber(1)
  set applicationId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasApplicationId() => $_has(0);
  @$pb.TagNumber(1)
  void clearApplicationId() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get approvedAmount => $_getI64(1);
  @$pb.TagNumber(2)
  set approvedAmount($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasApprovedAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearApprovedAmount() => $_clearField(2);

  @$pb.TagNumber(3)
  $pb.PbList<UpliftMilestonePlanInput> get milestones => $_getList(2);

  @$pb.TagNumber(4)
  $core.int get offerExpiryHours => $_getIZ(3);
  @$pb.TagNumber(4)
  set offerExpiryHours($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasOfferExpiryHours() => $_has(3);
  @$pb.TagNumber(4)
  void clearOfferExpiryHours() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get note => $_getSZ(4);
  @$pb.TagNumber(5)
  set note($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasNote() => $_has(4);
  @$pb.TagNumber(5)
  void clearNote() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.int get equityPct => $_getIZ(5);
  @$pb.TagNumber(6)
  set equityPct($core.int value) => $_setUnsignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasEquityPct() => $_has(5);
  @$pb.TagNumber(6)
  void clearEquityPct() => $_clearField(6);
}

class SelectUpliftApplicationResponse extends $pb.GeneratedMessage {
  factory SelectUpliftApplicationResponse({
    UpliftApplicationMessage? application,
  }) {
    final result = create();
    if (application != null) result.application = application;
    return result;
  }

  SelectUpliftApplicationResponse._();

  factory SelectUpliftApplicationResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SelectUpliftApplicationResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SelectUpliftApplicationResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<UpliftApplicationMessage>(1, _omitFieldNames ? '' : 'application',
        subBuilder: UpliftApplicationMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SelectUpliftApplicationResponse clone() =>
      SelectUpliftApplicationResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SelectUpliftApplicationResponse copyWith(
          void Function(SelectUpliftApplicationResponse) updates) =>
      super.copyWith(
              (message) => updates(message as SelectUpliftApplicationResponse))
          as SelectUpliftApplicationResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SelectUpliftApplicationResponse create() =>
      SelectUpliftApplicationResponse._();
  @$core.override
  SelectUpliftApplicationResponse createEmptyInstance() => create();
  static $pb.PbList<SelectUpliftApplicationResponse> createRepeated() =>
      $pb.PbList<SelectUpliftApplicationResponse>();
  @$core.pragma('dart2js:noInline')
  static SelectUpliftApplicationResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SelectUpliftApplicationResponse>(
          create);
  static SelectUpliftApplicationResponse? _defaultInstance;

  @$pb.TagNumber(1)
  UpliftApplicationMessage get application => $_getN(0);
  @$pb.TagNumber(1)
  set application(UpliftApplicationMessage value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasApplication() => $_has(0);
  @$pb.TagNumber(1)
  void clearApplication() => $_clearField(1);
  @$pb.TagNumber(1)
  UpliftApplicationMessage ensureApplication() => $_ensure(0);
}

class RespondToUpliftOfferRequest extends $pb.GeneratedMessage {
  factory RespondToUpliftOfferRequest({
    $core.String? applicationId,
    $core.bool? accept,
    $core.String? reason,
    $core.String? businessAccountId,
    $core.bool? counter,
    $fixnum.Int64? counterAmount,
    $core.int? counterEquityPct,
    $core.String? counterNote,
  }) {
    final result = create();
    if (applicationId != null) result.applicationId = applicationId;
    if (accept != null) result.accept = accept;
    if (reason != null) result.reason = reason;
    if (businessAccountId != null) result.businessAccountId = businessAccountId;
    if (counter != null) result.counter = counter;
    if (counterAmount != null) result.counterAmount = counterAmount;
    if (counterEquityPct != null) result.counterEquityPct = counterEquityPct;
    if (counterNote != null) result.counterNote = counterNote;
    return result;
  }

  RespondToUpliftOfferRequest._();

  factory RespondToUpliftOfferRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RespondToUpliftOfferRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RespondToUpliftOfferRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'applicationId')
    ..aOB(2, _omitFieldNames ? '' : 'accept')
    ..aOS(3, _omitFieldNames ? '' : 'reason')
    ..aOS(4, _omitFieldNames ? '' : 'businessAccountId')
    ..aOB(5, _omitFieldNames ? '' : 'counter')
    ..a<$fixnum.Int64>(
        6, _omitFieldNames ? '' : 'counterAmount', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(
        7, _omitFieldNames ? '' : 'counterEquityPct', $pb.PbFieldType.OU3)
    ..aOS(8, _omitFieldNames ? '' : 'counterNote')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RespondToUpliftOfferRequest clone() =>
      RespondToUpliftOfferRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RespondToUpliftOfferRequest copyWith(
          void Function(RespondToUpliftOfferRequest) updates) =>
      super.copyWith(
              (message) => updates(message as RespondToUpliftOfferRequest))
          as RespondToUpliftOfferRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RespondToUpliftOfferRequest create() =>
      RespondToUpliftOfferRequest._();
  @$core.override
  RespondToUpliftOfferRequest createEmptyInstance() => create();
  static $pb.PbList<RespondToUpliftOfferRequest> createRepeated() =>
      $pb.PbList<RespondToUpliftOfferRequest>();
  @$core.pragma('dart2js:noInline')
  static RespondToUpliftOfferRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RespondToUpliftOfferRequest>(create);
  static RespondToUpliftOfferRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get applicationId => $_getSZ(0);
  @$pb.TagNumber(1)
  set applicationId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasApplicationId() => $_has(0);
  @$pb.TagNumber(1)
  void clearApplicationId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get accept => $_getBF(1);
  @$pb.TagNumber(2)
  set accept($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAccept() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccept() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get reason => $_getSZ(2);
  @$pb.TagNumber(3)
  set reason($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasReason() => $_has(2);
  @$pb.TagNumber(3)
  void clearReason() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get businessAccountId => $_getSZ(3);
  @$pb.TagNumber(4)
  set businessAccountId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasBusinessAccountId() => $_has(3);
  @$pb.TagNumber(4)
  void clearBusinessAccountId() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.bool get counter => $_getBF(4);
  @$pb.TagNumber(5)
  set counter($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasCounter() => $_has(4);
  @$pb.TagNumber(5)
  void clearCounter() => $_clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get counterAmount => $_getI64(5);
  @$pb.TagNumber(6)
  set counterAmount($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasCounterAmount() => $_has(5);
  @$pb.TagNumber(6)
  void clearCounterAmount() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.int get counterEquityPct => $_getIZ(6);
  @$pb.TagNumber(7)
  set counterEquityPct($core.int value) => $_setUnsignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasCounterEquityPct() => $_has(6);
  @$pb.TagNumber(7)
  void clearCounterEquityPct() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get counterNote => $_getSZ(7);
  @$pb.TagNumber(8)
  set counterNote($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasCounterNote() => $_has(7);
  @$pb.TagNumber(8)
  void clearCounterNote() => $_clearField(8);
}

class RespondToUpliftOfferResponse extends $pb.GeneratedMessage {
  factory RespondToUpliftOfferResponse({
    UpliftApplicationMessage? application,
  }) {
    final result = create();
    if (application != null) result.application = application;
    return result;
  }

  RespondToUpliftOfferResponse._();

  factory RespondToUpliftOfferResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RespondToUpliftOfferResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RespondToUpliftOfferResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<UpliftApplicationMessage>(1, _omitFieldNames ? '' : 'application',
        subBuilder: UpliftApplicationMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RespondToUpliftOfferResponse clone() =>
      RespondToUpliftOfferResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RespondToUpliftOfferResponse copyWith(
          void Function(RespondToUpliftOfferResponse) updates) =>
      super.copyWith(
              (message) => updates(message as RespondToUpliftOfferResponse))
          as RespondToUpliftOfferResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RespondToUpliftOfferResponse create() =>
      RespondToUpliftOfferResponse._();
  @$core.override
  RespondToUpliftOfferResponse createEmptyInstance() => create();
  static $pb.PbList<RespondToUpliftOfferResponse> createRepeated() =>
      $pb.PbList<RespondToUpliftOfferResponse>();
  @$core.pragma('dart2js:noInline')
  static RespondToUpliftOfferResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RespondToUpliftOfferResponse>(create);
  static RespondToUpliftOfferResponse? _defaultInstance;

  @$pb.TagNumber(1)
  UpliftApplicationMessage get application => $_getN(0);
  @$pb.TagNumber(1)
  set application(UpliftApplicationMessage value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasApplication() => $_has(0);
  @$pb.TagNumber(1)
  void clearApplication() => $_clearField(1);
  @$pb.TagNumber(1)
  UpliftApplicationMessage ensureApplication() => $_ensure(0);
}

class SubmitMilestoneEvidenceRequest extends $pb.GeneratedMessage {
  factory SubmitMilestoneEvidenceRequest({
    $core.String? milestoneId,
    $core.Iterable<$core.String>? evidence,
    $core.String? note,
  }) {
    final result = create();
    if (milestoneId != null) result.milestoneId = milestoneId;
    if (evidence != null) result.evidence.addAll(evidence);
    if (note != null) result.note = note;
    return result;
  }

  SubmitMilestoneEvidenceRequest._();

  factory SubmitMilestoneEvidenceRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SubmitMilestoneEvidenceRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SubmitMilestoneEvidenceRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'milestoneId')
    ..pPS(2, _omitFieldNames ? '' : 'evidence')
    ..aOS(3, _omitFieldNames ? '' : 'note')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubmitMilestoneEvidenceRequest clone() =>
      SubmitMilestoneEvidenceRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubmitMilestoneEvidenceRequest copyWith(
          void Function(SubmitMilestoneEvidenceRequest) updates) =>
      super.copyWith(
              (message) => updates(message as SubmitMilestoneEvidenceRequest))
          as SubmitMilestoneEvidenceRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SubmitMilestoneEvidenceRequest create() =>
      SubmitMilestoneEvidenceRequest._();
  @$core.override
  SubmitMilestoneEvidenceRequest createEmptyInstance() => create();
  static $pb.PbList<SubmitMilestoneEvidenceRequest> createRepeated() =>
      $pb.PbList<SubmitMilestoneEvidenceRequest>();
  @$core.pragma('dart2js:noInline')
  static SubmitMilestoneEvidenceRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SubmitMilestoneEvidenceRequest>(create);
  static SubmitMilestoneEvidenceRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get milestoneId => $_getSZ(0);
  @$pb.TagNumber(1)
  set milestoneId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMilestoneId() => $_has(0);
  @$pb.TagNumber(1)
  void clearMilestoneId() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<$core.String> get evidence => $_getList(1);

  @$pb.TagNumber(3)
  $core.String get note => $_getSZ(2);
  @$pb.TagNumber(3)
  set note($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasNote() => $_has(2);
  @$pb.TagNumber(3)
  void clearNote() => $_clearField(3);
}

class SubmitMilestoneEvidenceResponse extends $pb.GeneratedMessage {
  factory SubmitMilestoneEvidenceResponse({
    UpliftMilestoneMessage? milestone,
  }) {
    final result = create();
    if (milestone != null) result.milestone = milestone;
    return result;
  }

  SubmitMilestoneEvidenceResponse._();

  factory SubmitMilestoneEvidenceResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SubmitMilestoneEvidenceResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SubmitMilestoneEvidenceResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<UpliftMilestoneMessage>(1, _omitFieldNames ? '' : 'milestone',
        subBuilder: UpliftMilestoneMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubmitMilestoneEvidenceResponse clone() =>
      SubmitMilestoneEvidenceResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubmitMilestoneEvidenceResponse copyWith(
          void Function(SubmitMilestoneEvidenceResponse) updates) =>
      super.copyWith(
              (message) => updates(message as SubmitMilestoneEvidenceResponse))
          as SubmitMilestoneEvidenceResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SubmitMilestoneEvidenceResponse create() =>
      SubmitMilestoneEvidenceResponse._();
  @$core.override
  SubmitMilestoneEvidenceResponse createEmptyInstance() => create();
  static $pb.PbList<SubmitMilestoneEvidenceResponse> createRepeated() =>
      $pb.PbList<SubmitMilestoneEvidenceResponse>();
  @$core.pragma('dart2js:noInline')
  static SubmitMilestoneEvidenceResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SubmitMilestoneEvidenceResponse>(
          create);
  static SubmitMilestoneEvidenceResponse? _defaultInstance;

  @$pb.TagNumber(1)
  UpliftMilestoneMessage get milestone => $_getN(0);
  @$pb.TagNumber(1)
  set milestone(UpliftMilestoneMessage value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasMilestone() => $_has(0);
  @$pb.TagNumber(1)
  void clearMilestone() => $_clearField(1);
  @$pb.TagNumber(1)
  UpliftMilestoneMessage ensureMilestone() => $_ensure(0);
}

class ReviewMilestoneRequest extends $pb.GeneratedMessage {
  factory ReviewMilestoneRequest({
    $core.String? milestoneId,
    $core.bool? approve,
    $core.String? reason,
    $core.String? transactionPin,
    $core.String? transactionId,
  }) {
    final result = create();
    if (milestoneId != null) result.milestoneId = milestoneId;
    if (approve != null) result.approve = approve;
    if (reason != null) result.reason = reason;
    if (transactionPin != null) result.transactionPin = transactionPin;
    if (transactionId != null) result.transactionId = transactionId;
    return result;
  }

  ReviewMilestoneRequest._();

  factory ReviewMilestoneRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ReviewMilestoneRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ReviewMilestoneRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'milestoneId')
    ..aOB(2, _omitFieldNames ? '' : 'approve')
    ..aOS(3, _omitFieldNames ? '' : 'reason')
    ..aOS(4, _omitFieldNames ? '' : 'transactionPin')
    ..aOS(5, _omitFieldNames ? '' : 'transactionId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReviewMilestoneRequest clone() =>
      ReviewMilestoneRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReviewMilestoneRequest copyWith(
          void Function(ReviewMilestoneRequest) updates) =>
      super.copyWith((message) => updates(message as ReviewMilestoneRequest))
          as ReviewMilestoneRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ReviewMilestoneRequest create() => ReviewMilestoneRequest._();
  @$core.override
  ReviewMilestoneRequest createEmptyInstance() => create();
  static $pb.PbList<ReviewMilestoneRequest> createRepeated() =>
      $pb.PbList<ReviewMilestoneRequest>();
  @$core.pragma('dart2js:noInline')
  static ReviewMilestoneRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ReviewMilestoneRequest>(create);
  static ReviewMilestoneRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get milestoneId => $_getSZ(0);
  @$pb.TagNumber(1)
  set milestoneId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMilestoneId() => $_has(0);
  @$pb.TagNumber(1)
  void clearMilestoneId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get approve => $_getBF(1);
  @$pb.TagNumber(2)
  set approve($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasApprove() => $_has(1);
  @$pb.TagNumber(2)
  void clearApprove() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get reason => $_getSZ(2);
  @$pb.TagNumber(3)
  set reason($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasReason() => $_has(2);
  @$pb.TagNumber(3)
  void clearReason() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get transactionPin => $_getSZ(3);
  @$pb.TagNumber(4)
  set transactionPin($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTransactionPin() => $_has(3);
  @$pb.TagNumber(4)
  void clearTransactionPin() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get transactionId => $_getSZ(4);
  @$pb.TagNumber(5)
  set transactionId($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTransactionId() => $_has(4);
  @$pb.TagNumber(5)
  void clearTransactionId() => $_clearField(5);
}

class ReviewMilestoneResponse extends $pb.GeneratedMessage {
  factory ReviewMilestoneResponse({
    UpliftMilestoneMessage? milestone,
    $core.String? releaseId,
    $core.String? message,
  }) {
    final result = create();
    if (milestone != null) result.milestone = milestone;
    if (releaseId != null) result.releaseId = releaseId;
    if (message != null) result.message = message;
    return result;
  }

  ReviewMilestoneResponse._();

  factory ReviewMilestoneResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ReviewMilestoneResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ReviewMilestoneResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<UpliftMilestoneMessage>(1, _omitFieldNames ? '' : 'milestone',
        subBuilder: UpliftMilestoneMessage.create)
    ..aOS(2, _omitFieldNames ? '' : 'releaseId')
    ..aOS(3, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReviewMilestoneResponse clone() =>
      ReviewMilestoneResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReviewMilestoneResponse copyWith(
          void Function(ReviewMilestoneResponse) updates) =>
      super.copyWith((message) => updates(message as ReviewMilestoneResponse))
          as ReviewMilestoneResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ReviewMilestoneResponse create() => ReviewMilestoneResponse._();
  @$core.override
  ReviewMilestoneResponse createEmptyInstance() => create();
  static $pb.PbList<ReviewMilestoneResponse> createRepeated() =>
      $pb.PbList<ReviewMilestoneResponse>();
  @$core.pragma('dart2js:noInline')
  static ReviewMilestoneResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ReviewMilestoneResponse>(create);
  static ReviewMilestoneResponse? _defaultInstance;

  @$pb.TagNumber(1)
  UpliftMilestoneMessage get milestone => $_getN(0);
  @$pb.TagNumber(1)
  set milestone(UpliftMilestoneMessage value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasMilestone() => $_has(0);
  @$pb.TagNumber(1)
  void clearMilestone() => $_clearField(1);
  @$pb.TagNumber(1)
  UpliftMilestoneMessage ensureMilestone() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get releaseId => $_getSZ(1);
  @$pb.TagNumber(2)
  set releaseId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasReleaseId() => $_has(1);
  @$pb.TagNumber(2)
  void clearReleaseId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => $_clearField(3);
}

class ListUpliftMilestoneReleasesRequest extends $pb.GeneratedMessage {
  factory ListUpliftMilestoneReleasesRequest({
    $core.String? fundId,
    $core.String? applicationId,
    $core.String? status,
    $core.int? page,
    $core.int? pageSize,
  }) {
    final result = create();
    if (fundId != null) result.fundId = fundId;
    if (applicationId != null) result.applicationId = applicationId;
    if (status != null) result.status = status;
    if (page != null) result.page = page;
    if (pageSize != null) result.pageSize = pageSize;
    return result;
  }

  ListUpliftMilestoneReleasesRequest._();

  factory ListUpliftMilestoneReleasesRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListUpliftMilestoneReleasesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListUpliftMilestoneReleasesRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'fundId')
    ..aOS(2, _omitFieldNames ? '' : 'applicationId')
    ..aOS(3, _omitFieldNames ? '' : 'status')
    ..a<$core.int>(4, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListUpliftMilestoneReleasesRequest clone() =>
      ListUpliftMilestoneReleasesRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListUpliftMilestoneReleasesRequest copyWith(
          void Function(ListUpliftMilestoneReleasesRequest) updates) =>
      super.copyWith((message) =>
              updates(message as ListUpliftMilestoneReleasesRequest))
          as ListUpliftMilestoneReleasesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListUpliftMilestoneReleasesRequest create() =>
      ListUpliftMilestoneReleasesRequest._();
  @$core.override
  ListUpliftMilestoneReleasesRequest createEmptyInstance() => create();
  static $pb.PbList<ListUpliftMilestoneReleasesRequest> createRepeated() =>
      $pb.PbList<ListUpliftMilestoneReleasesRequest>();
  @$core.pragma('dart2js:noInline')
  static ListUpliftMilestoneReleasesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListUpliftMilestoneReleasesRequest>(
          create);
  static ListUpliftMilestoneReleasesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get fundId => $_getSZ(0);
  @$pb.TagNumber(1)
  set fundId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFundId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFundId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get applicationId => $_getSZ(1);
  @$pb.TagNumber(2)
  set applicationId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasApplicationId() => $_has(1);
  @$pb.TagNumber(2)
  void clearApplicationId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get status => $_getSZ(2);
  @$pb.TagNumber(3)
  set status($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasStatus() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatus() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get page => $_getIZ(3);
  @$pb.TagNumber(4)
  set page($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPage() => $_has(3);
  @$pb.TagNumber(4)
  void clearPage() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get pageSize => $_getIZ(4);
  @$pb.TagNumber(5)
  set pageSize($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasPageSize() => $_has(4);
  @$pb.TagNumber(5)
  void clearPageSize() => $_clearField(5);
}

class ListUpliftMilestoneReleasesResponse extends $pb.GeneratedMessage {
  factory ListUpliftMilestoneReleasesResponse({
    $core.Iterable<UpliftMilestoneReleaseRecord>? releases,
    $core.int? total,
    $core.int? page,
    $core.int? pageSize,
    $core.bool? hasMore,
  }) {
    final result = create();
    if (releases != null) result.releases.addAll(releases);
    if (total != null) result.total = total;
    if (page != null) result.page = page;
    if (pageSize != null) result.pageSize = pageSize;
    if (hasMore != null) result.hasMore = hasMore;
    return result;
  }

  ListUpliftMilestoneReleasesResponse._();

  factory ListUpliftMilestoneReleasesResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListUpliftMilestoneReleasesResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListUpliftMilestoneReleasesResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<UpliftMilestoneReleaseRecord>(
        1, _omitFieldNames ? '' : 'releases', $pb.PbFieldType.PM,
        subBuilder: UpliftMilestoneReleaseRecord.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOB(5, _omitFieldNames ? '' : 'hasMore')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListUpliftMilestoneReleasesResponse clone() =>
      ListUpliftMilestoneReleasesResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListUpliftMilestoneReleasesResponse copyWith(
          void Function(ListUpliftMilestoneReleasesResponse) updates) =>
      super.copyWith((message) =>
              updates(message as ListUpliftMilestoneReleasesResponse))
          as ListUpliftMilestoneReleasesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListUpliftMilestoneReleasesResponse create() =>
      ListUpliftMilestoneReleasesResponse._();
  @$core.override
  ListUpliftMilestoneReleasesResponse createEmptyInstance() => create();
  static $pb.PbList<ListUpliftMilestoneReleasesResponse> createRepeated() =>
      $pb.PbList<ListUpliftMilestoneReleasesResponse>();
  @$core.pragma('dart2js:noInline')
  static ListUpliftMilestoneReleasesResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          ListUpliftMilestoneReleasesResponse>(create);
  static ListUpliftMilestoneReleasesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<UpliftMilestoneReleaseRecord> get releases => $_getList(0);

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
  $core.int get pageSize => $_getIZ(3);
  @$pb.TagNumber(4)
  set pageSize($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPageSize() => $_has(3);
  @$pb.TagNumber(4)
  void clearPageSize() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.bool get hasMore => $_getBF(4);
  @$pb.TagNumber(5)
  set hasMore($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasHasMore() => $_has(4);
  @$pb.TagNumber(5)
  void clearHasMore() => $_clearField(5);
}

class ListUpliftEscrowRefundsRequest extends $pb.GeneratedMessage {
  factory ListUpliftEscrowRefundsRequest({
    $core.String? fundId,
    $core.String? status,
    $core.int? page,
    $core.int? pageSize,
  }) {
    final result = create();
    if (fundId != null) result.fundId = fundId;
    if (status != null) result.status = status;
    if (page != null) result.page = page;
    if (pageSize != null) result.pageSize = pageSize;
    return result;
  }

  ListUpliftEscrowRefundsRequest._();

  factory ListUpliftEscrowRefundsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListUpliftEscrowRefundsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListUpliftEscrowRefundsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'fundId')
    ..aOS(2, _omitFieldNames ? '' : 'status')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListUpliftEscrowRefundsRequest clone() =>
      ListUpliftEscrowRefundsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListUpliftEscrowRefundsRequest copyWith(
          void Function(ListUpliftEscrowRefundsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as ListUpliftEscrowRefundsRequest))
          as ListUpliftEscrowRefundsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListUpliftEscrowRefundsRequest create() =>
      ListUpliftEscrowRefundsRequest._();
  @$core.override
  ListUpliftEscrowRefundsRequest createEmptyInstance() => create();
  static $pb.PbList<ListUpliftEscrowRefundsRequest> createRepeated() =>
      $pb.PbList<ListUpliftEscrowRefundsRequest>();
  @$core.pragma('dart2js:noInline')
  static ListUpliftEscrowRefundsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListUpliftEscrowRefundsRequest>(create);
  static ListUpliftEscrowRefundsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get fundId => $_getSZ(0);
  @$pb.TagNumber(1)
  set fundId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFundId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFundId() => $_clearField(1);

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
  $core.int get pageSize => $_getIZ(3);
  @$pb.TagNumber(4)
  set pageSize($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPageSize() => $_has(3);
  @$pb.TagNumber(4)
  void clearPageSize() => $_clearField(4);
}

class ListUpliftEscrowRefundsResponse extends $pb.GeneratedMessage {
  factory ListUpliftEscrowRefundsResponse({
    $core.Iterable<UpliftEscrowRefundRecord>? refunds,
    $core.int? total,
    $core.int? page,
    $core.int? pageSize,
    $core.bool? hasMore,
  }) {
    final result = create();
    if (refunds != null) result.refunds.addAll(refunds);
    if (total != null) result.total = total;
    if (page != null) result.page = page;
    if (pageSize != null) result.pageSize = pageSize;
    if (hasMore != null) result.hasMore = hasMore;
    return result;
  }

  ListUpliftEscrowRefundsResponse._();

  factory ListUpliftEscrowRefundsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListUpliftEscrowRefundsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListUpliftEscrowRefundsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<UpliftEscrowRefundRecord>(
        1, _omitFieldNames ? '' : 'refunds', $pb.PbFieldType.PM,
        subBuilder: UpliftEscrowRefundRecord.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOB(5, _omitFieldNames ? '' : 'hasMore')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListUpliftEscrowRefundsResponse clone() =>
      ListUpliftEscrowRefundsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListUpliftEscrowRefundsResponse copyWith(
          void Function(ListUpliftEscrowRefundsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as ListUpliftEscrowRefundsResponse))
          as ListUpliftEscrowRefundsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListUpliftEscrowRefundsResponse create() =>
      ListUpliftEscrowRefundsResponse._();
  @$core.override
  ListUpliftEscrowRefundsResponse createEmptyInstance() => create();
  static $pb.PbList<ListUpliftEscrowRefundsResponse> createRepeated() =>
      $pb.PbList<ListUpliftEscrowRefundsResponse>();
  @$core.pragma('dart2js:noInline')
  static ListUpliftEscrowRefundsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListUpliftEscrowRefundsResponse>(
          create);
  static ListUpliftEscrowRefundsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<UpliftEscrowRefundRecord> get refunds => $_getList(0);

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
  $core.int get pageSize => $_getIZ(3);
  @$pb.TagNumber(4)
  set pageSize($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPageSize() => $_has(3);
  @$pb.TagNumber(4)
  void clearPageSize() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.bool get hasMore => $_getBF(4);
  @$pb.TagNumber(5)
  set hasMore($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasHasMore() => $_has(4);
  @$pb.TagNumber(5)
  void clearHasMore() => $_clearField(5);
}

class GetUpliftReceiptRequest extends $pb.GeneratedMessage {
  factory GetUpliftReceiptRequest({
    $core.String? referenceId,
    $core.String? referenceType,
  }) {
    final result = create();
    if (referenceId != null) result.referenceId = referenceId;
    if (referenceType != null) result.referenceType = referenceType;
    return result;
  }

  GetUpliftReceiptRequest._();

  factory GetUpliftReceiptRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetUpliftReceiptRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUpliftReceiptRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'referenceId')
    ..aOS(2, _omitFieldNames ? '' : 'referenceType')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUpliftReceiptRequest clone() =>
      GetUpliftReceiptRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUpliftReceiptRequest copyWith(
          void Function(GetUpliftReceiptRequest) updates) =>
      super.copyWith((message) => updates(message as GetUpliftReceiptRequest))
          as GetUpliftReceiptRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUpliftReceiptRequest create() => GetUpliftReceiptRequest._();
  @$core.override
  GetUpliftReceiptRequest createEmptyInstance() => create();
  static $pb.PbList<GetUpliftReceiptRequest> createRepeated() =>
      $pb.PbList<GetUpliftReceiptRequest>();
  @$core.pragma('dart2js:noInline')
  static GetUpliftReceiptRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetUpliftReceiptRequest>(create);
  static GetUpliftReceiptRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get referenceId => $_getSZ(0);
  @$pb.TagNumber(1)
  set referenceId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasReferenceId() => $_has(0);
  @$pb.TagNumber(1)
  void clearReferenceId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get referenceType => $_getSZ(1);
  @$pb.TagNumber(2)
  set referenceType($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasReferenceType() => $_has(1);
  @$pb.TagNumber(2)
  void clearReferenceType() => $_clearField(2);
}

class GetUpliftReceiptResponse extends $pb.GeneratedMessage {
  factory GetUpliftReceiptResponse({
    UpliftReceiptMessage? receipt,
  }) {
    final result = create();
    if (receipt != null) result.receipt = receipt;
    return result;
  }

  GetUpliftReceiptResponse._();

  factory GetUpliftReceiptResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetUpliftReceiptResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUpliftReceiptResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<UpliftReceiptMessage>(1, _omitFieldNames ? '' : 'receipt',
        subBuilder: UpliftReceiptMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUpliftReceiptResponse clone() =>
      GetUpliftReceiptResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUpliftReceiptResponse copyWith(
          void Function(GetUpliftReceiptResponse) updates) =>
      super.copyWith((message) => updates(message as GetUpliftReceiptResponse))
          as GetUpliftReceiptResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUpliftReceiptResponse create() => GetUpliftReceiptResponse._();
  @$core.override
  GetUpliftReceiptResponse createEmptyInstance() => create();
  static $pb.PbList<GetUpliftReceiptResponse> createRepeated() =>
      $pb.PbList<GetUpliftReceiptResponse>();
  @$core.pragma('dart2js:noInline')
  static GetUpliftReceiptResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetUpliftReceiptResponse>(create);
  static GetUpliftReceiptResponse? _defaultInstance;

  @$pb.TagNumber(1)
  UpliftReceiptMessage get receipt => $_getN(0);
  @$pb.TagNumber(1)
  set receipt(UpliftReceiptMessage value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasReceipt() => $_has(0);
  @$pb.TagNumber(1)
  void clearReceipt() => $_clearField(1);
  @$pb.TagNumber(1)
  UpliftReceiptMessage ensureReceipt() => $_ensure(0);
}

class ListUpliftReceiptsRequest extends $pb.GeneratedMessage {
  factory ListUpliftReceiptsRequest({
    $core.int? page,
    $core.int? pageSize,
  }) {
    final result = create();
    if (page != null) result.page = page;
    if (pageSize != null) result.pageSize = pageSize;
    return result;
  }

  ListUpliftReceiptsRequest._();

  factory ListUpliftReceiptsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListUpliftReceiptsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListUpliftReceiptsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListUpliftReceiptsRequest clone() =>
      ListUpliftReceiptsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListUpliftReceiptsRequest copyWith(
          void Function(ListUpliftReceiptsRequest) updates) =>
      super.copyWith((message) => updates(message as ListUpliftReceiptsRequest))
          as ListUpliftReceiptsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListUpliftReceiptsRequest create() => ListUpliftReceiptsRequest._();
  @$core.override
  ListUpliftReceiptsRequest createEmptyInstance() => create();
  static $pb.PbList<ListUpliftReceiptsRequest> createRepeated() =>
      $pb.PbList<ListUpliftReceiptsRequest>();
  @$core.pragma('dart2js:noInline')
  static ListUpliftReceiptsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListUpliftReceiptsRequest>(create);
  static ListUpliftReceiptsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get page => $_getIZ(0);
  @$pb.TagNumber(1)
  set page($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearPage() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get pageSize => $_getIZ(1);
  @$pb.TagNumber(2)
  set pageSize($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPageSize() => $_has(1);
  @$pb.TagNumber(2)
  void clearPageSize() => $_clearField(2);
}

class ListUpliftReceiptsResponse extends $pb.GeneratedMessage {
  factory ListUpliftReceiptsResponse({
    $core.Iterable<UpliftReceiptMessage>? receipts,
    UpliftPaginationInfo? pagination,
  }) {
    final result = create();
    if (receipts != null) result.receipts.addAll(receipts);
    if (pagination != null) result.pagination = pagination;
    return result;
  }

  ListUpliftReceiptsResponse._();

  factory ListUpliftReceiptsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListUpliftReceiptsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListUpliftReceiptsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<UpliftReceiptMessage>(
        1, _omitFieldNames ? '' : 'receipts', $pb.PbFieldType.PM,
        subBuilder: UpliftReceiptMessage.create)
    ..aOM<UpliftPaginationInfo>(2, _omitFieldNames ? '' : 'pagination',
        subBuilder: UpliftPaginationInfo.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListUpliftReceiptsResponse clone() =>
      ListUpliftReceiptsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListUpliftReceiptsResponse copyWith(
          void Function(ListUpliftReceiptsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as ListUpliftReceiptsResponse))
          as ListUpliftReceiptsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListUpliftReceiptsResponse create() => ListUpliftReceiptsResponse._();
  @$core.override
  ListUpliftReceiptsResponse createEmptyInstance() => create();
  static $pb.PbList<ListUpliftReceiptsResponse> createRepeated() =>
      $pb.PbList<ListUpliftReceiptsResponse>();
  @$core.pragma('dart2js:noInline')
  static ListUpliftReceiptsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListUpliftReceiptsResponse>(create);
  static ListUpliftReceiptsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<UpliftReceiptMessage> get receipts => $_getList(0);

  @$pb.TagNumber(2)
  UpliftPaginationInfo get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination(UpliftPaginationInfo value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => $_clearField(2);
  @$pb.TagNumber(2)
  UpliftPaginationInfo ensurePagination() => $_ensure(1);
}

class GetUpliftFeeQuoteRequest extends $pb.GeneratedMessage {
  factory GetUpliftFeeQuoteRequest({
    $fixnum.Int64? amount,
  }) {
    final result = create();
    if (amount != null) result.amount = amount;
    return result;
  }

  GetUpliftFeeQuoteRequest._();

  factory GetUpliftFeeQuoteRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetUpliftFeeQuoteRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUpliftFeeQuoteRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUpliftFeeQuoteRequest clone() =>
      GetUpliftFeeQuoteRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUpliftFeeQuoteRequest copyWith(
          void Function(GetUpliftFeeQuoteRequest) updates) =>
      super.copyWith((message) => updates(message as GetUpliftFeeQuoteRequest))
          as GetUpliftFeeQuoteRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUpliftFeeQuoteRequest create() => GetUpliftFeeQuoteRequest._();
  @$core.override
  GetUpliftFeeQuoteRequest createEmptyInstance() => create();
  static $pb.PbList<GetUpliftFeeQuoteRequest> createRepeated() =>
      $pb.PbList<GetUpliftFeeQuoteRequest>();
  @$core.pragma('dart2js:noInline')
  static GetUpliftFeeQuoteRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetUpliftFeeQuoteRequest>(create);
  static GetUpliftFeeQuoteRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get amount => $_getI64(0);
  @$pb.TagNumber(1)
  set amount($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAmount() => $_has(0);
  @$pb.TagNumber(1)
  void clearAmount() => $_clearField(1);
}

class GetUpliftFeeQuoteResponse extends $pb.GeneratedMessage {
  factory GetUpliftFeeQuoteResponse({
    $fixnum.Int64? gross,
    $fixnum.Int64? fee,
    $fixnum.Int64? net,
    $core.bool? feeEnabled,
    $core.String? feeType,
    $core.int? feePercentageBps,
    $fixnum.Int64? feeFixedKobo,
  }) {
    final result = create();
    if (gross != null) result.gross = gross;
    if (fee != null) result.fee = fee;
    if (net != null) result.net = net;
    if (feeEnabled != null) result.feeEnabled = feeEnabled;
    if (feeType != null) result.feeType = feeType;
    if (feePercentageBps != null) result.feePercentageBps = feePercentageBps;
    if (feeFixedKobo != null) result.feeFixedKobo = feeFixedKobo;
    return result;
  }

  GetUpliftFeeQuoteResponse._();

  factory GetUpliftFeeQuoteResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetUpliftFeeQuoteResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUpliftFeeQuoteResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'gross', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'fee', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'net', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOB(4, _omitFieldNames ? '' : 'feeEnabled')
    ..aOS(5, _omitFieldNames ? '' : 'feeType')
    ..a<$core.int>(
        6, _omitFieldNames ? '' : 'feePercentageBps', $pb.PbFieldType.OU3)
    ..a<$fixnum.Int64>(
        7, _omitFieldNames ? '' : 'feeFixedKobo', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUpliftFeeQuoteResponse clone() =>
      GetUpliftFeeQuoteResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUpliftFeeQuoteResponse copyWith(
          void Function(GetUpliftFeeQuoteResponse) updates) =>
      super.copyWith((message) => updates(message as GetUpliftFeeQuoteResponse))
          as GetUpliftFeeQuoteResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUpliftFeeQuoteResponse create() => GetUpliftFeeQuoteResponse._();
  @$core.override
  GetUpliftFeeQuoteResponse createEmptyInstance() => create();
  static $pb.PbList<GetUpliftFeeQuoteResponse> createRepeated() =>
      $pb.PbList<GetUpliftFeeQuoteResponse>();
  @$core.pragma('dart2js:noInline')
  static GetUpliftFeeQuoteResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetUpliftFeeQuoteResponse>(create);
  static GetUpliftFeeQuoteResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get gross => $_getI64(0);
  @$pb.TagNumber(1)
  set gross($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasGross() => $_has(0);
  @$pb.TagNumber(1)
  void clearGross() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get fee => $_getI64(1);
  @$pb.TagNumber(2)
  set fee($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasFee() => $_has(1);
  @$pb.TagNumber(2)
  void clearFee() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get net => $_getI64(2);
  @$pb.TagNumber(3)
  set net($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasNet() => $_has(2);
  @$pb.TagNumber(3)
  void clearNet() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.bool get feeEnabled => $_getBF(3);
  @$pb.TagNumber(4)
  set feeEnabled($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasFeeEnabled() => $_has(3);
  @$pb.TagNumber(4)
  void clearFeeEnabled() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get feeType => $_getSZ(4);
  @$pb.TagNumber(5)
  set feeType($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasFeeType() => $_has(4);
  @$pb.TagNumber(5)
  void clearFeeType() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.int get feePercentageBps => $_getIZ(5);
  @$pb.TagNumber(6)
  set feePercentageBps($core.int value) => $_setUnsignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasFeePercentageBps() => $_has(5);
  @$pb.TagNumber(6)
  void clearFeePercentageBps() => $_clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get feeFixedKobo => $_getI64(6);
  @$pb.TagNumber(7)
  set feeFixedKobo($fixnum.Int64 value) => $_setInt64(6, value);
  @$pb.TagNumber(7)
  $core.bool hasFeeFixedKobo() => $_has(6);
  @$pb.TagNumber(7)
  void clearFeeFixedKobo() => $_clearField(7);
}

class GetUpliftStatisticsRequest extends $pb.GeneratedMessage {
  factory GetUpliftStatisticsRequest({
    $core.String? fundId,
  }) {
    final result = create();
    if (fundId != null) result.fundId = fundId;
    return result;
  }

  GetUpliftStatisticsRequest._();

  factory GetUpliftStatisticsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetUpliftStatisticsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUpliftStatisticsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'fundId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUpliftStatisticsRequest clone() =>
      GetUpliftStatisticsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUpliftStatisticsRequest copyWith(
          void Function(GetUpliftStatisticsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetUpliftStatisticsRequest))
          as GetUpliftStatisticsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUpliftStatisticsRequest create() => GetUpliftStatisticsRequest._();
  @$core.override
  GetUpliftStatisticsRequest createEmptyInstance() => create();
  static $pb.PbList<GetUpliftStatisticsRequest> createRepeated() =>
      $pb.PbList<GetUpliftStatisticsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetUpliftStatisticsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetUpliftStatisticsRequest>(create);
  static GetUpliftStatisticsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get fundId => $_getSZ(0);
  @$pb.TagNumber(1)
  set fundId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFundId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFundId() => $_clearField(1);
}

class GetUpliftStatisticsResponse extends $pb.GeneratedMessage {
  factory GetUpliftStatisticsResponse({
    $core.String? fundId,
    $fixnum.Int64? committedPool,
    $fixnum.Int64? releasedTotal,
    $fixnum.Int64? refundedTotal,
    $fixnum.Int64? escrowAvailable,
    $core.int? targetCount,
    $core.int? applicationCount,
    $core.int? selectedCount,
    $core.int? completedCount,
    $core.int? endorsementCount,
    $core.double? fundedPercentage,
    $core.int? daysRemaining,
    $core.String? currency,
  }) {
    final result = create();
    if (fundId != null) result.fundId = fundId;
    if (committedPool != null) result.committedPool = committedPool;
    if (releasedTotal != null) result.releasedTotal = releasedTotal;
    if (refundedTotal != null) result.refundedTotal = refundedTotal;
    if (escrowAvailable != null) result.escrowAvailable = escrowAvailable;
    if (targetCount != null) result.targetCount = targetCount;
    if (applicationCount != null) result.applicationCount = applicationCount;
    if (selectedCount != null) result.selectedCount = selectedCount;
    if (completedCount != null) result.completedCount = completedCount;
    if (endorsementCount != null) result.endorsementCount = endorsementCount;
    if (fundedPercentage != null) result.fundedPercentage = fundedPercentage;
    if (daysRemaining != null) result.daysRemaining = daysRemaining;
    if (currency != null) result.currency = currency;
    return result;
  }

  GetUpliftStatisticsResponse._();

  factory GetUpliftStatisticsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetUpliftStatisticsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUpliftStatisticsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'fundId')
    ..a<$fixnum.Int64>(
        2, _omitFieldNames ? '' : 'committedPool', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(
        3, _omitFieldNames ? '' : 'releasedTotal', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(
        4, _omitFieldNames ? '' : 'refundedTotal', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(
        5, _omitFieldNames ? '' : 'escrowAvailable', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(6, _omitFieldNames ? '' : 'targetCount', $pb.PbFieldType.O3)
    ..a<$core.int>(
        7, _omitFieldNames ? '' : 'applicationCount', $pb.PbFieldType.O3)
    ..a<$core.int>(
        8, _omitFieldNames ? '' : 'selectedCount', $pb.PbFieldType.O3)
    ..a<$core.int>(
        9, _omitFieldNames ? '' : 'completedCount', $pb.PbFieldType.O3)
    ..a<$core.int>(
        10, _omitFieldNames ? '' : 'endorsementCount', $pb.PbFieldType.O3)
    ..a<$core.double>(
        11, _omitFieldNames ? '' : 'fundedPercentage', $pb.PbFieldType.OD)
    ..a<$core.int>(
        12, _omitFieldNames ? '' : 'daysRemaining', $pb.PbFieldType.O3)
    ..aOS(13, _omitFieldNames ? '' : 'currency')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUpliftStatisticsResponse clone() =>
      GetUpliftStatisticsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUpliftStatisticsResponse copyWith(
          void Function(GetUpliftStatisticsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetUpliftStatisticsResponse))
          as GetUpliftStatisticsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUpliftStatisticsResponse create() =>
      GetUpliftStatisticsResponse._();
  @$core.override
  GetUpliftStatisticsResponse createEmptyInstance() => create();
  static $pb.PbList<GetUpliftStatisticsResponse> createRepeated() =>
      $pb.PbList<GetUpliftStatisticsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetUpliftStatisticsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetUpliftStatisticsResponse>(create);
  static GetUpliftStatisticsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get fundId => $_getSZ(0);
  @$pb.TagNumber(1)
  set fundId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFundId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFundId() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get committedPool => $_getI64(1);
  @$pb.TagNumber(2)
  set committedPool($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCommittedPool() => $_has(1);
  @$pb.TagNumber(2)
  void clearCommittedPool() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get releasedTotal => $_getI64(2);
  @$pb.TagNumber(3)
  set releasedTotal($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasReleasedTotal() => $_has(2);
  @$pb.TagNumber(3)
  void clearReleasedTotal() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get refundedTotal => $_getI64(3);
  @$pb.TagNumber(4)
  set refundedTotal($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasRefundedTotal() => $_has(3);
  @$pb.TagNumber(4)
  void clearRefundedTotal() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get escrowAvailable => $_getI64(4);
  @$pb.TagNumber(5)
  set escrowAvailable($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasEscrowAvailable() => $_has(4);
  @$pb.TagNumber(5)
  void clearEscrowAvailable() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.int get targetCount => $_getIZ(5);
  @$pb.TagNumber(6)
  set targetCount($core.int value) => $_setSignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasTargetCount() => $_has(5);
  @$pb.TagNumber(6)
  void clearTargetCount() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.int get applicationCount => $_getIZ(6);
  @$pb.TagNumber(7)
  set applicationCount($core.int value) => $_setSignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasApplicationCount() => $_has(6);
  @$pb.TagNumber(7)
  void clearApplicationCount() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.int get selectedCount => $_getIZ(7);
  @$pb.TagNumber(8)
  set selectedCount($core.int value) => $_setSignedInt32(7, value);
  @$pb.TagNumber(8)
  $core.bool hasSelectedCount() => $_has(7);
  @$pb.TagNumber(8)
  void clearSelectedCount() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.int get completedCount => $_getIZ(8);
  @$pb.TagNumber(9)
  set completedCount($core.int value) => $_setSignedInt32(8, value);
  @$pb.TagNumber(9)
  $core.bool hasCompletedCount() => $_has(8);
  @$pb.TagNumber(9)
  void clearCompletedCount() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.int get endorsementCount => $_getIZ(9);
  @$pb.TagNumber(10)
  set endorsementCount($core.int value) => $_setSignedInt32(9, value);
  @$pb.TagNumber(10)
  $core.bool hasEndorsementCount() => $_has(9);
  @$pb.TagNumber(10)
  void clearEndorsementCount() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.double get fundedPercentage => $_getN(10);
  @$pb.TagNumber(11)
  set fundedPercentage($core.double value) => $_setDouble(10, value);
  @$pb.TagNumber(11)
  $core.bool hasFundedPercentage() => $_has(10);
  @$pb.TagNumber(11)
  void clearFundedPercentage() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.int get daysRemaining => $_getIZ(11);
  @$pb.TagNumber(12)
  set daysRemaining($core.int value) => $_setSignedInt32(11, value);
  @$pb.TagNumber(12)
  $core.bool hasDaysRemaining() => $_has(11);
  @$pb.TagNumber(12)
  void clearDaysRemaining() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.String get currency => $_getSZ(12);
  @$pb.TagNumber(13)
  set currency($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasCurrency() => $_has(12);
  @$pb.TagNumber(13)
  void clearCurrency() => $_clearField(13);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
