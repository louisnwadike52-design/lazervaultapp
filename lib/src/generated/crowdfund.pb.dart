///
//  Generated code. Do not modify.
//  source: crowdfund.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/timestamp.pb.dart' as $1;

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
    ..aOM<$1.Timestamp>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'verifiedAt', subBuilder: $1.Timestamp.create)
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
    $1.Timestamp? verifiedAt,
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
    ..aOM<$1.Timestamp>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'deadline', subBuilder: $1.Timestamp.create)
    ..aOS(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'category')
    ..e<CrowdfundStatus>(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: CrowdfundStatus.CROWDFUND_STATUS_UNSPECIFIED, valueOf: CrowdfundStatus.valueOf, enumValues: CrowdfundStatus.values)
    ..aOS(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'imageUrl')
    ..e<CrowdfundVisibility>(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'visibility', $pb.PbFieldType.OE, defaultOrMaker: CrowdfundVisibility.CROWDFUND_VISIBILITY_UNSPECIFIED, valueOf: CrowdfundVisibility.valueOf, enumValues: CrowdfundVisibility.values)
    ..aOS(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'metadata')
    ..a<$core.int>(17, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'donorCount', $pb.PbFieldType.O3)
    ..a<$core.double>(18, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'progressPercentage', $pb.PbFieldType.OD)
    ..aOM<$1.Timestamp>(19, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(20, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedAt', subBuilder: $1.Timestamp.create)
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
    ..aOM<$1.Timestamp>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'donationDate', subBuilder: $1.Timestamp.create)
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
    $1.Timestamp? donationDate,
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CrowdfundReceiptMessage', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'donationId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'crowdfundId')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'crowdfundTitle')
    ..a<$fixnum.Int64>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'donorUserId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'donorName')
    ..a<$fixnum.Int64>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOM<$1.Timestamp>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'donationDate', subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'generatedAt', subBuilder: $1.Timestamp.create)
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
    $1.Timestamp? donationDate,
    $1.Timestamp? generatedAt,
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

class CreateCrowdfundRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateCrowdfundRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'title')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'story')
    ..a<$fixnum.Int64>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'targetAmount', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOM<$1.Timestamp>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'deadline', subBuilder: $1.Timestamp.create)
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
    $1.Timestamp? deadline,
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
    ..aOM<$1.Timestamp>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'deadline', subBuilder: $1.Timestamp.create)
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
    $1.Timestamp? deadline,
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
    ..aOM<$1.Timestamp>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $1.Timestamp.create)
    ..a<$core.int>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'uniqueDonors', $pb.PbFieldType.O3)
    ..a<$fixnum.Int64>(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'smallestDonation', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..pc<ContributorLeaderboardEntry>(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'topContributors', $pb.PbFieldType.PM, subBuilder: ContributorLeaderboardEntry.create)
    ..pc<DailyProgressEntry>(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dailyProgress', $pb.PbFieldType.PM, subBuilder: DailyProgressEntry.create)
    ..a<$core.double>(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fundingVelocity', $pb.PbFieldType.OD)
    ..aOS(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'projectedCompletionDate')
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
    $1.Timestamp? createdAt,
    $core.int? uniqueDonors,
    $fixnum.Int64? smallestDonation,
    $core.Iterable<ContributorLeaderboardEntry>? topContributors,
    $core.Iterable<DailyProgressEntry>? dailyProgress,
    $core.double? fundingVelocity,
    $core.String? projectedCompletionDate,
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
    if (uniqueDonors != null) {
      _result.uniqueDonors = uniqueDonors;
    }
    if (smallestDonation != null) {
      _result.smallestDonation = smallestDonation;
    }
    if (topContributors != null) {
      _result.topContributors.addAll(topContributors);
    }
    if (dailyProgress != null) {
      _result.dailyProgress.addAll(dailyProgress);
    }
    if (fundingVelocity != null) {
      _result.fundingVelocity = fundingVelocity;
    }
    if (projectedCompletionDate != null) {
      _result.projectedCompletionDate = projectedCompletionDate;
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

class ContributorLeaderboardEntry extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ContributorLeaderboardEntry', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'rank', $pb.PbFieldType.O3)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'displayName')
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalAmount', $pb.PbFieldType.OD)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'contributionCount', $pb.PbFieldType.O3)
    ..aOB(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isAnonymous')
    ..hasRequiredFields = false
  ;

  ContributorLeaderboardEntry._() : super();
  factory ContributorLeaderboardEntry({
    $core.int? rank,
    $core.String? displayName,
    $core.double? totalAmount,
    $core.int? contributionCount,
    $core.bool? isAnonymous,
  }) {
    final _result = create();
    if (rank != null) {
      _result.rank = rank;
    }
    if (displayName != null) {
      _result.displayName = displayName;
    }
    if (totalAmount != null) {
      _result.totalAmount = totalAmount;
    }
    if (contributionCount != null) {
      _result.contributionCount = contributionCount;
    }
    if (isAnonymous != null) {
      _result.isAnonymous = isAnonymous;
    }
    return _result;
  }
  factory ContributorLeaderboardEntry.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ContributorLeaderboardEntry.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ContributorLeaderboardEntry clone() => ContributorLeaderboardEntry()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ContributorLeaderboardEntry copyWith(void Function(ContributorLeaderboardEntry) updates) => super.copyWith((message) => updates(message as ContributorLeaderboardEntry)) as ContributorLeaderboardEntry; // ignore: deprecated_member_use
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

class DailyProgressEntry extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DailyProgressEntry', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'date')
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'donationCount', $pb.PbFieldType.O3)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cumulativeAmount', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  DailyProgressEntry._() : super();
  factory DailyProgressEntry({
    $core.String? date,
    $core.double? amount,
    $core.int? donationCount,
    $core.double? cumulativeAmount,
  }) {
    final _result = create();
    if (date != null) {
      _result.date = date;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (donationCount != null) {
      _result.donationCount = donationCount;
    }
    if (cumulativeAmount != null) {
      _result.cumulativeAmount = cumulativeAmount;
    }
    return _result;
  }
  factory DailyProgressEntry.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DailyProgressEntry.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DailyProgressEntry clone() => DailyProgressEntry()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DailyProgressEntry copyWith(void Function(DailyProgressEntry) updates) => super.copyWith((message) => updates(message as DailyProgressEntry)) as DailyProgressEntry; // ignore: deprecated_member_use
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

class NotificationChannelMessage extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'NotificationChannelMessage', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'crowdfundId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'creatorUserId')
    ..e<NotificationChannelType>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'channelType', $pb.PbFieldType.OE, defaultOrMaker: NotificationChannelType.NOTIFICATION_CHANNEL_TYPE_UNSPECIFIED, valueOf: NotificationChannelType.valueOf, enumValues: NotificationChannelType.values)
    ..e<NotificationChannelStatus>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: NotificationChannelStatus.NOTIFICATION_CHANNEL_STATUS_UNSPECIFIED, valueOf: NotificationChannelStatus.valueOf, enumValues: NotificationChannelStatus.values)
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'channelName')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'channelUsername')
    ..pc<NotificationEventType>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'enabledEvents', $pb.PbFieldType.KE, valueOf: NotificationEventType.valueOf, enumValues: NotificationEventType.values, defaultEnumValue: NotificationEventType.NOTIFICATION_EVENT_TYPE_UNSPECIFIED)
    ..aOM<NotificationPreferencesMessage>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'preferences', subBuilder: NotificationPreferencesMessage.create)
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lastNotificationAt')
    ..a<$core.int>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'notificationCount', $pb.PbFieldType.O3)
    ..a<$core.int>(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'failureCount', $pb.PbFieldType.O3)
    ..aOS(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lastError')
    ..aOS(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt')
    ..aOS(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedAt')
    ..hasRequiredFields = false
  ;

  NotificationChannelMessage._() : super();
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
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (crowdfundId != null) {
      _result.crowdfundId = crowdfundId;
    }
    if (creatorUserId != null) {
      _result.creatorUserId = creatorUserId;
    }
    if (channelType != null) {
      _result.channelType = channelType;
    }
    if (status != null) {
      _result.status = status;
    }
    if (channelName != null) {
      _result.channelName = channelName;
    }
    if (channelUsername != null) {
      _result.channelUsername = channelUsername;
    }
    if (enabledEvents != null) {
      _result.enabledEvents.addAll(enabledEvents);
    }
    if (preferences != null) {
      _result.preferences = preferences;
    }
    if (lastNotificationAt != null) {
      _result.lastNotificationAt = lastNotificationAt;
    }
    if (notificationCount != null) {
      _result.notificationCount = notificationCount;
    }
    if (failureCount != null) {
      _result.failureCount = failureCount;
    }
    if (lastError != null) {
      _result.lastError = lastError;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      _result.updatedAt = updatedAt;
    }
    return _result;
  }
  factory NotificationChannelMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NotificationChannelMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NotificationChannelMessage clone() => NotificationChannelMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NotificationChannelMessage copyWith(void Function(NotificationChannelMessage) updates) => super.copyWith((message) => updates(message as NotificationChannelMessage)) as NotificationChannelMessage; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'NotificationPreferencesMessage', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'includeDonorName')
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'includeAmount')
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'includeMessage')
    ..aOB(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'includeProgress')
    ..aOB(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'includeLeaderboard')
    ..a<$core.double>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'largeDonationThreshold', $pb.PbFieldType.OD)
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'messageTemplate')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'language')
    ..aOB(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'quietHoursEnabled')
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'quietHoursStart')
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'quietHoursEnd')
    ..aOS(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'timezone')
    ..hasRequiredFields = false
  ;

  NotificationPreferencesMessage._() : super();
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
    final _result = create();
    if (includeDonorName != null) {
      _result.includeDonorName = includeDonorName;
    }
    if (includeAmount != null) {
      _result.includeAmount = includeAmount;
    }
    if (includeMessage != null) {
      _result.includeMessage = includeMessage;
    }
    if (includeProgress != null) {
      _result.includeProgress = includeProgress;
    }
    if (includeLeaderboard != null) {
      _result.includeLeaderboard = includeLeaderboard;
    }
    if (largeDonationThreshold != null) {
      _result.largeDonationThreshold = largeDonationThreshold;
    }
    if (messageTemplate != null) {
      _result.messageTemplate = messageTemplate;
    }
    if (language != null) {
      _result.language = language;
    }
    if (quietHoursEnabled != null) {
      _result.quietHoursEnabled = quietHoursEnabled;
    }
    if (quietHoursStart != null) {
      _result.quietHoursStart = quietHoursStart;
    }
    if (quietHoursEnd != null) {
      _result.quietHoursEnd = quietHoursEnd;
    }
    if (timezone != null) {
      _result.timezone = timezone;
    }
    return _result;
  }
  factory NotificationPreferencesMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NotificationPreferencesMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NotificationPreferencesMessage clone() => NotificationPreferencesMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NotificationPreferencesMessage copyWith(void Function(NotificationPreferencesMessage) updates) => super.copyWith((message) => updates(message as NotificationPreferencesMessage)) as NotificationPreferencesMessage; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'NotificationDeliveryMessage', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'channelId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'crowdfundId')
    ..e<NotificationEventType>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'eventType', $pb.PbFieldType.OE, defaultOrMaker: NotificationEventType.NOTIFICATION_EVENT_TYPE_UNSPECIFIED, valueOf: NotificationEventType.valueOf, enumValues: NotificationEventType.values)
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'eventData')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'messageContent')
    ..aOB(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errorMessage')
    ..a<$core.int>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'retryCount', $pb.PbFieldType.O3)
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'platformMessageId')
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt')
    ..aOS(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'deliveredAt')
    ..hasRequiredFields = false
  ;

  NotificationDeliveryMessage._() : super();
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
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (channelId != null) {
      _result.channelId = channelId;
    }
    if (crowdfundId != null) {
      _result.crowdfundId = crowdfundId;
    }
    if (eventType != null) {
      _result.eventType = eventType;
    }
    if (eventData != null) {
      _result.eventData = eventData;
    }
    if (messageContent != null) {
      _result.messageContent = messageContent;
    }
    if (success != null) {
      _result.success = success;
    }
    if (errorMessage != null) {
      _result.errorMessage = errorMessage;
    }
    if (retryCount != null) {
      _result.retryCount = retryCount;
    }
    if (platformMessageId != null) {
      _result.platformMessageId = platformMessageId;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (deliveredAt != null) {
      _result.deliveredAt = deliveredAt;
    }
    return _result;
  }
  factory NotificationDeliveryMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NotificationDeliveryMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NotificationDeliveryMessage clone() => NotificationDeliveryMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NotificationDeliveryMessage copyWith(void Function(NotificationDeliveryMessage) updates) => super.copyWith((message) => updates(message as NotificationDeliveryMessage)) as NotificationDeliveryMessage; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TelegramConnectionDataMessage', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'chatId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'verificationCode')
    ..hasRequiredFields = false
  ;

  TelegramConnectionDataMessage._() : super();
  factory TelegramConnectionDataMessage({
    $core.String? chatId,
    $core.String? verificationCode,
  }) {
    final _result = create();
    if (chatId != null) {
      _result.chatId = chatId;
    }
    if (verificationCode != null) {
      _result.verificationCode = verificationCode;
    }
    return _result;
  }
  factory TelegramConnectionDataMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TelegramConnectionDataMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TelegramConnectionDataMessage clone() => TelegramConnectionDataMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TelegramConnectionDataMessage copyWith(void Function(TelegramConnectionDataMessage) updates) => super.copyWith((message) => updates(message as TelegramConnectionDataMessage)) as TelegramConnectionDataMessage; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DiscordConnectionDataMessage', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'webhookUrl')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'serverName')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'channelName')
    ..hasRequiredFields = false
  ;

  DiscordConnectionDataMessage._() : super();
  factory DiscordConnectionDataMessage({
    $core.String? webhookUrl,
    $core.String? serverName,
    $core.String? channelName,
  }) {
    final _result = create();
    if (webhookUrl != null) {
      _result.webhookUrl = webhookUrl;
    }
    if (serverName != null) {
      _result.serverName = serverName;
    }
    if (channelName != null) {
      _result.channelName = channelName;
    }
    return _result;
  }
  factory DiscordConnectionDataMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DiscordConnectionDataMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DiscordConnectionDataMessage clone() => DiscordConnectionDataMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DiscordConnectionDataMessage copyWith(void Function(DiscordConnectionDataMessage) updates) => super.copyWith((message) => updates(message as DiscordConnectionDataMessage)) as DiscordConnectionDataMessage; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'WhatsAppBusinessConnectionDataMessage', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'phoneNumberId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accessToken')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recipientId')
    ..hasRequiredFields = false
  ;

  WhatsAppBusinessConnectionDataMessage._() : super();
  factory WhatsAppBusinessConnectionDataMessage({
    $core.String? phoneNumberId,
    $core.String? accessToken,
    $core.String? recipientId,
  }) {
    final _result = create();
    if (phoneNumberId != null) {
      _result.phoneNumberId = phoneNumberId;
    }
    if (accessToken != null) {
      _result.accessToken = accessToken;
    }
    if (recipientId != null) {
      _result.recipientId = recipientId;
    }
    return _result;
  }
  factory WhatsAppBusinessConnectionDataMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WhatsAppBusinessConnectionDataMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  WhatsAppBusinessConnectionDataMessage clone() => WhatsAppBusinessConnectionDataMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  WhatsAppBusinessConnectionDataMessage copyWith(void Function(WhatsAppBusinessConnectionDataMessage) updates) => super.copyWith((message) => updates(message as WhatsAppBusinessConnectionDataMessage)) as WhatsAppBusinessConnectionDataMessage; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SlackConnectionDataMessage', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'webhookUrl')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'workspaceName')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'channelName')
    ..hasRequiredFields = false
  ;

  SlackConnectionDataMessage._() : super();
  factory SlackConnectionDataMessage({
    $core.String? webhookUrl,
    $core.String? workspaceName,
    $core.String? channelName,
  }) {
    final _result = create();
    if (webhookUrl != null) {
      _result.webhookUrl = webhookUrl;
    }
    if (workspaceName != null) {
      _result.workspaceName = workspaceName;
    }
    if (channelName != null) {
      _result.channelName = channelName;
    }
    return _result;
  }
  factory SlackConnectionDataMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SlackConnectionDataMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SlackConnectionDataMessage clone() => SlackConnectionDataMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SlackConnectionDataMessage copyWith(void Function(SlackConnectionDataMessage) updates) => super.copyWith((message) => updates(message as SlackConnectionDataMessage)) as SlackConnectionDataMessage; // ignore: deprecated_member_use
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
  static const $core.Map<$core.int, ConnectNotificationChannelRequest_ConnectionData> _ConnectNotificationChannelRequest_ConnectionDataByTag = {
    4 : ConnectNotificationChannelRequest_ConnectionData.telegram,
    5 : ConnectNotificationChannelRequest_ConnectionData.discord,
    6 : ConnectNotificationChannelRequest_ConnectionData.whatsappBusiness,
    7 : ConnectNotificationChannelRequest_ConnectionData.slack,
    0 : ConnectNotificationChannelRequest_ConnectionData.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ConnectNotificationChannelRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..oo(0, [4, 5, 6, 7])
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'crowdfundId')
    ..e<NotificationChannelType>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'channelType', $pb.PbFieldType.OE, defaultOrMaker: NotificationChannelType.NOTIFICATION_CHANNEL_TYPE_UNSPECIFIED, valueOf: NotificationChannelType.valueOf, enumValues: NotificationChannelType.values)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'channelName')
    ..aOM<TelegramConnectionDataMessage>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'telegram', subBuilder: TelegramConnectionDataMessage.create)
    ..aOM<DiscordConnectionDataMessage>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'discord', subBuilder: DiscordConnectionDataMessage.create)
    ..aOM<WhatsAppBusinessConnectionDataMessage>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'whatsappBusiness', subBuilder: WhatsAppBusinessConnectionDataMessage.create)
    ..aOM<SlackConnectionDataMessage>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'slack', subBuilder: SlackConnectionDataMessage.create)
    ..pc<NotificationEventType>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'enabledEvents', $pb.PbFieldType.KE, valueOf: NotificationEventType.valueOf, enumValues: NotificationEventType.values, defaultEnumValue: NotificationEventType.NOTIFICATION_EVENT_TYPE_UNSPECIFIED)
    ..aOM<NotificationPreferencesMessage>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'preferences', subBuilder: NotificationPreferencesMessage.create)
    ..hasRequiredFields = false
  ;

  ConnectNotificationChannelRequest._() : super();
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
    final _result = create();
    if (crowdfundId != null) {
      _result.crowdfundId = crowdfundId;
    }
    if (channelType != null) {
      _result.channelType = channelType;
    }
    if (channelName != null) {
      _result.channelName = channelName;
    }
    if (telegram != null) {
      _result.telegram = telegram;
    }
    if (discord != null) {
      _result.discord = discord;
    }
    if (whatsappBusiness != null) {
      _result.whatsappBusiness = whatsappBusiness;
    }
    if (slack != null) {
      _result.slack = slack;
    }
    if (enabledEvents != null) {
      _result.enabledEvents.addAll(enabledEvents);
    }
    if (preferences != null) {
      _result.preferences = preferences;
    }
    return _result;
  }
  factory ConnectNotificationChannelRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ConnectNotificationChannelRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ConnectNotificationChannelRequest clone() => ConnectNotificationChannelRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ConnectNotificationChannelRequest copyWith(void Function(ConnectNotificationChannelRequest) updates) => super.copyWith((message) => updates(message as ConnectNotificationChannelRequest)) as ConnectNotificationChannelRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ConnectNotificationChannelResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<NotificationChannelMessage>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'channel', subBuilder: NotificationChannelMessage.create)
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'requiresVerification')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'verificationInstructions')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  ConnectNotificationChannelResponse._() : super();
  factory ConnectNotificationChannelResponse({
    NotificationChannelMessage? channel,
    $core.bool? requiresVerification,
    $core.String? verificationInstructions,
    $core.String? message,
  }) {
    final _result = create();
    if (channel != null) {
      _result.channel = channel;
    }
    if (requiresVerification != null) {
      _result.requiresVerification = requiresVerification;
    }
    if (verificationInstructions != null) {
      _result.verificationInstructions = verificationInstructions;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory ConnectNotificationChannelResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ConnectNotificationChannelResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ConnectNotificationChannelResponse clone() => ConnectNotificationChannelResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ConnectNotificationChannelResponse copyWith(void Function(ConnectNotificationChannelResponse) updates) => super.copyWith((message) => updates(message as ConnectNotificationChannelResponse)) as ConnectNotificationChannelResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DisconnectNotificationChannelRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'channelId')
    ..hasRequiredFields = false
  ;

  DisconnectNotificationChannelRequest._() : super();
  factory DisconnectNotificationChannelRequest({
    $core.String? channelId,
  }) {
    final _result = create();
    if (channelId != null) {
      _result.channelId = channelId;
    }
    return _result;
  }
  factory DisconnectNotificationChannelRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DisconnectNotificationChannelRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DisconnectNotificationChannelRequest clone() => DisconnectNotificationChannelRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DisconnectNotificationChannelRequest copyWith(void Function(DisconnectNotificationChannelRequest) updates) => super.copyWith((message) => updates(message as DisconnectNotificationChannelRequest)) as DisconnectNotificationChannelRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DisconnectNotificationChannelResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  DisconnectNotificationChannelResponse._() : super();
  factory DisconnectNotificationChannelResponse({
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
  factory DisconnectNotificationChannelResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DisconnectNotificationChannelResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DisconnectNotificationChannelResponse clone() => DisconnectNotificationChannelResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DisconnectNotificationChannelResponse copyWith(void Function(DisconnectNotificationChannelResponse) updates) => super.copyWith((message) => updates(message as DisconnectNotificationChannelResponse)) as DisconnectNotificationChannelResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetNotificationChannelsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'crowdfundId')
    ..hasRequiredFields = false
  ;

  GetNotificationChannelsRequest._() : super();
  factory GetNotificationChannelsRequest({
    $core.String? crowdfundId,
  }) {
    final _result = create();
    if (crowdfundId != null) {
      _result.crowdfundId = crowdfundId;
    }
    return _result;
  }
  factory GetNotificationChannelsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetNotificationChannelsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetNotificationChannelsRequest clone() => GetNotificationChannelsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetNotificationChannelsRequest copyWith(void Function(GetNotificationChannelsRequest) updates) => super.copyWith((message) => updates(message as GetNotificationChannelsRequest)) as GetNotificationChannelsRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetNotificationChannelsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<NotificationChannelMessage>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'channels', $pb.PbFieldType.PM, subBuilder: NotificationChannelMessage.create)
    ..hasRequiredFields = false
  ;

  GetNotificationChannelsResponse._() : super();
  factory GetNotificationChannelsResponse({
    $core.Iterable<NotificationChannelMessage>? channels,
  }) {
    final _result = create();
    if (channels != null) {
      _result.channels.addAll(channels);
    }
    return _result;
  }
  factory GetNotificationChannelsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetNotificationChannelsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetNotificationChannelsResponse clone() => GetNotificationChannelsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetNotificationChannelsResponse copyWith(void Function(GetNotificationChannelsResponse) updates) => super.copyWith((message) => updates(message as GetNotificationChannelsResponse)) as GetNotificationChannelsResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateNotificationChannelRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'channelId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'channelName')
    ..pc<NotificationEventType>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'enabledEvents', $pb.PbFieldType.KE, valueOf: NotificationEventType.valueOf, enumValues: NotificationEventType.values, defaultEnumValue: NotificationEventType.NOTIFICATION_EVENT_TYPE_UNSPECIFIED)
    ..aOM<NotificationPreferencesMessage>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'preferences', subBuilder: NotificationPreferencesMessage.create)
    ..e<NotificationChannelStatus>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: NotificationChannelStatus.NOTIFICATION_CHANNEL_STATUS_UNSPECIFIED, valueOf: NotificationChannelStatus.valueOf, enumValues: NotificationChannelStatus.values)
    ..hasRequiredFields = false
  ;

  UpdateNotificationChannelRequest._() : super();
  factory UpdateNotificationChannelRequest({
    $core.String? channelId,
    $core.String? channelName,
    $core.Iterable<NotificationEventType>? enabledEvents,
    NotificationPreferencesMessage? preferences,
    NotificationChannelStatus? status,
  }) {
    final _result = create();
    if (channelId != null) {
      _result.channelId = channelId;
    }
    if (channelName != null) {
      _result.channelName = channelName;
    }
    if (enabledEvents != null) {
      _result.enabledEvents.addAll(enabledEvents);
    }
    if (preferences != null) {
      _result.preferences = preferences;
    }
    if (status != null) {
      _result.status = status;
    }
    return _result;
  }
  factory UpdateNotificationChannelRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateNotificationChannelRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateNotificationChannelRequest clone() => UpdateNotificationChannelRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateNotificationChannelRequest copyWith(void Function(UpdateNotificationChannelRequest) updates) => super.copyWith((message) => updates(message as UpdateNotificationChannelRequest)) as UpdateNotificationChannelRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateNotificationChannelResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<NotificationChannelMessage>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'channel', subBuilder: NotificationChannelMessage.create)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  UpdateNotificationChannelResponse._() : super();
  factory UpdateNotificationChannelResponse({
    NotificationChannelMessage? channel,
    $core.String? message,
  }) {
    final _result = create();
    if (channel != null) {
      _result.channel = channel;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory UpdateNotificationChannelResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateNotificationChannelResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateNotificationChannelResponse clone() => UpdateNotificationChannelResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateNotificationChannelResponse copyWith(void Function(UpdateNotificationChannelResponse) updates) => super.copyWith((message) => updates(message as UpdateNotificationChannelResponse)) as UpdateNotificationChannelResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TestNotificationChannelRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'channelId')
    ..hasRequiredFields = false
  ;

  TestNotificationChannelRequest._() : super();
  factory TestNotificationChannelRequest({
    $core.String? channelId,
  }) {
    final _result = create();
    if (channelId != null) {
      _result.channelId = channelId;
    }
    return _result;
  }
  factory TestNotificationChannelRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TestNotificationChannelRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TestNotificationChannelRequest clone() => TestNotificationChannelRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TestNotificationChannelRequest copyWith(void Function(TestNotificationChannelRequest) updates) => super.copyWith((message) => updates(message as TestNotificationChannelRequest)) as TestNotificationChannelRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TestNotificationChannelResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'platformMessageId')
    ..hasRequiredFields = false
  ;

  TestNotificationChannelResponse._() : super();
  factory TestNotificationChannelResponse({
    $core.bool? success,
    $core.String? message,
    $core.String? platformMessageId,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (platformMessageId != null) {
      _result.platformMessageId = platformMessageId;
    }
    return _result;
  }
  factory TestNotificationChannelResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TestNotificationChannelResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TestNotificationChannelResponse clone() => TestNotificationChannelResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TestNotificationChannelResponse copyWith(void Function(TestNotificationChannelResponse) updates) => super.copyWith((message) => updates(message as TestNotificationChannelResponse)) as TestNotificationChannelResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetTelegramBotInfoRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GetTelegramBotInfoRequest._() : super();
  factory GetTelegramBotInfoRequest() => create();
  factory GetTelegramBotInfoRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTelegramBotInfoRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetTelegramBotInfoRequest clone() => GetTelegramBotInfoRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetTelegramBotInfoRequest copyWith(void Function(GetTelegramBotInfoRequest) updates) => super.copyWith((message) => updates(message as GetTelegramBotInfoRequest)) as GetTelegramBotInfoRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetTelegramBotInfoResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'botUsername')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'botName')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'botLink')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'instructions')
    ..hasRequiredFields = false
  ;

  GetTelegramBotInfoResponse._() : super();
  factory GetTelegramBotInfoResponse({
    $core.String? botUsername,
    $core.String? botName,
    $core.String? botLink,
    $core.String? instructions,
  }) {
    final _result = create();
    if (botUsername != null) {
      _result.botUsername = botUsername;
    }
    if (botName != null) {
      _result.botName = botName;
    }
    if (botLink != null) {
      _result.botLink = botLink;
    }
    if (instructions != null) {
      _result.instructions = instructions;
    }
    return _result;
  }
  factory GetTelegramBotInfoResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTelegramBotInfoResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetTelegramBotInfoResponse clone() => GetTelegramBotInfoResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetTelegramBotInfoResponse copyWith(void Function(GetTelegramBotInfoResponse) updates) => super.copyWith((message) => updates(message as GetTelegramBotInfoResponse)) as GetTelegramBotInfoResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'VerifyTelegramChannelRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'crowdfundId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'chatId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'verificationCode')
    ..hasRequiredFields = false
  ;

  VerifyTelegramChannelRequest._() : super();
  factory VerifyTelegramChannelRequest({
    $core.String? crowdfundId,
    $core.String? chatId,
    $core.String? verificationCode,
  }) {
    final _result = create();
    if (crowdfundId != null) {
      _result.crowdfundId = crowdfundId;
    }
    if (chatId != null) {
      _result.chatId = chatId;
    }
    if (verificationCode != null) {
      _result.verificationCode = verificationCode;
    }
    return _result;
  }
  factory VerifyTelegramChannelRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VerifyTelegramChannelRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VerifyTelegramChannelRequest clone() => VerifyTelegramChannelRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VerifyTelegramChannelRequest copyWith(void Function(VerifyTelegramChannelRequest) updates) => super.copyWith((message) => updates(message as VerifyTelegramChannelRequest)) as VerifyTelegramChannelRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'VerifyTelegramChannelResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOM<NotificationChannelMessage>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'channel', subBuilder: NotificationChannelMessage.create)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  VerifyTelegramChannelResponse._() : super();
  factory VerifyTelegramChannelResponse({
    $core.bool? success,
    NotificationChannelMessage? channel,
    $core.String? message,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (channel != null) {
      _result.channel = channel;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory VerifyTelegramChannelResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VerifyTelegramChannelResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VerifyTelegramChannelResponse clone() => VerifyTelegramChannelResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VerifyTelegramChannelResponse copyWith(void Function(VerifyTelegramChannelResponse) updates) => super.copyWith((message) => updates(message as VerifyTelegramChannelResponse)) as VerifyTelegramChannelResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetNotificationHistoryRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'crowdfundId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'channelId')
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetNotificationHistoryRequest._() : super();
  factory GetNotificationHistoryRequest({
    $core.String? crowdfundId,
    $core.String? channelId,
    $core.int? page,
    $core.int? pageSize,
  }) {
    final _result = create();
    if (crowdfundId != null) {
      _result.crowdfundId = crowdfundId;
    }
    if (channelId != null) {
      _result.channelId = channelId;
    }
    if (page != null) {
      _result.page = page;
    }
    if (pageSize != null) {
      _result.pageSize = pageSize;
    }
    return _result;
  }
  factory GetNotificationHistoryRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetNotificationHistoryRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetNotificationHistoryRequest clone() => GetNotificationHistoryRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetNotificationHistoryRequest copyWith(void Function(GetNotificationHistoryRequest) updates) => super.copyWith((message) => updates(message as GetNotificationHistoryRequest)) as GetNotificationHistoryRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetNotificationHistoryResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<NotificationDeliveryMessage>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'deliveries', $pb.PbFieldType.PM, subBuilder: NotificationDeliveryMessage.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'total', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOB(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hasMore')
    ..hasRequiredFields = false
  ;

  GetNotificationHistoryResponse._() : super();
  factory GetNotificationHistoryResponse({
    $core.Iterable<NotificationDeliveryMessage>? deliveries,
    $core.int? total,
    $core.int? page,
    $core.int? pageSize,
    $core.bool? hasMore,
  }) {
    final _result = create();
    if (deliveries != null) {
      _result.deliveries.addAll(deliveries);
    }
    if (total != null) {
      _result.total = total;
    }
    if (page != null) {
      _result.page = page;
    }
    if (pageSize != null) {
      _result.pageSize = pageSize;
    }
    if (hasMore != null) {
      _result.hasMore = hasMore;
    }
    return _result;
  }
  factory GetNotificationHistoryResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetNotificationHistoryResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetNotificationHistoryResponse clone() => GetNotificationHistoryResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetNotificationHistoryResponse copyWith(void Function(GetNotificationHistoryResponse) updates) => super.copyWith((message) => updates(message as GetNotificationHistoryResponse)) as GetNotificationHistoryResponse; // ignore: deprecated_member_use
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

