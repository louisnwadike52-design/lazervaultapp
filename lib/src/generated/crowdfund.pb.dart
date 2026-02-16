//
//  Generated code. Do not modify.
//  source: crowdfund.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'crowdfund.pbenum.dart';
import 'google/protobuf/timestamp.pb.dart' as $1;

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
    final $result = create();
    if (userId != null) {
      $result.userId = userId;
    }
    if (username != null) {
      $result.username = username;
    }
    if (firstName != null) {
      $result.firstName = firstName;
    }
    if (lastName != null) {
      $result.lastName = lastName;
    }
    if (profilePicture != null) {
      $result.profilePicture = profilePicture;
    }
    if (verified != null) {
      $result.verified = verified;
    }
    if (verifiedAt != null) {
      $result.verifiedAt = verifiedAt;
    }
    if (facialRecognitionEnabled != null) {
      $result.facialRecognitionEnabled = facialRecognitionEnabled;
    }
    return $result;
  }
  CrowdfundCreatorMessage._() : super();
  factory CrowdfundCreatorMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CrowdfundCreatorMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CrowdfundCreatorMessage', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'userId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(2, _omitFieldNames ? '' : 'username')
    ..aOS(3, _omitFieldNames ? '' : 'firstName')
    ..aOS(4, _omitFieldNames ? '' : 'lastName')
    ..aOS(5, _omitFieldNames ? '' : 'profilePicture')
    ..aOB(6, _omitFieldNames ? '' : 'verified')
    ..aOM<$1.Timestamp>(7, _omitFieldNames ? '' : 'verifiedAt', subBuilder: $1.Timestamp.create)
    ..aOB(8, _omitFieldNames ? '' : 'facialRecognitionEnabled')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CrowdfundCreatorMessage clone() => CrowdfundCreatorMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CrowdfundCreatorMessage copyWith(void Function(CrowdfundCreatorMessage) updates) => super.copyWith((message) => updates(message as CrowdfundCreatorMessage)) as CrowdfundCreatorMessage;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CrowdfundCreatorMessage create() => CrowdfundCreatorMessage._();
  CrowdfundCreatorMessage createEmptyInstance() => create();
  static $pb.PbList<CrowdfundCreatorMessage> createRepeated() => $pb.PbList<CrowdfundCreatorMessage>();
  @$core.pragma('dart2js:noInline')
  static CrowdfundCreatorMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CrowdfundCreatorMessage>(create);
  static CrowdfundCreatorMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get userId => $_getI64(0);
  @$pb.TagNumber(1)
  set userId($fixnum.Int64 v) { $_setInt64(0, v); }
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
  $core.String get profilePicture => $_getSZ(4);
  @$pb.TagNumber(5)
  set profilePicture($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasProfilePicture() => $_has(4);
  @$pb.TagNumber(5)
  void clearProfilePicture() => clearField(5);

  @$pb.TagNumber(6)
  $core.bool get verified => $_getBF(5);
  @$pb.TagNumber(6)
  set verified($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasVerified() => $_has(5);
  @$pb.TagNumber(6)
  void clearVerified() => clearField(6);

  @$pb.TagNumber(7)
  $1.Timestamp get verifiedAt => $_getN(6);
  @$pb.TagNumber(7)
  set verifiedAt($1.Timestamp v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasVerifiedAt() => $_has(6);
  @$pb.TagNumber(7)
  void clearVerifiedAt() => clearField(7);
  @$pb.TagNumber(7)
  $1.Timestamp ensureVerifiedAt() => $_ensure(6);

  @$pb.TagNumber(8)
  $core.bool get facialRecognitionEnabled => $_getBF(7);
  @$pb.TagNumber(8)
  set facialRecognitionEnabled($core.bool v) { $_setBool(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasFacialRecognitionEnabled() => $_has(7);
  @$pb.TagNumber(8)
  void clearFacialRecognitionEnabled() => clearField(8);
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
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (creatorUserId != null) {
      $result.creatorUserId = creatorUserId;
    }
    if (creator != null) {
      $result.creator = creator;
    }
    if (title != null) {
      $result.title = title;
    }
    if (description != null) {
      $result.description = description;
    }
    if (story != null) {
      $result.story = story;
    }
    if (crowdfundCode != null) {
      $result.crowdfundCode = crowdfundCode;
    }
    if (targetAmount != null) {
      $result.targetAmount = targetAmount;
    }
    if (currentAmount != null) {
      $result.currentAmount = currentAmount;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (deadline != null) {
      $result.deadline = deadline;
    }
    if (category != null) {
      $result.category = category;
    }
    if (status != null) {
      $result.status = status;
    }
    if (imageUrl != null) {
      $result.imageUrl = imageUrl;
    }
    if (visibility != null) {
      $result.visibility = visibility;
    }
    if (metadata != null) {
      $result.metadata = metadata;
    }
    if (donorCount != null) {
      $result.donorCount = donorCount;
    }
    if (progressPercentage != null) {
      $result.progressPercentage = progressPercentage;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      $result.updatedAt = updatedAt;
    }
    if (recentDonations != null) {
      $result.recentDonations.addAll(recentDonations);
    }
    return $result;
  }
  CrowdfundMessage._() : super();
  factory CrowdfundMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CrowdfundMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CrowdfundMessage', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'creatorUserId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<CrowdfundCreatorMessage>(3, _omitFieldNames ? '' : 'creator', subBuilder: CrowdfundCreatorMessage.create)
    ..aOS(4, _omitFieldNames ? '' : 'title')
    ..aOS(5, _omitFieldNames ? '' : 'description')
    ..aOS(6, _omitFieldNames ? '' : 'story')
    ..aOS(7, _omitFieldNames ? '' : 'crowdfundCode')
    ..a<$fixnum.Int64>(8, _omitFieldNames ? '' : 'targetAmount', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(9, _omitFieldNames ? '' : 'currentAmount', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(10, _omitFieldNames ? '' : 'currency')
    ..aOM<$1.Timestamp>(11, _omitFieldNames ? '' : 'deadline', subBuilder: $1.Timestamp.create)
    ..aOS(12, _omitFieldNames ? '' : 'category')
    ..e<CrowdfundStatus>(13, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: CrowdfundStatus.CROWDFUND_STATUS_UNSPECIFIED, valueOf: CrowdfundStatus.valueOf, enumValues: CrowdfundStatus.values)
    ..aOS(14, _omitFieldNames ? '' : 'imageUrl')
    ..e<CrowdfundVisibility>(15, _omitFieldNames ? '' : 'visibility', $pb.PbFieldType.OE, defaultOrMaker: CrowdfundVisibility.CROWDFUND_VISIBILITY_UNSPECIFIED, valueOf: CrowdfundVisibility.valueOf, enumValues: CrowdfundVisibility.values)
    ..aOS(16, _omitFieldNames ? '' : 'metadata')
    ..a<$core.int>(17, _omitFieldNames ? '' : 'donorCount', $pb.PbFieldType.O3)
    ..a<$core.double>(18, _omitFieldNames ? '' : 'progressPercentage', $pb.PbFieldType.OD)
    ..aOM<$1.Timestamp>(19, _omitFieldNames ? '' : 'createdAt', subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(20, _omitFieldNames ? '' : 'updatedAt', subBuilder: $1.Timestamp.create)
    ..pc<CrowdfundDonationMessage>(21, _omitFieldNames ? '' : 'recentDonations', $pb.PbFieldType.PM, subBuilder: CrowdfundDonationMessage.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CrowdfundMessage clone() => CrowdfundMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CrowdfundMessage copyWith(void Function(CrowdfundMessage) updates) => super.copyWith((message) => updates(message as CrowdfundMessage)) as CrowdfundMessage;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CrowdfundMessage create() => CrowdfundMessage._();
  CrowdfundMessage createEmptyInstance() => create();
  static $pb.PbList<CrowdfundMessage> createRepeated() => $pb.PbList<CrowdfundMessage>();
  @$core.pragma('dart2js:noInline')
  static CrowdfundMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CrowdfundMessage>(create);
  static CrowdfundMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get creatorUserId => $_getI64(1);
  @$pb.TagNumber(2)
  set creatorUserId($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCreatorUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearCreatorUserId() => clearField(2);

  @$pb.TagNumber(3)
  CrowdfundCreatorMessage get creator => $_getN(2);
  @$pb.TagNumber(3)
  set creator(CrowdfundCreatorMessage v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasCreator() => $_has(2);
  @$pb.TagNumber(3)
  void clearCreator() => clearField(3);
  @$pb.TagNumber(3)
  CrowdfundCreatorMessage ensureCreator() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.String get title => $_getSZ(3);
  @$pb.TagNumber(4)
  set title($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTitle() => $_has(3);
  @$pb.TagNumber(4)
  void clearTitle() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get description => $_getSZ(4);
  @$pb.TagNumber(5)
  set description($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasDescription() => $_has(4);
  @$pb.TagNumber(5)
  void clearDescription() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get story => $_getSZ(5);
  @$pb.TagNumber(6)
  set story($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasStory() => $_has(5);
  @$pb.TagNumber(6)
  void clearStory() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get crowdfundCode => $_getSZ(6);
  @$pb.TagNumber(7)
  set crowdfundCode($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasCrowdfundCode() => $_has(6);
  @$pb.TagNumber(7)
  void clearCrowdfundCode() => clearField(7);

  @$pb.TagNumber(8)
  $fixnum.Int64 get targetAmount => $_getI64(7);
  @$pb.TagNumber(8)
  set targetAmount($fixnum.Int64 v) { $_setInt64(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasTargetAmount() => $_has(7);
  @$pb.TagNumber(8)
  void clearTargetAmount() => clearField(8);

  @$pb.TagNumber(9)
  $fixnum.Int64 get currentAmount => $_getI64(8);
  @$pb.TagNumber(9)
  set currentAmount($fixnum.Int64 v) { $_setInt64(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasCurrentAmount() => $_has(8);
  @$pb.TagNumber(9)
  void clearCurrentAmount() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get currency => $_getSZ(9);
  @$pb.TagNumber(10)
  set currency($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasCurrency() => $_has(9);
  @$pb.TagNumber(10)
  void clearCurrency() => clearField(10);

  @$pb.TagNumber(11)
  $1.Timestamp get deadline => $_getN(10);
  @$pb.TagNumber(11)
  set deadline($1.Timestamp v) { setField(11, v); }
  @$pb.TagNumber(11)
  $core.bool hasDeadline() => $_has(10);
  @$pb.TagNumber(11)
  void clearDeadline() => clearField(11);
  @$pb.TagNumber(11)
  $1.Timestamp ensureDeadline() => $_ensure(10);

  @$pb.TagNumber(12)
  $core.String get category => $_getSZ(11);
  @$pb.TagNumber(12)
  set category($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasCategory() => $_has(11);
  @$pb.TagNumber(12)
  void clearCategory() => clearField(12);

  @$pb.TagNumber(13)
  CrowdfundStatus get status => $_getN(12);
  @$pb.TagNumber(13)
  set status(CrowdfundStatus v) { setField(13, v); }
  @$pb.TagNumber(13)
  $core.bool hasStatus() => $_has(12);
  @$pb.TagNumber(13)
  void clearStatus() => clearField(13);

  @$pb.TagNumber(14)
  $core.String get imageUrl => $_getSZ(13);
  @$pb.TagNumber(14)
  set imageUrl($core.String v) { $_setString(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasImageUrl() => $_has(13);
  @$pb.TagNumber(14)
  void clearImageUrl() => clearField(14);

  @$pb.TagNumber(15)
  CrowdfundVisibility get visibility => $_getN(14);
  @$pb.TagNumber(15)
  set visibility(CrowdfundVisibility v) { setField(15, v); }
  @$pb.TagNumber(15)
  $core.bool hasVisibility() => $_has(14);
  @$pb.TagNumber(15)
  void clearVisibility() => clearField(15);

  @$pb.TagNumber(16)
  $core.String get metadata => $_getSZ(15);
  @$pb.TagNumber(16)
  set metadata($core.String v) { $_setString(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasMetadata() => $_has(15);
  @$pb.TagNumber(16)
  void clearMetadata() => clearField(16);

  @$pb.TagNumber(17)
  $core.int get donorCount => $_getIZ(16);
  @$pb.TagNumber(17)
  set donorCount($core.int v) { $_setSignedInt32(16, v); }
  @$pb.TagNumber(17)
  $core.bool hasDonorCount() => $_has(16);
  @$pb.TagNumber(17)
  void clearDonorCount() => clearField(17);

  @$pb.TagNumber(18)
  $core.double get progressPercentage => $_getN(17);
  @$pb.TagNumber(18)
  set progressPercentage($core.double v) { $_setDouble(17, v); }
  @$pb.TagNumber(18)
  $core.bool hasProgressPercentage() => $_has(17);
  @$pb.TagNumber(18)
  void clearProgressPercentage() => clearField(18);

  @$pb.TagNumber(19)
  $1.Timestamp get createdAt => $_getN(18);
  @$pb.TagNumber(19)
  set createdAt($1.Timestamp v) { setField(19, v); }
  @$pb.TagNumber(19)
  $core.bool hasCreatedAt() => $_has(18);
  @$pb.TagNumber(19)
  void clearCreatedAt() => clearField(19);
  @$pb.TagNumber(19)
  $1.Timestamp ensureCreatedAt() => $_ensure(18);

  @$pb.TagNumber(20)
  $1.Timestamp get updatedAt => $_getN(19);
  @$pb.TagNumber(20)
  set updatedAt($1.Timestamp v) { setField(20, v); }
  @$pb.TagNumber(20)
  $core.bool hasUpdatedAt() => $_has(19);
  @$pb.TagNumber(20)
  void clearUpdatedAt() => clearField(20);
  @$pb.TagNumber(20)
  $1.Timestamp ensureUpdatedAt() => $_ensure(19);

  @$pb.TagNumber(21)
  $core.List<CrowdfundDonationMessage> get recentDonations => $_getList(20);
}

class CrowdfundDonorMessage extends $pb.GeneratedMessage {
  factory CrowdfundDonorMessage({
    $fixnum.Int64? userId,
    $core.String? displayName,
    $core.String? profilePicture,
    $core.bool? isAnonymous,
    $core.bool? isCreator,
  }) {
    final $result = create();
    if (userId != null) {
      $result.userId = userId;
    }
    if (displayName != null) {
      $result.displayName = displayName;
    }
    if (profilePicture != null) {
      $result.profilePicture = profilePicture;
    }
    if (isAnonymous != null) {
      $result.isAnonymous = isAnonymous;
    }
    if (isCreator != null) {
      $result.isCreator = isCreator;
    }
    return $result;
  }
  CrowdfundDonorMessage._() : super();
  factory CrowdfundDonorMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CrowdfundDonorMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CrowdfundDonorMessage', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'userId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(2, _omitFieldNames ? '' : 'displayName')
    ..aOS(3, _omitFieldNames ? '' : 'profilePicture')
    ..aOB(4, _omitFieldNames ? '' : 'isAnonymous')
    ..aOB(5, _omitFieldNames ? '' : 'isCreator')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CrowdfundDonorMessage clone() => CrowdfundDonorMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CrowdfundDonorMessage copyWith(void Function(CrowdfundDonorMessage) updates) => super.copyWith((message) => updates(message as CrowdfundDonorMessage)) as CrowdfundDonorMessage;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CrowdfundDonorMessage create() => CrowdfundDonorMessage._();
  CrowdfundDonorMessage createEmptyInstance() => create();
  static $pb.PbList<CrowdfundDonorMessage> createRepeated() => $pb.PbList<CrowdfundDonorMessage>();
  @$core.pragma('dart2js:noInline')
  static CrowdfundDonorMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CrowdfundDonorMessage>(create);
  static CrowdfundDonorMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get userId => $_getI64(0);
  @$pb.TagNumber(1)
  set userId($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get displayName => $_getSZ(1);
  @$pb.TagNumber(2)
  set displayName($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasDisplayName() => $_has(1);
  @$pb.TagNumber(2)
  void clearDisplayName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get profilePicture => $_getSZ(2);
  @$pb.TagNumber(3)
  set profilePicture($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasProfilePicture() => $_has(2);
  @$pb.TagNumber(3)
  void clearProfilePicture() => clearField(3);

  @$pb.TagNumber(4)
  $core.bool get isAnonymous => $_getBF(3);
  @$pb.TagNumber(4)
  set isAnonymous($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasIsAnonymous() => $_has(3);
  @$pb.TagNumber(4)
  void clearIsAnonymous() => clearField(4);

  @$pb.TagNumber(5)
  $core.bool get isCreator => $_getBF(4);
  @$pb.TagNumber(5)
  set isCreator($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasIsCreator() => $_has(4);
  @$pb.TagNumber(5)
  void clearIsCreator() => clearField(5);
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
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (crowdfundId != null) {
      $result.crowdfundId = crowdfundId;
    }
    if (donorUserId != null) {
      $result.donorUserId = donorUserId;
    }
    if (donor != null) {
      $result.donor = donor;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (donationDate != null) {
      $result.donationDate = donationDate;
    }
    if (status != null) {
      $result.status = status;
    }
    if (transactionId != null) {
      $result.transactionId = transactionId;
    }
    if (receiptId != null) {
      $result.receiptId = receiptId;
    }
    if (message != null) {
      $result.message = message;
    }
    if (isAnonymous != null) {
      $result.isAnonymous = isAnonymous;
    }
    if (paymentMethod != null) {
      $result.paymentMethod = paymentMethod;
    }
    if (metadata != null) {
      $result.metadata = metadata;
    }
    return $result;
  }
  CrowdfundDonationMessage._() : super();
  factory CrowdfundDonationMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CrowdfundDonationMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CrowdfundDonationMessage', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'crowdfundId')
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'donorUserId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<CrowdfundDonorMessage>(4, _omitFieldNames ? '' : 'donor', subBuilder: CrowdfundDonorMessage.create)
    ..a<$fixnum.Int64>(5, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(6, _omitFieldNames ? '' : 'currency')
    ..aOM<$1.Timestamp>(7, _omitFieldNames ? '' : 'donationDate', subBuilder: $1.Timestamp.create)
    ..e<DonationStatus>(8, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: DonationStatus.DONATION_STATUS_UNSPECIFIED, valueOf: DonationStatus.valueOf, enumValues: DonationStatus.values)
    ..aOS(9, _omitFieldNames ? '' : 'transactionId')
    ..aOS(10, _omitFieldNames ? '' : 'receiptId')
    ..aOS(11, _omitFieldNames ? '' : 'message')
    ..aOB(12, _omitFieldNames ? '' : 'isAnonymous')
    ..aOS(13, _omitFieldNames ? '' : 'paymentMethod')
    ..aOS(14, _omitFieldNames ? '' : 'metadata')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CrowdfundDonationMessage clone() => CrowdfundDonationMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CrowdfundDonationMessage copyWith(void Function(CrowdfundDonationMessage) updates) => super.copyWith((message) => updates(message as CrowdfundDonationMessage)) as CrowdfundDonationMessage;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CrowdfundDonationMessage create() => CrowdfundDonationMessage._();
  CrowdfundDonationMessage createEmptyInstance() => create();
  static $pb.PbList<CrowdfundDonationMessage> createRepeated() => $pb.PbList<CrowdfundDonationMessage>();
  @$core.pragma('dart2js:noInline')
  static CrowdfundDonationMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CrowdfundDonationMessage>(create);
  static CrowdfundDonationMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get crowdfundId => $_getSZ(1);
  @$pb.TagNumber(2)
  set crowdfundId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCrowdfundId() => $_has(1);
  @$pb.TagNumber(2)
  void clearCrowdfundId() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get donorUserId => $_getI64(2);
  @$pb.TagNumber(3)
  set donorUserId($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDonorUserId() => $_has(2);
  @$pb.TagNumber(3)
  void clearDonorUserId() => clearField(3);

  @$pb.TagNumber(4)
  CrowdfundDonorMessage get donor => $_getN(3);
  @$pb.TagNumber(4)
  set donor(CrowdfundDonorMessage v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasDonor() => $_has(3);
  @$pb.TagNumber(4)
  void clearDonor() => clearField(4);
  @$pb.TagNumber(4)
  CrowdfundDonorMessage ensureDonor() => $_ensure(3);

  @$pb.TagNumber(5)
  $fixnum.Int64 get amount => $_getI64(4);
  @$pb.TagNumber(5)
  set amount($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasAmount() => $_has(4);
  @$pb.TagNumber(5)
  void clearAmount() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get currency => $_getSZ(5);
  @$pb.TagNumber(6)
  set currency($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasCurrency() => $_has(5);
  @$pb.TagNumber(6)
  void clearCurrency() => clearField(6);

  @$pb.TagNumber(7)
  $1.Timestamp get donationDate => $_getN(6);
  @$pb.TagNumber(7)
  set donationDate($1.Timestamp v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasDonationDate() => $_has(6);
  @$pb.TagNumber(7)
  void clearDonationDate() => clearField(7);
  @$pb.TagNumber(7)
  $1.Timestamp ensureDonationDate() => $_ensure(6);

  @$pb.TagNumber(8)
  DonationStatus get status => $_getN(7);
  @$pb.TagNumber(8)
  set status(DonationStatus v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasStatus() => $_has(7);
  @$pb.TagNumber(8)
  void clearStatus() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get transactionId => $_getSZ(8);
  @$pb.TagNumber(9)
  set transactionId($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasTransactionId() => $_has(8);
  @$pb.TagNumber(9)
  void clearTransactionId() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get receiptId => $_getSZ(9);
  @$pb.TagNumber(10)
  set receiptId($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasReceiptId() => $_has(9);
  @$pb.TagNumber(10)
  void clearReceiptId() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get message => $_getSZ(10);
  @$pb.TagNumber(11)
  set message($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasMessage() => $_has(10);
  @$pb.TagNumber(11)
  void clearMessage() => clearField(11);

  @$pb.TagNumber(12)
  $core.bool get isAnonymous => $_getBF(11);
  @$pb.TagNumber(12)
  set isAnonymous($core.bool v) { $_setBool(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasIsAnonymous() => $_has(11);
  @$pb.TagNumber(12)
  void clearIsAnonymous() => clearField(12);

  @$pb.TagNumber(13)
  $core.String get paymentMethod => $_getSZ(12);
  @$pb.TagNumber(13)
  set paymentMethod($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasPaymentMethod() => $_has(12);
  @$pb.TagNumber(13)
  void clearPaymentMethod() => clearField(13);

  @$pb.TagNumber(14)
  $core.String get metadata => $_getSZ(13);
  @$pb.TagNumber(14)
  set metadata($core.String v) { $_setString(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasMetadata() => $_has(13);
  @$pb.TagNumber(14)
  void clearMetadata() => clearField(14);
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
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (donationId != null) {
      $result.donationId = donationId;
    }
    if (crowdfundId != null) {
      $result.crowdfundId = crowdfundId;
    }
    if (crowdfundTitle != null) {
      $result.crowdfundTitle = crowdfundTitle;
    }
    if (donorUserId != null) {
      $result.donorUserId = donorUserId;
    }
    if (donorName != null) {
      $result.donorName = donorName;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (donationDate != null) {
      $result.donationDate = donationDate;
    }
    if (generatedAt != null) {
      $result.generatedAt = generatedAt;
    }
    if (receiptNumber != null) {
      $result.receiptNumber = receiptNumber;
    }
    if (receiptData != null) {
      $result.receiptData = receiptData;
    }
    return $result;
  }
  CrowdfundReceiptMessage._() : super();
  factory CrowdfundReceiptMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CrowdfundReceiptMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CrowdfundReceiptMessage', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'donationId')
    ..aOS(3, _omitFieldNames ? '' : 'crowdfundId')
    ..aOS(4, _omitFieldNames ? '' : 'crowdfundTitle')
    ..a<$fixnum.Int64>(5, _omitFieldNames ? '' : 'donorUserId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(6, _omitFieldNames ? '' : 'donorName')
    ..a<$fixnum.Int64>(7, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(8, _omitFieldNames ? '' : 'currency')
    ..aOM<$1.Timestamp>(9, _omitFieldNames ? '' : 'donationDate', subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(10, _omitFieldNames ? '' : 'generatedAt', subBuilder: $1.Timestamp.create)
    ..aOS(11, _omitFieldNames ? '' : 'receiptNumber')
    ..aOS(12, _omitFieldNames ? '' : 'receiptData')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CrowdfundReceiptMessage clone() => CrowdfundReceiptMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CrowdfundReceiptMessage copyWith(void Function(CrowdfundReceiptMessage) updates) => super.copyWith((message) => updates(message as CrowdfundReceiptMessage)) as CrowdfundReceiptMessage;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CrowdfundReceiptMessage create() => CrowdfundReceiptMessage._();
  CrowdfundReceiptMessage createEmptyInstance() => create();
  static $pb.PbList<CrowdfundReceiptMessage> createRepeated() => $pb.PbList<CrowdfundReceiptMessage>();
  @$core.pragma('dart2js:noInline')
  static CrowdfundReceiptMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CrowdfundReceiptMessage>(create);
  static CrowdfundReceiptMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get donationId => $_getSZ(1);
  @$pb.TagNumber(2)
  set donationId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasDonationId() => $_has(1);
  @$pb.TagNumber(2)
  void clearDonationId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get crowdfundId => $_getSZ(2);
  @$pb.TagNumber(3)
  set crowdfundId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCrowdfundId() => $_has(2);
  @$pb.TagNumber(3)
  void clearCrowdfundId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get crowdfundTitle => $_getSZ(3);
  @$pb.TagNumber(4)
  set crowdfundTitle($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCrowdfundTitle() => $_has(3);
  @$pb.TagNumber(4)
  void clearCrowdfundTitle() => clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get donorUserId => $_getI64(4);
  @$pb.TagNumber(5)
  set donorUserId($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasDonorUserId() => $_has(4);
  @$pb.TagNumber(5)
  void clearDonorUserId() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get donorName => $_getSZ(5);
  @$pb.TagNumber(6)
  set donorName($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasDonorName() => $_has(5);
  @$pb.TagNumber(6)
  void clearDonorName() => clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get amount => $_getI64(6);
  @$pb.TagNumber(7)
  set amount($fixnum.Int64 v) { $_setInt64(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasAmount() => $_has(6);
  @$pb.TagNumber(7)
  void clearAmount() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get currency => $_getSZ(7);
  @$pb.TagNumber(8)
  set currency($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasCurrency() => $_has(7);
  @$pb.TagNumber(8)
  void clearCurrency() => clearField(8);

  @$pb.TagNumber(9)
  $1.Timestamp get donationDate => $_getN(8);
  @$pb.TagNumber(9)
  set donationDate($1.Timestamp v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasDonationDate() => $_has(8);
  @$pb.TagNumber(9)
  void clearDonationDate() => clearField(9);
  @$pb.TagNumber(9)
  $1.Timestamp ensureDonationDate() => $_ensure(8);

  @$pb.TagNumber(10)
  $1.Timestamp get generatedAt => $_getN(9);
  @$pb.TagNumber(10)
  set generatedAt($1.Timestamp v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasGeneratedAt() => $_has(9);
  @$pb.TagNumber(10)
  void clearGeneratedAt() => clearField(10);
  @$pb.TagNumber(10)
  $1.Timestamp ensureGeneratedAt() => $_ensure(9);

  @$pb.TagNumber(11)
  $core.String get receiptNumber => $_getSZ(10);
  @$pb.TagNumber(11)
  set receiptNumber($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasReceiptNumber() => $_has(10);
  @$pb.TagNumber(11)
  void clearReceiptNumber() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get receiptData => $_getSZ(11);
  @$pb.TagNumber(12)
  set receiptData($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasReceiptData() => $_has(11);
  @$pb.TagNumber(12)
  void clearReceiptData() => clearField(12);
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
    final $result = create();
    if (title != null) {
      $result.title = title;
    }
    if (description != null) {
      $result.description = description;
    }
    if (story != null) {
      $result.story = story;
    }
    if (targetAmount != null) {
      $result.targetAmount = targetAmount;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (deadline != null) {
      $result.deadline = deadline;
    }
    if (category != null) {
      $result.category = category;
    }
    if (imageUrl != null) {
      $result.imageUrl = imageUrl;
    }
    if (visibility != null) {
      $result.visibility = visibility;
    }
    if (metadata != null) {
      $result.metadata = metadata;
    }
    return $result;
  }
  CreateCrowdfundRequest._() : super();
  factory CreateCrowdfundRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateCrowdfundRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateCrowdfundRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'title')
    ..aOS(2, _omitFieldNames ? '' : 'description')
    ..aOS(3, _omitFieldNames ? '' : 'story')
    ..a<$fixnum.Int64>(4, _omitFieldNames ? '' : 'targetAmount', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(5, _omitFieldNames ? '' : 'currency')
    ..aOM<$1.Timestamp>(6, _omitFieldNames ? '' : 'deadline', subBuilder: $1.Timestamp.create)
    ..aOS(7, _omitFieldNames ? '' : 'category')
    ..aOS(8, _omitFieldNames ? '' : 'imageUrl')
    ..e<CrowdfundVisibility>(9, _omitFieldNames ? '' : 'visibility', $pb.PbFieldType.OE, defaultOrMaker: CrowdfundVisibility.CROWDFUND_VISIBILITY_UNSPECIFIED, valueOf: CrowdfundVisibility.valueOf, enumValues: CrowdfundVisibility.values)
    ..aOS(10, _omitFieldNames ? '' : 'metadata')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateCrowdfundRequest clone() => CreateCrowdfundRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateCrowdfundRequest copyWith(void Function(CreateCrowdfundRequest) updates) => super.copyWith((message) => updates(message as CreateCrowdfundRequest)) as CreateCrowdfundRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateCrowdfundRequest create() => CreateCrowdfundRequest._();
  CreateCrowdfundRequest createEmptyInstance() => create();
  static $pb.PbList<CreateCrowdfundRequest> createRepeated() => $pb.PbList<CreateCrowdfundRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateCrowdfundRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateCrowdfundRequest>(create);
  static CreateCrowdfundRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get title => $_getSZ(0);
  @$pb.TagNumber(1)
  set title($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTitle() => $_has(0);
  @$pb.TagNumber(1)
  void clearTitle() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get description => $_getSZ(1);
  @$pb.TagNumber(2)
  set description($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasDescription() => $_has(1);
  @$pb.TagNumber(2)
  void clearDescription() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get story => $_getSZ(2);
  @$pb.TagNumber(3)
  set story($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasStory() => $_has(2);
  @$pb.TagNumber(3)
  void clearStory() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get targetAmount => $_getI64(3);
  @$pb.TagNumber(4)
  set targetAmount($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTargetAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearTargetAmount() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get currency => $_getSZ(4);
  @$pb.TagNumber(5)
  set currency($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasCurrency() => $_has(4);
  @$pb.TagNumber(5)
  void clearCurrency() => clearField(5);

  @$pb.TagNumber(6)
  $1.Timestamp get deadline => $_getN(5);
  @$pb.TagNumber(6)
  set deadline($1.Timestamp v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasDeadline() => $_has(5);
  @$pb.TagNumber(6)
  void clearDeadline() => clearField(6);
  @$pb.TagNumber(6)
  $1.Timestamp ensureDeadline() => $_ensure(5);

  @$pb.TagNumber(7)
  $core.String get category => $_getSZ(6);
  @$pb.TagNumber(7)
  set category($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasCategory() => $_has(6);
  @$pb.TagNumber(7)
  void clearCategory() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get imageUrl => $_getSZ(7);
  @$pb.TagNumber(8)
  set imageUrl($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasImageUrl() => $_has(7);
  @$pb.TagNumber(8)
  void clearImageUrl() => clearField(8);

  @$pb.TagNumber(9)
  CrowdfundVisibility get visibility => $_getN(8);
  @$pb.TagNumber(9)
  set visibility(CrowdfundVisibility v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasVisibility() => $_has(8);
  @$pb.TagNumber(9)
  void clearVisibility() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get metadata => $_getSZ(9);
  @$pb.TagNumber(10)
  set metadata($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasMetadata() => $_has(9);
  @$pb.TagNumber(10)
  void clearMetadata() => clearField(10);
}

class CreateCrowdfundResponse extends $pb.GeneratedMessage {
  factory CreateCrowdfundResponse({
    CrowdfundMessage? crowdfund,
  }) {
    final $result = create();
    if (crowdfund != null) {
      $result.crowdfund = crowdfund;
    }
    return $result;
  }
  CreateCrowdfundResponse._() : super();
  factory CreateCrowdfundResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateCrowdfundResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateCrowdfundResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<CrowdfundMessage>(1, _omitFieldNames ? '' : 'crowdfund', subBuilder: CrowdfundMessage.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateCrowdfundResponse clone() => CreateCrowdfundResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateCrowdfundResponse copyWith(void Function(CreateCrowdfundResponse) updates) => super.copyWith((message) => updates(message as CreateCrowdfundResponse)) as CreateCrowdfundResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateCrowdfundResponse create() => CreateCrowdfundResponse._();
  CreateCrowdfundResponse createEmptyInstance() => create();
  static $pb.PbList<CreateCrowdfundResponse> createRepeated() => $pb.PbList<CreateCrowdfundResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateCrowdfundResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateCrowdfundResponse>(create);
  static CreateCrowdfundResponse? _defaultInstance;

  @$pb.TagNumber(1)
  CrowdfundMessage get crowdfund => $_getN(0);
  @$pb.TagNumber(1)
  set crowdfund(CrowdfundMessage v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasCrowdfund() => $_has(0);
  @$pb.TagNumber(1)
  void clearCrowdfund() => clearField(1);
  @$pb.TagNumber(1)
  CrowdfundMessage ensureCrowdfund() => $_ensure(0);
}

/// Get Crowdfund
class GetCrowdfundRequest extends $pb.GeneratedMessage {
  factory GetCrowdfundRequest({
    $core.String? crowdfundId,
  }) {
    final $result = create();
    if (crowdfundId != null) {
      $result.crowdfundId = crowdfundId;
    }
    return $result;
  }
  GetCrowdfundRequest._() : super();
  factory GetCrowdfundRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCrowdfundRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetCrowdfundRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'crowdfundId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCrowdfundRequest clone() => GetCrowdfundRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCrowdfundRequest copyWith(void Function(GetCrowdfundRequest) updates) => super.copyWith((message) => updates(message as GetCrowdfundRequest)) as GetCrowdfundRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetCrowdfundRequest create() => GetCrowdfundRequest._();
  GetCrowdfundRequest createEmptyInstance() => create();
  static $pb.PbList<GetCrowdfundRequest> createRepeated() => $pb.PbList<GetCrowdfundRequest>();
  @$core.pragma('dart2js:noInline')
  static GetCrowdfundRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetCrowdfundRequest>(create);
  static GetCrowdfundRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get crowdfundId => $_getSZ(0);
  @$pb.TagNumber(1)
  set crowdfundId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCrowdfundId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCrowdfundId() => clearField(1);
}

class GetCrowdfundResponse extends $pb.GeneratedMessage {
  factory GetCrowdfundResponse({
    CrowdfundMessage? crowdfund,
  }) {
    final $result = create();
    if (crowdfund != null) {
      $result.crowdfund = crowdfund;
    }
    return $result;
  }
  GetCrowdfundResponse._() : super();
  factory GetCrowdfundResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCrowdfundResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetCrowdfundResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<CrowdfundMessage>(1, _omitFieldNames ? '' : 'crowdfund', subBuilder: CrowdfundMessage.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCrowdfundResponse clone() => GetCrowdfundResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCrowdfundResponse copyWith(void Function(GetCrowdfundResponse) updates) => super.copyWith((message) => updates(message as GetCrowdfundResponse)) as GetCrowdfundResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetCrowdfundResponse create() => GetCrowdfundResponse._();
  GetCrowdfundResponse createEmptyInstance() => create();
  static $pb.PbList<GetCrowdfundResponse> createRepeated() => $pb.PbList<GetCrowdfundResponse>();
  @$core.pragma('dart2js:noInline')
  static GetCrowdfundResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetCrowdfundResponse>(create);
  static GetCrowdfundResponse? _defaultInstance;

  @$pb.TagNumber(1)
  CrowdfundMessage get crowdfund => $_getN(0);
  @$pb.TagNumber(1)
  set crowdfund(CrowdfundMessage v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasCrowdfund() => $_has(0);
  @$pb.TagNumber(1)
  void clearCrowdfund() => clearField(1);
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
    final $result = create();
    if (page != null) {
      $result.page = page;
    }
    if (pageSize != null) {
      $result.pageSize = pageSize;
    }
    if (status != null) {
      $result.status = status;
    }
    if (category != null) {
      $result.category = category;
    }
    if (myCrowdfundsOnly != null) {
      $result.myCrowdfundsOnly = myCrowdfundsOnly;
    }
    if (sortBy != null) {
      $result.sortBy = sortBy;
    }
    if (visibility != null) {
      $result.visibility = visibility;
    }
    return $result;
  }
  ListCrowdfundsRequest._() : super();
  factory ListCrowdfundsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListCrowdfundsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ListCrowdfundsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOS(3, _omitFieldNames ? '' : 'status')
    ..aOS(4, _omitFieldNames ? '' : 'category')
    ..aOB(5, _omitFieldNames ? '' : 'myCrowdfundsOnly')
    ..aOS(6, _omitFieldNames ? '' : 'sortBy')
    ..e<CrowdfundVisibility>(7, _omitFieldNames ? '' : 'visibility', $pb.PbFieldType.OE, defaultOrMaker: CrowdfundVisibility.CROWDFUND_VISIBILITY_UNSPECIFIED, valueOf: CrowdfundVisibility.valueOf, enumValues: CrowdfundVisibility.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListCrowdfundsRequest clone() => ListCrowdfundsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListCrowdfundsRequest copyWith(void Function(ListCrowdfundsRequest) updates) => super.copyWith((message) => updates(message as ListCrowdfundsRequest)) as ListCrowdfundsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListCrowdfundsRequest create() => ListCrowdfundsRequest._();
  ListCrowdfundsRequest createEmptyInstance() => create();
  static $pb.PbList<ListCrowdfundsRequest> createRepeated() => $pb.PbList<ListCrowdfundsRequest>();
  @$core.pragma('dart2js:noInline')
  static ListCrowdfundsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListCrowdfundsRequest>(create);
  static ListCrowdfundsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get page => $_getIZ(0);
  @$pb.TagNumber(1)
  set page($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearPage() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get pageSize => $_getIZ(1);
  @$pb.TagNumber(2)
  set pageSize($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPageSize() => $_has(1);
  @$pb.TagNumber(2)
  void clearPageSize() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get status => $_getSZ(2);
  @$pb.TagNumber(3)
  set status($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasStatus() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatus() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get category => $_getSZ(3);
  @$pb.TagNumber(4)
  set category($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCategory() => $_has(3);
  @$pb.TagNumber(4)
  void clearCategory() => clearField(4);

  @$pb.TagNumber(5)
  $core.bool get myCrowdfundsOnly => $_getBF(4);
  @$pb.TagNumber(5)
  set myCrowdfundsOnly($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasMyCrowdfundsOnly() => $_has(4);
  @$pb.TagNumber(5)
  void clearMyCrowdfundsOnly() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get sortBy => $_getSZ(5);
  @$pb.TagNumber(6)
  set sortBy($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasSortBy() => $_has(5);
  @$pb.TagNumber(6)
  void clearSortBy() => clearField(6);

  @$pb.TagNumber(7)
  CrowdfundVisibility get visibility => $_getN(6);
  @$pb.TagNumber(7)
  set visibility(CrowdfundVisibility v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasVisibility() => $_has(6);
  @$pb.TagNumber(7)
  void clearVisibility() => clearField(7);
}

class ListCrowdfundsResponse extends $pb.GeneratedMessage {
  factory ListCrowdfundsResponse({
    $core.Iterable<CrowdfundMessage>? crowdfunds,
    CrowdfundPaginationInfo? pagination,
  }) {
    final $result = create();
    if (crowdfunds != null) {
      $result.crowdfunds.addAll(crowdfunds);
    }
    if (pagination != null) {
      $result.pagination = pagination;
    }
    return $result;
  }
  ListCrowdfundsResponse._() : super();
  factory ListCrowdfundsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListCrowdfundsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ListCrowdfundsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pc<CrowdfundMessage>(1, _omitFieldNames ? '' : 'crowdfunds', $pb.PbFieldType.PM, subBuilder: CrowdfundMessage.create)
    ..aOM<CrowdfundPaginationInfo>(2, _omitFieldNames ? '' : 'pagination', subBuilder: CrowdfundPaginationInfo.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListCrowdfundsResponse clone() => ListCrowdfundsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListCrowdfundsResponse copyWith(void Function(ListCrowdfundsResponse) updates) => super.copyWith((message) => updates(message as ListCrowdfundsResponse)) as ListCrowdfundsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListCrowdfundsResponse create() => ListCrowdfundsResponse._();
  ListCrowdfundsResponse createEmptyInstance() => create();
  static $pb.PbList<ListCrowdfundsResponse> createRepeated() => $pb.PbList<ListCrowdfundsResponse>();
  @$core.pragma('dart2js:noInline')
  static ListCrowdfundsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListCrowdfundsResponse>(create);
  static ListCrowdfundsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<CrowdfundMessage> get crowdfunds => $_getList(0);

  @$pb.TagNumber(2)
  CrowdfundPaginationInfo get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination(CrowdfundPaginationInfo v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => clearField(2);
  @$pb.TagNumber(2)
  CrowdfundPaginationInfo ensurePagination() => $_ensure(1);
}

/// Search Crowdfunds
class SearchCrowdfundsRequest extends $pb.GeneratedMessage {
  factory SearchCrowdfundsRequest({
    $core.String? query,
    $core.int? limit,
  }) {
    final $result = create();
    if (query != null) {
      $result.query = query;
    }
    if (limit != null) {
      $result.limit = limit;
    }
    return $result;
  }
  SearchCrowdfundsRequest._() : super();
  factory SearchCrowdfundsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SearchCrowdfundsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SearchCrowdfundsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'query')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SearchCrowdfundsRequest clone() => SearchCrowdfundsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SearchCrowdfundsRequest copyWith(void Function(SearchCrowdfundsRequest) updates) => super.copyWith((message) => updates(message as SearchCrowdfundsRequest)) as SearchCrowdfundsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SearchCrowdfundsRequest create() => SearchCrowdfundsRequest._();
  SearchCrowdfundsRequest createEmptyInstance() => create();
  static $pb.PbList<SearchCrowdfundsRequest> createRepeated() => $pb.PbList<SearchCrowdfundsRequest>();
  @$core.pragma('dart2js:noInline')
  static SearchCrowdfundsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SearchCrowdfundsRequest>(create);
  static SearchCrowdfundsRequest? _defaultInstance;

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

class SearchCrowdfundsResponse extends $pb.GeneratedMessage {
  factory SearchCrowdfundsResponse({
    $core.Iterable<CrowdfundMessage>? crowdfunds,
  }) {
    final $result = create();
    if (crowdfunds != null) {
      $result.crowdfunds.addAll(crowdfunds);
    }
    return $result;
  }
  SearchCrowdfundsResponse._() : super();
  factory SearchCrowdfundsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SearchCrowdfundsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SearchCrowdfundsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pc<CrowdfundMessage>(1, _omitFieldNames ? '' : 'crowdfunds', $pb.PbFieldType.PM, subBuilder: CrowdfundMessage.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SearchCrowdfundsResponse clone() => SearchCrowdfundsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SearchCrowdfundsResponse copyWith(void Function(SearchCrowdfundsResponse) updates) => super.copyWith((message) => updates(message as SearchCrowdfundsResponse)) as SearchCrowdfundsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SearchCrowdfundsResponse create() => SearchCrowdfundsResponse._();
  SearchCrowdfundsResponse createEmptyInstance() => create();
  static $pb.PbList<SearchCrowdfundsResponse> createRepeated() => $pb.PbList<SearchCrowdfundsResponse>();
  @$core.pragma('dart2js:noInline')
  static SearchCrowdfundsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SearchCrowdfundsResponse>(create);
  static SearchCrowdfundsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<CrowdfundMessage> get crowdfunds => $_getList(0);
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
    final $result = create();
    if (crowdfundId != null) {
      $result.crowdfundId = crowdfundId;
    }
    if (title != null) {
      $result.title = title;
    }
    if (description != null) {
      $result.description = description;
    }
    if (story != null) {
      $result.story = story;
    }
    if (deadline != null) {
      $result.deadline = deadline;
    }
    if (status != null) {
      $result.status = status;
    }
    if (imageUrl != null) {
      $result.imageUrl = imageUrl;
    }
    if (metadata != null) {
      $result.metadata = metadata;
    }
    return $result;
  }
  UpdateCrowdfundRequest._() : super();
  factory UpdateCrowdfundRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateCrowdfundRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateCrowdfundRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'crowdfundId')
    ..aOS(2, _omitFieldNames ? '' : 'title')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..aOS(4, _omitFieldNames ? '' : 'story')
    ..aOM<$1.Timestamp>(5, _omitFieldNames ? '' : 'deadline', subBuilder: $1.Timestamp.create)
    ..e<CrowdfundStatus>(6, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: CrowdfundStatus.CROWDFUND_STATUS_UNSPECIFIED, valueOf: CrowdfundStatus.valueOf, enumValues: CrowdfundStatus.values)
    ..aOS(7, _omitFieldNames ? '' : 'imageUrl')
    ..aOS(8, _omitFieldNames ? '' : 'metadata')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateCrowdfundRequest clone() => UpdateCrowdfundRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateCrowdfundRequest copyWith(void Function(UpdateCrowdfundRequest) updates) => super.copyWith((message) => updates(message as UpdateCrowdfundRequest)) as UpdateCrowdfundRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateCrowdfundRequest create() => UpdateCrowdfundRequest._();
  UpdateCrowdfundRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateCrowdfundRequest> createRepeated() => $pb.PbList<UpdateCrowdfundRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateCrowdfundRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateCrowdfundRequest>(create);
  static UpdateCrowdfundRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get crowdfundId => $_getSZ(0);
  @$pb.TagNumber(1)
  set crowdfundId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCrowdfundId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCrowdfundId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get title => $_getSZ(1);
  @$pb.TagNumber(2)
  set title($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTitle() => $_has(1);
  @$pb.TagNumber(2)
  void clearTitle() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get story => $_getSZ(3);
  @$pb.TagNumber(4)
  set story($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasStory() => $_has(3);
  @$pb.TagNumber(4)
  void clearStory() => clearField(4);

  @$pb.TagNumber(5)
  $1.Timestamp get deadline => $_getN(4);
  @$pb.TagNumber(5)
  set deadline($1.Timestamp v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasDeadline() => $_has(4);
  @$pb.TagNumber(5)
  void clearDeadline() => clearField(5);
  @$pb.TagNumber(5)
  $1.Timestamp ensureDeadline() => $_ensure(4);

  @$pb.TagNumber(6)
  CrowdfundStatus get status => $_getN(5);
  @$pb.TagNumber(6)
  set status(CrowdfundStatus v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasStatus() => $_has(5);
  @$pb.TagNumber(6)
  void clearStatus() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get imageUrl => $_getSZ(6);
  @$pb.TagNumber(7)
  set imageUrl($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasImageUrl() => $_has(6);
  @$pb.TagNumber(7)
  void clearImageUrl() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get metadata => $_getSZ(7);
  @$pb.TagNumber(8)
  set metadata($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasMetadata() => $_has(7);
  @$pb.TagNumber(8)
  void clearMetadata() => clearField(8);
}

class UpdateCrowdfundResponse extends $pb.GeneratedMessage {
  factory UpdateCrowdfundResponse({
    CrowdfundMessage? crowdfund,
  }) {
    final $result = create();
    if (crowdfund != null) {
      $result.crowdfund = crowdfund;
    }
    return $result;
  }
  UpdateCrowdfundResponse._() : super();
  factory UpdateCrowdfundResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateCrowdfundResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateCrowdfundResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<CrowdfundMessage>(1, _omitFieldNames ? '' : 'crowdfund', subBuilder: CrowdfundMessage.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateCrowdfundResponse clone() => UpdateCrowdfundResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateCrowdfundResponse copyWith(void Function(UpdateCrowdfundResponse) updates) => super.copyWith((message) => updates(message as UpdateCrowdfundResponse)) as UpdateCrowdfundResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateCrowdfundResponse create() => UpdateCrowdfundResponse._();
  UpdateCrowdfundResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateCrowdfundResponse> createRepeated() => $pb.PbList<UpdateCrowdfundResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateCrowdfundResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateCrowdfundResponse>(create);
  static UpdateCrowdfundResponse? _defaultInstance;

  @$pb.TagNumber(1)
  CrowdfundMessage get crowdfund => $_getN(0);
  @$pb.TagNumber(1)
  set crowdfund(CrowdfundMessage v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasCrowdfund() => $_has(0);
  @$pb.TagNumber(1)
  void clearCrowdfund() => clearField(1);
  @$pb.TagNumber(1)
  CrowdfundMessage ensureCrowdfund() => $_ensure(0);
}

/// Delete Crowdfund
class DeleteCrowdfundRequest extends $pb.GeneratedMessage {
  factory DeleteCrowdfundRequest({
    $core.String? crowdfundId,
  }) {
    final $result = create();
    if (crowdfundId != null) {
      $result.crowdfundId = crowdfundId;
    }
    return $result;
  }
  DeleteCrowdfundRequest._() : super();
  factory DeleteCrowdfundRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteCrowdfundRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DeleteCrowdfundRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'crowdfundId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteCrowdfundRequest clone() => DeleteCrowdfundRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteCrowdfundRequest copyWith(void Function(DeleteCrowdfundRequest) updates) => super.copyWith((message) => updates(message as DeleteCrowdfundRequest)) as DeleteCrowdfundRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteCrowdfundRequest create() => DeleteCrowdfundRequest._();
  DeleteCrowdfundRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteCrowdfundRequest> createRepeated() => $pb.PbList<DeleteCrowdfundRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteCrowdfundRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteCrowdfundRequest>(create);
  static DeleteCrowdfundRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get crowdfundId => $_getSZ(0);
  @$pb.TagNumber(1)
  set crowdfundId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCrowdfundId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCrowdfundId() => clearField(1);
}

class DeleteCrowdfundResponse extends $pb.GeneratedMessage {
  factory DeleteCrowdfundResponse({
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
  DeleteCrowdfundResponse._() : super();
  factory DeleteCrowdfundResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteCrowdfundResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DeleteCrowdfundResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteCrowdfundResponse clone() => DeleteCrowdfundResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteCrowdfundResponse copyWith(void Function(DeleteCrowdfundResponse) updates) => super.copyWith((message) => updates(message as DeleteCrowdfundResponse)) as DeleteCrowdfundResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteCrowdfundResponse create() => DeleteCrowdfundResponse._();
  DeleteCrowdfundResponse createEmptyInstance() => create();
  static $pb.PbList<DeleteCrowdfundResponse> createRepeated() => $pb.PbList<DeleteCrowdfundResponse>();
  @$core.pragma('dart2js:noInline')
  static DeleteCrowdfundResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteCrowdfundResponse>(create);
  static DeleteCrowdfundResponse? _defaultInstance;

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

/// Make Donation
class MakeDonationRequest extends $pb.GeneratedMessage {
  factory MakeDonationRequest({
    $core.String? crowdfundId,
    $fixnum.Int64? amount,
    $core.String? message,
    $core.bool? isAnonymous,
    $core.String? sourceAccountId,
  }) {
    final $result = create();
    if (crowdfundId != null) {
      $result.crowdfundId = crowdfundId;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (message != null) {
      $result.message = message;
    }
    if (isAnonymous != null) {
      $result.isAnonymous = isAnonymous;
    }
    if (sourceAccountId != null) {
      $result.sourceAccountId = sourceAccountId;
    }
    return $result;
  }
  MakeDonationRequest._() : super();
  factory MakeDonationRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MakeDonationRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MakeDonationRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'crowdfundId')
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(3, _omitFieldNames ? '' : 'message')
    ..aOB(4, _omitFieldNames ? '' : 'isAnonymous')
    ..aOS(5, _omitFieldNames ? '' : 'sourceAccountId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MakeDonationRequest clone() => MakeDonationRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MakeDonationRequest copyWith(void Function(MakeDonationRequest) updates) => super.copyWith((message) => updates(message as MakeDonationRequest)) as MakeDonationRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MakeDonationRequest create() => MakeDonationRequest._();
  MakeDonationRequest createEmptyInstance() => create();
  static $pb.PbList<MakeDonationRequest> createRepeated() => $pb.PbList<MakeDonationRequest>();
  @$core.pragma('dart2js:noInline')
  static MakeDonationRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MakeDonationRequest>(create);
  static MakeDonationRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get crowdfundId => $_getSZ(0);
  @$pb.TagNumber(1)
  set crowdfundId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCrowdfundId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCrowdfundId() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get amount => $_getI64(1);
  @$pb.TagNumber(2)
  set amount($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => clearField(3);

  @$pb.TagNumber(4)
  $core.bool get isAnonymous => $_getBF(3);
  @$pb.TagNumber(4)
  set isAnonymous($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasIsAnonymous() => $_has(3);
  @$pb.TagNumber(4)
  void clearIsAnonymous() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get sourceAccountId => $_getSZ(4);
  @$pb.TagNumber(5)
  set sourceAccountId($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasSourceAccountId() => $_has(4);
  @$pb.TagNumber(5)
  void clearSourceAccountId() => clearField(5);
}

class MakeDonationResponse extends $pb.GeneratedMessage {
  factory MakeDonationResponse({
    CrowdfundDonationMessage? donation,
  }) {
    final $result = create();
    if (donation != null) {
      $result.donation = donation;
    }
    return $result;
  }
  MakeDonationResponse._() : super();
  factory MakeDonationResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MakeDonationResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MakeDonationResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<CrowdfundDonationMessage>(1, _omitFieldNames ? '' : 'donation', subBuilder: CrowdfundDonationMessage.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MakeDonationResponse clone() => MakeDonationResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MakeDonationResponse copyWith(void Function(MakeDonationResponse) updates) => super.copyWith((message) => updates(message as MakeDonationResponse)) as MakeDonationResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MakeDonationResponse create() => MakeDonationResponse._();
  MakeDonationResponse createEmptyInstance() => create();
  static $pb.PbList<MakeDonationResponse> createRepeated() => $pb.PbList<MakeDonationResponse>();
  @$core.pragma('dart2js:noInline')
  static MakeDonationResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MakeDonationResponse>(create);
  static MakeDonationResponse? _defaultInstance;

  @$pb.TagNumber(1)
  CrowdfundDonationMessage get donation => $_getN(0);
  @$pb.TagNumber(1)
  set donation(CrowdfundDonationMessage v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasDonation() => $_has(0);
  @$pb.TagNumber(1)
  void clearDonation() => clearField(1);
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
    final $result = create();
    if (crowdfundId != null) {
      $result.crowdfundId = crowdfundId;
    }
    if (page != null) {
      $result.page = page;
    }
    if (pageSize != null) {
      $result.pageSize = pageSize;
    }
    return $result;
  }
  GetCrowdfundDonationsRequest._() : super();
  factory GetCrowdfundDonationsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCrowdfundDonationsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetCrowdfundDonationsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'crowdfundId')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCrowdfundDonationsRequest clone() => GetCrowdfundDonationsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCrowdfundDonationsRequest copyWith(void Function(GetCrowdfundDonationsRequest) updates) => super.copyWith((message) => updates(message as GetCrowdfundDonationsRequest)) as GetCrowdfundDonationsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetCrowdfundDonationsRequest create() => GetCrowdfundDonationsRequest._();
  GetCrowdfundDonationsRequest createEmptyInstance() => create();
  static $pb.PbList<GetCrowdfundDonationsRequest> createRepeated() => $pb.PbList<GetCrowdfundDonationsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetCrowdfundDonationsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetCrowdfundDonationsRequest>(create);
  static GetCrowdfundDonationsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get crowdfundId => $_getSZ(0);
  @$pb.TagNumber(1)
  set crowdfundId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCrowdfundId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCrowdfundId() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get page => $_getIZ(1);
  @$pb.TagNumber(2)
  set page($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPage() => $_has(1);
  @$pb.TagNumber(2)
  void clearPage() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get pageSize => $_getIZ(2);
  @$pb.TagNumber(3)
  set pageSize($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPageSize() => $_has(2);
  @$pb.TagNumber(3)
  void clearPageSize() => clearField(3);
}

class GetCrowdfundDonationsResponse extends $pb.GeneratedMessage {
  factory GetCrowdfundDonationsResponse({
    $core.Iterable<CrowdfundDonationMessage>? donations,
    DonationPaginationInfo? pagination,
  }) {
    final $result = create();
    if (donations != null) {
      $result.donations.addAll(donations);
    }
    if (pagination != null) {
      $result.pagination = pagination;
    }
    return $result;
  }
  GetCrowdfundDonationsResponse._() : super();
  factory GetCrowdfundDonationsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCrowdfundDonationsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetCrowdfundDonationsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pc<CrowdfundDonationMessage>(1, _omitFieldNames ? '' : 'donations', $pb.PbFieldType.PM, subBuilder: CrowdfundDonationMessage.create)
    ..aOM<DonationPaginationInfo>(2, _omitFieldNames ? '' : 'pagination', subBuilder: DonationPaginationInfo.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCrowdfundDonationsResponse clone() => GetCrowdfundDonationsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCrowdfundDonationsResponse copyWith(void Function(GetCrowdfundDonationsResponse) updates) => super.copyWith((message) => updates(message as GetCrowdfundDonationsResponse)) as GetCrowdfundDonationsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetCrowdfundDonationsResponse create() => GetCrowdfundDonationsResponse._();
  GetCrowdfundDonationsResponse createEmptyInstance() => create();
  static $pb.PbList<GetCrowdfundDonationsResponse> createRepeated() => $pb.PbList<GetCrowdfundDonationsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetCrowdfundDonationsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetCrowdfundDonationsResponse>(create);
  static GetCrowdfundDonationsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<CrowdfundDonationMessage> get donations => $_getList(0);

  @$pb.TagNumber(2)
  DonationPaginationInfo get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination(DonationPaginationInfo v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => clearField(2);
  @$pb.TagNumber(2)
  DonationPaginationInfo ensurePagination() => $_ensure(1);
}

/// Get User Donations
class GetUserDonationsRequest extends $pb.GeneratedMessage {
  factory GetUserDonationsRequest({
    $core.int? page,
    $core.int? pageSize,
  }) {
    final $result = create();
    if (page != null) {
      $result.page = page;
    }
    if (pageSize != null) {
      $result.pageSize = pageSize;
    }
    return $result;
  }
  GetUserDonationsRequest._() : super();
  factory GetUserDonationsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUserDonationsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetUserDonationsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUserDonationsRequest clone() => GetUserDonationsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUserDonationsRequest copyWith(void Function(GetUserDonationsRequest) updates) => super.copyWith((message) => updates(message as GetUserDonationsRequest)) as GetUserDonationsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserDonationsRequest create() => GetUserDonationsRequest._();
  GetUserDonationsRequest createEmptyInstance() => create();
  static $pb.PbList<GetUserDonationsRequest> createRepeated() => $pb.PbList<GetUserDonationsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetUserDonationsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetUserDonationsRequest>(create);
  static GetUserDonationsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get page => $_getIZ(0);
  @$pb.TagNumber(1)
  set page($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearPage() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get pageSize => $_getIZ(1);
  @$pb.TagNumber(2)
  set pageSize($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPageSize() => $_has(1);
  @$pb.TagNumber(2)
  void clearPageSize() => clearField(2);
}

class GetUserDonationsResponse extends $pb.GeneratedMessage {
  factory GetUserDonationsResponse({
    $core.Iterable<CrowdfundDonationMessage>? donations,
    DonationPaginationInfo? pagination,
  }) {
    final $result = create();
    if (donations != null) {
      $result.donations.addAll(donations);
    }
    if (pagination != null) {
      $result.pagination = pagination;
    }
    return $result;
  }
  GetUserDonationsResponse._() : super();
  factory GetUserDonationsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUserDonationsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetUserDonationsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pc<CrowdfundDonationMessage>(1, _omitFieldNames ? '' : 'donations', $pb.PbFieldType.PM, subBuilder: CrowdfundDonationMessage.create)
    ..aOM<DonationPaginationInfo>(2, _omitFieldNames ? '' : 'pagination', subBuilder: DonationPaginationInfo.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUserDonationsResponse clone() => GetUserDonationsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUserDonationsResponse copyWith(void Function(GetUserDonationsResponse) updates) => super.copyWith((message) => updates(message as GetUserDonationsResponse)) as GetUserDonationsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserDonationsResponse create() => GetUserDonationsResponse._();
  GetUserDonationsResponse createEmptyInstance() => create();
  static $pb.PbList<GetUserDonationsResponse> createRepeated() => $pb.PbList<GetUserDonationsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetUserDonationsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetUserDonationsResponse>(create);
  static GetUserDonationsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<CrowdfundDonationMessage> get donations => $_getList(0);

  @$pb.TagNumber(2)
  DonationPaginationInfo get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination(DonationPaginationInfo v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => clearField(2);
  @$pb.TagNumber(2)
  DonationPaginationInfo ensurePagination() => $_ensure(1);
}

/// Generate Receipt
class GenerateDonationReceiptRequest extends $pb.GeneratedMessage {
  factory GenerateDonationReceiptRequest({
    $core.String? donationId,
  }) {
    final $result = create();
    if (donationId != null) {
      $result.donationId = donationId;
    }
    return $result;
  }
  GenerateDonationReceiptRequest._() : super();
  factory GenerateDonationReceiptRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GenerateDonationReceiptRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GenerateDonationReceiptRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'donationId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GenerateDonationReceiptRequest clone() => GenerateDonationReceiptRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GenerateDonationReceiptRequest copyWith(void Function(GenerateDonationReceiptRequest) updates) => super.copyWith((message) => updates(message as GenerateDonationReceiptRequest)) as GenerateDonationReceiptRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GenerateDonationReceiptRequest create() => GenerateDonationReceiptRequest._();
  GenerateDonationReceiptRequest createEmptyInstance() => create();
  static $pb.PbList<GenerateDonationReceiptRequest> createRepeated() => $pb.PbList<GenerateDonationReceiptRequest>();
  @$core.pragma('dart2js:noInline')
  static GenerateDonationReceiptRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GenerateDonationReceiptRequest>(create);
  static GenerateDonationReceiptRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get donationId => $_getSZ(0);
  @$pb.TagNumber(1)
  set donationId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDonationId() => $_has(0);
  @$pb.TagNumber(1)
  void clearDonationId() => clearField(1);
}

class GenerateDonationReceiptResponse extends $pb.GeneratedMessage {
  factory GenerateDonationReceiptResponse({
    CrowdfundReceiptMessage? receipt,
  }) {
    final $result = create();
    if (receipt != null) {
      $result.receipt = receipt;
    }
    return $result;
  }
  GenerateDonationReceiptResponse._() : super();
  factory GenerateDonationReceiptResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GenerateDonationReceiptResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GenerateDonationReceiptResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<CrowdfundReceiptMessage>(1, _omitFieldNames ? '' : 'receipt', subBuilder: CrowdfundReceiptMessage.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GenerateDonationReceiptResponse clone() => GenerateDonationReceiptResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GenerateDonationReceiptResponse copyWith(void Function(GenerateDonationReceiptResponse) updates) => super.copyWith((message) => updates(message as GenerateDonationReceiptResponse)) as GenerateDonationReceiptResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GenerateDonationReceiptResponse create() => GenerateDonationReceiptResponse._();
  GenerateDonationReceiptResponse createEmptyInstance() => create();
  static $pb.PbList<GenerateDonationReceiptResponse> createRepeated() => $pb.PbList<GenerateDonationReceiptResponse>();
  @$core.pragma('dart2js:noInline')
  static GenerateDonationReceiptResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GenerateDonationReceiptResponse>(create);
  static GenerateDonationReceiptResponse? _defaultInstance;

  @$pb.TagNumber(1)
  CrowdfundReceiptMessage get receipt => $_getN(0);
  @$pb.TagNumber(1)
  set receipt(CrowdfundReceiptMessage v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasReceipt() => $_has(0);
  @$pb.TagNumber(1)
  void clearReceipt() => clearField(1);
  @$pb.TagNumber(1)
  CrowdfundReceiptMessage ensureReceipt() => $_ensure(0);
}

/// Get User Receipts
class GetUserCrowdfundReceiptsRequest extends $pb.GeneratedMessage {
  factory GetUserCrowdfundReceiptsRequest({
    $core.int? page,
    $core.int? pageSize,
  }) {
    final $result = create();
    if (page != null) {
      $result.page = page;
    }
    if (pageSize != null) {
      $result.pageSize = pageSize;
    }
    return $result;
  }
  GetUserCrowdfundReceiptsRequest._() : super();
  factory GetUserCrowdfundReceiptsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUserCrowdfundReceiptsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetUserCrowdfundReceiptsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUserCrowdfundReceiptsRequest clone() => GetUserCrowdfundReceiptsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUserCrowdfundReceiptsRequest copyWith(void Function(GetUserCrowdfundReceiptsRequest) updates) => super.copyWith((message) => updates(message as GetUserCrowdfundReceiptsRequest)) as GetUserCrowdfundReceiptsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserCrowdfundReceiptsRequest create() => GetUserCrowdfundReceiptsRequest._();
  GetUserCrowdfundReceiptsRequest createEmptyInstance() => create();
  static $pb.PbList<GetUserCrowdfundReceiptsRequest> createRepeated() => $pb.PbList<GetUserCrowdfundReceiptsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetUserCrowdfundReceiptsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetUserCrowdfundReceiptsRequest>(create);
  static GetUserCrowdfundReceiptsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get page => $_getIZ(0);
  @$pb.TagNumber(1)
  set page($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearPage() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get pageSize => $_getIZ(1);
  @$pb.TagNumber(2)
  set pageSize($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPageSize() => $_has(1);
  @$pb.TagNumber(2)
  void clearPageSize() => clearField(2);
}

class GetUserCrowdfundReceiptsResponse extends $pb.GeneratedMessage {
  factory GetUserCrowdfundReceiptsResponse({
    $core.Iterable<CrowdfundReceiptMessage>? receipts,
    CrowdfundReceiptPaginationInfo? pagination,
  }) {
    final $result = create();
    if (receipts != null) {
      $result.receipts.addAll(receipts);
    }
    if (pagination != null) {
      $result.pagination = pagination;
    }
    return $result;
  }
  GetUserCrowdfundReceiptsResponse._() : super();
  factory GetUserCrowdfundReceiptsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUserCrowdfundReceiptsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetUserCrowdfundReceiptsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pc<CrowdfundReceiptMessage>(1, _omitFieldNames ? '' : 'receipts', $pb.PbFieldType.PM, subBuilder: CrowdfundReceiptMessage.create)
    ..aOM<CrowdfundReceiptPaginationInfo>(2, _omitFieldNames ? '' : 'pagination', subBuilder: CrowdfundReceiptPaginationInfo.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUserCrowdfundReceiptsResponse clone() => GetUserCrowdfundReceiptsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUserCrowdfundReceiptsResponse copyWith(void Function(GetUserCrowdfundReceiptsResponse) updates) => super.copyWith((message) => updates(message as GetUserCrowdfundReceiptsResponse)) as GetUserCrowdfundReceiptsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserCrowdfundReceiptsResponse create() => GetUserCrowdfundReceiptsResponse._();
  GetUserCrowdfundReceiptsResponse createEmptyInstance() => create();
  static $pb.PbList<GetUserCrowdfundReceiptsResponse> createRepeated() => $pb.PbList<GetUserCrowdfundReceiptsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetUserCrowdfundReceiptsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetUserCrowdfundReceiptsResponse>(create);
  static GetUserCrowdfundReceiptsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<CrowdfundReceiptMessage> get receipts => $_getList(0);

  @$pb.TagNumber(2)
  CrowdfundReceiptPaginationInfo get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination(CrowdfundReceiptPaginationInfo v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => clearField(2);
  @$pb.TagNumber(2)
  CrowdfundReceiptPaginationInfo ensurePagination() => $_ensure(1);
}

/// Get Crowdfund Statistics
class GetCrowdfundStatisticsRequest extends $pb.GeneratedMessage {
  factory GetCrowdfundStatisticsRequest({
    $core.String? crowdfundId,
  }) {
    final $result = create();
    if (crowdfundId != null) {
      $result.crowdfundId = crowdfundId;
    }
    return $result;
  }
  GetCrowdfundStatisticsRequest._() : super();
  factory GetCrowdfundStatisticsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCrowdfundStatisticsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetCrowdfundStatisticsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'crowdfundId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCrowdfundStatisticsRequest clone() => GetCrowdfundStatisticsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCrowdfundStatisticsRequest copyWith(void Function(GetCrowdfundStatisticsRequest) updates) => super.copyWith((message) => updates(message as GetCrowdfundStatisticsRequest)) as GetCrowdfundStatisticsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetCrowdfundStatisticsRequest create() => GetCrowdfundStatisticsRequest._();
  GetCrowdfundStatisticsRequest createEmptyInstance() => create();
  static $pb.PbList<GetCrowdfundStatisticsRequest> createRepeated() => $pb.PbList<GetCrowdfundStatisticsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetCrowdfundStatisticsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetCrowdfundStatisticsRequest>(create);
  static GetCrowdfundStatisticsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get crowdfundId => $_getSZ(0);
  @$pb.TagNumber(1)
  set crowdfundId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCrowdfundId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCrowdfundId() => clearField(1);
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
    final $result = create();
    if (crowdfundId != null) {
      $result.crowdfundId = crowdfundId;
    }
    if (totalRaised != null) {
      $result.totalRaised = totalRaised;
    }
    if (targetAmount != null) {
      $result.targetAmount = targetAmount;
    }
    if (progressPercentage != null) {
      $result.progressPercentage = progressPercentage;
    }
    if (donorCount != null) {
      $result.donorCount = donorCount;
    }
    if (averageDonation != null) {
      $result.averageDonation = averageDonation;
    }
    if (largestDonation != null) {
      $result.largestDonation = largestDonation;
    }
    if (daysRemaining != null) {
      $result.daysRemaining = daysRemaining;
    }
    if (isCompleted != null) {
      $result.isCompleted = isCompleted;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    if (uniqueDonors != null) {
      $result.uniqueDonors = uniqueDonors;
    }
    if (smallestDonation != null) {
      $result.smallestDonation = smallestDonation;
    }
    if (topContributors != null) {
      $result.topContributors.addAll(topContributors);
    }
    if (dailyProgress != null) {
      $result.dailyProgress.addAll(dailyProgress);
    }
    if (fundingVelocity != null) {
      $result.fundingVelocity = fundingVelocity;
    }
    if (projectedCompletionDate != null) {
      $result.projectedCompletionDate = projectedCompletionDate;
    }
    return $result;
  }
  GetCrowdfundStatisticsResponse._() : super();
  factory GetCrowdfundStatisticsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCrowdfundStatisticsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetCrowdfundStatisticsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'crowdfundId')
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'totalRaised', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'targetAmount', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'progressPercentage', $pb.PbFieldType.OD)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'donorCount', $pb.PbFieldType.O3)
    ..a<$fixnum.Int64>(6, _omitFieldNames ? '' : 'averageDonation', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(7, _omitFieldNames ? '' : 'largestDonation', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(8, _omitFieldNames ? '' : 'daysRemaining', $pb.PbFieldType.O3)
    ..aOB(9, _omitFieldNames ? '' : 'isCompleted')
    ..aOM<$1.Timestamp>(10, _omitFieldNames ? '' : 'createdAt', subBuilder: $1.Timestamp.create)
    ..a<$core.int>(11, _omitFieldNames ? '' : 'uniqueDonors', $pb.PbFieldType.O3)
    ..a<$fixnum.Int64>(12, _omitFieldNames ? '' : 'smallestDonation', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..pc<ContributorLeaderboardEntry>(13, _omitFieldNames ? '' : 'topContributors', $pb.PbFieldType.PM, subBuilder: ContributorLeaderboardEntry.create)
    ..pc<DailyProgressEntry>(14, _omitFieldNames ? '' : 'dailyProgress', $pb.PbFieldType.PM, subBuilder: DailyProgressEntry.create)
    ..a<$core.double>(15, _omitFieldNames ? '' : 'fundingVelocity', $pb.PbFieldType.OD)
    ..aOS(16, _omitFieldNames ? '' : 'projectedCompletionDate')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCrowdfundStatisticsResponse clone() => GetCrowdfundStatisticsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCrowdfundStatisticsResponse copyWith(void Function(GetCrowdfundStatisticsResponse) updates) => super.copyWith((message) => updates(message as GetCrowdfundStatisticsResponse)) as GetCrowdfundStatisticsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetCrowdfundStatisticsResponse create() => GetCrowdfundStatisticsResponse._();
  GetCrowdfundStatisticsResponse createEmptyInstance() => create();
  static $pb.PbList<GetCrowdfundStatisticsResponse> createRepeated() => $pb.PbList<GetCrowdfundStatisticsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetCrowdfundStatisticsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetCrowdfundStatisticsResponse>(create);
  static GetCrowdfundStatisticsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get crowdfundId => $_getSZ(0);
  @$pb.TagNumber(1)
  set crowdfundId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCrowdfundId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCrowdfundId() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get totalRaised => $_getI64(1);
  @$pb.TagNumber(2)
  set totalRaised($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotalRaised() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalRaised() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get targetAmount => $_getI64(2);
  @$pb.TagNumber(3)
  set targetAmount($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTargetAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearTargetAmount() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get progressPercentage => $_getN(3);
  @$pb.TagNumber(4)
  set progressPercentage($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasProgressPercentage() => $_has(3);
  @$pb.TagNumber(4)
  void clearProgressPercentage() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get donorCount => $_getIZ(4);
  @$pb.TagNumber(5)
  set donorCount($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasDonorCount() => $_has(4);
  @$pb.TagNumber(5)
  void clearDonorCount() => clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get averageDonation => $_getI64(5);
  @$pb.TagNumber(6)
  set averageDonation($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasAverageDonation() => $_has(5);
  @$pb.TagNumber(6)
  void clearAverageDonation() => clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get largestDonation => $_getI64(6);
  @$pb.TagNumber(7)
  set largestDonation($fixnum.Int64 v) { $_setInt64(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasLargestDonation() => $_has(6);
  @$pb.TagNumber(7)
  void clearLargestDonation() => clearField(7);

  @$pb.TagNumber(8)
  $core.int get daysRemaining => $_getIZ(7);
  @$pb.TagNumber(8)
  set daysRemaining($core.int v) { $_setSignedInt32(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasDaysRemaining() => $_has(7);
  @$pb.TagNumber(8)
  void clearDaysRemaining() => clearField(8);

  @$pb.TagNumber(9)
  $core.bool get isCompleted => $_getBF(8);
  @$pb.TagNumber(9)
  set isCompleted($core.bool v) { $_setBool(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasIsCompleted() => $_has(8);
  @$pb.TagNumber(9)
  void clearIsCompleted() => clearField(9);

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

  /// Enhanced statistics fields
  @$pb.TagNumber(11)
  $core.int get uniqueDonors => $_getIZ(10);
  @$pb.TagNumber(11)
  set uniqueDonors($core.int v) { $_setSignedInt32(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasUniqueDonors() => $_has(10);
  @$pb.TagNumber(11)
  void clearUniqueDonors() => clearField(11);

  @$pb.TagNumber(12)
  $fixnum.Int64 get smallestDonation => $_getI64(11);
  @$pb.TagNumber(12)
  set smallestDonation($fixnum.Int64 v) { $_setInt64(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasSmallestDonation() => $_has(11);
  @$pb.TagNumber(12)
  void clearSmallestDonation() => clearField(12);

  @$pb.TagNumber(13)
  $core.List<ContributorLeaderboardEntry> get topContributors => $_getList(12);

  @$pb.TagNumber(14)
  $core.List<DailyProgressEntry> get dailyProgress => $_getList(13);

  @$pb.TagNumber(15)
  $core.double get fundingVelocity => $_getN(14);
  @$pb.TagNumber(15)
  set fundingVelocity($core.double v) { $_setDouble(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasFundingVelocity() => $_has(14);
  @$pb.TagNumber(15)
  void clearFundingVelocity() => clearField(15);

  @$pb.TagNumber(16)
  $core.String get projectedCompletionDate => $_getSZ(15);
  @$pb.TagNumber(16)
  set projectedCompletionDate($core.String v) { $_setString(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasProjectedCompletionDate() => $_has(15);
  @$pb.TagNumber(16)
  void clearProjectedCompletionDate() => clearField(16);
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
    final $result = create();
    if (rank != null) {
      $result.rank = rank;
    }
    if (displayName != null) {
      $result.displayName = displayName;
    }
    if (totalAmount != null) {
      $result.totalAmount = totalAmount;
    }
    if (contributionCount != null) {
      $result.contributionCount = contributionCount;
    }
    if (isAnonymous != null) {
      $result.isAnonymous = isAnonymous;
    }
    return $result;
  }
  ContributorLeaderboardEntry._() : super();
  factory ContributorLeaderboardEntry.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ContributorLeaderboardEntry.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ContributorLeaderboardEntry', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'rank', $pb.PbFieldType.O3)
    ..aOS(2, _omitFieldNames ? '' : 'displayName')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'totalAmount', $pb.PbFieldType.OD)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'contributionCount', $pb.PbFieldType.O3)
    ..aOB(5, _omitFieldNames ? '' : 'isAnonymous')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ContributorLeaderboardEntry clone() => ContributorLeaderboardEntry()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ContributorLeaderboardEntry copyWith(void Function(ContributorLeaderboardEntry) updates) => super.copyWith((message) => updates(message as ContributorLeaderboardEntry)) as ContributorLeaderboardEntry;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ContributorLeaderboardEntry create() => ContributorLeaderboardEntry._();
  ContributorLeaderboardEntry createEmptyInstance() => create();
  static $pb.PbList<ContributorLeaderboardEntry> createRepeated() => $pb.PbList<ContributorLeaderboardEntry>();
  @$core.pragma('dart2js:noInline')
  static ContributorLeaderboardEntry getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ContributorLeaderboardEntry>(create);
  static ContributorLeaderboardEntry? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get rank => $_getIZ(0);
  @$pb.TagNumber(1)
  set rank($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRank() => $_has(0);
  @$pb.TagNumber(1)
  void clearRank() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get displayName => $_getSZ(1);
  @$pb.TagNumber(2)
  set displayName($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasDisplayName() => $_has(1);
  @$pb.TagNumber(2)
  void clearDisplayName() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get totalAmount => $_getN(2);
  @$pb.TagNumber(3)
  set totalAmount($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTotalAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalAmount() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get contributionCount => $_getIZ(3);
  @$pb.TagNumber(4)
  set contributionCount($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasContributionCount() => $_has(3);
  @$pb.TagNumber(4)
  void clearContributionCount() => clearField(4);

  @$pb.TagNumber(5)
  $core.bool get isAnonymous => $_getBF(4);
  @$pb.TagNumber(5)
  set isAnonymous($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasIsAnonymous() => $_has(4);
  @$pb.TagNumber(5)
  void clearIsAnonymous() => clearField(5);
}

/// Daily progress tracking
class DailyProgressEntry extends $pb.GeneratedMessage {
  factory DailyProgressEntry({
    $core.String? date,
    $core.double? amount,
    $core.int? donationCount,
    $core.double? cumulativeAmount,
  }) {
    final $result = create();
    if (date != null) {
      $result.date = date;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (donationCount != null) {
      $result.donationCount = donationCount;
    }
    if (cumulativeAmount != null) {
      $result.cumulativeAmount = cumulativeAmount;
    }
    return $result;
  }
  DailyProgressEntry._() : super();
  factory DailyProgressEntry.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DailyProgressEntry.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DailyProgressEntry', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'date')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'donationCount', $pb.PbFieldType.O3)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'cumulativeAmount', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DailyProgressEntry clone() => DailyProgressEntry()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DailyProgressEntry copyWith(void Function(DailyProgressEntry) updates) => super.copyWith((message) => updates(message as DailyProgressEntry)) as DailyProgressEntry;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DailyProgressEntry create() => DailyProgressEntry._();
  DailyProgressEntry createEmptyInstance() => create();
  static $pb.PbList<DailyProgressEntry> createRepeated() => $pb.PbList<DailyProgressEntry>();
  @$core.pragma('dart2js:noInline')
  static DailyProgressEntry getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DailyProgressEntry>(create);
  static DailyProgressEntry? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get date => $_getSZ(0);
  @$pb.TagNumber(1)
  set date($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDate() => $_has(0);
  @$pb.TagNumber(1)
  void clearDate() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get amount => $_getN(1);
  @$pb.TagNumber(2)
  set amount($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get donationCount => $_getIZ(2);
  @$pb.TagNumber(3)
  set donationCount($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDonationCount() => $_has(2);
  @$pb.TagNumber(3)
  void clearDonationCount() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get cumulativeAmount => $_getN(3);
  @$pb.TagNumber(4)
  set cumulativeAmount($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCumulativeAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearCumulativeAmount() => clearField(4);
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
    final $result = create();
    if (crowdfundId != null) {
      $result.crowdfundId = crowdfundId;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (transactionPin != null) {
      $result.transactionPin = transactionPin;
    }
    if (destinationAccountId != null) {
      $result.destinationAccountId = destinationAccountId;
    }
    if (destinationAccountType != null) {
      $result.destinationAccountType = destinationAccountType;
    }
    return $result;
  }
  WithdrawFromCrowdfundRequest._() : super();
  factory WithdrawFromCrowdfundRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WithdrawFromCrowdfundRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'WithdrawFromCrowdfundRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'crowdfundId')
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(3, _omitFieldNames ? '' : 'transactionPin')
    ..aOS(4, _omitFieldNames ? '' : 'destinationAccountId')
    ..aOS(5, _omitFieldNames ? '' : 'destinationAccountType')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  WithdrawFromCrowdfundRequest clone() => WithdrawFromCrowdfundRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  WithdrawFromCrowdfundRequest copyWith(void Function(WithdrawFromCrowdfundRequest) updates) => super.copyWith((message) => updates(message as WithdrawFromCrowdfundRequest)) as WithdrawFromCrowdfundRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WithdrawFromCrowdfundRequest create() => WithdrawFromCrowdfundRequest._();
  WithdrawFromCrowdfundRequest createEmptyInstance() => create();
  static $pb.PbList<WithdrawFromCrowdfundRequest> createRepeated() => $pb.PbList<WithdrawFromCrowdfundRequest>();
  @$core.pragma('dart2js:noInline')
  static WithdrawFromCrowdfundRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WithdrawFromCrowdfundRequest>(create);
  static WithdrawFromCrowdfundRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get crowdfundId => $_getSZ(0);
  @$pb.TagNumber(1)
  set crowdfundId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCrowdfundId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCrowdfundId() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get amount => $_getI64(1);
  @$pb.TagNumber(2)
  set amount($fixnum.Int64 v) { $_setInt64(1, v); }
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

  /// Destination account for withdrawal - one of the following:
  /// If destination_account_id is set, funds go to that specific account
  /// If destination_account_type is set, funds go to user's account of that type
  /// If neither is set, funds go to user's primary account
  @$pb.TagNumber(4)
  $core.String get destinationAccountId => $_getSZ(3);
  @$pb.TagNumber(4)
  set destinationAccountId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasDestinationAccountId() => $_has(3);
  @$pb.TagNumber(4)
  void clearDestinationAccountId() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get destinationAccountType => $_getSZ(4);
  @$pb.TagNumber(5)
  set destinationAccountType($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasDestinationAccountType() => $_has(4);
  @$pb.TagNumber(5)
  void clearDestinationAccountType() => clearField(5);
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
    final $result = create();
    if (crowdfundId != null) {
      $result.crowdfundId = crowdfundId;
    }
    if (amountWithdrawn != null) {
      $result.amountWithdrawn = amountWithdrawn;
    }
    if (remainingBalance != null) {
      $result.remainingBalance = remainingBalance;
    }
    if (destinationAccountId != null) {
      $result.destinationAccountId = destinationAccountId;
    }
    if (destinationNewBalance != null) {
      $result.destinationNewBalance = destinationNewBalance;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  WithdrawFromCrowdfundResponse._() : super();
  factory WithdrawFromCrowdfundResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WithdrawFromCrowdfundResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'WithdrawFromCrowdfundResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'crowdfundId')
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'amountWithdrawn', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'remainingBalance', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(4, _omitFieldNames ? '' : 'destinationAccountId')
    ..a<$fixnum.Int64>(5, _omitFieldNames ? '' : 'destinationNewBalance', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(6, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  WithdrawFromCrowdfundResponse clone() => WithdrawFromCrowdfundResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  WithdrawFromCrowdfundResponse copyWith(void Function(WithdrawFromCrowdfundResponse) updates) => super.copyWith((message) => updates(message as WithdrawFromCrowdfundResponse)) as WithdrawFromCrowdfundResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WithdrawFromCrowdfundResponse create() => WithdrawFromCrowdfundResponse._();
  WithdrawFromCrowdfundResponse createEmptyInstance() => create();
  static $pb.PbList<WithdrawFromCrowdfundResponse> createRepeated() => $pb.PbList<WithdrawFromCrowdfundResponse>();
  @$core.pragma('dart2js:noInline')
  static WithdrawFromCrowdfundResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WithdrawFromCrowdfundResponse>(create);
  static WithdrawFromCrowdfundResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get crowdfundId => $_getSZ(0);
  @$pb.TagNumber(1)
  set crowdfundId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCrowdfundId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCrowdfundId() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get amountWithdrawn => $_getI64(1);
  @$pb.TagNumber(2)
  set amountWithdrawn($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAmountWithdrawn() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmountWithdrawn() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get remainingBalance => $_getI64(2);
  @$pb.TagNumber(3)
  set remainingBalance($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasRemainingBalance() => $_has(2);
  @$pb.TagNumber(3)
  void clearRemainingBalance() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get destinationAccountId => $_getSZ(3);
  @$pb.TagNumber(4)
  set destinationAccountId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasDestinationAccountId() => $_has(3);
  @$pb.TagNumber(4)
  void clearDestinationAccountId() => clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get destinationNewBalance => $_getI64(4);
  @$pb.TagNumber(5)
  set destinationNewBalance($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasDestinationNewBalance() => $_has(4);
  @$pb.TagNumber(5)
  void clearDestinationNewBalance() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get message => $_getSZ(5);
  @$pb.TagNumber(6)
  set message($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasMessage() => $_has(5);
  @$pb.TagNumber(6)
  void clearMessage() => clearField(6);
}

/// Get My Crowdfunds (Creator's campaigns)
class GetMyCrowdfundsRequest extends $pb.GeneratedMessage {
  factory GetMyCrowdfundsRequest({
    $core.int? page,
    $core.int? pageSize,
    $core.String? status,
  }) {
    final $result = create();
    if (page != null) {
      $result.page = page;
    }
    if (pageSize != null) {
      $result.pageSize = pageSize;
    }
    if (status != null) {
      $result.status = status;
    }
    return $result;
  }
  GetMyCrowdfundsRequest._() : super();
  factory GetMyCrowdfundsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMyCrowdfundsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetMyCrowdfundsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOS(3, _omitFieldNames ? '' : 'status')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMyCrowdfundsRequest clone() => GetMyCrowdfundsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMyCrowdfundsRequest copyWith(void Function(GetMyCrowdfundsRequest) updates) => super.copyWith((message) => updates(message as GetMyCrowdfundsRequest)) as GetMyCrowdfundsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMyCrowdfundsRequest create() => GetMyCrowdfundsRequest._();
  GetMyCrowdfundsRequest createEmptyInstance() => create();
  static $pb.PbList<GetMyCrowdfundsRequest> createRepeated() => $pb.PbList<GetMyCrowdfundsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMyCrowdfundsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMyCrowdfundsRequest>(create);
  static GetMyCrowdfundsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get page => $_getIZ(0);
  @$pb.TagNumber(1)
  set page($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearPage() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get pageSize => $_getIZ(1);
  @$pb.TagNumber(2)
  set pageSize($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPageSize() => $_has(1);
  @$pb.TagNumber(2)
  void clearPageSize() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get status => $_getSZ(2);
  @$pb.TagNumber(3)
  set status($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasStatus() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatus() => clearField(3);
}

class GetMyCrowdfundsResponse extends $pb.GeneratedMessage {
  factory GetMyCrowdfundsResponse({
    $core.Iterable<CrowdfundMessage>? crowdfunds,
    CrowdfundPaginationInfo? pagination,
  }) {
    final $result = create();
    if (crowdfunds != null) {
      $result.crowdfunds.addAll(crowdfunds);
    }
    if (pagination != null) {
      $result.pagination = pagination;
    }
    return $result;
  }
  GetMyCrowdfundsResponse._() : super();
  factory GetMyCrowdfundsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMyCrowdfundsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetMyCrowdfundsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pc<CrowdfundMessage>(1, _omitFieldNames ? '' : 'crowdfunds', $pb.PbFieldType.PM, subBuilder: CrowdfundMessage.create)
    ..aOM<CrowdfundPaginationInfo>(2, _omitFieldNames ? '' : 'pagination', subBuilder: CrowdfundPaginationInfo.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMyCrowdfundsResponse clone() => GetMyCrowdfundsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMyCrowdfundsResponse copyWith(void Function(GetMyCrowdfundsResponse) updates) => super.copyWith((message) => updates(message as GetMyCrowdfundsResponse)) as GetMyCrowdfundsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMyCrowdfundsResponse create() => GetMyCrowdfundsResponse._();
  GetMyCrowdfundsResponse createEmptyInstance() => create();
  static $pb.PbList<GetMyCrowdfundsResponse> createRepeated() => $pb.PbList<GetMyCrowdfundsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMyCrowdfundsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMyCrowdfundsResponse>(create);
  static GetMyCrowdfundsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<CrowdfundMessage> get crowdfunds => $_getList(0);

  @$pb.TagNumber(2)
  CrowdfundPaginationInfo get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination(CrowdfundPaginationInfo v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => clearField(2);
  @$pb.TagNumber(2)
  CrowdfundPaginationInfo ensurePagination() => $_ensure(1);
}

/// Get Campaign Wallet Balance
class GetCampaignWalletBalanceRequest extends $pb.GeneratedMessage {
  factory GetCampaignWalletBalanceRequest({
    $core.String? crowdfundId,
  }) {
    final $result = create();
    if (crowdfundId != null) {
      $result.crowdfundId = crowdfundId;
    }
    return $result;
  }
  GetCampaignWalletBalanceRequest._() : super();
  factory GetCampaignWalletBalanceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCampaignWalletBalanceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetCampaignWalletBalanceRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'crowdfundId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCampaignWalletBalanceRequest clone() => GetCampaignWalletBalanceRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCampaignWalletBalanceRequest copyWith(void Function(GetCampaignWalletBalanceRequest) updates) => super.copyWith((message) => updates(message as GetCampaignWalletBalanceRequest)) as GetCampaignWalletBalanceRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetCampaignWalletBalanceRequest create() => GetCampaignWalletBalanceRequest._();
  GetCampaignWalletBalanceRequest createEmptyInstance() => create();
  static $pb.PbList<GetCampaignWalletBalanceRequest> createRepeated() => $pb.PbList<GetCampaignWalletBalanceRequest>();
  @$core.pragma('dart2js:noInline')
  static GetCampaignWalletBalanceRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetCampaignWalletBalanceRequest>(create);
  static GetCampaignWalletBalanceRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get crowdfundId => $_getSZ(0);
  @$pb.TagNumber(1)
  set crowdfundId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCrowdfundId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCrowdfundId() => clearField(1);
}

class GetCampaignWalletBalanceResponse extends $pb.GeneratedMessage {
  factory GetCampaignWalletBalanceResponse({
    $core.String? crowdfundId,
    $core.String? campaignWalletId,
    $fixnum.Int64? balance,
    $fixnum.Int64? availableBalance,
    $core.String? currency,
  }) {
    final $result = create();
    if (crowdfundId != null) {
      $result.crowdfundId = crowdfundId;
    }
    if (campaignWalletId != null) {
      $result.campaignWalletId = campaignWalletId;
    }
    if (balance != null) {
      $result.balance = balance;
    }
    if (availableBalance != null) {
      $result.availableBalance = availableBalance;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    return $result;
  }
  GetCampaignWalletBalanceResponse._() : super();
  factory GetCampaignWalletBalanceResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCampaignWalletBalanceResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetCampaignWalletBalanceResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'crowdfundId')
    ..aOS(2, _omitFieldNames ? '' : 'campaignWalletId')
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'balance', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(4, _omitFieldNames ? '' : 'availableBalance', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(5, _omitFieldNames ? '' : 'currency')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCampaignWalletBalanceResponse clone() => GetCampaignWalletBalanceResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCampaignWalletBalanceResponse copyWith(void Function(GetCampaignWalletBalanceResponse) updates) => super.copyWith((message) => updates(message as GetCampaignWalletBalanceResponse)) as GetCampaignWalletBalanceResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetCampaignWalletBalanceResponse create() => GetCampaignWalletBalanceResponse._();
  GetCampaignWalletBalanceResponse createEmptyInstance() => create();
  static $pb.PbList<GetCampaignWalletBalanceResponse> createRepeated() => $pb.PbList<GetCampaignWalletBalanceResponse>();
  @$core.pragma('dart2js:noInline')
  static GetCampaignWalletBalanceResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetCampaignWalletBalanceResponse>(create);
  static GetCampaignWalletBalanceResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get crowdfundId => $_getSZ(0);
  @$pb.TagNumber(1)
  set crowdfundId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCrowdfundId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCrowdfundId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get campaignWalletId => $_getSZ(1);
  @$pb.TagNumber(2)
  set campaignWalletId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCampaignWalletId() => $_has(1);
  @$pb.TagNumber(2)
  void clearCampaignWalletId() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get balance => $_getI64(2);
  @$pb.TagNumber(3)
  set balance($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasBalance() => $_has(2);
  @$pb.TagNumber(3)
  void clearBalance() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get availableBalance => $_getI64(3);
  @$pb.TagNumber(4)
  set availableBalance($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasAvailableBalance() => $_has(3);
  @$pb.TagNumber(4)
  void clearAvailableBalance() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get currency => $_getSZ(4);
  @$pb.TagNumber(5)
  set currency($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasCurrency() => $_has(4);
  @$pb.TagNumber(5)
  void clearCurrency() => clearField(5);
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
    final $result = create();
    if (currentPage != null) {
      $result.currentPage = currentPage;
    }
    if (totalPages != null) {
      $result.totalPages = totalPages;
    }
    if (totalItems != null) {
      $result.totalItems = totalItems;
    }
    if (itemsPerPage != null) {
      $result.itemsPerPage = itemsPerPage;
    }
    if (hasNext != null) {
      $result.hasNext = hasNext;
    }
    if (hasPrev != null) {
      $result.hasPrev = hasPrev;
    }
    return $result;
  }
  CrowdfundPaginationInfo._() : super();
  factory CrowdfundPaginationInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CrowdfundPaginationInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CrowdfundPaginationInfo', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'currentPage', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'totalPages', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'totalItems', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'itemsPerPage', $pb.PbFieldType.O3)
    ..aOB(5, _omitFieldNames ? '' : 'hasNext')
    ..aOB(6, _omitFieldNames ? '' : 'hasPrev')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CrowdfundPaginationInfo clone() => CrowdfundPaginationInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CrowdfundPaginationInfo copyWith(void Function(CrowdfundPaginationInfo) updates) => super.copyWith((message) => updates(message as CrowdfundPaginationInfo)) as CrowdfundPaginationInfo;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CrowdfundPaginationInfo create() => CrowdfundPaginationInfo._();
  CrowdfundPaginationInfo createEmptyInstance() => create();
  static $pb.PbList<CrowdfundPaginationInfo> createRepeated() => $pb.PbList<CrowdfundPaginationInfo>();
  @$core.pragma('dart2js:noInline')
  static CrowdfundPaginationInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CrowdfundPaginationInfo>(create);
  static CrowdfundPaginationInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get currentPage => $_getIZ(0);
  @$pb.TagNumber(1)
  set currentPage($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCurrentPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearCurrentPage() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get totalPages => $_getIZ(1);
  @$pb.TagNumber(2)
  set totalPages($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotalPages() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalPages() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get totalItems => $_getIZ(2);
  @$pb.TagNumber(3)
  set totalItems($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTotalItems() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalItems() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get itemsPerPage => $_getIZ(3);
  @$pb.TagNumber(4)
  set itemsPerPage($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasItemsPerPage() => $_has(3);
  @$pb.TagNumber(4)
  void clearItemsPerPage() => clearField(4);

  @$pb.TagNumber(5)
  $core.bool get hasNext => $_getBF(4);
  @$pb.TagNumber(5)
  set hasNext($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasHasNext() => $_has(4);
  @$pb.TagNumber(5)
  void clearHasNext() => clearField(5);

  @$pb.TagNumber(6)
  $core.bool get hasPrev => $_getBF(5);
  @$pb.TagNumber(6)
  set hasPrev($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasHasPrev() => $_has(5);
  @$pb.TagNumber(6)
  void clearHasPrev() => clearField(6);
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
    final $result = create();
    if (currentPage != null) {
      $result.currentPage = currentPage;
    }
    if (totalPages != null) {
      $result.totalPages = totalPages;
    }
    if (totalItems != null) {
      $result.totalItems = totalItems;
    }
    if (itemsPerPage != null) {
      $result.itemsPerPage = itemsPerPage;
    }
    if (hasNext != null) {
      $result.hasNext = hasNext;
    }
    if (hasPrev != null) {
      $result.hasPrev = hasPrev;
    }
    return $result;
  }
  DonationPaginationInfo._() : super();
  factory DonationPaginationInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DonationPaginationInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DonationPaginationInfo', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'currentPage', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'totalPages', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'totalItems', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'itemsPerPage', $pb.PbFieldType.O3)
    ..aOB(5, _omitFieldNames ? '' : 'hasNext')
    ..aOB(6, _omitFieldNames ? '' : 'hasPrev')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DonationPaginationInfo clone() => DonationPaginationInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DonationPaginationInfo copyWith(void Function(DonationPaginationInfo) updates) => super.copyWith((message) => updates(message as DonationPaginationInfo)) as DonationPaginationInfo;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DonationPaginationInfo create() => DonationPaginationInfo._();
  DonationPaginationInfo createEmptyInstance() => create();
  static $pb.PbList<DonationPaginationInfo> createRepeated() => $pb.PbList<DonationPaginationInfo>();
  @$core.pragma('dart2js:noInline')
  static DonationPaginationInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DonationPaginationInfo>(create);
  static DonationPaginationInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get currentPage => $_getIZ(0);
  @$pb.TagNumber(1)
  set currentPage($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCurrentPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearCurrentPage() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get totalPages => $_getIZ(1);
  @$pb.TagNumber(2)
  set totalPages($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotalPages() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalPages() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get totalItems => $_getIZ(2);
  @$pb.TagNumber(3)
  set totalItems($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTotalItems() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalItems() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get itemsPerPage => $_getIZ(3);
  @$pb.TagNumber(4)
  set itemsPerPage($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasItemsPerPage() => $_has(3);
  @$pb.TagNumber(4)
  void clearItemsPerPage() => clearField(4);

  @$pb.TagNumber(5)
  $core.bool get hasNext => $_getBF(4);
  @$pb.TagNumber(5)
  set hasNext($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasHasNext() => $_has(4);
  @$pb.TagNumber(5)
  void clearHasNext() => clearField(5);

  @$pb.TagNumber(6)
  $core.bool get hasPrev => $_getBF(5);
  @$pb.TagNumber(6)
  set hasPrev($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasHasPrev() => $_has(5);
  @$pb.TagNumber(6)
  void clearHasPrev() => clearField(6);
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
    final $result = create();
    if (currentPage != null) {
      $result.currentPage = currentPage;
    }
    if (totalPages != null) {
      $result.totalPages = totalPages;
    }
    if (totalItems != null) {
      $result.totalItems = totalItems;
    }
    if (itemsPerPage != null) {
      $result.itemsPerPage = itemsPerPage;
    }
    if (hasNext != null) {
      $result.hasNext = hasNext;
    }
    if (hasPrev != null) {
      $result.hasPrev = hasPrev;
    }
    return $result;
  }
  CrowdfundReceiptPaginationInfo._() : super();
  factory CrowdfundReceiptPaginationInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CrowdfundReceiptPaginationInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CrowdfundReceiptPaginationInfo', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'currentPage', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'totalPages', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'totalItems', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'itemsPerPage', $pb.PbFieldType.O3)
    ..aOB(5, _omitFieldNames ? '' : 'hasNext')
    ..aOB(6, _omitFieldNames ? '' : 'hasPrev')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CrowdfundReceiptPaginationInfo clone() => CrowdfundReceiptPaginationInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CrowdfundReceiptPaginationInfo copyWith(void Function(CrowdfundReceiptPaginationInfo) updates) => super.copyWith((message) => updates(message as CrowdfundReceiptPaginationInfo)) as CrowdfundReceiptPaginationInfo;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CrowdfundReceiptPaginationInfo create() => CrowdfundReceiptPaginationInfo._();
  CrowdfundReceiptPaginationInfo createEmptyInstance() => create();
  static $pb.PbList<CrowdfundReceiptPaginationInfo> createRepeated() => $pb.PbList<CrowdfundReceiptPaginationInfo>();
  @$core.pragma('dart2js:noInline')
  static CrowdfundReceiptPaginationInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CrowdfundReceiptPaginationInfo>(create);
  static CrowdfundReceiptPaginationInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get currentPage => $_getIZ(0);
  @$pb.TagNumber(1)
  set currentPage($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCurrentPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearCurrentPage() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get totalPages => $_getIZ(1);
  @$pb.TagNumber(2)
  set totalPages($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotalPages() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalPages() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get totalItems => $_getIZ(2);
  @$pb.TagNumber(3)
  set totalItems($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTotalItems() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalItems() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get itemsPerPage => $_getIZ(3);
  @$pb.TagNumber(4)
  set itemsPerPage($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasItemsPerPage() => $_has(3);
  @$pb.TagNumber(4)
  void clearItemsPerPage() => clearField(4);

  @$pb.TagNumber(5)
  $core.bool get hasNext => $_getBF(4);
  @$pb.TagNumber(5)
  set hasNext($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasHasNext() => $_has(4);
  @$pb.TagNumber(5)
  void clearHasNext() => clearField(5);

  @$pb.TagNumber(6)
  $core.bool get hasPrev => $_getBF(5);
  @$pb.TagNumber(6)
  set hasPrev($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasHasPrev() => $_has(5);
  @$pb.TagNumber(6)
  void clearHasPrev() => clearField(6);
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
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (crowdfundId != null) {
      $result.crowdfundId = crowdfundId;
    }
    if (creatorUserId != null) {
      $result.creatorUserId = creatorUserId;
    }
    if (channelType != null) {
      $result.channelType = channelType;
    }
    if (status != null) {
      $result.status = status;
    }
    if (channelName != null) {
      $result.channelName = channelName;
    }
    if (channelUsername != null) {
      $result.channelUsername = channelUsername;
    }
    if (enabledEvents != null) {
      $result.enabledEvents.addAll(enabledEvents);
    }
    if (preferences != null) {
      $result.preferences = preferences;
    }
    if (lastNotificationAt != null) {
      $result.lastNotificationAt = lastNotificationAt;
    }
    if (notificationCount != null) {
      $result.notificationCount = notificationCount;
    }
    if (failureCount != null) {
      $result.failureCount = failureCount;
    }
    if (lastError != null) {
      $result.lastError = lastError;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      $result.updatedAt = updatedAt;
    }
    return $result;
  }
  NotificationChannelMessage._() : super();
  factory NotificationChannelMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NotificationChannelMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'NotificationChannelMessage', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'crowdfundId')
    ..aOS(3, _omitFieldNames ? '' : 'creatorUserId')
    ..e<NotificationChannelType>(4, _omitFieldNames ? '' : 'channelType', $pb.PbFieldType.OE, defaultOrMaker: NotificationChannelType.NOTIFICATION_CHANNEL_TYPE_UNSPECIFIED, valueOf: NotificationChannelType.valueOf, enumValues: NotificationChannelType.values)
    ..e<NotificationChannelStatus>(5, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: NotificationChannelStatus.NOTIFICATION_CHANNEL_STATUS_UNSPECIFIED, valueOf: NotificationChannelStatus.valueOf, enumValues: NotificationChannelStatus.values)
    ..aOS(6, _omitFieldNames ? '' : 'channelName')
    ..aOS(7, _omitFieldNames ? '' : 'channelUsername')
    ..pc<NotificationEventType>(8, _omitFieldNames ? '' : 'enabledEvents', $pb.PbFieldType.KE, valueOf: NotificationEventType.valueOf, enumValues: NotificationEventType.values, defaultEnumValue: NotificationEventType.NOTIFICATION_EVENT_TYPE_UNSPECIFIED)
    ..aOM<NotificationPreferencesMessage>(9, _omitFieldNames ? '' : 'preferences', subBuilder: NotificationPreferencesMessage.create)
    ..aOS(10, _omitFieldNames ? '' : 'lastNotificationAt')
    ..a<$core.int>(11, _omitFieldNames ? '' : 'notificationCount', $pb.PbFieldType.O3)
    ..a<$core.int>(12, _omitFieldNames ? '' : 'failureCount', $pb.PbFieldType.O3)
    ..aOS(13, _omitFieldNames ? '' : 'lastError')
    ..aOS(14, _omitFieldNames ? '' : 'createdAt')
    ..aOS(15, _omitFieldNames ? '' : 'updatedAt')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NotificationChannelMessage clone() => NotificationChannelMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NotificationChannelMessage copyWith(void Function(NotificationChannelMessage) updates) => super.copyWith((message) => updates(message as NotificationChannelMessage)) as NotificationChannelMessage;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NotificationChannelMessage create() => NotificationChannelMessage._();
  NotificationChannelMessage createEmptyInstance() => create();
  static $pb.PbList<NotificationChannelMessage> createRepeated() => $pb.PbList<NotificationChannelMessage>();
  @$core.pragma('dart2js:noInline')
  static NotificationChannelMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NotificationChannelMessage>(create);
  static NotificationChannelMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get crowdfundId => $_getSZ(1);
  @$pb.TagNumber(2)
  set crowdfundId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCrowdfundId() => $_has(1);
  @$pb.TagNumber(2)
  void clearCrowdfundId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get creatorUserId => $_getSZ(2);
  @$pb.TagNumber(3)
  set creatorUserId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCreatorUserId() => $_has(2);
  @$pb.TagNumber(3)
  void clearCreatorUserId() => clearField(3);

  @$pb.TagNumber(4)
  NotificationChannelType get channelType => $_getN(3);
  @$pb.TagNumber(4)
  set channelType(NotificationChannelType v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasChannelType() => $_has(3);
  @$pb.TagNumber(4)
  void clearChannelType() => clearField(4);

  @$pb.TagNumber(5)
  NotificationChannelStatus get status => $_getN(4);
  @$pb.TagNumber(5)
  set status(NotificationChannelStatus v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasStatus() => $_has(4);
  @$pb.TagNumber(5)
  void clearStatus() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get channelName => $_getSZ(5);
  @$pb.TagNumber(6)
  set channelName($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasChannelName() => $_has(5);
  @$pb.TagNumber(6)
  void clearChannelName() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get channelUsername => $_getSZ(6);
  @$pb.TagNumber(7)
  set channelUsername($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasChannelUsername() => $_has(6);
  @$pb.TagNumber(7)
  void clearChannelUsername() => clearField(7);

  @$pb.TagNumber(8)
  $core.List<NotificationEventType> get enabledEvents => $_getList(7);

  @$pb.TagNumber(9)
  NotificationPreferencesMessage get preferences => $_getN(8);
  @$pb.TagNumber(9)
  set preferences(NotificationPreferencesMessage v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasPreferences() => $_has(8);
  @$pb.TagNumber(9)
  void clearPreferences() => clearField(9);
  @$pb.TagNumber(9)
  NotificationPreferencesMessage ensurePreferences() => $_ensure(8);

  @$pb.TagNumber(10)
  $core.String get lastNotificationAt => $_getSZ(9);
  @$pb.TagNumber(10)
  set lastNotificationAt($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasLastNotificationAt() => $_has(9);
  @$pb.TagNumber(10)
  void clearLastNotificationAt() => clearField(10);

  @$pb.TagNumber(11)
  $core.int get notificationCount => $_getIZ(10);
  @$pb.TagNumber(11)
  set notificationCount($core.int v) { $_setSignedInt32(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasNotificationCount() => $_has(10);
  @$pb.TagNumber(11)
  void clearNotificationCount() => clearField(11);

  @$pb.TagNumber(12)
  $core.int get failureCount => $_getIZ(11);
  @$pb.TagNumber(12)
  set failureCount($core.int v) { $_setSignedInt32(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasFailureCount() => $_has(11);
  @$pb.TagNumber(12)
  void clearFailureCount() => clearField(12);

  @$pb.TagNumber(13)
  $core.String get lastError => $_getSZ(12);
  @$pb.TagNumber(13)
  set lastError($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasLastError() => $_has(12);
  @$pb.TagNumber(13)
  void clearLastError() => clearField(13);

  @$pb.TagNumber(14)
  $core.String get createdAt => $_getSZ(13);
  @$pb.TagNumber(14)
  set createdAt($core.String v) { $_setString(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasCreatedAt() => $_has(13);
  @$pb.TagNumber(14)
  void clearCreatedAt() => clearField(14);

  @$pb.TagNumber(15)
  $core.String get updatedAt => $_getSZ(14);
  @$pb.TagNumber(15)
  set updatedAt($core.String v) { $_setString(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasUpdatedAt() => $_has(14);
  @$pb.TagNumber(15)
  void clearUpdatedAt() => clearField(15);
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
    final $result = create();
    if (includeDonorName != null) {
      $result.includeDonorName = includeDonorName;
    }
    if (includeAmount != null) {
      $result.includeAmount = includeAmount;
    }
    if (includeMessage != null) {
      $result.includeMessage = includeMessage;
    }
    if (includeProgress != null) {
      $result.includeProgress = includeProgress;
    }
    if (includeLeaderboard != null) {
      $result.includeLeaderboard = includeLeaderboard;
    }
    if (largeDonationThreshold != null) {
      $result.largeDonationThreshold = largeDonationThreshold;
    }
    if (messageTemplate != null) {
      $result.messageTemplate = messageTemplate;
    }
    if (language != null) {
      $result.language = language;
    }
    if (quietHoursEnabled != null) {
      $result.quietHoursEnabled = quietHoursEnabled;
    }
    if (quietHoursStart != null) {
      $result.quietHoursStart = quietHoursStart;
    }
    if (quietHoursEnd != null) {
      $result.quietHoursEnd = quietHoursEnd;
    }
    if (timezone != null) {
      $result.timezone = timezone;
    }
    return $result;
  }
  NotificationPreferencesMessage._() : super();
  factory NotificationPreferencesMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NotificationPreferencesMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'NotificationPreferencesMessage', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'includeDonorName')
    ..aOB(2, _omitFieldNames ? '' : 'includeAmount')
    ..aOB(3, _omitFieldNames ? '' : 'includeMessage')
    ..aOB(4, _omitFieldNames ? '' : 'includeProgress')
    ..aOB(5, _omitFieldNames ? '' : 'includeLeaderboard')
    ..a<$core.double>(6, _omitFieldNames ? '' : 'largeDonationThreshold', $pb.PbFieldType.OD)
    ..aOS(7, _omitFieldNames ? '' : 'messageTemplate')
    ..aOS(8, _omitFieldNames ? '' : 'language')
    ..aOB(9, _omitFieldNames ? '' : 'quietHoursEnabled')
    ..aOS(10, _omitFieldNames ? '' : 'quietHoursStart')
    ..aOS(11, _omitFieldNames ? '' : 'quietHoursEnd')
    ..aOS(12, _omitFieldNames ? '' : 'timezone')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NotificationPreferencesMessage clone() => NotificationPreferencesMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NotificationPreferencesMessage copyWith(void Function(NotificationPreferencesMessage) updates) => super.copyWith((message) => updates(message as NotificationPreferencesMessage)) as NotificationPreferencesMessage;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NotificationPreferencesMessage create() => NotificationPreferencesMessage._();
  NotificationPreferencesMessage createEmptyInstance() => create();
  static $pb.PbList<NotificationPreferencesMessage> createRepeated() => $pb.PbList<NotificationPreferencesMessage>();
  @$core.pragma('dart2js:noInline')
  static NotificationPreferencesMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NotificationPreferencesMessage>(create);
  static NotificationPreferencesMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get includeDonorName => $_getBF(0);
  @$pb.TagNumber(1)
  set includeDonorName($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasIncludeDonorName() => $_has(0);
  @$pb.TagNumber(1)
  void clearIncludeDonorName() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get includeAmount => $_getBF(1);
  @$pb.TagNumber(2)
  set includeAmount($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasIncludeAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearIncludeAmount() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get includeMessage => $_getBF(2);
  @$pb.TagNumber(3)
  set includeMessage($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasIncludeMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearIncludeMessage() => clearField(3);

  @$pb.TagNumber(4)
  $core.bool get includeProgress => $_getBF(3);
  @$pb.TagNumber(4)
  set includeProgress($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasIncludeProgress() => $_has(3);
  @$pb.TagNumber(4)
  void clearIncludeProgress() => clearField(4);

  @$pb.TagNumber(5)
  $core.bool get includeLeaderboard => $_getBF(4);
  @$pb.TagNumber(5)
  set includeLeaderboard($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasIncludeLeaderboard() => $_has(4);
  @$pb.TagNumber(5)
  void clearIncludeLeaderboard() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get largeDonationThreshold => $_getN(5);
  @$pb.TagNumber(6)
  set largeDonationThreshold($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasLargeDonationThreshold() => $_has(5);
  @$pb.TagNumber(6)
  void clearLargeDonationThreshold() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get messageTemplate => $_getSZ(6);
  @$pb.TagNumber(7)
  set messageTemplate($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasMessageTemplate() => $_has(6);
  @$pb.TagNumber(7)
  void clearMessageTemplate() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get language => $_getSZ(7);
  @$pb.TagNumber(8)
  set language($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasLanguage() => $_has(7);
  @$pb.TagNumber(8)
  void clearLanguage() => clearField(8);

  @$pb.TagNumber(9)
  $core.bool get quietHoursEnabled => $_getBF(8);
  @$pb.TagNumber(9)
  set quietHoursEnabled($core.bool v) { $_setBool(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasQuietHoursEnabled() => $_has(8);
  @$pb.TagNumber(9)
  void clearQuietHoursEnabled() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get quietHoursStart => $_getSZ(9);
  @$pb.TagNumber(10)
  set quietHoursStart($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasQuietHoursStart() => $_has(9);
  @$pb.TagNumber(10)
  void clearQuietHoursStart() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get quietHoursEnd => $_getSZ(10);
  @$pb.TagNumber(11)
  set quietHoursEnd($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasQuietHoursEnd() => $_has(10);
  @$pb.TagNumber(11)
  void clearQuietHoursEnd() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get timezone => $_getSZ(11);
  @$pb.TagNumber(12)
  set timezone($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasTimezone() => $_has(11);
  @$pb.TagNumber(12)
  void clearTimezone() => clearField(12);
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
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (channelId != null) {
      $result.channelId = channelId;
    }
    if (crowdfundId != null) {
      $result.crowdfundId = crowdfundId;
    }
    if (eventType != null) {
      $result.eventType = eventType;
    }
    if (eventData != null) {
      $result.eventData = eventData;
    }
    if (messageContent != null) {
      $result.messageContent = messageContent;
    }
    if (success != null) {
      $result.success = success;
    }
    if (errorMessage != null) {
      $result.errorMessage = errorMessage;
    }
    if (retryCount != null) {
      $result.retryCount = retryCount;
    }
    if (platformMessageId != null) {
      $result.platformMessageId = platformMessageId;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    if (deliveredAt != null) {
      $result.deliveredAt = deliveredAt;
    }
    return $result;
  }
  NotificationDeliveryMessage._() : super();
  factory NotificationDeliveryMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NotificationDeliveryMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'NotificationDeliveryMessage', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'channelId')
    ..aOS(3, _omitFieldNames ? '' : 'crowdfundId')
    ..e<NotificationEventType>(4, _omitFieldNames ? '' : 'eventType', $pb.PbFieldType.OE, defaultOrMaker: NotificationEventType.NOTIFICATION_EVENT_TYPE_UNSPECIFIED, valueOf: NotificationEventType.valueOf, enumValues: NotificationEventType.values)
    ..aOS(5, _omitFieldNames ? '' : 'eventData')
    ..aOS(6, _omitFieldNames ? '' : 'messageContent')
    ..aOB(7, _omitFieldNames ? '' : 'success')
    ..aOS(8, _omitFieldNames ? '' : 'errorMessage')
    ..a<$core.int>(9, _omitFieldNames ? '' : 'retryCount', $pb.PbFieldType.O3)
    ..aOS(10, _omitFieldNames ? '' : 'platformMessageId')
    ..aOS(11, _omitFieldNames ? '' : 'createdAt')
    ..aOS(12, _omitFieldNames ? '' : 'deliveredAt')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NotificationDeliveryMessage clone() => NotificationDeliveryMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NotificationDeliveryMessage copyWith(void Function(NotificationDeliveryMessage) updates) => super.copyWith((message) => updates(message as NotificationDeliveryMessage)) as NotificationDeliveryMessage;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NotificationDeliveryMessage create() => NotificationDeliveryMessage._();
  NotificationDeliveryMessage createEmptyInstance() => create();
  static $pb.PbList<NotificationDeliveryMessage> createRepeated() => $pb.PbList<NotificationDeliveryMessage>();
  @$core.pragma('dart2js:noInline')
  static NotificationDeliveryMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NotificationDeliveryMessage>(create);
  static NotificationDeliveryMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get channelId => $_getSZ(1);
  @$pb.TagNumber(2)
  set channelId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasChannelId() => $_has(1);
  @$pb.TagNumber(2)
  void clearChannelId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get crowdfundId => $_getSZ(2);
  @$pb.TagNumber(3)
  set crowdfundId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCrowdfundId() => $_has(2);
  @$pb.TagNumber(3)
  void clearCrowdfundId() => clearField(3);

  @$pb.TagNumber(4)
  NotificationEventType get eventType => $_getN(3);
  @$pb.TagNumber(4)
  set eventType(NotificationEventType v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasEventType() => $_has(3);
  @$pb.TagNumber(4)
  void clearEventType() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get eventData => $_getSZ(4);
  @$pb.TagNumber(5)
  set eventData($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasEventData() => $_has(4);
  @$pb.TagNumber(5)
  void clearEventData() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get messageContent => $_getSZ(5);
  @$pb.TagNumber(6)
  set messageContent($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasMessageContent() => $_has(5);
  @$pb.TagNumber(6)
  void clearMessageContent() => clearField(6);

  @$pb.TagNumber(7)
  $core.bool get success => $_getBF(6);
  @$pb.TagNumber(7)
  set success($core.bool v) { $_setBool(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasSuccess() => $_has(6);
  @$pb.TagNumber(7)
  void clearSuccess() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get errorMessage => $_getSZ(7);
  @$pb.TagNumber(8)
  set errorMessage($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasErrorMessage() => $_has(7);
  @$pb.TagNumber(8)
  void clearErrorMessage() => clearField(8);

  @$pb.TagNumber(9)
  $core.int get retryCount => $_getIZ(8);
  @$pb.TagNumber(9)
  set retryCount($core.int v) { $_setSignedInt32(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasRetryCount() => $_has(8);
  @$pb.TagNumber(9)
  void clearRetryCount() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get platformMessageId => $_getSZ(9);
  @$pb.TagNumber(10)
  set platformMessageId($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasPlatformMessageId() => $_has(9);
  @$pb.TagNumber(10)
  void clearPlatformMessageId() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get createdAt => $_getSZ(10);
  @$pb.TagNumber(11)
  set createdAt($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasCreatedAt() => $_has(10);
  @$pb.TagNumber(11)
  void clearCreatedAt() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get deliveredAt => $_getSZ(11);
  @$pb.TagNumber(12)
  set deliveredAt($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasDeliveredAt() => $_has(11);
  @$pb.TagNumber(12)
  void clearDeliveredAt() => clearField(12);
}

class TelegramConnectionDataMessage extends $pb.GeneratedMessage {
  factory TelegramConnectionDataMessage({
    $core.String? chatId,
    $core.String? verificationCode,
  }) {
    final $result = create();
    if (chatId != null) {
      $result.chatId = chatId;
    }
    if (verificationCode != null) {
      $result.verificationCode = verificationCode;
    }
    return $result;
  }
  TelegramConnectionDataMessage._() : super();
  factory TelegramConnectionDataMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TelegramConnectionDataMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TelegramConnectionDataMessage', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'chatId')
    ..aOS(2, _omitFieldNames ? '' : 'verificationCode')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TelegramConnectionDataMessage clone() => TelegramConnectionDataMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TelegramConnectionDataMessage copyWith(void Function(TelegramConnectionDataMessage) updates) => super.copyWith((message) => updates(message as TelegramConnectionDataMessage)) as TelegramConnectionDataMessage;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TelegramConnectionDataMessage create() => TelegramConnectionDataMessage._();
  TelegramConnectionDataMessage createEmptyInstance() => create();
  static $pb.PbList<TelegramConnectionDataMessage> createRepeated() => $pb.PbList<TelegramConnectionDataMessage>();
  @$core.pragma('dart2js:noInline')
  static TelegramConnectionDataMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TelegramConnectionDataMessage>(create);
  static TelegramConnectionDataMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get chatId => $_getSZ(0);
  @$pb.TagNumber(1)
  set chatId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasChatId() => $_has(0);
  @$pb.TagNumber(1)
  void clearChatId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get verificationCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set verificationCode($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasVerificationCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearVerificationCode() => clearField(2);
}

class DiscordConnectionDataMessage extends $pb.GeneratedMessage {
  factory DiscordConnectionDataMessage({
    $core.String? webhookUrl,
    $core.String? serverName,
    $core.String? channelName,
  }) {
    final $result = create();
    if (webhookUrl != null) {
      $result.webhookUrl = webhookUrl;
    }
    if (serverName != null) {
      $result.serverName = serverName;
    }
    if (channelName != null) {
      $result.channelName = channelName;
    }
    return $result;
  }
  DiscordConnectionDataMessage._() : super();
  factory DiscordConnectionDataMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DiscordConnectionDataMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DiscordConnectionDataMessage', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'webhookUrl')
    ..aOS(2, _omitFieldNames ? '' : 'serverName')
    ..aOS(3, _omitFieldNames ? '' : 'channelName')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DiscordConnectionDataMessage clone() => DiscordConnectionDataMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DiscordConnectionDataMessage copyWith(void Function(DiscordConnectionDataMessage) updates) => super.copyWith((message) => updates(message as DiscordConnectionDataMessage)) as DiscordConnectionDataMessage;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DiscordConnectionDataMessage create() => DiscordConnectionDataMessage._();
  DiscordConnectionDataMessage createEmptyInstance() => create();
  static $pb.PbList<DiscordConnectionDataMessage> createRepeated() => $pb.PbList<DiscordConnectionDataMessage>();
  @$core.pragma('dart2js:noInline')
  static DiscordConnectionDataMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DiscordConnectionDataMessage>(create);
  static DiscordConnectionDataMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get webhookUrl => $_getSZ(0);
  @$pb.TagNumber(1)
  set webhookUrl($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasWebhookUrl() => $_has(0);
  @$pb.TagNumber(1)
  void clearWebhookUrl() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get serverName => $_getSZ(1);
  @$pb.TagNumber(2)
  set serverName($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasServerName() => $_has(1);
  @$pb.TagNumber(2)
  void clearServerName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get channelName => $_getSZ(2);
  @$pb.TagNumber(3)
  set channelName($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasChannelName() => $_has(2);
  @$pb.TagNumber(3)
  void clearChannelName() => clearField(3);
}

class WhatsAppBusinessConnectionDataMessage extends $pb.GeneratedMessage {
  factory WhatsAppBusinessConnectionDataMessage({
    $core.String? phoneNumberId,
    $core.String? accessToken,
    $core.String? recipientId,
  }) {
    final $result = create();
    if (phoneNumberId != null) {
      $result.phoneNumberId = phoneNumberId;
    }
    if (accessToken != null) {
      $result.accessToken = accessToken;
    }
    if (recipientId != null) {
      $result.recipientId = recipientId;
    }
    return $result;
  }
  WhatsAppBusinessConnectionDataMessage._() : super();
  factory WhatsAppBusinessConnectionDataMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WhatsAppBusinessConnectionDataMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'WhatsAppBusinessConnectionDataMessage', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'phoneNumberId')
    ..aOS(2, _omitFieldNames ? '' : 'accessToken')
    ..aOS(3, _omitFieldNames ? '' : 'recipientId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  WhatsAppBusinessConnectionDataMessage clone() => WhatsAppBusinessConnectionDataMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  WhatsAppBusinessConnectionDataMessage copyWith(void Function(WhatsAppBusinessConnectionDataMessage) updates) => super.copyWith((message) => updates(message as WhatsAppBusinessConnectionDataMessage)) as WhatsAppBusinessConnectionDataMessage;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WhatsAppBusinessConnectionDataMessage create() => WhatsAppBusinessConnectionDataMessage._();
  WhatsAppBusinessConnectionDataMessage createEmptyInstance() => create();
  static $pb.PbList<WhatsAppBusinessConnectionDataMessage> createRepeated() => $pb.PbList<WhatsAppBusinessConnectionDataMessage>();
  @$core.pragma('dart2js:noInline')
  static WhatsAppBusinessConnectionDataMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WhatsAppBusinessConnectionDataMessage>(create);
  static WhatsAppBusinessConnectionDataMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get phoneNumberId => $_getSZ(0);
  @$pb.TagNumber(1)
  set phoneNumberId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPhoneNumberId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPhoneNumberId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get accessToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set accessToken($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAccessToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccessToken() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get recipientId => $_getSZ(2);
  @$pb.TagNumber(3)
  set recipientId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasRecipientId() => $_has(2);
  @$pb.TagNumber(3)
  void clearRecipientId() => clearField(3);
}

class SlackConnectionDataMessage extends $pb.GeneratedMessage {
  factory SlackConnectionDataMessage({
    $core.String? webhookUrl,
    $core.String? workspaceName,
    $core.String? channelName,
  }) {
    final $result = create();
    if (webhookUrl != null) {
      $result.webhookUrl = webhookUrl;
    }
    if (workspaceName != null) {
      $result.workspaceName = workspaceName;
    }
    if (channelName != null) {
      $result.channelName = channelName;
    }
    return $result;
  }
  SlackConnectionDataMessage._() : super();
  factory SlackConnectionDataMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SlackConnectionDataMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SlackConnectionDataMessage', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'webhookUrl')
    ..aOS(2, _omitFieldNames ? '' : 'workspaceName')
    ..aOS(3, _omitFieldNames ? '' : 'channelName')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SlackConnectionDataMessage clone() => SlackConnectionDataMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SlackConnectionDataMessage copyWith(void Function(SlackConnectionDataMessage) updates) => super.copyWith((message) => updates(message as SlackConnectionDataMessage)) as SlackConnectionDataMessage;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SlackConnectionDataMessage create() => SlackConnectionDataMessage._();
  SlackConnectionDataMessage createEmptyInstance() => create();
  static $pb.PbList<SlackConnectionDataMessage> createRepeated() => $pb.PbList<SlackConnectionDataMessage>();
  @$core.pragma('dart2js:noInline')
  static SlackConnectionDataMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SlackConnectionDataMessage>(create);
  static SlackConnectionDataMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get webhookUrl => $_getSZ(0);
  @$pb.TagNumber(1)
  set webhookUrl($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasWebhookUrl() => $_has(0);
  @$pb.TagNumber(1)
  void clearWebhookUrl() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get workspaceName => $_getSZ(1);
  @$pb.TagNumber(2)
  set workspaceName($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasWorkspaceName() => $_has(1);
  @$pb.TagNumber(2)
  void clearWorkspaceName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get channelName => $_getSZ(2);
  @$pb.TagNumber(3)
  set channelName($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasChannelName() => $_has(2);
  @$pb.TagNumber(3)
  void clearChannelName() => clearField(3);
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
    final $result = create();
    if (crowdfundId != null) {
      $result.crowdfundId = crowdfundId;
    }
    if (channelType != null) {
      $result.channelType = channelType;
    }
    if (channelName != null) {
      $result.channelName = channelName;
    }
    if (telegram != null) {
      $result.telegram = telegram;
    }
    if (discord != null) {
      $result.discord = discord;
    }
    if (whatsappBusiness != null) {
      $result.whatsappBusiness = whatsappBusiness;
    }
    if (slack != null) {
      $result.slack = slack;
    }
    if (enabledEvents != null) {
      $result.enabledEvents.addAll(enabledEvents);
    }
    if (preferences != null) {
      $result.preferences = preferences;
    }
    return $result;
  }
  ConnectNotificationChannelRequest._() : super();
  factory ConnectNotificationChannelRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ConnectNotificationChannelRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, ConnectNotificationChannelRequest_ConnectionData> _ConnectNotificationChannelRequest_ConnectionDataByTag = {
    4 : ConnectNotificationChannelRequest_ConnectionData.telegram,
    5 : ConnectNotificationChannelRequest_ConnectionData.discord,
    6 : ConnectNotificationChannelRequest_ConnectionData.whatsappBusiness,
    7 : ConnectNotificationChannelRequest_ConnectionData.slack,
    0 : ConnectNotificationChannelRequest_ConnectionData.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ConnectNotificationChannelRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..oo(0, [4, 5, 6, 7])
    ..aOS(1, _omitFieldNames ? '' : 'crowdfundId')
    ..e<NotificationChannelType>(2, _omitFieldNames ? '' : 'channelType', $pb.PbFieldType.OE, defaultOrMaker: NotificationChannelType.NOTIFICATION_CHANNEL_TYPE_UNSPECIFIED, valueOf: NotificationChannelType.valueOf, enumValues: NotificationChannelType.values)
    ..aOS(3, _omitFieldNames ? '' : 'channelName')
    ..aOM<TelegramConnectionDataMessage>(4, _omitFieldNames ? '' : 'telegram', subBuilder: TelegramConnectionDataMessage.create)
    ..aOM<DiscordConnectionDataMessage>(5, _omitFieldNames ? '' : 'discord', subBuilder: DiscordConnectionDataMessage.create)
    ..aOM<WhatsAppBusinessConnectionDataMessage>(6, _omitFieldNames ? '' : 'whatsappBusiness', subBuilder: WhatsAppBusinessConnectionDataMessage.create)
    ..aOM<SlackConnectionDataMessage>(7, _omitFieldNames ? '' : 'slack', subBuilder: SlackConnectionDataMessage.create)
    ..pc<NotificationEventType>(8, _omitFieldNames ? '' : 'enabledEvents', $pb.PbFieldType.KE, valueOf: NotificationEventType.valueOf, enumValues: NotificationEventType.values, defaultEnumValue: NotificationEventType.NOTIFICATION_EVENT_TYPE_UNSPECIFIED)
    ..aOM<NotificationPreferencesMessage>(9, _omitFieldNames ? '' : 'preferences', subBuilder: NotificationPreferencesMessage.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ConnectNotificationChannelRequest clone() => ConnectNotificationChannelRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ConnectNotificationChannelRequest copyWith(void Function(ConnectNotificationChannelRequest) updates) => super.copyWith((message) => updates(message as ConnectNotificationChannelRequest)) as ConnectNotificationChannelRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ConnectNotificationChannelRequest create() => ConnectNotificationChannelRequest._();
  ConnectNotificationChannelRequest createEmptyInstance() => create();
  static $pb.PbList<ConnectNotificationChannelRequest> createRepeated() => $pb.PbList<ConnectNotificationChannelRequest>();
  @$core.pragma('dart2js:noInline')
  static ConnectNotificationChannelRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ConnectNotificationChannelRequest>(create);
  static ConnectNotificationChannelRequest? _defaultInstance;

  ConnectNotificationChannelRequest_ConnectionData whichConnectionData() => _ConnectNotificationChannelRequest_ConnectionDataByTag[$_whichOneof(0)]!;
  void clearConnectionData() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.String get crowdfundId => $_getSZ(0);
  @$pb.TagNumber(1)
  set crowdfundId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCrowdfundId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCrowdfundId() => clearField(1);

  @$pb.TagNumber(2)
  NotificationChannelType get channelType => $_getN(1);
  @$pb.TagNumber(2)
  set channelType(NotificationChannelType v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasChannelType() => $_has(1);
  @$pb.TagNumber(2)
  void clearChannelType() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get channelName => $_getSZ(2);
  @$pb.TagNumber(3)
  set channelName($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasChannelName() => $_has(2);
  @$pb.TagNumber(3)
  void clearChannelName() => clearField(3);

  @$pb.TagNumber(4)
  TelegramConnectionDataMessage get telegram => $_getN(3);
  @$pb.TagNumber(4)
  set telegram(TelegramConnectionDataMessage v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasTelegram() => $_has(3);
  @$pb.TagNumber(4)
  void clearTelegram() => clearField(4);
  @$pb.TagNumber(4)
  TelegramConnectionDataMessage ensureTelegram() => $_ensure(3);

  @$pb.TagNumber(5)
  DiscordConnectionDataMessage get discord => $_getN(4);
  @$pb.TagNumber(5)
  set discord(DiscordConnectionDataMessage v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasDiscord() => $_has(4);
  @$pb.TagNumber(5)
  void clearDiscord() => clearField(5);
  @$pb.TagNumber(5)
  DiscordConnectionDataMessage ensureDiscord() => $_ensure(4);

  @$pb.TagNumber(6)
  WhatsAppBusinessConnectionDataMessage get whatsappBusiness => $_getN(5);
  @$pb.TagNumber(6)
  set whatsappBusiness(WhatsAppBusinessConnectionDataMessage v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasWhatsappBusiness() => $_has(5);
  @$pb.TagNumber(6)
  void clearWhatsappBusiness() => clearField(6);
  @$pb.TagNumber(6)
  WhatsAppBusinessConnectionDataMessage ensureWhatsappBusiness() => $_ensure(5);

  @$pb.TagNumber(7)
  SlackConnectionDataMessage get slack => $_getN(6);
  @$pb.TagNumber(7)
  set slack(SlackConnectionDataMessage v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasSlack() => $_has(6);
  @$pb.TagNumber(7)
  void clearSlack() => clearField(7);
  @$pb.TagNumber(7)
  SlackConnectionDataMessage ensureSlack() => $_ensure(6);

  @$pb.TagNumber(8)
  $core.List<NotificationEventType> get enabledEvents => $_getList(7);

  @$pb.TagNumber(9)
  NotificationPreferencesMessage get preferences => $_getN(8);
  @$pb.TagNumber(9)
  set preferences(NotificationPreferencesMessage v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasPreferences() => $_has(8);
  @$pb.TagNumber(9)
  void clearPreferences() => clearField(9);
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
    final $result = create();
    if (channel != null) {
      $result.channel = channel;
    }
    if (requiresVerification != null) {
      $result.requiresVerification = requiresVerification;
    }
    if (verificationInstructions != null) {
      $result.verificationInstructions = verificationInstructions;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  ConnectNotificationChannelResponse._() : super();
  factory ConnectNotificationChannelResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ConnectNotificationChannelResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ConnectNotificationChannelResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<NotificationChannelMessage>(1, _omitFieldNames ? '' : 'channel', subBuilder: NotificationChannelMessage.create)
    ..aOB(2, _omitFieldNames ? '' : 'requiresVerification')
    ..aOS(3, _omitFieldNames ? '' : 'verificationInstructions')
    ..aOS(4, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ConnectNotificationChannelResponse clone() => ConnectNotificationChannelResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ConnectNotificationChannelResponse copyWith(void Function(ConnectNotificationChannelResponse) updates) => super.copyWith((message) => updates(message as ConnectNotificationChannelResponse)) as ConnectNotificationChannelResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ConnectNotificationChannelResponse create() => ConnectNotificationChannelResponse._();
  ConnectNotificationChannelResponse createEmptyInstance() => create();
  static $pb.PbList<ConnectNotificationChannelResponse> createRepeated() => $pb.PbList<ConnectNotificationChannelResponse>();
  @$core.pragma('dart2js:noInline')
  static ConnectNotificationChannelResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ConnectNotificationChannelResponse>(create);
  static ConnectNotificationChannelResponse? _defaultInstance;

  @$pb.TagNumber(1)
  NotificationChannelMessage get channel => $_getN(0);
  @$pb.TagNumber(1)
  set channel(NotificationChannelMessage v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasChannel() => $_has(0);
  @$pb.TagNumber(1)
  void clearChannel() => clearField(1);
  @$pb.TagNumber(1)
  NotificationChannelMessage ensureChannel() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.bool get requiresVerification => $_getBF(1);
  @$pb.TagNumber(2)
  set requiresVerification($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasRequiresVerification() => $_has(1);
  @$pb.TagNumber(2)
  void clearRequiresVerification() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get verificationInstructions => $_getSZ(2);
  @$pb.TagNumber(3)
  set verificationInstructions($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasVerificationInstructions() => $_has(2);
  @$pb.TagNumber(3)
  void clearVerificationInstructions() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get message => $_getSZ(3);
  @$pb.TagNumber(4)
  set message($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasMessage() => $_has(3);
  @$pb.TagNumber(4)
  void clearMessage() => clearField(4);
}

class DisconnectNotificationChannelRequest extends $pb.GeneratedMessage {
  factory DisconnectNotificationChannelRequest({
    $core.String? channelId,
  }) {
    final $result = create();
    if (channelId != null) {
      $result.channelId = channelId;
    }
    return $result;
  }
  DisconnectNotificationChannelRequest._() : super();
  factory DisconnectNotificationChannelRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DisconnectNotificationChannelRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DisconnectNotificationChannelRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'channelId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DisconnectNotificationChannelRequest clone() => DisconnectNotificationChannelRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DisconnectNotificationChannelRequest copyWith(void Function(DisconnectNotificationChannelRequest) updates) => super.copyWith((message) => updates(message as DisconnectNotificationChannelRequest)) as DisconnectNotificationChannelRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DisconnectNotificationChannelRequest create() => DisconnectNotificationChannelRequest._();
  DisconnectNotificationChannelRequest createEmptyInstance() => create();
  static $pb.PbList<DisconnectNotificationChannelRequest> createRepeated() => $pb.PbList<DisconnectNotificationChannelRequest>();
  @$core.pragma('dart2js:noInline')
  static DisconnectNotificationChannelRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DisconnectNotificationChannelRequest>(create);
  static DisconnectNotificationChannelRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get channelId => $_getSZ(0);
  @$pb.TagNumber(1)
  set channelId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasChannelId() => $_has(0);
  @$pb.TagNumber(1)
  void clearChannelId() => clearField(1);
}

class DisconnectNotificationChannelResponse extends $pb.GeneratedMessage {
  factory DisconnectNotificationChannelResponse({
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
  DisconnectNotificationChannelResponse._() : super();
  factory DisconnectNotificationChannelResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DisconnectNotificationChannelResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DisconnectNotificationChannelResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DisconnectNotificationChannelResponse clone() => DisconnectNotificationChannelResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DisconnectNotificationChannelResponse copyWith(void Function(DisconnectNotificationChannelResponse) updates) => super.copyWith((message) => updates(message as DisconnectNotificationChannelResponse)) as DisconnectNotificationChannelResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DisconnectNotificationChannelResponse create() => DisconnectNotificationChannelResponse._();
  DisconnectNotificationChannelResponse createEmptyInstance() => create();
  static $pb.PbList<DisconnectNotificationChannelResponse> createRepeated() => $pb.PbList<DisconnectNotificationChannelResponse>();
  @$core.pragma('dart2js:noInline')
  static DisconnectNotificationChannelResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DisconnectNotificationChannelResponse>(create);
  static DisconnectNotificationChannelResponse? _defaultInstance;

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

class GetNotificationChannelsRequest extends $pb.GeneratedMessage {
  factory GetNotificationChannelsRequest({
    $core.String? crowdfundId,
  }) {
    final $result = create();
    if (crowdfundId != null) {
      $result.crowdfundId = crowdfundId;
    }
    return $result;
  }
  GetNotificationChannelsRequest._() : super();
  factory GetNotificationChannelsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetNotificationChannelsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetNotificationChannelsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'crowdfundId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetNotificationChannelsRequest clone() => GetNotificationChannelsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetNotificationChannelsRequest copyWith(void Function(GetNotificationChannelsRequest) updates) => super.copyWith((message) => updates(message as GetNotificationChannelsRequest)) as GetNotificationChannelsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetNotificationChannelsRequest create() => GetNotificationChannelsRequest._();
  GetNotificationChannelsRequest createEmptyInstance() => create();
  static $pb.PbList<GetNotificationChannelsRequest> createRepeated() => $pb.PbList<GetNotificationChannelsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetNotificationChannelsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetNotificationChannelsRequest>(create);
  static GetNotificationChannelsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get crowdfundId => $_getSZ(0);
  @$pb.TagNumber(1)
  set crowdfundId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCrowdfundId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCrowdfundId() => clearField(1);
}

class GetNotificationChannelsResponse extends $pb.GeneratedMessage {
  factory GetNotificationChannelsResponse({
    $core.Iterable<NotificationChannelMessage>? channels,
  }) {
    final $result = create();
    if (channels != null) {
      $result.channels.addAll(channels);
    }
    return $result;
  }
  GetNotificationChannelsResponse._() : super();
  factory GetNotificationChannelsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetNotificationChannelsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetNotificationChannelsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pc<NotificationChannelMessage>(1, _omitFieldNames ? '' : 'channels', $pb.PbFieldType.PM, subBuilder: NotificationChannelMessage.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetNotificationChannelsResponse clone() => GetNotificationChannelsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetNotificationChannelsResponse copyWith(void Function(GetNotificationChannelsResponse) updates) => super.copyWith((message) => updates(message as GetNotificationChannelsResponse)) as GetNotificationChannelsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetNotificationChannelsResponse create() => GetNotificationChannelsResponse._();
  GetNotificationChannelsResponse createEmptyInstance() => create();
  static $pb.PbList<GetNotificationChannelsResponse> createRepeated() => $pb.PbList<GetNotificationChannelsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetNotificationChannelsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetNotificationChannelsResponse>(create);
  static GetNotificationChannelsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<NotificationChannelMessage> get channels => $_getList(0);
}

class UpdateNotificationChannelRequest extends $pb.GeneratedMessage {
  factory UpdateNotificationChannelRequest({
    $core.String? channelId,
    $core.String? channelName,
    $core.Iterable<NotificationEventType>? enabledEvents,
    NotificationPreferencesMessage? preferences,
    NotificationChannelStatus? status,
  }) {
    final $result = create();
    if (channelId != null) {
      $result.channelId = channelId;
    }
    if (channelName != null) {
      $result.channelName = channelName;
    }
    if (enabledEvents != null) {
      $result.enabledEvents.addAll(enabledEvents);
    }
    if (preferences != null) {
      $result.preferences = preferences;
    }
    if (status != null) {
      $result.status = status;
    }
    return $result;
  }
  UpdateNotificationChannelRequest._() : super();
  factory UpdateNotificationChannelRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateNotificationChannelRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateNotificationChannelRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'channelId')
    ..aOS(2, _omitFieldNames ? '' : 'channelName')
    ..pc<NotificationEventType>(3, _omitFieldNames ? '' : 'enabledEvents', $pb.PbFieldType.KE, valueOf: NotificationEventType.valueOf, enumValues: NotificationEventType.values, defaultEnumValue: NotificationEventType.NOTIFICATION_EVENT_TYPE_UNSPECIFIED)
    ..aOM<NotificationPreferencesMessage>(4, _omitFieldNames ? '' : 'preferences', subBuilder: NotificationPreferencesMessage.create)
    ..e<NotificationChannelStatus>(5, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: NotificationChannelStatus.NOTIFICATION_CHANNEL_STATUS_UNSPECIFIED, valueOf: NotificationChannelStatus.valueOf, enumValues: NotificationChannelStatus.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateNotificationChannelRequest clone() => UpdateNotificationChannelRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateNotificationChannelRequest copyWith(void Function(UpdateNotificationChannelRequest) updates) => super.copyWith((message) => updates(message as UpdateNotificationChannelRequest)) as UpdateNotificationChannelRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateNotificationChannelRequest create() => UpdateNotificationChannelRequest._();
  UpdateNotificationChannelRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateNotificationChannelRequest> createRepeated() => $pb.PbList<UpdateNotificationChannelRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateNotificationChannelRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateNotificationChannelRequest>(create);
  static UpdateNotificationChannelRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get channelId => $_getSZ(0);
  @$pb.TagNumber(1)
  set channelId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasChannelId() => $_has(0);
  @$pb.TagNumber(1)
  void clearChannelId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get channelName => $_getSZ(1);
  @$pb.TagNumber(2)
  set channelName($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasChannelName() => $_has(1);
  @$pb.TagNumber(2)
  void clearChannelName() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<NotificationEventType> get enabledEvents => $_getList(2);

  @$pb.TagNumber(4)
  NotificationPreferencesMessage get preferences => $_getN(3);
  @$pb.TagNumber(4)
  set preferences(NotificationPreferencesMessage v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasPreferences() => $_has(3);
  @$pb.TagNumber(4)
  void clearPreferences() => clearField(4);
  @$pb.TagNumber(4)
  NotificationPreferencesMessage ensurePreferences() => $_ensure(3);

  @$pb.TagNumber(5)
  NotificationChannelStatus get status => $_getN(4);
  @$pb.TagNumber(5)
  set status(NotificationChannelStatus v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasStatus() => $_has(4);
  @$pb.TagNumber(5)
  void clearStatus() => clearField(5);
}

class UpdateNotificationChannelResponse extends $pb.GeneratedMessage {
  factory UpdateNotificationChannelResponse({
    NotificationChannelMessage? channel,
    $core.String? message,
  }) {
    final $result = create();
    if (channel != null) {
      $result.channel = channel;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  UpdateNotificationChannelResponse._() : super();
  factory UpdateNotificationChannelResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateNotificationChannelResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateNotificationChannelResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<NotificationChannelMessage>(1, _omitFieldNames ? '' : 'channel', subBuilder: NotificationChannelMessage.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateNotificationChannelResponse clone() => UpdateNotificationChannelResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateNotificationChannelResponse copyWith(void Function(UpdateNotificationChannelResponse) updates) => super.copyWith((message) => updates(message as UpdateNotificationChannelResponse)) as UpdateNotificationChannelResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateNotificationChannelResponse create() => UpdateNotificationChannelResponse._();
  UpdateNotificationChannelResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateNotificationChannelResponse> createRepeated() => $pb.PbList<UpdateNotificationChannelResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateNotificationChannelResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateNotificationChannelResponse>(create);
  static UpdateNotificationChannelResponse? _defaultInstance;

  @$pb.TagNumber(1)
  NotificationChannelMessage get channel => $_getN(0);
  @$pb.TagNumber(1)
  set channel(NotificationChannelMessage v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasChannel() => $_has(0);
  @$pb.TagNumber(1)
  void clearChannel() => clearField(1);
  @$pb.TagNumber(1)
  NotificationChannelMessage ensureChannel() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

class TestNotificationChannelRequest extends $pb.GeneratedMessage {
  factory TestNotificationChannelRequest({
    $core.String? channelId,
  }) {
    final $result = create();
    if (channelId != null) {
      $result.channelId = channelId;
    }
    return $result;
  }
  TestNotificationChannelRequest._() : super();
  factory TestNotificationChannelRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TestNotificationChannelRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TestNotificationChannelRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'channelId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TestNotificationChannelRequest clone() => TestNotificationChannelRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TestNotificationChannelRequest copyWith(void Function(TestNotificationChannelRequest) updates) => super.copyWith((message) => updates(message as TestNotificationChannelRequest)) as TestNotificationChannelRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TestNotificationChannelRequest create() => TestNotificationChannelRequest._();
  TestNotificationChannelRequest createEmptyInstance() => create();
  static $pb.PbList<TestNotificationChannelRequest> createRepeated() => $pb.PbList<TestNotificationChannelRequest>();
  @$core.pragma('dart2js:noInline')
  static TestNotificationChannelRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TestNotificationChannelRequest>(create);
  static TestNotificationChannelRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get channelId => $_getSZ(0);
  @$pb.TagNumber(1)
  set channelId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasChannelId() => $_has(0);
  @$pb.TagNumber(1)
  void clearChannelId() => clearField(1);
}

class TestNotificationChannelResponse extends $pb.GeneratedMessage {
  factory TestNotificationChannelResponse({
    $core.bool? success,
    $core.String? message,
    $core.String? platformMessageId,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (message != null) {
      $result.message = message;
    }
    if (platformMessageId != null) {
      $result.platformMessageId = platformMessageId;
    }
    return $result;
  }
  TestNotificationChannelResponse._() : super();
  factory TestNotificationChannelResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TestNotificationChannelResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TestNotificationChannelResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOS(3, _omitFieldNames ? '' : 'platformMessageId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TestNotificationChannelResponse clone() => TestNotificationChannelResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TestNotificationChannelResponse copyWith(void Function(TestNotificationChannelResponse) updates) => super.copyWith((message) => updates(message as TestNotificationChannelResponse)) as TestNotificationChannelResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TestNotificationChannelResponse create() => TestNotificationChannelResponse._();
  TestNotificationChannelResponse createEmptyInstance() => create();
  static $pb.PbList<TestNotificationChannelResponse> createRepeated() => $pb.PbList<TestNotificationChannelResponse>();
  @$core.pragma('dart2js:noInline')
  static TestNotificationChannelResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TestNotificationChannelResponse>(create);
  static TestNotificationChannelResponse? _defaultInstance;

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
  $core.String get platformMessageId => $_getSZ(2);
  @$pb.TagNumber(3)
  set platformMessageId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPlatformMessageId() => $_has(2);
  @$pb.TagNumber(3)
  void clearPlatformMessageId() => clearField(3);
}

class GetTelegramBotInfoRequest extends $pb.GeneratedMessage {
  factory GetTelegramBotInfoRequest() => create();
  GetTelegramBotInfoRequest._() : super();
  factory GetTelegramBotInfoRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTelegramBotInfoRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetTelegramBotInfoRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetTelegramBotInfoRequest clone() => GetTelegramBotInfoRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetTelegramBotInfoRequest copyWith(void Function(GetTelegramBotInfoRequest) updates) => super.copyWith((message) => updates(message as GetTelegramBotInfoRequest)) as GetTelegramBotInfoRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTelegramBotInfoRequest create() => GetTelegramBotInfoRequest._();
  GetTelegramBotInfoRequest createEmptyInstance() => create();
  static $pb.PbList<GetTelegramBotInfoRequest> createRepeated() => $pb.PbList<GetTelegramBotInfoRequest>();
  @$core.pragma('dart2js:noInline')
  static GetTelegramBotInfoRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetTelegramBotInfoRequest>(create);
  static GetTelegramBotInfoRequest? _defaultInstance;
}

class GetTelegramBotInfoResponse extends $pb.GeneratedMessage {
  factory GetTelegramBotInfoResponse({
    $core.String? botUsername,
    $core.String? botName,
    $core.String? botLink,
    $core.String? instructions,
  }) {
    final $result = create();
    if (botUsername != null) {
      $result.botUsername = botUsername;
    }
    if (botName != null) {
      $result.botName = botName;
    }
    if (botLink != null) {
      $result.botLink = botLink;
    }
    if (instructions != null) {
      $result.instructions = instructions;
    }
    return $result;
  }
  GetTelegramBotInfoResponse._() : super();
  factory GetTelegramBotInfoResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTelegramBotInfoResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetTelegramBotInfoResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'botUsername')
    ..aOS(2, _omitFieldNames ? '' : 'botName')
    ..aOS(3, _omitFieldNames ? '' : 'botLink')
    ..aOS(4, _omitFieldNames ? '' : 'instructions')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetTelegramBotInfoResponse clone() => GetTelegramBotInfoResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetTelegramBotInfoResponse copyWith(void Function(GetTelegramBotInfoResponse) updates) => super.copyWith((message) => updates(message as GetTelegramBotInfoResponse)) as GetTelegramBotInfoResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTelegramBotInfoResponse create() => GetTelegramBotInfoResponse._();
  GetTelegramBotInfoResponse createEmptyInstance() => create();
  static $pb.PbList<GetTelegramBotInfoResponse> createRepeated() => $pb.PbList<GetTelegramBotInfoResponse>();
  @$core.pragma('dart2js:noInline')
  static GetTelegramBotInfoResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetTelegramBotInfoResponse>(create);
  static GetTelegramBotInfoResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get botUsername => $_getSZ(0);
  @$pb.TagNumber(1)
  set botUsername($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasBotUsername() => $_has(0);
  @$pb.TagNumber(1)
  void clearBotUsername() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get botName => $_getSZ(1);
  @$pb.TagNumber(2)
  set botName($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasBotName() => $_has(1);
  @$pb.TagNumber(2)
  void clearBotName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get botLink => $_getSZ(2);
  @$pb.TagNumber(3)
  set botLink($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasBotLink() => $_has(2);
  @$pb.TagNumber(3)
  void clearBotLink() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get instructions => $_getSZ(3);
  @$pb.TagNumber(4)
  set instructions($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasInstructions() => $_has(3);
  @$pb.TagNumber(4)
  void clearInstructions() => clearField(4);
}

class VerifyTelegramChannelRequest extends $pb.GeneratedMessage {
  factory VerifyTelegramChannelRequest({
    $core.String? crowdfundId,
    $core.String? chatId,
    $core.String? verificationCode,
  }) {
    final $result = create();
    if (crowdfundId != null) {
      $result.crowdfundId = crowdfundId;
    }
    if (chatId != null) {
      $result.chatId = chatId;
    }
    if (verificationCode != null) {
      $result.verificationCode = verificationCode;
    }
    return $result;
  }
  VerifyTelegramChannelRequest._() : super();
  factory VerifyTelegramChannelRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VerifyTelegramChannelRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'VerifyTelegramChannelRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'crowdfundId')
    ..aOS(2, _omitFieldNames ? '' : 'chatId')
    ..aOS(3, _omitFieldNames ? '' : 'verificationCode')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VerifyTelegramChannelRequest clone() => VerifyTelegramChannelRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VerifyTelegramChannelRequest copyWith(void Function(VerifyTelegramChannelRequest) updates) => super.copyWith((message) => updates(message as VerifyTelegramChannelRequest)) as VerifyTelegramChannelRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VerifyTelegramChannelRequest create() => VerifyTelegramChannelRequest._();
  VerifyTelegramChannelRequest createEmptyInstance() => create();
  static $pb.PbList<VerifyTelegramChannelRequest> createRepeated() => $pb.PbList<VerifyTelegramChannelRequest>();
  @$core.pragma('dart2js:noInline')
  static VerifyTelegramChannelRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VerifyTelegramChannelRequest>(create);
  static VerifyTelegramChannelRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get crowdfundId => $_getSZ(0);
  @$pb.TagNumber(1)
  set crowdfundId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCrowdfundId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCrowdfundId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get chatId => $_getSZ(1);
  @$pb.TagNumber(2)
  set chatId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasChatId() => $_has(1);
  @$pb.TagNumber(2)
  void clearChatId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get verificationCode => $_getSZ(2);
  @$pb.TagNumber(3)
  set verificationCode($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasVerificationCode() => $_has(2);
  @$pb.TagNumber(3)
  void clearVerificationCode() => clearField(3);
}

class VerifyTelegramChannelResponse extends $pb.GeneratedMessage {
  factory VerifyTelegramChannelResponse({
    $core.bool? success,
    NotificationChannelMessage? channel,
    $core.String? message,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (channel != null) {
      $result.channel = channel;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  VerifyTelegramChannelResponse._() : super();
  factory VerifyTelegramChannelResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VerifyTelegramChannelResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'VerifyTelegramChannelResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOM<NotificationChannelMessage>(2, _omitFieldNames ? '' : 'channel', subBuilder: NotificationChannelMessage.create)
    ..aOS(3, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VerifyTelegramChannelResponse clone() => VerifyTelegramChannelResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VerifyTelegramChannelResponse copyWith(void Function(VerifyTelegramChannelResponse) updates) => super.copyWith((message) => updates(message as VerifyTelegramChannelResponse)) as VerifyTelegramChannelResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VerifyTelegramChannelResponse create() => VerifyTelegramChannelResponse._();
  VerifyTelegramChannelResponse createEmptyInstance() => create();
  static $pb.PbList<VerifyTelegramChannelResponse> createRepeated() => $pb.PbList<VerifyTelegramChannelResponse>();
  @$core.pragma('dart2js:noInline')
  static VerifyTelegramChannelResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VerifyTelegramChannelResponse>(create);
  static VerifyTelegramChannelResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  NotificationChannelMessage get channel => $_getN(1);
  @$pb.TagNumber(2)
  set channel(NotificationChannelMessage v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasChannel() => $_has(1);
  @$pb.TagNumber(2)
  void clearChannel() => clearField(2);
  @$pb.TagNumber(2)
  NotificationChannelMessage ensureChannel() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => clearField(3);
}

class GetNotificationHistoryRequest extends $pb.GeneratedMessage {
  factory GetNotificationHistoryRequest({
    $core.String? crowdfundId,
    $core.String? channelId,
    $core.int? page,
    $core.int? pageSize,
  }) {
    final $result = create();
    if (crowdfundId != null) {
      $result.crowdfundId = crowdfundId;
    }
    if (channelId != null) {
      $result.channelId = channelId;
    }
    if (page != null) {
      $result.page = page;
    }
    if (pageSize != null) {
      $result.pageSize = pageSize;
    }
    return $result;
  }
  GetNotificationHistoryRequest._() : super();
  factory GetNotificationHistoryRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetNotificationHistoryRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetNotificationHistoryRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'crowdfundId')
    ..aOS(2, _omitFieldNames ? '' : 'channelId')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetNotificationHistoryRequest clone() => GetNotificationHistoryRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetNotificationHistoryRequest copyWith(void Function(GetNotificationHistoryRequest) updates) => super.copyWith((message) => updates(message as GetNotificationHistoryRequest)) as GetNotificationHistoryRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetNotificationHistoryRequest create() => GetNotificationHistoryRequest._();
  GetNotificationHistoryRequest createEmptyInstance() => create();
  static $pb.PbList<GetNotificationHistoryRequest> createRepeated() => $pb.PbList<GetNotificationHistoryRequest>();
  @$core.pragma('dart2js:noInline')
  static GetNotificationHistoryRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetNotificationHistoryRequest>(create);
  static GetNotificationHistoryRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get crowdfundId => $_getSZ(0);
  @$pb.TagNumber(1)
  set crowdfundId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCrowdfundId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCrowdfundId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get channelId => $_getSZ(1);
  @$pb.TagNumber(2)
  set channelId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasChannelId() => $_has(1);
  @$pb.TagNumber(2)
  void clearChannelId() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get page => $_getIZ(2);
  @$pb.TagNumber(3)
  set page($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPage() => $_has(2);
  @$pb.TagNumber(3)
  void clearPage() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get pageSize => $_getIZ(3);
  @$pb.TagNumber(4)
  set pageSize($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPageSize() => $_has(3);
  @$pb.TagNumber(4)
  void clearPageSize() => clearField(4);
}

class GetNotificationHistoryResponse extends $pb.GeneratedMessage {
  factory GetNotificationHistoryResponse({
    $core.Iterable<NotificationDeliveryMessage>? deliveries,
    $core.int? total,
    $core.int? page,
    $core.int? pageSize,
    $core.bool? hasMore,
  }) {
    final $result = create();
    if (deliveries != null) {
      $result.deliveries.addAll(deliveries);
    }
    if (total != null) {
      $result.total = total;
    }
    if (page != null) {
      $result.page = page;
    }
    if (pageSize != null) {
      $result.pageSize = pageSize;
    }
    if (hasMore != null) {
      $result.hasMore = hasMore;
    }
    return $result;
  }
  GetNotificationHistoryResponse._() : super();
  factory GetNotificationHistoryResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetNotificationHistoryResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetNotificationHistoryResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pc<NotificationDeliveryMessage>(1, _omitFieldNames ? '' : 'deliveries', $pb.PbFieldType.PM, subBuilder: NotificationDeliveryMessage.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOB(5, _omitFieldNames ? '' : 'hasMore')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetNotificationHistoryResponse clone() => GetNotificationHistoryResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetNotificationHistoryResponse copyWith(void Function(GetNotificationHistoryResponse) updates) => super.copyWith((message) => updates(message as GetNotificationHistoryResponse)) as GetNotificationHistoryResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetNotificationHistoryResponse create() => GetNotificationHistoryResponse._();
  GetNotificationHistoryResponse createEmptyInstance() => create();
  static $pb.PbList<GetNotificationHistoryResponse> createRepeated() => $pb.PbList<GetNotificationHistoryResponse>();
  @$core.pragma('dart2js:noInline')
  static GetNotificationHistoryResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetNotificationHistoryResponse>(create);
  static GetNotificationHistoryResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<NotificationDeliveryMessage> get deliveries => $_getList(0);

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
  $core.int get pageSize => $_getIZ(3);
  @$pb.TagNumber(4)
  set pageSize($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPageSize() => $_has(3);
  @$pb.TagNumber(4)
  void clearPageSize() => clearField(4);

  @$pb.TagNumber(5)
  $core.bool get hasMore => $_getBF(4);
  @$pb.TagNumber(5)
  set hasMore($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasHasMore() => $_has(4);
  @$pb.TagNumber(5)
  void clearHasMore() => clearField(5);
}

class GetCrowdfundLeaderboardRequest extends $pb.GeneratedMessage {
  factory GetCrowdfundLeaderboardRequest({
    LeaderboardSortBy? sortBy,
    $core.String? category,
    $core.int? limit,
    $core.int? offset,
  }) {
    final $result = create();
    if (sortBy != null) {
      $result.sortBy = sortBy;
    }
    if (category != null) {
      $result.category = category;
    }
    if (limit != null) {
      $result.limit = limit;
    }
    if (offset != null) {
      $result.offset = offset;
    }
    return $result;
  }
  GetCrowdfundLeaderboardRequest._() : super();
  factory GetCrowdfundLeaderboardRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCrowdfundLeaderboardRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetCrowdfundLeaderboardRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..e<LeaderboardSortBy>(1, _omitFieldNames ? '' : 'sortBy', $pb.PbFieldType.OE, defaultOrMaker: LeaderboardSortBy.LEADERBOARD_SORT_UNSPECIFIED, valueOf: LeaderboardSortBy.valueOf, enumValues: LeaderboardSortBy.values)
    ..aOS(2, _omitFieldNames ? '' : 'category')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCrowdfundLeaderboardRequest clone() => GetCrowdfundLeaderboardRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCrowdfundLeaderboardRequest copyWith(void Function(GetCrowdfundLeaderboardRequest) updates) => super.copyWith((message) => updates(message as GetCrowdfundLeaderboardRequest)) as GetCrowdfundLeaderboardRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetCrowdfundLeaderboardRequest create() => GetCrowdfundLeaderboardRequest._();
  GetCrowdfundLeaderboardRequest createEmptyInstance() => create();
  static $pb.PbList<GetCrowdfundLeaderboardRequest> createRepeated() => $pb.PbList<GetCrowdfundLeaderboardRequest>();
  @$core.pragma('dart2js:noInline')
  static GetCrowdfundLeaderboardRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetCrowdfundLeaderboardRequest>(create);
  static GetCrowdfundLeaderboardRequest? _defaultInstance;

  @$pb.TagNumber(1)
  LeaderboardSortBy get sortBy => $_getN(0);
  @$pb.TagNumber(1)
  set sortBy(LeaderboardSortBy v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasSortBy() => $_has(0);
  @$pb.TagNumber(1)
  void clearSortBy() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get category => $_getSZ(1);
  @$pb.TagNumber(2)
  set category($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCategory() => $_has(1);
  @$pb.TagNumber(2)
  void clearCategory() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get limit => $_getIZ(2);
  @$pb.TagNumber(3)
  set limit($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasLimit() => $_has(2);
  @$pb.TagNumber(3)
  void clearLimit() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get offset => $_getIZ(3);
  @$pb.TagNumber(4)
  set offset($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasOffset() => $_has(3);
  @$pb.TagNumber(4)
  void clearOffset() => clearField(4);
}

class GetCrowdfundLeaderboardResponse extends $pb.GeneratedMessage {
  factory GetCrowdfundLeaderboardResponse({
    $core.Iterable<LeaderboardCrowdfundEntry>? entries,
    $core.int? totalCount,
  }) {
    final $result = create();
    if (entries != null) {
      $result.entries.addAll(entries);
    }
    if (totalCount != null) {
      $result.totalCount = totalCount;
    }
    return $result;
  }
  GetCrowdfundLeaderboardResponse._() : super();
  factory GetCrowdfundLeaderboardResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCrowdfundLeaderboardResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetCrowdfundLeaderboardResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pc<LeaderboardCrowdfundEntry>(1, _omitFieldNames ? '' : 'entries', $pb.PbFieldType.PM, subBuilder: LeaderboardCrowdfundEntry.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'totalCount', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCrowdfundLeaderboardResponse clone() => GetCrowdfundLeaderboardResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCrowdfundLeaderboardResponse copyWith(void Function(GetCrowdfundLeaderboardResponse) updates) => super.copyWith((message) => updates(message as GetCrowdfundLeaderboardResponse)) as GetCrowdfundLeaderboardResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetCrowdfundLeaderboardResponse create() => GetCrowdfundLeaderboardResponse._();
  GetCrowdfundLeaderboardResponse createEmptyInstance() => create();
  static $pb.PbList<GetCrowdfundLeaderboardResponse> createRepeated() => $pb.PbList<GetCrowdfundLeaderboardResponse>();
  @$core.pragma('dart2js:noInline')
  static GetCrowdfundLeaderboardResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetCrowdfundLeaderboardResponse>(create);
  static GetCrowdfundLeaderboardResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<LeaderboardCrowdfundEntry> get entries => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get totalCount => $_getIZ(1);
  @$pb.TagNumber(2)
  set totalCount($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotalCount() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalCount() => clearField(2);
}

class LeaderboardCrowdfundEntry extends $pb.GeneratedMessage {
  factory LeaderboardCrowdfundEntry({
    $core.int? rank,
    CrowdfundMessage? crowdfund,
  }) {
    final $result = create();
    if (rank != null) {
      $result.rank = rank;
    }
    if (crowdfund != null) {
      $result.crowdfund = crowdfund;
    }
    return $result;
  }
  LeaderboardCrowdfundEntry._() : super();
  factory LeaderboardCrowdfundEntry.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LeaderboardCrowdfundEntry.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'LeaderboardCrowdfundEntry', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'rank', $pb.PbFieldType.O3)
    ..aOM<CrowdfundMessage>(2, _omitFieldNames ? '' : 'crowdfund', subBuilder: CrowdfundMessage.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LeaderboardCrowdfundEntry clone() => LeaderboardCrowdfundEntry()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LeaderboardCrowdfundEntry copyWith(void Function(LeaderboardCrowdfundEntry) updates) => super.copyWith((message) => updates(message as LeaderboardCrowdfundEntry)) as LeaderboardCrowdfundEntry;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LeaderboardCrowdfundEntry create() => LeaderboardCrowdfundEntry._();
  LeaderboardCrowdfundEntry createEmptyInstance() => create();
  static $pb.PbList<LeaderboardCrowdfundEntry> createRepeated() => $pb.PbList<LeaderboardCrowdfundEntry>();
  @$core.pragma('dart2js:noInline')
  static LeaderboardCrowdfundEntry getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LeaderboardCrowdfundEntry>(create);
  static LeaderboardCrowdfundEntry? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get rank => $_getIZ(0);
  @$pb.TagNumber(1)
  set rank($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRank() => $_has(0);
  @$pb.TagNumber(1)
  void clearRank() => clearField(1);

  @$pb.TagNumber(2)
  CrowdfundMessage get crowdfund => $_getN(1);
  @$pb.TagNumber(2)
  set crowdfund(CrowdfundMessage v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasCrowdfund() => $_has(1);
  @$pb.TagNumber(2)
  void clearCrowdfund() => clearField(2);
  @$pb.TagNumber(2)
  CrowdfundMessage ensureCrowdfund() => $_ensure(1);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
