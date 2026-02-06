//
//  Generated code. Do not modify.
//  source: financial-products.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'financial-products.pbenum.dart';

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
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (name != null) {
      $result.name = name;
    }
    if (description != null) {
      $result.description = description;
    }
    if (creatorId != null) {
      $result.creatorId = creatorId;
    }
    if (balance != null) {
      $result.balance = balance;
    }
    if (targetAmount != null) {
      $result.targetAmount = targetAmount;
    }
    if (status != null) {
      $result.status = status;
    }
    if (members != null) {
      $result.members.addAll(members);
    }
    if (withdrawalRules != null) {
      $result.withdrawalRules = withdrawalRules;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      $result.updatedAt = updatedAt;
    }
    return $result;
  }
  GroupAccount._() : super();
  factory GroupAccount.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GroupAccount.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GroupAccount', package: const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..aOS(4, _omitFieldNames ? '' : 'creatorId')
    ..a<$core.double>(5, _omitFieldNames ? '' : 'balance', $pb.PbFieldType.OD)
    ..a<$core.double>(6, _omitFieldNames ? '' : 'targetAmount', $pb.PbFieldType.OD)
    ..aOS(7, _omitFieldNames ? '' : 'status')
    ..pc<GroupMember>(8, _omitFieldNames ? '' : 'members', $pb.PbFieldType.PM, subBuilder: GroupMember.create)
    ..aOS(9, _omitFieldNames ? '' : 'withdrawalRules')
    ..aOS(10, _omitFieldNames ? '' : 'createdAt')
    ..aOS(11, _omitFieldNames ? '' : 'updatedAt')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GroupAccount clone() => GroupAccount()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GroupAccount copyWith(void Function(GroupAccount) updates) => super.copyWith((message) => updates(message as GroupAccount)) as GroupAccount;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GroupAccount create() => GroupAccount._();
  GroupAccount createEmptyInstance() => create();
  static $pb.PbList<GroupAccount> createRepeated() => $pb.PbList<GroupAccount>();
  @$core.pragma('dart2js:noInline')
  static GroupAccount getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GroupAccount>(create);
  static GroupAccount? _defaultInstance;

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
  $core.String get creatorId => $_getSZ(3);
  @$pb.TagNumber(4)
  set creatorId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCreatorId() => $_has(3);
  @$pb.TagNumber(4)
  void clearCreatorId() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get balance => $_getN(4);
  @$pb.TagNumber(5)
  set balance($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasBalance() => $_has(4);
  @$pb.TagNumber(5)
  void clearBalance() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get targetAmount => $_getN(5);
  @$pb.TagNumber(6)
  set targetAmount($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasTargetAmount() => $_has(5);
  @$pb.TagNumber(6)
  void clearTargetAmount() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get status => $_getSZ(6);
  @$pb.TagNumber(7)
  set status($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasStatus() => $_has(6);
  @$pb.TagNumber(7)
  void clearStatus() => clearField(7);

  @$pb.TagNumber(8)
  $core.List<GroupMember> get members => $_getList(7);

  @$pb.TagNumber(9)
  $core.String get withdrawalRules => $_getSZ(8);
  @$pb.TagNumber(9)
  set withdrawalRules($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasWithdrawalRules() => $_has(8);
  @$pb.TagNumber(9)
  void clearWithdrawalRules() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get createdAt => $_getSZ(9);
  @$pb.TagNumber(10)
  set createdAt($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasCreatedAt() => $_has(9);
  @$pb.TagNumber(10)
  void clearCreatedAt() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get updatedAt => $_getSZ(10);
  @$pb.TagNumber(11)
  set updatedAt($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasUpdatedAt() => $_has(10);
  @$pb.TagNumber(11)
  void clearUpdatedAt() => clearField(11);
}

class GroupMember extends $pb.GeneratedMessage {
  factory GroupMember({
    $core.String? userId,
    $core.String? name,
    $core.String? role,
    $core.double? contribution,
    $core.String? joinedAt,
  }) {
    final $result = create();
    if (userId != null) {
      $result.userId = userId;
    }
    if (name != null) {
      $result.name = name;
    }
    if (role != null) {
      $result.role = role;
    }
    if (contribution != null) {
      $result.contribution = contribution;
    }
    if (joinedAt != null) {
      $result.joinedAt = joinedAt;
    }
    return $result;
  }
  GroupMember._() : super();
  factory GroupMember.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GroupMember.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GroupMember', package: const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'role')
    ..a<$core.double>(4, _omitFieldNames ? '' : 'contribution', $pb.PbFieldType.OD)
    ..aOS(5, _omitFieldNames ? '' : 'joinedAt')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GroupMember clone() => GroupMember()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GroupMember copyWith(void Function(GroupMember) updates) => super.copyWith((message) => updates(message as GroupMember)) as GroupMember;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GroupMember create() => GroupMember._();
  GroupMember createEmptyInstance() => create();
  static $pb.PbList<GroupMember> createRepeated() => $pb.PbList<GroupMember>();
  @$core.pragma('dart2js:noInline')
  static GroupMember getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GroupMember>(create);
  static GroupMember? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get role => $_getSZ(2);
  @$pb.TagNumber(3)
  set role($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasRole() => $_has(2);
  @$pb.TagNumber(3)
  void clearRole() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get contribution => $_getN(3);
  @$pb.TagNumber(4)
  set contribution($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasContribution() => $_has(3);
  @$pb.TagNumber(4)
  void clearContribution() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get joinedAt => $_getSZ(4);
  @$pb.TagNumber(5)
  set joinedAt($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasJoinedAt() => $_has(4);
  @$pb.TagNumber(5)
  void clearJoinedAt() => clearField(5);
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
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (userId != null) {
      $result.userId = userId;
    }
    if (accountId != null) {
      $result.accountId = accountId;
    }
    if (policyNumber != null) {
      $result.policyNumber = policyNumber;
    }
    if (planId != null) {
      $result.planId = planId;
    }
    if (planName != null) {
      $result.planName = planName;
    }
    if (coverageType != null) {
      $result.coverageType = coverageType;
    }
    if (premium != null) {
      $result.premium = premium;
    }
    if (coverageAmount != null) {
      $result.coverageAmount = coverageAmount;
    }
    if (paymentFrequency != null) {
      $result.paymentFrequency = paymentFrequency;
    }
    if (status != null) {
      $result.status = status;
    }
    if (startDate != null) {
      $result.startDate = startDate;
    }
    if (endDate != null) {
      $result.endDate = endDate;
    }
    if (nextPaymentDate != null) {
      $result.nextPaymentDate = nextPaymentDate;
    }
    if (beneficiary != null) {
      $result.beneficiary = beneficiary;
    }
    if (metadata != null) {
      $result.metadata = metadata;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      $result.updatedAt = updatedAt;
    }
    return $result;
  }
  Insurance._() : super();
  factory Insurance.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Insurance.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Insurance', package: const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'accountId')
    ..aOS(4, _omitFieldNames ? '' : 'policyNumber')
    ..aOS(5, _omitFieldNames ? '' : 'planId')
    ..aOS(6, _omitFieldNames ? '' : 'planName')
    ..aOS(7, _omitFieldNames ? '' : 'coverageType')
    ..a<$core.double>(8, _omitFieldNames ? '' : 'premium', $pb.PbFieldType.OD)
    ..a<$core.double>(9, _omitFieldNames ? '' : 'coverageAmount', $pb.PbFieldType.OD)
    ..aOS(10, _omitFieldNames ? '' : 'paymentFrequency')
    ..aOS(11, _omitFieldNames ? '' : 'status')
    ..aOS(12, _omitFieldNames ? '' : 'startDate')
    ..aOS(13, _omitFieldNames ? '' : 'endDate')
    ..aOS(14, _omitFieldNames ? '' : 'nextPaymentDate')
    ..aOS(15, _omitFieldNames ? '' : 'beneficiary')
    ..aOS(16, _omitFieldNames ? '' : 'metadata')
    ..aOS(17, _omitFieldNames ? '' : 'createdAt')
    ..aOS(18, _omitFieldNames ? '' : 'updatedAt')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Insurance clone() => Insurance()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Insurance copyWith(void Function(Insurance) updates) => super.copyWith((message) => updates(message as Insurance)) as Insurance;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Insurance create() => Insurance._();
  Insurance createEmptyInstance() => create();
  static $pb.PbList<Insurance> createRepeated() => $pb.PbList<Insurance>();
  @$core.pragma('dart2js:noInline')
  static Insurance getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Insurance>(create);
  static Insurance? _defaultInstance;

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
  $core.String get accountId => $_getSZ(2);
  @$pb.TagNumber(3)
  set accountId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAccountId() => $_has(2);
  @$pb.TagNumber(3)
  void clearAccountId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get policyNumber => $_getSZ(3);
  @$pb.TagNumber(4)
  set policyNumber($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPolicyNumber() => $_has(3);
  @$pb.TagNumber(4)
  void clearPolicyNumber() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get planId => $_getSZ(4);
  @$pb.TagNumber(5)
  set planId($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasPlanId() => $_has(4);
  @$pb.TagNumber(5)
  void clearPlanId() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get planName => $_getSZ(5);
  @$pb.TagNumber(6)
  set planName($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasPlanName() => $_has(5);
  @$pb.TagNumber(6)
  void clearPlanName() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get coverageType => $_getSZ(6);
  @$pb.TagNumber(7)
  set coverageType($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasCoverageType() => $_has(6);
  @$pb.TagNumber(7)
  void clearCoverageType() => clearField(7);

  @$pb.TagNumber(8)
  $core.double get premium => $_getN(7);
  @$pb.TagNumber(8)
  set premium($core.double v) { $_setDouble(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasPremium() => $_has(7);
  @$pb.TagNumber(8)
  void clearPremium() => clearField(8);

  @$pb.TagNumber(9)
  $core.double get coverageAmount => $_getN(8);
  @$pb.TagNumber(9)
  set coverageAmount($core.double v) { $_setDouble(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasCoverageAmount() => $_has(8);
  @$pb.TagNumber(9)
  void clearCoverageAmount() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get paymentFrequency => $_getSZ(9);
  @$pb.TagNumber(10)
  set paymentFrequency($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasPaymentFrequency() => $_has(9);
  @$pb.TagNumber(10)
  void clearPaymentFrequency() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get status => $_getSZ(10);
  @$pb.TagNumber(11)
  set status($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasStatus() => $_has(10);
  @$pb.TagNumber(11)
  void clearStatus() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get startDate => $_getSZ(11);
  @$pb.TagNumber(12)
  set startDate($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasStartDate() => $_has(11);
  @$pb.TagNumber(12)
  void clearStartDate() => clearField(12);

  @$pb.TagNumber(13)
  $core.String get endDate => $_getSZ(12);
  @$pb.TagNumber(13)
  set endDate($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasEndDate() => $_has(12);
  @$pb.TagNumber(13)
  void clearEndDate() => clearField(13);

  @$pb.TagNumber(14)
  $core.String get nextPaymentDate => $_getSZ(13);
  @$pb.TagNumber(14)
  set nextPaymentDate($core.String v) { $_setString(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasNextPaymentDate() => $_has(13);
  @$pb.TagNumber(14)
  void clearNextPaymentDate() => clearField(14);

  @$pb.TagNumber(15)
  $core.String get beneficiary => $_getSZ(14);
  @$pb.TagNumber(15)
  set beneficiary($core.String v) { $_setString(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasBeneficiary() => $_has(14);
  @$pb.TagNumber(15)
  void clearBeneficiary() => clearField(15);

  @$pb.TagNumber(16)
  $core.String get metadata => $_getSZ(15);
  @$pb.TagNumber(16)
  set metadata($core.String v) { $_setString(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasMetadata() => $_has(15);
  @$pb.TagNumber(16)
  void clearMetadata() => clearField(16);

  @$pb.TagNumber(17)
  $core.String get createdAt => $_getSZ(16);
  @$pb.TagNumber(17)
  set createdAt($core.String v) { $_setString(16, v); }
  @$pb.TagNumber(17)
  $core.bool hasCreatedAt() => $_has(16);
  @$pb.TagNumber(17)
  void clearCreatedAt() => clearField(17);

  @$pb.TagNumber(18)
  $core.String get updatedAt => $_getSZ(17);
  @$pb.TagNumber(18)
  set updatedAt($core.String v) { $_setString(17, v); }
  @$pb.TagNumber(18)
  $core.bool hasUpdatedAt() => $_has(17);
  @$pb.TagNumber(18)
  void clearUpdatedAt() => clearField(18);
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
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (name != null) {
      $result.name = name;
    }
    if (coverageType != null) {
      $result.coverageType = coverageType;
    }
    if (description != null) {
      $result.description = description;
    }
    if (minPremium != null) {
      $result.minPremium = minPremium;
    }
    if (maxPremium != null) {
      $result.maxPremium = maxPremium;
    }
    if (coverageAmount != null) {
      $result.coverageAmount = coverageAmount;
    }
    if (benefits != null) {
      $result.benefits.addAll(benefits);
    }
    if (terms != null) {
      $result.terms = terms;
    }
    if (isActive != null) {
      $result.isActive = isActive;
    }
    return $result;
  }
  InsurancePlan._() : super();
  factory InsurancePlan.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InsurancePlan.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'InsurancePlan', package: const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'coverageType')
    ..aOS(4, _omitFieldNames ? '' : 'description')
    ..a<$core.double>(5, _omitFieldNames ? '' : 'minPremium', $pb.PbFieldType.OD)
    ..a<$core.double>(6, _omitFieldNames ? '' : 'maxPremium', $pb.PbFieldType.OD)
    ..a<$core.double>(7, _omitFieldNames ? '' : 'coverageAmount', $pb.PbFieldType.OD)
    ..pPS(8, _omitFieldNames ? '' : 'benefits')
    ..aOS(9, _omitFieldNames ? '' : 'terms')
    ..aOB(10, _omitFieldNames ? '' : 'isActive')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InsurancePlan clone() => InsurancePlan()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InsurancePlan copyWith(void Function(InsurancePlan) updates) => super.copyWith((message) => updates(message as InsurancePlan)) as InsurancePlan;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InsurancePlan create() => InsurancePlan._();
  InsurancePlan createEmptyInstance() => create();
  static $pb.PbList<InsurancePlan> createRepeated() => $pb.PbList<InsurancePlan>();
  @$core.pragma('dart2js:noInline')
  static InsurancePlan getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InsurancePlan>(create);
  static InsurancePlan? _defaultInstance;

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
  $core.String get coverageType => $_getSZ(2);
  @$pb.TagNumber(3)
  set coverageType($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCoverageType() => $_has(2);
  @$pb.TagNumber(3)
  void clearCoverageType() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get description => $_getSZ(3);
  @$pb.TagNumber(4)
  set description($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasDescription() => $_has(3);
  @$pb.TagNumber(4)
  void clearDescription() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get minPremium => $_getN(4);
  @$pb.TagNumber(5)
  set minPremium($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasMinPremium() => $_has(4);
  @$pb.TagNumber(5)
  void clearMinPremium() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get maxPremium => $_getN(5);
  @$pb.TagNumber(6)
  set maxPremium($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasMaxPremium() => $_has(5);
  @$pb.TagNumber(6)
  void clearMaxPremium() => clearField(6);

  @$pb.TagNumber(7)
  $core.double get coverageAmount => $_getN(6);
  @$pb.TagNumber(7)
  set coverageAmount($core.double v) { $_setDouble(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasCoverageAmount() => $_has(6);
  @$pb.TagNumber(7)
  void clearCoverageAmount() => clearField(7);

  @$pb.TagNumber(8)
  $core.List<$core.String> get benefits => $_getList(7);

  @$pb.TagNumber(9)
  $core.String get terms => $_getSZ(8);
  @$pb.TagNumber(9)
  set terms($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasTerms() => $_has(8);
  @$pb.TagNumber(9)
  void clearTerms() => clearField(9);

  @$pb.TagNumber(10)
  $core.bool get isActive => $_getBF(9);
  @$pb.TagNumber(10)
  set isActive($core.bool v) { $_setBool(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasIsActive() => $_has(9);
  @$pb.TagNumber(10)
  void clearIsActive() => clearField(10);
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
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (policyId != null) {
      $result.policyId = policyId;
    }
    if (userId != null) {
      $result.userId = userId;
    }
    if (claimAmount != null) {
      $result.claimAmount = claimAmount;
    }
    if (reason != null) {
      $result.reason = reason;
    }
    if (status != null) {
      $result.status = status;
    }
    if (documents != null) {
      $result.documents = documents;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      $result.updatedAt = updatedAt;
    }
    return $result;
  }
  InsuranceClaim._() : super();
  factory InsuranceClaim.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InsuranceClaim.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'InsuranceClaim', package: const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'policyId')
    ..aOS(3, _omitFieldNames ? '' : 'userId')
    ..a<$core.double>(4, _omitFieldNames ? '' : 'claimAmount', $pb.PbFieldType.OD)
    ..aOS(5, _omitFieldNames ? '' : 'reason')
    ..aOS(6, _omitFieldNames ? '' : 'status')
    ..aOS(7, _omitFieldNames ? '' : 'documents')
    ..aOS(8, _omitFieldNames ? '' : 'createdAt')
    ..aOS(9, _omitFieldNames ? '' : 'updatedAt')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InsuranceClaim clone() => InsuranceClaim()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InsuranceClaim copyWith(void Function(InsuranceClaim) updates) => super.copyWith((message) => updates(message as InsuranceClaim)) as InsuranceClaim;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InsuranceClaim create() => InsuranceClaim._();
  InsuranceClaim createEmptyInstance() => create();
  static $pb.PbList<InsuranceClaim> createRepeated() => $pb.PbList<InsuranceClaim>();
  @$core.pragma('dart2js:noInline')
  static InsuranceClaim getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InsuranceClaim>(create);
  static InsuranceClaim? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get policyId => $_getSZ(1);
  @$pb.TagNumber(2)
  set policyId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPolicyId() => $_has(1);
  @$pb.TagNumber(2)
  void clearPolicyId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get userId => $_getSZ(2);
  @$pb.TagNumber(3)
  set userId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasUserId() => $_has(2);
  @$pb.TagNumber(3)
  void clearUserId() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get claimAmount => $_getN(3);
  @$pb.TagNumber(4)
  set claimAmount($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasClaimAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearClaimAmount() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get reason => $_getSZ(4);
  @$pb.TagNumber(5)
  set reason($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasReason() => $_has(4);
  @$pb.TagNumber(5)
  void clearReason() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get status => $_getSZ(5);
  @$pb.TagNumber(6)
  set status($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasStatus() => $_has(5);
  @$pb.TagNumber(6)
  void clearStatus() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get documents => $_getSZ(6);
  @$pb.TagNumber(7)
  set documents($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasDocuments() => $_has(6);
  @$pb.TagNumber(7)
  void clearDocuments() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get createdAt => $_getSZ(7);
  @$pb.TagNumber(8)
  set createdAt($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasCreatedAt() => $_has(7);
  @$pb.TagNumber(8)
  void clearCreatedAt() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get updatedAt => $_getSZ(8);
  @$pb.TagNumber(9)
  set updatedAt($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasUpdatedAt() => $_has(8);
  @$pb.TagNumber(9)
  void clearUpdatedAt() => clearField(9);
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
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (userId != null) {
      $result.userId = userId;
    }
    if (accountId != null) {
      $result.accountId = accountId;
    }
    if (title != null) {
      $result.title = title;
    }
    if (description != null) {
      $result.description = description;
    }
    if (category != null) {
      $result.category = category;
    }
    if (targetAmount != null) {
      $result.targetAmount = targetAmount;
    }
    if (currentAmount != null) {
      $result.currentAmount = currentAmount;
    }
    if (percentageFunded != null) {
      $result.percentageFunded = percentageFunded;
    }
    if (totalContributors != null) {
      $result.totalContributors = totalContributors;
    }
    if (status != null) {
      $result.status = status;
    }
    if (imageUrl != null) {
      $result.imageUrl = imageUrl;
    }
    if (deadline != null) {
      $result.deadline = deadline;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      $result.updatedAt = updatedAt;
    }
    return $result;
  }
  Crowdfund._() : super();
  factory Crowdfund.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Crowdfund.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Crowdfund', package: const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'accountId')
    ..aOS(4, _omitFieldNames ? '' : 'title')
    ..aOS(5, _omitFieldNames ? '' : 'description')
    ..aOS(6, _omitFieldNames ? '' : 'category')
    ..a<$core.double>(7, _omitFieldNames ? '' : 'targetAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(8, _omitFieldNames ? '' : 'currentAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(9, _omitFieldNames ? '' : 'percentageFunded', $pb.PbFieldType.OD)
    ..a<$core.int>(10, _omitFieldNames ? '' : 'totalContributors', $pb.PbFieldType.O3)
    ..aOS(11, _omitFieldNames ? '' : 'status')
    ..aOS(12, _omitFieldNames ? '' : 'imageUrl')
    ..aOS(13, _omitFieldNames ? '' : 'deadline')
    ..aOS(14, _omitFieldNames ? '' : 'createdAt')
    ..aOS(15, _omitFieldNames ? '' : 'updatedAt')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Crowdfund clone() => Crowdfund()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Crowdfund copyWith(void Function(Crowdfund) updates) => super.copyWith((message) => updates(message as Crowdfund)) as Crowdfund;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Crowdfund create() => Crowdfund._();
  Crowdfund createEmptyInstance() => create();
  static $pb.PbList<Crowdfund> createRepeated() => $pb.PbList<Crowdfund>();
  @$core.pragma('dart2js:noInline')
  static Crowdfund getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Crowdfund>(create);
  static Crowdfund? _defaultInstance;

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
  $core.String get accountId => $_getSZ(2);
  @$pb.TagNumber(3)
  set accountId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAccountId() => $_has(2);
  @$pb.TagNumber(3)
  void clearAccountId() => clearField(3);

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
  $core.String get category => $_getSZ(5);
  @$pb.TagNumber(6)
  set category($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasCategory() => $_has(5);
  @$pb.TagNumber(6)
  void clearCategory() => clearField(6);

  @$pb.TagNumber(7)
  $core.double get targetAmount => $_getN(6);
  @$pb.TagNumber(7)
  set targetAmount($core.double v) { $_setDouble(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasTargetAmount() => $_has(6);
  @$pb.TagNumber(7)
  void clearTargetAmount() => clearField(7);

  @$pb.TagNumber(8)
  $core.double get currentAmount => $_getN(7);
  @$pb.TagNumber(8)
  set currentAmount($core.double v) { $_setDouble(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasCurrentAmount() => $_has(7);
  @$pb.TagNumber(8)
  void clearCurrentAmount() => clearField(8);

  @$pb.TagNumber(9)
  $core.double get percentageFunded => $_getN(8);
  @$pb.TagNumber(9)
  set percentageFunded($core.double v) { $_setDouble(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasPercentageFunded() => $_has(8);
  @$pb.TagNumber(9)
  void clearPercentageFunded() => clearField(9);

  @$pb.TagNumber(10)
  $core.int get totalContributors => $_getIZ(9);
  @$pb.TagNumber(10)
  set totalContributors($core.int v) { $_setSignedInt32(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasTotalContributors() => $_has(9);
  @$pb.TagNumber(10)
  void clearTotalContributors() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get status => $_getSZ(10);
  @$pb.TagNumber(11)
  set status($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasStatus() => $_has(10);
  @$pb.TagNumber(11)
  void clearStatus() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get imageUrl => $_getSZ(11);
  @$pb.TagNumber(12)
  set imageUrl($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasImageUrl() => $_has(11);
  @$pb.TagNumber(12)
  void clearImageUrl() => clearField(12);

  @$pb.TagNumber(13)
  $core.String get deadline => $_getSZ(12);
  @$pb.TagNumber(13)
  set deadline($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasDeadline() => $_has(12);
  @$pb.TagNumber(13)
  void clearDeadline() => clearField(13);

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
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (crowdfundId != null) {
      $result.crowdfundId = crowdfundId;
    }
    if (userId != null) {
      $result.userId = userId;
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
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    return $result;
  }
  CrowdfundContribution._() : super();
  factory CrowdfundContribution.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CrowdfundContribution.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CrowdfundContribution', package: const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'crowdfundId')
    ..aOS(3, _omitFieldNames ? '' : 'userId')
    ..a<$core.double>(4, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(5, _omitFieldNames ? '' : 'message')
    ..aOB(6, _omitFieldNames ? '' : 'isAnonymous')
    ..aOS(7, _omitFieldNames ? '' : 'createdAt')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CrowdfundContribution clone() => CrowdfundContribution()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CrowdfundContribution copyWith(void Function(CrowdfundContribution) updates) => super.copyWith((message) => updates(message as CrowdfundContribution)) as CrowdfundContribution;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CrowdfundContribution create() => CrowdfundContribution._();
  CrowdfundContribution createEmptyInstance() => create();
  static $pb.PbList<CrowdfundContribution> createRepeated() => $pb.PbList<CrowdfundContribution>();
  @$core.pragma('dart2js:noInline')
  static CrowdfundContribution getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CrowdfundContribution>(create);
  static CrowdfundContribution? _defaultInstance;

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
  $core.String get userId => $_getSZ(2);
  @$pb.TagNumber(3)
  set userId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasUserId() => $_has(2);
  @$pb.TagNumber(3)
  void clearUserId() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get amount => $_getN(3);
  @$pb.TagNumber(4)
  set amount($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearAmount() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get message => $_getSZ(4);
  @$pb.TagNumber(5)
  set message($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasMessage() => $_has(4);
  @$pb.TagNumber(5)
  void clearMessage() => clearField(5);

  @$pb.TagNumber(6)
  $core.bool get isAnonymous => $_getBF(5);
  @$pb.TagNumber(6)
  set isAnonymous($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasIsAnonymous() => $_has(5);
  @$pb.TagNumber(6)
  void clearIsAnonymous() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get createdAt => $_getSZ(6);
  @$pb.TagNumber(7)
  set createdAt($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasCreatedAt() => $_has(6);
  @$pb.TagNumber(7)
  void clearCreatedAt() => clearField(7);
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
    final $result = create();
    if (accountId != null) {
      $result.accountId = accountId;
    }
    if (name != null) {
      $result.name = name;
    }
    if (description != null) {
      $result.description = description;
    }
    if (targetAmount != null) {
      $result.targetAmount = targetAmount;
    }
    if (withdrawalRules != null) {
      $result.withdrawalRules = withdrawalRules;
    }
    if (memberIds != null) {
      $result.memberIds.addAll(memberIds);
    }
    return $result;
  }
  CreateGroupAccountRequest._() : super();
  factory CreateGroupAccountRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateGroupAccountRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateGroupAccountRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountId')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..a<$core.double>(4, _omitFieldNames ? '' : 'targetAmount', $pb.PbFieldType.OD)
    ..aOS(5, _omitFieldNames ? '' : 'withdrawalRules')
    ..pPS(6, _omitFieldNames ? '' : 'memberIds')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateGroupAccountRequest clone() => CreateGroupAccountRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateGroupAccountRequest copyWith(void Function(CreateGroupAccountRequest) updates) => super.copyWith((message) => updates(message as CreateGroupAccountRequest)) as CreateGroupAccountRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateGroupAccountRequest create() => CreateGroupAccountRequest._();
  CreateGroupAccountRequest createEmptyInstance() => create();
  static $pb.PbList<CreateGroupAccountRequest> createRepeated() => $pb.PbList<CreateGroupAccountRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateGroupAccountRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateGroupAccountRequest>(create);
  static CreateGroupAccountRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => clearField(1);

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
  $core.double get targetAmount => $_getN(3);
  @$pb.TagNumber(4)
  set targetAmount($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTargetAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearTargetAmount() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get withdrawalRules => $_getSZ(4);
  @$pb.TagNumber(5)
  set withdrawalRules($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasWithdrawalRules() => $_has(4);
  @$pb.TagNumber(5)
  void clearWithdrawalRules() => clearField(5);

  @$pb.TagNumber(6)
  $core.List<$core.String> get memberIds => $_getList(5);
}

class CreateGroupAccountResponse extends $pb.GeneratedMessage {
  factory CreateGroupAccountResponse({
    GroupAccount? groupAccount,
    $core.String? message,
  }) {
    final $result = create();
    if (groupAccount != null) {
      $result.groupAccount = groupAccount;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  CreateGroupAccountResponse._() : super();
  factory CreateGroupAccountResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateGroupAccountResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateGroupAccountResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOM<GroupAccount>(1, _omitFieldNames ? '' : 'groupAccount', subBuilder: GroupAccount.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateGroupAccountResponse clone() => CreateGroupAccountResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateGroupAccountResponse copyWith(void Function(CreateGroupAccountResponse) updates) => super.copyWith((message) => updates(message as CreateGroupAccountResponse)) as CreateGroupAccountResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateGroupAccountResponse create() => CreateGroupAccountResponse._();
  CreateGroupAccountResponse createEmptyInstance() => create();
  static $pb.PbList<CreateGroupAccountResponse> createRepeated() => $pb.PbList<CreateGroupAccountResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateGroupAccountResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateGroupAccountResponse>(create);
  static CreateGroupAccountResponse? _defaultInstance;

  @$pb.TagNumber(1)
  GroupAccount get groupAccount => $_getN(0);
  @$pb.TagNumber(1)
  set groupAccount(GroupAccount v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasGroupAccount() => $_has(0);
  @$pb.TagNumber(1)
  void clearGroupAccount() => clearField(1);
  @$pb.TagNumber(1)
  GroupAccount ensureGroupAccount() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

/// NOTE: user_id extracted from JWT token, not from request
class GetGroupAccountsRequest extends $pb.GeneratedMessage {
  factory GetGroupAccountsRequest({
    $core.String? status,
    $core.int? limit,
    $core.int? offset,
  }) {
    final $result = create();
    if (status != null) {
      $result.status = status;
    }
    if (limit != null) {
      $result.limit = limit;
    }
    if (offset != null) {
      $result.offset = offset;
    }
    return $result;
  }
  GetGroupAccountsRequest._() : super();
  factory GetGroupAccountsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetGroupAccountsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetGroupAccountsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'status')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetGroupAccountsRequest clone() => GetGroupAccountsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetGroupAccountsRequest copyWith(void Function(GetGroupAccountsRequest) updates) => super.copyWith((message) => updates(message as GetGroupAccountsRequest)) as GetGroupAccountsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetGroupAccountsRequest create() => GetGroupAccountsRequest._();
  GetGroupAccountsRequest createEmptyInstance() => create();
  static $pb.PbList<GetGroupAccountsRequest> createRepeated() => $pb.PbList<GetGroupAccountsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetGroupAccountsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetGroupAccountsRequest>(create);
  static GetGroupAccountsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get status => $_getSZ(0);
  @$pb.TagNumber(1)
  set status($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get limit => $_getIZ(1);
  @$pb.TagNumber(2)
  set limit($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearLimit() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get offset => $_getIZ(2);
  @$pb.TagNumber(3)
  set offset($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasOffset() => $_has(2);
  @$pb.TagNumber(3)
  void clearOffset() => clearField(3);
}

class GetGroupAccountsResponse extends $pb.GeneratedMessage {
  factory GetGroupAccountsResponse({
    $core.Iterable<GroupAccount>? groupAccounts,
    $core.int? total,
  }) {
    final $result = create();
    if (groupAccounts != null) {
      $result.groupAccounts.addAll(groupAccounts);
    }
    if (total != null) {
      $result.total = total;
    }
    return $result;
  }
  GetGroupAccountsResponse._() : super();
  factory GetGroupAccountsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetGroupAccountsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetGroupAccountsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'), createEmptyInstance: create)
    ..pc<GroupAccount>(1, _omitFieldNames ? '' : 'groupAccounts', $pb.PbFieldType.PM, subBuilder: GroupAccount.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetGroupAccountsResponse clone() => GetGroupAccountsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetGroupAccountsResponse copyWith(void Function(GetGroupAccountsResponse) updates) => super.copyWith((message) => updates(message as GetGroupAccountsResponse)) as GetGroupAccountsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetGroupAccountsResponse create() => GetGroupAccountsResponse._();
  GetGroupAccountsResponse createEmptyInstance() => create();
  static $pb.PbList<GetGroupAccountsResponse> createRepeated() => $pb.PbList<GetGroupAccountsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetGroupAccountsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetGroupAccountsResponse>(create);
  static GetGroupAccountsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<GroupAccount> get groupAccounts => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => clearField(2);
}

/// NOTE: user_id extracted from JWT token, not from request
class GetGroupAccountRequest extends $pb.GeneratedMessage {
  factory GetGroupAccountRequest({
    $core.String? groupId,
  }) {
    final $result = create();
    if (groupId != null) {
      $result.groupId = groupId;
    }
    return $result;
  }
  GetGroupAccountRequest._() : super();
  factory GetGroupAccountRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetGroupAccountRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetGroupAccountRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'groupId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetGroupAccountRequest clone() => GetGroupAccountRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetGroupAccountRequest copyWith(void Function(GetGroupAccountRequest) updates) => super.copyWith((message) => updates(message as GetGroupAccountRequest)) as GetGroupAccountRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetGroupAccountRequest create() => GetGroupAccountRequest._();
  GetGroupAccountRequest createEmptyInstance() => create();
  static $pb.PbList<GetGroupAccountRequest> createRepeated() => $pb.PbList<GetGroupAccountRequest>();
  @$core.pragma('dart2js:noInline')
  static GetGroupAccountRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetGroupAccountRequest>(create);
  static GetGroupAccountRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get groupId => $_getSZ(0);
  @$pb.TagNumber(1)
  set groupId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasGroupId() => $_has(0);
  @$pb.TagNumber(1)
  void clearGroupId() => clearField(1);
}

class GetGroupAccountResponse extends $pb.GeneratedMessage {
  factory GetGroupAccountResponse({
    GroupAccount? groupAccount,
  }) {
    final $result = create();
    if (groupAccount != null) {
      $result.groupAccount = groupAccount;
    }
    return $result;
  }
  GetGroupAccountResponse._() : super();
  factory GetGroupAccountResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetGroupAccountResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetGroupAccountResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOM<GroupAccount>(1, _omitFieldNames ? '' : 'groupAccount', subBuilder: GroupAccount.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetGroupAccountResponse clone() => GetGroupAccountResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetGroupAccountResponse copyWith(void Function(GetGroupAccountResponse) updates) => super.copyWith((message) => updates(message as GetGroupAccountResponse)) as GetGroupAccountResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetGroupAccountResponse create() => GetGroupAccountResponse._();
  GetGroupAccountResponse createEmptyInstance() => create();
  static $pb.PbList<GetGroupAccountResponse> createRepeated() => $pb.PbList<GetGroupAccountResponse>();
  @$core.pragma('dart2js:noInline')
  static GetGroupAccountResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetGroupAccountResponse>(create);
  static GetGroupAccountResponse? _defaultInstance;

  @$pb.TagNumber(1)
  GroupAccount get groupAccount => $_getN(0);
  @$pb.TagNumber(1)
  set groupAccount(GroupAccount v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasGroupAccount() => $_has(0);
  @$pb.TagNumber(1)
  void clearGroupAccount() => clearField(1);
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
    final $result = create();
    if (groupId != null) {
      $result.groupId = groupId;
    }
    if (memberId != null) {
      $result.memberId = memberId;
    }
    if (role != null) {
      $result.role = role;
    }
    return $result;
  }
  AddGroupMemberRequest._() : super();
  factory AddGroupMemberRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddGroupMemberRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AddGroupMemberRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'groupId')
    ..aOS(2, _omitFieldNames ? '' : 'memberId')
    ..aOS(3, _omitFieldNames ? '' : 'role')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddGroupMemberRequest clone() => AddGroupMemberRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddGroupMemberRequest copyWith(void Function(AddGroupMemberRequest) updates) => super.copyWith((message) => updates(message as AddGroupMemberRequest)) as AddGroupMemberRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddGroupMemberRequest create() => AddGroupMemberRequest._();
  AddGroupMemberRequest createEmptyInstance() => create();
  static $pb.PbList<AddGroupMemberRequest> createRepeated() => $pb.PbList<AddGroupMemberRequest>();
  @$core.pragma('dart2js:noInline')
  static AddGroupMemberRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddGroupMemberRequest>(create);
  static AddGroupMemberRequest? _defaultInstance;

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
  $core.String get role => $_getSZ(2);
  @$pb.TagNumber(3)
  set role($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasRole() => $_has(2);
  @$pb.TagNumber(3)
  void clearRole() => clearField(3);
}

class AddGroupMemberResponse extends $pb.GeneratedMessage {
  factory AddGroupMemberResponse({
    GroupAccount? groupAccount,
    $core.String? message,
  }) {
    final $result = create();
    if (groupAccount != null) {
      $result.groupAccount = groupAccount;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  AddGroupMemberResponse._() : super();
  factory AddGroupMemberResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddGroupMemberResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AddGroupMemberResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOM<GroupAccount>(1, _omitFieldNames ? '' : 'groupAccount', subBuilder: GroupAccount.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddGroupMemberResponse clone() => AddGroupMemberResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddGroupMemberResponse copyWith(void Function(AddGroupMemberResponse) updates) => super.copyWith((message) => updates(message as AddGroupMemberResponse)) as AddGroupMemberResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddGroupMemberResponse create() => AddGroupMemberResponse._();
  AddGroupMemberResponse createEmptyInstance() => create();
  static $pb.PbList<AddGroupMemberResponse> createRepeated() => $pb.PbList<AddGroupMemberResponse>();
  @$core.pragma('dart2js:noInline')
  static AddGroupMemberResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddGroupMemberResponse>(create);
  static AddGroupMemberResponse? _defaultInstance;

  @$pb.TagNumber(1)
  GroupAccount get groupAccount => $_getN(0);
  @$pb.TagNumber(1)
  set groupAccount(GroupAccount v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasGroupAccount() => $_has(0);
  @$pb.TagNumber(1)
  void clearGroupAccount() => clearField(1);
  @$pb.TagNumber(1)
  GroupAccount ensureGroupAccount() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

/// NOTE: user_id extracted from JWT token, not from request
class RemoveGroupMemberRequest extends $pb.GeneratedMessage {
  factory RemoveGroupMemberRequest({
    $core.String? groupId,
    $core.String? memberId,
  }) {
    final $result = create();
    if (groupId != null) {
      $result.groupId = groupId;
    }
    if (memberId != null) {
      $result.memberId = memberId;
    }
    return $result;
  }
  RemoveGroupMemberRequest._() : super();
  factory RemoveGroupMemberRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RemoveGroupMemberRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RemoveGroupMemberRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'groupId')
    ..aOS(2, _omitFieldNames ? '' : 'memberId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RemoveGroupMemberRequest clone() => RemoveGroupMemberRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RemoveGroupMemberRequest copyWith(void Function(RemoveGroupMemberRequest) updates) => super.copyWith((message) => updates(message as RemoveGroupMemberRequest)) as RemoveGroupMemberRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RemoveGroupMemberRequest create() => RemoveGroupMemberRequest._();
  RemoveGroupMemberRequest createEmptyInstance() => create();
  static $pb.PbList<RemoveGroupMemberRequest> createRepeated() => $pb.PbList<RemoveGroupMemberRequest>();
  @$core.pragma('dart2js:noInline')
  static RemoveGroupMemberRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RemoveGroupMemberRequest>(create);
  static RemoveGroupMemberRequest? _defaultInstance;

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

class RemoveGroupMemberResponse extends $pb.GeneratedMessage {
  factory RemoveGroupMemberResponse({
    GroupAccount? groupAccount,
    $core.String? message,
  }) {
    final $result = create();
    if (groupAccount != null) {
      $result.groupAccount = groupAccount;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  RemoveGroupMemberResponse._() : super();
  factory RemoveGroupMemberResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RemoveGroupMemberResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RemoveGroupMemberResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOM<GroupAccount>(1, _omitFieldNames ? '' : 'groupAccount', subBuilder: GroupAccount.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RemoveGroupMemberResponse clone() => RemoveGroupMemberResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RemoveGroupMemberResponse copyWith(void Function(RemoveGroupMemberResponse) updates) => super.copyWith((message) => updates(message as RemoveGroupMemberResponse)) as RemoveGroupMemberResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RemoveGroupMemberResponse create() => RemoveGroupMemberResponse._();
  RemoveGroupMemberResponse createEmptyInstance() => create();
  static $pb.PbList<RemoveGroupMemberResponse> createRepeated() => $pb.PbList<RemoveGroupMemberResponse>();
  @$core.pragma('dart2js:noInline')
  static RemoveGroupMemberResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RemoveGroupMemberResponse>(create);
  static RemoveGroupMemberResponse? _defaultInstance;

  @$pb.TagNumber(1)
  GroupAccount get groupAccount => $_getN(0);
  @$pb.TagNumber(1)
  set groupAccount(GroupAccount v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasGroupAccount() => $_has(0);
  @$pb.TagNumber(1)
  void clearGroupAccount() => clearField(1);
  @$pb.TagNumber(1)
  GroupAccount ensureGroupAccount() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

/// NOTE: user_id extracted from JWT token, not from request
class ContributeToGroupRequest extends $pb.GeneratedMessage {
  factory ContributeToGroupRequest({
    $core.String? groupId,
    $core.String? accountId,
    $core.double? amount,
    $core.String? pin,
  }) {
    final $result = create();
    if (groupId != null) {
      $result.groupId = groupId;
    }
    if (accountId != null) {
      $result.accountId = accountId;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (pin != null) {
      $result.pin = pin;
    }
    return $result;
  }
  ContributeToGroupRequest._() : super();
  factory ContributeToGroupRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ContributeToGroupRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ContributeToGroupRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'groupId')
    ..aOS(2, _omitFieldNames ? '' : 'accountId')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(4, _omitFieldNames ? '' : 'pin')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ContributeToGroupRequest clone() => ContributeToGroupRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ContributeToGroupRequest copyWith(void Function(ContributeToGroupRequest) updates) => super.copyWith((message) => updates(message as ContributeToGroupRequest)) as ContributeToGroupRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ContributeToGroupRequest create() => ContributeToGroupRequest._();
  ContributeToGroupRequest createEmptyInstance() => create();
  static $pb.PbList<ContributeToGroupRequest> createRepeated() => $pb.PbList<ContributeToGroupRequest>();
  @$core.pragma('dart2js:noInline')
  static ContributeToGroupRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ContributeToGroupRequest>(create);
  static ContributeToGroupRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get groupId => $_getSZ(0);
  @$pb.TagNumber(1)
  set groupId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasGroupId() => $_has(0);
  @$pb.TagNumber(1)
  void clearGroupId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get accountId => $_getSZ(1);
  @$pb.TagNumber(2)
  set accountId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAccountId() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccountId() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get amount => $_getN(2);
  @$pb.TagNumber(3)
  set amount($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get pin => $_getSZ(3);
  @$pb.TagNumber(4)
  set pin($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPin() => $_has(3);
  @$pb.TagNumber(4)
  void clearPin() => clearField(4);
}

class ContributeToGroupResponse extends $pb.GeneratedMessage {
  factory ContributeToGroupResponse({
    GroupAccount? groupAccount,
    $core.double? newBalance,
    $core.String? message,
  }) {
    final $result = create();
    if (groupAccount != null) {
      $result.groupAccount = groupAccount;
    }
    if (newBalance != null) {
      $result.newBalance = newBalance;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  ContributeToGroupResponse._() : super();
  factory ContributeToGroupResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ContributeToGroupResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ContributeToGroupResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOM<GroupAccount>(1, _omitFieldNames ? '' : 'groupAccount', subBuilder: GroupAccount.create)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'newBalance', $pb.PbFieldType.OD)
    ..aOS(3, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ContributeToGroupResponse clone() => ContributeToGroupResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ContributeToGroupResponse copyWith(void Function(ContributeToGroupResponse) updates) => super.copyWith((message) => updates(message as ContributeToGroupResponse)) as ContributeToGroupResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ContributeToGroupResponse create() => ContributeToGroupResponse._();
  ContributeToGroupResponse createEmptyInstance() => create();
  static $pb.PbList<ContributeToGroupResponse> createRepeated() => $pb.PbList<ContributeToGroupResponse>();
  @$core.pragma('dart2js:noInline')
  static ContributeToGroupResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ContributeToGroupResponse>(create);
  static ContributeToGroupResponse? _defaultInstance;

  @$pb.TagNumber(1)
  GroupAccount get groupAccount => $_getN(0);
  @$pb.TagNumber(1)
  set groupAccount(GroupAccount v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasGroupAccount() => $_has(0);
  @$pb.TagNumber(1)
  void clearGroupAccount() => clearField(1);
  @$pb.TagNumber(1)
  GroupAccount ensureGroupAccount() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.double get newBalance => $_getN(1);
  @$pb.TagNumber(2)
  set newBalance($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasNewBalance() => $_has(1);
  @$pb.TagNumber(2)
  void clearNewBalance() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => clearField(3);
}

/// NOTE: user_id extracted from JWT token, not from request
class WithdrawFromGroupRequest extends $pb.GeneratedMessage {
  factory WithdrawFromGroupRequest({
    $core.String? groupId,
    $core.double? amount,
    $core.String? reason,
    $core.String? pin,
  }) {
    final $result = create();
    if (groupId != null) {
      $result.groupId = groupId;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (reason != null) {
      $result.reason = reason;
    }
    if (pin != null) {
      $result.pin = pin;
    }
    return $result;
  }
  WithdrawFromGroupRequest._() : super();
  factory WithdrawFromGroupRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WithdrawFromGroupRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'WithdrawFromGroupRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'groupId')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(3, _omitFieldNames ? '' : 'reason')
    ..aOS(4, _omitFieldNames ? '' : 'pin')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  WithdrawFromGroupRequest clone() => WithdrawFromGroupRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  WithdrawFromGroupRequest copyWith(void Function(WithdrawFromGroupRequest) updates) => super.copyWith((message) => updates(message as WithdrawFromGroupRequest)) as WithdrawFromGroupRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WithdrawFromGroupRequest create() => WithdrawFromGroupRequest._();
  WithdrawFromGroupRequest createEmptyInstance() => create();
  static $pb.PbList<WithdrawFromGroupRequest> createRepeated() => $pb.PbList<WithdrawFromGroupRequest>();
  @$core.pragma('dart2js:noInline')
  static WithdrawFromGroupRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WithdrawFromGroupRequest>(create);
  static WithdrawFromGroupRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get groupId => $_getSZ(0);
  @$pb.TagNumber(1)
  set groupId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasGroupId() => $_has(0);
  @$pb.TagNumber(1)
  void clearGroupId() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get amount => $_getN(1);
  @$pb.TagNumber(2)
  set amount($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get reason => $_getSZ(2);
  @$pb.TagNumber(3)
  set reason($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasReason() => $_has(2);
  @$pb.TagNumber(3)
  void clearReason() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get pin => $_getSZ(3);
  @$pb.TagNumber(4)
  set pin($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPin() => $_has(3);
  @$pb.TagNumber(4)
  void clearPin() => clearField(4);
}

class WithdrawFromGroupResponse extends $pb.GeneratedMessage {
  factory WithdrawFromGroupResponse({
    GroupAccount? groupAccount,
    $core.String? message,
  }) {
    final $result = create();
    if (groupAccount != null) {
      $result.groupAccount = groupAccount;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  WithdrawFromGroupResponse._() : super();
  factory WithdrawFromGroupResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WithdrawFromGroupResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'WithdrawFromGroupResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOM<GroupAccount>(1, _omitFieldNames ? '' : 'groupAccount', subBuilder: GroupAccount.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  WithdrawFromGroupResponse clone() => WithdrawFromGroupResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  WithdrawFromGroupResponse copyWith(void Function(WithdrawFromGroupResponse) updates) => super.copyWith((message) => updates(message as WithdrawFromGroupResponse)) as WithdrawFromGroupResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WithdrawFromGroupResponse create() => WithdrawFromGroupResponse._();
  WithdrawFromGroupResponse createEmptyInstance() => create();
  static $pb.PbList<WithdrawFromGroupResponse> createRepeated() => $pb.PbList<WithdrawFromGroupResponse>();
  @$core.pragma('dart2js:noInline')
  static WithdrawFromGroupResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WithdrawFromGroupResponse>(create);
  static WithdrawFromGroupResponse? _defaultInstance;

  @$pb.TagNumber(1)
  GroupAccount get groupAccount => $_getN(0);
  @$pb.TagNumber(1)
  set groupAccount(GroupAccount v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasGroupAccount() => $_has(0);
  @$pb.TagNumber(1)
  void clearGroupAccount() => clearField(1);
  @$pb.TagNumber(1)
  GroupAccount ensureGroupAccount() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

/// NOTE: user_id extracted from JWT token, not from request
class CloseGroupAccountRequest extends $pb.GeneratedMessage {
  factory CloseGroupAccountRequest({
    $core.String? groupId,
    $core.String? pin,
  }) {
    final $result = create();
    if (groupId != null) {
      $result.groupId = groupId;
    }
    if (pin != null) {
      $result.pin = pin;
    }
    return $result;
  }
  CloseGroupAccountRequest._() : super();
  factory CloseGroupAccountRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CloseGroupAccountRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CloseGroupAccountRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'groupId')
    ..aOS(2, _omitFieldNames ? '' : 'pin')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CloseGroupAccountRequest clone() => CloseGroupAccountRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CloseGroupAccountRequest copyWith(void Function(CloseGroupAccountRequest) updates) => super.copyWith((message) => updates(message as CloseGroupAccountRequest)) as CloseGroupAccountRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CloseGroupAccountRequest create() => CloseGroupAccountRequest._();
  CloseGroupAccountRequest createEmptyInstance() => create();
  static $pb.PbList<CloseGroupAccountRequest> createRepeated() => $pb.PbList<CloseGroupAccountRequest>();
  @$core.pragma('dart2js:noInline')
  static CloseGroupAccountRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CloseGroupAccountRequest>(create);
  static CloseGroupAccountRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get groupId => $_getSZ(0);
  @$pb.TagNumber(1)
  set groupId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasGroupId() => $_has(0);
  @$pb.TagNumber(1)
  void clearGroupId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get pin => $_getSZ(1);
  @$pb.TagNumber(2)
  set pin($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPin() => $_has(1);
  @$pb.TagNumber(2)
  void clearPin() => clearField(2);
}

class CloseGroupAccountResponse extends $pb.GeneratedMessage {
  factory CloseGroupAccountResponse({
    GroupAccount? groupAccount,
    $core.String? message,
  }) {
    final $result = create();
    if (groupAccount != null) {
      $result.groupAccount = groupAccount;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  CloseGroupAccountResponse._() : super();
  factory CloseGroupAccountResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CloseGroupAccountResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CloseGroupAccountResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOM<GroupAccount>(1, _omitFieldNames ? '' : 'groupAccount', subBuilder: GroupAccount.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CloseGroupAccountResponse clone() => CloseGroupAccountResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CloseGroupAccountResponse copyWith(void Function(CloseGroupAccountResponse) updates) => super.copyWith((message) => updates(message as CloseGroupAccountResponse)) as CloseGroupAccountResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CloseGroupAccountResponse create() => CloseGroupAccountResponse._();
  CloseGroupAccountResponse createEmptyInstance() => create();
  static $pb.PbList<CloseGroupAccountResponse> createRepeated() => $pb.PbList<CloseGroupAccountResponse>();
  @$core.pragma('dart2js:noInline')
  static CloseGroupAccountResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CloseGroupAccountResponse>(create);
  static CloseGroupAccountResponse? _defaultInstance;

  @$pb.TagNumber(1)
  GroupAccount get groupAccount => $_getN(0);
  @$pb.TagNumber(1)
  set groupAccount(GroupAccount v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasGroupAccount() => $_has(0);
  @$pb.TagNumber(1)
  void clearGroupAccount() => clearField(1);
  @$pb.TagNumber(1)
  GroupAccount ensureGroupAccount() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
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
    final $result = create();
    if (accountId != null) {
      $result.accountId = accountId;
    }
    if (planId != null) {
      $result.planId = planId;
    }
    if (coverageAmount != null) {
      $result.coverageAmount = coverageAmount;
    }
    if (paymentFrequency != null) {
      $result.paymentFrequency = paymentFrequency;
    }
    if (beneficiary != null) {
      $result.beneficiary = beneficiary;
    }
    if (pin != null) {
      $result.pin = pin;
    }
    return $result;
  }
  BuyInsuranceRequest._() : super();
  factory BuyInsuranceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BuyInsuranceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'BuyInsuranceRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountId')
    ..aOS(2, _omitFieldNames ? '' : 'planId')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'coverageAmount', $pb.PbFieldType.OD)
    ..aOS(4, _omitFieldNames ? '' : 'paymentFrequency')
    ..aOS(5, _omitFieldNames ? '' : 'beneficiary')
    ..aOS(6, _omitFieldNames ? '' : 'pin')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BuyInsuranceRequest clone() => BuyInsuranceRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BuyInsuranceRequest copyWith(void Function(BuyInsuranceRequest) updates) => super.copyWith((message) => updates(message as BuyInsuranceRequest)) as BuyInsuranceRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BuyInsuranceRequest create() => BuyInsuranceRequest._();
  BuyInsuranceRequest createEmptyInstance() => create();
  static $pb.PbList<BuyInsuranceRequest> createRepeated() => $pb.PbList<BuyInsuranceRequest>();
  @$core.pragma('dart2js:noInline')
  static BuyInsuranceRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BuyInsuranceRequest>(create);
  static BuyInsuranceRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get planId => $_getSZ(1);
  @$pb.TagNumber(2)
  set planId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPlanId() => $_has(1);
  @$pb.TagNumber(2)
  void clearPlanId() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get coverageAmount => $_getN(2);
  @$pb.TagNumber(3)
  set coverageAmount($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCoverageAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearCoverageAmount() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get paymentFrequency => $_getSZ(3);
  @$pb.TagNumber(4)
  set paymentFrequency($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPaymentFrequency() => $_has(3);
  @$pb.TagNumber(4)
  void clearPaymentFrequency() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get beneficiary => $_getSZ(4);
  @$pb.TagNumber(5)
  set beneficiary($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasBeneficiary() => $_has(4);
  @$pb.TagNumber(5)
  void clearBeneficiary() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get pin => $_getSZ(5);
  @$pb.TagNumber(6)
  set pin($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasPin() => $_has(5);
  @$pb.TagNumber(6)
  void clearPin() => clearField(6);
}

class BuyInsuranceResponse extends $pb.GeneratedMessage {
  factory BuyInsuranceResponse({
    Insurance? insurance,
    $core.double? firstPremium,
    $core.double? newBalance,
    $core.String? message,
  }) {
    final $result = create();
    if (insurance != null) {
      $result.insurance = insurance;
    }
    if (firstPremium != null) {
      $result.firstPremium = firstPremium;
    }
    if (newBalance != null) {
      $result.newBalance = newBalance;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  BuyInsuranceResponse._() : super();
  factory BuyInsuranceResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BuyInsuranceResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'BuyInsuranceResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOM<Insurance>(1, _omitFieldNames ? '' : 'insurance', subBuilder: Insurance.create)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'firstPremium', $pb.PbFieldType.OD)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'newBalance', $pb.PbFieldType.OD)
    ..aOS(4, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BuyInsuranceResponse clone() => BuyInsuranceResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BuyInsuranceResponse copyWith(void Function(BuyInsuranceResponse) updates) => super.copyWith((message) => updates(message as BuyInsuranceResponse)) as BuyInsuranceResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BuyInsuranceResponse create() => BuyInsuranceResponse._();
  BuyInsuranceResponse createEmptyInstance() => create();
  static $pb.PbList<BuyInsuranceResponse> createRepeated() => $pb.PbList<BuyInsuranceResponse>();
  @$core.pragma('dart2js:noInline')
  static BuyInsuranceResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BuyInsuranceResponse>(create);
  static BuyInsuranceResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Insurance get insurance => $_getN(0);
  @$pb.TagNumber(1)
  set insurance(Insurance v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasInsurance() => $_has(0);
  @$pb.TagNumber(1)
  void clearInsurance() => clearField(1);
  @$pb.TagNumber(1)
  Insurance ensureInsurance() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.double get firstPremium => $_getN(1);
  @$pb.TagNumber(2)
  set firstPremium($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasFirstPremium() => $_has(1);
  @$pb.TagNumber(2)
  void clearFirstPremium() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get newBalance => $_getN(2);
  @$pb.TagNumber(3)
  set newBalance($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasNewBalance() => $_has(2);
  @$pb.TagNumber(3)
  void clearNewBalance() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get message => $_getSZ(3);
  @$pb.TagNumber(4)
  set message($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasMessage() => $_has(3);
  @$pb.TagNumber(4)
  void clearMessage() => clearField(4);
}

/// NOTE: user_id extracted from JWT token, not from request
class GetInsurancePoliciesRequest extends $pb.GeneratedMessage {
  factory GetInsurancePoliciesRequest({
    $core.String? status,
    $core.int? limit,
    $core.int? offset,
  }) {
    final $result = create();
    if (status != null) {
      $result.status = status;
    }
    if (limit != null) {
      $result.limit = limit;
    }
    if (offset != null) {
      $result.offset = offset;
    }
    return $result;
  }
  GetInsurancePoliciesRequest._() : super();
  factory GetInsurancePoliciesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInsurancePoliciesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetInsurancePoliciesRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'status')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInsurancePoliciesRequest clone() => GetInsurancePoliciesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInsurancePoliciesRequest copyWith(void Function(GetInsurancePoliciesRequest) updates) => super.copyWith((message) => updates(message as GetInsurancePoliciesRequest)) as GetInsurancePoliciesRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInsurancePoliciesRequest create() => GetInsurancePoliciesRequest._();
  GetInsurancePoliciesRequest createEmptyInstance() => create();
  static $pb.PbList<GetInsurancePoliciesRequest> createRepeated() => $pb.PbList<GetInsurancePoliciesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInsurancePoliciesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInsurancePoliciesRequest>(create);
  static GetInsurancePoliciesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get status => $_getSZ(0);
  @$pb.TagNumber(1)
  set status($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get limit => $_getIZ(1);
  @$pb.TagNumber(2)
  set limit($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearLimit() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get offset => $_getIZ(2);
  @$pb.TagNumber(3)
  set offset($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasOffset() => $_has(2);
  @$pb.TagNumber(3)
  void clearOffset() => clearField(3);
}

class GetInsurancePoliciesResponse extends $pb.GeneratedMessage {
  factory GetInsurancePoliciesResponse({
    $core.Iterable<Insurance>? policies,
    $core.int? total,
    $core.double? totalCoverage,
    $core.double? totalPremiumsPaid,
  }) {
    final $result = create();
    if (policies != null) {
      $result.policies.addAll(policies);
    }
    if (total != null) {
      $result.total = total;
    }
    if (totalCoverage != null) {
      $result.totalCoverage = totalCoverage;
    }
    if (totalPremiumsPaid != null) {
      $result.totalPremiumsPaid = totalPremiumsPaid;
    }
    return $result;
  }
  GetInsurancePoliciesResponse._() : super();
  factory GetInsurancePoliciesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInsurancePoliciesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetInsurancePoliciesResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'), createEmptyInstance: create)
    ..pc<Insurance>(1, _omitFieldNames ? '' : 'policies', $pb.PbFieldType.PM, subBuilder: Insurance.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'totalCoverage', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'totalPremiumsPaid', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInsurancePoliciesResponse clone() => GetInsurancePoliciesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInsurancePoliciesResponse copyWith(void Function(GetInsurancePoliciesResponse) updates) => super.copyWith((message) => updates(message as GetInsurancePoliciesResponse)) as GetInsurancePoliciesResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInsurancePoliciesResponse create() => GetInsurancePoliciesResponse._();
  GetInsurancePoliciesResponse createEmptyInstance() => create();
  static $pb.PbList<GetInsurancePoliciesResponse> createRepeated() => $pb.PbList<GetInsurancePoliciesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInsurancePoliciesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInsurancePoliciesResponse>(create);
  static GetInsurancePoliciesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Insurance> get policies => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get totalCoverage => $_getN(2);
  @$pb.TagNumber(3)
  set totalCoverage($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTotalCoverage() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalCoverage() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get totalPremiumsPaid => $_getN(3);
  @$pb.TagNumber(4)
  set totalPremiumsPaid($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTotalPremiumsPaid() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalPremiumsPaid() => clearField(4);
}

/// NOTE: user_id extracted from JWT token, not from request
class GetInsurancePolicyRequest extends $pb.GeneratedMessage {
  factory GetInsurancePolicyRequest({
    $core.String? policyId,
  }) {
    final $result = create();
    if (policyId != null) {
      $result.policyId = policyId;
    }
    return $result;
  }
  GetInsurancePolicyRequest._() : super();
  factory GetInsurancePolicyRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInsurancePolicyRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetInsurancePolicyRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'policyId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInsurancePolicyRequest clone() => GetInsurancePolicyRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInsurancePolicyRequest copyWith(void Function(GetInsurancePolicyRequest) updates) => super.copyWith((message) => updates(message as GetInsurancePolicyRequest)) as GetInsurancePolicyRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInsurancePolicyRequest create() => GetInsurancePolicyRequest._();
  GetInsurancePolicyRequest createEmptyInstance() => create();
  static $pb.PbList<GetInsurancePolicyRequest> createRepeated() => $pb.PbList<GetInsurancePolicyRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInsurancePolicyRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInsurancePolicyRequest>(create);
  static GetInsurancePolicyRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get policyId => $_getSZ(0);
  @$pb.TagNumber(1)
  set policyId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPolicyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPolicyId() => clearField(1);
}

class GetInsurancePolicyResponse extends $pb.GeneratedMessage {
  factory GetInsurancePolicyResponse({
    Insurance? insurance,
  }) {
    final $result = create();
    if (insurance != null) {
      $result.insurance = insurance;
    }
    return $result;
  }
  GetInsurancePolicyResponse._() : super();
  factory GetInsurancePolicyResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInsurancePolicyResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetInsurancePolicyResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOM<Insurance>(1, _omitFieldNames ? '' : 'insurance', subBuilder: Insurance.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInsurancePolicyResponse clone() => GetInsurancePolicyResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInsurancePolicyResponse copyWith(void Function(GetInsurancePolicyResponse) updates) => super.copyWith((message) => updates(message as GetInsurancePolicyResponse)) as GetInsurancePolicyResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInsurancePolicyResponse create() => GetInsurancePolicyResponse._();
  GetInsurancePolicyResponse createEmptyInstance() => create();
  static $pb.PbList<GetInsurancePolicyResponse> createRepeated() => $pb.PbList<GetInsurancePolicyResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInsurancePolicyResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInsurancePolicyResponse>(create);
  static GetInsurancePolicyResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Insurance get insurance => $_getN(0);
  @$pb.TagNumber(1)
  set insurance(Insurance v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasInsurance() => $_has(0);
  @$pb.TagNumber(1)
  void clearInsurance() => clearField(1);
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
  }) {
    final $result = create();
    if (policyId != null) {
      $result.policyId = policyId;
    }
    if (claimAmount != null) {
      $result.claimAmount = claimAmount;
    }
    if (reason != null) {
      $result.reason = reason;
    }
    if (documents != null) {
      $result.documents.addAll(documents);
    }
    return $result;
  }
  MakeInsuranceClaimRequest._() : super();
  factory MakeInsuranceClaimRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MakeInsuranceClaimRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MakeInsuranceClaimRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'policyId')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'claimAmount', $pb.PbFieldType.OD)
    ..aOS(3, _omitFieldNames ? '' : 'reason')
    ..pPS(4, _omitFieldNames ? '' : 'documents')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MakeInsuranceClaimRequest clone() => MakeInsuranceClaimRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MakeInsuranceClaimRequest copyWith(void Function(MakeInsuranceClaimRequest) updates) => super.copyWith((message) => updates(message as MakeInsuranceClaimRequest)) as MakeInsuranceClaimRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MakeInsuranceClaimRequest create() => MakeInsuranceClaimRequest._();
  MakeInsuranceClaimRequest createEmptyInstance() => create();
  static $pb.PbList<MakeInsuranceClaimRequest> createRepeated() => $pb.PbList<MakeInsuranceClaimRequest>();
  @$core.pragma('dart2js:noInline')
  static MakeInsuranceClaimRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MakeInsuranceClaimRequest>(create);
  static MakeInsuranceClaimRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get policyId => $_getSZ(0);
  @$pb.TagNumber(1)
  set policyId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPolicyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPolicyId() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get claimAmount => $_getN(1);
  @$pb.TagNumber(2)
  set claimAmount($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasClaimAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearClaimAmount() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get reason => $_getSZ(2);
  @$pb.TagNumber(3)
  set reason($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasReason() => $_has(2);
  @$pb.TagNumber(3)
  void clearReason() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<$core.String> get documents => $_getList(3);
}

class MakeInsuranceClaimResponse extends $pb.GeneratedMessage {
  factory MakeInsuranceClaimResponse({
    InsuranceClaim? claim,
    $core.String? message,
  }) {
    final $result = create();
    if (claim != null) {
      $result.claim = claim;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  MakeInsuranceClaimResponse._() : super();
  factory MakeInsuranceClaimResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MakeInsuranceClaimResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MakeInsuranceClaimResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOM<InsuranceClaim>(1, _omitFieldNames ? '' : 'claim', subBuilder: InsuranceClaim.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MakeInsuranceClaimResponse clone() => MakeInsuranceClaimResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MakeInsuranceClaimResponse copyWith(void Function(MakeInsuranceClaimResponse) updates) => super.copyWith((message) => updates(message as MakeInsuranceClaimResponse)) as MakeInsuranceClaimResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MakeInsuranceClaimResponse create() => MakeInsuranceClaimResponse._();
  MakeInsuranceClaimResponse createEmptyInstance() => create();
  static $pb.PbList<MakeInsuranceClaimResponse> createRepeated() => $pb.PbList<MakeInsuranceClaimResponse>();
  @$core.pragma('dart2js:noInline')
  static MakeInsuranceClaimResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MakeInsuranceClaimResponse>(create);
  static MakeInsuranceClaimResponse? _defaultInstance;

  @$pb.TagNumber(1)
  InsuranceClaim get claim => $_getN(0);
  @$pb.TagNumber(1)
  set claim(InsuranceClaim v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasClaim() => $_has(0);
  @$pb.TagNumber(1)
  void clearClaim() => clearField(1);
  @$pb.TagNumber(1)
  InsuranceClaim ensureClaim() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

/// NOTE: user_id extracted from JWT token, not from request
class CancelInsuranceRequest extends $pb.GeneratedMessage {
  factory CancelInsuranceRequest({
    $core.String? policyId,
    $core.String? reason,
  }) {
    final $result = create();
    if (policyId != null) {
      $result.policyId = policyId;
    }
    if (reason != null) {
      $result.reason = reason;
    }
    return $result;
  }
  CancelInsuranceRequest._() : super();
  factory CancelInsuranceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CancelInsuranceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CancelInsuranceRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'policyId')
    ..aOS(2, _omitFieldNames ? '' : 'reason')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CancelInsuranceRequest clone() => CancelInsuranceRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CancelInsuranceRequest copyWith(void Function(CancelInsuranceRequest) updates) => super.copyWith((message) => updates(message as CancelInsuranceRequest)) as CancelInsuranceRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CancelInsuranceRequest create() => CancelInsuranceRequest._();
  CancelInsuranceRequest createEmptyInstance() => create();
  static $pb.PbList<CancelInsuranceRequest> createRepeated() => $pb.PbList<CancelInsuranceRequest>();
  @$core.pragma('dart2js:noInline')
  static CancelInsuranceRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CancelInsuranceRequest>(create);
  static CancelInsuranceRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get policyId => $_getSZ(0);
  @$pb.TagNumber(1)
  set policyId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPolicyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPolicyId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get reason => $_getSZ(1);
  @$pb.TagNumber(2)
  set reason($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasReason() => $_has(1);
  @$pb.TagNumber(2)
  void clearReason() => clearField(2);
}

class CancelInsuranceResponse extends $pb.GeneratedMessage {
  factory CancelInsuranceResponse({
    Insurance? insurance,
    $core.String? message,
  }) {
    final $result = create();
    if (insurance != null) {
      $result.insurance = insurance;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  CancelInsuranceResponse._() : super();
  factory CancelInsuranceResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CancelInsuranceResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CancelInsuranceResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOM<Insurance>(1, _omitFieldNames ? '' : 'insurance', subBuilder: Insurance.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CancelInsuranceResponse clone() => CancelInsuranceResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CancelInsuranceResponse copyWith(void Function(CancelInsuranceResponse) updates) => super.copyWith((message) => updates(message as CancelInsuranceResponse)) as CancelInsuranceResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CancelInsuranceResponse create() => CancelInsuranceResponse._();
  CancelInsuranceResponse createEmptyInstance() => create();
  static $pb.PbList<CancelInsuranceResponse> createRepeated() => $pb.PbList<CancelInsuranceResponse>();
  @$core.pragma('dart2js:noInline')
  static CancelInsuranceResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CancelInsuranceResponse>(create);
  static CancelInsuranceResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Insurance get insurance => $_getN(0);
  @$pb.TagNumber(1)
  set insurance(Insurance v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasInsurance() => $_has(0);
  @$pb.TagNumber(1)
  void clearInsurance() => clearField(1);
  @$pb.TagNumber(1)
  Insurance ensureInsurance() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

class GetInsurancePlansRequest extends $pb.GeneratedMessage {
  factory GetInsurancePlansRequest({
    $core.String? coverageType,
  }) {
    final $result = create();
    if (coverageType != null) {
      $result.coverageType = coverageType;
    }
    return $result;
  }
  GetInsurancePlansRequest._() : super();
  factory GetInsurancePlansRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInsurancePlansRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetInsurancePlansRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'coverageType')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInsurancePlansRequest clone() => GetInsurancePlansRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInsurancePlansRequest copyWith(void Function(GetInsurancePlansRequest) updates) => super.copyWith((message) => updates(message as GetInsurancePlansRequest)) as GetInsurancePlansRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInsurancePlansRequest create() => GetInsurancePlansRequest._();
  GetInsurancePlansRequest createEmptyInstance() => create();
  static $pb.PbList<GetInsurancePlansRequest> createRepeated() => $pb.PbList<GetInsurancePlansRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInsurancePlansRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInsurancePlansRequest>(create);
  static GetInsurancePlansRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get coverageType => $_getSZ(0);
  @$pb.TagNumber(1)
  set coverageType($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCoverageType() => $_has(0);
  @$pb.TagNumber(1)
  void clearCoverageType() => clearField(1);
}

class GetInsurancePlansResponse extends $pb.GeneratedMessage {
  factory GetInsurancePlansResponse({
    $core.Iterable<InsurancePlan>? plans,
    $core.int? total,
  }) {
    final $result = create();
    if (plans != null) {
      $result.plans.addAll(plans);
    }
    if (total != null) {
      $result.total = total;
    }
    return $result;
  }
  GetInsurancePlansResponse._() : super();
  factory GetInsurancePlansResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInsurancePlansResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetInsurancePlansResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'), createEmptyInstance: create)
    ..pc<InsurancePlan>(1, _omitFieldNames ? '' : 'plans', $pb.PbFieldType.PM, subBuilder: InsurancePlan.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInsurancePlansResponse clone() => GetInsurancePlansResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInsurancePlansResponse copyWith(void Function(GetInsurancePlansResponse) updates) => super.copyWith((message) => updates(message as GetInsurancePlansResponse)) as GetInsurancePlansResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInsurancePlansResponse create() => GetInsurancePlansResponse._();
  GetInsurancePlansResponse createEmptyInstance() => create();
  static $pb.PbList<GetInsurancePlansResponse> createRepeated() => $pb.PbList<GetInsurancePlansResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInsurancePlansResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInsurancePlansResponse>(create);
  static GetInsurancePlansResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<InsurancePlan> get plans => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => clearField(2);
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
    final $result = create();
    if (accountId != null) {
      $result.accountId = accountId;
    }
    if (title != null) {
      $result.title = title;
    }
    if (description != null) {
      $result.description = description;
    }
    if (category != null) {
      $result.category = category;
    }
    if (targetAmount != null) {
      $result.targetAmount = targetAmount;
    }
    if (deadline != null) {
      $result.deadline = deadline;
    }
    if (imageUrl != null) {
      $result.imageUrl = imageUrl;
    }
    return $result;
  }
  CreateCrowdfundRequest._() : super();
  factory CreateCrowdfundRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateCrowdfundRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateCrowdfundRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountId')
    ..aOS(2, _omitFieldNames ? '' : 'title')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..aOS(4, _omitFieldNames ? '' : 'category')
    ..a<$core.double>(5, _omitFieldNames ? '' : 'targetAmount', $pb.PbFieldType.OD)
    ..aOS(6, _omitFieldNames ? '' : 'deadline')
    ..aOS(7, _omitFieldNames ? '' : 'imageUrl')
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
  $core.String get accountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => clearField(1);

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
  $core.String get category => $_getSZ(3);
  @$pb.TagNumber(4)
  set category($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCategory() => $_has(3);
  @$pb.TagNumber(4)
  void clearCategory() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get targetAmount => $_getN(4);
  @$pb.TagNumber(5)
  set targetAmount($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTargetAmount() => $_has(4);
  @$pb.TagNumber(5)
  void clearTargetAmount() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get deadline => $_getSZ(5);
  @$pb.TagNumber(6)
  set deadline($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasDeadline() => $_has(5);
  @$pb.TagNumber(6)
  void clearDeadline() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get imageUrl => $_getSZ(6);
  @$pb.TagNumber(7)
  set imageUrl($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasImageUrl() => $_has(6);
  @$pb.TagNumber(7)
  void clearImageUrl() => clearField(7);
}

class CreateCrowdfundResponse extends $pb.GeneratedMessage {
  factory CreateCrowdfundResponse({
    Crowdfund? crowdfund,
    $core.String? message,
  }) {
    final $result = create();
    if (crowdfund != null) {
      $result.crowdfund = crowdfund;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  CreateCrowdfundResponse._() : super();
  factory CreateCrowdfundResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateCrowdfundResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateCrowdfundResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOM<Crowdfund>(1, _omitFieldNames ? '' : 'crowdfund', subBuilder: Crowdfund.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
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
  Crowdfund get crowdfund => $_getN(0);
  @$pb.TagNumber(1)
  set crowdfund(Crowdfund v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasCrowdfund() => $_has(0);
  @$pb.TagNumber(1)
  void clearCrowdfund() => clearField(1);
  @$pb.TagNumber(1)
  Crowdfund ensureCrowdfund() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

/// NOTE: user_id extracted from JWT token, not from request
class GetCrowdfundsRequest extends $pb.GeneratedMessage {
  factory GetCrowdfundsRequest({
    $core.String? category,
    $core.String? status,
    $core.int? limit,
    $core.int? offset,
  }) {
    final $result = create();
    if (category != null) {
      $result.category = category;
    }
    if (status != null) {
      $result.status = status;
    }
    if (limit != null) {
      $result.limit = limit;
    }
    if (offset != null) {
      $result.offset = offset;
    }
    return $result;
  }
  GetCrowdfundsRequest._() : super();
  factory GetCrowdfundsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCrowdfundsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetCrowdfundsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'category')
    ..aOS(2, _omitFieldNames ? '' : 'status')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCrowdfundsRequest clone() => GetCrowdfundsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCrowdfundsRequest copyWith(void Function(GetCrowdfundsRequest) updates) => super.copyWith((message) => updates(message as GetCrowdfundsRequest)) as GetCrowdfundsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetCrowdfundsRequest create() => GetCrowdfundsRequest._();
  GetCrowdfundsRequest createEmptyInstance() => create();
  static $pb.PbList<GetCrowdfundsRequest> createRepeated() => $pb.PbList<GetCrowdfundsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetCrowdfundsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetCrowdfundsRequest>(create);
  static GetCrowdfundsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get category => $_getSZ(0);
  @$pb.TagNumber(1)
  set category($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCategory() => $_has(0);
  @$pb.TagNumber(1)
  void clearCategory() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get status => $_getSZ(1);
  @$pb.TagNumber(2)
  set status($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => clearField(2);

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

class GetCrowdfundsResponse extends $pb.GeneratedMessage {
  factory GetCrowdfundsResponse({
    $core.Iterable<Crowdfund>? crowdfunds,
    $core.int? total,
  }) {
    final $result = create();
    if (crowdfunds != null) {
      $result.crowdfunds.addAll(crowdfunds);
    }
    if (total != null) {
      $result.total = total;
    }
    return $result;
  }
  GetCrowdfundsResponse._() : super();
  factory GetCrowdfundsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCrowdfundsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetCrowdfundsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'), createEmptyInstance: create)
    ..pc<Crowdfund>(1, _omitFieldNames ? '' : 'crowdfunds', $pb.PbFieldType.PM, subBuilder: Crowdfund.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCrowdfundsResponse clone() => GetCrowdfundsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCrowdfundsResponse copyWith(void Function(GetCrowdfundsResponse) updates) => super.copyWith((message) => updates(message as GetCrowdfundsResponse)) as GetCrowdfundsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetCrowdfundsResponse create() => GetCrowdfundsResponse._();
  GetCrowdfundsResponse createEmptyInstance() => create();
  static $pb.PbList<GetCrowdfundsResponse> createRepeated() => $pb.PbList<GetCrowdfundsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetCrowdfundsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetCrowdfundsResponse>(create);
  static GetCrowdfundsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Crowdfund> get crowdfunds => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => clearField(2);
}

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

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetCrowdfundRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'), createEmptyInstance: create)
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
    Crowdfund? crowdfund,
    $core.Iterable<CrowdfundContribution>? recentContributions,
  }) {
    final $result = create();
    if (crowdfund != null) {
      $result.crowdfund = crowdfund;
    }
    if (recentContributions != null) {
      $result.recentContributions.addAll(recentContributions);
    }
    return $result;
  }
  GetCrowdfundResponse._() : super();
  factory GetCrowdfundResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCrowdfundResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetCrowdfundResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOM<Crowdfund>(1, _omitFieldNames ? '' : 'crowdfund', subBuilder: Crowdfund.create)
    ..pc<CrowdfundContribution>(2, _omitFieldNames ? '' : 'recentContributions', $pb.PbFieldType.PM, subBuilder: CrowdfundContribution.create)
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
  Crowdfund get crowdfund => $_getN(0);
  @$pb.TagNumber(1)
  set crowdfund(Crowdfund v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasCrowdfund() => $_has(0);
  @$pb.TagNumber(1)
  void clearCrowdfund() => clearField(1);
  @$pb.TagNumber(1)
  Crowdfund ensureCrowdfund() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.List<CrowdfundContribution> get recentContributions => $_getList(1);
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
    final $result = create();
    if (crowdfundId != null) {
      $result.crowdfundId = crowdfundId;
    }
    if (accountId != null) {
      $result.accountId = accountId;
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
    if (pin != null) {
      $result.pin = pin;
    }
    return $result;
  }
  ContributeToCrowdfundRequest._() : super();
  factory ContributeToCrowdfundRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ContributeToCrowdfundRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ContributeToCrowdfundRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'crowdfundId')
    ..aOS(2, _omitFieldNames ? '' : 'accountId')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(4, _omitFieldNames ? '' : 'message')
    ..aOB(5, _omitFieldNames ? '' : 'isAnonymous')
    ..aOS(6, _omitFieldNames ? '' : 'pin')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ContributeToCrowdfundRequest clone() => ContributeToCrowdfundRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ContributeToCrowdfundRequest copyWith(void Function(ContributeToCrowdfundRequest) updates) => super.copyWith((message) => updates(message as ContributeToCrowdfundRequest)) as ContributeToCrowdfundRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ContributeToCrowdfundRequest create() => ContributeToCrowdfundRequest._();
  ContributeToCrowdfundRequest createEmptyInstance() => create();
  static $pb.PbList<ContributeToCrowdfundRequest> createRepeated() => $pb.PbList<ContributeToCrowdfundRequest>();
  @$core.pragma('dart2js:noInline')
  static ContributeToCrowdfundRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ContributeToCrowdfundRequest>(create);
  static ContributeToCrowdfundRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get crowdfundId => $_getSZ(0);
  @$pb.TagNumber(1)
  set crowdfundId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCrowdfundId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCrowdfundId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get accountId => $_getSZ(1);
  @$pb.TagNumber(2)
  set accountId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAccountId() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccountId() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get amount => $_getN(2);
  @$pb.TagNumber(3)
  set amount($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get message => $_getSZ(3);
  @$pb.TagNumber(4)
  set message($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasMessage() => $_has(3);
  @$pb.TagNumber(4)
  void clearMessage() => clearField(4);

  @$pb.TagNumber(5)
  $core.bool get isAnonymous => $_getBF(4);
  @$pb.TagNumber(5)
  set isAnonymous($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasIsAnonymous() => $_has(4);
  @$pb.TagNumber(5)
  void clearIsAnonymous() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get pin => $_getSZ(5);
  @$pb.TagNumber(6)
  set pin($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasPin() => $_has(5);
  @$pb.TagNumber(6)
  void clearPin() => clearField(6);
}

class ContributeToCrowdfundResponse extends $pb.GeneratedMessage {
  factory ContributeToCrowdfundResponse({
    Crowdfund? crowdfund,
    CrowdfundContribution? contribution,
    $core.double? newBalance,
    $core.String? message,
  }) {
    final $result = create();
    if (crowdfund != null) {
      $result.crowdfund = crowdfund;
    }
    if (contribution != null) {
      $result.contribution = contribution;
    }
    if (newBalance != null) {
      $result.newBalance = newBalance;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  ContributeToCrowdfundResponse._() : super();
  factory ContributeToCrowdfundResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ContributeToCrowdfundResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ContributeToCrowdfundResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOM<Crowdfund>(1, _omitFieldNames ? '' : 'crowdfund', subBuilder: Crowdfund.create)
    ..aOM<CrowdfundContribution>(2, _omitFieldNames ? '' : 'contribution', subBuilder: CrowdfundContribution.create)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'newBalance', $pb.PbFieldType.OD)
    ..aOS(4, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ContributeToCrowdfundResponse clone() => ContributeToCrowdfundResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ContributeToCrowdfundResponse copyWith(void Function(ContributeToCrowdfundResponse) updates) => super.copyWith((message) => updates(message as ContributeToCrowdfundResponse)) as ContributeToCrowdfundResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ContributeToCrowdfundResponse create() => ContributeToCrowdfundResponse._();
  ContributeToCrowdfundResponse createEmptyInstance() => create();
  static $pb.PbList<ContributeToCrowdfundResponse> createRepeated() => $pb.PbList<ContributeToCrowdfundResponse>();
  @$core.pragma('dart2js:noInline')
  static ContributeToCrowdfundResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ContributeToCrowdfundResponse>(create);
  static ContributeToCrowdfundResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Crowdfund get crowdfund => $_getN(0);
  @$pb.TagNumber(1)
  set crowdfund(Crowdfund v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasCrowdfund() => $_has(0);
  @$pb.TagNumber(1)
  void clearCrowdfund() => clearField(1);
  @$pb.TagNumber(1)
  Crowdfund ensureCrowdfund() => $_ensure(0);

  @$pb.TagNumber(2)
  CrowdfundContribution get contribution => $_getN(1);
  @$pb.TagNumber(2)
  set contribution(CrowdfundContribution v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasContribution() => $_has(1);
  @$pb.TagNumber(2)
  void clearContribution() => clearField(2);
  @$pb.TagNumber(2)
  CrowdfundContribution ensureContribution() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.double get newBalance => $_getN(2);
  @$pb.TagNumber(3)
  set newBalance($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasNewBalance() => $_has(2);
  @$pb.TagNumber(3)
  void clearNewBalance() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get message => $_getSZ(3);
  @$pb.TagNumber(4)
  set message($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasMessage() => $_has(3);
  @$pb.TagNumber(4)
  void clearMessage() => clearField(4);
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
    final $result = create();
    if (crowdfundId != null) {
      $result.crowdfundId = crowdfundId;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (pin != null) {
      $result.pin = pin;
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

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'WithdrawFromCrowdfundRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'crowdfundId')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(3, _omitFieldNames ? '' : 'pin')
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
  $core.double get amount => $_getN(1);
  @$pb.TagNumber(2)
  set amount($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get pin => $_getSZ(2);
  @$pb.TagNumber(3)
  set pin($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPin() => $_has(2);
  @$pb.TagNumber(3)
  void clearPin() => clearField(3);

  /// Destination account for withdrawal - one of the following must be specified:
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
    Crowdfund? crowdfund,
    $core.double? amountWithdrawn,
    $core.String? message,
    $core.String? destinationAccountId,
    $core.double? destinationNewBalance,
  }) {
    final $result = create();
    if (crowdfund != null) {
      $result.crowdfund = crowdfund;
    }
    if (amountWithdrawn != null) {
      $result.amountWithdrawn = amountWithdrawn;
    }
    if (message != null) {
      $result.message = message;
    }
    if (destinationAccountId != null) {
      $result.destinationAccountId = destinationAccountId;
    }
    if (destinationNewBalance != null) {
      $result.destinationNewBalance = destinationNewBalance;
    }
    return $result;
  }
  WithdrawFromCrowdfundResponse._() : super();
  factory WithdrawFromCrowdfundResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WithdrawFromCrowdfundResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'WithdrawFromCrowdfundResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOM<Crowdfund>(1, _omitFieldNames ? '' : 'crowdfund', subBuilder: Crowdfund.create)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'amountWithdrawn', $pb.PbFieldType.OD)
    ..aOS(3, _omitFieldNames ? '' : 'message')
    ..aOS(4, _omitFieldNames ? '' : 'destinationAccountId')
    ..a<$core.double>(5, _omitFieldNames ? '' : 'destinationNewBalance', $pb.PbFieldType.OD)
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
  Crowdfund get crowdfund => $_getN(0);
  @$pb.TagNumber(1)
  set crowdfund(Crowdfund v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasCrowdfund() => $_has(0);
  @$pb.TagNumber(1)
  void clearCrowdfund() => clearField(1);
  @$pb.TagNumber(1)
  Crowdfund ensureCrowdfund() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.double get amountWithdrawn => $_getN(1);
  @$pb.TagNumber(2)
  set amountWithdrawn($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAmountWithdrawn() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmountWithdrawn() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get destinationAccountId => $_getSZ(3);
  @$pb.TagNumber(4)
  set destinationAccountId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasDestinationAccountId() => $_has(3);
  @$pb.TagNumber(4)
  void clearDestinationAccountId() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get destinationNewBalance => $_getN(4);
  @$pb.TagNumber(5)
  set destinationNewBalance($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasDestinationNewBalance() => $_has(4);
  @$pb.TagNumber(5)
  void clearDestinationNewBalance() => clearField(5);
}

/// NOTE: user_id extracted from JWT token, not from request
class CloseCrowdfundRequest extends $pb.GeneratedMessage {
  factory CloseCrowdfundRequest({
    $core.String? crowdfundId,
  }) {
    final $result = create();
    if (crowdfundId != null) {
      $result.crowdfundId = crowdfundId;
    }
    return $result;
  }
  CloseCrowdfundRequest._() : super();
  factory CloseCrowdfundRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CloseCrowdfundRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CloseCrowdfundRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'crowdfundId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CloseCrowdfundRequest clone() => CloseCrowdfundRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CloseCrowdfundRequest copyWith(void Function(CloseCrowdfundRequest) updates) => super.copyWith((message) => updates(message as CloseCrowdfundRequest)) as CloseCrowdfundRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CloseCrowdfundRequest create() => CloseCrowdfundRequest._();
  CloseCrowdfundRequest createEmptyInstance() => create();
  static $pb.PbList<CloseCrowdfundRequest> createRepeated() => $pb.PbList<CloseCrowdfundRequest>();
  @$core.pragma('dart2js:noInline')
  static CloseCrowdfundRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CloseCrowdfundRequest>(create);
  static CloseCrowdfundRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get crowdfundId => $_getSZ(0);
  @$pb.TagNumber(1)
  set crowdfundId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCrowdfundId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCrowdfundId() => clearField(1);
}

class CloseCrowdfundResponse extends $pb.GeneratedMessage {
  factory CloseCrowdfundResponse({
    Crowdfund? crowdfund,
    $core.String? message,
  }) {
    final $result = create();
    if (crowdfund != null) {
      $result.crowdfund = crowdfund;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  CloseCrowdfundResponse._() : super();
  factory CloseCrowdfundResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CloseCrowdfundResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CloseCrowdfundResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOM<Crowdfund>(1, _omitFieldNames ? '' : 'crowdfund', subBuilder: Crowdfund.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CloseCrowdfundResponse clone() => CloseCrowdfundResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CloseCrowdfundResponse copyWith(void Function(CloseCrowdfundResponse) updates) => super.copyWith((message) => updates(message as CloseCrowdfundResponse)) as CloseCrowdfundResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CloseCrowdfundResponse create() => CloseCrowdfundResponse._();
  CloseCrowdfundResponse createEmptyInstance() => create();
  static $pb.PbList<CloseCrowdfundResponse> createRepeated() => $pb.PbList<CloseCrowdfundResponse>();
  @$core.pragma('dart2js:noInline')
  static CloseCrowdfundResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CloseCrowdfundResponse>(create);
  static CloseCrowdfundResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Crowdfund get crowdfund => $_getN(0);
  @$pb.TagNumber(1)
  set crowdfund(Crowdfund v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasCrowdfund() => $_has(0);
  @$pb.TagNumber(1)
  void clearCrowdfund() => clearField(1);
  @$pb.TagNumber(1)
  Crowdfund ensureCrowdfund() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

class GetCrowdfundStatisticsRequest extends $pb.GeneratedMessage {
  factory GetCrowdfundStatisticsRequest({
    $core.String? crowdfundId,
    $core.bool? includeLeaderboard,
    $core.bool? includeDailyProgress,
    $core.int? leaderboardLimit,
    $core.int? progressDays,
  }) {
    final $result = create();
    if (crowdfundId != null) {
      $result.crowdfundId = crowdfundId;
    }
    if (includeLeaderboard != null) {
      $result.includeLeaderboard = includeLeaderboard;
    }
    if (includeDailyProgress != null) {
      $result.includeDailyProgress = includeDailyProgress;
    }
    if (leaderboardLimit != null) {
      $result.leaderboardLimit = leaderboardLimit;
    }
    if (progressDays != null) {
      $result.progressDays = progressDays;
    }
    return $result;
  }
  GetCrowdfundStatisticsRequest._() : super();
  factory GetCrowdfundStatisticsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCrowdfundStatisticsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetCrowdfundStatisticsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'crowdfundId')
    ..aOB(2, _omitFieldNames ? '' : 'includeLeaderboard')
    ..aOB(3, _omitFieldNames ? '' : 'includeDailyProgress')
    ..a<$core.int>(4, _omitFieldNames ? '' : 'leaderboardLimit', $pb.PbFieldType.O3)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'progressDays', $pb.PbFieldType.O3)
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

  @$pb.TagNumber(2)
  $core.bool get includeLeaderboard => $_getBF(1);
  @$pb.TagNumber(2)
  set includeLeaderboard($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasIncludeLeaderboard() => $_has(1);
  @$pb.TagNumber(2)
  void clearIncludeLeaderboard() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get includeDailyProgress => $_getBF(2);
  @$pb.TagNumber(3)
  set includeDailyProgress($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasIncludeDailyProgress() => $_has(2);
  @$pb.TagNumber(3)
  void clearIncludeDailyProgress() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get leaderboardLimit => $_getIZ(3);
  @$pb.TagNumber(4)
  set leaderboardLimit($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasLeaderboardLimit() => $_has(3);
  @$pb.TagNumber(4)
  void clearLeaderboardLimit() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get progressDays => $_getIZ(4);
  @$pb.TagNumber(5)
  set progressDays($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasProgressDays() => $_has(4);
  @$pb.TagNumber(5)
  void clearProgressDays() => clearField(5);
}

class GetCrowdfundStatisticsResponse extends $pb.GeneratedMessage {
  factory GetCrowdfundStatisticsResponse({
    CrowdfundStatistics? statistics,
  }) {
    final $result = create();
    if (statistics != null) {
      $result.statistics = statistics;
    }
    return $result;
  }
  GetCrowdfundStatisticsResponse._() : super();
  factory GetCrowdfundStatisticsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCrowdfundStatisticsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetCrowdfundStatisticsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOM<CrowdfundStatistics>(1, _omitFieldNames ? '' : 'statistics', subBuilder: CrowdfundStatistics.create)
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
  CrowdfundStatistics get statistics => $_getN(0);
  @$pb.TagNumber(1)
  set statistics(CrowdfundStatistics v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasStatistics() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatistics() => clearField(1);
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
    if (smallestDonation != null) {
      $result.smallestDonation = smallestDonation;
    }
    if (daysRemaining != null) {
      $result.daysRemaining = daysRemaining;
    }
    if (daysActive != null) {
      $result.daysActive = daysActive;
    }
    if (isCompleted != null) {
      $result.isCompleted = isCompleted;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
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
    if (newDonorsToday != null) {
      $result.newDonorsToday = newDonorsToday;
    }
    if (newDonorsThisWeek != null) {
      $result.newDonorsThisWeek = newDonorsThisWeek;
    }
    if (amountRaisedToday != null) {
      $result.amountRaisedToday = amountRaisedToday;
    }
    if (amountRaisedThisWeek != null) {
      $result.amountRaisedThisWeek = amountRaisedThisWeek;
    }
    return $result;
  }
  CrowdfundStatistics._() : super();
  factory CrowdfundStatistics.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CrowdfundStatistics.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CrowdfundStatistics', package: const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'crowdfundId')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'totalRaised', $pb.PbFieldType.OD)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'targetAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'progressPercentage', $pb.PbFieldType.OD)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'donorCount', $pb.PbFieldType.O3)
    ..a<$core.double>(6, _omitFieldNames ? '' : 'averageDonation', $pb.PbFieldType.OD)
    ..a<$core.double>(7, _omitFieldNames ? '' : 'largestDonation', $pb.PbFieldType.OD)
    ..a<$core.double>(8, _omitFieldNames ? '' : 'smallestDonation', $pb.PbFieldType.OD)
    ..a<$core.int>(9, _omitFieldNames ? '' : 'daysRemaining', $pb.PbFieldType.O3)
    ..a<$core.int>(10, _omitFieldNames ? '' : 'daysActive', $pb.PbFieldType.O3)
    ..aOB(11, _omitFieldNames ? '' : 'isCompleted')
    ..aOS(12, _omitFieldNames ? '' : 'createdAt')
    ..pc<ContributorLeaderboardEntry>(13, _omitFieldNames ? '' : 'topContributors', $pb.PbFieldType.PM, subBuilder: ContributorLeaderboardEntry.create)
    ..pc<DailyProgress>(14, _omitFieldNames ? '' : 'dailyProgress', $pb.PbFieldType.PM, subBuilder: DailyProgress.create)
    ..a<$core.double>(15, _omitFieldNames ? '' : 'fundingVelocity', $pb.PbFieldType.OD)
    ..aOS(16, _omitFieldNames ? '' : 'projectedCompletionDate')
    ..a<$core.int>(17, _omitFieldNames ? '' : 'newDonorsToday', $pb.PbFieldType.O3)
    ..a<$core.int>(18, _omitFieldNames ? '' : 'newDonorsThisWeek', $pb.PbFieldType.O3)
    ..a<$core.double>(19, _omitFieldNames ? '' : 'amountRaisedToday', $pb.PbFieldType.OD)
    ..a<$core.double>(20, _omitFieldNames ? '' : 'amountRaisedThisWeek', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CrowdfundStatistics clone() => CrowdfundStatistics()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CrowdfundStatistics copyWith(void Function(CrowdfundStatistics) updates) => super.copyWith((message) => updates(message as CrowdfundStatistics)) as CrowdfundStatistics;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CrowdfundStatistics create() => CrowdfundStatistics._();
  CrowdfundStatistics createEmptyInstance() => create();
  static $pb.PbList<CrowdfundStatistics> createRepeated() => $pb.PbList<CrowdfundStatistics>();
  @$core.pragma('dart2js:noInline')
  static CrowdfundStatistics getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CrowdfundStatistics>(create);
  static CrowdfundStatistics? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get crowdfundId => $_getSZ(0);
  @$pb.TagNumber(1)
  set crowdfundId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCrowdfundId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCrowdfundId() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get totalRaised => $_getN(1);
  @$pb.TagNumber(2)
  set totalRaised($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotalRaised() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalRaised() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get targetAmount => $_getN(2);
  @$pb.TagNumber(3)
  set targetAmount($core.double v) { $_setDouble(2, v); }
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
  $core.double get averageDonation => $_getN(5);
  @$pb.TagNumber(6)
  set averageDonation($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasAverageDonation() => $_has(5);
  @$pb.TagNumber(6)
  void clearAverageDonation() => clearField(6);

  @$pb.TagNumber(7)
  $core.double get largestDonation => $_getN(6);
  @$pb.TagNumber(7)
  set largestDonation($core.double v) { $_setDouble(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasLargestDonation() => $_has(6);
  @$pb.TagNumber(7)
  void clearLargestDonation() => clearField(7);

  @$pb.TagNumber(8)
  $core.double get smallestDonation => $_getN(7);
  @$pb.TagNumber(8)
  set smallestDonation($core.double v) { $_setDouble(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasSmallestDonation() => $_has(7);
  @$pb.TagNumber(8)
  void clearSmallestDonation() => clearField(8);

  @$pb.TagNumber(9)
  $core.int get daysRemaining => $_getIZ(8);
  @$pb.TagNumber(9)
  set daysRemaining($core.int v) { $_setSignedInt32(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasDaysRemaining() => $_has(8);
  @$pb.TagNumber(9)
  void clearDaysRemaining() => clearField(9);

  @$pb.TagNumber(10)
  $core.int get daysActive => $_getIZ(9);
  @$pb.TagNumber(10)
  set daysActive($core.int v) { $_setSignedInt32(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasDaysActive() => $_has(9);
  @$pb.TagNumber(10)
  void clearDaysActive() => clearField(10);

  @$pb.TagNumber(11)
  $core.bool get isCompleted => $_getBF(10);
  @$pb.TagNumber(11)
  set isCompleted($core.bool v) { $_setBool(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasIsCompleted() => $_has(10);
  @$pb.TagNumber(11)
  void clearIsCompleted() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get createdAt => $_getSZ(11);
  @$pb.TagNumber(12)
  set createdAt($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasCreatedAt() => $_has(11);
  @$pb.TagNumber(12)
  void clearCreatedAt() => clearField(12);

  /// Enhanced analytics
  @$pb.TagNumber(13)
  $core.List<ContributorLeaderboardEntry> get topContributors => $_getList(12);

  @$pb.TagNumber(14)
  $core.List<DailyProgress> get dailyProgress => $_getList(13);

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

  @$pb.TagNumber(17)
  $core.int get newDonorsToday => $_getIZ(16);
  @$pb.TagNumber(17)
  set newDonorsToday($core.int v) { $_setSignedInt32(16, v); }
  @$pb.TagNumber(17)
  $core.bool hasNewDonorsToday() => $_has(16);
  @$pb.TagNumber(17)
  void clearNewDonorsToday() => clearField(17);

  @$pb.TagNumber(18)
  $core.int get newDonorsThisWeek => $_getIZ(17);
  @$pb.TagNumber(18)
  set newDonorsThisWeek($core.int v) { $_setSignedInt32(17, v); }
  @$pb.TagNumber(18)
  $core.bool hasNewDonorsThisWeek() => $_has(17);
  @$pb.TagNumber(18)
  void clearNewDonorsThisWeek() => clearField(18);

  @$pb.TagNumber(19)
  $core.double get amountRaisedToday => $_getN(18);
  @$pb.TagNumber(19)
  set amountRaisedToday($core.double v) { $_setDouble(18, v); }
  @$pb.TagNumber(19)
  $core.bool hasAmountRaisedToday() => $_has(18);
  @$pb.TagNumber(19)
  void clearAmountRaisedToday() => clearField(19);

  @$pb.TagNumber(20)
  $core.double get amountRaisedThisWeek => $_getN(19);
  @$pb.TagNumber(20)
  set amountRaisedThisWeek($core.double v) { $_setDouble(19, v); }
  @$pb.TagNumber(20)
  $core.bool hasAmountRaisedThisWeek() => $_has(19);
  @$pb.TagNumber(20)
  void clearAmountRaisedThisWeek() => clearField(20);
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
    final $result = create();
    if (rank != null) {
      $result.rank = rank;
    }
    if (userId != null) {
      $result.userId = userId;
    }
    if (displayName != null) {
      $result.displayName = displayName;
    }
    if (profilePicture != null) {
      $result.profilePicture = profilePicture;
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
    if (firstContributionDate != null) {
      $result.firstContributionDate = firstContributionDate;
    }
    if (lastContributionDate != null) {
      $result.lastContributionDate = lastContributionDate;
    }
    return $result;
  }
  ContributorLeaderboardEntry._() : super();
  factory ContributorLeaderboardEntry.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ContributorLeaderboardEntry.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ContributorLeaderboardEntry', package: const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'rank', $pb.PbFieldType.O3)
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'displayName')
    ..aOS(4, _omitFieldNames ? '' : 'profilePicture')
    ..a<$core.double>(5, _omitFieldNames ? '' : 'totalAmount', $pb.PbFieldType.OD)
    ..a<$core.int>(6, _omitFieldNames ? '' : 'contributionCount', $pb.PbFieldType.O3)
    ..aOB(7, _omitFieldNames ? '' : 'isAnonymous')
    ..aOS(8, _omitFieldNames ? '' : 'firstContributionDate')
    ..aOS(9, _omitFieldNames ? '' : 'lastContributionDate')
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
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get displayName => $_getSZ(2);
  @$pb.TagNumber(3)
  set displayName($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDisplayName() => $_has(2);
  @$pb.TagNumber(3)
  void clearDisplayName() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get profilePicture => $_getSZ(3);
  @$pb.TagNumber(4)
  set profilePicture($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasProfilePicture() => $_has(3);
  @$pb.TagNumber(4)
  void clearProfilePicture() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get totalAmount => $_getN(4);
  @$pb.TagNumber(5)
  set totalAmount($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTotalAmount() => $_has(4);
  @$pb.TagNumber(5)
  void clearTotalAmount() => clearField(5);

  @$pb.TagNumber(6)
  $core.int get contributionCount => $_getIZ(5);
  @$pb.TagNumber(6)
  set contributionCount($core.int v) { $_setSignedInt32(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasContributionCount() => $_has(5);
  @$pb.TagNumber(6)
  void clearContributionCount() => clearField(6);

  @$pb.TagNumber(7)
  $core.bool get isAnonymous => $_getBF(6);
  @$pb.TagNumber(7)
  set isAnonymous($core.bool v) { $_setBool(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasIsAnonymous() => $_has(6);
  @$pb.TagNumber(7)
  void clearIsAnonymous() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get firstContributionDate => $_getSZ(7);
  @$pb.TagNumber(8)
  set firstContributionDate($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasFirstContributionDate() => $_has(7);
  @$pb.TagNumber(8)
  void clearFirstContributionDate() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get lastContributionDate => $_getSZ(8);
  @$pb.TagNumber(9)
  set lastContributionDate($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasLastContributionDate() => $_has(8);
  @$pb.TagNumber(9)
  void clearLastContributionDate() => clearField(9);
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
    final $result = create();
    if (date != null) {
      $result.date = date;
    }
    if (amountRaised != null) {
      $result.amountRaised = amountRaised;
    }
    if (newDonors != null) {
      $result.newDonors = newDonors;
    }
    if (totalContributions != null) {
      $result.totalContributions = totalContributions;
    }
    if (cumulativeAmount != null) {
      $result.cumulativeAmount = cumulativeAmount;
    }
    if (progressPercentage != null) {
      $result.progressPercentage = progressPercentage;
    }
    return $result;
  }
  DailyProgress._() : super();
  factory DailyProgress.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DailyProgress.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DailyProgress', package: const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'date')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'amountRaised', $pb.PbFieldType.OD)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'newDonors', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'totalContributions', $pb.PbFieldType.O3)
    ..a<$core.double>(5, _omitFieldNames ? '' : 'cumulativeAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(6, _omitFieldNames ? '' : 'progressPercentage', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DailyProgress clone() => DailyProgress()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DailyProgress copyWith(void Function(DailyProgress) updates) => super.copyWith((message) => updates(message as DailyProgress)) as DailyProgress;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DailyProgress create() => DailyProgress._();
  DailyProgress createEmptyInstance() => create();
  static $pb.PbList<DailyProgress> createRepeated() => $pb.PbList<DailyProgress>();
  @$core.pragma('dart2js:noInline')
  static DailyProgress getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DailyProgress>(create);
  static DailyProgress? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get date => $_getSZ(0);
  @$pb.TagNumber(1)
  set date($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDate() => $_has(0);
  @$pb.TagNumber(1)
  void clearDate() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get amountRaised => $_getN(1);
  @$pb.TagNumber(2)
  set amountRaised($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAmountRaised() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmountRaised() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get newDonors => $_getIZ(2);
  @$pb.TagNumber(3)
  set newDonors($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasNewDonors() => $_has(2);
  @$pb.TagNumber(3)
  void clearNewDonors() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get totalContributions => $_getIZ(3);
  @$pb.TagNumber(4)
  set totalContributions($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTotalContributions() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalContributions() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get cumulativeAmount => $_getN(4);
  @$pb.TagNumber(5)
  set cumulativeAmount($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasCumulativeAmount() => $_has(4);
  @$pb.TagNumber(5)
  void clearCumulativeAmount() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get progressPercentage => $_getN(5);
  @$pb.TagNumber(6)
  set progressPercentage($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasProgressPercentage() => $_has(5);
  @$pb.TagNumber(6)
  void clearProgressPercentage() => clearField(6);
}

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

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SearchCrowdfundsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'), createEmptyInstance: create)
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
    $core.Iterable<Crowdfund>? crowdfunds,
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

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SearchCrowdfundsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'), createEmptyInstance: create)
    ..pc<Crowdfund>(1, _omitFieldNames ? '' : 'crowdfunds', $pb.PbFieldType.PM, subBuilder: Crowdfund.create)
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
  $core.List<Crowdfund> get crowdfunds => $_getList(0);
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
    if (category != null) {
      $result.category = category;
    }
    if (targetAmount != null) {
      $result.targetAmount = targetAmount;
    }
    if (deadline != null) {
      $result.deadline = deadline;
    }
    if (imageUrl != null) {
      $result.imageUrl = imageUrl;
    }
    if (status != null) {
      $result.status = status;
    }
    return $result;
  }
  UpdateCrowdfundRequest._() : super();
  factory UpdateCrowdfundRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateCrowdfundRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateCrowdfundRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'crowdfundId')
    ..aOS(2, _omitFieldNames ? '' : 'title')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..aOS(4, _omitFieldNames ? '' : 'category')
    ..a<$core.double>(5, _omitFieldNames ? '' : 'targetAmount', $pb.PbFieldType.OD)
    ..aOS(6, _omitFieldNames ? '' : 'deadline')
    ..aOS(7, _omitFieldNames ? '' : 'imageUrl')
    ..aOS(8, _omitFieldNames ? '' : 'status')
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
  $core.String get category => $_getSZ(3);
  @$pb.TagNumber(4)
  set category($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCategory() => $_has(3);
  @$pb.TagNumber(4)
  void clearCategory() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get targetAmount => $_getN(4);
  @$pb.TagNumber(5)
  set targetAmount($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTargetAmount() => $_has(4);
  @$pb.TagNumber(5)
  void clearTargetAmount() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get deadline => $_getSZ(5);
  @$pb.TagNumber(6)
  set deadline($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasDeadline() => $_has(5);
  @$pb.TagNumber(6)
  void clearDeadline() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get imageUrl => $_getSZ(6);
  @$pb.TagNumber(7)
  set imageUrl($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasImageUrl() => $_has(6);
  @$pb.TagNumber(7)
  void clearImageUrl() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get status => $_getSZ(7);
  @$pb.TagNumber(8)
  set status($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasStatus() => $_has(7);
  @$pb.TagNumber(8)
  void clearStatus() => clearField(8);
}

class UpdateCrowdfundResponse extends $pb.GeneratedMessage {
  factory UpdateCrowdfundResponse({
    Crowdfund? crowdfund,
    $core.String? message,
  }) {
    final $result = create();
    if (crowdfund != null) {
      $result.crowdfund = crowdfund;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  UpdateCrowdfundResponse._() : super();
  factory UpdateCrowdfundResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateCrowdfundResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateCrowdfundResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOM<Crowdfund>(1, _omitFieldNames ? '' : 'crowdfund', subBuilder: Crowdfund.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
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
  Crowdfund get crowdfund => $_getN(0);
  @$pb.TagNumber(1)
  set crowdfund(Crowdfund v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasCrowdfund() => $_has(0);
  @$pb.TagNumber(1)
  void clearCrowdfund() => clearField(1);
  @$pb.TagNumber(1)
  Crowdfund ensureCrowdfund() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

/// NOTE: user_id extracted from JWT token, not from request
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

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DeleteCrowdfundRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'), createEmptyInstance: create)
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

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DeleteCrowdfundResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'), createEmptyInstance: create)
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

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetCrowdfundDonationsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'), createEmptyInstance: create)
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
    $core.Iterable<CrowdfundContribution>? donations,
    $core.int? total,
    $core.int? page,
    $core.int? pageSize,
    $core.bool? hasMore,
  }) {
    final $result = create();
    if (donations != null) {
      $result.donations.addAll(donations);
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
  GetCrowdfundDonationsResponse._() : super();
  factory GetCrowdfundDonationsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCrowdfundDonationsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetCrowdfundDonationsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'), createEmptyInstance: create)
    ..pc<CrowdfundContribution>(1, _omitFieldNames ? '' : 'donations', $pb.PbFieldType.PM, subBuilder: CrowdfundContribution.create)
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
  $core.List<CrowdfundContribution> get donations => $_getList(0);

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

/// NOTE: user_id extracted from JWT token, not from request
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

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetUserDonationsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'), createEmptyInstance: create)
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
    $core.Iterable<CrowdfundContribution>? donations,
    $core.int? total,
    $core.int? page,
    $core.int? pageSize,
    $core.bool? hasMore,
  }) {
    final $result = create();
    if (donations != null) {
      $result.donations.addAll(donations);
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
  GetUserDonationsResponse._() : super();
  factory GetUserDonationsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUserDonationsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetUserDonationsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'), createEmptyInstance: create)
    ..pc<CrowdfundContribution>(1, _omitFieldNames ? '' : 'donations', $pb.PbFieldType.PM, subBuilder: CrowdfundContribution.create)
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
  $core.List<CrowdfundContribution> get donations => $_getList(0);

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

/// NOTE: user_id extracted from JWT token, not from request
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

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GenerateDonationReceiptRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'), createEmptyInstance: create)
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
    CrowdfundReceipt? receipt,
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

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GenerateDonationReceiptResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOM<CrowdfundReceipt>(1, _omitFieldNames ? '' : 'receipt', subBuilder: CrowdfundReceipt.create)
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
  CrowdfundReceipt get receipt => $_getN(0);
  @$pb.TagNumber(1)
  set receipt(CrowdfundReceipt v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasReceipt() => $_has(0);
  @$pb.TagNumber(1)
  void clearReceipt() => clearField(1);
  @$pb.TagNumber(1)
  CrowdfundReceipt ensureReceipt() => $_ensure(0);
}

/// NOTE: user_id extracted from JWT token, not from request
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

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetUserCrowdfundReceiptsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'), createEmptyInstance: create)
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
    $core.Iterable<CrowdfundReceipt>? receipts,
    $core.int? total,
    $core.int? page,
    $core.int? pageSize,
    $core.bool? hasMore,
  }) {
    final $result = create();
    if (receipts != null) {
      $result.receipts.addAll(receipts);
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
  GetUserCrowdfundReceiptsResponse._() : super();
  factory GetUserCrowdfundReceiptsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUserCrowdfundReceiptsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetUserCrowdfundReceiptsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'), createEmptyInstance: create)
    ..pc<CrowdfundReceipt>(1, _omitFieldNames ? '' : 'receipts', $pb.PbFieldType.PM, subBuilder: CrowdfundReceipt.create)
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
  $core.List<CrowdfundReceipt> get receipts => $_getList(0);

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
  CrowdfundReceipt._() : super();
  factory CrowdfundReceipt.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CrowdfundReceipt.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CrowdfundReceipt', package: const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'), createEmptyInstance: create)
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
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CrowdfundReceipt clone() => CrowdfundReceipt()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CrowdfundReceipt copyWith(void Function(CrowdfundReceipt) updates) => super.copyWith((message) => updates(message as CrowdfundReceipt)) as CrowdfundReceipt;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CrowdfundReceipt create() => CrowdfundReceipt._();
  CrowdfundReceipt createEmptyInstance() => create();
  static $pb.PbList<CrowdfundReceipt> createRepeated() => $pb.PbList<CrowdfundReceipt>();
  @$core.pragma('dart2js:noInline')
  static CrowdfundReceipt getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CrowdfundReceipt>(create);
  static CrowdfundReceipt? _defaultInstance;

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
  $core.String get donorUserId => $_getSZ(4);
  @$pb.TagNumber(5)
  set donorUserId($core.String v) { $_setString(4, v); }
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
  $core.double get amount => $_getN(6);
  @$pb.TagNumber(7)
  set amount($core.double v) { $_setDouble(6, v); }
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
  $core.String get donationDate => $_getSZ(8);
  @$pb.TagNumber(9)
  set donationDate($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasDonationDate() => $_has(8);
  @$pb.TagNumber(9)
  void clearDonationDate() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get generatedAt => $_getSZ(9);
  @$pb.TagNumber(10)
  set generatedAt($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasGeneratedAt() => $_has(9);
  @$pb.TagNumber(10)
  void clearGeneratedAt() => clearField(10);

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
    if (channelIdentifier != null) {
      $result.channelIdentifier = channelIdentifier;
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
  NotificationChannel._() : super();
  factory NotificationChannel.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NotificationChannel.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'NotificationChannel', package: const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'crowdfundId')
    ..aOS(3, _omitFieldNames ? '' : 'creatorUserId')
    ..e<NotificationChannelType>(4, _omitFieldNames ? '' : 'channelType', $pb.PbFieldType.OE, defaultOrMaker: NotificationChannelType.NOTIFICATION_CHANNEL_TYPE_UNSPECIFIED, valueOf: NotificationChannelType.valueOf, enumValues: NotificationChannelType.values)
    ..e<NotificationChannelStatus>(5, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: NotificationChannelStatus.NOTIFICATION_CHANNEL_STATUS_UNSPECIFIED, valueOf: NotificationChannelStatus.valueOf, enumValues: NotificationChannelStatus.values)
    ..aOS(6, _omitFieldNames ? '' : 'channelName')
    ..aOS(7, _omitFieldNames ? '' : 'channelIdentifier')
    ..aOS(8, _omitFieldNames ? '' : 'channelUsername')
    ..pc<NotificationEventType>(9, _omitFieldNames ? '' : 'enabledEvents', $pb.PbFieldType.KE, valueOf: NotificationEventType.valueOf, enumValues: NotificationEventType.values, defaultEnumValue: NotificationEventType.NOTIFICATION_EVENT_TYPE_UNSPECIFIED)
    ..aOM<NotificationPreferences>(10, _omitFieldNames ? '' : 'preferences', subBuilder: NotificationPreferences.create)
    ..aOS(11, _omitFieldNames ? '' : 'lastNotificationAt')
    ..a<$core.int>(12, _omitFieldNames ? '' : 'notificationCount', $pb.PbFieldType.O3)
    ..a<$core.int>(13, _omitFieldNames ? '' : 'failureCount', $pb.PbFieldType.O3)
    ..aOS(14, _omitFieldNames ? '' : 'lastError')
    ..aOS(15, _omitFieldNames ? '' : 'createdAt')
    ..aOS(16, _omitFieldNames ? '' : 'updatedAt')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NotificationChannel clone() => NotificationChannel()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NotificationChannel copyWith(void Function(NotificationChannel) updates) => super.copyWith((message) => updates(message as NotificationChannel)) as NotificationChannel;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NotificationChannel create() => NotificationChannel._();
  NotificationChannel createEmptyInstance() => create();
  static $pb.PbList<NotificationChannel> createRepeated() => $pb.PbList<NotificationChannel>();
  @$core.pragma('dart2js:noInline')
  static NotificationChannel getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NotificationChannel>(create);
  static NotificationChannel? _defaultInstance;

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
  $core.String get channelIdentifier => $_getSZ(6);
  @$pb.TagNumber(7)
  set channelIdentifier($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasChannelIdentifier() => $_has(6);
  @$pb.TagNumber(7)
  void clearChannelIdentifier() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get channelUsername => $_getSZ(7);
  @$pb.TagNumber(8)
  set channelUsername($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasChannelUsername() => $_has(7);
  @$pb.TagNumber(8)
  void clearChannelUsername() => clearField(8);

  @$pb.TagNumber(9)
  $core.List<NotificationEventType> get enabledEvents => $_getList(8);

  @$pb.TagNumber(10)
  NotificationPreferences get preferences => $_getN(9);
  @$pb.TagNumber(10)
  set preferences(NotificationPreferences v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasPreferences() => $_has(9);
  @$pb.TagNumber(10)
  void clearPreferences() => clearField(10);
  @$pb.TagNumber(10)
  NotificationPreferences ensurePreferences() => $_ensure(9);

  @$pb.TagNumber(11)
  $core.String get lastNotificationAt => $_getSZ(10);
  @$pb.TagNumber(11)
  set lastNotificationAt($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasLastNotificationAt() => $_has(10);
  @$pb.TagNumber(11)
  void clearLastNotificationAt() => clearField(11);

  @$pb.TagNumber(12)
  $core.int get notificationCount => $_getIZ(11);
  @$pb.TagNumber(12)
  set notificationCount($core.int v) { $_setSignedInt32(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasNotificationCount() => $_has(11);
  @$pb.TagNumber(12)
  void clearNotificationCount() => clearField(12);

  @$pb.TagNumber(13)
  $core.int get failureCount => $_getIZ(12);
  @$pb.TagNumber(13)
  set failureCount($core.int v) { $_setSignedInt32(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasFailureCount() => $_has(12);
  @$pb.TagNumber(13)
  void clearFailureCount() => clearField(13);

  @$pb.TagNumber(14)
  $core.String get lastError => $_getSZ(13);
  @$pb.TagNumber(14)
  set lastError($core.String v) { $_setString(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasLastError() => $_has(13);
  @$pb.TagNumber(14)
  void clearLastError() => clearField(14);

  @$pb.TagNumber(15)
  $core.String get createdAt => $_getSZ(14);
  @$pb.TagNumber(15)
  set createdAt($core.String v) { $_setString(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasCreatedAt() => $_has(14);
  @$pb.TagNumber(15)
  void clearCreatedAt() => clearField(15);

  @$pb.TagNumber(16)
  $core.String get updatedAt => $_getSZ(15);
  @$pb.TagNumber(16)
  set updatedAt($core.String v) { $_setString(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasUpdatedAt() => $_has(15);
  @$pb.TagNumber(16)
  void clearUpdatedAt() => clearField(16);
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
  NotificationPreferences._() : super();
  factory NotificationPreferences.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NotificationPreferences.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'NotificationPreferences', package: const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'), createEmptyInstance: create)
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
  NotificationPreferences clone() => NotificationPreferences()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NotificationPreferences copyWith(void Function(NotificationPreferences) updates) => super.copyWith((message) => updates(message as NotificationPreferences)) as NotificationPreferences;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NotificationPreferences create() => NotificationPreferences._();
  NotificationPreferences createEmptyInstance() => create();
  static $pb.PbList<NotificationPreferences> createRepeated() => $pb.PbList<NotificationPreferences>();
  @$core.pragma('dart2js:noInline')
  static NotificationPreferences getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NotificationPreferences>(create);
  static NotificationPreferences? _defaultInstance;

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
  NotificationDelivery._() : super();
  factory NotificationDelivery.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NotificationDelivery.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'NotificationDelivery', package: const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'), createEmptyInstance: create)
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
  NotificationDelivery clone() => NotificationDelivery()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NotificationDelivery copyWith(void Function(NotificationDelivery) updates) => super.copyWith((message) => updates(message as NotificationDelivery)) as NotificationDelivery;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NotificationDelivery create() => NotificationDelivery._();
  NotificationDelivery createEmptyInstance() => create();
  static $pb.PbList<NotificationDelivery> createRepeated() => $pb.PbList<NotificationDelivery>();
  @$core.pragma('dart2js:noInline')
  static NotificationDelivery getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NotificationDelivery>(create);
  static NotificationDelivery? _defaultInstance;

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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ConnectNotificationChannelRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'), createEmptyInstance: create)
    ..oo(0, [4, 5, 6, 7])
    ..aOS(1, _omitFieldNames ? '' : 'crowdfundId')
    ..e<NotificationChannelType>(2, _omitFieldNames ? '' : 'channelType', $pb.PbFieldType.OE, defaultOrMaker: NotificationChannelType.NOTIFICATION_CHANNEL_TYPE_UNSPECIFIED, valueOf: NotificationChannelType.valueOf, enumValues: NotificationChannelType.values)
    ..aOS(3, _omitFieldNames ? '' : 'channelName')
    ..aOM<TelegramConnectionData>(4, _omitFieldNames ? '' : 'telegram', subBuilder: TelegramConnectionData.create)
    ..aOM<DiscordConnectionData>(5, _omitFieldNames ? '' : 'discord', subBuilder: DiscordConnectionData.create)
    ..aOM<WhatsAppBusinessConnectionData>(6, _omitFieldNames ? '' : 'whatsappBusiness', subBuilder: WhatsAppBusinessConnectionData.create)
    ..aOM<SlackConnectionData>(7, _omitFieldNames ? '' : 'slack', subBuilder: SlackConnectionData.create)
    ..pc<NotificationEventType>(8, _omitFieldNames ? '' : 'enabledEvents', $pb.PbFieldType.KE, valueOf: NotificationEventType.valueOf, enumValues: NotificationEventType.values, defaultEnumValue: NotificationEventType.NOTIFICATION_EVENT_TYPE_UNSPECIFIED)
    ..aOM<NotificationPreferences>(9, _omitFieldNames ? '' : 'preferences', subBuilder: NotificationPreferences.create)
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
  TelegramConnectionData get telegram => $_getN(3);
  @$pb.TagNumber(4)
  set telegram(TelegramConnectionData v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasTelegram() => $_has(3);
  @$pb.TagNumber(4)
  void clearTelegram() => clearField(4);
  @$pb.TagNumber(4)
  TelegramConnectionData ensureTelegram() => $_ensure(3);

  @$pb.TagNumber(5)
  DiscordConnectionData get discord => $_getN(4);
  @$pb.TagNumber(5)
  set discord(DiscordConnectionData v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasDiscord() => $_has(4);
  @$pb.TagNumber(5)
  void clearDiscord() => clearField(5);
  @$pb.TagNumber(5)
  DiscordConnectionData ensureDiscord() => $_ensure(4);

  @$pb.TagNumber(6)
  WhatsAppBusinessConnectionData get whatsappBusiness => $_getN(5);
  @$pb.TagNumber(6)
  set whatsappBusiness(WhatsAppBusinessConnectionData v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasWhatsappBusiness() => $_has(5);
  @$pb.TagNumber(6)
  void clearWhatsappBusiness() => clearField(6);
  @$pb.TagNumber(6)
  WhatsAppBusinessConnectionData ensureWhatsappBusiness() => $_ensure(5);

  @$pb.TagNumber(7)
  SlackConnectionData get slack => $_getN(6);
  @$pb.TagNumber(7)
  set slack(SlackConnectionData v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasSlack() => $_has(6);
  @$pb.TagNumber(7)
  void clearSlack() => clearField(7);
  @$pb.TagNumber(7)
  SlackConnectionData ensureSlack() => $_ensure(6);

  @$pb.TagNumber(8)
  $core.List<NotificationEventType> get enabledEvents => $_getList(7);

  @$pb.TagNumber(9)
  NotificationPreferences get preferences => $_getN(8);
  @$pb.TagNumber(9)
  set preferences(NotificationPreferences v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasPreferences() => $_has(8);
  @$pb.TagNumber(9)
  void clearPreferences() => clearField(9);
  @$pb.TagNumber(9)
  NotificationPreferences ensurePreferences() => $_ensure(8);
}

class TelegramConnectionData extends $pb.GeneratedMessage {
  factory TelegramConnectionData({
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
  TelegramConnectionData._() : super();
  factory TelegramConnectionData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TelegramConnectionData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TelegramConnectionData', package: const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'chatId')
    ..aOS(2, _omitFieldNames ? '' : 'verificationCode')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TelegramConnectionData clone() => TelegramConnectionData()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TelegramConnectionData copyWith(void Function(TelegramConnectionData) updates) => super.copyWith((message) => updates(message as TelegramConnectionData)) as TelegramConnectionData;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TelegramConnectionData create() => TelegramConnectionData._();
  TelegramConnectionData createEmptyInstance() => create();
  static $pb.PbList<TelegramConnectionData> createRepeated() => $pb.PbList<TelegramConnectionData>();
  @$core.pragma('dart2js:noInline')
  static TelegramConnectionData getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TelegramConnectionData>(create);
  static TelegramConnectionData? _defaultInstance;

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

class DiscordConnectionData extends $pb.GeneratedMessage {
  factory DiscordConnectionData({
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
  DiscordConnectionData._() : super();
  factory DiscordConnectionData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DiscordConnectionData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DiscordConnectionData', package: const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'webhookUrl')
    ..aOS(2, _omitFieldNames ? '' : 'serverName')
    ..aOS(3, _omitFieldNames ? '' : 'channelName')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DiscordConnectionData clone() => DiscordConnectionData()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DiscordConnectionData copyWith(void Function(DiscordConnectionData) updates) => super.copyWith((message) => updates(message as DiscordConnectionData)) as DiscordConnectionData;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DiscordConnectionData create() => DiscordConnectionData._();
  DiscordConnectionData createEmptyInstance() => create();
  static $pb.PbList<DiscordConnectionData> createRepeated() => $pb.PbList<DiscordConnectionData>();
  @$core.pragma('dart2js:noInline')
  static DiscordConnectionData getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DiscordConnectionData>(create);
  static DiscordConnectionData? _defaultInstance;

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

class WhatsAppBusinessConnectionData extends $pb.GeneratedMessage {
  factory WhatsAppBusinessConnectionData({
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
  WhatsAppBusinessConnectionData._() : super();
  factory WhatsAppBusinessConnectionData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WhatsAppBusinessConnectionData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'WhatsAppBusinessConnectionData', package: const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'phoneNumberId')
    ..aOS(2, _omitFieldNames ? '' : 'accessToken')
    ..aOS(3, _omitFieldNames ? '' : 'recipientId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  WhatsAppBusinessConnectionData clone() => WhatsAppBusinessConnectionData()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  WhatsAppBusinessConnectionData copyWith(void Function(WhatsAppBusinessConnectionData) updates) => super.copyWith((message) => updates(message as WhatsAppBusinessConnectionData)) as WhatsAppBusinessConnectionData;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WhatsAppBusinessConnectionData create() => WhatsAppBusinessConnectionData._();
  WhatsAppBusinessConnectionData createEmptyInstance() => create();
  static $pb.PbList<WhatsAppBusinessConnectionData> createRepeated() => $pb.PbList<WhatsAppBusinessConnectionData>();
  @$core.pragma('dart2js:noInline')
  static WhatsAppBusinessConnectionData getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WhatsAppBusinessConnectionData>(create);
  static WhatsAppBusinessConnectionData? _defaultInstance;

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

class SlackConnectionData extends $pb.GeneratedMessage {
  factory SlackConnectionData({
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
  SlackConnectionData._() : super();
  factory SlackConnectionData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SlackConnectionData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SlackConnectionData', package: const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'webhookUrl')
    ..aOS(2, _omitFieldNames ? '' : 'workspaceName')
    ..aOS(3, _omitFieldNames ? '' : 'channelName')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SlackConnectionData clone() => SlackConnectionData()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SlackConnectionData copyWith(void Function(SlackConnectionData) updates) => super.copyWith((message) => updates(message as SlackConnectionData)) as SlackConnectionData;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SlackConnectionData create() => SlackConnectionData._();
  SlackConnectionData createEmptyInstance() => create();
  static $pb.PbList<SlackConnectionData> createRepeated() => $pb.PbList<SlackConnectionData>();
  @$core.pragma('dart2js:noInline')
  static SlackConnectionData getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SlackConnectionData>(create);
  static SlackConnectionData? _defaultInstance;

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

class ConnectNotificationChannelResponse extends $pb.GeneratedMessage {
  factory ConnectNotificationChannelResponse({
    NotificationChannel? channel,
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

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ConnectNotificationChannelResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOM<NotificationChannel>(1, _omitFieldNames ? '' : 'channel', subBuilder: NotificationChannel.create)
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
  NotificationChannel get channel => $_getN(0);
  @$pb.TagNumber(1)
  set channel(NotificationChannel v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasChannel() => $_has(0);
  @$pb.TagNumber(1)
  void clearChannel() => clearField(1);
  @$pb.TagNumber(1)
  NotificationChannel ensureChannel() => $_ensure(0);

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

/// Disconnect notification channel
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

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DisconnectNotificationChannelRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'), createEmptyInstance: create)
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

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DisconnectNotificationChannelResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'), createEmptyInstance: create)
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

/// Get notification channels
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

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetNotificationChannelsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'), createEmptyInstance: create)
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
    $core.Iterable<NotificationChannel>? channels,
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

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetNotificationChannelsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'), createEmptyInstance: create)
    ..pc<NotificationChannel>(1, _omitFieldNames ? '' : 'channels', $pb.PbFieldType.PM, subBuilder: NotificationChannel.create)
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
  $core.List<NotificationChannel> get channels => $_getList(0);
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

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateNotificationChannelRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'channelId')
    ..aOS(2, _omitFieldNames ? '' : 'channelName')
    ..pc<NotificationEventType>(3, _omitFieldNames ? '' : 'enabledEvents', $pb.PbFieldType.KE, valueOf: NotificationEventType.valueOf, enumValues: NotificationEventType.values, defaultEnumValue: NotificationEventType.NOTIFICATION_EVENT_TYPE_UNSPECIFIED)
    ..aOM<NotificationPreferences>(4, _omitFieldNames ? '' : 'preferences', subBuilder: NotificationPreferences.create)
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
  NotificationPreferences get preferences => $_getN(3);
  @$pb.TagNumber(4)
  set preferences(NotificationPreferences v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasPreferences() => $_has(3);
  @$pb.TagNumber(4)
  void clearPreferences() => clearField(4);
  @$pb.TagNumber(4)
  NotificationPreferences ensurePreferences() => $_ensure(3);

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
    NotificationChannel? channel,
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

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateNotificationChannelResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOM<NotificationChannel>(1, _omitFieldNames ? '' : 'channel', subBuilder: NotificationChannel.create)
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
  NotificationChannel get channel => $_getN(0);
  @$pb.TagNumber(1)
  set channel(NotificationChannel v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasChannel() => $_has(0);
  @$pb.TagNumber(1)
  void clearChannel() => clearField(1);
  @$pb.TagNumber(1)
  NotificationChannel ensureChannel() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

/// Test notification channel
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

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TestNotificationChannelRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'), createEmptyInstance: create)
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

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TestNotificationChannelResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'), createEmptyInstance: create)
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

/// Get Telegram bot info
class GetTelegramBotInfoRequest extends $pb.GeneratedMessage {
  factory GetTelegramBotInfoRequest() => create();
  GetTelegramBotInfoRequest._() : super();
  factory GetTelegramBotInfoRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTelegramBotInfoRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetTelegramBotInfoRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'), createEmptyInstance: create)
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

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetTelegramBotInfoResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'), createEmptyInstance: create)
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

/// Verify Telegram channel
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

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'VerifyTelegramChannelRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'), createEmptyInstance: create)
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
    NotificationChannel? channel,
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

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'VerifyTelegramChannelResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOM<NotificationChannel>(2, _omitFieldNames ? '' : 'channel', subBuilder: NotificationChannel.create)
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
  NotificationChannel get channel => $_getN(1);
  @$pb.TagNumber(2)
  set channel(NotificationChannel v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasChannel() => $_has(1);
  @$pb.TagNumber(2)
  void clearChannel() => clearField(2);
  @$pb.TagNumber(2)
  NotificationChannel ensureChannel() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => clearField(3);
}

/// Get notification history
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

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetNotificationHistoryRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'), createEmptyInstance: create)
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
    $core.Iterable<NotificationDelivery>? deliveries,
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

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetNotificationHistoryResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'), createEmptyInstance: create)
    ..pc<NotificationDelivery>(1, _omitFieldNames ? '' : 'deliveries', $pb.PbFieldType.PM, subBuilder: NotificationDelivery.create)
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
  $core.List<NotificationDelivery> get deliveries => $_getList(0);

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


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
