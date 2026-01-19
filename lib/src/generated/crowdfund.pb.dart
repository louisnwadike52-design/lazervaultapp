///
//  Generated code. Do not modify.
//  source: crowdfund.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/timestamp.pb.dart' as $36;

import 'crowdfund.pbenum.dart';

export 'crowdfund.pbenum.dart';

class CrowdfundCreatorMessage extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CrowdfundCreatorMessage', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'username')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'firstName')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lastName')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'profilePicture')
    ..aOB(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'verified')
    ..aOM<$36.Timestamp>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'verifiedAt', subBuilder: $36.Timestamp.create)
    ..aOB(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'facialRecognitionEnabled')
    ..hasRequiredFields = false
  ;

  CrowdfundCreatorMessage._() : super();
  factory CrowdfundCreatorMessage({
    $fixnum.Int64? userId,
    $core.String? username,
    $core.String? firstName,
    $core.String? lastName,
    $core.String? profilePicture,
    $core.bool? verified,
    $36.Timestamp? verifiedAt,
    $core.bool? facialRecognitionEnabled,
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
    if (profilePicture != null) {
      _result.profilePicture = profilePicture;
    }
    if (verified != null) {
      _result.verified = verified;
    }
    if (verifiedAt != null) {
      _result.verifiedAt = verifiedAt;
    }
    if (facialRecognitionEnabled != null) {
      _result.facialRecognitionEnabled = facialRecognitionEnabled;
    }
    return _result;
  }
  factory CrowdfundCreatorMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CrowdfundCreatorMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CrowdfundCreatorMessage clone() => CrowdfundCreatorMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CrowdfundCreatorMessage copyWith(void Function(CrowdfundCreatorMessage) updates) => super.copyWith((message) => updates(message as CrowdfundCreatorMessage)) as CrowdfundCreatorMessage; // ignore: deprecated_member_use
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
  $36.Timestamp get verifiedAt => $_getN(6);
  @$pb.TagNumber(7)
  set verifiedAt($36.Timestamp v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasVerifiedAt() => $_has(6);
  @$pb.TagNumber(7)
  void clearVerifiedAt() => clearField(7);
  @$pb.TagNumber(7)
  $36.Timestamp ensureVerifiedAt() => $_ensure(6);

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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CrowdfundMessage', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..a<$fixnum.Int64>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'creatorUserId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<CrowdfundCreatorMessage>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'creator', subBuilder: CrowdfundCreatorMessage.create)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'title')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'story')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'crowdfundCode')
    ..a<$fixnum.Int64>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'targetAmount', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currentAmount', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOM<$36.Timestamp>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'deadline', subBuilder: $36.Timestamp.create)
    ..aOS(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'category')
    ..e<CrowdfundStatus>(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: CrowdfundStatus.CROWDFUND_STATUS_UNSPECIFIED, valueOf: CrowdfundStatus.valueOf, enumValues: CrowdfundStatus.values)
    ..aOS(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'imageUrl')
    ..e<CrowdfundVisibility>(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'visibility', $pb.PbFieldType.OE, defaultOrMaker: CrowdfundVisibility.CROWDFUND_VISIBILITY_UNSPECIFIED, valueOf: CrowdfundVisibility.valueOf, enumValues: CrowdfundVisibility.values)
    ..aOS(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'metadata')
    ..a<$core.int>(17, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'donorCount', $pb.PbFieldType.O3)
    ..a<$core.double>(18, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'progressPercentage', $pb.PbFieldType.OD)
    ..aOM<$36.Timestamp>(19, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $36.Timestamp.create)
    ..aOM<$36.Timestamp>(20, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedAt', subBuilder: $36.Timestamp.create)
    ..pc<CrowdfundDonationMessage>(21, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recentDonations', $pb.PbFieldType.PM, subBuilder: CrowdfundDonationMessage.create)
    ..hasRequiredFields = false
  ;

  CrowdfundMessage._() : super();
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
    $36.Timestamp? deadline,
    $core.String? category,
    CrowdfundStatus? status,
    $core.String? imageUrl,
    CrowdfundVisibility? visibility,
    $core.String? metadata,
    $core.int? donorCount,
    $core.double? progressPercentage,
    $36.Timestamp? createdAt,
    $36.Timestamp? updatedAt,
    $core.Iterable<CrowdfundDonationMessage>? recentDonations,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (creatorUserId != null) {
      _result.creatorUserId = creatorUserId;
    }
    if (creator != null) {
      _result.creator = creator;
    }
    if (title != null) {
      _result.title = title;
    }
    if (description != null) {
      _result.description = description;
    }
    if (story != null) {
      _result.story = story;
    }
    if (crowdfundCode != null) {
      _result.crowdfundCode = crowdfundCode;
    }
    if (targetAmount != null) {
      _result.targetAmount = targetAmount;
    }
    if (currentAmount != null) {
      _result.currentAmount = currentAmount;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (deadline != null) {
      _result.deadline = deadline;
    }
    if (category != null) {
      _result.category = category;
    }
    if (status != null) {
      _result.status = status;
    }
    if (imageUrl != null) {
      _result.imageUrl = imageUrl;
    }
    if (visibility != null) {
      _result.visibility = visibility;
    }
    if (metadata != null) {
      _result.metadata = metadata;
    }
    if (donorCount != null) {
      _result.donorCount = donorCount;
    }
    if (progressPercentage != null) {
      _result.progressPercentage = progressPercentage;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      _result.updatedAt = updatedAt;
    }
    if (recentDonations != null) {
      _result.recentDonations.addAll(recentDonations);
    }
    return _result;
  }
  factory CrowdfundMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CrowdfundMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CrowdfundMessage clone() => CrowdfundMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CrowdfundMessage copyWith(void Function(CrowdfundMessage) updates) => super.copyWith((message) => updates(message as CrowdfundMessage)) as CrowdfundMessage; // ignore: deprecated_member_use
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
  $36.Timestamp get deadline => $_getN(10);
  @$pb.TagNumber(11)
  set deadline($36.Timestamp v) { setField(11, v); }
  @$pb.TagNumber(11)
  $core.bool hasDeadline() => $_has(10);
  @$pb.TagNumber(11)
  void clearDeadline() => clearField(11);
  @$pb.TagNumber(11)
  $36.Timestamp ensureDeadline() => $_ensure(10);

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
  $36.Timestamp get createdAt => $_getN(18);
  @$pb.TagNumber(19)
  set createdAt($36.Timestamp v) { setField(19, v); }
  @$pb.TagNumber(19)
  $core.bool hasCreatedAt() => $_has(18);
  @$pb.TagNumber(19)
  void clearCreatedAt() => clearField(19);
  @$pb.TagNumber(19)
  $36.Timestamp ensureCreatedAt() => $_ensure(18);

  @$pb.TagNumber(20)
  $36.Timestamp get updatedAt => $_getN(19);
  @$pb.TagNumber(20)
  set updatedAt($36.Timestamp v) { setField(20, v); }
  @$pb.TagNumber(20)
  $core.bool hasUpdatedAt() => $_has(19);
  @$pb.TagNumber(20)
  void clearUpdatedAt() => clearField(20);
  @$pb.TagNumber(20)
  $36.Timestamp ensureUpdatedAt() => $_ensure(19);

  @$pb.TagNumber(21)
  $core.List<CrowdfundDonationMessage> get recentDonations => $_getList(20);
}

class CrowdfundDonorMessage extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CrowdfundDonorMessage', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'displayName')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'profilePicture')
    ..aOB(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isAnonymous')
    ..aOB(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isCreator')
    ..hasRequiredFields = false
  ;

  CrowdfundDonorMessage._() : super();
  factory CrowdfundDonorMessage({
    $fixnum.Int64? userId,
    $core.String? displayName,
    $core.String? profilePicture,
    $core.bool? isAnonymous,
    $core.bool? isCreator,
  }) {
    final _result = create();
    if (userId != null) {
      _result.userId = userId;
    }
    if (displayName != null) {
      _result.displayName = displayName;
    }
    if (profilePicture != null) {
      _result.profilePicture = profilePicture;
    }
    if (isAnonymous != null) {
      _result.isAnonymous = isAnonymous;
    }
    if (isCreator != null) {
      _result.isCreator = isCreator;
    }
    return _result;
  }
  factory CrowdfundDonorMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CrowdfundDonorMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CrowdfundDonorMessage clone() => CrowdfundDonorMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CrowdfundDonorMessage copyWith(void Function(CrowdfundDonorMessage) updates) => super.copyWith((message) => updates(message as CrowdfundDonorMessage)) as CrowdfundDonorMessage; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CrowdfundDonationMessage', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'crowdfundId')
    ..a<$fixnum.Int64>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'donorUserId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<CrowdfundDonorMessage>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'donor', subBuilder: CrowdfundDonorMessage.create)
    ..a<$fixnum.Int64>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOM<$36.Timestamp>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'donationDate', subBuilder: $36.Timestamp.create)
    ..e<DonationStatus>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: DonationStatus.DONATION_STATUS_UNSPECIFIED, valueOf: DonationStatus.valueOf, enumValues: DonationStatus.values)
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionId')
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'receiptId')
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOB(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isAnonymous')
    ..aOS(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'paymentMethod')
    ..aOS(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'metadata')
    ..hasRequiredFields = false
  ;

  CrowdfundDonationMessage._() : super();
  factory CrowdfundDonationMessage({
    $core.String? id,
    $core.String? crowdfundId,
    $fixnum.Int64? donorUserId,
    CrowdfundDonorMessage? donor,
    $fixnum.Int64? amount,
    $core.String? currency,
    $36.Timestamp? donationDate,
    DonationStatus? status,
    $core.String? transactionId,
    $core.String? receiptId,
    $core.String? message,
    $core.bool? isAnonymous,
    $core.String? paymentMethod,
    $core.String? metadata,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (crowdfundId != null) {
      _result.crowdfundId = crowdfundId;
    }
    if (donorUserId != null) {
      _result.donorUserId = donorUserId;
    }
    if (donor != null) {
      _result.donor = donor;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (donationDate != null) {
      _result.donationDate = donationDate;
    }
    if (status != null) {
      _result.status = status;
    }
    if (transactionId != null) {
      _result.transactionId = transactionId;
    }
    if (receiptId != null) {
      _result.receiptId = receiptId;
    }
    if (message != null) {
      _result.message = message;
    }
    if (isAnonymous != null) {
      _result.isAnonymous = isAnonymous;
    }
    if (paymentMethod != null) {
      _result.paymentMethod = paymentMethod;
    }
    if (metadata != null) {
      _result.metadata = metadata;
    }
    return _result;
  }
  factory CrowdfundDonationMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CrowdfundDonationMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CrowdfundDonationMessage clone() => CrowdfundDonationMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CrowdfundDonationMessage copyWith(void Function(CrowdfundDonationMessage) updates) => super.copyWith((message) => updates(message as CrowdfundDonationMessage)) as CrowdfundDonationMessage; // ignore: deprecated_member_use
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
  $36.Timestamp get donationDate => $_getN(6);
  @$pb.TagNumber(7)
  set donationDate($36.Timestamp v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasDonationDate() => $_has(6);
  @$pb.TagNumber(7)
  void clearDonationDate() => clearField(7);
  @$pb.TagNumber(7)
  $36.Timestamp ensureDonationDate() => $_ensure(6);

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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CrowdfundReceiptMessage', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'donationId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'crowdfundId')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'crowdfundTitle')
    ..a<$fixnum.Int64>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'donorUserId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'donorName')
    ..a<$fixnum.Int64>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOM<$36.Timestamp>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'donationDate', subBuilder: $36.Timestamp.create)
    ..aOM<$36.Timestamp>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'generatedAt', subBuilder: $36.Timestamp.create)
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'receiptNumber')
    ..aOS(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'receiptData')
    ..hasRequiredFields = false
  ;

  CrowdfundReceiptMessage._() : super();
  factory CrowdfundReceiptMessage({
    $core.String? id,
    $core.String? donationId,
    $core.String? crowdfundId,
    $core.String? crowdfundTitle,
    $fixnum.Int64? donorUserId,
    $core.String? donorName,
    $fixnum.Int64? amount,
    $core.String? currency,
    $36.Timestamp? donationDate,
    $36.Timestamp? generatedAt,
    $core.String? receiptNumber,
    $core.String? receiptData,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (donationId != null) {
      _result.donationId = donationId;
    }
    if (crowdfundId != null) {
      _result.crowdfundId = crowdfundId;
    }
    if (crowdfundTitle != null) {
      _result.crowdfundTitle = crowdfundTitle;
    }
    if (donorUserId != null) {
      _result.donorUserId = donorUserId;
    }
    if (donorName != null) {
      _result.donorName = donorName;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (donationDate != null) {
      _result.donationDate = donationDate;
    }
    if (generatedAt != null) {
      _result.generatedAt = generatedAt;
    }
    if (receiptNumber != null) {
      _result.receiptNumber = receiptNumber;
    }
    if (receiptData != null) {
      _result.receiptData = receiptData;
    }
    return _result;
  }
  factory CrowdfundReceiptMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CrowdfundReceiptMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CrowdfundReceiptMessage clone() => CrowdfundReceiptMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CrowdfundReceiptMessage copyWith(void Function(CrowdfundReceiptMessage) updates) => super.copyWith((message) => updates(message as CrowdfundReceiptMessage)) as CrowdfundReceiptMessage; // ignore: deprecated_member_use
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
  $36.Timestamp get donationDate => $_getN(8);
  @$pb.TagNumber(9)
  set donationDate($36.Timestamp v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasDonationDate() => $_has(8);
  @$pb.TagNumber(9)
  void clearDonationDate() => clearField(9);
  @$pb.TagNumber(9)
  $36.Timestamp ensureDonationDate() => $_ensure(8);

  @$pb.TagNumber(10)
  $36.Timestamp get generatedAt => $_getN(9);
  @$pb.TagNumber(10)
  set generatedAt($36.Timestamp v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasGeneratedAt() => $_has(9);
  @$pb.TagNumber(10)
  void clearGeneratedAt() => clearField(10);
  @$pb.TagNumber(10)
  $36.Timestamp ensureGeneratedAt() => $_ensure(9);

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

class CreateCrowdfundRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateCrowdfundRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'title')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'story')
    ..a<$fixnum.Int64>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'targetAmount', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOM<$36.Timestamp>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'deadline', subBuilder: $36.Timestamp.create)
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'category')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'imageUrl')
    ..e<CrowdfundVisibility>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'visibility', $pb.PbFieldType.OE, defaultOrMaker: CrowdfundVisibility.CROWDFUND_VISIBILITY_UNSPECIFIED, valueOf: CrowdfundVisibility.valueOf, enumValues: CrowdfundVisibility.values)
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'metadata')
    ..hasRequiredFields = false
  ;

  CreateCrowdfundRequest._() : super();
  factory CreateCrowdfundRequest({
    $core.String? title,
    $core.String? description,
    $core.String? story,
    $fixnum.Int64? targetAmount,
    $core.String? currency,
    $36.Timestamp? deadline,
    $core.String? category,
    $core.String? imageUrl,
    CrowdfundVisibility? visibility,
    $core.String? metadata,
  }) {
    final _result = create();
    if (title != null) {
      _result.title = title;
    }
    if (description != null) {
      _result.description = description;
    }
    if (story != null) {
      _result.story = story;
    }
    if (targetAmount != null) {
      _result.targetAmount = targetAmount;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (deadline != null) {
      _result.deadline = deadline;
    }
    if (category != null) {
      _result.category = category;
    }
    if (imageUrl != null) {
      _result.imageUrl = imageUrl;
    }
    if (visibility != null) {
      _result.visibility = visibility;
    }
    if (metadata != null) {
      _result.metadata = metadata;
    }
    return _result;
  }
  factory CreateCrowdfundRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateCrowdfundRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateCrowdfundRequest clone() => CreateCrowdfundRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateCrowdfundRequest copyWith(void Function(CreateCrowdfundRequest) updates) => super.copyWith((message) => updates(message as CreateCrowdfundRequest)) as CreateCrowdfundRequest; // ignore: deprecated_member_use
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
  $36.Timestamp get deadline => $_getN(5);
  @$pb.TagNumber(6)
  set deadline($36.Timestamp v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasDeadline() => $_has(5);
  @$pb.TagNumber(6)
  void clearDeadline() => clearField(6);
  @$pb.TagNumber(6)
  $36.Timestamp ensureDeadline() => $_ensure(5);

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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateCrowdfundResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<CrowdfundMessage>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'crowdfund', subBuilder: CrowdfundMessage.create)
    ..hasRequiredFields = false
  ;

  CreateCrowdfundResponse._() : super();
  factory CreateCrowdfundResponse({
    CrowdfundMessage? crowdfund,
  }) {
    final _result = create();
    if (crowdfund != null) {
      _result.crowdfund = crowdfund;
    }
    return _result;
  }
  factory CreateCrowdfundResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateCrowdfundResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateCrowdfundResponse clone() => CreateCrowdfundResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateCrowdfundResponse copyWith(void Function(CreateCrowdfundResponse) updates) => super.copyWith((message) => updates(message as CreateCrowdfundResponse)) as CreateCrowdfundResponse; // ignore: deprecated_member_use
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

class GetCrowdfundRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetCrowdfundRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'crowdfundId')
    ..hasRequiredFields = false
  ;

  GetCrowdfundRequest._() : super();
  factory GetCrowdfundRequest({
    $core.String? crowdfundId,
  }) {
    final _result = create();
    if (crowdfundId != null) {
      _result.crowdfundId = crowdfundId;
    }
    return _result;
  }
  factory GetCrowdfundRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCrowdfundRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCrowdfundRequest clone() => GetCrowdfundRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCrowdfundRequest copyWith(void Function(GetCrowdfundRequest) updates) => super.copyWith((message) => updates(message as GetCrowdfundRequest)) as GetCrowdfundRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetCrowdfundResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<CrowdfundMessage>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'crowdfund', subBuilder: CrowdfundMessage.create)
    ..hasRequiredFields = false
  ;

  GetCrowdfundResponse._() : super();
  factory GetCrowdfundResponse({
    CrowdfundMessage? crowdfund,
  }) {
    final _result = create();
    if (crowdfund != null) {
      _result.crowdfund = crowdfund;
    }
    return _result;
  }
  factory GetCrowdfundResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCrowdfundResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCrowdfundResponse clone() => GetCrowdfundResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCrowdfundResponse copyWith(void Function(GetCrowdfundResponse) updates) => super.copyWith((message) => updates(message as GetCrowdfundResponse)) as GetCrowdfundResponse; // ignore: deprecated_member_use
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

class ListCrowdfundsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ListCrowdfundsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'category')
    ..aOB(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'myCrowdfundsOnly')
    ..hasRequiredFields = false
  ;

  ListCrowdfundsRequest._() : super();
  factory ListCrowdfundsRequest({
    $core.int? page,
    $core.int? pageSize,
    $core.String? status,
    $core.String? category,
    $core.bool? myCrowdfundsOnly,
  }) {
    final _result = create();
    if (page != null) {
      _result.page = page;
    }
    if (pageSize != null) {
      _result.pageSize = pageSize;
    }
    if (status != null) {
      _result.status = status;
    }
    if (category != null) {
      _result.category = category;
    }
    if (myCrowdfundsOnly != null) {
      _result.myCrowdfundsOnly = myCrowdfundsOnly;
    }
    return _result;
  }
  factory ListCrowdfundsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListCrowdfundsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListCrowdfundsRequest clone() => ListCrowdfundsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListCrowdfundsRequest copyWith(void Function(ListCrowdfundsRequest) updates) => super.copyWith((message) => updates(message as ListCrowdfundsRequest)) as ListCrowdfundsRequest; // ignore: deprecated_member_use
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
}

class ListCrowdfundsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ListCrowdfundsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<CrowdfundMessage>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'crowdfunds', $pb.PbFieldType.PM, subBuilder: CrowdfundMessage.create)
    ..aOM<CrowdfundPaginationInfo>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pagination', subBuilder: CrowdfundPaginationInfo.create)
    ..hasRequiredFields = false
  ;

  ListCrowdfundsResponse._() : super();
  factory ListCrowdfundsResponse({
    $core.Iterable<CrowdfundMessage>? crowdfunds,
    CrowdfundPaginationInfo? pagination,
  }) {
    final _result = create();
    if (crowdfunds != null) {
      _result.crowdfunds.addAll(crowdfunds);
    }
    if (pagination != null) {
      _result.pagination = pagination;
    }
    return _result;
  }
  factory ListCrowdfundsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListCrowdfundsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListCrowdfundsResponse clone() => ListCrowdfundsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListCrowdfundsResponse copyWith(void Function(ListCrowdfundsResponse) updates) => super.copyWith((message) => updates(message as ListCrowdfundsResponse)) as ListCrowdfundsResponse; // ignore: deprecated_member_use
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

class SearchCrowdfundsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SearchCrowdfundsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'query')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  SearchCrowdfundsRequest._() : super();
  factory SearchCrowdfundsRequest({
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
  factory SearchCrowdfundsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SearchCrowdfundsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SearchCrowdfundsRequest clone() => SearchCrowdfundsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SearchCrowdfundsRequest copyWith(void Function(SearchCrowdfundsRequest) updates) => super.copyWith((message) => updates(message as SearchCrowdfundsRequest)) as SearchCrowdfundsRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SearchCrowdfundsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<CrowdfundMessage>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'crowdfunds', $pb.PbFieldType.PM, subBuilder: CrowdfundMessage.create)
    ..hasRequiredFields = false
  ;

  SearchCrowdfundsResponse._() : super();
  factory SearchCrowdfundsResponse({
    $core.Iterable<CrowdfundMessage>? crowdfunds,
  }) {
    final _result = create();
    if (crowdfunds != null) {
      _result.crowdfunds.addAll(crowdfunds);
    }
    return _result;
  }
  factory SearchCrowdfundsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SearchCrowdfundsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SearchCrowdfundsResponse clone() => SearchCrowdfundsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SearchCrowdfundsResponse copyWith(void Function(SearchCrowdfundsResponse) updates) => super.copyWith((message) => updates(message as SearchCrowdfundsResponse)) as SearchCrowdfundsResponse; // ignore: deprecated_member_use
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

class UpdateCrowdfundRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateCrowdfundRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'crowdfundId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'title')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'story')
    ..aOM<$36.Timestamp>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'deadline', subBuilder: $36.Timestamp.create)
    ..e<CrowdfundStatus>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: CrowdfundStatus.CROWDFUND_STATUS_UNSPECIFIED, valueOf: CrowdfundStatus.valueOf, enumValues: CrowdfundStatus.values)
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'imageUrl')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'metadata')
    ..hasRequiredFields = false
  ;

  UpdateCrowdfundRequest._() : super();
  factory UpdateCrowdfundRequest({
    $core.String? crowdfundId,
    $core.String? title,
    $core.String? description,
    $core.String? story,
    $36.Timestamp? deadline,
    CrowdfundStatus? status,
    $core.String? imageUrl,
    $core.String? metadata,
  }) {
    final _result = create();
    if (crowdfundId != null) {
      _result.crowdfundId = crowdfundId;
    }
    if (title != null) {
      _result.title = title;
    }
    if (description != null) {
      _result.description = description;
    }
    if (story != null) {
      _result.story = story;
    }
    if (deadline != null) {
      _result.deadline = deadline;
    }
    if (status != null) {
      _result.status = status;
    }
    if (imageUrl != null) {
      _result.imageUrl = imageUrl;
    }
    if (metadata != null) {
      _result.metadata = metadata;
    }
    return _result;
  }
  factory UpdateCrowdfundRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateCrowdfundRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateCrowdfundRequest clone() => UpdateCrowdfundRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateCrowdfundRequest copyWith(void Function(UpdateCrowdfundRequest) updates) => super.copyWith((message) => updates(message as UpdateCrowdfundRequest)) as UpdateCrowdfundRequest; // ignore: deprecated_member_use
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
  $36.Timestamp get deadline => $_getN(4);
  @$pb.TagNumber(5)
  set deadline($36.Timestamp v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasDeadline() => $_has(4);
  @$pb.TagNumber(5)
  void clearDeadline() => clearField(5);
  @$pb.TagNumber(5)
  $36.Timestamp ensureDeadline() => $_ensure(4);

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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateCrowdfundResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<CrowdfundMessage>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'crowdfund', subBuilder: CrowdfundMessage.create)
    ..hasRequiredFields = false
  ;

  UpdateCrowdfundResponse._() : super();
  factory UpdateCrowdfundResponse({
    CrowdfundMessage? crowdfund,
  }) {
    final _result = create();
    if (crowdfund != null) {
      _result.crowdfund = crowdfund;
    }
    return _result;
  }
  factory UpdateCrowdfundResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateCrowdfundResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateCrowdfundResponse clone() => UpdateCrowdfundResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateCrowdfundResponse copyWith(void Function(UpdateCrowdfundResponse) updates) => super.copyWith((message) => updates(message as UpdateCrowdfundResponse)) as UpdateCrowdfundResponse; // ignore: deprecated_member_use
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

class DeleteCrowdfundRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DeleteCrowdfundRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'crowdfundId')
    ..hasRequiredFields = false
  ;

  DeleteCrowdfundRequest._() : super();
  factory DeleteCrowdfundRequest({
    $core.String? crowdfundId,
  }) {
    final _result = create();
    if (crowdfundId != null) {
      _result.crowdfundId = crowdfundId;
    }
    return _result;
  }
  factory DeleteCrowdfundRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteCrowdfundRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteCrowdfundRequest clone() => DeleteCrowdfundRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteCrowdfundRequest copyWith(void Function(DeleteCrowdfundRequest) updates) => super.copyWith((message) => updates(message as DeleteCrowdfundRequest)) as DeleteCrowdfundRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DeleteCrowdfundResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  DeleteCrowdfundResponse._() : super();
  factory DeleteCrowdfundResponse({
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
  factory DeleteCrowdfundResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteCrowdfundResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteCrowdfundResponse clone() => DeleteCrowdfundResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteCrowdfundResponse copyWith(void Function(DeleteCrowdfundResponse) updates) => super.copyWith((message) => updates(message as DeleteCrowdfundResponse)) as DeleteCrowdfundResponse; // ignore: deprecated_member_use
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

class MakeDonationRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MakeDonationRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'crowdfundId')
    ..a<$fixnum.Int64>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOB(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isAnonymous')
    ..a<$fixnum.Int64>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sourceAccountId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  MakeDonationRequest._() : super();
  factory MakeDonationRequest({
    $core.String? crowdfundId,
    $fixnum.Int64? amount,
    $core.String? message,
    $core.bool? isAnonymous,
    $fixnum.Int64? sourceAccountId,
  }) {
    final _result = create();
    if (crowdfundId != null) {
      _result.crowdfundId = crowdfundId;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (message != null) {
      _result.message = message;
    }
    if (isAnonymous != null) {
      _result.isAnonymous = isAnonymous;
    }
    if (sourceAccountId != null) {
      _result.sourceAccountId = sourceAccountId;
    }
    return _result;
  }
  factory MakeDonationRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MakeDonationRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MakeDonationRequest clone() => MakeDonationRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MakeDonationRequest copyWith(void Function(MakeDonationRequest) updates) => super.copyWith((message) => updates(message as MakeDonationRequest)) as MakeDonationRequest; // ignore: deprecated_member_use
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
  $fixnum.Int64 get sourceAccountId => $_getI64(4);
  @$pb.TagNumber(5)
  set sourceAccountId($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasSourceAccountId() => $_has(4);
  @$pb.TagNumber(5)
  void clearSourceAccountId() => clearField(5);
}

class MakeDonationResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MakeDonationResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<CrowdfundDonationMessage>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'donation', subBuilder: CrowdfundDonationMessage.create)
    ..hasRequiredFields = false
  ;

  MakeDonationResponse._() : super();
  factory MakeDonationResponse({
    CrowdfundDonationMessage? donation,
  }) {
    final _result = create();
    if (donation != null) {
      _result.donation = donation;
    }
    return _result;
  }
  factory MakeDonationResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MakeDonationResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MakeDonationResponse clone() => MakeDonationResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MakeDonationResponse copyWith(void Function(MakeDonationResponse) updates) => super.copyWith((message) => updates(message as MakeDonationResponse)) as MakeDonationResponse; // ignore: deprecated_member_use
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

class GetCrowdfundDonationsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetCrowdfundDonationsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'crowdfundId')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetCrowdfundDonationsRequest._() : super();
  factory GetCrowdfundDonationsRequest({
    $core.String? crowdfundId,
    $core.int? page,
    $core.int? pageSize,
  }) {
    final _result = create();
    if (crowdfundId != null) {
      _result.crowdfundId = crowdfundId;
    }
    if (page != null) {
      _result.page = page;
    }
    if (pageSize != null) {
      _result.pageSize = pageSize;
    }
    return _result;
  }
  factory GetCrowdfundDonationsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCrowdfundDonationsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCrowdfundDonationsRequest clone() => GetCrowdfundDonationsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCrowdfundDonationsRequest copyWith(void Function(GetCrowdfundDonationsRequest) updates) => super.copyWith((message) => updates(message as GetCrowdfundDonationsRequest)) as GetCrowdfundDonationsRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetCrowdfundDonationsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<CrowdfundDonationMessage>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'donations', $pb.PbFieldType.PM, subBuilder: CrowdfundDonationMessage.create)
    ..aOM<DonationPaginationInfo>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pagination', subBuilder: DonationPaginationInfo.create)
    ..hasRequiredFields = false
  ;

  GetCrowdfundDonationsResponse._() : super();
  factory GetCrowdfundDonationsResponse({
    $core.Iterable<CrowdfundDonationMessage>? donations,
    DonationPaginationInfo? pagination,
  }) {
    final _result = create();
    if (donations != null) {
      _result.donations.addAll(donations);
    }
    if (pagination != null) {
      _result.pagination = pagination;
    }
    return _result;
  }
  factory GetCrowdfundDonationsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCrowdfundDonationsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCrowdfundDonationsResponse clone() => GetCrowdfundDonationsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCrowdfundDonationsResponse copyWith(void Function(GetCrowdfundDonationsResponse) updates) => super.copyWith((message) => updates(message as GetCrowdfundDonationsResponse)) as GetCrowdfundDonationsResponse; // ignore: deprecated_member_use
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

class GetUserDonationsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetUserDonationsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetUserDonationsRequest._() : super();
  factory GetUserDonationsRequest({
    $core.int? page,
    $core.int? pageSize,
  }) {
    final _result = create();
    if (page != null) {
      _result.page = page;
    }
    if (pageSize != null) {
      _result.pageSize = pageSize;
    }
    return _result;
  }
  factory GetUserDonationsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUserDonationsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUserDonationsRequest clone() => GetUserDonationsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUserDonationsRequest copyWith(void Function(GetUserDonationsRequest) updates) => super.copyWith((message) => updates(message as GetUserDonationsRequest)) as GetUserDonationsRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetUserDonationsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<CrowdfundDonationMessage>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'donations', $pb.PbFieldType.PM, subBuilder: CrowdfundDonationMessage.create)
    ..aOM<DonationPaginationInfo>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pagination', subBuilder: DonationPaginationInfo.create)
    ..hasRequiredFields = false
  ;

  GetUserDonationsResponse._() : super();
  factory GetUserDonationsResponse({
    $core.Iterable<CrowdfundDonationMessage>? donations,
    DonationPaginationInfo? pagination,
  }) {
    final _result = create();
    if (donations != null) {
      _result.donations.addAll(donations);
    }
    if (pagination != null) {
      _result.pagination = pagination;
    }
    return _result;
  }
  factory GetUserDonationsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUserDonationsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUserDonationsResponse clone() => GetUserDonationsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUserDonationsResponse copyWith(void Function(GetUserDonationsResponse) updates) => super.copyWith((message) => updates(message as GetUserDonationsResponse)) as GetUserDonationsResponse; // ignore: deprecated_member_use
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

class GenerateDonationReceiptRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GenerateDonationReceiptRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'donationId')
    ..hasRequiredFields = false
  ;

  GenerateDonationReceiptRequest._() : super();
  factory GenerateDonationReceiptRequest({
    $core.String? donationId,
  }) {
    final _result = create();
    if (donationId != null) {
      _result.donationId = donationId;
    }
    return _result;
  }
  factory GenerateDonationReceiptRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GenerateDonationReceiptRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GenerateDonationReceiptRequest clone() => GenerateDonationReceiptRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GenerateDonationReceiptRequest copyWith(void Function(GenerateDonationReceiptRequest) updates) => super.copyWith((message) => updates(message as GenerateDonationReceiptRequest)) as GenerateDonationReceiptRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GenerateDonationReceiptResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<CrowdfundReceiptMessage>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'receipt', subBuilder: CrowdfundReceiptMessage.create)
    ..hasRequiredFields = false
  ;

  GenerateDonationReceiptResponse._() : super();
  factory GenerateDonationReceiptResponse({
    CrowdfundReceiptMessage? receipt,
  }) {
    final _result = create();
    if (receipt != null) {
      _result.receipt = receipt;
    }
    return _result;
  }
  factory GenerateDonationReceiptResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GenerateDonationReceiptResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GenerateDonationReceiptResponse clone() => GenerateDonationReceiptResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GenerateDonationReceiptResponse copyWith(void Function(GenerateDonationReceiptResponse) updates) => super.copyWith((message) => updates(message as GenerateDonationReceiptResponse)) as GenerateDonationReceiptResponse; // ignore: deprecated_member_use
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

class GetUserCrowdfundReceiptsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetUserCrowdfundReceiptsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetUserCrowdfundReceiptsRequest._() : super();
  factory GetUserCrowdfundReceiptsRequest({
    $core.int? page,
    $core.int? pageSize,
  }) {
    final _result = create();
    if (page != null) {
      _result.page = page;
    }
    if (pageSize != null) {
      _result.pageSize = pageSize;
    }
    return _result;
  }
  factory GetUserCrowdfundReceiptsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUserCrowdfundReceiptsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUserCrowdfundReceiptsRequest clone() => GetUserCrowdfundReceiptsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUserCrowdfundReceiptsRequest copyWith(void Function(GetUserCrowdfundReceiptsRequest) updates) => super.copyWith((message) => updates(message as GetUserCrowdfundReceiptsRequest)) as GetUserCrowdfundReceiptsRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetUserCrowdfundReceiptsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<CrowdfundReceiptMessage>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'receipts', $pb.PbFieldType.PM, subBuilder: CrowdfundReceiptMessage.create)
    ..aOM<CrowdfundReceiptPaginationInfo>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pagination', subBuilder: CrowdfundReceiptPaginationInfo.create)
    ..hasRequiredFields = false
  ;

  GetUserCrowdfundReceiptsResponse._() : super();
  factory GetUserCrowdfundReceiptsResponse({
    $core.Iterable<CrowdfundReceiptMessage>? receipts,
    CrowdfundReceiptPaginationInfo? pagination,
  }) {
    final _result = create();
    if (receipts != null) {
      _result.receipts.addAll(receipts);
    }
    if (pagination != null) {
      _result.pagination = pagination;
    }
    return _result;
  }
  factory GetUserCrowdfundReceiptsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUserCrowdfundReceiptsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUserCrowdfundReceiptsResponse clone() => GetUserCrowdfundReceiptsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUserCrowdfundReceiptsResponse copyWith(void Function(GetUserCrowdfundReceiptsResponse) updates) => super.copyWith((message) => updates(message as GetUserCrowdfundReceiptsResponse)) as GetUserCrowdfundReceiptsResponse; // ignore: deprecated_member_use
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

class GetCrowdfundStatisticsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetCrowdfundStatisticsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'crowdfundId')
    ..hasRequiredFields = false
  ;

  GetCrowdfundStatisticsRequest._() : super();
  factory GetCrowdfundStatisticsRequest({
    $core.String? crowdfundId,
  }) {
    final _result = create();
    if (crowdfundId != null) {
      _result.crowdfundId = crowdfundId;
    }
    return _result;
  }
  factory GetCrowdfundStatisticsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCrowdfundStatisticsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCrowdfundStatisticsRequest clone() => GetCrowdfundStatisticsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCrowdfundStatisticsRequest copyWith(void Function(GetCrowdfundStatisticsRequest) updates) => super.copyWith((message) => updates(message as GetCrowdfundStatisticsRequest)) as GetCrowdfundStatisticsRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetCrowdfundStatisticsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'crowdfundId')
    ..a<$fixnum.Int64>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalRaised', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'targetAmount', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'progressPercentage', $pb.PbFieldType.OD)
    ..a<$core.int>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'donorCount', $pb.PbFieldType.O3)
    ..a<$fixnum.Int64>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'averageDonation', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'largestDonation', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'daysRemaining', $pb.PbFieldType.O3)
    ..aOB(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isCompleted')
    ..aOM<$36.Timestamp>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $36.Timestamp.create)
    ..hasRequiredFields = false
  ;

  GetCrowdfundStatisticsResponse._() : super();
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
    $36.Timestamp? createdAt,
  }) {
    final _result = create();
    if (crowdfundId != null) {
      _result.crowdfundId = crowdfundId;
    }
    if (totalRaised != null) {
      _result.totalRaised = totalRaised;
    }
    if (targetAmount != null) {
      _result.targetAmount = targetAmount;
    }
    if (progressPercentage != null) {
      _result.progressPercentage = progressPercentage;
    }
    if (donorCount != null) {
      _result.donorCount = donorCount;
    }
    if (averageDonation != null) {
      _result.averageDonation = averageDonation;
    }
    if (largestDonation != null) {
      _result.largestDonation = largestDonation;
    }
    if (daysRemaining != null) {
      _result.daysRemaining = daysRemaining;
    }
    if (isCompleted != null) {
      _result.isCompleted = isCompleted;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    return _result;
  }
  factory GetCrowdfundStatisticsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCrowdfundStatisticsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCrowdfundStatisticsResponse clone() => GetCrowdfundStatisticsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCrowdfundStatisticsResponse copyWith(void Function(GetCrowdfundStatisticsResponse) updates) => super.copyWith((message) => updates(message as GetCrowdfundStatisticsResponse)) as GetCrowdfundStatisticsResponse; // ignore: deprecated_member_use
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
  $36.Timestamp get createdAt => $_getN(9);
  @$pb.TagNumber(10)
  set createdAt($36.Timestamp v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasCreatedAt() => $_has(9);
  @$pb.TagNumber(10)
  void clearCreatedAt() => clearField(10);
  @$pb.TagNumber(10)
  $36.Timestamp ensureCreatedAt() => $_ensure(9);
}

class CrowdfundPaginationInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CrowdfundPaginationInfo', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currentPage', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalPages', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalItems', $pb.PbFieldType.O3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'itemsPerPage', $pb.PbFieldType.O3)
    ..aOB(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hasNext')
    ..aOB(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hasPrev')
    ..hasRequiredFields = false
  ;

  CrowdfundPaginationInfo._() : super();
  factory CrowdfundPaginationInfo({
    $core.int? currentPage,
    $core.int? totalPages,
    $core.int? totalItems,
    $core.int? itemsPerPage,
    $core.bool? hasNext,
    $core.bool? hasPrev,
  }) {
    final _result = create();
    if (currentPage != null) {
      _result.currentPage = currentPage;
    }
    if (totalPages != null) {
      _result.totalPages = totalPages;
    }
    if (totalItems != null) {
      _result.totalItems = totalItems;
    }
    if (itemsPerPage != null) {
      _result.itemsPerPage = itemsPerPage;
    }
    if (hasNext != null) {
      _result.hasNext = hasNext;
    }
    if (hasPrev != null) {
      _result.hasPrev = hasPrev;
    }
    return _result;
  }
  factory CrowdfundPaginationInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CrowdfundPaginationInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CrowdfundPaginationInfo clone() => CrowdfundPaginationInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CrowdfundPaginationInfo copyWith(void Function(CrowdfundPaginationInfo) updates) => super.copyWith((message) => updates(message as CrowdfundPaginationInfo)) as CrowdfundPaginationInfo; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DonationPaginationInfo', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currentPage', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalPages', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalItems', $pb.PbFieldType.O3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'itemsPerPage', $pb.PbFieldType.O3)
    ..aOB(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hasNext')
    ..aOB(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hasPrev')
    ..hasRequiredFields = false
  ;

  DonationPaginationInfo._() : super();
  factory DonationPaginationInfo({
    $core.int? currentPage,
    $core.int? totalPages,
    $core.int? totalItems,
    $core.int? itemsPerPage,
    $core.bool? hasNext,
    $core.bool? hasPrev,
  }) {
    final _result = create();
    if (currentPage != null) {
      _result.currentPage = currentPage;
    }
    if (totalPages != null) {
      _result.totalPages = totalPages;
    }
    if (totalItems != null) {
      _result.totalItems = totalItems;
    }
    if (itemsPerPage != null) {
      _result.itemsPerPage = itemsPerPage;
    }
    if (hasNext != null) {
      _result.hasNext = hasNext;
    }
    if (hasPrev != null) {
      _result.hasPrev = hasPrev;
    }
    return _result;
  }
  factory DonationPaginationInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DonationPaginationInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DonationPaginationInfo clone() => DonationPaginationInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DonationPaginationInfo copyWith(void Function(DonationPaginationInfo) updates) => super.copyWith((message) => updates(message as DonationPaginationInfo)) as DonationPaginationInfo; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CrowdfundReceiptPaginationInfo', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currentPage', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalPages', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalItems', $pb.PbFieldType.O3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'itemsPerPage', $pb.PbFieldType.O3)
    ..aOB(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hasNext')
    ..aOB(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hasPrev')
    ..hasRequiredFields = false
  ;

  CrowdfundReceiptPaginationInfo._() : super();
  factory CrowdfundReceiptPaginationInfo({
    $core.int? currentPage,
    $core.int? totalPages,
    $core.int? totalItems,
    $core.int? itemsPerPage,
    $core.bool? hasNext,
    $core.bool? hasPrev,
  }) {
    final _result = create();
    if (currentPage != null) {
      _result.currentPage = currentPage;
    }
    if (totalPages != null) {
      _result.totalPages = totalPages;
    }
    if (totalItems != null) {
      _result.totalItems = totalItems;
    }
    if (itemsPerPage != null) {
      _result.itemsPerPage = itemsPerPage;
    }
    if (hasNext != null) {
      _result.hasNext = hasNext;
    }
    if (hasPrev != null) {
      _result.hasPrev = hasPrev;
    }
    return _result;
  }
  factory CrowdfundReceiptPaginationInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CrowdfundReceiptPaginationInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CrowdfundReceiptPaginationInfo clone() => CrowdfundReceiptPaginationInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CrowdfundReceiptPaginationInfo copyWith(void Function(CrowdfundReceiptPaginationInfo) updates) => super.copyWith((message) => updates(message as CrowdfundReceiptPaginationInfo)) as CrowdfundReceiptPaginationInfo; // ignore: deprecated_member_use
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

