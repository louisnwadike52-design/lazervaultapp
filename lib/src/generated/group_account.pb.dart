///
//  Generated code. Do not modify.
//  source: group_account.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/timestamp.pb.dart' as $1;

import 'group_account.pbenum.dart';

export 'group_account.pbenum.dart';

class GroupAccountMessage extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GroupAccountMessage', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'adminId')
    ..e<GroupAccountStatus>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: GroupAccountStatus.GROUP_ACCOUNT_STATUS_UNSPECIFIED, valueOf: GroupAccountStatus.valueOf, enumValues: GroupAccountStatus.values)
    ..aOM<$1.Timestamp>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedAt', subBuilder: $1.Timestamp.create)
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'metadata')
    ..pc<GroupMemberMessage>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'members', $pb.PbFieldType.PM, subBuilder: GroupMemberMessage.create)
    ..pc<ContributionMessage>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'contributions', $pb.PbFieldType.PM, subBuilder: ContributionMessage.create)
    ..hasRequiredFields = false
  ;

  GroupAccountMessage._() : super();
  factory GroupAccountMessage({
    $core.String? id,
    $core.String? name,
    $core.String? description,
    $core.String? adminId,
    GroupAccountStatus? status,
    $1.Timestamp? createdAt,
    $1.Timestamp? updatedAt,
    $core.String? metadata,
    $core.Iterable<GroupMemberMessage>? members,
    $core.Iterable<ContributionMessage>? contributions,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (name != null) {
      _result.name = name;
    }
    if (description != null) {
      _result.description = description;
    }
    if (adminId != null) {
      _result.adminId = adminId;
    }
    if (status != null) {
      _result.status = status;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      _result.updatedAt = updatedAt;
    }
    if (metadata != null) {
      _result.metadata = metadata;
    }
    if (members != null) {
      _result.members.addAll(members);
    }
    if (contributions != null) {
      _result.contributions.addAll(contributions);
    }
    return _result;
  }
  factory GroupAccountMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GroupAccountMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GroupAccountMessage clone() => GroupAccountMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GroupAccountMessage copyWith(void Function(GroupAccountMessage) updates) => super.copyWith((message) => updates(message as GroupAccountMessage)) as GroupAccountMessage; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GroupAccountMessage create() => GroupAccountMessage._();
  GroupAccountMessage createEmptyInstance() => create();
  static $pb.PbList<GroupAccountMessage> createRepeated() => $pb.PbList<GroupAccountMessage>();
  @$core.pragma('dart2js:noInline')
  static GroupAccountMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GroupAccountMessage>(create);
  static GroupAccountMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get adminId => $_getSZ(3);
  @$pb.TagNumber(4)
  set adminId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasAdminId() => $_has(3);
  @$pb.TagNumber(4)
  void clearAdminId() => clearField(4);

  @$pb.TagNumber(5)
  GroupAccountStatus get status => $_getN(4);
  @$pb.TagNumber(5)
  set status(GroupAccountStatus v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasStatus() => $_has(4);
  @$pb.TagNumber(5)
  void clearStatus() => clearField(5);

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

  @$pb.TagNumber(7)
  $1.Timestamp get updatedAt => $_getN(6);
  @$pb.TagNumber(7)
  set updatedAt($1.Timestamp v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasUpdatedAt() => $_has(6);
  @$pb.TagNumber(7)
  void clearUpdatedAt() => clearField(7);
  @$pb.TagNumber(7)
  $1.Timestamp ensureUpdatedAt() => $_ensure(6);

  @$pb.TagNumber(8)
  $core.String get metadata => $_getSZ(7);
  @$pb.TagNumber(8)
  set metadata($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasMetadata() => $_has(7);
  @$pb.TagNumber(8)
  void clearMetadata() => clearField(8);

  @$pb.TagNumber(9)
  $core.List<GroupMemberMessage> get members => $_getList(8);

  @$pb.TagNumber(10)
  $core.List<ContributionMessage> get contributions => $_getList(9);
}

class GroupMemberMessage extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GroupMemberMessage', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'groupId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userName')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'email')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'profileImage')
    ..e<GroupMemberRole>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'role', $pb.PbFieldType.OE, defaultOrMaker: GroupMemberRole.GROUP_MEMBER_ROLE_UNSPECIFIED, valueOf: GroupMemberRole.valueOf, enumValues: GroupMemberRole.values)
    ..e<GroupMemberStatus>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: GroupMemberStatus.GROUP_MEMBER_STATUS_UNSPECIFIED, valueOf: GroupMemberStatus.valueOf, enumValues: GroupMemberStatus.values)
    ..aOM<$1.Timestamp>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'joinedAt', subBuilder: $1.Timestamp.create)
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'permissions')
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'phoneNumber')
    ..aOB(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isPartial')
    ..aOS(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userUsername')
    ..hasRequiredFields = false
  ;

  GroupMemberMessage._() : super();
  factory GroupMemberMessage({
    $core.String? id,
    $core.String? groupId,
    $core.String? userId,
    $core.String? userName,
    $core.String? email,
    $core.String? profileImage,
    GroupMemberRole? role,
    GroupMemberStatus? status,
    $1.Timestamp? joinedAt,
    $core.String? permissions,
    $core.String? phoneNumber,
    $core.bool? isPartial,
    $core.String? userUsername,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (groupId != null) {
      _result.groupId = groupId;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    if (userName != null) {
      _result.userName = userName;
    }
    if (email != null) {
      _result.email = email;
    }
    if (profileImage != null) {
      _result.profileImage = profileImage;
    }
    if (role != null) {
      _result.role = role;
    }
    if (status != null) {
      _result.status = status;
    }
    if (joinedAt != null) {
      _result.joinedAt = joinedAt;
    }
    if (permissions != null) {
      _result.permissions = permissions;
    }
    if (phoneNumber != null) {
      _result.phoneNumber = phoneNumber;
    }
    if (isPartial != null) {
      _result.isPartial = isPartial;
    }
    if (userUsername != null) {
      _result.userUsername = userUsername;
    }
    return _result;
  }
  factory GroupMemberMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GroupMemberMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GroupMemberMessage clone() => GroupMemberMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GroupMemberMessage copyWith(void Function(GroupMemberMessage) updates) => super.copyWith((message) => updates(message as GroupMemberMessage)) as GroupMemberMessage; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GroupMemberMessage create() => GroupMemberMessage._();
  GroupMemberMessage createEmptyInstance() => create();
  static $pb.PbList<GroupMemberMessage> createRepeated() => $pb.PbList<GroupMemberMessage>();
  @$core.pragma('dart2js:noInline')
  static GroupMemberMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GroupMemberMessage>(create);
  static GroupMemberMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get groupId => $_getSZ(1);
  @$pb.TagNumber(2)
  set groupId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasGroupId() => $_has(1);
  @$pb.TagNumber(2)
  void clearGroupId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get userId => $_getSZ(2);
  @$pb.TagNumber(3)
  set userId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasUserId() => $_has(2);
  @$pb.TagNumber(3)
  void clearUserId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get userName => $_getSZ(3);
  @$pb.TagNumber(4)
  set userName($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasUserName() => $_has(3);
  @$pb.TagNumber(4)
  void clearUserName() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get email => $_getSZ(4);
  @$pb.TagNumber(5)
  set email($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasEmail() => $_has(4);
  @$pb.TagNumber(5)
  void clearEmail() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get profileImage => $_getSZ(5);
  @$pb.TagNumber(6)
  set profileImage($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasProfileImage() => $_has(5);
  @$pb.TagNumber(6)
  void clearProfileImage() => clearField(6);

  @$pb.TagNumber(7)
  GroupMemberRole get role => $_getN(6);
  @$pb.TagNumber(7)
  set role(GroupMemberRole v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasRole() => $_has(6);
  @$pb.TagNumber(7)
  void clearRole() => clearField(7);

  @$pb.TagNumber(8)
  GroupMemberStatus get status => $_getN(7);
  @$pb.TagNumber(8)
  set status(GroupMemberStatus v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasStatus() => $_has(7);
  @$pb.TagNumber(8)
  void clearStatus() => clearField(8);

  @$pb.TagNumber(9)
  $1.Timestamp get joinedAt => $_getN(8);
  @$pb.TagNumber(9)
  set joinedAt($1.Timestamp v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasJoinedAt() => $_has(8);
  @$pb.TagNumber(9)
  void clearJoinedAt() => clearField(9);
  @$pb.TagNumber(9)
  $1.Timestamp ensureJoinedAt() => $_ensure(8);

  @$pb.TagNumber(10)
  $core.String get permissions => $_getSZ(9);
  @$pb.TagNumber(10)
  set permissions($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasPermissions() => $_has(9);
  @$pb.TagNumber(10)
  void clearPermissions() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get phoneNumber => $_getSZ(10);
  @$pb.TagNumber(11)
  set phoneNumber($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasPhoneNumber() => $_has(10);
  @$pb.TagNumber(11)
  void clearPhoneNumber() => clearField(11);

  @$pb.TagNumber(12)
  $core.bool get isPartial => $_getBF(11);
  @$pb.TagNumber(12)
  set isPartial($core.bool v) { $_setBool(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasIsPartial() => $_has(11);
  @$pb.TagNumber(12)
  void clearIsPartial() => clearField(12);

  @$pb.TagNumber(13)
  $core.String get userUsername => $_getSZ(12);
  @$pb.TagNumber(13)
  set userUsername($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasUserUsername() => $_has(12);
  @$pb.TagNumber(13)
  void clearUserUsername() => clearField(13);
}

class ContributionMessage extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ContributionMessage', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'groupId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'title')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..a<$fixnum.Int64>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'targetAmount', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currentAmount', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOM<$1.Timestamp>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'deadline', subBuilder: $1.Timestamp.create)
    ..e<ContributionStatus>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: ContributionStatus.CONTRIBUTION_STATUS_UNSPECIFIED, valueOf: ContributionStatus.valueOf, enumValues: ContributionStatus.values)
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdBy')
    ..aOM<$1.Timestamp>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedAt', subBuilder: $1.Timestamp.create)
    ..aOS(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'metadata')
    ..e<ContributionType>(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type', $pb.PbFieldType.OE, defaultOrMaker: ContributionType.CONTRIBUTION_TYPE_UNSPECIFIED, valueOf: ContributionType.valueOf, enumValues: ContributionType.values)
    ..e<ContributionFrequency>(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'frequency', $pb.PbFieldType.OE, defaultOrMaker: ContributionFrequency.CONTRIBUTION_FREQUENCY_UNSPECIFIED, valueOf: ContributionFrequency.valueOf, enumValues: ContributionFrequency.values)
    ..a<$fixnum.Int64>(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'regularAmount', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<$1.Timestamp>(17, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'nextPaymentDate', subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(18, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'startDate', subBuilder: $1.Timestamp.create)
    ..a<$core.int>(19, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalCycles', $pb.PbFieldType.O3)
    ..a<$core.int>(20, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currentCycle', $pb.PbFieldType.O3)
    ..aOS(21, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currentPayoutRecipient')
    ..aOM<$1.Timestamp>(22, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'nextPayoutDate', subBuilder: $1.Timestamp.create)
    ..aOB(23, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'autoPayEnabled')
    ..a<$fixnum.Int64>(24, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'penaltyAmount', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(25, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'gracePeriodDays', $pb.PbFieldType.O3)
    ..aOB(26, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'allowPartialPayments')
    ..a<$fixnum.Int64>(27, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'minimumBalance', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..pc<ContributionPaymentMessage>(28, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payments', $pb.PbFieldType.PM, subBuilder: ContributionPaymentMessage.create)
    ..pc<PayoutScheduleMessage>(29, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payoutSchedule', $pb.PbFieldType.PM, subBuilder: PayoutScheduleMessage.create)
    ..pc<PayoutTransactionMessage>(30, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payoutHistory', $pb.PbFieldType.PM, subBuilder: PayoutTransactionMessage.create)
    ..pc<ContributionMemberMessage>(31, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'members', $pb.PbFieldType.PM, subBuilder: ContributionMemberMessage.create)
    ..hasRequiredFields = false
  ;

  ContributionMessage._() : super();
  factory ContributionMessage({
    $core.String? id,
    $core.String? groupId,
    $core.String? title,
    $core.String? description,
    $fixnum.Int64? targetAmount,
    $fixnum.Int64? currentAmount,
    $core.String? currency,
    $1.Timestamp? deadline,
    ContributionStatus? status,
    $core.String? createdBy,
    $1.Timestamp? createdAt,
    $1.Timestamp? updatedAt,
    $core.String? metadata,
    ContributionType? type,
    ContributionFrequency? frequency,
    $fixnum.Int64? regularAmount,
    $1.Timestamp? nextPaymentDate,
    $1.Timestamp? startDate,
    $core.int? totalCycles,
    $core.int? currentCycle,
    $core.String? currentPayoutRecipient,
    $1.Timestamp? nextPayoutDate,
    $core.bool? autoPayEnabled,
    $fixnum.Int64? penaltyAmount,
    $core.int? gracePeriodDays,
    $core.bool? allowPartialPayments,
    $fixnum.Int64? minimumBalance,
    $core.Iterable<ContributionPaymentMessage>? payments,
    $core.Iterable<PayoutScheduleMessage>? payoutSchedule,
    $core.Iterable<PayoutTransactionMessage>? payoutHistory,
    $core.Iterable<ContributionMemberMessage>? members,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (groupId != null) {
      _result.groupId = groupId;
    }
    if (title != null) {
      _result.title = title;
    }
    if (description != null) {
      _result.description = description;
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
    if (status != null) {
      _result.status = status;
    }
    if (createdBy != null) {
      _result.createdBy = createdBy;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      _result.updatedAt = updatedAt;
    }
    if (metadata != null) {
      _result.metadata = metadata;
    }
    if (type != null) {
      _result.type = type;
    }
    if (frequency != null) {
      _result.frequency = frequency;
    }
    if (regularAmount != null) {
      _result.regularAmount = regularAmount;
    }
    if (nextPaymentDate != null) {
      _result.nextPaymentDate = nextPaymentDate;
    }
    if (startDate != null) {
      _result.startDate = startDate;
    }
    if (totalCycles != null) {
      _result.totalCycles = totalCycles;
    }
    if (currentCycle != null) {
      _result.currentCycle = currentCycle;
    }
    if (currentPayoutRecipient != null) {
      _result.currentPayoutRecipient = currentPayoutRecipient;
    }
    if (nextPayoutDate != null) {
      _result.nextPayoutDate = nextPayoutDate;
    }
    if (autoPayEnabled != null) {
      _result.autoPayEnabled = autoPayEnabled;
    }
    if (penaltyAmount != null) {
      _result.penaltyAmount = penaltyAmount;
    }
    if (gracePeriodDays != null) {
      _result.gracePeriodDays = gracePeriodDays;
    }
    if (allowPartialPayments != null) {
      _result.allowPartialPayments = allowPartialPayments;
    }
    if (minimumBalance != null) {
      _result.minimumBalance = minimumBalance;
    }
    if (payments != null) {
      _result.payments.addAll(payments);
    }
    if (payoutSchedule != null) {
      _result.payoutSchedule.addAll(payoutSchedule);
    }
    if (payoutHistory != null) {
      _result.payoutHistory.addAll(payoutHistory);
    }
    if (members != null) {
      _result.members.addAll(members);
    }
    return _result;
  }
  factory ContributionMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ContributionMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ContributionMessage clone() => ContributionMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ContributionMessage copyWith(void Function(ContributionMessage) updates) => super.copyWith((message) => updates(message as ContributionMessage)) as ContributionMessage; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ContributionMessage create() => ContributionMessage._();
  ContributionMessage createEmptyInstance() => create();
  static $pb.PbList<ContributionMessage> createRepeated() => $pb.PbList<ContributionMessage>();
  @$core.pragma('dart2js:noInline')
  static ContributionMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ContributionMessage>(create);
  static ContributionMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get groupId => $_getSZ(1);
  @$pb.TagNumber(2)
  set groupId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasGroupId() => $_has(1);
  @$pb.TagNumber(2)
  void clearGroupId() => clearField(2);

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
  $fixnum.Int64 get targetAmount => $_getI64(4);
  @$pb.TagNumber(5)
  set targetAmount($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTargetAmount() => $_has(4);
  @$pb.TagNumber(5)
  void clearTargetAmount() => clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get currentAmount => $_getI64(5);
  @$pb.TagNumber(6)
  set currentAmount($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasCurrentAmount() => $_has(5);
  @$pb.TagNumber(6)
  void clearCurrentAmount() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get currency => $_getSZ(6);
  @$pb.TagNumber(7)
  set currency($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasCurrency() => $_has(6);
  @$pb.TagNumber(7)
  void clearCurrency() => clearField(7);

  @$pb.TagNumber(8)
  $1.Timestamp get deadline => $_getN(7);
  @$pb.TagNumber(8)
  set deadline($1.Timestamp v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasDeadline() => $_has(7);
  @$pb.TagNumber(8)
  void clearDeadline() => clearField(8);
  @$pb.TagNumber(8)
  $1.Timestamp ensureDeadline() => $_ensure(7);

  @$pb.TagNumber(9)
  ContributionStatus get status => $_getN(8);
  @$pb.TagNumber(9)
  set status(ContributionStatus v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasStatus() => $_has(8);
  @$pb.TagNumber(9)
  void clearStatus() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get createdBy => $_getSZ(9);
  @$pb.TagNumber(10)
  set createdBy($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasCreatedBy() => $_has(9);
  @$pb.TagNumber(10)
  void clearCreatedBy() => clearField(10);

  @$pb.TagNumber(11)
  $1.Timestamp get createdAt => $_getN(10);
  @$pb.TagNumber(11)
  set createdAt($1.Timestamp v) { setField(11, v); }
  @$pb.TagNumber(11)
  $core.bool hasCreatedAt() => $_has(10);
  @$pb.TagNumber(11)
  void clearCreatedAt() => clearField(11);
  @$pb.TagNumber(11)
  $1.Timestamp ensureCreatedAt() => $_ensure(10);

  @$pb.TagNumber(12)
  $1.Timestamp get updatedAt => $_getN(11);
  @$pb.TagNumber(12)
  set updatedAt($1.Timestamp v) { setField(12, v); }
  @$pb.TagNumber(12)
  $core.bool hasUpdatedAt() => $_has(11);
  @$pb.TagNumber(12)
  void clearUpdatedAt() => clearField(12);
  @$pb.TagNumber(12)
  $1.Timestamp ensureUpdatedAt() => $_ensure(11);

  @$pb.TagNumber(13)
  $core.String get metadata => $_getSZ(12);
  @$pb.TagNumber(13)
  set metadata($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasMetadata() => $_has(12);
  @$pb.TagNumber(13)
  void clearMetadata() => clearField(13);

  @$pb.TagNumber(14)
  ContributionType get type => $_getN(13);
  @$pb.TagNumber(14)
  set type(ContributionType v) { setField(14, v); }
  @$pb.TagNumber(14)
  $core.bool hasType() => $_has(13);
  @$pb.TagNumber(14)
  void clearType() => clearField(14);

  @$pb.TagNumber(15)
  ContributionFrequency get frequency => $_getN(14);
  @$pb.TagNumber(15)
  set frequency(ContributionFrequency v) { setField(15, v); }
  @$pb.TagNumber(15)
  $core.bool hasFrequency() => $_has(14);
  @$pb.TagNumber(15)
  void clearFrequency() => clearField(15);

  @$pb.TagNumber(16)
  $fixnum.Int64 get regularAmount => $_getI64(15);
  @$pb.TagNumber(16)
  set regularAmount($fixnum.Int64 v) { $_setInt64(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasRegularAmount() => $_has(15);
  @$pb.TagNumber(16)
  void clearRegularAmount() => clearField(16);

  @$pb.TagNumber(17)
  $1.Timestamp get nextPaymentDate => $_getN(16);
  @$pb.TagNumber(17)
  set nextPaymentDate($1.Timestamp v) { setField(17, v); }
  @$pb.TagNumber(17)
  $core.bool hasNextPaymentDate() => $_has(16);
  @$pb.TagNumber(17)
  void clearNextPaymentDate() => clearField(17);
  @$pb.TagNumber(17)
  $1.Timestamp ensureNextPaymentDate() => $_ensure(16);

  @$pb.TagNumber(18)
  $1.Timestamp get startDate => $_getN(17);
  @$pb.TagNumber(18)
  set startDate($1.Timestamp v) { setField(18, v); }
  @$pb.TagNumber(18)
  $core.bool hasStartDate() => $_has(17);
  @$pb.TagNumber(18)
  void clearStartDate() => clearField(18);
  @$pb.TagNumber(18)
  $1.Timestamp ensureStartDate() => $_ensure(17);

  @$pb.TagNumber(19)
  $core.int get totalCycles => $_getIZ(18);
  @$pb.TagNumber(19)
  set totalCycles($core.int v) { $_setSignedInt32(18, v); }
  @$pb.TagNumber(19)
  $core.bool hasTotalCycles() => $_has(18);
  @$pb.TagNumber(19)
  void clearTotalCycles() => clearField(19);

  @$pb.TagNumber(20)
  $core.int get currentCycle => $_getIZ(19);
  @$pb.TagNumber(20)
  set currentCycle($core.int v) { $_setSignedInt32(19, v); }
  @$pb.TagNumber(20)
  $core.bool hasCurrentCycle() => $_has(19);
  @$pb.TagNumber(20)
  void clearCurrentCycle() => clearField(20);

  @$pb.TagNumber(21)
  $core.String get currentPayoutRecipient => $_getSZ(20);
  @$pb.TagNumber(21)
  set currentPayoutRecipient($core.String v) { $_setString(20, v); }
  @$pb.TagNumber(21)
  $core.bool hasCurrentPayoutRecipient() => $_has(20);
  @$pb.TagNumber(21)
  void clearCurrentPayoutRecipient() => clearField(21);

  @$pb.TagNumber(22)
  $1.Timestamp get nextPayoutDate => $_getN(21);
  @$pb.TagNumber(22)
  set nextPayoutDate($1.Timestamp v) { setField(22, v); }
  @$pb.TagNumber(22)
  $core.bool hasNextPayoutDate() => $_has(21);
  @$pb.TagNumber(22)
  void clearNextPayoutDate() => clearField(22);
  @$pb.TagNumber(22)
  $1.Timestamp ensureNextPayoutDate() => $_ensure(21);

  @$pb.TagNumber(23)
  $core.bool get autoPayEnabled => $_getBF(22);
  @$pb.TagNumber(23)
  set autoPayEnabled($core.bool v) { $_setBool(22, v); }
  @$pb.TagNumber(23)
  $core.bool hasAutoPayEnabled() => $_has(22);
  @$pb.TagNumber(23)
  void clearAutoPayEnabled() => clearField(23);

  @$pb.TagNumber(24)
  $fixnum.Int64 get penaltyAmount => $_getI64(23);
  @$pb.TagNumber(24)
  set penaltyAmount($fixnum.Int64 v) { $_setInt64(23, v); }
  @$pb.TagNumber(24)
  $core.bool hasPenaltyAmount() => $_has(23);
  @$pb.TagNumber(24)
  void clearPenaltyAmount() => clearField(24);

  @$pb.TagNumber(25)
  $core.int get gracePeriodDays => $_getIZ(24);
  @$pb.TagNumber(25)
  set gracePeriodDays($core.int v) { $_setSignedInt32(24, v); }
  @$pb.TagNumber(25)
  $core.bool hasGracePeriodDays() => $_has(24);
  @$pb.TagNumber(25)
  void clearGracePeriodDays() => clearField(25);

  @$pb.TagNumber(26)
  $core.bool get allowPartialPayments => $_getBF(25);
  @$pb.TagNumber(26)
  set allowPartialPayments($core.bool v) { $_setBool(25, v); }
  @$pb.TagNumber(26)
  $core.bool hasAllowPartialPayments() => $_has(25);
  @$pb.TagNumber(26)
  void clearAllowPartialPayments() => clearField(26);

  @$pb.TagNumber(27)
  $fixnum.Int64 get minimumBalance => $_getI64(26);
  @$pb.TagNumber(27)
  set minimumBalance($fixnum.Int64 v) { $_setInt64(26, v); }
  @$pb.TagNumber(27)
  $core.bool hasMinimumBalance() => $_has(26);
  @$pb.TagNumber(27)
  void clearMinimumBalance() => clearField(27);

  @$pb.TagNumber(28)
  $core.List<ContributionPaymentMessage> get payments => $_getList(27);

  @$pb.TagNumber(29)
  $core.List<PayoutScheduleMessage> get payoutSchedule => $_getList(28);

  @$pb.TagNumber(30)
  $core.List<PayoutTransactionMessage> get payoutHistory => $_getList(29);

  @$pb.TagNumber(31)
  $core.List<ContributionMemberMessage> get members => $_getList(30);
}

class ContributionMemberMessage extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ContributionMemberMessage', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'contributionId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userName')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'email')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'profileImage')
    ..aOM<$1.Timestamp>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'joinedAt', subBuilder: $1.Timestamp.create)
    ..a<$fixnum.Int64>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalPaid', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'expectedAmount', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOB(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hasPaidCurrentCycle')
    ..hasRequiredFields = false
  ;

  ContributionMemberMessage._() : super();
  factory ContributionMemberMessage({
    $core.String? id,
    $core.String? contributionId,
    $core.String? userId,
    $core.String? userName,
    $core.String? email,
    $core.String? profileImage,
    $1.Timestamp? joinedAt,
    $fixnum.Int64? totalPaid,
    $fixnum.Int64? expectedAmount,
    $core.bool? hasPaidCurrentCycle,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (contributionId != null) {
      _result.contributionId = contributionId;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    if (userName != null) {
      _result.userName = userName;
    }
    if (email != null) {
      _result.email = email;
    }
    if (profileImage != null) {
      _result.profileImage = profileImage;
    }
    if (joinedAt != null) {
      _result.joinedAt = joinedAt;
    }
    if (totalPaid != null) {
      _result.totalPaid = totalPaid;
    }
    if (expectedAmount != null) {
      _result.expectedAmount = expectedAmount;
    }
    if (hasPaidCurrentCycle != null) {
      _result.hasPaidCurrentCycle = hasPaidCurrentCycle;
    }
    return _result;
  }
  factory ContributionMemberMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ContributionMemberMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ContributionMemberMessage clone() => ContributionMemberMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ContributionMemberMessage copyWith(void Function(ContributionMemberMessage) updates) => super.copyWith((message) => updates(message as ContributionMemberMessage)) as ContributionMemberMessage; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ContributionMemberMessage create() => ContributionMemberMessage._();
  ContributionMemberMessage createEmptyInstance() => create();
  static $pb.PbList<ContributionMemberMessage> createRepeated() => $pb.PbList<ContributionMemberMessage>();
  @$core.pragma('dart2js:noInline')
  static ContributionMemberMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ContributionMemberMessage>(create);
  static ContributionMemberMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get contributionId => $_getSZ(1);
  @$pb.TagNumber(2)
  set contributionId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasContributionId() => $_has(1);
  @$pb.TagNumber(2)
  void clearContributionId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get userId => $_getSZ(2);
  @$pb.TagNumber(3)
  set userId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasUserId() => $_has(2);
  @$pb.TagNumber(3)
  void clearUserId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get userName => $_getSZ(3);
  @$pb.TagNumber(4)
  set userName($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasUserName() => $_has(3);
  @$pb.TagNumber(4)
  void clearUserName() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get email => $_getSZ(4);
  @$pb.TagNumber(5)
  set email($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasEmail() => $_has(4);
  @$pb.TagNumber(5)
  void clearEmail() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get profileImage => $_getSZ(5);
  @$pb.TagNumber(6)
  set profileImage($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasProfileImage() => $_has(5);
  @$pb.TagNumber(6)
  void clearProfileImage() => clearField(6);

  @$pb.TagNumber(7)
  $1.Timestamp get joinedAt => $_getN(6);
  @$pb.TagNumber(7)
  set joinedAt($1.Timestamp v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasJoinedAt() => $_has(6);
  @$pb.TagNumber(7)
  void clearJoinedAt() => clearField(7);
  @$pb.TagNumber(7)
  $1.Timestamp ensureJoinedAt() => $_ensure(6);

  @$pb.TagNumber(8)
  $fixnum.Int64 get totalPaid => $_getI64(7);
  @$pb.TagNumber(8)
  set totalPaid($fixnum.Int64 v) { $_setInt64(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasTotalPaid() => $_has(7);
  @$pb.TagNumber(8)
  void clearTotalPaid() => clearField(8);

  @$pb.TagNumber(9)
  $fixnum.Int64 get expectedAmount => $_getI64(8);
  @$pb.TagNumber(9)
  set expectedAmount($fixnum.Int64 v) { $_setInt64(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasExpectedAmount() => $_has(8);
  @$pb.TagNumber(9)
  void clearExpectedAmount() => clearField(9);

  @$pb.TagNumber(10)
  $core.bool get hasPaidCurrentCycle => $_getBF(9);
  @$pb.TagNumber(10)
  set hasPaidCurrentCycle($core.bool v) { $_setBool(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasHasPaidCurrentCycle() => $_has(9);
  @$pb.TagNumber(10)
  void clearHasPaidCurrentCycle() => clearField(10);
}

class ContributionPaymentMessage extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ContributionPaymentMessage', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'contributionId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'groupId')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userName')
    ..a<$fixnum.Int64>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOM<$1.Timestamp>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'paymentDate', subBuilder: $1.Timestamp.create)
    ..e<PaymentStatus>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: PaymentStatus.PAYMENT_STATUS_UNSPECIFIED, valueOf: PaymentStatus.valueOf, enumValues: PaymentStatus.values)
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionId')
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'receiptId')
    ..aOS(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'notes')
    ..aOS(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'metadata')
    ..hasRequiredFields = false
  ;

  ContributionPaymentMessage._() : super();
  factory ContributionPaymentMessage({
    $core.String? id,
    $core.String? contributionId,
    $core.String? groupId,
    $core.String? userId,
    $core.String? userName,
    $fixnum.Int64? amount,
    $core.String? currency,
    $1.Timestamp? paymentDate,
    PaymentStatus? status,
    $core.String? transactionId,
    $core.String? receiptId,
    $core.String? notes,
    $core.String? metadata,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (contributionId != null) {
      _result.contributionId = contributionId;
    }
    if (groupId != null) {
      _result.groupId = groupId;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    if (userName != null) {
      _result.userName = userName;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (paymentDate != null) {
      _result.paymentDate = paymentDate;
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
    if (notes != null) {
      _result.notes = notes;
    }
    if (metadata != null) {
      _result.metadata = metadata;
    }
    return _result;
  }
  factory ContributionPaymentMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ContributionPaymentMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ContributionPaymentMessage clone() => ContributionPaymentMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ContributionPaymentMessage copyWith(void Function(ContributionPaymentMessage) updates) => super.copyWith((message) => updates(message as ContributionPaymentMessage)) as ContributionPaymentMessage; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ContributionPaymentMessage create() => ContributionPaymentMessage._();
  ContributionPaymentMessage createEmptyInstance() => create();
  static $pb.PbList<ContributionPaymentMessage> createRepeated() => $pb.PbList<ContributionPaymentMessage>();
  @$core.pragma('dart2js:noInline')
  static ContributionPaymentMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ContributionPaymentMessage>(create);
  static ContributionPaymentMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get contributionId => $_getSZ(1);
  @$pb.TagNumber(2)
  set contributionId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasContributionId() => $_has(1);
  @$pb.TagNumber(2)
  void clearContributionId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get groupId => $_getSZ(2);
  @$pb.TagNumber(3)
  set groupId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasGroupId() => $_has(2);
  @$pb.TagNumber(3)
  void clearGroupId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get userId => $_getSZ(3);
  @$pb.TagNumber(4)
  set userId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasUserId() => $_has(3);
  @$pb.TagNumber(4)
  void clearUserId() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get userName => $_getSZ(4);
  @$pb.TagNumber(5)
  set userName($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasUserName() => $_has(4);
  @$pb.TagNumber(5)
  void clearUserName() => clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get amount => $_getI64(5);
  @$pb.TagNumber(6)
  set amount($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasAmount() => $_has(5);
  @$pb.TagNumber(6)
  void clearAmount() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get currency => $_getSZ(6);
  @$pb.TagNumber(7)
  set currency($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasCurrency() => $_has(6);
  @$pb.TagNumber(7)
  void clearCurrency() => clearField(7);

  @$pb.TagNumber(8)
  $1.Timestamp get paymentDate => $_getN(7);
  @$pb.TagNumber(8)
  set paymentDate($1.Timestamp v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasPaymentDate() => $_has(7);
  @$pb.TagNumber(8)
  void clearPaymentDate() => clearField(8);
  @$pb.TagNumber(8)
  $1.Timestamp ensurePaymentDate() => $_ensure(7);

  @$pb.TagNumber(9)
  PaymentStatus get status => $_getN(8);
  @$pb.TagNumber(9)
  set status(PaymentStatus v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasStatus() => $_has(8);
  @$pb.TagNumber(9)
  void clearStatus() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get transactionId => $_getSZ(9);
  @$pb.TagNumber(10)
  set transactionId($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasTransactionId() => $_has(9);
  @$pb.TagNumber(10)
  void clearTransactionId() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get receiptId => $_getSZ(10);
  @$pb.TagNumber(11)
  set receiptId($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasReceiptId() => $_has(10);
  @$pb.TagNumber(11)
  void clearReceiptId() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get notes => $_getSZ(11);
  @$pb.TagNumber(12)
  set notes($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasNotes() => $_has(11);
  @$pb.TagNumber(12)
  void clearNotes() => clearField(12);

  @$pb.TagNumber(13)
  $core.String get metadata => $_getSZ(12);
  @$pb.TagNumber(13)
  set metadata($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasMetadata() => $_has(12);
  @$pb.TagNumber(13)
  void clearMetadata() => clearField(13);
}

class PayoutScheduleMessage extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PayoutScheduleMessage', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userName')
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'position', $pb.PbFieldType.O3)
    ..aOM<$1.Timestamp>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'scheduledDate', subBuilder: $1.Timestamp.create)
    ..a<$fixnum.Int64>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'expectedAmount', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..e<PayoutStatus>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: PayoutStatus.PAYOUT_STATUS_UNSPECIFIED, valueOf: PayoutStatus.valueOf, enumValues: PayoutStatus.values)
    ..aOM<$1.Timestamp>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'receivedDate', subBuilder: $1.Timestamp.create)
    ..a<$fixnum.Int64>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'actualAmount', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'notes')
    ..hasRequiredFields = false
  ;

  PayoutScheduleMessage._() : super();
  factory PayoutScheduleMessage({
    $core.String? id,
    $core.String? userId,
    $core.String? userName,
    $core.int? position,
    $1.Timestamp? scheduledDate,
    $fixnum.Int64? expectedAmount,
    PayoutStatus? status,
    $1.Timestamp? receivedDate,
    $fixnum.Int64? actualAmount,
    $core.String? notes,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    if (userName != null) {
      _result.userName = userName;
    }
    if (position != null) {
      _result.position = position;
    }
    if (scheduledDate != null) {
      _result.scheduledDate = scheduledDate;
    }
    if (expectedAmount != null) {
      _result.expectedAmount = expectedAmount;
    }
    if (status != null) {
      _result.status = status;
    }
    if (receivedDate != null) {
      _result.receivedDate = receivedDate;
    }
    if (actualAmount != null) {
      _result.actualAmount = actualAmount;
    }
    if (notes != null) {
      _result.notes = notes;
    }
    return _result;
  }
  factory PayoutScheduleMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PayoutScheduleMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PayoutScheduleMessage clone() => PayoutScheduleMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PayoutScheduleMessage copyWith(void Function(PayoutScheduleMessage) updates) => super.copyWith((message) => updates(message as PayoutScheduleMessage)) as PayoutScheduleMessage; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PayoutScheduleMessage create() => PayoutScheduleMessage._();
  PayoutScheduleMessage createEmptyInstance() => create();
  static $pb.PbList<PayoutScheduleMessage> createRepeated() => $pb.PbList<PayoutScheduleMessage>();
  @$core.pragma('dart2js:noInline')
  static PayoutScheduleMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PayoutScheduleMessage>(create);
  static PayoutScheduleMessage? _defaultInstance;

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
  $core.String get userName => $_getSZ(2);
  @$pb.TagNumber(3)
  set userName($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasUserName() => $_has(2);
  @$pb.TagNumber(3)
  void clearUserName() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get position => $_getIZ(3);
  @$pb.TagNumber(4)
  set position($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPosition() => $_has(3);
  @$pb.TagNumber(4)
  void clearPosition() => clearField(4);

  @$pb.TagNumber(5)
  $1.Timestamp get scheduledDate => $_getN(4);
  @$pb.TagNumber(5)
  set scheduledDate($1.Timestamp v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasScheduledDate() => $_has(4);
  @$pb.TagNumber(5)
  void clearScheduledDate() => clearField(5);
  @$pb.TagNumber(5)
  $1.Timestamp ensureScheduledDate() => $_ensure(4);

  @$pb.TagNumber(6)
  $fixnum.Int64 get expectedAmount => $_getI64(5);
  @$pb.TagNumber(6)
  set expectedAmount($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasExpectedAmount() => $_has(5);
  @$pb.TagNumber(6)
  void clearExpectedAmount() => clearField(6);

  @$pb.TagNumber(7)
  PayoutStatus get status => $_getN(6);
  @$pb.TagNumber(7)
  set status(PayoutStatus v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasStatus() => $_has(6);
  @$pb.TagNumber(7)
  void clearStatus() => clearField(7);

  @$pb.TagNumber(8)
  $1.Timestamp get receivedDate => $_getN(7);
  @$pb.TagNumber(8)
  set receivedDate($1.Timestamp v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasReceivedDate() => $_has(7);
  @$pb.TagNumber(8)
  void clearReceivedDate() => clearField(8);
  @$pb.TagNumber(8)
  $1.Timestamp ensureReceivedDate() => $_ensure(7);

  @$pb.TagNumber(9)
  $fixnum.Int64 get actualAmount => $_getI64(8);
  @$pb.TagNumber(9)
  set actualAmount($fixnum.Int64 v) { $_setInt64(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasActualAmount() => $_has(8);
  @$pb.TagNumber(9)
  void clearActualAmount() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get notes => $_getSZ(9);
  @$pb.TagNumber(10)
  set notes($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasNotes() => $_has(9);
  @$pb.TagNumber(10)
  void clearNotes() => clearField(10);
}

class PayoutTransactionMessage extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PayoutTransactionMessage', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'contributionId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'groupId')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recipientUserId')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recipientUserName')
    ..a<$fixnum.Int64>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOM<$1.Timestamp>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payoutDate', subBuilder: $1.Timestamp.create)
    ..e<PayoutTransactionStatus>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: PayoutTransactionStatus.PAYOUT_TRANSACTION_STATUS_UNSPECIFIED, valueOf: PayoutTransactionStatus.valueOf, enumValues: PayoutTransactionStatus.values)
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionId')
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'paymentMethod')
    ..aOS(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'failureReason')
    ..aOS(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'metadata')
    ..hasRequiredFields = false
  ;

  PayoutTransactionMessage._() : super();
  factory PayoutTransactionMessage({
    $core.String? id,
    $core.String? contributionId,
    $core.String? groupId,
    $core.String? recipientUserId,
    $core.String? recipientUserName,
    $fixnum.Int64? amount,
    $core.String? currency,
    $1.Timestamp? payoutDate,
    PayoutTransactionStatus? status,
    $core.String? transactionId,
    $core.String? paymentMethod,
    $core.String? failureReason,
    $core.String? metadata,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (contributionId != null) {
      _result.contributionId = contributionId;
    }
    if (groupId != null) {
      _result.groupId = groupId;
    }
    if (recipientUserId != null) {
      _result.recipientUserId = recipientUserId;
    }
    if (recipientUserName != null) {
      _result.recipientUserName = recipientUserName;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (payoutDate != null) {
      _result.payoutDate = payoutDate;
    }
    if (status != null) {
      _result.status = status;
    }
    if (transactionId != null) {
      _result.transactionId = transactionId;
    }
    if (paymentMethod != null) {
      _result.paymentMethod = paymentMethod;
    }
    if (failureReason != null) {
      _result.failureReason = failureReason;
    }
    if (metadata != null) {
      _result.metadata = metadata;
    }
    return _result;
  }
  factory PayoutTransactionMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PayoutTransactionMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PayoutTransactionMessage clone() => PayoutTransactionMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PayoutTransactionMessage copyWith(void Function(PayoutTransactionMessage) updates) => super.copyWith((message) => updates(message as PayoutTransactionMessage)) as PayoutTransactionMessage; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PayoutTransactionMessage create() => PayoutTransactionMessage._();
  PayoutTransactionMessage createEmptyInstance() => create();
  static $pb.PbList<PayoutTransactionMessage> createRepeated() => $pb.PbList<PayoutTransactionMessage>();
  @$core.pragma('dart2js:noInline')
  static PayoutTransactionMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PayoutTransactionMessage>(create);
  static PayoutTransactionMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get contributionId => $_getSZ(1);
  @$pb.TagNumber(2)
  set contributionId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasContributionId() => $_has(1);
  @$pb.TagNumber(2)
  void clearContributionId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get groupId => $_getSZ(2);
  @$pb.TagNumber(3)
  set groupId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasGroupId() => $_has(2);
  @$pb.TagNumber(3)
  void clearGroupId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get recipientUserId => $_getSZ(3);
  @$pb.TagNumber(4)
  set recipientUserId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasRecipientUserId() => $_has(3);
  @$pb.TagNumber(4)
  void clearRecipientUserId() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get recipientUserName => $_getSZ(4);
  @$pb.TagNumber(5)
  set recipientUserName($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasRecipientUserName() => $_has(4);
  @$pb.TagNumber(5)
  void clearRecipientUserName() => clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get amount => $_getI64(5);
  @$pb.TagNumber(6)
  set amount($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasAmount() => $_has(5);
  @$pb.TagNumber(6)
  void clearAmount() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get currency => $_getSZ(6);
  @$pb.TagNumber(7)
  set currency($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasCurrency() => $_has(6);
  @$pb.TagNumber(7)
  void clearCurrency() => clearField(7);

  @$pb.TagNumber(8)
  $1.Timestamp get payoutDate => $_getN(7);
  @$pb.TagNumber(8)
  set payoutDate($1.Timestamp v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasPayoutDate() => $_has(7);
  @$pb.TagNumber(8)
  void clearPayoutDate() => clearField(8);
  @$pb.TagNumber(8)
  $1.Timestamp ensurePayoutDate() => $_ensure(7);

  @$pb.TagNumber(9)
  PayoutTransactionStatus get status => $_getN(8);
  @$pb.TagNumber(9)
  set status(PayoutTransactionStatus v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasStatus() => $_has(8);
  @$pb.TagNumber(9)
  void clearStatus() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get transactionId => $_getSZ(9);
  @$pb.TagNumber(10)
  set transactionId($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasTransactionId() => $_has(9);
  @$pb.TagNumber(10)
  void clearTransactionId() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get paymentMethod => $_getSZ(10);
  @$pb.TagNumber(11)
  set paymentMethod($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasPaymentMethod() => $_has(10);
  @$pb.TagNumber(11)
  void clearPaymentMethod() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get failureReason => $_getSZ(11);
  @$pb.TagNumber(12)
  set failureReason($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasFailureReason() => $_has(11);
  @$pb.TagNumber(12)
  void clearFailureReason() => clearField(12);

  @$pb.TagNumber(13)
  $core.String get metadata => $_getSZ(12);
  @$pb.TagNumber(13)
  set metadata($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasMetadata() => $_has(12);
  @$pb.TagNumber(13)
  void clearMetadata() => clearField(13);
}

class ContributionReceiptMessage extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ContributionReceiptMessage', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'paymentId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'contributionId')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'groupId')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userName')
    ..a<$fixnum.Int64>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOM<$1.Timestamp>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'paymentDate', subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'generatedAt', subBuilder: $1.Timestamp.create)
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'receiptNumber')
    ..aOS(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'receiptData')
    ..hasRequiredFields = false
  ;

  ContributionReceiptMessage._() : super();
  factory ContributionReceiptMessage({
    $core.String? id,
    $core.String? paymentId,
    $core.String? contributionId,
    $core.String? groupId,
    $core.String? userId,
    $core.String? userName,
    $fixnum.Int64? amount,
    $core.String? currency,
    $1.Timestamp? paymentDate,
    $1.Timestamp? generatedAt,
    $core.String? receiptNumber,
    $core.String? receiptData,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (paymentId != null) {
      _result.paymentId = paymentId;
    }
    if (contributionId != null) {
      _result.contributionId = contributionId;
    }
    if (groupId != null) {
      _result.groupId = groupId;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    if (userName != null) {
      _result.userName = userName;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (paymentDate != null) {
      _result.paymentDate = paymentDate;
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
  factory ContributionReceiptMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ContributionReceiptMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ContributionReceiptMessage clone() => ContributionReceiptMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ContributionReceiptMessage copyWith(void Function(ContributionReceiptMessage) updates) => super.copyWith((message) => updates(message as ContributionReceiptMessage)) as ContributionReceiptMessage; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ContributionReceiptMessage create() => ContributionReceiptMessage._();
  ContributionReceiptMessage createEmptyInstance() => create();
  static $pb.PbList<ContributionReceiptMessage> createRepeated() => $pb.PbList<ContributionReceiptMessage>();
  @$core.pragma('dart2js:noInline')
  static ContributionReceiptMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ContributionReceiptMessage>(create);
  static ContributionReceiptMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get paymentId => $_getSZ(1);
  @$pb.TagNumber(2)
  set paymentId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPaymentId() => $_has(1);
  @$pb.TagNumber(2)
  void clearPaymentId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get contributionId => $_getSZ(2);
  @$pb.TagNumber(3)
  set contributionId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasContributionId() => $_has(2);
  @$pb.TagNumber(3)
  void clearContributionId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get groupId => $_getSZ(3);
  @$pb.TagNumber(4)
  set groupId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasGroupId() => $_has(3);
  @$pb.TagNumber(4)
  void clearGroupId() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get userId => $_getSZ(4);
  @$pb.TagNumber(5)
  set userId($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasUserId() => $_has(4);
  @$pb.TagNumber(5)
  void clearUserId() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get userName => $_getSZ(5);
  @$pb.TagNumber(6)
  set userName($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasUserName() => $_has(5);
  @$pb.TagNumber(6)
  void clearUserName() => clearField(6);

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
  $1.Timestamp get paymentDate => $_getN(8);
  @$pb.TagNumber(9)
  set paymentDate($1.Timestamp v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasPaymentDate() => $_has(8);
  @$pb.TagNumber(9)
  void clearPaymentDate() => clearField(9);
  @$pb.TagNumber(9)
  $1.Timestamp ensurePaymentDate() => $_ensure(8);

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

class ContributionTranscriptMessage extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ContributionTranscriptMessage', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'contributionId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'groupId')
    ..aOM<$1.Timestamp>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'generatedAt', subBuilder: $1.Timestamp.create)
    ..pc<ContributionPaymentMessage>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payments', $pb.PbFieldType.PM, subBuilder: ContributionPaymentMessage.create)
    ..a<$fixnum.Int64>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalAmount', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'memberContributions')
    ..hasRequiredFields = false
  ;

  ContributionTranscriptMessage._() : super();
  factory ContributionTranscriptMessage({
    $core.String? id,
    $core.String? contributionId,
    $core.String? groupId,
    $1.Timestamp? generatedAt,
    $core.Iterable<ContributionPaymentMessage>? payments,
    $fixnum.Int64? totalAmount,
    $core.String? currency,
    $core.String? memberContributions,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (contributionId != null) {
      _result.contributionId = contributionId;
    }
    if (groupId != null) {
      _result.groupId = groupId;
    }
    if (generatedAt != null) {
      _result.generatedAt = generatedAt;
    }
    if (payments != null) {
      _result.payments.addAll(payments);
    }
    if (totalAmount != null) {
      _result.totalAmount = totalAmount;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (memberContributions != null) {
      _result.memberContributions = memberContributions;
    }
    return _result;
  }
  factory ContributionTranscriptMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ContributionTranscriptMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ContributionTranscriptMessage clone() => ContributionTranscriptMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ContributionTranscriptMessage copyWith(void Function(ContributionTranscriptMessage) updates) => super.copyWith((message) => updates(message as ContributionTranscriptMessage)) as ContributionTranscriptMessage; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ContributionTranscriptMessage create() => ContributionTranscriptMessage._();
  ContributionTranscriptMessage createEmptyInstance() => create();
  static $pb.PbList<ContributionTranscriptMessage> createRepeated() => $pb.PbList<ContributionTranscriptMessage>();
  @$core.pragma('dart2js:noInline')
  static ContributionTranscriptMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ContributionTranscriptMessage>(create);
  static ContributionTranscriptMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get contributionId => $_getSZ(1);
  @$pb.TagNumber(2)
  set contributionId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasContributionId() => $_has(1);
  @$pb.TagNumber(2)
  void clearContributionId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get groupId => $_getSZ(2);
  @$pb.TagNumber(3)
  set groupId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasGroupId() => $_has(2);
  @$pb.TagNumber(3)
  void clearGroupId() => clearField(3);

  @$pb.TagNumber(4)
  $1.Timestamp get generatedAt => $_getN(3);
  @$pb.TagNumber(4)
  set generatedAt($1.Timestamp v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasGeneratedAt() => $_has(3);
  @$pb.TagNumber(4)
  void clearGeneratedAt() => clearField(4);
  @$pb.TagNumber(4)
  $1.Timestamp ensureGeneratedAt() => $_ensure(3);

  @$pb.TagNumber(5)
  $core.List<ContributionPaymentMessage> get payments => $_getList(4);

  @$pb.TagNumber(6)
  $fixnum.Int64 get totalAmount => $_getI64(5);
  @$pb.TagNumber(6)
  set totalAmount($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasTotalAmount() => $_has(5);
  @$pb.TagNumber(6)
  void clearTotalAmount() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get currency => $_getSZ(6);
  @$pb.TagNumber(7)
  set currency($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasCurrency() => $_has(6);
  @$pb.TagNumber(7)
  void clearCurrency() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get memberContributions => $_getSZ(7);
  @$pb.TagNumber(8)
  set memberContributions($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasMemberContributions() => $_has(7);
  @$pb.TagNumber(8)
  void clearMemberContributions() => clearField(8);
}

class CreateGroupRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateGroupRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..hasRequiredFields = false
  ;

  CreateGroupRequest._() : super();
  factory CreateGroupRequest({
    $core.String? name,
    $core.String? description,
  }) {
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    if (description != null) {
      _result.description = description;
    }
    return _result;
  }
  factory CreateGroupRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateGroupRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateGroupRequest clone() => CreateGroupRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateGroupRequest copyWith(void Function(CreateGroupRequest) updates) => super.copyWith((message) => updates(message as CreateGroupRequest)) as CreateGroupRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateGroupRequest create() => CreateGroupRequest._();
  CreateGroupRequest createEmptyInstance() => create();
  static $pb.PbList<CreateGroupRequest> createRepeated() => $pb.PbList<CreateGroupRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateGroupRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateGroupRequest>(create);
  static CreateGroupRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get description => $_getSZ(1);
  @$pb.TagNumber(2)
  set description($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasDescription() => $_has(1);
  @$pb.TagNumber(2)
  void clearDescription() => clearField(2);
}

class CreateGroupResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateGroupResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<GroupAccountMessage>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'group', subBuilder: GroupAccountMessage.create)
    ..hasRequiredFields = false
  ;

  CreateGroupResponse._() : super();
  factory CreateGroupResponse({
    GroupAccountMessage? group,
  }) {
    final _result = create();
    if (group != null) {
      _result.group = group;
    }
    return _result;
  }
  factory CreateGroupResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateGroupResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateGroupResponse clone() => CreateGroupResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateGroupResponse copyWith(void Function(CreateGroupResponse) updates) => super.copyWith((message) => updates(message as CreateGroupResponse)) as CreateGroupResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateGroupResponse create() => CreateGroupResponse._();
  CreateGroupResponse createEmptyInstance() => create();
  static $pb.PbList<CreateGroupResponse> createRepeated() => $pb.PbList<CreateGroupResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateGroupResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateGroupResponse>(create);
  static CreateGroupResponse? _defaultInstance;

  @$pb.TagNumber(1)
  GroupAccountMessage get group => $_getN(0);
  @$pb.TagNumber(1)
  set group(GroupAccountMessage v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasGroup() => $_has(0);
  @$pb.TagNumber(1)
  void clearGroup() => clearField(1);
  @$pb.TagNumber(1)
  GroupAccountMessage ensureGroup() => $_ensure(0);
}

class GetGroupRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetGroupRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'groupId')
    ..hasRequiredFields = false
  ;

  GetGroupRequest._() : super();
  factory GetGroupRequest({
    $core.String? groupId,
  }) {
    final _result = create();
    if (groupId != null) {
      _result.groupId = groupId;
    }
    return _result;
  }
  factory GetGroupRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetGroupRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetGroupRequest clone() => GetGroupRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetGroupRequest copyWith(void Function(GetGroupRequest) updates) => super.copyWith((message) => updates(message as GetGroupRequest)) as GetGroupRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetGroupRequest create() => GetGroupRequest._();
  GetGroupRequest createEmptyInstance() => create();
  static $pb.PbList<GetGroupRequest> createRepeated() => $pb.PbList<GetGroupRequest>();
  @$core.pragma('dart2js:noInline')
  static GetGroupRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetGroupRequest>(create);
  static GetGroupRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get groupId => $_getSZ(0);
  @$pb.TagNumber(1)
  set groupId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasGroupId() => $_has(0);
  @$pb.TagNumber(1)
  void clearGroupId() => clearField(1);
}

class GetGroupResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetGroupResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<GroupAccountMessage>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'group', subBuilder: GroupAccountMessage.create)
    ..hasRequiredFields = false
  ;

  GetGroupResponse._() : super();
  factory GetGroupResponse({
    GroupAccountMessage? group,
  }) {
    final _result = create();
    if (group != null) {
      _result.group = group;
    }
    return _result;
  }
  factory GetGroupResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetGroupResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetGroupResponse clone() => GetGroupResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetGroupResponse copyWith(void Function(GetGroupResponse) updates) => super.copyWith((message) => updates(message as GetGroupResponse)) as GetGroupResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetGroupResponse create() => GetGroupResponse._();
  GetGroupResponse createEmptyInstance() => create();
  static $pb.PbList<GetGroupResponse> createRepeated() => $pb.PbList<GetGroupResponse>();
  @$core.pragma('dart2js:noInline')
  static GetGroupResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetGroupResponse>(create);
  static GetGroupResponse? _defaultInstance;

  @$pb.TagNumber(1)
  GroupAccountMessage get group => $_getN(0);
  @$pb.TagNumber(1)
  set group(GroupAccountMessage v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasGroup() => $_has(0);
  @$pb.TagNumber(1)
  void clearGroup() => clearField(1);
  @$pb.TagNumber(1)
  GroupAccountMessage ensureGroup() => $_ensure(0);
}

class ListUserGroupsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ListUserGroupsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..hasRequiredFields = false
  ;

  ListUserGroupsRequest._() : super();
  factory ListUserGroupsRequest({
    $core.int? page,
    $core.int? pageSize,
    $core.String? status,
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
    return _result;
  }
  factory ListUserGroupsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListUserGroupsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListUserGroupsRequest clone() => ListUserGroupsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListUserGroupsRequest copyWith(void Function(ListUserGroupsRequest) updates) => super.copyWith((message) => updates(message as ListUserGroupsRequest)) as ListUserGroupsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ListUserGroupsRequest create() => ListUserGroupsRequest._();
  ListUserGroupsRequest createEmptyInstance() => create();
  static $pb.PbList<ListUserGroupsRequest> createRepeated() => $pb.PbList<ListUserGroupsRequest>();
  @$core.pragma('dart2js:noInline')
  static ListUserGroupsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListUserGroupsRequest>(create);
  static ListUserGroupsRequest? _defaultInstance;

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

class ListUserGroupsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ListUserGroupsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<GroupAccountMessage>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'groups', $pb.PbFieldType.PM, subBuilder: GroupAccountMessage.create)
    ..aOM<GroupPaginationInfo>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pagination', subBuilder: GroupPaginationInfo.create)
    ..hasRequiredFields = false
  ;

  ListUserGroupsResponse._() : super();
  factory ListUserGroupsResponse({
    $core.Iterable<GroupAccountMessage>? groups,
    GroupPaginationInfo? pagination,
  }) {
    final _result = create();
    if (groups != null) {
      _result.groups.addAll(groups);
    }
    if (pagination != null) {
      _result.pagination = pagination;
    }
    return _result;
  }
  factory ListUserGroupsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListUserGroupsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListUserGroupsResponse clone() => ListUserGroupsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListUserGroupsResponse copyWith(void Function(ListUserGroupsResponse) updates) => super.copyWith((message) => updates(message as ListUserGroupsResponse)) as ListUserGroupsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ListUserGroupsResponse create() => ListUserGroupsResponse._();
  ListUserGroupsResponse createEmptyInstance() => create();
  static $pb.PbList<ListUserGroupsResponse> createRepeated() => $pb.PbList<ListUserGroupsResponse>();
  @$core.pragma('dart2js:noInline')
  static ListUserGroupsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListUserGroupsResponse>(create);
  static ListUserGroupsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<GroupAccountMessage> get groups => $_getList(0);

  @$pb.TagNumber(2)
  GroupPaginationInfo get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination(GroupPaginationInfo v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => clearField(2);
  @$pb.TagNumber(2)
  GroupPaginationInfo ensurePagination() => $_ensure(1);
}

class UpdateGroupRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateGroupRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'groupId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..e<GroupAccountStatus>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: GroupAccountStatus.GROUP_ACCOUNT_STATUS_UNSPECIFIED, valueOf: GroupAccountStatus.valueOf, enumValues: GroupAccountStatus.values)
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'metadata')
    ..hasRequiredFields = false
  ;

  UpdateGroupRequest._() : super();
  factory UpdateGroupRequest({
    $core.String? groupId,
    $core.String? name,
    $core.String? description,
    GroupAccountStatus? status,
    $core.String? metadata,
  }) {
    final _result = create();
    if (groupId != null) {
      _result.groupId = groupId;
    }
    if (name != null) {
      _result.name = name;
    }
    if (description != null) {
      _result.description = description;
    }
    if (status != null) {
      _result.status = status;
    }
    if (metadata != null) {
      _result.metadata = metadata;
    }
    return _result;
  }
  factory UpdateGroupRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateGroupRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateGroupRequest clone() => UpdateGroupRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateGroupRequest copyWith(void Function(UpdateGroupRequest) updates) => super.copyWith((message) => updates(message as UpdateGroupRequest)) as UpdateGroupRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UpdateGroupRequest create() => UpdateGroupRequest._();
  UpdateGroupRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateGroupRequest> createRepeated() => $pb.PbList<UpdateGroupRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateGroupRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateGroupRequest>(create);
  static UpdateGroupRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get groupId => $_getSZ(0);
  @$pb.TagNumber(1)
  set groupId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasGroupId() => $_has(0);
  @$pb.TagNumber(1)
  void clearGroupId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => clearField(3);

  @$pb.TagNumber(4)
  GroupAccountStatus get status => $_getN(3);
  @$pb.TagNumber(4)
  set status(GroupAccountStatus v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasStatus() => $_has(3);
  @$pb.TagNumber(4)
  void clearStatus() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get metadata => $_getSZ(4);
  @$pb.TagNumber(5)
  set metadata($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasMetadata() => $_has(4);
  @$pb.TagNumber(5)
  void clearMetadata() => clearField(5);
}

class UpdateGroupResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateGroupResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<GroupAccountMessage>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'group', subBuilder: GroupAccountMessage.create)
    ..hasRequiredFields = false
  ;

  UpdateGroupResponse._() : super();
  factory UpdateGroupResponse({
    GroupAccountMessage? group,
  }) {
    final _result = create();
    if (group != null) {
      _result.group = group;
    }
    return _result;
  }
  factory UpdateGroupResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateGroupResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateGroupResponse clone() => UpdateGroupResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateGroupResponse copyWith(void Function(UpdateGroupResponse) updates) => super.copyWith((message) => updates(message as UpdateGroupResponse)) as UpdateGroupResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UpdateGroupResponse create() => UpdateGroupResponse._();
  UpdateGroupResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateGroupResponse> createRepeated() => $pb.PbList<UpdateGroupResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateGroupResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateGroupResponse>(create);
  static UpdateGroupResponse? _defaultInstance;

  @$pb.TagNumber(1)
  GroupAccountMessage get group => $_getN(0);
  @$pb.TagNumber(1)
  set group(GroupAccountMessage v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasGroup() => $_has(0);
  @$pb.TagNumber(1)
  void clearGroup() => clearField(1);
  @$pb.TagNumber(1)
  GroupAccountMessage ensureGroup() => $_ensure(0);
}

class DeleteGroupRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DeleteGroupRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'groupId')
    ..hasRequiredFields = false
  ;

  DeleteGroupRequest._() : super();
  factory DeleteGroupRequest({
    $core.String? groupId,
  }) {
    final _result = create();
    if (groupId != null) {
      _result.groupId = groupId;
    }
    return _result;
  }
  factory DeleteGroupRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteGroupRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteGroupRequest clone() => DeleteGroupRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteGroupRequest copyWith(void Function(DeleteGroupRequest) updates) => super.copyWith((message) => updates(message as DeleteGroupRequest)) as DeleteGroupRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DeleteGroupRequest create() => DeleteGroupRequest._();
  DeleteGroupRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteGroupRequest> createRepeated() => $pb.PbList<DeleteGroupRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteGroupRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteGroupRequest>(create);
  static DeleteGroupRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get groupId => $_getSZ(0);
  @$pb.TagNumber(1)
  set groupId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasGroupId() => $_has(0);
  @$pb.TagNumber(1)
  void clearGroupId() => clearField(1);
}

class DeleteGroupResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DeleteGroupResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..hasRequiredFields = false
  ;

  DeleteGroupResponse._() : super();
  factory DeleteGroupResponse({
    $core.bool? success,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    return _result;
  }
  factory DeleteGroupResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteGroupResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteGroupResponse clone() => DeleteGroupResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteGroupResponse copyWith(void Function(DeleteGroupResponse) updates) => super.copyWith((message) => updates(message as DeleteGroupResponse)) as DeleteGroupResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DeleteGroupResponse create() => DeleteGroupResponse._();
  DeleteGroupResponse createEmptyInstance() => create();
  static $pb.PbList<DeleteGroupResponse> createRepeated() => $pb.PbList<DeleteGroupResponse>();
  @$core.pragma('dart2js:noInline')
  static DeleteGroupResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteGroupResponse>(create);
  static DeleteGroupResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);
}

class GetGroupMembersRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetGroupMembersRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'groupId')
    ..hasRequiredFields = false
  ;

  GetGroupMembersRequest._() : super();
  factory GetGroupMembersRequest({
    $core.String? groupId,
  }) {
    final _result = create();
    if (groupId != null) {
      _result.groupId = groupId;
    }
    return _result;
  }
  factory GetGroupMembersRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetGroupMembersRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetGroupMembersRequest clone() => GetGroupMembersRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetGroupMembersRequest copyWith(void Function(GetGroupMembersRequest) updates) => super.copyWith((message) => updates(message as GetGroupMembersRequest)) as GetGroupMembersRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetGroupMembersRequest create() => GetGroupMembersRequest._();
  GetGroupMembersRequest createEmptyInstance() => create();
  static $pb.PbList<GetGroupMembersRequest> createRepeated() => $pb.PbList<GetGroupMembersRequest>();
  @$core.pragma('dart2js:noInline')
  static GetGroupMembersRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetGroupMembersRequest>(create);
  static GetGroupMembersRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get groupId => $_getSZ(0);
  @$pb.TagNumber(1)
  set groupId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasGroupId() => $_has(0);
  @$pb.TagNumber(1)
  void clearGroupId() => clearField(1);
}

class GetGroupMembersResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetGroupMembersResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<GroupMemberMessage>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'members', $pb.PbFieldType.PM, subBuilder: GroupMemberMessage.create)
    ..hasRequiredFields = false
  ;

  GetGroupMembersResponse._() : super();
  factory GetGroupMembersResponse({
    $core.Iterable<GroupMemberMessage>? members,
  }) {
    final _result = create();
    if (members != null) {
      _result.members.addAll(members);
    }
    return _result;
  }
  factory GetGroupMembersResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetGroupMembersResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetGroupMembersResponse clone() => GetGroupMembersResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetGroupMembersResponse copyWith(void Function(GetGroupMembersResponse) updates) => super.copyWith((message) => updates(message as GetGroupMembersResponse)) as GetGroupMembersResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetGroupMembersResponse create() => GetGroupMembersResponse._();
  GetGroupMembersResponse createEmptyInstance() => create();
  static $pb.PbList<GetGroupMembersResponse> createRepeated() => $pb.PbList<GetGroupMembersResponse>();
  @$core.pragma('dart2js:noInline')
  static GetGroupMembersResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetGroupMembersResponse>(create);
  static GetGroupMembersResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<GroupMemberMessage> get members => $_getList(0);
}

class AddMemberRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AddMemberRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'groupId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..e<GroupMemberRole>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'role', $pb.PbFieldType.OE, defaultOrMaker: GroupMemberRole.GROUP_MEMBER_ROLE_UNSPECIFIED, valueOf: GroupMemberRole.valueOf, enumValues: GroupMemberRole.values)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'email')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'phoneNumber')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lookupUsername')
    ..hasRequiredFields = false
  ;

  AddMemberRequest._() : super();
  factory AddMemberRequest({
    $core.String? groupId,
    $core.String? userId,
    GroupMemberRole? role,
    $core.String? email,
    $core.String? phoneNumber,
    $core.String? lookupUsername,
  }) {
    final _result = create();
    if (groupId != null) {
      _result.groupId = groupId;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    if (role != null) {
      _result.role = role;
    }
    if (email != null) {
      _result.email = email;
    }
    if (phoneNumber != null) {
      _result.phoneNumber = phoneNumber;
    }
    if (lookupUsername != null) {
      _result.lookupUsername = lookupUsername;
    }
    return _result;
  }
  factory AddMemberRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddMemberRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddMemberRequest clone() => AddMemberRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddMemberRequest copyWith(void Function(AddMemberRequest) updates) => super.copyWith((message) => updates(message as AddMemberRequest)) as AddMemberRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AddMemberRequest create() => AddMemberRequest._();
  AddMemberRequest createEmptyInstance() => create();
  static $pb.PbList<AddMemberRequest> createRepeated() => $pb.PbList<AddMemberRequest>();
  @$core.pragma('dart2js:noInline')
  static AddMemberRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddMemberRequest>(create);
  static AddMemberRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get groupId => $_getSZ(0);
  @$pb.TagNumber(1)
  set groupId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasGroupId() => $_has(0);
  @$pb.TagNumber(1)
  void clearGroupId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => clearField(2);

  @$pb.TagNumber(3)
  GroupMemberRole get role => $_getN(2);
  @$pb.TagNumber(3)
  set role(GroupMemberRole v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasRole() => $_has(2);
  @$pb.TagNumber(3)
  void clearRole() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get email => $_getSZ(3);
  @$pb.TagNumber(4)
  set email($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasEmail() => $_has(3);
  @$pb.TagNumber(4)
  void clearEmail() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get phoneNumber => $_getSZ(4);
  @$pb.TagNumber(5)
  set phoneNumber($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasPhoneNumber() => $_has(4);
  @$pb.TagNumber(5)
  void clearPhoneNumber() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get lookupUsername => $_getSZ(5);
  @$pb.TagNumber(6)
  set lookupUsername($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasLookupUsername() => $_has(5);
  @$pb.TagNumber(6)
  void clearLookupUsername() => clearField(6);
}

class AddMemberResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AddMemberResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<GroupMemberMessage>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'member', subBuilder: GroupMemberMessage.create)
    ..hasRequiredFields = false
  ;

  AddMemberResponse._() : super();
  factory AddMemberResponse({
    GroupMemberMessage? member,
  }) {
    final _result = create();
    if (member != null) {
      _result.member = member;
    }
    return _result;
  }
  factory AddMemberResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddMemberResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddMemberResponse clone() => AddMemberResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddMemberResponse copyWith(void Function(AddMemberResponse) updates) => super.copyWith((message) => updates(message as AddMemberResponse)) as AddMemberResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AddMemberResponse create() => AddMemberResponse._();
  AddMemberResponse createEmptyInstance() => create();
  static $pb.PbList<AddMemberResponse> createRepeated() => $pb.PbList<AddMemberResponse>();
  @$core.pragma('dart2js:noInline')
  static AddMemberResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddMemberResponse>(create);
  static AddMemberResponse? _defaultInstance;

  @$pb.TagNumber(1)
  GroupMemberMessage get member => $_getN(0);
  @$pb.TagNumber(1)
  set member(GroupMemberMessage v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasMember() => $_has(0);
  @$pb.TagNumber(1)
  void clearMember() => clearField(1);
  @$pb.TagNumber(1)
  GroupMemberMessage ensureMember() => $_ensure(0);
}

class UpdateMemberRoleRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateMemberRoleRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'groupId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'memberId')
    ..e<GroupMemberRole>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'newRole', $pb.PbFieldType.OE, defaultOrMaker: GroupMemberRole.GROUP_MEMBER_ROLE_UNSPECIFIED, valueOf: GroupMemberRole.valueOf, enumValues: GroupMemberRole.values)
    ..hasRequiredFields = false
  ;

  UpdateMemberRoleRequest._() : super();
  factory UpdateMemberRoleRequest({
    $core.String? groupId,
    $core.String? memberId,
    GroupMemberRole? newRole,
  }) {
    final _result = create();
    if (groupId != null) {
      _result.groupId = groupId;
    }
    if (memberId != null) {
      _result.memberId = memberId;
    }
    if (newRole != null) {
      _result.newRole = newRole;
    }
    return _result;
  }
  factory UpdateMemberRoleRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateMemberRoleRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateMemberRoleRequest clone() => UpdateMemberRoleRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateMemberRoleRequest copyWith(void Function(UpdateMemberRoleRequest) updates) => super.copyWith((message) => updates(message as UpdateMemberRoleRequest)) as UpdateMemberRoleRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UpdateMemberRoleRequest create() => UpdateMemberRoleRequest._();
  UpdateMemberRoleRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateMemberRoleRequest> createRepeated() => $pb.PbList<UpdateMemberRoleRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateMemberRoleRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateMemberRoleRequest>(create);
  static UpdateMemberRoleRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get groupId => $_getSZ(0);
  @$pb.TagNumber(1)
  set groupId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasGroupId() => $_has(0);
  @$pb.TagNumber(1)
  void clearGroupId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get memberId => $_getSZ(1);
  @$pb.TagNumber(2)
  set memberId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMemberId() => $_has(1);
  @$pb.TagNumber(2)
  void clearMemberId() => clearField(2);

  @$pb.TagNumber(3)
  GroupMemberRole get newRole => $_getN(2);
  @$pb.TagNumber(3)
  set newRole(GroupMemberRole v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasNewRole() => $_has(2);
  @$pb.TagNumber(3)
  void clearNewRole() => clearField(3);
}

class UpdateMemberRoleResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateMemberRoleResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<GroupMemberMessage>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'member', subBuilder: GroupMemberMessage.create)
    ..hasRequiredFields = false
  ;

  UpdateMemberRoleResponse._() : super();
  factory UpdateMemberRoleResponse({
    GroupMemberMessage? member,
  }) {
    final _result = create();
    if (member != null) {
      _result.member = member;
    }
    return _result;
  }
  factory UpdateMemberRoleResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateMemberRoleResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateMemberRoleResponse clone() => UpdateMemberRoleResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateMemberRoleResponse copyWith(void Function(UpdateMemberRoleResponse) updates) => super.copyWith((message) => updates(message as UpdateMemberRoleResponse)) as UpdateMemberRoleResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UpdateMemberRoleResponse create() => UpdateMemberRoleResponse._();
  UpdateMemberRoleResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateMemberRoleResponse> createRepeated() => $pb.PbList<UpdateMemberRoleResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateMemberRoleResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateMemberRoleResponse>(create);
  static UpdateMemberRoleResponse? _defaultInstance;

  @$pb.TagNumber(1)
  GroupMemberMessage get member => $_getN(0);
  @$pb.TagNumber(1)
  set member(GroupMemberMessage v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasMember() => $_has(0);
  @$pb.TagNumber(1)
  void clearMember() => clearField(1);
  @$pb.TagNumber(1)
  GroupMemberMessage ensureMember() => $_ensure(0);
}

class RemoveMemberRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RemoveMemberRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'groupId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'memberId')
    ..hasRequiredFields = false
  ;

  RemoveMemberRequest._() : super();
  factory RemoveMemberRequest({
    $core.String? groupId,
    $core.String? memberId,
  }) {
    final _result = create();
    if (groupId != null) {
      _result.groupId = groupId;
    }
    if (memberId != null) {
      _result.memberId = memberId;
    }
    return _result;
  }
  factory RemoveMemberRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RemoveMemberRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RemoveMemberRequest clone() => RemoveMemberRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RemoveMemberRequest copyWith(void Function(RemoveMemberRequest) updates) => super.copyWith((message) => updates(message as RemoveMemberRequest)) as RemoveMemberRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RemoveMemberRequest create() => RemoveMemberRequest._();
  RemoveMemberRequest createEmptyInstance() => create();
  static $pb.PbList<RemoveMemberRequest> createRepeated() => $pb.PbList<RemoveMemberRequest>();
  @$core.pragma('dart2js:noInline')
  static RemoveMemberRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RemoveMemberRequest>(create);
  static RemoveMemberRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get groupId => $_getSZ(0);
  @$pb.TagNumber(1)
  set groupId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasGroupId() => $_has(0);
  @$pb.TagNumber(1)
  void clearGroupId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get memberId => $_getSZ(1);
  @$pb.TagNumber(2)
  set memberId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMemberId() => $_has(1);
  @$pb.TagNumber(2)
  void clearMemberId() => clearField(2);
}

class RemoveMemberResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RemoveMemberResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..hasRequiredFields = false
  ;

  RemoveMemberResponse._() : super();
  factory RemoveMemberResponse({
    $core.bool? success,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    return _result;
  }
  factory RemoveMemberResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RemoveMemberResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RemoveMemberResponse clone() => RemoveMemberResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RemoveMemberResponse copyWith(void Function(RemoveMemberResponse) updates) => super.copyWith((message) => updates(message as RemoveMemberResponse)) as RemoveMemberResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RemoveMemberResponse create() => RemoveMemberResponse._();
  RemoveMemberResponse createEmptyInstance() => create();
  static $pb.PbList<RemoveMemberResponse> createRepeated() => $pb.PbList<RemoveMemberResponse>();
  @$core.pragma('dart2js:noInline')
  static RemoveMemberResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RemoveMemberResponse>(create);
  static RemoveMemberResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);
}

class SearchUsersRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SearchUsersRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'query')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  SearchUsersRequest._() : super();
  factory SearchUsersRequest({
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
  factory SearchUsersRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SearchUsersRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SearchUsersRequest clone() => SearchUsersRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SearchUsersRequest copyWith(void Function(SearchUsersRequest) updates) => super.copyWith((message) => updates(message as SearchUsersRequest)) as SearchUsersRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SearchUsersRequest create() => SearchUsersRequest._();
  SearchUsersRequest createEmptyInstance() => create();
  static $pb.PbList<SearchUsersRequest> createRepeated() => $pb.PbList<SearchUsersRequest>();
  @$core.pragma('dart2js:noInline')
  static SearchUsersRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SearchUsersRequest>(create);
  static SearchUsersRequest? _defaultInstance;

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

class SearchUsersResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SearchUsersResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<GroupMemberMessage>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'users', $pb.PbFieldType.PM, subBuilder: GroupMemberMessage.create)
    ..hasRequiredFields = false
  ;

  SearchUsersResponse._() : super();
  factory SearchUsersResponse({
    $core.Iterable<GroupMemberMessage>? users,
  }) {
    final _result = create();
    if (users != null) {
      _result.users.addAll(users);
    }
    return _result;
  }
  factory SearchUsersResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SearchUsersResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SearchUsersResponse clone() => SearchUsersResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SearchUsersResponse copyWith(void Function(SearchUsersResponse) updates) => super.copyWith((message) => updates(message as SearchUsersResponse)) as SearchUsersResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SearchUsersResponse create() => SearchUsersResponse._();
  SearchUsersResponse createEmptyInstance() => create();
  static $pb.PbList<SearchUsersResponse> createRepeated() => $pb.PbList<SearchUsersResponse>();
  @$core.pragma('dart2js:noInline')
  static SearchUsersResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SearchUsersResponse>(create);
  static SearchUsersResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<GroupMemberMessage> get users => $_getList(0);
}

class CreateContributionRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateContributionRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'groupId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'title')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..a<$fixnum.Int64>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'targetAmount', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOM<$1.Timestamp>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'deadline', subBuilder: $1.Timestamp.create)
    ..e<ContributionType>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type', $pb.PbFieldType.OE, defaultOrMaker: ContributionType.CONTRIBUTION_TYPE_UNSPECIFIED, valueOf: ContributionType.valueOf, enumValues: ContributionType.values)
    ..e<ContributionFrequency>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'frequency', $pb.PbFieldType.OE, defaultOrMaker: ContributionFrequency.CONTRIBUTION_FREQUENCY_UNSPECIFIED, valueOf: ContributionFrequency.valueOf, enumValues: ContributionFrequency.values)
    ..a<$fixnum.Int64>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'regularAmount', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<$1.Timestamp>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'startDate', subBuilder: $1.Timestamp.create)
    ..a<$core.int>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalCycles', $pb.PbFieldType.O3)
    ..pPS(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'memberRotationOrder')
    ..aOB(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'autoPayEnabled')
    ..a<$fixnum.Int64>(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'penaltyAmount', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'gracePeriodDays', $pb.PbFieldType.O3)
    ..aOB(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'allowPartialPayments')
    ..a<$fixnum.Int64>(17, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'minimumBalance', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  CreateContributionRequest._() : super();
  factory CreateContributionRequest({
    $core.String? groupId,
    $core.String? title,
    $core.String? description,
    $fixnum.Int64? targetAmount,
    $core.String? currency,
    $1.Timestamp? deadline,
    ContributionType? type,
    ContributionFrequency? frequency,
    $fixnum.Int64? regularAmount,
    $1.Timestamp? startDate,
    $core.int? totalCycles,
    $core.Iterable<$core.String>? memberRotationOrder,
    $core.bool? autoPayEnabled,
    $fixnum.Int64? penaltyAmount,
    $core.int? gracePeriodDays,
    $core.bool? allowPartialPayments,
    $fixnum.Int64? minimumBalance,
  }) {
    final _result = create();
    if (groupId != null) {
      _result.groupId = groupId;
    }
    if (title != null) {
      _result.title = title;
    }
    if (description != null) {
      _result.description = description;
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
    if (type != null) {
      _result.type = type;
    }
    if (frequency != null) {
      _result.frequency = frequency;
    }
    if (regularAmount != null) {
      _result.regularAmount = regularAmount;
    }
    if (startDate != null) {
      _result.startDate = startDate;
    }
    if (totalCycles != null) {
      _result.totalCycles = totalCycles;
    }
    if (memberRotationOrder != null) {
      _result.memberRotationOrder.addAll(memberRotationOrder);
    }
    if (autoPayEnabled != null) {
      _result.autoPayEnabled = autoPayEnabled;
    }
    if (penaltyAmount != null) {
      _result.penaltyAmount = penaltyAmount;
    }
    if (gracePeriodDays != null) {
      _result.gracePeriodDays = gracePeriodDays;
    }
    if (allowPartialPayments != null) {
      _result.allowPartialPayments = allowPartialPayments;
    }
    if (minimumBalance != null) {
      _result.minimumBalance = minimumBalance;
    }
    return _result;
  }
  factory CreateContributionRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateContributionRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateContributionRequest clone() => CreateContributionRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateContributionRequest copyWith(void Function(CreateContributionRequest) updates) => super.copyWith((message) => updates(message as CreateContributionRequest)) as CreateContributionRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateContributionRequest create() => CreateContributionRequest._();
  CreateContributionRequest createEmptyInstance() => create();
  static $pb.PbList<CreateContributionRequest> createRepeated() => $pb.PbList<CreateContributionRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateContributionRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateContributionRequest>(create);
  static CreateContributionRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get groupId => $_getSZ(0);
  @$pb.TagNumber(1)
  set groupId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasGroupId() => $_has(0);
  @$pb.TagNumber(1)
  void clearGroupId() => clearField(1);

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
  ContributionType get type => $_getN(6);
  @$pb.TagNumber(7)
  set type(ContributionType v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasType() => $_has(6);
  @$pb.TagNumber(7)
  void clearType() => clearField(7);

  @$pb.TagNumber(8)
  ContributionFrequency get frequency => $_getN(7);
  @$pb.TagNumber(8)
  set frequency(ContributionFrequency v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasFrequency() => $_has(7);
  @$pb.TagNumber(8)
  void clearFrequency() => clearField(8);

  @$pb.TagNumber(9)
  $fixnum.Int64 get regularAmount => $_getI64(8);
  @$pb.TagNumber(9)
  set regularAmount($fixnum.Int64 v) { $_setInt64(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasRegularAmount() => $_has(8);
  @$pb.TagNumber(9)
  void clearRegularAmount() => clearField(9);

  @$pb.TagNumber(10)
  $1.Timestamp get startDate => $_getN(9);
  @$pb.TagNumber(10)
  set startDate($1.Timestamp v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasStartDate() => $_has(9);
  @$pb.TagNumber(10)
  void clearStartDate() => clearField(10);
  @$pb.TagNumber(10)
  $1.Timestamp ensureStartDate() => $_ensure(9);

  @$pb.TagNumber(11)
  $core.int get totalCycles => $_getIZ(10);
  @$pb.TagNumber(11)
  set totalCycles($core.int v) { $_setSignedInt32(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasTotalCycles() => $_has(10);
  @$pb.TagNumber(11)
  void clearTotalCycles() => clearField(11);

  @$pb.TagNumber(12)
  $core.List<$core.String> get memberRotationOrder => $_getList(11);

  @$pb.TagNumber(13)
  $core.bool get autoPayEnabled => $_getBF(12);
  @$pb.TagNumber(13)
  set autoPayEnabled($core.bool v) { $_setBool(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasAutoPayEnabled() => $_has(12);
  @$pb.TagNumber(13)
  void clearAutoPayEnabled() => clearField(13);

  @$pb.TagNumber(14)
  $fixnum.Int64 get penaltyAmount => $_getI64(13);
  @$pb.TagNumber(14)
  set penaltyAmount($fixnum.Int64 v) { $_setInt64(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasPenaltyAmount() => $_has(13);
  @$pb.TagNumber(14)
  void clearPenaltyAmount() => clearField(14);

  @$pb.TagNumber(15)
  $core.int get gracePeriodDays => $_getIZ(14);
  @$pb.TagNumber(15)
  set gracePeriodDays($core.int v) { $_setSignedInt32(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasGracePeriodDays() => $_has(14);
  @$pb.TagNumber(15)
  void clearGracePeriodDays() => clearField(15);

  @$pb.TagNumber(16)
  $core.bool get allowPartialPayments => $_getBF(15);
  @$pb.TagNumber(16)
  set allowPartialPayments($core.bool v) { $_setBool(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasAllowPartialPayments() => $_has(15);
  @$pb.TagNumber(16)
  void clearAllowPartialPayments() => clearField(16);

  @$pb.TagNumber(17)
  $fixnum.Int64 get minimumBalance => $_getI64(16);
  @$pb.TagNumber(17)
  set minimumBalance($fixnum.Int64 v) { $_setInt64(16, v); }
  @$pb.TagNumber(17)
  $core.bool hasMinimumBalance() => $_has(16);
  @$pb.TagNumber(17)
  void clearMinimumBalance() => clearField(17);
}

class CreateContributionResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateContributionResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<ContributionMessage>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'contribution', subBuilder: ContributionMessage.create)
    ..hasRequiredFields = false
  ;

  CreateContributionResponse._() : super();
  factory CreateContributionResponse({
    ContributionMessage? contribution,
  }) {
    final _result = create();
    if (contribution != null) {
      _result.contribution = contribution;
    }
    return _result;
  }
  factory CreateContributionResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateContributionResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateContributionResponse clone() => CreateContributionResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateContributionResponse copyWith(void Function(CreateContributionResponse) updates) => super.copyWith((message) => updates(message as CreateContributionResponse)) as CreateContributionResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateContributionResponse create() => CreateContributionResponse._();
  CreateContributionResponse createEmptyInstance() => create();
  static $pb.PbList<CreateContributionResponse> createRepeated() => $pb.PbList<CreateContributionResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateContributionResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateContributionResponse>(create);
  static CreateContributionResponse? _defaultInstance;

  @$pb.TagNumber(1)
  ContributionMessage get contribution => $_getN(0);
  @$pb.TagNumber(1)
  set contribution(ContributionMessage v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasContribution() => $_has(0);
  @$pb.TagNumber(1)
  void clearContribution() => clearField(1);
  @$pb.TagNumber(1)
  ContributionMessage ensureContribution() => $_ensure(0);
}

class GetContributionRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetContributionRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'contributionId')
    ..hasRequiredFields = false
  ;

  GetContributionRequest._() : super();
  factory GetContributionRequest({
    $core.String? contributionId,
  }) {
    final _result = create();
    if (contributionId != null) {
      _result.contributionId = contributionId;
    }
    return _result;
  }
  factory GetContributionRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetContributionRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetContributionRequest clone() => GetContributionRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetContributionRequest copyWith(void Function(GetContributionRequest) updates) => super.copyWith((message) => updates(message as GetContributionRequest)) as GetContributionRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetContributionRequest create() => GetContributionRequest._();
  GetContributionRequest createEmptyInstance() => create();
  static $pb.PbList<GetContributionRequest> createRepeated() => $pb.PbList<GetContributionRequest>();
  @$core.pragma('dart2js:noInline')
  static GetContributionRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetContributionRequest>(create);
  static GetContributionRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get contributionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set contributionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasContributionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearContributionId() => clearField(1);
}

class GetContributionResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetContributionResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<ContributionMessage>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'contribution', subBuilder: ContributionMessage.create)
    ..hasRequiredFields = false
  ;

  GetContributionResponse._() : super();
  factory GetContributionResponse({
    ContributionMessage? contribution,
  }) {
    final _result = create();
    if (contribution != null) {
      _result.contribution = contribution;
    }
    return _result;
  }
  factory GetContributionResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetContributionResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetContributionResponse clone() => GetContributionResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetContributionResponse copyWith(void Function(GetContributionResponse) updates) => super.copyWith((message) => updates(message as GetContributionResponse)) as GetContributionResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetContributionResponse create() => GetContributionResponse._();
  GetContributionResponse createEmptyInstance() => create();
  static $pb.PbList<GetContributionResponse> createRepeated() => $pb.PbList<GetContributionResponse>();
  @$core.pragma('dart2js:noInline')
  static GetContributionResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetContributionResponse>(create);
  static GetContributionResponse? _defaultInstance;

  @$pb.TagNumber(1)
  ContributionMessage get contribution => $_getN(0);
  @$pb.TagNumber(1)
  set contribution(ContributionMessage v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasContribution() => $_has(0);
  @$pb.TagNumber(1)
  void clearContribution() => clearField(1);
  @$pb.TagNumber(1)
  ContributionMessage ensureContribution() => $_ensure(0);
}

class ListGroupContributionsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ListGroupContributionsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'groupId')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..hasRequiredFields = false
  ;

  ListGroupContributionsRequest._() : super();
  factory ListGroupContributionsRequest({
    $core.String? groupId,
    $core.int? page,
    $core.int? pageSize,
    $core.String? status,
  }) {
    final _result = create();
    if (groupId != null) {
      _result.groupId = groupId;
    }
    if (page != null) {
      _result.page = page;
    }
    if (pageSize != null) {
      _result.pageSize = pageSize;
    }
    if (status != null) {
      _result.status = status;
    }
    return _result;
  }
  factory ListGroupContributionsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListGroupContributionsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListGroupContributionsRequest clone() => ListGroupContributionsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListGroupContributionsRequest copyWith(void Function(ListGroupContributionsRequest) updates) => super.copyWith((message) => updates(message as ListGroupContributionsRequest)) as ListGroupContributionsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ListGroupContributionsRequest create() => ListGroupContributionsRequest._();
  ListGroupContributionsRequest createEmptyInstance() => create();
  static $pb.PbList<ListGroupContributionsRequest> createRepeated() => $pb.PbList<ListGroupContributionsRequest>();
  @$core.pragma('dart2js:noInline')
  static ListGroupContributionsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListGroupContributionsRequest>(create);
  static ListGroupContributionsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get groupId => $_getSZ(0);
  @$pb.TagNumber(1)
  set groupId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasGroupId() => $_has(0);
  @$pb.TagNumber(1)
  void clearGroupId() => clearField(1);

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

  @$pb.TagNumber(4)
  $core.String get status => $_getSZ(3);
  @$pb.TagNumber(4)
  set status($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasStatus() => $_has(3);
  @$pb.TagNumber(4)
  void clearStatus() => clearField(4);
}

class ListGroupContributionsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ListGroupContributionsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<ContributionMessage>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'contributions', $pb.PbFieldType.PM, subBuilder: ContributionMessage.create)
    ..aOM<ContributionPaginationInfo>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pagination', subBuilder: ContributionPaginationInfo.create)
    ..hasRequiredFields = false
  ;

  ListGroupContributionsResponse._() : super();
  factory ListGroupContributionsResponse({
    $core.Iterable<ContributionMessage>? contributions,
    ContributionPaginationInfo? pagination,
  }) {
    final _result = create();
    if (contributions != null) {
      _result.contributions.addAll(contributions);
    }
    if (pagination != null) {
      _result.pagination = pagination;
    }
    return _result;
  }
  factory ListGroupContributionsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListGroupContributionsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListGroupContributionsResponse clone() => ListGroupContributionsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListGroupContributionsResponse copyWith(void Function(ListGroupContributionsResponse) updates) => super.copyWith((message) => updates(message as ListGroupContributionsResponse)) as ListGroupContributionsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ListGroupContributionsResponse create() => ListGroupContributionsResponse._();
  ListGroupContributionsResponse createEmptyInstance() => create();
  static $pb.PbList<ListGroupContributionsResponse> createRepeated() => $pb.PbList<ListGroupContributionsResponse>();
  @$core.pragma('dart2js:noInline')
  static ListGroupContributionsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListGroupContributionsResponse>(create);
  static ListGroupContributionsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<ContributionMessage> get contributions => $_getList(0);

  @$pb.TagNumber(2)
  ContributionPaginationInfo get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination(ContributionPaginationInfo v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => clearField(2);
  @$pb.TagNumber(2)
  ContributionPaginationInfo ensurePagination() => $_ensure(1);
}

class UpdateContributionRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateContributionRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'contributionId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'title')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..a<$fixnum.Int64>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'targetAmount', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<$1.Timestamp>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'deadline', subBuilder: $1.Timestamp.create)
    ..e<ContributionStatus>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: ContributionStatus.CONTRIBUTION_STATUS_UNSPECIFIED, valueOf: ContributionStatus.valueOf, enumValues: ContributionStatus.values)
    ..hasRequiredFields = false
  ;

  UpdateContributionRequest._() : super();
  factory UpdateContributionRequest({
    $core.String? contributionId,
    $core.String? title,
    $core.String? description,
    $fixnum.Int64? targetAmount,
    $1.Timestamp? deadline,
    ContributionStatus? status,
  }) {
    final _result = create();
    if (contributionId != null) {
      _result.contributionId = contributionId;
    }
    if (title != null) {
      _result.title = title;
    }
    if (description != null) {
      _result.description = description;
    }
    if (targetAmount != null) {
      _result.targetAmount = targetAmount;
    }
    if (deadline != null) {
      _result.deadline = deadline;
    }
    if (status != null) {
      _result.status = status;
    }
    return _result;
  }
  factory UpdateContributionRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateContributionRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateContributionRequest clone() => UpdateContributionRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateContributionRequest copyWith(void Function(UpdateContributionRequest) updates) => super.copyWith((message) => updates(message as UpdateContributionRequest)) as UpdateContributionRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UpdateContributionRequest create() => UpdateContributionRequest._();
  UpdateContributionRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateContributionRequest> createRepeated() => $pb.PbList<UpdateContributionRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateContributionRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateContributionRequest>(create);
  static UpdateContributionRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get contributionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set contributionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasContributionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearContributionId() => clearField(1);

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
  $fixnum.Int64 get targetAmount => $_getI64(3);
  @$pb.TagNumber(4)
  set targetAmount($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTargetAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearTargetAmount() => clearField(4);

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
  ContributionStatus get status => $_getN(5);
  @$pb.TagNumber(6)
  set status(ContributionStatus v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasStatus() => $_has(5);
  @$pb.TagNumber(6)
  void clearStatus() => clearField(6);
}

class UpdateContributionResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateContributionResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<ContributionMessage>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'contribution', subBuilder: ContributionMessage.create)
    ..hasRequiredFields = false
  ;

  UpdateContributionResponse._() : super();
  factory UpdateContributionResponse({
    ContributionMessage? contribution,
  }) {
    final _result = create();
    if (contribution != null) {
      _result.contribution = contribution;
    }
    return _result;
  }
  factory UpdateContributionResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateContributionResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateContributionResponse clone() => UpdateContributionResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateContributionResponse copyWith(void Function(UpdateContributionResponse) updates) => super.copyWith((message) => updates(message as UpdateContributionResponse)) as UpdateContributionResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UpdateContributionResponse create() => UpdateContributionResponse._();
  UpdateContributionResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateContributionResponse> createRepeated() => $pb.PbList<UpdateContributionResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateContributionResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateContributionResponse>(create);
  static UpdateContributionResponse? _defaultInstance;

  @$pb.TagNumber(1)
  ContributionMessage get contribution => $_getN(0);
  @$pb.TagNumber(1)
  set contribution(ContributionMessage v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasContribution() => $_has(0);
  @$pb.TagNumber(1)
  void clearContribution() => clearField(1);
  @$pb.TagNumber(1)
  ContributionMessage ensureContribution() => $_ensure(0);
}

class DeleteContributionRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DeleteContributionRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'contributionId')
    ..hasRequiredFields = false
  ;

  DeleteContributionRequest._() : super();
  factory DeleteContributionRequest({
    $core.String? contributionId,
  }) {
    final _result = create();
    if (contributionId != null) {
      _result.contributionId = contributionId;
    }
    return _result;
  }
  factory DeleteContributionRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteContributionRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteContributionRequest clone() => DeleteContributionRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteContributionRequest copyWith(void Function(DeleteContributionRequest) updates) => super.copyWith((message) => updates(message as DeleteContributionRequest)) as DeleteContributionRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DeleteContributionRequest create() => DeleteContributionRequest._();
  DeleteContributionRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteContributionRequest> createRepeated() => $pb.PbList<DeleteContributionRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteContributionRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteContributionRequest>(create);
  static DeleteContributionRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get contributionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set contributionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasContributionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearContributionId() => clearField(1);
}

class DeleteContributionResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DeleteContributionResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..hasRequiredFields = false
  ;

  DeleteContributionResponse._() : super();
  factory DeleteContributionResponse({
    $core.bool? success,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    return _result;
  }
  factory DeleteContributionResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteContributionResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteContributionResponse clone() => DeleteContributionResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteContributionResponse copyWith(void Function(DeleteContributionResponse) updates) => super.copyWith((message) => updates(message as DeleteContributionResponse)) as DeleteContributionResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DeleteContributionResponse create() => DeleteContributionResponse._();
  DeleteContributionResponse createEmptyInstance() => create();
  static $pb.PbList<DeleteContributionResponse> createRepeated() => $pb.PbList<DeleteContributionResponse>();
  @$core.pragma('dart2js:noInline')
  static DeleteContributionResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteContributionResponse>(create);
  static DeleteContributionResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);
}

class AddMembersToContributionRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AddMembersToContributionRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'contributionId')
    ..pPS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'memberUserIds')
    ..hasRequiredFields = false
  ;

  AddMembersToContributionRequest._() : super();
  factory AddMembersToContributionRequest({
    $core.String? contributionId,
    $core.Iterable<$core.String>? memberUserIds,
  }) {
    final _result = create();
    if (contributionId != null) {
      _result.contributionId = contributionId;
    }
    if (memberUserIds != null) {
      _result.memberUserIds.addAll(memberUserIds);
    }
    return _result;
  }
  factory AddMembersToContributionRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddMembersToContributionRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddMembersToContributionRequest clone() => AddMembersToContributionRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddMembersToContributionRequest copyWith(void Function(AddMembersToContributionRequest) updates) => super.copyWith((message) => updates(message as AddMembersToContributionRequest)) as AddMembersToContributionRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AddMembersToContributionRequest create() => AddMembersToContributionRequest._();
  AddMembersToContributionRequest createEmptyInstance() => create();
  static $pb.PbList<AddMembersToContributionRequest> createRepeated() => $pb.PbList<AddMembersToContributionRequest>();
  @$core.pragma('dart2js:noInline')
  static AddMembersToContributionRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddMembersToContributionRequest>(create);
  static AddMembersToContributionRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get contributionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set contributionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasContributionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearContributionId() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.String> get memberUserIds => $_getList(1);
}

class AddMembersToContributionResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AddMembersToContributionResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<ContributionMessage>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'contribution', subBuilder: ContributionMessage.create)
    ..pc<ContributionMemberMessage>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'addedMembers', $pb.PbFieldType.PM, subBuilder: ContributionMemberMessage.create)
    ..hasRequiredFields = false
  ;

  AddMembersToContributionResponse._() : super();
  factory AddMembersToContributionResponse({
    ContributionMessage? contribution,
    $core.Iterable<ContributionMemberMessage>? addedMembers,
  }) {
    final _result = create();
    if (contribution != null) {
      _result.contribution = contribution;
    }
    if (addedMembers != null) {
      _result.addedMembers.addAll(addedMembers);
    }
    return _result;
  }
  factory AddMembersToContributionResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddMembersToContributionResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddMembersToContributionResponse clone() => AddMembersToContributionResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddMembersToContributionResponse copyWith(void Function(AddMembersToContributionResponse) updates) => super.copyWith((message) => updates(message as AddMembersToContributionResponse)) as AddMembersToContributionResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AddMembersToContributionResponse create() => AddMembersToContributionResponse._();
  AddMembersToContributionResponse createEmptyInstance() => create();
  static $pb.PbList<AddMembersToContributionResponse> createRepeated() => $pb.PbList<AddMembersToContributionResponse>();
  @$core.pragma('dart2js:noInline')
  static AddMembersToContributionResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddMembersToContributionResponse>(create);
  static AddMembersToContributionResponse? _defaultInstance;

  @$pb.TagNumber(1)
  ContributionMessage get contribution => $_getN(0);
  @$pb.TagNumber(1)
  set contribution(ContributionMessage v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasContribution() => $_has(0);
  @$pb.TagNumber(1)
  void clearContribution() => clearField(1);
  @$pb.TagNumber(1)
  ContributionMessage ensureContribution() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.List<ContributionMemberMessage> get addedMembers => $_getList(1);
}

class RemoveMemberFromContributionRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RemoveMemberFromContributionRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'contributionId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'memberUserId')
    ..hasRequiredFields = false
  ;

  RemoveMemberFromContributionRequest._() : super();
  factory RemoveMemberFromContributionRequest({
    $core.String? contributionId,
    $core.String? memberUserId,
  }) {
    final _result = create();
    if (contributionId != null) {
      _result.contributionId = contributionId;
    }
    if (memberUserId != null) {
      _result.memberUserId = memberUserId;
    }
    return _result;
  }
  factory RemoveMemberFromContributionRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RemoveMemberFromContributionRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RemoveMemberFromContributionRequest clone() => RemoveMemberFromContributionRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RemoveMemberFromContributionRequest copyWith(void Function(RemoveMemberFromContributionRequest) updates) => super.copyWith((message) => updates(message as RemoveMemberFromContributionRequest)) as RemoveMemberFromContributionRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RemoveMemberFromContributionRequest create() => RemoveMemberFromContributionRequest._();
  RemoveMemberFromContributionRequest createEmptyInstance() => create();
  static $pb.PbList<RemoveMemberFromContributionRequest> createRepeated() => $pb.PbList<RemoveMemberFromContributionRequest>();
  @$core.pragma('dart2js:noInline')
  static RemoveMemberFromContributionRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RemoveMemberFromContributionRequest>(create);
  static RemoveMemberFromContributionRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get contributionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set contributionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasContributionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearContributionId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get memberUserId => $_getSZ(1);
  @$pb.TagNumber(2)
  set memberUserId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMemberUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearMemberUserId() => clearField(2);
}

class RemoveMemberFromContributionResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RemoveMemberFromContributionResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..hasRequiredFields = false
  ;

  RemoveMemberFromContributionResponse._() : super();
  factory RemoveMemberFromContributionResponse({
    $core.bool? success,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    return _result;
  }
  factory RemoveMemberFromContributionResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RemoveMemberFromContributionResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RemoveMemberFromContributionResponse clone() => RemoveMemberFromContributionResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RemoveMemberFromContributionResponse copyWith(void Function(RemoveMemberFromContributionResponse) updates) => super.copyWith((message) => updates(message as RemoveMemberFromContributionResponse)) as RemoveMemberFromContributionResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RemoveMemberFromContributionResponse create() => RemoveMemberFromContributionResponse._();
  RemoveMemberFromContributionResponse createEmptyInstance() => create();
  static $pb.PbList<RemoveMemberFromContributionResponse> createRepeated() => $pb.PbList<RemoveMemberFromContributionResponse>();
  @$core.pragma('dart2js:noInline')
  static RemoveMemberFromContributionResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RemoveMemberFromContributionResponse>(create);
  static RemoveMemberFromContributionResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);
}

class GetContributionMembersRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetContributionMembersRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'contributionId')
    ..hasRequiredFields = false
  ;

  GetContributionMembersRequest._() : super();
  factory GetContributionMembersRequest({
    $core.String? contributionId,
  }) {
    final _result = create();
    if (contributionId != null) {
      _result.contributionId = contributionId;
    }
    return _result;
  }
  factory GetContributionMembersRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetContributionMembersRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetContributionMembersRequest clone() => GetContributionMembersRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetContributionMembersRequest copyWith(void Function(GetContributionMembersRequest) updates) => super.copyWith((message) => updates(message as GetContributionMembersRequest)) as GetContributionMembersRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetContributionMembersRequest create() => GetContributionMembersRequest._();
  GetContributionMembersRequest createEmptyInstance() => create();
  static $pb.PbList<GetContributionMembersRequest> createRepeated() => $pb.PbList<GetContributionMembersRequest>();
  @$core.pragma('dart2js:noInline')
  static GetContributionMembersRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetContributionMembersRequest>(create);
  static GetContributionMembersRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get contributionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set contributionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasContributionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearContributionId() => clearField(1);
}

class GetContributionMembersResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetContributionMembersResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<ContributionMemberMessage>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'members', $pb.PbFieldType.PM, subBuilder: ContributionMemberMessage.create)
    ..hasRequiredFields = false
  ;

  GetContributionMembersResponse._() : super();
  factory GetContributionMembersResponse({
    $core.Iterable<ContributionMemberMessage>? members,
  }) {
    final _result = create();
    if (members != null) {
      _result.members.addAll(members);
    }
    return _result;
  }
  factory GetContributionMembersResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetContributionMembersResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetContributionMembersResponse clone() => GetContributionMembersResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetContributionMembersResponse copyWith(void Function(GetContributionMembersResponse) updates) => super.copyWith((message) => updates(message as GetContributionMembersResponse)) as GetContributionMembersResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetContributionMembersResponse create() => GetContributionMembersResponse._();
  GetContributionMembersResponse createEmptyInstance() => create();
  static $pb.PbList<GetContributionMembersResponse> createRepeated() => $pb.PbList<GetContributionMembersResponse>();
  @$core.pragma('dart2js:noInline')
  static GetContributionMembersResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetContributionMembersResponse>(create);
  static GetContributionMembersResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<ContributionMemberMessage> get members => $_getList(0);
}

class MakePaymentRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MakePaymentRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'contributionId')
    ..a<$fixnum.Int64>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'notes')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sourceAccountId')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionPin')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'idempotencyKey')
    ..hasRequiredFields = false
  ;

  MakePaymentRequest._() : super();
  factory MakePaymentRequest({
    $core.String? contributionId,
    $fixnum.Int64? amount,
    $core.String? notes,
    $core.String? sourceAccountId,
    $core.String? transactionPin,
    $core.String? idempotencyKey,
  }) {
    final _result = create();
    if (contributionId != null) {
      _result.contributionId = contributionId;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (notes != null) {
      _result.notes = notes;
    }
    if (sourceAccountId != null) {
      _result.sourceAccountId = sourceAccountId;
    }
    if (transactionPin != null) {
      _result.transactionPin = transactionPin;
    }
    if (idempotencyKey != null) {
      _result.idempotencyKey = idempotencyKey;
    }
    return _result;
  }
  factory MakePaymentRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MakePaymentRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MakePaymentRequest clone() => MakePaymentRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MakePaymentRequest copyWith(void Function(MakePaymentRequest) updates) => super.copyWith((message) => updates(message as MakePaymentRequest)) as MakePaymentRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MakePaymentRequest create() => MakePaymentRequest._();
  MakePaymentRequest createEmptyInstance() => create();
  static $pb.PbList<MakePaymentRequest> createRepeated() => $pb.PbList<MakePaymentRequest>();
  @$core.pragma('dart2js:noInline')
  static MakePaymentRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MakePaymentRequest>(create);
  static MakePaymentRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get contributionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set contributionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasContributionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearContributionId() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get amount => $_getI64(1);
  @$pb.TagNumber(2)
  set amount($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get notes => $_getSZ(2);
  @$pb.TagNumber(3)
  set notes($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasNotes() => $_has(2);
  @$pb.TagNumber(3)
  void clearNotes() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get sourceAccountId => $_getSZ(3);
  @$pb.TagNumber(4)
  set sourceAccountId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasSourceAccountId() => $_has(3);
  @$pb.TagNumber(4)
  void clearSourceAccountId() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get transactionPin => $_getSZ(4);
  @$pb.TagNumber(5)
  set transactionPin($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTransactionPin() => $_has(4);
  @$pb.TagNumber(5)
  void clearTransactionPin() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get idempotencyKey => $_getSZ(5);
  @$pb.TagNumber(6)
  set idempotencyKey($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasIdempotencyKey() => $_has(5);
  @$pb.TagNumber(6)
  void clearIdempotencyKey() => clearField(6);
}

class MakePaymentResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MakePaymentResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<ContributionPaymentMessage>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payment', subBuilder: ContributionPaymentMessage.create)
    ..hasRequiredFields = false
  ;

  MakePaymentResponse._() : super();
  factory MakePaymentResponse({
    ContributionPaymentMessage? payment,
  }) {
    final _result = create();
    if (payment != null) {
      _result.payment = payment;
    }
    return _result;
  }
  factory MakePaymentResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MakePaymentResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MakePaymentResponse clone() => MakePaymentResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MakePaymentResponse copyWith(void Function(MakePaymentResponse) updates) => super.copyWith((message) => updates(message as MakePaymentResponse)) as MakePaymentResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MakePaymentResponse create() => MakePaymentResponse._();
  MakePaymentResponse createEmptyInstance() => create();
  static $pb.PbList<MakePaymentResponse> createRepeated() => $pb.PbList<MakePaymentResponse>();
  @$core.pragma('dart2js:noInline')
  static MakePaymentResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MakePaymentResponse>(create);
  static MakePaymentResponse? _defaultInstance;

  @$pb.TagNumber(1)
  ContributionPaymentMessage get payment => $_getN(0);
  @$pb.TagNumber(1)
  set payment(ContributionPaymentMessage v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasPayment() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayment() => clearField(1);
  @$pb.TagNumber(1)
  ContributionPaymentMessage ensurePayment() => $_ensure(0);
}

class GetContributionPaymentsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetContributionPaymentsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'contributionId')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetContributionPaymentsRequest._() : super();
  factory GetContributionPaymentsRequest({
    $core.String? contributionId,
    $core.int? page,
    $core.int? pageSize,
  }) {
    final _result = create();
    if (contributionId != null) {
      _result.contributionId = contributionId;
    }
    if (page != null) {
      _result.page = page;
    }
    if (pageSize != null) {
      _result.pageSize = pageSize;
    }
    return _result;
  }
  factory GetContributionPaymentsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetContributionPaymentsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetContributionPaymentsRequest clone() => GetContributionPaymentsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetContributionPaymentsRequest copyWith(void Function(GetContributionPaymentsRequest) updates) => super.copyWith((message) => updates(message as GetContributionPaymentsRequest)) as GetContributionPaymentsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetContributionPaymentsRequest create() => GetContributionPaymentsRequest._();
  GetContributionPaymentsRequest createEmptyInstance() => create();
  static $pb.PbList<GetContributionPaymentsRequest> createRepeated() => $pb.PbList<GetContributionPaymentsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetContributionPaymentsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetContributionPaymentsRequest>(create);
  static GetContributionPaymentsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get contributionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set contributionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasContributionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearContributionId() => clearField(1);

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

class GetContributionPaymentsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetContributionPaymentsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<ContributionPaymentMessage>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payments', $pb.PbFieldType.PM, subBuilder: ContributionPaymentMessage.create)
    ..aOM<PaymentPaginationInfo>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pagination', subBuilder: PaymentPaginationInfo.create)
    ..hasRequiredFields = false
  ;

  GetContributionPaymentsResponse._() : super();
  factory GetContributionPaymentsResponse({
    $core.Iterable<ContributionPaymentMessage>? payments,
    PaymentPaginationInfo? pagination,
  }) {
    final _result = create();
    if (payments != null) {
      _result.payments.addAll(payments);
    }
    if (pagination != null) {
      _result.pagination = pagination;
    }
    return _result;
  }
  factory GetContributionPaymentsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetContributionPaymentsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetContributionPaymentsResponse clone() => GetContributionPaymentsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetContributionPaymentsResponse copyWith(void Function(GetContributionPaymentsResponse) updates) => super.copyWith((message) => updates(message as GetContributionPaymentsResponse)) as GetContributionPaymentsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetContributionPaymentsResponse create() => GetContributionPaymentsResponse._();
  GetContributionPaymentsResponse createEmptyInstance() => create();
  static $pb.PbList<GetContributionPaymentsResponse> createRepeated() => $pb.PbList<GetContributionPaymentsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetContributionPaymentsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetContributionPaymentsResponse>(create);
  static GetContributionPaymentsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<ContributionPaymentMessage> get payments => $_getList(0);

  @$pb.TagNumber(2)
  PaymentPaginationInfo get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination(PaymentPaginationInfo v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => clearField(2);
  @$pb.TagNumber(2)
  PaymentPaginationInfo ensurePagination() => $_ensure(1);
}

class UpdatePaymentStatusRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdatePaymentStatusRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'paymentId')
    ..e<PaymentStatus>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: PaymentStatus.PAYMENT_STATUS_UNSPECIFIED, valueOf: PaymentStatus.valueOf, enumValues: PaymentStatus.values)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionId')
    ..hasRequiredFields = false
  ;

  UpdatePaymentStatusRequest._() : super();
  factory UpdatePaymentStatusRequest({
    $core.String? paymentId,
    PaymentStatus? status,
    $core.String? transactionId,
  }) {
    final _result = create();
    if (paymentId != null) {
      _result.paymentId = paymentId;
    }
    if (status != null) {
      _result.status = status;
    }
    if (transactionId != null) {
      _result.transactionId = transactionId;
    }
    return _result;
  }
  factory UpdatePaymentStatusRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdatePaymentStatusRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdatePaymentStatusRequest clone() => UpdatePaymentStatusRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdatePaymentStatusRequest copyWith(void Function(UpdatePaymentStatusRequest) updates) => super.copyWith((message) => updates(message as UpdatePaymentStatusRequest)) as UpdatePaymentStatusRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UpdatePaymentStatusRequest create() => UpdatePaymentStatusRequest._();
  UpdatePaymentStatusRequest createEmptyInstance() => create();
  static $pb.PbList<UpdatePaymentStatusRequest> createRepeated() => $pb.PbList<UpdatePaymentStatusRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdatePaymentStatusRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdatePaymentStatusRequest>(create);
  static UpdatePaymentStatusRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get paymentId => $_getSZ(0);
  @$pb.TagNumber(1)
  set paymentId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPaymentId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPaymentId() => clearField(1);

  @$pb.TagNumber(2)
  PaymentStatus get status => $_getN(1);
  @$pb.TagNumber(2)
  set status(PaymentStatus v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get transactionId => $_getSZ(2);
  @$pb.TagNumber(3)
  set transactionId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTransactionId() => $_has(2);
  @$pb.TagNumber(3)
  void clearTransactionId() => clearField(3);
}

class UpdatePaymentStatusResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdatePaymentStatusResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<ContributionPaymentMessage>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payment', subBuilder: ContributionPaymentMessage.create)
    ..hasRequiredFields = false
  ;

  UpdatePaymentStatusResponse._() : super();
  factory UpdatePaymentStatusResponse({
    ContributionPaymentMessage? payment,
  }) {
    final _result = create();
    if (payment != null) {
      _result.payment = payment;
    }
    return _result;
  }
  factory UpdatePaymentStatusResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdatePaymentStatusResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdatePaymentStatusResponse clone() => UpdatePaymentStatusResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdatePaymentStatusResponse copyWith(void Function(UpdatePaymentStatusResponse) updates) => super.copyWith((message) => updates(message as UpdatePaymentStatusResponse)) as UpdatePaymentStatusResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UpdatePaymentStatusResponse create() => UpdatePaymentStatusResponse._();
  UpdatePaymentStatusResponse createEmptyInstance() => create();
  static $pb.PbList<UpdatePaymentStatusResponse> createRepeated() => $pb.PbList<UpdatePaymentStatusResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdatePaymentStatusResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdatePaymentStatusResponse>(create);
  static UpdatePaymentStatusResponse? _defaultInstance;

  @$pb.TagNumber(1)
  ContributionPaymentMessage get payment => $_getN(0);
  @$pb.TagNumber(1)
  set payment(ContributionPaymentMessage v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasPayment() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayment() => clearField(1);
  @$pb.TagNumber(1)
  ContributionPaymentMessage ensurePayment() => $_ensure(0);
}

class ProcessScheduledPaymentsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProcessScheduledPaymentsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'contributionId')
    ..hasRequiredFields = false
  ;

  ProcessScheduledPaymentsRequest._() : super();
  factory ProcessScheduledPaymentsRequest({
    $core.String? contributionId,
  }) {
    final _result = create();
    if (contributionId != null) {
      _result.contributionId = contributionId;
    }
    return _result;
  }
  factory ProcessScheduledPaymentsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProcessScheduledPaymentsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProcessScheduledPaymentsRequest clone() => ProcessScheduledPaymentsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProcessScheduledPaymentsRequest copyWith(void Function(ProcessScheduledPaymentsRequest) updates) => super.copyWith((message) => updates(message as ProcessScheduledPaymentsRequest)) as ProcessScheduledPaymentsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProcessScheduledPaymentsRequest create() => ProcessScheduledPaymentsRequest._();
  ProcessScheduledPaymentsRequest createEmptyInstance() => create();
  static $pb.PbList<ProcessScheduledPaymentsRequest> createRepeated() => $pb.PbList<ProcessScheduledPaymentsRequest>();
  @$core.pragma('dart2js:noInline')
  static ProcessScheduledPaymentsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProcessScheduledPaymentsRequest>(create);
  static ProcessScheduledPaymentsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get contributionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set contributionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasContributionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearContributionId() => clearField(1);
}

class ProcessScheduledPaymentsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProcessScheduledPaymentsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<ContributionMessage>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'contribution', subBuilder: ContributionMessage.create)
    ..pc<ContributionPaymentMessage>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'paymentsProcessed', $pb.PbFieldType.PM, subBuilder: ContributionPaymentMessage.create)
    ..hasRequiredFields = false
  ;

  ProcessScheduledPaymentsResponse._() : super();
  factory ProcessScheduledPaymentsResponse({
    ContributionMessage? contribution,
    $core.Iterable<ContributionPaymentMessage>? paymentsProcessed,
  }) {
    final _result = create();
    if (contribution != null) {
      _result.contribution = contribution;
    }
    if (paymentsProcessed != null) {
      _result.paymentsProcessed.addAll(paymentsProcessed);
    }
    return _result;
  }
  factory ProcessScheduledPaymentsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProcessScheduledPaymentsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProcessScheduledPaymentsResponse clone() => ProcessScheduledPaymentsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProcessScheduledPaymentsResponse copyWith(void Function(ProcessScheduledPaymentsResponse) updates) => super.copyWith((message) => updates(message as ProcessScheduledPaymentsResponse)) as ProcessScheduledPaymentsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProcessScheduledPaymentsResponse create() => ProcessScheduledPaymentsResponse._();
  ProcessScheduledPaymentsResponse createEmptyInstance() => create();
  static $pb.PbList<ProcessScheduledPaymentsResponse> createRepeated() => $pb.PbList<ProcessScheduledPaymentsResponse>();
  @$core.pragma('dart2js:noInline')
  static ProcessScheduledPaymentsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProcessScheduledPaymentsResponse>(create);
  static ProcessScheduledPaymentsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  ContributionMessage get contribution => $_getN(0);
  @$pb.TagNumber(1)
  set contribution(ContributionMessage v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasContribution() => $_has(0);
  @$pb.TagNumber(1)
  void clearContribution() => clearField(1);
  @$pb.TagNumber(1)
  ContributionMessage ensureContribution() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.List<ContributionPaymentMessage> get paymentsProcessed => $_getList(1);
}

class GetOverdueContributionsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetOverdueContributionsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GetOverdueContributionsRequest._() : super();
  factory GetOverdueContributionsRequest() => create();
  factory GetOverdueContributionsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetOverdueContributionsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetOverdueContributionsRequest clone() => GetOverdueContributionsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetOverdueContributionsRequest copyWith(void Function(GetOverdueContributionsRequest) updates) => super.copyWith((message) => updates(message as GetOverdueContributionsRequest)) as GetOverdueContributionsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetOverdueContributionsRequest create() => GetOverdueContributionsRequest._();
  GetOverdueContributionsRequest createEmptyInstance() => create();
  static $pb.PbList<GetOverdueContributionsRequest> createRepeated() => $pb.PbList<GetOverdueContributionsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetOverdueContributionsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetOverdueContributionsRequest>(create);
  static GetOverdueContributionsRequest? _defaultInstance;
}

class GetOverdueContributionsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetOverdueContributionsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<ContributionMessage>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'contributions', $pb.PbFieldType.PM, subBuilder: ContributionMessage.create)
    ..hasRequiredFields = false
  ;

  GetOverdueContributionsResponse._() : super();
  factory GetOverdueContributionsResponse({
    $core.Iterable<ContributionMessage>? contributions,
  }) {
    final _result = create();
    if (contributions != null) {
      _result.contributions.addAll(contributions);
    }
    return _result;
  }
  factory GetOverdueContributionsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetOverdueContributionsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetOverdueContributionsResponse clone() => GetOverdueContributionsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetOverdueContributionsResponse copyWith(void Function(GetOverdueContributionsResponse) updates) => super.copyWith((message) => updates(message as GetOverdueContributionsResponse)) as GetOverdueContributionsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetOverdueContributionsResponse create() => GetOverdueContributionsResponse._();
  GetOverdueContributionsResponse createEmptyInstance() => create();
  static $pb.PbList<GetOverdueContributionsResponse> createRepeated() => $pb.PbList<GetOverdueContributionsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetOverdueContributionsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetOverdueContributionsResponse>(create);
  static GetOverdueContributionsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<ContributionMessage> get contributions => $_getList(0);
}

class GetPayoutScheduleRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetPayoutScheduleRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'contributionId')
    ..hasRequiredFields = false
  ;

  GetPayoutScheduleRequest._() : super();
  factory GetPayoutScheduleRequest({
    $core.String? contributionId,
  }) {
    final _result = create();
    if (contributionId != null) {
      _result.contributionId = contributionId;
    }
    return _result;
  }
  factory GetPayoutScheduleRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPayoutScheduleRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPayoutScheduleRequest clone() => GetPayoutScheduleRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPayoutScheduleRequest copyWith(void Function(GetPayoutScheduleRequest) updates) => super.copyWith((message) => updates(message as GetPayoutScheduleRequest)) as GetPayoutScheduleRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetPayoutScheduleRequest create() => GetPayoutScheduleRequest._();
  GetPayoutScheduleRequest createEmptyInstance() => create();
  static $pb.PbList<GetPayoutScheduleRequest> createRepeated() => $pb.PbList<GetPayoutScheduleRequest>();
  @$core.pragma('dart2js:noInline')
  static GetPayoutScheduleRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetPayoutScheduleRequest>(create);
  static GetPayoutScheduleRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get contributionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set contributionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasContributionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearContributionId() => clearField(1);
}

class GetPayoutScheduleResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetPayoutScheduleResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<PayoutScheduleMessage>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'schedule', $pb.PbFieldType.PM, subBuilder: PayoutScheduleMessage.create)
    ..hasRequiredFields = false
  ;

  GetPayoutScheduleResponse._() : super();
  factory GetPayoutScheduleResponse({
    $core.Iterable<PayoutScheduleMessage>? schedule,
  }) {
    final _result = create();
    if (schedule != null) {
      _result.schedule.addAll(schedule);
    }
    return _result;
  }
  factory GetPayoutScheduleResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPayoutScheduleResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPayoutScheduleResponse clone() => GetPayoutScheduleResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPayoutScheduleResponse copyWith(void Function(GetPayoutScheduleResponse) updates) => super.copyWith((message) => updates(message as GetPayoutScheduleResponse)) as GetPayoutScheduleResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetPayoutScheduleResponse create() => GetPayoutScheduleResponse._();
  GetPayoutScheduleResponse createEmptyInstance() => create();
  static $pb.PbList<GetPayoutScheduleResponse> createRepeated() => $pb.PbList<GetPayoutScheduleResponse>();
  @$core.pragma('dart2js:noInline')
  static GetPayoutScheduleResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetPayoutScheduleResponse>(create);
  static GetPayoutScheduleResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<PayoutScheduleMessage> get schedule => $_getList(0);
}

class ProcessPayoutRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProcessPayoutRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'contributionId')
    ..hasRequiredFields = false
  ;

  ProcessPayoutRequest._() : super();
  factory ProcessPayoutRequest({
    $core.String? contributionId,
  }) {
    final _result = create();
    if (contributionId != null) {
      _result.contributionId = contributionId;
    }
    return _result;
  }
  factory ProcessPayoutRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProcessPayoutRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProcessPayoutRequest clone() => ProcessPayoutRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProcessPayoutRequest copyWith(void Function(ProcessPayoutRequest) updates) => super.copyWith((message) => updates(message as ProcessPayoutRequest)) as ProcessPayoutRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProcessPayoutRequest create() => ProcessPayoutRequest._();
  ProcessPayoutRequest createEmptyInstance() => create();
  static $pb.PbList<ProcessPayoutRequest> createRepeated() => $pb.PbList<ProcessPayoutRequest>();
  @$core.pragma('dart2js:noInline')
  static ProcessPayoutRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProcessPayoutRequest>(create);
  static ProcessPayoutRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get contributionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set contributionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasContributionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearContributionId() => clearField(1);
}

class ProcessPayoutResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProcessPayoutResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<PayoutTransactionMessage>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transaction', subBuilder: PayoutTransactionMessage.create)
    ..hasRequiredFields = false
  ;

  ProcessPayoutResponse._() : super();
  factory ProcessPayoutResponse({
    PayoutTransactionMessage? transaction,
  }) {
    final _result = create();
    if (transaction != null) {
      _result.transaction = transaction;
    }
    return _result;
  }
  factory ProcessPayoutResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProcessPayoutResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProcessPayoutResponse clone() => ProcessPayoutResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProcessPayoutResponse copyWith(void Function(ProcessPayoutResponse) updates) => super.copyWith((message) => updates(message as ProcessPayoutResponse)) as ProcessPayoutResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProcessPayoutResponse create() => ProcessPayoutResponse._();
  ProcessPayoutResponse createEmptyInstance() => create();
  static $pb.PbList<ProcessPayoutResponse> createRepeated() => $pb.PbList<ProcessPayoutResponse>();
  @$core.pragma('dart2js:noInline')
  static ProcessPayoutResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProcessPayoutResponse>(create);
  static ProcessPayoutResponse? _defaultInstance;

  @$pb.TagNumber(1)
  PayoutTransactionMessage get transaction => $_getN(0);
  @$pb.TagNumber(1)
  set transaction(PayoutTransactionMessage v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasTransaction() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransaction() => clearField(1);
  @$pb.TagNumber(1)
  PayoutTransactionMessage ensureTransaction() => $_ensure(0);
}

class UpdatePayoutStatusRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdatePayoutStatusRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payoutId')
    ..e<PayoutTransactionStatus>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: PayoutTransactionStatus.PAYOUT_TRANSACTION_STATUS_UNSPECIFIED, valueOf: PayoutTransactionStatus.valueOf, enumValues: PayoutTransactionStatus.values)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionId')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'failureReason')
    ..hasRequiredFields = false
  ;

  UpdatePayoutStatusRequest._() : super();
  factory UpdatePayoutStatusRequest({
    $core.String? payoutId,
    PayoutTransactionStatus? status,
    $core.String? transactionId,
    $core.String? failureReason,
  }) {
    final _result = create();
    if (payoutId != null) {
      _result.payoutId = payoutId;
    }
    if (status != null) {
      _result.status = status;
    }
    if (transactionId != null) {
      _result.transactionId = transactionId;
    }
    if (failureReason != null) {
      _result.failureReason = failureReason;
    }
    return _result;
  }
  factory UpdatePayoutStatusRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdatePayoutStatusRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdatePayoutStatusRequest clone() => UpdatePayoutStatusRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdatePayoutStatusRequest copyWith(void Function(UpdatePayoutStatusRequest) updates) => super.copyWith((message) => updates(message as UpdatePayoutStatusRequest)) as UpdatePayoutStatusRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UpdatePayoutStatusRequest create() => UpdatePayoutStatusRequest._();
  UpdatePayoutStatusRequest createEmptyInstance() => create();
  static $pb.PbList<UpdatePayoutStatusRequest> createRepeated() => $pb.PbList<UpdatePayoutStatusRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdatePayoutStatusRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdatePayoutStatusRequest>(create);
  static UpdatePayoutStatusRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get payoutId => $_getSZ(0);
  @$pb.TagNumber(1)
  set payoutId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPayoutId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayoutId() => clearField(1);

  @$pb.TagNumber(2)
  PayoutTransactionStatus get status => $_getN(1);
  @$pb.TagNumber(2)
  set status(PayoutTransactionStatus v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get transactionId => $_getSZ(2);
  @$pb.TagNumber(3)
  set transactionId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTransactionId() => $_has(2);
  @$pb.TagNumber(3)
  void clearTransactionId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get failureReason => $_getSZ(3);
  @$pb.TagNumber(4)
  set failureReason($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasFailureReason() => $_has(3);
  @$pb.TagNumber(4)
  void clearFailureReason() => clearField(4);
}

class UpdatePayoutStatusResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdatePayoutStatusResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<PayoutTransactionMessage>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payout', subBuilder: PayoutTransactionMessage.create)
    ..hasRequiredFields = false
  ;

  UpdatePayoutStatusResponse._() : super();
  factory UpdatePayoutStatusResponse({
    PayoutTransactionMessage? payout,
  }) {
    final _result = create();
    if (payout != null) {
      _result.payout = payout;
    }
    return _result;
  }
  factory UpdatePayoutStatusResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdatePayoutStatusResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdatePayoutStatusResponse clone() => UpdatePayoutStatusResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdatePayoutStatusResponse copyWith(void Function(UpdatePayoutStatusResponse) updates) => super.copyWith((message) => updates(message as UpdatePayoutStatusResponse)) as UpdatePayoutStatusResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UpdatePayoutStatusResponse create() => UpdatePayoutStatusResponse._();
  UpdatePayoutStatusResponse createEmptyInstance() => create();
  static $pb.PbList<UpdatePayoutStatusResponse> createRepeated() => $pb.PbList<UpdatePayoutStatusResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdatePayoutStatusResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdatePayoutStatusResponse>(create);
  static UpdatePayoutStatusResponse? _defaultInstance;

  @$pb.TagNumber(1)
  PayoutTransactionMessage get payout => $_getN(0);
  @$pb.TagNumber(1)
  set payout(PayoutTransactionMessage v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasPayout() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayout() => clearField(1);
  @$pb.TagNumber(1)
  PayoutTransactionMessage ensurePayout() => $_ensure(0);
}

class AdvancePayoutRotationRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AdvancePayoutRotationRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'contributionId')
    ..hasRequiredFields = false
  ;

  AdvancePayoutRotationRequest._() : super();
  factory AdvancePayoutRotationRequest({
    $core.String? contributionId,
  }) {
    final _result = create();
    if (contributionId != null) {
      _result.contributionId = contributionId;
    }
    return _result;
  }
  factory AdvancePayoutRotationRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AdvancePayoutRotationRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AdvancePayoutRotationRequest clone() => AdvancePayoutRotationRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AdvancePayoutRotationRequest copyWith(void Function(AdvancePayoutRotationRequest) updates) => super.copyWith((message) => updates(message as AdvancePayoutRotationRequest)) as AdvancePayoutRotationRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AdvancePayoutRotationRequest create() => AdvancePayoutRotationRequest._();
  AdvancePayoutRotationRequest createEmptyInstance() => create();
  static $pb.PbList<AdvancePayoutRotationRequest> createRepeated() => $pb.PbList<AdvancePayoutRotationRequest>();
  @$core.pragma('dart2js:noInline')
  static AdvancePayoutRotationRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdvancePayoutRotationRequest>(create);
  static AdvancePayoutRotationRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get contributionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set contributionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasContributionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearContributionId() => clearField(1);
}

class AdvancePayoutRotationResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AdvancePayoutRotationResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<ContributionMessage>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'contribution', subBuilder: ContributionMessage.create)
    ..hasRequiredFields = false
  ;

  AdvancePayoutRotationResponse._() : super();
  factory AdvancePayoutRotationResponse({
    ContributionMessage? contribution,
  }) {
    final _result = create();
    if (contribution != null) {
      _result.contribution = contribution;
    }
    return _result;
  }
  factory AdvancePayoutRotationResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AdvancePayoutRotationResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AdvancePayoutRotationResponse clone() => AdvancePayoutRotationResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AdvancePayoutRotationResponse copyWith(void Function(AdvancePayoutRotationResponse) updates) => super.copyWith((message) => updates(message as AdvancePayoutRotationResponse)) as AdvancePayoutRotationResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AdvancePayoutRotationResponse create() => AdvancePayoutRotationResponse._();
  AdvancePayoutRotationResponse createEmptyInstance() => create();
  static $pb.PbList<AdvancePayoutRotationResponse> createRepeated() => $pb.PbList<AdvancePayoutRotationResponse>();
  @$core.pragma('dart2js:noInline')
  static AdvancePayoutRotationResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdvancePayoutRotationResponse>(create);
  static AdvancePayoutRotationResponse? _defaultInstance;

  @$pb.TagNumber(1)
  ContributionMessage get contribution => $_getN(0);
  @$pb.TagNumber(1)
  set contribution(ContributionMessage v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasContribution() => $_has(0);
  @$pb.TagNumber(1)
  void clearContribution() => clearField(1);
  @$pb.TagNumber(1)
  ContributionMessage ensureContribution() => $_ensure(0);
}

class GenerateReceiptRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GenerateReceiptRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'paymentId')
    ..hasRequiredFields = false
  ;

  GenerateReceiptRequest._() : super();
  factory GenerateReceiptRequest({
    $core.String? paymentId,
  }) {
    final _result = create();
    if (paymentId != null) {
      _result.paymentId = paymentId;
    }
    return _result;
  }
  factory GenerateReceiptRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GenerateReceiptRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GenerateReceiptRequest clone() => GenerateReceiptRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GenerateReceiptRequest copyWith(void Function(GenerateReceiptRequest) updates) => super.copyWith((message) => updates(message as GenerateReceiptRequest)) as GenerateReceiptRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GenerateReceiptRequest create() => GenerateReceiptRequest._();
  GenerateReceiptRequest createEmptyInstance() => create();
  static $pb.PbList<GenerateReceiptRequest> createRepeated() => $pb.PbList<GenerateReceiptRequest>();
  @$core.pragma('dart2js:noInline')
  static GenerateReceiptRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GenerateReceiptRequest>(create);
  static GenerateReceiptRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get paymentId => $_getSZ(0);
  @$pb.TagNumber(1)
  set paymentId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPaymentId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPaymentId() => clearField(1);
}

class GenerateReceiptResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GenerateReceiptResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<ContributionReceiptMessage>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'receipt', subBuilder: ContributionReceiptMessage.create)
    ..hasRequiredFields = false
  ;

  GenerateReceiptResponse._() : super();
  factory GenerateReceiptResponse({
    ContributionReceiptMessage? receipt,
  }) {
    final _result = create();
    if (receipt != null) {
      _result.receipt = receipt;
    }
    return _result;
  }
  factory GenerateReceiptResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GenerateReceiptResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GenerateReceiptResponse clone() => GenerateReceiptResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GenerateReceiptResponse copyWith(void Function(GenerateReceiptResponse) updates) => super.copyWith((message) => updates(message as GenerateReceiptResponse)) as GenerateReceiptResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GenerateReceiptResponse create() => GenerateReceiptResponse._();
  GenerateReceiptResponse createEmptyInstance() => create();
  static $pb.PbList<GenerateReceiptResponse> createRepeated() => $pb.PbList<GenerateReceiptResponse>();
  @$core.pragma('dart2js:noInline')
  static GenerateReceiptResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GenerateReceiptResponse>(create);
  static GenerateReceiptResponse? _defaultInstance;

  @$pb.TagNumber(1)
  ContributionReceiptMessage get receipt => $_getN(0);
  @$pb.TagNumber(1)
  set receipt(ContributionReceiptMessage v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasReceipt() => $_has(0);
  @$pb.TagNumber(1)
  void clearReceipt() => clearField(1);
  @$pb.TagNumber(1)
  ContributionReceiptMessage ensureReceipt() => $_ensure(0);
}

class GetUserContributionReceiptsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetUserContributionReceiptsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetUserContributionReceiptsRequest._() : super();
  factory GetUserContributionReceiptsRequest({
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
  factory GetUserContributionReceiptsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUserContributionReceiptsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUserContributionReceiptsRequest clone() => GetUserContributionReceiptsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUserContributionReceiptsRequest copyWith(void Function(GetUserContributionReceiptsRequest) updates) => super.copyWith((message) => updates(message as GetUserContributionReceiptsRequest)) as GetUserContributionReceiptsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetUserContributionReceiptsRequest create() => GetUserContributionReceiptsRequest._();
  GetUserContributionReceiptsRequest createEmptyInstance() => create();
  static $pb.PbList<GetUserContributionReceiptsRequest> createRepeated() => $pb.PbList<GetUserContributionReceiptsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetUserContributionReceiptsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetUserContributionReceiptsRequest>(create);
  static GetUserContributionReceiptsRequest? _defaultInstance;

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

class GetUserContributionReceiptsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetUserContributionReceiptsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<ContributionReceiptMessage>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'receipts', $pb.PbFieldType.PM, subBuilder: ContributionReceiptMessage.create)
    ..aOM<ReceiptPaginationInfo>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pagination', subBuilder: ReceiptPaginationInfo.create)
    ..hasRequiredFields = false
  ;

  GetUserContributionReceiptsResponse._() : super();
  factory GetUserContributionReceiptsResponse({
    $core.Iterable<ContributionReceiptMessage>? receipts,
    ReceiptPaginationInfo? pagination,
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
  factory GetUserContributionReceiptsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUserContributionReceiptsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUserContributionReceiptsResponse clone() => GetUserContributionReceiptsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUserContributionReceiptsResponse copyWith(void Function(GetUserContributionReceiptsResponse) updates) => super.copyWith((message) => updates(message as GetUserContributionReceiptsResponse)) as GetUserContributionReceiptsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetUserContributionReceiptsResponse create() => GetUserContributionReceiptsResponse._();
  GetUserContributionReceiptsResponse createEmptyInstance() => create();
  static $pb.PbList<GetUserContributionReceiptsResponse> createRepeated() => $pb.PbList<GetUserContributionReceiptsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetUserContributionReceiptsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetUserContributionReceiptsResponse>(create);
  static GetUserContributionReceiptsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<ContributionReceiptMessage> get receipts => $_getList(0);

  @$pb.TagNumber(2)
  ReceiptPaginationInfo get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination(ReceiptPaginationInfo v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => clearField(2);
  @$pb.TagNumber(2)
  ReceiptPaginationInfo ensurePagination() => $_ensure(1);
}

class GenerateTranscriptRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GenerateTranscriptRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'contributionId')
    ..hasRequiredFields = false
  ;

  GenerateTranscriptRequest._() : super();
  factory GenerateTranscriptRequest({
    $core.String? contributionId,
  }) {
    final _result = create();
    if (contributionId != null) {
      _result.contributionId = contributionId;
    }
    return _result;
  }
  factory GenerateTranscriptRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GenerateTranscriptRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GenerateTranscriptRequest clone() => GenerateTranscriptRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GenerateTranscriptRequest copyWith(void Function(GenerateTranscriptRequest) updates) => super.copyWith((message) => updates(message as GenerateTranscriptRequest)) as GenerateTranscriptRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GenerateTranscriptRequest create() => GenerateTranscriptRequest._();
  GenerateTranscriptRequest createEmptyInstance() => create();
  static $pb.PbList<GenerateTranscriptRequest> createRepeated() => $pb.PbList<GenerateTranscriptRequest>();
  @$core.pragma('dart2js:noInline')
  static GenerateTranscriptRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GenerateTranscriptRequest>(create);
  static GenerateTranscriptRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get contributionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set contributionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasContributionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearContributionId() => clearField(1);
}

class GenerateTranscriptResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GenerateTranscriptResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<ContributionTranscriptMessage>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transcript', subBuilder: ContributionTranscriptMessage.create)
    ..hasRequiredFields = false
  ;

  GenerateTranscriptResponse._() : super();
  factory GenerateTranscriptResponse({
    ContributionTranscriptMessage? transcript,
  }) {
    final _result = create();
    if (transcript != null) {
      _result.transcript = transcript;
    }
    return _result;
  }
  factory GenerateTranscriptResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GenerateTranscriptResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GenerateTranscriptResponse clone() => GenerateTranscriptResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GenerateTranscriptResponse copyWith(void Function(GenerateTranscriptResponse) updates) => super.copyWith((message) => updates(message as GenerateTranscriptResponse)) as GenerateTranscriptResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GenerateTranscriptResponse create() => GenerateTranscriptResponse._();
  GenerateTranscriptResponse createEmptyInstance() => create();
  static $pb.PbList<GenerateTranscriptResponse> createRepeated() => $pb.PbList<GenerateTranscriptResponse>();
  @$core.pragma('dart2js:noInline')
  static GenerateTranscriptResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GenerateTranscriptResponse>(create);
  static GenerateTranscriptResponse? _defaultInstance;

  @$pb.TagNumber(1)
  ContributionTranscriptMessage get transcript => $_getN(0);
  @$pb.TagNumber(1)
  set transcript(ContributionTranscriptMessage v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasTranscript() => $_has(0);
  @$pb.TagNumber(1)
  void clearTranscript() => clearField(1);
  @$pb.TagNumber(1)
  ContributionTranscriptMessage ensureTranscript() => $_ensure(0);
}

class GetGroupStatisticsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetGroupStatisticsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'groupId')
    ..hasRequiredFields = false
  ;

  GetGroupStatisticsRequest._() : super();
  factory GetGroupStatisticsRequest({
    $core.String? groupId,
  }) {
    final _result = create();
    if (groupId != null) {
      _result.groupId = groupId;
    }
    return _result;
  }
  factory GetGroupStatisticsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetGroupStatisticsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetGroupStatisticsRequest clone() => GetGroupStatisticsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetGroupStatisticsRequest copyWith(void Function(GetGroupStatisticsRequest) updates) => super.copyWith((message) => updates(message as GetGroupStatisticsRequest)) as GetGroupStatisticsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetGroupStatisticsRequest create() => GetGroupStatisticsRequest._();
  GetGroupStatisticsRequest createEmptyInstance() => create();
  static $pb.PbList<GetGroupStatisticsRequest> createRepeated() => $pb.PbList<GetGroupStatisticsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetGroupStatisticsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetGroupStatisticsRequest>(create);
  static GetGroupStatisticsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get groupId => $_getSZ(0);
  @$pb.TagNumber(1)
  set groupId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasGroupId() => $_has(0);
  @$pb.TagNumber(1)
  void clearGroupId() => clearField(1);
}

class GetGroupStatisticsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetGroupStatisticsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'memberCount', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalContributions', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'completedContributions', $pb.PbFieldType.O3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'activeContributions', $pb.PbFieldType.O3)
    ..a<$fixnum.Int64>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalTargetAmount', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalCurrentAmount', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.double>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'completionRate', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  GetGroupStatisticsResponse._() : super();
  factory GetGroupStatisticsResponse({
    $core.int? memberCount,
    $core.int? totalContributions,
    $core.int? completedContributions,
    $core.int? activeContributions,
    $fixnum.Int64? totalTargetAmount,
    $fixnum.Int64? totalCurrentAmount,
    $core.double? completionRate,
  }) {
    final _result = create();
    if (memberCount != null) {
      _result.memberCount = memberCount;
    }
    if (totalContributions != null) {
      _result.totalContributions = totalContributions;
    }
    if (completedContributions != null) {
      _result.completedContributions = completedContributions;
    }
    if (activeContributions != null) {
      _result.activeContributions = activeContributions;
    }
    if (totalTargetAmount != null) {
      _result.totalTargetAmount = totalTargetAmount;
    }
    if (totalCurrentAmount != null) {
      _result.totalCurrentAmount = totalCurrentAmount;
    }
    if (completionRate != null) {
      _result.completionRate = completionRate;
    }
    return _result;
  }
  factory GetGroupStatisticsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetGroupStatisticsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetGroupStatisticsResponse clone() => GetGroupStatisticsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetGroupStatisticsResponse copyWith(void Function(GetGroupStatisticsResponse) updates) => super.copyWith((message) => updates(message as GetGroupStatisticsResponse)) as GetGroupStatisticsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetGroupStatisticsResponse create() => GetGroupStatisticsResponse._();
  GetGroupStatisticsResponse createEmptyInstance() => create();
  static $pb.PbList<GetGroupStatisticsResponse> createRepeated() => $pb.PbList<GetGroupStatisticsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetGroupStatisticsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetGroupStatisticsResponse>(create);
  static GetGroupStatisticsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get memberCount => $_getIZ(0);
  @$pb.TagNumber(1)
  set memberCount($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMemberCount() => $_has(0);
  @$pb.TagNumber(1)
  void clearMemberCount() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get totalContributions => $_getIZ(1);
  @$pb.TagNumber(2)
  set totalContributions($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotalContributions() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalContributions() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get completedContributions => $_getIZ(2);
  @$pb.TagNumber(3)
  set completedContributions($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCompletedContributions() => $_has(2);
  @$pb.TagNumber(3)
  void clearCompletedContributions() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get activeContributions => $_getIZ(3);
  @$pb.TagNumber(4)
  set activeContributions($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasActiveContributions() => $_has(3);
  @$pb.TagNumber(4)
  void clearActiveContributions() => clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get totalTargetAmount => $_getI64(4);
  @$pb.TagNumber(5)
  set totalTargetAmount($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTotalTargetAmount() => $_has(4);
  @$pb.TagNumber(5)
  void clearTotalTargetAmount() => clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get totalCurrentAmount => $_getI64(5);
  @$pb.TagNumber(6)
  set totalCurrentAmount($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasTotalCurrentAmount() => $_has(5);
  @$pb.TagNumber(6)
  void clearTotalCurrentAmount() => clearField(6);

  @$pb.TagNumber(7)
  $core.double get completionRate => $_getN(6);
  @$pb.TagNumber(7)
  set completionRate($core.double v) { $_setDouble(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasCompletionRate() => $_has(6);
  @$pb.TagNumber(7)
  void clearCompletionRate() => clearField(7);
}

class GetUserContributionStatsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetUserContributionStatsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GetUserContributionStatsRequest._() : super();
  factory GetUserContributionStatsRequest() => create();
  factory GetUserContributionStatsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUserContributionStatsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUserContributionStatsRequest clone() => GetUserContributionStatsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUserContributionStatsRequest copyWith(void Function(GetUserContributionStatsRequest) updates) => super.copyWith((message) => updates(message as GetUserContributionStatsRequest)) as GetUserContributionStatsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetUserContributionStatsRequest create() => GetUserContributionStatsRequest._();
  GetUserContributionStatsRequest createEmptyInstance() => create();
  static $pb.PbList<GetUserContributionStatsRequest> createRepeated() => $pb.PbList<GetUserContributionStatsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetUserContributionStatsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetUserContributionStatsRequest>(create);
  static GetUserContributionStatsRequest? _defaultInstance;
}

class GetUserContributionStatsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetUserContributionStatsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalPayments', $pb.PbFieldType.O3)
    ..a<$fixnum.Int64>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalAmount', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'groupsCount', $pb.PbFieldType.O3)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'averagePayment', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  GetUserContributionStatsResponse._() : super();
  factory GetUserContributionStatsResponse({
    $core.int? totalPayments,
    $fixnum.Int64? totalAmount,
    $core.int? groupsCount,
    $core.double? averagePayment,
  }) {
    final _result = create();
    if (totalPayments != null) {
      _result.totalPayments = totalPayments;
    }
    if (totalAmount != null) {
      _result.totalAmount = totalAmount;
    }
    if (groupsCount != null) {
      _result.groupsCount = groupsCount;
    }
    if (averagePayment != null) {
      _result.averagePayment = averagePayment;
    }
    return _result;
  }
  factory GetUserContributionStatsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUserContributionStatsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUserContributionStatsResponse clone() => GetUserContributionStatsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUserContributionStatsResponse copyWith(void Function(GetUserContributionStatsResponse) updates) => super.copyWith((message) => updates(message as GetUserContributionStatsResponse)) as GetUserContributionStatsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetUserContributionStatsResponse create() => GetUserContributionStatsResponse._();
  GetUserContributionStatsResponse createEmptyInstance() => create();
  static $pb.PbList<GetUserContributionStatsResponse> createRepeated() => $pb.PbList<GetUserContributionStatsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetUserContributionStatsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetUserContributionStatsResponse>(create);
  static GetUserContributionStatsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get totalPayments => $_getIZ(0);
  @$pb.TagNumber(1)
  set totalPayments($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTotalPayments() => $_has(0);
  @$pb.TagNumber(1)
  void clearTotalPayments() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get totalAmount => $_getI64(1);
  @$pb.TagNumber(2)
  set totalAmount($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotalAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalAmount() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get groupsCount => $_getIZ(2);
  @$pb.TagNumber(3)
  set groupsCount($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasGroupsCount() => $_has(2);
  @$pb.TagNumber(3)
  void clearGroupsCount() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get averagePayment => $_getN(3);
  @$pb.TagNumber(4)
  set averagePayment($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasAveragePayment() => $_has(3);
  @$pb.TagNumber(4)
  void clearAveragePayment() => clearField(4);
}

class GetContributionAnalyticsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetContributionAnalyticsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'contributionId')
    ..hasRequiredFields = false
  ;

  GetContributionAnalyticsRequest._() : super();
  factory GetContributionAnalyticsRequest({
    $core.String? contributionId,
  }) {
    final _result = create();
    if (contributionId != null) {
      _result.contributionId = contributionId;
    }
    return _result;
  }
  factory GetContributionAnalyticsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetContributionAnalyticsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetContributionAnalyticsRequest clone() => GetContributionAnalyticsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetContributionAnalyticsRequest copyWith(void Function(GetContributionAnalyticsRequest) updates) => super.copyWith((message) => updates(message as GetContributionAnalyticsRequest)) as GetContributionAnalyticsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetContributionAnalyticsRequest create() => GetContributionAnalyticsRequest._();
  GetContributionAnalyticsRequest createEmptyInstance() => create();
  static $pb.PbList<GetContributionAnalyticsRequest> createRepeated() => $pb.PbList<GetContributionAnalyticsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetContributionAnalyticsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetContributionAnalyticsRequest>(create);
  static GetContributionAnalyticsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get contributionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set contributionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasContributionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearContributionId() => clearField(1);
}

class GetContributionAnalyticsResponse_MemberParticipation extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetContributionAnalyticsResponse.MemberParticipation', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalMembers', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'participatingMembers', $pb.PbFieldType.O3)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'participationRate', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  GetContributionAnalyticsResponse_MemberParticipation._() : super();
  factory GetContributionAnalyticsResponse_MemberParticipation({
    $core.int? totalMembers,
    $core.int? participatingMembers,
    $core.double? participationRate,
  }) {
    final _result = create();
    if (totalMembers != null) {
      _result.totalMembers = totalMembers;
    }
    if (participatingMembers != null) {
      _result.participatingMembers = participatingMembers;
    }
    if (participationRate != null) {
      _result.participationRate = participationRate;
    }
    return _result;
  }
  factory GetContributionAnalyticsResponse_MemberParticipation.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetContributionAnalyticsResponse_MemberParticipation.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetContributionAnalyticsResponse_MemberParticipation clone() => GetContributionAnalyticsResponse_MemberParticipation()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetContributionAnalyticsResponse_MemberParticipation copyWith(void Function(GetContributionAnalyticsResponse_MemberParticipation) updates) => super.copyWith((message) => updates(message as GetContributionAnalyticsResponse_MemberParticipation)) as GetContributionAnalyticsResponse_MemberParticipation; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetContributionAnalyticsResponse_MemberParticipation create() => GetContributionAnalyticsResponse_MemberParticipation._();
  GetContributionAnalyticsResponse_MemberParticipation createEmptyInstance() => create();
  static $pb.PbList<GetContributionAnalyticsResponse_MemberParticipation> createRepeated() => $pb.PbList<GetContributionAnalyticsResponse_MemberParticipation>();
  @$core.pragma('dart2js:noInline')
  static GetContributionAnalyticsResponse_MemberParticipation getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetContributionAnalyticsResponse_MemberParticipation>(create);
  static GetContributionAnalyticsResponse_MemberParticipation? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get totalMembers => $_getIZ(0);
  @$pb.TagNumber(1)
  set totalMembers($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTotalMembers() => $_has(0);
  @$pb.TagNumber(1)
  void clearTotalMembers() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get participatingMembers => $_getIZ(1);
  @$pb.TagNumber(2)
  set participatingMembers($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasParticipatingMembers() => $_has(1);
  @$pb.TagNumber(2)
  void clearParticipatingMembers() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get participationRate => $_getN(2);
  @$pb.TagNumber(3)
  set participationRate($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasParticipationRate() => $_has(2);
  @$pb.TagNumber(3)
  void clearParticipationRate() => clearField(3);
}

class GetContributionAnalyticsResponse_Schedule extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetContributionAnalyticsResponse.Schedule', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isOnSchedule')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'daysBehindSchedule', $pb.PbFieldType.O3)
    ..aOM<$1.Timestamp>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'nextPaymentDate', subBuilder: $1.Timestamp.create)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currentCycle', $pb.PbFieldType.O3)
    ..a<$core.int>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalCycles', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetContributionAnalyticsResponse_Schedule._() : super();
  factory GetContributionAnalyticsResponse_Schedule({
    $core.bool? isOnSchedule,
    $core.int? daysBehindSchedule,
    $1.Timestamp? nextPaymentDate,
    $core.int? currentCycle,
    $core.int? totalCycles,
  }) {
    final _result = create();
    if (isOnSchedule != null) {
      _result.isOnSchedule = isOnSchedule;
    }
    if (daysBehindSchedule != null) {
      _result.daysBehindSchedule = daysBehindSchedule;
    }
    if (nextPaymentDate != null) {
      _result.nextPaymentDate = nextPaymentDate;
    }
    if (currentCycle != null) {
      _result.currentCycle = currentCycle;
    }
    if (totalCycles != null) {
      _result.totalCycles = totalCycles;
    }
    return _result;
  }
  factory GetContributionAnalyticsResponse_Schedule.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetContributionAnalyticsResponse_Schedule.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetContributionAnalyticsResponse_Schedule clone() => GetContributionAnalyticsResponse_Schedule()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetContributionAnalyticsResponse_Schedule copyWith(void Function(GetContributionAnalyticsResponse_Schedule) updates) => super.copyWith((message) => updates(message as GetContributionAnalyticsResponse_Schedule)) as GetContributionAnalyticsResponse_Schedule; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetContributionAnalyticsResponse_Schedule create() => GetContributionAnalyticsResponse_Schedule._();
  GetContributionAnalyticsResponse_Schedule createEmptyInstance() => create();
  static $pb.PbList<GetContributionAnalyticsResponse_Schedule> createRepeated() => $pb.PbList<GetContributionAnalyticsResponse_Schedule>();
  @$core.pragma('dart2js:noInline')
  static GetContributionAnalyticsResponse_Schedule getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetContributionAnalyticsResponse_Schedule>(create);
  static GetContributionAnalyticsResponse_Schedule? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get isOnSchedule => $_getBF(0);
  @$pb.TagNumber(1)
  set isOnSchedule($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasIsOnSchedule() => $_has(0);
  @$pb.TagNumber(1)
  void clearIsOnSchedule() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get daysBehindSchedule => $_getIZ(1);
  @$pb.TagNumber(2)
  set daysBehindSchedule($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasDaysBehindSchedule() => $_has(1);
  @$pb.TagNumber(2)
  void clearDaysBehindSchedule() => clearField(2);

  @$pb.TagNumber(3)
  $1.Timestamp get nextPaymentDate => $_getN(2);
  @$pb.TagNumber(3)
  set nextPaymentDate($1.Timestamp v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasNextPaymentDate() => $_has(2);
  @$pb.TagNumber(3)
  void clearNextPaymentDate() => clearField(3);
  @$pb.TagNumber(3)
  $1.Timestamp ensureNextPaymentDate() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.int get currentCycle => $_getIZ(3);
  @$pb.TagNumber(4)
  set currentCycle($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCurrentCycle() => $_has(3);
  @$pb.TagNumber(4)
  void clearCurrentCycle() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get totalCycles => $_getIZ(4);
  @$pb.TagNumber(5)
  set totalCycles($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTotalCycles() => $_has(4);
  @$pb.TagNumber(5)
  void clearTotalCycles() => clearField(5);
}

class GetContributionAnalyticsResponse_Payout extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetContributionAnalyticsResponse.Payout', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currentRecipient')
    ..aOM<$1.Timestamp>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'nextPayoutDate', subBuilder: $1.Timestamp.create)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'completedPayouts', $pb.PbFieldType.O3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pendingPayouts', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetContributionAnalyticsResponse_Payout._() : super();
  factory GetContributionAnalyticsResponse_Payout({
    $core.String? currentRecipient,
    $1.Timestamp? nextPayoutDate,
    $core.int? completedPayouts,
    $core.int? pendingPayouts,
  }) {
    final _result = create();
    if (currentRecipient != null) {
      _result.currentRecipient = currentRecipient;
    }
    if (nextPayoutDate != null) {
      _result.nextPayoutDate = nextPayoutDate;
    }
    if (completedPayouts != null) {
      _result.completedPayouts = completedPayouts;
    }
    if (pendingPayouts != null) {
      _result.pendingPayouts = pendingPayouts;
    }
    return _result;
  }
  factory GetContributionAnalyticsResponse_Payout.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetContributionAnalyticsResponse_Payout.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetContributionAnalyticsResponse_Payout clone() => GetContributionAnalyticsResponse_Payout()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetContributionAnalyticsResponse_Payout copyWith(void Function(GetContributionAnalyticsResponse_Payout) updates) => super.copyWith((message) => updates(message as GetContributionAnalyticsResponse_Payout)) as GetContributionAnalyticsResponse_Payout; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetContributionAnalyticsResponse_Payout create() => GetContributionAnalyticsResponse_Payout._();
  GetContributionAnalyticsResponse_Payout createEmptyInstance() => create();
  static $pb.PbList<GetContributionAnalyticsResponse_Payout> createRepeated() => $pb.PbList<GetContributionAnalyticsResponse_Payout>();
  @$core.pragma('dart2js:noInline')
  static GetContributionAnalyticsResponse_Payout getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetContributionAnalyticsResponse_Payout>(create);
  static GetContributionAnalyticsResponse_Payout? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get currentRecipient => $_getSZ(0);
  @$pb.TagNumber(1)
  set currentRecipient($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCurrentRecipient() => $_has(0);
  @$pb.TagNumber(1)
  void clearCurrentRecipient() => clearField(1);

  @$pb.TagNumber(2)
  $1.Timestamp get nextPayoutDate => $_getN(1);
  @$pb.TagNumber(2)
  set nextPayoutDate($1.Timestamp v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasNextPayoutDate() => $_has(1);
  @$pb.TagNumber(2)
  void clearNextPayoutDate() => clearField(2);
  @$pb.TagNumber(2)
  $1.Timestamp ensureNextPayoutDate() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.int get completedPayouts => $_getIZ(2);
  @$pb.TagNumber(3)
  set completedPayouts($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCompletedPayouts() => $_has(2);
  @$pb.TagNumber(3)
  void clearCompletedPayouts() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get pendingPayouts => $_getIZ(3);
  @$pb.TagNumber(4)
  set pendingPayouts($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPendingPayouts() => $_has(3);
  @$pb.TagNumber(4)
  void clearPendingPayouts() => clearField(4);
}

class GetContributionAnalyticsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetContributionAnalyticsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'contributionId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type')
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'progressPercentage', $pb.PbFieldType.OD)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalPayments', $pb.PbFieldType.O3)
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'averagePayment', $pb.PbFieldType.OD)
    ..a<$fixnum.Int64>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currentAmount', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'targetAmount', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<GetContributionAnalyticsResponse_MemberParticipation>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'memberParticipation', subBuilder: GetContributionAnalyticsResponse_MemberParticipation.create)
    ..aOM<GetContributionAnalyticsResponse_Schedule>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'schedule', subBuilder: GetContributionAnalyticsResponse_Schedule.create)
    ..aOM<GetContributionAnalyticsResponse_Payout>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payout', subBuilder: GetContributionAnalyticsResponse_Payout.create)
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'memberStats')
    ..hasRequiredFields = false
  ;

  GetContributionAnalyticsResponse._() : super();
  factory GetContributionAnalyticsResponse({
    $core.String? contributionId,
    $core.String? type,
    $core.double? progressPercentage,
    $core.int? totalPayments,
    $core.double? averagePayment,
    $fixnum.Int64? currentAmount,
    $fixnum.Int64? targetAmount,
    GetContributionAnalyticsResponse_MemberParticipation? memberParticipation,
    GetContributionAnalyticsResponse_Schedule? schedule,
    GetContributionAnalyticsResponse_Payout? payout,
    $core.String? memberStats,
  }) {
    final _result = create();
    if (contributionId != null) {
      _result.contributionId = contributionId;
    }
    if (type != null) {
      _result.type = type;
    }
    if (progressPercentage != null) {
      _result.progressPercentage = progressPercentage;
    }
    if (totalPayments != null) {
      _result.totalPayments = totalPayments;
    }
    if (averagePayment != null) {
      _result.averagePayment = averagePayment;
    }
    if (currentAmount != null) {
      _result.currentAmount = currentAmount;
    }
    if (targetAmount != null) {
      _result.targetAmount = targetAmount;
    }
    if (memberParticipation != null) {
      _result.memberParticipation = memberParticipation;
    }
    if (schedule != null) {
      _result.schedule = schedule;
    }
    if (payout != null) {
      _result.payout = payout;
    }
    if (memberStats != null) {
      _result.memberStats = memberStats;
    }
    return _result;
  }
  factory GetContributionAnalyticsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetContributionAnalyticsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetContributionAnalyticsResponse clone() => GetContributionAnalyticsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetContributionAnalyticsResponse copyWith(void Function(GetContributionAnalyticsResponse) updates) => super.copyWith((message) => updates(message as GetContributionAnalyticsResponse)) as GetContributionAnalyticsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetContributionAnalyticsResponse create() => GetContributionAnalyticsResponse._();
  GetContributionAnalyticsResponse createEmptyInstance() => create();
  static $pb.PbList<GetContributionAnalyticsResponse> createRepeated() => $pb.PbList<GetContributionAnalyticsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetContributionAnalyticsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetContributionAnalyticsResponse>(create);
  static GetContributionAnalyticsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get contributionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set contributionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasContributionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearContributionId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get type => $_getSZ(1);
  @$pb.TagNumber(2)
  set type($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasType() => $_has(1);
  @$pb.TagNumber(2)
  void clearType() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get progressPercentage => $_getN(2);
  @$pb.TagNumber(3)
  set progressPercentage($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasProgressPercentage() => $_has(2);
  @$pb.TagNumber(3)
  void clearProgressPercentage() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get totalPayments => $_getIZ(3);
  @$pb.TagNumber(4)
  set totalPayments($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTotalPayments() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalPayments() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get averagePayment => $_getN(4);
  @$pb.TagNumber(5)
  set averagePayment($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasAveragePayment() => $_has(4);
  @$pb.TagNumber(5)
  void clearAveragePayment() => clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get currentAmount => $_getI64(5);
  @$pb.TagNumber(6)
  set currentAmount($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasCurrentAmount() => $_has(5);
  @$pb.TagNumber(6)
  void clearCurrentAmount() => clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get targetAmount => $_getI64(6);
  @$pb.TagNumber(7)
  set targetAmount($fixnum.Int64 v) { $_setInt64(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasTargetAmount() => $_has(6);
  @$pb.TagNumber(7)
  void clearTargetAmount() => clearField(7);

  @$pb.TagNumber(8)
  GetContributionAnalyticsResponse_MemberParticipation get memberParticipation => $_getN(7);
  @$pb.TagNumber(8)
  set memberParticipation(GetContributionAnalyticsResponse_MemberParticipation v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasMemberParticipation() => $_has(7);
  @$pb.TagNumber(8)
  void clearMemberParticipation() => clearField(8);
  @$pb.TagNumber(8)
  GetContributionAnalyticsResponse_MemberParticipation ensureMemberParticipation() => $_ensure(7);

  @$pb.TagNumber(9)
  GetContributionAnalyticsResponse_Schedule get schedule => $_getN(8);
  @$pb.TagNumber(9)
  set schedule(GetContributionAnalyticsResponse_Schedule v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasSchedule() => $_has(8);
  @$pb.TagNumber(9)
  void clearSchedule() => clearField(9);
  @$pb.TagNumber(9)
  GetContributionAnalyticsResponse_Schedule ensureSchedule() => $_ensure(8);

  @$pb.TagNumber(10)
  GetContributionAnalyticsResponse_Payout get payout => $_getN(9);
  @$pb.TagNumber(10)
  set payout(GetContributionAnalyticsResponse_Payout v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasPayout() => $_has(9);
  @$pb.TagNumber(10)
  void clearPayout() => clearField(10);
  @$pb.TagNumber(10)
  GetContributionAnalyticsResponse_Payout ensurePayout() => $_ensure(9);

  @$pb.TagNumber(11)
  $core.String get memberStats => $_getSZ(10);
  @$pb.TagNumber(11)
  set memberStats($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasMemberStats() => $_has(10);
  @$pb.TagNumber(11)
  void clearMemberStats() => clearField(11);
}

class GroupPaginationInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GroupPaginationInfo', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currentPage', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalPages', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalItems', $pb.PbFieldType.O3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'itemsPerPage', $pb.PbFieldType.O3)
    ..aOB(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hasNext')
    ..aOB(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hasPrev')
    ..hasRequiredFields = false
  ;

  GroupPaginationInfo._() : super();
  factory GroupPaginationInfo({
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
  factory GroupPaginationInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GroupPaginationInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GroupPaginationInfo clone() => GroupPaginationInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GroupPaginationInfo copyWith(void Function(GroupPaginationInfo) updates) => super.copyWith((message) => updates(message as GroupPaginationInfo)) as GroupPaginationInfo; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GroupPaginationInfo create() => GroupPaginationInfo._();
  GroupPaginationInfo createEmptyInstance() => create();
  static $pb.PbList<GroupPaginationInfo> createRepeated() => $pb.PbList<GroupPaginationInfo>();
  @$core.pragma('dart2js:noInline')
  static GroupPaginationInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GroupPaginationInfo>(create);
  static GroupPaginationInfo? _defaultInstance;

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

class ContributionPaginationInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ContributionPaginationInfo', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currentPage', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalPages', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalItems', $pb.PbFieldType.O3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'itemsPerPage', $pb.PbFieldType.O3)
    ..aOB(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hasNext')
    ..aOB(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hasPrev')
    ..hasRequiredFields = false
  ;

  ContributionPaginationInfo._() : super();
  factory ContributionPaginationInfo({
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
  factory ContributionPaginationInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ContributionPaginationInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ContributionPaginationInfo clone() => ContributionPaginationInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ContributionPaginationInfo copyWith(void Function(ContributionPaginationInfo) updates) => super.copyWith((message) => updates(message as ContributionPaginationInfo)) as ContributionPaginationInfo; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ContributionPaginationInfo create() => ContributionPaginationInfo._();
  ContributionPaginationInfo createEmptyInstance() => create();
  static $pb.PbList<ContributionPaginationInfo> createRepeated() => $pb.PbList<ContributionPaginationInfo>();
  @$core.pragma('dart2js:noInline')
  static ContributionPaginationInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ContributionPaginationInfo>(create);
  static ContributionPaginationInfo? _defaultInstance;

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

class PaymentPaginationInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PaymentPaginationInfo', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currentPage', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalPages', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalItems', $pb.PbFieldType.O3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'itemsPerPage', $pb.PbFieldType.O3)
    ..aOB(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hasNext')
    ..aOB(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hasPrev')
    ..hasRequiredFields = false
  ;

  PaymentPaginationInfo._() : super();
  factory PaymentPaginationInfo({
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
  factory PaymentPaginationInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PaymentPaginationInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PaymentPaginationInfo clone() => PaymentPaginationInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PaymentPaginationInfo copyWith(void Function(PaymentPaginationInfo) updates) => super.copyWith((message) => updates(message as PaymentPaginationInfo)) as PaymentPaginationInfo; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PaymentPaginationInfo create() => PaymentPaginationInfo._();
  PaymentPaginationInfo createEmptyInstance() => create();
  static $pb.PbList<PaymentPaginationInfo> createRepeated() => $pb.PbList<PaymentPaginationInfo>();
  @$core.pragma('dart2js:noInline')
  static PaymentPaginationInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PaymentPaginationInfo>(create);
  static PaymentPaginationInfo? _defaultInstance;

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

class ReceiptPaginationInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ReceiptPaginationInfo', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currentPage', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalPages', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalItems', $pb.PbFieldType.O3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'itemsPerPage', $pb.PbFieldType.O3)
    ..aOB(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hasNext')
    ..aOB(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hasPrev')
    ..hasRequiredFields = false
  ;

  ReceiptPaginationInfo._() : super();
  factory ReceiptPaginationInfo({
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
  factory ReceiptPaginationInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ReceiptPaginationInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ReceiptPaginationInfo clone() => ReceiptPaginationInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ReceiptPaginationInfo copyWith(void Function(ReceiptPaginationInfo) updates) => super.copyWith((message) => updates(message as ReceiptPaginationInfo)) as ReceiptPaginationInfo; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ReceiptPaginationInfo create() => ReceiptPaginationInfo._();
  ReceiptPaginationInfo createEmptyInstance() => create();
  static $pb.PbList<ReceiptPaginationInfo> createRepeated() => $pb.PbList<ReceiptPaginationInfo>();
  @$core.pragma('dart2js:noInline')
  static ReceiptPaginationInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ReceiptPaginationInfo>(create);
  static ReceiptPaginationInfo? _defaultInstance;

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

class ActivityLogPaginationInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ActivityLogPaginationInfo', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currentPage', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalPages', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalCount', $pb.PbFieldType.O3)
    ..aOB(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hasMore')
    ..hasRequiredFields = false
  ;

  ActivityLogPaginationInfo._() : super();
  factory ActivityLogPaginationInfo({
    $core.int? currentPage,
    $core.int? totalPages,
    $core.int? totalCount,
    $core.bool? hasMore,
  }) {
    final _result = create();
    if (currentPage != null) {
      _result.currentPage = currentPage;
    }
    if (totalPages != null) {
      _result.totalPages = totalPages;
    }
    if (totalCount != null) {
      _result.totalCount = totalCount;
    }
    if (hasMore != null) {
      _result.hasMore = hasMore;
    }
    return _result;
  }
  factory ActivityLogPaginationInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ActivityLogPaginationInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ActivityLogPaginationInfo clone() => ActivityLogPaginationInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ActivityLogPaginationInfo copyWith(void Function(ActivityLogPaginationInfo) updates) => super.copyWith((message) => updates(message as ActivityLogPaginationInfo)) as ActivityLogPaginationInfo; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ActivityLogPaginationInfo create() => ActivityLogPaginationInfo._();
  ActivityLogPaginationInfo createEmptyInstance() => create();
  static $pb.PbList<ActivityLogPaginationInfo> createRepeated() => $pb.PbList<ActivityLogPaginationInfo>();
  @$core.pragma('dart2js:noInline')
  static ActivityLogPaginationInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ActivityLogPaginationInfo>(create);
  static ActivityLogPaginationInfo? _defaultInstance;

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
  $core.int get totalCount => $_getIZ(2);
  @$pb.TagNumber(3)
  set totalCount($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTotalCount() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalCount() => clearField(3);

  @$pb.TagNumber(4)
  $core.bool get hasMore => $_getBF(3);
  @$pb.TagNumber(4)
  set hasMore($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasHasMore() => $_has(3);
  @$pb.TagNumber(4)
  void clearHasMore() => clearField(4);
}

class GroupActivityLogMessage extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GroupActivityLogMessage', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'groupId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'contributionId')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'actorUserId')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'actorName')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'actionType')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'targetType')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'targetId')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'details')
    ..aOM<$1.Timestamp>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false
  ;

  GroupActivityLogMessage._() : super();
  factory GroupActivityLogMessage({
    $core.String? id,
    $core.String? groupId,
    $core.String? contributionId,
    $core.String? actorUserId,
    $core.String? actorName,
    $core.String? actionType,
    $core.String? targetType,
    $core.String? targetId,
    $core.String? details,
    $1.Timestamp? createdAt,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (groupId != null) {
      _result.groupId = groupId;
    }
    if (contributionId != null) {
      _result.contributionId = contributionId;
    }
    if (actorUserId != null) {
      _result.actorUserId = actorUserId;
    }
    if (actorName != null) {
      _result.actorName = actorName;
    }
    if (actionType != null) {
      _result.actionType = actionType;
    }
    if (targetType != null) {
      _result.targetType = targetType;
    }
    if (targetId != null) {
      _result.targetId = targetId;
    }
    if (details != null) {
      _result.details = details;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    return _result;
  }
  factory GroupActivityLogMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GroupActivityLogMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GroupActivityLogMessage clone() => GroupActivityLogMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GroupActivityLogMessage copyWith(void Function(GroupActivityLogMessage) updates) => super.copyWith((message) => updates(message as GroupActivityLogMessage)) as GroupActivityLogMessage; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GroupActivityLogMessage create() => GroupActivityLogMessage._();
  GroupActivityLogMessage createEmptyInstance() => create();
  static $pb.PbList<GroupActivityLogMessage> createRepeated() => $pb.PbList<GroupActivityLogMessage>();
  @$core.pragma('dart2js:noInline')
  static GroupActivityLogMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GroupActivityLogMessage>(create);
  static GroupActivityLogMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get groupId => $_getSZ(1);
  @$pb.TagNumber(2)
  set groupId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasGroupId() => $_has(1);
  @$pb.TagNumber(2)
  void clearGroupId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get contributionId => $_getSZ(2);
  @$pb.TagNumber(3)
  set contributionId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasContributionId() => $_has(2);
  @$pb.TagNumber(3)
  void clearContributionId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get actorUserId => $_getSZ(3);
  @$pb.TagNumber(4)
  set actorUserId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasActorUserId() => $_has(3);
  @$pb.TagNumber(4)
  void clearActorUserId() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get actorName => $_getSZ(4);
  @$pb.TagNumber(5)
  set actorName($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasActorName() => $_has(4);
  @$pb.TagNumber(5)
  void clearActorName() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get actionType => $_getSZ(5);
  @$pb.TagNumber(6)
  set actionType($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasActionType() => $_has(5);
  @$pb.TagNumber(6)
  void clearActionType() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get targetType => $_getSZ(6);
  @$pb.TagNumber(7)
  set targetType($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasTargetType() => $_has(6);
  @$pb.TagNumber(7)
  void clearTargetType() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get targetId => $_getSZ(7);
  @$pb.TagNumber(8)
  set targetId($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasTargetId() => $_has(7);
  @$pb.TagNumber(8)
  void clearTargetId() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get details => $_getSZ(8);
  @$pb.TagNumber(9)
  set details($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasDetails() => $_has(8);
  @$pb.TagNumber(9)
  void clearDetails() => clearField(9);

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

class GetGroupActivityLogsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetGroupActivityLogsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'groupId')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'actionTypeFilter')
    ..hasRequiredFields = false
  ;

  GetGroupActivityLogsRequest._() : super();
  factory GetGroupActivityLogsRequest({
    $core.String? groupId,
    $core.int? page,
    $core.int? pageSize,
    $core.String? actionTypeFilter,
  }) {
    final _result = create();
    if (groupId != null) {
      _result.groupId = groupId;
    }
    if (page != null) {
      _result.page = page;
    }
    if (pageSize != null) {
      _result.pageSize = pageSize;
    }
    if (actionTypeFilter != null) {
      _result.actionTypeFilter = actionTypeFilter;
    }
    return _result;
  }
  factory GetGroupActivityLogsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetGroupActivityLogsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetGroupActivityLogsRequest clone() => GetGroupActivityLogsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetGroupActivityLogsRequest copyWith(void Function(GetGroupActivityLogsRequest) updates) => super.copyWith((message) => updates(message as GetGroupActivityLogsRequest)) as GetGroupActivityLogsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetGroupActivityLogsRequest create() => GetGroupActivityLogsRequest._();
  GetGroupActivityLogsRequest createEmptyInstance() => create();
  static $pb.PbList<GetGroupActivityLogsRequest> createRepeated() => $pb.PbList<GetGroupActivityLogsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetGroupActivityLogsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetGroupActivityLogsRequest>(create);
  static GetGroupActivityLogsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get groupId => $_getSZ(0);
  @$pb.TagNumber(1)
  set groupId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasGroupId() => $_has(0);
  @$pb.TagNumber(1)
  void clearGroupId() => clearField(1);

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

  @$pb.TagNumber(4)
  $core.String get actionTypeFilter => $_getSZ(3);
  @$pb.TagNumber(4)
  set actionTypeFilter($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasActionTypeFilter() => $_has(3);
  @$pb.TagNumber(4)
  void clearActionTypeFilter() => clearField(4);
}

class GetGroupActivityLogsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetGroupActivityLogsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<GroupActivityLogMessage>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'logs', $pb.PbFieldType.PM, subBuilder: GroupActivityLogMessage.create)
    ..aOM<ActivityLogPaginationInfo>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pagination', subBuilder: ActivityLogPaginationInfo.create)
    ..hasRequiredFields = false
  ;

  GetGroupActivityLogsResponse._() : super();
  factory GetGroupActivityLogsResponse({
    $core.Iterable<GroupActivityLogMessage>? logs,
    ActivityLogPaginationInfo? pagination,
  }) {
    final _result = create();
    if (logs != null) {
      _result.logs.addAll(logs);
    }
    if (pagination != null) {
      _result.pagination = pagination;
    }
    return _result;
  }
  factory GetGroupActivityLogsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetGroupActivityLogsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetGroupActivityLogsResponse clone() => GetGroupActivityLogsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetGroupActivityLogsResponse copyWith(void Function(GetGroupActivityLogsResponse) updates) => super.copyWith((message) => updates(message as GetGroupActivityLogsResponse)) as GetGroupActivityLogsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetGroupActivityLogsResponse create() => GetGroupActivityLogsResponse._();
  GetGroupActivityLogsResponse createEmptyInstance() => create();
  static $pb.PbList<GetGroupActivityLogsResponse> createRepeated() => $pb.PbList<GetGroupActivityLogsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetGroupActivityLogsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetGroupActivityLogsResponse>(create);
  static GetGroupActivityLogsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<GroupActivityLogMessage> get logs => $_getList(0);

  @$pb.TagNumber(2)
  ActivityLogPaginationInfo get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination(ActivityLogPaginationInfo v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => clearField(2);
  @$pb.TagNumber(2)
  ActivityLogPaginationInfo ensurePagination() => $_ensure(1);
}

class GetContributionActivityLogsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetContributionActivityLogsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'contributionId')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetContributionActivityLogsRequest._() : super();
  factory GetContributionActivityLogsRequest({
    $core.String? contributionId,
    $core.int? page,
    $core.int? pageSize,
  }) {
    final _result = create();
    if (contributionId != null) {
      _result.contributionId = contributionId;
    }
    if (page != null) {
      _result.page = page;
    }
    if (pageSize != null) {
      _result.pageSize = pageSize;
    }
    return _result;
  }
  factory GetContributionActivityLogsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetContributionActivityLogsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetContributionActivityLogsRequest clone() => GetContributionActivityLogsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetContributionActivityLogsRequest copyWith(void Function(GetContributionActivityLogsRequest) updates) => super.copyWith((message) => updates(message as GetContributionActivityLogsRequest)) as GetContributionActivityLogsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetContributionActivityLogsRequest create() => GetContributionActivityLogsRequest._();
  GetContributionActivityLogsRequest createEmptyInstance() => create();
  static $pb.PbList<GetContributionActivityLogsRequest> createRepeated() => $pb.PbList<GetContributionActivityLogsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetContributionActivityLogsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetContributionActivityLogsRequest>(create);
  static GetContributionActivityLogsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get contributionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set contributionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasContributionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearContributionId() => clearField(1);

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

class GetContributionActivityLogsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetContributionActivityLogsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<GroupActivityLogMessage>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'logs', $pb.PbFieldType.PM, subBuilder: GroupActivityLogMessage.create)
    ..aOM<ActivityLogPaginationInfo>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pagination', subBuilder: ActivityLogPaginationInfo.create)
    ..hasRequiredFields = false
  ;

  GetContributionActivityLogsResponse._() : super();
  factory GetContributionActivityLogsResponse({
    $core.Iterable<GroupActivityLogMessage>? logs,
    ActivityLogPaginationInfo? pagination,
  }) {
    final _result = create();
    if (logs != null) {
      _result.logs.addAll(logs);
    }
    if (pagination != null) {
      _result.pagination = pagination;
    }
    return _result;
  }
  factory GetContributionActivityLogsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetContributionActivityLogsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetContributionActivityLogsResponse clone() => GetContributionActivityLogsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetContributionActivityLogsResponse copyWith(void Function(GetContributionActivityLogsResponse) updates) => super.copyWith((message) => updates(message as GetContributionActivityLogsResponse)) as GetContributionActivityLogsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetContributionActivityLogsResponse create() => GetContributionActivityLogsResponse._();
  GetContributionActivityLogsResponse createEmptyInstance() => create();
  static $pb.PbList<GetContributionActivityLogsResponse> createRepeated() => $pb.PbList<GetContributionActivityLogsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetContributionActivityLogsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetContributionActivityLogsResponse>(create);
  static GetContributionActivityLogsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<GroupActivityLogMessage> get logs => $_getList(0);

  @$pb.TagNumber(2)
  ActivityLogPaginationInfo get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination(ActivityLogPaginationInfo v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => clearField(2);
  @$pb.TagNumber(2)
  ActivityLogPaginationInfo ensurePagination() => $_ensure(1);
}

