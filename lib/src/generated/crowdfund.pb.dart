// This is a generated file - do not edit.
//
// Generated from crowdfund.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'crowdfund.pbenum.dart';
import 'google/protobuf/timestamp.pb.dart' as $1;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'crowdfund.pbenum.dart';

class CrowdfundCreatorMessage extends $pb.GeneratedMessage {
  factory CrowdfundCreatorMessage({
    $fixnum.Int64? userId,
    $core.String? username,
    $core.String? firstName,
    $core.String? lastName,
    $core.String? profilePicture,
    $core.bool? verified,
    $1.Timestamp? verifiedAt,
    $core.bool? facialRecognitionEnabled,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    if (username != null) result.username = username;
    if (firstName != null) result.firstName = firstName;
    if (lastName != null) result.lastName = lastName;
    if (profilePicture != null) result.profilePicture = profilePicture;
    if (verified != null) result.verified = verified;
    if (verifiedAt != null) result.verifiedAt = verifiedAt;
    if (facialRecognitionEnabled != null)
      result.facialRecognitionEnabled = facialRecognitionEnabled;
    return result;
  }

  CrowdfundCreatorMessage._();

  factory CrowdfundCreatorMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CrowdfundCreatorMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CrowdfundCreatorMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'userId', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(2, _omitFieldNames ? '' : 'username')
    ..aOS(3, _omitFieldNames ? '' : 'firstName')
    ..aOS(4, _omitFieldNames ? '' : 'lastName')
    ..aOS(5, _omitFieldNames ? '' : 'profilePicture')
    ..aOB(6, _omitFieldNames ? '' : 'verified')
    ..aOM<$1.Timestamp>(7, _omitFieldNames ? '' : 'verifiedAt',
        subBuilder: $1.Timestamp.create)
    ..aOB(8, _omitFieldNames ? '' : 'facialRecognitionEnabled')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CrowdfundCreatorMessage clone() =>
      CrowdfundCreatorMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CrowdfundCreatorMessage copyWith(
          void Function(CrowdfundCreatorMessage) updates) =>
      super.copyWith((message) => updates(message as CrowdfundCreatorMessage))
          as CrowdfundCreatorMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CrowdfundCreatorMessage create() => CrowdfundCreatorMessage._();
  @$core.override
  CrowdfundCreatorMessage createEmptyInstance() => create();
  static $pb.PbList<CrowdfundCreatorMessage> createRepeated() =>
      $pb.PbList<CrowdfundCreatorMessage>();
  @$core.pragma('dart2js:noInline')
  static CrowdfundCreatorMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CrowdfundCreatorMessage>(create);
  static CrowdfundCreatorMessage? _defaultInstance;

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
  $core.String get profilePicture => $_getSZ(4);
  @$pb.TagNumber(5)
  set profilePicture($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasProfilePicture() => $_has(4);
  @$pb.TagNumber(5)
  void clearProfilePicture() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.bool get verified => $_getBF(5);
  @$pb.TagNumber(6)
  set verified($core.bool value) => $_setBool(5, value);
  @$pb.TagNumber(6)
  $core.bool hasVerified() => $_has(5);
  @$pb.TagNumber(6)
  void clearVerified() => $_clearField(6);

  @$pb.TagNumber(7)
  $1.Timestamp get verifiedAt => $_getN(6);
  @$pb.TagNumber(7)
  set verifiedAt($1.Timestamp value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasVerifiedAt() => $_has(6);
  @$pb.TagNumber(7)
  void clearVerifiedAt() => $_clearField(7);
  @$pb.TagNumber(7)
  $1.Timestamp ensureVerifiedAt() => $_ensure(6);

  @$pb.TagNumber(8)
  $core.bool get facialRecognitionEnabled => $_getBF(7);
  @$pb.TagNumber(8)
  set facialRecognitionEnabled($core.bool value) => $_setBool(7, value);
  @$pb.TagNumber(8)
  $core.bool hasFacialRecognitionEnabled() => $_has(7);
  @$pb.TagNumber(8)
  void clearFacialRecognitionEnabled() => $_clearField(8);
}

class CrowdfundMessage extends $pb.GeneratedMessage {
  factory CrowdfundMessage({
    $core.String? id,
    $fixnum.Int64? creatorUserId,
    CrowdfundCreatorMessage? creator,
    $core.String? title,
    $core.String? description,
    $core.String? story,
    $core.String? crowdfundCode,
    $fixnum.Int64? targetAmount,
    $fixnum.Int64? currentAmount,
    $core.String? currency,
    $1.Timestamp? deadline,
    $core.String? category,
    CrowdfundStatus? status,
    $core.String? imageUrl,
    CrowdfundVisibility? visibility,
    $core.String? metadata,
    $core.int? donorCount,
    $core.double? progressPercentage,
    $1.Timestamp? createdAt,
    $1.Timestamp? updatedAt,
    $core.Iterable<CrowdfundDonationMessage>? recentDonations,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (creatorUserId != null) result.creatorUserId = creatorUserId;
    if (creator != null) result.creator = creator;
    if (title != null) result.title = title;
    if (description != null) result.description = description;
    if (story != null) result.story = story;
    if (crowdfundCode != null) result.crowdfundCode = crowdfundCode;
    if (targetAmount != null) result.targetAmount = targetAmount;
    if (currentAmount != null) result.currentAmount = currentAmount;
    if (currency != null) result.currency = currency;
    if (deadline != null) result.deadline = deadline;
    if (category != null) result.category = category;
    if (status != null) result.status = status;
    if (imageUrl != null) result.imageUrl = imageUrl;
    if (visibility != null) result.visibility = visibility;
    if (metadata != null) result.metadata = metadata;
    if (donorCount != null) result.donorCount = donorCount;
    if (progressPercentage != null)
      result.progressPercentage = progressPercentage;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    if (recentDonations != null) result.recentDonations.addAll(recentDonations);
    return result;
  }

  CrowdfundMessage._();

  factory CrowdfundMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CrowdfundMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CrowdfundMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..a<$fixnum.Int64>(
        2, _omitFieldNames ? '' : 'creatorUserId', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<CrowdfundCreatorMessage>(3, _omitFieldNames ? '' : 'creator',
        subBuilder: CrowdfundCreatorMessage.create)
    ..aOS(4, _omitFieldNames ? '' : 'title')
    ..aOS(5, _omitFieldNames ? '' : 'description')
    ..aOS(6, _omitFieldNames ? '' : 'story')
    ..aOS(7, _omitFieldNames ? '' : 'crowdfundCode')
    ..a<$fixnum.Int64>(
        8, _omitFieldNames ? '' : 'targetAmount', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(
        9, _omitFieldNames ? '' : 'currentAmount', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(10, _omitFieldNames ? '' : 'currency')
    ..aOM<$1.Timestamp>(11, _omitFieldNames ? '' : 'deadline',
        subBuilder: $1.Timestamp.create)
    ..aOS(12, _omitFieldNames ? '' : 'category')
    ..e<CrowdfundStatus>(
        13, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: CrowdfundStatus.CROWDFUND_STATUS_UNSPECIFIED,
        valueOf: CrowdfundStatus.valueOf,
        enumValues: CrowdfundStatus.values)
    ..aOS(14, _omitFieldNames ? '' : 'imageUrl')
    ..e<CrowdfundVisibility>(
        15, _omitFieldNames ? '' : 'visibility', $pb.PbFieldType.OE,
        defaultOrMaker: CrowdfundVisibility.CROWDFUND_VISIBILITY_UNSPECIFIED,
        valueOf: CrowdfundVisibility.valueOf,
        enumValues: CrowdfundVisibility.values)
    ..aOS(16, _omitFieldNames ? '' : 'metadata')
    ..a<$core.int>(17, _omitFieldNames ? '' : 'donorCount', $pb.PbFieldType.O3)
    ..a<$core.double>(
        18, _omitFieldNames ? '' : 'progressPercentage', $pb.PbFieldType.OD)
    ..aOM<$1.Timestamp>(19, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(20, _omitFieldNames ? '' : 'updatedAt',
        subBuilder: $1.Timestamp.create)
    ..pc<CrowdfundDonationMessage>(
        21, _omitFieldNames ? '' : 'recentDonations', $pb.PbFieldType.PM,
        subBuilder: CrowdfundDonationMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CrowdfundMessage clone() => CrowdfundMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CrowdfundMessage copyWith(void Function(CrowdfundMessage) updates) =>
      super.copyWith((message) => updates(message as CrowdfundMessage))
          as CrowdfundMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CrowdfundMessage create() => CrowdfundMessage._();
  @$core.override
  CrowdfundMessage createEmptyInstance() => create();
  static $pb.PbList<CrowdfundMessage> createRepeated() =>
      $pb.PbList<CrowdfundMessage>();
  @$core.pragma('dart2js:noInline')
  static CrowdfundMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CrowdfundMessage>(create);
  static CrowdfundMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get creatorUserId => $_getI64(1);
  @$pb.TagNumber(2)
  set creatorUserId($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCreatorUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearCreatorUserId() => $_clearField(2);

  @$pb.TagNumber(3)
  CrowdfundCreatorMessage get creator => $_getN(2);
  @$pb.TagNumber(3)
  set creator(CrowdfundCreatorMessage value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasCreator() => $_has(2);
  @$pb.TagNumber(3)
  void clearCreator() => $_clearField(3);
  @$pb.TagNumber(3)
  CrowdfundCreatorMessage ensureCreator() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.String get title => $_getSZ(3);
  @$pb.TagNumber(4)
  set title($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTitle() => $_has(3);
  @$pb.TagNumber(4)
  void clearTitle() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get description => $_getSZ(4);
  @$pb.TagNumber(5)
  set description($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasDescription() => $_has(4);
  @$pb.TagNumber(5)
  void clearDescription() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get story => $_getSZ(5);
  @$pb.TagNumber(6)
  set story($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasStory() => $_has(5);
  @$pb.TagNumber(6)
  void clearStory() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get crowdfundCode => $_getSZ(6);
  @$pb.TagNumber(7)
  set crowdfundCode($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasCrowdfundCode() => $_has(6);
  @$pb.TagNumber(7)
  void clearCrowdfundCode() => $_clearField(7);

  @$pb.TagNumber(8)
  $fixnum.Int64 get targetAmount => $_getI64(7);
  @$pb.TagNumber(8)
  set targetAmount($fixnum.Int64 value) => $_setInt64(7, value);
  @$pb.TagNumber(8)
  $core.bool hasTargetAmount() => $_has(7);
  @$pb.TagNumber(8)
  void clearTargetAmount() => $_clearField(8);

  @$pb.TagNumber(9)
  $fixnum.Int64 get currentAmount => $_getI64(8);
  @$pb.TagNumber(9)
  set currentAmount($fixnum.Int64 value) => $_setInt64(8, value);
  @$pb.TagNumber(9)
  $core.bool hasCurrentAmount() => $_has(8);
  @$pb.TagNumber(9)
  void clearCurrentAmount() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get currency => $_getSZ(9);
  @$pb.TagNumber(10)
  set currency($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasCurrency() => $_has(9);
  @$pb.TagNumber(10)
  void clearCurrency() => $_clearField(10);

  @$pb.TagNumber(11)
  $1.Timestamp get deadline => $_getN(10);
  @$pb.TagNumber(11)
  set deadline($1.Timestamp value) => $_setField(11, value);
  @$pb.TagNumber(11)
  $core.bool hasDeadline() => $_has(10);
  @$pb.TagNumber(11)
  void clearDeadline() => $_clearField(11);
  @$pb.TagNumber(11)
  $1.Timestamp ensureDeadline() => $_ensure(10);

  @$pb.TagNumber(12)
  $core.String get category => $_getSZ(11);
  @$pb.TagNumber(12)
  set category($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasCategory() => $_has(11);
  @$pb.TagNumber(12)
  void clearCategory() => $_clearField(12);

  @$pb.TagNumber(13)
  CrowdfundStatus get status => $_getN(12);
  @$pb.TagNumber(13)
  set status(CrowdfundStatus value) => $_setField(13, value);
  @$pb.TagNumber(13)
  $core.bool hasStatus() => $_has(12);
  @$pb.TagNumber(13)
  void clearStatus() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.String get imageUrl => $_getSZ(13);
  @$pb.TagNumber(14)
  set imageUrl($core.String value) => $_setString(13, value);
  @$pb.TagNumber(14)
  $core.bool hasImageUrl() => $_has(13);
  @$pb.TagNumber(14)
  void clearImageUrl() => $_clearField(14);

  @$pb.TagNumber(15)
  CrowdfundVisibility get visibility => $_getN(14);
  @$pb.TagNumber(15)
  set visibility(CrowdfundVisibility value) => $_setField(15, value);
  @$pb.TagNumber(15)
  $core.bool hasVisibility() => $_has(14);
  @$pb.TagNumber(15)
  void clearVisibility() => $_clearField(15);

  @$pb.TagNumber(16)
  $core.String get metadata => $_getSZ(15);
  @$pb.TagNumber(16)
  set metadata($core.String value) => $_setString(15, value);
  @$pb.TagNumber(16)
  $core.bool hasMetadata() => $_has(15);
  @$pb.TagNumber(16)
  void clearMetadata() => $_clearField(16);

  @$pb.TagNumber(17)
  $core.int get donorCount => $_getIZ(16);
  @$pb.TagNumber(17)
  set donorCount($core.int value) => $_setSignedInt32(16, value);
  @$pb.TagNumber(17)
  $core.bool hasDonorCount() => $_has(16);
  @$pb.TagNumber(17)
  void clearDonorCount() => $_clearField(17);

  @$pb.TagNumber(18)
  $core.double get progressPercentage => $_getN(17);
  @$pb.TagNumber(18)
  set progressPercentage($core.double value) => $_setDouble(17, value);
  @$pb.TagNumber(18)
  $core.bool hasProgressPercentage() => $_has(17);
  @$pb.TagNumber(18)
  void clearProgressPercentage() => $_clearField(18);

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

  @$pb.TagNumber(21)
  $pb.PbList<CrowdfundDonationMessage> get recentDonations => $_getList(20);
}

class CrowdfundDonorMessage extends $pb.GeneratedMessage {
  factory CrowdfundDonorMessage({
    $fixnum.Int64? userId,
    $core.String? displayName,
    $core.String? profilePicture,
    $core.bool? isAnonymous,
    $core.bool? isCreator,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    if (displayName != null) result.displayName = displayName;
    if (profilePicture != null) result.profilePicture = profilePicture;
    if (isAnonymous != null) result.isAnonymous = isAnonymous;
    if (isCreator != null) result.isCreator = isCreator;
    return result;
  }

  CrowdfundDonorMessage._();

  factory CrowdfundDonorMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CrowdfundDonorMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CrowdfundDonorMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'userId', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(2, _omitFieldNames ? '' : 'displayName')
    ..aOS(3, _omitFieldNames ? '' : 'profilePicture')
    ..aOB(4, _omitFieldNames ? '' : 'isAnonymous')
    ..aOB(5, _omitFieldNames ? '' : 'isCreator')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CrowdfundDonorMessage clone() =>
      CrowdfundDonorMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CrowdfundDonorMessage copyWith(
          void Function(CrowdfundDonorMessage) updates) =>
      super.copyWith((message) => updates(message as CrowdfundDonorMessage))
          as CrowdfundDonorMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CrowdfundDonorMessage create() => CrowdfundDonorMessage._();
  @$core.override
  CrowdfundDonorMessage createEmptyInstance() => create();
  static $pb.PbList<CrowdfundDonorMessage> createRepeated() =>
      $pb.PbList<CrowdfundDonorMessage>();
  @$core.pragma('dart2js:noInline')
  static CrowdfundDonorMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CrowdfundDonorMessage>(create);
  static CrowdfundDonorMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get userId => $_getI64(0);
  @$pb.TagNumber(1)
  set userId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get displayName => $_getSZ(1);
  @$pb.TagNumber(2)
  set displayName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDisplayName() => $_has(1);
  @$pb.TagNumber(2)
  void clearDisplayName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get profilePicture => $_getSZ(2);
  @$pb.TagNumber(3)
  set profilePicture($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasProfilePicture() => $_has(2);
  @$pb.TagNumber(3)
  void clearProfilePicture() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.bool get isAnonymous => $_getBF(3);
  @$pb.TagNumber(4)
  set isAnonymous($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasIsAnonymous() => $_has(3);
  @$pb.TagNumber(4)
  void clearIsAnonymous() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.bool get isCreator => $_getBF(4);
  @$pb.TagNumber(5)
  set isCreator($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasIsCreator() => $_has(4);
  @$pb.TagNumber(5)
  void clearIsCreator() => $_clearField(5);
}

class CrowdfundDonationMessage extends $pb.GeneratedMessage {
  factory CrowdfundDonationMessage({
    $core.String? id,
    $core.String? crowdfundId,
    $fixnum.Int64? donorUserId,
    CrowdfundDonorMessage? donor,
    $fixnum.Int64? amount,
    $core.String? currency,
    $1.Timestamp? donationDate,
    DonationStatus? status,
    $core.String? transactionId,
    $core.String? receiptId,
    $core.String? message,
    $core.bool? isAnonymous,
    $core.String? paymentMethod,
    $core.String? metadata,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (crowdfundId != null) result.crowdfundId = crowdfundId;
    if (donorUserId != null) result.donorUserId = donorUserId;
    if (donor != null) result.donor = donor;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    if (donationDate != null) result.donationDate = donationDate;
    if (status != null) result.status = status;
    if (transactionId != null) result.transactionId = transactionId;
    if (receiptId != null) result.receiptId = receiptId;
    if (message != null) result.message = message;
    if (isAnonymous != null) result.isAnonymous = isAnonymous;
    if (paymentMethod != null) result.paymentMethod = paymentMethod;
    if (metadata != null) result.metadata = metadata;
    return result;
  }

  CrowdfundDonationMessage._();

  factory CrowdfundDonationMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CrowdfundDonationMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CrowdfundDonationMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'crowdfundId')
    ..a<$fixnum.Int64>(
        3, _omitFieldNames ? '' : 'donorUserId', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<CrowdfundDonorMessage>(4, _omitFieldNames ? '' : 'donor',
        subBuilder: CrowdfundDonorMessage.create)
    ..a<$fixnum.Int64>(5, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(6, _omitFieldNames ? '' : 'currency')
    ..aOM<$1.Timestamp>(7, _omitFieldNames ? '' : 'donationDate',
        subBuilder: $1.Timestamp.create)
    ..e<DonationStatus>(8, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: DonationStatus.DONATION_STATUS_UNSPECIFIED,
        valueOf: DonationStatus.valueOf,
        enumValues: DonationStatus.values)
    ..aOS(9, _omitFieldNames ? '' : 'transactionId')
    ..aOS(10, _omitFieldNames ? '' : 'receiptId')
    ..aOS(11, _omitFieldNames ? '' : 'message')
    ..aOB(12, _omitFieldNames ? '' : 'isAnonymous')
    ..aOS(13, _omitFieldNames ? '' : 'paymentMethod')
    ..aOS(14, _omitFieldNames ? '' : 'metadata')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CrowdfundDonationMessage clone() =>
      CrowdfundDonationMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CrowdfundDonationMessage copyWith(
          void Function(CrowdfundDonationMessage) updates) =>
      super.copyWith((message) => updates(message as CrowdfundDonationMessage))
          as CrowdfundDonationMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CrowdfundDonationMessage create() => CrowdfundDonationMessage._();
  @$core.override
  CrowdfundDonationMessage createEmptyInstance() => create();
  static $pb.PbList<CrowdfundDonationMessage> createRepeated() =>
      $pb.PbList<CrowdfundDonationMessage>();
  @$core.pragma('dart2js:noInline')
  static CrowdfundDonationMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CrowdfundDonationMessage>(create);
  static CrowdfundDonationMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get crowdfundId => $_getSZ(1);
  @$pb.TagNumber(2)
  set crowdfundId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCrowdfundId() => $_has(1);
  @$pb.TagNumber(2)
  void clearCrowdfundId() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get donorUserId => $_getI64(2);
  @$pb.TagNumber(3)
  set donorUserId($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDonorUserId() => $_has(2);
  @$pb.TagNumber(3)
  void clearDonorUserId() => $_clearField(3);

  @$pb.TagNumber(4)
  CrowdfundDonorMessage get donor => $_getN(3);
  @$pb.TagNumber(4)
  set donor(CrowdfundDonorMessage value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasDonor() => $_has(3);
  @$pb.TagNumber(4)
  void clearDonor() => $_clearField(4);
  @$pb.TagNumber(4)
  CrowdfundDonorMessage ensureDonor() => $_ensure(3);

  @$pb.TagNumber(5)
  $fixnum.Int64 get amount => $_getI64(4);
  @$pb.TagNumber(5)
  set amount($fixnum.Int64 value) => $_setInt64(4, value);
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
  $1.Timestamp get donationDate => $_getN(6);
  @$pb.TagNumber(7)
  set donationDate($1.Timestamp value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasDonationDate() => $_has(6);
  @$pb.TagNumber(7)
  void clearDonationDate() => $_clearField(7);
  @$pb.TagNumber(7)
  $1.Timestamp ensureDonationDate() => $_ensure(6);

  @$pb.TagNumber(8)
  DonationStatus get status => $_getN(7);
  @$pb.TagNumber(8)
  set status(DonationStatus value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasStatus() => $_has(7);
  @$pb.TagNumber(8)
  void clearStatus() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get transactionId => $_getSZ(8);
  @$pb.TagNumber(9)
  set transactionId($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasTransactionId() => $_has(8);
  @$pb.TagNumber(9)
  void clearTransactionId() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get receiptId => $_getSZ(9);
  @$pb.TagNumber(10)
  set receiptId($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasReceiptId() => $_has(9);
  @$pb.TagNumber(10)
  void clearReceiptId() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get message => $_getSZ(10);
  @$pb.TagNumber(11)
  set message($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasMessage() => $_has(10);
  @$pb.TagNumber(11)
  void clearMessage() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.bool get isAnonymous => $_getBF(11);
  @$pb.TagNumber(12)
  set isAnonymous($core.bool value) => $_setBool(11, value);
  @$pb.TagNumber(12)
  $core.bool hasIsAnonymous() => $_has(11);
  @$pb.TagNumber(12)
  void clearIsAnonymous() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.String get paymentMethod => $_getSZ(12);
  @$pb.TagNumber(13)
  set paymentMethod($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasPaymentMethod() => $_has(12);
  @$pb.TagNumber(13)
  void clearPaymentMethod() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.String get metadata => $_getSZ(13);
  @$pb.TagNumber(14)
  set metadata($core.String value) => $_setString(13, value);
  @$pb.TagNumber(14)
  $core.bool hasMetadata() => $_has(13);
  @$pb.TagNumber(14)
  void clearMetadata() => $_clearField(14);
}

class CrowdfundReceiptMessage extends $pb.GeneratedMessage {
  factory CrowdfundReceiptMessage({
    $core.String? id,
    $core.String? donationId,
    $core.String? crowdfundId,
    $core.String? crowdfundTitle,
    $fixnum.Int64? donorUserId,
    $core.String? donorName,
    $fixnum.Int64? amount,
    $core.String? currency,
    $1.Timestamp? donationDate,
    $1.Timestamp? generatedAt,
    $core.String? receiptNumber,
    $core.String? receiptData,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (donationId != null) result.donationId = donationId;
    if (crowdfundId != null) result.crowdfundId = crowdfundId;
    if (crowdfundTitle != null) result.crowdfundTitle = crowdfundTitle;
    if (donorUserId != null) result.donorUserId = donorUserId;
    if (donorName != null) result.donorName = donorName;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    if (donationDate != null) result.donationDate = donationDate;
    if (generatedAt != null) result.generatedAt = generatedAt;
    if (receiptNumber != null) result.receiptNumber = receiptNumber;
    if (receiptData != null) result.receiptData = receiptData;
    return result;
  }

  CrowdfundReceiptMessage._();

  factory CrowdfundReceiptMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CrowdfundReceiptMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CrowdfundReceiptMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'donationId')
    ..aOS(3, _omitFieldNames ? '' : 'crowdfundId')
    ..aOS(4, _omitFieldNames ? '' : 'crowdfundTitle')
    ..a<$fixnum.Int64>(
        5, _omitFieldNames ? '' : 'donorUserId', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(6, _omitFieldNames ? '' : 'donorName')
    ..a<$fixnum.Int64>(7, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(8, _omitFieldNames ? '' : 'currency')
    ..aOM<$1.Timestamp>(9, _omitFieldNames ? '' : 'donationDate',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(10, _omitFieldNames ? '' : 'generatedAt',
        subBuilder: $1.Timestamp.create)
    ..aOS(11, _omitFieldNames ? '' : 'receiptNumber')
    ..aOS(12, _omitFieldNames ? '' : 'receiptData')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CrowdfundReceiptMessage clone() =>
      CrowdfundReceiptMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CrowdfundReceiptMessage copyWith(
          void Function(CrowdfundReceiptMessage) updates) =>
      super.copyWith((message) => updates(message as CrowdfundReceiptMessage))
          as CrowdfundReceiptMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CrowdfundReceiptMessage create() => CrowdfundReceiptMessage._();
  @$core.override
  CrowdfundReceiptMessage createEmptyInstance() => create();
  static $pb.PbList<CrowdfundReceiptMessage> createRepeated() =>
      $pb.PbList<CrowdfundReceiptMessage>();
  @$core.pragma('dart2js:noInline')
  static CrowdfundReceiptMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CrowdfundReceiptMessage>(create);
  static CrowdfundReceiptMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get donationId => $_getSZ(1);
  @$pb.TagNumber(2)
  set donationId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDonationId() => $_has(1);
  @$pb.TagNumber(2)
  void clearDonationId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get crowdfundId => $_getSZ(2);
  @$pb.TagNumber(3)
  set crowdfundId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCrowdfundId() => $_has(2);
  @$pb.TagNumber(3)
  void clearCrowdfundId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get crowdfundTitle => $_getSZ(3);
  @$pb.TagNumber(4)
  set crowdfundTitle($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCrowdfundTitle() => $_has(3);
  @$pb.TagNumber(4)
  void clearCrowdfundTitle() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get donorUserId => $_getI64(4);
  @$pb.TagNumber(5)
  set donorUserId($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasDonorUserId() => $_has(4);
  @$pb.TagNumber(5)
  void clearDonorUserId() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get donorName => $_getSZ(5);
  @$pb.TagNumber(6)
  set donorName($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasDonorName() => $_has(5);
  @$pb.TagNumber(6)
  void clearDonorName() => $_clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get amount => $_getI64(6);
  @$pb.TagNumber(7)
  set amount($fixnum.Int64 value) => $_setInt64(6, value);
  @$pb.TagNumber(7)
  $core.bool hasAmount() => $_has(6);
  @$pb.TagNumber(7)
  void clearAmount() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get currency => $_getSZ(7);
  @$pb.TagNumber(8)
  set currency($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasCurrency() => $_has(7);
  @$pb.TagNumber(8)
  void clearCurrency() => $_clearField(8);

  @$pb.TagNumber(9)
  $1.Timestamp get donationDate => $_getN(8);
  @$pb.TagNumber(9)
  set donationDate($1.Timestamp value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasDonationDate() => $_has(8);
  @$pb.TagNumber(9)
  void clearDonationDate() => $_clearField(9);
  @$pb.TagNumber(9)
  $1.Timestamp ensureDonationDate() => $_ensure(8);

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

  @$pb.TagNumber(11)
  $core.String get receiptNumber => $_getSZ(10);
  @$pb.TagNumber(11)
  set receiptNumber($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasReceiptNumber() => $_has(10);
  @$pb.TagNumber(11)
  void clearReceiptNumber() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get receiptData => $_getSZ(11);
  @$pb.TagNumber(12)
  set receiptData($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasReceiptData() => $_has(11);
  @$pb.TagNumber(12)
  void clearReceiptData() => $_clearField(12);
}

/// Create Crowdfund
class CreateCrowdfundRequest extends $pb.GeneratedMessage {
  factory CreateCrowdfundRequest({
    $core.String? title,
    $core.String? description,
    $core.String? story,
    $fixnum.Int64? targetAmount,
    $core.String? currency,
    $1.Timestamp? deadline,
    $core.String? category,
    $core.String? imageUrl,
    CrowdfundVisibility? visibility,
    $core.String? metadata,
  }) {
    final result = create();
    if (title != null) result.title = title;
    if (description != null) result.description = description;
    if (story != null) result.story = story;
    if (targetAmount != null) result.targetAmount = targetAmount;
    if (currency != null) result.currency = currency;
    if (deadline != null) result.deadline = deadline;
    if (category != null) result.category = category;
    if (imageUrl != null) result.imageUrl = imageUrl;
    if (visibility != null) result.visibility = visibility;
    if (metadata != null) result.metadata = metadata;
    return result;
  }

  CreateCrowdfundRequest._();

  factory CreateCrowdfundRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateCrowdfundRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateCrowdfundRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'title')
    ..aOS(2, _omitFieldNames ? '' : 'description')
    ..aOS(3, _omitFieldNames ? '' : 'story')
    ..a<$fixnum.Int64>(
        4, _omitFieldNames ? '' : 'targetAmount', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(5, _omitFieldNames ? '' : 'currency')
    ..aOM<$1.Timestamp>(6, _omitFieldNames ? '' : 'deadline',
        subBuilder: $1.Timestamp.create)
    ..aOS(7, _omitFieldNames ? '' : 'category')
    ..aOS(8, _omitFieldNames ? '' : 'imageUrl')
    ..e<CrowdfundVisibility>(
        9, _omitFieldNames ? '' : 'visibility', $pb.PbFieldType.OE,
        defaultOrMaker: CrowdfundVisibility.CROWDFUND_VISIBILITY_UNSPECIFIED,
        valueOf: CrowdfundVisibility.valueOf,
        enumValues: CrowdfundVisibility.values)
    ..aOS(10, _omitFieldNames ? '' : 'metadata')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateCrowdfundRequest clone() =>
      CreateCrowdfundRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateCrowdfundRequest copyWith(
          void Function(CreateCrowdfundRequest) updates) =>
      super.copyWith((message) => updates(message as CreateCrowdfundRequest))
          as CreateCrowdfundRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateCrowdfundRequest create() => CreateCrowdfundRequest._();
  @$core.override
  CreateCrowdfundRequest createEmptyInstance() => create();
  static $pb.PbList<CreateCrowdfundRequest> createRepeated() =>
      $pb.PbList<CreateCrowdfundRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateCrowdfundRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateCrowdfundRequest>(create);
  static CreateCrowdfundRequest? _defaultInstance;

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
  $fixnum.Int64 get targetAmount => $_getI64(3);
  @$pb.TagNumber(4)
  set targetAmount($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTargetAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearTargetAmount() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get currency => $_getSZ(4);
  @$pb.TagNumber(5)
  set currency($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasCurrency() => $_has(4);
  @$pb.TagNumber(5)
  void clearCurrency() => $_clearField(5);

  @$pb.TagNumber(6)
  $1.Timestamp get deadline => $_getN(5);
  @$pb.TagNumber(6)
  set deadline($1.Timestamp value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasDeadline() => $_has(5);
  @$pb.TagNumber(6)
  void clearDeadline() => $_clearField(6);
  @$pb.TagNumber(6)
  $1.Timestamp ensureDeadline() => $_ensure(5);

  @$pb.TagNumber(7)
  $core.String get category => $_getSZ(6);
  @$pb.TagNumber(7)
  set category($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasCategory() => $_has(6);
  @$pb.TagNumber(7)
  void clearCategory() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get imageUrl => $_getSZ(7);
  @$pb.TagNumber(8)
  set imageUrl($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasImageUrl() => $_has(7);
  @$pb.TagNumber(8)
  void clearImageUrl() => $_clearField(8);

  @$pb.TagNumber(9)
  CrowdfundVisibility get visibility => $_getN(8);
  @$pb.TagNumber(9)
  set visibility(CrowdfundVisibility value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasVisibility() => $_has(8);
  @$pb.TagNumber(9)
  void clearVisibility() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get metadata => $_getSZ(9);
  @$pb.TagNumber(10)
  set metadata($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasMetadata() => $_has(9);
  @$pb.TagNumber(10)
  void clearMetadata() => $_clearField(10);
}

class CreateCrowdfundResponse extends $pb.GeneratedMessage {
  factory CreateCrowdfundResponse({
    CrowdfundMessage? crowdfund,
  }) {
    final result = create();
    if (crowdfund != null) result.crowdfund = crowdfund;
    return result;
  }

  CreateCrowdfundResponse._();

  factory CreateCrowdfundResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateCrowdfundResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateCrowdfundResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<CrowdfundMessage>(1, _omitFieldNames ? '' : 'crowdfund',
        subBuilder: CrowdfundMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateCrowdfundResponse clone() =>
      CreateCrowdfundResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateCrowdfundResponse copyWith(
          void Function(CreateCrowdfundResponse) updates) =>
      super.copyWith((message) => updates(message as CreateCrowdfundResponse))
          as CreateCrowdfundResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateCrowdfundResponse create() => CreateCrowdfundResponse._();
  @$core.override
  CreateCrowdfundResponse createEmptyInstance() => create();
  static $pb.PbList<CreateCrowdfundResponse> createRepeated() =>
      $pb.PbList<CreateCrowdfundResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateCrowdfundResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateCrowdfundResponse>(create);
  static CreateCrowdfundResponse? _defaultInstance;

  @$pb.TagNumber(1)
  CrowdfundMessage get crowdfund => $_getN(0);
  @$pb.TagNumber(1)
  set crowdfund(CrowdfundMessage value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasCrowdfund() => $_has(0);
  @$pb.TagNumber(1)
  void clearCrowdfund() => $_clearField(1);
  @$pb.TagNumber(1)
  CrowdfundMessage ensureCrowdfund() => $_ensure(0);
}

/// Get Crowdfund
class GetCrowdfundRequest extends $pb.GeneratedMessage {
  factory GetCrowdfundRequest({
    $core.String? crowdfundId,
  }) {
    final result = create();
    if (crowdfundId != null) result.crowdfundId = crowdfundId;
    return result;
  }

  GetCrowdfundRequest._();

  factory GetCrowdfundRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetCrowdfundRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetCrowdfundRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'crowdfundId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCrowdfundRequest clone() => GetCrowdfundRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCrowdfundRequest copyWith(void Function(GetCrowdfundRequest) updates) =>
      super.copyWith((message) => updates(message as GetCrowdfundRequest))
          as GetCrowdfundRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetCrowdfundRequest create() => GetCrowdfundRequest._();
  @$core.override
  GetCrowdfundRequest createEmptyInstance() => create();
  static $pb.PbList<GetCrowdfundRequest> createRepeated() =>
      $pb.PbList<GetCrowdfundRequest>();
  @$core.pragma('dart2js:noInline')
  static GetCrowdfundRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetCrowdfundRequest>(create);
  static GetCrowdfundRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get crowdfundId => $_getSZ(0);
  @$pb.TagNumber(1)
  set crowdfundId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCrowdfundId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCrowdfundId() => $_clearField(1);
}

class GetCrowdfundResponse extends $pb.GeneratedMessage {
  factory GetCrowdfundResponse({
    CrowdfundMessage? crowdfund,
  }) {
    final result = create();
    if (crowdfund != null) result.crowdfund = crowdfund;
    return result;
  }

  GetCrowdfundResponse._();

  factory GetCrowdfundResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetCrowdfundResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetCrowdfundResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<CrowdfundMessage>(1, _omitFieldNames ? '' : 'crowdfund',
        subBuilder: CrowdfundMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCrowdfundResponse clone() =>
      GetCrowdfundResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCrowdfundResponse copyWith(void Function(GetCrowdfundResponse) updates) =>
      super.copyWith((message) => updates(message as GetCrowdfundResponse))
          as GetCrowdfundResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetCrowdfundResponse create() => GetCrowdfundResponse._();
  @$core.override
  GetCrowdfundResponse createEmptyInstance() => create();
  static $pb.PbList<GetCrowdfundResponse> createRepeated() =>
      $pb.PbList<GetCrowdfundResponse>();
  @$core.pragma('dart2js:noInline')
  static GetCrowdfundResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetCrowdfundResponse>(create);
  static GetCrowdfundResponse? _defaultInstance;

  @$pb.TagNumber(1)
  CrowdfundMessage get crowdfund => $_getN(0);
  @$pb.TagNumber(1)
  set crowdfund(CrowdfundMessage value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasCrowdfund() => $_has(0);
  @$pb.TagNumber(1)
  void clearCrowdfund() => $_clearField(1);
  @$pb.TagNumber(1)
  CrowdfundMessage ensureCrowdfund() => $_ensure(0);
}

/// List Crowdfunds
class ListCrowdfundsRequest extends $pb.GeneratedMessage {
  factory ListCrowdfundsRequest({
    $core.int? page,
    $core.int? pageSize,
    $core.String? status,
    $core.String? category,
    $core.bool? myCrowdfundsOnly,
    $core.String? sortBy,
    CrowdfundVisibility? visibility,
  }) {
    final result = create();
    if (page != null) result.page = page;
    if (pageSize != null) result.pageSize = pageSize;
    if (status != null) result.status = status;
    if (category != null) result.category = category;
    if (myCrowdfundsOnly != null) result.myCrowdfundsOnly = myCrowdfundsOnly;
    if (sortBy != null) result.sortBy = sortBy;
    if (visibility != null) result.visibility = visibility;
    return result;
  }

  ListCrowdfundsRequest._();

  factory ListCrowdfundsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListCrowdfundsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListCrowdfundsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOS(3, _omitFieldNames ? '' : 'status')
    ..aOS(4, _omitFieldNames ? '' : 'category')
    ..aOB(5, _omitFieldNames ? '' : 'myCrowdfundsOnly')
    ..aOS(6, _omitFieldNames ? '' : 'sortBy')
    ..e<CrowdfundVisibility>(
        7, _omitFieldNames ? '' : 'visibility', $pb.PbFieldType.OE,
        defaultOrMaker: CrowdfundVisibility.CROWDFUND_VISIBILITY_UNSPECIFIED,
        valueOf: CrowdfundVisibility.valueOf,
        enumValues: CrowdfundVisibility.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListCrowdfundsRequest clone() =>
      ListCrowdfundsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListCrowdfundsRequest copyWith(
          void Function(ListCrowdfundsRequest) updates) =>
      super.copyWith((message) => updates(message as ListCrowdfundsRequest))
          as ListCrowdfundsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListCrowdfundsRequest create() => ListCrowdfundsRequest._();
  @$core.override
  ListCrowdfundsRequest createEmptyInstance() => create();
  static $pb.PbList<ListCrowdfundsRequest> createRepeated() =>
      $pb.PbList<ListCrowdfundsRequest>();
  @$core.pragma('dart2js:noInline')
  static ListCrowdfundsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListCrowdfundsRequest>(create);
  static ListCrowdfundsRequest? _defaultInstance;

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
  $core.bool get myCrowdfundsOnly => $_getBF(4);
  @$pb.TagNumber(5)
  set myCrowdfundsOnly($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasMyCrowdfundsOnly() => $_has(4);
  @$pb.TagNumber(5)
  void clearMyCrowdfundsOnly() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get sortBy => $_getSZ(5);
  @$pb.TagNumber(6)
  set sortBy($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasSortBy() => $_has(5);
  @$pb.TagNumber(6)
  void clearSortBy() => $_clearField(6);

  @$pb.TagNumber(7)
  CrowdfundVisibility get visibility => $_getN(6);
  @$pb.TagNumber(7)
  set visibility(CrowdfundVisibility value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasVisibility() => $_has(6);
  @$pb.TagNumber(7)
  void clearVisibility() => $_clearField(7);
}

class ListCrowdfundsResponse extends $pb.GeneratedMessage {
  factory ListCrowdfundsResponse({
    $core.Iterable<CrowdfundMessage>? crowdfunds,
    CrowdfundPaginationInfo? pagination,
  }) {
    final result = create();
    if (crowdfunds != null) result.crowdfunds.addAll(crowdfunds);
    if (pagination != null) result.pagination = pagination;
    return result;
  }

  ListCrowdfundsResponse._();

  factory ListCrowdfundsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListCrowdfundsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListCrowdfundsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<CrowdfundMessage>(
        1, _omitFieldNames ? '' : 'crowdfunds', $pb.PbFieldType.PM,
        subBuilder: CrowdfundMessage.create)
    ..aOM<CrowdfundPaginationInfo>(2, _omitFieldNames ? '' : 'pagination',
        subBuilder: CrowdfundPaginationInfo.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListCrowdfundsResponse clone() =>
      ListCrowdfundsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListCrowdfundsResponse copyWith(
          void Function(ListCrowdfundsResponse) updates) =>
      super.copyWith((message) => updates(message as ListCrowdfundsResponse))
          as ListCrowdfundsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListCrowdfundsResponse create() => ListCrowdfundsResponse._();
  @$core.override
  ListCrowdfundsResponse createEmptyInstance() => create();
  static $pb.PbList<ListCrowdfundsResponse> createRepeated() =>
      $pb.PbList<ListCrowdfundsResponse>();
  @$core.pragma('dart2js:noInline')
  static ListCrowdfundsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListCrowdfundsResponse>(create);
  static ListCrowdfundsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<CrowdfundMessage> get crowdfunds => $_getList(0);

  @$pb.TagNumber(2)
  CrowdfundPaginationInfo get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination(CrowdfundPaginationInfo value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => $_clearField(2);
  @$pb.TagNumber(2)
  CrowdfundPaginationInfo ensurePagination() => $_ensure(1);
}

/// Search Crowdfunds
class SearchCrowdfundsRequest extends $pb.GeneratedMessage {
  factory SearchCrowdfundsRequest({
    $core.String? query,
    $core.int? limit,
  }) {
    final result = create();
    if (query != null) result.query = query;
    if (limit != null) result.limit = limit;
    return result;
  }

  SearchCrowdfundsRequest._();

  factory SearchCrowdfundsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SearchCrowdfundsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SearchCrowdfundsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'query')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchCrowdfundsRequest clone() =>
      SearchCrowdfundsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchCrowdfundsRequest copyWith(
          void Function(SearchCrowdfundsRequest) updates) =>
      super.copyWith((message) => updates(message as SearchCrowdfundsRequest))
          as SearchCrowdfundsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SearchCrowdfundsRequest create() => SearchCrowdfundsRequest._();
  @$core.override
  SearchCrowdfundsRequest createEmptyInstance() => create();
  static $pb.PbList<SearchCrowdfundsRequest> createRepeated() =>
      $pb.PbList<SearchCrowdfundsRequest>();
  @$core.pragma('dart2js:noInline')
  static SearchCrowdfundsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SearchCrowdfundsRequest>(create);
  static SearchCrowdfundsRequest? _defaultInstance;

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

class SearchCrowdfundsResponse extends $pb.GeneratedMessage {
  factory SearchCrowdfundsResponse({
    $core.Iterable<CrowdfundMessage>? crowdfunds,
  }) {
    final result = create();
    if (crowdfunds != null) result.crowdfunds.addAll(crowdfunds);
    return result;
  }

  SearchCrowdfundsResponse._();

  factory SearchCrowdfundsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SearchCrowdfundsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SearchCrowdfundsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<CrowdfundMessage>(
        1, _omitFieldNames ? '' : 'crowdfunds', $pb.PbFieldType.PM,
        subBuilder: CrowdfundMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchCrowdfundsResponse clone() =>
      SearchCrowdfundsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchCrowdfundsResponse copyWith(
          void Function(SearchCrowdfundsResponse) updates) =>
      super.copyWith((message) => updates(message as SearchCrowdfundsResponse))
          as SearchCrowdfundsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SearchCrowdfundsResponse create() => SearchCrowdfundsResponse._();
  @$core.override
  SearchCrowdfundsResponse createEmptyInstance() => create();
  static $pb.PbList<SearchCrowdfundsResponse> createRepeated() =>
      $pb.PbList<SearchCrowdfundsResponse>();
  @$core.pragma('dart2js:noInline')
  static SearchCrowdfundsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SearchCrowdfundsResponse>(create);
  static SearchCrowdfundsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<CrowdfundMessage> get crowdfunds => $_getList(0);
}

/// Update Crowdfund
class UpdateCrowdfundRequest extends $pb.GeneratedMessage {
  factory UpdateCrowdfundRequest({
    $core.String? crowdfundId,
    $core.String? title,
    $core.String? description,
    $core.String? story,
    $1.Timestamp? deadline,
    CrowdfundStatus? status,
    $core.String? imageUrl,
    $core.String? metadata,
  }) {
    final result = create();
    if (crowdfundId != null) result.crowdfundId = crowdfundId;
    if (title != null) result.title = title;
    if (description != null) result.description = description;
    if (story != null) result.story = story;
    if (deadline != null) result.deadline = deadline;
    if (status != null) result.status = status;
    if (imageUrl != null) result.imageUrl = imageUrl;
    if (metadata != null) result.metadata = metadata;
    return result;
  }

  UpdateCrowdfundRequest._();

  factory UpdateCrowdfundRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateCrowdfundRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateCrowdfundRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'crowdfundId')
    ..aOS(2, _omitFieldNames ? '' : 'title')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..aOS(4, _omitFieldNames ? '' : 'story')
    ..aOM<$1.Timestamp>(5, _omitFieldNames ? '' : 'deadline',
        subBuilder: $1.Timestamp.create)
    ..e<CrowdfundStatus>(6, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: CrowdfundStatus.CROWDFUND_STATUS_UNSPECIFIED,
        valueOf: CrowdfundStatus.valueOf,
        enumValues: CrowdfundStatus.values)
    ..aOS(7, _omitFieldNames ? '' : 'imageUrl')
    ..aOS(8, _omitFieldNames ? '' : 'metadata')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateCrowdfundRequest clone() =>
      UpdateCrowdfundRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateCrowdfundRequest copyWith(
          void Function(UpdateCrowdfundRequest) updates) =>
      super.copyWith((message) => updates(message as UpdateCrowdfundRequest))
          as UpdateCrowdfundRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateCrowdfundRequest create() => UpdateCrowdfundRequest._();
  @$core.override
  UpdateCrowdfundRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateCrowdfundRequest> createRepeated() =>
      $pb.PbList<UpdateCrowdfundRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateCrowdfundRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateCrowdfundRequest>(create);
  static UpdateCrowdfundRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get crowdfundId => $_getSZ(0);
  @$pb.TagNumber(1)
  set crowdfundId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCrowdfundId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCrowdfundId() => $_clearField(1);

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
  $1.Timestamp get deadline => $_getN(4);
  @$pb.TagNumber(5)
  set deadline($1.Timestamp value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasDeadline() => $_has(4);
  @$pb.TagNumber(5)
  void clearDeadline() => $_clearField(5);
  @$pb.TagNumber(5)
  $1.Timestamp ensureDeadline() => $_ensure(4);

  @$pb.TagNumber(6)
  CrowdfundStatus get status => $_getN(5);
  @$pb.TagNumber(6)
  set status(CrowdfundStatus value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasStatus() => $_has(5);
  @$pb.TagNumber(6)
  void clearStatus() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get imageUrl => $_getSZ(6);
  @$pb.TagNumber(7)
  set imageUrl($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasImageUrl() => $_has(6);
  @$pb.TagNumber(7)
  void clearImageUrl() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get metadata => $_getSZ(7);
  @$pb.TagNumber(8)
  set metadata($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasMetadata() => $_has(7);
  @$pb.TagNumber(8)
  void clearMetadata() => $_clearField(8);
}

class UpdateCrowdfundResponse extends $pb.GeneratedMessage {
  factory UpdateCrowdfundResponse({
    CrowdfundMessage? crowdfund,
  }) {
    final result = create();
    if (crowdfund != null) result.crowdfund = crowdfund;
    return result;
  }

  UpdateCrowdfundResponse._();

  factory UpdateCrowdfundResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateCrowdfundResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateCrowdfundResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<CrowdfundMessage>(1, _omitFieldNames ? '' : 'crowdfund',
        subBuilder: CrowdfundMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateCrowdfundResponse clone() =>
      UpdateCrowdfundResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateCrowdfundResponse copyWith(
          void Function(UpdateCrowdfundResponse) updates) =>
      super.copyWith((message) => updates(message as UpdateCrowdfundResponse))
          as UpdateCrowdfundResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateCrowdfundResponse create() => UpdateCrowdfundResponse._();
  @$core.override
  UpdateCrowdfundResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateCrowdfundResponse> createRepeated() =>
      $pb.PbList<UpdateCrowdfundResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateCrowdfundResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateCrowdfundResponse>(create);
  static UpdateCrowdfundResponse? _defaultInstance;

  @$pb.TagNumber(1)
  CrowdfundMessage get crowdfund => $_getN(0);
  @$pb.TagNumber(1)
  set crowdfund(CrowdfundMessage value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasCrowdfund() => $_has(0);
  @$pb.TagNumber(1)
  void clearCrowdfund() => $_clearField(1);
  @$pb.TagNumber(1)
  CrowdfundMessage ensureCrowdfund() => $_ensure(0);
}

/// Delete Crowdfund
class DeleteCrowdfundRequest extends $pb.GeneratedMessage {
  factory DeleteCrowdfundRequest({
    $core.String? crowdfundId,
  }) {
    final result = create();
    if (crowdfundId != null) result.crowdfundId = crowdfundId;
    return result;
  }

  DeleteCrowdfundRequest._();

  factory DeleteCrowdfundRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeleteCrowdfundRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteCrowdfundRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'crowdfundId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteCrowdfundRequest clone() =>
      DeleteCrowdfundRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteCrowdfundRequest copyWith(
          void Function(DeleteCrowdfundRequest) updates) =>
      super.copyWith((message) => updates(message as DeleteCrowdfundRequest))
          as DeleteCrowdfundRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteCrowdfundRequest create() => DeleteCrowdfundRequest._();
  @$core.override
  DeleteCrowdfundRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteCrowdfundRequest> createRepeated() =>
      $pb.PbList<DeleteCrowdfundRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteCrowdfundRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteCrowdfundRequest>(create);
  static DeleteCrowdfundRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get crowdfundId => $_getSZ(0);
  @$pb.TagNumber(1)
  set crowdfundId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCrowdfundId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCrowdfundId() => $_clearField(1);
}

class DeleteCrowdfundResponse extends $pb.GeneratedMessage {
  factory DeleteCrowdfundResponse({
    $core.bool? success,
    $core.String? message,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    return result;
  }

  DeleteCrowdfundResponse._();

  factory DeleteCrowdfundResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeleteCrowdfundResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteCrowdfundResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteCrowdfundResponse clone() =>
      DeleteCrowdfundResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteCrowdfundResponse copyWith(
          void Function(DeleteCrowdfundResponse) updates) =>
      super.copyWith((message) => updates(message as DeleteCrowdfundResponse))
          as DeleteCrowdfundResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteCrowdfundResponse create() => DeleteCrowdfundResponse._();
  @$core.override
  DeleteCrowdfundResponse createEmptyInstance() => create();
  static $pb.PbList<DeleteCrowdfundResponse> createRepeated() =>
      $pb.PbList<DeleteCrowdfundResponse>();
  @$core.pragma('dart2js:noInline')
  static DeleteCrowdfundResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteCrowdfundResponse>(create);
  static DeleteCrowdfundResponse? _defaultInstance;

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

/// Make Donation
class MakeDonationRequest extends $pb.GeneratedMessage {
  factory MakeDonationRequest({
    $core.String? crowdfundId,
    $fixnum.Int64? amount,
    $core.String? message,
    $core.bool? isAnonymous,
    $core.String? sourceAccountId,
    $core.String? transactionPin,
  }) {
    final result = create();
    if (crowdfundId != null) result.crowdfundId = crowdfundId;
    if (amount != null) result.amount = amount;
    if (message != null) result.message = message;
    if (isAnonymous != null) result.isAnonymous = isAnonymous;
    if (sourceAccountId != null) result.sourceAccountId = sourceAccountId;
    if (transactionPin != null) result.transactionPin = transactionPin;
    return result;
  }

  MakeDonationRequest._();

  factory MakeDonationRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MakeDonationRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MakeDonationRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'crowdfundId')
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(3, _omitFieldNames ? '' : 'message')
    ..aOB(4, _omitFieldNames ? '' : 'isAnonymous')
    ..aOS(5, _omitFieldNames ? '' : 'sourceAccountId')
    ..aOS(6, _omitFieldNames ? '' : 'transactionPin')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MakeDonationRequest clone() => MakeDonationRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MakeDonationRequest copyWith(void Function(MakeDonationRequest) updates) =>
      super.copyWith((message) => updates(message as MakeDonationRequest))
          as MakeDonationRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MakeDonationRequest create() => MakeDonationRequest._();
  @$core.override
  MakeDonationRequest createEmptyInstance() => create();
  static $pb.PbList<MakeDonationRequest> createRepeated() =>
      $pb.PbList<MakeDonationRequest>();
  @$core.pragma('dart2js:noInline')
  static MakeDonationRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MakeDonationRequest>(create);
  static MakeDonationRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get crowdfundId => $_getSZ(0);
  @$pb.TagNumber(1)
  set crowdfundId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCrowdfundId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCrowdfundId() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get amount => $_getI64(1);
  @$pb.TagNumber(2)
  set amount($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.bool get isAnonymous => $_getBF(3);
  @$pb.TagNumber(4)
  set isAnonymous($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasIsAnonymous() => $_has(3);
  @$pb.TagNumber(4)
  void clearIsAnonymous() => $_clearField(4);

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

class MakeDonationResponse extends $pb.GeneratedMessage {
  factory MakeDonationResponse({
    CrowdfundDonationMessage? donation,
  }) {
    final result = create();
    if (donation != null) result.donation = donation;
    return result;
  }

  MakeDonationResponse._();

  factory MakeDonationResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MakeDonationResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MakeDonationResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<CrowdfundDonationMessage>(1, _omitFieldNames ? '' : 'donation',
        subBuilder: CrowdfundDonationMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MakeDonationResponse clone() =>
      MakeDonationResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MakeDonationResponse copyWith(void Function(MakeDonationResponse) updates) =>
      super.copyWith((message) => updates(message as MakeDonationResponse))
          as MakeDonationResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MakeDonationResponse create() => MakeDonationResponse._();
  @$core.override
  MakeDonationResponse createEmptyInstance() => create();
  static $pb.PbList<MakeDonationResponse> createRepeated() =>
      $pb.PbList<MakeDonationResponse>();
  @$core.pragma('dart2js:noInline')
  static MakeDonationResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MakeDonationResponse>(create);
  static MakeDonationResponse? _defaultInstance;

  @$pb.TagNumber(1)
  CrowdfundDonationMessage get donation => $_getN(0);
  @$pb.TagNumber(1)
  set donation(CrowdfundDonationMessage value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasDonation() => $_has(0);
  @$pb.TagNumber(1)
  void clearDonation() => $_clearField(1);
  @$pb.TagNumber(1)
  CrowdfundDonationMessage ensureDonation() => $_ensure(0);
}

/// Get Crowdfund Donations
class GetCrowdfundDonationsRequest extends $pb.GeneratedMessage {
  factory GetCrowdfundDonationsRequest({
    $core.String? crowdfundId,
    $core.int? page,
    $core.int? pageSize,
  }) {
    final result = create();
    if (crowdfundId != null) result.crowdfundId = crowdfundId;
    if (page != null) result.page = page;
    if (pageSize != null) result.pageSize = pageSize;
    return result;
  }

  GetCrowdfundDonationsRequest._();

  factory GetCrowdfundDonationsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetCrowdfundDonationsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetCrowdfundDonationsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'crowdfundId')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCrowdfundDonationsRequest clone() =>
      GetCrowdfundDonationsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCrowdfundDonationsRequest copyWith(
          void Function(GetCrowdfundDonationsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetCrowdfundDonationsRequest))
          as GetCrowdfundDonationsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetCrowdfundDonationsRequest create() =>
      GetCrowdfundDonationsRequest._();
  @$core.override
  GetCrowdfundDonationsRequest createEmptyInstance() => create();
  static $pb.PbList<GetCrowdfundDonationsRequest> createRepeated() =>
      $pb.PbList<GetCrowdfundDonationsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetCrowdfundDonationsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetCrowdfundDonationsRequest>(create);
  static GetCrowdfundDonationsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get crowdfundId => $_getSZ(0);
  @$pb.TagNumber(1)
  set crowdfundId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCrowdfundId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCrowdfundId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get page => $_getIZ(1);
  @$pb.TagNumber(2)
  set page($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPage() => $_has(1);
  @$pb.TagNumber(2)
  void clearPage() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get pageSize => $_getIZ(2);
  @$pb.TagNumber(3)
  set pageSize($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPageSize() => $_has(2);
  @$pb.TagNumber(3)
  void clearPageSize() => $_clearField(3);
}

class GetCrowdfundDonationsResponse extends $pb.GeneratedMessage {
  factory GetCrowdfundDonationsResponse({
    $core.Iterable<CrowdfundDonationMessage>? donations,
    DonationPaginationInfo? pagination,
  }) {
    final result = create();
    if (donations != null) result.donations.addAll(donations);
    if (pagination != null) result.pagination = pagination;
    return result;
  }

  GetCrowdfundDonationsResponse._();

  factory GetCrowdfundDonationsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetCrowdfundDonationsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetCrowdfundDonationsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<CrowdfundDonationMessage>(
        1, _omitFieldNames ? '' : 'donations', $pb.PbFieldType.PM,
        subBuilder: CrowdfundDonationMessage.create)
    ..aOM<DonationPaginationInfo>(2, _omitFieldNames ? '' : 'pagination',
        subBuilder: DonationPaginationInfo.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCrowdfundDonationsResponse clone() =>
      GetCrowdfundDonationsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCrowdfundDonationsResponse copyWith(
          void Function(GetCrowdfundDonationsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetCrowdfundDonationsResponse))
          as GetCrowdfundDonationsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetCrowdfundDonationsResponse create() =>
      GetCrowdfundDonationsResponse._();
  @$core.override
  GetCrowdfundDonationsResponse createEmptyInstance() => create();
  static $pb.PbList<GetCrowdfundDonationsResponse> createRepeated() =>
      $pb.PbList<GetCrowdfundDonationsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetCrowdfundDonationsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetCrowdfundDonationsResponse>(create);
  static GetCrowdfundDonationsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<CrowdfundDonationMessage> get donations => $_getList(0);

  @$pb.TagNumber(2)
  DonationPaginationInfo get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination(DonationPaginationInfo value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => $_clearField(2);
  @$pb.TagNumber(2)
  DonationPaginationInfo ensurePagination() => $_ensure(1);
}

/// Get User Donations
class GetUserDonationsRequest extends $pb.GeneratedMessage {
  factory GetUserDonationsRequest({
    $core.int? page,
    $core.int? pageSize,
  }) {
    final result = create();
    if (page != null) result.page = page;
    if (pageSize != null) result.pageSize = pageSize;
    return result;
  }

  GetUserDonationsRequest._();

  factory GetUserDonationsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetUserDonationsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUserDonationsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserDonationsRequest clone() =>
      GetUserDonationsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserDonationsRequest copyWith(
          void Function(GetUserDonationsRequest) updates) =>
      super.copyWith((message) => updates(message as GetUserDonationsRequest))
          as GetUserDonationsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserDonationsRequest create() => GetUserDonationsRequest._();
  @$core.override
  GetUserDonationsRequest createEmptyInstance() => create();
  static $pb.PbList<GetUserDonationsRequest> createRepeated() =>
      $pb.PbList<GetUserDonationsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetUserDonationsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetUserDonationsRequest>(create);
  static GetUserDonationsRequest? _defaultInstance;

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

class GetUserDonationsResponse extends $pb.GeneratedMessage {
  factory GetUserDonationsResponse({
    $core.Iterable<CrowdfundDonationMessage>? donations,
    DonationPaginationInfo? pagination,
  }) {
    final result = create();
    if (donations != null) result.donations.addAll(donations);
    if (pagination != null) result.pagination = pagination;
    return result;
  }

  GetUserDonationsResponse._();

  factory GetUserDonationsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetUserDonationsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUserDonationsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<CrowdfundDonationMessage>(
        1, _omitFieldNames ? '' : 'donations', $pb.PbFieldType.PM,
        subBuilder: CrowdfundDonationMessage.create)
    ..aOM<DonationPaginationInfo>(2, _omitFieldNames ? '' : 'pagination',
        subBuilder: DonationPaginationInfo.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserDonationsResponse clone() =>
      GetUserDonationsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserDonationsResponse copyWith(
          void Function(GetUserDonationsResponse) updates) =>
      super.copyWith((message) => updates(message as GetUserDonationsResponse))
          as GetUserDonationsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserDonationsResponse create() => GetUserDonationsResponse._();
  @$core.override
  GetUserDonationsResponse createEmptyInstance() => create();
  static $pb.PbList<GetUserDonationsResponse> createRepeated() =>
      $pb.PbList<GetUserDonationsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetUserDonationsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetUserDonationsResponse>(create);
  static GetUserDonationsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<CrowdfundDonationMessage> get donations => $_getList(0);

  @$pb.TagNumber(2)
  DonationPaginationInfo get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination(DonationPaginationInfo value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => $_clearField(2);
  @$pb.TagNumber(2)
  DonationPaginationInfo ensurePagination() => $_ensure(1);
}

/// Generate Receipt
class GenerateDonationReceiptRequest extends $pb.GeneratedMessage {
  factory GenerateDonationReceiptRequest({
    $core.String? donationId,
  }) {
    final result = create();
    if (donationId != null) result.donationId = donationId;
    return result;
  }

  GenerateDonationReceiptRequest._();

  factory GenerateDonationReceiptRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GenerateDonationReceiptRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GenerateDonationReceiptRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'donationId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GenerateDonationReceiptRequest clone() =>
      GenerateDonationReceiptRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GenerateDonationReceiptRequest copyWith(
          void Function(GenerateDonationReceiptRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GenerateDonationReceiptRequest))
          as GenerateDonationReceiptRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GenerateDonationReceiptRequest create() =>
      GenerateDonationReceiptRequest._();
  @$core.override
  GenerateDonationReceiptRequest createEmptyInstance() => create();
  static $pb.PbList<GenerateDonationReceiptRequest> createRepeated() =>
      $pb.PbList<GenerateDonationReceiptRequest>();
  @$core.pragma('dart2js:noInline')
  static GenerateDonationReceiptRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GenerateDonationReceiptRequest>(create);
  static GenerateDonationReceiptRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get donationId => $_getSZ(0);
  @$pb.TagNumber(1)
  set donationId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDonationId() => $_has(0);
  @$pb.TagNumber(1)
  void clearDonationId() => $_clearField(1);
}

class GenerateDonationReceiptResponse extends $pb.GeneratedMessage {
  factory GenerateDonationReceiptResponse({
    CrowdfundReceiptMessage? receipt,
  }) {
    final result = create();
    if (receipt != null) result.receipt = receipt;
    return result;
  }

  GenerateDonationReceiptResponse._();

  factory GenerateDonationReceiptResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GenerateDonationReceiptResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GenerateDonationReceiptResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<CrowdfundReceiptMessage>(1, _omitFieldNames ? '' : 'receipt',
        subBuilder: CrowdfundReceiptMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GenerateDonationReceiptResponse clone() =>
      GenerateDonationReceiptResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GenerateDonationReceiptResponse copyWith(
          void Function(GenerateDonationReceiptResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GenerateDonationReceiptResponse))
          as GenerateDonationReceiptResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GenerateDonationReceiptResponse create() =>
      GenerateDonationReceiptResponse._();
  @$core.override
  GenerateDonationReceiptResponse createEmptyInstance() => create();
  static $pb.PbList<GenerateDonationReceiptResponse> createRepeated() =>
      $pb.PbList<GenerateDonationReceiptResponse>();
  @$core.pragma('dart2js:noInline')
  static GenerateDonationReceiptResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GenerateDonationReceiptResponse>(
          create);
  static GenerateDonationReceiptResponse? _defaultInstance;

  @$pb.TagNumber(1)
  CrowdfundReceiptMessage get receipt => $_getN(0);
  @$pb.TagNumber(1)
  set receipt(CrowdfundReceiptMessage value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasReceipt() => $_has(0);
  @$pb.TagNumber(1)
  void clearReceipt() => $_clearField(1);
  @$pb.TagNumber(1)
  CrowdfundReceiptMessage ensureReceipt() => $_ensure(0);
}

/// Get User Receipts
class GetUserCrowdfundReceiptsRequest extends $pb.GeneratedMessage {
  factory GetUserCrowdfundReceiptsRequest({
    $core.int? page,
    $core.int? pageSize,
  }) {
    final result = create();
    if (page != null) result.page = page;
    if (pageSize != null) result.pageSize = pageSize;
    return result;
  }

  GetUserCrowdfundReceiptsRequest._();

  factory GetUserCrowdfundReceiptsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetUserCrowdfundReceiptsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUserCrowdfundReceiptsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserCrowdfundReceiptsRequest clone() =>
      GetUserCrowdfundReceiptsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserCrowdfundReceiptsRequest copyWith(
          void Function(GetUserCrowdfundReceiptsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetUserCrowdfundReceiptsRequest))
          as GetUserCrowdfundReceiptsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserCrowdfundReceiptsRequest create() =>
      GetUserCrowdfundReceiptsRequest._();
  @$core.override
  GetUserCrowdfundReceiptsRequest createEmptyInstance() => create();
  static $pb.PbList<GetUserCrowdfundReceiptsRequest> createRepeated() =>
      $pb.PbList<GetUserCrowdfundReceiptsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetUserCrowdfundReceiptsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetUserCrowdfundReceiptsRequest>(
          create);
  static GetUserCrowdfundReceiptsRequest? _defaultInstance;

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

class GetUserCrowdfundReceiptsResponse extends $pb.GeneratedMessage {
  factory GetUserCrowdfundReceiptsResponse({
    $core.Iterable<CrowdfundReceiptMessage>? receipts,
    CrowdfundReceiptPaginationInfo? pagination,
  }) {
    final result = create();
    if (receipts != null) result.receipts.addAll(receipts);
    if (pagination != null) result.pagination = pagination;
    return result;
  }

  GetUserCrowdfundReceiptsResponse._();

  factory GetUserCrowdfundReceiptsResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetUserCrowdfundReceiptsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUserCrowdfundReceiptsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<CrowdfundReceiptMessage>(
        1, _omitFieldNames ? '' : 'receipts', $pb.PbFieldType.PM,
        subBuilder: CrowdfundReceiptMessage.create)
    ..aOM<CrowdfundReceiptPaginationInfo>(
        2, _omitFieldNames ? '' : 'pagination',
        subBuilder: CrowdfundReceiptPaginationInfo.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserCrowdfundReceiptsResponse clone() =>
      GetUserCrowdfundReceiptsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserCrowdfundReceiptsResponse copyWith(
          void Function(GetUserCrowdfundReceiptsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetUserCrowdfundReceiptsResponse))
          as GetUserCrowdfundReceiptsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserCrowdfundReceiptsResponse create() =>
      GetUserCrowdfundReceiptsResponse._();
  @$core.override
  GetUserCrowdfundReceiptsResponse createEmptyInstance() => create();
  static $pb.PbList<GetUserCrowdfundReceiptsResponse> createRepeated() =>
      $pb.PbList<GetUserCrowdfundReceiptsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetUserCrowdfundReceiptsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetUserCrowdfundReceiptsResponse>(
          create);
  static GetUserCrowdfundReceiptsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<CrowdfundReceiptMessage> get receipts => $_getList(0);

  @$pb.TagNumber(2)
  CrowdfundReceiptPaginationInfo get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination(CrowdfundReceiptPaginationInfo value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => $_clearField(2);
  @$pb.TagNumber(2)
  CrowdfundReceiptPaginationInfo ensurePagination() => $_ensure(1);
}

/// Get Crowdfund Statistics
class GetCrowdfundStatisticsRequest extends $pb.GeneratedMessage {
  factory GetCrowdfundStatisticsRequest({
    $core.String? crowdfundId,
  }) {
    final result = create();
    if (crowdfundId != null) result.crowdfundId = crowdfundId;
    return result;
  }

  GetCrowdfundStatisticsRequest._();

  factory GetCrowdfundStatisticsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetCrowdfundStatisticsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetCrowdfundStatisticsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'crowdfundId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCrowdfundStatisticsRequest clone() =>
      GetCrowdfundStatisticsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCrowdfundStatisticsRequest copyWith(
          void Function(GetCrowdfundStatisticsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetCrowdfundStatisticsRequest))
          as GetCrowdfundStatisticsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetCrowdfundStatisticsRequest create() =>
      GetCrowdfundStatisticsRequest._();
  @$core.override
  GetCrowdfundStatisticsRequest createEmptyInstance() => create();
  static $pb.PbList<GetCrowdfundStatisticsRequest> createRepeated() =>
      $pb.PbList<GetCrowdfundStatisticsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetCrowdfundStatisticsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetCrowdfundStatisticsRequest>(create);
  static GetCrowdfundStatisticsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get crowdfundId => $_getSZ(0);
  @$pb.TagNumber(1)
  set crowdfundId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCrowdfundId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCrowdfundId() => $_clearField(1);
}

class GetCrowdfundStatisticsResponse extends $pb.GeneratedMessage {
  factory GetCrowdfundStatisticsResponse({
    $core.String? crowdfundId,
    $fixnum.Int64? totalRaised,
    $fixnum.Int64? targetAmount,
    $core.double? progressPercentage,
    $core.int? donorCount,
    $fixnum.Int64? averageDonation,
    $fixnum.Int64? largestDonation,
    $core.int? daysRemaining,
    $core.bool? isCompleted,
    $1.Timestamp? createdAt,
    $core.int? uniqueDonors,
    $fixnum.Int64? smallestDonation,
    $core.Iterable<ContributorLeaderboardEntry>? topContributors,
    $core.Iterable<DailyProgressEntry>? dailyProgress,
    $core.double? fundingVelocity,
    $core.String? projectedCompletionDate,
  }) {
    final result = create();
    if (crowdfundId != null) result.crowdfundId = crowdfundId;
    if (totalRaised != null) result.totalRaised = totalRaised;
    if (targetAmount != null) result.targetAmount = targetAmount;
    if (progressPercentage != null)
      result.progressPercentage = progressPercentage;
    if (donorCount != null) result.donorCount = donorCount;
    if (averageDonation != null) result.averageDonation = averageDonation;
    if (largestDonation != null) result.largestDonation = largestDonation;
    if (daysRemaining != null) result.daysRemaining = daysRemaining;
    if (isCompleted != null) result.isCompleted = isCompleted;
    if (createdAt != null) result.createdAt = createdAt;
    if (uniqueDonors != null) result.uniqueDonors = uniqueDonors;
    if (smallestDonation != null) result.smallestDonation = smallestDonation;
    if (topContributors != null) result.topContributors.addAll(topContributors);
    if (dailyProgress != null) result.dailyProgress.addAll(dailyProgress);
    if (fundingVelocity != null) result.fundingVelocity = fundingVelocity;
    if (projectedCompletionDate != null)
      result.projectedCompletionDate = projectedCompletionDate;
    return result;
  }

  GetCrowdfundStatisticsResponse._();

  factory GetCrowdfundStatisticsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetCrowdfundStatisticsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetCrowdfundStatisticsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'crowdfundId')
    ..a<$fixnum.Int64>(
        2, _omitFieldNames ? '' : 'totalRaised', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(
        3, _omitFieldNames ? '' : 'targetAmount', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.double>(
        4, _omitFieldNames ? '' : 'progressPercentage', $pb.PbFieldType.OD)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'donorCount', $pb.PbFieldType.O3)
    ..a<$fixnum.Int64>(
        6, _omitFieldNames ? '' : 'averageDonation', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(
        7, _omitFieldNames ? '' : 'largestDonation', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(
        8, _omitFieldNames ? '' : 'daysRemaining', $pb.PbFieldType.O3)
    ..aOB(9, _omitFieldNames ? '' : 'isCompleted')
    ..aOM<$1.Timestamp>(10, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $1.Timestamp.create)
    ..a<$core.int>(
        11, _omitFieldNames ? '' : 'uniqueDonors', $pb.PbFieldType.O3)
    ..a<$fixnum.Int64>(
        12, _omitFieldNames ? '' : 'smallestDonation', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..pc<ContributorLeaderboardEntry>(
        13, _omitFieldNames ? '' : 'topContributors', $pb.PbFieldType.PM,
        subBuilder: ContributorLeaderboardEntry.create)
    ..pc<DailyProgressEntry>(
        14, _omitFieldNames ? '' : 'dailyProgress', $pb.PbFieldType.PM,
        subBuilder: DailyProgressEntry.create)
    ..a<$core.double>(
        15, _omitFieldNames ? '' : 'fundingVelocity', $pb.PbFieldType.OD)
    ..aOS(16, _omitFieldNames ? '' : 'projectedCompletionDate')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCrowdfundStatisticsResponse clone() =>
      GetCrowdfundStatisticsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCrowdfundStatisticsResponse copyWith(
          void Function(GetCrowdfundStatisticsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetCrowdfundStatisticsResponse))
          as GetCrowdfundStatisticsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetCrowdfundStatisticsResponse create() =>
      GetCrowdfundStatisticsResponse._();
  @$core.override
  GetCrowdfundStatisticsResponse createEmptyInstance() => create();
  static $pb.PbList<GetCrowdfundStatisticsResponse> createRepeated() =>
      $pb.PbList<GetCrowdfundStatisticsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetCrowdfundStatisticsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetCrowdfundStatisticsResponse>(create);
  static GetCrowdfundStatisticsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get crowdfundId => $_getSZ(0);
  @$pb.TagNumber(1)
  set crowdfundId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCrowdfundId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCrowdfundId() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get totalRaised => $_getI64(1);
  @$pb.TagNumber(2)
  set totalRaised($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotalRaised() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalRaised() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get targetAmount => $_getI64(2);
  @$pb.TagNumber(3)
  set targetAmount($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTargetAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearTargetAmount() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get progressPercentage => $_getN(3);
  @$pb.TagNumber(4)
  set progressPercentage($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasProgressPercentage() => $_has(3);
  @$pb.TagNumber(4)
  void clearProgressPercentage() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get donorCount => $_getIZ(4);
  @$pb.TagNumber(5)
  set donorCount($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasDonorCount() => $_has(4);
  @$pb.TagNumber(5)
  void clearDonorCount() => $_clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get averageDonation => $_getI64(5);
  @$pb.TagNumber(6)
  set averageDonation($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasAverageDonation() => $_has(5);
  @$pb.TagNumber(6)
  void clearAverageDonation() => $_clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get largestDonation => $_getI64(6);
  @$pb.TagNumber(7)
  set largestDonation($fixnum.Int64 value) => $_setInt64(6, value);
  @$pb.TagNumber(7)
  $core.bool hasLargestDonation() => $_has(6);
  @$pb.TagNumber(7)
  void clearLargestDonation() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.int get daysRemaining => $_getIZ(7);
  @$pb.TagNumber(8)
  set daysRemaining($core.int value) => $_setSignedInt32(7, value);
  @$pb.TagNumber(8)
  $core.bool hasDaysRemaining() => $_has(7);
  @$pb.TagNumber(8)
  void clearDaysRemaining() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.bool get isCompleted => $_getBF(8);
  @$pb.TagNumber(9)
  set isCompleted($core.bool value) => $_setBool(8, value);
  @$pb.TagNumber(9)
  $core.bool hasIsCompleted() => $_has(8);
  @$pb.TagNumber(9)
  void clearIsCompleted() => $_clearField(9);

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

  /// Enhanced statistics fields
  @$pb.TagNumber(11)
  $core.int get uniqueDonors => $_getIZ(10);
  @$pb.TagNumber(11)
  set uniqueDonors($core.int value) => $_setSignedInt32(10, value);
  @$pb.TagNumber(11)
  $core.bool hasUniqueDonors() => $_has(10);
  @$pb.TagNumber(11)
  void clearUniqueDonors() => $_clearField(11);

  @$pb.TagNumber(12)
  $fixnum.Int64 get smallestDonation => $_getI64(11);
  @$pb.TagNumber(12)
  set smallestDonation($fixnum.Int64 value) => $_setInt64(11, value);
  @$pb.TagNumber(12)
  $core.bool hasSmallestDonation() => $_has(11);
  @$pb.TagNumber(12)
  void clearSmallestDonation() => $_clearField(12);

  @$pb.TagNumber(13)
  $pb.PbList<ContributorLeaderboardEntry> get topContributors => $_getList(12);

  @$pb.TagNumber(14)
  $pb.PbList<DailyProgressEntry> get dailyProgress => $_getList(13);

  @$pb.TagNumber(15)
  $core.double get fundingVelocity => $_getN(14);
  @$pb.TagNumber(15)
  set fundingVelocity($core.double value) => $_setDouble(14, value);
  @$pb.TagNumber(15)
  $core.bool hasFundingVelocity() => $_has(14);
  @$pb.TagNumber(15)
  void clearFundingVelocity() => $_clearField(15);

  @$pb.TagNumber(16)
  $core.String get projectedCompletionDate => $_getSZ(15);
  @$pb.TagNumber(16)
  set projectedCompletionDate($core.String value) => $_setString(15, value);
  @$pb.TagNumber(16)
  $core.bool hasProjectedCompletionDate() => $_has(15);
  @$pb.TagNumber(16)
  void clearProjectedCompletionDate() => $_clearField(16);
}

/// Leaderboard entry for top contributors
class ContributorLeaderboardEntry extends $pb.GeneratedMessage {
  factory ContributorLeaderboardEntry({
    $core.int? rank,
    $core.String? displayName,
    $core.double? totalAmount,
    $core.int? contributionCount,
    $core.bool? isAnonymous,
  }) {
    final result = create();
    if (rank != null) result.rank = rank;
    if (displayName != null) result.displayName = displayName;
    if (totalAmount != null) result.totalAmount = totalAmount;
    if (contributionCount != null) result.contributionCount = contributionCount;
    if (isAnonymous != null) result.isAnonymous = isAnonymous;
    return result;
  }

  ContributorLeaderboardEntry._();

  factory ContributorLeaderboardEntry.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ContributorLeaderboardEntry.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ContributorLeaderboardEntry',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'rank', $pb.PbFieldType.O3)
    ..aOS(2, _omitFieldNames ? '' : 'displayName')
    ..a<$core.double>(
        3, _omitFieldNames ? '' : 'totalAmount', $pb.PbFieldType.OD)
    ..a<$core.int>(
        4, _omitFieldNames ? '' : 'contributionCount', $pb.PbFieldType.O3)
    ..aOB(5, _omitFieldNames ? '' : 'isAnonymous')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ContributorLeaderboardEntry clone() =>
      ContributorLeaderboardEntry()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ContributorLeaderboardEntry copyWith(
          void Function(ContributorLeaderboardEntry) updates) =>
      super.copyWith(
              (message) => updates(message as ContributorLeaderboardEntry))
          as ContributorLeaderboardEntry;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ContributorLeaderboardEntry create() =>
      ContributorLeaderboardEntry._();
  @$core.override
  ContributorLeaderboardEntry createEmptyInstance() => create();
  static $pb.PbList<ContributorLeaderboardEntry> createRepeated() =>
      $pb.PbList<ContributorLeaderboardEntry>();
  @$core.pragma('dart2js:noInline')
  static ContributorLeaderboardEntry getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ContributorLeaderboardEntry>(create);
  static ContributorLeaderboardEntry? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get rank => $_getIZ(0);
  @$pb.TagNumber(1)
  set rank($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRank() => $_has(0);
  @$pb.TagNumber(1)
  void clearRank() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get displayName => $_getSZ(1);
  @$pb.TagNumber(2)
  set displayName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDisplayName() => $_has(1);
  @$pb.TagNumber(2)
  void clearDisplayName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get totalAmount => $_getN(2);
  @$pb.TagNumber(3)
  set totalAmount($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTotalAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalAmount() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get contributionCount => $_getIZ(3);
  @$pb.TagNumber(4)
  set contributionCount($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasContributionCount() => $_has(3);
  @$pb.TagNumber(4)
  void clearContributionCount() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.bool get isAnonymous => $_getBF(4);
  @$pb.TagNumber(5)
  set isAnonymous($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasIsAnonymous() => $_has(4);
  @$pb.TagNumber(5)
  void clearIsAnonymous() => $_clearField(5);
}

/// Daily progress tracking
class DailyProgressEntry extends $pb.GeneratedMessage {
  factory DailyProgressEntry({
    $core.String? date,
    $core.double? amount,
    $core.int? donationCount,
    $core.double? cumulativeAmount,
  }) {
    final result = create();
    if (date != null) result.date = date;
    if (amount != null) result.amount = amount;
    if (donationCount != null) result.donationCount = donationCount;
    if (cumulativeAmount != null) result.cumulativeAmount = cumulativeAmount;
    return result;
  }

  DailyProgressEntry._();

  factory DailyProgressEntry.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DailyProgressEntry.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DailyProgressEntry',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'date')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..a<$core.int>(
        3, _omitFieldNames ? '' : 'donationCount', $pb.PbFieldType.O3)
    ..a<$core.double>(
        4, _omitFieldNames ? '' : 'cumulativeAmount', $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DailyProgressEntry clone() => DailyProgressEntry()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DailyProgressEntry copyWith(void Function(DailyProgressEntry) updates) =>
      super.copyWith((message) => updates(message as DailyProgressEntry))
          as DailyProgressEntry;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DailyProgressEntry create() => DailyProgressEntry._();
  @$core.override
  DailyProgressEntry createEmptyInstance() => create();
  static $pb.PbList<DailyProgressEntry> createRepeated() =>
      $pb.PbList<DailyProgressEntry>();
  @$core.pragma('dart2js:noInline')
  static DailyProgressEntry getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DailyProgressEntry>(create);
  static DailyProgressEntry? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get date => $_getSZ(0);
  @$pb.TagNumber(1)
  set date($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDate() => $_has(0);
  @$pb.TagNumber(1)
  void clearDate() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get amount => $_getN(1);
  @$pb.TagNumber(2)
  set amount($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get donationCount => $_getIZ(2);
  @$pb.TagNumber(3)
  set donationCount($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDonationCount() => $_has(2);
  @$pb.TagNumber(3)
  void clearDonationCount() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get cumulativeAmount => $_getN(3);
  @$pb.TagNumber(4)
  set cumulativeAmount($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCumulativeAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearCumulativeAmount() => $_clearField(4);
}

/// Withdraw from Crowdfund (Campaign Creator Only)
class WithdrawFromCrowdfundRequest extends $pb.GeneratedMessage {
  factory WithdrawFromCrowdfundRequest({
    $core.String? crowdfundId,
    $fixnum.Int64? amount,
    $core.String? transactionPin,
    $core.String? destinationAccountId,
    $core.String? destinationAccountType,
  }) {
    final result = create();
    if (crowdfundId != null) result.crowdfundId = crowdfundId;
    if (amount != null) result.amount = amount;
    if (transactionPin != null) result.transactionPin = transactionPin;
    if (destinationAccountId != null)
      result.destinationAccountId = destinationAccountId;
    if (destinationAccountType != null)
      result.destinationAccountType = destinationAccountType;
    return result;
  }

  WithdrawFromCrowdfundRequest._();

  factory WithdrawFromCrowdfundRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory WithdrawFromCrowdfundRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'WithdrawFromCrowdfundRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'crowdfundId')
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(3, _omitFieldNames ? '' : 'transactionPin')
    ..aOS(4, _omitFieldNames ? '' : 'destinationAccountId')
    ..aOS(5, _omitFieldNames ? '' : 'destinationAccountType')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WithdrawFromCrowdfundRequest clone() =>
      WithdrawFromCrowdfundRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WithdrawFromCrowdfundRequest copyWith(
          void Function(WithdrawFromCrowdfundRequest) updates) =>
      super.copyWith(
              (message) => updates(message as WithdrawFromCrowdfundRequest))
          as WithdrawFromCrowdfundRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WithdrawFromCrowdfundRequest create() =>
      WithdrawFromCrowdfundRequest._();
  @$core.override
  WithdrawFromCrowdfundRequest createEmptyInstance() => create();
  static $pb.PbList<WithdrawFromCrowdfundRequest> createRepeated() =>
      $pb.PbList<WithdrawFromCrowdfundRequest>();
  @$core.pragma('dart2js:noInline')
  static WithdrawFromCrowdfundRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<WithdrawFromCrowdfundRequest>(create);
  static WithdrawFromCrowdfundRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get crowdfundId => $_getSZ(0);
  @$pb.TagNumber(1)
  set crowdfundId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCrowdfundId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCrowdfundId() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get amount => $_getI64(1);
  @$pb.TagNumber(2)
  set amount($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get transactionPin => $_getSZ(2);
  @$pb.TagNumber(3)
  set transactionPin($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTransactionPin() => $_has(2);
  @$pb.TagNumber(3)
  void clearTransactionPin() => $_clearField(3);

  /// Destination account for withdrawal - one of the following:
  /// If destination_account_id is set, funds go to that specific account
  /// If destination_account_type is set, funds go to user's account of that type
  /// If neither is set, funds go to user's primary account
  @$pb.TagNumber(4)
  $core.String get destinationAccountId => $_getSZ(3);
  @$pb.TagNumber(4)
  set destinationAccountId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDestinationAccountId() => $_has(3);
  @$pb.TagNumber(4)
  void clearDestinationAccountId() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get destinationAccountType => $_getSZ(4);
  @$pb.TagNumber(5)
  set destinationAccountType($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasDestinationAccountType() => $_has(4);
  @$pb.TagNumber(5)
  void clearDestinationAccountType() => $_clearField(5);
}

class WithdrawFromCrowdfundResponse extends $pb.GeneratedMessage {
  factory WithdrawFromCrowdfundResponse({
    $core.String? crowdfundId,
    $fixnum.Int64? amountWithdrawn,
    $fixnum.Int64? remainingBalance,
    $core.String? destinationAccountId,
    $fixnum.Int64? destinationNewBalance,
    $core.String? message,
  }) {
    final result = create();
    if (crowdfundId != null) result.crowdfundId = crowdfundId;
    if (amountWithdrawn != null) result.amountWithdrawn = amountWithdrawn;
    if (remainingBalance != null) result.remainingBalance = remainingBalance;
    if (destinationAccountId != null)
      result.destinationAccountId = destinationAccountId;
    if (destinationNewBalance != null)
      result.destinationNewBalance = destinationNewBalance;
    if (message != null) result.message = message;
    return result;
  }

  WithdrawFromCrowdfundResponse._();

  factory WithdrawFromCrowdfundResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory WithdrawFromCrowdfundResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'WithdrawFromCrowdfundResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'crowdfundId')
    ..a<$fixnum.Int64>(
        2, _omitFieldNames ? '' : 'amountWithdrawn', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(
        3, _omitFieldNames ? '' : 'remainingBalance', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(4, _omitFieldNames ? '' : 'destinationAccountId')
    ..a<$fixnum.Int64>(
        5, _omitFieldNames ? '' : 'destinationNewBalance', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(6, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WithdrawFromCrowdfundResponse clone() =>
      WithdrawFromCrowdfundResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WithdrawFromCrowdfundResponse copyWith(
          void Function(WithdrawFromCrowdfundResponse) updates) =>
      super.copyWith(
              (message) => updates(message as WithdrawFromCrowdfundResponse))
          as WithdrawFromCrowdfundResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WithdrawFromCrowdfundResponse create() =>
      WithdrawFromCrowdfundResponse._();
  @$core.override
  WithdrawFromCrowdfundResponse createEmptyInstance() => create();
  static $pb.PbList<WithdrawFromCrowdfundResponse> createRepeated() =>
      $pb.PbList<WithdrawFromCrowdfundResponse>();
  @$core.pragma('dart2js:noInline')
  static WithdrawFromCrowdfundResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<WithdrawFromCrowdfundResponse>(create);
  static WithdrawFromCrowdfundResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get crowdfundId => $_getSZ(0);
  @$pb.TagNumber(1)
  set crowdfundId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCrowdfundId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCrowdfundId() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get amountWithdrawn => $_getI64(1);
  @$pb.TagNumber(2)
  set amountWithdrawn($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAmountWithdrawn() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmountWithdrawn() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get remainingBalance => $_getI64(2);
  @$pb.TagNumber(3)
  set remainingBalance($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasRemainingBalance() => $_has(2);
  @$pb.TagNumber(3)
  void clearRemainingBalance() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get destinationAccountId => $_getSZ(3);
  @$pb.TagNumber(4)
  set destinationAccountId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDestinationAccountId() => $_has(3);
  @$pb.TagNumber(4)
  void clearDestinationAccountId() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get destinationNewBalance => $_getI64(4);
  @$pb.TagNumber(5)
  set destinationNewBalance($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasDestinationNewBalance() => $_has(4);
  @$pb.TagNumber(5)
  void clearDestinationNewBalance() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get message => $_getSZ(5);
  @$pb.TagNumber(6)
  set message($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasMessage() => $_has(5);
  @$pb.TagNumber(6)
  void clearMessage() => $_clearField(6);
}

/// Get My Crowdfunds (Creator's campaigns)
class GetMyCrowdfundsRequest extends $pb.GeneratedMessage {
  factory GetMyCrowdfundsRequest({
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

  GetMyCrowdfundsRequest._();

  factory GetMyCrowdfundsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMyCrowdfundsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMyCrowdfundsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOS(3, _omitFieldNames ? '' : 'status')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyCrowdfundsRequest clone() =>
      GetMyCrowdfundsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyCrowdfundsRequest copyWith(
          void Function(GetMyCrowdfundsRequest) updates) =>
      super.copyWith((message) => updates(message as GetMyCrowdfundsRequest))
          as GetMyCrowdfundsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMyCrowdfundsRequest create() => GetMyCrowdfundsRequest._();
  @$core.override
  GetMyCrowdfundsRequest createEmptyInstance() => create();
  static $pb.PbList<GetMyCrowdfundsRequest> createRepeated() =>
      $pb.PbList<GetMyCrowdfundsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMyCrowdfundsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetMyCrowdfundsRequest>(create);
  static GetMyCrowdfundsRequest? _defaultInstance;

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

class GetMyCrowdfundsResponse extends $pb.GeneratedMessage {
  factory GetMyCrowdfundsResponse({
    $core.Iterable<CrowdfundMessage>? crowdfunds,
    CrowdfundPaginationInfo? pagination,
  }) {
    final result = create();
    if (crowdfunds != null) result.crowdfunds.addAll(crowdfunds);
    if (pagination != null) result.pagination = pagination;
    return result;
  }

  GetMyCrowdfundsResponse._();

  factory GetMyCrowdfundsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMyCrowdfundsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMyCrowdfundsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<CrowdfundMessage>(
        1, _omitFieldNames ? '' : 'crowdfunds', $pb.PbFieldType.PM,
        subBuilder: CrowdfundMessage.create)
    ..aOM<CrowdfundPaginationInfo>(2, _omitFieldNames ? '' : 'pagination',
        subBuilder: CrowdfundPaginationInfo.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyCrowdfundsResponse clone() =>
      GetMyCrowdfundsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyCrowdfundsResponse copyWith(
          void Function(GetMyCrowdfundsResponse) updates) =>
      super.copyWith((message) => updates(message as GetMyCrowdfundsResponse))
          as GetMyCrowdfundsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMyCrowdfundsResponse create() => GetMyCrowdfundsResponse._();
  @$core.override
  GetMyCrowdfundsResponse createEmptyInstance() => create();
  static $pb.PbList<GetMyCrowdfundsResponse> createRepeated() =>
      $pb.PbList<GetMyCrowdfundsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMyCrowdfundsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetMyCrowdfundsResponse>(create);
  static GetMyCrowdfundsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<CrowdfundMessage> get crowdfunds => $_getList(0);

  @$pb.TagNumber(2)
  CrowdfundPaginationInfo get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination(CrowdfundPaginationInfo value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => $_clearField(2);
  @$pb.TagNumber(2)
  CrowdfundPaginationInfo ensurePagination() => $_ensure(1);
}

/// Get Campaign Wallet Balance
class GetCampaignWalletBalanceRequest extends $pb.GeneratedMessage {
  factory GetCampaignWalletBalanceRequest({
    $core.String? crowdfundId,
  }) {
    final result = create();
    if (crowdfundId != null) result.crowdfundId = crowdfundId;
    return result;
  }

  GetCampaignWalletBalanceRequest._();

  factory GetCampaignWalletBalanceRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetCampaignWalletBalanceRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetCampaignWalletBalanceRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'crowdfundId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCampaignWalletBalanceRequest clone() =>
      GetCampaignWalletBalanceRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCampaignWalletBalanceRequest copyWith(
          void Function(GetCampaignWalletBalanceRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetCampaignWalletBalanceRequest))
          as GetCampaignWalletBalanceRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetCampaignWalletBalanceRequest create() =>
      GetCampaignWalletBalanceRequest._();
  @$core.override
  GetCampaignWalletBalanceRequest createEmptyInstance() => create();
  static $pb.PbList<GetCampaignWalletBalanceRequest> createRepeated() =>
      $pb.PbList<GetCampaignWalletBalanceRequest>();
  @$core.pragma('dart2js:noInline')
  static GetCampaignWalletBalanceRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetCampaignWalletBalanceRequest>(
          create);
  static GetCampaignWalletBalanceRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get crowdfundId => $_getSZ(0);
  @$pb.TagNumber(1)
  set crowdfundId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCrowdfundId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCrowdfundId() => $_clearField(1);
}

class GetCampaignWalletBalanceResponse extends $pb.GeneratedMessage {
  factory GetCampaignWalletBalanceResponse({
    $core.String? crowdfundId,
    $core.String? campaignWalletId,
    $fixnum.Int64? balance,
    $fixnum.Int64? availableBalance,
    $core.String? currency,
  }) {
    final result = create();
    if (crowdfundId != null) result.crowdfundId = crowdfundId;
    if (campaignWalletId != null) result.campaignWalletId = campaignWalletId;
    if (balance != null) result.balance = balance;
    if (availableBalance != null) result.availableBalance = availableBalance;
    if (currency != null) result.currency = currency;
    return result;
  }

  GetCampaignWalletBalanceResponse._();

  factory GetCampaignWalletBalanceResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetCampaignWalletBalanceResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetCampaignWalletBalanceResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'crowdfundId')
    ..aOS(2, _omitFieldNames ? '' : 'campaignWalletId')
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'balance', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(
        4, _omitFieldNames ? '' : 'availableBalance', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(5, _omitFieldNames ? '' : 'currency')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCampaignWalletBalanceResponse clone() =>
      GetCampaignWalletBalanceResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCampaignWalletBalanceResponse copyWith(
          void Function(GetCampaignWalletBalanceResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetCampaignWalletBalanceResponse))
          as GetCampaignWalletBalanceResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetCampaignWalletBalanceResponse create() =>
      GetCampaignWalletBalanceResponse._();
  @$core.override
  GetCampaignWalletBalanceResponse createEmptyInstance() => create();
  static $pb.PbList<GetCampaignWalletBalanceResponse> createRepeated() =>
      $pb.PbList<GetCampaignWalletBalanceResponse>();
  @$core.pragma('dart2js:noInline')
  static GetCampaignWalletBalanceResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetCampaignWalletBalanceResponse>(
          create);
  static GetCampaignWalletBalanceResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get crowdfundId => $_getSZ(0);
  @$pb.TagNumber(1)
  set crowdfundId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCrowdfundId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCrowdfundId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get campaignWalletId => $_getSZ(1);
  @$pb.TagNumber(2)
  set campaignWalletId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCampaignWalletId() => $_has(1);
  @$pb.TagNumber(2)
  void clearCampaignWalletId() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get balance => $_getI64(2);
  @$pb.TagNumber(3)
  set balance($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasBalance() => $_has(2);
  @$pb.TagNumber(3)
  void clearBalance() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get availableBalance => $_getI64(3);
  @$pb.TagNumber(4)
  set availableBalance($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAvailableBalance() => $_has(3);
  @$pb.TagNumber(4)
  void clearAvailableBalance() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get currency => $_getSZ(4);
  @$pb.TagNumber(5)
  set currency($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasCurrency() => $_has(4);
  @$pb.TagNumber(5)
  void clearCurrency() => $_clearField(5);
}

class CrowdfundPaginationInfo extends $pb.GeneratedMessage {
  factory CrowdfundPaginationInfo({
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

  CrowdfundPaginationInfo._();

  factory CrowdfundPaginationInfo.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CrowdfundPaginationInfo.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CrowdfundPaginationInfo',
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
  CrowdfundPaginationInfo clone() =>
      CrowdfundPaginationInfo()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CrowdfundPaginationInfo copyWith(
          void Function(CrowdfundPaginationInfo) updates) =>
      super.copyWith((message) => updates(message as CrowdfundPaginationInfo))
          as CrowdfundPaginationInfo;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CrowdfundPaginationInfo create() => CrowdfundPaginationInfo._();
  @$core.override
  CrowdfundPaginationInfo createEmptyInstance() => create();
  static $pb.PbList<CrowdfundPaginationInfo> createRepeated() =>
      $pb.PbList<CrowdfundPaginationInfo>();
  @$core.pragma('dart2js:noInline')
  static CrowdfundPaginationInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CrowdfundPaginationInfo>(create);
  static CrowdfundPaginationInfo? _defaultInstance;

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

class DonationPaginationInfo extends $pb.GeneratedMessage {
  factory DonationPaginationInfo({
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

  DonationPaginationInfo._();

  factory DonationPaginationInfo.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DonationPaginationInfo.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DonationPaginationInfo',
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
  DonationPaginationInfo clone() =>
      DonationPaginationInfo()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DonationPaginationInfo copyWith(
          void Function(DonationPaginationInfo) updates) =>
      super.copyWith((message) => updates(message as DonationPaginationInfo))
          as DonationPaginationInfo;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DonationPaginationInfo create() => DonationPaginationInfo._();
  @$core.override
  DonationPaginationInfo createEmptyInstance() => create();
  static $pb.PbList<DonationPaginationInfo> createRepeated() =>
      $pb.PbList<DonationPaginationInfo>();
  @$core.pragma('dart2js:noInline')
  static DonationPaginationInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DonationPaginationInfo>(create);
  static DonationPaginationInfo? _defaultInstance;

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

class CrowdfundReceiptPaginationInfo extends $pb.GeneratedMessage {
  factory CrowdfundReceiptPaginationInfo({
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

  CrowdfundReceiptPaginationInfo._();

  factory CrowdfundReceiptPaginationInfo.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CrowdfundReceiptPaginationInfo.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CrowdfundReceiptPaginationInfo',
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
  CrowdfundReceiptPaginationInfo clone() =>
      CrowdfundReceiptPaginationInfo()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CrowdfundReceiptPaginationInfo copyWith(
          void Function(CrowdfundReceiptPaginationInfo) updates) =>
      super.copyWith(
              (message) => updates(message as CrowdfundReceiptPaginationInfo))
          as CrowdfundReceiptPaginationInfo;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CrowdfundReceiptPaginationInfo create() =>
      CrowdfundReceiptPaginationInfo._();
  @$core.override
  CrowdfundReceiptPaginationInfo createEmptyInstance() => create();
  static $pb.PbList<CrowdfundReceiptPaginationInfo> createRepeated() =>
      $pb.PbList<CrowdfundReceiptPaginationInfo>();
  @$core.pragma('dart2js:noInline')
  static CrowdfundReceiptPaginationInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CrowdfundReceiptPaginationInfo>(create);
  static CrowdfundReceiptPaginationInfo? _defaultInstance;

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

class NotificationChannelMessage extends $pb.GeneratedMessage {
  factory NotificationChannelMessage({
    $core.String? id,
    $core.String? crowdfundId,
    $core.String? creatorUserId,
    NotificationChannelType? channelType,
    NotificationChannelStatus? status,
    $core.String? channelName,
    $core.String? channelUsername,
    $core.Iterable<NotificationEventType>? enabledEvents,
    NotificationPreferencesMessage? preferences,
    $core.String? lastNotificationAt,
    $core.int? notificationCount,
    $core.int? failureCount,
    $core.String? lastError,
    $core.String? createdAt,
    $core.String? updatedAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (crowdfundId != null) result.crowdfundId = crowdfundId;
    if (creatorUserId != null) result.creatorUserId = creatorUserId;
    if (channelType != null) result.channelType = channelType;
    if (status != null) result.status = status;
    if (channelName != null) result.channelName = channelName;
    if (channelUsername != null) result.channelUsername = channelUsername;
    if (enabledEvents != null) result.enabledEvents.addAll(enabledEvents);
    if (preferences != null) result.preferences = preferences;
    if (lastNotificationAt != null)
      result.lastNotificationAt = lastNotificationAt;
    if (notificationCount != null) result.notificationCount = notificationCount;
    if (failureCount != null) result.failureCount = failureCount;
    if (lastError != null) result.lastError = lastError;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    return result;
  }

  NotificationChannelMessage._();

  factory NotificationChannelMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory NotificationChannelMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'NotificationChannelMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'crowdfundId')
    ..aOS(3, _omitFieldNames ? '' : 'creatorUserId')
    ..e<NotificationChannelType>(
        4, _omitFieldNames ? '' : 'channelType', $pb.PbFieldType.OE,
        defaultOrMaker:
            NotificationChannelType.NOTIFICATION_CHANNEL_TYPE_UNSPECIFIED,
        valueOf: NotificationChannelType.valueOf,
        enumValues: NotificationChannelType.values)
    ..e<NotificationChannelStatus>(
        5, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker:
            NotificationChannelStatus.NOTIFICATION_CHANNEL_STATUS_UNSPECIFIED,
        valueOf: NotificationChannelStatus.valueOf,
        enumValues: NotificationChannelStatus.values)
    ..aOS(6, _omitFieldNames ? '' : 'channelName')
    ..aOS(7, _omitFieldNames ? '' : 'channelUsername')
    ..pc<NotificationEventType>(
        8, _omitFieldNames ? '' : 'enabledEvents', $pb.PbFieldType.KE,
        valueOf: NotificationEventType.valueOf,
        enumValues: NotificationEventType.values,
        defaultEnumValue:
            NotificationEventType.NOTIFICATION_EVENT_TYPE_UNSPECIFIED)
    ..aOM<NotificationPreferencesMessage>(
        9, _omitFieldNames ? '' : 'preferences',
        subBuilder: NotificationPreferencesMessage.create)
    ..aOS(10, _omitFieldNames ? '' : 'lastNotificationAt')
    ..a<$core.int>(
        11, _omitFieldNames ? '' : 'notificationCount', $pb.PbFieldType.O3)
    ..a<$core.int>(
        12, _omitFieldNames ? '' : 'failureCount', $pb.PbFieldType.O3)
    ..aOS(13, _omitFieldNames ? '' : 'lastError')
    ..aOS(14, _omitFieldNames ? '' : 'createdAt')
    ..aOS(15, _omitFieldNames ? '' : 'updatedAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  NotificationChannelMessage clone() =>
      NotificationChannelMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  NotificationChannelMessage copyWith(
          void Function(NotificationChannelMessage) updates) =>
      super.copyWith(
              (message) => updates(message as NotificationChannelMessage))
          as NotificationChannelMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NotificationChannelMessage create() => NotificationChannelMessage._();
  @$core.override
  NotificationChannelMessage createEmptyInstance() => create();
  static $pb.PbList<NotificationChannelMessage> createRepeated() =>
      $pb.PbList<NotificationChannelMessage>();
  @$core.pragma('dart2js:noInline')
  static NotificationChannelMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<NotificationChannelMessage>(create);
  static NotificationChannelMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get crowdfundId => $_getSZ(1);
  @$pb.TagNumber(2)
  set crowdfundId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCrowdfundId() => $_has(1);
  @$pb.TagNumber(2)
  void clearCrowdfundId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get creatorUserId => $_getSZ(2);
  @$pb.TagNumber(3)
  set creatorUserId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCreatorUserId() => $_has(2);
  @$pb.TagNumber(3)
  void clearCreatorUserId() => $_clearField(3);

  @$pb.TagNumber(4)
  NotificationChannelType get channelType => $_getN(3);
  @$pb.TagNumber(4)
  set channelType(NotificationChannelType value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasChannelType() => $_has(3);
  @$pb.TagNumber(4)
  void clearChannelType() => $_clearField(4);

  @$pb.TagNumber(5)
  NotificationChannelStatus get status => $_getN(4);
  @$pb.TagNumber(5)
  set status(NotificationChannelStatus value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasStatus() => $_has(4);
  @$pb.TagNumber(5)
  void clearStatus() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get channelName => $_getSZ(5);
  @$pb.TagNumber(6)
  set channelName($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasChannelName() => $_has(5);
  @$pb.TagNumber(6)
  void clearChannelName() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get channelUsername => $_getSZ(6);
  @$pb.TagNumber(7)
  set channelUsername($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasChannelUsername() => $_has(6);
  @$pb.TagNumber(7)
  void clearChannelUsername() => $_clearField(7);

  @$pb.TagNumber(8)
  $pb.PbList<NotificationEventType> get enabledEvents => $_getList(7);

  @$pb.TagNumber(9)
  NotificationPreferencesMessage get preferences => $_getN(8);
  @$pb.TagNumber(9)
  set preferences(NotificationPreferencesMessage value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasPreferences() => $_has(8);
  @$pb.TagNumber(9)
  void clearPreferences() => $_clearField(9);
  @$pb.TagNumber(9)
  NotificationPreferencesMessage ensurePreferences() => $_ensure(8);

  @$pb.TagNumber(10)
  $core.String get lastNotificationAt => $_getSZ(9);
  @$pb.TagNumber(10)
  set lastNotificationAt($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasLastNotificationAt() => $_has(9);
  @$pb.TagNumber(10)
  void clearLastNotificationAt() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.int get notificationCount => $_getIZ(10);
  @$pb.TagNumber(11)
  set notificationCount($core.int value) => $_setSignedInt32(10, value);
  @$pb.TagNumber(11)
  $core.bool hasNotificationCount() => $_has(10);
  @$pb.TagNumber(11)
  void clearNotificationCount() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.int get failureCount => $_getIZ(11);
  @$pb.TagNumber(12)
  set failureCount($core.int value) => $_setSignedInt32(11, value);
  @$pb.TagNumber(12)
  $core.bool hasFailureCount() => $_has(11);
  @$pb.TagNumber(12)
  void clearFailureCount() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.String get lastError => $_getSZ(12);
  @$pb.TagNumber(13)
  set lastError($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasLastError() => $_has(12);
  @$pb.TagNumber(13)
  void clearLastError() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.String get createdAt => $_getSZ(13);
  @$pb.TagNumber(14)
  set createdAt($core.String value) => $_setString(13, value);
  @$pb.TagNumber(14)
  $core.bool hasCreatedAt() => $_has(13);
  @$pb.TagNumber(14)
  void clearCreatedAt() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.String get updatedAt => $_getSZ(14);
  @$pb.TagNumber(15)
  set updatedAt($core.String value) => $_setString(14, value);
  @$pb.TagNumber(15)
  $core.bool hasUpdatedAt() => $_has(14);
  @$pb.TagNumber(15)
  void clearUpdatedAt() => $_clearField(15);
}

class NotificationPreferencesMessage extends $pb.GeneratedMessage {
  factory NotificationPreferencesMessage({
    $core.bool? includeDonorName,
    $core.bool? includeAmount,
    $core.bool? includeMessage,
    $core.bool? includeProgress,
    $core.bool? includeLeaderboard,
    $core.double? largeDonationThreshold,
    $core.String? messageTemplate,
    $core.String? language,
    $core.bool? quietHoursEnabled,
    $core.String? quietHoursStart,
    $core.String? quietHoursEnd,
    $core.String? timezone,
  }) {
    final result = create();
    if (includeDonorName != null) result.includeDonorName = includeDonorName;
    if (includeAmount != null) result.includeAmount = includeAmount;
    if (includeMessage != null) result.includeMessage = includeMessage;
    if (includeProgress != null) result.includeProgress = includeProgress;
    if (includeLeaderboard != null)
      result.includeLeaderboard = includeLeaderboard;
    if (largeDonationThreshold != null)
      result.largeDonationThreshold = largeDonationThreshold;
    if (messageTemplate != null) result.messageTemplate = messageTemplate;
    if (language != null) result.language = language;
    if (quietHoursEnabled != null) result.quietHoursEnabled = quietHoursEnabled;
    if (quietHoursStart != null) result.quietHoursStart = quietHoursStart;
    if (quietHoursEnd != null) result.quietHoursEnd = quietHoursEnd;
    if (timezone != null) result.timezone = timezone;
    return result;
  }

  NotificationPreferencesMessage._();

  factory NotificationPreferencesMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory NotificationPreferencesMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'NotificationPreferencesMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'includeDonorName')
    ..aOB(2, _omitFieldNames ? '' : 'includeAmount')
    ..aOB(3, _omitFieldNames ? '' : 'includeMessage')
    ..aOB(4, _omitFieldNames ? '' : 'includeProgress')
    ..aOB(5, _omitFieldNames ? '' : 'includeLeaderboard')
    ..a<$core.double>(
        6, _omitFieldNames ? '' : 'largeDonationThreshold', $pb.PbFieldType.OD)
    ..aOS(7, _omitFieldNames ? '' : 'messageTemplate')
    ..aOS(8, _omitFieldNames ? '' : 'language')
    ..aOB(9, _omitFieldNames ? '' : 'quietHoursEnabled')
    ..aOS(10, _omitFieldNames ? '' : 'quietHoursStart')
    ..aOS(11, _omitFieldNames ? '' : 'quietHoursEnd')
    ..aOS(12, _omitFieldNames ? '' : 'timezone')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  NotificationPreferencesMessage clone() =>
      NotificationPreferencesMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  NotificationPreferencesMessage copyWith(
          void Function(NotificationPreferencesMessage) updates) =>
      super.copyWith(
              (message) => updates(message as NotificationPreferencesMessage))
          as NotificationPreferencesMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NotificationPreferencesMessage create() =>
      NotificationPreferencesMessage._();
  @$core.override
  NotificationPreferencesMessage createEmptyInstance() => create();
  static $pb.PbList<NotificationPreferencesMessage> createRepeated() =>
      $pb.PbList<NotificationPreferencesMessage>();
  @$core.pragma('dart2js:noInline')
  static NotificationPreferencesMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<NotificationPreferencesMessage>(create);
  static NotificationPreferencesMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get includeDonorName => $_getBF(0);
  @$pb.TagNumber(1)
  set includeDonorName($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasIncludeDonorName() => $_has(0);
  @$pb.TagNumber(1)
  void clearIncludeDonorName() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get includeAmount => $_getBF(1);
  @$pb.TagNumber(2)
  set includeAmount($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasIncludeAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearIncludeAmount() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.bool get includeMessage => $_getBF(2);
  @$pb.TagNumber(3)
  set includeMessage($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasIncludeMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearIncludeMessage() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.bool get includeProgress => $_getBF(3);
  @$pb.TagNumber(4)
  set includeProgress($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasIncludeProgress() => $_has(3);
  @$pb.TagNumber(4)
  void clearIncludeProgress() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.bool get includeLeaderboard => $_getBF(4);
  @$pb.TagNumber(5)
  set includeLeaderboard($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasIncludeLeaderboard() => $_has(4);
  @$pb.TagNumber(5)
  void clearIncludeLeaderboard() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.double get largeDonationThreshold => $_getN(5);
  @$pb.TagNumber(6)
  set largeDonationThreshold($core.double value) => $_setDouble(5, value);
  @$pb.TagNumber(6)
  $core.bool hasLargeDonationThreshold() => $_has(5);
  @$pb.TagNumber(6)
  void clearLargeDonationThreshold() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get messageTemplate => $_getSZ(6);
  @$pb.TagNumber(7)
  set messageTemplate($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasMessageTemplate() => $_has(6);
  @$pb.TagNumber(7)
  void clearMessageTemplate() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get language => $_getSZ(7);
  @$pb.TagNumber(8)
  set language($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasLanguage() => $_has(7);
  @$pb.TagNumber(8)
  void clearLanguage() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.bool get quietHoursEnabled => $_getBF(8);
  @$pb.TagNumber(9)
  set quietHoursEnabled($core.bool value) => $_setBool(8, value);
  @$pb.TagNumber(9)
  $core.bool hasQuietHoursEnabled() => $_has(8);
  @$pb.TagNumber(9)
  void clearQuietHoursEnabled() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get quietHoursStart => $_getSZ(9);
  @$pb.TagNumber(10)
  set quietHoursStart($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasQuietHoursStart() => $_has(9);
  @$pb.TagNumber(10)
  void clearQuietHoursStart() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get quietHoursEnd => $_getSZ(10);
  @$pb.TagNumber(11)
  set quietHoursEnd($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasQuietHoursEnd() => $_has(10);
  @$pb.TagNumber(11)
  void clearQuietHoursEnd() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get timezone => $_getSZ(11);
  @$pb.TagNumber(12)
  set timezone($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasTimezone() => $_has(11);
  @$pb.TagNumber(12)
  void clearTimezone() => $_clearField(12);
}

class NotificationDeliveryMessage extends $pb.GeneratedMessage {
  factory NotificationDeliveryMessage({
    $core.String? id,
    $core.String? channelId,
    $core.String? crowdfundId,
    NotificationEventType? eventType,
    $core.String? eventData,
    $core.String? messageContent,
    $core.bool? success,
    $core.String? errorMessage,
    $core.int? retryCount,
    $core.String? platformMessageId,
    $core.String? createdAt,
    $core.String? deliveredAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (channelId != null) result.channelId = channelId;
    if (crowdfundId != null) result.crowdfundId = crowdfundId;
    if (eventType != null) result.eventType = eventType;
    if (eventData != null) result.eventData = eventData;
    if (messageContent != null) result.messageContent = messageContent;
    if (success != null) result.success = success;
    if (errorMessage != null) result.errorMessage = errorMessage;
    if (retryCount != null) result.retryCount = retryCount;
    if (platformMessageId != null) result.platformMessageId = platformMessageId;
    if (createdAt != null) result.createdAt = createdAt;
    if (deliveredAt != null) result.deliveredAt = deliveredAt;
    return result;
  }

  NotificationDeliveryMessage._();

  factory NotificationDeliveryMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory NotificationDeliveryMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'NotificationDeliveryMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'channelId')
    ..aOS(3, _omitFieldNames ? '' : 'crowdfundId')
    ..e<NotificationEventType>(
        4, _omitFieldNames ? '' : 'eventType', $pb.PbFieldType.OE,
        defaultOrMaker:
            NotificationEventType.NOTIFICATION_EVENT_TYPE_UNSPECIFIED,
        valueOf: NotificationEventType.valueOf,
        enumValues: NotificationEventType.values)
    ..aOS(5, _omitFieldNames ? '' : 'eventData')
    ..aOS(6, _omitFieldNames ? '' : 'messageContent')
    ..aOB(7, _omitFieldNames ? '' : 'success')
    ..aOS(8, _omitFieldNames ? '' : 'errorMessage')
    ..a<$core.int>(9, _omitFieldNames ? '' : 'retryCount', $pb.PbFieldType.O3)
    ..aOS(10, _omitFieldNames ? '' : 'platformMessageId')
    ..aOS(11, _omitFieldNames ? '' : 'createdAt')
    ..aOS(12, _omitFieldNames ? '' : 'deliveredAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  NotificationDeliveryMessage clone() =>
      NotificationDeliveryMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  NotificationDeliveryMessage copyWith(
          void Function(NotificationDeliveryMessage) updates) =>
      super.copyWith(
              (message) => updates(message as NotificationDeliveryMessage))
          as NotificationDeliveryMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NotificationDeliveryMessage create() =>
      NotificationDeliveryMessage._();
  @$core.override
  NotificationDeliveryMessage createEmptyInstance() => create();
  static $pb.PbList<NotificationDeliveryMessage> createRepeated() =>
      $pb.PbList<NotificationDeliveryMessage>();
  @$core.pragma('dart2js:noInline')
  static NotificationDeliveryMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<NotificationDeliveryMessage>(create);
  static NotificationDeliveryMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get channelId => $_getSZ(1);
  @$pb.TagNumber(2)
  set channelId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasChannelId() => $_has(1);
  @$pb.TagNumber(2)
  void clearChannelId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get crowdfundId => $_getSZ(2);
  @$pb.TagNumber(3)
  set crowdfundId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCrowdfundId() => $_has(2);
  @$pb.TagNumber(3)
  void clearCrowdfundId() => $_clearField(3);

  @$pb.TagNumber(4)
  NotificationEventType get eventType => $_getN(3);
  @$pb.TagNumber(4)
  set eventType(NotificationEventType value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasEventType() => $_has(3);
  @$pb.TagNumber(4)
  void clearEventType() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get eventData => $_getSZ(4);
  @$pb.TagNumber(5)
  set eventData($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasEventData() => $_has(4);
  @$pb.TagNumber(5)
  void clearEventData() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get messageContent => $_getSZ(5);
  @$pb.TagNumber(6)
  set messageContent($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasMessageContent() => $_has(5);
  @$pb.TagNumber(6)
  void clearMessageContent() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.bool get success => $_getBF(6);
  @$pb.TagNumber(7)
  set success($core.bool value) => $_setBool(6, value);
  @$pb.TagNumber(7)
  $core.bool hasSuccess() => $_has(6);
  @$pb.TagNumber(7)
  void clearSuccess() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get errorMessage => $_getSZ(7);
  @$pb.TagNumber(8)
  set errorMessage($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasErrorMessage() => $_has(7);
  @$pb.TagNumber(8)
  void clearErrorMessage() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.int get retryCount => $_getIZ(8);
  @$pb.TagNumber(9)
  set retryCount($core.int value) => $_setSignedInt32(8, value);
  @$pb.TagNumber(9)
  $core.bool hasRetryCount() => $_has(8);
  @$pb.TagNumber(9)
  void clearRetryCount() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get platformMessageId => $_getSZ(9);
  @$pb.TagNumber(10)
  set platformMessageId($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasPlatformMessageId() => $_has(9);
  @$pb.TagNumber(10)
  void clearPlatformMessageId() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get createdAt => $_getSZ(10);
  @$pb.TagNumber(11)
  set createdAt($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasCreatedAt() => $_has(10);
  @$pb.TagNumber(11)
  void clearCreatedAt() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get deliveredAt => $_getSZ(11);
  @$pb.TagNumber(12)
  set deliveredAt($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasDeliveredAt() => $_has(11);
  @$pb.TagNumber(12)
  void clearDeliveredAt() => $_clearField(12);
}

class TelegramConnectionDataMessage extends $pb.GeneratedMessage {
  factory TelegramConnectionDataMessage({
    $core.String? chatId,
    $core.String? verificationCode,
  }) {
    final result = create();
    if (chatId != null) result.chatId = chatId;
    if (verificationCode != null) result.verificationCode = verificationCode;
    return result;
  }

  TelegramConnectionDataMessage._();

  factory TelegramConnectionDataMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TelegramConnectionDataMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TelegramConnectionDataMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'chatId')
    ..aOS(2, _omitFieldNames ? '' : 'verificationCode')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TelegramConnectionDataMessage clone() =>
      TelegramConnectionDataMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TelegramConnectionDataMessage copyWith(
          void Function(TelegramConnectionDataMessage) updates) =>
      super.copyWith(
              (message) => updates(message as TelegramConnectionDataMessage))
          as TelegramConnectionDataMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TelegramConnectionDataMessage create() =>
      TelegramConnectionDataMessage._();
  @$core.override
  TelegramConnectionDataMessage createEmptyInstance() => create();
  static $pb.PbList<TelegramConnectionDataMessage> createRepeated() =>
      $pb.PbList<TelegramConnectionDataMessage>();
  @$core.pragma('dart2js:noInline')
  static TelegramConnectionDataMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TelegramConnectionDataMessage>(create);
  static TelegramConnectionDataMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get chatId => $_getSZ(0);
  @$pb.TagNumber(1)
  set chatId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasChatId() => $_has(0);
  @$pb.TagNumber(1)
  void clearChatId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get verificationCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set verificationCode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasVerificationCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearVerificationCode() => $_clearField(2);
}

class DiscordConnectionDataMessage extends $pb.GeneratedMessage {
  factory DiscordConnectionDataMessage({
    $core.String? webhookUrl,
    $core.String? serverName,
    $core.String? channelName,
  }) {
    final result = create();
    if (webhookUrl != null) result.webhookUrl = webhookUrl;
    if (serverName != null) result.serverName = serverName;
    if (channelName != null) result.channelName = channelName;
    return result;
  }

  DiscordConnectionDataMessage._();

  factory DiscordConnectionDataMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DiscordConnectionDataMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DiscordConnectionDataMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'webhookUrl')
    ..aOS(2, _omitFieldNames ? '' : 'serverName')
    ..aOS(3, _omitFieldNames ? '' : 'channelName')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DiscordConnectionDataMessage clone() =>
      DiscordConnectionDataMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DiscordConnectionDataMessage copyWith(
          void Function(DiscordConnectionDataMessage) updates) =>
      super.copyWith(
              (message) => updates(message as DiscordConnectionDataMessage))
          as DiscordConnectionDataMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DiscordConnectionDataMessage create() =>
      DiscordConnectionDataMessage._();
  @$core.override
  DiscordConnectionDataMessage createEmptyInstance() => create();
  static $pb.PbList<DiscordConnectionDataMessage> createRepeated() =>
      $pb.PbList<DiscordConnectionDataMessage>();
  @$core.pragma('dart2js:noInline')
  static DiscordConnectionDataMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DiscordConnectionDataMessage>(create);
  static DiscordConnectionDataMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get webhookUrl => $_getSZ(0);
  @$pb.TagNumber(1)
  set webhookUrl($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasWebhookUrl() => $_has(0);
  @$pb.TagNumber(1)
  void clearWebhookUrl() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get serverName => $_getSZ(1);
  @$pb.TagNumber(2)
  set serverName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasServerName() => $_has(1);
  @$pb.TagNumber(2)
  void clearServerName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get channelName => $_getSZ(2);
  @$pb.TagNumber(3)
  set channelName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasChannelName() => $_has(2);
  @$pb.TagNumber(3)
  void clearChannelName() => $_clearField(3);
}

class WhatsAppBusinessConnectionDataMessage extends $pb.GeneratedMessage {
  factory WhatsAppBusinessConnectionDataMessage({
    $core.String? phoneNumberId,
    $core.String? accessToken,
    $core.String? recipientId,
  }) {
    final result = create();
    if (phoneNumberId != null) result.phoneNumberId = phoneNumberId;
    if (accessToken != null) result.accessToken = accessToken;
    if (recipientId != null) result.recipientId = recipientId;
    return result;
  }

  WhatsAppBusinessConnectionDataMessage._();

  factory WhatsAppBusinessConnectionDataMessage.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory WhatsAppBusinessConnectionDataMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'WhatsAppBusinessConnectionDataMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'phoneNumberId')
    ..aOS(2, _omitFieldNames ? '' : 'accessToken')
    ..aOS(3, _omitFieldNames ? '' : 'recipientId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WhatsAppBusinessConnectionDataMessage clone() =>
      WhatsAppBusinessConnectionDataMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WhatsAppBusinessConnectionDataMessage copyWith(
          void Function(WhatsAppBusinessConnectionDataMessage) updates) =>
      super.copyWith((message) =>
              updates(message as WhatsAppBusinessConnectionDataMessage))
          as WhatsAppBusinessConnectionDataMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WhatsAppBusinessConnectionDataMessage create() =>
      WhatsAppBusinessConnectionDataMessage._();
  @$core.override
  WhatsAppBusinessConnectionDataMessage createEmptyInstance() => create();
  static $pb.PbList<WhatsAppBusinessConnectionDataMessage> createRepeated() =>
      $pb.PbList<WhatsAppBusinessConnectionDataMessage>();
  @$core.pragma('dart2js:noInline')
  static WhatsAppBusinessConnectionDataMessage getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          WhatsAppBusinessConnectionDataMessage>(create);
  static WhatsAppBusinessConnectionDataMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get phoneNumberId => $_getSZ(0);
  @$pb.TagNumber(1)
  set phoneNumberId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPhoneNumberId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPhoneNumberId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get accessToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set accessToken($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAccessToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccessToken() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get recipientId => $_getSZ(2);
  @$pb.TagNumber(3)
  set recipientId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasRecipientId() => $_has(2);
  @$pb.TagNumber(3)
  void clearRecipientId() => $_clearField(3);
}

class SlackConnectionDataMessage extends $pb.GeneratedMessage {
  factory SlackConnectionDataMessage({
    $core.String? webhookUrl,
    $core.String? workspaceName,
    $core.String? channelName,
  }) {
    final result = create();
    if (webhookUrl != null) result.webhookUrl = webhookUrl;
    if (workspaceName != null) result.workspaceName = workspaceName;
    if (channelName != null) result.channelName = channelName;
    return result;
  }

  SlackConnectionDataMessage._();

  factory SlackConnectionDataMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SlackConnectionDataMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SlackConnectionDataMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'webhookUrl')
    ..aOS(2, _omitFieldNames ? '' : 'workspaceName')
    ..aOS(3, _omitFieldNames ? '' : 'channelName')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SlackConnectionDataMessage clone() =>
      SlackConnectionDataMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SlackConnectionDataMessage copyWith(
          void Function(SlackConnectionDataMessage) updates) =>
      super.copyWith(
              (message) => updates(message as SlackConnectionDataMessage))
          as SlackConnectionDataMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SlackConnectionDataMessage create() => SlackConnectionDataMessage._();
  @$core.override
  SlackConnectionDataMessage createEmptyInstance() => create();
  static $pb.PbList<SlackConnectionDataMessage> createRepeated() =>
      $pb.PbList<SlackConnectionDataMessage>();
  @$core.pragma('dart2js:noInline')
  static SlackConnectionDataMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SlackConnectionDataMessage>(create);
  static SlackConnectionDataMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get webhookUrl => $_getSZ(0);
  @$pb.TagNumber(1)
  set webhookUrl($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasWebhookUrl() => $_has(0);
  @$pb.TagNumber(1)
  void clearWebhookUrl() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get workspaceName => $_getSZ(1);
  @$pb.TagNumber(2)
  set workspaceName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasWorkspaceName() => $_has(1);
  @$pb.TagNumber(2)
  void clearWorkspaceName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get channelName => $_getSZ(2);
  @$pb.TagNumber(3)
  set channelName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasChannelName() => $_has(2);
  @$pb.TagNumber(3)
  void clearChannelName() => $_clearField(3);
}

enum ConnectNotificationChannelRequest_ConnectionData {
  telegram,
  discord,
  whatsappBusiness,
  slack,
  notSet
}

class ConnectNotificationChannelRequest extends $pb.GeneratedMessage {
  factory ConnectNotificationChannelRequest({
    $core.String? crowdfundId,
    NotificationChannelType? channelType,
    $core.String? channelName,
    TelegramConnectionDataMessage? telegram,
    DiscordConnectionDataMessage? discord,
    WhatsAppBusinessConnectionDataMessage? whatsappBusiness,
    SlackConnectionDataMessage? slack,
    $core.Iterable<NotificationEventType>? enabledEvents,
    NotificationPreferencesMessage? preferences,
  }) {
    final result = create();
    if (crowdfundId != null) result.crowdfundId = crowdfundId;
    if (channelType != null) result.channelType = channelType;
    if (channelName != null) result.channelName = channelName;
    if (telegram != null) result.telegram = telegram;
    if (discord != null) result.discord = discord;
    if (whatsappBusiness != null) result.whatsappBusiness = whatsappBusiness;
    if (slack != null) result.slack = slack;
    if (enabledEvents != null) result.enabledEvents.addAll(enabledEvents);
    if (preferences != null) result.preferences = preferences;
    return result;
  }

  ConnectNotificationChannelRequest._();

  factory ConnectNotificationChannelRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ConnectNotificationChannelRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static const $core
      .Map<$core.int, ConnectNotificationChannelRequest_ConnectionData>
      _ConnectNotificationChannelRequest_ConnectionDataByTag = {
    4: ConnectNotificationChannelRequest_ConnectionData.telegram,
    5: ConnectNotificationChannelRequest_ConnectionData.discord,
    6: ConnectNotificationChannelRequest_ConnectionData.whatsappBusiness,
    7: ConnectNotificationChannelRequest_ConnectionData.slack,
    0: ConnectNotificationChannelRequest_ConnectionData.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ConnectNotificationChannelRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..oo(0, [4, 5, 6, 7])
    ..aOS(1, _omitFieldNames ? '' : 'crowdfundId')
    ..e<NotificationChannelType>(
        2, _omitFieldNames ? '' : 'channelType', $pb.PbFieldType.OE,
        defaultOrMaker:
            NotificationChannelType.NOTIFICATION_CHANNEL_TYPE_UNSPECIFIED,
        valueOf: NotificationChannelType.valueOf,
        enumValues: NotificationChannelType.values)
    ..aOS(3, _omitFieldNames ? '' : 'channelName')
    ..aOM<TelegramConnectionDataMessage>(4, _omitFieldNames ? '' : 'telegram',
        subBuilder: TelegramConnectionDataMessage.create)
    ..aOM<DiscordConnectionDataMessage>(5, _omitFieldNames ? '' : 'discord',
        subBuilder: DiscordConnectionDataMessage.create)
    ..aOM<WhatsAppBusinessConnectionDataMessage>(
        6, _omitFieldNames ? '' : 'whatsappBusiness',
        subBuilder: WhatsAppBusinessConnectionDataMessage.create)
    ..aOM<SlackConnectionDataMessage>(7, _omitFieldNames ? '' : 'slack',
        subBuilder: SlackConnectionDataMessage.create)
    ..pc<NotificationEventType>(
        8, _omitFieldNames ? '' : 'enabledEvents', $pb.PbFieldType.KE,
        valueOf: NotificationEventType.valueOf,
        enumValues: NotificationEventType.values,
        defaultEnumValue:
            NotificationEventType.NOTIFICATION_EVENT_TYPE_UNSPECIFIED)
    ..aOM<NotificationPreferencesMessage>(
        9, _omitFieldNames ? '' : 'preferences',
        subBuilder: NotificationPreferencesMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ConnectNotificationChannelRequest clone() =>
      ConnectNotificationChannelRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ConnectNotificationChannelRequest copyWith(
          void Function(ConnectNotificationChannelRequest) updates) =>
      super.copyWith((message) =>
              updates(message as ConnectNotificationChannelRequest))
          as ConnectNotificationChannelRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ConnectNotificationChannelRequest create() =>
      ConnectNotificationChannelRequest._();
  @$core.override
  ConnectNotificationChannelRequest createEmptyInstance() => create();
  static $pb.PbList<ConnectNotificationChannelRequest> createRepeated() =>
      $pb.PbList<ConnectNotificationChannelRequest>();
  @$core.pragma('dart2js:noInline')
  static ConnectNotificationChannelRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ConnectNotificationChannelRequest>(
          create);
  static ConnectNotificationChannelRequest? _defaultInstance;

  ConnectNotificationChannelRequest_ConnectionData whichConnectionData() =>
      _ConnectNotificationChannelRequest_ConnectionDataByTag[$_whichOneof(0)]!;
  void clearConnectionData() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.String get crowdfundId => $_getSZ(0);
  @$pb.TagNumber(1)
  set crowdfundId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCrowdfundId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCrowdfundId() => $_clearField(1);

  @$pb.TagNumber(2)
  NotificationChannelType get channelType => $_getN(1);
  @$pb.TagNumber(2)
  set channelType(NotificationChannelType value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasChannelType() => $_has(1);
  @$pb.TagNumber(2)
  void clearChannelType() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get channelName => $_getSZ(2);
  @$pb.TagNumber(3)
  set channelName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasChannelName() => $_has(2);
  @$pb.TagNumber(3)
  void clearChannelName() => $_clearField(3);

  @$pb.TagNumber(4)
  TelegramConnectionDataMessage get telegram => $_getN(3);
  @$pb.TagNumber(4)
  set telegram(TelegramConnectionDataMessage value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasTelegram() => $_has(3);
  @$pb.TagNumber(4)
  void clearTelegram() => $_clearField(4);
  @$pb.TagNumber(4)
  TelegramConnectionDataMessage ensureTelegram() => $_ensure(3);

  @$pb.TagNumber(5)
  DiscordConnectionDataMessage get discord => $_getN(4);
  @$pb.TagNumber(5)
  set discord(DiscordConnectionDataMessage value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasDiscord() => $_has(4);
  @$pb.TagNumber(5)
  void clearDiscord() => $_clearField(5);
  @$pb.TagNumber(5)
  DiscordConnectionDataMessage ensureDiscord() => $_ensure(4);

  @$pb.TagNumber(6)
  WhatsAppBusinessConnectionDataMessage get whatsappBusiness => $_getN(5);
  @$pb.TagNumber(6)
  set whatsappBusiness(WhatsAppBusinessConnectionDataMessage value) =>
      $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasWhatsappBusiness() => $_has(5);
  @$pb.TagNumber(6)
  void clearWhatsappBusiness() => $_clearField(6);
  @$pb.TagNumber(6)
  WhatsAppBusinessConnectionDataMessage ensureWhatsappBusiness() => $_ensure(5);

  @$pb.TagNumber(7)
  SlackConnectionDataMessage get slack => $_getN(6);
  @$pb.TagNumber(7)
  set slack(SlackConnectionDataMessage value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasSlack() => $_has(6);
  @$pb.TagNumber(7)
  void clearSlack() => $_clearField(7);
  @$pb.TagNumber(7)
  SlackConnectionDataMessage ensureSlack() => $_ensure(6);

  @$pb.TagNumber(8)
  $pb.PbList<NotificationEventType> get enabledEvents => $_getList(7);

  @$pb.TagNumber(9)
  NotificationPreferencesMessage get preferences => $_getN(8);
  @$pb.TagNumber(9)
  set preferences(NotificationPreferencesMessage value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasPreferences() => $_has(8);
  @$pb.TagNumber(9)
  void clearPreferences() => $_clearField(9);
  @$pb.TagNumber(9)
  NotificationPreferencesMessage ensurePreferences() => $_ensure(8);
}

class ConnectNotificationChannelResponse extends $pb.GeneratedMessage {
  factory ConnectNotificationChannelResponse({
    NotificationChannelMessage? channel,
    $core.bool? requiresVerification,
    $core.String? verificationInstructions,
    $core.String? message,
  }) {
    final result = create();
    if (channel != null) result.channel = channel;
    if (requiresVerification != null)
      result.requiresVerification = requiresVerification;
    if (verificationInstructions != null)
      result.verificationInstructions = verificationInstructions;
    if (message != null) result.message = message;
    return result;
  }

  ConnectNotificationChannelResponse._();

  factory ConnectNotificationChannelResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ConnectNotificationChannelResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ConnectNotificationChannelResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<NotificationChannelMessage>(1, _omitFieldNames ? '' : 'channel',
        subBuilder: NotificationChannelMessage.create)
    ..aOB(2, _omitFieldNames ? '' : 'requiresVerification')
    ..aOS(3, _omitFieldNames ? '' : 'verificationInstructions')
    ..aOS(4, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ConnectNotificationChannelResponse clone() =>
      ConnectNotificationChannelResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ConnectNotificationChannelResponse copyWith(
          void Function(ConnectNotificationChannelResponse) updates) =>
      super.copyWith((message) =>
              updates(message as ConnectNotificationChannelResponse))
          as ConnectNotificationChannelResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ConnectNotificationChannelResponse create() =>
      ConnectNotificationChannelResponse._();
  @$core.override
  ConnectNotificationChannelResponse createEmptyInstance() => create();
  static $pb.PbList<ConnectNotificationChannelResponse> createRepeated() =>
      $pb.PbList<ConnectNotificationChannelResponse>();
  @$core.pragma('dart2js:noInline')
  static ConnectNotificationChannelResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ConnectNotificationChannelResponse>(
          create);
  static ConnectNotificationChannelResponse? _defaultInstance;

  @$pb.TagNumber(1)
  NotificationChannelMessage get channel => $_getN(0);
  @$pb.TagNumber(1)
  set channel(NotificationChannelMessage value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasChannel() => $_has(0);
  @$pb.TagNumber(1)
  void clearChannel() => $_clearField(1);
  @$pb.TagNumber(1)
  NotificationChannelMessage ensureChannel() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.bool get requiresVerification => $_getBF(1);
  @$pb.TagNumber(2)
  set requiresVerification($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRequiresVerification() => $_has(1);
  @$pb.TagNumber(2)
  void clearRequiresVerification() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get verificationInstructions => $_getSZ(2);
  @$pb.TagNumber(3)
  set verificationInstructions($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasVerificationInstructions() => $_has(2);
  @$pb.TagNumber(3)
  void clearVerificationInstructions() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get message => $_getSZ(3);
  @$pb.TagNumber(4)
  set message($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMessage() => $_has(3);
  @$pb.TagNumber(4)
  void clearMessage() => $_clearField(4);
}

class DisconnectNotificationChannelRequest extends $pb.GeneratedMessage {
  factory DisconnectNotificationChannelRequest({
    $core.String? channelId,
  }) {
    final result = create();
    if (channelId != null) result.channelId = channelId;
    return result;
  }

  DisconnectNotificationChannelRequest._();

  factory DisconnectNotificationChannelRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DisconnectNotificationChannelRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DisconnectNotificationChannelRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'channelId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DisconnectNotificationChannelRequest clone() =>
      DisconnectNotificationChannelRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DisconnectNotificationChannelRequest copyWith(
          void Function(DisconnectNotificationChannelRequest) updates) =>
      super.copyWith((message) =>
              updates(message as DisconnectNotificationChannelRequest))
          as DisconnectNotificationChannelRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DisconnectNotificationChannelRequest create() =>
      DisconnectNotificationChannelRequest._();
  @$core.override
  DisconnectNotificationChannelRequest createEmptyInstance() => create();
  static $pb.PbList<DisconnectNotificationChannelRequest> createRepeated() =>
      $pb.PbList<DisconnectNotificationChannelRequest>();
  @$core.pragma('dart2js:noInline')
  static DisconnectNotificationChannelRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          DisconnectNotificationChannelRequest>(create);
  static DisconnectNotificationChannelRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get channelId => $_getSZ(0);
  @$pb.TagNumber(1)
  set channelId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasChannelId() => $_has(0);
  @$pb.TagNumber(1)
  void clearChannelId() => $_clearField(1);
}

class DisconnectNotificationChannelResponse extends $pb.GeneratedMessage {
  factory DisconnectNotificationChannelResponse({
    $core.bool? success,
    $core.String? message,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    return result;
  }

  DisconnectNotificationChannelResponse._();

  factory DisconnectNotificationChannelResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DisconnectNotificationChannelResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DisconnectNotificationChannelResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DisconnectNotificationChannelResponse clone() =>
      DisconnectNotificationChannelResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DisconnectNotificationChannelResponse copyWith(
          void Function(DisconnectNotificationChannelResponse) updates) =>
      super.copyWith((message) =>
              updates(message as DisconnectNotificationChannelResponse))
          as DisconnectNotificationChannelResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DisconnectNotificationChannelResponse create() =>
      DisconnectNotificationChannelResponse._();
  @$core.override
  DisconnectNotificationChannelResponse createEmptyInstance() => create();
  static $pb.PbList<DisconnectNotificationChannelResponse> createRepeated() =>
      $pb.PbList<DisconnectNotificationChannelResponse>();
  @$core.pragma('dart2js:noInline')
  static DisconnectNotificationChannelResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          DisconnectNotificationChannelResponse>(create);
  static DisconnectNotificationChannelResponse? _defaultInstance;

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

class GetNotificationChannelsRequest extends $pb.GeneratedMessage {
  factory GetNotificationChannelsRequest({
    $core.String? crowdfundId,
  }) {
    final result = create();
    if (crowdfundId != null) result.crowdfundId = crowdfundId;
    return result;
  }

  GetNotificationChannelsRequest._();

  factory GetNotificationChannelsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetNotificationChannelsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetNotificationChannelsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'crowdfundId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetNotificationChannelsRequest clone() =>
      GetNotificationChannelsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetNotificationChannelsRequest copyWith(
          void Function(GetNotificationChannelsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetNotificationChannelsRequest))
          as GetNotificationChannelsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetNotificationChannelsRequest create() =>
      GetNotificationChannelsRequest._();
  @$core.override
  GetNotificationChannelsRequest createEmptyInstance() => create();
  static $pb.PbList<GetNotificationChannelsRequest> createRepeated() =>
      $pb.PbList<GetNotificationChannelsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetNotificationChannelsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetNotificationChannelsRequest>(create);
  static GetNotificationChannelsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get crowdfundId => $_getSZ(0);
  @$pb.TagNumber(1)
  set crowdfundId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCrowdfundId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCrowdfundId() => $_clearField(1);
}

class GetNotificationChannelsResponse extends $pb.GeneratedMessage {
  factory GetNotificationChannelsResponse({
    $core.Iterable<NotificationChannelMessage>? channels,
  }) {
    final result = create();
    if (channels != null) result.channels.addAll(channels);
    return result;
  }

  GetNotificationChannelsResponse._();

  factory GetNotificationChannelsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetNotificationChannelsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetNotificationChannelsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<NotificationChannelMessage>(
        1, _omitFieldNames ? '' : 'channels', $pb.PbFieldType.PM,
        subBuilder: NotificationChannelMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetNotificationChannelsResponse clone() =>
      GetNotificationChannelsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetNotificationChannelsResponse copyWith(
          void Function(GetNotificationChannelsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetNotificationChannelsResponse))
          as GetNotificationChannelsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetNotificationChannelsResponse create() =>
      GetNotificationChannelsResponse._();
  @$core.override
  GetNotificationChannelsResponse createEmptyInstance() => create();
  static $pb.PbList<GetNotificationChannelsResponse> createRepeated() =>
      $pb.PbList<GetNotificationChannelsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetNotificationChannelsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetNotificationChannelsResponse>(
          create);
  static GetNotificationChannelsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<NotificationChannelMessage> get channels => $_getList(0);
}

class UpdateNotificationChannelRequest extends $pb.GeneratedMessage {
  factory UpdateNotificationChannelRequest({
    $core.String? channelId,
    $core.String? channelName,
    $core.Iterable<NotificationEventType>? enabledEvents,
    NotificationPreferencesMessage? preferences,
    NotificationChannelStatus? status,
  }) {
    final result = create();
    if (channelId != null) result.channelId = channelId;
    if (channelName != null) result.channelName = channelName;
    if (enabledEvents != null) result.enabledEvents.addAll(enabledEvents);
    if (preferences != null) result.preferences = preferences;
    if (status != null) result.status = status;
    return result;
  }

  UpdateNotificationChannelRequest._();

  factory UpdateNotificationChannelRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateNotificationChannelRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateNotificationChannelRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'channelId')
    ..aOS(2, _omitFieldNames ? '' : 'channelName')
    ..pc<NotificationEventType>(
        3, _omitFieldNames ? '' : 'enabledEvents', $pb.PbFieldType.KE,
        valueOf: NotificationEventType.valueOf,
        enumValues: NotificationEventType.values,
        defaultEnumValue:
            NotificationEventType.NOTIFICATION_EVENT_TYPE_UNSPECIFIED)
    ..aOM<NotificationPreferencesMessage>(
        4, _omitFieldNames ? '' : 'preferences',
        subBuilder: NotificationPreferencesMessage.create)
    ..e<NotificationChannelStatus>(
        5, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker:
            NotificationChannelStatus.NOTIFICATION_CHANNEL_STATUS_UNSPECIFIED,
        valueOf: NotificationChannelStatus.valueOf,
        enumValues: NotificationChannelStatus.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateNotificationChannelRequest clone() =>
      UpdateNotificationChannelRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateNotificationChannelRequest copyWith(
          void Function(UpdateNotificationChannelRequest) updates) =>
      super.copyWith(
              (message) => updates(message as UpdateNotificationChannelRequest))
          as UpdateNotificationChannelRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateNotificationChannelRequest create() =>
      UpdateNotificationChannelRequest._();
  @$core.override
  UpdateNotificationChannelRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateNotificationChannelRequest> createRepeated() =>
      $pb.PbList<UpdateNotificationChannelRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateNotificationChannelRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateNotificationChannelRequest>(
          create);
  static UpdateNotificationChannelRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get channelId => $_getSZ(0);
  @$pb.TagNumber(1)
  set channelId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasChannelId() => $_has(0);
  @$pb.TagNumber(1)
  void clearChannelId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get channelName => $_getSZ(1);
  @$pb.TagNumber(2)
  set channelName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasChannelName() => $_has(1);
  @$pb.TagNumber(2)
  void clearChannelName() => $_clearField(2);

  @$pb.TagNumber(3)
  $pb.PbList<NotificationEventType> get enabledEvents => $_getList(2);

  @$pb.TagNumber(4)
  NotificationPreferencesMessage get preferences => $_getN(3);
  @$pb.TagNumber(4)
  set preferences(NotificationPreferencesMessage value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasPreferences() => $_has(3);
  @$pb.TagNumber(4)
  void clearPreferences() => $_clearField(4);
  @$pb.TagNumber(4)
  NotificationPreferencesMessage ensurePreferences() => $_ensure(3);

  @$pb.TagNumber(5)
  NotificationChannelStatus get status => $_getN(4);
  @$pb.TagNumber(5)
  set status(NotificationChannelStatus value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasStatus() => $_has(4);
  @$pb.TagNumber(5)
  void clearStatus() => $_clearField(5);
}

class UpdateNotificationChannelResponse extends $pb.GeneratedMessage {
  factory UpdateNotificationChannelResponse({
    NotificationChannelMessage? channel,
    $core.String? message,
  }) {
    final result = create();
    if (channel != null) result.channel = channel;
    if (message != null) result.message = message;
    return result;
  }

  UpdateNotificationChannelResponse._();

  factory UpdateNotificationChannelResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateNotificationChannelResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateNotificationChannelResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<NotificationChannelMessage>(1, _omitFieldNames ? '' : 'channel',
        subBuilder: NotificationChannelMessage.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateNotificationChannelResponse clone() =>
      UpdateNotificationChannelResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateNotificationChannelResponse copyWith(
          void Function(UpdateNotificationChannelResponse) updates) =>
      super.copyWith((message) =>
              updates(message as UpdateNotificationChannelResponse))
          as UpdateNotificationChannelResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateNotificationChannelResponse create() =>
      UpdateNotificationChannelResponse._();
  @$core.override
  UpdateNotificationChannelResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateNotificationChannelResponse> createRepeated() =>
      $pb.PbList<UpdateNotificationChannelResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateNotificationChannelResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateNotificationChannelResponse>(
          create);
  static UpdateNotificationChannelResponse? _defaultInstance;

  @$pb.TagNumber(1)
  NotificationChannelMessage get channel => $_getN(0);
  @$pb.TagNumber(1)
  set channel(NotificationChannelMessage value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasChannel() => $_has(0);
  @$pb.TagNumber(1)
  void clearChannel() => $_clearField(1);
  @$pb.TagNumber(1)
  NotificationChannelMessage ensureChannel() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);
}

class TestNotificationChannelRequest extends $pb.GeneratedMessage {
  factory TestNotificationChannelRequest({
    $core.String? channelId,
  }) {
    final result = create();
    if (channelId != null) result.channelId = channelId;
    return result;
  }

  TestNotificationChannelRequest._();

  factory TestNotificationChannelRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TestNotificationChannelRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TestNotificationChannelRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'channelId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TestNotificationChannelRequest clone() =>
      TestNotificationChannelRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TestNotificationChannelRequest copyWith(
          void Function(TestNotificationChannelRequest) updates) =>
      super.copyWith(
              (message) => updates(message as TestNotificationChannelRequest))
          as TestNotificationChannelRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TestNotificationChannelRequest create() =>
      TestNotificationChannelRequest._();
  @$core.override
  TestNotificationChannelRequest createEmptyInstance() => create();
  static $pb.PbList<TestNotificationChannelRequest> createRepeated() =>
      $pb.PbList<TestNotificationChannelRequest>();
  @$core.pragma('dart2js:noInline')
  static TestNotificationChannelRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TestNotificationChannelRequest>(create);
  static TestNotificationChannelRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get channelId => $_getSZ(0);
  @$pb.TagNumber(1)
  set channelId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasChannelId() => $_has(0);
  @$pb.TagNumber(1)
  void clearChannelId() => $_clearField(1);
}

class TestNotificationChannelResponse extends $pb.GeneratedMessage {
  factory TestNotificationChannelResponse({
    $core.bool? success,
    $core.String? message,
    $core.String? platformMessageId,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (platformMessageId != null) result.platformMessageId = platformMessageId;
    return result;
  }

  TestNotificationChannelResponse._();

  factory TestNotificationChannelResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TestNotificationChannelResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TestNotificationChannelResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOS(3, _omitFieldNames ? '' : 'platformMessageId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TestNotificationChannelResponse clone() =>
      TestNotificationChannelResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TestNotificationChannelResponse copyWith(
          void Function(TestNotificationChannelResponse) updates) =>
      super.copyWith(
              (message) => updates(message as TestNotificationChannelResponse))
          as TestNotificationChannelResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TestNotificationChannelResponse create() =>
      TestNotificationChannelResponse._();
  @$core.override
  TestNotificationChannelResponse createEmptyInstance() => create();
  static $pb.PbList<TestNotificationChannelResponse> createRepeated() =>
      $pb.PbList<TestNotificationChannelResponse>();
  @$core.pragma('dart2js:noInline')
  static TestNotificationChannelResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TestNotificationChannelResponse>(
          create);
  static TestNotificationChannelResponse? _defaultInstance;

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
  $core.String get platformMessageId => $_getSZ(2);
  @$pb.TagNumber(3)
  set platformMessageId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPlatformMessageId() => $_has(2);
  @$pb.TagNumber(3)
  void clearPlatformMessageId() => $_clearField(3);
}

class GetTelegramBotInfoRequest extends $pb.GeneratedMessage {
  factory GetTelegramBotInfoRequest() => create();

  GetTelegramBotInfoRequest._();

  factory GetTelegramBotInfoRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTelegramBotInfoRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetTelegramBotInfoRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTelegramBotInfoRequest clone() =>
      GetTelegramBotInfoRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTelegramBotInfoRequest copyWith(
          void Function(GetTelegramBotInfoRequest) updates) =>
      super.copyWith((message) => updates(message as GetTelegramBotInfoRequest))
          as GetTelegramBotInfoRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTelegramBotInfoRequest create() => GetTelegramBotInfoRequest._();
  @$core.override
  GetTelegramBotInfoRequest createEmptyInstance() => create();
  static $pb.PbList<GetTelegramBotInfoRequest> createRepeated() =>
      $pb.PbList<GetTelegramBotInfoRequest>();
  @$core.pragma('dart2js:noInline')
  static GetTelegramBotInfoRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetTelegramBotInfoRequest>(create);
  static GetTelegramBotInfoRequest? _defaultInstance;
}

class GetTelegramBotInfoResponse extends $pb.GeneratedMessage {
  factory GetTelegramBotInfoResponse({
    $core.String? botUsername,
    $core.String? botName,
    $core.String? botLink,
    $core.String? instructions,
  }) {
    final result = create();
    if (botUsername != null) result.botUsername = botUsername;
    if (botName != null) result.botName = botName;
    if (botLink != null) result.botLink = botLink;
    if (instructions != null) result.instructions = instructions;
    return result;
  }

  GetTelegramBotInfoResponse._();

  factory GetTelegramBotInfoResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTelegramBotInfoResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetTelegramBotInfoResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'botUsername')
    ..aOS(2, _omitFieldNames ? '' : 'botName')
    ..aOS(3, _omitFieldNames ? '' : 'botLink')
    ..aOS(4, _omitFieldNames ? '' : 'instructions')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTelegramBotInfoResponse clone() =>
      GetTelegramBotInfoResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTelegramBotInfoResponse copyWith(
          void Function(GetTelegramBotInfoResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetTelegramBotInfoResponse))
          as GetTelegramBotInfoResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTelegramBotInfoResponse create() => GetTelegramBotInfoResponse._();
  @$core.override
  GetTelegramBotInfoResponse createEmptyInstance() => create();
  static $pb.PbList<GetTelegramBotInfoResponse> createRepeated() =>
      $pb.PbList<GetTelegramBotInfoResponse>();
  @$core.pragma('dart2js:noInline')
  static GetTelegramBotInfoResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetTelegramBotInfoResponse>(create);
  static GetTelegramBotInfoResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get botUsername => $_getSZ(0);
  @$pb.TagNumber(1)
  set botUsername($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasBotUsername() => $_has(0);
  @$pb.TagNumber(1)
  void clearBotUsername() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get botName => $_getSZ(1);
  @$pb.TagNumber(2)
  set botName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasBotName() => $_has(1);
  @$pb.TagNumber(2)
  void clearBotName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get botLink => $_getSZ(2);
  @$pb.TagNumber(3)
  set botLink($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasBotLink() => $_has(2);
  @$pb.TagNumber(3)
  void clearBotLink() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get instructions => $_getSZ(3);
  @$pb.TagNumber(4)
  set instructions($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasInstructions() => $_has(3);
  @$pb.TagNumber(4)
  void clearInstructions() => $_clearField(4);
}

class VerifyTelegramChannelRequest extends $pb.GeneratedMessage {
  factory VerifyTelegramChannelRequest({
    $core.String? crowdfundId,
    $core.String? chatId,
    $core.String? verificationCode,
  }) {
    final result = create();
    if (crowdfundId != null) result.crowdfundId = crowdfundId;
    if (chatId != null) result.chatId = chatId;
    if (verificationCode != null) result.verificationCode = verificationCode;
    return result;
  }

  VerifyTelegramChannelRequest._();

  factory VerifyTelegramChannelRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VerifyTelegramChannelRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VerifyTelegramChannelRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'crowdfundId')
    ..aOS(2, _omitFieldNames ? '' : 'chatId')
    ..aOS(3, _omitFieldNames ? '' : 'verificationCode')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyTelegramChannelRequest clone() =>
      VerifyTelegramChannelRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyTelegramChannelRequest copyWith(
          void Function(VerifyTelegramChannelRequest) updates) =>
      super.copyWith(
              (message) => updates(message as VerifyTelegramChannelRequest))
          as VerifyTelegramChannelRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VerifyTelegramChannelRequest create() =>
      VerifyTelegramChannelRequest._();
  @$core.override
  VerifyTelegramChannelRequest createEmptyInstance() => create();
  static $pb.PbList<VerifyTelegramChannelRequest> createRepeated() =>
      $pb.PbList<VerifyTelegramChannelRequest>();
  @$core.pragma('dart2js:noInline')
  static VerifyTelegramChannelRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VerifyTelegramChannelRequest>(create);
  static VerifyTelegramChannelRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get crowdfundId => $_getSZ(0);
  @$pb.TagNumber(1)
  set crowdfundId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCrowdfundId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCrowdfundId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get chatId => $_getSZ(1);
  @$pb.TagNumber(2)
  set chatId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasChatId() => $_has(1);
  @$pb.TagNumber(2)
  void clearChatId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get verificationCode => $_getSZ(2);
  @$pb.TagNumber(3)
  set verificationCode($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasVerificationCode() => $_has(2);
  @$pb.TagNumber(3)
  void clearVerificationCode() => $_clearField(3);
}

class VerifyTelegramChannelResponse extends $pb.GeneratedMessage {
  factory VerifyTelegramChannelResponse({
    $core.bool? success,
    NotificationChannelMessage? channel,
    $core.String? message,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (channel != null) result.channel = channel;
    if (message != null) result.message = message;
    return result;
  }

  VerifyTelegramChannelResponse._();

  factory VerifyTelegramChannelResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VerifyTelegramChannelResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VerifyTelegramChannelResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOM<NotificationChannelMessage>(2, _omitFieldNames ? '' : 'channel',
        subBuilder: NotificationChannelMessage.create)
    ..aOS(3, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyTelegramChannelResponse clone() =>
      VerifyTelegramChannelResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyTelegramChannelResponse copyWith(
          void Function(VerifyTelegramChannelResponse) updates) =>
      super.copyWith(
              (message) => updates(message as VerifyTelegramChannelResponse))
          as VerifyTelegramChannelResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VerifyTelegramChannelResponse create() =>
      VerifyTelegramChannelResponse._();
  @$core.override
  VerifyTelegramChannelResponse createEmptyInstance() => create();
  static $pb.PbList<VerifyTelegramChannelResponse> createRepeated() =>
      $pb.PbList<VerifyTelegramChannelResponse>();
  @$core.pragma('dart2js:noInline')
  static VerifyTelegramChannelResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VerifyTelegramChannelResponse>(create);
  static VerifyTelegramChannelResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  NotificationChannelMessage get channel => $_getN(1);
  @$pb.TagNumber(2)
  set channel(NotificationChannelMessage value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasChannel() => $_has(1);
  @$pb.TagNumber(2)
  void clearChannel() => $_clearField(2);
  @$pb.TagNumber(2)
  NotificationChannelMessage ensureChannel() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => $_clearField(3);
}

class GetNotificationHistoryRequest extends $pb.GeneratedMessage {
  factory GetNotificationHistoryRequest({
    $core.String? crowdfundId,
    $core.String? channelId,
    $core.int? page,
    $core.int? pageSize,
  }) {
    final result = create();
    if (crowdfundId != null) result.crowdfundId = crowdfundId;
    if (channelId != null) result.channelId = channelId;
    if (page != null) result.page = page;
    if (pageSize != null) result.pageSize = pageSize;
    return result;
  }

  GetNotificationHistoryRequest._();

  factory GetNotificationHistoryRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetNotificationHistoryRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetNotificationHistoryRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'crowdfundId')
    ..aOS(2, _omitFieldNames ? '' : 'channelId')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetNotificationHistoryRequest clone() =>
      GetNotificationHistoryRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetNotificationHistoryRequest copyWith(
          void Function(GetNotificationHistoryRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetNotificationHistoryRequest))
          as GetNotificationHistoryRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetNotificationHistoryRequest create() =>
      GetNotificationHistoryRequest._();
  @$core.override
  GetNotificationHistoryRequest createEmptyInstance() => create();
  static $pb.PbList<GetNotificationHistoryRequest> createRepeated() =>
      $pb.PbList<GetNotificationHistoryRequest>();
  @$core.pragma('dart2js:noInline')
  static GetNotificationHistoryRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetNotificationHistoryRequest>(create);
  static GetNotificationHistoryRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get crowdfundId => $_getSZ(0);
  @$pb.TagNumber(1)
  set crowdfundId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCrowdfundId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCrowdfundId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get channelId => $_getSZ(1);
  @$pb.TagNumber(2)
  set channelId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasChannelId() => $_has(1);
  @$pb.TagNumber(2)
  void clearChannelId() => $_clearField(2);

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

class GetNotificationHistoryResponse extends $pb.GeneratedMessage {
  factory GetNotificationHistoryResponse({
    $core.Iterable<NotificationDeliveryMessage>? deliveries,
    $core.int? total,
    $core.int? page,
    $core.int? pageSize,
    $core.bool? hasMore,
  }) {
    final result = create();
    if (deliveries != null) result.deliveries.addAll(deliveries);
    if (total != null) result.total = total;
    if (page != null) result.page = page;
    if (pageSize != null) result.pageSize = pageSize;
    if (hasMore != null) result.hasMore = hasMore;
    return result;
  }

  GetNotificationHistoryResponse._();

  factory GetNotificationHistoryResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetNotificationHistoryResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetNotificationHistoryResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<NotificationDeliveryMessage>(
        1, _omitFieldNames ? '' : 'deliveries', $pb.PbFieldType.PM,
        subBuilder: NotificationDeliveryMessage.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOB(5, _omitFieldNames ? '' : 'hasMore')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetNotificationHistoryResponse clone() =>
      GetNotificationHistoryResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetNotificationHistoryResponse copyWith(
          void Function(GetNotificationHistoryResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetNotificationHistoryResponse))
          as GetNotificationHistoryResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetNotificationHistoryResponse create() =>
      GetNotificationHistoryResponse._();
  @$core.override
  GetNotificationHistoryResponse createEmptyInstance() => create();
  static $pb.PbList<GetNotificationHistoryResponse> createRepeated() =>
      $pb.PbList<GetNotificationHistoryResponse>();
  @$core.pragma('dart2js:noInline')
  static GetNotificationHistoryResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetNotificationHistoryResponse>(create);
  static GetNotificationHistoryResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<NotificationDeliveryMessage> get deliveries => $_getList(0);

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

class GetCrowdfundLeaderboardRequest extends $pb.GeneratedMessage {
  factory GetCrowdfundLeaderboardRequest({
    LeaderboardSortBy? sortBy,
    $core.String? category,
    $core.int? limit,
    $core.int? offset,
  }) {
    final result = create();
    if (sortBy != null) result.sortBy = sortBy;
    if (category != null) result.category = category;
    if (limit != null) result.limit = limit;
    if (offset != null) result.offset = offset;
    return result;
  }

  GetCrowdfundLeaderboardRequest._();

  factory GetCrowdfundLeaderboardRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetCrowdfundLeaderboardRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetCrowdfundLeaderboardRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..e<LeaderboardSortBy>(
        1, _omitFieldNames ? '' : 'sortBy', $pb.PbFieldType.OE,
        defaultOrMaker: LeaderboardSortBy.LEADERBOARD_SORT_UNSPECIFIED,
        valueOf: LeaderboardSortBy.valueOf,
        enumValues: LeaderboardSortBy.values)
    ..aOS(2, _omitFieldNames ? '' : 'category')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCrowdfundLeaderboardRequest clone() =>
      GetCrowdfundLeaderboardRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCrowdfundLeaderboardRequest copyWith(
          void Function(GetCrowdfundLeaderboardRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetCrowdfundLeaderboardRequest))
          as GetCrowdfundLeaderboardRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetCrowdfundLeaderboardRequest create() =>
      GetCrowdfundLeaderboardRequest._();
  @$core.override
  GetCrowdfundLeaderboardRequest createEmptyInstance() => create();
  static $pb.PbList<GetCrowdfundLeaderboardRequest> createRepeated() =>
      $pb.PbList<GetCrowdfundLeaderboardRequest>();
  @$core.pragma('dart2js:noInline')
  static GetCrowdfundLeaderboardRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetCrowdfundLeaderboardRequest>(create);
  static GetCrowdfundLeaderboardRequest? _defaultInstance;

  @$pb.TagNumber(1)
  LeaderboardSortBy get sortBy => $_getN(0);
  @$pb.TagNumber(1)
  set sortBy(LeaderboardSortBy value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasSortBy() => $_has(0);
  @$pb.TagNumber(1)
  void clearSortBy() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get category => $_getSZ(1);
  @$pb.TagNumber(2)
  set category($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCategory() => $_has(1);
  @$pb.TagNumber(2)
  void clearCategory() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get limit => $_getIZ(2);
  @$pb.TagNumber(3)
  set limit($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasLimit() => $_has(2);
  @$pb.TagNumber(3)
  void clearLimit() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get offset => $_getIZ(3);
  @$pb.TagNumber(4)
  set offset($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasOffset() => $_has(3);
  @$pb.TagNumber(4)
  void clearOffset() => $_clearField(4);
}

class GetCrowdfundLeaderboardResponse extends $pb.GeneratedMessage {
  factory GetCrowdfundLeaderboardResponse({
    $core.Iterable<LeaderboardCrowdfundEntry>? entries,
    $core.int? totalCount,
  }) {
    final result = create();
    if (entries != null) result.entries.addAll(entries);
    if (totalCount != null) result.totalCount = totalCount;
    return result;
  }

  GetCrowdfundLeaderboardResponse._();

  factory GetCrowdfundLeaderboardResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetCrowdfundLeaderboardResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetCrowdfundLeaderboardResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<LeaderboardCrowdfundEntry>(
        1, _omitFieldNames ? '' : 'entries', $pb.PbFieldType.PM,
        subBuilder: LeaderboardCrowdfundEntry.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'totalCount', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCrowdfundLeaderboardResponse clone() =>
      GetCrowdfundLeaderboardResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCrowdfundLeaderboardResponse copyWith(
          void Function(GetCrowdfundLeaderboardResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetCrowdfundLeaderboardResponse))
          as GetCrowdfundLeaderboardResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetCrowdfundLeaderboardResponse create() =>
      GetCrowdfundLeaderboardResponse._();
  @$core.override
  GetCrowdfundLeaderboardResponse createEmptyInstance() => create();
  static $pb.PbList<GetCrowdfundLeaderboardResponse> createRepeated() =>
      $pb.PbList<GetCrowdfundLeaderboardResponse>();
  @$core.pragma('dart2js:noInline')
  static GetCrowdfundLeaderboardResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetCrowdfundLeaderboardResponse>(
          create);
  static GetCrowdfundLeaderboardResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<LeaderboardCrowdfundEntry> get entries => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get totalCount => $_getIZ(1);
  @$pb.TagNumber(2)
  set totalCount($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotalCount() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalCount() => $_clearField(2);
}

class LeaderboardCrowdfundEntry extends $pb.GeneratedMessage {
  factory LeaderboardCrowdfundEntry({
    $core.int? rank,
    CrowdfundMessage? crowdfund,
  }) {
    final result = create();
    if (rank != null) result.rank = rank;
    if (crowdfund != null) result.crowdfund = crowdfund;
    return result;
  }

  LeaderboardCrowdfundEntry._();

  factory LeaderboardCrowdfundEntry.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory LeaderboardCrowdfundEntry.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LeaderboardCrowdfundEntry',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'rank', $pb.PbFieldType.O3)
    ..aOM<CrowdfundMessage>(2, _omitFieldNames ? '' : 'crowdfund',
        subBuilder: CrowdfundMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LeaderboardCrowdfundEntry clone() =>
      LeaderboardCrowdfundEntry()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LeaderboardCrowdfundEntry copyWith(
          void Function(LeaderboardCrowdfundEntry) updates) =>
      super.copyWith((message) => updates(message as LeaderboardCrowdfundEntry))
          as LeaderboardCrowdfundEntry;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LeaderboardCrowdfundEntry create() => LeaderboardCrowdfundEntry._();
  @$core.override
  LeaderboardCrowdfundEntry createEmptyInstance() => create();
  static $pb.PbList<LeaderboardCrowdfundEntry> createRepeated() =>
      $pb.PbList<LeaderboardCrowdfundEntry>();
  @$core.pragma('dart2js:noInline')
  static LeaderboardCrowdfundEntry getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LeaderboardCrowdfundEntry>(create);
  static LeaderboardCrowdfundEntry? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get rank => $_getIZ(0);
  @$pb.TagNumber(1)
  set rank($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRank() => $_has(0);
  @$pb.TagNumber(1)
  void clearRank() => $_clearField(1);

  @$pb.TagNumber(2)
  CrowdfundMessage get crowdfund => $_getN(1);
  @$pb.TagNumber(2)
  set crowdfund(CrowdfundMessage value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasCrowdfund() => $_has(1);
  @$pb.TagNumber(2)
  void clearCrowdfund() => $_clearField(2);
  @$pb.TagNumber(2)
  CrowdfundMessage ensureCrowdfund() => $_ensure(1);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
