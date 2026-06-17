// This is a generated file - do not edit.
//
// Generated from group_account.proto.

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
import 'group_account.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'group_account.pbenum.dart';

class GroupAccountMessage extends $pb.GeneratedMessage {
  factory GroupAccountMessage({
    $core.String? id,
    $core.String? name,
    $core.String? description,
    $fixnum.Int64? adminId,
    GroupAccountStatus? status,
    $1.Timestamp? createdAt,
    $1.Timestamp? updatedAt,
    $core.String? metadata,
    $core.Iterable<GroupMemberMessage>? members,
    $core.Iterable<ContributionMessage>? contributions,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (description != null) result.description = description;
    if (adminId != null) result.adminId = adminId;
    if (status != null) result.status = status;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    if (metadata != null) result.metadata = metadata;
    if (members != null) result.members.addAll(members);
    if (contributions != null) result.contributions.addAll(contributions);
    return result;
  }

  GroupAccountMessage._();

  factory GroupAccountMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GroupAccountMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GroupAccountMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..a<$fixnum.Int64>(4, _omitFieldNames ? '' : 'adminId', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..e<GroupAccountStatus>(
        5, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: GroupAccountStatus.GROUP_ACCOUNT_STATUS_UNSPECIFIED,
        valueOf: GroupAccountStatus.valueOf,
        enumValues: GroupAccountStatus.values)
    ..aOM<$1.Timestamp>(6, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(7, _omitFieldNames ? '' : 'updatedAt',
        subBuilder: $1.Timestamp.create)
    ..aOS(8, _omitFieldNames ? '' : 'metadata')
    ..pc<GroupMemberMessage>(
        9, _omitFieldNames ? '' : 'members', $pb.PbFieldType.PM,
        subBuilder: GroupMemberMessage.create)
    ..pc<ContributionMessage>(
        10, _omitFieldNames ? '' : 'contributions', $pb.PbFieldType.PM,
        subBuilder: ContributionMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GroupAccountMessage clone() => GroupAccountMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GroupAccountMessage copyWith(void Function(GroupAccountMessage) updates) =>
      super.copyWith((message) => updates(message as GroupAccountMessage))
          as GroupAccountMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GroupAccountMessage create() => GroupAccountMessage._();
  @$core.override
  GroupAccountMessage createEmptyInstance() => create();
  static $pb.PbList<GroupAccountMessage> createRepeated() =>
      $pb.PbList<GroupAccountMessage>();
  @$core.pragma('dart2js:noInline')
  static GroupAccountMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GroupAccountMessage>(create);
  static GroupAccountMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get adminId => $_getI64(3);
  @$pb.TagNumber(4)
  set adminId($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAdminId() => $_has(3);
  @$pb.TagNumber(4)
  void clearAdminId() => $_clearField(4);

  @$pb.TagNumber(5)
  GroupAccountStatus get status => $_getN(4);
  @$pb.TagNumber(5)
  set status(GroupAccountStatus value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasStatus() => $_has(4);
  @$pb.TagNumber(5)
  void clearStatus() => $_clearField(5);

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

  @$pb.TagNumber(7)
  $1.Timestamp get updatedAt => $_getN(6);
  @$pb.TagNumber(7)
  set updatedAt($1.Timestamp value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasUpdatedAt() => $_has(6);
  @$pb.TagNumber(7)
  void clearUpdatedAt() => $_clearField(7);
  @$pb.TagNumber(7)
  $1.Timestamp ensureUpdatedAt() => $_ensure(6);

  @$pb.TagNumber(8)
  $core.String get metadata => $_getSZ(7);
  @$pb.TagNumber(8)
  set metadata($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasMetadata() => $_has(7);
  @$pb.TagNumber(8)
  void clearMetadata() => $_clearField(8);

  @$pb.TagNumber(9)
  $pb.PbList<GroupMemberMessage> get members => $_getList(8);

  @$pb.TagNumber(10)
  $pb.PbList<ContributionMessage> get contributions => $_getList(9);
}

class GroupMemberMessage extends $pb.GeneratedMessage {
  factory GroupMemberMessage({
    $core.String? id,
    $core.String? groupId,
    $fixnum.Int64? userId,
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
    final result = create();
    if (id != null) result.id = id;
    if (groupId != null) result.groupId = groupId;
    if (userId != null) result.userId = userId;
    if (userName != null) result.userName = userName;
    if (email != null) result.email = email;
    if (profileImage != null) result.profileImage = profileImage;
    if (role != null) result.role = role;
    if (status != null) result.status = status;
    if (joinedAt != null) result.joinedAt = joinedAt;
    if (permissions != null) result.permissions = permissions;
    if (phoneNumber != null) result.phoneNumber = phoneNumber;
    if (isPartial != null) result.isPartial = isPartial;
    if (userUsername != null) result.userUsername = userUsername;
    return result;
  }

  GroupMemberMessage._();

  factory GroupMemberMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GroupMemberMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GroupMemberMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'groupId')
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'userId', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(4, _omitFieldNames ? '' : 'userName')
    ..aOS(5, _omitFieldNames ? '' : 'email')
    ..aOS(6, _omitFieldNames ? '' : 'profileImage')
    ..e<GroupMemberRole>(7, _omitFieldNames ? '' : 'role', $pb.PbFieldType.OE,
        defaultOrMaker: GroupMemberRole.GROUP_MEMBER_ROLE_UNSPECIFIED,
        valueOf: GroupMemberRole.valueOf,
        enumValues: GroupMemberRole.values)
    ..e<GroupMemberStatus>(
        8, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: GroupMemberStatus.GROUP_MEMBER_STATUS_UNSPECIFIED,
        valueOf: GroupMemberStatus.valueOf,
        enumValues: GroupMemberStatus.values)
    ..aOM<$1.Timestamp>(9, _omitFieldNames ? '' : 'joinedAt',
        subBuilder: $1.Timestamp.create)
    ..aOS(10, _omitFieldNames ? '' : 'permissions')
    ..aOS(11, _omitFieldNames ? '' : 'phoneNumber')
    ..aOB(12, _omitFieldNames ? '' : 'isPartial')
    ..aOS(13, _omitFieldNames ? '' : 'userUsername')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GroupMemberMessage clone() => GroupMemberMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GroupMemberMessage copyWith(void Function(GroupMemberMessage) updates) =>
      super.copyWith((message) => updates(message as GroupMemberMessage))
          as GroupMemberMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GroupMemberMessage create() => GroupMemberMessage._();
  @$core.override
  GroupMemberMessage createEmptyInstance() => create();
  static $pb.PbList<GroupMemberMessage> createRepeated() =>
      $pb.PbList<GroupMemberMessage>();
  @$core.pragma('dart2js:noInline')
  static GroupMemberMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GroupMemberMessage>(create);
  static GroupMemberMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get groupId => $_getSZ(1);
  @$pb.TagNumber(2)
  set groupId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasGroupId() => $_has(1);
  @$pb.TagNumber(2)
  void clearGroupId() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get userId => $_getI64(2);
  @$pb.TagNumber(3)
  set userId($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasUserId() => $_has(2);
  @$pb.TagNumber(3)
  void clearUserId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get userName => $_getSZ(3);
  @$pb.TagNumber(4)
  set userName($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasUserName() => $_has(3);
  @$pb.TagNumber(4)
  void clearUserName() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get email => $_getSZ(4);
  @$pb.TagNumber(5)
  set email($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasEmail() => $_has(4);
  @$pb.TagNumber(5)
  void clearEmail() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get profileImage => $_getSZ(5);
  @$pb.TagNumber(6)
  set profileImage($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasProfileImage() => $_has(5);
  @$pb.TagNumber(6)
  void clearProfileImage() => $_clearField(6);

  @$pb.TagNumber(7)
  GroupMemberRole get role => $_getN(6);
  @$pb.TagNumber(7)
  set role(GroupMemberRole value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasRole() => $_has(6);
  @$pb.TagNumber(7)
  void clearRole() => $_clearField(7);

  @$pb.TagNumber(8)
  GroupMemberStatus get status => $_getN(7);
  @$pb.TagNumber(8)
  set status(GroupMemberStatus value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasStatus() => $_has(7);
  @$pb.TagNumber(8)
  void clearStatus() => $_clearField(8);

  @$pb.TagNumber(9)
  $1.Timestamp get joinedAt => $_getN(8);
  @$pb.TagNumber(9)
  set joinedAt($1.Timestamp value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasJoinedAt() => $_has(8);
  @$pb.TagNumber(9)
  void clearJoinedAt() => $_clearField(9);
  @$pb.TagNumber(9)
  $1.Timestamp ensureJoinedAt() => $_ensure(8);

  @$pb.TagNumber(10)
  $core.String get permissions => $_getSZ(9);
  @$pb.TagNumber(10)
  set permissions($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasPermissions() => $_has(9);
  @$pb.TagNumber(10)
  void clearPermissions() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get phoneNumber => $_getSZ(10);
  @$pb.TagNumber(11)
  set phoneNumber($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasPhoneNumber() => $_has(10);
  @$pb.TagNumber(11)
  void clearPhoneNumber() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.bool get isPartial => $_getBF(11);
  @$pb.TagNumber(12)
  set isPartial($core.bool value) => $_setBool(11, value);
  @$pb.TagNumber(12)
  $core.bool hasIsPartial() => $_has(11);
  @$pb.TagNumber(12)
  void clearIsPartial() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.String get userUsername => $_getSZ(12);
  @$pb.TagNumber(13)
  set userUsername($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasUserUsername() => $_has(12);
  @$pb.TagNumber(13)
  void clearUserUsername() => $_clearField(13);
}

class ContributionMessage extends $pb.GeneratedMessage {
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
    $fixnum.Int64? createdBy,
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
    $fixnum.Int64? currentPayoutRecipient,
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
    final result = create();
    if (id != null) result.id = id;
    if (groupId != null) result.groupId = groupId;
    if (title != null) result.title = title;
    if (description != null) result.description = description;
    if (targetAmount != null) result.targetAmount = targetAmount;
    if (currentAmount != null) result.currentAmount = currentAmount;
    if (currency != null) result.currency = currency;
    if (deadline != null) result.deadline = deadline;
    if (status != null) result.status = status;
    if (createdBy != null) result.createdBy = createdBy;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    if (metadata != null) result.metadata = metadata;
    if (type != null) result.type = type;
    if (frequency != null) result.frequency = frequency;
    if (regularAmount != null) result.regularAmount = regularAmount;
    if (nextPaymentDate != null) result.nextPaymentDate = nextPaymentDate;
    if (startDate != null) result.startDate = startDate;
    if (totalCycles != null) result.totalCycles = totalCycles;
    if (currentCycle != null) result.currentCycle = currentCycle;
    if (currentPayoutRecipient != null)
      result.currentPayoutRecipient = currentPayoutRecipient;
    if (nextPayoutDate != null) result.nextPayoutDate = nextPayoutDate;
    if (autoPayEnabled != null) result.autoPayEnabled = autoPayEnabled;
    if (penaltyAmount != null) result.penaltyAmount = penaltyAmount;
    if (gracePeriodDays != null) result.gracePeriodDays = gracePeriodDays;
    if (allowPartialPayments != null)
      result.allowPartialPayments = allowPartialPayments;
    if (minimumBalance != null) result.minimumBalance = minimumBalance;
    if (payments != null) result.payments.addAll(payments);
    if (payoutSchedule != null) result.payoutSchedule.addAll(payoutSchedule);
    if (payoutHistory != null) result.payoutHistory.addAll(payoutHistory);
    if (members != null) result.members.addAll(members);
    return result;
  }

  ContributionMessage._();

  factory ContributionMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ContributionMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ContributionMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'groupId')
    ..aOS(3, _omitFieldNames ? '' : 'title')
    ..aOS(4, _omitFieldNames ? '' : 'description')
    ..a<$fixnum.Int64>(
        5, _omitFieldNames ? '' : 'targetAmount', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(
        6, _omitFieldNames ? '' : 'currentAmount', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(7, _omitFieldNames ? '' : 'currency')
    ..aOM<$1.Timestamp>(8, _omitFieldNames ? '' : 'deadline',
        subBuilder: $1.Timestamp.create)
    ..e<ContributionStatus>(
        9, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: ContributionStatus.CONTRIBUTION_STATUS_UNSPECIFIED,
        valueOf: ContributionStatus.valueOf,
        enumValues: ContributionStatus.values)
    ..a<$fixnum.Int64>(
        10, _omitFieldNames ? '' : 'createdBy', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<$1.Timestamp>(11, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(12, _omitFieldNames ? '' : 'updatedAt',
        subBuilder: $1.Timestamp.create)
    ..aOS(13, _omitFieldNames ? '' : 'metadata')
    ..e<ContributionType>(14, _omitFieldNames ? '' : 'type', $pb.PbFieldType.OE,
        defaultOrMaker: ContributionType.CONTRIBUTION_TYPE_UNSPECIFIED,
        valueOf: ContributionType.valueOf,
        enumValues: ContributionType.values)
    ..e<ContributionFrequency>(
        15, _omitFieldNames ? '' : 'frequency', $pb.PbFieldType.OE,
        defaultOrMaker:
            ContributionFrequency.CONTRIBUTION_FREQUENCY_UNSPECIFIED,
        valueOf: ContributionFrequency.valueOf,
        enumValues: ContributionFrequency.values)
    ..a<$fixnum.Int64>(
        16, _omitFieldNames ? '' : 'regularAmount', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<$1.Timestamp>(17, _omitFieldNames ? '' : 'nextPaymentDate',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(18, _omitFieldNames ? '' : 'startDate',
        subBuilder: $1.Timestamp.create)
    ..a<$core.int>(19, _omitFieldNames ? '' : 'totalCycles', $pb.PbFieldType.O3)
    ..a<$core.int>(
        20, _omitFieldNames ? '' : 'currentCycle', $pb.PbFieldType.O3)
    ..a<$fixnum.Int64>(21, _omitFieldNames ? '' : 'currentPayoutRecipient',
        $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<$1.Timestamp>(22, _omitFieldNames ? '' : 'nextPayoutDate',
        subBuilder: $1.Timestamp.create)
    ..aOB(23, _omitFieldNames ? '' : 'autoPayEnabled')
    ..a<$fixnum.Int64>(
        24, _omitFieldNames ? '' : 'penaltyAmount', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(
        25, _omitFieldNames ? '' : 'gracePeriodDays', $pb.PbFieldType.O3)
    ..aOB(26, _omitFieldNames ? '' : 'allowPartialPayments')
    ..a<$fixnum.Int64>(
        27, _omitFieldNames ? '' : 'minimumBalance', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..pc<ContributionPaymentMessage>(
        28, _omitFieldNames ? '' : 'payments', $pb.PbFieldType.PM,
        subBuilder: ContributionPaymentMessage.create)
    ..pc<PayoutScheduleMessage>(
        29, _omitFieldNames ? '' : 'payoutSchedule', $pb.PbFieldType.PM,
        subBuilder: PayoutScheduleMessage.create)
    ..pc<PayoutTransactionMessage>(
        30, _omitFieldNames ? '' : 'payoutHistory', $pb.PbFieldType.PM,
        subBuilder: PayoutTransactionMessage.create)
    ..pc<ContributionMemberMessage>(
        31, _omitFieldNames ? '' : 'members', $pb.PbFieldType.PM,
        subBuilder: ContributionMemberMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ContributionMessage clone() => ContributionMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ContributionMessage copyWith(void Function(ContributionMessage) updates) =>
      super.copyWith((message) => updates(message as ContributionMessage))
          as ContributionMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ContributionMessage create() => ContributionMessage._();
  @$core.override
  ContributionMessage createEmptyInstance() => create();
  static $pb.PbList<ContributionMessage> createRepeated() =>
      $pb.PbList<ContributionMessage>();
  @$core.pragma('dart2js:noInline')
  static ContributionMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ContributionMessage>(create);
  static ContributionMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get groupId => $_getSZ(1);
  @$pb.TagNumber(2)
  set groupId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasGroupId() => $_has(1);
  @$pb.TagNumber(2)
  void clearGroupId() => $_clearField(2);

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
  $fixnum.Int64 get targetAmount => $_getI64(4);
  @$pb.TagNumber(5)
  set targetAmount($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTargetAmount() => $_has(4);
  @$pb.TagNumber(5)
  void clearTargetAmount() => $_clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get currentAmount => $_getI64(5);
  @$pb.TagNumber(6)
  set currentAmount($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasCurrentAmount() => $_has(5);
  @$pb.TagNumber(6)
  void clearCurrentAmount() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get currency => $_getSZ(6);
  @$pb.TagNumber(7)
  set currency($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasCurrency() => $_has(6);
  @$pb.TagNumber(7)
  void clearCurrency() => $_clearField(7);

  @$pb.TagNumber(8)
  $1.Timestamp get deadline => $_getN(7);
  @$pb.TagNumber(8)
  set deadline($1.Timestamp value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasDeadline() => $_has(7);
  @$pb.TagNumber(8)
  void clearDeadline() => $_clearField(8);
  @$pb.TagNumber(8)
  $1.Timestamp ensureDeadline() => $_ensure(7);

  @$pb.TagNumber(9)
  ContributionStatus get status => $_getN(8);
  @$pb.TagNumber(9)
  set status(ContributionStatus value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasStatus() => $_has(8);
  @$pb.TagNumber(9)
  void clearStatus() => $_clearField(9);

  @$pb.TagNumber(10)
  $fixnum.Int64 get createdBy => $_getI64(9);
  @$pb.TagNumber(10)
  set createdBy($fixnum.Int64 value) => $_setInt64(9, value);
  @$pb.TagNumber(10)
  $core.bool hasCreatedBy() => $_has(9);
  @$pb.TagNumber(10)
  void clearCreatedBy() => $_clearField(10);

  @$pb.TagNumber(11)
  $1.Timestamp get createdAt => $_getN(10);
  @$pb.TagNumber(11)
  set createdAt($1.Timestamp value) => $_setField(11, value);
  @$pb.TagNumber(11)
  $core.bool hasCreatedAt() => $_has(10);
  @$pb.TagNumber(11)
  void clearCreatedAt() => $_clearField(11);
  @$pb.TagNumber(11)
  $1.Timestamp ensureCreatedAt() => $_ensure(10);

  @$pb.TagNumber(12)
  $1.Timestamp get updatedAt => $_getN(11);
  @$pb.TagNumber(12)
  set updatedAt($1.Timestamp value) => $_setField(12, value);
  @$pb.TagNumber(12)
  $core.bool hasUpdatedAt() => $_has(11);
  @$pb.TagNumber(12)
  void clearUpdatedAt() => $_clearField(12);
  @$pb.TagNumber(12)
  $1.Timestamp ensureUpdatedAt() => $_ensure(11);

  @$pb.TagNumber(13)
  $core.String get metadata => $_getSZ(12);
  @$pb.TagNumber(13)
  set metadata($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasMetadata() => $_has(12);
  @$pb.TagNumber(13)
  void clearMetadata() => $_clearField(13);

  @$pb.TagNumber(14)
  ContributionType get type => $_getN(13);
  @$pb.TagNumber(14)
  set type(ContributionType value) => $_setField(14, value);
  @$pb.TagNumber(14)
  $core.bool hasType() => $_has(13);
  @$pb.TagNumber(14)
  void clearType() => $_clearField(14);

  @$pb.TagNumber(15)
  ContributionFrequency get frequency => $_getN(14);
  @$pb.TagNumber(15)
  set frequency(ContributionFrequency value) => $_setField(15, value);
  @$pb.TagNumber(15)
  $core.bool hasFrequency() => $_has(14);
  @$pb.TagNumber(15)
  void clearFrequency() => $_clearField(15);

  @$pb.TagNumber(16)
  $fixnum.Int64 get regularAmount => $_getI64(15);
  @$pb.TagNumber(16)
  set regularAmount($fixnum.Int64 value) => $_setInt64(15, value);
  @$pb.TagNumber(16)
  $core.bool hasRegularAmount() => $_has(15);
  @$pb.TagNumber(16)
  void clearRegularAmount() => $_clearField(16);

  @$pb.TagNumber(17)
  $1.Timestamp get nextPaymentDate => $_getN(16);
  @$pb.TagNumber(17)
  set nextPaymentDate($1.Timestamp value) => $_setField(17, value);
  @$pb.TagNumber(17)
  $core.bool hasNextPaymentDate() => $_has(16);
  @$pb.TagNumber(17)
  void clearNextPaymentDate() => $_clearField(17);
  @$pb.TagNumber(17)
  $1.Timestamp ensureNextPaymentDate() => $_ensure(16);

  @$pb.TagNumber(18)
  $1.Timestamp get startDate => $_getN(17);
  @$pb.TagNumber(18)
  set startDate($1.Timestamp value) => $_setField(18, value);
  @$pb.TagNumber(18)
  $core.bool hasStartDate() => $_has(17);
  @$pb.TagNumber(18)
  void clearStartDate() => $_clearField(18);
  @$pb.TagNumber(18)
  $1.Timestamp ensureStartDate() => $_ensure(17);

  @$pb.TagNumber(19)
  $core.int get totalCycles => $_getIZ(18);
  @$pb.TagNumber(19)
  set totalCycles($core.int value) => $_setSignedInt32(18, value);
  @$pb.TagNumber(19)
  $core.bool hasTotalCycles() => $_has(18);
  @$pb.TagNumber(19)
  void clearTotalCycles() => $_clearField(19);

  @$pb.TagNumber(20)
  $core.int get currentCycle => $_getIZ(19);
  @$pb.TagNumber(20)
  set currentCycle($core.int value) => $_setSignedInt32(19, value);
  @$pb.TagNumber(20)
  $core.bool hasCurrentCycle() => $_has(19);
  @$pb.TagNumber(20)
  void clearCurrentCycle() => $_clearField(20);

  @$pb.TagNumber(21)
  $fixnum.Int64 get currentPayoutRecipient => $_getI64(20);
  @$pb.TagNumber(21)
  set currentPayoutRecipient($fixnum.Int64 value) => $_setInt64(20, value);
  @$pb.TagNumber(21)
  $core.bool hasCurrentPayoutRecipient() => $_has(20);
  @$pb.TagNumber(21)
  void clearCurrentPayoutRecipient() => $_clearField(21);

  @$pb.TagNumber(22)
  $1.Timestamp get nextPayoutDate => $_getN(21);
  @$pb.TagNumber(22)
  set nextPayoutDate($1.Timestamp value) => $_setField(22, value);
  @$pb.TagNumber(22)
  $core.bool hasNextPayoutDate() => $_has(21);
  @$pb.TagNumber(22)
  void clearNextPayoutDate() => $_clearField(22);
  @$pb.TagNumber(22)
  $1.Timestamp ensureNextPayoutDate() => $_ensure(21);

  @$pb.TagNumber(23)
  $core.bool get autoPayEnabled => $_getBF(22);
  @$pb.TagNumber(23)
  set autoPayEnabled($core.bool value) => $_setBool(22, value);
  @$pb.TagNumber(23)
  $core.bool hasAutoPayEnabled() => $_has(22);
  @$pb.TagNumber(23)
  void clearAutoPayEnabled() => $_clearField(23);

  @$pb.TagNumber(24)
  $fixnum.Int64 get penaltyAmount => $_getI64(23);
  @$pb.TagNumber(24)
  set penaltyAmount($fixnum.Int64 value) => $_setInt64(23, value);
  @$pb.TagNumber(24)
  $core.bool hasPenaltyAmount() => $_has(23);
  @$pb.TagNumber(24)
  void clearPenaltyAmount() => $_clearField(24);

  @$pb.TagNumber(25)
  $core.int get gracePeriodDays => $_getIZ(24);
  @$pb.TagNumber(25)
  set gracePeriodDays($core.int value) => $_setSignedInt32(24, value);
  @$pb.TagNumber(25)
  $core.bool hasGracePeriodDays() => $_has(24);
  @$pb.TagNumber(25)
  void clearGracePeriodDays() => $_clearField(25);

  @$pb.TagNumber(26)
  $core.bool get allowPartialPayments => $_getBF(25);
  @$pb.TagNumber(26)
  set allowPartialPayments($core.bool value) => $_setBool(25, value);
  @$pb.TagNumber(26)
  $core.bool hasAllowPartialPayments() => $_has(25);
  @$pb.TagNumber(26)
  void clearAllowPartialPayments() => $_clearField(26);

  @$pb.TagNumber(27)
  $fixnum.Int64 get minimumBalance => $_getI64(26);
  @$pb.TagNumber(27)
  set minimumBalance($fixnum.Int64 value) => $_setInt64(26, value);
  @$pb.TagNumber(27)
  $core.bool hasMinimumBalance() => $_has(26);
  @$pb.TagNumber(27)
  void clearMinimumBalance() => $_clearField(27);

  @$pb.TagNumber(28)
  $pb.PbList<ContributionPaymentMessage> get payments => $_getList(27);

  @$pb.TagNumber(29)
  $pb.PbList<PayoutScheduleMessage> get payoutSchedule => $_getList(28);

  @$pb.TagNumber(30)
  $pb.PbList<PayoutTransactionMessage> get payoutHistory => $_getList(29);

  @$pb.TagNumber(31)
  $pb.PbList<ContributionMemberMessage> get members => $_getList(30);
}

/// Member assigned to a contribution
class ContributionMemberMessage extends $pb.GeneratedMessage {
  factory ContributionMemberMessage({
    $core.String? id,
    $core.String? contributionId,
    $fixnum.Int64? userId,
    $core.String? userName,
    $core.String? email,
    $core.String? profileImage,
    $1.Timestamp? joinedAt,
    $fixnum.Int64? totalPaid,
    $fixnum.Int64? expectedAmount,
    $core.bool? hasPaidCurrentCycle,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (contributionId != null) result.contributionId = contributionId;
    if (userId != null) result.userId = userId;
    if (userName != null) result.userName = userName;
    if (email != null) result.email = email;
    if (profileImage != null) result.profileImage = profileImage;
    if (joinedAt != null) result.joinedAt = joinedAt;
    if (totalPaid != null) result.totalPaid = totalPaid;
    if (expectedAmount != null) result.expectedAmount = expectedAmount;
    if (hasPaidCurrentCycle != null)
      result.hasPaidCurrentCycle = hasPaidCurrentCycle;
    return result;
  }

  ContributionMemberMessage._();

  factory ContributionMemberMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ContributionMemberMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ContributionMemberMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'contributionId')
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'userId', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(4, _omitFieldNames ? '' : 'userName')
    ..aOS(5, _omitFieldNames ? '' : 'email')
    ..aOS(6, _omitFieldNames ? '' : 'profileImage')
    ..aOM<$1.Timestamp>(7, _omitFieldNames ? '' : 'joinedAt',
        subBuilder: $1.Timestamp.create)
    ..a<$fixnum.Int64>(
        8, _omitFieldNames ? '' : 'totalPaid', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(
        9, _omitFieldNames ? '' : 'expectedAmount', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOB(10, _omitFieldNames ? '' : 'hasPaidCurrentCycle')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ContributionMemberMessage clone() =>
      ContributionMemberMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ContributionMemberMessage copyWith(
          void Function(ContributionMemberMessage) updates) =>
      super.copyWith((message) => updates(message as ContributionMemberMessage))
          as ContributionMemberMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ContributionMemberMessage create() => ContributionMemberMessage._();
  @$core.override
  ContributionMemberMessage createEmptyInstance() => create();
  static $pb.PbList<ContributionMemberMessage> createRepeated() =>
      $pb.PbList<ContributionMemberMessage>();
  @$core.pragma('dart2js:noInline')
  static ContributionMemberMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ContributionMemberMessage>(create);
  static ContributionMemberMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get contributionId => $_getSZ(1);
  @$pb.TagNumber(2)
  set contributionId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasContributionId() => $_has(1);
  @$pb.TagNumber(2)
  void clearContributionId() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get userId => $_getI64(2);
  @$pb.TagNumber(3)
  set userId($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasUserId() => $_has(2);
  @$pb.TagNumber(3)
  void clearUserId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get userName => $_getSZ(3);
  @$pb.TagNumber(4)
  set userName($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasUserName() => $_has(3);
  @$pb.TagNumber(4)
  void clearUserName() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get email => $_getSZ(4);
  @$pb.TagNumber(5)
  set email($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasEmail() => $_has(4);
  @$pb.TagNumber(5)
  void clearEmail() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get profileImage => $_getSZ(5);
  @$pb.TagNumber(6)
  set profileImage($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasProfileImage() => $_has(5);
  @$pb.TagNumber(6)
  void clearProfileImage() => $_clearField(6);

  @$pb.TagNumber(7)
  $1.Timestamp get joinedAt => $_getN(6);
  @$pb.TagNumber(7)
  set joinedAt($1.Timestamp value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasJoinedAt() => $_has(6);
  @$pb.TagNumber(7)
  void clearJoinedAt() => $_clearField(7);
  @$pb.TagNumber(7)
  $1.Timestamp ensureJoinedAt() => $_ensure(6);

  @$pb.TagNumber(8)
  $fixnum.Int64 get totalPaid => $_getI64(7);
  @$pb.TagNumber(8)
  set totalPaid($fixnum.Int64 value) => $_setInt64(7, value);
  @$pb.TagNumber(8)
  $core.bool hasTotalPaid() => $_has(7);
  @$pb.TagNumber(8)
  void clearTotalPaid() => $_clearField(8);

  @$pb.TagNumber(9)
  $fixnum.Int64 get expectedAmount => $_getI64(8);
  @$pb.TagNumber(9)
  set expectedAmount($fixnum.Int64 value) => $_setInt64(8, value);
  @$pb.TagNumber(9)
  $core.bool hasExpectedAmount() => $_has(8);
  @$pb.TagNumber(9)
  void clearExpectedAmount() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.bool get hasPaidCurrentCycle => $_getBF(9);
  @$pb.TagNumber(10)
  set hasPaidCurrentCycle($core.bool value) => $_setBool(9, value);
  @$pb.TagNumber(10)
  $core.bool hasHasPaidCurrentCycle() => $_has(9);
  @$pb.TagNumber(10)
  void clearHasPaidCurrentCycle() => $_clearField(10);
}

class ContributionPaymentMessage extends $pb.GeneratedMessage {
  factory ContributionPaymentMessage({
    $core.String? id,
    $core.String? contributionId,
    $core.String? groupId,
    $fixnum.Int64? userId,
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
    final result = create();
    if (id != null) result.id = id;
    if (contributionId != null) result.contributionId = contributionId;
    if (groupId != null) result.groupId = groupId;
    if (userId != null) result.userId = userId;
    if (userName != null) result.userName = userName;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    if (paymentDate != null) result.paymentDate = paymentDate;
    if (status != null) result.status = status;
    if (transactionId != null) result.transactionId = transactionId;
    if (receiptId != null) result.receiptId = receiptId;
    if (notes != null) result.notes = notes;
    if (metadata != null) result.metadata = metadata;
    return result;
  }

  ContributionPaymentMessage._();

  factory ContributionPaymentMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ContributionPaymentMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ContributionPaymentMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'contributionId')
    ..aOS(3, _omitFieldNames ? '' : 'groupId')
    ..a<$fixnum.Int64>(4, _omitFieldNames ? '' : 'userId', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(5, _omitFieldNames ? '' : 'userName')
    ..a<$fixnum.Int64>(6, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(7, _omitFieldNames ? '' : 'currency')
    ..aOM<$1.Timestamp>(8, _omitFieldNames ? '' : 'paymentDate',
        subBuilder: $1.Timestamp.create)
    ..e<PaymentStatus>(9, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: PaymentStatus.PAYMENT_STATUS_UNSPECIFIED,
        valueOf: PaymentStatus.valueOf,
        enumValues: PaymentStatus.values)
    ..aOS(10, _omitFieldNames ? '' : 'transactionId')
    ..aOS(11, _omitFieldNames ? '' : 'receiptId')
    ..aOS(12, _omitFieldNames ? '' : 'notes')
    ..aOS(13, _omitFieldNames ? '' : 'metadata')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ContributionPaymentMessage clone() =>
      ContributionPaymentMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ContributionPaymentMessage copyWith(
          void Function(ContributionPaymentMessage) updates) =>
      super.copyWith(
              (message) => updates(message as ContributionPaymentMessage))
          as ContributionPaymentMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ContributionPaymentMessage create() => ContributionPaymentMessage._();
  @$core.override
  ContributionPaymentMessage createEmptyInstance() => create();
  static $pb.PbList<ContributionPaymentMessage> createRepeated() =>
      $pb.PbList<ContributionPaymentMessage>();
  @$core.pragma('dart2js:noInline')
  static ContributionPaymentMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ContributionPaymentMessage>(create);
  static ContributionPaymentMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get contributionId => $_getSZ(1);
  @$pb.TagNumber(2)
  set contributionId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasContributionId() => $_has(1);
  @$pb.TagNumber(2)
  void clearContributionId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get groupId => $_getSZ(2);
  @$pb.TagNumber(3)
  set groupId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasGroupId() => $_has(2);
  @$pb.TagNumber(3)
  void clearGroupId() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get userId => $_getI64(3);
  @$pb.TagNumber(4)
  set userId($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasUserId() => $_has(3);
  @$pb.TagNumber(4)
  void clearUserId() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get userName => $_getSZ(4);
  @$pb.TagNumber(5)
  set userName($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasUserName() => $_has(4);
  @$pb.TagNumber(5)
  void clearUserName() => $_clearField(5);

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
  $1.Timestamp get paymentDate => $_getN(7);
  @$pb.TagNumber(8)
  set paymentDate($1.Timestamp value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasPaymentDate() => $_has(7);
  @$pb.TagNumber(8)
  void clearPaymentDate() => $_clearField(8);
  @$pb.TagNumber(8)
  $1.Timestamp ensurePaymentDate() => $_ensure(7);

  @$pb.TagNumber(9)
  PaymentStatus get status => $_getN(8);
  @$pb.TagNumber(9)
  set status(PaymentStatus value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasStatus() => $_has(8);
  @$pb.TagNumber(9)
  void clearStatus() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get transactionId => $_getSZ(9);
  @$pb.TagNumber(10)
  set transactionId($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasTransactionId() => $_has(9);
  @$pb.TagNumber(10)
  void clearTransactionId() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get receiptId => $_getSZ(10);
  @$pb.TagNumber(11)
  set receiptId($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasReceiptId() => $_has(10);
  @$pb.TagNumber(11)
  void clearReceiptId() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get notes => $_getSZ(11);
  @$pb.TagNumber(12)
  set notes($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasNotes() => $_has(11);
  @$pb.TagNumber(12)
  void clearNotes() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.String get metadata => $_getSZ(12);
  @$pb.TagNumber(13)
  set metadata($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasMetadata() => $_has(12);
  @$pb.TagNumber(13)
  void clearMetadata() => $_clearField(13);
}

class PayoutScheduleMessage extends $pb.GeneratedMessage {
  factory PayoutScheduleMessage({
    $core.String? id,
    $fixnum.Int64? userId,
    $core.String? userName,
    $core.int? position,
    $1.Timestamp? scheduledDate,
    $fixnum.Int64? expectedAmount,
    PayoutStatus? status,
    $1.Timestamp? receivedDate,
    $fixnum.Int64? actualAmount,
    $core.String? notes,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (userId != null) result.userId = userId;
    if (userName != null) result.userName = userName;
    if (position != null) result.position = position;
    if (scheduledDate != null) result.scheduledDate = scheduledDate;
    if (expectedAmount != null) result.expectedAmount = expectedAmount;
    if (status != null) result.status = status;
    if (receivedDate != null) result.receivedDate = receivedDate;
    if (actualAmount != null) result.actualAmount = actualAmount;
    if (notes != null) result.notes = notes;
    return result;
  }

  PayoutScheduleMessage._();

  factory PayoutScheduleMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PayoutScheduleMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PayoutScheduleMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'userId', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(3, _omitFieldNames ? '' : 'userName')
    ..a<$core.int>(4, _omitFieldNames ? '' : 'position', $pb.PbFieldType.O3)
    ..aOM<$1.Timestamp>(5, _omitFieldNames ? '' : 'scheduledDate',
        subBuilder: $1.Timestamp.create)
    ..a<$fixnum.Int64>(
        6, _omitFieldNames ? '' : 'expectedAmount', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..e<PayoutStatus>(7, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: PayoutStatus.PAYOUT_STATUS_UNSPECIFIED,
        valueOf: PayoutStatus.valueOf,
        enumValues: PayoutStatus.values)
    ..aOM<$1.Timestamp>(8, _omitFieldNames ? '' : 'receivedDate',
        subBuilder: $1.Timestamp.create)
    ..a<$fixnum.Int64>(
        9, _omitFieldNames ? '' : 'actualAmount', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(10, _omitFieldNames ? '' : 'notes')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PayoutScheduleMessage clone() =>
      PayoutScheduleMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PayoutScheduleMessage copyWith(
          void Function(PayoutScheduleMessage) updates) =>
      super.copyWith((message) => updates(message as PayoutScheduleMessage))
          as PayoutScheduleMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PayoutScheduleMessage create() => PayoutScheduleMessage._();
  @$core.override
  PayoutScheduleMessage createEmptyInstance() => create();
  static $pb.PbList<PayoutScheduleMessage> createRepeated() =>
      $pb.PbList<PayoutScheduleMessage>();
  @$core.pragma('dart2js:noInline')
  static PayoutScheduleMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PayoutScheduleMessage>(create);
  static PayoutScheduleMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get userId => $_getI64(1);
  @$pb.TagNumber(2)
  set userId($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get userName => $_getSZ(2);
  @$pb.TagNumber(3)
  set userName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasUserName() => $_has(2);
  @$pb.TagNumber(3)
  void clearUserName() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get position => $_getIZ(3);
  @$pb.TagNumber(4)
  set position($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPosition() => $_has(3);
  @$pb.TagNumber(4)
  void clearPosition() => $_clearField(4);

  @$pb.TagNumber(5)
  $1.Timestamp get scheduledDate => $_getN(4);
  @$pb.TagNumber(5)
  set scheduledDate($1.Timestamp value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasScheduledDate() => $_has(4);
  @$pb.TagNumber(5)
  void clearScheduledDate() => $_clearField(5);
  @$pb.TagNumber(5)
  $1.Timestamp ensureScheduledDate() => $_ensure(4);

  @$pb.TagNumber(6)
  $fixnum.Int64 get expectedAmount => $_getI64(5);
  @$pb.TagNumber(6)
  set expectedAmount($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasExpectedAmount() => $_has(5);
  @$pb.TagNumber(6)
  void clearExpectedAmount() => $_clearField(6);

  @$pb.TagNumber(7)
  PayoutStatus get status => $_getN(6);
  @$pb.TagNumber(7)
  set status(PayoutStatus value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasStatus() => $_has(6);
  @$pb.TagNumber(7)
  void clearStatus() => $_clearField(7);

  @$pb.TagNumber(8)
  $1.Timestamp get receivedDate => $_getN(7);
  @$pb.TagNumber(8)
  set receivedDate($1.Timestamp value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasReceivedDate() => $_has(7);
  @$pb.TagNumber(8)
  void clearReceivedDate() => $_clearField(8);
  @$pb.TagNumber(8)
  $1.Timestamp ensureReceivedDate() => $_ensure(7);

  @$pb.TagNumber(9)
  $fixnum.Int64 get actualAmount => $_getI64(8);
  @$pb.TagNumber(9)
  set actualAmount($fixnum.Int64 value) => $_setInt64(8, value);
  @$pb.TagNumber(9)
  $core.bool hasActualAmount() => $_has(8);
  @$pb.TagNumber(9)
  void clearActualAmount() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get notes => $_getSZ(9);
  @$pb.TagNumber(10)
  set notes($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasNotes() => $_has(9);
  @$pb.TagNumber(10)
  void clearNotes() => $_clearField(10);
}

class PayoutTransactionMessage extends $pb.GeneratedMessage {
  factory PayoutTransactionMessage({
    $core.String? id,
    $core.String? contributionId,
    $core.String? groupId,
    $fixnum.Int64? recipientUserId,
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
    final result = create();
    if (id != null) result.id = id;
    if (contributionId != null) result.contributionId = contributionId;
    if (groupId != null) result.groupId = groupId;
    if (recipientUserId != null) result.recipientUserId = recipientUserId;
    if (recipientUserName != null) result.recipientUserName = recipientUserName;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    if (payoutDate != null) result.payoutDate = payoutDate;
    if (status != null) result.status = status;
    if (transactionId != null) result.transactionId = transactionId;
    if (paymentMethod != null) result.paymentMethod = paymentMethod;
    if (failureReason != null) result.failureReason = failureReason;
    if (metadata != null) result.metadata = metadata;
    return result;
  }

  PayoutTransactionMessage._();

  factory PayoutTransactionMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PayoutTransactionMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PayoutTransactionMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'contributionId')
    ..aOS(3, _omitFieldNames ? '' : 'groupId')
    ..a<$fixnum.Int64>(
        4, _omitFieldNames ? '' : 'recipientUserId', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(5, _omitFieldNames ? '' : 'recipientUserName')
    ..a<$fixnum.Int64>(6, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(7, _omitFieldNames ? '' : 'currency')
    ..aOM<$1.Timestamp>(8, _omitFieldNames ? '' : 'payoutDate',
        subBuilder: $1.Timestamp.create)
    ..e<PayoutTransactionStatus>(
        9, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker:
            PayoutTransactionStatus.PAYOUT_TRANSACTION_STATUS_UNSPECIFIED,
        valueOf: PayoutTransactionStatus.valueOf,
        enumValues: PayoutTransactionStatus.values)
    ..aOS(10, _omitFieldNames ? '' : 'transactionId')
    ..aOS(11, _omitFieldNames ? '' : 'paymentMethod')
    ..aOS(12, _omitFieldNames ? '' : 'failureReason')
    ..aOS(13, _omitFieldNames ? '' : 'metadata')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PayoutTransactionMessage clone() =>
      PayoutTransactionMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PayoutTransactionMessage copyWith(
          void Function(PayoutTransactionMessage) updates) =>
      super.copyWith((message) => updates(message as PayoutTransactionMessage))
          as PayoutTransactionMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PayoutTransactionMessage create() => PayoutTransactionMessage._();
  @$core.override
  PayoutTransactionMessage createEmptyInstance() => create();
  static $pb.PbList<PayoutTransactionMessage> createRepeated() =>
      $pb.PbList<PayoutTransactionMessage>();
  @$core.pragma('dart2js:noInline')
  static PayoutTransactionMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PayoutTransactionMessage>(create);
  static PayoutTransactionMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get contributionId => $_getSZ(1);
  @$pb.TagNumber(2)
  set contributionId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasContributionId() => $_has(1);
  @$pb.TagNumber(2)
  void clearContributionId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get groupId => $_getSZ(2);
  @$pb.TagNumber(3)
  set groupId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasGroupId() => $_has(2);
  @$pb.TagNumber(3)
  void clearGroupId() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get recipientUserId => $_getI64(3);
  @$pb.TagNumber(4)
  set recipientUserId($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasRecipientUserId() => $_has(3);
  @$pb.TagNumber(4)
  void clearRecipientUserId() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get recipientUserName => $_getSZ(4);
  @$pb.TagNumber(5)
  set recipientUserName($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasRecipientUserName() => $_has(4);
  @$pb.TagNumber(5)
  void clearRecipientUserName() => $_clearField(5);

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
  $1.Timestamp get payoutDate => $_getN(7);
  @$pb.TagNumber(8)
  set payoutDate($1.Timestamp value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasPayoutDate() => $_has(7);
  @$pb.TagNumber(8)
  void clearPayoutDate() => $_clearField(8);
  @$pb.TagNumber(8)
  $1.Timestamp ensurePayoutDate() => $_ensure(7);

  @$pb.TagNumber(9)
  PayoutTransactionStatus get status => $_getN(8);
  @$pb.TagNumber(9)
  set status(PayoutTransactionStatus value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasStatus() => $_has(8);
  @$pb.TagNumber(9)
  void clearStatus() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get transactionId => $_getSZ(9);
  @$pb.TagNumber(10)
  set transactionId($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasTransactionId() => $_has(9);
  @$pb.TagNumber(10)
  void clearTransactionId() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get paymentMethod => $_getSZ(10);
  @$pb.TagNumber(11)
  set paymentMethod($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasPaymentMethod() => $_has(10);
  @$pb.TagNumber(11)
  void clearPaymentMethod() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get failureReason => $_getSZ(11);
  @$pb.TagNumber(12)
  set failureReason($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasFailureReason() => $_has(11);
  @$pb.TagNumber(12)
  void clearFailureReason() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.String get metadata => $_getSZ(12);
  @$pb.TagNumber(13)
  set metadata($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasMetadata() => $_has(12);
  @$pb.TagNumber(13)
  void clearMetadata() => $_clearField(13);
}

class ContributionReceiptMessage extends $pb.GeneratedMessage {
  factory ContributionReceiptMessage({
    $core.String? id,
    $core.String? paymentId,
    $core.String? contributionId,
    $core.String? groupId,
    $fixnum.Int64? userId,
    $core.String? userName,
    $fixnum.Int64? amount,
    $core.String? currency,
    $1.Timestamp? paymentDate,
    $1.Timestamp? generatedAt,
    $core.String? receiptNumber,
    $core.String? receiptData,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (paymentId != null) result.paymentId = paymentId;
    if (contributionId != null) result.contributionId = contributionId;
    if (groupId != null) result.groupId = groupId;
    if (userId != null) result.userId = userId;
    if (userName != null) result.userName = userName;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    if (paymentDate != null) result.paymentDate = paymentDate;
    if (generatedAt != null) result.generatedAt = generatedAt;
    if (receiptNumber != null) result.receiptNumber = receiptNumber;
    if (receiptData != null) result.receiptData = receiptData;
    return result;
  }

  ContributionReceiptMessage._();

  factory ContributionReceiptMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ContributionReceiptMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ContributionReceiptMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'paymentId')
    ..aOS(3, _omitFieldNames ? '' : 'contributionId')
    ..aOS(4, _omitFieldNames ? '' : 'groupId')
    ..a<$fixnum.Int64>(5, _omitFieldNames ? '' : 'userId', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(6, _omitFieldNames ? '' : 'userName')
    ..a<$fixnum.Int64>(7, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(8, _omitFieldNames ? '' : 'currency')
    ..aOM<$1.Timestamp>(9, _omitFieldNames ? '' : 'paymentDate',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(10, _omitFieldNames ? '' : 'generatedAt',
        subBuilder: $1.Timestamp.create)
    ..aOS(11, _omitFieldNames ? '' : 'receiptNumber')
    ..aOS(12, _omitFieldNames ? '' : 'receiptData')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ContributionReceiptMessage clone() =>
      ContributionReceiptMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ContributionReceiptMessage copyWith(
          void Function(ContributionReceiptMessage) updates) =>
      super.copyWith(
              (message) => updates(message as ContributionReceiptMessage))
          as ContributionReceiptMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ContributionReceiptMessage create() => ContributionReceiptMessage._();
  @$core.override
  ContributionReceiptMessage createEmptyInstance() => create();
  static $pb.PbList<ContributionReceiptMessage> createRepeated() =>
      $pb.PbList<ContributionReceiptMessage>();
  @$core.pragma('dart2js:noInline')
  static ContributionReceiptMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ContributionReceiptMessage>(create);
  static ContributionReceiptMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get paymentId => $_getSZ(1);
  @$pb.TagNumber(2)
  set paymentId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPaymentId() => $_has(1);
  @$pb.TagNumber(2)
  void clearPaymentId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get contributionId => $_getSZ(2);
  @$pb.TagNumber(3)
  set contributionId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasContributionId() => $_has(2);
  @$pb.TagNumber(3)
  void clearContributionId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get groupId => $_getSZ(3);
  @$pb.TagNumber(4)
  set groupId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasGroupId() => $_has(3);
  @$pb.TagNumber(4)
  void clearGroupId() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get userId => $_getI64(4);
  @$pb.TagNumber(5)
  set userId($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasUserId() => $_has(4);
  @$pb.TagNumber(5)
  void clearUserId() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get userName => $_getSZ(5);
  @$pb.TagNumber(6)
  set userName($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasUserName() => $_has(5);
  @$pb.TagNumber(6)
  void clearUserName() => $_clearField(6);

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
  $1.Timestamp get paymentDate => $_getN(8);
  @$pb.TagNumber(9)
  set paymentDate($1.Timestamp value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasPaymentDate() => $_has(8);
  @$pb.TagNumber(9)
  void clearPaymentDate() => $_clearField(9);
  @$pb.TagNumber(9)
  $1.Timestamp ensurePaymentDate() => $_ensure(8);

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

class ContributionTranscriptMessage extends $pb.GeneratedMessage {
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
    final result = create();
    if (id != null) result.id = id;
    if (contributionId != null) result.contributionId = contributionId;
    if (groupId != null) result.groupId = groupId;
    if (generatedAt != null) result.generatedAt = generatedAt;
    if (payments != null) result.payments.addAll(payments);
    if (totalAmount != null) result.totalAmount = totalAmount;
    if (currency != null) result.currency = currency;
    if (memberContributions != null)
      result.memberContributions = memberContributions;
    return result;
  }

  ContributionTranscriptMessage._();

  factory ContributionTranscriptMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ContributionTranscriptMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ContributionTranscriptMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'contributionId')
    ..aOS(3, _omitFieldNames ? '' : 'groupId')
    ..aOM<$1.Timestamp>(4, _omitFieldNames ? '' : 'generatedAt',
        subBuilder: $1.Timestamp.create)
    ..pc<ContributionPaymentMessage>(
        5, _omitFieldNames ? '' : 'payments', $pb.PbFieldType.PM,
        subBuilder: ContributionPaymentMessage.create)
    ..a<$fixnum.Int64>(
        6, _omitFieldNames ? '' : 'totalAmount', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(7, _omitFieldNames ? '' : 'currency')
    ..aOS(8, _omitFieldNames ? '' : 'memberContributions')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ContributionTranscriptMessage clone() =>
      ContributionTranscriptMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ContributionTranscriptMessage copyWith(
          void Function(ContributionTranscriptMessage) updates) =>
      super.copyWith(
              (message) => updates(message as ContributionTranscriptMessage))
          as ContributionTranscriptMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ContributionTranscriptMessage create() =>
      ContributionTranscriptMessage._();
  @$core.override
  ContributionTranscriptMessage createEmptyInstance() => create();
  static $pb.PbList<ContributionTranscriptMessage> createRepeated() =>
      $pb.PbList<ContributionTranscriptMessage>();
  @$core.pragma('dart2js:noInline')
  static ContributionTranscriptMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ContributionTranscriptMessage>(create);
  static ContributionTranscriptMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get contributionId => $_getSZ(1);
  @$pb.TagNumber(2)
  set contributionId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasContributionId() => $_has(1);
  @$pb.TagNumber(2)
  void clearContributionId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get groupId => $_getSZ(2);
  @$pb.TagNumber(3)
  set groupId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasGroupId() => $_has(2);
  @$pb.TagNumber(3)
  void clearGroupId() => $_clearField(3);

  @$pb.TagNumber(4)
  $1.Timestamp get generatedAt => $_getN(3);
  @$pb.TagNumber(4)
  set generatedAt($1.Timestamp value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasGeneratedAt() => $_has(3);
  @$pb.TagNumber(4)
  void clearGeneratedAt() => $_clearField(4);
  @$pb.TagNumber(4)
  $1.Timestamp ensureGeneratedAt() => $_ensure(3);

  @$pb.TagNumber(5)
  $pb.PbList<ContributionPaymentMessage> get payments => $_getList(4);

  @$pb.TagNumber(6)
  $fixnum.Int64 get totalAmount => $_getI64(5);
  @$pb.TagNumber(6)
  set totalAmount($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasTotalAmount() => $_has(5);
  @$pb.TagNumber(6)
  void clearTotalAmount() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get currency => $_getSZ(6);
  @$pb.TagNumber(7)
  set currency($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasCurrency() => $_has(6);
  @$pb.TagNumber(7)
  void clearCurrency() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get memberContributions => $_getSZ(7);
  @$pb.TagNumber(8)
  set memberContributions($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasMemberContributions() => $_has(7);
  @$pb.TagNumber(8)
  void clearMemberContributions() => $_clearField(8);
}

class CreateGroupRequest extends $pb.GeneratedMessage {
  factory CreateGroupRequest({
    $core.String? name,
    $core.String? description,
  }) {
    final result = create();
    if (name != null) result.name = name;
    if (description != null) result.description = description;
    return result;
  }

  CreateGroupRequest._();

  factory CreateGroupRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateGroupRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateGroupRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOS(2, _omitFieldNames ? '' : 'description')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateGroupRequest clone() => CreateGroupRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateGroupRequest copyWith(void Function(CreateGroupRequest) updates) =>
      super.copyWith((message) => updates(message as CreateGroupRequest))
          as CreateGroupRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateGroupRequest create() => CreateGroupRequest._();
  @$core.override
  CreateGroupRequest createEmptyInstance() => create();
  static $pb.PbList<CreateGroupRequest> createRepeated() =>
      $pb.PbList<CreateGroupRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateGroupRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateGroupRequest>(create);
  static CreateGroupRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get description => $_getSZ(1);
  @$pb.TagNumber(2)
  set description($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDescription() => $_has(1);
  @$pb.TagNumber(2)
  void clearDescription() => $_clearField(2);
}

class CreateGroupResponse extends $pb.GeneratedMessage {
  factory CreateGroupResponse({
    GroupAccountMessage? group,
  }) {
    final result = create();
    if (group != null) result.group = group;
    return result;
  }

  CreateGroupResponse._();

  factory CreateGroupResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateGroupResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateGroupResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<GroupAccountMessage>(1, _omitFieldNames ? '' : 'group',
        subBuilder: GroupAccountMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateGroupResponse clone() => CreateGroupResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateGroupResponse copyWith(void Function(CreateGroupResponse) updates) =>
      super.copyWith((message) => updates(message as CreateGroupResponse))
          as CreateGroupResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateGroupResponse create() => CreateGroupResponse._();
  @$core.override
  CreateGroupResponse createEmptyInstance() => create();
  static $pb.PbList<CreateGroupResponse> createRepeated() =>
      $pb.PbList<CreateGroupResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateGroupResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateGroupResponse>(create);
  static CreateGroupResponse? _defaultInstance;

  @$pb.TagNumber(1)
  GroupAccountMessage get group => $_getN(0);
  @$pb.TagNumber(1)
  set group(GroupAccountMessage value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasGroup() => $_has(0);
  @$pb.TagNumber(1)
  void clearGroup() => $_clearField(1);
  @$pb.TagNumber(1)
  GroupAccountMessage ensureGroup() => $_ensure(0);
}

class GetGroupRequest extends $pb.GeneratedMessage {
  factory GetGroupRequest({
    $core.String? groupId,
  }) {
    final result = create();
    if (groupId != null) result.groupId = groupId;
    return result;
  }

  GetGroupRequest._();

  factory GetGroupRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetGroupRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetGroupRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'groupId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetGroupRequest clone() => GetGroupRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetGroupRequest copyWith(void Function(GetGroupRequest) updates) =>
      super.copyWith((message) => updates(message as GetGroupRequest))
          as GetGroupRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetGroupRequest create() => GetGroupRequest._();
  @$core.override
  GetGroupRequest createEmptyInstance() => create();
  static $pb.PbList<GetGroupRequest> createRepeated() =>
      $pb.PbList<GetGroupRequest>();
  @$core.pragma('dart2js:noInline')
  static GetGroupRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetGroupRequest>(create);
  static GetGroupRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get groupId => $_getSZ(0);
  @$pb.TagNumber(1)
  set groupId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasGroupId() => $_has(0);
  @$pb.TagNumber(1)
  void clearGroupId() => $_clearField(1);
}

class GetGroupResponse extends $pb.GeneratedMessage {
  factory GetGroupResponse({
    GroupAccountMessage? group,
  }) {
    final result = create();
    if (group != null) result.group = group;
    return result;
  }

  GetGroupResponse._();

  factory GetGroupResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetGroupResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetGroupResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<GroupAccountMessage>(1, _omitFieldNames ? '' : 'group',
        subBuilder: GroupAccountMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetGroupResponse clone() => GetGroupResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetGroupResponse copyWith(void Function(GetGroupResponse) updates) =>
      super.copyWith((message) => updates(message as GetGroupResponse))
          as GetGroupResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetGroupResponse create() => GetGroupResponse._();
  @$core.override
  GetGroupResponse createEmptyInstance() => create();
  static $pb.PbList<GetGroupResponse> createRepeated() =>
      $pb.PbList<GetGroupResponse>();
  @$core.pragma('dart2js:noInline')
  static GetGroupResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetGroupResponse>(create);
  static GetGroupResponse? _defaultInstance;

  @$pb.TagNumber(1)
  GroupAccountMessage get group => $_getN(0);
  @$pb.TagNumber(1)
  set group(GroupAccountMessage value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasGroup() => $_has(0);
  @$pb.TagNumber(1)
  void clearGroup() => $_clearField(1);
  @$pb.TagNumber(1)
  GroupAccountMessage ensureGroup() => $_ensure(0);
}

class ListUserGroupsRequest extends $pb.GeneratedMessage {
  factory ListUserGroupsRequest({
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

  ListUserGroupsRequest._();

  factory ListUserGroupsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListUserGroupsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListUserGroupsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOS(3, _omitFieldNames ? '' : 'status')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListUserGroupsRequest clone() =>
      ListUserGroupsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListUserGroupsRequest copyWith(
          void Function(ListUserGroupsRequest) updates) =>
      super.copyWith((message) => updates(message as ListUserGroupsRequest))
          as ListUserGroupsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListUserGroupsRequest create() => ListUserGroupsRequest._();
  @$core.override
  ListUserGroupsRequest createEmptyInstance() => create();
  static $pb.PbList<ListUserGroupsRequest> createRepeated() =>
      $pb.PbList<ListUserGroupsRequest>();
  @$core.pragma('dart2js:noInline')
  static ListUserGroupsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListUserGroupsRequest>(create);
  static ListUserGroupsRequest? _defaultInstance;

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

class ListUserGroupsResponse extends $pb.GeneratedMessage {
  factory ListUserGroupsResponse({
    $core.Iterable<GroupAccountMessage>? groups,
    GroupPaginationInfo? pagination,
  }) {
    final result = create();
    if (groups != null) result.groups.addAll(groups);
    if (pagination != null) result.pagination = pagination;
    return result;
  }

  ListUserGroupsResponse._();

  factory ListUserGroupsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListUserGroupsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListUserGroupsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<GroupAccountMessage>(
        1, _omitFieldNames ? '' : 'groups', $pb.PbFieldType.PM,
        subBuilder: GroupAccountMessage.create)
    ..aOM<GroupPaginationInfo>(2, _omitFieldNames ? '' : 'pagination',
        subBuilder: GroupPaginationInfo.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListUserGroupsResponse clone() =>
      ListUserGroupsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListUserGroupsResponse copyWith(
          void Function(ListUserGroupsResponse) updates) =>
      super.copyWith((message) => updates(message as ListUserGroupsResponse))
          as ListUserGroupsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListUserGroupsResponse create() => ListUserGroupsResponse._();
  @$core.override
  ListUserGroupsResponse createEmptyInstance() => create();
  static $pb.PbList<ListUserGroupsResponse> createRepeated() =>
      $pb.PbList<ListUserGroupsResponse>();
  @$core.pragma('dart2js:noInline')
  static ListUserGroupsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListUserGroupsResponse>(create);
  static ListUserGroupsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<GroupAccountMessage> get groups => $_getList(0);

  @$pb.TagNumber(2)
  GroupPaginationInfo get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination(GroupPaginationInfo value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => $_clearField(2);
  @$pb.TagNumber(2)
  GroupPaginationInfo ensurePagination() => $_ensure(1);
}

class UpdateGroupRequest extends $pb.GeneratedMessage {
  factory UpdateGroupRequest({
    $core.String? groupId,
    $core.String? name,
    $core.String? description,
    GroupAccountStatus? status,
    $core.String? metadata,
  }) {
    final result = create();
    if (groupId != null) result.groupId = groupId;
    if (name != null) result.name = name;
    if (description != null) result.description = description;
    if (status != null) result.status = status;
    if (metadata != null) result.metadata = metadata;
    return result;
  }

  UpdateGroupRequest._();

  factory UpdateGroupRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateGroupRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateGroupRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'groupId')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..e<GroupAccountStatus>(
        4, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: GroupAccountStatus.GROUP_ACCOUNT_STATUS_UNSPECIFIED,
        valueOf: GroupAccountStatus.valueOf,
        enumValues: GroupAccountStatus.values)
    ..aOS(5, _omitFieldNames ? '' : 'metadata')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateGroupRequest clone() => UpdateGroupRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateGroupRequest copyWith(void Function(UpdateGroupRequest) updates) =>
      super.copyWith((message) => updates(message as UpdateGroupRequest))
          as UpdateGroupRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateGroupRequest create() => UpdateGroupRequest._();
  @$core.override
  UpdateGroupRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateGroupRequest> createRepeated() =>
      $pb.PbList<UpdateGroupRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateGroupRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateGroupRequest>(create);
  static UpdateGroupRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get groupId => $_getSZ(0);
  @$pb.TagNumber(1)
  set groupId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasGroupId() => $_has(0);
  @$pb.TagNumber(1)
  void clearGroupId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => $_clearField(3);

  @$pb.TagNumber(4)
  GroupAccountStatus get status => $_getN(3);
  @$pb.TagNumber(4)
  set status(GroupAccountStatus value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasStatus() => $_has(3);
  @$pb.TagNumber(4)
  void clearStatus() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get metadata => $_getSZ(4);
  @$pb.TagNumber(5)
  set metadata($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasMetadata() => $_has(4);
  @$pb.TagNumber(5)
  void clearMetadata() => $_clearField(5);
}

class UpdateGroupResponse extends $pb.GeneratedMessage {
  factory UpdateGroupResponse({
    GroupAccountMessage? group,
  }) {
    final result = create();
    if (group != null) result.group = group;
    return result;
  }

  UpdateGroupResponse._();

  factory UpdateGroupResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateGroupResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateGroupResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<GroupAccountMessage>(1, _omitFieldNames ? '' : 'group',
        subBuilder: GroupAccountMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateGroupResponse clone() => UpdateGroupResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateGroupResponse copyWith(void Function(UpdateGroupResponse) updates) =>
      super.copyWith((message) => updates(message as UpdateGroupResponse))
          as UpdateGroupResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateGroupResponse create() => UpdateGroupResponse._();
  @$core.override
  UpdateGroupResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateGroupResponse> createRepeated() =>
      $pb.PbList<UpdateGroupResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateGroupResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateGroupResponse>(create);
  static UpdateGroupResponse? _defaultInstance;

  @$pb.TagNumber(1)
  GroupAccountMessage get group => $_getN(0);
  @$pb.TagNumber(1)
  set group(GroupAccountMessage value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasGroup() => $_has(0);
  @$pb.TagNumber(1)
  void clearGroup() => $_clearField(1);
  @$pb.TagNumber(1)
  GroupAccountMessage ensureGroup() => $_ensure(0);
}

class DeleteGroupRequest extends $pb.GeneratedMessage {
  factory DeleteGroupRequest({
    $core.String? groupId,
  }) {
    final result = create();
    if (groupId != null) result.groupId = groupId;
    return result;
  }

  DeleteGroupRequest._();

  factory DeleteGroupRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeleteGroupRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteGroupRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'groupId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteGroupRequest clone() => DeleteGroupRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteGroupRequest copyWith(void Function(DeleteGroupRequest) updates) =>
      super.copyWith((message) => updates(message as DeleteGroupRequest))
          as DeleteGroupRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteGroupRequest create() => DeleteGroupRequest._();
  @$core.override
  DeleteGroupRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteGroupRequest> createRepeated() =>
      $pb.PbList<DeleteGroupRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteGroupRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteGroupRequest>(create);
  static DeleteGroupRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get groupId => $_getSZ(0);
  @$pb.TagNumber(1)
  set groupId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasGroupId() => $_has(0);
  @$pb.TagNumber(1)
  void clearGroupId() => $_clearField(1);
}

class DeleteGroupResponse extends $pb.GeneratedMessage {
  factory DeleteGroupResponse({
    $core.bool? success,
  }) {
    final result = create();
    if (success != null) result.success = success;
    return result;
  }

  DeleteGroupResponse._();

  factory DeleteGroupResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeleteGroupResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteGroupResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteGroupResponse clone() => DeleteGroupResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteGroupResponse copyWith(void Function(DeleteGroupResponse) updates) =>
      super.copyWith((message) => updates(message as DeleteGroupResponse))
          as DeleteGroupResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteGroupResponse create() => DeleteGroupResponse._();
  @$core.override
  DeleteGroupResponse createEmptyInstance() => create();
  static $pb.PbList<DeleteGroupResponse> createRepeated() =>
      $pb.PbList<DeleteGroupResponse>();
  @$core.pragma('dart2js:noInline')
  static DeleteGroupResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteGroupResponse>(create);
  static DeleteGroupResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);
}

class GetGroupMembersRequest extends $pb.GeneratedMessage {
  factory GetGroupMembersRequest({
    $core.String? groupId,
  }) {
    final result = create();
    if (groupId != null) result.groupId = groupId;
    return result;
  }

  GetGroupMembersRequest._();

  factory GetGroupMembersRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetGroupMembersRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetGroupMembersRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'groupId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetGroupMembersRequest clone() =>
      GetGroupMembersRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetGroupMembersRequest copyWith(
          void Function(GetGroupMembersRequest) updates) =>
      super.copyWith((message) => updates(message as GetGroupMembersRequest))
          as GetGroupMembersRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetGroupMembersRequest create() => GetGroupMembersRequest._();
  @$core.override
  GetGroupMembersRequest createEmptyInstance() => create();
  static $pb.PbList<GetGroupMembersRequest> createRepeated() =>
      $pb.PbList<GetGroupMembersRequest>();
  @$core.pragma('dart2js:noInline')
  static GetGroupMembersRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetGroupMembersRequest>(create);
  static GetGroupMembersRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get groupId => $_getSZ(0);
  @$pb.TagNumber(1)
  set groupId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasGroupId() => $_has(0);
  @$pb.TagNumber(1)
  void clearGroupId() => $_clearField(1);
}

class GetGroupMembersResponse extends $pb.GeneratedMessage {
  factory GetGroupMembersResponse({
    $core.Iterable<GroupMemberMessage>? members,
  }) {
    final result = create();
    if (members != null) result.members.addAll(members);
    return result;
  }

  GetGroupMembersResponse._();

  factory GetGroupMembersResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetGroupMembersResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetGroupMembersResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<GroupMemberMessage>(
        1, _omitFieldNames ? '' : 'members', $pb.PbFieldType.PM,
        subBuilder: GroupMemberMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetGroupMembersResponse clone() =>
      GetGroupMembersResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetGroupMembersResponse copyWith(
          void Function(GetGroupMembersResponse) updates) =>
      super.copyWith((message) => updates(message as GetGroupMembersResponse))
          as GetGroupMembersResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetGroupMembersResponse create() => GetGroupMembersResponse._();
  @$core.override
  GetGroupMembersResponse createEmptyInstance() => create();
  static $pb.PbList<GetGroupMembersResponse> createRepeated() =>
      $pb.PbList<GetGroupMembersResponse>();
  @$core.pragma('dart2js:noInline')
  static GetGroupMembersResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetGroupMembersResponse>(create);
  static GetGroupMembersResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<GroupMemberMessage> get members => $_getList(0);
}

class AddMemberRequest extends $pb.GeneratedMessage {
  factory AddMemberRequest({
    $core.String? groupId,
    $fixnum.Int64? userId,
    GroupMemberRole? role,
    $core.String? email,
    $core.String? phoneNumber,
    $core.String? lookupUsername,
  }) {
    final result = create();
    if (groupId != null) result.groupId = groupId;
    if (userId != null) result.userId = userId;
    if (role != null) result.role = role;
    if (email != null) result.email = email;
    if (phoneNumber != null) result.phoneNumber = phoneNumber;
    if (lookupUsername != null) result.lookupUsername = lookupUsername;
    return result;
  }

  AddMemberRequest._();

  factory AddMemberRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AddMemberRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AddMemberRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'groupId')
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'userId', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..e<GroupMemberRole>(3, _omitFieldNames ? '' : 'role', $pb.PbFieldType.OE,
        defaultOrMaker: GroupMemberRole.GROUP_MEMBER_ROLE_UNSPECIFIED,
        valueOf: GroupMemberRole.valueOf,
        enumValues: GroupMemberRole.values)
    ..aOS(4, _omitFieldNames ? '' : 'email')
    ..aOS(5, _omitFieldNames ? '' : 'phoneNumber')
    ..aOS(6, _omitFieldNames ? '' : 'lookupUsername')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddMemberRequest clone() => AddMemberRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddMemberRequest copyWith(void Function(AddMemberRequest) updates) =>
      super.copyWith((message) => updates(message as AddMemberRequest))
          as AddMemberRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddMemberRequest create() => AddMemberRequest._();
  @$core.override
  AddMemberRequest createEmptyInstance() => create();
  static $pb.PbList<AddMemberRequest> createRepeated() =>
      $pb.PbList<AddMemberRequest>();
  @$core.pragma('dart2js:noInline')
  static AddMemberRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AddMemberRequest>(create);
  static AddMemberRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get groupId => $_getSZ(0);
  @$pb.TagNumber(1)
  set groupId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasGroupId() => $_has(0);
  @$pb.TagNumber(1)
  void clearGroupId() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get userId => $_getI64(1);
  @$pb.TagNumber(2)
  set userId($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => $_clearField(2);

  @$pb.TagNumber(3)
  GroupMemberRole get role => $_getN(2);
  @$pb.TagNumber(3)
  set role(GroupMemberRole value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasRole() => $_has(2);
  @$pb.TagNumber(3)
  void clearRole() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get email => $_getSZ(3);
  @$pb.TagNumber(4)
  set email($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasEmail() => $_has(3);
  @$pb.TagNumber(4)
  void clearEmail() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get phoneNumber => $_getSZ(4);
  @$pb.TagNumber(5)
  set phoneNumber($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasPhoneNumber() => $_has(4);
  @$pb.TagNumber(5)
  void clearPhoneNumber() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get lookupUsername => $_getSZ(5);
  @$pb.TagNumber(6)
  set lookupUsername($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasLookupUsername() => $_has(5);
  @$pb.TagNumber(6)
  void clearLookupUsername() => $_clearField(6);
}

class AddMemberResponse extends $pb.GeneratedMessage {
  factory AddMemberResponse({
    GroupMemberMessage? member,
  }) {
    final result = create();
    if (member != null) result.member = member;
    return result;
  }

  AddMemberResponse._();

  factory AddMemberResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AddMemberResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AddMemberResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<GroupMemberMessage>(1, _omitFieldNames ? '' : 'member',
        subBuilder: GroupMemberMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddMemberResponse clone() => AddMemberResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddMemberResponse copyWith(void Function(AddMemberResponse) updates) =>
      super.copyWith((message) => updates(message as AddMemberResponse))
          as AddMemberResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddMemberResponse create() => AddMemberResponse._();
  @$core.override
  AddMemberResponse createEmptyInstance() => create();
  static $pb.PbList<AddMemberResponse> createRepeated() =>
      $pb.PbList<AddMemberResponse>();
  @$core.pragma('dart2js:noInline')
  static AddMemberResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AddMemberResponse>(create);
  static AddMemberResponse? _defaultInstance;

  @$pb.TagNumber(1)
  GroupMemberMessage get member => $_getN(0);
  @$pb.TagNumber(1)
  set member(GroupMemberMessage value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasMember() => $_has(0);
  @$pb.TagNumber(1)
  void clearMember() => $_clearField(1);
  @$pb.TagNumber(1)
  GroupMemberMessage ensureMember() => $_ensure(0);
}

class UpdateMemberRoleRequest extends $pb.GeneratedMessage {
  factory UpdateMemberRoleRequest({
    $core.String? groupId,
    $core.String? memberId,
    GroupMemberRole? newRole,
  }) {
    final result = create();
    if (groupId != null) result.groupId = groupId;
    if (memberId != null) result.memberId = memberId;
    if (newRole != null) result.newRole = newRole;
    return result;
  }

  UpdateMemberRoleRequest._();

  factory UpdateMemberRoleRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateMemberRoleRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateMemberRoleRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'groupId')
    ..aOS(2, _omitFieldNames ? '' : 'memberId')
    ..e<GroupMemberRole>(
        3, _omitFieldNames ? '' : 'newRole', $pb.PbFieldType.OE,
        defaultOrMaker: GroupMemberRole.GROUP_MEMBER_ROLE_UNSPECIFIED,
        valueOf: GroupMemberRole.valueOf,
        enumValues: GroupMemberRole.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateMemberRoleRequest clone() =>
      UpdateMemberRoleRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateMemberRoleRequest copyWith(
          void Function(UpdateMemberRoleRequest) updates) =>
      super.copyWith((message) => updates(message as UpdateMemberRoleRequest))
          as UpdateMemberRoleRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateMemberRoleRequest create() => UpdateMemberRoleRequest._();
  @$core.override
  UpdateMemberRoleRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateMemberRoleRequest> createRepeated() =>
      $pb.PbList<UpdateMemberRoleRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateMemberRoleRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateMemberRoleRequest>(create);
  static UpdateMemberRoleRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get groupId => $_getSZ(0);
  @$pb.TagNumber(1)
  set groupId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasGroupId() => $_has(0);
  @$pb.TagNumber(1)
  void clearGroupId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get memberId => $_getSZ(1);
  @$pb.TagNumber(2)
  set memberId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMemberId() => $_has(1);
  @$pb.TagNumber(2)
  void clearMemberId() => $_clearField(2);

  @$pb.TagNumber(3)
  GroupMemberRole get newRole => $_getN(2);
  @$pb.TagNumber(3)
  set newRole(GroupMemberRole value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasNewRole() => $_has(2);
  @$pb.TagNumber(3)
  void clearNewRole() => $_clearField(3);
}

class UpdateMemberRoleResponse extends $pb.GeneratedMessage {
  factory UpdateMemberRoleResponse({
    GroupMemberMessage? member,
  }) {
    final result = create();
    if (member != null) result.member = member;
    return result;
  }

  UpdateMemberRoleResponse._();

  factory UpdateMemberRoleResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateMemberRoleResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateMemberRoleResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<GroupMemberMessage>(1, _omitFieldNames ? '' : 'member',
        subBuilder: GroupMemberMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateMemberRoleResponse clone() =>
      UpdateMemberRoleResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateMemberRoleResponse copyWith(
          void Function(UpdateMemberRoleResponse) updates) =>
      super.copyWith((message) => updates(message as UpdateMemberRoleResponse))
          as UpdateMemberRoleResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateMemberRoleResponse create() => UpdateMemberRoleResponse._();
  @$core.override
  UpdateMemberRoleResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateMemberRoleResponse> createRepeated() =>
      $pb.PbList<UpdateMemberRoleResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateMemberRoleResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateMemberRoleResponse>(create);
  static UpdateMemberRoleResponse? _defaultInstance;

  @$pb.TagNumber(1)
  GroupMemberMessage get member => $_getN(0);
  @$pb.TagNumber(1)
  set member(GroupMemberMessage value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasMember() => $_has(0);
  @$pb.TagNumber(1)
  void clearMember() => $_clearField(1);
  @$pb.TagNumber(1)
  GroupMemberMessage ensureMember() => $_ensure(0);
}

class RemoveMemberRequest extends $pb.GeneratedMessage {
  factory RemoveMemberRequest({
    $core.String? groupId,
    $core.String? memberId,
  }) {
    final result = create();
    if (groupId != null) result.groupId = groupId;
    if (memberId != null) result.memberId = memberId;
    return result;
  }

  RemoveMemberRequest._();

  factory RemoveMemberRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RemoveMemberRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RemoveMemberRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'groupId')
    ..aOS(2, _omitFieldNames ? '' : 'memberId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RemoveMemberRequest clone() => RemoveMemberRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RemoveMemberRequest copyWith(void Function(RemoveMemberRequest) updates) =>
      super.copyWith((message) => updates(message as RemoveMemberRequest))
          as RemoveMemberRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RemoveMemberRequest create() => RemoveMemberRequest._();
  @$core.override
  RemoveMemberRequest createEmptyInstance() => create();
  static $pb.PbList<RemoveMemberRequest> createRepeated() =>
      $pb.PbList<RemoveMemberRequest>();
  @$core.pragma('dart2js:noInline')
  static RemoveMemberRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RemoveMemberRequest>(create);
  static RemoveMemberRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get groupId => $_getSZ(0);
  @$pb.TagNumber(1)
  set groupId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasGroupId() => $_has(0);
  @$pb.TagNumber(1)
  void clearGroupId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get memberId => $_getSZ(1);
  @$pb.TagNumber(2)
  set memberId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMemberId() => $_has(1);
  @$pb.TagNumber(2)
  void clearMemberId() => $_clearField(2);
}

class RemoveMemberResponse extends $pb.GeneratedMessage {
  factory RemoveMemberResponse({
    $core.bool? success,
  }) {
    final result = create();
    if (success != null) result.success = success;
    return result;
  }

  RemoveMemberResponse._();

  factory RemoveMemberResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RemoveMemberResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RemoveMemberResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RemoveMemberResponse clone() =>
      RemoveMemberResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RemoveMemberResponse copyWith(void Function(RemoveMemberResponse) updates) =>
      super.copyWith((message) => updates(message as RemoveMemberResponse))
          as RemoveMemberResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RemoveMemberResponse create() => RemoveMemberResponse._();
  @$core.override
  RemoveMemberResponse createEmptyInstance() => create();
  static $pb.PbList<RemoveMemberResponse> createRepeated() =>
      $pb.PbList<RemoveMemberResponse>();
  @$core.pragma('dart2js:noInline')
  static RemoveMemberResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RemoveMemberResponse>(create);
  static RemoveMemberResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);
}

class SearchUsersRequest extends $pb.GeneratedMessage {
  factory SearchUsersRequest({
    $core.String? query,
    $core.int? limit,
  }) {
    final result = create();
    if (query != null) result.query = query;
    if (limit != null) result.limit = limit;
    return result;
  }

  SearchUsersRequest._();

  factory SearchUsersRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SearchUsersRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SearchUsersRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'query')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchUsersRequest clone() => SearchUsersRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchUsersRequest copyWith(void Function(SearchUsersRequest) updates) =>
      super.copyWith((message) => updates(message as SearchUsersRequest))
          as SearchUsersRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SearchUsersRequest create() => SearchUsersRequest._();
  @$core.override
  SearchUsersRequest createEmptyInstance() => create();
  static $pb.PbList<SearchUsersRequest> createRepeated() =>
      $pb.PbList<SearchUsersRequest>();
  @$core.pragma('dart2js:noInline')
  static SearchUsersRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SearchUsersRequest>(create);
  static SearchUsersRequest? _defaultInstance;

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

class SearchUsersResponse extends $pb.GeneratedMessage {
  factory SearchUsersResponse({
    $core.Iterable<GroupMemberMessage>? users,
  }) {
    final result = create();
    if (users != null) result.users.addAll(users);
    return result;
  }

  SearchUsersResponse._();

  factory SearchUsersResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SearchUsersResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SearchUsersResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<GroupMemberMessage>(
        1, _omitFieldNames ? '' : 'users', $pb.PbFieldType.PM,
        subBuilder: GroupMemberMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchUsersResponse clone() => SearchUsersResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchUsersResponse copyWith(void Function(SearchUsersResponse) updates) =>
      super.copyWith((message) => updates(message as SearchUsersResponse))
          as SearchUsersResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SearchUsersResponse create() => SearchUsersResponse._();
  @$core.override
  SearchUsersResponse createEmptyInstance() => create();
  static $pb.PbList<SearchUsersResponse> createRepeated() =>
      $pb.PbList<SearchUsersResponse>();
  @$core.pragma('dart2js:noInline')
  static SearchUsersResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SearchUsersResponse>(create);
  static SearchUsersResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<GroupMemberMessage> get users => $_getList(0);
}

class CreateContributionRequest extends $pb.GeneratedMessage {
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
    $core.Iterable<$fixnum.Int64>? memberRotationOrder,
    $core.bool? autoPayEnabled,
    $fixnum.Int64? penaltyAmount,
    $core.int? gracePeriodDays,
    $core.bool? allowPartialPayments,
    $fixnum.Int64? minimumBalance,
  }) {
    final result = create();
    if (groupId != null) result.groupId = groupId;
    if (title != null) result.title = title;
    if (description != null) result.description = description;
    if (targetAmount != null) result.targetAmount = targetAmount;
    if (currency != null) result.currency = currency;
    if (deadline != null) result.deadline = deadline;
    if (type != null) result.type = type;
    if (frequency != null) result.frequency = frequency;
    if (regularAmount != null) result.regularAmount = regularAmount;
    if (startDate != null) result.startDate = startDate;
    if (totalCycles != null) result.totalCycles = totalCycles;
    if (memberRotationOrder != null)
      result.memberRotationOrder.addAll(memberRotationOrder);
    if (autoPayEnabled != null) result.autoPayEnabled = autoPayEnabled;
    if (penaltyAmount != null) result.penaltyAmount = penaltyAmount;
    if (gracePeriodDays != null) result.gracePeriodDays = gracePeriodDays;
    if (allowPartialPayments != null)
      result.allowPartialPayments = allowPartialPayments;
    if (minimumBalance != null) result.minimumBalance = minimumBalance;
    return result;
  }

  CreateContributionRequest._();

  factory CreateContributionRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateContributionRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateContributionRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'groupId')
    ..aOS(2, _omitFieldNames ? '' : 'title')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..a<$fixnum.Int64>(
        4, _omitFieldNames ? '' : 'targetAmount', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(5, _omitFieldNames ? '' : 'currency')
    ..aOM<$1.Timestamp>(6, _omitFieldNames ? '' : 'deadline',
        subBuilder: $1.Timestamp.create)
    ..e<ContributionType>(7, _omitFieldNames ? '' : 'type', $pb.PbFieldType.OE,
        defaultOrMaker: ContributionType.CONTRIBUTION_TYPE_UNSPECIFIED,
        valueOf: ContributionType.valueOf,
        enumValues: ContributionType.values)
    ..e<ContributionFrequency>(
        8, _omitFieldNames ? '' : 'frequency', $pb.PbFieldType.OE,
        defaultOrMaker:
            ContributionFrequency.CONTRIBUTION_FREQUENCY_UNSPECIFIED,
        valueOf: ContributionFrequency.valueOf,
        enumValues: ContributionFrequency.values)
    ..a<$fixnum.Int64>(
        9, _omitFieldNames ? '' : 'regularAmount', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<$1.Timestamp>(10, _omitFieldNames ? '' : 'startDate',
        subBuilder: $1.Timestamp.create)
    ..a<$core.int>(11, _omitFieldNames ? '' : 'totalCycles', $pb.PbFieldType.O3)
    ..p<$fixnum.Int64>(
        12, _omitFieldNames ? '' : 'memberRotationOrder', $pb.PbFieldType.KU6)
    ..aOB(13, _omitFieldNames ? '' : 'autoPayEnabled')
    ..a<$fixnum.Int64>(
        14, _omitFieldNames ? '' : 'penaltyAmount', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(
        15, _omitFieldNames ? '' : 'gracePeriodDays', $pb.PbFieldType.O3)
    ..aOB(16, _omitFieldNames ? '' : 'allowPartialPayments')
    ..a<$fixnum.Int64>(
        17, _omitFieldNames ? '' : 'minimumBalance', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateContributionRequest clone() =>
      CreateContributionRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateContributionRequest copyWith(
          void Function(CreateContributionRequest) updates) =>
      super.copyWith((message) => updates(message as CreateContributionRequest))
          as CreateContributionRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateContributionRequest create() => CreateContributionRequest._();
  @$core.override
  CreateContributionRequest createEmptyInstance() => create();
  static $pb.PbList<CreateContributionRequest> createRepeated() =>
      $pb.PbList<CreateContributionRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateContributionRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateContributionRequest>(create);
  static CreateContributionRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get groupId => $_getSZ(0);
  @$pb.TagNumber(1)
  set groupId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasGroupId() => $_has(0);
  @$pb.TagNumber(1)
  void clearGroupId() => $_clearField(1);

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
  ContributionType get type => $_getN(6);
  @$pb.TagNumber(7)
  set type(ContributionType value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasType() => $_has(6);
  @$pb.TagNumber(7)
  void clearType() => $_clearField(7);

  @$pb.TagNumber(8)
  ContributionFrequency get frequency => $_getN(7);
  @$pb.TagNumber(8)
  set frequency(ContributionFrequency value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasFrequency() => $_has(7);
  @$pb.TagNumber(8)
  void clearFrequency() => $_clearField(8);

  @$pb.TagNumber(9)
  $fixnum.Int64 get regularAmount => $_getI64(8);
  @$pb.TagNumber(9)
  set regularAmount($fixnum.Int64 value) => $_setInt64(8, value);
  @$pb.TagNumber(9)
  $core.bool hasRegularAmount() => $_has(8);
  @$pb.TagNumber(9)
  void clearRegularAmount() => $_clearField(9);

  @$pb.TagNumber(10)
  $1.Timestamp get startDate => $_getN(9);
  @$pb.TagNumber(10)
  set startDate($1.Timestamp value) => $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasStartDate() => $_has(9);
  @$pb.TagNumber(10)
  void clearStartDate() => $_clearField(10);
  @$pb.TagNumber(10)
  $1.Timestamp ensureStartDate() => $_ensure(9);

  @$pb.TagNumber(11)
  $core.int get totalCycles => $_getIZ(10);
  @$pb.TagNumber(11)
  set totalCycles($core.int value) => $_setSignedInt32(10, value);
  @$pb.TagNumber(11)
  $core.bool hasTotalCycles() => $_has(10);
  @$pb.TagNumber(11)
  void clearTotalCycles() => $_clearField(11);

  @$pb.TagNumber(12)
  $pb.PbList<$fixnum.Int64> get memberRotationOrder => $_getList(11);

  @$pb.TagNumber(13)
  $core.bool get autoPayEnabled => $_getBF(12);
  @$pb.TagNumber(13)
  set autoPayEnabled($core.bool value) => $_setBool(12, value);
  @$pb.TagNumber(13)
  $core.bool hasAutoPayEnabled() => $_has(12);
  @$pb.TagNumber(13)
  void clearAutoPayEnabled() => $_clearField(13);

  @$pb.TagNumber(14)
  $fixnum.Int64 get penaltyAmount => $_getI64(13);
  @$pb.TagNumber(14)
  set penaltyAmount($fixnum.Int64 value) => $_setInt64(13, value);
  @$pb.TagNumber(14)
  $core.bool hasPenaltyAmount() => $_has(13);
  @$pb.TagNumber(14)
  void clearPenaltyAmount() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.int get gracePeriodDays => $_getIZ(14);
  @$pb.TagNumber(15)
  set gracePeriodDays($core.int value) => $_setSignedInt32(14, value);
  @$pb.TagNumber(15)
  $core.bool hasGracePeriodDays() => $_has(14);
  @$pb.TagNumber(15)
  void clearGracePeriodDays() => $_clearField(15);

  @$pb.TagNumber(16)
  $core.bool get allowPartialPayments => $_getBF(15);
  @$pb.TagNumber(16)
  set allowPartialPayments($core.bool value) => $_setBool(15, value);
  @$pb.TagNumber(16)
  $core.bool hasAllowPartialPayments() => $_has(15);
  @$pb.TagNumber(16)
  void clearAllowPartialPayments() => $_clearField(16);

  @$pb.TagNumber(17)
  $fixnum.Int64 get minimumBalance => $_getI64(16);
  @$pb.TagNumber(17)
  set minimumBalance($fixnum.Int64 value) => $_setInt64(16, value);
  @$pb.TagNumber(17)
  $core.bool hasMinimumBalance() => $_has(16);
  @$pb.TagNumber(17)
  void clearMinimumBalance() => $_clearField(17);
}

class CreateContributionResponse extends $pb.GeneratedMessage {
  factory CreateContributionResponse({
    ContributionMessage? contribution,
  }) {
    final result = create();
    if (contribution != null) result.contribution = contribution;
    return result;
  }

  CreateContributionResponse._();

  factory CreateContributionResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateContributionResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateContributionResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<ContributionMessage>(1, _omitFieldNames ? '' : 'contribution',
        subBuilder: ContributionMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateContributionResponse clone() =>
      CreateContributionResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateContributionResponse copyWith(
          void Function(CreateContributionResponse) updates) =>
      super.copyWith(
              (message) => updates(message as CreateContributionResponse))
          as CreateContributionResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateContributionResponse create() => CreateContributionResponse._();
  @$core.override
  CreateContributionResponse createEmptyInstance() => create();
  static $pb.PbList<CreateContributionResponse> createRepeated() =>
      $pb.PbList<CreateContributionResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateContributionResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateContributionResponse>(create);
  static CreateContributionResponse? _defaultInstance;

  @$pb.TagNumber(1)
  ContributionMessage get contribution => $_getN(0);
  @$pb.TagNumber(1)
  set contribution(ContributionMessage value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasContribution() => $_has(0);
  @$pb.TagNumber(1)
  void clearContribution() => $_clearField(1);
  @$pb.TagNumber(1)
  ContributionMessage ensureContribution() => $_ensure(0);
}

class GetContributionRequest extends $pb.GeneratedMessage {
  factory GetContributionRequest({
    $core.String? contributionId,
  }) {
    final result = create();
    if (contributionId != null) result.contributionId = contributionId;
    return result;
  }

  GetContributionRequest._();

  factory GetContributionRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetContributionRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetContributionRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'contributionId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetContributionRequest clone() =>
      GetContributionRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetContributionRequest copyWith(
          void Function(GetContributionRequest) updates) =>
      super.copyWith((message) => updates(message as GetContributionRequest))
          as GetContributionRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetContributionRequest create() => GetContributionRequest._();
  @$core.override
  GetContributionRequest createEmptyInstance() => create();
  static $pb.PbList<GetContributionRequest> createRepeated() =>
      $pb.PbList<GetContributionRequest>();
  @$core.pragma('dart2js:noInline')
  static GetContributionRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetContributionRequest>(create);
  static GetContributionRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get contributionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set contributionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasContributionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearContributionId() => $_clearField(1);
}

class GetContributionResponse extends $pb.GeneratedMessage {
  factory GetContributionResponse({
    ContributionMessage? contribution,
  }) {
    final result = create();
    if (contribution != null) result.contribution = contribution;
    return result;
  }

  GetContributionResponse._();

  factory GetContributionResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetContributionResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetContributionResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<ContributionMessage>(1, _omitFieldNames ? '' : 'contribution',
        subBuilder: ContributionMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetContributionResponse clone() =>
      GetContributionResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetContributionResponse copyWith(
          void Function(GetContributionResponse) updates) =>
      super.copyWith((message) => updates(message as GetContributionResponse))
          as GetContributionResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetContributionResponse create() => GetContributionResponse._();
  @$core.override
  GetContributionResponse createEmptyInstance() => create();
  static $pb.PbList<GetContributionResponse> createRepeated() =>
      $pb.PbList<GetContributionResponse>();
  @$core.pragma('dart2js:noInline')
  static GetContributionResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetContributionResponse>(create);
  static GetContributionResponse? _defaultInstance;

  @$pb.TagNumber(1)
  ContributionMessage get contribution => $_getN(0);
  @$pb.TagNumber(1)
  set contribution(ContributionMessage value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasContribution() => $_has(0);
  @$pb.TagNumber(1)
  void clearContribution() => $_clearField(1);
  @$pb.TagNumber(1)
  ContributionMessage ensureContribution() => $_ensure(0);
}

class ListGroupContributionsRequest extends $pb.GeneratedMessage {
  factory ListGroupContributionsRequest({
    $core.String? groupId,
    $core.int? page,
    $core.int? pageSize,
    $core.String? status,
  }) {
    final result = create();
    if (groupId != null) result.groupId = groupId;
    if (page != null) result.page = page;
    if (pageSize != null) result.pageSize = pageSize;
    if (status != null) result.status = status;
    return result;
  }

  ListGroupContributionsRequest._();

  factory ListGroupContributionsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListGroupContributionsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListGroupContributionsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'groupId')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOS(4, _omitFieldNames ? '' : 'status')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListGroupContributionsRequest clone() =>
      ListGroupContributionsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListGroupContributionsRequest copyWith(
          void Function(ListGroupContributionsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as ListGroupContributionsRequest))
          as ListGroupContributionsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListGroupContributionsRequest create() =>
      ListGroupContributionsRequest._();
  @$core.override
  ListGroupContributionsRequest createEmptyInstance() => create();
  static $pb.PbList<ListGroupContributionsRequest> createRepeated() =>
      $pb.PbList<ListGroupContributionsRequest>();
  @$core.pragma('dart2js:noInline')
  static ListGroupContributionsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListGroupContributionsRequest>(create);
  static ListGroupContributionsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get groupId => $_getSZ(0);
  @$pb.TagNumber(1)
  set groupId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasGroupId() => $_has(0);
  @$pb.TagNumber(1)
  void clearGroupId() => $_clearField(1);

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

  @$pb.TagNumber(4)
  $core.String get status => $_getSZ(3);
  @$pb.TagNumber(4)
  set status($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasStatus() => $_has(3);
  @$pb.TagNumber(4)
  void clearStatus() => $_clearField(4);
}

class ListGroupContributionsResponse extends $pb.GeneratedMessage {
  factory ListGroupContributionsResponse({
    $core.Iterable<ContributionMessage>? contributions,
    ContributionPaginationInfo? pagination,
  }) {
    final result = create();
    if (contributions != null) result.contributions.addAll(contributions);
    if (pagination != null) result.pagination = pagination;
    return result;
  }

  ListGroupContributionsResponse._();

  factory ListGroupContributionsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListGroupContributionsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListGroupContributionsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<ContributionMessage>(
        1, _omitFieldNames ? '' : 'contributions', $pb.PbFieldType.PM,
        subBuilder: ContributionMessage.create)
    ..aOM<ContributionPaginationInfo>(2, _omitFieldNames ? '' : 'pagination',
        subBuilder: ContributionPaginationInfo.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListGroupContributionsResponse clone() =>
      ListGroupContributionsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListGroupContributionsResponse copyWith(
          void Function(ListGroupContributionsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as ListGroupContributionsResponse))
          as ListGroupContributionsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListGroupContributionsResponse create() =>
      ListGroupContributionsResponse._();
  @$core.override
  ListGroupContributionsResponse createEmptyInstance() => create();
  static $pb.PbList<ListGroupContributionsResponse> createRepeated() =>
      $pb.PbList<ListGroupContributionsResponse>();
  @$core.pragma('dart2js:noInline')
  static ListGroupContributionsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListGroupContributionsResponse>(create);
  static ListGroupContributionsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<ContributionMessage> get contributions => $_getList(0);

  @$pb.TagNumber(2)
  ContributionPaginationInfo get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination(ContributionPaginationInfo value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => $_clearField(2);
  @$pb.TagNumber(2)
  ContributionPaginationInfo ensurePagination() => $_ensure(1);
}

class UpdateContributionRequest extends $pb.GeneratedMessage {
  factory UpdateContributionRequest({
    $core.String? contributionId,
    $core.String? title,
    $core.String? description,
    $fixnum.Int64? targetAmount,
    $1.Timestamp? deadline,
    ContributionStatus? status,
  }) {
    final result = create();
    if (contributionId != null) result.contributionId = contributionId;
    if (title != null) result.title = title;
    if (description != null) result.description = description;
    if (targetAmount != null) result.targetAmount = targetAmount;
    if (deadline != null) result.deadline = deadline;
    if (status != null) result.status = status;
    return result;
  }

  UpdateContributionRequest._();

  factory UpdateContributionRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateContributionRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateContributionRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'contributionId')
    ..aOS(2, _omitFieldNames ? '' : 'title')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..a<$fixnum.Int64>(
        4, _omitFieldNames ? '' : 'targetAmount', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<$1.Timestamp>(5, _omitFieldNames ? '' : 'deadline',
        subBuilder: $1.Timestamp.create)
    ..e<ContributionStatus>(
        6, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: ContributionStatus.CONTRIBUTION_STATUS_UNSPECIFIED,
        valueOf: ContributionStatus.valueOf,
        enumValues: ContributionStatus.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateContributionRequest clone() =>
      UpdateContributionRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateContributionRequest copyWith(
          void Function(UpdateContributionRequest) updates) =>
      super.copyWith((message) => updates(message as UpdateContributionRequest))
          as UpdateContributionRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateContributionRequest create() => UpdateContributionRequest._();
  @$core.override
  UpdateContributionRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateContributionRequest> createRepeated() =>
      $pb.PbList<UpdateContributionRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateContributionRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateContributionRequest>(create);
  static UpdateContributionRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get contributionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set contributionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasContributionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearContributionId() => $_clearField(1);

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
  $fixnum.Int64 get targetAmount => $_getI64(3);
  @$pb.TagNumber(4)
  set targetAmount($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTargetAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearTargetAmount() => $_clearField(4);

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
  ContributionStatus get status => $_getN(5);
  @$pb.TagNumber(6)
  set status(ContributionStatus value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasStatus() => $_has(5);
  @$pb.TagNumber(6)
  void clearStatus() => $_clearField(6);
}

class UpdateContributionResponse extends $pb.GeneratedMessage {
  factory UpdateContributionResponse({
    ContributionMessage? contribution,
  }) {
    final result = create();
    if (contribution != null) result.contribution = contribution;
    return result;
  }

  UpdateContributionResponse._();

  factory UpdateContributionResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateContributionResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateContributionResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<ContributionMessage>(1, _omitFieldNames ? '' : 'contribution',
        subBuilder: ContributionMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateContributionResponse clone() =>
      UpdateContributionResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateContributionResponse copyWith(
          void Function(UpdateContributionResponse) updates) =>
      super.copyWith(
              (message) => updates(message as UpdateContributionResponse))
          as UpdateContributionResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateContributionResponse create() => UpdateContributionResponse._();
  @$core.override
  UpdateContributionResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateContributionResponse> createRepeated() =>
      $pb.PbList<UpdateContributionResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateContributionResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateContributionResponse>(create);
  static UpdateContributionResponse? _defaultInstance;

  @$pb.TagNumber(1)
  ContributionMessage get contribution => $_getN(0);
  @$pb.TagNumber(1)
  set contribution(ContributionMessage value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasContribution() => $_has(0);
  @$pb.TagNumber(1)
  void clearContribution() => $_clearField(1);
  @$pb.TagNumber(1)
  ContributionMessage ensureContribution() => $_ensure(0);
}

class DeleteContributionRequest extends $pb.GeneratedMessage {
  factory DeleteContributionRequest({
    $core.String? contributionId,
  }) {
    final result = create();
    if (contributionId != null) result.contributionId = contributionId;
    return result;
  }

  DeleteContributionRequest._();

  factory DeleteContributionRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeleteContributionRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteContributionRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'contributionId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteContributionRequest clone() =>
      DeleteContributionRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteContributionRequest copyWith(
          void Function(DeleteContributionRequest) updates) =>
      super.copyWith((message) => updates(message as DeleteContributionRequest))
          as DeleteContributionRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteContributionRequest create() => DeleteContributionRequest._();
  @$core.override
  DeleteContributionRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteContributionRequest> createRepeated() =>
      $pb.PbList<DeleteContributionRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteContributionRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteContributionRequest>(create);
  static DeleteContributionRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get contributionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set contributionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasContributionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearContributionId() => $_clearField(1);
}

class DeleteContributionResponse extends $pb.GeneratedMessage {
  factory DeleteContributionResponse({
    $core.bool? success,
  }) {
    final result = create();
    if (success != null) result.success = success;
    return result;
  }

  DeleteContributionResponse._();

  factory DeleteContributionResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeleteContributionResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteContributionResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteContributionResponse clone() =>
      DeleteContributionResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteContributionResponse copyWith(
          void Function(DeleteContributionResponse) updates) =>
      super.copyWith(
              (message) => updates(message as DeleteContributionResponse))
          as DeleteContributionResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteContributionResponse create() => DeleteContributionResponse._();
  @$core.override
  DeleteContributionResponse createEmptyInstance() => create();
  static $pb.PbList<DeleteContributionResponse> createRepeated() =>
      $pb.PbList<DeleteContributionResponse>();
  @$core.pragma('dart2js:noInline')
  static DeleteContributionResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteContributionResponse>(create);
  static DeleteContributionResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);
}

class AddMembersToContributionRequest extends $pb.GeneratedMessage {
  factory AddMembersToContributionRequest({
    $core.String? contributionId,
    $core.Iterable<$core.String>? memberUserIds,
  }) {
    final result = create();
    if (contributionId != null) result.contributionId = contributionId;
    if (memberUserIds != null) result.memberUserIds.addAll(memberUserIds);
    return result;
  }

  AddMembersToContributionRequest._();

  factory AddMembersToContributionRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AddMembersToContributionRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AddMembersToContributionRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'contributionId')
    ..pPS(2, _omitFieldNames ? '' : 'memberUserIds')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddMembersToContributionRequest clone() =>
      AddMembersToContributionRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddMembersToContributionRequest copyWith(
          void Function(AddMembersToContributionRequest) updates) =>
      super.copyWith(
              (message) => updates(message as AddMembersToContributionRequest))
          as AddMembersToContributionRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddMembersToContributionRequest create() =>
      AddMembersToContributionRequest._();
  @$core.override
  AddMembersToContributionRequest createEmptyInstance() => create();
  static $pb.PbList<AddMembersToContributionRequest> createRepeated() =>
      $pb.PbList<AddMembersToContributionRequest>();
  @$core.pragma('dart2js:noInline')
  static AddMembersToContributionRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AddMembersToContributionRequest>(
          create);
  static AddMembersToContributionRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get contributionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set contributionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasContributionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearContributionId() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<$core.String> get memberUserIds => $_getList(1);
}

class AddMembersToContributionResponse extends $pb.GeneratedMessage {
  factory AddMembersToContributionResponse({
    ContributionMessage? contribution,
    $core.Iterable<ContributionMemberMessage>? addedMembers,
  }) {
    final result = create();
    if (contribution != null) result.contribution = contribution;
    if (addedMembers != null) result.addedMembers.addAll(addedMembers);
    return result;
  }

  AddMembersToContributionResponse._();

  factory AddMembersToContributionResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AddMembersToContributionResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AddMembersToContributionResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<ContributionMessage>(1, _omitFieldNames ? '' : 'contribution',
        subBuilder: ContributionMessage.create)
    ..pc<ContributionMemberMessage>(
        2, _omitFieldNames ? '' : 'addedMembers', $pb.PbFieldType.PM,
        subBuilder: ContributionMemberMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddMembersToContributionResponse clone() =>
      AddMembersToContributionResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddMembersToContributionResponse copyWith(
          void Function(AddMembersToContributionResponse) updates) =>
      super.copyWith(
              (message) => updates(message as AddMembersToContributionResponse))
          as AddMembersToContributionResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddMembersToContributionResponse create() =>
      AddMembersToContributionResponse._();
  @$core.override
  AddMembersToContributionResponse createEmptyInstance() => create();
  static $pb.PbList<AddMembersToContributionResponse> createRepeated() =>
      $pb.PbList<AddMembersToContributionResponse>();
  @$core.pragma('dart2js:noInline')
  static AddMembersToContributionResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AddMembersToContributionResponse>(
          create);
  static AddMembersToContributionResponse? _defaultInstance;

  @$pb.TagNumber(1)
  ContributionMessage get contribution => $_getN(0);
  @$pb.TagNumber(1)
  set contribution(ContributionMessage value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasContribution() => $_has(0);
  @$pb.TagNumber(1)
  void clearContribution() => $_clearField(1);
  @$pb.TagNumber(1)
  ContributionMessage ensureContribution() => $_ensure(0);

  @$pb.TagNumber(2)
  $pb.PbList<ContributionMemberMessage> get addedMembers => $_getList(1);
}

class RemoveMemberFromContributionRequest extends $pb.GeneratedMessage {
  factory RemoveMemberFromContributionRequest({
    $core.String? contributionId,
    $core.String? memberUserId,
  }) {
    final result = create();
    if (contributionId != null) result.contributionId = contributionId;
    if (memberUserId != null) result.memberUserId = memberUserId;
    return result;
  }

  RemoveMemberFromContributionRequest._();

  factory RemoveMemberFromContributionRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RemoveMemberFromContributionRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RemoveMemberFromContributionRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'contributionId')
    ..aOS(2, _omitFieldNames ? '' : 'memberUserId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RemoveMemberFromContributionRequest clone() =>
      RemoveMemberFromContributionRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RemoveMemberFromContributionRequest copyWith(
          void Function(RemoveMemberFromContributionRequest) updates) =>
      super.copyWith((message) =>
              updates(message as RemoveMemberFromContributionRequest))
          as RemoveMemberFromContributionRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RemoveMemberFromContributionRequest create() =>
      RemoveMemberFromContributionRequest._();
  @$core.override
  RemoveMemberFromContributionRequest createEmptyInstance() => create();
  static $pb.PbList<RemoveMemberFromContributionRequest> createRepeated() =>
      $pb.PbList<RemoveMemberFromContributionRequest>();
  @$core.pragma('dart2js:noInline')
  static RemoveMemberFromContributionRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          RemoveMemberFromContributionRequest>(create);
  static RemoveMemberFromContributionRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get contributionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set contributionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasContributionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearContributionId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get memberUserId => $_getSZ(1);
  @$pb.TagNumber(2)
  set memberUserId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMemberUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearMemberUserId() => $_clearField(2);
}

class RemoveMemberFromContributionResponse extends $pb.GeneratedMessage {
  factory RemoveMemberFromContributionResponse({
    $core.bool? success,
  }) {
    final result = create();
    if (success != null) result.success = success;
    return result;
  }

  RemoveMemberFromContributionResponse._();

  factory RemoveMemberFromContributionResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RemoveMemberFromContributionResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RemoveMemberFromContributionResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RemoveMemberFromContributionResponse clone() =>
      RemoveMemberFromContributionResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RemoveMemberFromContributionResponse copyWith(
          void Function(RemoveMemberFromContributionResponse) updates) =>
      super.copyWith((message) =>
              updates(message as RemoveMemberFromContributionResponse))
          as RemoveMemberFromContributionResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RemoveMemberFromContributionResponse create() =>
      RemoveMemberFromContributionResponse._();
  @$core.override
  RemoveMemberFromContributionResponse createEmptyInstance() => create();
  static $pb.PbList<RemoveMemberFromContributionResponse> createRepeated() =>
      $pb.PbList<RemoveMemberFromContributionResponse>();
  @$core.pragma('dart2js:noInline')
  static RemoveMemberFromContributionResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          RemoveMemberFromContributionResponse>(create);
  static RemoveMemberFromContributionResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);
}

class GetContributionMembersRequest extends $pb.GeneratedMessage {
  factory GetContributionMembersRequest({
    $core.String? contributionId,
  }) {
    final result = create();
    if (contributionId != null) result.contributionId = contributionId;
    return result;
  }

  GetContributionMembersRequest._();

  factory GetContributionMembersRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetContributionMembersRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetContributionMembersRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'contributionId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetContributionMembersRequest clone() =>
      GetContributionMembersRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetContributionMembersRequest copyWith(
          void Function(GetContributionMembersRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetContributionMembersRequest))
          as GetContributionMembersRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetContributionMembersRequest create() =>
      GetContributionMembersRequest._();
  @$core.override
  GetContributionMembersRequest createEmptyInstance() => create();
  static $pb.PbList<GetContributionMembersRequest> createRepeated() =>
      $pb.PbList<GetContributionMembersRequest>();
  @$core.pragma('dart2js:noInline')
  static GetContributionMembersRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetContributionMembersRequest>(create);
  static GetContributionMembersRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get contributionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set contributionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasContributionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearContributionId() => $_clearField(1);
}

class GetContributionMembersResponse extends $pb.GeneratedMessage {
  factory GetContributionMembersResponse({
    $core.Iterable<ContributionMemberMessage>? members,
  }) {
    final result = create();
    if (members != null) result.members.addAll(members);
    return result;
  }

  GetContributionMembersResponse._();

  factory GetContributionMembersResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetContributionMembersResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetContributionMembersResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<ContributionMemberMessage>(
        1, _omitFieldNames ? '' : 'members', $pb.PbFieldType.PM,
        subBuilder: ContributionMemberMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetContributionMembersResponse clone() =>
      GetContributionMembersResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetContributionMembersResponse copyWith(
          void Function(GetContributionMembersResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetContributionMembersResponse))
          as GetContributionMembersResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetContributionMembersResponse create() =>
      GetContributionMembersResponse._();
  @$core.override
  GetContributionMembersResponse createEmptyInstance() => create();
  static $pb.PbList<GetContributionMembersResponse> createRepeated() =>
      $pb.PbList<GetContributionMembersResponse>();
  @$core.pragma('dart2js:noInline')
  static GetContributionMembersResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetContributionMembersResponse>(create);
  static GetContributionMembersResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<ContributionMemberMessage> get members => $_getList(0);
}

class MakePaymentRequest extends $pb.GeneratedMessage {
  factory MakePaymentRequest({
    $core.String? contributionId,
    $fixnum.Int64? amount,
    $core.String? notes,
  }) {
    final result = create();
    if (contributionId != null) result.contributionId = contributionId;
    if (amount != null) result.amount = amount;
    if (notes != null) result.notes = notes;
    return result;
  }

  MakePaymentRequest._();

  factory MakePaymentRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MakePaymentRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MakePaymentRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'contributionId')
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(3, _omitFieldNames ? '' : 'notes')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MakePaymentRequest clone() => MakePaymentRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MakePaymentRequest copyWith(void Function(MakePaymentRequest) updates) =>
      super.copyWith((message) => updates(message as MakePaymentRequest))
          as MakePaymentRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MakePaymentRequest create() => MakePaymentRequest._();
  @$core.override
  MakePaymentRequest createEmptyInstance() => create();
  static $pb.PbList<MakePaymentRequest> createRepeated() =>
      $pb.PbList<MakePaymentRequest>();
  @$core.pragma('dart2js:noInline')
  static MakePaymentRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MakePaymentRequest>(create);
  static MakePaymentRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get contributionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set contributionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasContributionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearContributionId() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get amount => $_getI64(1);
  @$pb.TagNumber(2)
  set amount($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get notes => $_getSZ(2);
  @$pb.TagNumber(3)
  set notes($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasNotes() => $_has(2);
  @$pb.TagNumber(3)
  void clearNotes() => $_clearField(3);
}

class MakePaymentResponse extends $pb.GeneratedMessage {
  factory MakePaymentResponse({
    ContributionPaymentMessage? payment,
  }) {
    final result = create();
    if (payment != null) result.payment = payment;
    return result;
  }

  MakePaymentResponse._();

  factory MakePaymentResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MakePaymentResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MakePaymentResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<ContributionPaymentMessage>(1, _omitFieldNames ? '' : 'payment',
        subBuilder: ContributionPaymentMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MakePaymentResponse clone() => MakePaymentResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MakePaymentResponse copyWith(void Function(MakePaymentResponse) updates) =>
      super.copyWith((message) => updates(message as MakePaymentResponse))
          as MakePaymentResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MakePaymentResponse create() => MakePaymentResponse._();
  @$core.override
  MakePaymentResponse createEmptyInstance() => create();
  static $pb.PbList<MakePaymentResponse> createRepeated() =>
      $pb.PbList<MakePaymentResponse>();
  @$core.pragma('dart2js:noInline')
  static MakePaymentResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MakePaymentResponse>(create);
  static MakePaymentResponse? _defaultInstance;

  @$pb.TagNumber(1)
  ContributionPaymentMessage get payment => $_getN(0);
  @$pb.TagNumber(1)
  set payment(ContributionPaymentMessage value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasPayment() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayment() => $_clearField(1);
  @$pb.TagNumber(1)
  ContributionPaymentMessage ensurePayment() => $_ensure(0);
}

class GetContributionPaymentsRequest extends $pb.GeneratedMessage {
  factory GetContributionPaymentsRequest({
    $core.String? contributionId,
    $core.int? page,
    $core.int? pageSize,
  }) {
    final result = create();
    if (contributionId != null) result.contributionId = contributionId;
    if (page != null) result.page = page;
    if (pageSize != null) result.pageSize = pageSize;
    return result;
  }

  GetContributionPaymentsRequest._();

  factory GetContributionPaymentsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetContributionPaymentsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetContributionPaymentsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'contributionId')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetContributionPaymentsRequest clone() =>
      GetContributionPaymentsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetContributionPaymentsRequest copyWith(
          void Function(GetContributionPaymentsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetContributionPaymentsRequest))
          as GetContributionPaymentsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetContributionPaymentsRequest create() =>
      GetContributionPaymentsRequest._();
  @$core.override
  GetContributionPaymentsRequest createEmptyInstance() => create();
  static $pb.PbList<GetContributionPaymentsRequest> createRepeated() =>
      $pb.PbList<GetContributionPaymentsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetContributionPaymentsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetContributionPaymentsRequest>(create);
  static GetContributionPaymentsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get contributionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set contributionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasContributionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearContributionId() => $_clearField(1);

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

class GetContributionPaymentsResponse extends $pb.GeneratedMessage {
  factory GetContributionPaymentsResponse({
    $core.Iterable<ContributionPaymentMessage>? payments,
    PaymentPaginationInfo? pagination,
  }) {
    final result = create();
    if (payments != null) result.payments.addAll(payments);
    if (pagination != null) result.pagination = pagination;
    return result;
  }

  GetContributionPaymentsResponse._();

  factory GetContributionPaymentsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetContributionPaymentsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetContributionPaymentsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<ContributionPaymentMessage>(
        1, _omitFieldNames ? '' : 'payments', $pb.PbFieldType.PM,
        subBuilder: ContributionPaymentMessage.create)
    ..aOM<PaymentPaginationInfo>(2, _omitFieldNames ? '' : 'pagination',
        subBuilder: PaymentPaginationInfo.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetContributionPaymentsResponse clone() =>
      GetContributionPaymentsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetContributionPaymentsResponse copyWith(
          void Function(GetContributionPaymentsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetContributionPaymentsResponse))
          as GetContributionPaymentsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetContributionPaymentsResponse create() =>
      GetContributionPaymentsResponse._();
  @$core.override
  GetContributionPaymentsResponse createEmptyInstance() => create();
  static $pb.PbList<GetContributionPaymentsResponse> createRepeated() =>
      $pb.PbList<GetContributionPaymentsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetContributionPaymentsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetContributionPaymentsResponse>(
          create);
  static GetContributionPaymentsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<ContributionPaymentMessage> get payments => $_getList(0);

  @$pb.TagNumber(2)
  PaymentPaginationInfo get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination(PaymentPaginationInfo value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => $_clearField(2);
  @$pb.TagNumber(2)
  PaymentPaginationInfo ensurePagination() => $_ensure(1);
}

class UpdatePaymentStatusRequest extends $pb.GeneratedMessage {
  factory UpdatePaymentStatusRequest({
    $core.String? paymentId,
    PaymentStatus? status,
    $core.String? transactionId,
  }) {
    final result = create();
    if (paymentId != null) result.paymentId = paymentId;
    if (status != null) result.status = status;
    if (transactionId != null) result.transactionId = transactionId;
    return result;
  }

  UpdatePaymentStatusRequest._();

  factory UpdatePaymentStatusRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdatePaymentStatusRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdatePaymentStatusRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'paymentId')
    ..e<PaymentStatus>(2, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: PaymentStatus.PAYMENT_STATUS_UNSPECIFIED,
        valueOf: PaymentStatus.valueOf,
        enumValues: PaymentStatus.values)
    ..aOS(3, _omitFieldNames ? '' : 'transactionId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdatePaymentStatusRequest clone() =>
      UpdatePaymentStatusRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdatePaymentStatusRequest copyWith(
          void Function(UpdatePaymentStatusRequest) updates) =>
      super.copyWith(
              (message) => updates(message as UpdatePaymentStatusRequest))
          as UpdatePaymentStatusRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdatePaymentStatusRequest create() => UpdatePaymentStatusRequest._();
  @$core.override
  UpdatePaymentStatusRequest createEmptyInstance() => create();
  static $pb.PbList<UpdatePaymentStatusRequest> createRepeated() =>
      $pb.PbList<UpdatePaymentStatusRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdatePaymentStatusRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdatePaymentStatusRequest>(create);
  static UpdatePaymentStatusRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get paymentId => $_getSZ(0);
  @$pb.TagNumber(1)
  set paymentId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPaymentId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPaymentId() => $_clearField(1);

  @$pb.TagNumber(2)
  PaymentStatus get status => $_getN(1);
  @$pb.TagNumber(2)
  set status(PaymentStatus value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get transactionId => $_getSZ(2);
  @$pb.TagNumber(3)
  set transactionId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTransactionId() => $_has(2);
  @$pb.TagNumber(3)
  void clearTransactionId() => $_clearField(3);
}

class UpdatePaymentStatusResponse extends $pb.GeneratedMessage {
  factory UpdatePaymentStatusResponse({
    ContributionPaymentMessage? payment,
  }) {
    final result = create();
    if (payment != null) result.payment = payment;
    return result;
  }

  UpdatePaymentStatusResponse._();

  factory UpdatePaymentStatusResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdatePaymentStatusResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdatePaymentStatusResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<ContributionPaymentMessage>(1, _omitFieldNames ? '' : 'payment',
        subBuilder: ContributionPaymentMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdatePaymentStatusResponse clone() =>
      UpdatePaymentStatusResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdatePaymentStatusResponse copyWith(
          void Function(UpdatePaymentStatusResponse) updates) =>
      super.copyWith(
              (message) => updates(message as UpdatePaymentStatusResponse))
          as UpdatePaymentStatusResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdatePaymentStatusResponse create() =>
      UpdatePaymentStatusResponse._();
  @$core.override
  UpdatePaymentStatusResponse createEmptyInstance() => create();
  static $pb.PbList<UpdatePaymentStatusResponse> createRepeated() =>
      $pb.PbList<UpdatePaymentStatusResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdatePaymentStatusResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdatePaymentStatusResponse>(create);
  static UpdatePaymentStatusResponse? _defaultInstance;

  @$pb.TagNumber(1)
  ContributionPaymentMessage get payment => $_getN(0);
  @$pb.TagNumber(1)
  set payment(ContributionPaymentMessage value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasPayment() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayment() => $_clearField(1);
  @$pb.TagNumber(1)
  ContributionPaymentMessage ensurePayment() => $_ensure(0);
}

class ProcessScheduledPaymentsRequest extends $pb.GeneratedMessage {
  factory ProcessScheduledPaymentsRequest({
    $core.String? contributionId,
  }) {
    final result = create();
    if (contributionId != null) result.contributionId = contributionId;
    return result;
  }

  ProcessScheduledPaymentsRequest._();

  factory ProcessScheduledPaymentsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ProcessScheduledPaymentsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ProcessScheduledPaymentsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'contributionId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProcessScheduledPaymentsRequest clone() =>
      ProcessScheduledPaymentsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProcessScheduledPaymentsRequest copyWith(
          void Function(ProcessScheduledPaymentsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as ProcessScheduledPaymentsRequest))
          as ProcessScheduledPaymentsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ProcessScheduledPaymentsRequest create() =>
      ProcessScheduledPaymentsRequest._();
  @$core.override
  ProcessScheduledPaymentsRequest createEmptyInstance() => create();
  static $pb.PbList<ProcessScheduledPaymentsRequest> createRepeated() =>
      $pb.PbList<ProcessScheduledPaymentsRequest>();
  @$core.pragma('dart2js:noInline')
  static ProcessScheduledPaymentsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ProcessScheduledPaymentsRequest>(
          create);
  static ProcessScheduledPaymentsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get contributionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set contributionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasContributionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearContributionId() => $_clearField(1);
}

class ProcessScheduledPaymentsResponse extends $pb.GeneratedMessage {
  factory ProcessScheduledPaymentsResponse({
    ContributionMessage? contribution,
    $core.Iterable<ContributionPaymentMessage>? paymentsProcessed,
  }) {
    final result = create();
    if (contribution != null) result.contribution = contribution;
    if (paymentsProcessed != null)
      result.paymentsProcessed.addAll(paymentsProcessed);
    return result;
  }

  ProcessScheduledPaymentsResponse._();

  factory ProcessScheduledPaymentsResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ProcessScheduledPaymentsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ProcessScheduledPaymentsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<ContributionMessage>(1, _omitFieldNames ? '' : 'contribution',
        subBuilder: ContributionMessage.create)
    ..pc<ContributionPaymentMessage>(
        2, _omitFieldNames ? '' : 'paymentsProcessed', $pb.PbFieldType.PM,
        subBuilder: ContributionPaymentMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProcessScheduledPaymentsResponse clone() =>
      ProcessScheduledPaymentsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProcessScheduledPaymentsResponse copyWith(
          void Function(ProcessScheduledPaymentsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as ProcessScheduledPaymentsResponse))
          as ProcessScheduledPaymentsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ProcessScheduledPaymentsResponse create() =>
      ProcessScheduledPaymentsResponse._();
  @$core.override
  ProcessScheduledPaymentsResponse createEmptyInstance() => create();
  static $pb.PbList<ProcessScheduledPaymentsResponse> createRepeated() =>
      $pb.PbList<ProcessScheduledPaymentsResponse>();
  @$core.pragma('dart2js:noInline')
  static ProcessScheduledPaymentsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ProcessScheduledPaymentsResponse>(
          create);
  static ProcessScheduledPaymentsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  ContributionMessage get contribution => $_getN(0);
  @$pb.TagNumber(1)
  set contribution(ContributionMessage value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasContribution() => $_has(0);
  @$pb.TagNumber(1)
  void clearContribution() => $_clearField(1);
  @$pb.TagNumber(1)
  ContributionMessage ensureContribution() => $_ensure(0);

  @$pb.TagNumber(2)
  $pb.PbList<ContributionPaymentMessage> get paymentsProcessed => $_getList(1);
}

class GetOverdueContributionsRequest extends $pb.GeneratedMessage {
  factory GetOverdueContributionsRequest() => create();

  GetOverdueContributionsRequest._();

  factory GetOverdueContributionsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetOverdueContributionsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetOverdueContributionsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetOverdueContributionsRequest clone() =>
      GetOverdueContributionsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetOverdueContributionsRequest copyWith(
          void Function(GetOverdueContributionsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetOverdueContributionsRequest))
          as GetOverdueContributionsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetOverdueContributionsRequest create() =>
      GetOverdueContributionsRequest._();
  @$core.override
  GetOverdueContributionsRequest createEmptyInstance() => create();
  static $pb.PbList<GetOverdueContributionsRequest> createRepeated() =>
      $pb.PbList<GetOverdueContributionsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetOverdueContributionsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetOverdueContributionsRequest>(create);
  static GetOverdueContributionsRequest? _defaultInstance;
}

class GetOverdueContributionsResponse extends $pb.GeneratedMessage {
  factory GetOverdueContributionsResponse({
    $core.Iterable<ContributionMessage>? contributions,
  }) {
    final result = create();
    if (contributions != null) result.contributions.addAll(contributions);
    return result;
  }

  GetOverdueContributionsResponse._();

  factory GetOverdueContributionsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetOverdueContributionsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetOverdueContributionsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<ContributionMessage>(
        1, _omitFieldNames ? '' : 'contributions', $pb.PbFieldType.PM,
        subBuilder: ContributionMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetOverdueContributionsResponse clone() =>
      GetOverdueContributionsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetOverdueContributionsResponse copyWith(
          void Function(GetOverdueContributionsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetOverdueContributionsResponse))
          as GetOverdueContributionsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetOverdueContributionsResponse create() =>
      GetOverdueContributionsResponse._();
  @$core.override
  GetOverdueContributionsResponse createEmptyInstance() => create();
  static $pb.PbList<GetOverdueContributionsResponse> createRepeated() =>
      $pb.PbList<GetOverdueContributionsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetOverdueContributionsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetOverdueContributionsResponse>(
          create);
  static GetOverdueContributionsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<ContributionMessage> get contributions => $_getList(0);
}

class GetPayoutScheduleRequest extends $pb.GeneratedMessage {
  factory GetPayoutScheduleRequest({
    $core.String? contributionId,
  }) {
    final result = create();
    if (contributionId != null) result.contributionId = contributionId;
    return result;
  }

  GetPayoutScheduleRequest._();

  factory GetPayoutScheduleRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetPayoutScheduleRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetPayoutScheduleRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'contributionId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPayoutScheduleRequest clone() =>
      GetPayoutScheduleRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPayoutScheduleRequest copyWith(
          void Function(GetPayoutScheduleRequest) updates) =>
      super.copyWith((message) => updates(message as GetPayoutScheduleRequest))
          as GetPayoutScheduleRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPayoutScheduleRequest create() => GetPayoutScheduleRequest._();
  @$core.override
  GetPayoutScheduleRequest createEmptyInstance() => create();
  static $pb.PbList<GetPayoutScheduleRequest> createRepeated() =>
      $pb.PbList<GetPayoutScheduleRequest>();
  @$core.pragma('dart2js:noInline')
  static GetPayoutScheduleRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetPayoutScheduleRequest>(create);
  static GetPayoutScheduleRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get contributionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set contributionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasContributionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearContributionId() => $_clearField(1);
}

class GetPayoutScheduleResponse extends $pb.GeneratedMessage {
  factory GetPayoutScheduleResponse({
    $core.Iterable<PayoutScheduleMessage>? schedule,
  }) {
    final result = create();
    if (schedule != null) result.schedule.addAll(schedule);
    return result;
  }

  GetPayoutScheduleResponse._();

  factory GetPayoutScheduleResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetPayoutScheduleResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetPayoutScheduleResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<PayoutScheduleMessage>(
        1, _omitFieldNames ? '' : 'schedule', $pb.PbFieldType.PM,
        subBuilder: PayoutScheduleMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPayoutScheduleResponse clone() =>
      GetPayoutScheduleResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPayoutScheduleResponse copyWith(
          void Function(GetPayoutScheduleResponse) updates) =>
      super.copyWith((message) => updates(message as GetPayoutScheduleResponse))
          as GetPayoutScheduleResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPayoutScheduleResponse create() => GetPayoutScheduleResponse._();
  @$core.override
  GetPayoutScheduleResponse createEmptyInstance() => create();
  static $pb.PbList<GetPayoutScheduleResponse> createRepeated() =>
      $pb.PbList<GetPayoutScheduleResponse>();
  @$core.pragma('dart2js:noInline')
  static GetPayoutScheduleResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetPayoutScheduleResponse>(create);
  static GetPayoutScheduleResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<PayoutScheduleMessage> get schedule => $_getList(0);
}

class ProcessPayoutRequest extends $pb.GeneratedMessage {
  factory ProcessPayoutRequest({
    $core.String? contributionId,
  }) {
    final result = create();
    if (contributionId != null) result.contributionId = contributionId;
    return result;
  }

  ProcessPayoutRequest._();

  factory ProcessPayoutRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ProcessPayoutRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ProcessPayoutRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'contributionId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProcessPayoutRequest clone() =>
      ProcessPayoutRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProcessPayoutRequest copyWith(void Function(ProcessPayoutRequest) updates) =>
      super.copyWith((message) => updates(message as ProcessPayoutRequest))
          as ProcessPayoutRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ProcessPayoutRequest create() => ProcessPayoutRequest._();
  @$core.override
  ProcessPayoutRequest createEmptyInstance() => create();
  static $pb.PbList<ProcessPayoutRequest> createRepeated() =>
      $pb.PbList<ProcessPayoutRequest>();
  @$core.pragma('dart2js:noInline')
  static ProcessPayoutRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ProcessPayoutRequest>(create);
  static ProcessPayoutRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get contributionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set contributionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasContributionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearContributionId() => $_clearField(1);
}

class ProcessPayoutResponse extends $pb.GeneratedMessage {
  factory ProcessPayoutResponse({
    PayoutTransactionMessage? transaction,
  }) {
    final result = create();
    if (transaction != null) result.transaction = transaction;
    return result;
  }

  ProcessPayoutResponse._();

  factory ProcessPayoutResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ProcessPayoutResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ProcessPayoutResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<PayoutTransactionMessage>(1, _omitFieldNames ? '' : 'transaction',
        subBuilder: PayoutTransactionMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProcessPayoutResponse clone() =>
      ProcessPayoutResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProcessPayoutResponse copyWith(
          void Function(ProcessPayoutResponse) updates) =>
      super.copyWith((message) => updates(message as ProcessPayoutResponse))
          as ProcessPayoutResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ProcessPayoutResponse create() => ProcessPayoutResponse._();
  @$core.override
  ProcessPayoutResponse createEmptyInstance() => create();
  static $pb.PbList<ProcessPayoutResponse> createRepeated() =>
      $pb.PbList<ProcessPayoutResponse>();
  @$core.pragma('dart2js:noInline')
  static ProcessPayoutResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ProcessPayoutResponse>(create);
  static ProcessPayoutResponse? _defaultInstance;

  @$pb.TagNumber(1)
  PayoutTransactionMessage get transaction => $_getN(0);
  @$pb.TagNumber(1)
  set transaction(PayoutTransactionMessage value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasTransaction() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransaction() => $_clearField(1);
  @$pb.TagNumber(1)
  PayoutTransactionMessage ensureTransaction() => $_ensure(0);
}

class UpdatePayoutStatusRequest extends $pb.GeneratedMessage {
  factory UpdatePayoutStatusRequest({
    $core.String? payoutId,
    PayoutTransactionStatus? status,
    $core.String? transactionId,
    $core.String? failureReason,
  }) {
    final result = create();
    if (payoutId != null) result.payoutId = payoutId;
    if (status != null) result.status = status;
    if (transactionId != null) result.transactionId = transactionId;
    if (failureReason != null) result.failureReason = failureReason;
    return result;
  }

  UpdatePayoutStatusRequest._();

  factory UpdatePayoutStatusRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdatePayoutStatusRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdatePayoutStatusRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'payoutId')
    ..e<PayoutTransactionStatus>(
        2, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker:
            PayoutTransactionStatus.PAYOUT_TRANSACTION_STATUS_UNSPECIFIED,
        valueOf: PayoutTransactionStatus.valueOf,
        enumValues: PayoutTransactionStatus.values)
    ..aOS(3, _omitFieldNames ? '' : 'transactionId')
    ..aOS(4, _omitFieldNames ? '' : 'failureReason')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdatePayoutStatusRequest clone() =>
      UpdatePayoutStatusRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdatePayoutStatusRequest copyWith(
          void Function(UpdatePayoutStatusRequest) updates) =>
      super.copyWith((message) => updates(message as UpdatePayoutStatusRequest))
          as UpdatePayoutStatusRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdatePayoutStatusRequest create() => UpdatePayoutStatusRequest._();
  @$core.override
  UpdatePayoutStatusRequest createEmptyInstance() => create();
  static $pb.PbList<UpdatePayoutStatusRequest> createRepeated() =>
      $pb.PbList<UpdatePayoutStatusRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdatePayoutStatusRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdatePayoutStatusRequest>(create);
  static UpdatePayoutStatusRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get payoutId => $_getSZ(0);
  @$pb.TagNumber(1)
  set payoutId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPayoutId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayoutId() => $_clearField(1);

  @$pb.TagNumber(2)
  PayoutTransactionStatus get status => $_getN(1);
  @$pb.TagNumber(2)
  set status(PayoutTransactionStatus value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get transactionId => $_getSZ(2);
  @$pb.TagNumber(3)
  set transactionId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTransactionId() => $_has(2);
  @$pb.TagNumber(3)
  void clearTransactionId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get failureReason => $_getSZ(3);
  @$pb.TagNumber(4)
  set failureReason($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasFailureReason() => $_has(3);
  @$pb.TagNumber(4)
  void clearFailureReason() => $_clearField(4);
}

class UpdatePayoutStatusResponse extends $pb.GeneratedMessage {
  factory UpdatePayoutStatusResponse({
    PayoutTransactionMessage? payout,
  }) {
    final result = create();
    if (payout != null) result.payout = payout;
    return result;
  }

  UpdatePayoutStatusResponse._();

  factory UpdatePayoutStatusResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdatePayoutStatusResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdatePayoutStatusResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<PayoutTransactionMessage>(1, _omitFieldNames ? '' : 'payout',
        subBuilder: PayoutTransactionMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdatePayoutStatusResponse clone() =>
      UpdatePayoutStatusResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdatePayoutStatusResponse copyWith(
          void Function(UpdatePayoutStatusResponse) updates) =>
      super.copyWith(
              (message) => updates(message as UpdatePayoutStatusResponse))
          as UpdatePayoutStatusResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdatePayoutStatusResponse create() => UpdatePayoutStatusResponse._();
  @$core.override
  UpdatePayoutStatusResponse createEmptyInstance() => create();
  static $pb.PbList<UpdatePayoutStatusResponse> createRepeated() =>
      $pb.PbList<UpdatePayoutStatusResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdatePayoutStatusResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdatePayoutStatusResponse>(create);
  static UpdatePayoutStatusResponse? _defaultInstance;

  @$pb.TagNumber(1)
  PayoutTransactionMessage get payout => $_getN(0);
  @$pb.TagNumber(1)
  set payout(PayoutTransactionMessage value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasPayout() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayout() => $_clearField(1);
  @$pb.TagNumber(1)
  PayoutTransactionMessage ensurePayout() => $_ensure(0);
}

class AdvancePayoutRotationRequest extends $pb.GeneratedMessage {
  factory AdvancePayoutRotationRequest({
    $core.String? contributionId,
  }) {
    final result = create();
    if (contributionId != null) result.contributionId = contributionId;
    return result;
  }

  AdvancePayoutRotationRequest._();

  factory AdvancePayoutRotationRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AdvancePayoutRotationRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AdvancePayoutRotationRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'contributionId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdvancePayoutRotationRequest clone() =>
      AdvancePayoutRotationRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdvancePayoutRotationRequest copyWith(
          void Function(AdvancePayoutRotationRequest) updates) =>
      super.copyWith(
              (message) => updates(message as AdvancePayoutRotationRequest))
          as AdvancePayoutRotationRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdvancePayoutRotationRequest create() =>
      AdvancePayoutRotationRequest._();
  @$core.override
  AdvancePayoutRotationRequest createEmptyInstance() => create();
  static $pb.PbList<AdvancePayoutRotationRequest> createRepeated() =>
      $pb.PbList<AdvancePayoutRotationRequest>();
  @$core.pragma('dart2js:noInline')
  static AdvancePayoutRotationRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AdvancePayoutRotationRequest>(create);
  static AdvancePayoutRotationRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get contributionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set contributionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasContributionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearContributionId() => $_clearField(1);
}

class AdvancePayoutRotationResponse extends $pb.GeneratedMessage {
  factory AdvancePayoutRotationResponse({
    ContributionMessage? contribution,
  }) {
    final result = create();
    if (contribution != null) result.contribution = contribution;
    return result;
  }

  AdvancePayoutRotationResponse._();

  factory AdvancePayoutRotationResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AdvancePayoutRotationResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AdvancePayoutRotationResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<ContributionMessage>(1, _omitFieldNames ? '' : 'contribution',
        subBuilder: ContributionMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdvancePayoutRotationResponse clone() =>
      AdvancePayoutRotationResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdvancePayoutRotationResponse copyWith(
          void Function(AdvancePayoutRotationResponse) updates) =>
      super.copyWith(
              (message) => updates(message as AdvancePayoutRotationResponse))
          as AdvancePayoutRotationResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdvancePayoutRotationResponse create() =>
      AdvancePayoutRotationResponse._();
  @$core.override
  AdvancePayoutRotationResponse createEmptyInstance() => create();
  static $pb.PbList<AdvancePayoutRotationResponse> createRepeated() =>
      $pb.PbList<AdvancePayoutRotationResponse>();
  @$core.pragma('dart2js:noInline')
  static AdvancePayoutRotationResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AdvancePayoutRotationResponse>(create);
  static AdvancePayoutRotationResponse? _defaultInstance;

  @$pb.TagNumber(1)
  ContributionMessage get contribution => $_getN(0);
  @$pb.TagNumber(1)
  set contribution(ContributionMessage value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasContribution() => $_has(0);
  @$pb.TagNumber(1)
  void clearContribution() => $_clearField(1);
  @$pb.TagNumber(1)
  ContributionMessage ensureContribution() => $_ensure(0);
}

class GenerateReceiptRequest extends $pb.GeneratedMessage {
  factory GenerateReceiptRequest({
    $core.String? paymentId,
  }) {
    final result = create();
    if (paymentId != null) result.paymentId = paymentId;
    return result;
  }

  GenerateReceiptRequest._();

  factory GenerateReceiptRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GenerateReceiptRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GenerateReceiptRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'paymentId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GenerateReceiptRequest clone() =>
      GenerateReceiptRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GenerateReceiptRequest copyWith(
          void Function(GenerateReceiptRequest) updates) =>
      super.copyWith((message) => updates(message as GenerateReceiptRequest))
          as GenerateReceiptRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GenerateReceiptRequest create() => GenerateReceiptRequest._();
  @$core.override
  GenerateReceiptRequest createEmptyInstance() => create();
  static $pb.PbList<GenerateReceiptRequest> createRepeated() =>
      $pb.PbList<GenerateReceiptRequest>();
  @$core.pragma('dart2js:noInline')
  static GenerateReceiptRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GenerateReceiptRequest>(create);
  static GenerateReceiptRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get paymentId => $_getSZ(0);
  @$pb.TagNumber(1)
  set paymentId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPaymentId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPaymentId() => $_clearField(1);
}

class GenerateReceiptResponse extends $pb.GeneratedMessage {
  factory GenerateReceiptResponse({
    ContributionReceiptMessage? receipt,
  }) {
    final result = create();
    if (receipt != null) result.receipt = receipt;
    return result;
  }

  GenerateReceiptResponse._();

  factory GenerateReceiptResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GenerateReceiptResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GenerateReceiptResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<ContributionReceiptMessage>(1, _omitFieldNames ? '' : 'receipt',
        subBuilder: ContributionReceiptMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GenerateReceiptResponse clone() =>
      GenerateReceiptResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GenerateReceiptResponse copyWith(
          void Function(GenerateReceiptResponse) updates) =>
      super.copyWith((message) => updates(message as GenerateReceiptResponse))
          as GenerateReceiptResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GenerateReceiptResponse create() => GenerateReceiptResponse._();
  @$core.override
  GenerateReceiptResponse createEmptyInstance() => create();
  static $pb.PbList<GenerateReceiptResponse> createRepeated() =>
      $pb.PbList<GenerateReceiptResponse>();
  @$core.pragma('dart2js:noInline')
  static GenerateReceiptResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GenerateReceiptResponse>(create);
  static GenerateReceiptResponse? _defaultInstance;

  @$pb.TagNumber(1)
  ContributionReceiptMessage get receipt => $_getN(0);
  @$pb.TagNumber(1)
  set receipt(ContributionReceiptMessage value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasReceipt() => $_has(0);
  @$pb.TagNumber(1)
  void clearReceipt() => $_clearField(1);
  @$pb.TagNumber(1)
  ContributionReceiptMessage ensureReceipt() => $_ensure(0);
}

class GetUserContributionReceiptsRequest extends $pb.GeneratedMessage {
  factory GetUserContributionReceiptsRequest({
    $core.int? page,
    $core.int? pageSize,
  }) {
    final result = create();
    if (page != null) result.page = page;
    if (pageSize != null) result.pageSize = pageSize;
    return result;
  }

  GetUserContributionReceiptsRequest._();

  factory GetUserContributionReceiptsRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetUserContributionReceiptsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUserContributionReceiptsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserContributionReceiptsRequest clone() =>
      GetUserContributionReceiptsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserContributionReceiptsRequest copyWith(
          void Function(GetUserContributionReceiptsRequest) updates) =>
      super.copyWith((message) =>
              updates(message as GetUserContributionReceiptsRequest))
          as GetUserContributionReceiptsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserContributionReceiptsRequest create() =>
      GetUserContributionReceiptsRequest._();
  @$core.override
  GetUserContributionReceiptsRequest createEmptyInstance() => create();
  static $pb.PbList<GetUserContributionReceiptsRequest> createRepeated() =>
      $pb.PbList<GetUserContributionReceiptsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetUserContributionReceiptsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetUserContributionReceiptsRequest>(
          create);
  static GetUserContributionReceiptsRequest? _defaultInstance;

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

class GetUserContributionReceiptsResponse extends $pb.GeneratedMessage {
  factory GetUserContributionReceiptsResponse({
    $core.Iterable<ContributionReceiptMessage>? receipts,
    ReceiptPaginationInfo? pagination,
  }) {
    final result = create();
    if (receipts != null) result.receipts.addAll(receipts);
    if (pagination != null) result.pagination = pagination;
    return result;
  }

  GetUserContributionReceiptsResponse._();

  factory GetUserContributionReceiptsResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetUserContributionReceiptsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUserContributionReceiptsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<ContributionReceiptMessage>(
        1, _omitFieldNames ? '' : 'receipts', $pb.PbFieldType.PM,
        subBuilder: ContributionReceiptMessage.create)
    ..aOM<ReceiptPaginationInfo>(2, _omitFieldNames ? '' : 'pagination',
        subBuilder: ReceiptPaginationInfo.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserContributionReceiptsResponse clone() =>
      GetUserContributionReceiptsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserContributionReceiptsResponse copyWith(
          void Function(GetUserContributionReceiptsResponse) updates) =>
      super.copyWith((message) =>
              updates(message as GetUserContributionReceiptsResponse))
          as GetUserContributionReceiptsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserContributionReceiptsResponse create() =>
      GetUserContributionReceiptsResponse._();
  @$core.override
  GetUserContributionReceiptsResponse createEmptyInstance() => create();
  static $pb.PbList<GetUserContributionReceiptsResponse> createRepeated() =>
      $pb.PbList<GetUserContributionReceiptsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetUserContributionReceiptsResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          GetUserContributionReceiptsResponse>(create);
  static GetUserContributionReceiptsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<ContributionReceiptMessage> get receipts => $_getList(0);

  @$pb.TagNumber(2)
  ReceiptPaginationInfo get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination(ReceiptPaginationInfo value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => $_clearField(2);
  @$pb.TagNumber(2)
  ReceiptPaginationInfo ensurePagination() => $_ensure(1);
}

class GenerateTranscriptRequest extends $pb.GeneratedMessage {
  factory GenerateTranscriptRequest({
    $core.String? contributionId,
  }) {
    final result = create();
    if (contributionId != null) result.contributionId = contributionId;
    return result;
  }

  GenerateTranscriptRequest._();

  factory GenerateTranscriptRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GenerateTranscriptRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GenerateTranscriptRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'contributionId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GenerateTranscriptRequest clone() =>
      GenerateTranscriptRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GenerateTranscriptRequest copyWith(
          void Function(GenerateTranscriptRequest) updates) =>
      super.copyWith((message) => updates(message as GenerateTranscriptRequest))
          as GenerateTranscriptRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GenerateTranscriptRequest create() => GenerateTranscriptRequest._();
  @$core.override
  GenerateTranscriptRequest createEmptyInstance() => create();
  static $pb.PbList<GenerateTranscriptRequest> createRepeated() =>
      $pb.PbList<GenerateTranscriptRequest>();
  @$core.pragma('dart2js:noInline')
  static GenerateTranscriptRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GenerateTranscriptRequest>(create);
  static GenerateTranscriptRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get contributionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set contributionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasContributionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearContributionId() => $_clearField(1);
}

class GenerateTranscriptResponse extends $pb.GeneratedMessage {
  factory GenerateTranscriptResponse({
    ContributionTranscriptMessage? transcript,
  }) {
    final result = create();
    if (transcript != null) result.transcript = transcript;
    return result;
  }

  GenerateTranscriptResponse._();

  factory GenerateTranscriptResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GenerateTranscriptResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GenerateTranscriptResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<ContributionTranscriptMessage>(1, _omitFieldNames ? '' : 'transcript',
        subBuilder: ContributionTranscriptMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GenerateTranscriptResponse clone() =>
      GenerateTranscriptResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GenerateTranscriptResponse copyWith(
          void Function(GenerateTranscriptResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GenerateTranscriptResponse))
          as GenerateTranscriptResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GenerateTranscriptResponse create() => GenerateTranscriptResponse._();
  @$core.override
  GenerateTranscriptResponse createEmptyInstance() => create();
  static $pb.PbList<GenerateTranscriptResponse> createRepeated() =>
      $pb.PbList<GenerateTranscriptResponse>();
  @$core.pragma('dart2js:noInline')
  static GenerateTranscriptResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GenerateTranscriptResponse>(create);
  static GenerateTranscriptResponse? _defaultInstance;

  @$pb.TagNumber(1)
  ContributionTranscriptMessage get transcript => $_getN(0);
  @$pb.TagNumber(1)
  set transcript(ContributionTranscriptMessage value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasTranscript() => $_has(0);
  @$pb.TagNumber(1)
  void clearTranscript() => $_clearField(1);
  @$pb.TagNumber(1)
  ContributionTranscriptMessage ensureTranscript() => $_ensure(0);
}

class GetGroupStatisticsRequest extends $pb.GeneratedMessage {
  factory GetGroupStatisticsRequest({
    $core.String? groupId,
  }) {
    final result = create();
    if (groupId != null) result.groupId = groupId;
    return result;
  }

  GetGroupStatisticsRequest._();

  factory GetGroupStatisticsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetGroupStatisticsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetGroupStatisticsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'groupId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetGroupStatisticsRequest clone() =>
      GetGroupStatisticsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetGroupStatisticsRequest copyWith(
          void Function(GetGroupStatisticsRequest) updates) =>
      super.copyWith((message) => updates(message as GetGroupStatisticsRequest))
          as GetGroupStatisticsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetGroupStatisticsRequest create() => GetGroupStatisticsRequest._();
  @$core.override
  GetGroupStatisticsRequest createEmptyInstance() => create();
  static $pb.PbList<GetGroupStatisticsRequest> createRepeated() =>
      $pb.PbList<GetGroupStatisticsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetGroupStatisticsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetGroupStatisticsRequest>(create);
  static GetGroupStatisticsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get groupId => $_getSZ(0);
  @$pb.TagNumber(1)
  set groupId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasGroupId() => $_has(0);
  @$pb.TagNumber(1)
  void clearGroupId() => $_clearField(1);
}

class GetGroupStatisticsResponse extends $pb.GeneratedMessage {
  factory GetGroupStatisticsResponse({
    $core.int? memberCount,
    $core.int? totalContributions,
    $core.int? completedContributions,
    $core.int? activeContributions,
    $fixnum.Int64? totalTargetAmount,
    $fixnum.Int64? totalCurrentAmount,
    $core.double? completionRate,
  }) {
    final result = create();
    if (memberCount != null) result.memberCount = memberCount;
    if (totalContributions != null)
      result.totalContributions = totalContributions;
    if (completedContributions != null)
      result.completedContributions = completedContributions;
    if (activeContributions != null)
      result.activeContributions = activeContributions;
    if (totalTargetAmount != null) result.totalTargetAmount = totalTargetAmount;
    if (totalCurrentAmount != null)
      result.totalCurrentAmount = totalCurrentAmount;
    if (completionRate != null) result.completionRate = completionRate;
    return result;
  }

  GetGroupStatisticsResponse._();

  factory GetGroupStatisticsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetGroupStatisticsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetGroupStatisticsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'memberCount', $pb.PbFieldType.O3)
    ..a<$core.int>(
        2, _omitFieldNames ? '' : 'totalContributions', $pb.PbFieldType.O3)
    ..a<$core.int>(
        3, _omitFieldNames ? '' : 'completedContributions', $pb.PbFieldType.O3)
    ..a<$core.int>(
        4, _omitFieldNames ? '' : 'activeContributions', $pb.PbFieldType.O3)
    ..a<$fixnum.Int64>(
        5, _omitFieldNames ? '' : 'totalTargetAmount', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(
        6, _omitFieldNames ? '' : 'totalCurrentAmount', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.double>(
        7, _omitFieldNames ? '' : 'completionRate', $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetGroupStatisticsResponse clone() =>
      GetGroupStatisticsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetGroupStatisticsResponse copyWith(
          void Function(GetGroupStatisticsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetGroupStatisticsResponse))
          as GetGroupStatisticsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetGroupStatisticsResponse create() => GetGroupStatisticsResponse._();
  @$core.override
  GetGroupStatisticsResponse createEmptyInstance() => create();
  static $pb.PbList<GetGroupStatisticsResponse> createRepeated() =>
      $pb.PbList<GetGroupStatisticsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetGroupStatisticsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetGroupStatisticsResponse>(create);
  static GetGroupStatisticsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get memberCount => $_getIZ(0);
  @$pb.TagNumber(1)
  set memberCount($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMemberCount() => $_has(0);
  @$pb.TagNumber(1)
  void clearMemberCount() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get totalContributions => $_getIZ(1);
  @$pb.TagNumber(2)
  set totalContributions($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotalContributions() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalContributions() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get completedContributions => $_getIZ(2);
  @$pb.TagNumber(3)
  set completedContributions($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCompletedContributions() => $_has(2);
  @$pb.TagNumber(3)
  void clearCompletedContributions() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get activeContributions => $_getIZ(3);
  @$pb.TagNumber(4)
  set activeContributions($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasActiveContributions() => $_has(3);
  @$pb.TagNumber(4)
  void clearActiveContributions() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get totalTargetAmount => $_getI64(4);
  @$pb.TagNumber(5)
  set totalTargetAmount($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTotalTargetAmount() => $_has(4);
  @$pb.TagNumber(5)
  void clearTotalTargetAmount() => $_clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get totalCurrentAmount => $_getI64(5);
  @$pb.TagNumber(6)
  set totalCurrentAmount($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasTotalCurrentAmount() => $_has(5);
  @$pb.TagNumber(6)
  void clearTotalCurrentAmount() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.double get completionRate => $_getN(6);
  @$pb.TagNumber(7)
  set completionRate($core.double value) => $_setDouble(6, value);
  @$pb.TagNumber(7)
  $core.bool hasCompletionRate() => $_has(6);
  @$pb.TagNumber(7)
  void clearCompletionRate() => $_clearField(7);
}

class GetUserContributionStatsRequest extends $pb.GeneratedMessage {
  factory GetUserContributionStatsRequest() => create();

  GetUserContributionStatsRequest._();

  factory GetUserContributionStatsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetUserContributionStatsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUserContributionStatsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserContributionStatsRequest clone() =>
      GetUserContributionStatsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserContributionStatsRequest copyWith(
          void Function(GetUserContributionStatsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetUserContributionStatsRequest))
          as GetUserContributionStatsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserContributionStatsRequest create() =>
      GetUserContributionStatsRequest._();
  @$core.override
  GetUserContributionStatsRequest createEmptyInstance() => create();
  static $pb.PbList<GetUserContributionStatsRequest> createRepeated() =>
      $pb.PbList<GetUserContributionStatsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetUserContributionStatsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetUserContributionStatsRequest>(
          create);
  static GetUserContributionStatsRequest? _defaultInstance;
}

class GetUserContributionStatsResponse extends $pb.GeneratedMessage {
  factory GetUserContributionStatsResponse({
    $core.int? totalPayments,
    $fixnum.Int64? totalAmount,
    $core.int? groupsCount,
    $core.double? averagePayment,
  }) {
    final result = create();
    if (totalPayments != null) result.totalPayments = totalPayments;
    if (totalAmount != null) result.totalAmount = totalAmount;
    if (groupsCount != null) result.groupsCount = groupsCount;
    if (averagePayment != null) result.averagePayment = averagePayment;
    return result;
  }

  GetUserContributionStatsResponse._();

  factory GetUserContributionStatsResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetUserContributionStatsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUserContributionStatsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..a<$core.int>(
        1, _omitFieldNames ? '' : 'totalPayments', $pb.PbFieldType.O3)
    ..a<$fixnum.Int64>(
        2, _omitFieldNames ? '' : 'totalAmount', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'groupsCount', $pb.PbFieldType.O3)
    ..a<$core.double>(
        4, _omitFieldNames ? '' : 'averagePayment', $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserContributionStatsResponse clone() =>
      GetUserContributionStatsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserContributionStatsResponse copyWith(
          void Function(GetUserContributionStatsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetUserContributionStatsResponse))
          as GetUserContributionStatsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserContributionStatsResponse create() =>
      GetUserContributionStatsResponse._();
  @$core.override
  GetUserContributionStatsResponse createEmptyInstance() => create();
  static $pb.PbList<GetUserContributionStatsResponse> createRepeated() =>
      $pb.PbList<GetUserContributionStatsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetUserContributionStatsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetUserContributionStatsResponse>(
          create);
  static GetUserContributionStatsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get totalPayments => $_getIZ(0);
  @$pb.TagNumber(1)
  set totalPayments($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTotalPayments() => $_has(0);
  @$pb.TagNumber(1)
  void clearTotalPayments() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get totalAmount => $_getI64(1);
  @$pb.TagNumber(2)
  set totalAmount($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotalAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalAmount() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get groupsCount => $_getIZ(2);
  @$pb.TagNumber(3)
  set groupsCount($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasGroupsCount() => $_has(2);
  @$pb.TagNumber(3)
  void clearGroupsCount() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get averagePayment => $_getN(3);
  @$pb.TagNumber(4)
  set averagePayment($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAveragePayment() => $_has(3);
  @$pb.TagNumber(4)
  void clearAveragePayment() => $_clearField(4);
}

class GetContributionAnalyticsRequest extends $pb.GeneratedMessage {
  factory GetContributionAnalyticsRequest({
    $core.String? contributionId,
  }) {
    final result = create();
    if (contributionId != null) result.contributionId = contributionId;
    return result;
  }

  GetContributionAnalyticsRequest._();

  factory GetContributionAnalyticsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetContributionAnalyticsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetContributionAnalyticsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'contributionId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetContributionAnalyticsRequest clone() =>
      GetContributionAnalyticsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetContributionAnalyticsRequest copyWith(
          void Function(GetContributionAnalyticsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetContributionAnalyticsRequest))
          as GetContributionAnalyticsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetContributionAnalyticsRequest create() =>
      GetContributionAnalyticsRequest._();
  @$core.override
  GetContributionAnalyticsRequest createEmptyInstance() => create();
  static $pb.PbList<GetContributionAnalyticsRequest> createRepeated() =>
      $pb.PbList<GetContributionAnalyticsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetContributionAnalyticsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetContributionAnalyticsRequest>(
          create);
  static GetContributionAnalyticsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get contributionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set contributionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasContributionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearContributionId() => $_clearField(1);
}

class GetContributionAnalyticsResponse_MemberParticipation
    extends $pb.GeneratedMessage {
  factory GetContributionAnalyticsResponse_MemberParticipation({
    $core.int? totalMembers,
    $core.int? participatingMembers,
    $core.double? participationRate,
  }) {
    final result = create();
    if (totalMembers != null) result.totalMembers = totalMembers;
    if (participatingMembers != null)
      result.participatingMembers = participatingMembers;
    if (participationRate != null) result.participationRate = participationRate;
    return result;
  }

  GetContributionAnalyticsResponse_MemberParticipation._();

  factory GetContributionAnalyticsResponse_MemberParticipation.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetContributionAnalyticsResponse_MemberParticipation.fromJson(
          $core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames
          ? ''
          : 'GetContributionAnalyticsResponse.MemberParticipation',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'totalMembers', $pb.PbFieldType.O3)
    ..a<$core.int>(
        2, _omitFieldNames ? '' : 'participatingMembers', $pb.PbFieldType.O3)
    ..a<$core.double>(
        3, _omitFieldNames ? '' : 'participationRate', $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetContributionAnalyticsResponse_MemberParticipation clone() =>
      GetContributionAnalyticsResponse_MemberParticipation()
        ..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetContributionAnalyticsResponse_MemberParticipation copyWith(
          void Function(GetContributionAnalyticsResponse_MemberParticipation)
              updates) =>
      super.copyWith((message) => updates(
              message as GetContributionAnalyticsResponse_MemberParticipation))
          as GetContributionAnalyticsResponse_MemberParticipation;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetContributionAnalyticsResponse_MemberParticipation create() =>
      GetContributionAnalyticsResponse_MemberParticipation._();
  @$core.override
  GetContributionAnalyticsResponse_MemberParticipation createEmptyInstance() =>
      create();
  static $pb.PbList<GetContributionAnalyticsResponse_MemberParticipation>
      createRepeated() =>
          $pb.PbList<GetContributionAnalyticsResponse_MemberParticipation>();
  @$core.pragma('dart2js:noInline')
  static GetContributionAnalyticsResponse_MemberParticipation getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          GetContributionAnalyticsResponse_MemberParticipation>(create);
  static GetContributionAnalyticsResponse_MemberParticipation? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get totalMembers => $_getIZ(0);
  @$pb.TagNumber(1)
  set totalMembers($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTotalMembers() => $_has(0);
  @$pb.TagNumber(1)
  void clearTotalMembers() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get participatingMembers => $_getIZ(1);
  @$pb.TagNumber(2)
  set participatingMembers($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasParticipatingMembers() => $_has(1);
  @$pb.TagNumber(2)
  void clearParticipatingMembers() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get participationRate => $_getN(2);
  @$pb.TagNumber(3)
  set participationRate($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasParticipationRate() => $_has(2);
  @$pb.TagNumber(3)
  void clearParticipationRate() => $_clearField(3);
}

class GetContributionAnalyticsResponse_Schedule extends $pb.GeneratedMessage {
  factory GetContributionAnalyticsResponse_Schedule({
    $core.bool? isOnSchedule,
    $core.int? daysBehindSchedule,
    $1.Timestamp? nextPaymentDate,
    $core.int? currentCycle,
    $core.int? totalCycles,
  }) {
    final result = create();
    if (isOnSchedule != null) result.isOnSchedule = isOnSchedule;
    if (daysBehindSchedule != null)
      result.daysBehindSchedule = daysBehindSchedule;
    if (nextPaymentDate != null) result.nextPaymentDate = nextPaymentDate;
    if (currentCycle != null) result.currentCycle = currentCycle;
    if (totalCycles != null) result.totalCycles = totalCycles;
    return result;
  }

  GetContributionAnalyticsResponse_Schedule._();

  factory GetContributionAnalyticsResponse_Schedule.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetContributionAnalyticsResponse_Schedule.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetContributionAnalyticsResponse.Schedule',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'isOnSchedule')
    ..a<$core.int>(
        2, _omitFieldNames ? '' : 'daysBehindSchedule', $pb.PbFieldType.O3)
    ..aOM<$1.Timestamp>(3, _omitFieldNames ? '' : 'nextPaymentDate',
        subBuilder: $1.Timestamp.create)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'currentCycle', $pb.PbFieldType.O3)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'totalCycles', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetContributionAnalyticsResponse_Schedule clone() =>
      GetContributionAnalyticsResponse_Schedule()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetContributionAnalyticsResponse_Schedule copyWith(
          void Function(GetContributionAnalyticsResponse_Schedule) updates) =>
      super.copyWith((message) =>
              updates(message as GetContributionAnalyticsResponse_Schedule))
          as GetContributionAnalyticsResponse_Schedule;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetContributionAnalyticsResponse_Schedule create() =>
      GetContributionAnalyticsResponse_Schedule._();
  @$core.override
  GetContributionAnalyticsResponse_Schedule createEmptyInstance() => create();
  static $pb.PbList<GetContributionAnalyticsResponse_Schedule>
      createRepeated() =>
          $pb.PbList<GetContributionAnalyticsResponse_Schedule>();
  @$core.pragma('dart2js:noInline')
  static GetContributionAnalyticsResponse_Schedule getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          GetContributionAnalyticsResponse_Schedule>(create);
  static GetContributionAnalyticsResponse_Schedule? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get isOnSchedule => $_getBF(0);
  @$pb.TagNumber(1)
  set isOnSchedule($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasIsOnSchedule() => $_has(0);
  @$pb.TagNumber(1)
  void clearIsOnSchedule() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get daysBehindSchedule => $_getIZ(1);
  @$pb.TagNumber(2)
  set daysBehindSchedule($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDaysBehindSchedule() => $_has(1);
  @$pb.TagNumber(2)
  void clearDaysBehindSchedule() => $_clearField(2);

  @$pb.TagNumber(3)
  $1.Timestamp get nextPaymentDate => $_getN(2);
  @$pb.TagNumber(3)
  set nextPaymentDate($1.Timestamp value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasNextPaymentDate() => $_has(2);
  @$pb.TagNumber(3)
  void clearNextPaymentDate() => $_clearField(3);
  @$pb.TagNumber(3)
  $1.Timestamp ensureNextPaymentDate() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.int get currentCycle => $_getIZ(3);
  @$pb.TagNumber(4)
  set currentCycle($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCurrentCycle() => $_has(3);
  @$pb.TagNumber(4)
  void clearCurrentCycle() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get totalCycles => $_getIZ(4);
  @$pb.TagNumber(5)
  set totalCycles($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTotalCycles() => $_has(4);
  @$pb.TagNumber(5)
  void clearTotalCycles() => $_clearField(5);
}

class GetContributionAnalyticsResponse_Payout extends $pb.GeneratedMessage {
  factory GetContributionAnalyticsResponse_Payout({
    $fixnum.Int64? currentRecipient,
    $1.Timestamp? nextPayoutDate,
    $core.int? completedPayouts,
    $core.int? pendingPayouts,
  }) {
    final result = create();
    if (currentRecipient != null) result.currentRecipient = currentRecipient;
    if (nextPayoutDate != null) result.nextPayoutDate = nextPayoutDate;
    if (completedPayouts != null) result.completedPayouts = completedPayouts;
    if (pendingPayouts != null) result.pendingPayouts = pendingPayouts;
    return result;
  }

  GetContributionAnalyticsResponse_Payout._();

  factory GetContributionAnalyticsResponse_Payout.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetContributionAnalyticsResponse_Payout.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetContributionAnalyticsResponse.Payout',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..a<$fixnum.Int64>(
        1, _omitFieldNames ? '' : 'currentRecipient', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<$1.Timestamp>(2, _omitFieldNames ? '' : 'nextPayoutDate',
        subBuilder: $1.Timestamp.create)
    ..a<$core.int>(
        3, _omitFieldNames ? '' : 'completedPayouts', $pb.PbFieldType.O3)
    ..a<$core.int>(
        4, _omitFieldNames ? '' : 'pendingPayouts', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetContributionAnalyticsResponse_Payout clone() =>
      GetContributionAnalyticsResponse_Payout()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetContributionAnalyticsResponse_Payout copyWith(
          void Function(GetContributionAnalyticsResponse_Payout) updates) =>
      super.copyWith((message) =>
              updates(message as GetContributionAnalyticsResponse_Payout))
          as GetContributionAnalyticsResponse_Payout;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetContributionAnalyticsResponse_Payout create() =>
      GetContributionAnalyticsResponse_Payout._();
  @$core.override
  GetContributionAnalyticsResponse_Payout createEmptyInstance() => create();
  static $pb.PbList<GetContributionAnalyticsResponse_Payout> createRepeated() =>
      $pb.PbList<GetContributionAnalyticsResponse_Payout>();
  @$core.pragma('dart2js:noInline')
  static GetContributionAnalyticsResponse_Payout getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          GetContributionAnalyticsResponse_Payout>(create);
  static GetContributionAnalyticsResponse_Payout? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get currentRecipient => $_getI64(0);
  @$pb.TagNumber(1)
  set currentRecipient($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCurrentRecipient() => $_has(0);
  @$pb.TagNumber(1)
  void clearCurrentRecipient() => $_clearField(1);

  @$pb.TagNumber(2)
  $1.Timestamp get nextPayoutDate => $_getN(1);
  @$pb.TagNumber(2)
  set nextPayoutDate($1.Timestamp value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasNextPayoutDate() => $_has(1);
  @$pb.TagNumber(2)
  void clearNextPayoutDate() => $_clearField(2);
  @$pb.TagNumber(2)
  $1.Timestamp ensureNextPayoutDate() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.int get completedPayouts => $_getIZ(2);
  @$pb.TagNumber(3)
  set completedPayouts($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCompletedPayouts() => $_has(2);
  @$pb.TagNumber(3)
  void clearCompletedPayouts() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get pendingPayouts => $_getIZ(3);
  @$pb.TagNumber(4)
  set pendingPayouts($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPendingPayouts() => $_has(3);
  @$pb.TagNumber(4)
  void clearPendingPayouts() => $_clearField(4);
}

class GetContributionAnalyticsResponse extends $pb.GeneratedMessage {
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
    final result = create();
    if (contributionId != null) result.contributionId = contributionId;
    if (type != null) result.type = type;
    if (progressPercentage != null)
      result.progressPercentage = progressPercentage;
    if (totalPayments != null) result.totalPayments = totalPayments;
    if (averagePayment != null) result.averagePayment = averagePayment;
    if (currentAmount != null) result.currentAmount = currentAmount;
    if (targetAmount != null) result.targetAmount = targetAmount;
    if (memberParticipation != null)
      result.memberParticipation = memberParticipation;
    if (schedule != null) result.schedule = schedule;
    if (payout != null) result.payout = payout;
    if (memberStats != null) result.memberStats = memberStats;
    return result;
  }

  GetContributionAnalyticsResponse._();

  factory GetContributionAnalyticsResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetContributionAnalyticsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetContributionAnalyticsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'contributionId')
    ..aOS(2, _omitFieldNames ? '' : 'type')
    ..a<$core.double>(
        3, _omitFieldNames ? '' : 'progressPercentage', $pb.PbFieldType.OD)
    ..a<$core.int>(
        4, _omitFieldNames ? '' : 'totalPayments', $pb.PbFieldType.O3)
    ..a<$core.double>(
        5, _omitFieldNames ? '' : 'averagePayment', $pb.PbFieldType.OD)
    ..a<$fixnum.Int64>(
        6, _omitFieldNames ? '' : 'currentAmount', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(
        7, _omitFieldNames ? '' : 'targetAmount', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<GetContributionAnalyticsResponse_MemberParticipation>(
        8, _omitFieldNames ? '' : 'memberParticipation',
        subBuilder: GetContributionAnalyticsResponse_MemberParticipation.create)
    ..aOM<GetContributionAnalyticsResponse_Schedule>(
        9, _omitFieldNames ? '' : 'schedule',
        subBuilder: GetContributionAnalyticsResponse_Schedule.create)
    ..aOM<GetContributionAnalyticsResponse_Payout>(
        10, _omitFieldNames ? '' : 'payout',
        subBuilder: GetContributionAnalyticsResponse_Payout.create)
    ..aOS(11, _omitFieldNames ? '' : 'memberStats')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetContributionAnalyticsResponse clone() =>
      GetContributionAnalyticsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetContributionAnalyticsResponse copyWith(
          void Function(GetContributionAnalyticsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetContributionAnalyticsResponse))
          as GetContributionAnalyticsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetContributionAnalyticsResponse create() =>
      GetContributionAnalyticsResponse._();
  @$core.override
  GetContributionAnalyticsResponse createEmptyInstance() => create();
  static $pb.PbList<GetContributionAnalyticsResponse> createRepeated() =>
      $pb.PbList<GetContributionAnalyticsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetContributionAnalyticsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetContributionAnalyticsResponse>(
          create);
  static GetContributionAnalyticsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get contributionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set contributionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasContributionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearContributionId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get type => $_getSZ(1);
  @$pb.TagNumber(2)
  set type($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasType() => $_has(1);
  @$pb.TagNumber(2)
  void clearType() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get progressPercentage => $_getN(2);
  @$pb.TagNumber(3)
  set progressPercentage($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasProgressPercentage() => $_has(2);
  @$pb.TagNumber(3)
  void clearProgressPercentage() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get totalPayments => $_getIZ(3);
  @$pb.TagNumber(4)
  set totalPayments($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTotalPayments() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalPayments() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get averagePayment => $_getN(4);
  @$pb.TagNumber(5)
  set averagePayment($core.double value) => $_setDouble(4, value);
  @$pb.TagNumber(5)
  $core.bool hasAveragePayment() => $_has(4);
  @$pb.TagNumber(5)
  void clearAveragePayment() => $_clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get currentAmount => $_getI64(5);
  @$pb.TagNumber(6)
  set currentAmount($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasCurrentAmount() => $_has(5);
  @$pb.TagNumber(6)
  void clearCurrentAmount() => $_clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get targetAmount => $_getI64(6);
  @$pb.TagNumber(7)
  set targetAmount($fixnum.Int64 value) => $_setInt64(6, value);
  @$pb.TagNumber(7)
  $core.bool hasTargetAmount() => $_has(6);
  @$pb.TagNumber(7)
  void clearTargetAmount() => $_clearField(7);

  @$pb.TagNumber(8)
  GetContributionAnalyticsResponse_MemberParticipation
      get memberParticipation => $_getN(7);
  @$pb.TagNumber(8)
  set memberParticipation(
          GetContributionAnalyticsResponse_MemberParticipation value) =>
      $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasMemberParticipation() => $_has(7);
  @$pb.TagNumber(8)
  void clearMemberParticipation() => $_clearField(8);
  @$pb.TagNumber(8)
  GetContributionAnalyticsResponse_MemberParticipation
      ensureMemberParticipation() => $_ensure(7);

  @$pb.TagNumber(9)
  GetContributionAnalyticsResponse_Schedule get schedule => $_getN(8);
  @$pb.TagNumber(9)
  set schedule(GetContributionAnalyticsResponse_Schedule value) =>
      $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasSchedule() => $_has(8);
  @$pb.TagNumber(9)
  void clearSchedule() => $_clearField(9);
  @$pb.TagNumber(9)
  GetContributionAnalyticsResponse_Schedule ensureSchedule() => $_ensure(8);

  @$pb.TagNumber(10)
  GetContributionAnalyticsResponse_Payout get payout => $_getN(9);
  @$pb.TagNumber(10)
  set payout(GetContributionAnalyticsResponse_Payout value) =>
      $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasPayout() => $_has(9);
  @$pb.TagNumber(10)
  void clearPayout() => $_clearField(10);
  @$pb.TagNumber(10)
  GetContributionAnalyticsResponse_Payout ensurePayout() => $_ensure(9);

  @$pb.TagNumber(11)
  $core.String get memberStats => $_getSZ(10);
  @$pb.TagNumber(11)
  set memberStats($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasMemberStats() => $_has(10);
  @$pb.TagNumber(11)
  void clearMemberStats() => $_clearField(11);
}

class GroupPaginationInfo extends $pb.GeneratedMessage {
  factory GroupPaginationInfo({
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

  GroupPaginationInfo._();

  factory GroupPaginationInfo.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GroupPaginationInfo.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GroupPaginationInfo',
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
  GroupPaginationInfo clone() => GroupPaginationInfo()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GroupPaginationInfo copyWith(void Function(GroupPaginationInfo) updates) =>
      super.copyWith((message) => updates(message as GroupPaginationInfo))
          as GroupPaginationInfo;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GroupPaginationInfo create() => GroupPaginationInfo._();
  @$core.override
  GroupPaginationInfo createEmptyInstance() => create();
  static $pb.PbList<GroupPaginationInfo> createRepeated() =>
      $pb.PbList<GroupPaginationInfo>();
  @$core.pragma('dart2js:noInline')
  static GroupPaginationInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GroupPaginationInfo>(create);
  static GroupPaginationInfo? _defaultInstance;

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

class ContributionPaginationInfo extends $pb.GeneratedMessage {
  factory ContributionPaginationInfo({
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

  ContributionPaginationInfo._();

  factory ContributionPaginationInfo.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ContributionPaginationInfo.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ContributionPaginationInfo',
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
  ContributionPaginationInfo clone() =>
      ContributionPaginationInfo()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ContributionPaginationInfo copyWith(
          void Function(ContributionPaginationInfo) updates) =>
      super.copyWith(
              (message) => updates(message as ContributionPaginationInfo))
          as ContributionPaginationInfo;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ContributionPaginationInfo create() => ContributionPaginationInfo._();
  @$core.override
  ContributionPaginationInfo createEmptyInstance() => create();
  static $pb.PbList<ContributionPaginationInfo> createRepeated() =>
      $pb.PbList<ContributionPaginationInfo>();
  @$core.pragma('dart2js:noInline')
  static ContributionPaginationInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ContributionPaginationInfo>(create);
  static ContributionPaginationInfo? _defaultInstance;

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

class PaymentPaginationInfo extends $pb.GeneratedMessage {
  factory PaymentPaginationInfo({
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

  PaymentPaginationInfo._();

  factory PaymentPaginationInfo.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PaymentPaginationInfo.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PaymentPaginationInfo',
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
  PaymentPaginationInfo clone() =>
      PaymentPaginationInfo()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PaymentPaginationInfo copyWith(
          void Function(PaymentPaginationInfo) updates) =>
      super.copyWith((message) => updates(message as PaymentPaginationInfo))
          as PaymentPaginationInfo;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PaymentPaginationInfo create() => PaymentPaginationInfo._();
  @$core.override
  PaymentPaginationInfo createEmptyInstance() => create();
  static $pb.PbList<PaymentPaginationInfo> createRepeated() =>
      $pb.PbList<PaymentPaginationInfo>();
  @$core.pragma('dart2js:noInline')
  static PaymentPaginationInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PaymentPaginationInfo>(create);
  static PaymentPaginationInfo? _defaultInstance;

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

class ReceiptPaginationInfo extends $pb.GeneratedMessage {
  factory ReceiptPaginationInfo({
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

  ReceiptPaginationInfo._();

  factory ReceiptPaginationInfo.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ReceiptPaginationInfo.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ReceiptPaginationInfo',
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
  ReceiptPaginationInfo clone() =>
      ReceiptPaginationInfo()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReceiptPaginationInfo copyWith(
          void Function(ReceiptPaginationInfo) updates) =>
      super.copyWith((message) => updates(message as ReceiptPaginationInfo))
          as ReceiptPaginationInfo;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ReceiptPaginationInfo create() => ReceiptPaginationInfo._();
  @$core.override
  ReceiptPaginationInfo createEmptyInstance() => create();
  static $pb.PbList<ReceiptPaginationInfo> createRepeated() =>
      $pb.PbList<ReceiptPaginationInfo>();
  @$core.pragma('dart2js:noInline')
  static ReceiptPaginationInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ReceiptPaginationInfo>(create);
  static ReceiptPaginationInfo? _defaultInstance;

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

class ActivityLogPaginationInfo extends $pb.GeneratedMessage {
  factory ActivityLogPaginationInfo({
    $core.int? currentPage,
    $core.int? totalPages,
    $core.int? totalCount,
    $core.bool? hasMore,
  }) {
    final result = create();
    if (currentPage != null) result.currentPage = currentPage;
    if (totalPages != null) result.totalPages = totalPages;
    if (totalCount != null) result.totalCount = totalCount;
    if (hasMore != null) result.hasMore = hasMore;
    return result;
  }

  ActivityLogPaginationInfo._();

  factory ActivityLogPaginationInfo.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ActivityLogPaginationInfo.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ActivityLogPaginationInfo',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'currentPage', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'totalPages', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'totalCount', $pb.PbFieldType.O3)
    ..aOB(4, _omitFieldNames ? '' : 'hasMore')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ActivityLogPaginationInfo clone() =>
      ActivityLogPaginationInfo()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ActivityLogPaginationInfo copyWith(
          void Function(ActivityLogPaginationInfo) updates) =>
      super.copyWith((message) => updates(message as ActivityLogPaginationInfo))
          as ActivityLogPaginationInfo;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ActivityLogPaginationInfo create() => ActivityLogPaginationInfo._();
  @$core.override
  ActivityLogPaginationInfo createEmptyInstance() => create();
  static $pb.PbList<ActivityLogPaginationInfo> createRepeated() =>
      $pb.PbList<ActivityLogPaginationInfo>();
  @$core.pragma('dart2js:noInline')
  static ActivityLogPaginationInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ActivityLogPaginationInfo>(create);
  static ActivityLogPaginationInfo? _defaultInstance;

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
  $core.int get totalCount => $_getIZ(2);
  @$pb.TagNumber(3)
  set totalCount($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTotalCount() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalCount() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.bool get hasMore => $_getBF(3);
  @$pb.TagNumber(4)
  set hasMore($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasHasMore() => $_has(3);
  @$pb.TagNumber(4)
  void clearHasMore() => $_clearField(4);
}

class GroupActivityLogMessage extends $pb.GeneratedMessage {
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
    final result = create();
    if (id != null) result.id = id;
    if (groupId != null) result.groupId = groupId;
    if (contributionId != null) result.contributionId = contributionId;
    if (actorUserId != null) result.actorUserId = actorUserId;
    if (actorName != null) result.actorName = actorName;
    if (actionType != null) result.actionType = actionType;
    if (targetType != null) result.targetType = targetType;
    if (targetId != null) result.targetId = targetId;
    if (details != null) result.details = details;
    if (createdAt != null) result.createdAt = createdAt;
    return result;
  }

  GroupActivityLogMessage._();

  factory GroupActivityLogMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GroupActivityLogMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GroupActivityLogMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'groupId')
    ..aOS(3, _omitFieldNames ? '' : 'contributionId')
    ..aOS(4, _omitFieldNames ? '' : 'actorUserId')
    ..aOS(5, _omitFieldNames ? '' : 'actorName')
    ..aOS(6, _omitFieldNames ? '' : 'actionType')
    ..aOS(7, _omitFieldNames ? '' : 'targetType')
    ..aOS(8, _omitFieldNames ? '' : 'targetId')
    ..aOS(9, _omitFieldNames ? '' : 'details')
    ..aOM<$1.Timestamp>(10, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GroupActivityLogMessage clone() =>
      GroupActivityLogMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GroupActivityLogMessage copyWith(
          void Function(GroupActivityLogMessage) updates) =>
      super.copyWith((message) => updates(message as GroupActivityLogMessage))
          as GroupActivityLogMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GroupActivityLogMessage create() => GroupActivityLogMessage._();
  @$core.override
  GroupActivityLogMessage createEmptyInstance() => create();
  static $pb.PbList<GroupActivityLogMessage> createRepeated() =>
      $pb.PbList<GroupActivityLogMessage>();
  @$core.pragma('dart2js:noInline')
  static GroupActivityLogMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GroupActivityLogMessage>(create);
  static GroupActivityLogMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get groupId => $_getSZ(1);
  @$pb.TagNumber(2)
  set groupId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasGroupId() => $_has(1);
  @$pb.TagNumber(2)
  void clearGroupId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get contributionId => $_getSZ(2);
  @$pb.TagNumber(3)
  set contributionId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasContributionId() => $_has(2);
  @$pb.TagNumber(3)
  void clearContributionId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get actorUserId => $_getSZ(3);
  @$pb.TagNumber(4)
  set actorUserId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasActorUserId() => $_has(3);
  @$pb.TagNumber(4)
  void clearActorUserId() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get actorName => $_getSZ(4);
  @$pb.TagNumber(5)
  set actorName($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasActorName() => $_has(4);
  @$pb.TagNumber(5)
  void clearActorName() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get actionType => $_getSZ(5);
  @$pb.TagNumber(6)
  set actionType($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasActionType() => $_has(5);
  @$pb.TagNumber(6)
  void clearActionType() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get targetType => $_getSZ(6);
  @$pb.TagNumber(7)
  set targetType($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasTargetType() => $_has(6);
  @$pb.TagNumber(7)
  void clearTargetType() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get targetId => $_getSZ(7);
  @$pb.TagNumber(8)
  set targetId($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasTargetId() => $_has(7);
  @$pb.TagNumber(8)
  void clearTargetId() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get details => $_getSZ(8);
  @$pb.TagNumber(9)
  set details($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasDetails() => $_has(8);
  @$pb.TagNumber(9)
  void clearDetails() => $_clearField(9);

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

class GetGroupActivityLogsRequest extends $pb.GeneratedMessage {
  factory GetGroupActivityLogsRequest({
    $core.String? groupId,
    $core.int? page,
    $core.int? pageSize,
    $core.String? actionTypeFilter,
  }) {
    final result = create();
    if (groupId != null) result.groupId = groupId;
    if (page != null) result.page = page;
    if (pageSize != null) result.pageSize = pageSize;
    if (actionTypeFilter != null) result.actionTypeFilter = actionTypeFilter;
    return result;
  }

  GetGroupActivityLogsRequest._();

  factory GetGroupActivityLogsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetGroupActivityLogsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetGroupActivityLogsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'groupId')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOS(4, _omitFieldNames ? '' : 'actionTypeFilter')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetGroupActivityLogsRequest clone() =>
      GetGroupActivityLogsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetGroupActivityLogsRequest copyWith(
          void Function(GetGroupActivityLogsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetGroupActivityLogsRequest))
          as GetGroupActivityLogsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetGroupActivityLogsRequest create() =>
      GetGroupActivityLogsRequest._();
  @$core.override
  GetGroupActivityLogsRequest createEmptyInstance() => create();
  static $pb.PbList<GetGroupActivityLogsRequest> createRepeated() =>
      $pb.PbList<GetGroupActivityLogsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetGroupActivityLogsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetGroupActivityLogsRequest>(create);
  static GetGroupActivityLogsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get groupId => $_getSZ(0);
  @$pb.TagNumber(1)
  set groupId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasGroupId() => $_has(0);
  @$pb.TagNumber(1)
  void clearGroupId() => $_clearField(1);

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

  @$pb.TagNumber(4)
  $core.String get actionTypeFilter => $_getSZ(3);
  @$pb.TagNumber(4)
  set actionTypeFilter($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasActionTypeFilter() => $_has(3);
  @$pb.TagNumber(4)
  void clearActionTypeFilter() => $_clearField(4);
}

class GetGroupActivityLogsResponse extends $pb.GeneratedMessage {
  factory GetGroupActivityLogsResponse({
    $core.Iterable<GroupActivityLogMessage>? logs,
    ActivityLogPaginationInfo? pagination,
  }) {
    final result = create();
    if (logs != null) result.logs.addAll(logs);
    if (pagination != null) result.pagination = pagination;
    return result;
  }

  GetGroupActivityLogsResponse._();

  factory GetGroupActivityLogsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetGroupActivityLogsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetGroupActivityLogsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<GroupActivityLogMessage>(
        1, _omitFieldNames ? '' : 'logs', $pb.PbFieldType.PM,
        subBuilder: GroupActivityLogMessage.create)
    ..aOM<ActivityLogPaginationInfo>(2, _omitFieldNames ? '' : 'pagination',
        subBuilder: ActivityLogPaginationInfo.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetGroupActivityLogsResponse clone() =>
      GetGroupActivityLogsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetGroupActivityLogsResponse copyWith(
          void Function(GetGroupActivityLogsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetGroupActivityLogsResponse))
          as GetGroupActivityLogsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetGroupActivityLogsResponse create() =>
      GetGroupActivityLogsResponse._();
  @$core.override
  GetGroupActivityLogsResponse createEmptyInstance() => create();
  static $pb.PbList<GetGroupActivityLogsResponse> createRepeated() =>
      $pb.PbList<GetGroupActivityLogsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetGroupActivityLogsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetGroupActivityLogsResponse>(create);
  static GetGroupActivityLogsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<GroupActivityLogMessage> get logs => $_getList(0);

  @$pb.TagNumber(2)
  ActivityLogPaginationInfo get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination(ActivityLogPaginationInfo value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => $_clearField(2);
  @$pb.TagNumber(2)
  ActivityLogPaginationInfo ensurePagination() => $_ensure(1);
}

class GetContributionActivityLogsRequest extends $pb.GeneratedMessage {
  factory GetContributionActivityLogsRequest({
    $core.String? contributionId,
    $core.int? page,
    $core.int? pageSize,
  }) {
    final result = create();
    if (contributionId != null) result.contributionId = contributionId;
    if (page != null) result.page = page;
    if (pageSize != null) result.pageSize = pageSize;
    return result;
  }

  GetContributionActivityLogsRequest._();

  factory GetContributionActivityLogsRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetContributionActivityLogsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetContributionActivityLogsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'contributionId')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetContributionActivityLogsRequest clone() =>
      GetContributionActivityLogsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetContributionActivityLogsRequest copyWith(
          void Function(GetContributionActivityLogsRequest) updates) =>
      super.copyWith((message) =>
              updates(message as GetContributionActivityLogsRequest))
          as GetContributionActivityLogsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetContributionActivityLogsRequest create() =>
      GetContributionActivityLogsRequest._();
  @$core.override
  GetContributionActivityLogsRequest createEmptyInstance() => create();
  static $pb.PbList<GetContributionActivityLogsRequest> createRepeated() =>
      $pb.PbList<GetContributionActivityLogsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetContributionActivityLogsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetContributionActivityLogsRequest>(
          create);
  static GetContributionActivityLogsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get contributionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set contributionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasContributionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearContributionId() => $_clearField(1);

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

class GetContributionActivityLogsResponse extends $pb.GeneratedMessage {
  factory GetContributionActivityLogsResponse({
    $core.Iterable<GroupActivityLogMessage>? logs,
    ActivityLogPaginationInfo? pagination,
  }) {
    final result = create();
    if (logs != null) result.logs.addAll(logs);
    if (pagination != null) result.pagination = pagination;
    return result;
  }

  GetContributionActivityLogsResponse._();

  factory GetContributionActivityLogsResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetContributionActivityLogsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetContributionActivityLogsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<GroupActivityLogMessage>(
        1, _omitFieldNames ? '' : 'logs', $pb.PbFieldType.PM,
        subBuilder: GroupActivityLogMessage.create)
    ..aOM<ActivityLogPaginationInfo>(2, _omitFieldNames ? '' : 'pagination',
        subBuilder: ActivityLogPaginationInfo.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetContributionActivityLogsResponse clone() =>
      GetContributionActivityLogsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetContributionActivityLogsResponse copyWith(
          void Function(GetContributionActivityLogsResponse) updates) =>
      super.copyWith((message) =>
              updates(message as GetContributionActivityLogsResponse))
          as GetContributionActivityLogsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetContributionActivityLogsResponse create() =>
      GetContributionActivityLogsResponse._();
  @$core.override
  GetContributionActivityLogsResponse createEmptyInstance() => create();
  static $pb.PbList<GetContributionActivityLogsResponse> createRepeated() =>
      $pb.PbList<GetContributionActivityLogsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetContributionActivityLogsResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          GetContributionActivityLogsResponse>(create);
  static GetContributionActivityLogsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<GroupActivityLogMessage> get logs => $_getList(0);

  @$pb.TagNumber(2)
  ActivityLogPaginationInfo get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination(ActivityLogPaginationInfo value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => $_clearField(2);
  @$pb.TagNumber(2)
  ActivityLogPaginationInfo ensurePagination() => $_ensure(1);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
