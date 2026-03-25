// This is a generated file - do not edit.
//
// Generated from financial-products.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'financial-products.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'financial-products.pbenum.dart';

/// Group Account Models
class GroupAccount extends $pb.GeneratedMessage {
  factory GroupAccount({
    $core.String? id,
    $core.String? name,
    $core.String? description,
    $core.String? creatorId,
    $core.double? balance,
    $core.double? targetAmount,
    $core.String? status,
    $core.Iterable<GroupMember>? members,
    $core.String? withdrawalRules,
    $core.String? createdAt,
    $core.String? updatedAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (description != null) result.description = description;
    if (creatorId != null) result.creatorId = creatorId;
    if (balance != null) result.balance = balance;
    if (targetAmount != null) result.targetAmount = targetAmount;
    if (status != null) result.status = status;
    if (members != null) result.members.addAll(members);
    if (withdrawalRules != null) result.withdrawalRules = withdrawalRules;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    return result;
  }

  GroupAccount._();

  factory GroupAccount.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GroupAccount.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GroupAccount',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..aOS(4, _omitFieldNames ? '' : 'creatorId')
    ..a<$core.double>(5, _omitFieldNames ? '' : 'balance', $pb.PbFieldType.OD)
    ..a<$core.double>(
        6, _omitFieldNames ? '' : 'targetAmount', $pb.PbFieldType.OD)
    ..aOS(7, _omitFieldNames ? '' : 'status')
    ..pc<GroupMember>(8, _omitFieldNames ? '' : 'members', $pb.PbFieldType.PM,
        subBuilder: GroupMember.create)
    ..aOS(9, _omitFieldNames ? '' : 'withdrawalRules')
    ..aOS(10, _omitFieldNames ? '' : 'createdAt')
    ..aOS(11, _omitFieldNames ? '' : 'updatedAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GroupAccount clone() => GroupAccount()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GroupAccount copyWith(void Function(GroupAccount) updates) =>
      super.copyWith((message) => updates(message as GroupAccount))
          as GroupAccount;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GroupAccount create() => GroupAccount._();
  @$core.override
  GroupAccount createEmptyInstance() => create();
  static $pb.PbList<GroupAccount> createRepeated() =>
      $pb.PbList<GroupAccount>();
  @$core.pragma('dart2js:noInline')
  static GroupAccount getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GroupAccount>(create);
  static GroupAccount? _defaultInstance;

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
  $core.String get creatorId => $_getSZ(3);
  @$pb.TagNumber(4)
  set creatorId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCreatorId() => $_has(3);
  @$pb.TagNumber(4)
  void clearCreatorId() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get balance => $_getN(4);
  @$pb.TagNumber(5)
  set balance($core.double value) => $_setDouble(4, value);
  @$pb.TagNumber(5)
  $core.bool hasBalance() => $_has(4);
  @$pb.TagNumber(5)
  void clearBalance() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.double get targetAmount => $_getN(5);
  @$pb.TagNumber(6)
  set targetAmount($core.double value) => $_setDouble(5, value);
  @$pb.TagNumber(6)
  $core.bool hasTargetAmount() => $_has(5);
  @$pb.TagNumber(6)
  void clearTargetAmount() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get status => $_getSZ(6);
  @$pb.TagNumber(7)
  set status($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasStatus() => $_has(6);
  @$pb.TagNumber(7)
  void clearStatus() => $_clearField(7);

  @$pb.TagNumber(8)
  $pb.PbList<GroupMember> get members => $_getList(7);

  @$pb.TagNumber(9)
  $core.String get withdrawalRules => $_getSZ(8);
  @$pb.TagNumber(9)
  set withdrawalRules($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasWithdrawalRules() => $_has(8);
  @$pb.TagNumber(9)
  void clearWithdrawalRules() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get createdAt => $_getSZ(9);
  @$pb.TagNumber(10)
  set createdAt($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasCreatedAt() => $_has(9);
  @$pb.TagNumber(10)
  void clearCreatedAt() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get updatedAt => $_getSZ(10);
  @$pb.TagNumber(11)
  set updatedAt($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasUpdatedAt() => $_has(10);
  @$pb.TagNumber(11)
  void clearUpdatedAt() => $_clearField(11);
}

class GroupMember extends $pb.GeneratedMessage {
  factory GroupMember({
    $core.String? userId,
    $core.String? name,
    $core.String? role,
    $core.double? contribution,
    $core.String? joinedAt,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    if (name != null) result.name = name;
    if (role != null) result.role = role;
    if (contribution != null) result.contribution = contribution;
    if (joinedAt != null) result.joinedAt = joinedAt;
    return result;
  }

  GroupMember._();

  factory GroupMember.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GroupMember.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GroupMember',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'role')
    ..a<$core.double>(
        4, _omitFieldNames ? '' : 'contribution', $pb.PbFieldType.OD)
    ..aOS(5, _omitFieldNames ? '' : 'joinedAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GroupMember clone() => GroupMember()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GroupMember copyWith(void Function(GroupMember) updates) =>
      super.copyWith((message) => updates(message as GroupMember))
          as GroupMember;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GroupMember create() => GroupMember._();
  @$core.override
  GroupMember createEmptyInstance() => create();
  static $pb.PbList<GroupMember> createRepeated() => $pb.PbList<GroupMember>();
  @$core.pragma('dart2js:noInline')
  static GroupMember getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GroupMember>(create);
  static GroupMember? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get role => $_getSZ(2);
  @$pb.TagNumber(3)
  set role($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasRole() => $_has(2);
  @$pb.TagNumber(3)
  void clearRole() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get contribution => $_getN(3);
  @$pb.TagNumber(4)
  set contribution($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasContribution() => $_has(3);
  @$pb.TagNumber(4)
  void clearContribution() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get joinedAt => $_getSZ(4);
  @$pb.TagNumber(5)
  set joinedAt($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasJoinedAt() => $_has(4);
  @$pb.TagNumber(5)
  void clearJoinedAt() => $_clearField(5);
}

/// Insurance Models
class Insurance extends $pb.GeneratedMessage {
  factory Insurance({
    $core.String? id,
    $core.String? userId,
    $core.String? accountId,
    $core.String? policyNumber,
    $core.String? planId,
    $core.String? planName,
    $core.String? coverageType,
    $core.double? premium,
    $core.double? coverageAmount,
    $core.String? paymentFrequency,
    $core.String? status,
    $core.String? startDate,
    $core.String? endDate,
    $core.String? nextPaymentDate,
    $core.String? beneficiary,
    $core.String? metadata,
    $core.String? createdAt,
    $core.String? updatedAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (userId != null) result.userId = userId;
    if (accountId != null) result.accountId = accountId;
    if (policyNumber != null) result.policyNumber = policyNumber;
    if (planId != null) result.planId = planId;
    if (planName != null) result.planName = planName;
    if (coverageType != null) result.coverageType = coverageType;
    if (premium != null) result.premium = premium;
    if (coverageAmount != null) result.coverageAmount = coverageAmount;
    if (paymentFrequency != null) result.paymentFrequency = paymentFrequency;
    if (status != null) result.status = status;
    if (startDate != null) result.startDate = startDate;
    if (endDate != null) result.endDate = endDate;
    if (nextPaymentDate != null) result.nextPaymentDate = nextPaymentDate;
    if (beneficiary != null) result.beneficiary = beneficiary;
    if (metadata != null) result.metadata = metadata;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    return result;
  }

  Insurance._();

  factory Insurance.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Insurance.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Insurance',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'accountId')
    ..aOS(4, _omitFieldNames ? '' : 'policyNumber')
    ..aOS(5, _omitFieldNames ? '' : 'planId')
    ..aOS(6, _omitFieldNames ? '' : 'planName')
    ..aOS(7, _omitFieldNames ? '' : 'coverageType')
    ..a<$core.double>(8, _omitFieldNames ? '' : 'premium', $pb.PbFieldType.OD)
    ..a<$core.double>(
        9, _omitFieldNames ? '' : 'coverageAmount', $pb.PbFieldType.OD)
    ..aOS(10, _omitFieldNames ? '' : 'paymentFrequency')
    ..aOS(11, _omitFieldNames ? '' : 'status')
    ..aOS(12, _omitFieldNames ? '' : 'startDate')
    ..aOS(13, _omitFieldNames ? '' : 'endDate')
    ..aOS(14, _omitFieldNames ? '' : 'nextPaymentDate')
    ..aOS(15, _omitFieldNames ? '' : 'beneficiary')
    ..aOS(16, _omitFieldNames ? '' : 'metadata')
    ..aOS(17, _omitFieldNames ? '' : 'createdAt')
    ..aOS(18, _omitFieldNames ? '' : 'updatedAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Insurance clone() => Insurance()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Insurance copyWith(void Function(Insurance) updates) =>
      super.copyWith((message) => updates(message as Insurance)) as Insurance;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Insurance create() => Insurance._();
  @$core.override
  Insurance createEmptyInstance() => create();
  static $pb.PbList<Insurance> createRepeated() => $pb.PbList<Insurance>();
  @$core.pragma('dart2js:noInline')
  static Insurance getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Insurance>(create);
  static Insurance? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get accountId => $_getSZ(2);
  @$pb.TagNumber(3)
  set accountId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAccountId() => $_has(2);
  @$pb.TagNumber(3)
  void clearAccountId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get policyNumber => $_getSZ(3);
  @$pb.TagNumber(4)
  set policyNumber($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPolicyNumber() => $_has(3);
  @$pb.TagNumber(4)
  void clearPolicyNumber() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get planId => $_getSZ(4);
  @$pb.TagNumber(5)
  set planId($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasPlanId() => $_has(4);
  @$pb.TagNumber(5)
  void clearPlanId() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get planName => $_getSZ(5);
  @$pb.TagNumber(6)
  set planName($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasPlanName() => $_has(5);
  @$pb.TagNumber(6)
  void clearPlanName() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get coverageType => $_getSZ(6);
  @$pb.TagNumber(7)
  set coverageType($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasCoverageType() => $_has(6);
  @$pb.TagNumber(7)
  void clearCoverageType() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.double get premium => $_getN(7);
  @$pb.TagNumber(8)
  set premium($core.double value) => $_setDouble(7, value);
  @$pb.TagNumber(8)
  $core.bool hasPremium() => $_has(7);
  @$pb.TagNumber(8)
  void clearPremium() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.double get coverageAmount => $_getN(8);
  @$pb.TagNumber(9)
  set coverageAmount($core.double value) => $_setDouble(8, value);
  @$pb.TagNumber(9)
  $core.bool hasCoverageAmount() => $_has(8);
  @$pb.TagNumber(9)
  void clearCoverageAmount() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get paymentFrequency => $_getSZ(9);
  @$pb.TagNumber(10)
  set paymentFrequency($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasPaymentFrequency() => $_has(9);
  @$pb.TagNumber(10)
  void clearPaymentFrequency() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get status => $_getSZ(10);
  @$pb.TagNumber(11)
  set status($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasStatus() => $_has(10);
  @$pb.TagNumber(11)
  void clearStatus() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get startDate => $_getSZ(11);
  @$pb.TagNumber(12)
  set startDate($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasStartDate() => $_has(11);
  @$pb.TagNumber(12)
  void clearStartDate() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.String get endDate => $_getSZ(12);
  @$pb.TagNumber(13)
  set endDate($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasEndDate() => $_has(12);
  @$pb.TagNumber(13)
  void clearEndDate() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.String get nextPaymentDate => $_getSZ(13);
  @$pb.TagNumber(14)
  set nextPaymentDate($core.String value) => $_setString(13, value);
  @$pb.TagNumber(14)
  $core.bool hasNextPaymentDate() => $_has(13);
  @$pb.TagNumber(14)
  void clearNextPaymentDate() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.String get beneficiary => $_getSZ(14);
  @$pb.TagNumber(15)
  set beneficiary($core.String value) => $_setString(14, value);
  @$pb.TagNumber(15)
  $core.bool hasBeneficiary() => $_has(14);
  @$pb.TagNumber(15)
  void clearBeneficiary() => $_clearField(15);

  @$pb.TagNumber(16)
  $core.String get metadata => $_getSZ(15);
  @$pb.TagNumber(16)
  set metadata($core.String value) => $_setString(15, value);
  @$pb.TagNumber(16)
  $core.bool hasMetadata() => $_has(15);
  @$pb.TagNumber(16)
  void clearMetadata() => $_clearField(16);

  @$pb.TagNumber(17)
  $core.String get createdAt => $_getSZ(16);
  @$pb.TagNumber(17)
  set createdAt($core.String value) => $_setString(16, value);
  @$pb.TagNumber(17)
  $core.bool hasCreatedAt() => $_has(16);
  @$pb.TagNumber(17)
  void clearCreatedAt() => $_clearField(17);

  @$pb.TagNumber(18)
  $core.String get updatedAt => $_getSZ(17);
  @$pb.TagNumber(18)
  set updatedAt($core.String value) => $_setString(17, value);
  @$pb.TagNumber(18)
  $core.bool hasUpdatedAt() => $_has(17);
  @$pb.TagNumber(18)
  void clearUpdatedAt() => $_clearField(18);
}

class InsurancePlan extends $pb.GeneratedMessage {
  factory InsurancePlan({
    $core.String? id,
    $core.String? name,
    $core.String? coverageType,
    $core.String? description,
    $core.double? minPremium,
    $core.double? maxPremium,
    $core.double? coverageAmount,
    $core.Iterable<$core.String>? benefits,
    $core.String? terms,
    $core.bool? isActive,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (coverageType != null) result.coverageType = coverageType;
    if (description != null) result.description = description;
    if (minPremium != null) result.minPremium = minPremium;
    if (maxPremium != null) result.maxPremium = maxPremium;
    if (coverageAmount != null) result.coverageAmount = coverageAmount;
    if (benefits != null) result.benefits.addAll(benefits);
    if (terms != null) result.terms = terms;
    if (isActive != null) result.isActive = isActive;
    return result;
  }

  InsurancePlan._();

  factory InsurancePlan.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InsurancePlan.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InsurancePlan',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'coverageType')
    ..aOS(4, _omitFieldNames ? '' : 'description')
    ..a<$core.double>(
        5, _omitFieldNames ? '' : 'minPremium', $pb.PbFieldType.OD)
    ..a<$core.double>(
        6, _omitFieldNames ? '' : 'maxPremium', $pb.PbFieldType.OD)
    ..a<$core.double>(
        7, _omitFieldNames ? '' : 'coverageAmount', $pb.PbFieldType.OD)
    ..pPS(8, _omitFieldNames ? '' : 'benefits')
    ..aOS(9, _omitFieldNames ? '' : 'terms')
    ..aOB(10, _omitFieldNames ? '' : 'isActive')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InsurancePlan clone() => InsurancePlan()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InsurancePlan copyWith(void Function(InsurancePlan) updates) =>
      super.copyWith((message) => updates(message as InsurancePlan))
          as InsurancePlan;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InsurancePlan create() => InsurancePlan._();
  @$core.override
  InsurancePlan createEmptyInstance() => create();
  static $pb.PbList<InsurancePlan> createRepeated() =>
      $pb.PbList<InsurancePlan>();
  @$core.pragma('dart2js:noInline')
  static InsurancePlan getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InsurancePlan>(create);
  static InsurancePlan? _defaultInstance;

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
  $core.String get coverageType => $_getSZ(2);
  @$pb.TagNumber(3)
  set coverageType($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCoverageType() => $_has(2);
  @$pb.TagNumber(3)
  void clearCoverageType() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get description => $_getSZ(3);
  @$pb.TagNumber(4)
  set description($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDescription() => $_has(3);
  @$pb.TagNumber(4)
  void clearDescription() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get minPremium => $_getN(4);
  @$pb.TagNumber(5)
  set minPremium($core.double value) => $_setDouble(4, value);
  @$pb.TagNumber(5)
  $core.bool hasMinPremium() => $_has(4);
  @$pb.TagNumber(5)
  void clearMinPremium() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.double get maxPremium => $_getN(5);
  @$pb.TagNumber(6)
  set maxPremium($core.double value) => $_setDouble(5, value);
  @$pb.TagNumber(6)
  $core.bool hasMaxPremium() => $_has(5);
  @$pb.TagNumber(6)
  void clearMaxPremium() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.double get coverageAmount => $_getN(6);
  @$pb.TagNumber(7)
  set coverageAmount($core.double value) => $_setDouble(6, value);
  @$pb.TagNumber(7)
  $core.bool hasCoverageAmount() => $_has(6);
  @$pb.TagNumber(7)
  void clearCoverageAmount() => $_clearField(7);

  @$pb.TagNumber(8)
  $pb.PbList<$core.String> get benefits => $_getList(7);

  @$pb.TagNumber(9)
  $core.String get terms => $_getSZ(8);
  @$pb.TagNumber(9)
  set terms($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasTerms() => $_has(8);
  @$pb.TagNumber(9)
  void clearTerms() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.bool get isActive => $_getBF(9);
  @$pb.TagNumber(10)
  set isActive($core.bool value) => $_setBool(9, value);
  @$pb.TagNumber(10)
  $core.bool hasIsActive() => $_has(9);
  @$pb.TagNumber(10)
  void clearIsActive() => $_clearField(10);
}

class InsuranceClaim extends $pb.GeneratedMessage {
  factory InsuranceClaim({
    $core.String? id,
    $core.String? policyId,
    $core.String? userId,
    $core.double? claimAmount,
    $core.String? reason,
    $core.String? status,
    $core.String? documents,
    $core.String? createdAt,
    $core.String? updatedAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (policyId != null) result.policyId = policyId;
    if (userId != null) result.userId = userId;
    if (claimAmount != null) result.claimAmount = claimAmount;
    if (reason != null) result.reason = reason;
    if (status != null) result.status = status;
    if (documents != null) result.documents = documents;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    return result;
  }

  InsuranceClaim._();

  factory InsuranceClaim.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InsuranceClaim.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InsuranceClaim',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'policyId')
    ..aOS(3, _omitFieldNames ? '' : 'userId')
    ..a<$core.double>(
        4, _omitFieldNames ? '' : 'claimAmount', $pb.PbFieldType.OD)
    ..aOS(5, _omitFieldNames ? '' : 'reason')
    ..aOS(6, _omitFieldNames ? '' : 'status')
    ..aOS(7, _omitFieldNames ? '' : 'documents')
    ..aOS(8, _omitFieldNames ? '' : 'createdAt')
    ..aOS(9, _omitFieldNames ? '' : 'updatedAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InsuranceClaim clone() => InsuranceClaim()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InsuranceClaim copyWith(void Function(InsuranceClaim) updates) =>
      super.copyWith((message) => updates(message as InsuranceClaim))
          as InsuranceClaim;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InsuranceClaim create() => InsuranceClaim._();
  @$core.override
  InsuranceClaim createEmptyInstance() => create();
  static $pb.PbList<InsuranceClaim> createRepeated() =>
      $pb.PbList<InsuranceClaim>();
  @$core.pragma('dart2js:noInline')
  static InsuranceClaim getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InsuranceClaim>(create);
  static InsuranceClaim? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get policyId => $_getSZ(1);
  @$pb.TagNumber(2)
  set policyId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPolicyId() => $_has(1);
  @$pb.TagNumber(2)
  void clearPolicyId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get userId => $_getSZ(2);
  @$pb.TagNumber(3)
  set userId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasUserId() => $_has(2);
  @$pb.TagNumber(3)
  void clearUserId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get claimAmount => $_getN(3);
  @$pb.TagNumber(4)
  set claimAmount($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasClaimAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearClaimAmount() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get reason => $_getSZ(4);
  @$pb.TagNumber(5)
  set reason($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasReason() => $_has(4);
  @$pb.TagNumber(5)
  void clearReason() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get status => $_getSZ(5);
  @$pb.TagNumber(6)
  set status($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasStatus() => $_has(5);
  @$pb.TagNumber(6)
  void clearStatus() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get documents => $_getSZ(6);
  @$pb.TagNumber(7)
  set documents($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasDocuments() => $_has(6);
  @$pb.TagNumber(7)
  void clearDocuments() => $_clearField(7);

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

/// Crowdfund Models
class Crowdfund extends $pb.GeneratedMessage {
  factory Crowdfund({
    $core.String? id,
    $core.String? userId,
    $core.String? accountId,
    $core.String? title,
    $core.String? description,
    $core.String? category,
    $core.double? targetAmount,
    $core.double? currentAmount,
    $core.double? percentageFunded,
    $core.int? totalContributors,
    $core.String? status,
    $core.String? imageUrl,
    $core.String? deadline,
    $core.String? createdAt,
    $core.String? updatedAt,
    $core.String? crowdfundCode,
    $core.String? creatorFirstName,
    $core.String? creatorLastName,
    $core.String? creatorUsername,
    $core.String? creatorEmail,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (userId != null) result.userId = userId;
    if (accountId != null) result.accountId = accountId;
    if (title != null) result.title = title;
    if (description != null) result.description = description;
    if (category != null) result.category = category;
    if (targetAmount != null) result.targetAmount = targetAmount;
    if (currentAmount != null) result.currentAmount = currentAmount;
    if (percentageFunded != null) result.percentageFunded = percentageFunded;
    if (totalContributors != null) result.totalContributors = totalContributors;
    if (status != null) result.status = status;
    if (imageUrl != null) result.imageUrl = imageUrl;
    if (deadline != null) result.deadline = deadline;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    if (crowdfundCode != null) result.crowdfundCode = crowdfundCode;
    if (creatorFirstName != null) result.creatorFirstName = creatorFirstName;
    if (creatorLastName != null) result.creatorLastName = creatorLastName;
    if (creatorUsername != null) result.creatorUsername = creatorUsername;
    if (creatorEmail != null) result.creatorEmail = creatorEmail;
    return result;
  }

  Crowdfund._();

  factory Crowdfund.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Crowdfund.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Crowdfund',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'accountId')
    ..aOS(4, _omitFieldNames ? '' : 'title')
    ..aOS(5, _omitFieldNames ? '' : 'description')
    ..aOS(6, _omitFieldNames ? '' : 'category')
    ..a<$core.double>(
        7, _omitFieldNames ? '' : 'targetAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(
        8, _omitFieldNames ? '' : 'currentAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(
        9, _omitFieldNames ? '' : 'percentageFunded', $pb.PbFieldType.OD)
    ..a<$core.int>(
        10, _omitFieldNames ? '' : 'totalContributors', $pb.PbFieldType.O3)
    ..aOS(11, _omitFieldNames ? '' : 'status')
    ..aOS(12, _omitFieldNames ? '' : 'imageUrl')
    ..aOS(13, _omitFieldNames ? '' : 'deadline')
    ..aOS(14, _omitFieldNames ? '' : 'createdAt')
    ..aOS(15, _omitFieldNames ? '' : 'updatedAt')
    ..aOS(16, _omitFieldNames ? '' : 'crowdfundCode')
    ..aOS(17, _omitFieldNames ? '' : 'creatorFirstName')
    ..aOS(18, _omitFieldNames ? '' : 'creatorLastName')
    ..aOS(19, _omitFieldNames ? '' : 'creatorUsername')
    ..aOS(20, _omitFieldNames ? '' : 'creatorEmail')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Crowdfund clone() => Crowdfund()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Crowdfund copyWith(void Function(Crowdfund) updates) =>
      super.copyWith((message) => updates(message as Crowdfund)) as Crowdfund;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Crowdfund create() => Crowdfund._();
  @$core.override
  Crowdfund createEmptyInstance() => create();
  static $pb.PbList<Crowdfund> createRepeated() => $pb.PbList<Crowdfund>();
  @$core.pragma('dart2js:noInline')
  static Crowdfund getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Crowdfund>(create);
  static Crowdfund? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get accountId => $_getSZ(2);
  @$pb.TagNumber(3)
  set accountId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAccountId() => $_has(2);
  @$pb.TagNumber(3)
  void clearAccountId() => $_clearField(3);

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
  $core.String get category => $_getSZ(5);
  @$pb.TagNumber(6)
  set category($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasCategory() => $_has(5);
  @$pb.TagNumber(6)
  void clearCategory() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.double get targetAmount => $_getN(6);
  @$pb.TagNumber(7)
  set targetAmount($core.double value) => $_setDouble(6, value);
  @$pb.TagNumber(7)
  $core.bool hasTargetAmount() => $_has(6);
  @$pb.TagNumber(7)
  void clearTargetAmount() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.double get currentAmount => $_getN(7);
  @$pb.TagNumber(8)
  set currentAmount($core.double value) => $_setDouble(7, value);
  @$pb.TagNumber(8)
  $core.bool hasCurrentAmount() => $_has(7);
  @$pb.TagNumber(8)
  void clearCurrentAmount() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.double get percentageFunded => $_getN(8);
  @$pb.TagNumber(9)
  set percentageFunded($core.double value) => $_setDouble(8, value);
  @$pb.TagNumber(9)
  $core.bool hasPercentageFunded() => $_has(8);
  @$pb.TagNumber(9)
  void clearPercentageFunded() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.int get totalContributors => $_getIZ(9);
  @$pb.TagNumber(10)
  set totalContributors($core.int value) => $_setSignedInt32(9, value);
  @$pb.TagNumber(10)
  $core.bool hasTotalContributors() => $_has(9);
  @$pb.TagNumber(10)
  void clearTotalContributors() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get status => $_getSZ(10);
  @$pb.TagNumber(11)
  set status($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasStatus() => $_has(10);
  @$pb.TagNumber(11)
  void clearStatus() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get imageUrl => $_getSZ(11);
  @$pb.TagNumber(12)
  set imageUrl($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasImageUrl() => $_has(11);
  @$pb.TagNumber(12)
  void clearImageUrl() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.String get deadline => $_getSZ(12);
  @$pb.TagNumber(13)
  set deadline($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasDeadline() => $_has(12);
  @$pb.TagNumber(13)
  void clearDeadline() => $_clearField(13);

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

  @$pb.TagNumber(16)
  $core.String get crowdfundCode => $_getSZ(15);
  @$pb.TagNumber(16)
  set crowdfundCode($core.String value) => $_setString(15, value);
  @$pb.TagNumber(16)
  $core.bool hasCrowdfundCode() => $_has(15);
  @$pb.TagNumber(16)
  void clearCrowdfundCode() => $_clearField(16);

  @$pb.TagNumber(17)
  $core.String get creatorFirstName => $_getSZ(16);
  @$pb.TagNumber(17)
  set creatorFirstName($core.String value) => $_setString(16, value);
  @$pb.TagNumber(17)
  $core.bool hasCreatorFirstName() => $_has(16);
  @$pb.TagNumber(17)
  void clearCreatorFirstName() => $_clearField(17);

  @$pb.TagNumber(18)
  $core.String get creatorLastName => $_getSZ(17);
  @$pb.TagNumber(18)
  set creatorLastName($core.String value) => $_setString(17, value);
  @$pb.TagNumber(18)
  $core.bool hasCreatorLastName() => $_has(17);
  @$pb.TagNumber(18)
  void clearCreatorLastName() => $_clearField(18);

  @$pb.TagNumber(19)
  $core.String get creatorUsername => $_getSZ(18);
  @$pb.TagNumber(19)
  set creatorUsername($core.String value) => $_setString(18, value);
  @$pb.TagNumber(19)
  $core.bool hasCreatorUsername() => $_has(18);
  @$pb.TagNumber(19)
  void clearCreatorUsername() => $_clearField(19);

  @$pb.TagNumber(20)
  $core.String get creatorEmail => $_getSZ(19);
  @$pb.TagNumber(20)
  set creatorEmail($core.String value) => $_setString(19, value);
  @$pb.TagNumber(20)
  $core.bool hasCreatorEmail() => $_has(19);
  @$pb.TagNumber(20)
  void clearCreatorEmail() => $_clearField(20);
}

class CrowdfundContribution extends $pb.GeneratedMessage {
  factory CrowdfundContribution({
    $core.String? id,
    $core.String? crowdfundId,
    $core.String? userId,
    $core.double? amount,
    $core.String? message,
    $core.bool? isAnonymous,
    $core.String? createdAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (crowdfundId != null) result.crowdfundId = crowdfundId;
    if (userId != null) result.userId = userId;
    if (amount != null) result.amount = amount;
    if (message != null) result.message = message;
    if (isAnonymous != null) result.isAnonymous = isAnonymous;
    if (createdAt != null) result.createdAt = createdAt;
    return result;
  }

  CrowdfundContribution._();

  factory CrowdfundContribution.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CrowdfundContribution.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CrowdfundContribution',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'crowdfundId')
    ..aOS(3, _omitFieldNames ? '' : 'userId')
    ..a<$core.double>(4, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(5, _omitFieldNames ? '' : 'message')
    ..aOB(6, _omitFieldNames ? '' : 'isAnonymous')
    ..aOS(7, _omitFieldNames ? '' : 'createdAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CrowdfundContribution clone() =>
      CrowdfundContribution()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CrowdfundContribution copyWith(
          void Function(CrowdfundContribution) updates) =>
      super.copyWith((message) => updates(message as CrowdfundContribution))
          as CrowdfundContribution;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CrowdfundContribution create() => CrowdfundContribution._();
  @$core.override
  CrowdfundContribution createEmptyInstance() => create();
  static $pb.PbList<CrowdfundContribution> createRepeated() =>
      $pb.PbList<CrowdfundContribution>();
  @$core.pragma('dart2js:noInline')
  static CrowdfundContribution getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CrowdfundContribution>(create);
  static CrowdfundContribution? _defaultInstance;

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
  $core.String get userId => $_getSZ(2);
  @$pb.TagNumber(3)
  set userId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasUserId() => $_has(2);
  @$pb.TagNumber(3)
  void clearUserId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get amount => $_getN(3);
  @$pb.TagNumber(4)
  set amount($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearAmount() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get message => $_getSZ(4);
  @$pb.TagNumber(5)
  set message($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasMessage() => $_has(4);
  @$pb.TagNumber(5)
  void clearMessage() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.bool get isAnonymous => $_getBF(5);
  @$pb.TagNumber(6)
  set isAnonymous($core.bool value) => $_setBool(5, value);
  @$pb.TagNumber(6)
  $core.bool hasIsAnonymous() => $_has(5);
  @$pb.TagNumber(6)
  void clearIsAnonymous() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get createdAt => $_getSZ(6);
  @$pb.TagNumber(7)
  set createdAt($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasCreatedAt() => $_has(6);
  @$pb.TagNumber(7)
  void clearCreatedAt() => $_clearField(7);
}

/// NOTE: user_id extracted from JWT token, not from request
class CreateGroupAccountRequest extends $pb.GeneratedMessage {
  factory CreateGroupAccountRequest({
    $core.String? accountId,
    $core.String? name,
    $core.String? description,
    $core.double? targetAmount,
    $core.String? withdrawalRules,
    $core.Iterable<$core.String>? memberIds,
  }) {
    final result = create();
    if (accountId != null) result.accountId = accountId;
    if (name != null) result.name = name;
    if (description != null) result.description = description;
    if (targetAmount != null) result.targetAmount = targetAmount;
    if (withdrawalRules != null) result.withdrawalRules = withdrawalRules;
    if (memberIds != null) result.memberIds.addAll(memberIds);
    return result;
  }

  CreateGroupAccountRequest._();

  factory CreateGroupAccountRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateGroupAccountRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateGroupAccountRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountId')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..a<$core.double>(
        4, _omitFieldNames ? '' : 'targetAmount', $pb.PbFieldType.OD)
    ..aOS(5, _omitFieldNames ? '' : 'withdrawalRules')
    ..pPS(6, _omitFieldNames ? '' : 'memberIds')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateGroupAccountRequest clone() =>
      CreateGroupAccountRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateGroupAccountRequest copyWith(
          void Function(CreateGroupAccountRequest) updates) =>
      super.copyWith((message) => updates(message as CreateGroupAccountRequest))
          as CreateGroupAccountRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateGroupAccountRequest create() => CreateGroupAccountRequest._();
  @$core.override
  CreateGroupAccountRequest createEmptyInstance() => create();
  static $pb.PbList<CreateGroupAccountRequest> createRepeated() =>
      $pb.PbList<CreateGroupAccountRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateGroupAccountRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateGroupAccountRequest>(create);
  static CreateGroupAccountRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => $_clearField(1);

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
  $core.double get targetAmount => $_getN(3);
  @$pb.TagNumber(4)
  set targetAmount($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTargetAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearTargetAmount() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get withdrawalRules => $_getSZ(4);
  @$pb.TagNumber(5)
  set withdrawalRules($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasWithdrawalRules() => $_has(4);
  @$pb.TagNumber(5)
  void clearWithdrawalRules() => $_clearField(5);

  @$pb.TagNumber(6)
  $pb.PbList<$core.String> get memberIds => $_getList(5);
}

class CreateGroupAccountResponse extends $pb.GeneratedMessage {
  factory CreateGroupAccountResponse({
    GroupAccount? groupAccount,
    $core.String? message,
  }) {
    final result = create();
    if (groupAccount != null) result.groupAccount = groupAccount;
    if (message != null) result.message = message;
    return result;
  }

  CreateGroupAccountResponse._();

  factory CreateGroupAccountResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateGroupAccountResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateGroupAccountResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOM<GroupAccount>(1, _omitFieldNames ? '' : 'groupAccount',
        subBuilder: GroupAccount.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateGroupAccountResponse clone() =>
      CreateGroupAccountResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateGroupAccountResponse copyWith(
          void Function(CreateGroupAccountResponse) updates) =>
      super.copyWith(
              (message) => updates(message as CreateGroupAccountResponse))
          as CreateGroupAccountResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateGroupAccountResponse create() => CreateGroupAccountResponse._();
  @$core.override
  CreateGroupAccountResponse createEmptyInstance() => create();
  static $pb.PbList<CreateGroupAccountResponse> createRepeated() =>
      $pb.PbList<CreateGroupAccountResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateGroupAccountResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateGroupAccountResponse>(create);
  static CreateGroupAccountResponse? _defaultInstance;

  @$pb.TagNumber(1)
  GroupAccount get groupAccount => $_getN(0);
  @$pb.TagNumber(1)
  set groupAccount(GroupAccount value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasGroupAccount() => $_has(0);
  @$pb.TagNumber(1)
  void clearGroupAccount() => $_clearField(1);
  @$pb.TagNumber(1)
  GroupAccount ensureGroupAccount() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);
}

/// NOTE: user_id extracted from JWT token, not from request
class GetGroupAccountsRequest extends $pb.GeneratedMessage {
  factory GetGroupAccountsRequest({
    $core.String? status,
    $core.int? limit,
    $core.int? offset,
  }) {
    final result = create();
    if (status != null) result.status = status;
    if (limit != null) result.limit = limit;
    if (offset != null) result.offset = offset;
    return result;
  }

  GetGroupAccountsRequest._();

  factory GetGroupAccountsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetGroupAccountsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetGroupAccountsRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'status')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetGroupAccountsRequest clone() =>
      GetGroupAccountsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetGroupAccountsRequest copyWith(
          void Function(GetGroupAccountsRequest) updates) =>
      super.copyWith((message) => updates(message as GetGroupAccountsRequest))
          as GetGroupAccountsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetGroupAccountsRequest create() => GetGroupAccountsRequest._();
  @$core.override
  GetGroupAccountsRequest createEmptyInstance() => create();
  static $pb.PbList<GetGroupAccountsRequest> createRepeated() =>
      $pb.PbList<GetGroupAccountsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetGroupAccountsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetGroupAccountsRequest>(create);
  static GetGroupAccountsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get status => $_getSZ(0);
  @$pb.TagNumber(1)
  set status($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get limit => $_getIZ(1);
  @$pb.TagNumber(2)
  set limit($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearLimit() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get offset => $_getIZ(2);
  @$pb.TagNumber(3)
  set offset($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasOffset() => $_has(2);
  @$pb.TagNumber(3)
  void clearOffset() => $_clearField(3);
}

class GetGroupAccountsResponse extends $pb.GeneratedMessage {
  factory GetGroupAccountsResponse({
    $core.Iterable<GroupAccount>? groupAccounts,
    $core.int? total,
  }) {
    final result = create();
    if (groupAccounts != null) result.groupAccounts.addAll(groupAccounts);
    if (total != null) result.total = total;
    return result;
  }

  GetGroupAccountsResponse._();

  factory GetGroupAccountsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetGroupAccountsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetGroupAccountsResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..pc<GroupAccount>(
        1, _omitFieldNames ? '' : 'groupAccounts', $pb.PbFieldType.PM,
        subBuilder: GroupAccount.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetGroupAccountsResponse clone() =>
      GetGroupAccountsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetGroupAccountsResponse copyWith(
          void Function(GetGroupAccountsResponse) updates) =>
      super.copyWith((message) => updates(message as GetGroupAccountsResponse))
          as GetGroupAccountsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetGroupAccountsResponse create() => GetGroupAccountsResponse._();
  @$core.override
  GetGroupAccountsResponse createEmptyInstance() => create();
  static $pb.PbList<GetGroupAccountsResponse> createRepeated() =>
      $pb.PbList<GetGroupAccountsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetGroupAccountsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetGroupAccountsResponse>(create);
  static GetGroupAccountsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<GroupAccount> get groupAccounts => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);
}

/// NOTE: user_id extracted from JWT token, not from request
class GetGroupAccountRequest extends $pb.GeneratedMessage {
  factory GetGroupAccountRequest({
    $core.String? groupId,
  }) {
    final result = create();
    if (groupId != null) result.groupId = groupId;
    return result;
  }

  GetGroupAccountRequest._();

  factory GetGroupAccountRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetGroupAccountRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetGroupAccountRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'groupId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetGroupAccountRequest clone() =>
      GetGroupAccountRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetGroupAccountRequest copyWith(
          void Function(GetGroupAccountRequest) updates) =>
      super.copyWith((message) => updates(message as GetGroupAccountRequest))
          as GetGroupAccountRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetGroupAccountRequest create() => GetGroupAccountRequest._();
  @$core.override
  GetGroupAccountRequest createEmptyInstance() => create();
  static $pb.PbList<GetGroupAccountRequest> createRepeated() =>
      $pb.PbList<GetGroupAccountRequest>();
  @$core.pragma('dart2js:noInline')
  static GetGroupAccountRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetGroupAccountRequest>(create);
  static GetGroupAccountRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get groupId => $_getSZ(0);
  @$pb.TagNumber(1)
  set groupId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasGroupId() => $_has(0);
  @$pb.TagNumber(1)
  void clearGroupId() => $_clearField(1);
}

class GetGroupAccountResponse extends $pb.GeneratedMessage {
  factory GetGroupAccountResponse({
    GroupAccount? groupAccount,
  }) {
    final result = create();
    if (groupAccount != null) result.groupAccount = groupAccount;
    return result;
  }

  GetGroupAccountResponse._();

  factory GetGroupAccountResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetGroupAccountResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetGroupAccountResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOM<GroupAccount>(1, _omitFieldNames ? '' : 'groupAccount',
        subBuilder: GroupAccount.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetGroupAccountResponse clone() =>
      GetGroupAccountResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetGroupAccountResponse copyWith(
          void Function(GetGroupAccountResponse) updates) =>
      super.copyWith((message) => updates(message as GetGroupAccountResponse))
          as GetGroupAccountResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetGroupAccountResponse create() => GetGroupAccountResponse._();
  @$core.override
  GetGroupAccountResponse createEmptyInstance() => create();
  static $pb.PbList<GetGroupAccountResponse> createRepeated() =>
      $pb.PbList<GetGroupAccountResponse>();
  @$core.pragma('dart2js:noInline')
  static GetGroupAccountResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetGroupAccountResponse>(create);
  static GetGroupAccountResponse? _defaultInstance;

  @$pb.TagNumber(1)
  GroupAccount get groupAccount => $_getN(0);
  @$pb.TagNumber(1)
  set groupAccount(GroupAccount value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasGroupAccount() => $_has(0);
  @$pb.TagNumber(1)
  void clearGroupAccount() => $_clearField(1);
  @$pb.TagNumber(1)
  GroupAccount ensureGroupAccount() => $_ensure(0);
}

/// NOTE: user_id extracted from JWT token, not from request
class AddGroupMemberRequest extends $pb.GeneratedMessage {
  factory AddGroupMemberRequest({
    $core.String? groupId,
    $core.String? memberId,
    $core.String? role,
  }) {
    final result = create();
    if (groupId != null) result.groupId = groupId;
    if (memberId != null) result.memberId = memberId;
    if (role != null) result.role = role;
    return result;
  }

  AddGroupMemberRequest._();

  factory AddGroupMemberRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AddGroupMemberRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AddGroupMemberRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'groupId')
    ..aOS(2, _omitFieldNames ? '' : 'memberId')
    ..aOS(3, _omitFieldNames ? '' : 'role')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddGroupMemberRequest clone() =>
      AddGroupMemberRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddGroupMemberRequest copyWith(
          void Function(AddGroupMemberRequest) updates) =>
      super.copyWith((message) => updates(message as AddGroupMemberRequest))
          as AddGroupMemberRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddGroupMemberRequest create() => AddGroupMemberRequest._();
  @$core.override
  AddGroupMemberRequest createEmptyInstance() => create();
  static $pb.PbList<AddGroupMemberRequest> createRepeated() =>
      $pb.PbList<AddGroupMemberRequest>();
  @$core.pragma('dart2js:noInline')
  static AddGroupMemberRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AddGroupMemberRequest>(create);
  static AddGroupMemberRequest? _defaultInstance;

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
  $core.String get role => $_getSZ(2);
  @$pb.TagNumber(3)
  set role($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasRole() => $_has(2);
  @$pb.TagNumber(3)
  void clearRole() => $_clearField(3);
}

class AddGroupMemberResponse extends $pb.GeneratedMessage {
  factory AddGroupMemberResponse({
    GroupAccount? groupAccount,
    $core.String? message,
  }) {
    final result = create();
    if (groupAccount != null) result.groupAccount = groupAccount;
    if (message != null) result.message = message;
    return result;
  }

  AddGroupMemberResponse._();

  factory AddGroupMemberResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AddGroupMemberResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AddGroupMemberResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOM<GroupAccount>(1, _omitFieldNames ? '' : 'groupAccount',
        subBuilder: GroupAccount.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddGroupMemberResponse clone() =>
      AddGroupMemberResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddGroupMemberResponse copyWith(
          void Function(AddGroupMemberResponse) updates) =>
      super.copyWith((message) => updates(message as AddGroupMemberResponse))
          as AddGroupMemberResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddGroupMemberResponse create() => AddGroupMemberResponse._();
  @$core.override
  AddGroupMemberResponse createEmptyInstance() => create();
  static $pb.PbList<AddGroupMemberResponse> createRepeated() =>
      $pb.PbList<AddGroupMemberResponse>();
  @$core.pragma('dart2js:noInline')
  static AddGroupMemberResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AddGroupMemberResponse>(create);
  static AddGroupMemberResponse? _defaultInstance;

  @$pb.TagNumber(1)
  GroupAccount get groupAccount => $_getN(0);
  @$pb.TagNumber(1)
  set groupAccount(GroupAccount value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasGroupAccount() => $_has(0);
  @$pb.TagNumber(1)
  void clearGroupAccount() => $_clearField(1);
  @$pb.TagNumber(1)
  GroupAccount ensureGroupAccount() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);
}

/// NOTE: user_id extracted from JWT token, not from request
class RemoveGroupMemberRequest extends $pb.GeneratedMessage {
  factory RemoveGroupMemberRequest({
    $core.String? groupId,
    $core.String? memberId,
  }) {
    final result = create();
    if (groupId != null) result.groupId = groupId;
    if (memberId != null) result.memberId = memberId;
    return result;
  }

  RemoveGroupMemberRequest._();

  factory RemoveGroupMemberRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RemoveGroupMemberRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RemoveGroupMemberRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'groupId')
    ..aOS(2, _omitFieldNames ? '' : 'memberId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RemoveGroupMemberRequest clone() =>
      RemoveGroupMemberRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RemoveGroupMemberRequest copyWith(
          void Function(RemoveGroupMemberRequest) updates) =>
      super.copyWith((message) => updates(message as RemoveGroupMemberRequest))
          as RemoveGroupMemberRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RemoveGroupMemberRequest create() => RemoveGroupMemberRequest._();
  @$core.override
  RemoveGroupMemberRequest createEmptyInstance() => create();
  static $pb.PbList<RemoveGroupMemberRequest> createRepeated() =>
      $pb.PbList<RemoveGroupMemberRequest>();
  @$core.pragma('dart2js:noInline')
  static RemoveGroupMemberRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RemoveGroupMemberRequest>(create);
  static RemoveGroupMemberRequest? _defaultInstance;

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

class RemoveGroupMemberResponse extends $pb.GeneratedMessage {
  factory RemoveGroupMemberResponse({
    GroupAccount? groupAccount,
    $core.String? message,
  }) {
    final result = create();
    if (groupAccount != null) result.groupAccount = groupAccount;
    if (message != null) result.message = message;
    return result;
  }

  RemoveGroupMemberResponse._();

  factory RemoveGroupMemberResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RemoveGroupMemberResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RemoveGroupMemberResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOM<GroupAccount>(1, _omitFieldNames ? '' : 'groupAccount',
        subBuilder: GroupAccount.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RemoveGroupMemberResponse clone() =>
      RemoveGroupMemberResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RemoveGroupMemberResponse copyWith(
          void Function(RemoveGroupMemberResponse) updates) =>
      super.copyWith((message) => updates(message as RemoveGroupMemberResponse))
          as RemoveGroupMemberResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RemoveGroupMemberResponse create() => RemoveGroupMemberResponse._();
  @$core.override
  RemoveGroupMemberResponse createEmptyInstance() => create();
  static $pb.PbList<RemoveGroupMemberResponse> createRepeated() =>
      $pb.PbList<RemoveGroupMemberResponse>();
  @$core.pragma('dart2js:noInline')
  static RemoveGroupMemberResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RemoveGroupMemberResponse>(create);
  static RemoveGroupMemberResponse? _defaultInstance;

  @$pb.TagNumber(1)
  GroupAccount get groupAccount => $_getN(0);
  @$pb.TagNumber(1)
  set groupAccount(GroupAccount value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasGroupAccount() => $_has(0);
  @$pb.TagNumber(1)
  void clearGroupAccount() => $_clearField(1);
  @$pb.TagNumber(1)
  GroupAccount ensureGroupAccount() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);
}

/// NOTE: user_id extracted from JWT token, not from request
class ContributeToGroupRequest extends $pb.GeneratedMessage {
  factory ContributeToGroupRequest({
    $core.String? groupId,
    $core.String? accountId,
    $core.double? amount,
    $core.String? pin,
  }) {
    final result = create();
    if (groupId != null) result.groupId = groupId;
    if (accountId != null) result.accountId = accountId;
    if (amount != null) result.amount = amount;
    if (pin != null) result.pin = pin;
    return result;
  }

  ContributeToGroupRequest._();

  factory ContributeToGroupRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ContributeToGroupRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ContributeToGroupRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'groupId')
    ..aOS(2, _omitFieldNames ? '' : 'accountId')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(4, _omitFieldNames ? '' : 'pin')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ContributeToGroupRequest clone() =>
      ContributeToGroupRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ContributeToGroupRequest copyWith(
          void Function(ContributeToGroupRequest) updates) =>
      super.copyWith((message) => updates(message as ContributeToGroupRequest))
          as ContributeToGroupRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ContributeToGroupRequest create() => ContributeToGroupRequest._();
  @$core.override
  ContributeToGroupRequest createEmptyInstance() => create();
  static $pb.PbList<ContributeToGroupRequest> createRepeated() =>
      $pb.PbList<ContributeToGroupRequest>();
  @$core.pragma('dart2js:noInline')
  static ContributeToGroupRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ContributeToGroupRequest>(create);
  static ContributeToGroupRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get groupId => $_getSZ(0);
  @$pb.TagNumber(1)
  set groupId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasGroupId() => $_has(0);
  @$pb.TagNumber(1)
  void clearGroupId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get accountId => $_getSZ(1);
  @$pb.TagNumber(2)
  set accountId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAccountId() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccountId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get amount => $_getN(2);
  @$pb.TagNumber(3)
  set amount($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get pin => $_getSZ(3);
  @$pb.TagNumber(4)
  set pin($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPin() => $_has(3);
  @$pb.TagNumber(4)
  void clearPin() => $_clearField(4);
}

class ContributeToGroupResponse extends $pb.GeneratedMessage {
  factory ContributeToGroupResponse({
    GroupAccount? groupAccount,
    $core.double? newBalance,
    $core.String? message,
  }) {
    final result = create();
    if (groupAccount != null) result.groupAccount = groupAccount;
    if (newBalance != null) result.newBalance = newBalance;
    if (message != null) result.message = message;
    return result;
  }

  ContributeToGroupResponse._();

  factory ContributeToGroupResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ContributeToGroupResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ContributeToGroupResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOM<GroupAccount>(1, _omitFieldNames ? '' : 'groupAccount',
        subBuilder: GroupAccount.create)
    ..a<$core.double>(
        2, _omitFieldNames ? '' : 'newBalance', $pb.PbFieldType.OD)
    ..aOS(3, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ContributeToGroupResponse clone() =>
      ContributeToGroupResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ContributeToGroupResponse copyWith(
          void Function(ContributeToGroupResponse) updates) =>
      super.copyWith((message) => updates(message as ContributeToGroupResponse))
          as ContributeToGroupResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ContributeToGroupResponse create() => ContributeToGroupResponse._();
  @$core.override
  ContributeToGroupResponse createEmptyInstance() => create();
  static $pb.PbList<ContributeToGroupResponse> createRepeated() =>
      $pb.PbList<ContributeToGroupResponse>();
  @$core.pragma('dart2js:noInline')
  static ContributeToGroupResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ContributeToGroupResponse>(create);
  static ContributeToGroupResponse? _defaultInstance;

  @$pb.TagNumber(1)
  GroupAccount get groupAccount => $_getN(0);
  @$pb.TagNumber(1)
  set groupAccount(GroupAccount value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasGroupAccount() => $_has(0);
  @$pb.TagNumber(1)
  void clearGroupAccount() => $_clearField(1);
  @$pb.TagNumber(1)
  GroupAccount ensureGroupAccount() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.double get newBalance => $_getN(1);
  @$pb.TagNumber(2)
  set newBalance($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNewBalance() => $_has(1);
  @$pb.TagNumber(2)
  void clearNewBalance() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => $_clearField(3);
}

/// NOTE: user_id extracted from JWT token, not from request
class WithdrawFromGroupRequest extends $pb.GeneratedMessage {
  factory WithdrawFromGroupRequest({
    $core.String? groupId,
    $core.double? amount,
    $core.String? reason,
    $core.String? pin,
  }) {
    final result = create();
    if (groupId != null) result.groupId = groupId;
    if (amount != null) result.amount = amount;
    if (reason != null) result.reason = reason;
    if (pin != null) result.pin = pin;
    return result;
  }

  WithdrawFromGroupRequest._();

  factory WithdrawFromGroupRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory WithdrawFromGroupRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'WithdrawFromGroupRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'groupId')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(3, _omitFieldNames ? '' : 'reason')
    ..aOS(4, _omitFieldNames ? '' : 'pin')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WithdrawFromGroupRequest clone() =>
      WithdrawFromGroupRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WithdrawFromGroupRequest copyWith(
          void Function(WithdrawFromGroupRequest) updates) =>
      super.copyWith((message) => updates(message as WithdrawFromGroupRequest))
          as WithdrawFromGroupRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WithdrawFromGroupRequest create() => WithdrawFromGroupRequest._();
  @$core.override
  WithdrawFromGroupRequest createEmptyInstance() => create();
  static $pb.PbList<WithdrawFromGroupRequest> createRepeated() =>
      $pb.PbList<WithdrawFromGroupRequest>();
  @$core.pragma('dart2js:noInline')
  static WithdrawFromGroupRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<WithdrawFromGroupRequest>(create);
  static WithdrawFromGroupRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get groupId => $_getSZ(0);
  @$pb.TagNumber(1)
  set groupId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasGroupId() => $_has(0);
  @$pb.TagNumber(1)
  void clearGroupId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get amount => $_getN(1);
  @$pb.TagNumber(2)
  set amount($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get reason => $_getSZ(2);
  @$pb.TagNumber(3)
  set reason($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasReason() => $_has(2);
  @$pb.TagNumber(3)
  void clearReason() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get pin => $_getSZ(3);
  @$pb.TagNumber(4)
  set pin($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPin() => $_has(3);
  @$pb.TagNumber(4)
  void clearPin() => $_clearField(4);
}

class WithdrawFromGroupResponse extends $pb.GeneratedMessage {
  factory WithdrawFromGroupResponse({
    GroupAccount? groupAccount,
    $core.String? message,
  }) {
    final result = create();
    if (groupAccount != null) result.groupAccount = groupAccount;
    if (message != null) result.message = message;
    return result;
  }

  WithdrawFromGroupResponse._();

  factory WithdrawFromGroupResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory WithdrawFromGroupResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'WithdrawFromGroupResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOM<GroupAccount>(1, _omitFieldNames ? '' : 'groupAccount',
        subBuilder: GroupAccount.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WithdrawFromGroupResponse clone() =>
      WithdrawFromGroupResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WithdrawFromGroupResponse copyWith(
          void Function(WithdrawFromGroupResponse) updates) =>
      super.copyWith((message) => updates(message as WithdrawFromGroupResponse))
          as WithdrawFromGroupResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WithdrawFromGroupResponse create() => WithdrawFromGroupResponse._();
  @$core.override
  WithdrawFromGroupResponse createEmptyInstance() => create();
  static $pb.PbList<WithdrawFromGroupResponse> createRepeated() =>
      $pb.PbList<WithdrawFromGroupResponse>();
  @$core.pragma('dart2js:noInline')
  static WithdrawFromGroupResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<WithdrawFromGroupResponse>(create);
  static WithdrawFromGroupResponse? _defaultInstance;

  @$pb.TagNumber(1)
  GroupAccount get groupAccount => $_getN(0);
  @$pb.TagNumber(1)
  set groupAccount(GroupAccount value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasGroupAccount() => $_has(0);
  @$pb.TagNumber(1)
  void clearGroupAccount() => $_clearField(1);
  @$pb.TagNumber(1)
  GroupAccount ensureGroupAccount() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);
}

/// NOTE: user_id extracted from JWT token, not from request
class CloseGroupAccountRequest extends $pb.GeneratedMessage {
  factory CloseGroupAccountRequest({
    $core.String? groupId,
    $core.String? pin,
  }) {
    final result = create();
    if (groupId != null) result.groupId = groupId;
    if (pin != null) result.pin = pin;
    return result;
  }

  CloseGroupAccountRequest._();

  factory CloseGroupAccountRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CloseGroupAccountRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CloseGroupAccountRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'groupId')
    ..aOS(2, _omitFieldNames ? '' : 'pin')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CloseGroupAccountRequest clone() =>
      CloseGroupAccountRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CloseGroupAccountRequest copyWith(
          void Function(CloseGroupAccountRequest) updates) =>
      super.copyWith((message) => updates(message as CloseGroupAccountRequest))
          as CloseGroupAccountRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CloseGroupAccountRequest create() => CloseGroupAccountRequest._();
  @$core.override
  CloseGroupAccountRequest createEmptyInstance() => create();
  static $pb.PbList<CloseGroupAccountRequest> createRepeated() =>
      $pb.PbList<CloseGroupAccountRequest>();
  @$core.pragma('dart2js:noInline')
  static CloseGroupAccountRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CloseGroupAccountRequest>(create);
  static CloseGroupAccountRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get groupId => $_getSZ(0);
  @$pb.TagNumber(1)
  set groupId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasGroupId() => $_has(0);
  @$pb.TagNumber(1)
  void clearGroupId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get pin => $_getSZ(1);
  @$pb.TagNumber(2)
  set pin($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPin() => $_has(1);
  @$pb.TagNumber(2)
  void clearPin() => $_clearField(2);
}

class CloseGroupAccountResponse extends $pb.GeneratedMessage {
  factory CloseGroupAccountResponse({
    GroupAccount? groupAccount,
    $core.String? message,
  }) {
    final result = create();
    if (groupAccount != null) result.groupAccount = groupAccount;
    if (message != null) result.message = message;
    return result;
  }

  CloseGroupAccountResponse._();

  factory CloseGroupAccountResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CloseGroupAccountResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CloseGroupAccountResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOM<GroupAccount>(1, _omitFieldNames ? '' : 'groupAccount',
        subBuilder: GroupAccount.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CloseGroupAccountResponse clone() =>
      CloseGroupAccountResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CloseGroupAccountResponse copyWith(
          void Function(CloseGroupAccountResponse) updates) =>
      super.copyWith((message) => updates(message as CloseGroupAccountResponse))
          as CloseGroupAccountResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CloseGroupAccountResponse create() => CloseGroupAccountResponse._();
  @$core.override
  CloseGroupAccountResponse createEmptyInstance() => create();
  static $pb.PbList<CloseGroupAccountResponse> createRepeated() =>
      $pb.PbList<CloseGroupAccountResponse>();
  @$core.pragma('dart2js:noInline')
  static CloseGroupAccountResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CloseGroupAccountResponse>(create);
  static CloseGroupAccountResponse? _defaultInstance;

  @$pb.TagNumber(1)
  GroupAccount get groupAccount => $_getN(0);
  @$pb.TagNumber(1)
  set groupAccount(GroupAccount value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasGroupAccount() => $_has(0);
  @$pb.TagNumber(1)
  void clearGroupAccount() => $_clearField(1);
  @$pb.TagNumber(1)
  GroupAccount ensureGroupAccount() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);
}

/// NOTE: user_id extracted from JWT token, not from request
class BuyInsuranceRequest extends $pb.GeneratedMessage {
  factory BuyInsuranceRequest({
    $core.String? accountId,
    $core.String? planId,
    $core.double? coverageAmount,
    $core.String? paymentFrequency,
    $core.String? beneficiary,
    $core.String? pin,
  }) {
    final result = create();
    if (accountId != null) result.accountId = accountId;
    if (planId != null) result.planId = planId;
    if (coverageAmount != null) result.coverageAmount = coverageAmount;
    if (paymentFrequency != null) result.paymentFrequency = paymentFrequency;
    if (beneficiary != null) result.beneficiary = beneficiary;
    if (pin != null) result.pin = pin;
    return result;
  }

  BuyInsuranceRequest._();

  factory BuyInsuranceRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory BuyInsuranceRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BuyInsuranceRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountId')
    ..aOS(2, _omitFieldNames ? '' : 'planId')
    ..a<$core.double>(
        3, _omitFieldNames ? '' : 'coverageAmount', $pb.PbFieldType.OD)
    ..aOS(4, _omitFieldNames ? '' : 'paymentFrequency')
    ..aOS(5, _omitFieldNames ? '' : 'beneficiary')
    ..aOS(6, _omitFieldNames ? '' : 'pin')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BuyInsuranceRequest clone() => BuyInsuranceRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BuyInsuranceRequest copyWith(void Function(BuyInsuranceRequest) updates) =>
      super.copyWith((message) => updates(message as BuyInsuranceRequest))
          as BuyInsuranceRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BuyInsuranceRequest create() => BuyInsuranceRequest._();
  @$core.override
  BuyInsuranceRequest createEmptyInstance() => create();
  static $pb.PbList<BuyInsuranceRequest> createRepeated() =>
      $pb.PbList<BuyInsuranceRequest>();
  @$core.pragma('dart2js:noInline')
  static BuyInsuranceRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BuyInsuranceRequest>(create);
  static BuyInsuranceRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get planId => $_getSZ(1);
  @$pb.TagNumber(2)
  set planId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPlanId() => $_has(1);
  @$pb.TagNumber(2)
  void clearPlanId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get coverageAmount => $_getN(2);
  @$pb.TagNumber(3)
  set coverageAmount($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCoverageAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearCoverageAmount() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get paymentFrequency => $_getSZ(3);
  @$pb.TagNumber(4)
  set paymentFrequency($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPaymentFrequency() => $_has(3);
  @$pb.TagNumber(4)
  void clearPaymentFrequency() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get beneficiary => $_getSZ(4);
  @$pb.TagNumber(5)
  set beneficiary($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasBeneficiary() => $_has(4);
  @$pb.TagNumber(5)
  void clearBeneficiary() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get pin => $_getSZ(5);
  @$pb.TagNumber(6)
  set pin($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasPin() => $_has(5);
  @$pb.TagNumber(6)
  void clearPin() => $_clearField(6);
}

class BuyInsuranceResponse extends $pb.GeneratedMessage {
  factory BuyInsuranceResponse({
    Insurance? insurance,
    $core.double? firstPremium,
    $core.double? newBalance,
    $core.String? message,
  }) {
    final result = create();
    if (insurance != null) result.insurance = insurance;
    if (firstPremium != null) result.firstPremium = firstPremium;
    if (newBalance != null) result.newBalance = newBalance;
    if (message != null) result.message = message;
    return result;
  }

  BuyInsuranceResponse._();

  factory BuyInsuranceResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory BuyInsuranceResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BuyInsuranceResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOM<Insurance>(1, _omitFieldNames ? '' : 'insurance',
        subBuilder: Insurance.create)
    ..a<$core.double>(
        2, _omitFieldNames ? '' : 'firstPremium', $pb.PbFieldType.OD)
    ..a<$core.double>(
        3, _omitFieldNames ? '' : 'newBalance', $pb.PbFieldType.OD)
    ..aOS(4, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BuyInsuranceResponse clone() =>
      BuyInsuranceResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BuyInsuranceResponse copyWith(void Function(BuyInsuranceResponse) updates) =>
      super.copyWith((message) => updates(message as BuyInsuranceResponse))
          as BuyInsuranceResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BuyInsuranceResponse create() => BuyInsuranceResponse._();
  @$core.override
  BuyInsuranceResponse createEmptyInstance() => create();
  static $pb.PbList<BuyInsuranceResponse> createRepeated() =>
      $pb.PbList<BuyInsuranceResponse>();
  @$core.pragma('dart2js:noInline')
  static BuyInsuranceResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BuyInsuranceResponse>(create);
  static BuyInsuranceResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Insurance get insurance => $_getN(0);
  @$pb.TagNumber(1)
  set insurance(Insurance value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasInsurance() => $_has(0);
  @$pb.TagNumber(1)
  void clearInsurance() => $_clearField(1);
  @$pb.TagNumber(1)
  Insurance ensureInsurance() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.double get firstPremium => $_getN(1);
  @$pb.TagNumber(2)
  set firstPremium($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasFirstPremium() => $_has(1);
  @$pb.TagNumber(2)
  void clearFirstPremium() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get newBalance => $_getN(2);
  @$pb.TagNumber(3)
  set newBalance($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasNewBalance() => $_has(2);
  @$pb.TagNumber(3)
  void clearNewBalance() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get message => $_getSZ(3);
  @$pb.TagNumber(4)
  set message($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMessage() => $_has(3);
  @$pb.TagNumber(4)
  void clearMessage() => $_clearField(4);
}

/// NOTE: user_id extracted from JWT token, not from request
class GetInsurancePoliciesRequest extends $pb.GeneratedMessage {
  factory GetInsurancePoliciesRequest({
    $core.String? status,
    $core.int? limit,
    $core.int? offset,
  }) {
    final result = create();
    if (status != null) result.status = status;
    if (limit != null) result.limit = limit;
    if (offset != null) result.offset = offset;
    return result;
  }

  GetInsurancePoliciesRequest._();

  factory GetInsurancePoliciesRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetInsurancePoliciesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetInsurancePoliciesRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'status')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsurancePoliciesRequest clone() =>
      GetInsurancePoliciesRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsurancePoliciesRequest copyWith(
          void Function(GetInsurancePoliciesRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetInsurancePoliciesRequest))
          as GetInsurancePoliciesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInsurancePoliciesRequest create() =>
      GetInsurancePoliciesRequest._();
  @$core.override
  GetInsurancePoliciesRequest createEmptyInstance() => create();
  static $pb.PbList<GetInsurancePoliciesRequest> createRepeated() =>
      $pb.PbList<GetInsurancePoliciesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInsurancePoliciesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetInsurancePoliciesRequest>(create);
  static GetInsurancePoliciesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get status => $_getSZ(0);
  @$pb.TagNumber(1)
  set status($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get limit => $_getIZ(1);
  @$pb.TagNumber(2)
  set limit($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearLimit() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get offset => $_getIZ(2);
  @$pb.TagNumber(3)
  set offset($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasOffset() => $_has(2);
  @$pb.TagNumber(3)
  void clearOffset() => $_clearField(3);
}

class GetInsurancePoliciesResponse extends $pb.GeneratedMessage {
  factory GetInsurancePoliciesResponse({
    $core.Iterable<Insurance>? policies,
    $core.int? total,
    $core.double? totalCoverage,
    $core.double? totalPremiumsPaid,
  }) {
    final result = create();
    if (policies != null) result.policies.addAll(policies);
    if (total != null) result.total = total;
    if (totalCoverage != null) result.totalCoverage = totalCoverage;
    if (totalPremiumsPaid != null) result.totalPremiumsPaid = totalPremiumsPaid;
    return result;
  }

  GetInsurancePoliciesResponse._();

  factory GetInsurancePoliciesResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetInsurancePoliciesResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetInsurancePoliciesResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..pc<Insurance>(1, _omitFieldNames ? '' : 'policies', $pb.PbFieldType.PM,
        subBuilder: Insurance.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..a<$core.double>(
        3, _omitFieldNames ? '' : 'totalCoverage', $pb.PbFieldType.OD)
    ..a<$core.double>(
        4, _omitFieldNames ? '' : 'totalPremiumsPaid', $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsurancePoliciesResponse clone() =>
      GetInsurancePoliciesResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsurancePoliciesResponse copyWith(
          void Function(GetInsurancePoliciesResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetInsurancePoliciesResponse))
          as GetInsurancePoliciesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInsurancePoliciesResponse create() =>
      GetInsurancePoliciesResponse._();
  @$core.override
  GetInsurancePoliciesResponse createEmptyInstance() => create();
  static $pb.PbList<GetInsurancePoliciesResponse> createRepeated() =>
      $pb.PbList<GetInsurancePoliciesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInsurancePoliciesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetInsurancePoliciesResponse>(create);
  static GetInsurancePoliciesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Insurance> get policies => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get totalCoverage => $_getN(2);
  @$pb.TagNumber(3)
  set totalCoverage($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTotalCoverage() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalCoverage() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get totalPremiumsPaid => $_getN(3);
  @$pb.TagNumber(4)
  set totalPremiumsPaid($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTotalPremiumsPaid() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalPremiumsPaid() => $_clearField(4);
}

/// NOTE: user_id extracted from JWT token, not from request
class GetInsurancePolicyRequest extends $pb.GeneratedMessage {
  factory GetInsurancePolicyRequest({
    $core.String? policyId,
  }) {
    final result = create();
    if (policyId != null) result.policyId = policyId;
    return result;
  }

  GetInsurancePolicyRequest._();

  factory GetInsurancePolicyRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetInsurancePolicyRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetInsurancePolicyRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'policyId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsurancePolicyRequest clone() =>
      GetInsurancePolicyRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsurancePolicyRequest copyWith(
          void Function(GetInsurancePolicyRequest) updates) =>
      super.copyWith((message) => updates(message as GetInsurancePolicyRequest))
          as GetInsurancePolicyRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInsurancePolicyRequest create() => GetInsurancePolicyRequest._();
  @$core.override
  GetInsurancePolicyRequest createEmptyInstance() => create();
  static $pb.PbList<GetInsurancePolicyRequest> createRepeated() =>
      $pb.PbList<GetInsurancePolicyRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInsurancePolicyRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetInsurancePolicyRequest>(create);
  static GetInsurancePolicyRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get policyId => $_getSZ(0);
  @$pb.TagNumber(1)
  set policyId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPolicyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPolicyId() => $_clearField(1);
}

class GetInsurancePolicyResponse extends $pb.GeneratedMessage {
  factory GetInsurancePolicyResponse({
    Insurance? insurance,
  }) {
    final result = create();
    if (insurance != null) result.insurance = insurance;
    return result;
  }

  GetInsurancePolicyResponse._();

  factory GetInsurancePolicyResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetInsurancePolicyResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetInsurancePolicyResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOM<Insurance>(1, _omitFieldNames ? '' : 'insurance',
        subBuilder: Insurance.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsurancePolicyResponse clone() =>
      GetInsurancePolicyResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsurancePolicyResponse copyWith(
          void Function(GetInsurancePolicyResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetInsurancePolicyResponse))
          as GetInsurancePolicyResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInsurancePolicyResponse create() => GetInsurancePolicyResponse._();
  @$core.override
  GetInsurancePolicyResponse createEmptyInstance() => create();
  static $pb.PbList<GetInsurancePolicyResponse> createRepeated() =>
      $pb.PbList<GetInsurancePolicyResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInsurancePolicyResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetInsurancePolicyResponse>(create);
  static GetInsurancePolicyResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Insurance get insurance => $_getN(0);
  @$pb.TagNumber(1)
  set insurance(Insurance value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasInsurance() => $_has(0);
  @$pb.TagNumber(1)
  void clearInsurance() => $_clearField(1);
  @$pb.TagNumber(1)
  Insurance ensureInsurance() => $_ensure(0);
}

/// NOTE: user_id extracted from JWT token, not from request
class MakeInsuranceClaimRequest extends $pb.GeneratedMessage {
  factory MakeInsuranceClaimRequest({
    $core.String? policyId,
    $core.double? claimAmount,
    $core.String? reason,
    $core.Iterable<$core.String>? documents,
    $core.String? claimType,
    $core.String? title,
    $core.String? incidentDate,
    $core.String? incidentLocation,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? additionalInfo,
    $core.String? idempotencyKey,
    $core.String? currency,
    $core.Iterable<$core.String>? attachments,
  }) {
    final result = create();
    if (policyId != null) result.policyId = policyId;
    if (claimAmount != null) result.claimAmount = claimAmount;
    if (reason != null) result.reason = reason;
    if (documents != null) result.documents.addAll(documents);
    if (claimType != null) result.claimType = claimType;
    if (title != null) result.title = title;
    if (incidentDate != null) result.incidentDate = incidentDate;
    if (incidentLocation != null) result.incidentLocation = incidentLocation;
    if (additionalInfo != null)
      result.additionalInfo.addEntries(additionalInfo);
    if (idempotencyKey != null) result.idempotencyKey = idempotencyKey;
    if (currency != null) result.currency = currency;
    if (attachments != null) result.attachments.addAll(attachments);
    return result;
  }

  MakeInsuranceClaimRequest._();

  factory MakeInsuranceClaimRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MakeInsuranceClaimRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MakeInsuranceClaimRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'policyId')
    ..a<$core.double>(
        2, _omitFieldNames ? '' : 'claimAmount', $pb.PbFieldType.OD)
    ..aOS(3, _omitFieldNames ? '' : 'reason')
    ..pPS(4, _omitFieldNames ? '' : 'documents')
    ..aOS(5, _omitFieldNames ? '' : 'claimType')
    ..aOS(6, _omitFieldNames ? '' : 'title')
    ..aOS(7, _omitFieldNames ? '' : 'incidentDate')
    ..aOS(8, _omitFieldNames ? '' : 'incidentLocation')
    ..m<$core.String, $core.String>(9, _omitFieldNames ? '' : 'additionalInfo',
        entryClassName: 'MakeInsuranceClaimRequest.AdditionalInfoEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('financialproducts'))
    ..aOS(10, _omitFieldNames ? '' : 'idempotencyKey')
    ..aOS(11, _omitFieldNames ? '' : 'currency')
    ..pPS(12, _omitFieldNames ? '' : 'attachments')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MakeInsuranceClaimRequest clone() =>
      MakeInsuranceClaimRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MakeInsuranceClaimRequest copyWith(
          void Function(MakeInsuranceClaimRequest) updates) =>
      super.copyWith((message) => updates(message as MakeInsuranceClaimRequest))
          as MakeInsuranceClaimRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MakeInsuranceClaimRequest create() => MakeInsuranceClaimRequest._();
  @$core.override
  MakeInsuranceClaimRequest createEmptyInstance() => create();
  static $pb.PbList<MakeInsuranceClaimRequest> createRepeated() =>
      $pb.PbList<MakeInsuranceClaimRequest>();
  @$core.pragma('dart2js:noInline')
  static MakeInsuranceClaimRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MakeInsuranceClaimRequest>(create);
  static MakeInsuranceClaimRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get policyId => $_getSZ(0);
  @$pb.TagNumber(1)
  set policyId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPolicyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPolicyId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get claimAmount => $_getN(1);
  @$pb.TagNumber(2)
  set claimAmount($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasClaimAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearClaimAmount() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get reason => $_getSZ(2);
  @$pb.TagNumber(3)
  set reason($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasReason() => $_has(2);
  @$pb.TagNumber(3)
  void clearReason() => $_clearField(3);

  @$pb.TagNumber(4)
  $pb.PbList<$core.String> get documents => $_getList(3);

  @$pb.TagNumber(5)
  $core.String get claimType => $_getSZ(4);
  @$pb.TagNumber(5)
  set claimType($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasClaimType() => $_has(4);
  @$pb.TagNumber(5)
  void clearClaimType() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get title => $_getSZ(5);
  @$pb.TagNumber(6)
  set title($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasTitle() => $_has(5);
  @$pb.TagNumber(6)
  void clearTitle() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get incidentDate => $_getSZ(6);
  @$pb.TagNumber(7)
  set incidentDate($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasIncidentDate() => $_has(6);
  @$pb.TagNumber(7)
  void clearIncidentDate() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get incidentLocation => $_getSZ(7);
  @$pb.TagNumber(8)
  set incidentLocation($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasIncidentLocation() => $_has(7);
  @$pb.TagNumber(8)
  void clearIncidentLocation() => $_clearField(8);

  @$pb.TagNumber(9)
  $pb.PbMap<$core.String, $core.String> get additionalInfo => $_getMap(8);

  @$pb.TagNumber(10)
  $core.String get idempotencyKey => $_getSZ(9);
  @$pb.TagNumber(10)
  set idempotencyKey($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasIdempotencyKey() => $_has(9);
  @$pb.TagNumber(10)
  void clearIdempotencyKey() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get currency => $_getSZ(10);
  @$pb.TagNumber(11)
  set currency($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasCurrency() => $_has(10);
  @$pb.TagNumber(11)
  void clearCurrency() => $_clearField(11);

  @$pb.TagNumber(12)
  $pb.PbList<$core.String> get attachments => $_getList(11);
}

class MakeInsuranceClaimResponse extends $pb.GeneratedMessage {
  factory MakeInsuranceClaimResponse({
    InsuranceClaimRecord? claim,
    $core.String? message,
  }) {
    final result = create();
    if (claim != null) result.claim = claim;
    if (message != null) result.message = message;
    return result;
  }

  MakeInsuranceClaimResponse._();

  factory MakeInsuranceClaimResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MakeInsuranceClaimResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MakeInsuranceClaimResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOM<InsuranceClaimRecord>(1, _omitFieldNames ? '' : 'claim',
        subBuilder: InsuranceClaimRecord.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MakeInsuranceClaimResponse clone() =>
      MakeInsuranceClaimResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MakeInsuranceClaimResponse copyWith(
          void Function(MakeInsuranceClaimResponse) updates) =>
      super.copyWith(
              (message) => updates(message as MakeInsuranceClaimResponse))
          as MakeInsuranceClaimResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MakeInsuranceClaimResponse create() => MakeInsuranceClaimResponse._();
  @$core.override
  MakeInsuranceClaimResponse createEmptyInstance() => create();
  static $pb.PbList<MakeInsuranceClaimResponse> createRepeated() =>
      $pb.PbList<MakeInsuranceClaimResponse>();
  @$core.pragma('dart2js:noInline')
  static MakeInsuranceClaimResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MakeInsuranceClaimResponse>(create);
  static MakeInsuranceClaimResponse? _defaultInstance;

  @$pb.TagNumber(1)
  InsuranceClaimRecord get claim => $_getN(0);
  @$pb.TagNumber(1)
  set claim(InsuranceClaimRecord value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasClaim() => $_has(0);
  @$pb.TagNumber(1)
  void clearClaim() => $_clearField(1);
  @$pb.TagNumber(1)
  InsuranceClaimRecord ensureClaim() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);
}

/// NOTE: user_id extracted from JWT token, not from request
class CancelInsuranceRequest extends $pb.GeneratedMessage {
  factory CancelInsuranceRequest({
    $core.String? policyId,
    $core.String? reason,
  }) {
    final result = create();
    if (policyId != null) result.policyId = policyId;
    if (reason != null) result.reason = reason;
    return result;
  }

  CancelInsuranceRequest._();

  factory CancelInsuranceRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CancelInsuranceRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CancelInsuranceRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'policyId')
    ..aOS(2, _omitFieldNames ? '' : 'reason')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CancelInsuranceRequest clone() =>
      CancelInsuranceRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CancelInsuranceRequest copyWith(
          void Function(CancelInsuranceRequest) updates) =>
      super.copyWith((message) => updates(message as CancelInsuranceRequest))
          as CancelInsuranceRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CancelInsuranceRequest create() => CancelInsuranceRequest._();
  @$core.override
  CancelInsuranceRequest createEmptyInstance() => create();
  static $pb.PbList<CancelInsuranceRequest> createRepeated() =>
      $pb.PbList<CancelInsuranceRequest>();
  @$core.pragma('dart2js:noInline')
  static CancelInsuranceRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CancelInsuranceRequest>(create);
  static CancelInsuranceRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get policyId => $_getSZ(0);
  @$pb.TagNumber(1)
  set policyId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPolicyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPolicyId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get reason => $_getSZ(1);
  @$pb.TagNumber(2)
  set reason($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasReason() => $_has(1);
  @$pb.TagNumber(2)
  void clearReason() => $_clearField(2);
}

class CancelInsuranceResponse extends $pb.GeneratedMessage {
  factory CancelInsuranceResponse({
    Insurance? insurance,
    $core.String? message,
  }) {
    final result = create();
    if (insurance != null) result.insurance = insurance;
    if (message != null) result.message = message;
    return result;
  }

  CancelInsuranceResponse._();

  factory CancelInsuranceResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CancelInsuranceResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CancelInsuranceResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOM<Insurance>(1, _omitFieldNames ? '' : 'insurance',
        subBuilder: Insurance.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CancelInsuranceResponse clone() =>
      CancelInsuranceResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CancelInsuranceResponse copyWith(
          void Function(CancelInsuranceResponse) updates) =>
      super.copyWith((message) => updates(message as CancelInsuranceResponse))
          as CancelInsuranceResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CancelInsuranceResponse create() => CancelInsuranceResponse._();
  @$core.override
  CancelInsuranceResponse createEmptyInstance() => create();
  static $pb.PbList<CancelInsuranceResponse> createRepeated() =>
      $pb.PbList<CancelInsuranceResponse>();
  @$core.pragma('dart2js:noInline')
  static CancelInsuranceResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CancelInsuranceResponse>(create);
  static CancelInsuranceResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Insurance get insurance => $_getN(0);
  @$pb.TagNumber(1)
  set insurance(Insurance value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasInsurance() => $_has(0);
  @$pb.TagNumber(1)
  void clearInsurance() => $_clearField(1);
  @$pb.TagNumber(1)
  Insurance ensureInsurance() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);
}

class GetInsurancePlansRequest extends $pb.GeneratedMessage {
  factory GetInsurancePlansRequest({
    $core.String? coverageType,
  }) {
    final result = create();
    if (coverageType != null) result.coverageType = coverageType;
    return result;
  }

  GetInsurancePlansRequest._();

  factory GetInsurancePlansRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetInsurancePlansRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetInsurancePlansRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'coverageType')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsurancePlansRequest clone() =>
      GetInsurancePlansRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsurancePlansRequest copyWith(
          void Function(GetInsurancePlansRequest) updates) =>
      super.copyWith((message) => updates(message as GetInsurancePlansRequest))
          as GetInsurancePlansRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInsurancePlansRequest create() => GetInsurancePlansRequest._();
  @$core.override
  GetInsurancePlansRequest createEmptyInstance() => create();
  static $pb.PbList<GetInsurancePlansRequest> createRepeated() =>
      $pb.PbList<GetInsurancePlansRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInsurancePlansRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetInsurancePlansRequest>(create);
  static GetInsurancePlansRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get coverageType => $_getSZ(0);
  @$pb.TagNumber(1)
  set coverageType($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCoverageType() => $_has(0);
  @$pb.TagNumber(1)
  void clearCoverageType() => $_clearField(1);
}

class GetInsurancePlansResponse extends $pb.GeneratedMessage {
  factory GetInsurancePlansResponse({
    $core.Iterable<InsurancePlan>? plans,
    $core.int? total,
  }) {
    final result = create();
    if (plans != null) result.plans.addAll(plans);
    if (total != null) result.total = total;
    return result;
  }

  GetInsurancePlansResponse._();

  factory GetInsurancePlansResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetInsurancePlansResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetInsurancePlansResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..pc<InsurancePlan>(1, _omitFieldNames ? '' : 'plans', $pb.PbFieldType.PM,
        subBuilder: InsurancePlan.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsurancePlansResponse clone() =>
      GetInsurancePlansResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsurancePlansResponse copyWith(
          void Function(GetInsurancePlansResponse) updates) =>
      super.copyWith((message) => updates(message as GetInsurancePlansResponse))
          as GetInsurancePlansResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInsurancePlansResponse create() => GetInsurancePlansResponse._();
  @$core.override
  GetInsurancePlansResponse createEmptyInstance() => create();
  static $pb.PbList<GetInsurancePlansResponse> createRepeated() =>
      $pb.PbList<GetInsurancePlansResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInsurancePlansResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetInsurancePlansResponse>(create);
  static GetInsurancePlansResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<InsurancePlan> get plans => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);
}

/// MyCover.ai product form field definition
class MarketplaceProductFormField extends $pb.GeneratedMessage {
  factory MarketplaceProductFormField({
    $core.String? name,
    $core.String? label,
    $core.String? type,
    $core.bool? required,
    $core.Iterable<$core.String>? options,
    $core.String? defaultValue,
    $core.String? validationRegex,
    $core.String? placeholder,
    $core.String? description,
  }) {
    final result = create();
    if (name != null) result.name = name;
    if (label != null) result.label = label;
    if (type != null) result.type = type;
    if (required != null) result.required = required;
    if (options != null) result.options.addAll(options);
    if (defaultValue != null) result.defaultValue = defaultValue;
    if (validationRegex != null) result.validationRegex = validationRegex;
    if (placeholder != null) result.placeholder = placeholder;
    if (description != null) result.description = description;
    return result;
  }

  MarketplaceProductFormField._();

  factory MarketplaceProductFormField.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MarketplaceProductFormField.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MarketplaceProductFormField',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOS(2, _omitFieldNames ? '' : 'label')
    ..aOS(3, _omitFieldNames ? '' : 'type')
    ..aOB(4, _omitFieldNames ? '' : 'required')
    ..pPS(5, _omitFieldNames ? '' : 'options')
    ..aOS(6, _omitFieldNames ? '' : 'defaultValue')
    ..aOS(7, _omitFieldNames ? '' : 'validationRegex')
    ..aOS(8, _omitFieldNames ? '' : 'placeholder')
    ..aOS(9, _omitFieldNames ? '' : 'description')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MarketplaceProductFormField clone() =>
      MarketplaceProductFormField()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MarketplaceProductFormField copyWith(
          void Function(MarketplaceProductFormField) updates) =>
      super.copyWith(
              (message) => updates(message as MarketplaceProductFormField))
          as MarketplaceProductFormField;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MarketplaceProductFormField create() =>
      MarketplaceProductFormField._();
  @$core.override
  MarketplaceProductFormField createEmptyInstance() => create();
  static $pb.PbList<MarketplaceProductFormField> createRepeated() =>
      $pb.PbList<MarketplaceProductFormField>();
  @$core.pragma('dart2js:noInline')
  static MarketplaceProductFormField getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MarketplaceProductFormField>(create);
  static MarketplaceProductFormField? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get label => $_getSZ(1);
  @$pb.TagNumber(2)
  set label($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLabel() => $_has(1);
  @$pb.TagNumber(2)
  void clearLabel() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get type => $_getSZ(2);
  @$pb.TagNumber(3)
  set type($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasType() => $_has(2);
  @$pb.TagNumber(3)
  void clearType() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.bool get required => $_getBF(3);
  @$pb.TagNumber(4)
  set required($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasRequired() => $_has(3);
  @$pb.TagNumber(4)
  void clearRequired() => $_clearField(4);

  @$pb.TagNumber(5)
  $pb.PbList<$core.String> get options => $_getList(4);

  @$pb.TagNumber(6)
  $core.String get defaultValue => $_getSZ(5);
  @$pb.TagNumber(6)
  set defaultValue($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasDefaultValue() => $_has(5);
  @$pb.TagNumber(6)
  void clearDefaultValue() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get validationRegex => $_getSZ(6);
  @$pb.TagNumber(7)
  set validationRegex($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasValidationRegex() => $_has(6);
  @$pb.TagNumber(7)
  void clearValidationRegex() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get placeholder => $_getSZ(7);
  @$pb.TagNumber(8)
  set placeholder($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasPlaceholder() => $_has(7);
  @$pb.TagNumber(8)
  void clearPlaceholder() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get description => $_getSZ(8);
  @$pb.TagNumber(9)
  set description($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasDescription() => $_has(8);
  @$pb.TagNumber(9)
  void clearDescription() => $_clearField(9);
}

/// MyCover.ai insurance product
class MarketplaceInsuranceProduct extends $pb.GeneratedMessage {
  factory MarketplaceInsuranceProduct({
    $core.String? id,
    $core.String? name,
    $core.String? description,
    $core.String? category,
    $core.String? providerName,
    $core.String? providerLogo,
    $core.double? minPremium,
    $core.double? maxPremium,
    $core.String? currency,
    $core.Iterable<$core.String>? benefits,
    $core.String? termsUrl,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? metadata,
    $core.Iterable<MarketplaceProductFormField>? formFields,
    $core.bool? isActive,
    $core.String? purchaseRoute,
    $core.String? providerId,
    $core.double? basePrice,
    $core.String? howItWorks,
    $core.String? fullBenefits,
    $core.bool? isRenewable,
    $core.bool? isClaimable,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (description != null) result.description = description;
    if (category != null) result.category = category;
    if (providerName != null) result.providerName = providerName;
    if (providerLogo != null) result.providerLogo = providerLogo;
    if (minPremium != null) result.minPremium = minPremium;
    if (maxPremium != null) result.maxPremium = maxPremium;
    if (currency != null) result.currency = currency;
    if (benefits != null) result.benefits.addAll(benefits);
    if (termsUrl != null) result.termsUrl = termsUrl;
    if (metadata != null) result.metadata.addEntries(metadata);
    if (formFields != null) result.formFields.addAll(formFields);
    if (isActive != null) result.isActive = isActive;
    if (purchaseRoute != null) result.purchaseRoute = purchaseRoute;
    if (providerId != null) result.providerId = providerId;
    if (basePrice != null) result.basePrice = basePrice;
    if (howItWorks != null) result.howItWorks = howItWorks;
    if (fullBenefits != null) result.fullBenefits = fullBenefits;
    if (isRenewable != null) result.isRenewable = isRenewable;
    if (isClaimable != null) result.isClaimable = isClaimable;
    return result;
  }

  MarketplaceInsuranceProduct._();

  factory MarketplaceInsuranceProduct.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MarketplaceInsuranceProduct.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MarketplaceInsuranceProduct',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..aOS(4, _omitFieldNames ? '' : 'category')
    ..aOS(5, _omitFieldNames ? '' : 'providerName')
    ..aOS(6, _omitFieldNames ? '' : 'providerLogo')
    ..a<$core.double>(
        7, _omitFieldNames ? '' : 'minPremium', $pb.PbFieldType.OD)
    ..a<$core.double>(
        8, _omitFieldNames ? '' : 'maxPremium', $pb.PbFieldType.OD)
    ..aOS(9, _omitFieldNames ? '' : 'currency')
    ..pPS(10, _omitFieldNames ? '' : 'benefits')
    ..aOS(11, _omitFieldNames ? '' : 'termsUrl')
    ..m<$core.String, $core.String>(12, _omitFieldNames ? '' : 'metadata',
        entryClassName: 'MarketplaceInsuranceProduct.MetadataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('financialproducts'))
    ..pc<MarketplaceProductFormField>(
        13, _omitFieldNames ? '' : 'formFields', $pb.PbFieldType.PM,
        subBuilder: MarketplaceProductFormField.create)
    ..aOB(14, _omitFieldNames ? '' : 'isActive')
    ..aOS(15, _omitFieldNames ? '' : 'purchaseRoute')
    ..aOS(16, _omitFieldNames ? '' : 'providerId')
    ..a<$core.double>(
        17, _omitFieldNames ? '' : 'basePrice', $pb.PbFieldType.OD)
    ..aOS(18, _omitFieldNames ? '' : 'howItWorks')
    ..aOS(19, _omitFieldNames ? '' : 'fullBenefits')
    ..aOB(20, _omitFieldNames ? '' : 'isRenewable')
    ..aOB(21, _omitFieldNames ? '' : 'isClaimable')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MarketplaceInsuranceProduct clone() =>
      MarketplaceInsuranceProduct()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MarketplaceInsuranceProduct copyWith(
          void Function(MarketplaceInsuranceProduct) updates) =>
      super.copyWith(
              (message) => updates(message as MarketplaceInsuranceProduct))
          as MarketplaceInsuranceProduct;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MarketplaceInsuranceProduct create() =>
      MarketplaceInsuranceProduct._();
  @$core.override
  MarketplaceInsuranceProduct createEmptyInstance() => create();
  static $pb.PbList<MarketplaceInsuranceProduct> createRepeated() =>
      $pb.PbList<MarketplaceInsuranceProduct>();
  @$core.pragma('dart2js:noInline')
  static MarketplaceInsuranceProduct getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MarketplaceInsuranceProduct>(create);
  static MarketplaceInsuranceProduct? _defaultInstance;

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
  $core.String get category => $_getSZ(3);
  @$pb.TagNumber(4)
  set category($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCategory() => $_has(3);
  @$pb.TagNumber(4)
  void clearCategory() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get providerName => $_getSZ(4);
  @$pb.TagNumber(5)
  set providerName($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasProviderName() => $_has(4);
  @$pb.TagNumber(5)
  void clearProviderName() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get providerLogo => $_getSZ(5);
  @$pb.TagNumber(6)
  set providerLogo($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasProviderLogo() => $_has(5);
  @$pb.TagNumber(6)
  void clearProviderLogo() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.double get minPremium => $_getN(6);
  @$pb.TagNumber(7)
  set minPremium($core.double value) => $_setDouble(6, value);
  @$pb.TagNumber(7)
  $core.bool hasMinPremium() => $_has(6);
  @$pb.TagNumber(7)
  void clearMinPremium() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.double get maxPremium => $_getN(7);
  @$pb.TagNumber(8)
  set maxPremium($core.double value) => $_setDouble(7, value);
  @$pb.TagNumber(8)
  $core.bool hasMaxPremium() => $_has(7);
  @$pb.TagNumber(8)
  void clearMaxPremium() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get currency => $_getSZ(8);
  @$pb.TagNumber(9)
  set currency($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasCurrency() => $_has(8);
  @$pb.TagNumber(9)
  void clearCurrency() => $_clearField(9);

  @$pb.TagNumber(10)
  $pb.PbList<$core.String> get benefits => $_getList(9);

  @$pb.TagNumber(11)
  $core.String get termsUrl => $_getSZ(10);
  @$pb.TagNumber(11)
  set termsUrl($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasTermsUrl() => $_has(10);
  @$pb.TagNumber(11)
  void clearTermsUrl() => $_clearField(11);

  @$pb.TagNumber(12)
  $pb.PbMap<$core.String, $core.String> get metadata => $_getMap(11);

  @$pb.TagNumber(13)
  $pb.PbList<MarketplaceProductFormField> get formFields => $_getList(12);

  @$pb.TagNumber(14)
  $core.bool get isActive => $_getBF(13);
  @$pb.TagNumber(14)
  set isActive($core.bool value) => $_setBool(13, value);
  @$pb.TagNumber(14)
  $core.bool hasIsActive() => $_has(13);
  @$pb.TagNumber(14)
  void clearIsActive() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.String get purchaseRoute => $_getSZ(14);
  @$pb.TagNumber(15)
  set purchaseRoute($core.String value) => $_setString(14, value);
  @$pb.TagNumber(15)
  $core.bool hasPurchaseRoute() => $_has(14);
  @$pb.TagNumber(15)
  void clearPurchaseRoute() => $_clearField(15);

  @$pb.TagNumber(16)
  $core.String get providerId => $_getSZ(15);
  @$pb.TagNumber(16)
  set providerId($core.String value) => $_setString(15, value);
  @$pb.TagNumber(16)
  $core.bool hasProviderId() => $_has(15);
  @$pb.TagNumber(16)
  void clearProviderId() => $_clearField(16);

  @$pb.TagNumber(17)
  $core.double get basePrice => $_getN(16);
  @$pb.TagNumber(17)
  set basePrice($core.double value) => $_setDouble(16, value);
  @$pb.TagNumber(17)
  $core.bool hasBasePrice() => $_has(16);
  @$pb.TagNumber(17)
  void clearBasePrice() => $_clearField(17);

  @$pb.TagNumber(18)
  $core.String get howItWorks => $_getSZ(17);
  @$pb.TagNumber(18)
  set howItWorks($core.String value) => $_setString(17, value);
  @$pb.TagNumber(18)
  $core.bool hasHowItWorks() => $_has(17);
  @$pb.TagNumber(18)
  void clearHowItWorks() => $_clearField(18);

  @$pb.TagNumber(19)
  $core.String get fullBenefits => $_getSZ(18);
  @$pb.TagNumber(19)
  set fullBenefits($core.String value) => $_setString(18, value);
  @$pb.TagNumber(19)
  $core.bool hasFullBenefits() => $_has(18);
  @$pb.TagNumber(19)
  void clearFullBenefits() => $_clearField(19);

  @$pb.TagNumber(20)
  $core.bool get isRenewable => $_getBF(19);
  @$pb.TagNumber(20)
  set isRenewable($core.bool value) => $_setBool(19, value);
  @$pb.TagNumber(20)
  $core.bool hasIsRenewable() => $_has(19);
  @$pb.TagNumber(20)
  void clearIsRenewable() => $_clearField(20);

  @$pb.TagNumber(21)
  $core.bool get isClaimable => $_getBF(20);
  @$pb.TagNumber(21)
  set isClaimable($core.bool value) => $_setBool(20, value);
  @$pb.TagNumber(21)
  $core.bool hasIsClaimable() => $_has(20);
  @$pb.TagNumber(21)
  void clearIsClaimable() => $_clearField(21);
}

/// Insurance category metadata
class MarketplaceInsuranceCategory extends $pb.GeneratedMessage {
  factory MarketplaceInsuranceCategory({
    $core.String? id,
    $core.String? name,
    $core.String? icon,
    $core.String? description,
    $core.int? productCount,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (icon != null) result.icon = icon;
    if (description != null) result.description = description;
    if (productCount != null) result.productCount = productCount;
    return result;
  }

  MarketplaceInsuranceCategory._();

  factory MarketplaceInsuranceCategory.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MarketplaceInsuranceCategory.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MarketplaceInsuranceCategory',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'icon')
    ..aOS(4, _omitFieldNames ? '' : 'description')
    ..a<$core.int>(5, _omitFieldNames ? '' : 'productCount', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MarketplaceInsuranceCategory clone() =>
      MarketplaceInsuranceCategory()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MarketplaceInsuranceCategory copyWith(
          void Function(MarketplaceInsuranceCategory) updates) =>
      super.copyWith(
              (message) => updates(message as MarketplaceInsuranceCategory))
          as MarketplaceInsuranceCategory;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MarketplaceInsuranceCategory create() =>
      MarketplaceInsuranceCategory._();
  @$core.override
  MarketplaceInsuranceCategory createEmptyInstance() => create();
  static $pb.PbList<MarketplaceInsuranceCategory> createRepeated() =>
      $pb.PbList<MarketplaceInsuranceCategory>();
  @$core.pragma('dart2js:noInline')
  static MarketplaceInsuranceCategory getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MarketplaceInsuranceCategory>(create);
  static MarketplaceInsuranceCategory? _defaultInstance;

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
  $core.String get icon => $_getSZ(2);
  @$pb.TagNumber(3)
  set icon($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasIcon() => $_has(2);
  @$pb.TagNumber(3)
  void clearIcon() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get description => $_getSZ(3);
  @$pb.TagNumber(4)
  set description($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDescription() => $_has(3);
  @$pb.TagNumber(4)
  void clearDescription() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get productCount => $_getIZ(4);
  @$pb.TagNumber(5)
  set productCount($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasProductCount() => $_has(4);
  @$pb.TagNumber(5)
  void clearProductCount() => $_clearField(5);
}

/// Quote result
class MarketplaceInsuranceQuote extends $pb.GeneratedMessage {
  factory MarketplaceInsuranceQuote({
    $core.String? quoteId,
    $core.String? productId,
    $core.double? premium,
    $core.String? currency,
    $core.String? coverageSummary,
    $core.Iterable<$core.String>? coverageItems,
    $core.String? validUntil,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? quoteDetails,
  }) {
    final result = create();
    if (quoteId != null) result.quoteId = quoteId;
    if (productId != null) result.productId = productId;
    if (premium != null) result.premium = premium;
    if (currency != null) result.currency = currency;
    if (coverageSummary != null) result.coverageSummary = coverageSummary;
    if (coverageItems != null) result.coverageItems.addAll(coverageItems);
    if (validUntil != null) result.validUntil = validUntil;
    if (quoteDetails != null) result.quoteDetails.addEntries(quoteDetails);
    return result;
  }

  MarketplaceInsuranceQuote._();

  factory MarketplaceInsuranceQuote.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MarketplaceInsuranceQuote.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MarketplaceInsuranceQuote',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'quoteId')
    ..aOS(2, _omitFieldNames ? '' : 'productId')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'premium', $pb.PbFieldType.OD)
    ..aOS(4, _omitFieldNames ? '' : 'currency')
    ..aOS(5, _omitFieldNames ? '' : 'coverageSummary')
    ..pPS(6, _omitFieldNames ? '' : 'coverageItems')
    ..aOS(7, _omitFieldNames ? '' : 'validUntil')
    ..m<$core.String, $core.String>(8, _omitFieldNames ? '' : 'quoteDetails',
        entryClassName: 'MarketplaceInsuranceQuote.QuoteDetailsEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('financialproducts'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MarketplaceInsuranceQuote clone() =>
      MarketplaceInsuranceQuote()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MarketplaceInsuranceQuote copyWith(
          void Function(MarketplaceInsuranceQuote) updates) =>
      super.copyWith((message) => updates(message as MarketplaceInsuranceQuote))
          as MarketplaceInsuranceQuote;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MarketplaceInsuranceQuote create() => MarketplaceInsuranceQuote._();
  @$core.override
  MarketplaceInsuranceQuote createEmptyInstance() => create();
  static $pb.PbList<MarketplaceInsuranceQuote> createRepeated() =>
      $pb.PbList<MarketplaceInsuranceQuote>();
  @$core.pragma('dart2js:noInline')
  static MarketplaceInsuranceQuote getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MarketplaceInsuranceQuote>(create);
  static MarketplaceInsuranceQuote? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get quoteId => $_getSZ(0);
  @$pb.TagNumber(1)
  set quoteId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasQuoteId() => $_has(0);
  @$pb.TagNumber(1)
  void clearQuoteId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get productId => $_getSZ(1);
  @$pb.TagNumber(2)
  set productId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasProductId() => $_has(1);
  @$pb.TagNumber(2)
  void clearProductId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get premium => $_getN(2);
  @$pb.TagNumber(3)
  set premium($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPremium() => $_has(2);
  @$pb.TagNumber(3)
  void clearPremium() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get currency => $_getSZ(3);
  @$pb.TagNumber(4)
  set currency($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCurrency() => $_has(3);
  @$pb.TagNumber(4)
  void clearCurrency() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get coverageSummary => $_getSZ(4);
  @$pb.TagNumber(5)
  set coverageSummary($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasCoverageSummary() => $_has(4);
  @$pb.TagNumber(5)
  void clearCoverageSummary() => $_clearField(5);

  @$pb.TagNumber(6)
  $pb.PbList<$core.String> get coverageItems => $_getList(5);

  @$pb.TagNumber(7)
  $core.String get validUntil => $_getSZ(6);
  @$pb.TagNumber(7)
  set validUntil($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasValidUntil() => $_has(6);
  @$pb.TagNumber(7)
  void clearValidUntil() => $_clearField(7);

  @$pb.TagNumber(8)
  $pb.PbMap<$core.String, $core.String> get quoteDetails => $_getMap(7);
}

/// Purchase result
class MarketplaceInsurancePurchaseResult extends $pb.GeneratedMessage {
  factory MarketplaceInsurancePurchaseResult({
    $core.String? policyId,
    $core.String? policyNumber,
    $core.String? reference,
    $core.String? status,
    $core.String? providerReference,
    Insurance? insurance,
  }) {
    final result = create();
    if (policyId != null) result.policyId = policyId;
    if (policyNumber != null) result.policyNumber = policyNumber;
    if (reference != null) result.reference = reference;
    if (status != null) result.status = status;
    if (providerReference != null) result.providerReference = providerReference;
    if (insurance != null) result.insurance = insurance;
    return result;
  }

  MarketplaceInsurancePurchaseResult._();

  factory MarketplaceInsurancePurchaseResult.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MarketplaceInsurancePurchaseResult.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MarketplaceInsurancePurchaseResult',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'policyId')
    ..aOS(2, _omitFieldNames ? '' : 'policyNumber')
    ..aOS(3, _omitFieldNames ? '' : 'reference')
    ..aOS(4, _omitFieldNames ? '' : 'status')
    ..aOS(5, _omitFieldNames ? '' : 'providerReference')
    ..aOM<Insurance>(6, _omitFieldNames ? '' : 'insurance',
        subBuilder: Insurance.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MarketplaceInsurancePurchaseResult clone() =>
      MarketplaceInsurancePurchaseResult()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MarketplaceInsurancePurchaseResult copyWith(
          void Function(MarketplaceInsurancePurchaseResult) updates) =>
      super.copyWith((message) =>
              updates(message as MarketplaceInsurancePurchaseResult))
          as MarketplaceInsurancePurchaseResult;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MarketplaceInsurancePurchaseResult create() =>
      MarketplaceInsurancePurchaseResult._();
  @$core.override
  MarketplaceInsurancePurchaseResult createEmptyInstance() => create();
  static $pb.PbList<MarketplaceInsurancePurchaseResult> createRepeated() =>
      $pb.PbList<MarketplaceInsurancePurchaseResult>();
  @$core.pragma('dart2js:noInline')
  static MarketplaceInsurancePurchaseResult getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MarketplaceInsurancePurchaseResult>(
          create);
  static MarketplaceInsurancePurchaseResult? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get policyId => $_getSZ(0);
  @$pb.TagNumber(1)
  set policyId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPolicyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPolicyId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get policyNumber => $_getSZ(1);
  @$pb.TagNumber(2)
  set policyNumber($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPolicyNumber() => $_has(1);
  @$pb.TagNumber(2)
  void clearPolicyNumber() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get reference => $_getSZ(2);
  @$pb.TagNumber(3)
  set reference($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasReference() => $_has(2);
  @$pb.TagNumber(3)
  void clearReference() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get status => $_getSZ(3);
  @$pb.TagNumber(4)
  set status($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasStatus() => $_has(3);
  @$pb.TagNumber(4)
  void clearStatus() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get providerReference => $_getSZ(4);
  @$pb.TagNumber(5)
  set providerReference($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasProviderReference() => $_has(4);
  @$pb.TagNumber(5)
  void clearProviderReference() => $_clearField(5);

  @$pb.TagNumber(6)
  Insurance get insurance => $_getN(5);
  @$pb.TagNumber(6)
  set insurance(Insurance value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasInsurance() => $_has(5);
  @$pb.TagNumber(6)
  void clearInsurance() => $_clearField(6);
  @$pb.TagNumber(6)
  Insurance ensureInsurance() => $_ensure(5);
}

/// Get marketplace products
class GetInsuranceMarketplaceProductsRequest extends $pb.GeneratedMessage {
  factory GetInsuranceMarketplaceProductsRequest({
    $core.String? category,
    $core.String? locale,
    $core.int? page,
    $core.int? limit,
  }) {
    final result = create();
    if (category != null) result.category = category;
    if (locale != null) result.locale = locale;
    if (page != null) result.page = page;
    if (limit != null) result.limit = limit;
    return result;
  }

  GetInsuranceMarketplaceProductsRequest._();

  factory GetInsuranceMarketplaceProductsRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetInsuranceMarketplaceProductsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetInsuranceMarketplaceProductsRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'category')
    ..aOS(2, _omitFieldNames ? '' : 'locale')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsuranceMarketplaceProductsRequest clone() =>
      GetInsuranceMarketplaceProductsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsuranceMarketplaceProductsRequest copyWith(
          void Function(GetInsuranceMarketplaceProductsRequest) updates) =>
      super.copyWith((message) =>
              updates(message as GetInsuranceMarketplaceProductsRequest))
          as GetInsuranceMarketplaceProductsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInsuranceMarketplaceProductsRequest create() =>
      GetInsuranceMarketplaceProductsRequest._();
  @$core.override
  GetInsuranceMarketplaceProductsRequest createEmptyInstance() => create();
  static $pb.PbList<GetInsuranceMarketplaceProductsRequest> createRepeated() =>
      $pb.PbList<GetInsuranceMarketplaceProductsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInsuranceMarketplaceProductsRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          GetInsuranceMarketplaceProductsRequest>(create);
  static GetInsuranceMarketplaceProductsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get category => $_getSZ(0);
  @$pb.TagNumber(1)
  set category($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCategory() => $_has(0);
  @$pb.TagNumber(1)
  void clearCategory() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get locale => $_getSZ(1);
  @$pb.TagNumber(2)
  set locale($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLocale() => $_has(1);
  @$pb.TagNumber(2)
  void clearLocale() => $_clearField(2);

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

class GetInsuranceMarketplaceProductsResponse extends $pb.GeneratedMessage {
  factory GetInsuranceMarketplaceProductsResponse({
    $core.Iterable<MarketplaceInsuranceProduct>? products,
    $core.int? total,
  }) {
    final result = create();
    if (products != null) result.products.addAll(products);
    if (total != null) result.total = total;
    return result;
  }

  GetInsuranceMarketplaceProductsResponse._();

  factory GetInsuranceMarketplaceProductsResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetInsuranceMarketplaceProductsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetInsuranceMarketplaceProductsResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..pc<MarketplaceInsuranceProduct>(
        1, _omitFieldNames ? '' : 'products', $pb.PbFieldType.PM,
        subBuilder: MarketplaceInsuranceProduct.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsuranceMarketplaceProductsResponse clone() =>
      GetInsuranceMarketplaceProductsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsuranceMarketplaceProductsResponse copyWith(
          void Function(GetInsuranceMarketplaceProductsResponse) updates) =>
      super.copyWith((message) =>
              updates(message as GetInsuranceMarketplaceProductsResponse))
          as GetInsuranceMarketplaceProductsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInsuranceMarketplaceProductsResponse create() =>
      GetInsuranceMarketplaceProductsResponse._();
  @$core.override
  GetInsuranceMarketplaceProductsResponse createEmptyInstance() => create();
  static $pb.PbList<GetInsuranceMarketplaceProductsResponse> createRepeated() =>
      $pb.PbList<GetInsuranceMarketplaceProductsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInsuranceMarketplaceProductsResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          GetInsuranceMarketplaceProductsResponse>(create);
  static GetInsuranceMarketplaceProductsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<MarketplaceInsuranceProduct> get products => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);
}

/// Get marketplace categories
class GetInsuranceMarketplaceCategoriesRequest extends $pb.GeneratedMessage {
  factory GetInsuranceMarketplaceCategoriesRequest({
    $core.String? locale,
  }) {
    final result = create();
    if (locale != null) result.locale = locale;
    return result;
  }

  GetInsuranceMarketplaceCategoriesRequest._();

  factory GetInsuranceMarketplaceCategoriesRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetInsuranceMarketplaceCategoriesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetInsuranceMarketplaceCategoriesRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'locale')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsuranceMarketplaceCategoriesRequest clone() =>
      GetInsuranceMarketplaceCategoriesRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsuranceMarketplaceCategoriesRequest copyWith(
          void Function(GetInsuranceMarketplaceCategoriesRequest) updates) =>
      super.copyWith((message) =>
              updates(message as GetInsuranceMarketplaceCategoriesRequest))
          as GetInsuranceMarketplaceCategoriesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInsuranceMarketplaceCategoriesRequest create() =>
      GetInsuranceMarketplaceCategoriesRequest._();
  @$core.override
  GetInsuranceMarketplaceCategoriesRequest createEmptyInstance() => create();
  static $pb.PbList<GetInsuranceMarketplaceCategoriesRequest>
      createRepeated() =>
          $pb.PbList<GetInsuranceMarketplaceCategoriesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInsuranceMarketplaceCategoriesRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          GetInsuranceMarketplaceCategoriesRequest>(create);
  static GetInsuranceMarketplaceCategoriesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get locale => $_getSZ(0);
  @$pb.TagNumber(1)
  set locale($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasLocale() => $_has(0);
  @$pb.TagNumber(1)
  void clearLocale() => $_clearField(1);
}

class GetInsuranceMarketplaceCategoriesResponse extends $pb.GeneratedMessage {
  factory GetInsuranceMarketplaceCategoriesResponse({
    $core.Iterable<MarketplaceInsuranceCategory>? categories,
  }) {
    final result = create();
    if (categories != null) result.categories.addAll(categories);
    return result;
  }

  GetInsuranceMarketplaceCategoriesResponse._();

  factory GetInsuranceMarketplaceCategoriesResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetInsuranceMarketplaceCategoriesResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetInsuranceMarketplaceCategoriesResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..pc<MarketplaceInsuranceCategory>(
        1, _omitFieldNames ? '' : 'categories', $pb.PbFieldType.PM,
        subBuilder: MarketplaceInsuranceCategory.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsuranceMarketplaceCategoriesResponse clone() =>
      GetInsuranceMarketplaceCategoriesResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsuranceMarketplaceCategoriesResponse copyWith(
          void Function(GetInsuranceMarketplaceCategoriesResponse) updates) =>
      super.copyWith((message) =>
              updates(message as GetInsuranceMarketplaceCategoriesResponse))
          as GetInsuranceMarketplaceCategoriesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInsuranceMarketplaceCategoriesResponse create() =>
      GetInsuranceMarketplaceCategoriesResponse._();
  @$core.override
  GetInsuranceMarketplaceCategoriesResponse createEmptyInstance() => create();
  static $pb.PbList<GetInsuranceMarketplaceCategoriesResponse>
      createRepeated() =>
          $pb.PbList<GetInsuranceMarketplaceCategoriesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInsuranceMarketplaceCategoriesResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          GetInsuranceMarketplaceCategoriesResponse>(create);
  static GetInsuranceMarketplaceCategoriesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<MarketplaceInsuranceCategory> get categories => $_getList(0);
}

/// Get insurance quote
class GetInsuranceQuoteRequest extends $pb.GeneratedMessage {
  factory GetInsuranceQuoteRequest({
    $core.String? productId,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? formData,
    $core.String? locale,
  }) {
    final result = create();
    if (productId != null) result.productId = productId;
    if (formData != null) result.formData.addEntries(formData);
    if (locale != null) result.locale = locale;
    return result;
  }

  GetInsuranceQuoteRequest._();

  factory GetInsuranceQuoteRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetInsuranceQuoteRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetInsuranceQuoteRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'productId')
    ..m<$core.String, $core.String>(2, _omitFieldNames ? '' : 'formData',
        entryClassName: 'GetInsuranceQuoteRequest.FormDataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('financialproducts'))
    ..aOS(3, _omitFieldNames ? '' : 'locale')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsuranceQuoteRequest clone() =>
      GetInsuranceQuoteRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsuranceQuoteRequest copyWith(
          void Function(GetInsuranceQuoteRequest) updates) =>
      super.copyWith((message) => updates(message as GetInsuranceQuoteRequest))
          as GetInsuranceQuoteRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInsuranceQuoteRequest create() => GetInsuranceQuoteRequest._();
  @$core.override
  GetInsuranceQuoteRequest createEmptyInstance() => create();
  static $pb.PbList<GetInsuranceQuoteRequest> createRepeated() =>
      $pb.PbList<GetInsuranceQuoteRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInsuranceQuoteRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetInsuranceQuoteRequest>(create);
  static GetInsuranceQuoteRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get productId => $_getSZ(0);
  @$pb.TagNumber(1)
  set productId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasProductId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProductId() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbMap<$core.String, $core.String> get formData => $_getMap(1);

  @$pb.TagNumber(3)
  $core.String get locale => $_getSZ(2);
  @$pb.TagNumber(3)
  set locale($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasLocale() => $_has(2);
  @$pb.TagNumber(3)
  void clearLocale() => $_clearField(3);
}

class GetInsuranceQuoteResponse extends $pb.GeneratedMessage {
  factory GetInsuranceQuoteResponse({
    MarketplaceInsuranceQuote? quote,
  }) {
    final result = create();
    if (quote != null) result.quote = quote;
    return result;
  }

  GetInsuranceQuoteResponse._();

  factory GetInsuranceQuoteResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetInsuranceQuoteResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetInsuranceQuoteResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOM<MarketplaceInsuranceQuote>(1, _omitFieldNames ? '' : 'quote',
        subBuilder: MarketplaceInsuranceQuote.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsuranceQuoteResponse clone() =>
      GetInsuranceQuoteResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsuranceQuoteResponse copyWith(
          void Function(GetInsuranceQuoteResponse) updates) =>
      super.copyWith((message) => updates(message as GetInsuranceQuoteResponse))
          as GetInsuranceQuoteResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInsuranceQuoteResponse create() => GetInsuranceQuoteResponse._();
  @$core.override
  GetInsuranceQuoteResponse createEmptyInstance() => create();
  static $pb.PbList<GetInsuranceQuoteResponse> createRepeated() =>
      $pb.PbList<GetInsuranceQuoteResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInsuranceQuoteResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetInsuranceQuoteResponse>(create);
  static GetInsuranceQuoteResponse? _defaultInstance;

  @$pb.TagNumber(1)
  MarketplaceInsuranceQuote get quote => $_getN(0);
  @$pb.TagNumber(1)
  set quote(MarketplaceInsuranceQuote value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasQuote() => $_has(0);
  @$pb.TagNumber(1)
  void clearQuote() => $_clearField(1);
  @$pb.TagNumber(1)
  MarketplaceInsuranceQuote ensureQuote() => $_ensure(0);
}

/// Purchase marketplace insurance
class PurchaseMarketplaceInsuranceRequest extends $pb.GeneratedMessage {
  factory PurchaseMarketplaceInsuranceRequest({
    $core.String? quoteId,
    $core.String? productId,
    $core.String? accountId,
    $core.String? transactionPinToken,
    $core.String? idempotencyKey,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? formData,
    $core.String? locale,
  }) {
    final result = create();
    if (quoteId != null) result.quoteId = quoteId;
    if (productId != null) result.productId = productId;
    if (accountId != null) result.accountId = accountId;
    if (transactionPinToken != null)
      result.transactionPinToken = transactionPinToken;
    if (idempotencyKey != null) result.idempotencyKey = idempotencyKey;
    if (formData != null) result.formData.addEntries(formData);
    if (locale != null) result.locale = locale;
    return result;
  }

  PurchaseMarketplaceInsuranceRequest._();

  factory PurchaseMarketplaceInsuranceRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PurchaseMarketplaceInsuranceRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PurchaseMarketplaceInsuranceRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'quoteId')
    ..aOS(2, _omitFieldNames ? '' : 'productId')
    ..aOS(3, _omitFieldNames ? '' : 'accountId')
    ..aOS(4, _omitFieldNames ? '' : 'transactionPinToken')
    ..aOS(5, _omitFieldNames ? '' : 'idempotencyKey')
    ..m<$core.String, $core.String>(6, _omitFieldNames ? '' : 'formData',
        entryClassName: 'PurchaseMarketplaceInsuranceRequest.FormDataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('financialproducts'))
    ..aOS(7, _omitFieldNames ? '' : 'locale')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PurchaseMarketplaceInsuranceRequest clone() =>
      PurchaseMarketplaceInsuranceRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PurchaseMarketplaceInsuranceRequest copyWith(
          void Function(PurchaseMarketplaceInsuranceRequest) updates) =>
      super.copyWith((message) =>
              updates(message as PurchaseMarketplaceInsuranceRequest))
          as PurchaseMarketplaceInsuranceRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PurchaseMarketplaceInsuranceRequest create() =>
      PurchaseMarketplaceInsuranceRequest._();
  @$core.override
  PurchaseMarketplaceInsuranceRequest createEmptyInstance() => create();
  static $pb.PbList<PurchaseMarketplaceInsuranceRequest> createRepeated() =>
      $pb.PbList<PurchaseMarketplaceInsuranceRequest>();
  @$core.pragma('dart2js:noInline')
  static PurchaseMarketplaceInsuranceRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          PurchaseMarketplaceInsuranceRequest>(create);
  static PurchaseMarketplaceInsuranceRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get quoteId => $_getSZ(0);
  @$pb.TagNumber(1)
  set quoteId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasQuoteId() => $_has(0);
  @$pb.TagNumber(1)
  void clearQuoteId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get productId => $_getSZ(1);
  @$pb.TagNumber(2)
  set productId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasProductId() => $_has(1);
  @$pb.TagNumber(2)
  void clearProductId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get accountId => $_getSZ(2);
  @$pb.TagNumber(3)
  set accountId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAccountId() => $_has(2);
  @$pb.TagNumber(3)
  void clearAccountId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get transactionPinToken => $_getSZ(3);
  @$pb.TagNumber(4)
  set transactionPinToken($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTransactionPinToken() => $_has(3);
  @$pb.TagNumber(4)
  void clearTransactionPinToken() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get idempotencyKey => $_getSZ(4);
  @$pb.TagNumber(5)
  set idempotencyKey($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasIdempotencyKey() => $_has(4);
  @$pb.TagNumber(5)
  void clearIdempotencyKey() => $_clearField(5);

  @$pb.TagNumber(6)
  $pb.PbMap<$core.String, $core.String> get formData => $_getMap(5);

  @$pb.TagNumber(7)
  $core.String get locale => $_getSZ(6);
  @$pb.TagNumber(7)
  set locale($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasLocale() => $_has(6);
  @$pb.TagNumber(7)
  void clearLocale() => $_clearField(7);
}

class PurchaseMarketplaceInsuranceResponse extends $pb.GeneratedMessage {
  factory PurchaseMarketplaceInsuranceResponse({
    MarketplaceInsurancePurchaseResult? result,
    $core.String? message,
  }) {
    final result$ = create();
    if (result != null) result$.result = result;
    if (message != null) result$.message = message;
    return result$;
  }

  PurchaseMarketplaceInsuranceResponse._();

  factory PurchaseMarketplaceInsuranceResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PurchaseMarketplaceInsuranceResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PurchaseMarketplaceInsuranceResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOM<MarketplaceInsurancePurchaseResult>(
        1, _omitFieldNames ? '' : 'result',
        subBuilder: MarketplaceInsurancePurchaseResult.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PurchaseMarketplaceInsuranceResponse clone() =>
      PurchaseMarketplaceInsuranceResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PurchaseMarketplaceInsuranceResponse copyWith(
          void Function(PurchaseMarketplaceInsuranceResponse) updates) =>
      super.copyWith((message) =>
              updates(message as PurchaseMarketplaceInsuranceResponse))
          as PurchaseMarketplaceInsuranceResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PurchaseMarketplaceInsuranceResponse create() =>
      PurchaseMarketplaceInsuranceResponse._();
  @$core.override
  PurchaseMarketplaceInsuranceResponse createEmptyInstance() => create();
  static $pb.PbList<PurchaseMarketplaceInsuranceResponse> createRepeated() =>
      $pb.PbList<PurchaseMarketplaceInsuranceResponse>();
  @$core.pragma('dart2js:noInline')
  static PurchaseMarketplaceInsuranceResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          PurchaseMarketplaceInsuranceResponse>(create);
  static PurchaseMarketplaceInsuranceResponse? _defaultInstance;

  @$pb.TagNumber(1)
  MarketplaceInsurancePurchaseResult get result => $_getN(0);
  @$pb.TagNumber(1)
  set result(MarketplaceInsurancePurchaseResult value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasResult() => $_has(0);
  @$pb.TagNumber(1)
  void clearResult() => $_clearField(1);
  @$pb.TagNumber(1)
  MarketplaceInsurancePurchaseResult ensureResult() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);
}

/// Get insurance purchase status
class GetInsurancePurchaseStatusRequest extends $pb.GeneratedMessage {
  factory GetInsurancePurchaseStatusRequest({
    $core.String? reference,
  }) {
    final result = create();
    if (reference != null) result.reference = reference;
    return result;
  }

  GetInsurancePurchaseStatusRequest._();

  factory GetInsurancePurchaseStatusRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetInsurancePurchaseStatusRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetInsurancePurchaseStatusRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'reference')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsurancePurchaseStatusRequest clone() =>
      GetInsurancePurchaseStatusRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsurancePurchaseStatusRequest copyWith(
          void Function(GetInsurancePurchaseStatusRequest) updates) =>
      super.copyWith((message) =>
              updates(message as GetInsurancePurchaseStatusRequest))
          as GetInsurancePurchaseStatusRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInsurancePurchaseStatusRequest create() =>
      GetInsurancePurchaseStatusRequest._();
  @$core.override
  GetInsurancePurchaseStatusRequest createEmptyInstance() => create();
  static $pb.PbList<GetInsurancePurchaseStatusRequest> createRepeated() =>
      $pb.PbList<GetInsurancePurchaseStatusRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInsurancePurchaseStatusRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetInsurancePurchaseStatusRequest>(
          create);
  static GetInsurancePurchaseStatusRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get reference => $_getSZ(0);
  @$pb.TagNumber(1)
  set reference($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasReference() => $_has(0);
  @$pb.TagNumber(1)
  void clearReference() => $_clearField(1);
}

class GetInsurancePurchaseStatusResponse extends $pb.GeneratedMessage {
  factory GetInsurancePurchaseStatusResponse({
    MarketplaceInsurancePurchaseResult? result,
  }) {
    final result$ = create();
    if (result != null) result$.result = result;
    return result$;
  }

  GetInsurancePurchaseStatusResponse._();

  factory GetInsurancePurchaseStatusResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetInsurancePurchaseStatusResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetInsurancePurchaseStatusResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOM<MarketplaceInsurancePurchaseResult>(
        1, _omitFieldNames ? '' : 'result',
        subBuilder: MarketplaceInsurancePurchaseResult.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsurancePurchaseStatusResponse clone() =>
      GetInsurancePurchaseStatusResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsurancePurchaseStatusResponse copyWith(
          void Function(GetInsurancePurchaseStatusResponse) updates) =>
      super.copyWith((message) =>
              updates(message as GetInsurancePurchaseStatusResponse))
          as GetInsurancePurchaseStatusResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInsurancePurchaseStatusResponse create() =>
      GetInsurancePurchaseStatusResponse._();
  @$core.override
  GetInsurancePurchaseStatusResponse createEmptyInstance() => create();
  static $pb.PbList<GetInsurancePurchaseStatusResponse> createRepeated() =>
      $pb.PbList<GetInsurancePurchaseStatusResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInsurancePurchaseStatusResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetInsurancePurchaseStatusResponse>(
          create);
  static GetInsurancePurchaseStatusResponse? _defaultInstance;

  @$pb.TagNumber(1)
  MarketplaceInsurancePurchaseResult get result => $_getN(0);
  @$pb.TagNumber(1)
  set result(MarketplaceInsurancePurchaseResult value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasResult() => $_has(0);
  @$pb.TagNumber(1)
  void clearResult() => $_clearField(1);
  @$pb.TagNumber(1)
  MarketplaceInsurancePurchaseResult ensureResult() => $_ensure(0);
}

/// Upload insurance document (ID, proof of purchase, claim evidence, device photo)
class UploadInsuranceDocumentRequest extends $pb.GeneratedMessage {
  factory UploadInsuranceDocumentRequest({
    $core.List<$core.int>? fileData,
    $core.String? filename,
    $core.String? documentType,
  }) {
    final result = create();
    if (fileData != null) result.fileData = fileData;
    if (filename != null) result.filename = filename;
    if (documentType != null) result.documentType = documentType;
    return result;
  }

  UploadInsuranceDocumentRequest._();

  factory UploadInsuranceDocumentRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UploadInsuranceDocumentRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UploadInsuranceDocumentRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..a<$core.List<$core.int>>(
        1, _omitFieldNames ? '' : 'fileData', $pb.PbFieldType.OY)
    ..aOS(2, _omitFieldNames ? '' : 'filename')
    ..aOS(3, _omitFieldNames ? '' : 'documentType')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UploadInsuranceDocumentRequest clone() =>
      UploadInsuranceDocumentRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UploadInsuranceDocumentRequest copyWith(
          void Function(UploadInsuranceDocumentRequest) updates) =>
      super.copyWith(
              (message) => updates(message as UploadInsuranceDocumentRequest))
          as UploadInsuranceDocumentRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UploadInsuranceDocumentRequest create() =>
      UploadInsuranceDocumentRequest._();
  @$core.override
  UploadInsuranceDocumentRequest createEmptyInstance() => create();
  static $pb.PbList<UploadInsuranceDocumentRequest> createRepeated() =>
      $pb.PbList<UploadInsuranceDocumentRequest>();
  @$core.pragma('dart2js:noInline')
  static UploadInsuranceDocumentRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UploadInsuranceDocumentRequest>(create);
  static UploadInsuranceDocumentRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get fileData => $_getN(0);
  @$pb.TagNumber(1)
  set fileData($core.List<$core.int> value) => $_setBytes(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFileData() => $_has(0);
  @$pb.TagNumber(1)
  void clearFileData() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get filename => $_getSZ(1);
  @$pb.TagNumber(2)
  set filename($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasFilename() => $_has(1);
  @$pb.TagNumber(2)
  void clearFilename() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get documentType => $_getSZ(2);
  @$pb.TagNumber(3)
  set documentType($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDocumentType() => $_has(2);
  @$pb.TagNumber(3)
  void clearDocumentType() => $_clearField(3);
}

class UploadInsuranceDocumentResponse extends $pb.GeneratedMessage {
  factory UploadInsuranceDocumentResponse({
    $core.String? uploadId,
    $core.String? fileUrl,
    $core.bool? success,
    $core.String? msg,
  }) {
    final result = create();
    if (uploadId != null) result.uploadId = uploadId;
    if (fileUrl != null) result.fileUrl = fileUrl;
    if (success != null) result.success = success;
    if (msg != null) result.msg = msg;
    return result;
  }

  UploadInsuranceDocumentResponse._();

  factory UploadInsuranceDocumentResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UploadInsuranceDocumentResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UploadInsuranceDocumentResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'uploadId')
    ..aOS(2, _omitFieldNames ? '' : 'fileUrl')
    ..aOB(3, _omitFieldNames ? '' : 'success')
    ..aOS(4, _omitFieldNames ? '' : 'msg')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UploadInsuranceDocumentResponse clone() =>
      UploadInsuranceDocumentResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UploadInsuranceDocumentResponse copyWith(
          void Function(UploadInsuranceDocumentResponse) updates) =>
      super.copyWith(
              (message) => updates(message as UploadInsuranceDocumentResponse))
          as UploadInsuranceDocumentResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UploadInsuranceDocumentResponse create() =>
      UploadInsuranceDocumentResponse._();
  @$core.override
  UploadInsuranceDocumentResponse createEmptyInstance() => create();
  static $pb.PbList<UploadInsuranceDocumentResponse> createRepeated() =>
      $pb.PbList<UploadInsuranceDocumentResponse>();
  @$core.pragma('dart2js:noInline')
  static UploadInsuranceDocumentResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UploadInsuranceDocumentResponse>(
          create);
  static UploadInsuranceDocumentResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get uploadId => $_getSZ(0);
  @$pb.TagNumber(1)
  set uploadId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUploadId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUploadId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get fileUrl => $_getSZ(1);
  @$pb.TagNumber(2)
  set fileUrl($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasFileUrl() => $_has(1);
  @$pb.TagNumber(2)
  void clearFileUrl() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.bool get success => $_getBF(2);
  @$pb.TagNumber(3)
  set success($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSuccess() => $_has(2);
  @$pb.TagNumber(3)
  void clearSuccess() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get msg => $_getSZ(3);
  @$pb.TagNumber(4)
  set msg($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMsg() => $_has(3);
  @$pb.TagNumber(4)
  void clearMsg() => $_clearField(4);
}

/// Get auxiliary data (states, vehicle makes/models, genders, etc.)
class GetInsuranceAuxiliaryDataRequest extends $pb.GeneratedMessage {
  factory GetInsuranceAuxiliaryDataRequest({
    $core.String? utilityId,
    $core.String? query,
  }) {
    final result = create();
    if (utilityId != null) result.utilityId = utilityId;
    if (query != null) result.query = query;
    return result;
  }

  GetInsuranceAuxiliaryDataRequest._();

  factory GetInsuranceAuxiliaryDataRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetInsuranceAuxiliaryDataRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetInsuranceAuxiliaryDataRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'utilityId')
    ..aOS(2, _omitFieldNames ? '' : 'query')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsuranceAuxiliaryDataRequest clone() =>
      GetInsuranceAuxiliaryDataRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsuranceAuxiliaryDataRequest copyWith(
          void Function(GetInsuranceAuxiliaryDataRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetInsuranceAuxiliaryDataRequest))
          as GetInsuranceAuxiliaryDataRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInsuranceAuxiliaryDataRequest create() =>
      GetInsuranceAuxiliaryDataRequest._();
  @$core.override
  GetInsuranceAuxiliaryDataRequest createEmptyInstance() => create();
  static $pb.PbList<GetInsuranceAuxiliaryDataRequest> createRepeated() =>
      $pb.PbList<GetInsuranceAuxiliaryDataRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInsuranceAuxiliaryDataRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetInsuranceAuxiliaryDataRequest>(
          create);
  static GetInsuranceAuxiliaryDataRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get utilityId => $_getSZ(0);
  @$pb.TagNumber(1)
  set utilityId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUtilityId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUtilityId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get query => $_getSZ(1);
  @$pb.TagNumber(2)
  set query($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasQuery() => $_has(1);
  @$pb.TagNumber(2)
  void clearQuery() => $_clearField(2);
}

class GetInsuranceAuxiliaryDataResponse extends $pb.GeneratedMessage {
  factory GetInsuranceAuxiliaryDataResponse({
    $core.Iterable<InsuranceAuxiliaryItem>? items,
    $core.bool? success,
    $core.String? msg,
  }) {
    final result = create();
    if (items != null) result.items.addAll(items);
    if (success != null) result.success = success;
    if (msg != null) result.msg = msg;
    return result;
  }

  GetInsuranceAuxiliaryDataResponse._();

  factory GetInsuranceAuxiliaryDataResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetInsuranceAuxiliaryDataResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetInsuranceAuxiliaryDataResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..pc<InsuranceAuxiliaryItem>(
        1, _omitFieldNames ? '' : 'items', $pb.PbFieldType.PM,
        subBuilder: InsuranceAuxiliaryItem.create)
    ..aOB(2, _omitFieldNames ? '' : 'success')
    ..aOS(3, _omitFieldNames ? '' : 'msg')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsuranceAuxiliaryDataResponse clone() =>
      GetInsuranceAuxiliaryDataResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsuranceAuxiliaryDataResponse copyWith(
          void Function(GetInsuranceAuxiliaryDataResponse) updates) =>
      super.copyWith((message) =>
              updates(message as GetInsuranceAuxiliaryDataResponse))
          as GetInsuranceAuxiliaryDataResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInsuranceAuxiliaryDataResponse create() =>
      GetInsuranceAuxiliaryDataResponse._();
  @$core.override
  GetInsuranceAuxiliaryDataResponse createEmptyInstance() => create();
  static $pb.PbList<GetInsuranceAuxiliaryDataResponse> createRepeated() =>
      $pb.PbList<GetInsuranceAuxiliaryDataResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInsuranceAuxiliaryDataResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetInsuranceAuxiliaryDataResponse>(
          create);
  static GetInsuranceAuxiliaryDataResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<InsuranceAuxiliaryItem> get items => $_getList(0);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get msg => $_getSZ(2);
  @$pb.TagNumber(3)
  set msg($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMsg() => $_has(2);
  @$pb.TagNumber(3)
  void clearMsg() => $_clearField(3);
}

class InsuranceAuxiliaryItem extends $pb.GeneratedMessage {
  factory InsuranceAuxiliaryItem({
    $core.String? label,
    $core.String? value,
  }) {
    final result = create();
    if (label != null) result.label = label;
    if (value != null) result.value = value;
    return result;
  }

  InsuranceAuxiliaryItem._();

  factory InsuranceAuxiliaryItem.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InsuranceAuxiliaryItem.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InsuranceAuxiliaryItem',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'label')
    ..aOS(2, _omitFieldNames ? '' : 'value')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InsuranceAuxiliaryItem clone() =>
      InsuranceAuxiliaryItem()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InsuranceAuxiliaryItem copyWith(
          void Function(InsuranceAuxiliaryItem) updates) =>
      super.copyWith((message) => updates(message as InsuranceAuxiliaryItem))
          as InsuranceAuxiliaryItem;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InsuranceAuxiliaryItem create() => InsuranceAuxiliaryItem._();
  @$core.override
  InsuranceAuxiliaryItem createEmptyInstance() => create();
  static $pb.PbList<InsuranceAuxiliaryItem> createRepeated() =>
      $pb.PbList<InsuranceAuxiliaryItem>();
  @$core.pragma('dart2js:noInline')
  static InsuranceAuxiliaryItem getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InsuranceAuxiliaryItem>(create);
  static InsuranceAuxiliaryItem? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get label => $_getSZ(0);
  @$pb.TagNumber(1)
  set label($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasLabel() => $_has(0);
  @$pb.TagNumber(1)
  void clearLabel() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get value => $_getSZ(1);
  @$pb.TagNumber(2)
  set value($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearValue() => $_clearField(2);
}

/// NOTE: user_id extracted from JWT token, not from request
class CreateCrowdfundRequest extends $pb.GeneratedMessage {
  factory CreateCrowdfundRequest({
    $core.String? accountId,
    $core.String? title,
    $core.String? description,
    $core.String? category,
    $core.double? targetAmount,
    $core.String? deadline,
    $core.String? imageUrl,
  }) {
    final result = create();
    if (accountId != null) result.accountId = accountId;
    if (title != null) result.title = title;
    if (description != null) result.description = description;
    if (category != null) result.category = category;
    if (targetAmount != null) result.targetAmount = targetAmount;
    if (deadline != null) result.deadline = deadline;
    if (imageUrl != null) result.imageUrl = imageUrl;
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
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountId')
    ..aOS(2, _omitFieldNames ? '' : 'title')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..aOS(4, _omitFieldNames ? '' : 'category')
    ..a<$core.double>(
        5, _omitFieldNames ? '' : 'targetAmount', $pb.PbFieldType.OD)
    ..aOS(6, _omitFieldNames ? '' : 'deadline')
    ..aOS(7, _omitFieldNames ? '' : 'imageUrl')
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
  $core.String get accountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => $_clearField(1);

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
  $core.String get category => $_getSZ(3);
  @$pb.TagNumber(4)
  set category($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCategory() => $_has(3);
  @$pb.TagNumber(4)
  void clearCategory() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get targetAmount => $_getN(4);
  @$pb.TagNumber(5)
  set targetAmount($core.double value) => $_setDouble(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTargetAmount() => $_has(4);
  @$pb.TagNumber(5)
  void clearTargetAmount() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get deadline => $_getSZ(5);
  @$pb.TagNumber(6)
  set deadline($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasDeadline() => $_has(5);
  @$pb.TagNumber(6)
  void clearDeadline() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get imageUrl => $_getSZ(6);
  @$pb.TagNumber(7)
  set imageUrl($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasImageUrl() => $_has(6);
  @$pb.TagNumber(7)
  void clearImageUrl() => $_clearField(7);
}

class CreateCrowdfundResponse extends $pb.GeneratedMessage {
  factory CreateCrowdfundResponse({
    Crowdfund? crowdfund,
    $core.String? message,
  }) {
    final result = create();
    if (crowdfund != null) result.crowdfund = crowdfund;
    if (message != null) result.message = message;
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
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOM<Crowdfund>(1, _omitFieldNames ? '' : 'crowdfund',
        subBuilder: Crowdfund.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
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
  Crowdfund get crowdfund => $_getN(0);
  @$pb.TagNumber(1)
  set crowdfund(Crowdfund value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasCrowdfund() => $_has(0);
  @$pb.TagNumber(1)
  void clearCrowdfund() => $_clearField(1);
  @$pb.TagNumber(1)
  Crowdfund ensureCrowdfund() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);
}

/// NOTE: user_id extracted from JWT token, not from request
class GetCrowdfundsRequest extends $pb.GeneratedMessage {
  factory GetCrowdfundsRequest({
    $core.String? category,
    $core.String? status,
    $core.int? limit,
    $core.int? offset,
  }) {
    final result = create();
    if (category != null) result.category = category;
    if (status != null) result.status = status;
    if (limit != null) result.limit = limit;
    if (offset != null) result.offset = offset;
    return result;
  }

  GetCrowdfundsRequest._();

  factory GetCrowdfundsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetCrowdfundsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetCrowdfundsRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'category')
    ..aOS(2, _omitFieldNames ? '' : 'status')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCrowdfundsRequest clone() =>
      GetCrowdfundsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCrowdfundsRequest copyWith(void Function(GetCrowdfundsRequest) updates) =>
      super.copyWith((message) => updates(message as GetCrowdfundsRequest))
          as GetCrowdfundsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetCrowdfundsRequest create() => GetCrowdfundsRequest._();
  @$core.override
  GetCrowdfundsRequest createEmptyInstance() => create();
  static $pb.PbList<GetCrowdfundsRequest> createRepeated() =>
      $pb.PbList<GetCrowdfundsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetCrowdfundsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetCrowdfundsRequest>(create);
  static GetCrowdfundsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get category => $_getSZ(0);
  @$pb.TagNumber(1)
  set category($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCategory() => $_has(0);
  @$pb.TagNumber(1)
  void clearCategory() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get status => $_getSZ(1);
  @$pb.TagNumber(2)
  set status($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => $_clearField(2);

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

class GetCrowdfundsResponse extends $pb.GeneratedMessage {
  factory GetCrowdfundsResponse({
    $core.Iterable<Crowdfund>? crowdfunds,
    $core.int? total,
  }) {
    final result = create();
    if (crowdfunds != null) result.crowdfunds.addAll(crowdfunds);
    if (total != null) result.total = total;
    return result;
  }

  GetCrowdfundsResponse._();

  factory GetCrowdfundsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetCrowdfundsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetCrowdfundsResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..pc<Crowdfund>(1, _omitFieldNames ? '' : 'crowdfunds', $pb.PbFieldType.PM,
        subBuilder: Crowdfund.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCrowdfundsResponse clone() =>
      GetCrowdfundsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCrowdfundsResponse copyWith(
          void Function(GetCrowdfundsResponse) updates) =>
      super.copyWith((message) => updates(message as GetCrowdfundsResponse))
          as GetCrowdfundsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetCrowdfundsResponse create() => GetCrowdfundsResponse._();
  @$core.override
  GetCrowdfundsResponse createEmptyInstance() => create();
  static $pb.PbList<GetCrowdfundsResponse> createRepeated() =>
      $pb.PbList<GetCrowdfundsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetCrowdfundsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetCrowdfundsResponse>(create);
  static GetCrowdfundsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Crowdfund> get crowdfunds => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);
}

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
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
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
    Crowdfund? crowdfund,
    $core.Iterable<CrowdfundContribution>? recentContributions,
  }) {
    final result = create();
    if (crowdfund != null) result.crowdfund = crowdfund;
    if (recentContributions != null)
      result.recentContributions.addAll(recentContributions);
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
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOM<Crowdfund>(1, _omitFieldNames ? '' : 'crowdfund',
        subBuilder: Crowdfund.create)
    ..pc<CrowdfundContribution>(
        2, _omitFieldNames ? '' : 'recentContributions', $pb.PbFieldType.PM,
        subBuilder: CrowdfundContribution.create)
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
  Crowdfund get crowdfund => $_getN(0);
  @$pb.TagNumber(1)
  set crowdfund(Crowdfund value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasCrowdfund() => $_has(0);
  @$pb.TagNumber(1)
  void clearCrowdfund() => $_clearField(1);
  @$pb.TagNumber(1)
  Crowdfund ensureCrowdfund() => $_ensure(0);

  @$pb.TagNumber(2)
  $pb.PbList<CrowdfundContribution> get recentContributions => $_getList(1);
}

/// NOTE: user_id extracted from JWT token, not from request
class ContributeToCrowdfundRequest extends $pb.GeneratedMessage {
  factory ContributeToCrowdfundRequest({
    $core.String? crowdfundId,
    $core.String? accountId,
    $core.double? amount,
    $core.String? message,
    $core.bool? isAnonymous,
    $core.String? pin,
  }) {
    final result = create();
    if (crowdfundId != null) result.crowdfundId = crowdfundId;
    if (accountId != null) result.accountId = accountId;
    if (amount != null) result.amount = amount;
    if (message != null) result.message = message;
    if (isAnonymous != null) result.isAnonymous = isAnonymous;
    if (pin != null) result.pin = pin;
    return result;
  }

  ContributeToCrowdfundRequest._();

  factory ContributeToCrowdfundRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ContributeToCrowdfundRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ContributeToCrowdfundRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'crowdfundId')
    ..aOS(2, _omitFieldNames ? '' : 'accountId')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(4, _omitFieldNames ? '' : 'message')
    ..aOB(5, _omitFieldNames ? '' : 'isAnonymous')
    ..aOS(6, _omitFieldNames ? '' : 'pin')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ContributeToCrowdfundRequest clone() =>
      ContributeToCrowdfundRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ContributeToCrowdfundRequest copyWith(
          void Function(ContributeToCrowdfundRequest) updates) =>
      super.copyWith(
              (message) => updates(message as ContributeToCrowdfundRequest))
          as ContributeToCrowdfundRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ContributeToCrowdfundRequest create() =>
      ContributeToCrowdfundRequest._();
  @$core.override
  ContributeToCrowdfundRequest createEmptyInstance() => create();
  static $pb.PbList<ContributeToCrowdfundRequest> createRepeated() =>
      $pb.PbList<ContributeToCrowdfundRequest>();
  @$core.pragma('dart2js:noInline')
  static ContributeToCrowdfundRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ContributeToCrowdfundRequest>(create);
  static ContributeToCrowdfundRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get crowdfundId => $_getSZ(0);
  @$pb.TagNumber(1)
  set crowdfundId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCrowdfundId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCrowdfundId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get accountId => $_getSZ(1);
  @$pb.TagNumber(2)
  set accountId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAccountId() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccountId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get amount => $_getN(2);
  @$pb.TagNumber(3)
  set amount($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get message => $_getSZ(3);
  @$pb.TagNumber(4)
  set message($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMessage() => $_has(3);
  @$pb.TagNumber(4)
  void clearMessage() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.bool get isAnonymous => $_getBF(4);
  @$pb.TagNumber(5)
  set isAnonymous($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasIsAnonymous() => $_has(4);
  @$pb.TagNumber(5)
  void clearIsAnonymous() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get pin => $_getSZ(5);
  @$pb.TagNumber(6)
  set pin($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasPin() => $_has(5);
  @$pb.TagNumber(6)
  void clearPin() => $_clearField(6);
}

class ContributeToCrowdfundResponse extends $pb.GeneratedMessage {
  factory ContributeToCrowdfundResponse({
    Crowdfund? crowdfund,
    CrowdfundContribution? contribution,
    $core.double? newBalance,
    $core.String? message,
  }) {
    final result = create();
    if (crowdfund != null) result.crowdfund = crowdfund;
    if (contribution != null) result.contribution = contribution;
    if (newBalance != null) result.newBalance = newBalance;
    if (message != null) result.message = message;
    return result;
  }

  ContributeToCrowdfundResponse._();

  factory ContributeToCrowdfundResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ContributeToCrowdfundResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ContributeToCrowdfundResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOM<Crowdfund>(1, _omitFieldNames ? '' : 'crowdfund',
        subBuilder: Crowdfund.create)
    ..aOM<CrowdfundContribution>(2, _omitFieldNames ? '' : 'contribution',
        subBuilder: CrowdfundContribution.create)
    ..a<$core.double>(
        3, _omitFieldNames ? '' : 'newBalance', $pb.PbFieldType.OD)
    ..aOS(4, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ContributeToCrowdfundResponse clone() =>
      ContributeToCrowdfundResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ContributeToCrowdfundResponse copyWith(
          void Function(ContributeToCrowdfundResponse) updates) =>
      super.copyWith(
              (message) => updates(message as ContributeToCrowdfundResponse))
          as ContributeToCrowdfundResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ContributeToCrowdfundResponse create() =>
      ContributeToCrowdfundResponse._();
  @$core.override
  ContributeToCrowdfundResponse createEmptyInstance() => create();
  static $pb.PbList<ContributeToCrowdfundResponse> createRepeated() =>
      $pb.PbList<ContributeToCrowdfundResponse>();
  @$core.pragma('dart2js:noInline')
  static ContributeToCrowdfundResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ContributeToCrowdfundResponse>(create);
  static ContributeToCrowdfundResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Crowdfund get crowdfund => $_getN(0);
  @$pb.TagNumber(1)
  set crowdfund(Crowdfund value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasCrowdfund() => $_has(0);
  @$pb.TagNumber(1)
  void clearCrowdfund() => $_clearField(1);
  @$pb.TagNumber(1)
  Crowdfund ensureCrowdfund() => $_ensure(0);

  @$pb.TagNumber(2)
  CrowdfundContribution get contribution => $_getN(1);
  @$pb.TagNumber(2)
  set contribution(CrowdfundContribution value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasContribution() => $_has(1);
  @$pb.TagNumber(2)
  void clearContribution() => $_clearField(2);
  @$pb.TagNumber(2)
  CrowdfundContribution ensureContribution() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.double get newBalance => $_getN(2);
  @$pb.TagNumber(3)
  set newBalance($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasNewBalance() => $_has(2);
  @$pb.TagNumber(3)
  void clearNewBalance() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get message => $_getSZ(3);
  @$pb.TagNumber(4)
  set message($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMessage() => $_has(3);
  @$pb.TagNumber(4)
  void clearMessage() => $_clearField(4);
}

/// NOTE: user_id extracted from JWT token, not from request
class WithdrawFromCrowdfundRequest extends $pb.GeneratedMessage {
  factory WithdrawFromCrowdfundRequest({
    $core.String? crowdfundId,
    $core.double? amount,
    $core.String? pin,
    $core.String? destinationAccountId,
    $core.String? destinationAccountType,
  }) {
    final result = create();
    if (crowdfundId != null) result.crowdfundId = crowdfundId;
    if (amount != null) result.amount = amount;
    if (pin != null) result.pin = pin;
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
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'crowdfundId')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(3, _omitFieldNames ? '' : 'pin')
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
  $core.double get amount => $_getN(1);
  @$pb.TagNumber(2)
  set amount($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get pin => $_getSZ(2);
  @$pb.TagNumber(3)
  set pin($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPin() => $_has(2);
  @$pb.TagNumber(3)
  void clearPin() => $_clearField(3);

  /// Destination account for withdrawal - one of the following must be specified:
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
    Crowdfund? crowdfund,
    $core.double? amountWithdrawn,
    $core.String? message,
    $core.String? destinationAccountId,
    $core.double? destinationNewBalance,
  }) {
    final result = create();
    if (crowdfund != null) result.crowdfund = crowdfund;
    if (amountWithdrawn != null) result.amountWithdrawn = amountWithdrawn;
    if (message != null) result.message = message;
    if (destinationAccountId != null)
      result.destinationAccountId = destinationAccountId;
    if (destinationNewBalance != null)
      result.destinationNewBalance = destinationNewBalance;
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
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOM<Crowdfund>(1, _omitFieldNames ? '' : 'crowdfund',
        subBuilder: Crowdfund.create)
    ..a<$core.double>(
        2, _omitFieldNames ? '' : 'amountWithdrawn', $pb.PbFieldType.OD)
    ..aOS(3, _omitFieldNames ? '' : 'message')
    ..aOS(4, _omitFieldNames ? '' : 'destinationAccountId')
    ..a<$core.double>(
        5, _omitFieldNames ? '' : 'destinationNewBalance', $pb.PbFieldType.OD)
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
  Crowdfund get crowdfund => $_getN(0);
  @$pb.TagNumber(1)
  set crowdfund(Crowdfund value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasCrowdfund() => $_has(0);
  @$pb.TagNumber(1)
  void clearCrowdfund() => $_clearField(1);
  @$pb.TagNumber(1)
  Crowdfund ensureCrowdfund() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.double get amountWithdrawn => $_getN(1);
  @$pb.TagNumber(2)
  set amountWithdrawn($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAmountWithdrawn() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmountWithdrawn() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get destinationAccountId => $_getSZ(3);
  @$pb.TagNumber(4)
  set destinationAccountId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDestinationAccountId() => $_has(3);
  @$pb.TagNumber(4)
  void clearDestinationAccountId() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get destinationNewBalance => $_getN(4);
  @$pb.TagNumber(5)
  set destinationNewBalance($core.double value) => $_setDouble(4, value);
  @$pb.TagNumber(5)
  $core.bool hasDestinationNewBalance() => $_has(4);
  @$pb.TagNumber(5)
  void clearDestinationNewBalance() => $_clearField(5);
}

/// NOTE: user_id extracted from JWT token, not from request
class CloseCrowdfundRequest extends $pb.GeneratedMessage {
  factory CloseCrowdfundRequest({
    $core.String? crowdfundId,
  }) {
    final result = create();
    if (crowdfundId != null) result.crowdfundId = crowdfundId;
    return result;
  }

  CloseCrowdfundRequest._();

  factory CloseCrowdfundRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CloseCrowdfundRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CloseCrowdfundRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'crowdfundId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CloseCrowdfundRequest clone() =>
      CloseCrowdfundRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CloseCrowdfundRequest copyWith(
          void Function(CloseCrowdfundRequest) updates) =>
      super.copyWith((message) => updates(message as CloseCrowdfundRequest))
          as CloseCrowdfundRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CloseCrowdfundRequest create() => CloseCrowdfundRequest._();
  @$core.override
  CloseCrowdfundRequest createEmptyInstance() => create();
  static $pb.PbList<CloseCrowdfundRequest> createRepeated() =>
      $pb.PbList<CloseCrowdfundRequest>();
  @$core.pragma('dart2js:noInline')
  static CloseCrowdfundRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CloseCrowdfundRequest>(create);
  static CloseCrowdfundRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get crowdfundId => $_getSZ(0);
  @$pb.TagNumber(1)
  set crowdfundId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCrowdfundId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCrowdfundId() => $_clearField(1);
}

class CloseCrowdfundResponse extends $pb.GeneratedMessage {
  factory CloseCrowdfundResponse({
    Crowdfund? crowdfund,
    $core.String? message,
  }) {
    final result = create();
    if (crowdfund != null) result.crowdfund = crowdfund;
    if (message != null) result.message = message;
    return result;
  }

  CloseCrowdfundResponse._();

  factory CloseCrowdfundResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CloseCrowdfundResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CloseCrowdfundResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOM<Crowdfund>(1, _omitFieldNames ? '' : 'crowdfund',
        subBuilder: Crowdfund.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CloseCrowdfundResponse clone() =>
      CloseCrowdfundResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CloseCrowdfundResponse copyWith(
          void Function(CloseCrowdfundResponse) updates) =>
      super.copyWith((message) => updates(message as CloseCrowdfundResponse))
          as CloseCrowdfundResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CloseCrowdfundResponse create() => CloseCrowdfundResponse._();
  @$core.override
  CloseCrowdfundResponse createEmptyInstance() => create();
  static $pb.PbList<CloseCrowdfundResponse> createRepeated() =>
      $pb.PbList<CloseCrowdfundResponse>();
  @$core.pragma('dart2js:noInline')
  static CloseCrowdfundResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CloseCrowdfundResponse>(create);
  static CloseCrowdfundResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Crowdfund get crowdfund => $_getN(0);
  @$pb.TagNumber(1)
  set crowdfund(Crowdfund value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasCrowdfund() => $_has(0);
  @$pb.TagNumber(1)
  void clearCrowdfund() => $_clearField(1);
  @$pb.TagNumber(1)
  Crowdfund ensureCrowdfund() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);
}

class GetCrowdfundStatisticsRequest extends $pb.GeneratedMessage {
  factory GetCrowdfundStatisticsRequest({
    $core.String? crowdfundId,
    $core.bool? includeLeaderboard,
    $core.bool? includeDailyProgress,
    $core.int? leaderboardLimit,
    $core.int? progressDays,
  }) {
    final result = create();
    if (crowdfundId != null) result.crowdfundId = crowdfundId;
    if (includeLeaderboard != null)
      result.includeLeaderboard = includeLeaderboard;
    if (includeDailyProgress != null)
      result.includeDailyProgress = includeDailyProgress;
    if (leaderboardLimit != null) result.leaderboardLimit = leaderboardLimit;
    if (progressDays != null) result.progressDays = progressDays;
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
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'crowdfundId')
    ..aOB(2, _omitFieldNames ? '' : 'includeLeaderboard')
    ..aOB(3, _omitFieldNames ? '' : 'includeDailyProgress')
    ..a<$core.int>(
        4, _omitFieldNames ? '' : 'leaderboardLimit', $pb.PbFieldType.O3)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'progressDays', $pb.PbFieldType.O3)
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

  @$pb.TagNumber(2)
  $core.bool get includeLeaderboard => $_getBF(1);
  @$pb.TagNumber(2)
  set includeLeaderboard($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasIncludeLeaderboard() => $_has(1);
  @$pb.TagNumber(2)
  void clearIncludeLeaderboard() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.bool get includeDailyProgress => $_getBF(2);
  @$pb.TagNumber(3)
  set includeDailyProgress($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasIncludeDailyProgress() => $_has(2);
  @$pb.TagNumber(3)
  void clearIncludeDailyProgress() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get leaderboardLimit => $_getIZ(3);
  @$pb.TagNumber(4)
  set leaderboardLimit($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasLeaderboardLimit() => $_has(3);
  @$pb.TagNumber(4)
  void clearLeaderboardLimit() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get progressDays => $_getIZ(4);
  @$pb.TagNumber(5)
  set progressDays($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasProgressDays() => $_has(4);
  @$pb.TagNumber(5)
  void clearProgressDays() => $_clearField(5);
}

class GetCrowdfundStatisticsResponse extends $pb.GeneratedMessage {
  factory GetCrowdfundStatisticsResponse({
    CrowdfundStatistics? statistics,
  }) {
    final result = create();
    if (statistics != null) result.statistics = statistics;
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
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOM<CrowdfundStatistics>(1, _omitFieldNames ? '' : 'statistics',
        subBuilder: CrowdfundStatistics.create)
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
  CrowdfundStatistics get statistics => $_getN(0);
  @$pb.TagNumber(1)
  set statistics(CrowdfundStatistics value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasStatistics() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatistics() => $_clearField(1);
  @$pb.TagNumber(1)
  CrowdfundStatistics ensureStatistics() => $_ensure(0);
}

/// Enhanced crowdfund statistics with analytics
class CrowdfundStatistics extends $pb.GeneratedMessage {
  factory CrowdfundStatistics({
    $core.String? crowdfundId,
    $core.double? totalRaised,
    $core.double? targetAmount,
    $core.double? progressPercentage,
    $core.int? donorCount,
    $core.double? averageDonation,
    $core.double? largestDonation,
    $core.double? smallestDonation,
    $core.int? daysRemaining,
    $core.int? daysActive,
    $core.bool? isCompleted,
    $core.String? createdAt,
    $core.Iterable<ContributorLeaderboardEntry>? topContributors,
    $core.Iterable<DailyProgress>? dailyProgress,
    $core.double? fundingVelocity,
    $core.String? projectedCompletionDate,
    $core.int? newDonorsToday,
    $core.int? newDonorsThisWeek,
    $core.double? amountRaisedToday,
    $core.double? amountRaisedThisWeek,
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
    if (smallestDonation != null) result.smallestDonation = smallestDonation;
    if (daysRemaining != null) result.daysRemaining = daysRemaining;
    if (daysActive != null) result.daysActive = daysActive;
    if (isCompleted != null) result.isCompleted = isCompleted;
    if (createdAt != null) result.createdAt = createdAt;
    if (topContributors != null) result.topContributors.addAll(topContributors);
    if (dailyProgress != null) result.dailyProgress.addAll(dailyProgress);
    if (fundingVelocity != null) result.fundingVelocity = fundingVelocity;
    if (projectedCompletionDate != null)
      result.projectedCompletionDate = projectedCompletionDate;
    if (newDonorsToday != null) result.newDonorsToday = newDonorsToday;
    if (newDonorsThisWeek != null) result.newDonorsThisWeek = newDonorsThisWeek;
    if (amountRaisedToday != null) result.amountRaisedToday = amountRaisedToday;
    if (amountRaisedThisWeek != null)
      result.amountRaisedThisWeek = amountRaisedThisWeek;
    return result;
  }

  CrowdfundStatistics._();

  factory CrowdfundStatistics.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CrowdfundStatistics.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CrowdfundStatistics',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'crowdfundId')
    ..a<$core.double>(
        2, _omitFieldNames ? '' : 'totalRaised', $pb.PbFieldType.OD)
    ..a<$core.double>(
        3, _omitFieldNames ? '' : 'targetAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(
        4, _omitFieldNames ? '' : 'progressPercentage', $pb.PbFieldType.OD)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'donorCount', $pb.PbFieldType.O3)
    ..a<$core.double>(
        6, _omitFieldNames ? '' : 'averageDonation', $pb.PbFieldType.OD)
    ..a<$core.double>(
        7, _omitFieldNames ? '' : 'largestDonation', $pb.PbFieldType.OD)
    ..a<$core.double>(
        8, _omitFieldNames ? '' : 'smallestDonation', $pb.PbFieldType.OD)
    ..a<$core.int>(
        9, _omitFieldNames ? '' : 'daysRemaining', $pb.PbFieldType.O3)
    ..a<$core.int>(10, _omitFieldNames ? '' : 'daysActive', $pb.PbFieldType.O3)
    ..aOB(11, _omitFieldNames ? '' : 'isCompleted')
    ..aOS(12, _omitFieldNames ? '' : 'createdAt')
    ..pc<ContributorLeaderboardEntry>(
        13, _omitFieldNames ? '' : 'topContributors', $pb.PbFieldType.PM,
        subBuilder: ContributorLeaderboardEntry.create)
    ..pc<DailyProgress>(
        14, _omitFieldNames ? '' : 'dailyProgress', $pb.PbFieldType.PM,
        subBuilder: DailyProgress.create)
    ..a<$core.double>(
        15, _omitFieldNames ? '' : 'fundingVelocity', $pb.PbFieldType.OD)
    ..aOS(16, _omitFieldNames ? '' : 'projectedCompletionDate')
    ..a<$core.int>(
        17, _omitFieldNames ? '' : 'newDonorsToday', $pb.PbFieldType.O3)
    ..a<$core.int>(
        18, _omitFieldNames ? '' : 'newDonorsThisWeek', $pb.PbFieldType.O3)
    ..a<$core.double>(
        19, _omitFieldNames ? '' : 'amountRaisedToday', $pb.PbFieldType.OD)
    ..a<$core.double>(
        20, _omitFieldNames ? '' : 'amountRaisedThisWeek', $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CrowdfundStatistics clone() => CrowdfundStatistics()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CrowdfundStatistics copyWith(void Function(CrowdfundStatistics) updates) =>
      super.copyWith((message) => updates(message as CrowdfundStatistics))
          as CrowdfundStatistics;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CrowdfundStatistics create() => CrowdfundStatistics._();
  @$core.override
  CrowdfundStatistics createEmptyInstance() => create();
  static $pb.PbList<CrowdfundStatistics> createRepeated() =>
      $pb.PbList<CrowdfundStatistics>();
  @$core.pragma('dart2js:noInline')
  static CrowdfundStatistics getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CrowdfundStatistics>(create);
  static CrowdfundStatistics? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get crowdfundId => $_getSZ(0);
  @$pb.TagNumber(1)
  set crowdfundId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCrowdfundId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCrowdfundId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get totalRaised => $_getN(1);
  @$pb.TagNumber(2)
  set totalRaised($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotalRaised() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalRaised() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get targetAmount => $_getN(2);
  @$pb.TagNumber(3)
  set targetAmount($core.double value) => $_setDouble(2, value);
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
  $core.double get averageDonation => $_getN(5);
  @$pb.TagNumber(6)
  set averageDonation($core.double value) => $_setDouble(5, value);
  @$pb.TagNumber(6)
  $core.bool hasAverageDonation() => $_has(5);
  @$pb.TagNumber(6)
  void clearAverageDonation() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.double get largestDonation => $_getN(6);
  @$pb.TagNumber(7)
  set largestDonation($core.double value) => $_setDouble(6, value);
  @$pb.TagNumber(7)
  $core.bool hasLargestDonation() => $_has(6);
  @$pb.TagNumber(7)
  void clearLargestDonation() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.double get smallestDonation => $_getN(7);
  @$pb.TagNumber(8)
  set smallestDonation($core.double value) => $_setDouble(7, value);
  @$pb.TagNumber(8)
  $core.bool hasSmallestDonation() => $_has(7);
  @$pb.TagNumber(8)
  void clearSmallestDonation() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.int get daysRemaining => $_getIZ(8);
  @$pb.TagNumber(9)
  set daysRemaining($core.int value) => $_setSignedInt32(8, value);
  @$pb.TagNumber(9)
  $core.bool hasDaysRemaining() => $_has(8);
  @$pb.TagNumber(9)
  void clearDaysRemaining() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.int get daysActive => $_getIZ(9);
  @$pb.TagNumber(10)
  set daysActive($core.int value) => $_setSignedInt32(9, value);
  @$pb.TagNumber(10)
  $core.bool hasDaysActive() => $_has(9);
  @$pb.TagNumber(10)
  void clearDaysActive() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.bool get isCompleted => $_getBF(10);
  @$pb.TagNumber(11)
  set isCompleted($core.bool value) => $_setBool(10, value);
  @$pb.TagNumber(11)
  $core.bool hasIsCompleted() => $_has(10);
  @$pb.TagNumber(11)
  void clearIsCompleted() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get createdAt => $_getSZ(11);
  @$pb.TagNumber(12)
  set createdAt($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasCreatedAt() => $_has(11);
  @$pb.TagNumber(12)
  void clearCreatedAt() => $_clearField(12);

  /// Enhanced analytics
  @$pb.TagNumber(13)
  $pb.PbList<ContributorLeaderboardEntry> get topContributors => $_getList(12);

  @$pb.TagNumber(14)
  $pb.PbList<DailyProgress> get dailyProgress => $_getList(13);

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

  @$pb.TagNumber(17)
  $core.int get newDonorsToday => $_getIZ(16);
  @$pb.TagNumber(17)
  set newDonorsToday($core.int value) => $_setSignedInt32(16, value);
  @$pb.TagNumber(17)
  $core.bool hasNewDonorsToday() => $_has(16);
  @$pb.TagNumber(17)
  void clearNewDonorsToday() => $_clearField(17);

  @$pb.TagNumber(18)
  $core.int get newDonorsThisWeek => $_getIZ(17);
  @$pb.TagNumber(18)
  set newDonorsThisWeek($core.int value) => $_setSignedInt32(17, value);
  @$pb.TagNumber(18)
  $core.bool hasNewDonorsThisWeek() => $_has(17);
  @$pb.TagNumber(18)
  void clearNewDonorsThisWeek() => $_clearField(18);

  @$pb.TagNumber(19)
  $core.double get amountRaisedToday => $_getN(18);
  @$pb.TagNumber(19)
  set amountRaisedToday($core.double value) => $_setDouble(18, value);
  @$pb.TagNumber(19)
  $core.bool hasAmountRaisedToday() => $_has(18);
  @$pb.TagNumber(19)
  void clearAmountRaisedToday() => $_clearField(19);

  @$pb.TagNumber(20)
  $core.double get amountRaisedThisWeek => $_getN(19);
  @$pb.TagNumber(20)
  set amountRaisedThisWeek($core.double value) => $_setDouble(19, value);
  @$pb.TagNumber(20)
  $core.bool hasAmountRaisedThisWeek() => $_has(19);
  @$pb.TagNumber(20)
  void clearAmountRaisedThisWeek() => $_clearField(20);
}

/// Leaderboard entry for top contributors
class ContributorLeaderboardEntry extends $pb.GeneratedMessage {
  factory ContributorLeaderboardEntry({
    $core.int? rank,
    $core.String? userId,
    $core.String? displayName,
    $core.String? profilePicture,
    $core.double? totalAmount,
    $core.int? contributionCount,
    $core.bool? isAnonymous,
    $core.String? firstContributionDate,
    $core.String? lastContributionDate,
  }) {
    final result = create();
    if (rank != null) result.rank = rank;
    if (userId != null) result.userId = userId;
    if (displayName != null) result.displayName = displayName;
    if (profilePicture != null) result.profilePicture = profilePicture;
    if (totalAmount != null) result.totalAmount = totalAmount;
    if (contributionCount != null) result.contributionCount = contributionCount;
    if (isAnonymous != null) result.isAnonymous = isAnonymous;
    if (firstContributionDate != null)
      result.firstContributionDate = firstContributionDate;
    if (lastContributionDate != null)
      result.lastContributionDate = lastContributionDate;
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
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'rank', $pb.PbFieldType.O3)
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'displayName')
    ..aOS(4, _omitFieldNames ? '' : 'profilePicture')
    ..a<$core.double>(
        5, _omitFieldNames ? '' : 'totalAmount', $pb.PbFieldType.OD)
    ..a<$core.int>(
        6, _omitFieldNames ? '' : 'contributionCount', $pb.PbFieldType.O3)
    ..aOB(7, _omitFieldNames ? '' : 'isAnonymous')
    ..aOS(8, _omitFieldNames ? '' : 'firstContributionDate')
    ..aOS(9, _omitFieldNames ? '' : 'lastContributionDate')
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
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get displayName => $_getSZ(2);
  @$pb.TagNumber(3)
  set displayName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDisplayName() => $_has(2);
  @$pb.TagNumber(3)
  void clearDisplayName() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get profilePicture => $_getSZ(3);
  @$pb.TagNumber(4)
  set profilePicture($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasProfilePicture() => $_has(3);
  @$pb.TagNumber(4)
  void clearProfilePicture() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get totalAmount => $_getN(4);
  @$pb.TagNumber(5)
  set totalAmount($core.double value) => $_setDouble(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTotalAmount() => $_has(4);
  @$pb.TagNumber(5)
  void clearTotalAmount() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.int get contributionCount => $_getIZ(5);
  @$pb.TagNumber(6)
  set contributionCount($core.int value) => $_setSignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasContributionCount() => $_has(5);
  @$pb.TagNumber(6)
  void clearContributionCount() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.bool get isAnonymous => $_getBF(6);
  @$pb.TagNumber(7)
  set isAnonymous($core.bool value) => $_setBool(6, value);
  @$pb.TagNumber(7)
  $core.bool hasIsAnonymous() => $_has(6);
  @$pb.TagNumber(7)
  void clearIsAnonymous() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get firstContributionDate => $_getSZ(7);
  @$pb.TagNumber(8)
  set firstContributionDate($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasFirstContributionDate() => $_has(7);
  @$pb.TagNumber(8)
  void clearFirstContributionDate() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get lastContributionDate => $_getSZ(8);
  @$pb.TagNumber(9)
  set lastContributionDate($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasLastContributionDate() => $_has(8);
  @$pb.TagNumber(9)
  void clearLastContributionDate() => $_clearField(9);
}

/// Daily progress tracking for charts
class DailyProgress extends $pb.GeneratedMessage {
  factory DailyProgress({
    $core.String? date,
    $core.double? amountRaised,
    $core.int? newDonors,
    $core.int? totalContributions,
    $core.double? cumulativeAmount,
    $core.double? progressPercentage,
  }) {
    final result = create();
    if (date != null) result.date = date;
    if (amountRaised != null) result.amountRaised = amountRaised;
    if (newDonors != null) result.newDonors = newDonors;
    if (totalContributions != null)
      result.totalContributions = totalContributions;
    if (cumulativeAmount != null) result.cumulativeAmount = cumulativeAmount;
    if (progressPercentage != null)
      result.progressPercentage = progressPercentage;
    return result;
  }

  DailyProgress._();

  factory DailyProgress.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DailyProgress.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DailyProgress',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'date')
    ..a<$core.double>(
        2, _omitFieldNames ? '' : 'amountRaised', $pb.PbFieldType.OD)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'newDonors', $pb.PbFieldType.O3)
    ..a<$core.int>(
        4, _omitFieldNames ? '' : 'totalContributions', $pb.PbFieldType.O3)
    ..a<$core.double>(
        5, _omitFieldNames ? '' : 'cumulativeAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(
        6, _omitFieldNames ? '' : 'progressPercentage', $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DailyProgress clone() => DailyProgress()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DailyProgress copyWith(void Function(DailyProgress) updates) =>
      super.copyWith((message) => updates(message as DailyProgress))
          as DailyProgress;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DailyProgress create() => DailyProgress._();
  @$core.override
  DailyProgress createEmptyInstance() => create();
  static $pb.PbList<DailyProgress> createRepeated() =>
      $pb.PbList<DailyProgress>();
  @$core.pragma('dart2js:noInline')
  static DailyProgress getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DailyProgress>(create);
  static DailyProgress? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get date => $_getSZ(0);
  @$pb.TagNumber(1)
  set date($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDate() => $_has(0);
  @$pb.TagNumber(1)
  void clearDate() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get amountRaised => $_getN(1);
  @$pb.TagNumber(2)
  set amountRaised($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAmountRaised() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmountRaised() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get newDonors => $_getIZ(2);
  @$pb.TagNumber(3)
  set newDonors($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasNewDonors() => $_has(2);
  @$pb.TagNumber(3)
  void clearNewDonors() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get totalContributions => $_getIZ(3);
  @$pb.TagNumber(4)
  set totalContributions($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTotalContributions() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalContributions() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get cumulativeAmount => $_getN(4);
  @$pb.TagNumber(5)
  set cumulativeAmount($core.double value) => $_setDouble(4, value);
  @$pb.TagNumber(5)
  $core.bool hasCumulativeAmount() => $_has(4);
  @$pb.TagNumber(5)
  void clearCumulativeAmount() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.double get progressPercentage => $_getN(5);
  @$pb.TagNumber(6)
  set progressPercentage($core.double value) => $_setDouble(5, value);
  @$pb.TagNumber(6)
  $core.bool hasProgressPercentage() => $_has(5);
  @$pb.TagNumber(6)
  void clearProgressPercentage() => $_clearField(6);
}

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
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
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
    $core.Iterable<Crowdfund>? crowdfunds,
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
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..pc<Crowdfund>(1, _omitFieldNames ? '' : 'crowdfunds', $pb.PbFieldType.PM,
        subBuilder: Crowdfund.create)
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
  $pb.PbList<Crowdfund> get crowdfunds => $_getList(0);
}

/// NOTE: user_id extracted from JWT token, not from request
class UpdateCrowdfundRequest extends $pb.GeneratedMessage {
  factory UpdateCrowdfundRequest({
    $core.String? crowdfundId,
    $core.String? title,
    $core.String? description,
    $core.String? category,
    $core.double? targetAmount,
    $core.String? deadline,
    $core.String? imageUrl,
    $core.String? status,
  }) {
    final result = create();
    if (crowdfundId != null) result.crowdfundId = crowdfundId;
    if (title != null) result.title = title;
    if (description != null) result.description = description;
    if (category != null) result.category = category;
    if (targetAmount != null) result.targetAmount = targetAmount;
    if (deadline != null) result.deadline = deadline;
    if (imageUrl != null) result.imageUrl = imageUrl;
    if (status != null) result.status = status;
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
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'crowdfundId')
    ..aOS(2, _omitFieldNames ? '' : 'title')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..aOS(4, _omitFieldNames ? '' : 'category')
    ..a<$core.double>(
        5, _omitFieldNames ? '' : 'targetAmount', $pb.PbFieldType.OD)
    ..aOS(6, _omitFieldNames ? '' : 'deadline')
    ..aOS(7, _omitFieldNames ? '' : 'imageUrl')
    ..aOS(8, _omitFieldNames ? '' : 'status')
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
  $core.String get category => $_getSZ(3);
  @$pb.TagNumber(4)
  set category($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCategory() => $_has(3);
  @$pb.TagNumber(4)
  void clearCategory() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get targetAmount => $_getN(4);
  @$pb.TagNumber(5)
  set targetAmount($core.double value) => $_setDouble(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTargetAmount() => $_has(4);
  @$pb.TagNumber(5)
  void clearTargetAmount() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get deadline => $_getSZ(5);
  @$pb.TagNumber(6)
  set deadline($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasDeadline() => $_has(5);
  @$pb.TagNumber(6)
  void clearDeadline() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get imageUrl => $_getSZ(6);
  @$pb.TagNumber(7)
  set imageUrl($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasImageUrl() => $_has(6);
  @$pb.TagNumber(7)
  void clearImageUrl() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get status => $_getSZ(7);
  @$pb.TagNumber(8)
  set status($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasStatus() => $_has(7);
  @$pb.TagNumber(8)
  void clearStatus() => $_clearField(8);
}

class UpdateCrowdfundResponse extends $pb.GeneratedMessage {
  factory UpdateCrowdfundResponse({
    Crowdfund? crowdfund,
    $core.String? message,
  }) {
    final result = create();
    if (crowdfund != null) result.crowdfund = crowdfund;
    if (message != null) result.message = message;
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
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOM<Crowdfund>(1, _omitFieldNames ? '' : 'crowdfund',
        subBuilder: Crowdfund.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
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
  Crowdfund get crowdfund => $_getN(0);
  @$pb.TagNumber(1)
  set crowdfund(Crowdfund value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasCrowdfund() => $_has(0);
  @$pb.TagNumber(1)
  void clearCrowdfund() => $_clearField(1);
  @$pb.TagNumber(1)
  Crowdfund ensureCrowdfund() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);
}

/// NOTE: user_id extracted from JWT token, not from request
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
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
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
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
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
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
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
    $core.Iterable<CrowdfundContribution>? donations,
    $core.int? total,
    $core.int? page,
    $core.int? pageSize,
    $core.bool? hasMore,
  }) {
    final result = create();
    if (donations != null) result.donations.addAll(donations);
    if (total != null) result.total = total;
    if (page != null) result.page = page;
    if (pageSize != null) result.pageSize = pageSize;
    if (hasMore != null) result.hasMore = hasMore;
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
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..pc<CrowdfundContribution>(
        1, _omitFieldNames ? '' : 'donations', $pb.PbFieldType.PM,
        subBuilder: CrowdfundContribution.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOB(5, _omitFieldNames ? '' : 'hasMore')
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
  $pb.PbList<CrowdfundContribution> get donations => $_getList(0);

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

/// NOTE: user_id extracted from JWT token, not from request
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
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
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
    $core.Iterable<CrowdfundContribution>? donations,
    $core.int? total,
    $core.int? page,
    $core.int? pageSize,
    $core.bool? hasMore,
  }) {
    final result = create();
    if (donations != null) result.donations.addAll(donations);
    if (total != null) result.total = total;
    if (page != null) result.page = page;
    if (pageSize != null) result.pageSize = pageSize;
    if (hasMore != null) result.hasMore = hasMore;
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
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..pc<CrowdfundContribution>(
        1, _omitFieldNames ? '' : 'donations', $pb.PbFieldType.PM,
        subBuilder: CrowdfundContribution.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOB(5, _omitFieldNames ? '' : 'hasMore')
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
  $pb.PbList<CrowdfundContribution> get donations => $_getList(0);

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

/// NOTE: user_id extracted from JWT token, not from request
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
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
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
    CrowdfundReceipt? receipt,
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
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOM<CrowdfundReceipt>(1, _omitFieldNames ? '' : 'receipt',
        subBuilder: CrowdfundReceipt.create)
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
  CrowdfundReceipt get receipt => $_getN(0);
  @$pb.TagNumber(1)
  set receipt(CrowdfundReceipt value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasReceipt() => $_has(0);
  @$pb.TagNumber(1)
  void clearReceipt() => $_clearField(1);
  @$pb.TagNumber(1)
  CrowdfundReceipt ensureReceipt() => $_ensure(0);
}

/// NOTE: user_id extracted from JWT token, not from request
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
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
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
    $core.Iterable<CrowdfundReceipt>? receipts,
    $core.int? total,
    $core.int? page,
    $core.int? pageSize,
    $core.bool? hasMore,
  }) {
    final result = create();
    if (receipts != null) result.receipts.addAll(receipts);
    if (total != null) result.total = total;
    if (page != null) result.page = page;
    if (pageSize != null) result.pageSize = pageSize;
    if (hasMore != null) result.hasMore = hasMore;
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
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..pc<CrowdfundReceipt>(
        1, _omitFieldNames ? '' : 'receipts', $pb.PbFieldType.PM,
        subBuilder: CrowdfundReceipt.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOB(5, _omitFieldNames ? '' : 'hasMore')
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
  $pb.PbList<CrowdfundReceipt> get receipts => $_getList(0);

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

/// Crowdfund donation receipt model
class CrowdfundReceipt extends $pb.GeneratedMessage {
  factory CrowdfundReceipt({
    $core.String? id,
    $core.String? donationId,
    $core.String? crowdfundId,
    $core.String? crowdfundTitle,
    $core.String? donorUserId,
    $core.String? donorName,
    $core.double? amount,
    $core.String? currency,
    $core.String? donationDate,
    $core.String? generatedAt,
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

  CrowdfundReceipt._();

  factory CrowdfundReceipt.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CrowdfundReceipt.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CrowdfundReceipt',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'donationId')
    ..aOS(3, _omitFieldNames ? '' : 'crowdfundId')
    ..aOS(4, _omitFieldNames ? '' : 'crowdfundTitle')
    ..aOS(5, _omitFieldNames ? '' : 'donorUserId')
    ..aOS(6, _omitFieldNames ? '' : 'donorName')
    ..a<$core.double>(7, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(8, _omitFieldNames ? '' : 'currency')
    ..aOS(9, _omitFieldNames ? '' : 'donationDate')
    ..aOS(10, _omitFieldNames ? '' : 'generatedAt')
    ..aOS(11, _omitFieldNames ? '' : 'receiptNumber')
    ..aOS(12, _omitFieldNames ? '' : 'receiptData')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CrowdfundReceipt clone() => CrowdfundReceipt()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CrowdfundReceipt copyWith(void Function(CrowdfundReceipt) updates) =>
      super.copyWith((message) => updates(message as CrowdfundReceipt))
          as CrowdfundReceipt;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CrowdfundReceipt create() => CrowdfundReceipt._();
  @$core.override
  CrowdfundReceipt createEmptyInstance() => create();
  static $pb.PbList<CrowdfundReceipt> createRepeated() =>
      $pb.PbList<CrowdfundReceipt>();
  @$core.pragma('dart2js:noInline')
  static CrowdfundReceipt getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CrowdfundReceipt>(create);
  static CrowdfundReceipt? _defaultInstance;

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
  $core.String get donorUserId => $_getSZ(4);
  @$pb.TagNumber(5)
  set donorUserId($core.String value) => $_setString(4, value);
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
  $core.double get amount => $_getN(6);
  @$pb.TagNumber(7)
  set amount($core.double value) => $_setDouble(6, value);
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
  $core.String get donationDate => $_getSZ(8);
  @$pb.TagNumber(9)
  set donationDate($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasDonationDate() => $_has(8);
  @$pb.TagNumber(9)
  void clearDonationDate() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get generatedAt => $_getSZ(9);
  @$pb.TagNumber(10)
  set generatedAt($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasGeneratedAt() => $_has(9);
  @$pb.TagNumber(10)
  void clearGeneratedAt() => $_clearField(10);

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

/// Insurance payment record
class InsurancePaymentRecord extends $pb.GeneratedMessage {
  factory InsurancePaymentRecord({
    $core.String? id,
    $core.String? userId,
    $core.String? policyId,
    $core.String? accountId,
    $core.String? purchaseId,
    $fixnum.Int64? amount,
    $core.String? currency,
    $core.String? paymentMethod,
    $core.String? status,
    $core.String? transactionReference,
    $core.String? idempotencyKey,
    $core.String? narration,
    $core.String? failureReason,
    $core.String? receiptNumber,
    $core.String? processedAt,
    $core.String? createdAt,
    $core.String? updatedAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (userId != null) result.userId = userId;
    if (policyId != null) result.policyId = policyId;
    if (accountId != null) result.accountId = accountId;
    if (purchaseId != null) result.purchaseId = purchaseId;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    if (paymentMethod != null) result.paymentMethod = paymentMethod;
    if (status != null) result.status = status;
    if (transactionReference != null)
      result.transactionReference = transactionReference;
    if (idempotencyKey != null) result.idempotencyKey = idempotencyKey;
    if (narration != null) result.narration = narration;
    if (failureReason != null) result.failureReason = failureReason;
    if (receiptNumber != null) result.receiptNumber = receiptNumber;
    if (processedAt != null) result.processedAt = processedAt;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    return result;
  }

  InsurancePaymentRecord._();

  factory InsurancePaymentRecord.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InsurancePaymentRecord.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InsurancePaymentRecord',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'policyId')
    ..aOS(4, _omitFieldNames ? '' : 'accountId')
    ..aOS(5, _omitFieldNames ? '' : 'purchaseId')
    ..aInt64(6, _omitFieldNames ? '' : 'amount')
    ..aOS(7, _omitFieldNames ? '' : 'currency')
    ..aOS(8, _omitFieldNames ? '' : 'paymentMethod')
    ..aOS(9, _omitFieldNames ? '' : 'status')
    ..aOS(10, _omitFieldNames ? '' : 'transactionReference')
    ..aOS(11, _omitFieldNames ? '' : 'idempotencyKey')
    ..aOS(12, _omitFieldNames ? '' : 'narration')
    ..aOS(13, _omitFieldNames ? '' : 'failureReason')
    ..aOS(14, _omitFieldNames ? '' : 'receiptNumber')
    ..aOS(15, _omitFieldNames ? '' : 'processedAt')
    ..aOS(16, _omitFieldNames ? '' : 'createdAt')
    ..aOS(17, _omitFieldNames ? '' : 'updatedAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InsurancePaymentRecord clone() =>
      InsurancePaymentRecord()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InsurancePaymentRecord copyWith(
          void Function(InsurancePaymentRecord) updates) =>
      super.copyWith((message) => updates(message as InsurancePaymentRecord))
          as InsurancePaymentRecord;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InsurancePaymentRecord create() => InsurancePaymentRecord._();
  @$core.override
  InsurancePaymentRecord createEmptyInstance() => create();
  static $pb.PbList<InsurancePaymentRecord> createRepeated() =>
      $pb.PbList<InsurancePaymentRecord>();
  @$core.pragma('dart2js:noInline')
  static InsurancePaymentRecord getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InsurancePaymentRecord>(create);
  static InsurancePaymentRecord? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get policyId => $_getSZ(2);
  @$pb.TagNumber(3)
  set policyId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPolicyId() => $_has(2);
  @$pb.TagNumber(3)
  void clearPolicyId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get accountId => $_getSZ(3);
  @$pb.TagNumber(4)
  set accountId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAccountId() => $_has(3);
  @$pb.TagNumber(4)
  void clearAccountId() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get purchaseId => $_getSZ(4);
  @$pb.TagNumber(5)
  set purchaseId($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasPurchaseId() => $_has(4);
  @$pb.TagNumber(5)
  void clearPurchaseId() => $_clearField(5);

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
  $core.String get paymentMethod => $_getSZ(7);
  @$pb.TagNumber(8)
  set paymentMethod($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasPaymentMethod() => $_has(7);
  @$pb.TagNumber(8)
  void clearPaymentMethod() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get status => $_getSZ(8);
  @$pb.TagNumber(9)
  set status($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasStatus() => $_has(8);
  @$pb.TagNumber(9)
  void clearStatus() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get transactionReference => $_getSZ(9);
  @$pb.TagNumber(10)
  set transactionReference($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasTransactionReference() => $_has(9);
  @$pb.TagNumber(10)
  void clearTransactionReference() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get idempotencyKey => $_getSZ(10);
  @$pb.TagNumber(11)
  set idempotencyKey($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasIdempotencyKey() => $_has(10);
  @$pb.TagNumber(11)
  void clearIdempotencyKey() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get narration => $_getSZ(11);
  @$pb.TagNumber(12)
  set narration($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasNarration() => $_has(11);
  @$pb.TagNumber(12)
  void clearNarration() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.String get failureReason => $_getSZ(12);
  @$pb.TagNumber(13)
  set failureReason($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasFailureReason() => $_has(12);
  @$pb.TagNumber(13)
  void clearFailureReason() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.String get receiptNumber => $_getSZ(13);
  @$pb.TagNumber(14)
  set receiptNumber($core.String value) => $_setString(13, value);
  @$pb.TagNumber(14)
  $core.bool hasReceiptNumber() => $_has(13);
  @$pb.TagNumber(14)
  void clearReceiptNumber() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.String get processedAt => $_getSZ(14);
  @$pb.TagNumber(15)
  set processedAt($core.String value) => $_setString(14, value);
  @$pb.TagNumber(15)
  $core.bool hasProcessedAt() => $_has(14);
  @$pb.TagNumber(15)
  void clearProcessedAt() => $_clearField(15);

  @$pb.TagNumber(16)
  $core.String get createdAt => $_getSZ(15);
  @$pb.TagNumber(16)
  set createdAt($core.String value) => $_setString(15, value);
  @$pb.TagNumber(16)
  $core.bool hasCreatedAt() => $_has(15);
  @$pb.TagNumber(16)
  void clearCreatedAt() => $_clearField(16);

  @$pb.TagNumber(17)
  $core.String get updatedAt => $_getSZ(16);
  @$pb.TagNumber(17)
  set updatedAt($core.String value) => $_setString(16, value);
  @$pb.TagNumber(17)
  $core.bool hasUpdatedAt() => $_has(16);
  @$pb.TagNumber(17)
  void clearUpdatedAt() => $_clearField(17);
}

/// Insurance claim record (detailed)
class InsuranceClaimRecord extends $pb.GeneratedMessage {
  factory InsuranceClaimRecord({
    $core.String? id,
    $core.String? userId,
    $core.String? policyId,
    $core.String? claimNumber,
    $core.String? claimType,
    $fixnum.Int64? claimAmount,
    $fixnum.Int64? approvedAmount,
    $core.String? currency,
    $core.String? status,
    $core.String? title,
    $core.String? description,
    $core.String? incidentDate,
    $core.String? incidentLocation,
    $core.Iterable<$core.String>? documents,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? additionalInfo,
    $core.String? rejectionReason,
    $core.String? settlementDate,
    $core.String? settlementDetails,
    $core.String? providerClaimId,
    $core.String? createdAt,
    $core.String? updatedAt,
    $core.Iterable<$core.String>? attachments,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (userId != null) result.userId = userId;
    if (policyId != null) result.policyId = policyId;
    if (claimNumber != null) result.claimNumber = claimNumber;
    if (claimType != null) result.claimType = claimType;
    if (claimAmount != null) result.claimAmount = claimAmount;
    if (approvedAmount != null) result.approvedAmount = approvedAmount;
    if (currency != null) result.currency = currency;
    if (status != null) result.status = status;
    if (title != null) result.title = title;
    if (description != null) result.description = description;
    if (incidentDate != null) result.incidentDate = incidentDate;
    if (incidentLocation != null) result.incidentLocation = incidentLocation;
    if (documents != null) result.documents.addAll(documents);
    if (additionalInfo != null)
      result.additionalInfo.addEntries(additionalInfo);
    if (rejectionReason != null) result.rejectionReason = rejectionReason;
    if (settlementDate != null) result.settlementDate = settlementDate;
    if (settlementDetails != null) result.settlementDetails = settlementDetails;
    if (providerClaimId != null) result.providerClaimId = providerClaimId;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    if (attachments != null) result.attachments.addAll(attachments);
    return result;
  }

  InsuranceClaimRecord._();

  factory InsuranceClaimRecord.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InsuranceClaimRecord.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InsuranceClaimRecord',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'policyId')
    ..aOS(4, _omitFieldNames ? '' : 'claimNumber')
    ..aOS(5, _omitFieldNames ? '' : 'claimType')
    ..aInt64(6, _omitFieldNames ? '' : 'claimAmount')
    ..aInt64(7, _omitFieldNames ? '' : 'approvedAmount')
    ..aOS(8, _omitFieldNames ? '' : 'currency')
    ..aOS(9, _omitFieldNames ? '' : 'status')
    ..aOS(10, _omitFieldNames ? '' : 'title')
    ..aOS(11, _omitFieldNames ? '' : 'description')
    ..aOS(12, _omitFieldNames ? '' : 'incidentDate')
    ..aOS(13, _omitFieldNames ? '' : 'incidentLocation')
    ..pPS(14, _omitFieldNames ? '' : 'documents')
    ..m<$core.String, $core.String>(15, _omitFieldNames ? '' : 'additionalInfo',
        entryClassName: 'InsuranceClaimRecord.AdditionalInfoEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('financialproducts'))
    ..aOS(16, _omitFieldNames ? '' : 'rejectionReason')
    ..aOS(17, _omitFieldNames ? '' : 'settlementDate')
    ..aOS(18, _omitFieldNames ? '' : 'settlementDetails')
    ..aOS(19, _omitFieldNames ? '' : 'providerClaimId')
    ..aOS(20, _omitFieldNames ? '' : 'createdAt')
    ..aOS(21, _omitFieldNames ? '' : 'updatedAt')
    ..pPS(22, _omitFieldNames ? '' : 'attachments')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InsuranceClaimRecord clone() =>
      InsuranceClaimRecord()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InsuranceClaimRecord copyWith(void Function(InsuranceClaimRecord) updates) =>
      super.copyWith((message) => updates(message as InsuranceClaimRecord))
          as InsuranceClaimRecord;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InsuranceClaimRecord create() => InsuranceClaimRecord._();
  @$core.override
  InsuranceClaimRecord createEmptyInstance() => create();
  static $pb.PbList<InsuranceClaimRecord> createRepeated() =>
      $pb.PbList<InsuranceClaimRecord>();
  @$core.pragma('dart2js:noInline')
  static InsuranceClaimRecord getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InsuranceClaimRecord>(create);
  static InsuranceClaimRecord? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get policyId => $_getSZ(2);
  @$pb.TagNumber(3)
  set policyId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPolicyId() => $_has(2);
  @$pb.TagNumber(3)
  void clearPolicyId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get claimNumber => $_getSZ(3);
  @$pb.TagNumber(4)
  set claimNumber($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasClaimNumber() => $_has(3);
  @$pb.TagNumber(4)
  void clearClaimNumber() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get claimType => $_getSZ(4);
  @$pb.TagNumber(5)
  set claimType($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasClaimType() => $_has(4);
  @$pb.TagNumber(5)
  void clearClaimType() => $_clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get claimAmount => $_getI64(5);
  @$pb.TagNumber(6)
  set claimAmount($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasClaimAmount() => $_has(5);
  @$pb.TagNumber(6)
  void clearClaimAmount() => $_clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get approvedAmount => $_getI64(6);
  @$pb.TagNumber(7)
  set approvedAmount($fixnum.Int64 value) => $_setInt64(6, value);
  @$pb.TagNumber(7)
  $core.bool hasApprovedAmount() => $_has(6);
  @$pb.TagNumber(7)
  void clearApprovedAmount() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get currency => $_getSZ(7);
  @$pb.TagNumber(8)
  set currency($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasCurrency() => $_has(7);
  @$pb.TagNumber(8)
  void clearCurrency() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get status => $_getSZ(8);
  @$pb.TagNumber(9)
  set status($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasStatus() => $_has(8);
  @$pb.TagNumber(9)
  void clearStatus() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get title => $_getSZ(9);
  @$pb.TagNumber(10)
  set title($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasTitle() => $_has(9);
  @$pb.TagNumber(10)
  void clearTitle() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get description => $_getSZ(10);
  @$pb.TagNumber(11)
  set description($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasDescription() => $_has(10);
  @$pb.TagNumber(11)
  void clearDescription() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get incidentDate => $_getSZ(11);
  @$pb.TagNumber(12)
  set incidentDate($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasIncidentDate() => $_has(11);
  @$pb.TagNumber(12)
  void clearIncidentDate() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.String get incidentLocation => $_getSZ(12);
  @$pb.TagNumber(13)
  set incidentLocation($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasIncidentLocation() => $_has(12);
  @$pb.TagNumber(13)
  void clearIncidentLocation() => $_clearField(13);

  @$pb.TagNumber(14)
  $pb.PbList<$core.String> get documents => $_getList(13);

  @$pb.TagNumber(15)
  $pb.PbMap<$core.String, $core.String> get additionalInfo => $_getMap(14);

  @$pb.TagNumber(16)
  $core.String get rejectionReason => $_getSZ(15);
  @$pb.TagNumber(16)
  set rejectionReason($core.String value) => $_setString(15, value);
  @$pb.TagNumber(16)
  $core.bool hasRejectionReason() => $_has(15);
  @$pb.TagNumber(16)
  void clearRejectionReason() => $_clearField(16);

  @$pb.TagNumber(17)
  $core.String get settlementDate => $_getSZ(16);
  @$pb.TagNumber(17)
  set settlementDate($core.String value) => $_setString(16, value);
  @$pb.TagNumber(17)
  $core.bool hasSettlementDate() => $_has(16);
  @$pb.TagNumber(17)
  void clearSettlementDate() => $_clearField(17);

  @$pb.TagNumber(18)
  $core.String get settlementDetails => $_getSZ(17);
  @$pb.TagNumber(18)
  set settlementDetails($core.String value) => $_setString(17, value);
  @$pb.TagNumber(18)
  $core.bool hasSettlementDetails() => $_has(17);
  @$pb.TagNumber(18)
  void clearSettlementDetails() => $_clearField(18);

  @$pb.TagNumber(19)
  $core.String get providerClaimId => $_getSZ(18);
  @$pb.TagNumber(19)
  set providerClaimId($core.String value) => $_setString(18, value);
  @$pb.TagNumber(19)
  $core.bool hasProviderClaimId() => $_has(18);
  @$pb.TagNumber(19)
  void clearProviderClaimId() => $_clearField(19);

  @$pb.TagNumber(20)
  $core.String get createdAt => $_getSZ(19);
  @$pb.TagNumber(20)
  set createdAt($core.String value) => $_setString(19, value);
  @$pb.TagNumber(20)
  $core.bool hasCreatedAt() => $_has(19);
  @$pb.TagNumber(20)
  void clearCreatedAt() => $_clearField(20);

  @$pb.TagNumber(21)
  $core.String get updatedAt => $_getSZ(20);
  @$pb.TagNumber(21)
  set updatedAt($core.String value) => $_setString(20, value);
  @$pb.TagNumber(21)
  $core.bool hasUpdatedAt() => $_has(20);
  @$pb.TagNumber(21)
  void clearUpdatedAt() => $_clearField(21);

  @$pb.TagNumber(22)
  $pb.PbList<$core.String> get attachments => $_getList(21);
}

/// Get payments by policy
class GetInsurancePaymentsRequest extends $pb.GeneratedMessage {
  factory GetInsurancePaymentsRequest({
    $core.String? policyId,
    $core.int? limit,
    $core.int? offset,
  }) {
    final result = create();
    if (policyId != null) result.policyId = policyId;
    if (limit != null) result.limit = limit;
    if (offset != null) result.offset = offset;
    return result;
  }

  GetInsurancePaymentsRequest._();

  factory GetInsurancePaymentsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetInsurancePaymentsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetInsurancePaymentsRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'policyId')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsurancePaymentsRequest clone() =>
      GetInsurancePaymentsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsurancePaymentsRequest copyWith(
          void Function(GetInsurancePaymentsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetInsurancePaymentsRequest))
          as GetInsurancePaymentsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInsurancePaymentsRequest create() =>
      GetInsurancePaymentsRequest._();
  @$core.override
  GetInsurancePaymentsRequest createEmptyInstance() => create();
  static $pb.PbList<GetInsurancePaymentsRequest> createRepeated() =>
      $pb.PbList<GetInsurancePaymentsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInsurancePaymentsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetInsurancePaymentsRequest>(create);
  static GetInsurancePaymentsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get policyId => $_getSZ(0);
  @$pb.TagNumber(1)
  set policyId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPolicyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPolicyId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get limit => $_getIZ(1);
  @$pb.TagNumber(2)
  set limit($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearLimit() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get offset => $_getIZ(2);
  @$pb.TagNumber(3)
  set offset($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasOffset() => $_has(2);
  @$pb.TagNumber(3)
  void clearOffset() => $_clearField(3);
}

class GetInsurancePaymentsResponse extends $pb.GeneratedMessage {
  factory GetInsurancePaymentsResponse({
    $core.Iterable<InsurancePaymentRecord>? payments,
    $core.int? total,
  }) {
    final result = create();
    if (payments != null) result.payments.addAll(payments);
    if (total != null) result.total = total;
    return result;
  }

  GetInsurancePaymentsResponse._();

  factory GetInsurancePaymentsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetInsurancePaymentsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetInsurancePaymentsResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..pc<InsurancePaymentRecord>(
        1, _omitFieldNames ? '' : 'payments', $pb.PbFieldType.PM,
        subBuilder: InsurancePaymentRecord.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsurancePaymentsResponse clone() =>
      GetInsurancePaymentsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsurancePaymentsResponse copyWith(
          void Function(GetInsurancePaymentsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetInsurancePaymentsResponse))
          as GetInsurancePaymentsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInsurancePaymentsResponse create() =>
      GetInsurancePaymentsResponse._();
  @$core.override
  GetInsurancePaymentsResponse createEmptyInstance() => create();
  static $pb.PbList<GetInsurancePaymentsResponse> createRepeated() =>
      $pb.PbList<GetInsurancePaymentsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInsurancePaymentsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetInsurancePaymentsResponse>(create);
  static GetInsurancePaymentsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<InsurancePaymentRecord> get payments => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);
}

/// Get all user payments
class GetUserInsurancePaymentsRequest extends $pb.GeneratedMessage {
  factory GetUserInsurancePaymentsRequest({
    $core.String? status,
    $core.int? limit,
    $core.int? offset,
  }) {
    final result = create();
    if (status != null) result.status = status;
    if (limit != null) result.limit = limit;
    if (offset != null) result.offset = offset;
    return result;
  }

  GetUserInsurancePaymentsRequest._();

  factory GetUserInsurancePaymentsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetUserInsurancePaymentsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUserInsurancePaymentsRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'status')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserInsurancePaymentsRequest clone() =>
      GetUserInsurancePaymentsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserInsurancePaymentsRequest copyWith(
          void Function(GetUserInsurancePaymentsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetUserInsurancePaymentsRequest))
          as GetUserInsurancePaymentsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserInsurancePaymentsRequest create() =>
      GetUserInsurancePaymentsRequest._();
  @$core.override
  GetUserInsurancePaymentsRequest createEmptyInstance() => create();
  static $pb.PbList<GetUserInsurancePaymentsRequest> createRepeated() =>
      $pb.PbList<GetUserInsurancePaymentsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetUserInsurancePaymentsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetUserInsurancePaymentsRequest>(
          create);
  static GetUserInsurancePaymentsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get status => $_getSZ(0);
  @$pb.TagNumber(1)
  set status($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get limit => $_getIZ(1);
  @$pb.TagNumber(2)
  set limit($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearLimit() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get offset => $_getIZ(2);
  @$pb.TagNumber(3)
  set offset($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasOffset() => $_has(2);
  @$pb.TagNumber(3)
  void clearOffset() => $_clearField(3);
}

class GetUserInsurancePaymentsResponse extends $pb.GeneratedMessage {
  factory GetUserInsurancePaymentsResponse({
    $core.Iterable<InsurancePaymentRecord>? payments,
    $core.int? total,
  }) {
    final result = create();
    if (payments != null) result.payments.addAll(payments);
    if (total != null) result.total = total;
    return result;
  }

  GetUserInsurancePaymentsResponse._();

  factory GetUserInsurancePaymentsResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetUserInsurancePaymentsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUserInsurancePaymentsResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..pc<InsurancePaymentRecord>(
        1, _omitFieldNames ? '' : 'payments', $pb.PbFieldType.PM,
        subBuilder: InsurancePaymentRecord.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserInsurancePaymentsResponse clone() =>
      GetUserInsurancePaymentsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserInsurancePaymentsResponse copyWith(
          void Function(GetUserInsurancePaymentsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetUserInsurancePaymentsResponse))
          as GetUserInsurancePaymentsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserInsurancePaymentsResponse create() =>
      GetUserInsurancePaymentsResponse._();
  @$core.override
  GetUserInsurancePaymentsResponse createEmptyInstance() => create();
  static $pb.PbList<GetUserInsurancePaymentsResponse> createRepeated() =>
      $pb.PbList<GetUserInsurancePaymentsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetUserInsurancePaymentsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetUserInsurancePaymentsResponse>(
          create);
  static GetUserInsurancePaymentsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<InsurancePaymentRecord> get payments => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);
}

/// Create payment
class CreateInsurancePaymentRequest extends $pb.GeneratedMessage {
  factory CreateInsurancePaymentRequest({
    $core.String? policyId,
    $core.String? accountId,
    $fixnum.Int64? amount,
    $core.String? currency,
    $core.String? paymentMethod,
    $core.String? narration,
    $core.String? idempotencyKey,
  }) {
    final result = create();
    if (policyId != null) result.policyId = policyId;
    if (accountId != null) result.accountId = accountId;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    if (paymentMethod != null) result.paymentMethod = paymentMethod;
    if (narration != null) result.narration = narration;
    if (idempotencyKey != null) result.idempotencyKey = idempotencyKey;
    return result;
  }

  CreateInsurancePaymentRequest._();

  factory CreateInsurancePaymentRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateInsurancePaymentRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateInsurancePaymentRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'policyId')
    ..aOS(2, _omitFieldNames ? '' : 'accountId')
    ..aInt64(3, _omitFieldNames ? '' : 'amount')
    ..aOS(4, _omitFieldNames ? '' : 'currency')
    ..aOS(5, _omitFieldNames ? '' : 'paymentMethod')
    ..aOS(6, _omitFieldNames ? '' : 'narration')
    ..aOS(7, _omitFieldNames ? '' : 'idempotencyKey')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateInsurancePaymentRequest clone() =>
      CreateInsurancePaymentRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateInsurancePaymentRequest copyWith(
          void Function(CreateInsurancePaymentRequest) updates) =>
      super.copyWith(
              (message) => updates(message as CreateInsurancePaymentRequest))
          as CreateInsurancePaymentRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateInsurancePaymentRequest create() =>
      CreateInsurancePaymentRequest._();
  @$core.override
  CreateInsurancePaymentRequest createEmptyInstance() => create();
  static $pb.PbList<CreateInsurancePaymentRequest> createRepeated() =>
      $pb.PbList<CreateInsurancePaymentRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateInsurancePaymentRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateInsurancePaymentRequest>(create);
  static CreateInsurancePaymentRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get policyId => $_getSZ(0);
  @$pb.TagNumber(1)
  set policyId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPolicyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPolicyId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get accountId => $_getSZ(1);
  @$pb.TagNumber(2)
  set accountId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAccountId() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccountId() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get amount => $_getI64(2);
  @$pb.TagNumber(3)
  set amount($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get currency => $_getSZ(3);
  @$pb.TagNumber(4)
  set currency($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCurrency() => $_has(3);
  @$pb.TagNumber(4)
  void clearCurrency() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get paymentMethod => $_getSZ(4);
  @$pb.TagNumber(5)
  set paymentMethod($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasPaymentMethod() => $_has(4);
  @$pb.TagNumber(5)
  void clearPaymentMethod() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get narration => $_getSZ(5);
  @$pb.TagNumber(6)
  set narration($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasNarration() => $_has(5);
  @$pb.TagNumber(6)
  void clearNarration() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get idempotencyKey => $_getSZ(6);
  @$pb.TagNumber(7)
  set idempotencyKey($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasIdempotencyKey() => $_has(6);
  @$pb.TagNumber(7)
  void clearIdempotencyKey() => $_clearField(7);
}

class CreateInsurancePaymentResponse extends $pb.GeneratedMessage {
  factory CreateInsurancePaymentResponse({
    InsurancePaymentRecord? payment,
    $core.String? message,
  }) {
    final result = create();
    if (payment != null) result.payment = payment;
    if (message != null) result.message = message;
    return result;
  }

  CreateInsurancePaymentResponse._();

  factory CreateInsurancePaymentResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateInsurancePaymentResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateInsurancePaymentResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOM<InsurancePaymentRecord>(1, _omitFieldNames ? '' : 'payment',
        subBuilder: InsurancePaymentRecord.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateInsurancePaymentResponse clone() =>
      CreateInsurancePaymentResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateInsurancePaymentResponse copyWith(
          void Function(CreateInsurancePaymentResponse) updates) =>
      super.copyWith(
              (message) => updates(message as CreateInsurancePaymentResponse))
          as CreateInsurancePaymentResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateInsurancePaymentResponse create() =>
      CreateInsurancePaymentResponse._();
  @$core.override
  CreateInsurancePaymentResponse createEmptyInstance() => create();
  static $pb.PbList<CreateInsurancePaymentResponse> createRepeated() =>
      $pb.PbList<CreateInsurancePaymentResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateInsurancePaymentResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateInsurancePaymentResponse>(create);
  static CreateInsurancePaymentResponse? _defaultInstance;

  @$pb.TagNumber(1)
  InsurancePaymentRecord get payment => $_getN(0);
  @$pb.TagNumber(1)
  set payment(InsurancePaymentRecord value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasPayment() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayment() => $_clearField(1);
  @$pb.TagNumber(1)
  InsurancePaymentRecord ensurePayment() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);
}

/// Process payment
class ProcessInsurancePaymentRequest extends $pb.GeneratedMessage {
  factory ProcessInsurancePaymentRequest({
    $core.String? paymentId,
    $core.String? transactionPinToken,
  }) {
    final result = create();
    if (paymentId != null) result.paymentId = paymentId;
    if (transactionPinToken != null)
      result.transactionPinToken = transactionPinToken;
    return result;
  }

  ProcessInsurancePaymentRequest._();

  factory ProcessInsurancePaymentRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ProcessInsurancePaymentRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ProcessInsurancePaymentRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'paymentId')
    ..aOS(2, _omitFieldNames ? '' : 'transactionPinToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProcessInsurancePaymentRequest clone() =>
      ProcessInsurancePaymentRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProcessInsurancePaymentRequest copyWith(
          void Function(ProcessInsurancePaymentRequest) updates) =>
      super.copyWith(
              (message) => updates(message as ProcessInsurancePaymentRequest))
          as ProcessInsurancePaymentRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ProcessInsurancePaymentRequest create() =>
      ProcessInsurancePaymentRequest._();
  @$core.override
  ProcessInsurancePaymentRequest createEmptyInstance() => create();
  static $pb.PbList<ProcessInsurancePaymentRequest> createRepeated() =>
      $pb.PbList<ProcessInsurancePaymentRequest>();
  @$core.pragma('dart2js:noInline')
  static ProcessInsurancePaymentRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ProcessInsurancePaymentRequest>(create);
  static ProcessInsurancePaymentRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get paymentId => $_getSZ(0);
  @$pb.TagNumber(1)
  set paymentId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPaymentId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPaymentId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get transactionPinToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set transactionPinToken($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTransactionPinToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearTransactionPinToken() => $_clearField(2);
}

class ProcessInsurancePaymentResponse extends $pb.GeneratedMessage {
  factory ProcessInsurancePaymentResponse({
    InsurancePaymentRecord? payment,
    $core.String? message,
  }) {
    final result = create();
    if (payment != null) result.payment = payment;
    if (message != null) result.message = message;
    return result;
  }

  ProcessInsurancePaymentResponse._();

  factory ProcessInsurancePaymentResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ProcessInsurancePaymentResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ProcessInsurancePaymentResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOM<InsurancePaymentRecord>(1, _omitFieldNames ? '' : 'payment',
        subBuilder: InsurancePaymentRecord.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProcessInsurancePaymentResponse clone() =>
      ProcessInsurancePaymentResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProcessInsurancePaymentResponse copyWith(
          void Function(ProcessInsurancePaymentResponse) updates) =>
      super.copyWith(
              (message) => updates(message as ProcessInsurancePaymentResponse))
          as ProcessInsurancePaymentResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ProcessInsurancePaymentResponse create() =>
      ProcessInsurancePaymentResponse._();
  @$core.override
  ProcessInsurancePaymentResponse createEmptyInstance() => create();
  static $pb.PbList<ProcessInsurancePaymentResponse> createRepeated() =>
      $pb.PbList<ProcessInsurancePaymentResponse>();
  @$core.pragma('dart2js:noInline')
  static ProcessInsurancePaymentResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ProcessInsurancePaymentResponse>(
          create);
  static ProcessInsurancePaymentResponse? _defaultInstance;

  @$pb.TagNumber(1)
  InsurancePaymentRecord get payment => $_getN(0);
  @$pb.TagNumber(1)
  set payment(InsurancePaymentRecord value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasPayment() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayment() => $_clearField(1);
  @$pb.TagNumber(1)
  InsurancePaymentRecord ensurePayment() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);
}

/// Get payment by ID
class GetInsurancePaymentByIdRequest extends $pb.GeneratedMessage {
  factory GetInsurancePaymentByIdRequest({
    $core.String? paymentId,
  }) {
    final result = create();
    if (paymentId != null) result.paymentId = paymentId;
    return result;
  }

  GetInsurancePaymentByIdRequest._();

  factory GetInsurancePaymentByIdRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetInsurancePaymentByIdRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetInsurancePaymentByIdRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'paymentId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsurancePaymentByIdRequest clone() =>
      GetInsurancePaymentByIdRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsurancePaymentByIdRequest copyWith(
          void Function(GetInsurancePaymentByIdRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetInsurancePaymentByIdRequest))
          as GetInsurancePaymentByIdRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInsurancePaymentByIdRequest create() =>
      GetInsurancePaymentByIdRequest._();
  @$core.override
  GetInsurancePaymentByIdRequest createEmptyInstance() => create();
  static $pb.PbList<GetInsurancePaymentByIdRequest> createRepeated() =>
      $pb.PbList<GetInsurancePaymentByIdRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInsurancePaymentByIdRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetInsurancePaymentByIdRequest>(create);
  static GetInsurancePaymentByIdRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get paymentId => $_getSZ(0);
  @$pb.TagNumber(1)
  set paymentId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPaymentId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPaymentId() => $_clearField(1);
}

class GetInsurancePaymentByIdResponse extends $pb.GeneratedMessage {
  factory GetInsurancePaymentByIdResponse({
    InsurancePaymentRecord? payment,
  }) {
    final result = create();
    if (payment != null) result.payment = payment;
    return result;
  }

  GetInsurancePaymentByIdResponse._();

  factory GetInsurancePaymentByIdResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetInsurancePaymentByIdResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetInsurancePaymentByIdResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOM<InsurancePaymentRecord>(1, _omitFieldNames ? '' : 'payment',
        subBuilder: InsurancePaymentRecord.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsurancePaymentByIdResponse clone() =>
      GetInsurancePaymentByIdResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsurancePaymentByIdResponse copyWith(
          void Function(GetInsurancePaymentByIdResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetInsurancePaymentByIdResponse))
          as GetInsurancePaymentByIdResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInsurancePaymentByIdResponse create() =>
      GetInsurancePaymentByIdResponse._();
  @$core.override
  GetInsurancePaymentByIdResponse createEmptyInstance() => create();
  static $pb.PbList<GetInsurancePaymentByIdResponse> createRepeated() =>
      $pb.PbList<GetInsurancePaymentByIdResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInsurancePaymentByIdResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetInsurancePaymentByIdResponse>(
          create);
  static GetInsurancePaymentByIdResponse? _defaultInstance;

  @$pb.TagNumber(1)
  InsurancePaymentRecord get payment => $_getN(0);
  @$pb.TagNumber(1)
  set payment(InsurancePaymentRecord value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasPayment() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayment() => $_clearField(1);
  @$pb.TagNumber(1)
  InsurancePaymentRecord ensurePayment() => $_ensure(0);
}

/// Get overdue payments
class GetOverdueInsurancePaymentsRequest extends $pb.GeneratedMessage {
  factory GetOverdueInsurancePaymentsRequest() => create();

  GetOverdueInsurancePaymentsRequest._();

  factory GetOverdueInsurancePaymentsRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetOverdueInsurancePaymentsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetOverdueInsurancePaymentsRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetOverdueInsurancePaymentsRequest clone() =>
      GetOverdueInsurancePaymentsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetOverdueInsurancePaymentsRequest copyWith(
          void Function(GetOverdueInsurancePaymentsRequest) updates) =>
      super.copyWith((message) =>
              updates(message as GetOverdueInsurancePaymentsRequest))
          as GetOverdueInsurancePaymentsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetOverdueInsurancePaymentsRequest create() =>
      GetOverdueInsurancePaymentsRequest._();
  @$core.override
  GetOverdueInsurancePaymentsRequest createEmptyInstance() => create();
  static $pb.PbList<GetOverdueInsurancePaymentsRequest> createRepeated() =>
      $pb.PbList<GetOverdueInsurancePaymentsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetOverdueInsurancePaymentsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetOverdueInsurancePaymentsRequest>(
          create);
  static GetOverdueInsurancePaymentsRequest? _defaultInstance;
}

class GetOverdueInsurancePaymentsResponse extends $pb.GeneratedMessage {
  factory GetOverdueInsurancePaymentsResponse({
    $core.Iterable<InsurancePaymentRecord>? payments,
  }) {
    final result = create();
    if (payments != null) result.payments.addAll(payments);
    return result;
  }

  GetOverdueInsurancePaymentsResponse._();

  factory GetOverdueInsurancePaymentsResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetOverdueInsurancePaymentsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetOverdueInsurancePaymentsResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..pc<InsurancePaymentRecord>(
        1, _omitFieldNames ? '' : 'payments', $pb.PbFieldType.PM,
        subBuilder: InsurancePaymentRecord.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetOverdueInsurancePaymentsResponse clone() =>
      GetOverdueInsurancePaymentsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetOverdueInsurancePaymentsResponse copyWith(
          void Function(GetOverdueInsurancePaymentsResponse) updates) =>
      super.copyWith((message) =>
              updates(message as GetOverdueInsurancePaymentsResponse))
          as GetOverdueInsurancePaymentsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetOverdueInsurancePaymentsResponse create() =>
      GetOverdueInsurancePaymentsResponse._();
  @$core.override
  GetOverdueInsurancePaymentsResponse createEmptyInstance() => create();
  static $pb.PbList<GetOverdueInsurancePaymentsResponse> createRepeated() =>
      $pb.PbList<GetOverdueInsurancePaymentsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetOverdueInsurancePaymentsResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          GetOverdueInsurancePaymentsResponse>(create);
  static GetOverdueInsurancePaymentsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<InsurancePaymentRecord> get payments => $_getList(0);
}

/// Get claims by policy
class GetInsuranceClaimsRequest extends $pb.GeneratedMessage {
  factory GetInsuranceClaimsRequest({
    $core.String? policyId,
    $core.int? limit,
    $core.int? offset,
  }) {
    final result = create();
    if (policyId != null) result.policyId = policyId;
    if (limit != null) result.limit = limit;
    if (offset != null) result.offset = offset;
    return result;
  }

  GetInsuranceClaimsRequest._();

  factory GetInsuranceClaimsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetInsuranceClaimsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetInsuranceClaimsRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'policyId')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsuranceClaimsRequest clone() =>
      GetInsuranceClaimsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsuranceClaimsRequest copyWith(
          void Function(GetInsuranceClaimsRequest) updates) =>
      super.copyWith((message) => updates(message as GetInsuranceClaimsRequest))
          as GetInsuranceClaimsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInsuranceClaimsRequest create() => GetInsuranceClaimsRequest._();
  @$core.override
  GetInsuranceClaimsRequest createEmptyInstance() => create();
  static $pb.PbList<GetInsuranceClaimsRequest> createRepeated() =>
      $pb.PbList<GetInsuranceClaimsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInsuranceClaimsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetInsuranceClaimsRequest>(create);
  static GetInsuranceClaimsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get policyId => $_getSZ(0);
  @$pb.TagNumber(1)
  set policyId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPolicyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPolicyId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get limit => $_getIZ(1);
  @$pb.TagNumber(2)
  set limit($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearLimit() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get offset => $_getIZ(2);
  @$pb.TagNumber(3)
  set offset($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasOffset() => $_has(2);
  @$pb.TagNumber(3)
  void clearOffset() => $_clearField(3);
}

class GetInsuranceClaimsResponse extends $pb.GeneratedMessage {
  factory GetInsuranceClaimsResponse({
    $core.Iterable<InsuranceClaimRecord>? claims,
    $core.int? total,
  }) {
    final result = create();
    if (claims != null) result.claims.addAll(claims);
    if (total != null) result.total = total;
    return result;
  }

  GetInsuranceClaimsResponse._();

  factory GetInsuranceClaimsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetInsuranceClaimsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetInsuranceClaimsResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..pc<InsuranceClaimRecord>(
        1, _omitFieldNames ? '' : 'claims', $pb.PbFieldType.PM,
        subBuilder: InsuranceClaimRecord.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsuranceClaimsResponse clone() =>
      GetInsuranceClaimsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsuranceClaimsResponse copyWith(
          void Function(GetInsuranceClaimsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetInsuranceClaimsResponse))
          as GetInsuranceClaimsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInsuranceClaimsResponse create() => GetInsuranceClaimsResponse._();
  @$core.override
  GetInsuranceClaimsResponse createEmptyInstance() => create();
  static $pb.PbList<GetInsuranceClaimsResponse> createRepeated() =>
      $pb.PbList<GetInsuranceClaimsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInsuranceClaimsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetInsuranceClaimsResponse>(create);
  static GetInsuranceClaimsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<InsuranceClaimRecord> get claims => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);
}

/// Get all user claims
class GetUserInsuranceClaimsRequest extends $pb.GeneratedMessage {
  factory GetUserInsuranceClaimsRequest({
    $core.String? status,
    $core.int? limit,
    $core.int? offset,
  }) {
    final result = create();
    if (status != null) result.status = status;
    if (limit != null) result.limit = limit;
    if (offset != null) result.offset = offset;
    return result;
  }

  GetUserInsuranceClaimsRequest._();

  factory GetUserInsuranceClaimsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetUserInsuranceClaimsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUserInsuranceClaimsRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'status')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserInsuranceClaimsRequest clone() =>
      GetUserInsuranceClaimsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserInsuranceClaimsRequest copyWith(
          void Function(GetUserInsuranceClaimsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetUserInsuranceClaimsRequest))
          as GetUserInsuranceClaimsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserInsuranceClaimsRequest create() =>
      GetUserInsuranceClaimsRequest._();
  @$core.override
  GetUserInsuranceClaimsRequest createEmptyInstance() => create();
  static $pb.PbList<GetUserInsuranceClaimsRequest> createRepeated() =>
      $pb.PbList<GetUserInsuranceClaimsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetUserInsuranceClaimsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetUserInsuranceClaimsRequest>(create);
  static GetUserInsuranceClaimsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get status => $_getSZ(0);
  @$pb.TagNumber(1)
  set status($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get limit => $_getIZ(1);
  @$pb.TagNumber(2)
  set limit($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearLimit() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get offset => $_getIZ(2);
  @$pb.TagNumber(3)
  set offset($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasOffset() => $_has(2);
  @$pb.TagNumber(3)
  void clearOffset() => $_clearField(3);
}

class GetUserInsuranceClaimsResponse extends $pb.GeneratedMessage {
  factory GetUserInsuranceClaimsResponse({
    $core.Iterable<InsuranceClaimRecord>? claims,
    $core.int? total,
  }) {
    final result = create();
    if (claims != null) result.claims.addAll(claims);
    if (total != null) result.total = total;
    return result;
  }

  GetUserInsuranceClaimsResponse._();

  factory GetUserInsuranceClaimsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetUserInsuranceClaimsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUserInsuranceClaimsResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..pc<InsuranceClaimRecord>(
        1, _omitFieldNames ? '' : 'claims', $pb.PbFieldType.PM,
        subBuilder: InsuranceClaimRecord.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserInsuranceClaimsResponse clone() =>
      GetUserInsuranceClaimsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserInsuranceClaimsResponse copyWith(
          void Function(GetUserInsuranceClaimsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetUserInsuranceClaimsResponse))
          as GetUserInsuranceClaimsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserInsuranceClaimsResponse create() =>
      GetUserInsuranceClaimsResponse._();
  @$core.override
  GetUserInsuranceClaimsResponse createEmptyInstance() => create();
  static $pb.PbList<GetUserInsuranceClaimsResponse> createRepeated() =>
      $pb.PbList<GetUserInsuranceClaimsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetUserInsuranceClaimsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetUserInsuranceClaimsResponse>(create);
  static GetUserInsuranceClaimsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<InsuranceClaimRecord> get claims => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);
}

/// Update claim
class UpdateInsuranceClaimRequest extends $pb.GeneratedMessage {
  factory UpdateInsuranceClaimRequest({
    $core.String? claimId,
    $core.String? title,
    $core.String? description,
    $core.Iterable<$core.String>? documents,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? additionalInfo,
    $core.String? status,
    $core.Iterable<$core.String>? attachments,
  }) {
    final result = create();
    if (claimId != null) result.claimId = claimId;
    if (title != null) result.title = title;
    if (description != null) result.description = description;
    if (documents != null) result.documents.addAll(documents);
    if (additionalInfo != null)
      result.additionalInfo.addEntries(additionalInfo);
    if (status != null) result.status = status;
    if (attachments != null) result.attachments.addAll(attachments);
    return result;
  }

  UpdateInsuranceClaimRequest._();

  factory UpdateInsuranceClaimRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateInsuranceClaimRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateInsuranceClaimRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'claimId')
    ..aOS(2, _omitFieldNames ? '' : 'title')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..pPS(4, _omitFieldNames ? '' : 'documents')
    ..m<$core.String, $core.String>(5, _omitFieldNames ? '' : 'additionalInfo',
        entryClassName: 'UpdateInsuranceClaimRequest.AdditionalInfoEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('financialproducts'))
    ..aOS(6, _omitFieldNames ? '' : 'status')
    ..pPS(7, _omitFieldNames ? '' : 'attachments')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateInsuranceClaimRequest clone() =>
      UpdateInsuranceClaimRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateInsuranceClaimRequest copyWith(
          void Function(UpdateInsuranceClaimRequest) updates) =>
      super.copyWith(
              (message) => updates(message as UpdateInsuranceClaimRequest))
          as UpdateInsuranceClaimRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateInsuranceClaimRequest create() =>
      UpdateInsuranceClaimRequest._();
  @$core.override
  UpdateInsuranceClaimRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateInsuranceClaimRequest> createRepeated() =>
      $pb.PbList<UpdateInsuranceClaimRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateInsuranceClaimRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateInsuranceClaimRequest>(create);
  static UpdateInsuranceClaimRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get claimId => $_getSZ(0);
  @$pb.TagNumber(1)
  set claimId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasClaimId() => $_has(0);
  @$pb.TagNumber(1)
  void clearClaimId() => $_clearField(1);

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
  $pb.PbList<$core.String> get documents => $_getList(3);

  @$pb.TagNumber(5)
  $pb.PbMap<$core.String, $core.String> get additionalInfo => $_getMap(4);

  @$pb.TagNumber(6)
  $core.String get status => $_getSZ(5);
  @$pb.TagNumber(6)
  set status($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasStatus() => $_has(5);
  @$pb.TagNumber(6)
  void clearStatus() => $_clearField(6);

  @$pb.TagNumber(7)
  $pb.PbList<$core.String> get attachments => $_getList(6);
}

class UpdateInsuranceClaimResponse extends $pb.GeneratedMessage {
  factory UpdateInsuranceClaimResponse({
    InsuranceClaimRecord? claim,
    $core.String? message,
  }) {
    final result = create();
    if (claim != null) result.claim = claim;
    if (message != null) result.message = message;
    return result;
  }

  UpdateInsuranceClaimResponse._();

  factory UpdateInsuranceClaimResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateInsuranceClaimResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateInsuranceClaimResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOM<InsuranceClaimRecord>(1, _omitFieldNames ? '' : 'claim',
        subBuilder: InsuranceClaimRecord.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateInsuranceClaimResponse clone() =>
      UpdateInsuranceClaimResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateInsuranceClaimResponse copyWith(
          void Function(UpdateInsuranceClaimResponse) updates) =>
      super.copyWith(
              (message) => updates(message as UpdateInsuranceClaimResponse))
          as UpdateInsuranceClaimResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateInsuranceClaimResponse create() =>
      UpdateInsuranceClaimResponse._();
  @$core.override
  UpdateInsuranceClaimResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateInsuranceClaimResponse> createRepeated() =>
      $pb.PbList<UpdateInsuranceClaimResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateInsuranceClaimResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateInsuranceClaimResponse>(create);
  static UpdateInsuranceClaimResponse? _defaultInstance;

  @$pb.TagNumber(1)
  InsuranceClaimRecord get claim => $_getN(0);
  @$pb.TagNumber(1)
  set claim(InsuranceClaimRecord value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasClaim() => $_has(0);
  @$pb.TagNumber(1)
  void clearClaim() => $_clearField(1);
  @$pb.TagNumber(1)
  InsuranceClaimRecord ensureClaim() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);
}

/// Get claim by ID
class GetInsuranceClaimByIdRequest extends $pb.GeneratedMessage {
  factory GetInsuranceClaimByIdRequest({
    $core.String? claimId,
  }) {
    final result = create();
    if (claimId != null) result.claimId = claimId;
    return result;
  }

  GetInsuranceClaimByIdRequest._();

  factory GetInsuranceClaimByIdRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetInsuranceClaimByIdRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetInsuranceClaimByIdRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'claimId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsuranceClaimByIdRequest clone() =>
      GetInsuranceClaimByIdRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsuranceClaimByIdRequest copyWith(
          void Function(GetInsuranceClaimByIdRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetInsuranceClaimByIdRequest))
          as GetInsuranceClaimByIdRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInsuranceClaimByIdRequest create() =>
      GetInsuranceClaimByIdRequest._();
  @$core.override
  GetInsuranceClaimByIdRequest createEmptyInstance() => create();
  static $pb.PbList<GetInsuranceClaimByIdRequest> createRepeated() =>
      $pb.PbList<GetInsuranceClaimByIdRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInsuranceClaimByIdRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetInsuranceClaimByIdRequest>(create);
  static GetInsuranceClaimByIdRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get claimId => $_getSZ(0);
  @$pb.TagNumber(1)
  set claimId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasClaimId() => $_has(0);
  @$pb.TagNumber(1)
  void clearClaimId() => $_clearField(1);
}

class GetInsuranceClaimByIdResponse extends $pb.GeneratedMessage {
  factory GetInsuranceClaimByIdResponse({
    InsuranceClaimRecord? claim,
  }) {
    final result = create();
    if (claim != null) result.claim = claim;
    return result;
  }

  GetInsuranceClaimByIdResponse._();

  factory GetInsuranceClaimByIdResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetInsuranceClaimByIdResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetInsuranceClaimByIdResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOM<InsuranceClaimRecord>(1, _omitFieldNames ? '' : 'claim',
        subBuilder: InsuranceClaimRecord.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsuranceClaimByIdResponse clone() =>
      GetInsuranceClaimByIdResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsuranceClaimByIdResponse copyWith(
          void Function(GetInsuranceClaimByIdResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetInsuranceClaimByIdResponse))
          as GetInsuranceClaimByIdResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInsuranceClaimByIdResponse create() =>
      GetInsuranceClaimByIdResponse._();
  @$core.override
  GetInsuranceClaimByIdResponse createEmptyInstance() => create();
  static $pb.PbList<GetInsuranceClaimByIdResponse> createRepeated() =>
      $pb.PbList<GetInsuranceClaimByIdResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInsuranceClaimByIdResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetInsuranceClaimByIdResponse>(create);
  static GetInsuranceClaimByIdResponse? _defaultInstance;

  @$pb.TagNumber(1)
  InsuranceClaimRecord get claim => $_getN(0);
  @$pb.TagNumber(1)
  set claim(InsuranceClaimRecord value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasClaim() => $_has(0);
  @$pb.TagNumber(1)
  void clearClaim() => $_clearField(1);
  @$pb.TagNumber(1)
  InsuranceClaimRecord ensureClaim() => $_ensure(0);
}

/// Update insurance policy
class UpdateInsurancePolicyRequest extends $pb.GeneratedMessage {
  factory UpdateInsurancePolicyRequest({
    $core.String? policyId,
    $core.String? beneficiary,
    $core.String? paymentFrequency,
    $core.String? metadata,
  }) {
    final result = create();
    if (policyId != null) result.policyId = policyId;
    if (beneficiary != null) result.beneficiary = beneficiary;
    if (paymentFrequency != null) result.paymentFrequency = paymentFrequency;
    if (metadata != null) result.metadata = metadata;
    return result;
  }

  UpdateInsurancePolicyRequest._();

  factory UpdateInsurancePolicyRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateInsurancePolicyRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateInsurancePolicyRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'policyId')
    ..aOS(2, _omitFieldNames ? '' : 'beneficiary')
    ..aOS(3, _omitFieldNames ? '' : 'paymentFrequency')
    ..aOS(4, _omitFieldNames ? '' : 'metadata')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateInsurancePolicyRequest clone() =>
      UpdateInsurancePolicyRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateInsurancePolicyRequest copyWith(
          void Function(UpdateInsurancePolicyRequest) updates) =>
      super.copyWith(
              (message) => updates(message as UpdateInsurancePolicyRequest))
          as UpdateInsurancePolicyRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateInsurancePolicyRequest create() =>
      UpdateInsurancePolicyRequest._();
  @$core.override
  UpdateInsurancePolicyRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateInsurancePolicyRequest> createRepeated() =>
      $pb.PbList<UpdateInsurancePolicyRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateInsurancePolicyRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateInsurancePolicyRequest>(create);
  static UpdateInsurancePolicyRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get policyId => $_getSZ(0);
  @$pb.TagNumber(1)
  set policyId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPolicyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPolicyId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get beneficiary => $_getSZ(1);
  @$pb.TagNumber(2)
  set beneficiary($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasBeneficiary() => $_has(1);
  @$pb.TagNumber(2)
  void clearBeneficiary() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get paymentFrequency => $_getSZ(2);
  @$pb.TagNumber(3)
  set paymentFrequency($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPaymentFrequency() => $_has(2);
  @$pb.TagNumber(3)
  void clearPaymentFrequency() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get metadata => $_getSZ(3);
  @$pb.TagNumber(4)
  set metadata($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMetadata() => $_has(3);
  @$pb.TagNumber(4)
  void clearMetadata() => $_clearField(4);
}

class UpdateInsurancePolicyResponse extends $pb.GeneratedMessage {
  factory UpdateInsurancePolicyResponse({
    Insurance? insurance,
    $core.String? message,
  }) {
    final result = create();
    if (insurance != null) result.insurance = insurance;
    if (message != null) result.message = message;
    return result;
  }

  UpdateInsurancePolicyResponse._();

  factory UpdateInsurancePolicyResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateInsurancePolicyResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateInsurancePolicyResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOM<Insurance>(1, _omitFieldNames ? '' : 'insurance',
        subBuilder: Insurance.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateInsurancePolicyResponse clone() =>
      UpdateInsurancePolicyResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateInsurancePolicyResponse copyWith(
          void Function(UpdateInsurancePolicyResponse) updates) =>
      super.copyWith(
              (message) => updates(message as UpdateInsurancePolicyResponse))
          as UpdateInsurancePolicyResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateInsurancePolicyResponse create() =>
      UpdateInsurancePolicyResponse._();
  @$core.override
  UpdateInsurancePolicyResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateInsurancePolicyResponse> createRepeated() =>
      $pb.PbList<UpdateInsurancePolicyResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateInsurancePolicyResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateInsurancePolicyResponse>(create);
  static UpdateInsurancePolicyResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Insurance get insurance => $_getN(0);
  @$pb.TagNumber(1)
  set insurance(Insurance value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasInsurance() => $_has(0);
  @$pb.TagNumber(1)
  void clearInsurance() => $_clearField(1);
  @$pb.TagNumber(1)
  Insurance ensureInsurance() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);
}

/// Generate receipt
class GenerateInsuranceReceiptRequest extends $pb.GeneratedMessage {
  factory GenerateInsuranceReceiptRequest({
    $core.String? paymentId,
  }) {
    final result = create();
    if (paymentId != null) result.paymentId = paymentId;
    return result;
  }

  GenerateInsuranceReceiptRequest._();

  factory GenerateInsuranceReceiptRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GenerateInsuranceReceiptRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GenerateInsuranceReceiptRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'paymentId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GenerateInsuranceReceiptRequest clone() =>
      GenerateInsuranceReceiptRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GenerateInsuranceReceiptRequest copyWith(
          void Function(GenerateInsuranceReceiptRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GenerateInsuranceReceiptRequest))
          as GenerateInsuranceReceiptRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GenerateInsuranceReceiptRequest create() =>
      GenerateInsuranceReceiptRequest._();
  @$core.override
  GenerateInsuranceReceiptRequest createEmptyInstance() => create();
  static $pb.PbList<GenerateInsuranceReceiptRequest> createRepeated() =>
      $pb.PbList<GenerateInsuranceReceiptRequest>();
  @$core.pragma('dart2js:noInline')
  static GenerateInsuranceReceiptRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GenerateInsuranceReceiptRequest>(
          create);
  static GenerateInsuranceReceiptRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get paymentId => $_getSZ(0);
  @$pb.TagNumber(1)
  set paymentId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPaymentId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPaymentId() => $_clearField(1);
}

class GenerateInsuranceReceiptResponse extends $pb.GeneratedMessage {
  factory GenerateInsuranceReceiptResponse({
    $core.String? receiptId,
    $core.String? receiptNumber,
    InsurancePaymentRecord? payment,
    $core.String? policyNumber,
    $core.String? policyType,
    $core.String? message,
  }) {
    final result = create();
    if (receiptId != null) result.receiptId = receiptId;
    if (receiptNumber != null) result.receiptNumber = receiptNumber;
    if (payment != null) result.payment = payment;
    if (policyNumber != null) result.policyNumber = policyNumber;
    if (policyType != null) result.policyType = policyType;
    if (message != null) result.message = message;
    return result;
  }

  GenerateInsuranceReceiptResponse._();

  factory GenerateInsuranceReceiptResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GenerateInsuranceReceiptResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GenerateInsuranceReceiptResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'receiptId')
    ..aOS(2, _omitFieldNames ? '' : 'receiptNumber')
    ..aOM<InsurancePaymentRecord>(3, _omitFieldNames ? '' : 'payment',
        subBuilder: InsurancePaymentRecord.create)
    ..aOS(4, _omitFieldNames ? '' : 'policyNumber')
    ..aOS(5, _omitFieldNames ? '' : 'policyType')
    ..aOS(6, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GenerateInsuranceReceiptResponse clone() =>
      GenerateInsuranceReceiptResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GenerateInsuranceReceiptResponse copyWith(
          void Function(GenerateInsuranceReceiptResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GenerateInsuranceReceiptResponse))
          as GenerateInsuranceReceiptResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GenerateInsuranceReceiptResponse create() =>
      GenerateInsuranceReceiptResponse._();
  @$core.override
  GenerateInsuranceReceiptResponse createEmptyInstance() => create();
  static $pb.PbList<GenerateInsuranceReceiptResponse> createRepeated() =>
      $pb.PbList<GenerateInsuranceReceiptResponse>();
  @$core.pragma('dart2js:noInline')
  static GenerateInsuranceReceiptResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GenerateInsuranceReceiptResponse>(
          create);
  static GenerateInsuranceReceiptResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get receiptId => $_getSZ(0);
  @$pb.TagNumber(1)
  set receiptId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasReceiptId() => $_has(0);
  @$pb.TagNumber(1)
  void clearReceiptId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get receiptNumber => $_getSZ(1);
  @$pb.TagNumber(2)
  set receiptNumber($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasReceiptNumber() => $_has(1);
  @$pb.TagNumber(2)
  void clearReceiptNumber() => $_clearField(2);

  @$pb.TagNumber(3)
  InsurancePaymentRecord get payment => $_getN(2);
  @$pb.TagNumber(3)
  set payment(InsurancePaymentRecord value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasPayment() => $_has(2);
  @$pb.TagNumber(3)
  void clearPayment() => $_clearField(3);
  @$pb.TagNumber(3)
  InsurancePaymentRecord ensurePayment() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.String get policyNumber => $_getSZ(3);
  @$pb.TagNumber(4)
  set policyNumber($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPolicyNumber() => $_has(3);
  @$pb.TagNumber(4)
  void clearPolicyNumber() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get policyType => $_getSZ(4);
  @$pb.TagNumber(5)
  set policyType($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasPolicyType() => $_has(4);
  @$pb.TagNumber(5)
  void clearPolicyType() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get message => $_getSZ(5);
  @$pb.TagNumber(6)
  set message($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasMessage() => $_has(5);
  @$pb.TagNumber(6)
  void clearMessage() => $_clearField(6);
}

/// Get user receipts
class GetUserInsuranceReceiptsRequest extends $pb.GeneratedMessage {
  factory GetUserInsuranceReceiptsRequest({
    $core.int? limit,
    $core.int? offset,
  }) {
    final result = create();
    if (limit != null) result.limit = limit;
    if (offset != null) result.offset = offset;
    return result;
  }

  GetUserInsuranceReceiptsRequest._();

  factory GetUserInsuranceReceiptsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetUserInsuranceReceiptsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUserInsuranceReceiptsRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserInsuranceReceiptsRequest clone() =>
      GetUserInsuranceReceiptsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserInsuranceReceiptsRequest copyWith(
          void Function(GetUserInsuranceReceiptsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetUserInsuranceReceiptsRequest))
          as GetUserInsuranceReceiptsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserInsuranceReceiptsRequest create() =>
      GetUserInsuranceReceiptsRequest._();
  @$core.override
  GetUserInsuranceReceiptsRequest createEmptyInstance() => create();
  static $pb.PbList<GetUserInsuranceReceiptsRequest> createRepeated() =>
      $pb.PbList<GetUserInsuranceReceiptsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetUserInsuranceReceiptsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetUserInsuranceReceiptsRequest>(
          create);
  static GetUserInsuranceReceiptsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get limit => $_getIZ(0);
  @$pb.TagNumber(1)
  set limit($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasLimit() => $_has(0);
  @$pb.TagNumber(1)
  void clearLimit() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get offset => $_getIZ(1);
  @$pb.TagNumber(2)
  set offset($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasOffset() => $_has(1);
  @$pb.TagNumber(2)
  void clearOffset() => $_clearField(2);
}

class GetUserInsuranceReceiptsResponse extends $pb.GeneratedMessage {
  factory GetUserInsuranceReceiptsResponse({
    $core.Iterable<InsurancePaymentRecord>? receipts,
    $core.int? total,
  }) {
    final result = create();
    if (receipts != null) result.receipts.addAll(receipts);
    if (total != null) result.total = total;
    return result;
  }

  GetUserInsuranceReceiptsResponse._();

  factory GetUserInsuranceReceiptsResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetUserInsuranceReceiptsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUserInsuranceReceiptsResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..pc<InsurancePaymentRecord>(
        1, _omitFieldNames ? '' : 'receipts', $pb.PbFieldType.PM,
        subBuilder: InsurancePaymentRecord.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserInsuranceReceiptsResponse clone() =>
      GetUserInsuranceReceiptsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserInsuranceReceiptsResponse copyWith(
          void Function(GetUserInsuranceReceiptsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetUserInsuranceReceiptsResponse))
          as GetUserInsuranceReceiptsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserInsuranceReceiptsResponse create() =>
      GetUserInsuranceReceiptsResponse._();
  @$core.override
  GetUserInsuranceReceiptsResponse createEmptyInstance() => create();
  static $pb.PbList<GetUserInsuranceReceiptsResponse> createRepeated() =>
      $pb.PbList<GetUserInsuranceReceiptsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetUserInsuranceReceiptsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetUserInsuranceReceiptsResponse>(
          create);
  static GetUserInsuranceReceiptsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<InsurancePaymentRecord> get receipts => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);
}

/// Insurance statistics
class GetInsuranceStatisticsRequest extends $pb.GeneratedMessage {
  factory GetInsuranceStatisticsRequest() => create();

  GetInsuranceStatisticsRequest._();

  factory GetInsuranceStatisticsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetInsuranceStatisticsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetInsuranceStatisticsRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsuranceStatisticsRequest clone() =>
      GetInsuranceStatisticsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsuranceStatisticsRequest copyWith(
          void Function(GetInsuranceStatisticsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetInsuranceStatisticsRequest))
          as GetInsuranceStatisticsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInsuranceStatisticsRequest create() =>
      GetInsuranceStatisticsRequest._();
  @$core.override
  GetInsuranceStatisticsRequest createEmptyInstance() => create();
  static $pb.PbList<GetInsuranceStatisticsRequest> createRepeated() =>
      $pb.PbList<GetInsuranceStatisticsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInsuranceStatisticsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetInsuranceStatisticsRequest>(create);
  static GetInsuranceStatisticsRequest? _defaultInstance;
}

class GetInsuranceStatisticsResponse extends $pb.GeneratedMessage {
  factory GetInsuranceStatisticsResponse({
    $core.int? activePolicies,
    $core.int? totalPolicies,
    $fixnum.Int64? totalCoverage,
    $fixnum.Int64? totalPremiumsPaid,
    $core.int? totalClaims,
    $core.int? pendingClaims,
    $fixnum.Int64? totalClaimedAmount,
    $fixnum.Int64? totalApprovedAmount,
    $core.String? nextPaymentDue,
    $core.Iterable<$core.MapEntry<$core.String, $core.int>>? policiesByType,
  }) {
    final result = create();
    if (activePolicies != null) result.activePolicies = activePolicies;
    if (totalPolicies != null) result.totalPolicies = totalPolicies;
    if (totalCoverage != null) result.totalCoverage = totalCoverage;
    if (totalPremiumsPaid != null) result.totalPremiumsPaid = totalPremiumsPaid;
    if (totalClaims != null) result.totalClaims = totalClaims;
    if (pendingClaims != null) result.pendingClaims = pendingClaims;
    if (totalClaimedAmount != null)
      result.totalClaimedAmount = totalClaimedAmount;
    if (totalApprovedAmount != null)
      result.totalApprovedAmount = totalApprovedAmount;
    if (nextPaymentDue != null) result.nextPaymentDue = nextPaymentDue;
    if (policiesByType != null)
      result.policiesByType.addEntries(policiesByType);
    return result;
  }

  GetInsuranceStatisticsResponse._();

  factory GetInsuranceStatisticsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetInsuranceStatisticsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetInsuranceStatisticsResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..a<$core.int>(
        1, _omitFieldNames ? '' : 'activePolicies', $pb.PbFieldType.O3)
    ..a<$core.int>(
        2, _omitFieldNames ? '' : 'totalPolicies', $pb.PbFieldType.O3)
    ..aInt64(3, _omitFieldNames ? '' : 'totalCoverage')
    ..aInt64(4, _omitFieldNames ? '' : 'totalPremiumsPaid')
    ..a<$core.int>(5, _omitFieldNames ? '' : 'totalClaims', $pb.PbFieldType.O3)
    ..a<$core.int>(
        6, _omitFieldNames ? '' : 'pendingClaims', $pb.PbFieldType.O3)
    ..aInt64(7, _omitFieldNames ? '' : 'totalClaimedAmount')
    ..aInt64(8, _omitFieldNames ? '' : 'totalApprovedAmount')
    ..aOS(9, _omitFieldNames ? '' : 'nextPaymentDue')
    ..m<$core.String, $core.int>(10, _omitFieldNames ? '' : 'policiesByType',
        entryClassName: 'GetInsuranceStatisticsResponse.PoliciesByTypeEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.O3,
        packageName: const $pb.PackageName('financialproducts'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsuranceStatisticsResponse clone() =>
      GetInsuranceStatisticsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsuranceStatisticsResponse copyWith(
          void Function(GetInsuranceStatisticsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetInsuranceStatisticsResponse))
          as GetInsuranceStatisticsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInsuranceStatisticsResponse create() =>
      GetInsuranceStatisticsResponse._();
  @$core.override
  GetInsuranceStatisticsResponse createEmptyInstance() => create();
  static $pb.PbList<GetInsuranceStatisticsResponse> createRepeated() =>
      $pb.PbList<GetInsuranceStatisticsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInsuranceStatisticsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetInsuranceStatisticsResponse>(create);
  static GetInsuranceStatisticsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get activePolicies => $_getIZ(0);
  @$pb.TagNumber(1)
  set activePolicies($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasActivePolicies() => $_has(0);
  @$pb.TagNumber(1)
  void clearActivePolicies() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get totalPolicies => $_getIZ(1);
  @$pb.TagNumber(2)
  set totalPolicies($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotalPolicies() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalPolicies() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get totalCoverage => $_getI64(2);
  @$pb.TagNumber(3)
  set totalCoverage($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTotalCoverage() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalCoverage() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get totalPremiumsPaid => $_getI64(3);
  @$pb.TagNumber(4)
  set totalPremiumsPaid($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTotalPremiumsPaid() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalPremiumsPaid() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get totalClaims => $_getIZ(4);
  @$pb.TagNumber(5)
  set totalClaims($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTotalClaims() => $_has(4);
  @$pb.TagNumber(5)
  void clearTotalClaims() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.int get pendingClaims => $_getIZ(5);
  @$pb.TagNumber(6)
  set pendingClaims($core.int value) => $_setSignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasPendingClaims() => $_has(5);
  @$pb.TagNumber(6)
  void clearPendingClaims() => $_clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get totalClaimedAmount => $_getI64(6);
  @$pb.TagNumber(7)
  set totalClaimedAmount($fixnum.Int64 value) => $_setInt64(6, value);
  @$pb.TagNumber(7)
  $core.bool hasTotalClaimedAmount() => $_has(6);
  @$pb.TagNumber(7)
  void clearTotalClaimedAmount() => $_clearField(7);

  @$pb.TagNumber(8)
  $fixnum.Int64 get totalApprovedAmount => $_getI64(7);
  @$pb.TagNumber(8)
  set totalApprovedAmount($fixnum.Int64 value) => $_setInt64(7, value);
  @$pb.TagNumber(8)
  $core.bool hasTotalApprovedAmount() => $_has(7);
  @$pb.TagNumber(8)
  void clearTotalApprovedAmount() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get nextPaymentDue => $_getSZ(8);
  @$pb.TagNumber(9)
  set nextPaymentDue($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasNextPaymentDue() => $_has(8);
  @$pb.TagNumber(9)
  void clearNextPaymentDue() => $_clearField(9);

  @$pb.TagNumber(10)
  $pb.PbMap<$core.String, $core.int> get policiesByType => $_getMap(9);
}

/// Payment statistics
class GetInsurancePaymentStatisticsRequest extends $pb.GeneratedMessage {
  factory GetInsurancePaymentStatisticsRequest({
    $core.String? startDate,
    $core.String? endDate,
  }) {
    final result = create();
    if (startDate != null) result.startDate = startDate;
    if (endDate != null) result.endDate = endDate;
    return result;
  }

  GetInsurancePaymentStatisticsRequest._();

  factory GetInsurancePaymentStatisticsRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetInsurancePaymentStatisticsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetInsurancePaymentStatisticsRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'startDate')
    ..aOS(2, _omitFieldNames ? '' : 'endDate')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsurancePaymentStatisticsRequest clone() =>
      GetInsurancePaymentStatisticsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsurancePaymentStatisticsRequest copyWith(
          void Function(GetInsurancePaymentStatisticsRequest) updates) =>
      super.copyWith((message) =>
              updates(message as GetInsurancePaymentStatisticsRequest))
          as GetInsurancePaymentStatisticsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInsurancePaymentStatisticsRequest create() =>
      GetInsurancePaymentStatisticsRequest._();
  @$core.override
  GetInsurancePaymentStatisticsRequest createEmptyInstance() => create();
  static $pb.PbList<GetInsurancePaymentStatisticsRequest> createRepeated() =>
      $pb.PbList<GetInsurancePaymentStatisticsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInsurancePaymentStatisticsRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          GetInsurancePaymentStatisticsRequest>(create);
  static GetInsurancePaymentStatisticsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get startDate => $_getSZ(0);
  @$pb.TagNumber(1)
  set startDate($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasStartDate() => $_has(0);
  @$pb.TagNumber(1)
  void clearStartDate() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get endDate => $_getSZ(1);
  @$pb.TagNumber(2)
  set endDate($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasEndDate() => $_has(1);
  @$pb.TagNumber(2)
  void clearEndDate() => $_clearField(2);
}

class GetInsurancePaymentStatisticsResponse extends $pb.GeneratedMessage {
  factory GetInsurancePaymentStatisticsResponse({
    $core.int? totalPayments,
    $core.int? completedPayments,
    $core.int? pendingPayments,
    $core.int? failedPayments,
    $fixnum.Int64? totalAmount,
    $fixnum.Int64? completedAmount,
  }) {
    final result = create();
    if (totalPayments != null) result.totalPayments = totalPayments;
    if (completedPayments != null) result.completedPayments = completedPayments;
    if (pendingPayments != null) result.pendingPayments = pendingPayments;
    if (failedPayments != null) result.failedPayments = failedPayments;
    if (totalAmount != null) result.totalAmount = totalAmount;
    if (completedAmount != null) result.completedAmount = completedAmount;
    return result;
  }

  GetInsurancePaymentStatisticsResponse._();

  factory GetInsurancePaymentStatisticsResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetInsurancePaymentStatisticsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetInsurancePaymentStatisticsResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..a<$core.int>(
        1, _omitFieldNames ? '' : 'totalPayments', $pb.PbFieldType.O3)
    ..a<$core.int>(
        2, _omitFieldNames ? '' : 'completedPayments', $pb.PbFieldType.O3)
    ..a<$core.int>(
        3, _omitFieldNames ? '' : 'pendingPayments', $pb.PbFieldType.O3)
    ..a<$core.int>(
        4, _omitFieldNames ? '' : 'failedPayments', $pb.PbFieldType.O3)
    ..aInt64(5, _omitFieldNames ? '' : 'totalAmount')
    ..aInt64(6, _omitFieldNames ? '' : 'completedAmount')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsurancePaymentStatisticsResponse clone() =>
      GetInsurancePaymentStatisticsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsurancePaymentStatisticsResponse copyWith(
          void Function(GetInsurancePaymentStatisticsResponse) updates) =>
      super.copyWith((message) =>
              updates(message as GetInsurancePaymentStatisticsResponse))
          as GetInsurancePaymentStatisticsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInsurancePaymentStatisticsResponse create() =>
      GetInsurancePaymentStatisticsResponse._();
  @$core.override
  GetInsurancePaymentStatisticsResponse createEmptyInstance() => create();
  static $pb.PbList<GetInsurancePaymentStatisticsResponse> createRepeated() =>
      $pb.PbList<GetInsurancePaymentStatisticsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInsurancePaymentStatisticsResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          GetInsurancePaymentStatisticsResponse>(create);
  static GetInsurancePaymentStatisticsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get totalPayments => $_getIZ(0);
  @$pb.TagNumber(1)
  set totalPayments($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTotalPayments() => $_has(0);
  @$pb.TagNumber(1)
  void clearTotalPayments() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get completedPayments => $_getIZ(1);
  @$pb.TagNumber(2)
  set completedPayments($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCompletedPayments() => $_has(1);
  @$pb.TagNumber(2)
  void clearCompletedPayments() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get pendingPayments => $_getIZ(2);
  @$pb.TagNumber(3)
  set pendingPayments($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPendingPayments() => $_has(2);
  @$pb.TagNumber(3)
  void clearPendingPayments() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get failedPayments => $_getIZ(3);
  @$pb.TagNumber(4)
  set failedPayments($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasFailedPayments() => $_has(3);
  @$pb.TagNumber(4)
  void clearFailedPayments() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get totalAmount => $_getI64(4);
  @$pb.TagNumber(5)
  set totalAmount($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTotalAmount() => $_has(4);
  @$pb.TagNumber(5)
  void clearTotalAmount() => $_clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get completedAmount => $_getI64(5);
  @$pb.TagNumber(6)
  set completedAmount($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasCompletedAmount() => $_has(5);
  @$pb.TagNumber(6)
  void clearCompletedAmount() => $_clearField(6);
}

/// Auto-save rule model
class AutoSaveRule extends $pb.GeneratedMessage {
  factory AutoSaveRule({
    $core.String? id,
    $core.String? userId,
    $core.String? name,
    $core.String? description,
    $core.String? triggerType,
    $core.String? amountType,
    $core.double? amountValue,
    $core.String? sourceAccountId,
    $core.String? destinationAccountId,
    $core.String? status,
    $core.String? frequency,
    $core.String? scheduleTime,
    $core.int? scheduleDay,
    $core.int? roundUpTo,
    $core.double? targetAmount,
    $core.double? minimumBalance,
    $core.double? maximumPerSave,
    $core.String? createdAt,
    $core.String? updatedAt,
    $core.String? lastTriggeredAt,
    $core.int? triggerCount,
    $core.double? totalSaved,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (userId != null) result.userId = userId;
    if (name != null) result.name = name;
    if (description != null) result.description = description;
    if (triggerType != null) result.triggerType = triggerType;
    if (amountType != null) result.amountType = amountType;
    if (amountValue != null) result.amountValue = amountValue;
    if (sourceAccountId != null) result.sourceAccountId = sourceAccountId;
    if (destinationAccountId != null)
      result.destinationAccountId = destinationAccountId;
    if (status != null) result.status = status;
    if (frequency != null) result.frequency = frequency;
    if (scheduleTime != null) result.scheduleTime = scheduleTime;
    if (scheduleDay != null) result.scheduleDay = scheduleDay;
    if (roundUpTo != null) result.roundUpTo = roundUpTo;
    if (targetAmount != null) result.targetAmount = targetAmount;
    if (minimumBalance != null) result.minimumBalance = minimumBalance;
    if (maximumPerSave != null) result.maximumPerSave = maximumPerSave;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    if (lastTriggeredAt != null) result.lastTriggeredAt = lastTriggeredAt;
    if (triggerCount != null) result.triggerCount = triggerCount;
    if (totalSaved != null) result.totalSaved = totalSaved;
    return result;
  }

  AutoSaveRule._();

  factory AutoSaveRule.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AutoSaveRule.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AutoSaveRule',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'name')
    ..aOS(4, _omitFieldNames ? '' : 'description')
    ..aOS(5, _omitFieldNames ? '' : 'triggerType')
    ..aOS(6, _omitFieldNames ? '' : 'amountType')
    ..a<$core.double>(
        7, _omitFieldNames ? '' : 'amountValue', $pb.PbFieldType.OD)
    ..aOS(8, _omitFieldNames ? '' : 'sourceAccountId')
    ..aOS(9, _omitFieldNames ? '' : 'destinationAccountId')
    ..aOS(10, _omitFieldNames ? '' : 'status')
    ..aOS(11, _omitFieldNames ? '' : 'frequency')
    ..aOS(12, _omitFieldNames ? '' : 'scheduleTime')
    ..a<$core.int>(13, _omitFieldNames ? '' : 'scheduleDay', $pb.PbFieldType.O3)
    ..a<$core.int>(14, _omitFieldNames ? '' : 'roundUpTo', $pb.PbFieldType.O3)
    ..a<$core.double>(
        15, _omitFieldNames ? '' : 'targetAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(
        16, _omitFieldNames ? '' : 'minimumBalance', $pb.PbFieldType.OD)
    ..a<$core.double>(
        17, _omitFieldNames ? '' : 'maximumPerSave', $pb.PbFieldType.OD)
    ..aOS(18, _omitFieldNames ? '' : 'createdAt')
    ..aOS(19, _omitFieldNames ? '' : 'updatedAt')
    ..aOS(20, _omitFieldNames ? '' : 'lastTriggeredAt')
    ..a<$core.int>(
        21, _omitFieldNames ? '' : 'triggerCount', $pb.PbFieldType.O3)
    ..a<$core.double>(
        22, _omitFieldNames ? '' : 'totalSaved', $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AutoSaveRule clone() => AutoSaveRule()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AutoSaveRule copyWith(void Function(AutoSaveRule) updates) =>
      super.copyWith((message) => updates(message as AutoSaveRule))
          as AutoSaveRule;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AutoSaveRule create() => AutoSaveRule._();
  @$core.override
  AutoSaveRule createEmptyInstance() => create();
  static $pb.PbList<AutoSaveRule> createRepeated() =>
      $pb.PbList<AutoSaveRule>();
  @$core.pragma('dart2js:noInline')
  static AutoSaveRule getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AutoSaveRule>(create);
  static AutoSaveRule? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(3)
  set name($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get description => $_getSZ(3);
  @$pb.TagNumber(4)
  set description($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDescription() => $_has(3);
  @$pb.TagNumber(4)
  void clearDescription() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get triggerType => $_getSZ(4);
  @$pb.TagNumber(5)
  set triggerType($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTriggerType() => $_has(4);
  @$pb.TagNumber(5)
  void clearTriggerType() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get amountType => $_getSZ(5);
  @$pb.TagNumber(6)
  set amountType($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasAmountType() => $_has(5);
  @$pb.TagNumber(6)
  void clearAmountType() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.double get amountValue => $_getN(6);
  @$pb.TagNumber(7)
  set amountValue($core.double value) => $_setDouble(6, value);
  @$pb.TagNumber(7)
  $core.bool hasAmountValue() => $_has(6);
  @$pb.TagNumber(7)
  void clearAmountValue() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get sourceAccountId => $_getSZ(7);
  @$pb.TagNumber(8)
  set sourceAccountId($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasSourceAccountId() => $_has(7);
  @$pb.TagNumber(8)
  void clearSourceAccountId() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get destinationAccountId => $_getSZ(8);
  @$pb.TagNumber(9)
  set destinationAccountId($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasDestinationAccountId() => $_has(8);
  @$pb.TagNumber(9)
  void clearDestinationAccountId() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get status => $_getSZ(9);
  @$pb.TagNumber(10)
  set status($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasStatus() => $_has(9);
  @$pb.TagNumber(10)
  void clearStatus() => $_clearField(10);

  /// For scheduled triggers
  @$pb.TagNumber(11)
  $core.String get frequency => $_getSZ(10);
  @$pb.TagNumber(11)
  set frequency($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasFrequency() => $_has(10);
  @$pb.TagNumber(11)
  void clearFrequency() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get scheduleTime => $_getSZ(11);
  @$pb.TagNumber(12)
  set scheduleTime($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasScheduleTime() => $_has(11);
  @$pb.TagNumber(12)
  void clearScheduleTime() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.int get scheduleDay => $_getIZ(12);
  @$pb.TagNumber(13)
  set scheduleDay($core.int value) => $_setSignedInt32(12, value);
  @$pb.TagNumber(13)
  $core.bool hasScheduleDay() => $_has(12);
  @$pb.TagNumber(13)
  void clearScheduleDay() => $_clearField(13);

  /// For round-up triggers
  @$pb.TagNumber(14)
  $core.int get roundUpTo => $_getIZ(13);
  @$pb.TagNumber(14)
  set roundUpTo($core.int value) => $_setSignedInt32(13, value);
  @$pb.TagNumber(14)
  $core.bool hasRoundUpTo() => $_has(13);
  @$pb.TagNumber(14)
  void clearRoundUpTo() => $_clearField(14);

  /// Goals and limits
  @$pb.TagNumber(15)
  $core.double get targetAmount => $_getN(14);
  @$pb.TagNumber(15)
  set targetAmount($core.double value) => $_setDouble(14, value);
  @$pb.TagNumber(15)
  $core.bool hasTargetAmount() => $_has(14);
  @$pb.TagNumber(15)
  void clearTargetAmount() => $_clearField(15);

  @$pb.TagNumber(16)
  $core.double get minimumBalance => $_getN(15);
  @$pb.TagNumber(16)
  set minimumBalance($core.double value) => $_setDouble(15, value);
  @$pb.TagNumber(16)
  $core.bool hasMinimumBalance() => $_has(15);
  @$pb.TagNumber(16)
  void clearMinimumBalance() => $_clearField(16);

  @$pb.TagNumber(17)
  $core.double get maximumPerSave => $_getN(16);
  @$pb.TagNumber(17)
  set maximumPerSave($core.double value) => $_setDouble(16, value);
  @$pb.TagNumber(17)
  $core.bool hasMaximumPerSave() => $_has(16);
  @$pb.TagNumber(17)
  void clearMaximumPerSave() => $_clearField(17);

  /// Metadata
  @$pb.TagNumber(18)
  $core.String get createdAt => $_getSZ(17);
  @$pb.TagNumber(18)
  set createdAt($core.String value) => $_setString(17, value);
  @$pb.TagNumber(18)
  $core.bool hasCreatedAt() => $_has(17);
  @$pb.TagNumber(18)
  void clearCreatedAt() => $_clearField(18);

  @$pb.TagNumber(19)
  $core.String get updatedAt => $_getSZ(18);
  @$pb.TagNumber(19)
  set updatedAt($core.String value) => $_setString(18, value);
  @$pb.TagNumber(19)
  $core.bool hasUpdatedAt() => $_has(18);
  @$pb.TagNumber(19)
  void clearUpdatedAt() => $_clearField(19);

  @$pb.TagNumber(20)
  $core.String get lastTriggeredAt => $_getSZ(19);
  @$pb.TagNumber(20)
  set lastTriggeredAt($core.String value) => $_setString(19, value);
  @$pb.TagNumber(20)
  $core.bool hasLastTriggeredAt() => $_has(19);
  @$pb.TagNumber(20)
  void clearLastTriggeredAt() => $_clearField(20);

  @$pb.TagNumber(21)
  $core.int get triggerCount => $_getIZ(20);
  @$pb.TagNumber(21)
  set triggerCount($core.int value) => $_setSignedInt32(20, value);
  @$pb.TagNumber(21)
  $core.bool hasTriggerCount() => $_has(20);
  @$pb.TagNumber(21)
  void clearTriggerCount() => $_clearField(21);

  @$pb.TagNumber(22)
  $core.double get totalSaved => $_getN(21);
  @$pb.TagNumber(22)
  set totalSaved($core.double value) => $_setDouble(21, value);
  @$pb.TagNumber(22)
  $core.bool hasTotalSaved() => $_has(21);
  @$pb.TagNumber(22)
  void clearTotalSaved() => $_clearField(22);
}

/// Auto-save transaction record
class AutoSaveTransaction extends $pb.GeneratedMessage {
  factory AutoSaveTransaction({
    $core.String? id,
    $core.String? ruleId,
    $core.String? userId,
    $core.String? sourceAccountId,
    $core.String? destinationAccountId,
    $core.double? amount,
    $core.String? triggerType,
    $core.String? triggerReason,
    $core.bool? success,
    $core.String? errorMessage,
    $core.String? createdAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (ruleId != null) result.ruleId = ruleId;
    if (userId != null) result.userId = userId;
    if (sourceAccountId != null) result.sourceAccountId = sourceAccountId;
    if (destinationAccountId != null)
      result.destinationAccountId = destinationAccountId;
    if (amount != null) result.amount = amount;
    if (triggerType != null) result.triggerType = triggerType;
    if (triggerReason != null) result.triggerReason = triggerReason;
    if (success != null) result.success = success;
    if (errorMessage != null) result.errorMessage = errorMessage;
    if (createdAt != null) result.createdAt = createdAt;
    return result;
  }

  AutoSaveTransaction._();

  factory AutoSaveTransaction.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AutoSaveTransaction.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AutoSaveTransaction',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'ruleId')
    ..aOS(3, _omitFieldNames ? '' : 'userId')
    ..aOS(4, _omitFieldNames ? '' : 'sourceAccountId')
    ..aOS(5, _omitFieldNames ? '' : 'destinationAccountId')
    ..a<$core.double>(6, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(7, _omitFieldNames ? '' : 'triggerType')
    ..aOS(8, _omitFieldNames ? '' : 'triggerReason')
    ..aOB(9, _omitFieldNames ? '' : 'success')
    ..aOS(10, _omitFieldNames ? '' : 'errorMessage')
    ..aOS(11, _omitFieldNames ? '' : 'createdAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AutoSaveTransaction clone() => AutoSaveTransaction()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AutoSaveTransaction copyWith(void Function(AutoSaveTransaction) updates) =>
      super.copyWith((message) => updates(message as AutoSaveTransaction))
          as AutoSaveTransaction;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AutoSaveTransaction create() => AutoSaveTransaction._();
  @$core.override
  AutoSaveTransaction createEmptyInstance() => create();
  static $pb.PbList<AutoSaveTransaction> createRepeated() =>
      $pb.PbList<AutoSaveTransaction>();
  @$core.pragma('dart2js:noInline')
  static AutoSaveTransaction getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AutoSaveTransaction>(create);
  static AutoSaveTransaction? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get ruleId => $_getSZ(1);
  @$pb.TagNumber(2)
  set ruleId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRuleId() => $_has(1);
  @$pb.TagNumber(2)
  void clearRuleId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get userId => $_getSZ(2);
  @$pb.TagNumber(3)
  set userId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasUserId() => $_has(2);
  @$pb.TagNumber(3)
  void clearUserId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get sourceAccountId => $_getSZ(3);
  @$pb.TagNumber(4)
  set sourceAccountId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasSourceAccountId() => $_has(3);
  @$pb.TagNumber(4)
  void clearSourceAccountId() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get destinationAccountId => $_getSZ(4);
  @$pb.TagNumber(5)
  set destinationAccountId($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasDestinationAccountId() => $_has(4);
  @$pb.TagNumber(5)
  void clearDestinationAccountId() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.double get amount => $_getN(5);
  @$pb.TagNumber(6)
  set amount($core.double value) => $_setDouble(5, value);
  @$pb.TagNumber(6)
  $core.bool hasAmount() => $_has(5);
  @$pb.TagNumber(6)
  void clearAmount() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get triggerType => $_getSZ(6);
  @$pb.TagNumber(7)
  set triggerType($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasTriggerType() => $_has(6);
  @$pb.TagNumber(7)
  void clearTriggerType() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get triggerReason => $_getSZ(7);
  @$pb.TagNumber(8)
  set triggerReason($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasTriggerReason() => $_has(7);
  @$pb.TagNumber(8)
  void clearTriggerReason() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.bool get success => $_getBF(8);
  @$pb.TagNumber(9)
  set success($core.bool value) => $_setBool(8, value);
  @$pb.TagNumber(9)
  $core.bool hasSuccess() => $_has(8);
  @$pb.TagNumber(9)
  void clearSuccess() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get errorMessage => $_getSZ(9);
  @$pb.TagNumber(10)
  set errorMessage($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasErrorMessage() => $_has(9);
  @$pb.TagNumber(10)
  void clearErrorMessage() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get createdAt => $_getSZ(10);
  @$pb.TagNumber(11)
  set createdAt($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasCreatedAt() => $_has(10);
  @$pb.TagNumber(11)
  void clearCreatedAt() => $_clearField(11);
}

/// Auto-save statistics
class AutoSaveStatistics extends $pb.GeneratedMessage {
  factory AutoSaveStatistics({
    $core.String? userId,
    $core.int? activeRulesCount,
    $core.double? totalSavedAllTime,
    $core.double? totalSavedThisMonth,
    $core.double? totalSavedThisWeek,
    $core.int? totalTransactions,
    $core.double? averageSaveAmount,
    AutoSaveRule? mostActiveRule,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    if (activeRulesCount != null) result.activeRulesCount = activeRulesCount;
    if (totalSavedAllTime != null) result.totalSavedAllTime = totalSavedAllTime;
    if (totalSavedThisMonth != null)
      result.totalSavedThisMonth = totalSavedThisMonth;
    if (totalSavedThisWeek != null)
      result.totalSavedThisWeek = totalSavedThisWeek;
    if (totalTransactions != null) result.totalTransactions = totalTransactions;
    if (averageSaveAmount != null) result.averageSaveAmount = averageSaveAmount;
    if (mostActiveRule != null) result.mostActiveRule = mostActiveRule;
    return result;
  }

  AutoSaveStatistics._();

  factory AutoSaveStatistics.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AutoSaveStatistics.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AutoSaveStatistics',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..a<$core.int>(
        2, _omitFieldNames ? '' : 'activeRulesCount', $pb.PbFieldType.O3)
    ..a<$core.double>(
        3, _omitFieldNames ? '' : 'totalSavedAllTime', $pb.PbFieldType.OD)
    ..a<$core.double>(
        4, _omitFieldNames ? '' : 'totalSavedThisMonth', $pb.PbFieldType.OD)
    ..a<$core.double>(
        5, _omitFieldNames ? '' : 'totalSavedThisWeek', $pb.PbFieldType.OD)
    ..a<$core.int>(
        6, _omitFieldNames ? '' : 'totalTransactions', $pb.PbFieldType.O3)
    ..a<$core.double>(
        7, _omitFieldNames ? '' : 'averageSaveAmount', $pb.PbFieldType.OD)
    ..aOM<AutoSaveRule>(8, _omitFieldNames ? '' : 'mostActiveRule',
        subBuilder: AutoSaveRule.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AutoSaveStatistics clone() => AutoSaveStatistics()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AutoSaveStatistics copyWith(void Function(AutoSaveStatistics) updates) =>
      super.copyWith((message) => updates(message as AutoSaveStatistics))
          as AutoSaveStatistics;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AutoSaveStatistics create() => AutoSaveStatistics._();
  @$core.override
  AutoSaveStatistics createEmptyInstance() => create();
  static $pb.PbList<AutoSaveStatistics> createRepeated() =>
      $pb.PbList<AutoSaveStatistics>();
  @$core.pragma('dart2js:noInline')
  static AutoSaveStatistics getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AutoSaveStatistics>(create);
  static AutoSaveStatistics? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get activeRulesCount => $_getIZ(1);
  @$pb.TagNumber(2)
  set activeRulesCount($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasActiveRulesCount() => $_has(1);
  @$pb.TagNumber(2)
  void clearActiveRulesCount() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get totalSavedAllTime => $_getN(2);
  @$pb.TagNumber(3)
  set totalSavedAllTime($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTotalSavedAllTime() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalSavedAllTime() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get totalSavedThisMonth => $_getN(3);
  @$pb.TagNumber(4)
  set totalSavedThisMonth($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTotalSavedThisMonth() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalSavedThisMonth() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get totalSavedThisWeek => $_getN(4);
  @$pb.TagNumber(5)
  set totalSavedThisWeek($core.double value) => $_setDouble(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTotalSavedThisWeek() => $_has(4);
  @$pb.TagNumber(5)
  void clearTotalSavedThisWeek() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.int get totalTransactions => $_getIZ(5);
  @$pb.TagNumber(6)
  set totalTransactions($core.int value) => $_setSignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasTotalTransactions() => $_has(5);
  @$pb.TagNumber(6)
  void clearTotalTransactions() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.double get averageSaveAmount => $_getN(6);
  @$pb.TagNumber(7)
  set averageSaveAmount($core.double value) => $_setDouble(6, value);
  @$pb.TagNumber(7)
  $core.bool hasAverageSaveAmount() => $_has(6);
  @$pb.TagNumber(7)
  void clearAverageSaveAmount() => $_clearField(7);

  @$pb.TagNumber(8)
  AutoSaveRule get mostActiveRule => $_getN(7);
  @$pb.TagNumber(8)
  set mostActiveRule(AutoSaveRule value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasMostActiveRule() => $_has(7);
  @$pb.TagNumber(8)
  void clearMostActiveRule() => $_clearField(8);
  @$pb.TagNumber(8)
  AutoSaveRule ensureMostActiveRule() => $_ensure(7);
}

/// Create auto-save rule
class CreateAutoSaveRuleRequest2 extends $pb.GeneratedMessage {
  factory CreateAutoSaveRuleRequest2({
    $core.String? name,
    $core.String? description,
    $core.String? triggerType,
    $core.String? amountType,
    $core.double? amountValue,
    $core.String? sourceAccountId,
    $core.String? destinationAccountId,
    $core.String? frequency,
    $core.String? scheduleTime,
    $core.int? scheduleDay,
    $core.int? roundUpTo,
    $core.double? targetAmount,
    $core.double? minimumBalance,
    $core.double? maximumPerSave,
  }) {
    final result = create();
    if (name != null) result.name = name;
    if (description != null) result.description = description;
    if (triggerType != null) result.triggerType = triggerType;
    if (amountType != null) result.amountType = amountType;
    if (amountValue != null) result.amountValue = amountValue;
    if (sourceAccountId != null) result.sourceAccountId = sourceAccountId;
    if (destinationAccountId != null)
      result.destinationAccountId = destinationAccountId;
    if (frequency != null) result.frequency = frequency;
    if (scheduleTime != null) result.scheduleTime = scheduleTime;
    if (scheduleDay != null) result.scheduleDay = scheduleDay;
    if (roundUpTo != null) result.roundUpTo = roundUpTo;
    if (targetAmount != null) result.targetAmount = targetAmount;
    if (minimumBalance != null) result.minimumBalance = minimumBalance;
    if (maximumPerSave != null) result.maximumPerSave = maximumPerSave;
    return result;
  }

  CreateAutoSaveRuleRequest2._();

  factory CreateAutoSaveRuleRequest2.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateAutoSaveRuleRequest2.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateAutoSaveRuleRequest2',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOS(2, _omitFieldNames ? '' : 'description')
    ..aOS(3, _omitFieldNames ? '' : 'triggerType')
    ..aOS(4, _omitFieldNames ? '' : 'amountType')
    ..a<$core.double>(
        5, _omitFieldNames ? '' : 'amountValue', $pb.PbFieldType.OD)
    ..aOS(6, _omitFieldNames ? '' : 'sourceAccountId')
    ..aOS(7, _omitFieldNames ? '' : 'destinationAccountId')
    ..aOS(8, _omitFieldNames ? '' : 'frequency')
    ..aOS(9, _omitFieldNames ? '' : 'scheduleTime')
    ..a<$core.int>(10, _omitFieldNames ? '' : 'scheduleDay', $pb.PbFieldType.O3)
    ..a<$core.int>(11, _omitFieldNames ? '' : 'roundUpTo', $pb.PbFieldType.O3)
    ..a<$core.double>(
        12, _omitFieldNames ? '' : 'targetAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(
        13, _omitFieldNames ? '' : 'minimumBalance', $pb.PbFieldType.OD)
    ..a<$core.double>(
        14, _omitFieldNames ? '' : 'maximumPerSave', $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateAutoSaveRuleRequest2 clone() =>
      CreateAutoSaveRuleRequest2()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateAutoSaveRuleRequest2 copyWith(
          void Function(CreateAutoSaveRuleRequest2) updates) =>
      super.copyWith(
              (message) => updates(message as CreateAutoSaveRuleRequest2))
          as CreateAutoSaveRuleRequest2;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateAutoSaveRuleRequest2 create() => CreateAutoSaveRuleRequest2._();
  @$core.override
  CreateAutoSaveRuleRequest2 createEmptyInstance() => create();
  static $pb.PbList<CreateAutoSaveRuleRequest2> createRepeated() =>
      $pb.PbList<CreateAutoSaveRuleRequest2>();
  @$core.pragma('dart2js:noInline')
  static CreateAutoSaveRuleRequest2 getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateAutoSaveRuleRequest2>(create);
  static CreateAutoSaveRuleRequest2? _defaultInstance;

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

  @$pb.TagNumber(3)
  $core.String get triggerType => $_getSZ(2);
  @$pb.TagNumber(3)
  set triggerType($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTriggerType() => $_has(2);
  @$pb.TagNumber(3)
  void clearTriggerType() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get amountType => $_getSZ(3);
  @$pb.TagNumber(4)
  set amountType($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAmountType() => $_has(3);
  @$pb.TagNumber(4)
  void clearAmountType() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get amountValue => $_getN(4);
  @$pb.TagNumber(5)
  set amountValue($core.double value) => $_setDouble(4, value);
  @$pb.TagNumber(5)
  $core.bool hasAmountValue() => $_has(4);
  @$pb.TagNumber(5)
  void clearAmountValue() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get sourceAccountId => $_getSZ(5);
  @$pb.TagNumber(6)
  set sourceAccountId($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasSourceAccountId() => $_has(5);
  @$pb.TagNumber(6)
  void clearSourceAccountId() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get destinationAccountId => $_getSZ(6);
  @$pb.TagNumber(7)
  set destinationAccountId($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasDestinationAccountId() => $_has(6);
  @$pb.TagNumber(7)
  void clearDestinationAccountId() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get frequency => $_getSZ(7);
  @$pb.TagNumber(8)
  set frequency($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasFrequency() => $_has(7);
  @$pb.TagNumber(8)
  void clearFrequency() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get scheduleTime => $_getSZ(8);
  @$pb.TagNumber(9)
  set scheduleTime($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasScheduleTime() => $_has(8);
  @$pb.TagNumber(9)
  void clearScheduleTime() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.int get scheduleDay => $_getIZ(9);
  @$pb.TagNumber(10)
  set scheduleDay($core.int value) => $_setSignedInt32(9, value);
  @$pb.TagNumber(10)
  $core.bool hasScheduleDay() => $_has(9);
  @$pb.TagNumber(10)
  void clearScheduleDay() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.int get roundUpTo => $_getIZ(10);
  @$pb.TagNumber(11)
  set roundUpTo($core.int value) => $_setSignedInt32(10, value);
  @$pb.TagNumber(11)
  $core.bool hasRoundUpTo() => $_has(10);
  @$pb.TagNumber(11)
  void clearRoundUpTo() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.double get targetAmount => $_getN(11);
  @$pb.TagNumber(12)
  set targetAmount($core.double value) => $_setDouble(11, value);
  @$pb.TagNumber(12)
  $core.bool hasTargetAmount() => $_has(11);
  @$pb.TagNumber(12)
  void clearTargetAmount() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.double get minimumBalance => $_getN(12);
  @$pb.TagNumber(13)
  set minimumBalance($core.double value) => $_setDouble(12, value);
  @$pb.TagNumber(13)
  $core.bool hasMinimumBalance() => $_has(12);
  @$pb.TagNumber(13)
  void clearMinimumBalance() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.double get maximumPerSave => $_getN(13);
  @$pb.TagNumber(14)
  set maximumPerSave($core.double value) => $_setDouble(13, value);
  @$pb.TagNumber(14)
  $core.bool hasMaximumPerSave() => $_has(13);
  @$pb.TagNumber(14)
  void clearMaximumPerSave() => $_clearField(14);
}

class CreateAutoSaveRuleResponse2 extends $pb.GeneratedMessage {
  factory CreateAutoSaveRuleResponse2({
    AutoSaveRule? rule,
    $core.String? message,
  }) {
    final result = create();
    if (rule != null) result.rule = rule;
    if (message != null) result.message = message;
    return result;
  }

  CreateAutoSaveRuleResponse2._();

  factory CreateAutoSaveRuleResponse2.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateAutoSaveRuleResponse2.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateAutoSaveRuleResponse2',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOM<AutoSaveRule>(1, _omitFieldNames ? '' : 'rule',
        subBuilder: AutoSaveRule.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateAutoSaveRuleResponse2 clone() =>
      CreateAutoSaveRuleResponse2()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateAutoSaveRuleResponse2 copyWith(
          void Function(CreateAutoSaveRuleResponse2) updates) =>
      super.copyWith(
              (message) => updates(message as CreateAutoSaveRuleResponse2))
          as CreateAutoSaveRuleResponse2;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateAutoSaveRuleResponse2 create() =>
      CreateAutoSaveRuleResponse2._();
  @$core.override
  CreateAutoSaveRuleResponse2 createEmptyInstance() => create();
  static $pb.PbList<CreateAutoSaveRuleResponse2> createRepeated() =>
      $pb.PbList<CreateAutoSaveRuleResponse2>();
  @$core.pragma('dart2js:noInline')
  static CreateAutoSaveRuleResponse2 getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateAutoSaveRuleResponse2>(create);
  static CreateAutoSaveRuleResponse2? _defaultInstance;

  @$pb.TagNumber(1)
  AutoSaveRule get rule => $_getN(0);
  @$pb.TagNumber(1)
  set rule(AutoSaveRule value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRule() => $_has(0);
  @$pb.TagNumber(1)
  void clearRule() => $_clearField(1);
  @$pb.TagNumber(1)
  AutoSaveRule ensureRule() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);
}

/// Get auto-save rules
class GetAutoSaveRulesRequest2 extends $pb.GeneratedMessage {
  factory GetAutoSaveRulesRequest2({
    $core.String? accountId,
    $core.String? status,
  }) {
    final result = create();
    if (accountId != null) result.accountId = accountId;
    if (status != null) result.status = status;
    return result;
  }

  GetAutoSaveRulesRequest2._();

  factory GetAutoSaveRulesRequest2.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetAutoSaveRulesRequest2.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetAutoSaveRulesRequest2',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountId')
    ..aOS(2, _omitFieldNames ? '' : 'status')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAutoSaveRulesRequest2 clone() =>
      GetAutoSaveRulesRequest2()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAutoSaveRulesRequest2 copyWith(
          void Function(GetAutoSaveRulesRequest2) updates) =>
      super.copyWith((message) => updates(message as GetAutoSaveRulesRequest2))
          as GetAutoSaveRulesRequest2;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAutoSaveRulesRequest2 create() => GetAutoSaveRulesRequest2._();
  @$core.override
  GetAutoSaveRulesRequest2 createEmptyInstance() => create();
  static $pb.PbList<GetAutoSaveRulesRequest2> createRepeated() =>
      $pb.PbList<GetAutoSaveRulesRequest2>();
  @$core.pragma('dart2js:noInline')
  static GetAutoSaveRulesRequest2 getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetAutoSaveRulesRequest2>(create);
  static GetAutoSaveRulesRequest2? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get status => $_getSZ(1);
  @$pb.TagNumber(2)
  set status($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => $_clearField(2);
}

class GetAutoSaveRulesResponse2 extends $pb.GeneratedMessage {
  factory GetAutoSaveRulesResponse2({
    $core.Iterable<AutoSaveRule>? rules,
    $core.int? total,
  }) {
    final result = create();
    if (rules != null) result.rules.addAll(rules);
    if (total != null) result.total = total;
    return result;
  }

  GetAutoSaveRulesResponse2._();

  factory GetAutoSaveRulesResponse2.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetAutoSaveRulesResponse2.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetAutoSaveRulesResponse2',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..pc<AutoSaveRule>(1, _omitFieldNames ? '' : 'rules', $pb.PbFieldType.PM,
        subBuilder: AutoSaveRule.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAutoSaveRulesResponse2 clone() =>
      GetAutoSaveRulesResponse2()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAutoSaveRulesResponse2 copyWith(
          void Function(GetAutoSaveRulesResponse2) updates) =>
      super.copyWith((message) => updates(message as GetAutoSaveRulesResponse2))
          as GetAutoSaveRulesResponse2;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAutoSaveRulesResponse2 create() => GetAutoSaveRulesResponse2._();
  @$core.override
  GetAutoSaveRulesResponse2 createEmptyInstance() => create();
  static $pb.PbList<GetAutoSaveRulesResponse2> createRepeated() =>
      $pb.PbList<GetAutoSaveRulesResponse2>();
  @$core.pragma('dart2js:noInline')
  static GetAutoSaveRulesResponse2 getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetAutoSaveRulesResponse2>(create);
  static GetAutoSaveRulesResponse2? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<AutoSaveRule> get rules => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);
}

/// Update auto-save rule
class UpdateAutoSaveRuleRequest2 extends $pb.GeneratedMessage {
  factory UpdateAutoSaveRuleRequest2({
    $core.String? ruleId,
    $core.String? name,
    $core.String? description,
    $core.String? amountType,
    $core.double? amountValue,
    $core.String? frequency,
    $core.String? scheduleTime,
    $core.int? scheduleDay,
    $core.int? roundUpTo,
    $core.double? targetAmount,
    $core.double? minimumBalance,
    $core.double? maximumPerSave,
  }) {
    final result = create();
    if (ruleId != null) result.ruleId = ruleId;
    if (name != null) result.name = name;
    if (description != null) result.description = description;
    if (amountType != null) result.amountType = amountType;
    if (amountValue != null) result.amountValue = amountValue;
    if (frequency != null) result.frequency = frequency;
    if (scheduleTime != null) result.scheduleTime = scheduleTime;
    if (scheduleDay != null) result.scheduleDay = scheduleDay;
    if (roundUpTo != null) result.roundUpTo = roundUpTo;
    if (targetAmount != null) result.targetAmount = targetAmount;
    if (minimumBalance != null) result.minimumBalance = minimumBalance;
    if (maximumPerSave != null) result.maximumPerSave = maximumPerSave;
    return result;
  }

  UpdateAutoSaveRuleRequest2._();

  factory UpdateAutoSaveRuleRequest2.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateAutoSaveRuleRequest2.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateAutoSaveRuleRequest2',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'ruleId')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..aOS(4, _omitFieldNames ? '' : 'amountType')
    ..a<$core.double>(
        5, _omitFieldNames ? '' : 'amountValue', $pb.PbFieldType.OD)
    ..aOS(6, _omitFieldNames ? '' : 'frequency')
    ..aOS(7, _omitFieldNames ? '' : 'scheduleTime')
    ..a<$core.int>(8, _omitFieldNames ? '' : 'scheduleDay', $pb.PbFieldType.O3)
    ..a<$core.int>(9, _omitFieldNames ? '' : 'roundUpTo', $pb.PbFieldType.O3)
    ..a<$core.double>(
        10, _omitFieldNames ? '' : 'targetAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(
        11, _omitFieldNames ? '' : 'minimumBalance', $pb.PbFieldType.OD)
    ..a<$core.double>(
        12, _omitFieldNames ? '' : 'maximumPerSave', $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateAutoSaveRuleRequest2 clone() =>
      UpdateAutoSaveRuleRequest2()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateAutoSaveRuleRequest2 copyWith(
          void Function(UpdateAutoSaveRuleRequest2) updates) =>
      super.copyWith(
              (message) => updates(message as UpdateAutoSaveRuleRequest2))
          as UpdateAutoSaveRuleRequest2;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateAutoSaveRuleRequest2 create() => UpdateAutoSaveRuleRequest2._();
  @$core.override
  UpdateAutoSaveRuleRequest2 createEmptyInstance() => create();
  static $pb.PbList<UpdateAutoSaveRuleRequest2> createRepeated() =>
      $pb.PbList<UpdateAutoSaveRuleRequest2>();
  @$core.pragma('dart2js:noInline')
  static UpdateAutoSaveRuleRequest2 getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateAutoSaveRuleRequest2>(create);
  static UpdateAutoSaveRuleRequest2? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get ruleId => $_getSZ(0);
  @$pb.TagNumber(1)
  set ruleId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRuleId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRuleId() => $_clearField(1);

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
  $core.String get amountType => $_getSZ(3);
  @$pb.TagNumber(4)
  set amountType($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAmountType() => $_has(3);
  @$pb.TagNumber(4)
  void clearAmountType() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get amountValue => $_getN(4);
  @$pb.TagNumber(5)
  set amountValue($core.double value) => $_setDouble(4, value);
  @$pb.TagNumber(5)
  $core.bool hasAmountValue() => $_has(4);
  @$pb.TagNumber(5)
  void clearAmountValue() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get frequency => $_getSZ(5);
  @$pb.TagNumber(6)
  set frequency($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasFrequency() => $_has(5);
  @$pb.TagNumber(6)
  void clearFrequency() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get scheduleTime => $_getSZ(6);
  @$pb.TagNumber(7)
  set scheduleTime($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasScheduleTime() => $_has(6);
  @$pb.TagNumber(7)
  void clearScheduleTime() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.int get scheduleDay => $_getIZ(7);
  @$pb.TagNumber(8)
  set scheduleDay($core.int value) => $_setSignedInt32(7, value);
  @$pb.TagNumber(8)
  $core.bool hasScheduleDay() => $_has(7);
  @$pb.TagNumber(8)
  void clearScheduleDay() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.int get roundUpTo => $_getIZ(8);
  @$pb.TagNumber(9)
  set roundUpTo($core.int value) => $_setSignedInt32(8, value);
  @$pb.TagNumber(9)
  $core.bool hasRoundUpTo() => $_has(8);
  @$pb.TagNumber(9)
  void clearRoundUpTo() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.double get targetAmount => $_getN(9);
  @$pb.TagNumber(10)
  set targetAmount($core.double value) => $_setDouble(9, value);
  @$pb.TagNumber(10)
  $core.bool hasTargetAmount() => $_has(9);
  @$pb.TagNumber(10)
  void clearTargetAmount() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.double get minimumBalance => $_getN(10);
  @$pb.TagNumber(11)
  set minimumBalance($core.double value) => $_setDouble(10, value);
  @$pb.TagNumber(11)
  $core.bool hasMinimumBalance() => $_has(10);
  @$pb.TagNumber(11)
  void clearMinimumBalance() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.double get maximumPerSave => $_getN(11);
  @$pb.TagNumber(12)
  set maximumPerSave($core.double value) => $_setDouble(11, value);
  @$pb.TagNumber(12)
  $core.bool hasMaximumPerSave() => $_has(11);
  @$pb.TagNumber(12)
  void clearMaximumPerSave() => $_clearField(12);
}

class UpdateAutoSaveRuleResponse2 extends $pb.GeneratedMessage {
  factory UpdateAutoSaveRuleResponse2({
    AutoSaveRule? rule,
    $core.String? message,
  }) {
    final result = create();
    if (rule != null) result.rule = rule;
    if (message != null) result.message = message;
    return result;
  }

  UpdateAutoSaveRuleResponse2._();

  factory UpdateAutoSaveRuleResponse2.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateAutoSaveRuleResponse2.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateAutoSaveRuleResponse2',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOM<AutoSaveRule>(1, _omitFieldNames ? '' : 'rule',
        subBuilder: AutoSaveRule.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateAutoSaveRuleResponse2 clone() =>
      UpdateAutoSaveRuleResponse2()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateAutoSaveRuleResponse2 copyWith(
          void Function(UpdateAutoSaveRuleResponse2) updates) =>
      super.copyWith(
              (message) => updates(message as UpdateAutoSaveRuleResponse2))
          as UpdateAutoSaveRuleResponse2;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateAutoSaveRuleResponse2 create() =>
      UpdateAutoSaveRuleResponse2._();
  @$core.override
  UpdateAutoSaveRuleResponse2 createEmptyInstance() => create();
  static $pb.PbList<UpdateAutoSaveRuleResponse2> createRepeated() =>
      $pb.PbList<UpdateAutoSaveRuleResponse2>();
  @$core.pragma('dart2js:noInline')
  static UpdateAutoSaveRuleResponse2 getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateAutoSaveRuleResponse2>(create);
  static UpdateAutoSaveRuleResponse2? _defaultInstance;

  @$pb.TagNumber(1)
  AutoSaveRule get rule => $_getN(0);
  @$pb.TagNumber(1)
  set rule(AutoSaveRule value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRule() => $_has(0);
  @$pb.TagNumber(1)
  void clearRule() => $_clearField(1);
  @$pb.TagNumber(1)
  AutoSaveRule ensureRule() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);
}

/// Toggle auto-save rule (pause/resume)
class ToggleAutoSaveRuleRequest2 extends $pb.GeneratedMessage {
  factory ToggleAutoSaveRuleRequest2({
    $core.String? ruleId,
    $core.String? action,
  }) {
    final result = create();
    if (ruleId != null) result.ruleId = ruleId;
    if (action != null) result.action = action;
    return result;
  }

  ToggleAutoSaveRuleRequest2._();

  factory ToggleAutoSaveRuleRequest2.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ToggleAutoSaveRuleRequest2.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ToggleAutoSaveRuleRequest2',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'ruleId')
    ..aOS(2, _omitFieldNames ? '' : 'action')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ToggleAutoSaveRuleRequest2 clone() =>
      ToggleAutoSaveRuleRequest2()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ToggleAutoSaveRuleRequest2 copyWith(
          void Function(ToggleAutoSaveRuleRequest2) updates) =>
      super.copyWith(
              (message) => updates(message as ToggleAutoSaveRuleRequest2))
          as ToggleAutoSaveRuleRequest2;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ToggleAutoSaveRuleRequest2 create() => ToggleAutoSaveRuleRequest2._();
  @$core.override
  ToggleAutoSaveRuleRequest2 createEmptyInstance() => create();
  static $pb.PbList<ToggleAutoSaveRuleRequest2> createRepeated() =>
      $pb.PbList<ToggleAutoSaveRuleRequest2>();
  @$core.pragma('dart2js:noInline')
  static ToggleAutoSaveRuleRequest2 getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ToggleAutoSaveRuleRequest2>(create);
  static ToggleAutoSaveRuleRequest2? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get ruleId => $_getSZ(0);
  @$pb.TagNumber(1)
  set ruleId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRuleId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRuleId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get action => $_getSZ(1);
  @$pb.TagNumber(2)
  set action($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAction() => $_has(1);
  @$pb.TagNumber(2)
  void clearAction() => $_clearField(2);
}

class ToggleAutoSaveRuleResponse2 extends $pb.GeneratedMessage {
  factory ToggleAutoSaveRuleResponse2({
    AutoSaveRule? rule,
    $core.String? message,
  }) {
    final result = create();
    if (rule != null) result.rule = rule;
    if (message != null) result.message = message;
    return result;
  }

  ToggleAutoSaveRuleResponse2._();

  factory ToggleAutoSaveRuleResponse2.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ToggleAutoSaveRuleResponse2.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ToggleAutoSaveRuleResponse2',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOM<AutoSaveRule>(1, _omitFieldNames ? '' : 'rule',
        subBuilder: AutoSaveRule.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ToggleAutoSaveRuleResponse2 clone() =>
      ToggleAutoSaveRuleResponse2()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ToggleAutoSaveRuleResponse2 copyWith(
          void Function(ToggleAutoSaveRuleResponse2) updates) =>
      super.copyWith(
              (message) => updates(message as ToggleAutoSaveRuleResponse2))
          as ToggleAutoSaveRuleResponse2;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ToggleAutoSaveRuleResponse2 create() =>
      ToggleAutoSaveRuleResponse2._();
  @$core.override
  ToggleAutoSaveRuleResponse2 createEmptyInstance() => create();
  static $pb.PbList<ToggleAutoSaveRuleResponse2> createRepeated() =>
      $pb.PbList<ToggleAutoSaveRuleResponse2>();
  @$core.pragma('dart2js:noInline')
  static ToggleAutoSaveRuleResponse2 getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ToggleAutoSaveRuleResponse2>(create);
  static ToggleAutoSaveRuleResponse2? _defaultInstance;

  @$pb.TagNumber(1)
  AutoSaveRule get rule => $_getN(0);
  @$pb.TagNumber(1)
  set rule(AutoSaveRule value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRule() => $_has(0);
  @$pb.TagNumber(1)
  void clearRule() => $_clearField(1);
  @$pb.TagNumber(1)
  AutoSaveRule ensureRule() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);
}

/// Delete auto-save rule
class DeleteAutoSaveRuleRequest2 extends $pb.GeneratedMessage {
  factory DeleteAutoSaveRuleRequest2({
    $core.String? ruleId,
  }) {
    final result = create();
    if (ruleId != null) result.ruleId = ruleId;
    return result;
  }

  DeleteAutoSaveRuleRequest2._();

  factory DeleteAutoSaveRuleRequest2.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeleteAutoSaveRuleRequest2.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteAutoSaveRuleRequest2',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'ruleId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteAutoSaveRuleRequest2 clone() =>
      DeleteAutoSaveRuleRequest2()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteAutoSaveRuleRequest2 copyWith(
          void Function(DeleteAutoSaveRuleRequest2) updates) =>
      super.copyWith(
              (message) => updates(message as DeleteAutoSaveRuleRequest2))
          as DeleteAutoSaveRuleRequest2;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteAutoSaveRuleRequest2 create() => DeleteAutoSaveRuleRequest2._();
  @$core.override
  DeleteAutoSaveRuleRequest2 createEmptyInstance() => create();
  static $pb.PbList<DeleteAutoSaveRuleRequest2> createRepeated() =>
      $pb.PbList<DeleteAutoSaveRuleRequest2>();
  @$core.pragma('dart2js:noInline')
  static DeleteAutoSaveRuleRequest2 getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteAutoSaveRuleRequest2>(create);
  static DeleteAutoSaveRuleRequest2? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get ruleId => $_getSZ(0);
  @$pb.TagNumber(1)
  set ruleId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRuleId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRuleId() => $_clearField(1);
}

class DeleteAutoSaveRuleResponse2 extends $pb.GeneratedMessage {
  factory DeleteAutoSaveRuleResponse2({
    $core.bool? success,
    $core.String? message,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    return result;
  }

  DeleteAutoSaveRuleResponse2._();

  factory DeleteAutoSaveRuleResponse2.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeleteAutoSaveRuleResponse2.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteAutoSaveRuleResponse2',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteAutoSaveRuleResponse2 clone() =>
      DeleteAutoSaveRuleResponse2()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteAutoSaveRuleResponse2 copyWith(
          void Function(DeleteAutoSaveRuleResponse2) updates) =>
      super.copyWith(
              (message) => updates(message as DeleteAutoSaveRuleResponse2))
          as DeleteAutoSaveRuleResponse2;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteAutoSaveRuleResponse2 create() =>
      DeleteAutoSaveRuleResponse2._();
  @$core.override
  DeleteAutoSaveRuleResponse2 createEmptyInstance() => create();
  static $pb.PbList<DeleteAutoSaveRuleResponse2> createRepeated() =>
      $pb.PbList<DeleteAutoSaveRuleResponse2>();
  @$core.pragma('dart2js:noInline')
  static DeleteAutoSaveRuleResponse2 getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteAutoSaveRuleResponse2>(create);
  static DeleteAutoSaveRuleResponse2? _defaultInstance;

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

/// Get auto-save transactions
class GetAutoSaveTransactionsRequest2 extends $pb.GeneratedMessage {
  factory GetAutoSaveTransactionsRequest2({
    $core.String? ruleId,
    $core.String? accountId,
    $core.int? limit,
    $core.int? offset,
  }) {
    final result = create();
    if (ruleId != null) result.ruleId = ruleId;
    if (accountId != null) result.accountId = accountId;
    if (limit != null) result.limit = limit;
    if (offset != null) result.offset = offset;
    return result;
  }

  GetAutoSaveTransactionsRequest2._();

  factory GetAutoSaveTransactionsRequest2.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetAutoSaveTransactionsRequest2.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetAutoSaveTransactionsRequest2',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'ruleId')
    ..aOS(2, _omitFieldNames ? '' : 'accountId')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAutoSaveTransactionsRequest2 clone() =>
      GetAutoSaveTransactionsRequest2()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAutoSaveTransactionsRequest2 copyWith(
          void Function(GetAutoSaveTransactionsRequest2) updates) =>
      super.copyWith(
              (message) => updates(message as GetAutoSaveTransactionsRequest2))
          as GetAutoSaveTransactionsRequest2;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAutoSaveTransactionsRequest2 create() =>
      GetAutoSaveTransactionsRequest2._();
  @$core.override
  GetAutoSaveTransactionsRequest2 createEmptyInstance() => create();
  static $pb.PbList<GetAutoSaveTransactionsRequest2> createRepeated() =>
      $pb.PbList<GetAutoSaveTransactionsRequest2>();
  @$core.pragma('dart2js:noInline')
  static GetAutoSaveTransactionsRequest2 getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetAutoSaveTransactionsRequest2>(
          create);
  static GetAutoSaveTransactionsRequest2? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get ruleId => $_getSZ(0);
  @$pb.TagNumber(1)
  set ruleId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRuleId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRuleId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get accountId => $_getSZ(1);
  @$pb.TagNumber(2)
  set accountId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAccountId() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccountId() => $_clearField(2);

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

class GetAutoSaveTransactionsResponse2 extends $pb.GeneratedMessage {
  factory GetAutoSaveTransactionsResponse2({
    $core.Iterable<AutoSaveTransaction>? transactions,
    $core.int? total,
  }) {
    final result = create();
    if (transactions != null) result.transactions.addAll(transactions);
    if (total != null) result.total = total;
    return result;
  }

  GetAutoSaveTransactionsResponse2._();

  factory GetAutoSaveTransactionsResponse2.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetAutoSaveTransactionsResponse2.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetAutoSaveTransactionsResponse2',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..pc<AutoSaveTransaction>(
        1, _omitFieldNames ? '' : 'transactions', $pb.PbFieldType.PM,
        subBuilder: AutoSaveTransaction.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAutoSaveTransactionsResponse2 clone() =>
      GetAutoSaveTransactionsResponse2()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAutoSaveTransactionsResponse2 copyWith(
          void Function(GetAutoSaveTransactionsResponse2) updates) =>
      super.copyWith(
              (message) => updates(message as GetAutoSaveTransactionsResponse2))
          as GetAutoSaveTransactionsResponse2;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAutoSaveTransactionsResponse2 create() =>
      GetAutoSaveTransactionsResponse2._();
  @$core.override
  GetAutoSaveTransactionsResponse2 createEmptyInstance() => create();
  static $pb.PbList<GetAutoSaveTransactionsResponse2> createRepeated() =>
      $pb.PbList<GetAutoSaveTransactionsResponse2>();
  @$core.pragma('dart2js:noInline')
  static GetAutoSaveTransactionsResponse2 getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetAutoSaveTransactionsResponse2>(
          create);
  static GetAutoSaveTransactionsResponse2? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<AutoSaveTransaction> get transactions => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);
}

/// Get auto-save statistics
class GetAutoSaveStatisticsRequest2 extends $pb.GeneratedMessage {
  factory GetAutoSaveStatisticsRequest2() => create();

  GetAutoSaveStatisticsRequest2._();

  factory GetAutoSaveStatisticsRequest2.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetAutoSaveStatisticsRequest2.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetAutoSaveStatisticsRequest2',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAutoSaveStatisticsRequest2 clone() =>
      GetAutoSaveStatisticsRequest2()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAutoSaveStatisticsRequest2 copyWith(
          void Function(GetAutoSaveStatisticsRequest2) updates) =>
      super.copyWith(
              (message) => updates(message as GetAutoSaveStatisticsRequest2))
          as GetAutoSaveStatisticsRequest2;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAutoSaveStatisticsRequest2 create() =>
      GetAutoSaveStatisticsRequest2._();
  @$core.override
  GetAutoSaveStatisticsRequest2 createEmptyInstance() => create();
  static $pb.PbList<GetAutoSaveStatisticsRequest2> createRepeated() =>
      $pb.PbList<GetAutoSaveStatisticsRequest2>();
  @$core.pragma('dart2js:noInline')
  static GetAutoSaveStatisticsRequest2 getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetAutoSaveStatisticsRequest2>(create);
  static GetAutoSaveStatisticsRequest2? _defaultInstance;
}

class GetAutoSaveStatisticsResponse2 extends $pb.GeneratedMessage {
  factory GetAutoSaveStatisticsResponse2({
    AutoSaveStatistics? statistics,
  }) {
    final result = create();
    if (statistics != null) result.statistics = statistics;
    return result;
  }

  GetAutoSaveStatisticsResponse2._();

  factory GetAutoSaveStatisticsResponse2.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetAutoSaveStatisticsResponse2.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetAutoSaveStatisticsResponse2',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOM<AutoSaveStatistics>(1, _omitFieldNames ? '' : 'statistics',
        subBuilder: AutoSaveStatistics.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAutoSaveStatisticsResponse2 clone() =>
      GetAutoSaveStatisticsResponse2()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAutoSaveStatisticsResponse2 copyWith(
          void Function(GetAutoSaveStatisticsResponse2) updates) =>
      super.copyWith(
              (message) => updates(message as GetAutoSaveStatisticsResponse2))
          as GetAutoSaveStatisticsResponse2;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAutoSaveStatisticsResponse2 create() =>
      GetAutoSaveStatisticsResponse2._();
  @$core.override
  GetAutoSaveStatisticsResponse2 createEmptyInstance() => create();
  static $pb.PbList<GetAutoSaveStatisticsResponse2> createRepeated() =>
      $pb.PbList<GetAutoSaveStatisticsResponse2>();
  @$core.pragma('dart2js:noInline')
  static GetAutoSaveStatisticsResponse2 getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetAutoSaveStatisticsResponse2>(create);
  static GetAutoSaveStatisticsResponse2? _defaultInstance;

  @$pb.TagNumber(1)
  AutoSaveStatistics get statistics => $_getN(0);
  @$pb.TagNumber(1)
  set statistics(AutoSaveStatistics value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasStatistics() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatistics() => $_clearField(1);
  @$pb.TagNumber(1)
  AutoSaveStatistics ensureStatistics() => $_ensure(0);
}

/// Trigger auto-save manually
class TriggerAutoSaveRequest2 extends $pb.GeneratedMessage {
  factory TriggerAutoSaveRequest2({
    $core.String? ruleId,
    $core.double? customAmount,
    $core.String? transactionPinToken,
  }) {
    final result = create();
    if (ruleId != null) result.ruleId = ruleId;
    if (customAmount != null) result.customAmount = customAmount;
    if (transactionPinToken != null)
      result.transactionPinToken = transactionPinToken;
    return result;
  }

  TriggerAutoSaveRequest2._();

  factory TriggerAutoSaveRequest2.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TriggerAutoSaveRequest2.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TriggerAutoSaveRequest2',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'ruleId')
    ..a<$core.double>(
        2, _omitFieldNames ? '' : 'customAmount', $pb.PbFieldType.OD)
    ..aOS(4, _omitFieldNames ? '' : 'transactionPinToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TriggerAutoSaveRequest2 clone() =>
      TriggerAutoSaveRequest2()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TriggerAutoSaveRequest2 copyWith(
          void Function(TriggerAutoSaveRequest2) updates) =>
      super.copyWith((message) => updates(message as TriggerAutoSaveRequest2))
          as TriggerAutoSaveRequest2;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TriggerAutoSaveRequest2 create() => TriggerAutoSaveRequest2._();
  @$core.override
  TriggerAutoSaveRequest2 createEmptyInstance() => create();
  static $pb.PbList<TriggerAutoSaveRequest2> createRepeated() =>
      $pb.PbList<TriggerAutoSaveRequest2>();
  @$core.pragma('dart2js:noInline')
  static TriggerAutoSaveRequest2 getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TriggerAutoSaveRequest2>(create);
  static TriggerAutoSaveRequest2? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get ruleId => $_getSZ(0);
  @$pb.TagNumber(1)
  set ruleId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRuleId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRuleId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get customAmount => $_getN(1);
  @$pb.TagNumber(2)
  set customAmount($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCustomAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearCustomAmount() => $_clearField(2);

  @$pb.TagNumber(4)
  $core.String get transactionPinToken => $_getSZ(2);
  @$pb.TagNumber(4)
  set transactionPinToken($core.String value) => $_setString(2, value);
  @$pb.TagNumber(4)
  $core.bool hasTransactionPinToken() => $_has(2);
  @$pb.TagNumber(4)
  void clearTransactionPinToken() => $_clearField(4);
}

class TriggerAutoSaveResponse2 extends $pb.GeneratedMessage {
  factory TriggerAutoSaveResponse2({
    AutoSaveTransaction? transaction,
    $core.String? message,
  }) {
    final result = create();
    if (transaction != null) result.transaction = transaction;
    if (message != null) result.message = message;
    return result;
  }

  TriggerAutoSaveResponse2._();

  factory TriggerAutoSaveResponse2.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TriggerAutoSaveResponse2.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TriggerAutoSaveResponse2',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOM<AutoSaveTransaction>(1, _omitFieldNames ? '' : 'transaction',
        subBuilder: AutoSaveTransaction.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TriggerAutoSaveResponse2 clone() =>
      TriggerAutoSaveResponse2()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TriggerAutoSaveResponse2 copyWith(
          void Function(TriggerAutoSaveResponse2) updates) =>
      super.copyWith((message) => updates(message as TriggerAutoSaveResponse2))
          as TriggerAutoSaveResponse2;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TriggerAutoSaveResponse2 create() => TriggerAutoSaveResponse2._();
  @$core.override
  TriggerAutoSaveResponse2 createEmptyInstance() => create();
  static $pb.PbList<TriggerAutoSaveResponse2> createRepeated() =>
      $pb.PbList<TriggerAutoSaveResponse2>();
  @$core.pragma('dart2js:noInline')
  static TriggerAutoSaveResponse2 getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TriggerAutoSaveResponse2>(create);
  static TriggerAutoSaveResponse2? _defaultInstance;

  @$pb.TagNumber(1)
  AutoSaveTransaction get transaction => $_getN(0);
  @$pb.TagNumber(1)
  set transaction(AutoSaveTransaction value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasTransaction() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransaction() => $_clearField(1);
  @$pb.TagNumber(1)
  AutoSaveTransaction ensureTransaction() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);
}

/// Notification channel model
class NotificationChannel extends $pb.GeneratedMessage {
  factory NotificationChannel({
    $core.String? id,
    $core.String? crowdfundId,
    $core.String? creatorUserId,
    NotificationChannelType? channelType,
    NotificationChannelStatus? status,
    $core.String? channelName,
    $core.String? channelIdentifier,
    $core.String? channelUsername,
    $core.Iterable<NotificationEventType>? enabledEvents,
    NotificationPreferences? preferences,
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
    if (channelIdentifier != null) result.channelIdentifier = channelIdentifier;
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

  NotificationChannel._();

  factory NotificationChannel.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory NotificationChannel.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'NotificationChannel',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
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
    ..aOS(7, _omitFieldNames ? '' : 'channelIdentifier')
    ..aOS(8, _omitFieldNames ? '' : 'channelUsername')
    ..pc<NotificationEventType>(
        9, _omitFieldNames ? '' : 'enabledEvents', $pb.PbFieldType.KE,
        valueOf: NotificationEventType.valueOf,
        enumValues: NotificationEventType.values,
        defaultEnumValue:
            NotificationEventType.NOTIFICATION_EVENT_TYPE_UNSPECIFIED)
    ..aOM<NotificationPreferences>(10, _omitFieldNames ? '' : 'preferences',
        subBuilder: NotificationPreferences.create)
    ..aOS(11, _omitFieldNames ? '' : 'lastNotificationAt')
    ..a<$core.int>(
        12, _omitFieldNames ? '' : 'notificationCount', $pb.PbFieldType.O3)
    ..a<$core.int>(
        13, _omitFieldNames ? '' : 'failureCount', $pb.PbFieldType.O3)
    ..aOS(14, _omitFieldNames ? '' : 'lastError')
    ..aOS(15, _omitFieldNames ? '' : 'createdAt')
    ..aOS(16, _omitFieldNames ? '' : 'updatedAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  NotificationChannel clone() => NotificationChannel()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  NotificationChannel copyWith(void Function(NotificationChannel) updates) =>
      super.copyWith((message) => updates(message as NotificationChannel))
          as NotificationChannel;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NotificationChannel create() => NotificationChannel._();
  @$core.override
  NotificationChannel createEmptyInstance() => create();
  static $pb.PbList<NotificationChannel> createRepeated() =>
      $pb.PbList<NotificationChannel>();
  @$core.pragma('dart2js:noInline')
  static NotificationChannel getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<NotificationChannel>(create);
  static NotificationChannel? _defaultInstance;

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
  $core.String get channelIdentifier => $_getSZ(6);
  @$pb.TagNumber(7)
  set channelIdentifier($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasChannelIdentifier() => $_has(6);
  @$pb.TagNumber(7)
  void clearChannelIdentifier() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get channelUsername => $_getSZ(7);
  @$pb.TagNumber(8)
  set channelUsername($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasChannelUsername() => $_has(7);
  @$pb.TagNumber(8)
  void clearChannelUsername() => $_clearField(8);

  @$pb.TagNumber(9)
  $pb.PbList<NotificationEventType> get enabledEvents => $_getList(8);

  @$pb.TagNumber(10)
  NotificationPreferences get preferences => $_getN(9);
  @$pb.TagNumber(10)
  set preferences(NotificationPreferences value) => $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasPreferences() => $_has(9);
  @$pb.TagNumber(10)
  void clearPreferences() => $_clearField(10);
  @$pb.TagNumber(10)
  NotificationPreferences ensurePreferences() => $_ensure(9);

  @$pb.TagNumber(11)
  $core.String get lastNotificationAt => $_getSZ(10);
  @$pb.TagNumber(11)
  set lastNotificationAt($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasLastNotificationAt() => $_has(10);
  @$pb.TagNumber(11)
  void clearLastNotificationAt() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.int get notificationCount => $_getIZ(11);
  @$pb.TagNumber(12)
  set notificationCount($core.int value) => $_setSignedInt32(11, value);
  @$pb.TagNumber(12)
  $core.bool hasNotificationCount() => $_has(11);
  @$pb.TagNumber(12)
  void clearNotificationCount() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.int get failureCount => $_getIZ(12);
  @$pb.TagNumber(13)
  set failureCount($core.int value) => $_setSignedInt32(12, value);
  @$pb.TagNumber(13)
  $core.bool hasFailureCount() => $_has(12);
  @$pb.TagNumber(13)
  void clearFailureCount() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.String get lastError => $_getSZ(13);
  @$pb.TagNumber(14)
  set lastError($core.String value) => $_setString(13, value);
  @$pb.TagNumber(14)
  $core.bool hasLastError() => $_has(13);
  @$pb.TagNumber(14)
  void clearLastError() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.String get createdAt => $_getSZ(14);
  @$pb.TagNumber(15)
  set createdAt($core.String value) => $_setString(14, value);
  @$pb.TagNumber(15)
  $core.bool hasCreatedAt() => $_has(14);
  @$pb.TagNumber(15)
  void clearCreatedAt() => $_clearField(15);

  @$pb.TagNumber(16)
  $core.String get updatedAt => $_getSZ(15);
  @$pb.TagNumber(16)
  set updatedAt($core.String value) => $_setString(15, value);
  @$pb.TagNumber(16)
  $core.bool hasUpdatedAt() => $_has(15);
  @$pb.TagNumber(16)
  void clearUpdatedAt() => $_clearField(16);
}

/// Notification preferences for a channel
class NotificationPreferences extends $pb.GeneratedMessage {
  factory NotificationPreferences({
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

  NotificationPreferences._();

  factory NotificationPreferences.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory NotificationPreferences.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'NotificationPreferences',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
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
  NotificationPreferences clone() =>
      NotificationPreferences()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  NotificationPreferences copyWith(
          void Function(NotificationPreferences) updates) =>
      super.copyWith((message) => updates(message as NotificationPreferences))
          as NotificationPreferences;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NotificationPreferences create() => NotificationPreferences._();
  @$core.override
  NotificationPreferences createEmptyInstance() => create();
  static $pb.PbList<NotificationPreferences> createRepeated() =>
      $pb.PbList<NotificationPreferences>();
  @$core.pragma('dart2js:noInline')
  static NotificationPreferences getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<NotificationPreferences>(create);
  static NotificationPreferences? _defaultInstance;

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

/// Notification delivery record
class NotificationDelivery extends $pb.GeneratedMessage {
  factory NotificationDelivery({
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

  NotificationDelivery._();

  factory NotificationDelivery.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory NotificationDelivery.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'NotificationDelivery',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
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
  NotificationDelivery clone() =>
      NotificationDelivery()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  NotificationDelivery copyWith(void Function(NotificationDelivery) updates) =>
      super.copyWith((message) => updates(message as NotificationDelivery))
          as NotificationDelivery;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NotificationDelivery create() => NotificationDelivery._();
  @$core.override
  NotificationDelivery createEmptyInstance() => create();
  static $pb.PbList<NotificationDelivery> createRepeated() =>
      $pb.PbList<NotificationDelivery>();
  @$core.pragma('dart2js:noInline')
  static NotificationDelivery getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<NotificationDelivery>(create);
  static NotificationDelivery? _defaultInstance;

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

enum ConnectNotificationChannelRequest_ConnectionData {
  telegram,
  discord,
  whatsappBusiness,
  slack,
  notSet
}

/// Connect notification channel
class ConnectNotificationChannelRequest extends $pb.GeneratedMessage {
  factory ConnectNotificationChannelRequest({
    $core.String? crowdfundId,
    NotificationChannelType? channelType,
    $core.String? channelName,
    TelegramConnectionData? telegram,
    DiscordConnectionData? discord,
    WhatsAppBusinessConnectionData? whatsappBusiness,
    SlackConnectionData? slack,
    $core.Iterable<NotificationEventType>? enabledEvents,
    NotificationPreferences? preferences,
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
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
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
    ..aOM<TelegramConnectionData>(4, _omitFieldNames ? '' : 'telegram',
        subBuilder: TelegramConnectionData.create)
    ..aOM<DiscordConnectionData>(5, _omitFieldNames ? '' : 'discord',
        subBuilder: DiscordConnectionData.create)
    ..aOM<WhatsAppBusinessConnectionData>(
        6, _omitFieldNames ? '' : 'whatsappBusiness',
        subBuilder: WhatsAppBusinessConnectionData.create)
    ..aOM<SlackConnectionData>(7, _omitFieldNames ? '' : 'slack',
        subBuilder: SlackConnectionData.create)
    ..pc<NotificationEventType>(
        8, _omitFieldNames ? '' : 'enabledEvents', $pb.PbFieldType.KE,
        valueOf: NotificationEventType.valueOf,
        enumValues: NotificationEventType.values,
        defaultEnumValue:
            NotificationEventType.NOTIFICATION_EVENT_TYPE_UNSPECIFIED)
    ..aOM<NotificationPreferences>(9, _omitFieldNames ? '' : 'preferences',
        subBuilder: NotificationPreferences.create)
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
  TelegramConnectionData get telegram => $_getN(3);
  @$pb.TagNumber(4)
  set telegram(TelegramConnectionData value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasTelegram() => $_has(3);
  @$pb.TagNumber(4)
  void clearTelegram() => $_clearField(4);
  @$pb.TagNumber(4)
  TelegramConnectionData ensureTelegram() => $_ensure(3);

  @$pb.TagNumber(5)
  DiscordConnectionData get discord => $_getN(4);
  @$pb.TagNumber(5)
  set discord(DiscordConnectionData value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasDiscord() => $_has(4);
  @$pb.TagNumber(5)
  void clearDiscord() => $_clearField(5);
  @$pb.TagNumber(5)
  DiscordConnectionData ensureDiscord() => $_ensure(4);

  @$pb.TagNumber(6)
  WhatsAppBusinessConnectionData get whatsappBusiness => $_getN(5);
  @$pb.TagNumber(6)
  set whatsappBusiness(WhatsAppBusinessConnectionData value) =>
      $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasWhatsappBusiness() => $_has(5);
  @$pb.TagNumber(6)
  void clearWhatsappBusiness() => $_clearField(6);
  @$pb.TagNumber(6)
  WhatsAppBusinessConnectionData ensureWhatsappBusiness() => $_ensure(5);

  @$pb.TagNumber(7)
  SlackConnectionData get slack => $_getN(6);
  @$pb.TagNumber(7)
  set slack(SlackConnectionData value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasSlack() => $_has(6);
  @$pb.TagNumber(7)
  void clearSlack() => $_clearField(7);
  @$pb.TagNumber(7)
  SlackConnectionData ensureSlack() => $_ensure(6);

  @$pb.TagNumber(8)
  $pb.PbList<NotificationEventType> get enabledEvents => $_getList(7);

  @$pb.TagNumber(9)
  NotificationPreferences get preferences => $_getN(8);
  @$pb.TagNumber(9)
  set preferences(NotificationPreferences value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasPreferences() => $_has(8);
  @$pb.TagNumber(9)
  void clearPreferences() => $_clearField(9);
  @$pb.TagNumber(9)
  NotificationPreferences ensurePreferences() => $_ensure(8);
}

class TelegramConnectionData extends $pb.GeneratedMessage {
  factory TelegramConnectionData({
    $core.String? chatId,
    $core.String? verificationCode,
  }) {
    final result = create();
    if (chatId != null) result.chatId = chatId;
    if (verificationCode != null) result.verificationCode = verificationCode;
    return result;
  }

  TelegramConnectionData._();

  factory TelegramConnectionData.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TelegramConnectionData.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TelegramConnectionData',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'chatId')
    ..aOS(2, _omitFieldNames ? '' : 'verificationCode')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TelegramConnectionData clone() =>
      TelegramConnectionData()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TelegramConnectionData copyWith(
          void Function(TelegramConnectionData) updates) =>
      super.copyWith((message) => updates(message as TelegramConnectionData))
          as TelegramConnectionData;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TelegramConnectionData create() => TelegramConnectionData._();
  @$core.override
  TelegramConnectionData createEmptyInstance() => create();
  static $pb.PbList<TelegramConnectionData> createRepeated() =>
      $pb.PbList<TelegramConnectionData>();
  @$core.pragma('dart2js:noInline')
  static TelegramConnectionData getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TelegramConnectionData>(create);
  static TelegramConnectionData? _defaultInstance;

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

class DiscordConnectionData extends $pb.GeneratedMessage {
  factory DiscordConnectionData({
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

  DiscordConnectionData._();

  factory DiscordConnectionData.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DiscordConnectionData.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DiscordConnectionData',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'webhookUrl')
    ..aOS(2, _omitFieldNames ? '' : 'serverName')
    ..aOS(3, _omitFieldNames ? '' : 'channelName')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DiscordConnectionData clone() =>
      DiscordConnectionData()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DiscordConnectionData copyWith(
          void Function(DiscordConnectionData) updates) =>
      super.copyWith((message) => updates(message as DiscordConnectionData))
          as DiscordConnectionData;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DiscordConnectionData create() => DiscordConnectionData._();
  @$core.override
  DiscordConnectionData createEmptyInstance() => create();
  static $pb.PbList<DiscordConnectionData> createRepeated() =>
      $pb.PbList<DiscordConnectionData>();
  @$core.pragma('dart2js:noInline')
  static DiscordConnectionData getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DiscordConnectionData>(create);
  static DiscordConnectionData? _defaultInstance;

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

class WhatsAppBusinessConnectionData extends $pb.GeneratedMessage {
  factory WhatsAppBusinessConnectionData({
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

  WhatsAppBusinessConnectionData._();

  factory WhatsAppBusinessConnectionData.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory WhatsAppBusinessConnectionData.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'WhatsAppBusinessConnectionData',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'phoneNumberId')
    ..aOS(2, _omitFieldNames ? '' : 'accessToken')
    ..aOS(3, _omitFieldNames ? '' : 'recipientId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WhatsAppBusinessConnectionData clone() =>
      WhatsAppBusinessConnectionData()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WhatsAppBusinessConnectionData copyWith(
          void Function(WhatsAppBusinessConnectionData) updates) =>
      super.copyWith(
              (message) => updates(message as WhatsAppBusinessConnectionData))
          as WhatsAppBusinessConnectionData;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WhatsAppBusinessConnectionData create() =>
      WhatsAppBusinessConnectionData._();
  @$core.override
  WhatsAppBusinessConnectionData createEmptyInstance() => create();
  static $pb.PbList<WhatsAppBusinessConnectionData> createRepeated() =>
      $pb.PbList<WhatsAppBusinessConnectionData>();
  @$core.pragma('dart2js:noInline')
  static WhatsAppBusinessConnectionData getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<WhatsAppBusinessConnectionData>(create);
  static WhatsAppBusinessConnectionData? _defaultInstance;

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

class SlackConnectionData extends $pb.GeneratedMessage {
  factory SlackConnectionData({
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

  SlackConnectionData._();

  factory SlackConnectionData.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SlackConnectionData.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SlackConnectionData',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'webhookUrl')
    ..aOS(2, _omitFieldNames ? '' : 'workspaceName')
    ..aOS(3, _omitFieldNames ? '' : 'channelName')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SlackConnectionData clone() => SlackConnectionData()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SlackConnectionData copyWith(void Function(SlackConnectionData) updates) =>
      super.copyWith((message) => updates(message as SlackConnectionData))
          as SlackConnectionData;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SlackConnectionData create() => SlackConnectionData._();
  @$core.override
  SlackConnectionData createEmptyInstance() => create();
  static $pb.PbList<SlackConnectionData> createRepeated() =>
      $pb.PbList<SlackConnectionData>();
  @$core.pragma('dart2js:noInline')
  static SlackConnectionData getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SlackConnectionData>(create);
  static SlackConnectionData? _defaultInstance;

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

class ConnectNotificationChannelResponse extends $pb.GeneratedMessage {
  factory ConnectNotificationChannelResponse({
    NotificationChannel? channel,
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
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOM<NotificationChannel>(1, _omitFieldNames ? '' : 'channel',
        subBuilder: NotificationChannel.create)
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
  NotificationChannel get channel => $_getN(0);
  @$pb.TagNumber(1)
  set channel(NotificationChannel value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasChannel() => $_has(0);
  @$pb.TagNumber(1)
  void clearChannel() => $_clearField(1);
  @$pb.TagNumber(1)
  NotificationChannel ensureChannel() => $_ensure(0);

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

/// Disconnect notification channel
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
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
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
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
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

/// Get notification channels
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
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
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
    $core.Iterable<NotificationChannel>? channels,
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
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..pc<NotificationChannel>(
        1, _omitFieldNames ? '' : 'channels', $pb.PbFieldType.PM,
        subBuilder: NotificationChannel.create)
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
  $pb.PbList<NotificationChannel> get channels => $_getList(0);
}

/// Update notification channel
class UpdateNotificationChannelRequest extends $pb.GeneratedMessage {
  factory UpdateNotificationChannelRequest({
    $core.String? channelId,
    $core.String? channelName,
    $core.Iterable<NotificationEventType>? enabledEvents,
    NotificationPreferences? preferences,
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
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'channelId')
    ..aOS(2, _omitFieldNames ? '' : 'channelName')
    ..pc<NotificationEventType>(
        3, _omitFieldNames ? '' : 'enabledEvents', $pb.PbFieldType.KE,
        valueOf: NotificationEventType.valueOf,
        enumValues: NotificationEventType.values,
        defaultEnumValue:
            NotificationEventType.NOTIFICATION_EVENT_TYPE_UNSPECIFIED)
    ..aOM<NotificationPreferences>(4, _omitFieldNames ? '' : 'preferences',
        subBuilder: NotificationPreferences.create)
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
  NotificationPreferences get preferences => $_getN(3);
  @$pb.TagNumber(4)
  set preferences(NotificationPreferences value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasPreferences() => $_has(3);
  @$pb.TagNumber(4)
  void clearPreferences() => $_clearField(4);
  @$pb.TagNumber(4)
  NotificationPreferences ensurePreferences() => $_ensure(3);

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
    NotificationChannel? channel,
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
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOM<NotificationChannel>(1, _omitFieldNames ? '' : 'channel',
        subBuilder: NotificationChannel.create)
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
  NotificationChannel get channel => $_getN(0);
  @$pb.TagNumber(1)
  set channel(NotificationChannel value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasChannel() => $_has(0);
  @$pb.TagNumber(1)
  void clearChannel() => $_clearField(1);
  @$pb.TagNumber(1)
  NotificationChannel ensureChannel() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);
}

/// Test notification channel
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
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
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
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
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

/// Get Telegram bot info
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
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
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
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
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

/// Verify Telegram channel
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
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
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
    NotificationChannel? channel,
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
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOM<NotificationChannel>(2, _omitFieldNames ? '' : 'channel',
        subBuilder: NotificationChannel.create)
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
  NotificationChannel get channel => $_getN(1);
  @$pb.TagNumber(2)
  set channel(NotificationChannel value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasChannel() => $_has(1);
  @$pb.TagNumber(2)
  void clearChannel() => $_clearField(2);
  @$pb.TagNumber(2)
  NotificationChannel ensureChannel() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => $_clearField(3);
}

/// Get notification history
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
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
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
    $core.Iterable<NotificationDelivery>? deliveries,
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
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..pc<NotificationDelivery>(
        1, _omitFieldNames ? '' : 'deliveries', $pb.PbFieldType.PM,
        subBuilder: NotificationDelivery.create)
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
  $pb.PbList<NotificationDelivery> get deliveries => $_getList(0);

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
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
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
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
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
    Crowdfund? crowdfund,
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
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'rank', $pb.PbFieldType.O3)
    ..aOM<Crowdfund>(2, _omitFieldNames ? '' : 'crowdfund',
        subBuilder: Crowdfund.create)
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
  Crowdfund get crowdfund => $_getN(1);
  @$pb.TagNumber(2)
  set crowdfund(Crowdfund value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasCrowdfund() => $_has(1);
  @$pb.TagNumber(2)
  void clearCrowdfund() => $_clearField(2);
  @$pb.TagNumber(2)
  Crowdfund ensureCrowdfund() => $_ensure(1);
}

/// MyCover Customer
class MyCoverCustomer extends $pb.GeneratedMessage {
  factory MyCoverCustomer({
    $core.String? id,
    $core.String? firstName,
    $core.String? lastName,
    $core.String? email,
    $core.String? phoneNumber,
    $core.String? gender,
    $core.String? dateOfBirth,
    $core.String? createdAt,
    $core.String? updatedAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (firstName != null) result.firstName = firstName;
    if (lastName != null) result.lastName = lastName;
    if (email != null) result.email = email;
    if (phoneNumber != null) result.phoneNumber = phoneNumber;
    if (gender != null) result.gender = gender;
    if (dateOfBirth != null) result.dateOfBirth = dateOfBirth;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    return result;
  }

  MyCoverCustomer._();

  factory MyCoverCustomer.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MyCoverCustomer.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MyCoverCustomer',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'firstName')
    ..aOS(3, _omitFieldNames ? '' : 'lastName')
    ..aOS(4, _omitFieldNames ? '' : 'email')
    ..aOS(5, _omitFieldNames ? '' : 'phoneNumber')
    ..aOS(6, _omitFieldNames ? '' : 'gender')
    ..aOS(7, _omitFieldNames ? '' : 'dateOfBirth')
    ..aOS(8, _omitFieldNames ? '' : 'createdAt')
    ..aOS(9, _omitFieldNames ? '' : 'updatedAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MyCoverCustomer clone() => MyCoverCustomer()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MyCoverCustomer copyWith(void Function(MyCoverCustomer) updates) =>
      super.copyWith((message) => updates(message as MyCoverCustomer))
          as MyCoverCustomer;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MyCoverCustomer create() => MyCoverCustomer._();
  @$core.override
  MyCoverCustomer createEmptyInstance() => create();
  static $pb.PbList<MyCoverCustomer> createRepeated() =>
      $pb.PbList<MyCoverCustomer>();
  @$core.pragma('dart2js:noInline')
  static MyCoverCustomer getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MyCoverCustomer>(create);
  static MyCoverCustomer? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get firstName => $_getSZ(1);
  @$pb.TagNumber(2)
  set firstName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasFirstName() => $_has(1);
  @$pb.TagNumber(2)
  void clearFirstName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get lastName => $_getSZ(2);
  @$pb.TagNumber(3)
  set lastName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasLastName() => $_has(2);
  @$pb.TagNumber(3)
  void clearLastName() => $_clearField(3);

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
  $core.String get gender => $_getSZ(5);
  @$pb.TagNumber(6)
  set gender($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasGender() => $_has(5);
  @$pb.TagNumber(6)
  void clearGender() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get dateOfBirth => $_getSZ(6);
  @$pb.TagNumber(7)
  set dateOfBirth($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasDateOfBirth() => $_has(6);
  @$pb.TagNumber(7)
  void clearDateOfBirth() => $_clearField(7);

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

/// MyCover Purchase
class MyCoverPurchase extends $pb.GeneratedMessage {
  factory MyCoverPurchase({
    $core.String? id,
    $core.String? appMode,
    $core.bool? isRenewal,
    $core.String? amount,
    $core.String? customerId,
    $core.String? distributorId,
    $core.String? paymentChannel,
    $core.String? paymentOption,
    $core.String? policyId,
    $core.String? productCategoryId,
    $core.String? productId,
    $core.String? providerId,
    $core.String? countryId,
    $core.String? currencyId,
    $core.String? createdAt,
    $core.String? updatedAt,
    $core.String? customerName,
    $core.String? customerEmail,
    $core.String? customerPhone,
    $core.String? policyNumber,
    $core.String? certificateUrl,
    $core.bool? policyIsActive,
    $core.String? policyAmount,
    $core.String? providerName,
    $core.String? productName,
    $core.String? productCategoryName,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (appMode != null) result.appMode = appMode;
    if (isRenewal != null) result.isRenewal = isRenewal;
    if (amount != null) result.amount = amount;
    if (customerId != null) result.customerId = customerId;
    if (distributorId != null) result.distributorId = distributorId;
    if (paymentChannel != null) result.paymentChannel = paymentChannel;
    if (paymentOption != null) result.paymentOption = paymentOption;
    if (policyId != null) result.policyId = policyId;
    if (productCategoryId != null) result.productCategoryId = productCategoryId;
    if (productId != null) result.productId = productId;
    if (providerId != null) result.providerId = providerId;
    if (countryId != null) result.countryId = countryId;
    if (currencyId != null) result.currencyId = currencyId;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    if (customerName != null) result.customerName = customerName;
    if (customerEmail != null) result.customerEmail = customerEmail;
    if (customerPhone != null) result.customerPhone = customerPhone;
    if (policyNumber != null) result.policyNumber = policyNumber;
    if (certificateUrl != null) result.certificateUrl = certificateUrl;
    if (policyIsActive != null) result.policyIsActive = policyIsActive;
    if (policyAmount != null) result.policyAmount = policyAmount;
    if (providerName != null) result.providerName = providerName;
    if (productName != null) result.productName = productName;
    if (productCategoryName != null)
      result.productCategoryName = productCategoryName;
    return result;
  }

  MyCoverPurchase._();

  factory MyCoverPurchase.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MyCoverPurchase.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MyCoverPurchase',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'appMode')
    ..aOB(3, _omitFieldNames ? '' : 'isRenewal')
    ..aOS(4, _omitFieldNames ? '' : 'amount')
    ..aOS(5, _omitFieldNames ? '' : 'customerId')
    ..aOS(6, _omitFieldNames ? '' : 'distributorId')
    ..aOS(7, _omitFieldNames ? '' : 'paymentChannel')
    ..aOS(8, _omitFieldNames ? '' : 'paymentOption')
    ..aOS(9, _omitFieldNames ? '' : 'policyId')
    ..aOS(10, _omitFieldNames ? '' : 'productCategoryId')
    ..aOS(11, _omitFieldNames ? '' : 'productId')
    ..aOS(12, _omitFieldNames ? '' : 'providerId')
    ..aOS(13, _omitFieldNames ? '' : 'countryId')
    ..aOS(14, _omitFieldNames ? '' : 'currencyId')
    ..aOS(15, _omitFieldNames ? '' : 'createdAt')
    ..aOS(16, _omitFieldNames ? '' : 'updatedAt')
    ..aOS(17, _omitFieldNames ? '' : 'customerName')
    ..aOS(18, _omitFieldNames ? '' : 'customerEmail')
    ..aOS(19, _omitFieldNames ? '' : 'customerPhone')
    ..aOS(20, _omitFieldNames ? '' : 'policyNumber')
    ..aOS(21, _omitFieldNames ? '' : 'certificateUrl')
    ..aOB(22, _omitFieldNames ? '' : 'policyIsActive')
    ..aOS(23, _omitFieldNames ? '' : 'policyAmount')
    ..aOS(24, _omitFieldNames ? '' : 'providerName')
    ..aOS(25, _omitFieldNames ? '' : 'productName')
    ..aOS(26, _omitFieldNames ? '' : 'productCategoryName')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MyCoverPurchase clone() => MyCoverPurchase()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MyCoverPurchase copyWith(void Function(MyCoverPurchase) updates) =>
      super.copyWith((message) => updates(message as MyCoverPurchase))
          as MyCoverPurchase;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MyCoverPurchase create() => MyCoverPurchase._();
  @$core.override
  MyCoverPurchase createEmptyInstance() => create();
  static $pb.PbList<MyCoverPurchase> createRepeated() =>
      $pb.PbList<MyCoverPurchase>();
  @$core.pragma('dart2js:noInline')
  static MyCoverPurchase getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MyCoverPurchase>(create);
  static MyCoverPurchase? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get appMode => $_getSZ(1);
  @$pb.TagNumber(2)
  set appMode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAppMode() => $_has(1);
  @$pb.TagNumber(2)
  void clearAppMode() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.bool get isRenewal => $_getBF(2);
  @$pb.TagNumber(3)
  set isRenewal($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasIsRenewal() => $_has(2);
  @$pb.TagNumber(3)
  void clearIsRenewal() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get amount => $_getSZ(3);
  @$pb.TagNumber(4)
  set amount($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearAmount() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get customerId => $_getSZ(4);
  @$pb.TagNumber(5)
  set customerId($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasCustomerId() => $_has(4);
  @$pb.TagNumber(5)
  void clearCustomerId() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get distributorId => $_getSZ(5);
  @$pb.TagNumber(6)
  set distributorId($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasDistributorId() => $_has(5);
  @$pb.TagNumber(6)
  void clearDistributorId() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get paymentChannel => $_getSZ(6);
  @$pb.TagNumber(7)
  set paymentChannel($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasPaymentChannel() => $_has(6);
  @$pb.TagNumber(7)
  void clearPaymentChannel() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get paymentOption => $_getSZ(7);
  @$pb.TagNumber(8)
  set paymentOption($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasPaymentOption() => $_has(7);
  @$pb.TagNumber(8)
  void clearPaymentOption() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get policyId => $_getSZ(8);
  @$pb.TagNumber(9)
  set policyId($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasPolicyId() => $_has(8);
  @$pb.TagNumber(9)
  void clearPolicyId() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get productCategoryId => $_getSZ(9);
  @$pb.TagNumber(10)
  set productCategoryId($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasProductCategoryId() => $_has(9);
  @$pb.TagNumber(10)
  void clearProductCategoryId() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get productId => $_getSZ(10);
  @$pb.TagNumber(11)
  set productId($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasProductId() => $_has(10);
  @$pb.TagNumber(11)
  void clearProductId() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get providerId => $_getSZ(11);
  @$pb.TagNumber(12)
  set providerId($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasProviderId() => $_has(11);
  @$pb.TagNumber(12)
  void clearProviderId() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.String get countryId => $_getSZ(12);
  @$pb.TagNumber(13)
  set countryId($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasCountryId() => $_has(12);
  @$pb.TagNumber(13)
  void clearCountryId() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.String get currencyId => $_getSZ(13);
  @$pb.TagNumber(14)
  set currencyId($core.String value) => $_setString(13, value);
  @$pb.TagNumber(14)
  $core.bool hasCurrencyId() => $_has(13);
  @$pb.TagNumber(14)
  void clearCurrencyId() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.String get createdAt => $_getSZ(14);
  @$pb.TagNumber(15)
  set createdAt($core.String value) => $_setString(14, value);
  @$pb.TagNumber(15)
  $core.bool hasCreatedAt() => $_has(14);
  @$pb.TagNumber(15)
  void clearCreatedAt() => $_clearField(15);

  @$pb.TagNumber(16)
  $core.String get updatedAt => $_getSZ(15);
  @$pb.TagNumber(16)
  set updatedAt($core.String value) => $_setString(15, value);
  @$pb.TagNumber(16)
  $core.bool hasUpdatedAt() => $_has(15);
  @$pb.TagNumber(16)
  void clearUpdatedAt() => $_clearField(16);

  /// Nested info
  @$pb.TagNumber(17)
  $core.String get customerName => $_getSZ(16);
  @$pb.TagNumber(17)
  set customerName($core.String value) => $_setString(16, value);
  @$pb.TagNumber(17)
  $core.bool hasCustomerName() => $_has(16);
  @$pb.TagNumber(17)
  void clearCustomerName() => $_clearField(17);

  @$pb.TagNumber(18)
  $core.String get customerEmail => $_getSZ(17);
  @$pb.TagNumber(18)
  set customerEmail($core.String value) => $_setString(17, value);
  @$pb.TagNumber(18)
  $core.bool hasCustomerEmail() => $_has(17);
  @$pb.TagNumber(18)
  void clearCustomerEmail() => $_clearField(18);

  @$pb.TagNumber(19)
  $core.String get customerPhone => $_getSZ(18);
  @$pb.TagNumber(19)
  set customerPhone($core.String value) => $_setString(18, value);
  @$pb.TagNumber(19)
  $core.bool hasCustomerPhone() => $_has(18);
  @$pb.TagNumber(19)
  void clearCustomerPhone() => $_clearField(19);

  @$pb.TagNumber(20)
  $core.String get policyNumber => $_getSZ(19);
  @$pb.TagNumber(20)
  set policyNumber($core.String value) => $_setString(19, value);
  @$pb.TagNumber(20)
  $core.bool hasPolicyNumber() => $_has(19);
  @$pb.TagNumber(20)
  void clearPolicyNumber() => $_clearField(20);

  @$pb.TagNumber(21)
  $core.String get certificateUrl => $_getSZ(20);
  @$pb.TagNumber(21)
  set certificateUrl($core.String value) => $_setString(20, value);
  @$pb.TagNumber(21)
  $core.bool hasCertificateUrl() => $_has(20);
  @$pb.TagNumber(21)
  void clearCertificateUrl() => $_clearField(21);

  @$pb.TagNumber(22)
  $core.bool get policyIsActive => $_getBF(21);
  @$pb.TagNumber(22)
  set policyIsActive($core.bool value) => $_setBool(21, value);
  @$pb.TagNumber(22)
  $core.bool hasPolicyIsActive() => $_has(21);
  @$pb.TagNumber(22)
  void clearPolicyIsActive() => $_clearField(22);

  @$pb.TagNumber(23)
  $core.String get policyAmount => $_getSZ(22);
  @$pb.TagNumber(23)
  set policyAmount($core.String value) => $_setString(22, value);
  @$pb.TagNumber(23)
  $core.bool hasPolicyAmount() => $_has(22);
  @$pb.TagNumber(23)
  void clearPolicyAmount() => $_clearField(23);

  @$pb.TagNumber(24)
  $core.String get providerName => $_getSZ(23);
  @$pb.TagNumber(24)
  set providerName($core.String value) => $_setString(23, value);
  @$pb.TagNumber(24)
  $core.bool hasProviderName() => $_has(23);
  @$pb.TagNumber(24)
  void clearProviderName() => $_clearField(24);

  @$pb.TagNumber(25)
  $core.String get productName => $_getSZ(24);
  @$pb.TagNumber(25)
  set productName($core.String value) => $_setString(24, value);
  @$pb.TagNumber(25)
  $core.bool hasProductName() => $_has(24);
  @$pb.TagNumber(25)
  void clearProductName() => $_clearField(25);

  @$pb.TagNumber(26)
  $core.String get productCategoryName => $_getSZ(25);
  @$pb.TagNumber(26)
  set productCategoryName($core.String value) => $_setString(25, value);
  @$pb.TagNumber(26)
  $core.bool hasProductCategoryName() => $_has(25);
  @$pb.TagNumber(26)
  void clearProductCategoryName() => $_clearField(26);
}

/// MyCover Claim (from provider API)
class MyCoverClaim extends $pb.GeneratedMessage {
  factory MyCoverClaim({
    $core.String? id,
    $core.String? status,
    $core.String? type,
    $core.double? amount,
    $core.String? description,
    $core.String? policyId,
    $core.String? customerId,
    $core.String? claimNumber,
    $core.Iterable<$core.String>? documents,
    $core.String? rejectionReason,
    $core.double? approvedAmount,
    $core.String? createdAt,
    $core.String? updatedAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (status != null) result.status = status;
    if (type != null) result.type = type;
    if (amount != null) result.amount = amount;
    if (description != null) result.description = description;
    if (policyId != null) result.policyId = policyId;
    if (customerId != null) result.customerId = customerId;
    if (claimNumber != null) result.claimNumber = claimNumber;
    if (documents != null) result.documents.addAll(documents);
    if (rejectionReason != null) result.rejectionReason = rejectionReason;
    if (approvedAmount != null) result.approvedAmount = approvedAmount;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    return result;
  }

  MyCoverClaim._();

  factory MyCoverClaim.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MyCoverClaim.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MyCoverClaim',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'status')
    ..aOS(3, _omitFieldNames ? '' : 'type')
    ..a<$core.double>(4, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(5, _omitFieldNames ? '' : 'description')
    ..aOS(6, _omitFieldNames ? '' : 'policyId')
    ..aOS(7, _omitFieldNames ? '' : 'customerId')
    ..aOS(8, _omitFieldNames ? '' : 'claimNumber')
    ..pPS(9, _omitFieldNames ? '' : 'documents')
    ..aOS(10, _omitFieldNames ? '' : 'rejectionReason')
    ..a<$core.double>(
        11, _omitFieldNames ? '' : 'approvedAmount', $pb.PbFieldType.OD)
    ..aOS(12, _omitFieldNames ? '' : 'createdAt')
    ..aOS(13, _omitFieldNames ? '' : 'updatedAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MyCoverClaim clone() => MyCoverClaim()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MyCoverClaim copyWith(void Function(MyCoverClaim) updates) =>
      super.copyWith((message) => updates(message as MyCoverClaim))
          as MyCoverClaim;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MyCoverClaim create() => MyCoverClaim._();
  @$core.override
  MyCoverClaim createEmptyInstance() => create();
  static $pb.PbList<MyCoverClaim> createRepeated() =>
      $pb.PbList<MyCoverClaim>();
  @$core.pragma('dart2js:noInline')
  static MyCoverClaim getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MyCoverClaim>(create);
  static MyCoverClaim? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get status => $_getSZ(1);
  @$pb.TagNumber(2)
  set status($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get type => $_getSZ(2);
  @$pb.TagNumber(3)
  set type($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasType() => $_has(2);
  @$pb.TagNumber(3)
  void clearType() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get amount => $_getN(3);
  @$pb.TagNumber(4)
  set amount($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearAmount() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get description => $_getSZ(4);
  @$pb.TagNumber(5)
  set description($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasDescription() => $_has(4);
  @$pb.TagNumber(5)
  void clearDescription() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get policyId => $_getSZ(5);
  @$pb.TagNumber(6)
  set policyId($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasPolicyId() => $_has(5);
  @$pb.TagNumber(6)
  void clearPolicyId() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get customerId => $_getSZ(6);
  @$pb.TagNumber(7)
  set customerId($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasCustomerId() => $_has(6);
  @$pb.TagNumber(7)
  void clearCustomerId() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get claimNumber => $_getSZ(7);
  @$pb.TagNumber(8)
  set claimNumber($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasClaimNumber() => $_has(7);
  @$pb.TagNumber(8)
  void clearClaimNumber() => $_clearField(8);

  @$pb.TagNumber(9)
  $pb.PbList<$core.String> get documents => $_getList(8);

  @$pb.TagNumber(10)
  $core.String get rejectionReason => $_getSZ(9);
  @$pb.TagNumber(10)
  set rejectionReason($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasRejectionReason() => $_has(9);
  @$pb.TagNumber(10)
  void clearRejectionReason() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.double get approvedAmount => $_getN(10);
  @$pb.TagNumber(11)
  set approvedAmount($core.double value) => $_setDouble(10, value);
  @$pb.TagNumber(11)
  $core.bool hasApprovedAmount() => $_has(10);
  @$pb.TagNumber(11)
  void clearApprovedAmount() => $_clearField(11);

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

/// Customers
class GetMyCoverCustomersRequest extends $pb.GeneratedMessage {
  factory GetMyCoverCustomersRequest({
    $core.int? page,
    $core.int? limit,
  }) {
    final result = create();
    if (page != null) result.page = page;
    if (limit != null) result.limit = limit;
    return result;
  }

  GetMyCoverCustomersRequest._();

  factory GetMyCoverCustomersRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMyCoverCustomersRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMyCoverCustomersRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyCoverCustomersRequest clone() =>
      GetMyCoverCustomersRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyCoverCustomersRequest copyWith(
          void Function(GetMyCoverCustomersRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetMyCoverCustomersRequest))
          as GetMyCoverCustomersRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMyCoverCustomersRequest create() => GetMyCoverCustomersRequest._();
  @$core.override
  GetMyCoverCustomersRequest createEmptyInstance() => create();
  static $pb.PbList<GetMyCoverCustomersRequest> createRepeated() =>
      $pb.PbList<GetMyCoverCustomersRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMyCoverCustomersRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetMyCoverCustomersRequest>(create);
  static GetMyCoverCustomersRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get page => $_getIZ(0);
  @$pb.TagNumber(1)
  set page($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearPage() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get limit => $_getIZ(1);
  @$pb.TagNumber(2)
  set limit($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearLimit() => $_clearField(2);
}

class GetMyCoverCustomersResponse extends $pb.GeneratedMessage {
  factory GetMyCoverCustomersResponse({
    $core.Iterable<MyCoverCustomer>? customers,
    $core.int? total,
  }) {
    final result = create();
    if (customers != null) result.customers.addAll(customers);
    if (total != null) result.total = total;
    return result;
  }

  GetMyCoverCustomersResponse._();

  factory GetMyCoverCustomersResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMyCoverCustomersResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMyCoverCustomersResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..pc<MyCoverCustomer>(
        1, _omitFieldNames ? '' : 'customers', $pb.PbFieldType.PM,
        subBuilder: MyCoverCustomer.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyCoverCustomersResponse clone() =>
      GetMyCoverCustomersResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyCoverCustomersResponse copyWith(
          void Function(GetMyCoverCustomersResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetMyCoverCustomersResponse))
          as GetMyCoverCustomersResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMyCoverCustomersResponse create() =>
      GetMyCoverCustomersResponse._();
  @$core.override
  GetMyCoverCustomersResponse createEmptyInstance() => create();
  static $pb.PbList<GetMyCoverCustomersResponse> createRepeated() =>
      $pb.PbList<GetMyCoverCustomersResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMyCoverCustomersResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetMyCoverCustomersResponse>(create);
  static GetMyCoverCustomersResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<MyCoverCustomer> get customers => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);
}

class GetMyCoverCustomerByIdRequest extends $pb.GeneratedMessage {
  factory GetMyCoverCustomerByIdRequest({
    $core.String? customerId,
  }) {
    final result = create();
    if (customerId != null) result.customerId = customerId;
    return result;
  }

  GetMyCoverCustomerByIdRequest._();

  factory GetMyCoverCustomerByIdRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMyCoverCustomerByIdRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMyCoverCustomerByIdRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'customerId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyCoverCustomerByIdRequest clone() =>
      GetMyCoverCustomerByIdRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyCoverCustomerByIdRequest copyWith(
          void Function(GetMyCoverCustomerByIdRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetMyCoverCustomerByIdRequest))
          as GetMyCoverCustomerByIdRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMyCoverCustomerByIdRequest create() =>
      GetMyCoverCustomerByIdRequest._();
  @$core.override
  GetMyCoverCustomerByIdRequest createEmptyInstance() => create();
  static $pb.PbList<GetMyCoverCustomerByIdRequest> createRepeated() =>
      $pb.PbList<GetMyCoverCustomerByIdRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMyCoverCustomerByIdRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetMyCoverCustomerByIdRequest>(create);
  static GetMyCoverCustomerByIdRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get customerId => $_getSZ(0);
  @$pb.TagNumber(1)
  set customerId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCustomerId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCustomerId() => $_clearField(1);
}

class GetMyCoverCustomerByIdResponse extends $pb.GeneratedMessage {
  factory GetMyCoverCustomerByIdResponse({
    MyCoverCustomer? customer,
  }) {
    final result = create();
    if (customer != null) result.customer = customer;
    return result;
  }

  GetMyCoverCustomerByIdResponse._();

  factory GetMyCoverCustomerByIdResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMyCoverCustomerByIdResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMyCoverCustomerByIdResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOM<MyCoverCustomer>(1, _omitFieldNames ? '' : 'customer',
        subBuilder: MyCoverCustomer.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyCoverCustomerByIdResponse clone() =>
      GetMyCoverCustomerByIdResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyCoverCustomerByIdResponse copyWith(
          void Function(GetMyCoverCustomerByIdResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetMyCoverCustomerByIdResponse))
          as GetMyCoverCustomerByIdResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMyCoverCustomerByIdResponse create() =>
      GetMyCoverCustomerByIdResponse._();
  @$core.override
  GetMyCoverCustomerByIdResponse createEmptyInstance() => create();
  static $pb.PbList<GetMyCoverCustomerByIdResponse> createRepeated() =>
      $pb.PbList<GetMyCoverCustomerByIdResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMyCoverCustomerByIdResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetMyCoverCustomerByIdResponse>(create);
  static GetMyCoverCustomerByIdResponse? _defaultInstance;

  @$pb.TagNumber(1)
  MyCoverCustomer get customer => $_getN(0);
  @$pb.TagNumber(1)
  set customer(MyCoverCustomer value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasCustomer() => $_has(0);
  @$pb.TagNumber(1)
  void clearCustomer() => $_clearField(1);
  @$pb.TagNumber(1)
  MyCoverCustomer ensureCustomer() => $_ensure(0);
}

class GetMyCoverCustomerPoliciesRequest extends $pb.GeneratedMessage {
  factory GetMyCoverCustomerPoliciesRequest({
    $core.String? customerId,
    $core.int? page,
    $core.int? limit,
  }) {
    final result = create();
    if (customerId != null) result.customerId = customerId;
    if (page != null) result.page = page;
    if (limit != null) result.limit = limit;
    return result;
  }

  GetMyCoverCustomerPoliciesRequest._();

  factory GetMyCoverCustomerPoliciesRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMyCoverCustomerPoliciesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMyCoverCustomerPoliciesRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'customerId')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyCoverCustomerPoliciesRequest clone() =>
      GetMyCoverCustomerPoliciesRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyCoverCustomerPoliciesRequest copyWith(
          void Function(GetMyCoverCustomerPoliciesRequest) updates) =>
      super.copyWith((message) =>
              updates(message as GetMyCoverCustomerPoliciesRequest))
          as GetMyCoverCustomerPoliciesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMyCoverCustomerPoliciesRequest create() =>
      GetMyCoverCustomerPoliciesRequest._();
  @$core.override
  GetMyCoverCustomerPoliciesRequest createEmptyInstance() => create();
  static $pb.PbList<GetMyCoverCustomerPoliciesRequest> createRepeated() =>
      $pb.PbList<GetMyCoverCustomerPoliciesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMyCoverCustomerPoliciesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetMyCoverCustomerPoliciesRequest>(
          create);
  static GetMyCoverCustomerPoliciesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get customerId => $_getSZ(0);
  @$pb.TagNumber(1)
  set customerId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCustomerId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCustomerId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get page => $_getIZ(1);
  @$pb.TagNumber(2)
  set page($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPage() => $_has(1);
  @$pb.TagNumber(2)
  void clearPage() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get limit => $_getIZ(2);
  @$pb.TagNumber(3)
  set limit($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasLimit() => $_has(2);
  @$pb.TagNumber(3)
  void clearLimit() => $_clearField(3);
}

class GetMyCoverCustomerPoliciesResponse extends $pb.GeneratedMessage {
  factory GetMyCoverCustomerPoliciesResponse({
    $core.Iterable<InsurancePolicyDetail>? policies,
    $core.int? total,
  }) {
    final result = create();
    if (policies != null) result.policies.addAll(policies);
    if (total != null) result.total = total;
    return result;
  }

  GetMyCoverCustomerPoliciesResponse._();

  factory GetMyCoverCustomerPoliciesResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMyCoverCustomerPoliciesResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMyCoverCustomerPoliciesResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..pc<InsurancePolicyDetail>(
        1, _omitFieldNames ? '' : 'policies', $pb.PbFieldType.PM,
        subBuilder: InsurancePolicyDetail.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyCoverCustomerPoliciesResponse clone() =>
      GetMyCoverCustomerPoliciesResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyCoverCustomerPoliciesResponse copyWith(
          void Function(GetMyCoverCustomerPoliciesResponse) updates) =>
      super.copyWith((message) =>
              updates(message as GetMyCoverCustomerPoliciesResponse))
          as GetMyCoverCustomerPoliciesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMyCoverCustomerPoliciesResponse create() =>
      GetMyCoverCustomerPoliciesResponse._();
  @$core.override
  GetMyCoverCustomerPoliciesResponse createEmptyInstance() => create();
  static $pb.PbList<GetMyCoverCustomerPoliciesResponse> createRepeated() =>
      $pb.PbList<GetMyCoverCustomerPoliciesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMyCoverCustomerPoliciesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetMyCoverCustomerPoliciesResponse>(
          create);
  static GetMyCoverCustomerPoliciesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<InsurancePolicyDetail> get policies => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);
}

class GetMyCoverCustomerPurchasesRequest extends $pb.GeneratedMessage {
  factory GetMyCoverCustomerPurchasesRequest({
    $core.String? customerId,
    $core.int? page,
    $core.int? limit,
  }) {
    final result = create();
    if (customerId != null) result.customerId = customerId;
    if (page != null) result.page = page;
    if (limit != null) result.limit = limit;
    return result;
  }

  GetMyCoverCustomerPurchasesRequest._();

  factory GetMyCoverCustomerPurchasesRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMyCoverCustomerPurchasesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMyCoverCustomerPurchasesRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'customerId')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyCoverCustomerPurchasesRequest clone() =>
      GetMyCoverCustomerPurchasesRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyCoverCustomerPurchasesRequest copyWith(
          void Function(GetMyCoverCustomerPurchasesRequest) updates) =>
      super.copyWith((message) =>
              updates(message as GetMyCoverCustomerPurchasesRequest))
          as GetMyCoverCustomerPurchasesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMyCoverCustomerPurchasesRequest create() =>
      GetMyCoverCustomerPurchasesRequest._();
  @$core.override
  GetMyCoverCustomerPurchasesRequest createEmptyInstance() => create();
  static $pb.PbList<GetMyCoverCustomerPurchasesRequest> createRepeated() =>
      $pb.PbList<GetMyCoverCustomerPurchasesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMyCoverCustomerPurchasesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetMyCoverCustomerPurchasesRequest>(
          create);
  static GetMyCoverCustomerPurchasesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get customerId => $_getSZ(0);
  @$pb.TagNumber(1)
  set customerId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCustomerId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCustomerId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get page => $_getIZ(1);
  @$pb.TagNumber(2)
  set page($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPage() => $_has(1);
  @$pb.TagNumber(2)
  void clearPage() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get limit => $_getIZ(2);
  @$pb.TagNumber(3)
  set limit($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasLimit() => $_has(2);
  @$pb.TagNumber(3)
  void clearLimit() => $_clearField(3);
}

class GetMyCoverCustomerPurchasesResponse extends $pb.GeneratedMessage {
  factory GetMyCoverCustomerPurchasesResponse({
    $core.Iterable<MyCoverPurchase>? purchases,
    $core.int? total,
  }) {
    final result = create();
    if (purchases != null) result.purchases.addAll(purchases);
    if (total != null) result.total = total;
    return result;
  }

  GetMyCoverCustomerPurchasesResponse._();

  factory GetMyCoverCustomerPurchasesResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMyCoverCustomerPurchasesResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMyCoverCustomerPurchasesResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..pc<MyCoverPurchase>(
        1, _omitFieldNames ? '' : 'purchases', $pb.PbFieldType.PM,
        subBuilder: MyCoverPurchase.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyCoverCustomerPurchasesResponse clone() =>
      GetMyCoverCustomerPurchasesResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyCoverCustomerPurchasesResponse copyWith(
          void Function(GetMyCoverCustomerPurchasesResponse) updates) =>
      super.copyWith((message) =>
              updates(message as GetMyCoverCustomerPurchasesResponse))
          as GetMyCoverCustomerPurchasesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMyCoverCustomerPurchasesResponse create() =>
      GetMyCoverCustomerPurchasesResponse._();
  @$core.override
  GetMyCoverCustomerPurchasesResponse createEmptyInstance() => create();
  static $pb.PbList<GetMyCoverCustomerPurchasesResponse> createRepeated() =>
      $pb.PbList<GetMyCoverCustomerPurchasesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMyCoverCustomerPurchasesResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          GetMyCoverCustomerPurchasesResponse>(create);
  static GetMyCoverCustomerPurchasesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<MyCoverPurchase> get purchases => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);
}

/// Purchases
class GetMyCoverPurchasesRequest extends $pb.GeneratedMessage {
  factory GetMyCoverPurchasesRequest({
    $core.int? page,
    $core.int? limit,
  }) {
    final result = create();
    if (page != null) result.page = page;
    if (limit != null) result.limit = limit;
    return result;
  }

  GetMyCoverPurchasesRequest._();

  factory GetMyCoverPurchasesRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMyCoverPurchasesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMyCoverPurchasesRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyCoverPurchasesRequest clone() =>
      GetMyCoverPurchasesRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyCoverPurchasesRequest copyWith(
          void Function(GetMyCoverPurchasesRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetMyCoverPurchasesRequest))
          as GetMyCoverPurchasesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMyCoverPurchasesRequest create() => GetMyCoverPurchasesRequest._();
  @$core.override
  GetMyCoverPurchasesRequest createEmptyInstance() => create();
  static $pb.PbList<GetMyCoverPurchasesRequest> createRepeated() =>
      $pb.PbList<GetMyCoverPurchasesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMyCoverPurchasesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetMyCoverPurchasesRequest>(create);
  static GetMyCoverPurchasesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get page => $_getIZ(0);
  @$pb.TagNumber(1)
  set page($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearPage() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get limit => $_getIZ(1);
  @$pb.TagNumber(2)
  set limit($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearLimit() => $_clearField(2);
}

class GetMyCoverPurchasesResponse extends $pb.GeneratedMessage {
  factory GetMyCoverPurchasesResponse({
    $core.Iterable<MyCoverPurchase>? purchases,
    $core.int? total,
  }) {
    final result = create();
    if (purchases != null) result.purchases.addAll(purchases);
    if (total != null) result.total = total;
    return result;
  }

  GetMyCoverPurchasesResponse._();

  factory GetMyCoverPurchasesResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMyCoverPurchasesResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMyCoverPurchasesResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..pc<MyCoverPurchase>(
        1, _omitFieldNames ? '' : 'purchases', $pb.PbFieldType.PM,
        subBuilder: MyCoverPurchase.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyCoverPurchasesResponse clone() =>
      GetMyCoverPurchasesResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyCoverPurchasesResponse copyWith(
          void Function(GetMyCoverPurchasesResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetMyCoverPurchasesResponse))
          as GetMyCoverPurchasesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMyCoverPurchasesResponse create() =>
      GetMyCoverPurchasesResponse._();
  @$core.override
  GetMyCoverPurchasesResponse createEmptyInstance() => create();
  static $pb.PbList<GetMyCoverPurchasesResponse> createRepeated() =>
      $pb.PbList<GetMyCoverPurchasesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMyCoverPurchasesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetMyCoverPurchasesResponse>(create);
  static GetMyCoverPurchasesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<MyCoverPurchase> get purchases => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);
}

class GetMyCoverPurchaseByIdRequest extends $pb.GeneratedMessage {
  factory GetMyCoverPurchaseByIdRequest({
    $core.String? purchaseId,
  }) {
    final result = create();
    if (purchaseId != null) result.purchaseId = purchaseId;
    return result;
  }

  GetMyCoverPurchaseByIdRequest._();

  factory GetMyCoverPurchaseByIdRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMyCoverPurchaseByIdRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMyCoverPurchaseByIdRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'purchaseId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyCoverPurchaseByIdRequest clone() =>
      GetMyCoverPurchaseByIdRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyCoverPurchaseByIdRequest copyWith(
          void Function(GetMyCoverPurchaseByIdRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetMyCoverPurchaseByIdRequest))
          as GetMyCoverPurchaseByIdRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMyCoverPurchaseByIdRequest create() =>
      GetMyCoverPurchaseByIdRequest._();
  @$core.override
  GetMyCoverPurchaseByIdRequest createEmptyInstance() => create();
  static $pb.PbList<GetMyCoverPurchaseByIdRequest> createRepeated() =>
      $pb.PbList<GetMyCoverPurchaseByIdRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMyCoverPurchaseByIdRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetMyCoverPurchaseByIdRequest>(create);
  static GetMyCoverPurchaseByIdRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get purchaseId => $_getSZ(0);
  @$pb.TagNumber(1)
  set purchaseId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPurchaseId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPurchaseId() => $_clearField(1);
}

class GetMyCoverPurchaseByIdResponse extends $pb.GeneratedMessage {
  factory GetMyCoverPurchaseByIdResponse({
    MyCoverPurchase? purchase,
  }) {
    final result = create();
    if (purchase != null) result.purchase = purchase;
    return result;
  }

  GetMyCoverPurchaseByIdResponse._();

  factory GetMyCoverPurchaseByIdResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMyCoverPurchaseByIdResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMyCoverPurchaseByIdResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOM<MyCoverPurchase>(1, _omitFieldNames ? '' : 'purchase',
        subBuilder: MyCoverPurchase.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyCoverPurchaseByIdResponse clone() =>
      GetMyCoverPurchaseByIdResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyCoverPurchaseByIdResponse copyWith(
          void Function(GetMyCoverPurchaseByIdResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetMyCoverPurchaseByIdResponse))
          as GetMyCoverPurchaseByIdResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMyCoverPurchaseByIdResponse create() =>
      GetMyCoverPurchaseByIdResponse._();
  @$core.override
  GetMyCoverPurchaseByIdResponse createEmptyInstance() => create();
  static $pb.PbList<GetMyCoverPurchaseByIdResponse> createRepeated() =>
      $pb.PbList<GetMyCoverPurchaseByIdResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMyCoverPurchaseByIdResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetMyCoverPurchaseByIdResponse>(create);
  static GetMyCoverPurchaseByIdResponse? _defaultInstance;

  @$pb.TagNumber(1)
  MyCoverPurchase get purchase => $_getN(0);
  @$pb.TagNumber(1)
  set purchase(MyCoverPurchase value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasPurchase() => $_has(0);
  @$pb.TagNumber(1)
  void clearPurchase() => $_clearField(1);
  @$pb.TagNumber(1)
  MyCoverPurchase ensurePurchase() => $_ensure(0);
}

/// MyCover Claims (from provider)
class GetMyCoverClaimsRequest extends $pb.GeneratedMessage {
  factory GetMyCoverClaimsRequest({
    $core.String? status,
    $core.int? page,
    $core.int? limit,
  }) {
    final result = create();
    if (status != null) result.status = status;
    if (page != null) result.page = page;
    if (limit != null) result.limit = limit;
    return result;
  }

  GetMyCoverClaimsRequest._();

  factory GetMyCoverClaimsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMyCoverClaimsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMyCoverClaimsRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'status')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyCoverClaimsRequest clone() =>
      GetMyCoverClaimsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyCoverClaimsRequest copyWith(
          void Function(GetMyCoverClaimsRequest) updates) =>
      super.copyWith((message) => updates(message as GetMyCoverClaimsRequest))
          as GetMyCoverClaimsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMyCoverClaimsRequest create() => GetMyCoverClaimsRequest._();
  @$core.override
  GetMyCoverClaimsRequest createEmptyInstance() => create();
  static $pb.PbList<GetMyCoverClaimsRequest> createRepeated() =>
      $pb.PbList<GetMyCoverClaimsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMyCoverClaimsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetMyCoverClaimsRequest>(create);
  static GetMyCoverClaimsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get status => $_getSZ(0);
  @$pb.TagNumber(1)
  set status($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get page => $_getIZ(1);
  @$pb.TagNumber(2)
  set page($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPage() => $_has(1);
  @$pb.TagNumber(2)
  void clearPage() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get limit => $_getIZ(2);
  @$pb.TagNumber(3)
  set limit($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasLimit() => $_has(2);
  @$pb.TagNumber(3)
  void clearLimit() => $_clearField(3);
}

class GetMyCoverClaimsResponse extends $pb.GeneratedMessage {
  factory GetMyCoverClaimsResponse({
    $core.Iterable<MyCoverClaim>? claims,
    $core.int? total,
  }) {
    final result = create();
    if (claims != null) result.claims.addAll(claims);
    if (total != null) result.total = total;
    return result;
  }

  GetMyCoverClaimsResponse._();

  factory GetMyCoverClaimsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMyCoverClaimsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMyCoverClaimsResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..pc<MyCoverClaim>(1, _omitFieldNames ? '' : 'claims', $pb.PbFieldType.PM,
        subBuilder: MyCoverClaim.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyCoverClaimsResponse clone() =>
      GetMyCoverClaimsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyCoverClaimsResponse copyWith(
          void Function(GetMyCoverClaimsResponse) updates) =>
      super.copyWith((message) => updates(message as GetMyCoverClaimsResponse))
          as GetMyCoverClaimsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMyCoverClaimsResponse create() => GetMyCoverClaimsResponse._();
  @$core.override
  GetMyCoverClaimsResponse createEmptyInstance() => create();
  static $pb.PbList<GetMyCoverClaimsResponse> createRepeated() =>
      $pb.PbList<GetMyCoverClaimsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMyCoverClaimsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetMyCoverClaimsResponse>(create);
  static GetMyCoverClaimsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<MyCoverClaim> get claims => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);
}

class GetMyCoverClaimByIdRequest extends $pb.GeneratedMessage {
  factory GetMyCoverClaimByIdRequest({
    $core.String? claimId,
  }) {
    final result = create();
    if (claimId != null) result.claimId = claimId;
    return result;
  }

  GetMyCoverClaimByIdRequest._();

  factory GetMyCoverClaimByIdRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMyCoverClaimByIdRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMyCoverClaimByIdRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'claimId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyCoverClaimByIdRequest clone() =>
      GetMyCoverClaimByIdRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyCoverClaimByIdRequest copyWith(
          void Function(GetMyCoverClaimByIdRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetMyCoverClaimByIdRequest))
          as GetMyCoverClaimByIdRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMyCoverClaimByIdRequest create() => GetMyCoverClaimByIdRequest._();
  @$core.override
  GetMyCoverClaimByIdRequest createEmptyInstance() => create();
  static $pb.PbList<GetMyCoverClaimByIdRequest> createRepeated() =>
      $pb.PbList<GetMyCoverClaimByIdRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMyCoverClaimByIdRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetMyCoverClaimByIdRequest>(create);
  static GetMyCoverClaimByIdRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get claimId => $_getSZ(0);
  @$pb.TagNumber(1)
  set claimId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasClaimId() => $_has(0);
  @$pb.TagNumber(1)
  void clearClaimId() => $_clearField(1);
}

class GetMyCoverClaimByIdResponse extends $pb.GeneratedMessage {
  factory GetMyCoverClaimByIdResponse({
    MyCoverClaim? claim,
  }) {
    final result = create();
    if (claim != null) result.claim = claim;
    return result;
  }

  GetMyCoverClaimByIdResponse._();

  factory GetMyCoverClaimByIdResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMyCoverClaimByIdResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMyCoverClaimByIdResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOM<MyCoverClaim>(1, _omitFieldNames ? '' : 'claim',
        subBuilder: MyCoverClaim.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyCoverClaimByIdResponse clone() =>
      GetMyCoverClaimByIdResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyCoverClaimByIdResponse copyWith(
          void Function(GetMyCoverClaimByIdResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetMyCoverClaimByIdResponse))
          as GetMyCoverClaimByIdResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMyCoverClaimByIdResponse create() =>
      GetMyCoverClaimByIdResponse._();
  @$core.override
  GetMyCoverClaimByIdResponse createEmptyInstance() => create();
  static $pb.PbList<GetMyCoverClaimByIdResponse> createRepeated() =>
      $pb.PbList<GetMyCoverClaimByIdResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMyCoverClaimByIdResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetMyCoverClaimByIdResponse>(create);
  static GetMyCoverClaimByIdResponse? _defaultInstance;

  @$pb.TagNumber(1)
  MyCoverClaim get claim => $_getN(0);
  @$pb.TagNumber(1)
  set claim(MyCoverClaim value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasClaim() => $_has(0);
  @$pb.TagNumber(1)
  void clearClaim() => $_clearField(1);
  @$pb.TagNumber(1)
  MyCoverClaim ensureClaim() => $_ensure(0);
}

/// Credit-Life Claim
class FileCreditLifeClaimRequest extends $pb.GeneratedMessage {
  factory FileCreditLifeClaimRequest({
    $core.String? policyId,
    $core.String? claimType,
    $core.String? description,
    $core.double? amount,
    $core.Iterable<$core.String>? documents,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? additionalInfo,
  }) {
    final result = create();
    if (policyId != null) result.policyId = policyId;
    if (claimType != null) result.claimType = claimType;
    if (description != null) result.description = description;
    if (amount != null) result.amount = amount;
    if (documents != null) result.documents.addAll(documents);
    if (additionalInfo != null)
      result.additionalInfo.addEntries(additionalInfo);
    return result;
  }

  FileCreditLifeClaimRequest._();

  factory FileCreditLifeClaimRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FileCreditLifeClaimRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FileCreditLifeClaimRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'policyId')
    ..aOS(2, _omitFieldNames ? '' : 'claimType')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..a<$core.double>(4, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..pPS(5, _omitFieldNames ? '' : 'documents')
    ..m<$core.String, $core.String>(6, _omitFieldNames ? '' : 'additionalInfo',
        entryClassName: 'FileCreditLifeClaimRequest.AdditionalInfoEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('financialproducts'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FileCreditLifeClaimRequest clone() =>
      FileCreditLifeClaimRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FileCreditLifeClaimRequest copyWith(
          void Function(FileCreditLifeClaimRequest) updates) =>
      super.copyWith(
              (message) => updates(message as FileCreditLifeClaimRequest))
          as FileCreditLifeClaimRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FileCreditLifeClaimRequest create() => FileCreditLifeClaimRequest._();
  @$core.override
  FileCreditLifeClaimRequest createEmptyInstance() => create();
  static $pb.PbList<FileCreditLifeClaimRequest> createRepeated() =>
      $pb.PbList<FileCreditLifeClaimRequest>();
  @$core.pragma('dart2js:noInline')
  static FileCreditLifeClaimRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FileCreditLifeClaimRequest>(create);
  static FileCreditLifeClaimRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get policyId => $_getSZ(0);
  @$pb.TagNumber(1)
  set policyId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPolicyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPolicyId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get claimType => $_getSZ(1);
  @$pb.TagNumber(2)
  set claimType($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasClaimType() => $_has(1);
  @$pb.TagNumber(2)
  void clearClaimType() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get amount => $_getN(3);
  @$pb.TagNumber(4)
  set amount($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearAmount() => $_clearField(4);

  @$pb.TagNumber(5)
  $pb.PbList<$core.String> get documents => $_getList(4);

  @$pb.TagNumber(6)
  $pb.PbMap<$core.String, $core.String> get additionalInfo => $_getMap(5);
}

class FileCreditLifeClaimResponse extends $pb.GeneratedMessage {
  factory FileCreditLifeClaimResponse({
    $core.String? claimId,
    $core.String? claimNumber,
    $core.String? status,
    $core.String? message,
  }) {
    final result = create();
    if (claimId != null) result.claimId = claimId;
    if (claimNumber != null) result.claimNumber = claimNumber;
    if (status != null) result.status = status;
    if (message != null) result.message = message;
    return result;
  }

  FileCreditLifeClaimResponse._();

  factory FileCreditLifeClaimResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FileCreditLifeClaimResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FileCreditLifeClaimResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'claimId')
    ..aOS(2, _omitFieldNames ? '' : 'claimNumber')
    ..aOS(3, _omitFieldNames ? '' : 'status')
    ..aOS(4, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FileCreditLifeClaimResponse clone() =>
      FileCreditLifeClaimResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FileCreditLifeClaimResponse copyWith(
          void Function(FileCreditLifeClaimResponse) updates) =>
      super.copyWith(
              (message) => updates(message as FileCreditLifeClaimResponse))
          as FileCreditLifeClaimResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FileCreditLifeClaimResponse create() =>
      FileCreditLifeClaimResponse._();
  @$core.override
  FileCreditLifeClaimResponse createEmptyInstance() => create();
  static $pb.PbList<FileCreditLifeClaimResponse> createRepeated() =>
      $pb.PbList<FileCreditLifeClaimResponse>();
  @$core.pragma('dart2js:noInline')
  static FileCreditLifeClaimResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FileCreditLifeClaimResponse>(create);
  static FileCreditLifeClaimResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get claimId => $_getSZ(0);
  @$pb.TagNumber(1)
  set claimId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasClaimId() => $_has(0);
  @$pb.TagNumber(1)
  void clearClaimId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get claimNumber => $_getSZ(1);
  @$pb.TagNumber(2)
  set claimNumber($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasClaimNumber() => $_has(1);
  @$pb.TagNumber(2)
  void clearClaimNumber() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get status => $_getSZ(2);
  @$pb.TagNumber(3)
  set status($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasStatus() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatus() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get message => $_getSZ(3);
  @$pb.TagNumber(4)
  set message($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMessage() => $_has(3);
  @$pb.TagNumber(4)
  void clearMessage() => $_clearField(4);
}

/// Auxiliary: States
class GetInsuranceStatesRequest extends $pb.GeneratedMessage {
  factory GetInsuranceStatesRequest() => create();

  GetInsuranceStatesRequest._();

  factory GetInsuranceStatesRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetInsuranceStatesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetInsuranceStatesRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsuranceStatesRequest clone() =>
      GetInsuranceStatesRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsuranceStatesRequest copyWith(
          void Function(GetInsuranceStatesRequest) updates) =>
      super.copyWith((message) => updates(message as GetInsuranceStatesRequest))
          as GetInsuranceStatesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInsuranceStatesRequest create() => GetInsuranceStatesRequest._();
  @$core.override
  GetInsuranceStatesRequest createEmptyInstance() => create();
  static $pb.PbList<GetInsuranceStatesRequest> createRepeated() =>
      $pb.PbList<GetInsuranceStatesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInsuranceStatesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetInsuranceStatesRequest>(create);
  static GetInsuranceStatesRequest? _defaultInstance;
}

class GetInsuranceStatesResponse extends $pb.GeneratedMessage {
  factory GetInsuranceStatesResponse({
    $core.Iterable<InsuranceAuxiliaryItem>? states,
  }) {
    final result = create();
    if (states != null) result.states.addAll(states);
    return result;
  }

  GetInsuranceStatesResponse._();

  factory GetInsuranceStatesResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetInsuranceStatesResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetInsuranceStatesResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..pc<InsuranceAuxiliaryItem>(
        1, _omitFieldNames ? '' : 'states', $pb.PbFieldType.PM,
        subBuilder: InsuranceAuxiliaryItem.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsuranceStatesResponse clone() =>
      GetInsuranceStatesResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsuranceStatesResponse copyWith(
          void Function(GetInsuranceStatesResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetInsuranceStatesResponse))
          as GetInsuranceStatesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInsuranceStatesResponse create() => GetInsuranceStatesResponse._();
  @$core.override
  GetInsuranceStatesResponse createEmptyInstance() => create();
  static $pb.PbList<GetInsuranceStatesResponse> createRepeated() =>
      $pb.PbList<GetInsuranceStatesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInsuranceStatesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetInsuranceStatesResponse>(create);
  static GetInsuranceStatesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<InsuranceAuxiliaryItem> get states => $_getList(0);
}

/// Auxiliary: Vehicle Makes
class GetInsuranceVehicleMakesRequest extends $pb.GeneratedMessage {
  factory GetInsuranceVehicleMakesRequest() => create();

  GetInsuranceVehicleMakesRequest._();

  factory GetInsuranceVehicleMakesRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetInsuranceVehicleMakesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetInsuranceVehicleMakesRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsuranceVehicleMakesRequest clone() =>
      GetInsuranceVehicleMakesRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsuranceVehicleMakesRequest copyWith(
          void Function(GetInsuranceVehicleMakesRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetInsuranceVehicleMakesRequest))
          as GetInsuranceVehicleMakesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInsuranceVehicleMakesRequest create() =>
      GetInsuranceVehicleMakesRequest._();
  @$core.override
  GetInsuranceVehicleMakesRequest createEmptyInstance() => create();
  static $pb.PbList<GetInsuranceVehicleMakesRequest> createRepeated() =>
      $pb.PbList<GetInsuranceVehicleMakesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInsuranceVehicleMakesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetInsuranceVehicleMakesRequest>(
          create);
  static GetInsuranceVehicleMakesRequest? _defaultInstance;
}

class GetInsuranceVehicleMakesResponse extends $pb.GeneratedMessage {
  factory GetInsuranceVehicleMakesResponse({
    $core.Iterable<InsuranceAuxiliaryItem>? makes,
  }) {
    final result = create();
    if (makes != null) result.makes.addAll(makes);
    return result;
  }

  GetInsuranceVehicleMakesResponse._();

  factory GetInsuranceVehicleMakesResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetInsuranceVehicleMakesResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetInsuranceVehicleMakesResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..pc<InsuranceAuxiliaryItem>(
        1, _omitFieldNames ? '' : 'makes', $pb.PbFieldType.PM,
        subBuilder: InsuranceAuxiliaryItem.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsuranceVehicleMakesResponse clone() =>
      GetInsuranceVehicleMakesResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsuranceVehicleMakesResponse copyWith(
          void Function(GetInsuranceVehicleMakesResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetInsuranceVehicleMakesResponse))
          as GetInsuranceVehicleMakesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInsuranceVehicleMakesResponse create() =>
      GetInsuranceVehicleMakesResponse._();
  @$core.override
  GetInsuranceVehicleMakesResponse createEmptyInstance() => create();
  static $pb.PbList<GetInsuranceVehicleMakesResponse> createRepeated() =>
      $pb.PbList<GetInsuranceVehicleMakesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInsuranceVehicleMakesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetInsuranceVehicleMakesResponse>(
          create);
  static GetInsuranceVehicleMakesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<InsuranceAuxiliaryItem> get makes => $_getList(0);
}

/// InsurancePolicyDetail - MyCover policy detail for management APIs
class InsurancePolicyDetail extends $pb.GeneratedMessage {
  factory InsurancePolicyDetail({
    $core.String? id,
    $core.String? appMode,
    $core.String? firstName,
    $core.String? lastName,
    $core.String? email,
    $core.String? phoneNumber,
    $core.String? dateOfBirth,
    $core.String? activationDate,
    $core.String? startDate,
    $core.String? expirationDate,
    $core.String? amount,
    $core.bool? isActive,
    $core.bool? isSubmittedToProvider,
    $core.String? customerId,
    $core.String? productId,
    $core.String? productCategoryId,
    $core.String? providerId,
    $core.String? purchaseId,
    $core.String? policyNumber,
    $core.String? certificateUrl,
    $core.String? createdAt,
    $core.String? updatedAt,
    $core.String? providerName,
    $core.String? productName,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (appMode != null) result.appMode = appMode;
    if (firstName != null) result.firstName = firstName;
    if (lastName != null) result.lastName = lastName;
    if (email != null) result.email = email;
    if (phoneNumber != null) result.phoneNumber = phoneNumber;
    if (dateOfBirth != null) result.dateOfBirth = dateOfBirth;
    if (activationDate != null) result.activationDate = activationDate;
    if (startDate != null) result.startDate = startDate;
    if (expirationDate != null) result.expirationDate = expirationDate;
    if (amount != null) result.amount = amount;
    if (isActive != null) result.isActive = isActive;
    if (isSubmittedToProvider != null)
      result.isSubmittedToProvider = isSubmittedToProvider;
    if (customerId != null) result.customerId = customerId;
    if (productId != null) result.productId = productId;
    if (productCategoryId != null) result.productCategoryId = productCategoryId;
    if (providerId != null) result.providerId = providerId;
    if (purchaseId != null) result.purchaseId = purchaseId;
    if (policyNumber != null) result.policyNumber = policyNumber;
    if (certificateUrl != null) result.certificateUrl = certificateUrl;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    if (providerName != null) result.providerName = providerName;
    if (productName != null) result.productName = productName;
    return result;
  }

  InsurancePolicyDetail._();

  factory InsurancePolicyDetail.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InsurancePolicyDetail.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InsurancePolicyDetail',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'appMode')
    ..aOS(3, _omitFieldNames ? '' : 'firstName')
    ..aOS(4, _omitFieldNames ? '' : 'lastName')
    ..aOS(5, _omitFieldNames ? '' : 'email')
    ..aOS(6, _omitFieldNames ? '' : 'phoneNumber')
    ..aOS(7, _omitFieldNames ? '' : 'dateOfBirth')
    ..aOS(8, _omitFieldNames ? '' : 'activationDate')
    ..aOS(9, _omitFieldNames ? '' : 'startDate')
    ..aOS(10, _omitFieldNames ? '' : 'expirationDate')
    ..aOS(11, _omitFieldNames ? '' : 'amount')
    ..aOB(12, _omitFieldNames ? '' : 'isActive')
    ..aOB(13, _omitFieldNames ? '' : 'isSubmittedToProvider')
    ..aOS(14, _omitFieldNames ? '' : 'customerId')
    ..aOS(15, _omitFieldNames ? '' : 'productId')
    ..aOS(16, _omitFieldNames ? '' : 'productCategoryId')
    ..aOS(17, _omitFieldNames ? '' : 'providerId')
    ..aOS(18, _omitFieldNames ? '' : 'purchaseId')
    ..aOS(19, _omitFieldNames ? '' : 'policyNumber')
    ..aOS(20, _omitFieldNames ? '' : 'certificateUrl')
    ..aOS(21, _omitFieldNames ? '' : 'createdAt')
    ..aOS(22, _omitFieldNames ? '' : 'updatedAt')
    ..aOS(23, _omitFieldNames ? '' : 'providerName')
    ..aOS(24, _omitFieldNames ? '' : 'productName')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InsurancePolicyDetail clone() =>
      InsurancePolicyDetail()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InsurancePolicyDetail copyWith(
          void Function(InsurancePolicyDetail) updates) =>
      super.copyWith((message) => updates(message as InsurancePolicyDetail))
          as InsurancePolicyDetail;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InsurancePolicyDetail create() => InsurancePolicyDetail._();
  @$core.override
  InsurancePolicyDetail createEmptyInstance() => create();
  static $pb.PbList<InsurancePolicyDetail> createRepeated() =>
      $pb.PbList<InsurancePolicyDetail>();
  @$core.pragma('dart2js:noInline')
  static InsurancePolicyDetail getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InsurancePolicyDetail>(create);
  static InsurancePolicyDetail? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get appMode => $_getSZ(1);
  @$pb.TagNumber(2)
  set appMode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAppMode() => $_has(1);
  @$pb.TagNumber(2)
  void clearAppMode() => $_clearField(2);

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
  $core.String get email => $_getSZ(4);
  @$pb.TagNumber(5)
  set email($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasEmail() => $_has(4);
  @$pb.TagNumber(5)
  void clearEmail() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get phoneNumber => $_getSZ(5);
  @$pb.TagNumber(6)
  set phoneNumber($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasPhoneNumber() => $_has(5);
  @$pb.TagNumber(6)
  void clearPhoneNumber() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get dateOfBirth => $_getSZ(6);
  @$pb.TagNumber(7)
  set dateOfBirth($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasDateOfBirth() => $_has(6);
  @$pb.TagNumber(7)
  void clearDateOfBirth() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get activationDate => $_getSZ(7);
  @$pb.TagNumber(8)
  set activationDate($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasActivationDate() => $_has(7);
  @$pb.TagNumber(8)
  void clearActivationDate() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get startDate => $_getSZ(8);
  @$pb.TagNumber(9)
  set startDate($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasStartDate() => $_has(8);
  @$pb.TagNumber(9)
  void clearStartDate() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get expirationDate => $_getSZ(9);
  @$pb.TagNumber(10)
  set expirationDate($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasExpirationDate() => $_has(9);
  @$pb.TagNumber(10)
  void clearExpirationDate() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get amount => $_getSZ(10);
  @$pb.TagNumber(11)
  set amount($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasAmount() => $_has(10);
  @$pb.TagNumber(11)
  void clearAmount() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.bool get isActive => $_getBF(11);
  @$pb.TagNumber(12)
  set isActive($core.bool value) => $_setBool(11, value);
  @$pb.TagNumber(12)
  $core.bool hasIsActive() => $_has(11);
  @$pb.TagNumber(12)
  void clearIsActive() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.bool get isSubmittedToProvider => $_getBF(12);
  @$pb.TagNumber(13)
  set isSubmittedToProvider($core.bool value) => $_setBool(12, value);
  @$pb.TagNumber(13)
  $core.bool hasIsSubmittedToProvider() => $_has(12);
  @$pb.TagNumber(13)
  void clearIsSubmittedToProvider() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.String get customerId => $_getSZ(13);
  @$pb.TagNumber(14)
  set customerId($core.String value) => $_setString(13, value);
  @$pb.TagNumber(14)
  $core.bool hasCustomerId() => $_has(13);
  @$pb.TagNumber(14)
  void clearCustomerId() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.String get productId => $_getSZ(14);
  @$pb.TagNumber(15)
  set productId($core.String value) => $_setString(14, value);
  @$pb.TagNumber(15)
  $core.bool hasProductId() => $_has(14);
  @$pb.TagNumber(15)
  void clearProductId() => $_clearField(15);

  @$pb.TagNumber(16)
  $core.String get productCategoryId => $_getSZ(15);
  @$pb.TagNumber(16)
  set productCategoryId($core.String value) => $_setString(15, value);
  @$pb.TagNumber(16)
  $core.bool hasProductCategoryId() => $_has(15);
  @$pb.TagNumber(16)
  void clearProductCategoryId() => $_clearField(16);

  @$pb.TagNumber(17)
  $core.String get providerId => $_getSZ(16);
  @$pb.TagNumber(17)
  set providerId($core.String value) => $_setString(16, value);
  @$pb.TagNumber(17)
  $core.bool hasProviderId() => $_has(16);
  @$pb.TagNumber(17)
  void clearProviderId() => $_clearField(17);

  @$pb.TagNumber(18)
  $core.String get purchaseId => $_getSZ(17);
  @$pb.TagNumber(18)
  set purchaseId($core.String value) => $_setString(17, value);
  @$pb.TagNumber(18)
  $core.bool hasPurchaseId() => $_has(17);
  @$pb.TagNumber(18)
  void clearPurchaseId() => $_clearField(18);

  @$pb.TagNumber(19)
  $core.String get policyNumber => $_getSZ(18);
  @$pb.TagNumber(19)
  set policyNumber($core.String value) => $_setString(18, value);
  @$pb.TagNumber(19)
  $core.bool hasPolicyNumber() => $_has(18);
  @$pb.TagNumber(19)
  void clearPolicyNumber() => $_clearField(19);

  @$pb.TagNumber(20)
  $core.String get certificateUrl => $_getSZ(19);
  @$pb.TagNumber(20)
  set certificateUrl($core.String value) => $_setString(19, value);
  @$pb.TagNumber(20)
  $core.bool hasCertificateUrl() => $_has(19);
  @$pb.TagNumber(20)
  void clearCertificateUrl() => $_clearField(20);

  @$pb.TagNumber(21)
  $core.String get createdAt => $_getSZ(20);
  @$pb.TagNumber(21)
  set createdAt($core.String value) => $_setString(20, value);
  @$pb.TagNumber(21)
  $core.bool hasCreatedAt() => $_has(20);
  @$pb.TagNumber(21)
  void clearCreatedAt() => $_clearField(21);

  @$pb.TagNumber(22)
  $core.String get updatedAt => $_getSZ(21);
  @$pb.TagNumber(22)
  set updatedAt($core.String value) => $_setString(21, value);
  @$pb.TagNumber(22)
  $core.bool hasUpdatedAt() => $_has(21);
  @$pb.TagNumber(22)
  void clearUpdatedAt() => $_clearField(22);

  @$pb.TagNumber(23)
  $core.String get providerName => $_getSZ(22);
  @$pb.TagNumber(23)
  set providerName($core.String value) => $_setString(22, value);
  @$pb.TagNumber(23)
  $core.bool hasProviderName() => $_has(22);
  @$pb.TagNumber(23)
  void clearProviderName() => $_clearField(23);

  @$pb.TagNumber(24)
  $core.String get productName => $_getSZ(23);
  @$pb.TagNumber(24)
  set productName($core.String value) => $_setString(23, value);
  @$pb.TagNumber(24)
  $core.bool hasProductName() => $_has(23);
  @$pb.TagNumber(24)
  void clearProductName() => $_clearField(24);
}

/// Notification Preferences
class MyCoverNotificationPreference extends $pb.GeneratedMessage {
  factory MyCoverNotificationPreference({
    $core.String? key,
    $core.String? category,
    $core.String? label,
    $core.String? description,
    $core.bool? enabled,
  }) {
    final result = create();
    if (key != null) result.key = key;
    if (category != null) result.category = category;
    if (label != null) result.label = label;
    if (description != null) result.description = description;
    if (enabled != null) result.enabled = enabled;
    return result;
  }

  MyCoverNotificationPreference._();

  factory MyCoverNotificationPreference.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MyCoverNotificationPreference.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MyCoverNotificationPreference',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'key')
    ..aOS(2, _omitFieldNames ? '' : 'category')
    ..aOS(3, _omitFieldNames ? '' : 'label')
    ..aOS(4, _omitFieldNames ? '' : 'description')
    ..aOB(5, _omitFieldNames ? '' : 'enabled')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MyCoverNotificationPreference clone() =>
      MyCoverNotificationPreference()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MyCoverNotificationPreference copyWith(
          void Function(MyCoverNotificationPreference) updates) =>
      super.copyWith(
              (message) => updates(message as MyCoverNotificationPreference))
          as MyCoverNotificationPreference;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MyCoverNotificationPreference create() =>
      MyCoverNotificationPreference._();
  @$core.override
  MyCoverNotificationPreference createEmptyInstance() => create();
  static $pb.PbList<MyCoverNotificationPreference> createRepeated() =>
      $pb.PbList<MyCoverNotificationPreference>();
  @$core.pragma('dart2js:noInline')
  static MyCoverNotificationPreference getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MyCoverNotificationPreference>(create);
  static MyCoverNotificationPreference? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get key => $_getSZ(0);
  @$pb.TagNumber(1)
  set key($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearKey() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get category => $_getSZ(1);
  @$pb.TagNumber(2)
  set category($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCategory() => $_has(1);
  @$pb.TagNumber(2)
  void clearCategory() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get label => $_getSZ(2);
  @$pb.TagNumber(3)
  set label($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasLabel() => $_has(2);
  @$pb.TagNumber(3)
  void clearLabel() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get description => $_getSZ(3);
  @$pb.TagNumber(4)
  set description($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDescription() => $_has(3);
  @$pb.TagNumber(4)
  void clearDescription() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.bool get enabled => $_getBF(4);
  @$pb.TagNumber(5)
  set enabled($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasEnabled() => $_has(4);
  @$pb.TagNumber(5)
  void clearEnabled() => $_clearField(5);
}

class GetMyCoverNotificationPreferencesRequest extends $pb.GeneratedMessage {
  factory GetMyCoverNotificationPreferencesRequest() => create();

  GetMyCoverNotificationPreferencesRequest._();

  factory GetMyCoverNotificationPreferencesRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMyCoverNotificationPreferencesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMyCoverNotificationPreferencesRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyCoverNotificationPreferencesRequest clone() =>
      GetMyCoverNotificationPreferencesRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyCoverNotificationPreferencesRequest copyWith(
          void Function(GetMyCoverNotificationPreferencesRequest) updates) =>
      super.copyWith((message) =>
              updates(message as GetMyCoverNotificationPreferencesRequest))
          as GetMyCoverNotificationPreferencesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMyCoverNotificationPreferencesRequest create() =>
      GetMyCoverNotificationPreferencesRequest._();
  @$core.override
  GetMyCoverNotificationPreferencesRequest createEmptyInstance() => create();
  static $pb.PbList<GetMyCoverNotificationPreferencesRequest>
      createRepeated() =>
          $pb.PbList<GetMyCoverNotificationPreferencesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMyCoverNotificationPreferencesRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          GetMyCoverNotificationPreferencesRequest>(create);
  static GetMyCoverNotificationPreferencesRequest? _defaultInstance;
}

class GetMyCoverNotificationPreferencesResponse extends $pb.GeneratedMessage {
  factory GetMyCoverNotificationPreferencesResponse({
    $core.Iterable<MyCoverNotificationPreference>? preferences,
  }) {
    final result = create();
    if (preferences != null) result.preferences.addAll(preferences);
    return result;
  }

  GetMyCoverNotificationPreferencesResponse._();

  factory GetMyCoverNotificationPreferencesResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMyCoverNotificationPreferencesResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMyCoverNotificationPreferencesResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..pc<MyCoverNotificationPreference>(
        1, _omitFieldNames ? '' : 'preferences', $pb.PbFieldType.PM,
        subBuilder: MyCoverNotificationPreference.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyCoverNotificationPreferencesResponse clone() =>
      GetMyCoverNotificationPreferencesResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyCoverNotificationPreferencesResponse copyWith(
          void Function(GetMyCoverNotificationPreferencesResponse) updates) =>
      super.copyWith((message) =>
              updates(message as GetMyCoverNotificationPreferencesResponse))
          as GetMyCoverNotificationPreferencesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMyCoverNotificationPreferencesResponse create() =>
      GetMyCoverNotificationPreferencesResponse._();
  @$core.override
  GetMyCoverNotificationPreferencesResponse createEmptyInstance() => create();
  static $pb.PbList<GetMyCoverNotificationPreferencesResponse>
      createRepeated() =>
          $pb.PbList<GetMyCoverNotificationPreferencesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMyCoverNotificationPreferencesResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          GetMyCoverNotificationPreferencesResponse>(create);
  static GetMyCoverNotificationPreferencesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<MyCoverNotificationPreference> get preferences => $_getList(0);
}

class UpdateMyCoverNotificationPreferencesRequest extends $pb.GeneratedMessage {
  factory UpdateMyCoverNotificationPreferencesRequest({
    $core.Iterable<MyCoverNotificationPreference>? preferences,
  }) {
    final result = create();
    if (preferences != null) result.preferences.addAll(preferences);
    return result;
  }

  UpdateMyCoverNotificationPreferencesRequest._();

  factory UpdateMyCoverNotificationPreferencesRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateMyCoverNotificationPreferencesRequest.fromJson(
          $core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateMyCoverNotificationPreferencesRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..pc<MyCoverNotificationPreference>(
        1, _omitFieldNames ? '' : 'preferences', $pb.PbFieldType.PM,
        subBuilder: MyCoverNotificationPreference.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateMyCoverNotificationPreferencesRequest clone() =>
      UpdateMyCoverNotificationPreferencesRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateMyCoverNotificationPreferencesRequest copyWith(
          void Function(UpdateMyCoverNotificationPreferencesRequest) updates) =>
      super.copyWith((message) =>
              updates(message as UpdateMyCoverNotificationPreferencesRequest))
          as UpdateMyCoverNotificationPreferencesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateMyCoverNotificationPreferencesRequest create() =>
      UpdateMyCoverNotificationPreferencesRequest._();
  @$core.override
  UpdateMyCoverNotificationPreferencesRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateMyCoverNotificationPreferencesRequest>
      createRepeated() =>
          $pb.PbList<UpdateMyCoverNotificationPreferencesRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateMyCoverNotificationPreferencesRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          UpdateMyCoverNotificationPreferencesRequest>(create);
  static UpdateMyCoverNotificationPreferencesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<MyCoverNotificationPreference> get preferences => $_getList(0);
}

class UpdateMyCoverNotificationPreferencesResponse
    extends $pb.GeneratedMessage {
  factory UpdateMyCoverNotificationPreferencesResponse({
    $core.bool? success,
    $core.String? message,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    return result;
  }

  UpdateMyCoverNotificationPreferencesResponse._();

  factory UpdateMyCoverNotificationPreferencesResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateMyCoverNotificationPreferencesResponse.fromJson(
          $core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateMyCoverNotificationPreferencesResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateMyCoverNotificationPreferencesResponse clone() =>
      UpdateMyCoverNotificationPreferencesResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateMyCoverNotificationPreferencesResponse copyWith(
          void Function(UpdateMyCoverNotificationPreferencesResponse)
              updates) =>
      super.copyWith((message) =>
              updates(message as UpdateMyCoverNotificationPreferencesResponse))
          as UpdateMyCoverNotificationPreferencesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateMyCoverNotificationPreferencesResponse create() =>
      UpdateMyCoverNotificationPreferencesResponse._();
  @$core.override
  UpdateMyCoverNotificationPreferencesResponse createEmptyInstance() =>
      create();
  static $pb.PbList<UpdateMyCoverNotificationPreferencesResponse>
      createRepeated() =>
          $pb.PbList<UpdateMyCoverNotificationPreferencesResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateMyCoverNotificationPreferencesResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          UpdateMyCoverNotificationPreferencesResponse>(create);
  static UpdateMyCoverNotificationPreferencesResponse? _defaultInstance;

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

class GetMyCoverWalletBalanceRequest extends $pb.GeneratedMessage {
  factory GetMyCoverWalletBalanceRequest() => create();

  GetMyCoverWalletBalanceRequest._();

  factory GetMyCoverWalletBalanceRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMyCoverWalletBalanceRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMyCoverWalletBalanceRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyCoverWalletBalanceRequest clone() =>
      GetMyCoverWalletBalanceRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyCoverWalletBalanceRequest copyWith(
          void Function(GetMyCoverWalletBalanceRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetMyCoverWalletBalanceRequest))
          as GetMyCoverWalletBalanceRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMyCoverWalletBalanceRequest create() =>
      GetMyCoverWalletBalanceRequest._();
  @$core.override
  GetMyCoverWalletBalanceRequest createEmptyInstance() => create();
  static $pb.PbList<GetMyCoverWalletBalanceRequest> createRepeated() =>
      $pb.PbList<GetMyCoverWalletBalanceRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMyCoverWalletBalanceRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetMyCoverWalletBalanceRequest>(create);
  static GetMyCoverWalletBalanceRequest? _defaultInstance;
}

class GetMyCoverWalletBalanceResponse extends $pb.GeneratedMessage {
  factory GetMyCoverWalletBalanceResponse({
    $core.double? balance,
    $core.String? currency,
    $core.bool? success,
    $core.String? message,
  }) {
    final result = create();
    if (balance != null) result.balance = balance;
    if (currency != null) result.currency = currency;
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    return result;
  }

  GetMyCoverWalletBalanceResponse._();

  factory GetMyCoverWalletBalanceResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMyCoverWalletBalanceResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMyCoverWalletBalanceResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'balance', $pb.PbFieldType.OD)
    ..aOS(2, _omitFieldNames ? '' : 'currency')
    ..aOB(3, _omitFieldNames ? '' : 'success')
    ..aOS(4, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyCoverWalletBalanceResponse clone() =>
      GetMyCoverWalletBalanceResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyCoverWalletBalanceResponse copyWith(
          void Function(GetMyCoverWalletBalanceResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetMyCoverWalletBalanceResponse))
          as GetMyCoverWalletBalanceResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMyCoverWalletBalanceResponse create() =>
      GetMyCoverWalletBalanceResponse._();
  @$core.override
  GetMyCoverWalletBalanceResponse createEmptyInstance() => create();
  static $pb.PbList<GetMyCoverWalletBalanceResponse> createRepeated() =>
      $pb.PbList<GetMyCoverWalletBalanceResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMyCoverWalletBalanceResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetMyCoverWalletBalanceResponse>(
          create);
  static GetMyCoverWalletBalanceResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get balance => $_getN(0);
  @$pb.TagNumber(1)
  set balance($core.double value) => $_setDouble(0, value);
  @$pb.TagNumber(1)
  $core.bool hasBalance() => $_has(0);
  @$pb.TagNumber(1)
  void clearBalance() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get currency => $_getSZ(1);
  @$pb.TagNumber(2)
  set currency($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCurrency() => $_has(1);
  @$pb.TagNumber(2)
  void clearCurrency() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.bool get success => $_getBF(2);
  @$pb.TagNumber(3)
  set success($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSuccess() => $_has(2);
  @$pb.TagNumber(3)
  void clearSuccess() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get message => $_getSZ(3);
  @$pb.TagNumber(4)
  set message($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMessage() => $_has(3);
  @$pb.TagNumber(4)
  void clearMessage() => $_clearField(4);
}

class RequestInsuranceRefundRequest extends $pb.GeneratedMessage {
  factory RequestInsuranceRefundRequest({
    $core.String? policyReference,
    $core.String? reason,
  }) {
    final result = create();
    if (policyReference != null) result.policyReference = policyReference;
    if (reason != null) result.reason = reason;
    return result;
  }

  RequestInsuranceRefundRequest._();

  factory RequestInsuranceRefundRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RequestInsuranceRefundRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RequestInsuranceRefundRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'policyReference')
    ..aOS(2, _omitFieldNames ? '' : 'reason')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RequestInsuranceRefundRequest clone() =>
      RequestInsuranceRefundRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RequestInsuranceRefundRequest copyWith(
          void Function(RequestInsuranceRefundRequest) updates) =>
      super.copyWith(
              (message) => updates(message as RequestInsuranceRefundRequest))
          as RequestInsuranceRefundRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RequestInsuranceRefundRequest create() =>
      RequestInsuranceRefundRequest._();
  @$core.override
  RequestInsuranceRefundRequest createEmptyInstance() => create();
  static $pb.PbList<RequestInsuranceRefundRequest> createRepeated() =>
      $pb.PbList<RequestInsuranceRefundRequest>();
  @$core.pragma('dart2js:noInline')
  static RequestInsuranceRefundRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RequestInsuranceRefundRequest>(create);
  static RequestInsuranceRefundRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get policyReference => $_getSZ(0);
  @$pb.TagNumber(1)
  set policyReference($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPolicyReference() => $_has(0);
  @$pb.TagNumber(1)
  void clearPolicyReference() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get reason => $_getSZ(1);
  @$pb.TagNumber(2)
  set reason($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasReason() => $_has(1);
  @$pb.TagNumber(2)
  void clearReason() => $_clearField(2);
}

class RequestInsuranceRefundResponse extends $pb.GeneratedMessage {
  factory RequestInsuranceRefundResponse({
    InsuranceRefundInfo? refund,
    $core.bool? success,
    $core.String? message,
  }) {
    final result = create();
    if (refund != null) result.refund = refund;
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    return result;
  }

  RequestInsuranceRefundResponse._();

  factory RequestInsuranceRefundResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RequestInsuranceRefundResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RequestInsuranceRefundResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOM<InsuranceRefundInfo>(1, _omitFieldNames ? '' : 'refund',
        subBuilder: InsuranceRefundInfo.create)
    ..aOB(2, _omitFieldNames ? '' : 'success')
    ..aOS(3, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RequestInsuranceRefundResponse clone() =>
      RequestInsuranceRefundResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RequestInsuranceRefundResponse copyWith(
          void Function(RequestInsuranceRefundResponse) updates) =>
      super.copyWith(
              (message) => updates(message as RequestInsuranceRefundResponse))
          as RequestInsuranceRefundResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RequestInsuranceRefundResponse create() =>
      RequestInsuranceRefundResponse._();
  @$core.override
  RequestInsuranceRefundResponse createEmptyInstance() => create();
  static $pb.PbList<RequestInsuranceRefundResponse> createRepeated() =>
      $pb.PbList<RequestInsuranceRefundResponse>();
  @$core.pragma('dart2js:noInline')
  static RequestInsuranceRefundResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RequestInsuranceRefundResponse>(create);
  static RequestInsuranceRefundResponse? _defaultInstance;

  @$pb.TagNumber(1)
  InsuranceRefundInfo get refund => $_getN(0);
  @$pb.TagNumber(1)
  set refund(InsuranceRefundInfo value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRefund() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefund() => $_clearField(1);
  @$pb.TagNumber(1)
  InsuranceRefundInfo ensureRefund() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => $_clearField(3);
}

class GetInsuranceRefundStatusRequest extends $pb.GeneratedMessage {
  factory GetInsuranceRefundStatusRequest({
    $core.String? policyReference,
  }) {
    final result = create();
    if (policyReference != null) result.policyReference = policyReference;
    return result;
  }

  GetInsuranceRefundStatusRequest._();

  factory GetInsuranceRefundStatusRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetInsuranceRefundStatusRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetInsuranceRefundStatusRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'policyReference')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsuranceRefundStatusRequest clone() =>
      GetInsuranceRefundStatusRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsuranceRefundStatusRequest copyWith(
          void Function(GetInsuranceRefundStatusRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetInsuranceRefundStatusRequest))
          as GetInsuranceRefundStatusRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInsuranceRefundStatusRequest create() =>
      GetInsuranceRefundStatusRequest._();
  @$core.override
  GetInsuranceRefundStatusRequest createEmptyInstance() => create();
  static $pb.PbList<GetInsuranceRefundStatusRequest> createRepeated() =>
      $pb.PbList<GetInsuranceRefundStatusRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInsuranceRefundStatusRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetInsuranceRefundStatusRequest>(
          create);
  static GetInsuranceRefundStatusRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get policyReference => $_getSZ(0);
  @$pb.TagNumber(1)
  set policyReference($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPolicyReference() => $_has(0);
  @$pb.TagNumber(1)
  void clearPolicyReference() => $_clearField(1);
}

class GetInsuranceRefundStatusResponse extends $pb.GeneratedMessage {
  factory GetInsuranceRefundStatusResponse({
    InsuranceRefundInfo? refund,
    $core.bool? success,
    $core.String? message,
  }) {
    final result = create();
    if (refund != null) result.refund = refund;
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    return result;
  }

  GetInsuranceRefundStatusResponse._();

  factory GetInsuranceRefundStatusResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetInsuranceRefundStatusResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetInsuranceRefundStatusResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOM<InsuranceRefundInfo>(1, _omitFieldNames ? '' : 'refund',
        subBuilder: InsuranceRefundInfo.create)
    ..aOB(2, _omitFieldNames ? '' : 'success')
    ..aOS(3, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsuranceRefundStatusResponse clone() =>
      GetInsuranceRefundStatusResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsuranceRefundStatusResponse copyWith(
          void Function(GetInsuranceRefundStatusResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetInsuranceRefundStatusResponse))
          as GetInsuranceRefundStatusResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInsuranceRefundStatusResponse create() =>
      GetInsuranceRefundStatusResponse._();
  @$core.override
  GetInsuranceRefundStatusResponse createEmptyInstance() => create();
  static $pb.PbList<GetInsuranceRefundStatusResponse> createRepeated() =>
      $pb.PbList<GetInsuranceRefundStatusResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInsuranceRefundStatusResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetInsuranceRefundStatusResponse>(
          create);
  static GetInsuranceRefundStatusResponse? _defaultInstance;

  @$pb.TagNumber(1)
  InsuranceRefundInfo get refund => $_getN(0);
  @$pb.TagNumber(1)
  set refund(InsuranceRefundInfo value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRefund() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefund() => $_clearField(1);
  @$pb.TagNumber(1)
  InsuranceRefundInfo ensureRefund() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => $_clearField(3);
}

class InsuranceRefundInfo extends $pb.GeneratedMessage {
  factory InsuranceRefundInfo({
    $core.String? refundId,
    $core.String? policyReference,
    $core.String? status,
    $core.double? amount,
    $core.String? currency,
    $core.bool? providerRefunded,
    $core.bool? walletCredited,
    $core.String? reason,
    $core.String? failureReason,
    $core.String? initiatedAt,
    $core.String? completedAt,
  }) {
    final result = create();
    if (refundId != null) result.refundId = refundId;
    if (policyReference != null) result.policyReference = policyReference;
    if (status != null) result.status = status;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    if (providerRefunded != null) result.providerRefunded = providerRefunded;
    if (walletCredited != null) result.walletCredited = walletCredited;
    if (reason != null) result.reason = reason;
    if (failureReason != null) result.failureReason = failureReason;
    if (initiatedAt != null) result.initiatedAt = initiatedAt;
    if (completedAt != null) result.completedAt = completedAt;
    return result;
  }

  InsuranceRefundInfo._();

  factory InsuranceRefundInfo.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InsuranceRefundInfo.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InsuranceRefundInfo',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refundId')
    ..aOS(2, _omitFieldNames ? '' : 'policyReference')
    ..aOS(3, _omitFieldNames ? '' : 'status')
    ..a<$core.double>(4, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(5, _omitFieldNames ? '' : 'currency')
    ..aOB(6, _omitFieldNames ? '' : 'providerRefunded')
    ..aOB(7, _omitFieldNames ? '' : 'walletCredited')
    ..aOS(8, _omitFieldNames ? '' : 'reason')
    ..aOS(9, _omitFieldNames ? '' : 'failureReason')
    ..aOS(10, _omitFieldNames ? '' : 'initiatedAt')
    ..aOS(11, _omitFieldNames ? '' : 'completedAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InsuranceRefundInfo clone() => InsuranceRefundInfo()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InsuranceRefundInfo copyWith(void Function(InsuranceRefundInfo) updates) =>
      super.copyWith((message) => updates(message as InsuranceRefundInfo))
          as InsuranceRefundInfo;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InsuranceRefundInfo create() => InsuranceRefundInfo._();
  @$core.override
  InsuranceRefundInfo createEmptyInstance() => create();
  static $pb.PbList<InsuranceRefundInfo> createRepeated() =>
      $pb.PbList<InsuranceRefundInfo>();
  @$core.pragma('dart2js:noInline')
  static InsuranceRefundInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InsuranceRefundInfo>(create);
  static InsuranceRefundInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refundId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refundId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefundId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefundId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get policyReference => $_getSZ(1);
  @$pb.TagNumber(2)
  set policyReference($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPolicyReference() => $_has(1);
  @$pb.TagNumber(2)
  void clearPolicyReference() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get status => $_getSZ(2);
  @$pb.TagNumber(3)
  set status($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasStatus() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatus() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get amount => $_getN(3);
  @$pb.TagNumber(4)
  set amount($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearAmount() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get currency => $_getSZ(4);
  @$pb.TagNumber(5)
  set currency($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasCurrency() => $_has(4);
  @$pb.TagNumber(5)
  void clearCurrency() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.bool get providerRefunded => $_getBF(5);
  @$pb.TagNumber(6)
  set providerRefunded($core.bool value) => $_setBool(5, value);
  @$pb.TagNumber(6)
  $core.bool hasProviderRefunded() => $_has(5);
  @$pb.TagNumber(6)
  void clearProviderRefunded() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.bool get walletCredited => $_getBF(6);
  @$pb.TagNumber(7)
  set walletCredited($core.bool value) => $_setBool(6, value);
  @$pb.TagNumber(7)
  $core.bool hasWalletCredited() => $_has(6);
  @$pb.TagNumber(7)
  void clearWalletCredited() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get reason => $_getSZ(7);
  @$pb.TagNumber(8)
  set reason($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasReason() => $_has(7);
  @$pb.TagNumber(8)
  void clearReason() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get failureReason => $_getSZ(8);
  @$pb.TagNumber(9)
  set failureReason($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasFailureReason() => $_has(8);
  @$pb.TagNumber(9)
  void clearFailureReason() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get initiatedAt => $_getSZ(9);
  @$pb.TagNumber(10)
  set initiatedAt($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasInitiatedAt() => $_has(9);
  @$pb.TagNumber(10)
  void clearInitiatedAt() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get completedAt => $_getSZ(10);
  @$pb.TagNumber(11)
  set completedAt($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasCompletedAt() => $_has(10);
  @$pb.TagNumber(11)
  void clearCompletedAt() => $_clearField(11);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
