///
//  Generated code. Do not modify.
//  source: financial-products.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'financial-products.pbenum.dart';

export 'financial-products.pbenum.dart';

class GroupAccount extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GroupAccount', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'creatorId')
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'balance', $pb.PbFieldType.OD)
    ..a<$core.double>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'targetAmount', $pb.PbFieldType.OD)
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..pc<GroupMember>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'members', $pb.PbFieldType.PM, subBuilder: GroupMember.create)
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'withdrawalRules')
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt')
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedAt')
    ..hasRequiredFields = false
  ;

  GroupAccount._() : super();
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
    if (creatorId != null) {
      _result.creatorId = creatorId;
    }
    if (balance != null) {
      _result.balance = balance;
    }
    if (targetAmount != null) {
      _result.targetAmount = targetAmount;
    }
    if (status != null) {
      _result.status = status;
    }
    if (members != null) {
      _result.members.addAll(members);
    }
    if (withdrawalRules != null) {
      _result.withdrawalRules = withdrawalRules;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      _result.updatedAt = updatedAt;
    }
    return _result;
  }
  factory GroupAccount.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GroupAccount.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GroupAccount clone() => GroupAccount()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GroupAccount copyWith(void Function(GroupAccount) updates) => super.copyWith((message) => updates(message as GroupAccount)) as GroupAccount; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GroupMember', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'role')
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'contribution', $pb.PbFieldType.OD)
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'joinedAt')
    ..hasRequiredFields = false
  ;

  GroupMember._() : super();
  factory GroupMember({
    $core.String? userId,
    $core.String? name,
    $core.String? role,
    $core.double? contribution,
    $core.String? joinedAt,
  }) {
    final _result = create();
    if (userId != null) {
      _result.userId = userId;
    }
    if (name != null) {
      _result.name = name;
    }
    if (role != null) {
      _result.role = role;
    }
    if (contribution != null) {
      _result.contribution = contribution;
    }
    if (joinedAt != null) {
      _result.joinedAt = joinedAt;
    }
    return _result;
  }
  factory GroupMember.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GroupMember.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GroupMember clone() => GroupMember()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GroupMember copyWith(void Function(GroupMember) updates) => super.copyWith((message) => updates(message as GroupMember)) as GroupMember; // ignore: deprecated_member_use
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

class Insurance extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Insurance', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountId')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'policyNumber')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'planId')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'planName')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'coverageType')
    ..a<$core.double>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'premium', $pb.PbFieldType.OD)
    ..a<$core.double>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'coverageAmount', $pb.PbFieldType.OD)
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'paymentFrequency')
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..aOS(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'startDate')
    ..aOS(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'endDate')
    ..aOS(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'nextPaymentDate')
    ..aOS(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'beneficiary')
    ..aOS(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'metadata')
    ..aOS(17, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt')
    ..aOS(18, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedAt')
    ..hasRequiredFields = false
  ;

  Insurance._() : super();
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
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    if (accountId != null) {
      _result.accountId = accountId;
    }
    if (policyNumber != null) {
      _result.policyNumber = policyNumber;
    }
    if (planId != null) {
      _result.planId = planId;
    }
    if (planName != null) {
      _result.planName = planName;
    }
    if (coverageType != null) {
      _result.coverageType = coverageType;
    }
    if (premium != null) {
      _result.premium = premium;
    }
    if (coverageAmount != null) {
      _result.coverageAmount = coverageAmount;
    }
    if (paymentFrequency != null) {
      _result.paymentFrequency = paymentFrequency;
    }
    if (status != null) {
      _result.status = status;
    }
    if (startDate != null) {
      _result.startDate = startDate;
    }
    if (endDate != null) {
      _result.endDate = endDate;
    }
    if (nextPaymentDate != null) {
      _result.nextPaymentDate = nextPaymentDate;
    }
    if (beneficiary != null) {
      _result.beneficiary = beneficiary;
    }
    if (metadata != null) {
      _result.metadata = metadata;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      _result.updatedAt = updatedAt;
    }
    return _result;
  }
  factory Insurance.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Insurance.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Insurance clone() => Insurance()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Insurance copyWith(void Function(Insurance) updates) => super.copyWith((message) => updates(message as Insurance)) as Insurance; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'InsurancePlan', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'coverageType')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'minPremium', $pb.PbFieldType.OD)
    ..a<$core.double>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'maxPremium', $pb.PbFieldType.OD)
    ..a<$core.double>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'coverageAmount', $pb.PbFieldType.OD)
    ..pPS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'benefits')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'terms')
    ..aOB(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isActive')
    ..hasRequiredFields = false
  ;

  InsurancePlan._() : super();
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
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (name != null) {
      _result.name = name;
    }
    if (coverageType != null) {
      _result.coverageType = coverageType;
    }
    if (description != null) {
      _result.description = description;
    }
    if (minPremium != null) {
      _result.minPremium = minPremium;
    }
    if (maxPremium != null) {
      _result.maxPremium = maxPremium;
    }
    if (coverageAmount != null) {
      _result.coverageAmount = coverageAmount;
    }
    if (benefits != null) {
      _result.benefits.addAll(benefits);
    }
    if (terms != null) {
      _result.terms = terms;
    }
    if (isActive != null) {
      _result.isActive = isActive;
    }
    return _result;
  }
  factory InsurancePlan.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InsurancePlan.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InsurancePlan clone() => InsurancePlan()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InsurancePlan copyWith(void Function(InsurancePlan) updates) => super.copyWith((message) => updates(message as InsurancePlan)) as InsurancePlan; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'InsuranceClaim', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'policyId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'claimAmount', $pb.PbFieldType.OD)
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reason')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'documents')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedAt')
    ..hasRequiredFields = false
  ;

  InsuranceClaim._() : super();
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
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (policyId != null) {
      _result.policyId = policyId;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    if (claimAmount != null) {
      _result.claimAmount = claimAmount;
    }
    if (reason != null) {
      _result.reason = reason;
    }
    if (status != null) {
      _result.status = status;
    }
    if (documents != null) {
      _result.documents = documents;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      _result.updatedAt = updatedAt;
    }
    return _result;
  }
  factory InsuranceClaim.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InsuranceClaim.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InsuranceClaim clone() => InsuranceClaim()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InsuranceClaim copyWith(void Function(InsuranceClaim) updates) => super.copyWith((message) => updates(message as InsuranceClaim)) as InsuranceClaim; // ignore: deprecated_member_use
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

class Crowdfund extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Crowdfund', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountId')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'title')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'category')
    ..a<$core.double>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'targetAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currentAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'percentageFunded', $pb.PbFieldType.OD)
    ..a<$core.int>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalContributors', $pb.PbFieldType.O3)
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..aOS(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'imageUrl')
    ..aOS(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'deadline')
    ..aOS(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt')
    ..aOS(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedAt')
    ..aOS(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'crowdfundCode')
    ..aOS(17, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'creatorFirstName')
    ..aOS(18, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'creatorLastName')
    ..aOS(19, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'creatorUsername')
    ..aOS(20, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'creatorEmail')
    ..hasRequiredFields = false
  ;

  Crowdfund._() : super();
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
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    if (accountId != null) {
      _result.accountId = accountId;
    }
    if (title != null) {
      _result.title = title;
    }
    if (description != null) {
      _result.description = description;
    }
    if (category != null) {
      _result.category = category;
    }
    if (targetAmount != null) {
      _result.targetAmount = targetAmount;
    }
    if (currentAmount != null) {
      _result.currentAmount = currentAmount;
    }
    if (percentageFunded != null) {
      _result.percentageFunded = percentageFunded;
    }
    if (totalContributors != null) {
      _result.totalContributors = totalContributors;
    }
    if (status != null) {
      _result.status = status;
    }
    if (imageUrl != null) {
      _result.imageUrl = imageUrl;
    }
    if (deadline != null) {
      _result.deadline = deadline;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      _result.updatedAt = updatedAt;
    }
    if (crowdfundCode != null) {
      _result.crowdfundCode = crowdfundCode;
    }
    if (creatorFirstName != null) {
      _result.creatorFirstName = creatorFirstName;
    }
    if (creatorLastName != null) {
      _result.creatorLastName = creatorLastName;
    }
    if (creatorUsername != null) {
      _result.creatorUsername = creatorUsername;
    }
    if (creatorEmail != null) {
      _result.creatorEmail = creatorEmail;
    }
    return _result;
  }
  factory Crowdfund.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Crowdfund.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Crowdfund clone() => Crowdfund()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Crowdfund copyWith(void Function(Crowdfund) updates) => super.copyWith((message) => updates(message as Crowdfund)) as Crowdfund; // ignore: deprecated_member_use
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

  @$pb.TagNumber(16)
  $core.String get crowdfundCode => $_getSZ(15);
  @$pb.TagNumber(16)
  set crowdfundCode($core.String v) { $_setString(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasCrowdfundCode() => $_has(15);
  @$pb.TagNumber(16)
  void clearCrowdfundCode() => clearField(16);

  @$pb.TagNumber(17)
  $core.String get creatorFirstName => $_getSZ(16);
  @$pb.TagNumber(17)
  set creatorFirstName($core.String v) { $_setString(16, v); }
  @$pb.TagNumber(17)
  $core.bool hasCreatorFirstName() => $_has(16);
  @$pb.TagNumber(17)
  void clearCreatorFirstName() => clearField(17);

  @$pb.TagNumber(18)
  $core.String get creatorLastName => $_getSZ(17);
  @$pb.TagNumber(18)
  set creatorLastName($core.String v) { $_setString(17, v); }
  @$pb.TagNumber(18)
  $core.bool hasCreatorLastName() => $_has(17);
  @$pb.TagNumber(18)
  void clearCreatorLastName() => clearField(18);

  @$pb.TagNumber(19)
  $core.String get creatorUsername => $_getSZ(18);
  @$pb.TagNumber(19)
  set creatorUsername($core.String v) { $_setString(18, v); }
  @$pb.TagNumber(19)
  $core.bool hasCreatorUsername() => $_has(18);
  @$pb.TagNumber(19)
  void clearCreatorUsername() => clearField(19);

  @$pb.TagNumber(20)
  $core.String get creatorEmail => $_getSZ(19);
  @$pb.TagNumber(20)
  set creatorEmail($core.String v) { $_setString(19, v); }
  @$pb.TagNumber(20)
  $core.bool hasCreatorEmail() => $_has(19);
  @$pb.TagNumber(20)
  void clearCreatorEmail() => clearField(20);
}

class CrowdfundContribution extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CrowdfundContribution', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'crowdfundId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOB(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isAnonymous')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt')
    ..hasRequiredFields = false
  ;

  CrowdfundContribution._() : super();
  factory CrowdfundContribution({
    $core.String? id,
    $core.String? crowdfundId,
    $core.String? userId,
    $core.double? amount,
    $core.String? message,
    $core.bool? isAnonymous,
    $core.String? createdAt,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (crowdfundId != null) {
      _result.crowdfundId = crowdfundId;
    }
    if (userId != null) {
      _result.userId = userId;
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
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    return _result;
  }
  factory CrowdfundContribution.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CrowdfundContribution.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CrowdfundContribution clone() => CrowdfundContribution()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CrowdfundContribution copyWith(void Function(CrowdfundContribution) updates) => super.copyWith((message) => updates(message as CrowdfundContribution)) as CrowdfundContribution; // ignore: deprecated_member_use
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

class CreateGroupAccountRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateGroupAccountRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'targetAmount', $pb.PbFieldType.OD)
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'withdrawalRules')
    ..pPS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'memberIds')
    ..hasRequiredFields = false
  ;

  CreateGroupAccountRequest._() : super();
  factory CreateGroupAccountRequest({
    $core.String? accountId,
    $core.String? name,
    $core.String? description,
    $core.double? targetAmount,
    $core.String? withdrawalRules,
    $core.Iterable<$core.String>? memberIds,
  }) {
    final _result = create();
    if (accountId != null) {
      _result.accountId = accountId;
    }
    if (name != null) {
      _result.name = name;
    }
    if (description != null) {
      _result.description = description;
    }
    if (targetAmount != null) {
      _result.targetAmount = targetAmount;
    }
    if (withdrawalRules != null) {
      _result.withdrawalRules = withdrawalRules;
    }
    if (memberIds != null) {
      _result.memberIds.addAll(memberIds);
    }
    return _result;
  }
  factory CreateGroupAccountRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateGroupAccountRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateGroupAccountRequest clone() => CreateGroupAccountRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateGroupAccountRequest copyWith(void Function(CreateGroupAccountRequest) updates) => super.copyWith((message) => updates(message as CreateGroupAccountRequest)) as CreateGroupAccountRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateGroupAccountResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOM<GroupAccount>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'groupAccount', subBuilder: GroupAccount.create)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  CreateGroupAccountResponse._() : super();
  factory CreateGroupAccountResponse({
    GroupAccount? groupAccount,
    $core.String? message,
  }) {
    final _result = create();
    if (groupAccount != null) {
      _result.groupAccount = groupAccount;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory CreateGroupAccountResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateGroupAccountResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateGroupAccountResponse clone() => CreateGroupAccountResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateGroupAccountResponse copyWith(void Function(CreateGroupAccountResponse) updates) => super.copyWith((message) => updates(message as CreateGroupAccountResponse)) as CreateGroupAccountResponse; // ignore: deprecated_member_use
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

class GetGroupAccountsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetGroupAccountsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetGroupAccountsRequest._() : super();
  factory GetGroupAccountsRequest({
    $core.String? status,
    $core.int? limit,
    $core.int? offset,
  }) {
    final _result = create();
    if (status != null) {
      _result.status = status;
    }
    if (limit != null) {
      _result.limit = limit;
    }
    if (offset != null) {
      _result.offset = offset;
    }
    return _result;
  }
  factory GetGroupAccountsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetGroupAccountsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetGroupAccountsRequest clone() => GetGroupAccountsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetGroupAccountsRequest copyWith(void Function(GetGroupAccountsRequest) updates) => super.copyWith((message) => updates(message as GetGroupAccountsRequest)) as GetGroupAccountsRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetGroupAccountsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..pc<GroupAccount>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'groupAccounts', $pb.PbFieldType.PM, subBuilder: GroupAccount.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetGroupAccountsResponse._() : super();
  factory GetGroupAccountsResponse({
    $core.Iterable<GroupAccount>? groupAccounts,
    $core.int? total,
  }) {
    final _result = create();
    if (groupAccounts != null) {
      _result.groupAccounts.addAll(groupAccounts);
    }
    if (total != null) {
      _result.total = total;
    }
    return _result;
  }
  factory GetGroupAccountsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetGroupAccountsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetGroupAccountsResponse clone() => GetGroupAccountsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetGroupAccountsResponse copyWith(void Function(GetGroupAccountsResponse) updates) => super.copyWith((message) => updates(message as GetGroupAccountsResponse)) as GetGroupAccountsResponse; // ignore: deprecated_member_use
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

class GetGroupAccountRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetGroupAccountRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'groupId')
    ..hasRequiredFields = false
  ;

  GetGroupAccountRequest._() : super();
  factory GetGroupAccountRequest({
    $core.String? groupId,
  }) {
    final _result = create();
    if (groupId != null) {
      _result.groupId = groupId;
    }
    return _result;
  }
  factory GetGroupAccountRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetGroupAccountRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetGroupAccountRequest clone() => GetGroupAccountRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetGroupAccountRequest copyWith(void Function(GetGroupAccountRequest) updates) => super.copyWith((message) => updates(message as GetGroupAccountRequest)) as GetGroupAccountRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetGroupAccountResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOM<GroupAccount>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'groupAccount', subBuilder: GroupAccount.create)
    ..hasRequiredFields = false
  ;

  GetGroupAccountResponse._() : super();
  factory GetGroupAccountResponse({
    GroupAccount? groupAccount,
  }) {
    final _result = create();
    if (groupAccount != null) {
      _result.groupAccount = groupAccount;
    }
    return _result;
  }
  factory GetGroupAccountResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetGroupAccountResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetGroupAccountResponse clone() => GetGroupAccountResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetGroupAccountResponse copyWith(void Function(GetGroupAccountResponse) updates) => super.copyWith((message) => updates(message as GetGroupAccountResponse)) as GetGroupAccountResponse; // ignore: deprecated_member_use
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

class AddGroupMemberRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AddGroupMemberRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'groupId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'memberId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'role')
    ..hasRequiredFields = false
  ;

  AddGroupMemberRequest._() : super();
  factory AddGroupMemberRequest({
    $core.String? groupId,
    $core.String? memberId,
    $core.String? role,
  }) {
    final _result = create();
    if (groupId != null) {
      _result.groupId = groupId;
    }
    if (memberId != null) {
      _result.memberId = memberId;
    }
    if (role != null) {
      _result.role = role;
    }
    return _result;
  }
  factory AddGroupMemberRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddGroupMemberRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddGroupMemberRequest clone() => AddGroupMemberRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddGroupMemberRequest copyWith(void Function(AddGroupMemberRequest) updates) => super.copyWith((message) => updates(message as AddGroupMemberRequest)) as AddGroupMemberRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AddGroupMemberResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOM<GroupAccount>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'groupAccount', subBuilder: GroupAccount.create)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  AddGroupMemberResponse._() : super();
  factory AddGroupMemberResponse({
    GroupAccount? groupAccount,
    $core.String? message,
  }) {
    final _result = create();
    if (groupAccount != null) {
      _result.groupAccount = groupAccount;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory AddGroupMemberResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddGroupMemberResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddGroupMemberResponse clone() => AddGroupMemberResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddGroupMemberResponse copyWith(void Function(AddGroupMemberResponse) updates) => super.copyWith((message) => updates(message as AddGroupMemberResponse)) as AddGroupMemberResponse; // ignore: deprecated_member_use
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

class RemoveGroupMemberRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RemoveGroupMemberRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'groupId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'memberId')
    ..hasRequiredFields = false
  ;

  RemoveGroupMemberRequest._() : super();
  factory RemoveGroupMemberRequest({
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
  factory RemoveGroupMemberRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RemoveGroupMemberRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RemoveGroupMemberRequest clone() => RemoveGroupMemberRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RemoveGroupMemberRequest copyWith(void Function(RemoveGroupMemberRequest) updates) => super.copyWith((message) => updates(message as RemoveGroupMemberRequest)) as RemoveGroupMemberRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RemoveGroupMemberResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOM<GroupAccount>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'groupAccount', subBuilder: GroupAccount.create)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  RemoveGroupMemberResponse._() : super();
  factory RemoveGroupMemberResponse({
    GroupAccount? groupAccount,
    $core.String? message,
  }) {
    final _result = create();
    if (groupAccount != null) {
      _result.groupAccount = groupAccount;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory RemoveGroupMemberResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RemoveGroupMemberResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RemoveGroupMemberResponse clone() => RemoveGroupMemberResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RemoveGroupMemberResponse copyWith(void Function(RemoveGroupMemberResponse) updates) => super.copyWith((message) => updates(message as RemoveGroupMemberResponse)) as RemoveGroupMemberResponse; // ignore: deprecated_member_use
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

class ContributeToGroupRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ContributeToGroupRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'groupId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountId')
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pin')
    ..hasRequiredFields = false
  ;

  ContributeToGroupRequest._() : super();
  factory ContributeToGroupRequest({
    $core.String? groupId,
    $core.String? accountId,
    $core.double? amount,
    $core.String? pin,
  }) {
    final _result = create();
    if (groupId != null) {
      _result.groupId = groupId;
    }
    if (accountId != null) {
      _result.accountId = accountId;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (pin != null) {
      _result.pin = pin;
    }
    return _result;
  }
  factory ContributeToGroupRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ContributeToGroupRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ContributeToGroupRequest clone() => ContributeToGroupRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ContributeToGroupRequest copyWith(void Function(ContributeToGroupRequest) updates) => super.copyWith((message) => updates(message as ContributeToGroupRequest)) as ContributeToGroupRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ContributeToGroupResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOM<GroupAccount>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'groupAccount', subBuilder: GroupAccount.create)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'newBalance', $pb.PbFieldType.OD)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  ContributeToGroupResponse._() : super();
  factory ContributeToGroupResponse({
    GroupAccount? groupAccount,
    $core.double? newBalance,
    $core.String? message,
  }) {
    final _result = create();
    if (groupAccount != null) {
      _result.groupAccount = groupAccount;
    }
    if (newBalance != null) {
      _result.newBalance = newBalance;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory ContributeToGroupResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ContributeToGroupResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ContributeToGroupResponse clone() => ContributeToGroupResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ContributeToGroupResponse copyWith(void Function(ContributeToGroupResponse) updates) => super.copyWith((message) => updates(message as ContributeToGroupResponse)) as ContributeToGroupResponse; // ignore: deprecated_member_use
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

class WithdrawFromGroupRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'WithdrawFromGroupRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'groupId')
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reason')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pin')
    ..hasRequiredFields = false
  ;

  WithdrawFromGroupRequest._() : super();
  factory WithdrawFromGroupRequest({
    $core.String? groupId,
    $core.double? amount,
    $core.String? reason,
    $core.String? pin,
  }) {
    final _result = create();
    if (groupId != null) {
      _result.groupId = groupId;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (reason != null) {
      _result.reason = reason;
    }
    if (pin != null) {
      _result.pin = pin;
    }
    return _result;
  }
  factory WithdrawFromGroupRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WithdrawFromGroupRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  WithdrawFromGroupRequest clone() => WithdrawFromGroupRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  WithdrawFromGroupRequest copyWith(void Function(WithdrawFromGroupRequest) updates) => super.copyWith((message) => updates(message as WithdrawFromGroupRequest)) as WithdrawFromGroupRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'WithdrawFromGroupResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOM<GroupAccount>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'groupAccount', subBuilder: GroupAccount.create)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  WithdrawFromGroupResponse._() : super();
  factory WithdrawFromGroupResponse({
    GroupAccount? groupAccount,
    $core.String? message,
  }) {
    final _result = create();
    if (groupAccount != null) {
      _result.groupAccount = groupAccount;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory WithdrawFromGroupResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WithdrawFromGroupResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  WithdrawFromGroupResponse clone() => WithdrawFromGroupResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  WithdrawFromGroupResponse copyWith(void Function(WithdrawFromGroupResponse) updates) => super.copyWith((message) => updates(message as WithdrawFromGroupResponse)) as WithdrawFromGroupResponse; // ignore: deprecated_member_use
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

class CloseGroupAccountRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CloseGroupAccountRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'groupId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pin')
    ..hasRequiredFields = false
  ;

  CloseGroupAccountRequest._() : super();
  factory CloseGroupAccountRequest({
    $core.String? groupId,
    $core.String? pin,
  }) {
    final _result = create();
    if (groupId != null) {
      _result.groupId = groupId;
    }
    if (pin != null) {
      _result.pin = pin;
    }
    return _result;
  }
  factory CloseGroupAccountRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CloseGroupAccountRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CloseGroupAccountRequest clone() => CloseGroupAccountRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CloseGroupAccountRequest copyWith(void Function(CloseGroupAccountRequest) updates) => super.copyWith((message) => updates(message as CloseGroupAccountRequest)) as CloseGroupAccountRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CloseGroupAccountResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOM<GroupAccount>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'groupAccount', subBuilder: GroupAccount.create)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  CloseGroupAccountResponse._() : super();
  factory CloseGroupAccountResponse({
    GroupAccount? groupAccount,
    $core.String? message,
  }) {
    final _result = create();
    if (groupAccount != null) {
      _result.groupAccount = groupAccount;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory CloseGroupAccountResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CloseGroupAccountResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CloseGroupAccountResponse clone() => CloseGroupAccountResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CloseGroupAccountResponse copyWith(void Function(CloseGroupAccountResponse) updates) => super.copyWith((message) => updates(message as CloseGroupAccountResponse)) as CloseGroupAccountResponse; // ignore: deprecated_member_use
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

class BuyInsuranceRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'BuyInsuranceRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'planId')
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'coverageAmount', $pb.PbFieldType.OD)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'paymentFrequency')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'beneficiary')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pin')
    ..hasRequiredFields = false
  ;

  BuyInsuranceRequest._() : super();
  factory BuyInsuranceRequest({
    $core.String? accountId,
    $core.String? planId,
    $core.double? coverageAmount,
    $core.String? paymentFrequency,
    $core.String? beneficiary,
    $core.String? pin,
  }) {
    final _result = create();
    if (accountId != null) {
      _result.accountId = accountId;
    }
    if (planId != null) {
      _result.planId = planId;
    }
    if (coverageAmount != null) {
      _result.coverageAmount = coverageAmount;
    }
    if (paymentFrequency != null) {
      _result.paymentFrequency = paymentFrequency;
    }
    if (beneficiary != null) {
      _result.beneficiary = beneficiary;
    }
    if (pin != null) {
      _result.pin = pin;
    }
    return _result;
  }
  factory BuyInsuranceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BuyInsuranceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BuyInsuranceRequest clone() => BuyInsuranceRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BuyInsuranceRequest copyWith(void Function(BuyInsuranceRequest) updates) => super.copyWith((message) => updates(message as BuyInsuranceRequest)) as BuyInsuranceRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'BuyInsuranceResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOM<Insurance>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'insurance', subBuilder: Insurance.create)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'firstPremium', $pb.PbFieldType.OD)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'newBalance', $pb.PbFieldType.OD)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  BuyInsuranceResponse._() : super();
  factory BuyInsuranceResponse({
    Insurance? insurance,
    $core.double? firstPremium,
    $core.double? newBalance,
    $core.String? message,
  }) {
    final _result = create();
    if (insurance != null) {
      _result.insurance = insurance;
    }
    if (firstPremium != null) {
      _result.firstPremium = firstPremium;
    }
    if (newBalance != null) {
      _result.newBalance = newBalance;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory BuyInsuranceResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BuyInsuranceResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BuyInsuranceResponse clone() => BuyInsuranceResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BuyInsuranceResponse copyWith(void Function(BuyInsuranceResponse) updates) => super.copyWith((message) => updates(message as BuyInsuranceResponse)) as BuyInsuranceResponse; // ignore: deprecated_member_use
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

class GetInsurancePoliciesRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInsurancePoliciesRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetInsurancePoliciesRequest._() : super();
  factory GetInsurancePoliciesRequest({
    $core.String? status,
    $core.int? limit,
    $core.int? offset,
  }) {
    final _result = create();
    if (status != null) {
      _result.status = status;
    }
    if (limit != null) {
      _result.limit = limit;
    }
    if (offset != null) {
      _result.offset = offset;
    }
    return _result;
  }
  factory GetInsurancePoliciesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInsurancePoliciesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInsurancePoliciesRequest clone() => GetInsurancePoliciesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInsurancePoliciesRequest copyWith(void Function(GetInsurancePoliciesRequest) updates) => super.copyWith((message) => updates(message as GetInsurancePoliciesRequest)) as GetInsurancePoliciesRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInsurancePoliciesResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..pc<Insurance>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'policies', $pb.PbFieldType.PM, subBuilder: Insurance.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'total', $pb.PbFieldType.O3)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalCoverage', $pb.PbFieldType.OD)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalPremiumsPaid', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  GetInsurancePoliciesResponse._() : super();
  factory GetInsurancePoliciesResponse({
    $core.Iterable<Insurance>? policies,
    $core.int? total,
    $core.double? totalCoverage,
    $core.double? totalPremiumsPaid,
  }) {
    final _result = create();
    if (policies != null) {
      _result.policies.addAll(policies);
    }
    if (total != null) {
      _result.total = total;
    }
    if (totalCoverage != null) {
      _result.totalCoverage = totalCoverage;
    }
    if (totalPremiumsPaid != null) {
      _result.totalPremiumsPaid = totalPremiumsPaid;
    }
    return _result;
  }
  factory GetInsurancePoliciesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInsurancePoliciesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInsurancePoliciesResponse clone() => GetInsurancePoliciesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInsurancePoliciesResponse copyWith(void Function(GetInsurancePoliciesResponse) updates) => super.copyWith((message) => updates(message as GetInsurancePoliciesResponse)) as GetInsurancePoliciesResponse; // ignore: deprecated_member_use
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

class GetInsurancePolicyRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInsurancePolicyRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'policyId')
    ..hasRequiredFields = false
  ;

  GetInsurancePolicyRequest._() : super();
  factory GetInsurancePolicyRequest({
    $core.String? policyId,
  }) {
    final _result = create();
    if (policyId != null) {
      _result.policyId = policyId;
    }
    return _result;
  }
  factory GetInsurancePolicyRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInsurancePolicyRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInsurancePolicyRequest clone() => GetInsurancePolicyRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInsurancePolicyRequest copyWith(void Function(GetInsurancePolicyRequest) updates) => super.copyWith((message) => updates(message as GetInsurancePolicyRequest)) as GetInsurancePolicyRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInsurancePolicyResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOM<Insurance>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'insurance', subBuilder: Insurance.create)
    ..hasRequiredFields = false
  ;

  GetInsurancePolicyResponse._() : super();
  factory GetInsurancePolicyResponse({
    Insurance? insurance,
  }) {
    final _result = create();
    if (insurance != null) {
      _result.insurance = insurance;
    }
    return _result;
  }
  factory GetInsurancePolicyResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInsurancePolicyResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInsurancePolicyResponse clone() => GetInsurancePolicyResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInsurancePolicyResponse copyWith(void Function(GetInsurancePolicyResponse) updates) => super.copyWith((message) => updates(message as GetInsurancePolicyResponse)) as GetInsurancePolicyResponse; // ignore: deprecated_member_use
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

class MakeInsuranceClaimRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MakeInsuranceClaimRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'policyId')
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'claimAmount', $pb.PbFieldType.OD)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reason')
    ..pPS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'documents')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'claimType')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'title')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'incidentDate')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'incidentLocation')
    ..m<$core.String, $core.String>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'additionalInfo', entryClassName: 'MakeInsuranceClaimRequest.AdditionalInfoEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('financialproducts'))
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'idempotencyKey')
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..pPS(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'attachments')
    ..hasRequiredFields = false
  ;

  MakeInsuranceClaimRequest._() : super();
  factory MakeInsuranceClaimRequest({
    $core.String? policyId,
    $core.double? claimAmount,
    $core.String? reason,
    $core.Iterable<$core.String>? documents,
    $core.String? claimType,
    $core.String? title,
    $core.String? incidentDate,
    $core.String? incidentLocation,
    $core.Map<$core.String, $core.String>? additionalInfo,
    $core.String? idempotencyKey,
    $core.String? currency,
    $core.Iterable<$core.String>? attachments,
  }) {
    final _result = create();
    if (policyId != null) {
      _result.policyId = policyId;
    }
    if (claimAmount != null) {
      _result.claimAmount = claimAmount;
    }
    if (reason != null) {
      _result.reason = reason;
    }
    if (documents != null) {
      _result.documents.addAll(documents);
    }
    if (claimType != null) {
      _result.claimType = claimType;
    }
    if (title != null) {
      _result.title = title;
    }
    if (incidentDate != null) {
      _result.incidentDate = incidentDate;
    }
    if (incidentLocation != null) {
      _result.incidentLocation = incidentLocation;
    }
    if (additionalInfo != null) {
      _result.additionalInfo.addAll(additionalInfo);
    }
    if (idempotencyKey != null) {
      _result.idempotencyKey = idempotencyKey;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (attachments != null) {
      _result.attachments.addAll(attachments);
    }
    return _result;
  }
  factory MakeInsuranceClaimRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MakeInsuranceClaimRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MakeInsuranceClaimRequest clone() => MakeInsuranceClaimRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MakeInsuranceClaimRequest copyWith(void Function(MakeInsuranceClaimRequest) updates) => super.copyWith((message) => updates(message as MakeInsuranceClaimRequest)) as MakeInsuranceClaimRequest; // ignore: deprecated_member_use
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

  @$pb.TagNumber(5)
  $core.String get claimType => $_getSZ(4);
  @$pb.TagNumber(5)
  set claimType($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasClaimType() => $_has(4);
  @$pb.TagNumber(5)
  void clearClaimType() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get title => $_getSZ(5);
  @$pb.TagNumber(6)
  set title($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasTitle() => $_has(5);
  @$pb.TagNumber(6)
  void clearTitle() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get incidentDate => $_getSZ(6);
  @$pb.TagNumber(7)
  set incidentDate($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasIncidentDate() => $_has(6);
  @$pb.TagNumber(7)
  void clearIncidentDate() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get incidentLocation => $_getSZ(7);
  @$pb.TagNumber(8)
  set incidentLocation($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasIncidentLocation() => $_has(7);
  @$pb.TagNumber(8)
  void clearIncidentLocation() => clearField(8);

  @$pb.TagNumber(9)
  $core.Map<$core.String, $core.String> get additionalInfo => $_getMap(8);

  @$pb.TagNumber(10)
  $core.String get idempotencyKey => $_getSZ(9);
  @$pb.TagNumber(10)
  set idempotencyKey($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasIdempotencyKey() => $_has(9);
  @$pb.TagNumber(10)
  void clearIdempotencyKey() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get currency => $_getSZ(10);
  @$pb.TagNumber(11)
  set currency($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasCurrency() => $_has(10);
  @$pb.TagNumber(11)
  void clearCurrency() => clearField(11);

  @$pb.TagNumber(12)
  $core.List<$core.String> get attachments => $_getList(11);
}

class MakeInsuranceClaimResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MakeInsuranceClaimResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOM<InsuranceClaimRecord>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'claim', subBuilder: InsuranceClaimRecord.create)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  MakeInsuranceClaimResponse._() : super();
  factory MakeInsuranceClaimResponse({
    InsuranceClaimRecord? claim,
    $core.String? message,
  }) {
    final _result = create();
    if (claim != null) {
      _result.claim = claim;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory MakeInsuranceClaimResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MakeInsuranceClaimResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MakeInsuranceClaimResponse clone() => MakeInsuranceClaimResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MakeInsuranceClaimResponse copyWith(void Function(MakeInsuranceClaimResponse) updates) => super.copyWith((message) => updates(message as MakeInsuranceClaimResponse)) as MakeInsuranceClaimResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MakeInsuranceClaimResponse create() => MakeInsuranceClaimResponse._();
  MakeInsuranceClaimResponse createEmptyInstance() => create();
  static $pb.PbList<MakeInsuranceClaimResponse> createRepeated() => $pb.PbList<MakeInsuranceClaimResponse>();
  @$core.pragma('dart2js:noInline')
  static MakeInsuranceClaimResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MakeInsuranceClaimResponse>(create);
  static MakeInsuranceClaimResponse? _defaultInstance;

  @$pb.TagNumber(1)
  InsuranceClaimRecord get claim => $_getN(0);
  @$pb.TagNumber(1)
  set claim(InsuranceClaimRecord v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasClaim() => $_has(0);
  @$pb.TagNumber(1)
  void clearClaim() => clearField(1);
  @$pb.TagNumber(1)
  InsuranceClaimRecord ensureClaim() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

class CancelInsuranceRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CancelInsuranceRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'policyId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reason')
    ..hasRequiredFields = false
  ;

  CancelInsuranceRequest._() : super();
  factory CancelInsuranceRequest({
    $core.String? policyId,
    $core.String? reason,
  }) {
    final _result = create();
    if (policyId != null) {
      _result.policyId = policyId;
    }
    if (reason != null) {
      _result.reason = reason;
    }
    return _result;
  }
  factory CancelInsuranceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CancelInsuranceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CancelInsuranceRequest clone() => CancelInsuranceRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CancelInsuranceRequest copyWith(void Function(CancelInsuranceRequest) updates) => super.copyWith((message) => updates(message as CancelInsuranceRequest)) as CancelInsuranceRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CancelInsuranceResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOM<Insurance>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'insurance', subBuilder: Insurance.create)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  CancelInsuranceResponse._() : super();
  factory CancelInsuranceResponse({
    Insurance? insurance,
    $core.String? message,
  }) {
    final _result = create();
    if (insurance != null) {
      _result.insurance = insurance;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory CancelInsuranceResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CancelInsuranceResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CancelInsuranceResponse clone() => CancelInsuranceResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CancelInsuranceResponse copyWith(void Function(CancelInsuranceResponse) updates) => super.copyWith((message) => updates(message as CancelInsuranceResponse)) as CancelInsuranceResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInsurancePlansRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'coverageType')
    ..hasRequiredFields = false
  ;

  GetInsurancePlansRequest._() : super();
  factory GetInsurancePlansRequest({
    $core.String? coverageType,
  }) {
    final _result = create();
    if (coverageType != null) {
      _result.coverageType = coverageType;
    }
    return _result;
  }
  factory GetInsurancePlansRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInsurancePlansRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInsurancePlansRequest clone() => GetInsurancePlansRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInsurancePlansRequest copyWith(void Function(GetInsurancePlansRequest) updates) => super.copyWith((message) => updates(message as GetInsurancePlansRequest)) as GetInsurancePlansRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInsurancePlansResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..pc<InsurancePlan>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'plans', $pb.PbFieldType.PM, subBuilder: InsurancePlan.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetInsurancePlansResponse._() : super();
  factory GetInsurancePlansResponse({
    $core.Iterable<InsurancePlan>? plans,
    $core.int? total,
  }) {
    final _result = create();
    if (plans != null) {
      _result.plans.addAll(plans);
    }
    if (total != null) {
      _result.total = total;
    }
    return _result;
  }
  factory GetInsurancePlansResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInsurancePlansResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInsurancePlansResponse clone() => GetInsurancePlansResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInsurancePlansResponse copyWith(void Function(GetInsurancePlansResponse) updates) => super.copyWith((message) => updates(message as GetInsurancePlansResponse)) as GetInsurancePlansResponse; // ignore: deprecated_member_use
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

class MarketplaceProductFormField extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MarketplaceProductFormField', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'label')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type')
    ..aOB(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'required')
    ..pPS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'options')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'defaultValue')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'validationRegex')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'placeholder')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..hasRequiredFields = false
  ;

  MarketplaceProductFormField._() : super();
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
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    if (label != null) {
      _result.label = label;
    }
    if (type != null) {
      _result.type = type;
    }
    if (required != null) {
      _result.required = required;
    }
    if (options != null) {
      _result.options.addAll(options);
    }
    if (defaultValue != null) {
      _result.defaultValue = defaultValue;
    }
    if (validationRegex != null) {
      _result.validationRegex = validationRegex;
    }
    if (placeholder != null) {
      _result.placeholder = placeholder;
    }
    if (description != null) {
      _result.description = description;
    }
    return _result;
  }
  factory MarketplaceProductFormField.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MarketplaceProductFormField.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MarketplaceProductFormField clone() => MarketplaceProductFormField()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MarketplaceProductFormField copyWith(void Function(MarketplaceProductFormField) updates) => super.copyWith((message) => updates(message as MarketplaceProductFormField)) as MarketplaceProductFormField; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MarketplaceProductFormField create() => MarketplaceProductFormField._();
  MarketplaceProductFormField createEmptyInstance() => create();
  static $pb.PbList<MarketplaceProductFormField> createRepeated() => $pb.PbList<MarketplaceProductFormField>();
  @$core.pragma('dart2js:noInline')
  static MarketplaceProductFormField getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MarketplaceProductFormField>(create);
  static MarketplaceProductFormField? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get label => $_getSZ(1);
  @$pb.TagNumber(2)
  set label($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLabel() => $_has(1);
  @$pb.TagNumber(2)
  void clearLabel() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get type => $_getSZ(2);
  @$pb.TagNumber(3)
  set type($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasType() => $_has(2);
  @$pb.TagNumber(3)
  void clearType() => clearField(3);

  @$pb.TagNumber(4)
  $core.bool get required => $_getBF(3);
  @$pb.TagNumber(4)
  set required($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasRequired() => $_has(3);
  @$pb.TagNumber(4)
  void clearRequired() => clearField(4);

  @$pb.TagNumber(5)
  $core.List<$core.String> get options => $_getList(4);

  @$pb.TagNumber(6)
  $core.String get defaultValue => $_getSZ(5);
  @$pb.TagNumber(6)
  set defaultValue($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasDefaultValue() => $_has(5);
  @$pb.TagNumber(6)
  void clearDefaultValue() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get validationRegex => $_getSZ(6);
  @$pb.TagNumber(7)
  set validationRegex($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasValidationRegex() => $_has(6);
  @$pb.TagNumber(7)
  void clearValidationRegex() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get placeholder => $_getSZ(7);
  @$pb.TagNumber(8)
  set placeholder($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasPlaceholder() => $_has(7);
  @$pb.TagNumber(8)
  void clearPlaceholder() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get description => $_getSZ(8);
  @$pb.TagNumber(9)
  set description($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasDescription() => $_has(8);
  @$pb.TagNumber(9)
  void clearDescription() => clearField(9);
}

class MarketplaceInsuranceProduct extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MarketplaceInsuranceProduct', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'category')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerName')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerLogo')
    ..a<$core.double>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'minPremium', $pb.PbFieldType.OD)
    ..a<$core.double>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'maxPremium', $pb.PbFieldType.OD)
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..pPS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'benefits')
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'termsUrl')
    ..m<$core.String, $core.String>(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'metadata', entryClassName: 'MarketplaceInsuranceProduct.MetadataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('financialproducts'))
    ..pc<MarketplaceProductFormField>(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'formFields', $pb.PbFieldType.PM, subBuilder: MarketplaceProductFormField.create)
    ..aOB(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isActive')
    ..aOS(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'purchaseRoute')
    ..aOS(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerId')
    ..a<$core.double>(17, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'basePrice', $pb.PbFieldType.OD)
    ..aOS(18, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'howItWorks')
    ..aOS(19, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fullBenefits')
    ..aOB(20, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isRenewable')
    ..aOB(21, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isClaimable')
    ..hasRequiredFields = false
  ;

  MarketplaceInsuranceProduct._() : super();
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
    $core.Map<$core.String, $core.String>? metadata,
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
    if (category != null) {
      _result.category = category;
    }
    if (providerName != null) {
      _result.providerName = providerName;
    }
    if (providerLogo != null) {
      _result.providerLogo = providerLogo;
    }
    if (minPremium != null) {
      _result.minPremium = minPremium;
    }
    if (maxPremium != null) {
      _result.maxPremium = maxPremium;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (benefits != null) {
      _result.benefits.addAll(benefits);
    }
    if (termsUrl != null) {
      _result.termsUrl = termsUrl;
    }
    if (metadata != null) {
      _result.metadata.addAll(metadata);
    }
    if (formFields != null) {
      _result.formFields.addAll(formFields);
    }
    if (isActive != null) {
      _result.isActive = isActive;
    }
    if (purchaseRoute != null) {
      _result.purchaseRoute = purchaseRoute;
    }
    if (providerId != null) {
      _result.providerId = providerId;
    }
    if (basePrice != null) {
      _result.basePrice = basePrice;
    }
    if (howItWorks != null) {
      _result.howItWorks = howItWorks;
    }
    if (fullBenefits != null) {
      _result.fullBenefits = fullBenefits;
    }
    if (isRenewable != null) {
      _result.isRenewable = isRenewable;
    }
    if (isClaimable != null) {
      _result.isClaimable = isClaimable;
    }
    return _result;
  }
  factory MarketplaceInsuranceProduct.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MarketplaceInsuranceProduct.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MarketplaceInsuranceProduct clone() => MarketplaceInsuranceProduct()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MarketplaceInsuranceProduct copyWith(void Function(MarketplaceInsuranceProduct) updates) => super.copyWith((message) => updates(message as MarketplaceInsuranceProduct)) as MarketplaceInsuranceProduct; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MarketplaceInsuranceProduct create() => MarketplaceInsuranceProduct._();
  MarketplaceInsuranceProduct createEmptyInstance() => create();
  static $pb.PbList<MarketplaceInsuranceProduct> createRepeated() => $pb.PbList<MarketplaceInsuranceProduct>();
  @$core.pragma('dart2js:noInline')
  static MarketplaceInsuranceProduct getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MarketplaceInsuranceProduct>(create);
  static MarketplaceInsuranceProduct? _defaultInstance;

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
  $core.String get category => $_getSZ(3);
  @$pb.TagNumber(4)
  set category($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCategory() => $_has(3);
  @$pb.TagNumber(4)
  void clearCategory() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get providerName => $_getSZ(4);
  @$pb.TagNumber(5)
  set providerName($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasProviderName() => $_has(4);
  @$pb.TagNumber(5)
  void clearProviderName() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get providerLogo => $_getSZ(5);
  @$pb.TagNumber(6)
  set providerLogo($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasProviderLogo() => $_has(5);
  @$pb.TagNumber(6)
  void clearProviderLogo() => clearField(6);

  @$pb.TagNumber(7)
  $core.double get minPremium => $_getN(6);
  @$pb.TagNumber(7)
  set minPremium($core.double v) { $_setDouble(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasMinPremium() => $_has(6);
  @$pb.TagNumber(7)
  void clearMinPremium() => clearField(7);

  @$pb.TagNumber(8)
  $core.double get maxPremium => $_getN(7);
  @$pb.TagNumber(8)
  set maxPremium($core.double v) { $_setDouble(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasMaxPremium() => $_has(7);
  @$pb.TagNumber(8)
  void clearMaxPremium() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get currency => $_getSZ(8);
  @$pb.TagNumber(9)
  set currency($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasCurrency() => $_has(8);
  @$pb.TagNumber(9)
  void clearCurrency() => clearField(9);

  @$pb.TagNumber(10)
  $core.List<$core.String> get benefits => $_getList(9);

  @$pb.TagNumber(11)
  $core.String get termsUrl => $_getSZ(10);
  @$pb.TagNumber(11)
  set termsUrl($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasTermsUrl() => $_has(10);
  @$pb.TagNumber(11)
  void clearTermsUrl() => clearField(11);

  @$pb.TagNumber(12)
  $core.Map<$core.String, $core.String> get metadata => $_getMap(11);

  @$pb.TagNumber(13)
  $core.List<MarketplaceProductFormField> get formFields => $_getList(12);

  @$pb.TagNumber(14)
  $core.bool get isActive => $_getBF(13);
  @$pb.TagNumber(14)
  set isActive($core.bool v) { $_setBool(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasIsActive() => $_has(13);
  @$pb.TagNumber(14)
  void clearIsActive() => clearField(14);

  @$pb.TagNumber(15)
  $core.String get purchaseRoute => $_getSZ(14);
  @$pb.TagNumber(15)
  set purchaseRoute($core.String v) { $_setString(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasPurchaseRoute() => $_has(14);
  @$pb.TagNumber(15)
  void clearPurchaseRoute() => clearField(15);

  @$pb.TagNumber(16)
  $core.String get providerId => $_getSZ(15);
  @$pb.TagNumber(16)
  set providerId($core.String v) { $_setString(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasProviderId() => $_has(15);
  @$pb.TagNumber(16)
  void clearProviderId() => clearField(16);

  @$pb.TagNumber(17)
  $core.double get basePrice => $_getN(16);
  @$pb.TagNumber(17)
  set basePrice($core.double v) { $_setDouble(16, v); }
  @$pb.TagNumber(17)
  $core.bool hasBasePrice() => $_has(16);
  @$pb.TagNumber(17)
  void clearBasePrice() => clearField(17);

  @$pb.TagNumber(18)
  $core.String get howItWorks => $_getSZ(17);
  @$pb.TagNumber(18)
  set howItWorks($core.String v) { $_setString(17, v); }
  @$pb.TagNumber(18)
  $core.bool hasHowItWorks() => $_has(17);
  @$pb.TagNumber(18)
  void clearHowItWorks() => clearField(18);

  @$pb.TagNumber(19)
  $core.String get fullBenefits => $_getSZ(18);
  @$pb.TagNumber(19)
  set fullBenefits($core.String v) { $_setString(18, v); }
  @$pb.TagNumber(19)
  $core.bool hasFullBenefits() => $_has(18);
  @$pb.TagNumber(19)
  void clearFullBenefits() => clearField(19);

  @$pb.TagNumber(20)
  $core.bool get isRenewable => $_getBF(19);
  @$pb.TagNumber(20)
  set isRenewable($core.bool v) { $_setBool(19, v); }
  @$pb.TagNumber(20)
  $core.bool hasIsRenewable() => $_has(19);
  @$pb.TagNumber(20)
  void clearIsRenewable() => clearField(20);

  @$pb.TagNumber(21)
  $core.bool get isClaimable => $_getBF(20);
  @$pb.TagNumber(21)
  set isClaimable($core.bool v) { $_setBool(20, v); }
  @$pb.TagNumber(21)
  $core.bool hasIsClaimable() => $_has(20);
  @$pb.TagNumber(21)
  void clearIsClaimable() => clearField(21);
}

class MarketplaceInsuranceCategory extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MarketplaceInsuranceCategory', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'icon')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..a<$core.int>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'productCount', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  MarketplaceInsuranceCategory._() : super();
  factory MarketplaceInsuranceCategory({
    $core.String? id,
    $core.String? name,
    $core.String? icon,
    $core.String? description,
    $core.int? productCount,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (name != null) {
      _result.name = name;
    }
    if (icon != null) {
      _result.icon = icon;
    }
    if (description != null) {
      _result.description = description;
    }
    if (productCount != null) {
      _result.productCount = productCount;
    }
    return _result;
  }
  factory MarketplaceInsuranceCategory.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MarketplaceInsuranceCategory.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MarketplaceInsuranceCategory clone() => MarketplaceInsuranceCategory()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MarketplaceInsuranceCategory copyWith(void Function(MarketplaceInsuranceCategory) updates) => super.copyWith((message) => updates(message as MarketplaceInsuranceCategory)) as MarketplaceInsuranceCategory; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MarketplaceInsuranceCategory create() => MarketplaceInsuranceCategory._();
  MarketplaceInsuranceCategory createEmptyInstance() => create();
  static $pb.PbList<MarketplaceInsuranceCategory> createRepeated() => $pb.PbList<MarketplaceInsuranceCategory>();
  @$core.pragma('dart2js:noInline')
  static MarketplaceInsuranceCategory getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MarketplaceInsuranceCategory>(create);
  static MarketplaceInsuranceCategory? _defaultInstance;

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
  $core.String get icon => $_getSZ(2);
  @$pb.TagNumber(3)
  set icon($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasIcon() => $_has(2);
  @$pb.TagNumber(3)
  void clearIcon() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get description => $_getSZ(3);
  @$pb.TagNumber(4)
  set description($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasDescription() => $_has(3);
  @$pb.TagNumber(4)
  void clearDescription() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get productCount => $_getIZ(4);
  @$pb.TagNumber(5)
  set productCount($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasProductCount() => $_has(4);
  @$pb.TagNumber(5)
  void clearProductCount() => clearField(5);
}

class MarketplaceInsuranceQuote extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MarketplaceInsuranceQuote', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'quoteId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'productId')
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'premium', $pb.PbFieldType.OD)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'coverageSummary')
    ..pPS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'coverageItems')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'validUntil')
    ..m<$core.String, $core.String>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'quoteDetails', entryClassName: 'MarketplaceInsuranceQuote.QuoteDetailsEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('financialproducts'))
    ..hasRequiredFields = false
  ;

  MarketplaceInsuranceQuote._() : super();
  factory MarketplaceInsuranceQuote({
    $core.String? quoteId,
    $core.String? productId,
    $core.double? premium,
    $core.String? currency,
    $core.String? coverageSummary,
    $core.Iterable<$core.String>? coverageItems,
    $core.String? validUntil,
    $core.Map<$core.String, $core.String>? quoteDetails,
  }) {
    final _result = create();
    if (quoteId != null) {
      _result.quoteId = quoteId;
    }
    if (productId != null) {
      _result.productId = productId;
    }
    if (premium != null) {
      _result.premium = premium;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (coverageSummary != null) {
      _result.coverageSummary = coverageSummary;
    }
    if (coverageItems != null) {
      _result.coverageItems.addAll(coverageItems);
    }
    if (validUntil != null) {
      _result.validUntil = validUntil;
    }
    if (quoteDetails != null) {
      _result.quoteDetails.addAll(quoteDetails);
    }
    return _result;
  }
  factory MarketplaceInsuranceQuote.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MarketplaceInsuranceQuote.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MarketplaceInsuranceQuote clone() => MarketplaceInsuranceQuote()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MarketplaceInsuranceQuote copyWith(void Function(MarketplaceInsuranceQuote) updates) => super.copyWith((message) => updates(message as MarketplaceInsuranceQuote)) as MarketplaceInsuranceQuote; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MarketplaceInsuranceQuote create() => MarketplaceInsuranceQuote._();
  MarketplaceInsuranceQuote createEmptyInstance() => create();
  static $pb.PbList<MarketplaceInsuranceQuote> createRepeated() => $pb.PbList<MarketplaceInsuranceQuote>();
  @$core.pragma('dart2js:noInline')
  static MarketplaceInsuranceQuote getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MarketplaceInsuranceQuote>(create);
  static MarketplaceInsuranceQuote? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get quoteId => $_getSZ(0);
  @$pb.TagNumber(1)
  set quoteId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasQuoteId() => $_has(0);
  @$pb.TagNumber(1)
  void clearQuoteId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get productId => $_getSZ(1);
  @$pb.TagNumber(2)
  set productId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasProductId() => $_has(1);
  @$pb.TagNumber(2)
  void clearProductId() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get premium => $_getN(2);
  @$pb.TagNumber(3)
  set premium($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPremium() => $_has(2);
  @$pb.TagNumber(3)
  void clearPremium() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get currency => $_getSZ(3);
  @$pb.TagNumber(4)
  set currency($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCurrency() => $_has(3);
  @$pb.TagNumber(4)
  void clearCurrency() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get coverageSummary => $_getSZ(4);
  @$pb.TagNumber(5)
  set coverageSummary($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasCoverageSummary() => $_has(4);
  @$pb.TagNumber(5)
  void clearCoverageSummary() => clearField(5);

  @$pb.TagNumber(6)
  $core.List<$core.String> get coverageItems => $_getList(5);

  @$pb.TagNumber(7)
  $core.String get validUntil => $_getSZ(6);
  @$pb.TagNumber(7)
  set validUntil($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasValidUntil() => $_has(6);
  @$pb.TagNumber(7)
  void clearValidUntil() => clearField(7);

  @$pb.TagNumber(8)
  $core.Map<$core.String, $core.String> get quoteDetails => $_getMap(7);
}

class MarketplaceInsurancePurchaseResult extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MarketplaceInsurancePurchaseResult', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'policyId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'policyNumber')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reference')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerReference')
    ..aOM<Insurance>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'insurance', subBuilder: Insurance.create)
    ..hasRequiredFields = false
  ;

  MarketplaceInsurancePurchaseResult._() : super();
  factory MarketplaceInsurancePurchaseResult({
    $core.String? policyId,
    $core.String? policyNumber,
    $core.String? reference,
    $core.String? status,
    $core.String? providerReference,
    Insurance? insurance,
  }) {
    final _result = create();
    if (policyId != null) {
      _result.policyId = policyId;
    }
    if (policyNumber != null) {
      _result.policyNumber = policyNumber;
    }
    if (reference != null) {
      _result.reference = reference;
    }
    if (status != null) {
      _result.status = status;
    }
    if (providerReference != null) {
      _result.providerReference = providerReference;
    }
    if (insurance != null) {
      _result.insurance = insurance;
    }
    return _result;
  }
  factory MarketplaceInsurancePurchaseResult.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MarketplaceInsurancePurchaseResult.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MarketplaceInsurancePurchaseResult clone() => MarketplaceInsurancePurchaseResult()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MarketplaceInsurancePurchaseResult copyWith(void Function(MarketplaceInsurancePurchaseResult) updates) => super.copyWith((message) => updates(message as MarketplaceInsurancePurchaseResult)) as MarketplaceInsurancePurchaseResult; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MarketplaceInsurancePurchaseResult create() => MarketplaceInsurancePurchaseResult._();
  MarketplaceInsurancePurchaseResult createEmptyInstance() => create();
  static $pb.PbList<MarketplaceInsurancePurchaseResult> createRepeated() => $pb.PbList<MarketplaceInsurancePurchaseResult>();
  @$core.pragma('dart2js:noInline')
  static MarketplaceInsurancePurchaseResult getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MarketplaceInsurancePurchaseResult>(create);
  static MarketplaceInsurancePurchaseResult? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get policyId => $_getSZ(0);
  @$pb.TagNumber(1)
  set policyId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPolicyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPolicyId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get policyNumber => $_getSZ(1);
  @$pb.TagNumber(2)
  set policyNumber($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPolicyNumber() => $_has(1);
  @$pb.TagNumber(2)
  void clearPolicyNumber() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get reference => $_getSZ(2);
  @$pb.TagNumber(3)
  set reference($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasReference() => $_has(2);
  @$pb.TagNumber(3)
  void clearReference() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get status => $_getSZ(3);
  @$pb.TagNumber(4)
  set status($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasStatus() => $_has(3);
  @$pb.TagNumber(4)
  void clearStatus() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get providerReference => $_getSZ(4);
  @$pb.TagNumber(5)
  set providerReference($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasProviderReference() => $_has(4);
  @$pb.TagNumber(5)
  void clearProviderReference() => clearField(5);

  @$pb.TagNumber(6)
  Insurance get insurance => $_getN(5);
  @$pb.TagNumber(6)
  set insurance(Insurance v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasInsurance() => $_has(5);
  @$pb.TagNumber(6)
  void clearInsurance() => clearField(6);
  @$pb.TagNumber(6)
  Insurance ensureInsurance() => $_ensure(5);
}

class GetInsuranceMarketplaceProductsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInsuranceMarketplaceProductsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'category')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'locale')
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetInsuranceMarketplaceProductsRequest._() : super();
  factory GetInsuranceMarketplaceProductsRequest({
    $core.String? category,
    $core.String? locale,
    $core.int? page,
    $core.int? limit,
  }) {
    final _result = create();
    if (category != null) {
      _result.category = category;
    }
    if (locale != null) {
      _result.locale = locale;
    }
    if (page != null) {
      _result.page = page;
    }
    if (limit != null) {
      _result.limit = limit;
    }
    return _result;
  }
  factory GetInsuranceMarketplaceProductsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInsuranceMarketplaceProductsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInsuranceMarketplaceProductsRequest clone() => GetInsuranceMarketplaceProductsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInsuranceMarketplaceProductsRequest copyWith(void Function(GetInsuranceMarketplaceProductsRequest) updates) => super.copyWith((message) => updates(message as GetInsuranceMarketplaceProductsRequest)) as GetInsuranceMarketplaceProductsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetInsuranceMarketplaceProductsRequest create() => GetInsuranceMarketplaceProductsRequest._();
  GetInsuranceMarketplaceProductsRequest createEmptyInstance() => create();
  static $pb.PbList<GetInsuranceMarketplaceProductsRequest> createRepeated() => $pb.PbList<GetInsuranceMarketplaceProductsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInsuranceMarketplaceProductsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInsuranceMarketplaceProductsRequest>(create);
  static GetInsuranceMarketplaceProductsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get category => $_getSZ(0);
  @$pb.TagNumber(1)
  set category($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCategory() => $_has(0);
  @$pb.TagNumber(1)
  void clearCategory() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get locale => $_getSZ(1);
  @$pb.TagNumber(2)
  set locale($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLocale() => $_has(1);
  @$pb.TagNumber(2)
  void clearLocale() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get page => $_getIZ(2);
  @$pb.TagNumber(3)
  set page($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPage() => $_has(2);
  @$pb.TagNumber(3)
  void clearPage() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get limit => $_getIZ(3);
  @$pb.TagNumber(4)
  set limit($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasLimit() => $_has(3);
  @$pb.TagNumber(4)
  void clearLimit() => clearField(4);
}

class GetInsuranceMarketplaceProductsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInsuranceMarketplaceProductsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..pc<MarketplaceInsuranceProduct>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'products', $pb.PbFieldType.PM, subBuilder: MarketplaceInsuranceProduct.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetInsuranceMarketplaceProductsResponse._() : super();
  factory GetInsuranceMarketplaceProductsResponse({
    $core.Iterable<MarketplaceInsuranceProduct>? products,
    $core.int? total,
  }) {
    final _result = create();
    if (products != null) {
      _result.products.addAll(products);
    }
    if (total != null) {
      _result.total = total;
    }
    return _result;
  }
  factory GetInsuranceMarketplaceProductsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInsuranceMarketplaceProductsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInsuranceMarketplaceProductsResponse clone() => GetInsuranceMarketplaceProductsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInsuranceMarketplaceProductsResponse copyWith(void Function(GetInsuranceMarketplaceProductsResponse) updates) => super.copyWith((message) => updates(message as GetInsuranceMarketplaceProductsResponse)) as GetInsuranceMarketplaceProductsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetInsuranceMarketplaceProductsResponse create() => GetInsuranceMarketplaceProductsResponse._();
  GetInsuranceMarketplaceProductsResponse createEmptyInstance() => create();
  static $pb.PbList<GetInsuranceMarketplaceProductsResponse> createRepeated() => $pb.PbList<GetInsuranceMarketplaceProductsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInsuranceMarketplaceProductsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInsuranceMarketplaceProductsResponse>(create);
  static GetInsuranceMarketplaceProductsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<MarketplaceInsuranceProduct> get products => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => clearField(2);
}

class GetInsuranceMarketplaceCategoriesRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInsuranceMarketplaceCategoriesRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'locale')
    ..hasRequiredFields = false
  ;

  GetInsuranceMarketplaceCategoriesRequest._() : super();
  factory GetInsuranceMarketplaceCategoriesRequest({
    $core.String? locale,
  }) {
    final _result = create();
    if (locale != null) {
      _result.locale = locale;
    }
    return _result;
  }
  factory GetInsuranceMarketplaceCategoriesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInsuranceMarketplaceCategoriesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInsuranceMarketplaceCategoriesRequest clone() => GetInsuranceMarketplaceCategoriesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInsuranceMarketplaceCategoriesRequest copyWith(void Function(GetInsuranceMarketplaceCategoriesRequest) updates) => super.copyWith((message) => updates(message as GetInsuranceMarketplaceCategoriesRequest)) as GetInsuranceMarketplaceCategoriesRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetInsuranceMarketplaceCategoriesRequest create() => GetInsuranceMarketplaceCategoriesRequest._();
  GetInsuranceMarketplaceCategoriesRequest createEmptyInstance() => create();
  static $pb.PbList<GetInsuranceMarketplaceCategoriesRequest> createRepeated() => $pb.PbList<GetInsuranceMarketplaceCategoriesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInsuranceMarketplaceCategoriesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInsuranceMarketplaceCategoriesRequest>(create);
  static GetInsuranceMarketplaceCategoriesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get locale => $_getSZ(0);
  @$pb.TagNumber(1)
  set locale($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLocale() => $_has(0);
  @$pb.TagNumber(1)
  void clearLocale() => clearField(1);
}

class GetInsuranceMarketplaceCategoriesResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInsuranceMarketplaceCategoriesResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..pc<MarketplaceInsuranceCategory>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'categories', $pb.PbFieldType.PM, subBuilder: MarketplaceInsuranceCategory.create)
    ..hasRequiredFields = false
  ;

  GetInsuranceMarketplaceCategoriesResponse._() : super();
  factory GetInsuranceMarketplaceCategoriesResponse({
    $core.Iterable<MarketplaceInsuranceCategory>? categories,
  }) {
    final _result = create();
    if (categories != null) {
      _result.categories.addAll(categories);
    }
    return _result;
  }
  factory GetInsuranceMarketplaceCategoriesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInsuranceMarketplaceCategoriesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInsuranceMarketplaceCategoriesResponse clone() => GetInsuranceMarketplaceCategoriesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInsuranceMarketplaceCategoriesResponse copyWith(void Function(GetInsuranceMarketplaceCategoriesResponse) updates) => super.copyWith((message) => updates(message as GetInsuranceMarketplaceCategoriesResponse)) as GetInsuranceMarketplaceCategoriesResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetInsuranceMarketplaceCategoriesResponse create() => GetInsuranceMarketplaceCategoriesResponse._();
  GetInsuranceMarketplaceCategoriesResponse createEmptyInstance() => create();
  static $pb.PbList<GetInsuranceMarketplaceCategoriesResponse> createRepeated() => $pb.PbList<GetInsuranceMarketplaceCategoriesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInsuranceMarketplaceCategoriesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInsuranceMarketplaceCategoriesResponse>(create);
  static GetInsuranceMarketplaceCategoriesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<MarketplaceInsuranceCategory> get categories => $_getList(0);
}

class GetInsuranceQuoteRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInsuranceQuoteRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'productId')
    ..m<$core.String, $core.String>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'formData', entryClassName: 'GetInsuranceQuoteRequest.FormDataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('financialproducts'))
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'locale')
    ..hasRequiredFields = false
  ;

  GetInsuranceQuoteRequest._() : super();
  factory GetInsuranceQuoteRequest({
    $core.String? productId,
    $core.Map<$core.String, $core.String>? formData,
    $core.String? locale,
  }) {
    final _result = create();
    if (productId != null) {
      _result.productId = productId;
    }
    if (formData != null) {
      _result.formData.addAll(formData);
    }
    if (locale != null) {
      _result.locale = locale;
    }
    return _result;
  }
  factory GetInsuranceQuoteRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInsuranceQuoteRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInsuranceQuoteRequest clone() => GetInsuranceQuoteRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInsuranceQuoteRequest copyWith(void Function(GetInsuranceQuoteRequest) updates) => super.copyWith((message) => updates(message as GetInsuranceQuoteRequest)) as GetInsuranceQuoteRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetInsuranceQuoteRequest create() => GetInsuranceQuoteRequest._();
  GetInsuranceQuoteRequest createEmptyInstance() => create();
  static $pb.PbList<GetInsuranceQuoteRequest> createRepeated() => $pb.PbList<GetInsuranceQuoteRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInsuranceQuoteRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInsuranceQuoteRequest>(create);
  static GetInsuranceQuoteRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get productId => $_getSZ(0);
  @$pb.TagNumber(1)
  set productId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasProductId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProductId() => clearField(1);

  @$pb.TagNumber(2)
  $core.Map<$core.String, $core.String> get formData => $_getMap(1);

  @$pb.TagNumber(3)
  $core.String get locale => $_getSZ(2);
  @$pb.TagNumber(3)
  set locale($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasLocale() => $_has(2);
  @$pb.TagNumber(3)
  void clearLocale() => clearField(3);
}

class GetInsuranceQuoteResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInsuranceQuoteResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOM<MarketplaceInsuranceQuote>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'quote', subBuilder: MarketplaceInsuranceQuote.create)
    ..hasRequiredFields = false
  ;

  GetInsuranceQuoteResponse._() : super();
  factory GetInsuranceQuoteResponse({
    MarketplaceInsuranceQuote? quote,
  }) {
    final _result = create();
    if (quote != null) {
      _result.quote = quote;
    }
    return _result;
  }
  factory GetInsuranceQuoteResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInsuranceQuoteResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInsuranceQuoteResponse clone() => GetInsuranceQuoteResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInsuranceQuoteResponse copyWith(void Function(GetInsuranceQuoteResponse) updates) => super.copyWith((message) => updates(message as GetInsuranceQuoteResponse)) as GetInsuranceQuoteResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetInsuranceQuoteResponse create() => GetInsuranceQuoteResponse._();
  GetInsuranceQuoteResponse createEmptyInstance() => create();
  static $pb.PbList<GetInsuranceQuoteResponse> createRepeated() => $pb.PbList<GetInsuranceQuoteResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInsuranceQuoteResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInsuranceQuoteResponse>(create);
  static GetInsuranceQuoteResponse? _defaultInstance;

  @$pb.TagNumber(1)
  MarketplaceInsuranceQuote get quote => $_getN(0);
  @$pb.TagNumber(1)
  set quote(MarketplaceInsuranceQuote v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasQuote() => $_has(0);
  @$pb.TagNumber(1)
  void clearQuote() => clearField(1);
  @$pb.TagNumber(1)
  MarketplaceInsuranceQuote ensureQuote() => $_ensure(0);
}

class PurchaseMarketplaceInsuranceRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PurchaseMarketplaceInsuranceRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'quoteId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'productId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountId')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionPinToken')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'idempotencyKey')
    ..m<$core.String, $core.String>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'formData', entryClassName: 'PurchaseMarketplaceInsuranceRequest.FormDataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('financialproducts'))
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'locale')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pinTransactionId')
    ..hasRequiredFields = false
  ;

  PurchaseMarketplaceInsuranceRequest._() : super();
  factory PurchaseMarketplaceInsuranceRequest({
    $core.String? quoteId,
    $core.String? productId,
    $core.String? accountId,
    $core.String? transactionPinToken,
    $core.String? idempotencyKey,
    $core.Map<$core.String, $core.String>? formData,
    $core.String? locale,
    $core.String? pinTransactionId,
  }) {
    final _result = create();
    if (quoteId != null) {
      _result.quoteId = quoteId;
    }
    if (productId != null) {
      _result.productId = productId;
    }
    if (accountId != null) {
      _result.accountId = accountId;
    }
    if (transactionPinToken != null) {
      _result.transactionPinToken = transactionPinToken;
    }
    if (idempotencyKey != null) {
      _result.idempotencyKey = idempotencyKey;
    }
    if (formData != null) {
      _result.formData.addAll(formData);
    }
    if (locale != null) {
      _result.locale = locale;
    }
    if (pinTransactionId != null) {
      _result.pinTransactionId = pinTransactionId;
    }
    return _result;
  }
  factory PurchaseMarketplaceInsuranceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PurchaseMarketplaceInsuranceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PurchaseMarketplaceInsuranceRequest clone() => PurchaseMarketplaceInsuranceRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PurchaseMarketplaceInsuranceRequest copyWith(void Function(PurchaseMarketplaceInsuranceRequest) updates) => super.copyWith((message) => updates(message as PurchaseMarketplaceInsuranceRequest)) as PurchaseMarketplaceInsuranceRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PurchaseMarketplaceInsuranceRequest create() => PurchaseMarketplaceInsuranceRequest._();
  PurchaseMarketplaceInsuranceRequest createEmptyInstance() => create();
  static $pb.PbList<PurchaseMarketplaceInsuranceRequest> createRepeated() => $pb.PbList<PurchaseMarketplaceInsuranceRequest>();
  @$core.pragma('dart2js:noInline')
  static PurchaseMarketplaceInsuranceRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PurchaseMarketplaceInsuranceRequest>(create);
  static PurchaseMarketplaceInsuranceRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get quoteId => $_getSZ(0);
  @$pb.TagNumber(1)
  set quoteId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasQuoteId() => $_has(0);
  @$pb.TagNumber(1)
  void clearQuoteId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get productId => $_getSZ(1);
  @$pb.TagNumber(2)
  set productId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasProductId() => $_has(1);
  @$pb.TagNumber(2)
  void clearProductId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get accountId => $_getSZ(2);
  @$pb.TagNumber(3)
  set accountId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAccountId() => $_has(2);
  @$pb.TagNumber(3)
  void clearAccountId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get transactionPinToken => $_getSZ(3);
  @$pb.TagNumber(4)
  set transactionPinToken($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTransactionPinToken() => $_has(3);
  @$pb.TagNumber(4)
  void clearTransactionPinToken() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get idempotencyKey => $_getSZ(4);
  @$pb.TagNumber(5)
  set idempotencyKey($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasIdempotencyKey() => $_has(4);
  @$pb.TagNumber(5)
  void clearIdempotencyKey() => clearField(5);

  @$pb.TagNumber(6)
  $core.Map<$core.String, $core.String> get formData => $_getMap(5);

  @$pb.TagNumber(7)
  $core.String get locale => $_getSZ(6);
  @$pb.TagNumber(7)
  set locale($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasLocale() => $_has(6);
  @$pb.TagNumber(7)
  void clearLocale() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get pinTransactionId => $_getSZ(7);
  @$pb.TagNumber(8)
  set pinTransactionId($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasPinTransactionId() => $_has(7);
  @$pb.TagNumber(8)
  void clearPinTransactionId() => clearField(8);
}

class PurchaseMarketplaceInsuranceResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PurchaseMarketplaceInsuranceResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOM<MarketplaceInsurancePurchaseResult>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'result', subBuilder: MarketplaceInsurancePurchaseResult.create)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  PurchaseMarketplaceInsuranceResponse._() : super();
  factory PurchaseMarketplaceInsuranceResponse({
    MarketplaceInsurancePurchaseResult? result,
    $core.String? message,
  }) {
    final _result = create();
    if (result != null) {
      _result.result = result;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory PurchaseMarketplaceInsuranceResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PurchaseMarketplaceInsuranceResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PurchaseMarketplaceInsuranceResponse clone() => PurchaseMarketplaceInsuranceResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PurchaseMarketplaceInsuranceResponse copyWith(void Function(PurchaseMarketplaceInsuranceResponse) updates) => super.copyWith((message) => updates(message as PurchaseMarketplaceInsuranceResponse)) as PurchaseMarketplaceInsuranceResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PurchaseMarketplaceInsuranceResponse create() => PurchaseMarketplaceInsuranceResponse._();
  PurchaseMarketplaceInsuranceResponse createEmptyInstance() => create();
  static $pb.PbList<PurchaseMarketplaceInsuranceResponse> createRepeated() => $pb.PbList<PurchaseMarketplaceInsuranceResponse>();
  @$core.pragma('dart2js:noInline')
  static PurchaseMarketplaceInsuranceResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PurchaseMarketplaceInsuranceResponse>(create);
  static PurchaseMarketplaceInsuranceResponse? _defaultInstance;

  @$pb.TagNumber(1)
  MarketplaceInsurancePurchaseResult get result => $_getN(0);
  @$pb.TagNumber(1)
  set result(MarketplaceInsurancePurchaseResult v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasResult() => $_has(0);
  @$pb.TagNumber(1)
  void clearResult() => clearField(1);
  @$pb.TagNumber(1)
  MarketplaceInsurancePurchaseResult ensureResult() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

class GetInsurancePurchaseStatusRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInsurancePurchaseStatusRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reference')
    ..hasRequiredFields = false
  ;

  GetInsurancePurchaseStatusRequest._() : super();
  factory GetInsurancePurchaseStatusRequest({
    $core.String? reference,
  }) {
    final _result = create();
    if (reference != null) {
      _result.reference = reference;
    }
    return _result;
  }
  factory GetInsurancePurchaseStatusRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInsurancePurchaseStatusRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInsurancePurchaseStatusRequest clone() => GetInsurancePurchaseStatusRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInsurancePurchaseStatusRequest copyWith(void Function(GetInsurancePurchaseStatusRequest) updates) => super.copyWith((message) => updates(message as GetInsurancePurchaseStatusRequest)) as GetInsurancePurchaseStatusRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetInsurancePurchaseStatusRequest create() => GetInsurancePurchaseStatusRequest._();
  GetInsurancePurchaseStatusRequest createEmptyInstance() => create();
  static $pb.PbList<GetInsurancePurchaseStatusRequest> createRepeated() => $pb.PbList<GetInsurancePurchaseStatusRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInsurancePurchaseStatusRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInsurancePurchaseStatusRequest>(create);
  static GetInsurancePurchaseStatusRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get reference => $_getSZ(0);
  @$pb.TagNumber(1)
  set reference($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasReference() => $_has(0);
  @$pb.TagNumber(1)
  void clearReference() => clearField(1);
}

class GetInsurancePurchaseStatusResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInsurancePurchaseStatusResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOM<MarketplaceInsurancePurchaseResult>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'result', subBuilder: MarketplaceInsurancePurchaseResult.create)
    ..hasRequiredFields = false
  ;

  GetInsurancePurchaseStatusResponse._() : super();
  factory GetInsurancePurchaseStatusResponse({
    MarketplaceInsurancePurchaseResult? result,
  }) {
    final _result = create();
    if (result != null) {
      _result.result = result;
    }
    return _result;
  }
  factory GetInsurancePurchaseStatusResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInsurancePurchaseStatusResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInsurancePurchaseStatusResponse clone() => GetInsurancePurchaseStatusResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInsurancePurchaseStatusResponse copyWith(void Function(GetInsurancePurchaseStatusResponse) updates) => super.copyWith((message) => updates(message as GetInsurancePurchaseStatusResponse)) as GetInsurancePurchaseStatusResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetInsurancePurchaseStatusResponse create() => GetInsurancePurchaseStatusResponse._();
  GetInsurancePurchaseStatusResponse createEmptyInstance() => create();
  static $pb.PbList<GetInsurancePurchaseStatusResponse> createRepeated() => $pb.PbList<GetInsurancePurchaseStatusResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInsurancePurchaseStatusResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInsurancePurchaseStatusResponse>(create);
  static GetInsurancePurchaseStatusResponse? _defaultInstance;

  @$pb.TagNumber(1)
  MarketplaceInsurancePurchaseResult get result => $_getN(0);
  @$pb.TagNumber(1)
  set result(MarketplaceInsurancePurchaseResult v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasResult() => $_has(0);
  @$pb.TagNumber(1)
  void clearResult() => clearField(1);
  @$pb.TagNumber(1)
  MarketplaceInsurancePurchaseResult ensureResult() => $_ensure(0);
}

class UploadInsuranceDocumentRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UploadInsuranceDocumentRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fileData', $pb.PbFieldType.OY)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'filename')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'documentType')
    ..hasRequiredFields = false
  ;

  UploadInsuranceDocumentRequest._() : super();
  factory UploadInsuranceDocumentRequest({
    $core.List<$core.int>? fileData,
    $core.String? filename,
    $core.String? documentType,
  }) {
    final _result = create();
    if (fileData != null) {
      _result.fileData = fileData;
    }
    if (filename != null) {
      _result.filename = filename;
    }
    if (documentType != null) {
      _result.documentType = documentType;
    }
    return _result;
  }
  factory UploadInsuranceDocumentRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UploadInsuranceDocumentRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UploadInsuranceDocumentRequest clone() => UploadInsuranceDocumentRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UploadInsuranceDocumentRequest copyWith(void Function(UploadInsuranceDocumentRequest) updates) => super.copyWith((message) => updates(message as UploadInsuranceDocumentRequest)) as UploadInsuranceDocumentRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UploadInsuranceDocumentRequest create() => UploadInsuranceDocumentRequest._();
  UploadInsuranceDocumentRequest createEmptyInstance() => create();
  static $pb.PbList<UploadInsuranceDocumentRequest> createRepeated() => $pb.PbList<UploadInsuranceDocumentRequest>();
  @$core.pragma('dart2js:noInline')
  static UploadInsuranceDocumentRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UploadInsuranceDocumentRequest>(create);
  static UploadInsuranceDocumentRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get fileData => $_getN(0);
  @$pb.TagNumber(1)
  set fileData($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFileData() => $_has(0);
  @$pb.TagNumber(1)
  void clearFileData() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get filename => $_getSZ(1);
  @$pb.TagNumber(2)
  set filename($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasFilename() => $_has(1);
  @$pb.TagNumber(2)
  void clearFilename() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get documentType => $_getSZ(2);
  @$pb.TagNumber(3)
  set documentType($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDocumentType() => $_has(2);
  @$pb.TagNumber(3)
  void clearDocumentType() => clearField(3);
}

class UploadInsuranceDocumentResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UploadInsuranceDocumentResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'uploadId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fileUrl')
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'msg')
    ..hasRequiredFields = false
  ;

  UploadInsuranceDocumentResponse._() : super();
  factory UploadInsuranceDocumentResponse({
    $core.String? uploadId,
    $core.String? fileUrl,
    $core.bool? success,
    $core.String? msg,
  }) {
    final _result = create();
    if (uploadId != null) {
      _result.uploadId = uploadId;
    }
    if (fileUrl != null) {
      _result.fileUrl = fileUrl;
    }
    if (success != null) {
      _result.success = success;
    }
    if (msg != null) {
      _result.msg = msg;
    }
    return _result;
  }
  factory UploadInsuranceDocumentResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UploadInsuranceDocumentResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UploadInsuranceDocumentResponse clone() => UploadInsuranceDocumentResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UploadInsuranceDocumentResponse copyWith(void Function(UploadInsuranceDocumentResponse) updates) => super.copyWith((message) => updates(message as UploadInsuranceDocumentResponse)) as UploadInsuranceDocumentResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UploadInsuranceDocumentResponse create() => UploadInsuranceDocumentResponse._();
  UploadInsuranceDocumentResponse createEmptyInstance() => create();
  static $pb.PbList<UploadInsuranceDocumentResponse> createRepeated() => $pb.PbList<UploadInsuranceDocumentResponse>();
  @$core.pragma('dart2js:noInline')
  static UploadInsuranceDocumentResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UploadInsuranceDocumentResponse>(create);
  static UploadInsuranceDocumentResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get uploadId => $_getSZ(0);
  @$pb.TagNumber(1)
  set uploadId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUploadId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUploadId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get fileUrl => $_getSZ(1);
  @$pb.TagNumber(2)
  set fileUrl($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasFileUrl() => $_has(1);
  @$pb.TagNumber(2)
  void clearFileUrl() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get success => $_getBF(2);
  @$pb.TagNumber(3)
  set success($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSuccess() => $_has(2);
  @$pb.TagNumber(3)
  void clearSuccess() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get msg => $_getSZ(3);
  @$pb.TagNumber(4)
  set msg($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasMsg() => $_has(3);
  @$pb.TagNumber(4)
  void clearMsg() => clearField(4);
}

class GetInsuranceAuxiliaryDataRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInsuranceAuxiliaryDataRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'utilityId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'query')
    ..hasRequiredFields = false
  ;

  GetInsuranceAuxiliaryDataRequest._() : super();
  factory GetInsuranceAuxiliaryDataRequest({
    $core.String? utilityId,
    $core.String? query,
  }) {
    final _result = create();
    if (utilityId != null) {
      _result.utilityId = utilityId;
    }
    if (query != null) {
      _result.query = query;
    }
    return _result;
  }
  factory GetInsuranceAuxiliaryDataRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInsuranceAuxiliaryDataRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInsuranceAuxiliaryDataRequest clone() => GetInsuranceAuxiliaryDataRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInsuranceAuxiliaryDataRequest copyWith(void Function(GetInsuranceAuxiliaryDataRequest) updates) => super.copyWith((message) => updates(message as GetInsuranceAuxiliaryDataRequest)) as GetInsuranceAuxiliaryDataRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetInsuranceAuxiliaryDataRequest create() => GetInsuranceAuxiliaryDataRequest._();
  GetInsuranceAuxiliaryDataRequest createEmptyInstance() => create();
  static $pb.PbList<GetInsuranceAuxiliaryDataRequest> createRepeated() => $pb.PbList<GetInsuranceAuxiliaryDataRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInsuranceAuxiliaryDataRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInsuranceAuxiliaryDataRequest>(create);
  static GetInsuranceAuxiliaryDataRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get utilityId => $_getSZ(0);
  @$pb.TagNumber(1)
  set utilityId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUtilityId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUtilityId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get query => $_getSZ(1);
  @$pb.TagNumber(2)
  set query($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasQuery() => $_has(1);
  @$pb.TagNumber(2)
  void clearQuery() => clearField(2);
}

class GetInsuranceAuxiliaryDataResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInsuranceAuxiliaryDataResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..pc<InsuranceAuxiliaryItem>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'items', $pb.PbFieldType.PM, subBuilder: InsuranceAuxiliaryItem.create)
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'msg')
    ..hasRequiredFields = false
  ;

  GetInsuranceAuxiliaryDataResponse._() : super();
  factory GetInsuranceAuxiliaryDataResponse({
    $core.Iterable<InsuranceAuxiliaryItem>? items,
    $core.bool? success,
    $core.String? msg,
  }) {
    final _result = create();
    if (items != null) {
      _result.items.addAll(items);
    }
    if (success != null) {
      _result.success = success;
    }
    if (msg != null) {
      _result.msg = msg;
    }
    return _result;
  }
  factory GetInsuranceAuxiliaryDataResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInsuranceAuxiliaryDataResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInsuranceAuxiliaryDataResponse clone() => GetInsuranceAuxiliaryDataResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInsuranceAuxiliaryDataResponse copyWith(void Function(GetInsuranceAuxiliaryDataResponse) updates) => super.copyWith((message) => updates(message as GetInsuranceAuxiliaryDataResponse)) as GetInsuranceAuxiliaryDataResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetInsuranceAuxiliaryDataResponse create() => GetInsuranceAuxiliaryDataResponse._();
  GetInsuranceAuxiliaryDataResponse createEmptyInstance() => create();
  static $pb.PbList<GetInsuranceAuxiliaryDataResponse> createRepeated() => $pb.PbList<GetInsuranceAuxiliaryDataResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInsuranceAuxiliaryDataResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInsuranceAuxiliaryDataResponse>(create);
  static GetInsuranceAuxiliaryDataResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<InsuranceAuxiliaryItem> get items => $_getList(0);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get msg => $_getSZ(2);
  @$pb.TagNumber(3)
  set msg($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMsg() => $_has(2);
  @$pb.TagNumber(3)
  void clearMsg() => clearField(3);
}

class InsuranceAuxiliaryItem extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'InsuranceAuxiliaryItem', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'label')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'value')
    ..hasRequiredFields = false
  ;

  InsuranceAuxiliaryItem._() : super();
  factory InsuranceAuxiliaryItem({
    $core.String? label,
    $core.String? value,
  }) {
    final _result = create();
    if (label != null) {
      _result.label = label;
    }
    if (value != null) {
      _result.value = value;
    }
    return _result;
  }
  factory InsuranceAuxiliaryItem.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InsuranceAuxiliaryItem.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InsuranceAuxiliaryItem clone() => InsuranceAuxiliaryItem()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InsuranceAuxiliaryItem copyWith(void Function(InsuranceAuxiliaryItem) updates) => super.copyWith((message) => updates(message as InsuranceAuxiliaryItem)) as InsuranceAuxiliaryItem; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static InsuranceAuxiliaryItem create() => InsuranceAuxiliaryItem._();
  InsuranceAuxiliaryItem createEmptyInstance() => create();
  static $pb.PbList<InsuranceAuxiliaryItem> createRepeated() => $pb.PbList<InsuranceAuxiliaryItem>();
  @$core.pragma('dart2js:noInline')
  static InsuranceAuxiliaryItem getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InsuranceAuxiliaryItem>(create);
  static InsuranceAuxiliaryItem? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get label => $_getSZ(0);
  @$pb.TagNumber(1)
  set label($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLabel() => $_has(0);
  @$pb.TagNumber(1)
  void clearLabel() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get value => $_getSZ(1);
  @$pb.TagNumber(2)
  set value($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearValue() => clearField(2);
}

class CreateCrowdfundRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateCrowdfundRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'title')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'category')
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'targetAmount', $pb.PbFieldType.OD)
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'deadline')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'imageUrl')
    ..hasRequiredFields = false
  ;

  CreateCrowdfundRequest._() : super();
  factory CreateCrowdfundRequest({
    $core.String? accountId,
    $core.String? title,
    $core.String? description,
    $core.String? category,
    $core.double? targetAmount,
    $core.String? deadline,
    $core.String? imageUrl,
  }) {
    final _result = create();
    if (accountId != null) {
      _result.accountId = accountId;
    }
    if (title != null) {
      _result.title = title;
    }
    if (description != null) {
      _result.description = description;
    }
    if (category != null) {
      _result.category = category;
    }
    if (targetAmount != null) {
      _result.targetAmount = targetAmount;
    }
    if (deadline != null) {
      _result.deadline = deadline;
    }
    if (imageUrl != null) {
      _result.imageUrl = imageUrl;
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateCrowdfundResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOM<Crowdfund>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'crowdfund', subBuilder: Crowdfund.create)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  CreateCrowdfundResponse._() : super();
  factory CreateCrowdfundResponse({
    Crowdfund? crowdfund,
    $core.String? message,
  }) {
    final _result = create();
    if (crowdfund != null) {
      _result.crowdfund = crowdfund;
    }
    if (message != null) {
      _result.message = message;
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

class GetCrowdfundsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetCrowdfundsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'category')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetCrowdfundsRequest._() : super();
  factory GetCrowdfundsRequest({
    $core.String? category,
    $core.String? status,
    $core.int? limit,
    $core.int? offset,
  }) {
    final _result = create();
    if (category != null) {
      _result.category = category;
    }
    if (status != null) {
      _result.status = status;
    }
    if (limit != null) {
      _result.limit = limit;
    }
    if (offset != null) {
      _result.offset = offset;
    }
    return _result;
  }
  factory GetCrowdfundsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCrowdfundsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCrowdfundsRequest clone() => GetCrowdfundsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCrowdfundsRequest copyWith(void Function(GetCrowdfundsRequest) updates) => super.copyWith((message) => updates(message as GetCrowdfundsRequest)) as GetCrowdfundsRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetCrowdfundsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..pc<Crowdfund>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'crowdfunds', $pb.PbFieldType.PM, subBuilder: Crowdfund.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetCrowdfundsResponse._() : super();
  factory GetCrowdfundsResponse({
    $core.Iterable<Crowdfund>? crowdfunds,
    $core.int? total,
  }) {
    final _result = create();
    if (crowdfunds != null) {
      _result.crowdfunds.addAll(crowdfunds);
    }
    if (total != null) {
      _result.total = total;
    }
    return _result;
  }
  factory GetCrowdfundsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCrowdfundsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCrowdfundsResponse clone() => GetCrowdfundsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCrowdfundsResponse copyWith(void Function(GetCrowdfundsResponse) updates) => super.copyWith((message) => updates(message as GetCrowdfundsResponse)) as GetCrowdfundsResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetCrowdfundRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetCrowdfundResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOM<Crowdfund>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'crowdfund', subBuilder: Crowdfund.create)
    ..pc<CrowdfundContribution>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recentContributions', $pb.PbFieldType.PM, subBuilder: CrowdfundContribution.create)
    ..hasRequiredFields = false
  ;

  GetCrowdfundResponse._() : super();
  factory GetCrowdfundResponse({
    Crowdfund? crowdfund,
    $core.Iterable<CrowdfundContribution>? recentContributions,
  }) {
    final _result = create();
    if (crowdfund != null) {
      _result.crowdfund = crowdfund;
    }
    if (recentContributions != null) {
      _result.recentContributions.addAll(recentContributions);
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

class ContributeToCrowdfundRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ContributeToCrowdfundRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'crowdfundId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountId')
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOB(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isAnonymous')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pin')
    ..hasRequiredFields = false
  ;

  ContributeToCrowdfundRequest._() : super();
  factory ContributeToCrowdfundRequest({
    $core.String? crowdfundId,
    $core.String? accountId,
    $core.double? amount,
    $core.String? message,
    $core.bool? isAnonymous,
    $core.String? pin,
  }) {
    final _result = create();
    if (crowdfundId != null) {
      _result.crowdfundId = crowdfundId;
    }
    if (accountId != null) {
      _result.accountId = accountId;
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
    if (pin != null) {
      _result.pin = pin;
    }
    return _result;
  }
  factory ContributeToCrowdfundRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ContributeToCrowdfundRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ContributeToCrowdfundRequest clone() => ContributeToCrowdfundRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ContributeToCrowdfundRequest copyWith(void Function(ContributeToCrowdfundRequest) updates) => super.copyWith((message) => updates(message as ContributeToCrowdfundRequest)) as ContributeToCrowdfundRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ContributeToCrowdfundResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOM<Crowdfund>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'crowdfund', subBuilder: Crowdfund.create)
    ..aOM<CrowdfundContribution>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'contribution', subBuilder: CrowdfundContribution.create)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'newBalance', $pb.PbFieldType.OD)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  ContributeToCrowdfundResponse._() : super();
  factory ContributeToCrowdfundResponse({
    Crowdfund? crowdfund,
    CrowdfundContribution? contribution,
    $core.double? newBalance,
    $core.String? message,
  }) {
    final _result = create();
    if (crowdfund != null) {
      _result.crowdfund = crowdfund;
    }
    if (contribution != null) {
      _result.contribution = contribution;
    }
    if (newBalance != null) {
      _result.newBalance = newBalance;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory ContributeToCrowdfundResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ContributeToCrowdfundResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ContributeToCrowdfundResponse clone() => ContributeToCrowdfundResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ContributeToCrowdfundResponse copyWith(void Function(ContributeToCrowdfundResponse) updates) => super.copyWith((message) => updates(message as ContributeToCrowdfundResponse)) as ContributeToCrowdfundResponse; // ignore: deprecated_member_use
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

class WithdrawFromCrowdfundRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'WithdrawFromCrowdfundRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'crowdfundId')
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pin')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'destinationAccountId')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'destinationAccountType')
    ..hasRequiredFields = false
  ;

  WithdrawFromCrowdfundRequest._() : super();
  factory WithdrawFromCrowdfundRequest({
    $core.String? crowdfundId,
    $core.double? amount,
    $core.String? pin,
    $core.String? destinationAccountId,
    $core.String? destinationAccountType,
  }) {
    final _result = create();
    if (crowdfundId != null) {
      _result.crowdfundId = crowdfundId;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (pin != null) {
      _result.pin = pin;
    }
    if (destinationAccountId != null) {
      _result.destinationAccountId = destinationAccountId;
    }
    if (destinationAccountType != null) {
      _result.destinationAccountType = destinationAccountType;
    }
    return _result;
  }
  factory WithdrawFromCrowdfundRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WithdrawFromCrowdfundRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  WithdrawFromCrowdfundRequest clone() => WithdrawFromCrowdfundRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  WithdrawFromCrowdfundRequest copyWith(void Function(WithdrawFromCrowdfundRequest) updates) => super.copyWith((message) => updates(message as WithdrawFromCrowdfundRequest)) as WithdrawFromCrowdfundRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'WithdrawFromCrowdfundResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOM<Crowdfund>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'crowdfund', subBuilder: Crowdfund.create)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amountWithdrawn', $pb.PbFieldType.OD)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'destinationAccountId')
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'destinationNewBalance', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  WithdrawFromCrowdfundResponse._() : super();
  factory WithdrawFromCrowdfundResponse({
    Crowdfund? crowdfund,
    $core.double? amountWithdrawn,
    $core.String? message,
    $core.String? destinationAccountId,
    $core.double? destinationNewBalance,
  }) {
    final _result = create();
    if (crowdfund != null) {
      _result.crowdfund = crowdfund;
    }
    if (amountWithdrawn != null) {
      _result.amountWithdrawn = amountWithdrawn;
    }
    if (message != null) {
      _result.message = message;
    }
    if (destinationAccountId != null) {
      _result.destinationAccountId = destinationAccountId;
    }
    if (destinationNewBalance != null) {
      _result.destinationNewBalance = destinationNewBalance;
    }
    return _result;
  }
  factory WithdrawFromCrowdfundResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WithdrawFromCrowdfundResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  WithdrawFromCrowdfundResponse clone() => WithdrawFromCrowdfundResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  WithdrawFromCrowdfundResponse copyWith(void Function(WithdrawFromCrowdfundResponse) updates) => super.copyWith((message) => updates(message as WithdrawFromCrowdfundResponse)) as WithdrawFromCrowdfundResponse; // ignore: deprecated_member_use
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

class CloseCrowdfundRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CloseCrowdfundRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'crowdfundId')
    ..hasRequiredFields = false
  ;

  CloseCrowdfundRequest._() : super();
  factory CloseCrowdfundRequest({
    $core.String? crowdfundId,
  }) {
    final _result = create();
    if (crowdfundId != null) {
      _result.crowdfundId = crowdfundId;
    }
    return _result;
  }
  factory CloseCrowdfundRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CloseCrowdfundRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CloseCrowdfundRequest clone() => CloseCrowdfundRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CloseCrowdfundRequest copyWith(void Function(CloseCrowdfundRequest) updates) => super.copyWith((message) => updates(message as CloseCrowdfundRequest)) as CloseCrowdfundRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CloseCrowdfundResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOM<Crowdfund>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'crowdfund', subBuilder: Crowdfund.create)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  CloseCrowdfundResponse._() : super();
  factory CloseCrowdfundResponse({
    Crowdfund? crowdfund,
    $core.String? message,
  }) {
    final _result = create();
    if (crowdfund != null) {
      _result.crowdfund = crowdfund;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory CloseCrowdfundResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CloseCrowdfundResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CloseCrowdfundResponse clone() => CloseCrowdfundResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CloseCrowdfundResponse copyWith(void Function(CloseCrowdfundResponse) updates) => super.copyWith((message) => updates(message as CloseCrowdfundResponse)) as CloseCrowdfundResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetCrowdfundStatisticsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'crowdfundId')
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'includeLeaderboard')
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'includeDailyProgress')
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'leaderboardLimit', $pb.PbFieldType.O3)
    ..a<$core.int>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'progressDays', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetCrowdfundStatisticsRequest._() : super();
  factory GetCrowdfundStatisticsRequest({
    $core.String? crowdfundId,
    $core.bool? includeLeaderboard,
    $core.bool? includeDailyProgress,
    $core.int? leaderboardLimit,
    $core.int? progressDays,
  }) {
    final _result = create();
    if (crowdfundId != null) {
      _result.crowdfundId = crowdfundId;
    }
    if (includeLeaderboard != null) {
      _result.includeLeaderboard = includeLeaderboard;
    }
    if (includeDailyProgress != null) {
      _result.includeDailyProgress = includeDailyProgress;
    }
    if (leaderboardLimit != null) {
      _result.leaderboardLimit = leaderboardLimit;
    }
    if (progressDays != null) {
      _result.progressDays = progressDays;
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetCrowdfundStatisticsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOM<CrowdfundStatistics>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'statistics', subBuilder: CrowdfundStatistics.create)
    ..hasRequiredFields = false
  ;

  GetCrowdfundStatisticsResponse._() : super();
  factory GetCrowdfundStatisticsResponse({
    CrowdfundStatistics? statistics,
  }) {
    final _result = create();
    if (statistics != null) {
      _result.statistics = statistics;
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

class CrowdfundStatistics extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CrowdfundStatistics', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'crowdfundId')
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalRaised', $pb.PbFieldType.OD)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'targetAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'progressPercentage', $pb.PbFieldType.OD)
    ..a<$core.int>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'donorCount', $pb.PbFieldType.O3)
    ..a<$core.double>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'averageDonation', $pb.PbFieldType.OD)
    ..a<$core.double>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'largestDonation', $pb.PbFieldType.OD)
    ..a<$core.double>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'smallestDonation', $pb.PbFieldType.OD)
    ..a<$core.int>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'daysRemaining', $pb.PbFieldType.O3)
    ..a<$core.int>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'daysActive', $pb.PbFieldType.O3)
    ..aOB(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isCompleted')
    ..aOS(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt')
    ..pc<ContributorLeaderboardEntry>(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'topContributors', $pb.PbFieldType.PM, subBuilder: ContributorLeaderboardEntry.create)
    ..pc<DailyProgress>(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dailyProgress', $pb.PbFieldType.PM, subBuilder: DailyProgress.create)
    ..a<$core.double>(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fundingVelocity', $pb.PbFieldType.OD)
    ..aOS(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'projectedCompletionDate')
    ..a<$core.int>(17, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'newDonorsToday', $pb.PbFieldType.O3)
    ..a<$core.int>(18, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'newDonorsThisWeek', $pb.PbFieldType.O3)
    ..a<$core.double>(19, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amountRaisedToday', $pb.PbFieldType.OD)
    ..a<$core.double>(20, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amountRaisedThisWeek', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  CrowdfundStatistics._() : super();
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
    if (smallestDonation != null) {
      _result.smallestDonation = smallestDonation;
    }
    if (daysRemaining != null) {
      _result.daysRemaining = daysRemaining;
    }
    if (daysActive != null) {
      _result.daysActive = daysActive;
    }
    if (isCompleted != null) {
      _result.isCompleted = isCompleted;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
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
    if (newDonorsToday != null) {
      _result.newDonorsToday = newDonorsToday;
    }
    if (newDonorsThisWeek != null) {
      _result.newDonorsThisWeek = newDonorsThisWeek;
    }
    if (amountRaisedToday != null) {
      _result.amountRaisedToday = amountRaisedToday;
    }
    if (amountRaisedThisWeek != null) {
      _result.amountRaisedThisWeek = amountRaisedThisWeek;
    }
    return _result;
  }
  factory CrowdfundStatistics.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CrowdfundStatistics.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CrowdfundStatistics clone() => CrowdfundStatistics()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CrowdfundStatistics copyWith(void Function(CrowdfundStatistics) updates) => super.copyWith((message) => updates(message as CrowdfundStatistics)) as CrowdfundStatistics; // ignore: deprecated_member_use
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

class ContributorLeaderboardEntry extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ContributorLeaderboardEntry', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'rank', $pb.PbFieldType.O3)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'displayName')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'profilePicture')
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalAmount', $pb.PbFieldType.OD)
    ..a<$core.int>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'contributionCount', $pb.PbFieldType.O3)
    ..aOB(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isAnonymous')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'firstContributionDate')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lastContributionDate')
    ..hasRequiredFields = false
  ;

  ContributorLeaderboardEntry._() : super();
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
    final _result = create();
    if (rank != null) {
      _result.rank = rank;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    if (displayName != null) {
      _result.displayName = displayName;
    }
    if (profilePicture != null) {
      _result.profilePicture = profilePicture;
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
    if (firstContributionDate != null) {
      _result.firstContributionDate = firstContributionDate;
    }
    if (lastContributionDate != null) {
      _result.lastContributionDate = lastContributionDate;
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

class DailyProgress extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DailyProgress', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'date')
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amountRaised', $pb.PbFieldType.OD)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'newDonors', $pb.PbFieldType.O3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalContributions', $pb.PbFieldType.O3)
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cumulativeAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'progressPercentage', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  DailyProgress._() : super();
  factory DailyProgress({
    $core.String? date,
    $core.double? amountRaised,
    $core.int? newDonors,
    $core.int? totalContributions,
    $core.double? cumulativeAmount,
    $core.double? progressPercentage,
  }) {
    final _result = create();
    if (date != null) {
      _result.date = date;
    }
    if (amountRaised != null) {
      _result.amountRaised = amountRaised;
    }
    if (newDonors != null) {
      _result.newDonors = newDonors;
    }
    if (totalContributions != null) {
      _result.totalContributions = totalContributions;
    }
    if (cumulativeAmount != null) {
      _result.cumulativeAmount = cumulativeAmount;
    }
    if (progressPercentage != null) {
      _result.progressPercentage = progressPercentage;
    }
    return _result;
  }
  factory DailyProgress.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DailyProgress.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DailyProgress clone() => DailyProgress()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DailyProgress copyWith(void Function(DailyProgress) updates) => super.copyWith((message) => updates(message as DailyProgress)) as DailyProgress; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SearchCrowdfundsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SearchCrowdfundsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..pc<Crowdfund>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'crowdfunds', $pb.PbFieldType.PM, subBuilder: Crowdfund.create)
    ..hasRequiredFields = false
  ;

  SearchCrowdfundsResponse._() : super();
  factory SearchCrowdfundsResponse({
    $core.Iterable<Crowdfund>? crowdfunds,
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
  $core.List<Crowdfund> get crowdfunds => $_getList(0);
}

class UpdateCrowdfundRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateCrowdfundRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'crowdfundId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'title')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'category')
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'targetAmount', $pb.PbFieldType.OD)
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'deadline')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'imageUrl')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..hasRequiredFields = false
  ;

  UpdateCrowdfundRequest._() : super();
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
    if (category != null) {
      _result.category = category;
    }
    if (targetAmount != null) {
      _result.targetAmount = targetAmount;
    }
    if (deadline != null) {
      _result.deadline = deadline;
    }
    if (imageUrl != null) {
      _result.imageUrl = imageUrl;
    }
    if (status != null) {
      _result.status = status;
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateCrowdfundResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOM<Crowdfund>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'crowdfund', subBuilder: Crowdfund.create)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  UpdateCrowdfundResponse._() : super();
  factory UpdateCrowdfundResponse({
    Crowdfund? crowdfund,
    $core.String? message,
  }) {
    final _result = create();
    if (crowdfund != null) {
      _result.crowdfund = crowdfund;
    }
    if (message != null) {
      _result.message = message;
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

class DeleteCrowdfundRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DeleteCrowdfundRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DeleteCrowdfundResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
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

class GetCrowdfundDonationsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetCrowdfundDonationsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetCrowdfundDonationsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..pc<CrowdfundContribution>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'donations', $pb.PbFieldType.PM, subBuilder: CrowdfundContribution.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'total', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOB(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hasMore')
    ..hasRequiredFields = false
  ;

  GetCrowdfundDonationsResponse._() : super();
  factory GetCrowdfundDonationsResponse({
    $core.Iterable<CrowdfundContribution>? donations,
    $core.int? total,
    $core.int? page,
    $core.int? pageSize,
    $core.bool? hasMore,
  }) {
    final _result = create();
    if (donations != null) {
      _result.donations.addAll(donations);
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

class GetUserDonationsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetUserDonationsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetUserDonationsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..pc<CrowdfundContribution>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'donations', $pb.PbFieldType.PM, subBuilder: CrowdfundContribution.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'total', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOB(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hasMore')
    ..hasRequiredFields = false
  ;

  GetUserDonationsResponse._() : super();
  factory GetUserDonationsResponse({
    $core.Iterable<CrowdfundContribution>? donations,
    $core.int? total,
    $core.int? page,
    $core.int? pageSize,
    $core.bool? hasMore,
  }) {
    final _result = create();
    if (donations != null) {
      _result.donations.addAll(donations);
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

class GenerateDonationReceiptRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GenerateDonationReceiptRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GenerateDonationReceiptResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOM<CrowdfundReceipt>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'receipt', subBuilder: CrowdfundReceipt.create)
    ..hasRequiredFields = false
  ;

  GenerateDonationReceiptResponse._() : super();
  factory GenerateDonationReceiptResponse({
    CrowdfundReceipt? receipt,
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

class GetUserCrowdfundReceiptsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetUserCrowdfundReceiptsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetUserCrowdfundReceiptsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..pc<CrowdfundReceipt>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'receipts', $pb.PbFieldType.PM, subBuilder: CrowdfundReceipt.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'total', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOB(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hasMore')
    ..hasRequiredFields = false
  ;

  GetUserCrowdfundReceiptsResponse._() : super();
  factory GetUserCrowdfundReceiptsResponse({
    $core.Iterable<CrowdfundReceipt>? receipts,
    $core.int? total,
    $core.int? page,
    $core.int? pageSize,
    $core.bool? hasMore,
  }) {
    final _result = create();
    if (receipts != null) {
      _result.receipts.addAll(receipts);
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

class CrowdfundReceipt extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CrowdfundReceipt', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'donationId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'crowdfundId')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'crowdfundTitle')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'donorUserId')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'donorName')
    ..a<$core.double>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'donationDate')
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'generatedAt')
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'receiptNumber')
    ..aOS(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'receiptData')
    ..hasRequiredFields = false
  ;

  CrowdfundReceipt._() : super();
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
  factory CrowdfundReceipt.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CrowdfundReceipt.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CrowdfundReceipt clone() => CrowdfundReceipt()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CrowdfundReceipt copyWith(void Function(CrowdfundReceipt) updates) => super.copyWith((message) => updates(message as CrowdfundReceipt)) as CrowdfundReceipt; // ignore: deprecated_member_use
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

class InsurancePaymentRecord extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'InsurancePaymentRecord', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'policyId')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountId')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'purchaseId')
    ..aInt64(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'paymentMethod')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionReference')
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'idempotencyKey')
    ..aOS(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'narration')
    ..aOS(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'failureReason')
    ..aOS(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'receiptNumber')
    ..aOS(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'processedAt')
    ..aOS(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt')
    ..aOS(17, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedAt')
    ..hasRequiredFields = false
  ;

  InsurancePaymentRecord._() : super();
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
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    if (policyId != null) {
      _result.policyId = policyId;
    }
    if (accountId != null) {
      _result.accountId = accountId;
    }
    if (purchaseId != null) {
      _result.purchaseId = purchaseId;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (paymentMethod != null) {
      _result.paymentMethod = paymentMethod;
    }
    if (status != null) {
      _result.status = status;
    }
    if (transactionReference != null) {
      _result.transactionReference = transactionReference;
    }
    if (idempotencyKey != null) {
      _result.idempotencyKey = idempotencyKey;
    }
    if (narration != null) {
      _result.narration = narration;
    }
    if (failureReason != null) {
      _result.failureReason = failureReason;
    }
    if (receiptNumber != null) {
      _result.receiptNumber = receiptNumber;
    }
    if (processedAt != null) {
      _result.processedAt = processedAt;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      _result.updatedAt = updatedAt;
    }
    return _result;
  }
  factory InsurancePaymentRecord.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InsurancePaymentRecord.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InsurancePaymentRecord clone() => InsurancePaymentRecord()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InsurancePaymentRecord copyWith(void Function(InsurancePaymentRecord) updates) => super.copyWith((message) => updates(message as InsurancePaymentRecord)) as InsurancePaymentRecord; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static InsurancePaymentRecord create() => InsurancePaymentRecord._();
  InsurancePaymentRecord createEmptyInstance() => create();
  static $pb.PbList<InsurancePaymentRecord> createRepeated() => $pb.PbList<InsurancePaymentRecord>();
  @$core.pragma('dart2js:noInline')
  static InsurancePaymentRecord getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InsurancePaymentRecord>(create);
  static InsurancePaymentRecord? _defaultInstance;

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
  $core.String get policyId => $_getSZ(2);
  @$pb.TagNumber(3)
  set policyId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPolicyId() => $_has(2);
  @$pb.TagNumber(3)
  void clearPolicyId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get accountId => $_getSZ(3);
  @$pb.TagNumber(4)
  set accountId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasAccountId() => $_has(3);
  @$pb.TagNumber(4)
  void clearAccountId() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get purchaseId => $_getSZ(4);
  @$pb.TagNumber(5)
  set purchaseId($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasPurchaseId() => $_has(4);
  @$pb.TagNumber(5)
  void clearPurchaseId() => clearField(5);

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
  $core.String get paymentMethod => $_getSZ(7);
  @$pb.TagNumber(8)
  set paymentMethod($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasPaymentMethod() => $_has(7);
  @$pb.TagNumber(8)
  void clearPaymentMethod() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get status => $_getSZ(8);
  @$pb.TagNumber(9)
  set status($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasStatus() => $_has(8);
  @$pb.TagNumber(9)
  void clearStatus() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get transactionReference => $_getSZ(9);
  @$pb.TagNumber(10)
  set transactionReference($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasTransactionReference() => $_has(9);
  @$pb.TagNumber(10)
  void clearTransactionReference() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get idempotencyKey => $_getSZ(10);
  @$pb.TagNumber(11)
  set idempotencyKey($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasIdempotencyKey() => $_has(10);
  @$pb.TagNumber(11)
  void clearIdempotencyKey() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get narration => $_getSZ(11);
  @$pb.TagNumber(12)
  set narration($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasNarration() => $_has(11);
  @$pb.TagNumber(12)
  void clearNarration() => clearField(12);

  @$pb.TagNumber(13)
  $core.String get failureReason => $_getSZ(12);
  @$pb.TagNumber(13)
  set failureReason($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasFailureReason() => $_has(12);
  @$pb.TagNumber(13)
  void clearFailureReason() => clearField(13);

  @$pb.TagNumber(14)
  $core.String get receiptNumber => $_getSZ(13);
  @$pb.TagNumber(14)
  set receiptNumber($core.String v) { $_setString(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasReceiptNumber() => $_has(13);
  @$pb.TagNumber(14)
  void clearReceiptNumber() => clearField(14);

  @$pb.TagNumber(15)
  $core.String get processedAt => $_getSZ(14);
  @$pb.TagNumber(15)
  set processedAt($core.String v) { $_setString(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasProcessedAt() => $_has(14);
  @$pb.TagNumber(15)
  void clearProcessedAt() => clearField(15);

  @$pb.TagNumber(16)
  $core.String get createdAt => $_getSZ(15);
  @$pb.TagNumber(16)
  set createdAt($core.String v) { $_setString(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasCreatedAt() => $_has(15);
  @$pb.TagNumber(16)
  void clearCreatedAt() => clearField(16);

  @$pb.TagNumber(17)
  $core.String get updatedAt => $_getSZ(16);
  @$pb.TagNumber(17)
  set updatedAt($core.String v) { $_setString(16, v); }
  @$pb.TagNumber(17)
  $core.bool hasUpdatedAt() => $_has(16);
  @$pb.TagNumber(17)
  void clearUpdatedAt() => clearField(17);
}

class InsuranceClaimRecord extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'InsuranceClaimRecord', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'policyId')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'claimNumber')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'claimType')
    ..aInt64(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'claimAmount')
    ..aInt64(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'approvedAmount')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'title')
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..aOS(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'incidentDate')
    ..aOS(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'incidentLocation')
    ..pPS(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'documents')
    ..m<$core.String, $core.String>(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'additionalInfo', entryClassName: 'InsuranceClaimRecord.AdditionalInfoEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('financialproducts'))
    ..aOS(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'rejectionReason')
    ..aOS(17, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'settlementDate')
    ..aOS(18, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'settlementDetails')
    ..aOS(19, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerClaimId')
    ..aOS(20, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt')
    ..aOS(21, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedAt')
    ..pPS(22, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'attachments')
    ..hasRequiredFields = false
  ;

  InsuranceClaimRecord._() : super();
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
    $core.Map<$core.String, $core.String>? additionalInfo,
    $core.String? rejectionReason,
    $core.String? settlementDate,
    $core.String? settlementDetails,
    $core.String? providerClaimId,
    $core.String? createdAt,
    $core.String? updatedAt,
    $core.Iterable<$core.String>? attachments,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    if (policyId != null) {
      _result.policyId = policyId;
    }
    if (claimNumber != null) {
      _result.claimNumber = claimNumber;
    }
    if (claimType != null) {
      _result.claimType = claimType;
    }
    if (claimAmount != null) {
      _result.claimAmount = claimAmount;
    }
    if (approvedAmount != null) {
      _result.approvedAmount = approvedAmount;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (status != null) {
      _result.status = status;
    }
    if (title != null) {
      _result.title = title;
    }
    if (description != null) {
      _result.description = description;
    }
    if (incidentDate != null) {
      _result.incidentDate = incidentDate;
    }
    if (incidentLocation != null) {
      _result.incidentLocation = incidentLocation;
    }
    if (documents != null) {
      _result.documents.addAll(documents);
    }
    if (additionalInfo != null) {
      _result.additionalInfo.addAll(additionalInfo);
    }
    if (rejectionReason != null) {
      _result.rejectionReason = rejectionReason;
    }
    if (settlementDate != null) {
      _result.settlementDate = settlementDate;
    }
    if (settlementDetails != null) {
      _result.settlementDetails = settlementDetails;
    }
    if (providerClaimId != null) {
      _result.providerClaimId = providerClaimId;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      _result.updatedAt = updatedAt;
    }
    if (attachments != null) {
      _result.attachments.addAll(attachments);
    }
    return _result;
  }
  factory InsuranceClaimRecord.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InsuranceClaimRecord.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InsuranceClaimRecord clone() => InsuranceClaimRecord()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InsuranceClaimRecord copyWith(void Function(InsuranceClaimRecord) updates) => super.copyWith((message) => updates(message as InsuranceClaimRecord)) as InsuranceClaimRecord; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static InsuranceClaimRecord create() => InsuranceClaimRecord._();
  InsuranceClaimRecord createEmptyInstance() => create();
  static $pb.PbList<InsuranceClaimRecord> createRepeated() => $pb.PbList<InsuranceClaimRecord>();
  @$core.pragma('dart2js:noInline')
  static InsuranceClaimRecord getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InsuranceClaimRecord>(create);
  static InsuranceClaimRecord? _defaultInstance;

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
  $core.String get policyId => $_getSZ(2);
  @$pb.TagNumber(3)
  set policyId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPolicyId() => $_has(2);
  @$pb.TagNumber(3)
  void clearPolicyId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get claimNumber => $_getSZ(3);
  @$pb.TagNumber(4)
  set claimNumber($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasClaimNumber() => $_has(3);
  @$pb.TagNumber(4)
  void clearClaimNumber() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get claimType => $_getSZ(4);
  @$pb.TagNumber(5)
  set claimType($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasClaimType() => $_has(4);
  @$pb.TagNumber(5)
  void clearClaimType() => clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get claimAmount => $_getI64(5);
  @$pb.TagNumber(6)
  set claimAmount($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasClaimAmount() => $_has(5);
  @$pb.TagNumber(6)
  void clearClaimAmount() => clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get approvedAmount => $_getI64(6);
  @$pb.TagNumber(7)
  set approvedAmount($fixnum.Int64 v) { $_setInt64(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasApprovedAmount() => $_has(6);
  @$pb.TagNumber(7)
  void clearApprovedAmount() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get currency => $_getSZ(7);
  @$pb.TagNumber(8)
  set currency($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasCurrency() => $_has(7);
  @$pb.TagNumber(8)
  void clearCurrency() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get status => $_getSZ(8);
  @$pb.TagNumber(9)
  set status($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasStatus() => $_has(8);
  @$pb.TagNumber(9)
  void clearStatus() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get title => $_getSZ(9);
  @$pb.TagNumber(10)
  set title($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasTitle() => $_has(9);
  @$pb.TagNumber(10)
  void clearTitle() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get description => $_getSZ(10);
  @$pb.TagNumber(11)
  set description($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasDescription() => $_has(10);
  @$pb.TagNumber(11)
  void clearDescription() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get incidentDate => $_getSZ(11);
  @$pb.TagNumber(12)
  set incidentDate($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasIncidentDate() => $_has(11);
  @$pb.TagNumber(12)
  void clearIncidentDate() => clearField(12);

  @$pb.TagNumber(13)
  $core.String get incidentLocation => $_getSZ(12);
  @$pb.TagNumber(13)
  set incidentLocation($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasIncidentLocation() => $_has(12);
  @$pb.TagNumber(13)
  void clearIncidentLocation() => clearField(13);

  @$pb.TagNumber(14)
  $core.List<$core.String> get documents => $_getList(13);

  @$pb.TagNumber(15)
  $core.Map<$core.String, $core.String> get additionalInfo => $_getMap(14);

  @$pb.TagNumber(16)
  $core.String get rejectionReason => $_getSZ(15);
  @$pb.TagNumber(16)
  set rejectionReason($core.String v) { $_setString(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasRejectionReason() => $_has(15);
  @$pb.TagNumber(16)
  void clearRejectionReason() => clearField(16);

  @$pb.TagNumber(17)
  $core.String get settlementDate => $_getSZ(16);
  @$pb.TagNumber(17)
  set settlementDate($core.String v) { $_setString(16, v); }
  @$pb.TagNumber(17)
  $core.bool hasSettlementDate() => $_has(16);
  @$pb.TagNumber(17)
  void clearSettlementDate() => clearField(17);

  @$pb.TagNumber(18)
  $core.String get settlementDetails => $_getSZ(17);
  @$pb.TagNumber(18)
  set settlementDetails($core.String v) { $_setString(17, v); }
  @$pb.TagNumber(18)
  $core.bool hasSettlementDetails() => $_has(17);
  @$pb.TagNumber(18)
  void clearSettlementDetails() => clearField(18);

  @$pb.TagNumber(19)
  $core.String get providerClaimId => $_getSZ(18);
  @$pb.TagNumber(19)
  set providerClaimId($core.String v) { $_setString(18, v); }
  @$pb.TagNumber(19)
  $core.bool hasProviderClaimId() => $_has(18);
  @$pb.TagNumber(19)
  void clearProviderClaimId() => clearField(19);

  @$pb.TagNumber(20)
  $core.String get createdAt => $_getSZ(19);
  @$pb.TagNumber(20)
  set createdAt($core.String v) { $_setString(19, v); }
  @$pb.TagNumber(20)
  $core.bool hasCreatedAt() => $_has(19);
  @$pb.TagNumber(20)
  void clearCreatedAt() => clearField(20);

  @$pb.TagNumber(21)
  $core.String get updatedAt => $_getSZ(20);
  @$pb.TagNumber(21)
  set updatedAt($core.String v) { $_setString(20, v); }
  @$pb.TagNumber(21)
  $core.bool hasUpdatedAt() => $_has(20);
  @$pb.TagNumber(21)
  void clearUpdatedAt() => clearField(21);

  @$pb.TagNumber(22)
  $core.List<$core.String> get attachments => $_getList(21);
}

class GetInsurancePaymentsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInsurancePaymentsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'policyId')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetInsurancePaymentsRequest._() : super();
  factory GetInsurancePaymentsRequest({
    $core.String? policyId,
    $core.int? limit,
    $core.int? offset,
  }) {
    final _result = create();
    if (policyId != null) {
      _result.policyId = policyId;
    }
    if (limit != null) {
      _result.limit = limit;
    }
    if (offset != null) {
      _result.offset = offset;
    }
    return _result;
  }
  factory GetInsurancePaymentsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInsurancePaymentsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInsurancePaymentsRequest clone() => GetInsurancePaymentsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInsurancePaymentsRequest copyWith(void Function(GetInsurancePaymentsRequest) updates) => super.copyWith((message) => updates(message as GetInsurancePaymentsRequest)) as GetInsurancePaymentsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetInsurancePaymentsRequest create() => GetInsurancePaymentsRequest._();
  GetInsurancePaymentsRequest createEmptyInstance() => create();
  static $pb.PbList<GetInsurancePaymentsRequest> createRepeated() => $pb.PbList<GetInsurancePaymentsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInsurancePaymentsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInsurancePaymentsRequest>(create);
  static GetInsurancePaymentsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get policyId => $_getSZ(0);
  @$pb.TagNumber(1)
  set policyId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPolicyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPolicyId() => clearField(1);

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

class GetInsurancePaymentsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInsurancePaymentsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..pc<InsurancePaymentRecord>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payments', $pb.PbFieldType.PM, subBuilder: InsurancePaymentRecord.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetInsurancePaymentsResponse._() : super();
  factory GetInsurancePaymentsResponse({
    $core.Iterable<InsurancePaymentRecord>? payments,
    $core.int? total,
  }) {
    final _result = create();
    if (payments != null) {
      _result.payments.addAll(payments);
    }
    if (total != null) {
      _result.total = total;
    }
    return _result;
  }
  factory GetInsurancePaymentsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInsurancePaymentsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInsurancePaymentsResponse clone() => GetInsurancePaymentsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInsurancePaymentsResponse copyWith(void Function(GetInsurancePaymentsResponse) updates) => super.copyWith((message) => updates(message as GetInsurancePaymentsResponse)) as GetInsurancePaymentsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetInsurancePaymentsResponse create() => GetInsurancePaymentsResponse._();
  GetInsurancePaymentsResponse createEmptyInstance() => create();
  static $pb.PbList<GetInsurancePaymentsResponse> createRepeated() => $pb.PbList<GetInsurancePaymentsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInsurancePaymentsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInsurancePaymentsResponse>(create);
  static GetInsurancePaymentsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<InsurancePaymentRecord> get payments => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => clearField(2);
}

class GetUserInsurancePaymentsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetUserInsurancePaymentsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetUserInsurancePaymentsRequest._() : super();
  factory GetUserInsurancePaymentsRequest({
    $core.String? status,
    $core.int? limit,
    $core.int? offset,
  }) {
    final _result = create();
    if (status != null) {
      _result.status = status;
    }
    if (limit != null) {
      _result.limit = limit;
    }
    if (offset != null) {
      _result.offset = offset;
    }
    return _result;
  }
  factory GetUserInsurancePaymentsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUserInsurancePaymentsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUserInsurancePaymentsRequest clone() => GetUserInsurancePaymentsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUserInsurancePaymentsRequest copyWith(void Function(GetUserInsurancePaymentsRequest) updates) => super.copyWith((message) => updates(message as GetUserInsurancePaymentsRequest)) as GetUserInsurancePaymentsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetUserInsurancePaymentsRequest create() => GetUserInsurancePaymentsRequest._();
  GetUserInsurancePaymentsRequest createEmptyInstance() => create();
  static $pb.PbList<GetUserInsurancePaymentsRequest> createRepeated() => $pb.PbList<GetUserInsurancePaymentsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetUserInsurancePaymentsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetUserInsurancePaymentsRequest>(create);
  static GetUserInsurancePaymentsRequest? _defaultInstance;

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

class GetUserInsurancePaymentsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetUserInsurancePaymentsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..pc<InsurancePaymentRecord>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payments', $pb.PbFieldType.PM, subBuilder: InsurancePaymentRecord.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetUserInsurancePaymentsResponse._() : super();
  factory GetUserInsurancePaymentsResponse({
    $core.Iterable<InsurancePaymentRecord>? payments,
    $core.int? total,
  }) {
    final _result = create();
    if (payments != null) {
      _result.payments.addAll(payments);
    }
    if (total != null) {
      _result.total = total;
    }
    return _result;
  }
  factory GetUserInsurancePaymentsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUserInsurancePaymentsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUserInsurancePaymentsResponse clone() => GetUserInsurancePaymentsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUserInsurancePaymentsResponse copyWith(void Function(GetUserInsurancePaymentsResponse) updates) => super.copyWith((message) => updates(message as GetUserInsurancePaymentsResponse)) as GetUserInsurancePaymentsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetUserInsurancePaymentsResponse create() => GetUserInsurancePaymentsResponse._();
  GetUserInsurancePaymentsResponse createEmptyInstance() => create();
  static $pb.PbList<GetUserInsurancePaymentsResponse> createRepeated() => $pb.PbList<GetUserInsurancePaymentsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetUserInsurancePaymentsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetUserInsurancePaymentsResponse>(create);
  static GetUserInsurancePaymentsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<InsurancePaymentRecord> get payments => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => clearField(2);
}

class CreateInsurancePaymentRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateInsurancePaymentRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'policyId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountId')
    ..aInt64(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'paymentMethod')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'narration')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'idempotencyKey')
    ..hasRequiredFields = false
  ;

  CreateInsurancePaymentRequest._() : super();
  factory CreateInsurancePaymentRequest({
    $core.String? policyId,
    $core.String? accountId,
    $fixnum.Int64? amount,
    $core.String? currency,
    $core.String? paymentMethod,
    $core.String? narration,
    $core.String? idempotencyKey,
  }) {
    final _result = create();
    if (policyId != null) {
      _result.policyId = policyId;
    }
    if (accountId != null) {
      _result.accountId = accountId;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (paymentMethod != null) {
      _result.paymentMethod = paymentMethod;
    }
    if (narration != null) {
      _result.narration = narration;
    }
    if (idempotencyKey != null) {
      _result.idempotencyKey = idempotencyKey;
    }
    return _result;
  }
  factory CreateInsurancePaymentRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateInsurancePaymentRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateInsurancePaymentRequest clone() => CreateInsurancePaymentRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateInsurancePaymentRequest copyWith(void Function(CreateInsurancePaymentRequest) updates) => super.copyWith((message) => updates(message as CreateInsurancePaymentRequest)) as CreateInsurancePaymentRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateInsurancePaymentRequest create() => CreateInsurancePaymentRequest._();
  CreateInsurancePaymentRequest createEmptyInstance() => create();
  static $pb.PbList<CreateInsurancePaymentRequest> createRepeated() => $pb.PbList<CreateInsurancePaymentRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateInsurancePaymentRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateInsurancePaymentRequest>(create);
  static CreateInsurancePaymentRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get policyId => $_getSZ(0);
  @$pb.TagNumber(1)
  set policyId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPolicyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPolicyId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get accountId => $_getSZ(1);
  @$pb.TagNumber(2)
  set accountId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAccountId() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccountId() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get amount => $_getI64(2);
  @$pb.TagNumber(3)
  set amount($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get currency => $_getSZ(3);
  @$pb.TagNumber(4)
  set currency($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCurrency() => $_has(3);
  @$pb.TagNumber(4)
  void clearCurrency() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get paymentMethod => $_getSZ(4);
  @$pb.TagNumber(5)
  set paymentMethod($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasPaymentMethod() => $_has(4);
  @$pb.TagNumber(5)
  void clearPaymentMethod() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get narration => $_getSZ(5);
  @$pb.TagNumber(6)
  set narration($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasNarration() => $_has(5);
  @$pb.TagNumber(6)
  void clearNarration() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get idempotencyKey => $_getSZ(6);
  @$pb.TagNumber(7)
  set idempotencyKey($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasIdempotencyKey() => $_has(6);
  @$pb.TagNumber(7)
  void clearIdempotencyKey() => clearField(7);
}

class CreateInsurancePaymentResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateInsurancePaymentResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOM<InsurancePaymentRecord>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payment', subBuilder: InsurancePaymentRecord.create)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  CreateInsurancePaymentResponse._() : super();
  factory CreateInsurancePaymentResponse({
    InsurancePaymentRecord? payment,
    $core.String? message,
  }) {
    final _result = create();
    if (payment != null) {
      _result.payment = payment;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory CreateInsurancePaymentResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateInsurancePaymentResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateInsurancePaymentResponse clone() => CreateInsurancePaymentResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateInsurancePaymentResponse copyWith(void Function(CreateInsurancePaymentResponse) updates) => super.copyWith((message) => updates(message as CreateInsurancePaymentResponse)) as CreateInsurancePaymentResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateInsurancePaymentResponse create() => CreateInsurancePaymentResponse._();
  CreateInsurancePaymentResponse createEmptyInstance() => create();
  static $pb.PbList<CreateInsurancePaymentResponse> createRepeated() => $pb.PbList<CreateInsurancePaymentResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateInsurancePaymentResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateInsurancePaymentResponse>(create);
  static CreateInsurancePaymentResponse? _defaultInstance;

  @$pb.TagNumber(1)
  InsurancePaymentRecord get payment => $_getN(0);
  @$pb.TagNumber(1)
  set payment(InsurancePaymentRecord v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasPayment() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayment() => clearField(1);
  @$pb.TagNumber(1)
  InsurancePaymentRecord ensurePayment() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

class ProcessInsurancePaymentRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProcessInsurancePaymentRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'paymentId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionPinToken')
    ..hasRequiredFields = false
  ;

  ProcessInsurancePaymentRequest._() : super();
  factory ProcessInsurancePaymentRequest({
    $core.String? paymentId,
    $core.String? transactionPinToken,
  }) {
    final _result = create();
    if (paymentId != null) {
      _result.paymentId = paymentId;
    }
    if (transactionPinToken != null) {
      _result.transactionPinToken = transactionPinToken;
    }
    return _result;
  }
  factory ProcessInsurancePaymentRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProcessInsurancePaymentRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProcessInsurancePaymentRequest clone() => ProcessInsurancePaymentRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProcessInsurancePaymentRequest copyWith(void Function(ProcessInsurancePaymentRequest) updates) => super.copyWith((message) => updates(message as ProcessInsurancePaymentRequest)) as ProcessInsurancePaymentRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProcessInsurancePaymentRequest create() => ProcessInsurancePaymentRequest._();
  ProcessInsurancePaymentRequest createEmptyInstance() => create();
  static $pb.PbList<ProcessInsurancePaymentRequest> createRepeated() => $pb.PbList<ProcessInsurancePaymentRequest>();
  @$core.pragma('dart2js:noInline')
  static ProcessInsurancePaymentRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProcessInsurancePaymentRequest>(create);
  static ProcessInsurancePaymentRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get paymentId => $_getSZ(0);
  @$pb.TagNumber(1)
  set paymentId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPaymentId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPaymentId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get transactionPinToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set transactionPinToken($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTransactionPinToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearTransactionPinToken() => clearField(2);
}

class ProcessInsurancePaymentResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProcessInsurancePaymentResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOM<InsurancePaymentRecord>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payment', subBuilder: InsurancePaymentRecord.create)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  ProcessInsurancePaymentResponse._() : super();
  factory ProcessInsurancePaymentResponse({
    InsurancePaymentRecord? payment,
    $core.String? message,
  }) {
    final _result = create();
    if (payment != null) {
      _result.payment = payment;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory ProcessInsurancePaymentResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProcessInsurancePaymentResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProcessInsurancePaymentResponse clone() => ProcessInsurancePaymentResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProcessInsurancePaymentResponse copyWith(void Function(ProcessInsurancePaymentResponse) updates) => super.copyWith((message) => updates(message as ProcessInsurancePaymentResponse)) as ProcessInsurancePaymentResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProcessInsurancePaymentResponse create() => ProcessInsurancePaymentResponse._();
  ProcessInsurancePaymentResponse createEmptyInstance() => create();
  static $pb.PbList<ProcessInsurancePaymentResponse> createRepeated() => $pb.PbList<ProcessInsurancePaymentResponse>();
  @$core.pragma('dart2js:noInline')
  static ProcessInsurancePaymentResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProcessInsurancePaymentResponse>(create);
  static ProcessInsurancePaymentResponse? _defaultInstance;

  @$pb.TagNumber(1)
  InsurancePaymentRecord get payment => $_getN(0);
  @$pb.TagNumber(1)
  set payment(InsurancePaymentRecord v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasPayment() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayment() => clearField(1);
  @$pb.TagNumber(1)
  InsurancePaymentRecord ensurePayment() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

class GetInsurancePaymentByIdRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInsurancePaymentByIdRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'paymentId')
    ..hasRequiredFields = false
  ;

  GetInsurancePaymentByIdRequest._() : super();
  factory GetInsurancePaymentByIdRequest({
    $core.String? paymentId,
  }) {
    final _result = create();
    if (paymentId != null) {
      _result.paymentId = paymentId;
    }
    return _result;
  }
  factory GetInsurancePaymentByIdRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInsurancePaymentByIdRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInsurancePaymentByIdRequest clone() => GetInsurancePaymentByIdRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInsurancePaymentByIdRequest copyWith(void Function(GetInsurancePaymentByIdRequest) updates) => super.copyWith((message) => updates(message as GetInsurancePaymentByIdRequest)) as GetInsurancePaymentByIdRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetInsurancePaymentByIdRequest create() => GetInsurancePaymentByIdRequest._();
  GetInsurancePaymentByIdRequest createEmptyInstance() => create();
  static $pb.PbList<GetInsurancePaymentByIdRequest> createRepeated() => $pb.PbList<GetInsurancePaymentByIdRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInsurancePaymentByIdRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInsurancePaymentByIdRequest>(create);
  static GetInsurancePaymentByIdRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get paymentId => $_getSZ(0);
  @$pb.TagNumber(1)
  set paymentId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPaymentId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPaymentId() => clearField(1);
}

class GetInsurancePaymentByIdResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInsurancePaymentByIdResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOM<InsurancePaymentRecord>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payment', subBuilder: InsurancePaymentRecord.create)
    ..hasRequiredFields = false
  ;

  GetInsurancePaymentByIdResponse._() : super();
  factory GetInsurancePaymentByIdResponse({
    InsurancePaymentRecord? payment,
  }) {
    final _result = create();
    if (payment != null) {
      _result.payment = payment;
    }
    return _result;
  }
  factory GetInsurancePaymentByIdResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInsurancePaymentByIdResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInsurancePaymentByIdResponse clone() => GetInsurancePaymentByIdResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInsurancePaymentByIdResponse copyWith(void Function(GetInsurancePaymentByIdResponse) updates) => super.copyWith((message) => updates(message as GetInsurancePaymentByIdResponse)) as GetInsurancePaymentByIdResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetInsurancePaymentByIdResponse create() => GetInsurancePaymentByIdResponse._();
  GetInsurancePaymentByIdResponse createEmptyInstance() => create();
  static $pb.PbList<GetInsurancePaymentByIdResponse> createRepeated() => $pb.PbList<GetInsurancePaymentByIdResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInsurancePaymentByIdResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInsurancePaymentByIdResponse>(create);
  static GetInsurancePaymentByIdResponse? _defaultInstance;

  @$pb.TagNumber(1)
  InsurancePaymentRecord get payment => $_getN(0);
  @$pb.TagNumber(1)
  set payment(InsurancePaymentRecord v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasPayment() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayment() => clearField(1);
  @$pb.TagNumber(1)
  InsurancePaymentRecord ensurePayment() => $_ensure(0);
}

class GetOverdueInsurancePaymentsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetOverdueInsurancePaymentsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GetOverdueInsurancePaymentsRequest._() : super();
  factory GetOverdueInsurancePaymentsRequest() => create();
  factory GetOverdueInsurancePaymentsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetOverdueInsurancePaymentsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetOverdueInsurancePaymentsRequest clone() => GetOverdueInsurancePaymentsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetOverdueInsurancePaymentsRequest copyWith(void Function(GetOverdueInsurancePaymentsRequest) updates) => super.copyWith((message) => updates(message as GetOverdueInsurancePaymentsRequest)) as GetOverdueInsurancePaymentsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetOverdueInsurancePaymentsRequest create() => GetOverdueInsurancePaymentsRequest._();
  GetOverdueInsurancePaymentsRequest createEmptyInstance() => create();
  static $pb.PbList<GetOverdueInsurancePaymentsRequest> createRepeated() => $pb.PbList<GetOverdueInsurancePaymentsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetOverdueInsurancePaymentsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetOverdueInsurancePaymentsRequest>(create);
  static GetOverdueInsurancePaymentsRequest? _defaultInstance;
}

class GetOverdueInsurancePaymentsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetOverdueInsurancePaymentsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..pc<InsurancePaymentRecord>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payments', $pb.PbFieldType.PM, subBuilder: InsurancePaymentRecord.create)
    ..hasRequiredFields = false
  ;

  GetOverdueInsurancePaymentsResponse._() : super();
  factory GetOverdueInsurancePaymentsResponse({
    $core.Iterable<InsurancePaymentRecord>? payments,
  }) {
    final _result = create();
    if (payments != null) {
      _result.payments.addAll(payments);
    }
    return _result;
  }
  factory GetOverdueInsurancePaymentsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetOverdueInsurancePaymentsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetOverdueInsurancePaymentsResponse clone() => GetOverdueInsurancePaymentsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetOverdueInsurancePaymentsResponse copyWith(void Function(GetOverdueInsurancePaymentsResponse) updates) => super.copyWith((message) => updates(message as GetOverdueInsurancePaymentsResponse)) as GetOverdueInsurancePaymentsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetOverdueInsurancePaymentsResponse create() => GetOverdueInsurancePaymentsResponse._();
  GetOverdueInsurancePaymentsResponse createEmptyInstance() => create();
  static $pb.PbList<GetOverdueInsurancePaymentsResponse> createRepeated() => $pb.PbList<GetOverdueInsurancePaymentsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetOverdueInsurancePaymentsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetOverdueInsurancePaymentsResponse>(create);
  static GetOverdueInsurancePaymentsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<InsurancePaymentRecord> get payments => $_getList(0);
}

class GetInsuranceClaimsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInsuranceClaimsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'policyId')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetInsuranceClaimsRequest._() : super();
  factory GetInsuranceClaimsRequest({
    $core.String? policyId,
    $core.int? limit,
    $core.int? offset,
  }) {
    final _result = create();
    if (policyId != null) {
      _result.policyId = policyId;
    }
    if (limit != null) {
      _result.limit = limit;
    }
    if (offset != null) {
      _result.offset = offset;
    }
    return _result;
  }
  factory GetInsuranceClaimsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInsuranceClaimsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInsuranceClaimsRequest clone() => GetInsuranceClaimsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInsuranceClaimsRequest copyWith(void Function(GetInsuranceClaimsRequest) updates) => super.copyWith((message) => updates(message as GetInsuranceClaimsRequest)) as GetInsuranceClaimsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetInsuranceClaimsRequest create() => GetInsuranceClaimsRequest._();
  GetInsuranceClaimsRequest createEmptyInstance() => create();
  static $pb.PbList<GetInsuranceClaimsRequest> createRepeated() => $pb.PbList<GetInsuranceClaimsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInsuranceClaimsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInsuranceClaimsRequest>(create);
  static GetInsuranceClaimsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get policyId => $_getSZ(0);
  @$pb.TagNumber(1)
  set policyId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPolicyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPolicyId() => clearField(1);

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

class GetInsuranceClaimsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInsuranceClaimsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..pc<InsuranceClaimRecord>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'claims', $pb.PbFieldType.PM, subBuilder: InsuranceClaimRecord.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetInsuranceClaimsResponse._() : super();
  factory GetInsuranceClaimsResponse({
    $core.Iterable<InsuranceClaimRecord>? claims,
    $core.int? total,
  }) {
    final _result = create();
    if (claims != null) {
      _result.claims.addAll(claims);
    }
    if (total != null) {
      _result.total = total;
    }
    return _result;
  }
  factory GetInsuranceClaimsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInsuranceClaimsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInsuranceClaimsResponse clone() => GetInsuranceClaimsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInsuranceClaimsResponse copyWith(void Function(GetInsuranceClaimsResponse) updates) => super.copyWith((message) => updates(message as GetInsuranceClaimsResponse)) as GetInsuranceClaimsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetInsuranceClaimsResponse create() => GetInsuranceClaimsResponse._();
  GetInsuranceClaimsResponse createEmptyInstance() => create();
  static $pb.PbList<GetInsuranceClaimsResponse> createRepeated() => $pb.PbList<GetInsuranceClaimsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInsuranceClaimsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInsuranceClaimsResponse>(create);
  static GetInsuranceClaimsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<InsuranceClaimRecord> get claims => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => clearField(2);
}

class GetUserInsuranceClaimsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetUserInsuranceClaimsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetUserInsuranceClaimsRequest._() : super();
  factory GetUserInsuranceClaimsRequest({
    $core.String? status,
    $core.int? limit,
    $core.int? offset,
  }) {
    final _result = create();
    if (status != null) {
      _result.status = status;
    }
    if (limit != null) {
      _result.limit = limit;
    }
    if (offset != null) {
      _result.offset = offset;
    }
    return _result;
  }
  factory GetUserInsuranceClaimsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUserInsuranceClaimsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUserInsuranceClaimsRequest clone() => GetUserInsuranceClaimsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUserInsuranceClaimsRequest copyWith(void Function(GetUserInsuranceClaimsRequest) updates) => super.copyWith((message) => updates(message as GetUserInsuranceClaimsRequest)) as GetUserInsuranceClaimsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetUserInsuranceClaimsRequest create() => GetUserInsuranceClaimsRequest._();
  GetUserInsuranceClaimsRequest createEmptyInstance() => create();
  static $pb.PbList<GetUserInsuranceClaimsRequest> createRepeated() => $pb.PbList<GetUserInsuranceClaimsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetUserInsuranceClaimsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetUserInsuranceClaimsRequest>(create);
  static GetUserInsuranceClaimsRequest? _defaultInstance;

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

class GetUserInsuranceClaimsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetUserInsuranceClaimsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..pc<InsuranceClaimRecord>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'claims', $pb.PbFieldType.PM, subBuilder: InsuranceClaimRecord.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetUserInsuranceClaimsResponse._() : super();
  factory GetUserInsuranceClaimsResponse({
    $core.Iterable<InsuranceClaimRecord>? claims,
    $core.int? total,
  }) {
    final _result = create();
    if (claims != null) {
      _result.claims.addAll(claims);
    }
    if (total != null) {
      _result.total = total;
    }
    return _result;
  }
  factory GetUserInsuranceClaimsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUserInsuranceClaimsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUserInsuranceClaimsResponse clone() => GetUserInsuranceClaimsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUserInsuranceClaimsResponse copyWith(void Function(GetUserInsuranceClaimsResponse) updates) => super.copyWith((message) => updates(message as GetUserInsuranceClaimsResponse)) as GetUserInsuranceClaimsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetUserInsuranceClaimsResponse create() => GetUserInsuranceClaimsResponse._();
  GetUserInsuranceClaimsResponse createEmptyInstance() => create();
  static $pb.PbList<GetUserInsuranceClaimsResponse> createRepeated() => $pb.PbList<GetUserInsuranceClaimsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetUserInsuranceClaimsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetUserInsuranceClaimsResponse>(create);
  static GetUserInsuranceClaimsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<InsuranceClaimRecord> get claims => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => clearField(2);
}

class UpdateInsuranceClaimRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateInsuranceClaimRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'claimId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'title')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..pPS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'documents')
    ..m<$core.String, $core.String>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'additionalInfo', entryClassName: 'UpdateInsuranceClaimRequest.AdditionalInfoEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('financialproducts'))
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..pPS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'attachments')
    ..hasRequiredFields = false
  ;

  UpdateInsuranceClaimRequest._() : super();
  factory UpdateInsuranceClaimRequest({
    $core.String? claimId,
    $core.String? title,
    $core.String? description,
    $core.Iterable<$core.String>? documents,
    $core.Map<$core.String, $core.String>? additionalInfo,
    $core.String? status,
    $core.Iterable<$core.String>? attachments,
  }) {
    final _result = create();
    if (claimId != null) {
      _result.claimId = claimId;
    }
    if (title != null) {
      _result.title = title;
    }
    if (description != null) {
      _result.description = description;
    }
    if (documents != null) {
      _result.documents.addAll(documents);
    }
    if (additionalInfo != null) {
      _result.additionalInfo.addAll(additionalInfo);
    }
    if (status != null) {
      _result.status = status;
    }
    if (attachments != null) {
      _result.attachments.addAll(attachments);
    }
    return _result;
  }
  factory UpdateInsuranceClaimRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateInsuranceClaimRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateInsuranceClaimRequest clone() => UpdateInsuranceClaimRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateInsuranceClaimRequest copyWith(void Function(UpdateInsuranceClaimRequest) updates) => super.copyWith((message) => updates(message as UpdateInsuranceClaimRequest)) as UpdateInsuranceClaimRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UpdateInsuranceClaimRequest create() => UpdateInsuranceClaimRequest._();
  UpdateInsuranceClaimRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateInsuranceClaimRequest> createRepeated() => $pb.PbList<UpdateInsuranceClaimRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateInsuranceClaimRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateInsuranceClaimRequest>(create);
  static UpdateInsuranceClaimRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get claimId => $_getSZ(0);
  @$pb.TagNumber(1)
  set claimId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasClaimId() => $_has(0);
  @$pb.TagNumber(1)
  void clearClaimId() => clearField(1);

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
  $core.List<$core.String> get documents => $_getList(3);

  @$pb.TagNumber(5)
  $core.Map<$core.String, $core.String> get additionalInfo => $_getMap(4);

  @$pb.TagNumber(6)
  $core.String get status => $_getSZ(5);
  @$pb.TagNumber(6)
  set status($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasStatus() => $_has(5);
  @$pb.TagNumber(6)
  void clearStatus() => clearField(6);

  @$pb.TagNumber(7)
  $core.List<$core.String> get attachments => $_getList(6);
}

class UpdateInsuranceClaimResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateInsuranceClaimResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOM<InsuranceClaimRecord>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'claim', subBuilder: InsuranceClaimRecord.create)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  UpdateInsuranceClaimResponse._() : super();
  factory UpdateInsuranceClaimResponse({
    InsuranceClaimRecord? claim,
    $core.String? message,
  }) {
    final _result = create();
    if (claim != null) {
      _result.claim = claim;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory UpdateInsuranceClaimResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateInsuranceClaimResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateInsuranceClaimResponse clone() => UpdateInsuranceClaimResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateInsuranceClaimResponse copyWith(void Function(UpdateInsuranceClaimResponse) updates) => super.copyWith((message) => updates(message as UpdateInsuranceClaimResponse)) as UpdateInsuranceClaimResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UpdateInsuranceClaimResponse create() => UpdateInsuranceClaimResponse._();
  UpdateInsuranceClaimResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateInsuranceClaimResponse> createRepeated() => $pb.PbList<UpdateInsuranceClaimResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateInsuranceClaimResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateInsuranceClaimResponse>(create);
  static UpdateInsuranceClaimResponse? _defaultInstance;

  @$pb.TagNumber(1)
  InsuranceClaimRecord get claim => $_getN(0);
  @$pb.TagNumber(1)
  set claim(InsuranceClaimRecord v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasClaim() => $_has(0);
  @$pb.TagNumber(1)
  void clearClaim() => clearField(1);
  @$pb.TagNumber(1)
  InsuranceClaimRecord ensureClaim() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

class GetInsuranceClaimByIdRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInsuranceClaimByIdRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'claimId')
    ..hasRequiredFields = false
  ;

  GetInsuranceClaimByIdRequest._() : super();
  factory GetInsuranceClaimByIdRequest({
    $core.String? claimId,
  }) {
    final _result = create();
    if (claimId != null) {
      _result.claimId = claimId;
    }
    return _result;
  }
  factory GetInsuranceClaimByIdRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInsuranceClaimByIdRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInsuranceClaimByIdRequest clone() => GetInsuranceClaimByIdRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInsuranceClaimByIdRequest copyWith(void Function(GetInsuranceClaimByIdRequest) updates) => super.copyWith((message) => updates(message as GetInsuranceClaimByIdRequest)) as GetInsuranceClaimByIdRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetInsuranceClaimByIdRequest create() => GetInsuranceClaimByIdRequest._();
  GetInsuranceClaimByIdRequest createEmptyInstance() => create();
  static $pb.PbList<GetInsuranceClaimByIdRequest> createRepeated() => $pb.PbList<GetInsuranceClaimByIdRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInsuranceClaimByIdRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInsuranceClaimByIdRequest>(create);
  static GetInsuranceClaimByIdRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get claimId => $_getSZ(0);
  @$pb.TagNumber(1)
  set claimId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasClaimId() => $_has(0);
  @$pb.TagNumber(1)
  void clearClaimId() => clearField(1);
}

class GetInsuranceClaimByIdResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInsuranceClaimByIdResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOM<InsuranceClaimRecord>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'claim', subBuilder: InsuranceClaimRecord.create)
    ..hasRequiredFields = false
  ;

  GetInsuranceClaimByIdResponse._() : super();
  factory GetInsuranceClaimByIdResponse({
    InsuranceClaimRecord? claim,
  }) {
    final _result = create();
    if (claim != null) {
      _result.claim = claim;
    }
    return _result;
  }
  factory GetInsuranceClaimByIdResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInsuranceClaimByIdResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInsuranceClaimByIdResponse clone() => GetInsuranceClaimByIdResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInsuranceClaimByIdResponse copyWith(void Function(GetInsuranceClaimByIdResponse) updates) => super.copyWith((message) => updates(message as GetInsuranceClaimByIdResponse)) as GetInsuranceClaimByIdResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetInsuranceClaimByIdResponse create() => GetInsuranceClaimByIdResponse._();
  GetInsuranceClaimByIdResponse createEmptyInstance() => create();
  static $pb.PbList<GetInsuranceClaimByIdResponse> createRepeated() => $pb.PbList<GetInsuranceClaimByIdResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInsuranceClaimByIdResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInsuranceClaimByIdResponse>(create);
  static GetInsuranceClaimByIdResponse? _defaultInstance;

  @$pb.TagNumber(1)
  InsuranceClaimRecord get claim => $_getN(0);
  @$pb.TagNumber(1)
  set claim(InsuranceClaimRecord v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasClaim() => $_has(0);
  @$pb.TagNumber(1)
  void clearClaim() => clearField(1);
  @$pb.TagNumber(1)
  InsuranceClaimRecord ensureClaim() => $_ensure(0);
}

class UpdateInsurancePolicyRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateInsurancePolicyRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'policyId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'beneficiary')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'paymentFrequency')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'metadata')
    ..hasRequiredFields = false
  ;

  UpdateInsurancePolicyRequest._() : super();
  factory UpdateInsurancePolicyRequest({
    $core.String? policyId,
    $core.String? beneficiary,
    $core.String? paymentFrequency,
    $core.String? metadata,
  }) {
    final _result = create();
    if (policyId != null) {
      _result.policyId = policyId;
    }
    if (beneficiary != null) {
      _result.beneficiary = beneficiary;
    }
    if (paymentFrequency != null) {
      _result.paymentFrequency = paymentFrequency;
    }
    if (metadata != null) {
      _result.metadata = metadata;
    }
    return _result;
  }
  factory UpdateInsurancePolicyRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateInsurancePolicyRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateInsurancePolicyRequest clone() => UpdateInsurancePolicyRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateInsurancePolicyRequest copyWith(void Function(UpdateInsurancePolicyRequest) updates) => super.copyWith((message) => updates(message as UpdateInsurancePolicyRequest)) as UpdateInsurancePolicyRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UpdateInsurancePolicyRequest create() => UpdateInsurancePolicyRequest._();
  UpdateInsurancePolicyRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateInsurancePolicyRequest> createRepeated() => $pb.PbList<UpdateInsurancePolicyRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateInsurancePolicyRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateInsurancePolicyRequest>(create);
  static UpdateInsurancePolicyRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get policyId => $_getSZ(0);
  @$pb.TagNumber(1)
  set policyId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPolicyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPolicyId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get beneficiary => $_getSZ(1);
  @$pb.TagNumber(2)
  set beneficiary($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasBeneficiary() => $_has(1);
  @$pb.TagNumber(2)
  void clearBeneficiary() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get paymentFrequency => $_getSZ(2);
  @$pb.TagNumber(3)
  set paymentFrequency($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPaymentFrequency() => $_has(2);
  @$pb.TagNumber(3)
  void clearPaymentFrequency() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get metadata => $_getSZ(3);
  @$pb.TagNumber(4)
  set metadata($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasMetadata() => $_has(3);
  @$pb.TagNumber(4)
  void clearMetadata() => clearField(4);
}

class UpdateInsurancePolicyResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateInsurancePolicyResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOM<Insurance>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'insurance', subBuilder: Insurance.create)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  UpdateInsurancePolicyResponse._() : super();
  factory UpdateInsurancePolicyResponse({
    Insurance? insurance,
    $core.String? message,
  }) {
    final _result = create();
    if (insurance != null) {
      _result.insurance = insurance;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory UpdateInsurancePolicyResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateInsurancePolicyResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateInsurancePolicyResponse clone() => UpdateInsurancePolicyResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateInsurancePolicyResponse copyWith(void Function(UpdateInsurancePolicyResponse) updates) => super.copyWith((message) => updates(message as UpdateInsurancePolicyResponse)) as UpdateInsurancePolicyResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UpdateInsurancePolicyResponse create() => UpdateInsurancePolicyResponse._();
  UpdateInsurancePolicyResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateInsurancePolicyResponse> createRepeated() => $pb.PbList<UpdateInsurancePolicyResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateInsurancePolicyResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateInsurancePolicyResponse>(create);
  static UpdateInsurancePolicyResponse? _defaultInstance;

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

class GenerateInsuranceReceiptRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GenerateInsuranceReceiptRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'paymentId')
    ..hasRequiredFields = false
  ;

  GenerateInsuranceReceiptRequest._() : super();
  factory GenerateInsuranceReceiptRequest({
    $core.String? paymentId,
  }) {
    final _result = create();
    if (paymentId != null) {
      _result.paymentId = paymentId;
    }
    return _result;
  }
  factory GenerateInsuranceReceiptRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GenerateInsuranceReceiptRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GenerateInsuranceReceiptRequest clone() => GenerateInsuranceReceiptRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GenerateInsuranceReceiptRequest copyWith(void Function(GenerateInsuranceReceiptRequest) updates) => super.copyWith((message) => updates(message as GenerateInsuranceReceiptRequest)) as GenerateInsuranceReceiptRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GenerateInsuranceReceiptRequest create() => GenerateInsuranceReceiptRequest._();
  GenerateInsuranceReceiptRequest createEmptyInstance() => create();
  static $pb.PbList<GenerateInsuranceReceiptRequest> createRepeated() => $pb.PbList<GenerateInsuranceReceiptRequest>();
  @$core.pragma('dart2js:noInline')
  static GenerateInsuranceReceiptRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GenerateInsuranceReceiptRequest>(create);
  static GenerateInsuranceReceiptRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get paymentId => $_getSZ(0);
  @$pb.TagNumber(1)
  set paymentId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPaymentId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPaymentId() => clearField(1);
}

class GenerateInsuranceReceiptResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GenerateInsuranceReceiptResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'receiptId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'receiptNumber')
    ..aOM<InsurancePaymentRecord>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payment', subBuilder: InsurancePaymentRecord.create)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'policyNumber')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'policyType')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  GenerateInsuranceReceiptResponse._() : super();
  factory GenerateInsuranceReceiptResponse({
    $core.String? receiptId,
    $core.String? receiptNumber,
    InsurancePaymentRecord? payment,
    $core.String? policyNumber,
    $core.String? policyType,
    $core.String? message,
  }) {
    final _result = create();
    if (receiptId != null) {
      _result.receiptId = receiptId;
    }
    if (receiptNumber != null) {
      _result.receiptNumber = receiptNumber;
    }
    if (payment != null) {
      _result.payment = payment;
    }
    if (policyNumber != null) {
      _result.policyNumber = policyNumber;
    }
    if (policyType != null) {
      _result.policyType = policyType;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory GenerateInsuranceReceiptResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GenerateInsuranceReceiptResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GenerateInsuranceReceiptResponse clone() => GenerateInsuranceReceiptResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GenerateInsuranceReceiptResponse copyWith(void Function(GenerateInsuranceReceiptResponse) updates) => super.copyWith((message) => updates(message as GenerateInsuranceReceiptResponse)) as GenerateInsuranceReceiptResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GenerateInsuranceReceiptResponse create() => GenerateInsuranceReceiptResponse._();
  GenerateInsuranceReceiptResponse createEmptyInstance() => create();
  static $pb.PbList<GenerateInsuranceReceiptResponse> createRepeated() => $pb.PbList<GenerateInsuranceReceiptResponse>();
  @$core.pragma('dart2js:noInline')
  static GenerateInsuranceReceiptResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GenerateInsuranceReceiptResponse>(create);
  static GenerateInsuranceReceiptResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get receiptId => $_getSZ(0);
  @$pb.TagNumber(1)
  set receiptId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasReceiptId() => $_has(0);
  @$pb.TagNumber(1)
  void clearReceiptId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get receiptNumber => $_getSZ(1);
  @$pb.TagNumber(2)
  set receiptNumber($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasReceiptNumber() => $_has(1);
  @$pb.TagNumber(2)
  void clearReceiptNumber() => clearField(2);

  @$pb.TagNumber(3)
  InsurancePaymentRecord get payment => $_getN(2);
  @$pb.TagNumber(3)
  set payment(InsurancePaymentRecord v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasPayment() => $_has(2);
  @$pb.TagNumber(3)
  void clearPayment() => clearField(3);
  @$pb.TagNumber(3)
  InsurancePaymentRecord ensurePayment() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.String get policyNumber => $_getSZ(3);
  @$pb.TagNumber(4)
  set policyNumber($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPolicyNumber() => $_has(3);
  @$pb.TagNumber(4)
  void clearPolicyNumber() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get policyType => $_getSZ(4);
  @$pb.TagNumber(5)
  set policyType($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasPolicyType() => $_has(4);
  @$pb.TagNumber(5)
  void clearPolicyType() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get message => $_getSZ(5);
  @$pb.TagNumber(6)
  set message($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasMessage() => $_has(5);
  @$pb.TagNumber(6)
  void clearMessage() => clearField(6);
}

class GetUserInsuranceReceiptsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetUserInsuranceReceiptsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetUserInsuranceReceiptsRequest._() : super();
  factory GetUserInsuranceReceiptsRequest({
    $core.int? limit,
    $core.int? offset,
  }) {
    final _result = create();
    if (limit != null) {
      _result.limit = limit;
    }
    if (offset != null) {
      _result.offset = offset;
    }
    return _result;
  }
  factory GetUserInsuranceReceiptsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUserInsuranceReceiptsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUserInsuranceReceiptsRequest clone() => GetUserInsuranceReceiptsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUserInsuranceReceiptsRequest copyWith(void Function(GetUserInsuranceReceiptsRequest) updates) => super.copyWith((message) => updates(message as GetUserInsuranceReceiptsRequest)) as GetUserInsuranceReceiptsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetUserInsuranceReceiptsRequest create() => GetUserInsuranceReceiptsRequest._();
  GetUserInsuranceReceiptsRequest createEmptyInstance() => create();
  static $pb.PbList<GetUserInsuranceReceiptsRequest> createRepeated() => $pb.PbList<GetUserInsuranceReceiptsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetUserInsuranceReceiptsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetUserInsuranceReceiptsRequest>(create);
  static GetUserInsuranceReceiptsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get limit => $_getIZ(0);
  @$pb.TagNumber(1)
  set limit($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLimit() => $_has(0);
  @$pb.TagNumber(1)
  void clearLimit() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get offset => $_getIZ(1);
  @$pb.TagNumber(2)
  set offset($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasOffset() => $_has(1);
  @$pb.TagNumber(2)
  void clearOffset() => clearField(2);
}

class GetUserInsuranceReceiptsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetUserInsuranceReceiptsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..pc<InsurancePaymentRecord>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'receipts', $pb.PbFieldType.PM, subBuilder: InsurancePaymentRecord.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetUserInsuranceReceiptsResponse._() : super();
  factory GetUserInsuranceReceiptsResponse({
    $core.Iterable<InsurancePaymentRecord>? receipts,
    $core.int? total,
  }) {
    final _result = create();
    if (receipts != null) {
      _result.receipts.addAll(receipts);
    }
    if (total != null) {
      _result.total = total;
    }
    return _result;
  }
  factory GetUserInsuranceReceiptsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUserInsuranceReceiptsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUserInsuranceReceiptsResponse clone() => GetUserInsuranceReceiptsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUserInsuranceReceiptsResponse copyWith(void Function(GetUserInsuranceReceiptsResponse) updates) => super.copyWith((message) => updates(message as GetUserInsuranceReceiptsResponse)) as GetUserInsuranceReceiptsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetUserInsuranceReceiptsResponse create() => GetUserInsuranceReceiptsResponse._();
  GetUserInsuranceReceiptsResponse createEmptyInstance() => create();
  static $pb.PbList<GetUserInsuranceReceiptsResponse> createRepeated() => $pb.PbList<GetUserInsuranceReceiptsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetUserInsuranceReceiptsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetUserInsuranceReceiptsResponse>(create);
  static GetUserInsuranceReceiptsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<InsurancePaymentRecord> get receipts => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => clearField(2);
}

class GetInsuranceStatisticsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInsuranceStatisticsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GetInsuranceStatisticsRequest._() : super();
  factory GetInsuranceStatisticsRequest() => create();
  factory GetInsuranceStatisticsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInsuranceStatisticsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInsuranceStatisticsRequest clone() => GetInsuranceStatisticsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInsuranceStatisticsRequest copyWith(void Function(GetInsuranceStatisticsRequest) updates) => super.copyWith((message) => updates(message as GetInsuranceStatisticsRequest)) as GetInsuranceStatisticsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetInsuranceStatisticsRequest create() => GetInsuranceStatisticsRequest._();
  GetInsuranceStatisticsRequest createEmptyInstance() => create();
  static $pb.PbList<GetInsuranceStatisticsRequest> createRepeated() => $pb.PbList<GetInsuranceStatisticsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInsuranceStatisticsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInsuranceStatisticsRequest>(create);
  static GetInsuranceStatisticsRequest? _defaultInstance;
}

class GetInsuranceStatisticsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInsuranceStatisticsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'activePolicies', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalPolicies', $pb.PbFieldType.O3)
    ..aInt64(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalCoverage')
    ..aInt64(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalPremiumsPaid')
    ..a<$core.int>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalClaims', $pb.PbFieldType.O3)
    ..a<$core.int>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pendingClaims', $pb.PbFieldType.O3)
    ..aInt64(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalClaimedAmount')
    ..aInt64(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalApprovedAmount')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'nextPaymentDue')
    ..m<$core.String, $core.int>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'policiesByType', entryClassName: 'GetInsuranceStatisticsResponse.PoliciesByTypeEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.O3, packageName: const $pb.PackageName('financialproducts'))
    ..hasRequiredFields = false
  ;

  GetInsuranceStatisticsResponse._() : super();
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
    $core.Map<$core.String, $core.int>? policiesByType,
  }) {
    final _result = create();
    if (activePolicies != null) {
      _result.activePolicies = activePolicies;
    }
    if (totalPolicies != null) {
      _result.totalPolicies = totalPolicies;
    }
    if (totalCoverage != null) {
      _result.totalCoverage = totalCoverage;
    }
    if (totalPremiumsPaid != null) {
      _result.totalPremiumsPaid = totalPremiumsPaid;
    }
    if (totalClaims != null) {
      _result.totalClaims = totalClaims;
    }
    if (pendingClaims != null) {
      _result.pendingClaims = pendingClaims;
    }
    if (totalClaimedAmount != null) {
      _result.totalClaimedAmount = totalClaimedAmount;
    }
    if (totalApprovedAmount != null) {
      _result.totalApprovedAmount = totalApprovedAmount;
    }
    if (nextPaymentDue != null) {
      _result.nextPaymentDue = nextPaymentDue;
    }
    if (policiesByType != null) {
      _result.policiesByType.addAll(policiesByType);
    }
    return _result;
  }
  factory GetInsuranceStatisticsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInsuranceStatisticsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInsuranceStatisticsResponse clone() => GetInsuranceStatisticsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInsuranceStatisticsResponse copyWith(void Function(GetInsuranceStatisticsResponse) updates) => super.copyWith((message) => updates(message as GetInsuranceStatisticsResponse)) as GetInsuranceStatisticsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetInsuranceStatisticsResponse create() => GetInsuranceStatisticsResponse._();
  GetInsuranceStatisticsResponse createEmptyInstance() => create();
  static $pb.PbList<GetInsuranceStatisticsResponse> createRepeated() => $pb.PbList<GetInsuranceStatisticsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInsuranceStatisticsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInsuranceStatisticsResponse>(create);
  static GetInsuranceStatisticsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get activePolicies => $_getIZ(0);
  @$pb.TagNumber(1)
  set activePolicies($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasActivePolicies() => $_has(0);
  @$pb.TagNumber(1)
  void clearActivePolicies() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get totalPolicies => $_getIZ(1);
  @$pb.TagNumber(2)
  set totalPolicies($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotalPolicies() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalPolicies() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get totalCoverage => $_getI64(2);
  @$pb.TagNumber(3)
  set totalCoverage($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTotalCoverage() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalCoverage() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get totalPremiumsPaid => $_getI64(3);
  @$pb.TagNumber(4)
  set totalPremiumsPaid($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTotalPremiumsPaid() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalPremiumsPaid() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get totalClaims => $_getIZ(4);
  @$pb.TagNumber(5)
  set totalClaims($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTotalClaims() => $_has(4);
  @$pb.TagNumber(5)
  void clearTotalClaims() => clearField(5);

  @$pb.TagNumber(6)
  $core.int get pendingClaims => $_getIZ(5);
  @$pb.TagNumber(6)
  set pendingClaims($core.int v) { $_setSignedInt32(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasPendingClaims() => $_has(5);
  @$pb.TagNumber(6)
  void clearPendingClaims() => clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get totalClaimedAmount => $_getI64(6);
  @$pb.TagNumber(7)
  set totalClaimedAmount($fixnum.Int64 v) { $_setInt64(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasTotalClaimedAmount() => $_has(6);
  @$pb.TagNumber(7)
  void clearTotalClaimedAmount() => clearField(7);

  @$pb.TagNumber(8)
  $fixnum.Int64 get totalApprovedAmount => $_getI64(7);
  @$pb.TagNumber(8)
  set totalApprovedAmount($fixnum.Int64 v) { $_setInt64(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasTotalApprovedAmount() => $_has(7);
  @$pb.TagNumber(8)
  void clearTotalApprovedAmount() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get nextPaymentDue => $_getSZ(8);
  @$pb.TagNumber(9)
  set nextPaymentDue($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasNextPaymentDue() => $_has(8);
  @$pb.TagNumber(9)
  void clearNextPaymentDue() => clearField(9);

  @$pb.TagNumber(10)
  $core.Map<$core.String, $core.int> get policiesByType => $_getMap(9);
}

class GetInsurancePaymentStatisticsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInsurancePaymentStatisticsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'startDate')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'endDate')
    ..hasRequiredFields = false
  ;

  GetInsurancePaymentStatisticsRequest._() : super();
  factory GetInsurancePaymentStatisticsRequest({
    $core.String? startDate,
    $core.String? endDate,
  }) {
    final _result = create();
    if (startDate != null) {
      _result.startDate = startDate;
    }
    if (endDate != null) {
      _result.endDate = endDate;
    }
    return _result;
  }
  factory GetInsurancePaymentStatisticsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInsurancePaymentStatisticsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInsurancePaymentStatisticsRequest clone() => GetInsurancePaymentStatisticsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInsurancePaymentStatisticsRequest copyWith(void Function(GetInsurancePaymentStatisticsRequest) updates) => super.copyWith((message) => updates(message as GetInsurancePaymentStatisticsRequest)) as GetInsurancePaymentStatisticsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetInsurancePaymentStatisticsRequest create() => GetInsurancePaymentStatisticsRequest._();
  GetInsurancePaymentStatisticsRequest createEmptyInstance() => create();
  static $pb.PbList<GetInsurancePaymentStatisticsRequest> createRepeated() => $pb.PbList<GetInsurancePaymentStatisticsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInsurancePaymentStatisticsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInsurancePaymentStatisticsRequest>(create);
  static GetInsurancePaymentStatisticsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get startDate => $_getSZ(0);
  @$pb.TagNumber(1)
  set startDate($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStartDate() => $_has(0);
  @$pb.TagNumber(1)
  void clearStartDate() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get endDate => $_getSZ(1);
  @$pb.TagNumber(2)
  set endDate($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasEndDate() => $_has(1);
  @$pb.TagNumber(2)
  void clearEndDate() => clearField(2);
}

class GetInsurancePaymentStatisticsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInsurancePaymentStatisticsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalPayments', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'completedPayments', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pendingPayments', $pb.PbFieldType.O3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'failedPayments', $pb.PbFieldType.O3)
    ..aInt64(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalAmount')
    ..aInt64(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'completedAmount')
    ..hasRequiredFields = false
  ;

  GetInsurancePaymentStatisticsResponse._() : super();
  factory GetInsurancePaymentStatisticsResponse({
    $core.int? totalPayments,
    $core.int? completedPayments,
    $core.int? pendingPayments,
    $core.int? failedPayments,
    $fixnum.Int64? totalAmount,
    $fixnum.Int64? completedAmount,
  }) {
    final _result = create();
    if (totalPayments != null) {
      _result.totalPayments = totalPayments;
    }
    if (completedPayments != null) {
      _result.completedPayments = completedPayments;
    }
    if (pendingPayments != null) {
      _result.pendingPayments = pendingPayments;
    }
    if (failedPayments != null) {
      _result.failedPayments = failedPayments;
    }
    if (totalAmount != null) {
      _result.totalAmount = totalAmount;
    }
    if (completedAmount != null) {
      _result.completedAmount = completedAmount;
    }
    return _result;
  }
  factory GetInsurancePaymentStatisticsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInsurancePaymentStatisticsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInsurancePaymentStatisticsResponse clone() => GetInsurancePaymentStatisticsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInsurancePaymentStatisticsResponse copyWith(void Function(GetInsurancePaymentStatisticsResponse) updates) => super.copyWith((message) => updates(message as GetInsurancePaymentStatisticsResponse)) as GetInsurancePaymentStatisticsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetInsurancePaymentStatisticsResponse create() => GetInsurancePaymentStatisticsResponse._();
  GetInsurancePaymentStatisticsResponse createEmptyInstance() => create();
  static $pb.PbList<GetInsurancePaymentStatisticsResponse> createRepeated() => $pb.PbList<GetInsurancePaymentStatisticsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInsurancePaymentStatisticsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInsurancePaymentStatisticsResponse>(create);
  static GetInsurancePaymentStatisticsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get totalPayments => $_getIZ(0);
  @$pb.TagNumber(1)
  set totalPayments($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTotalPayments() => $_has(0);
  @$pb.TagNumber(1)
  void clearTotalPayments() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get completedPayments => $_getIZ(1);
  @$pb.TagNumber(2)
  set completedPayments($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCompletedPayments() => $_has(1);
  @$pb.TagNumber(2)
  void clearCompletedPayments() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get pendingPayments => $_getIZ(2);
  @$pb.TagNumber(3)
  set pendingPayments($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPendingPayments() => $_has(2);
  @$pb.TagNumber(3)
  void clearPendingPayments() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get failedPayments => $_getIZ(3);
  @$pb.TagNumber(4)
  set failedPayments($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasFailedPayments() => $_has(3);
  @$pb.TagNumber(4)
  void clearFailedPayments() => clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get totalAmount => $_getI64(4);
  @$pb.TagNumber(5)
  set totalAmount($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTotalAmount() => $_has(4);
  @$pb.TagNumber(5)
  void clearTotalAmount() => clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get completedAmount => $_getI64(5);
  @$pb.TagNumber(6)
  set completedAmount($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasCompletedAmount() => $_has(5);
  @$pb.TagNumber(6)
  void clearCompletedAmount() => clearField(6);
}

class AutoSaveRule extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AutoSaveRule', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'triggerType')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amountType')
    ..a<$core.double>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amountValue', $pb.PbFieldType.OD)
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sourceAccountId')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'destinationAccountId')
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'frequency')
    ..aOS(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'scheduleTime')
    ..a<$core.int>(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'scheduleDay', $pb.PbFieldType.O3)
    ..a<$core.int>(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'roundUpTo', $pb.PbFieldType.O3)
    ..a<$core.double>(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'targetAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'minimumBalance', $pb.PbFieldType.OD)
    ..a<$core.double>(17, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'maximumPerSave', $pb.PbFieldType.OD)
    ..aOS(18, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt')
    ..aOS(19, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedAt')
    ..aOS(20, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lastTriggeredAt')
    ..a<$core.int>(21, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'triggerCount', $pb.PbFieldType.O3)
    ..a<$core.double>(22, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalSaved', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  AutoSaveRule._() : super();
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
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    if (name != null) {
      _result.name = name;
    }
    if (description != null) {
      _result.description = description;
    }
    if (triggerType != null) {
      _result.triggerType = triggerType;
    }
    if (amountType != null) {
      _result.amountType = amountType;
    }
    if (amountValue != null) {
      _result.amountValue = amountValue;
    }
    if (sourceAccountId != null) {
      _result.sourceAccountId = sourceAccountId;
    }
    if (destinationAccountId != null) {
      _result.destinationAccountId = destinationAccountId;
    }
    if (status != null) {
      _result.status = status;
    }
    if (frequency != null) {
      _result.frequency = frequency;
    }
    if (scheduleTime != null) {
      _result.scheduleTime = scheduleTime;
    }
    if (scheduleDay != null) {
      _result.scheduleDay = scheduleDay;
    }
    if (roundUpTo != null) {
      _result.roundUpTo = roundUpTo;
    }
    if (targetAmount != null) {
      _result.targetAmount = targetAmount;
    }
    if (minimumBalance != null) {
      _result.minimumBalance = minimumBalance;
    }
    if (maximumPerSave != null) {
      _result.maximumPerSave = maximumPerSave;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      _result.updatedAt = updatedAt;
    }
    if (lastTriggeredAt != null) {
      _result.lastTriggeredAt = lastTriggeredAt;
    }
    if (triggerCount != null) {
      _result.triggerCount = triggerCount;
    }
    if (totalSaved != null) {
      _result.totalSaved = totalSaved;
    }
    return _result;
  }
  factory AutoSaveRule.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AutoSaveRule.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AutoSaveRule clone() => AutoSaveRule()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AutoSaveRule copyWith(void Function(AutoSaveRule) updates) => super.copyWith((message) => updates(message as AutoSaveRule)) as AutoSaveRule; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AutoSaveRule create() => AutoSaveRule._();
  AutoSaveRule createEmptyInstance() => create();
  static $pb.PbList<AutoSaveRule> createRepeated() => $pb.PbList<AutoSaveRule>();
  @$core.pragma('dart2js:noInline')
  static AutoSaveRule getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AutoSaveRule>(create);
  static AutoSaveRule? _defaultInstance;

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
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(3)
  set name($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get description => $_getSZ(3);
  @$pb.TagNumber(4)
  set description($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasDescription() => $_has(3);
  @$pb.TagNumber(4)
  void clearDescription() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get triggerType => $_getSZ(4);
  @$pb.TagNumber(5)
  set triggerType($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTriggerType() => $_has(4);
  @$pb.TagNumber(5)
  void clearTriggerType() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get amountType => $_getSZ(5);
  @$pb.TagNumber(6)
  set amountType($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasAmountType() => $_has(5);
  @$pb.TagNumber(6)
  void clearAmountType() => clearField(6);

  @$pb.TagNumber(7)
  $core.double get amountValue => $_getN(6);
  @$pb.TagNumber(7)
  set amountValue($core.double v) { $_setDouble(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasAmountValue() => $_has(6);
  @$pb.TagNumber(7)
  void clearAmountValue() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get sourceAccountId => $_getSZ(7);
  @$pb.TagNumber(8)
  set sourceAccountId($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasSourceAccountId() => $_has(7);
  @$pb.TagNumber(8)
  void clearSourceAccountId() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get destinationAccountId => $_getSZ(8);
  @$pb.TagNumber(9)
  set destinationAccountId($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasDestinationAccountId() => $_has(8);
  @$pb.TagNumber(9)
  void clearDestinationAccountId() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get status => $_getSZ(9);
  @$pb.TagNumber(10)
  set status($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasStatus() => $_has(9);
  @$pb.TagNumber(10)
  void clearStatus() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get frequency => $_getSZ(10);
  @$pb.TagNumber(11)
  set frequency($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasFrequency() => $_has(10);
  @$pb.TagNumber(11)
  void clearFrequency() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get scheduleTime => $_getSZ(11);
  @$pb.TagNumber(12)
  set scheduleTime($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasScheduleTime() => $_has(11);
  @$pb.TagNumber(12)
  void clearScheduleTime() => clearField(12);

  @$pb.TagNumber(13)
  $core.int get scheduleDay => $_getIZ(12);
  @$pb.TagNumber(13)
  set scheduleDay($core.int v) { $_setSignedInt32(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasScheduleDay() => $_has(12);
  @$pb.TagNumber(13)
  void clearScheduleDay() => clearField(13);

  @$pb.TagNumber(14)
  $core.int get roundUpTo => $_getIZ(13);
  @$pb.TagNumber(14)
  set roundUpTo($core.int v) { $_setSignedInt32(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasRoundUpTo() => $_has(13);
  @$pb.TagNumber(14)
  void clearRoundUpTo() => clearField(14);

  @$pb.TagNumber(15)
  $core.double get targetAmount => $_getN(14);
  @$pb.TagNumber(15)
  set targetAmount($core.double v) { $_setDouble(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasTargetAmount() => $_has(14);
  @$pb.TagNumber(15)
  void clearTargetAmount() => clearField(15);

  @$pb.TagNumber(16)
  $core.double get minimumBalance => $_getN(15);
  @$pb.TagNumber(16)
  set minimumBalance($core.double v) { $_setDouble(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasMinimumBalance() => $_has(15);
  @$pb.TagNumber(16)
  void clearMinimumBalance() => clearField(16);

  @$pb.TagNumber(17)
  $core.double get maximumPerSave => $_getN(16);
  @$pb.TagNumber(17)
  set maximumPerSave($core.double v) { $_setDouble(16, v); }
  @$pb.TagNumber(17)
  $core.bool hasMaximumPerSave() => $_has(16);
  @$pb.TagNumber(17)
  void clearMaximumPerSave() => clearField(17);

  @$pb.TagNumber(18)
  $core.String get createdAt => $_getSZ(17);
  @$pb.TagNumber(18)
  set createdAt($core.String v) { $_setString(17, v); }
  @$pb.TagNumber(18)
  $core.bool hasCreatedAt() => $_has(17);
  @$pb.TagNumber(18)
  void clearCreatedAt() => clearField(18);

  @$pb.TagNumber(19)
  $core.String get updatedAt => $_getSZ(18);
  @$pb.TagNumber(19)
  set updatedAt($core.String v) { $_setString(18, v); }
  @$pb.TagNumber(19)
  $core.bool hasUpdatedAt() => $_has(18);
  @$pb.TagNumber(19)
  void clearUpdatedAt() => clearField(19);

  @$pb.TagNumber(20)
  $core.String get lastTriggeredAt => $_getSZ(19);
  @$pb.TagNumber(20)
  set lastTriggeredAt($core.String v) { $_setString(19, v); }
  @$pb.TagNumber(20)
  $core.bool hasLastTriggeredAt() => $_has(19);
  @$pb.TagNumber(20)
  void clearLastTriggeredAt() => clearField(20);

  @$pb.TagNumber(21)
  $core.int get triggerCount => $_getIZ(20);
  @$pb.TagNumber(21)
  set triggerCount($core.int v) { $_setSignedInt32(20, v); }
  @$pb.TagNumber(21)
  $core.bool hasTriggerCount() => $_has(20);
  @$pb.TagNumber(21)
  void clearTriggerCount() => clearField(21);

  @$pb.TagNumber(22)
  $core.double get totalSaved => $_getN(21);
  @$pb.TagNumber(22)
  set totalSaved($core.double v) { $_setDouble(21, v); }
  @$pb.TagNumber(22)
  $core.bool hasTotalSaved() => $_has(21);
  @$pb.TagNumber(22)
  void clearTotalSaved() => clearField(22);
}

class AutoSaveTransaction extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AutoSaveTransaction', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ruleId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sourceAccountId')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'destinationAccountId')
    ..a<$core.double>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'triggerType')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'triggerReason')
    ..aOB(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errorMessage')
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt')
    ..hasRequiredFields = false
  ;

  AutoSaveTransaction._() : super();
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
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (ruleId != null) {
      _result.ruleId = ruleId;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    if (sourceAccountId != null) {
      _result.sourceAccountId = sourceAccountId;
    }
    if (destinationAccountId != null) {
      _result.destinationAccountId = destinationAccountId;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (triggerType != null) {
      _result.triggerType = triggerType;
    }
    if (triggerReason != null) {
      _result.triggerReason = triggerReason;
    }
    if (success != null) {
      _result.success = success;
    }
    if (errorMessage != null) {
      _result.errorMessage = errorMessage;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    return _result;
  }
  factory AutoSaveTransaction.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AutoSaveTransaction.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AutoSaveTransaction clone() => AutoSaveTransaction()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AutoSaveTransaction copyWith(void Function(AutoSaveTransaction) updates) => super.copyWith((message) => updates(message as AutoSaveTransaction)) as AutoSaveTransaction; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AutoSaveTransaction create() => AutoSaveTransaction._();
  AutoSaveTransaction createEmptyInstance() => create();
  static $pb.PbList<AutoSaveTransaction> createRepeated() => $pb.PbList<AutoSaveTransaction>();
  @$core.pragma('dart2js:noInline')
  static AutoSaveTransaction getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AutoSaveTransaction>(create);
  static AutoSaveTransaction? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get ruleId => $_getSZ(1);
  @$pb.TagNumber(2)
  set ruleId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasRuleId() => $_has(1);
  @$pb.TagNumber(2)
  void clearRuleId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get userId => $_getSZ(2);
  @$pb.TagNumber(3)
  set userId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasUserId() => $_has(2);
  @$pb.TagNumber(3)
  void clearUserId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get sourceAccountId => $_getSZ(3);
  @$pb.TagNumber(4)
  set sourceAccountId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasSourceAccountId() => $_has(3);
  @$pb.TagNumber(4)
  void clearSourceAccountId() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get destinationAccountId => $_getSZ(4);
  @$pb.TagNumber(5)
  set destinationAccountId($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasDestinationAccountId() => $_has(4);
  @$pb.TagNumber(5)
  void clearDestinationAccountId() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get amount => $_getN(5);
  @$pb.TagNumber(6)
  set amount($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasAmount() => $_has(5);
  @$pb.TagNumber(6)
  void clearAmount() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get triggerType => $_getSZ(6);
  @$pb.TagNumber(7)
  set triggerType($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasTriggerType() => $_has(6);
  @$pb.TagNumber(7)
  void clearTriggerType() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get triggerReason => $_getSZ(7);
  @$pb.TagNumber(8)
  set triggerReason($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasTriggerReason() => $_has(7);
  @$pb.TagNumber(8)
  void clearTriggerReason() => clearField(8);

  @$pb.TagNumber(9)
  $core.bool get success => $_getBF(8);
  @$pb.TagNumber(9)
  set success($core.bool v) { $_setBool(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasSuccess() => $_has(8);
  @$pb.TagNumber(9)
  void clearSuccess() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get errorMessage => $_getSZ(9);
  @$pb.TagNumber(10)
  set errorMessage($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasErrorMessage() => $_has(9);
  @$pb.TagNumber(10)
  void clearErrorMessage() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get createdAt => $_getSZ(10);
  @$pb.TagNumber(11)
  set createdAt($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasCreatedAt() => $_has(10);
  @$pb.TagNumber(11)
  void clearCreatedAt() => clearField(11);
}

class AutoSaveStatistics extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AutoSaveStatistics', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'activeRulesCount', $pb.PbFieldType.O3)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalSavedAllTime', $pb.PbFieldType.OD)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalSavedThisMonth', $pb.PbFieldType.OD)
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalSavedThisWeek', $pb.PbFieldType.OD)
    ..a<$core.int>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalTransactions', $pb.PbFieldType.O3)
    ..a<$core.double>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'averageSaveAmount', $pb.PbFieldType.OD)
    ..aOM<AutoSaveRule>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'mostActiveRule', subBuilder: AutoSaveRule.create)
    ..hasRequiredFields = false
  ;

  AutoSaveStatistics._() : super();
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
    final _result = create();
    if (userId != null) {
      _result.userId = userId;
    }
    if (activeRulesCount != null) {
      _result.activeRulesCount = activeRulesCount;
    }
    if (totalSavedAllTime != null) {
      _result.totalSavedAllTime = totalSavedAllTime;
    }
    if (totalSavedThisMonth != null) {
      _result.totalSavedThisMonth = totalSavedThisMonth;
    }
    if (totalSavedThisWeek != null) {
      _result.totalSavedThisWeek = totalSavedThisWeek;
    }
    if (totalTransactions != null) {
      _result.totalTransactions = totalTransactions;
    }
    if (averageSaveAmount != null) {
      _result.averageSaveAmount = averageSaveAmount;
    }
    if (mostActiveRule != null) {
      _result.mostActiveRule = mostActiveRule;
    }
    return _result;
  }
  factory AutoSaveStatistics.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AutoSaveStatistics.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AutoSaveStatistics clone() => AutoSaveStatistics()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AutoSaveStatistics copyWith(void Function(AutoSaveStatistics) updates) => super.copyWith((message) => updates(message as AutoSaveStatistics)) as AutoSaveStatistics; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AutoSaveStatistics create() => AutoSaveStatistics._();
  AutoSaveStatistics createEmptyInstance() => create();
  static $pb.PbList<AutoSaveStatistics> createRepeated() => $pb.PbList<AutoSaveStatistics>();
  @$core.pragma('dart2js:noInline')
  static AutoSaveStatistics getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AutoSaveStatistics>(create);
  static AutoSaveStatistics? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get activeRulesCount => $_getIZ(1);
  @$pb.TagNumber(2)
  set activeRulesCount($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasActiveRulesCount() => $_has(1);
  @$pb.TagNumber(2)
  void clearActiveRulesCount() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get totalSavedAllTime => $_getN(2);
  @$pb.TagNumber(3)
  set totalSavedAllTime($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTotalSavedAllTime() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalSavedAllTime() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get totalSavedThisMonth => $_getN(3);
  @$pb.TagNumber(4)
  set totalSavedThisMonth($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTotalSavedThisMonth() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalSavedThisMonth() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get totalSavedThisWeek => $_getN(4);
  @$pb.TagNumber(5)
  set totalSavedThisWeek($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTotalSavedThisWeek() => $_has(4);
  @$pb.TagNumber(5)
  void clearTotalSavedThisWeek() => clearField(5);

  @$pb.TagNumber(6)
  $core.int get totalTransactions => $_getIZ(5);
  @$pb.TagNumber(6)
  set totalTransactions($core.int v) { $_setSignedInt32(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasTotalTransactions() => $_has(5);
  @$pb.TagNumber(6)
  void clearTotalTransactions() => clearField(6);

  @$pb.TagNumber(7)
  $core.double get averageSaveAmount => $_getN(6);
  @$pb.TagNumber(7)
  set averageSaveAmount($core.double v) { $_setDouble(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasAverageSaveAmount() => $_has(6);
  @$pb.TagNumber(7)
  void clearAverageSaveAmount() => clearField(7);

  @$pb.TagNumber(8)
  AutoSaveRule get mostActiveRule => $_getN(7);
  @$pb.TagNumber(8)
  set mostActiveRule(AutoSaveRule v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasMostActiveRule() => $_has(7);
  @$pb.TagNumber(8)
  void clearMostActiveRule() => clearField(8);
  @$pb.TagNumber(8)
  AutoSaveRule ensureMostActiveRule() => $_ensure(7);
}

class CreateAutoSaveRuleRequest2 extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateAutoSaveRuleRequest2', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'triggerType')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amountType')
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amountValue', $pb.PbFieldType.OD)
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sourceAccountId')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'destinationAccountId')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'frequency')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'scheduleTime')
    ..a<$core.int>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'scheduleDay', $pb.PbFieldType.O3)
    ..a<$core.int>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'roundUpTo', $pb.PbFieldType.O3)
    ..a<$core.double>(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'targetAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'minimumBalance', $pb.PbFieldType.OD)
    ..a<$core.double>(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'maximumPerSave', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  CreateAutoSaveRuleRequest2._() : super();
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
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    if (description != null) {
      _result.description = description;
    }
    if (triggerType != null) {
      _result.triggerType = triggerType;
    }
    if (amountType != null) {
      _result.amountType = amountType;
    }
    if (amountValue != null) {
      _result.amountValue = amountValue;
    }
    if (sourceAccountId != null) {
      _result.sourceAccountId = sourceAccountId;
    }
    if (destinationAccountId != null) {
      _result.destinationAccountId = destinationAccountId;
    }
    if (frequency != null) {
      _result.frequency = frequency;
    }
    if (scheduleTime != null) {
      _result.scheduleTime = scheduleTime;
    }
    if (scheduleDay != null) {
      _result.scheduleDay = scheduleDay;
    }
    if (roundUpTo != null) {
      _result.roundUpTo = roundUpTo;
    }
    if (targetAmount != null) {
      _result.targetAmount = targetAmount;
    }
    if (minimumBalance != null) {
      _result.minimumBalance = minimumBalance;
    }
    if (maximumPerSave != null) {
      _result.maximumPerSave = maximumPerSave;
    }
    return _result;
  }
  factory CreateAutoSaveRuleRequest2.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateAutoSaveRuleRequest2.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateAutoSaveRuleRequest2 clone() => CreateAutoSaveRuleRequest2()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateAutoSaveRuleRequest2 copyWith(void Function(CreateAutoSaveRuleRequest2) updates) => super.copyWith((message) => updates(message as CreateAutoSaveRuleRequest2)) as CreateAutoSaveRuleRequest2; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateAutoSaveRuleRequest2 create() => CreateAutoSaveRuleRequest2._();
  CreateAutoSaveRuleRequest2 createEmptyInstance() => create();
  static $pb.PbList<CreateAutoSaveRuleRequest2> createRepeated() => $pb.PbList<CreateAutoSaveRuleRequest2>();
  @$core.pragma('dart2js:noInline')
  static CreateAutoSaveRuleRequest2 getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateAutoSaveRuleRequest2>(create);
  static CreateAutoSaveRuleRequest2? _defaultInstance;

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

  @$pb.TagNumber(3)
  $core.String get triggerType => $_getSZ(2);
  @$pb.TagNumber(3)
  set triggerType($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTriggerType() => $_has(2);
  @$pb.TagNumber(3)
  void clearTriggerType() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get amountType => $_getSZ(3);
  @$pb.TagNumber(4)
  set amountType($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasAmountType() => $_has(3);
  @$pb.TagNumber(4)
  void clearAmountType() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get amountValue => $_getN(4);
  @$pb.TagNumber(5)
  set amountValue($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasAmountValue() => $_has(4);
  @$pb.TagNumber(5)
  void clearAmountValue() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get sourceAccountId => $_getSZ(5);
  @$pb.TagNumber(6)
  set sourceAccountId($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasSourceAccountId() => $_has(5);
  @$pb.TagNumber(6)
  void clearSourceAccountId() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get destinationAccountId => $_getSZ(6);
  @$pb.TagNumber(7)
  set destinationAccountId($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasDestinationAccountId() => $_has(6);
  @$pb.TagNumber(7)
  void clearDestinationAccountId() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get frequency => $_getSZ(7);
  @$pb.TagNumber(8)
  set frequency($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasFrequency() => $_has(7);
  @$pb.TagNumber(8)
  void clearFrequency() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get scheduleTime => $_getSZ(8);
  @$pb.TagNumber(9)
  set scheduleTime($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasScheduleTime() => $_has(8);
  @$pb.TagNumber(9)
  void clearScheduleTime() => clearField(9);

  @$pb.TagNumber(10)
  $core.int get scheduleDay => $_getIZ(9);
  @$pb.TagNumber(10)
  set scheduleDay($core.int v) { $_setSignedInt32(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasScheduleDay() => $_has(9);
  @$pb.TagNumber(10)
  void clearScheduleDay() => clearField(10);

  @$pb.TagNumber(11)
  $core.int get roundUpTo => $_getIZ(10);
  @$pb.TagNumber(11)
  set roundUpTo($core.int v) { $_setSignedInt32(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasRoundUpTo() => $_has(10);
  @$pb.TagNumber(11)
  void clearRoundUpTo() => clearField(11);

  @$pb.TagNumber(12)
  $core.double get targetAmount => $_getN(11);
  @$pb.TagNumber(12)
  set targetAmount($core.double v) { $_setDouble(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasTargetAmount() => $_has(11);
  @$pb.TagNumber(12)
  void clearTargetAmount() => clearField(12);

  @$pb.TagNumber(13)
  $core.double get minimumBalance => $_getN(12);
  @$pb.TagNumber(13)
  set minimumBalance($core.double v) { $_setDouble(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasMinimumBalance() => $_has(12);
  @$pb.TagNumber(13)
  void clearMinimumBalance() => clearField(13);

  @$pb.TagNumber(14)
  $core.double get maximumPerSave => $_getN(13);
  @$pb.TagNumber(14)
  set maximumPerSave($core.double v) { $_setDouble(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasMaximumPerSave() => $_has(13);
  @$pb.TagNumber(14)
  void clearMaximumPerSave() => clearField(14);
}

class CreateAutoSaveRuleResponse2 extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateAutoSaveRuleResponse2', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOM<AutoSaveRule>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'rule', subBuilder: AutoSaveRule.create)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  CreateAutoSaveRuleResponse2._() : super();
  factory CreateAutoSaveRuleResponse2({
    AutoSaveRule? rule,
    $core.String? message,
  }) {
    final _result = create();
    if (rule != null) {
      _result.rule = rule;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory CreateAutoSaveRuleResponse2.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateAutoSaveRuleResponse2.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateAutoSaveRuleResponse2 clone() => CreateAutoSaveRuleResponse2()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateAutoSaveRuleResponse2 copyWith(void Function(CreateAutoSaveRuleResponse2) updates) => super.copyWith((message) => updates(message as CreateAutoSaveRuleResponse2)) as CreateAutoSaveRuleResponse2; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateAutoSaveRuleResponse2 create() => CreateAutoSaveRuleResponse2._();
  CreateAutoSaveRuleResponse2 createEmptyInstance() => create();
  static $pb.PbList<CreateAutoSaveRuleResponse2> createRepeated() => $pb.PbList<CreateAutoSaveRuleResponse2>();
  @$core.pragma('dart2js:noInline')
  static CreateAutoSaveRuleResponse2 getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateAutoSaveRuleResponse2>(create);
  static CreateAutoSaveRuleResponse2? _defaultInstance;

  @$pb.TagNumber(1)
  AutoSaveRule get rule => $_getN(0);
  @$pb.TagNumber(1)
  set rule(AutoSaveRule v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasRule() => $_has(0);
  @$pb.TagNumber(1)
  void clearRule() => clearField(1);
  @$pb.TagNumber(1)
  AutoSaveRule ensureRule() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

class GetAutoSaveRulesRequest2 extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetAutoSaveRulesRequest2', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..hasRequiredFields = false
  ;

  GetAutoSaveRulesRequest2._() : super();
  factory GetAutoSaveRulesRequest2({
    $core.String? accountId,
    $core.String? status,
  }) {
    final _result = create();
    if (accountId != null) {
      _result.accountId = accountId;
    }
    if (status != null) {
      _result.status = status;
    }
    return _result;
  }
  factory GetAutoSaveRulesRequest2.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAutoSaveRulesRequest2.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAutoSaveRulesRequest2 clone() => GetAutoSaveRulesRequest2()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAutoSaveRulesRequest2 copyWith(void Function(GetAutoSaveRulesRequest2) updates) => super.copyWith((message) => updates(message as GetAutoSaveRulesRequest2)) as GetAutoSaveRulesRequest2; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetAutoSaveRulesRequest2 create() => GetAutoSaveRulesRequest2._();
  GetAutoSaveRulesRequest2 createEmptyInstance() => create();
  static $pb.PbList<GetAutoSaveRulesRequest2> createRepeated() => $pb.PbList<GetAutoSaveRulesRequest2>();
  @$core.pragma('dart2js:noInline')
  static GetAutoSaveRulesRequest2 getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAutoSaveRulesRequest2>(create);
  static GetAutoSaveRulesRequest2? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get status => $_getSZ(1);
  @$pb.TagNumber(2)
  set status($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => clearField(2);
}

class GetAutoSaveRulesResponse2 extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetAutoSaveRulesResponse2', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..pc<AutoSaveRule>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'rules', $pb.PbFieldType.PM, subBuilder: AutoSaveRule.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetAutoSaveRulesResponse2._() : super();
  factory GetAutoSaveRulesResponse2({
    $core.Iterable<AutoSaveRule>? rules,
    $core.int? total,
  }) {
    final _result = create();
    if (rules != null) {
      _result.rules.addAll(rules);
    }
    if (total != null) {
      _result.total = total;
    }
    return _result;
  }
  factory GetAutoSaveRulesResponse2.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAutoSaveRulesResponse2.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAutoSaveRulesResponse2 clone() => GetAutoSaveRulesResponse2()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAutoSaveRulesResponse2 copyWith(void Function(GetAutoSaveRulesResponse2) updates) => super.copyWith((message) => updates(message as GetAutoSaveRulesResponse2)) as GetAutoSaveRulesResponse2; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetAutoSaveRulesResponse2 create() => GetAutoSaveRulesResponse2._();
  GetAutoSaveRulesResponse2 createEmptyInstance() => create();
  static $pb.PbList<GetAutoSaveRulesResponse2> createRepeated() => $pb.PbList<GetAutoSaveRulesResponse2>();
  @$core.pragma('dart2js:noInline')
  static GetAutoSaveRulesResponse2 getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAutoSaveRulesResponse2>(create);
  static GetAutoSaveRulesResponse2? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<AutoSaveRule> get rules => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => clearField(2);
}

class UpdateAutoSaveRuleRequest2 extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateAutoSaveRuleRequest2', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ruleId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amountType')
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amountValue', $pb.PbFieldType.OD)
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'frequency')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'scheduleTime')
    ..a<$core.int>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'scheduleDay', $pb.PbFieldType.O3)
    ..a<$core.int>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'roundUpTo', $pb.PbFieldType.O3)
    ..a<$core.double>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'targetAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'minimumBalance', $pb.PbFieldType.OD)
    ..a<$core.double>(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'maximumPerSave', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  UpdateAutoSaveRuleRequest2._() : super();
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
    final _result = create();
    if (ruleId != null) {
      _result.ruleId = ruleId;
    }
    if (name != null) {
      _result.name = name;
    }
    if (description != null) {
      _result.description = description;
    }
    if (amountType != null) {
      _result.amountType = amountType;
    }
    if (amountValue != null) {
      _result.amountValue = amountValue;
    }
    if (frequency != null) {
      _result.frequency = frequency;
    }
    if (scheduleTime != null) {
      _result.scheduleTime = scheduleTime;
    }
    if (scheduleDay != null) {
      _result.scheduleDay = scheduleDay;
    }
    if (roundUpTo != null) {
      _result.roundUpTo = roundUpTo;
    }
    if (targetAmount != null) {
      _result.targetAmount = targetAmount;
    }
    if (minimumBalance != null) {
      _result.minimumBalance = minimumBalance;
    }
    if (maximumPerSave != null) {
      _result.maximumPerSave = maximumPerSave;
    }
    return _result;
  }
  factory UpdateAutoSaveRuleRequest2.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateAutoSaveRuleRequest2.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateAutoSaveRuleRequest2 clone() => UpdateAutoSaveRuleRequest2()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateAutoSaveRuleRequest2 copyWith(void Function(UpdateAutoSaveRuleRequest2) updates) => super.copyWith((message) => updates(message as UpdateAutoSaveRuleRequest2)) as UpdateAutoSaveRuleRequest2; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UpdateAutoSaveRuleRequest2 create() => UpdateAutoSaveRuleRequest2._();
  UpdateAutoSaveRuleRequest2 createEmptyInstance() => create();
  static $pb.PbList<UpdateAutoSaveRuleRequest2> createRepeated() => $pb.PbList<UpdateAutoSaveRuleRequest2>();
  @$core.pragma('dart2js:noInline')
  static UpdateAutoSaveRuleRequest2 getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateAutoSaveRuleRequest2>(create);
  static UpdateAutoSaveRuleRequest2? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get ruleId => $_getSZ(0);
  @$pb.TagNumber(1)
  set ruleId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRuleId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRuleId() => clearField(1);

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
  $core.String get amountType => $_getSZ(3);
  @$pb.TagNumber(4)
  set amountType($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasAmountType() => $_has(3);
  @$pb.TagNumber(4)
  void clearAmountType() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get amountValue => $_getN(4);
  @$pb.TagNumber(5)
  set amountValue($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasAmountValue() => $_has(4);
  @$pb.TagNumber(5)
  void clearAmountValue() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get frequency => $_getSZ(5);
  @$pb.TagNumber(6)
  set frequency($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasFrequency() => $_has(5);
  @$pb.TagNumber(6)
  void clearFrequency() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get scheduleTime => $_getSZ(6);
  @$pb.TagNumber(7)
  set scheduleTime($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasScheduleTime() => $_has(6);
  @$pb.TagNumber(7)
  void clearScheduleTime() => clearField(7);

  @$pb.TagNumber(8)
  $core.int get scheduleDay => $_getIZ(7);
  @$pb.TagNumber(8)
  set scheduleDay($core.int v) { $_setSignedInt32(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasScheduleDay() => $_has(7);
  @$pb.TagNumber(8)
  void clearScheduleDay() => clearField(8);

  @$pb.TagNumber(9)
  $core.int get roundUpTo => $_getIZ(8);
  @$pb.TagNumber(9)
  set roundUpTo($core.int v) { $_setSignedInt32(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasRoundUpTo() => $_has(8);
  @$pb.TagNumber(9)
  void clearRoundUpTo() => clearField(9);

  @$pb.TagNumber(10)
  $core.double get targetAmount => $_getN(9);
  @$pb.TagNumber(10)
  set targetAmount($core.double v) { $_setDouble(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasTargetAmount() => $_has(9);
  @$pb.TagNumber(10)
  void clearTargetAmount() => clearField(10);

  @$pb.TagNumber(11)
  $core.double get minimumBalance => $_getN(10);
  @$pb.TagNumber(11)
  set minimumBalance($core.double v) { $_setDouble(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasMinimumBalance() => $_has(10);
  @$pb.TagNumber(11)
  void clearMinimumBalance() => clearField(11);

  @$pb.TagNumber(12)
  $core.double get maximumPerSave => $_getN(11);
  @$pb.TagNumber(12)
  set maximumPerSave($core.double v) { $_setDouble(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasMaximumPerSave() => $_has(11);
  @$pb.TagNumber(12)
  void clearMaximumPerSave() => clearField(12);
}

class UpdateAutoSaveRuleResponse2 extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateAutoSaveRuleResponse2', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOM<AutoSaveRule>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'rule', subBuilder: AutoSaveRule.create)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  UpdateAutoSaveRuleResponse2._() : super();
  factory UpdateAutoSaveRuleResponse2({
    AutoSaveRule? rule,
    $core.String? message,
  }) {
    final _result = create();
    if (rule != null) {
      _result.rule = rule;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory UpdateAutoSaveRuleResponse2.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateAutoSaveRuleResponse2.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateAutoSaveRuleResponse2 clone() => UpdateAutoSaveRuleResponse2()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateAutoSaveRuleResponse2 copyWith(void Function(UpdateAutoSaveRuleResponse2) updates) => super.copyWith((message) => updates(message as UpdateAutoSaveRuleResponse2)) as UpdateAutoSaveRuleResponse2; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UpdateAutoSaveRuleResponse2 create() => UpdateAutoSaveRuleResponse2._();
  UpdateAutoSaveRuleResponse2 createEmptyInstance() => create();
  static $pb.PbList<UpdateAutoSaveRuleResponse2> createRepeated() => $pb.PbList<UpdateAutoSaveRuleResponse2>();
  @$core.pragma('dart2js:noInline')
  static UpdateAutoSaveRuleResponse2 getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateAutoSaveRuleResponse2>(create);
  static UpdateAutoSaveRuleResponse2? _defaultInstance;

  @$pb.TagNumber(1)
  AutoSaveRule get rule => $_getN(0);
  @$pb.TagNumber(1)
  set rule(AutoSaveRule v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasRule() => $_has(0);
  @$pb.TagNumber(1)
  void clearRule() => clearField(1);
  @$pb.TagNumber(1)
  AutoSaveRule ensureRule() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

class ToggleAutoSaveRuleRequest2 extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ToggleAutoSaveRuleRequest2', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ruleId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'action')
    ..hasRequiredFields = false
  ;

  ToggleAutoSaveRuleRequest2._() : super();
  factory ToggleAutoSaveRuleRequest2({
    $core.String? ruleId,
    $core.String? action,
  }) {
    final _result = create();
    if (ruleId != null) {
      _result.ruleId = ruleId;
    }
    if (action != null) {
      _result.action = action;
    }
    return _result;
  }
  factory ToggleAutoSaveRuleRequest2.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ToggleAutoSaveRuleRequest2.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ToggleAutoSaveRuleRequest2 clone() => ToggleAutoSaveRuleRequest2()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ToggleAutoSaveRuleRequest2 copyWith(void Function(ToggleAutoSaveRuleRequest2) updates) => super.copyWith((message) => updates(message as ToggleAutoSaveRuleRequest2)) as ToggleAutoSaveRuleRequest2; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ToggleAutoSaveRuleRequest2 create() => ToggleAutoSaveRuleRequest2._();
  ToggleAutoSaveRuleRequest2 createEmptyInstance() => create();
  static $pb.PbList<ToggleAutoSaveRuleRequest2> createRepeated() => $pb.PbList<ToggleAutoSaveRuleRequest2>();
  @$core.pragma('dart2js:noInline')
  static ToggleAutoSaveRuleRequest2 getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ToggleAutoSaveRuleRequest2>(create);
  static ToggleAutoSaveRuleRequest2? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get ruleId => $_getSZ(0);
  @$pb.TagNumber(1)
  set ruleId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRuleId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRuleId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get action => $_getSZ(1);
  @$pb.TagNumber(2)
  set action($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAction() => $_has(1);
  @$pb.TagNumber(2)
  void clearAction() => clearField(2);
}

class ToggleAutoSaveRuleResponse2 extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ToggleAutoSaveRuleResponse2', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOM<AutoSaveRule>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'rule', subBuilder: AutoSaveRule.create)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  ToggleAutoSaveRuleResponse2._() : super();
  factory ToggleAutoSaveRuleResponse2({
    AutoSaveRule? rule,
    $core.String? message,
  }) {
    final _result = create();
    if (rule != null) {
      _result.rule = rule;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory ToggleAutoSaveRuleResponse2.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ToggleAutoSaveRuleResponse2.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ToggleAutoSaveRuleResponse2 clone() => ToggleAutoSaveRuleResponse2()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ToggleAutoSaveRuleResponse2 copyWith(void Function(ToggleAutoSaveRuleResponse2) updates) => super.copyWith((message) => updates(message as ToggleAutoSaveRuleResponse2)) as ToggleAutoSaveRuleResponse2; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ToggleAutoSaveRuleResponse2 create() => ToggleAutoSaveRuleResponse2._();
  ToggleAutoSaveRuleResponse2 createEmptyInstance() => create();
  static $pb.PbList<ToggleAutoSaveRuleResponse2> createRepeated() => $pb.PbList<ToggleAutoSaveRuleResponse2>();
  @$core.pragma('dart2js:noInline')
  static ToggleAutoSaveRuleResponse2 getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ToggleAutoSaveRuleResponse2>(create);
  static ToggleAutoSaveRuleResponse2? _defaultInstance;

  @$pb.TagNumber(1)
  AutoSaveRule get rule => $_getN(0);
  @$pb.TagNumber(1)
  set rule(AutoSaveRule v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasRule() => $_has(0);
  @$pb.TagNumber(1)
  void clearRule() => clearField(1);
  @$pb.TagNumber(1)
  AutoSaveRule ensureRule() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

class DeleteAutoSaveRuleRequest2 extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DeleteAutoSaveRuleRequest2', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ruleId')
    ..hasRequiredFields = false
  ;

  DeleteAutoSaveRuleRequest2._() : super();
  factory DeleteAutoSaveRuleRequest2({
    $core.String? ruleId,
  }) {
    final _result = create();
    if (ruleId != null) {
      _result.ruleId = ruleId;
    }
    return _result;
  }
  factory DeleteAutoSaveRuleRequest2.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteAutoSaveRuleRequest2.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteAutoSaveRuleRequest2 clone() => DeleteAutoSaveRuleRequest2()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteAutoSaveRuleRequest2 copyWith(void Function(DeleteAutoSaveRuleRequest2) updates) => super.copyWith((message) => updates(message as DeleteAutoSaveRuleRequest2)) as DeleteAutoSaveRuleRequest2; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DeleteAutoSaveRuleRequest2 create() => DeleteAutoSaveRuleRequest2._();
  DeleteAutoSaveRuleRequest2 createEmptyInstance() => create();
  static $pb.PbList<DeleteAutoSaveRuleRequest2> createRepeated() => $pb.PbList<DeleteAutoSaveRuleRequest2>();
  @$core.pragma('dart2js:noInline')
  static DeleteAutoSaveRuleRequest2 getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteAutoSaveRuleRequest2>(create);
  static DeleteAutoSaveRuleRequest2? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get ruleId => $_getSZ(0);
  @$pb.TagNumber(1)
  set ruleId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRuleId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRuleId() => clearField(1);
}

class DeleteAutoSaveRuleResponse2 extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DeleteAutoSaveRuleResponse2', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  DeleteAutoSaveRuleResponse2._() : super();
  factory DeleteAutoSaveRuleResponse2({
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
  factory DeleteAutoSaveRuleResponse2.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteAutoSaveRuleResponse2.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteAutoSaveRuleResponse2 clone() => DeleteAutoSaveRuleResponse2()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteAutoSaveRuleResponse2 copyWith(void Function(DeleteAutoSaveRuleResponse2) updates) => super.copyWith((message) => updates(message as DeleteAutoSaveRuleResponse2)) as DeleteAutoSaveRuleResponse2; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DeleteAutoSaveRuleResponse2 create() => DeleteAutoSaveRuleResponse2._();
  DeleteAutoSaveRuleResponse2 createEmptyInstance() => create();
  static $pb.PbList<DeleteAutoSaveRuleResponse2> createRepeated() => $pb.PbList<DeleteAutoSaveRuleResponse2>();
  @$core.pragma('dart2js:noInline')
  static DeleteAutoSaveRuleResponse2 getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteAutoSaveRuleResponse2>(create);
  static DeleteAutoSaveRuleResponse2? _defaultInstance;

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

class GetAutoSaveTransactionsRequest2 extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetAutoSaveTransactionsRequest2', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ruleId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountId')
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetAutoSaveTransactionsRequest2._() : super();
  factory GetAutoSaveTransactionsRequest2({
    $core.String? ruleId,
    $core.String? accountId,
    $core.int? limit,
    $core.int? offset,
  }) {
    final _result = create();
    if (ruleId != null) {
      _result.ruleId = ruleId;
    }
    if (accountId != null) {
      _result.accountId = accountId;
    }
    if (limit != null) {
      _result.limit = limit;
    }
    if (offset != null) {
      _result.offset = offset;
    }
    return _result;
  }
  factory GetAutoSaveTransactionsRequest2.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAutoSaveTransactionsRequest2.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAutoSaveTransactionsRequest2 clone() => GetAutoSaveTransactionsRequest2()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAutoSaveTransactionsRequest2 copyWith(void Function(GetAutoSaveTransactionsRequest2) updates) => super.copyWith((message) => updates(message as GetAutoSaveTransactionsRequest2)) as GetAutoSaveTransactionsRequest2; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetAutoSaveTransactionsRequest2 create() => GetAutoSaveTransactionsRequest2._();
  GetAutoSaveTransactionsRequest2 createEmptyInstance() => create();
  static $pb.PbList<GetAutoSaveTransactionsRequest2> createRepeated() => $pb.PbList<GetAutoSaveTransactionsRequest2>();
  @$core.pragma('dart2js:noInline')
  static GetAutoSaveTransactionsRequest2 getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAutoSaveTransactionsRequest2>(create);
  static GetAutoSaveTransactionsRequest2? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get ruleId => $_getSZ(0);
  @$pb.TagNumber(1)
  set ruleId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRuleId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRuleId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get accountId => $_getSZ(1);
  @$pb.TagNumber(2)
  set accountId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAccountId() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccountId() => clearField(2);

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

class GetAutoSaveTransactionsResponse2 extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetAutoSaveTransactionsResponse2', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..pc<AutoSaveTransaction>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactions', $pb.PbFieldType.PM, subBuilder: AutoSaveTransaction.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetAutoSaveTransactionsResponse2._() : super();
  factory GetAutoSaveTransactionsResponse2({
    $core.Iterable<AutoSaveTransaction>? transactions,
    $core.int? total,
  }) {
    final _result = create();
    if (transactions != null) {
      _result.transactions.addAll(transactions);
    }
    if (total != null) {
      _result.total = total;
    }
    return _result;
  }
  factory GetAutoSaveTransactionsResponse2.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAutoSaveTransactionsResponse2.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAutoSaveTransactionsResponse2 clone() => GetAutoSaveTransactionsResponse2()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAutoSaveTransactionsResponse2 copyWith(void Function(GetAutoSaveTransactionsResponse2) updates) => super.copyWith((message) => updates(message as GetAutoSaveTransactionsResponse2)) as GetAutoSaveTransactionsResponse2; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetAutoSaveTransactionsResponse2 create() => GetAutoSaveTransactionsResponse2._();
  GetAutoSaveTransactionsResponse2 createEmptyInstance() => create();
  static $pb.PbList<GetAutoSaveTransactionsResponse2> createRepeated() => $pb.PbList<GetAutoSaveTransactionsResponse2>();
  @$core.pragma('dart2js:noInline')
  static GetAutoSaveTransactionsResponse2 getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAutoSaveTransactionsResponse2>(create);
  static GetAutoSaveTransactionsResponse2? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<AutoSaveTransaction> get transactions => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => clearField(2);
}

class GetAutoSaveStatisticsRequest2 extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetAutoSaveStatisticsRequest2', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GetAutoSaveStatisticsRequest2._() : super();
  factory GetAutoSaveStatisticsRequest2() => create();
  factory GetAutoSaveStatisticsRequest2.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAutoSaveStatisticsRequest2.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAutoSaveStatisticsRequest2 clone() => GetAutoSaveStatisticsRequest2()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAutoSaveStatisticsRequest2 copyWith(void Function(GetAutoSaveStatisticsRequest2) updates) => super.copyWith((message) => updates(message as GetAutoSaveStatisticsRequest2)) as GetAutoSaveStatisticsRequest2; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetAutoSaveStatisticsRequest2 create() => GetAutoSaveStatisticsRequest2._();
  GetAutoSaveStatisticsRequest2 createEmptyInstance() => create();
  static $pb.PbList<GetAutoSaveStatisticsRequest2> createRepeated() => $pb.PbList<GetAutoSaveStatisticsRequest2>();
  @$core.pragma('dart2js:noInline')
  static GetAutoSaveStatisticsRequest2 getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAutoSaveStatisticsRequest2>(create);
  static GetAutoSaveStatisticsRequest2? _defaultInstance;
}

class GetAutoSaveStatisticsResponse2 extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetAutoSaveStatisticsResponse2', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOM<AutoSaveStatistics>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'statistics', subBuilder: AutoSaveStatistics.create)
    ..hasRequiredFields = false
  ;

  GetAutoSaveStatisticsResponse2._() : super();
  factory GetAutoSaveStatisticsResponse2({
    AutoSaveStatistics? statistics,
  }) {
    final _result = create();
    if (statistics != null) {
      _result.statistics = statistics;
    }
    return _result;
  }
  factory GetAutoSaveStatisticsResponse2.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAutoSaveStatisticsResponse2.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAutoSaveStatisticsResponse2 clone() => GetAutoSaveStatisticsResponse2()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAutoSaveStatisticsResponse2 copyWith(void Function(GetAutoSaveStatisticsResponse2) updates) => super.copyWith((message) => updates(message as GetAutoSaveStatisticsResponse2)) as GetAutoSaveStatisticsResponse2; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetAutoSaveStatisticsResponse2 create() => GetAutoSaveStatisticsResponse2._();
  GetAutoSaveStatisticsResponse2 createEmptyInstance() => create();
  static $pb.PbList<GetAutoSaveStatisticsResponse2> createRepeated() => $pb.PbList<GetAutoSaveStatisticsResponse2>();
  @$core.pragma('dart2js:noInline')
  static GetAutoSaveStatisticsResponse2 getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAutoSaveStatisticsResponse2>(create);
  static GetAutoSaveStatisticsResponse2? _defaultInstance;

  @$pb.TagNumber(1)
  AutoSaveStatistics get statistics => $_getN(0);
  @$pb.TagNumber(1)
  set statistics(AutoSaveStatistics v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasStatistics() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatistics() => clearField(1);
  @$pb.TagNumber(1)
  AutoSaveStatistics ensureStatistics() => $_ensure(0);
}

class TriggerAutoSaveRequest2 extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TriggerAutoSaveRequest2', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ruleId')
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'customAmount', $pb.PbFieldType.OD)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionPinToken')
    ..hasRequiredFields = false
  ;

  TriggerAutoSaveRequest2._() : super();
  factory TriggerAutoSaveRequest2({
    $core.String? ruleId,
    $core.double? customAmount,
    $core.String? transactionPinToken,
  }) {
    final _result = create();
    if (ruleId != null) {
      _result.ruleId = ruleId;
    }
    if (customAmount != null) {
      _result.customAmount = customAmount;
    }
    if (transactionPinToken != null) {
      _result.transactionPinToken = transactionPinToken;
    }
    return _result;
  }
  factory TriggerAutoSaveRequest2.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TriggerAutoSaveRequest2.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TriggerAutoSaveRequest2 clone() => TriggerAutoSaveRequest2()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TriggerAutoSaveRequest2 copyWith(void Function(TriggerAutoSaveRequest2) updates) => super.copyWith((message) => updates(message as TriggerAutoSaveRequest2)) as TriggerAutoSaveRequest2; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TriggerAutoSaveRequest2 create() => TriggerAutoSaveRequest2._();
  TriggerAutoSaveRequest2 createEmptyInstance() => create();
  static $pb.PbList<TriggerAutoSaveRequest2> createRepeated() => $pb.PbList<TriggerAutoSaveRequest2>();
  @$core.pragma('dart2js:noInline')
  static TriggerAutoSaveRequest2 getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TriggerAutoSaveRequest2>(create);
  static TriggerAutoSaveRequest2? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get ruleId => $_getSZ(0);
  @$pb.TagNumber(1)
  set ruleId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRuleId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRuleId() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get customAmount => $_getN(1);
  @$pb.TagNumber(2)
  set customAmount($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCustomAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearCustomAmount() => clearField(2);

  @$pb.TagNumber(4)
  $core.String get transactionPinToken => $_getSZ(2);
  @$pb.TagNumber(4)
  set transactionPinToken($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(4)
  $core.bool hasTransactionPinToken() => $_has(2);
  @$pb.TagNumber(4)
  void clearTransactionPinToken() => clearField(4);
}

class TriggerAutoSaveResponse2 extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TriggerAutoSaveResponse2', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOM<AutoSaveTransaction>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transaction', subBuilder: AutoSaveTransaction.create)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  TriggerAutoSaveResponse2._() : super();
  factory TriggerAutoSaveResponse2({
    AutoSaveTransaction? transaction,
    $core.String? message,
  }) {
    final _result = create();
    if (transaction != null) {
      _result.transaction = transaction;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory TriggerAutoSaveResponse2.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TriggerAutoSaveResponse2.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TriggerAutoSaveResponse2 clone() => TriggerAutoSaveResponse2()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TriggerAutoSaveResponse2 copyWith(void Function(TriggerAutoSaveResponse2) updates) => super.copyWith((message) => updates(message as TriggerAutoSaveResponse2)) as TriggerAutoSaveResponse2; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TriggerAutoSaveResponse2 create() => TriggerAutoSaveResponse2._();
  TriggerAutoSaveResponse2 createEmptyInstance() => create();
  static $pb.PbList<TriggerAutoSaveResponse2> createRepeated() => $pb.PbList<TriggerAutoSaveResponse2>();
  @$core.pragma('dart2js:noInline')
  static TriggerAutoSaveResponse2 getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TriggerAutoSaveResponse2>(create);
  static TriggerAutoSaveResponse2? _defaultInstance;

  @$pb.TagNumber(1)
  AutoSaveTransaction get transaction => $_getN(0);
  @$pb.TagNumber(1)
  set transaction(AutoSaveTransaction v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasTransaction() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransaction() => clearField(1);
  @$pb.TagNumber(1)
  AutoSaveTransaction ensureTransaction() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

class NotificationChannel extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'NotificationChannel', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'crowdfundId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'creatorUserId')
    ..e<NotificationChannelType>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'channelType', $pb.PbFieldType.OE, defaultOrMaker: NotificationChannelType.NOTIFICATION_CHANNEL_TYPE_UNSPECIFIED, valueOf: NotificationChannelType.valueOf, enumValues: NotificationChannelType.values)
    ..e<NotificationChannelStatus>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: NotificationChannelStatus.NOTIFICATION_CHANNEL_STATUS_UNSPECIFIED, valueOf: NotificationChannelStatus.valueOf, enumValues: NotificationChannelStatus.values)
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'channelName')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'channelIdentifier')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'channelUsername')
    ..pc<NotificationEventType>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'enabledEvents', $pb.PbFieldType.KE, valueOf: NotificationEventType.valueOf, enumValues: NotificationEventType.values, defaultEnumValue: NotificationEventType.NOTIFICATION_EVENT_TYPE_UNSPECIFIED)
    ..aOM<NotificationPreferences>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'preferences', subBuilder: NotificationPreferences.create)
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lastNotificationAt')
    ..a<$core.int>(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'notificationCount', $pb.PbFieldType.O3)
    ..a<$core.int>(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'failureCount', $pb.PbFieldType.O3)
    ..aOS(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lastError')
    ..aOS(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt')
    ..aOS(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedAt')
    ..hasRequiredFields = false
  ;

  NotificationChannel._() : super();
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
    if (channelIdentifier != null) {
      _result.channelIdentifier = channelIdentifier;
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
  factory NotificationChannel.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NotificationChannel.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NotificationChannel clone() => NotificationChannel()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NotificationChannel copyWith(void Function(NotificationChannel) updates) => super.copyWith((message) => updates(message as NotificationChannel)) as NotificationChannel; // ignore: deprecated_member_use
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

class NotificationPreferences extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'NotificationPreferences', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
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

  NotificationPreferences._() : super();
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
  factory NotificationPreferences.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NotificationPreferences.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NotificationPreferences clone() => NotificationPreferences()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NotificationPreferences copyWith(void Function(NotificationPreferences) updates) => super.copyWith((message) => updates(message as NotificationPreferences)) as NotificationPreferences; // ignore: deprecated_member_use
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

class NotificationDelivery extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'NotificationDelivery', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
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

  NotificationDelivery._() : super();
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
  factory NotificationDelivery.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NotificationDelivery.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NotificationDelivery clone() => NotificationDelivery()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NotificationDelivery copyWith(void Function(NotificationDelivery) updates) => super.copyWith((message) => updates(message as NotificationDelivery)) as NotificationDelivery; // ignore: deprecated_member_use
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

class ConnectNotificationChannelRequest extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, ConnectNotificationChannelRequest_ConnectionData> _ConnectNotificationChannelRequest_ConnectionDataByTag = {
    4 : ConnectNotificationChannelRequest_ConnectionData.telegram,
    5 : ConnectNotificationChannelRequest_ConnectionData.discord,
    6 : ConnectNotificationChannelRequest_ConnectionData.whatsappBusiness,
    7 : ConnectNotificationChannelRequest_ConnectionData.slack,
    0 : ConnectNotificationChannelRequest_ConnectionData.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ConnectNotificationChannelRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..oo(0, [4, 5, 6, 7])
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'crowdfundId')
    ..e<NotificationChannelType>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'channelType', $pb.PbFieldType.OE, defaultOrMaker: NotificationChannelType.NOTIFICATION_CHANNEL_TYPE_UNSPECIFIED, valueOf: NotificationChannelType.valueOf, enumValues: NotificationChannelType.values)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'channelName')
    ..aOM<TelegramConnectionData>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'telegram', subBuilder: TelegramConnectionData.create)
    ..aOM<DiscordConnectionData>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'discord', subBuilder: DiscordConnectionData.create)
    ..aOM<WhatsAppBusinessConnectionData>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'whatsappBusiness', subBuilder: WhatsAppBusinessConnectionData.create)
    ..aOM<SlackConnectionData>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'slack', subBuilder: SlackConnectionData.create)
    ..pc<NotificationEventType>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'enabledEvents', $pb.PbFieldType.KE, valueOf: NotificationEventType.valueOf, enumValues: NotificationEventType.values, defaultEnumValue: NotificationEventType.NOTIFICATION_EVENT_TYPE_UNSPECIFIED)
    ..aOM<NotificationPreferences>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'preferences', subBuilder: NotificationPreferences.create)
    ..hasRequiredFields = false
  ;

  ConnectNotificationChannelRequest._() : super();
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TelegramConnectionData', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'chatId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'verificationCode')
    ..hasRequiredFields = false
  ;

  TelegramConnectionData._() : super();
  factory TelegramConnectionData({
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
  factory TelegramConnectionData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TelegramConnectionData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TelegramConnectionData clone() => TelegramConnectionData()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TelegramConnectionData copyWith(void Function(TelegramConnectionData) updates) => super.copyWith((message) => updates(message as TelegramConnectionData)) as TelegramConnectionData; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DiscordConnectionData', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'webhookUrl')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'serverName')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'channelName')
    ..hasRequiredFields = false
  ;

  DiscordConnectionData._() : super();
  factory DiscordConnectionData({
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
  factory DiscordConnectionData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DiscordConnectionData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DiscordConnectionData clone() => DiscordConnectionData()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DiscordConnectionData copyWith(void Function(DiscordConnectionData) updates) => super.copyWith((message) => updates(message as DiscordConnectionData)) as DiscordConnectionData; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'WhatsAppBusinessConnectionData', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'phoneNumberId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accessToken')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recipientId')
    ..hasRequiredFields = false
  ;

  WhatsAppBusinessConnectionData._() : super();
  factory WhatsAppBusinessConnectionData({
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
  factory WhatsAppBusinessConnectionData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WhatsAppBusinessConnectionData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  WhatsAppBusinessConnectionData clone() => WhatsAppBusinessConnectionData()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  WhatsAppBusinessConnectionData copyWith(void Function(WhatsAppBusinessConnectionData) updates) => super.copyWith((message) => updates(message as WhatsAppBusinessConnectionData)) as WhatsAppBusinessConnectionData; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SlackConnectionData', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'webhookUrl')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'workspaceName')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'channelName')
    ..hasRequiredFields = false
  ;

  SlackConnectionData._() : super();
  factory SlackConnectionData({
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
  factory SlackConnectionData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SlackConnectionData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SlackConnectionData clone() => SlackConnectionData()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SlackConnectionData copyWith(void Function(SlackConnectionData) updates) => super.copyWith((message) => updates(message as SlackConnectionData)) as SlackConnectionData; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ConnectNotificationChannelResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOM<NotificationChannel>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'channel', subBuilder: NotificationChannel.create)
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'requiresVerification')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'verificationInstructions')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  ConnectNotificationChannelResponse._() : super();
  factory ConnectNotificationChannelResponse({
    NotificationChannel? channel,
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

class DisconnectNotificationChannelRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DisconnectNotificationChannelRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DisconnectNotificationChannelResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetNotificationChannelsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetNotificationChannelsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..pc<NotificationChannel>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'channels', $pb.PbFieldType.PM, subBuilder: NotificationChannel.create)
    ..hasRequiredFields = false
  ;

  GetNotificationChannelsResponse._() : super();
  factory GetNotificationChannelsResponse({
    $core.Iterable<NotificationChannel>? channels,
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
  $core.List<NotificationChannel> get channels => $_getList(0);
}

class UpdateNotificationChannelRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateNotificationChannelRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'channelId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'channelName')
    ..pc<NotificationEventType>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'enabledEvents', $pb.PbFieldType.KE, valueOf: NotificationEventType.valueOf, enumValues: NotificationEventType.values, defaultEnumValue: NotificationEventType.NOTIFICATION_EVENT_TYPE_UNSPECIFIED)
    ..aOM<NotificationPreferences>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'preferences', subBuilder: NotificationPreferences.create)
    ..e<NotificationChannelStatus>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: NotificationChannelStatus.NOTIFICATION_CHANNEL_STATUS_UNSPECIFIED, valueOf: NotificationChannelStatus.valueOf, enumValues: NotificationChannelStatus.values)
    ..hasRequiredFields = false
  ;

  UpdateNotificationChannelRequest._() : super();
  factory UpdateNotificationChannelRequest({
    $core.String? channelId,
    $core.String? channelName,
    $core.Iterable<NotificationEventType>? enabledEvents,
    NotificationPreferences? preferences,
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateNotificationChannelResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOM<NotificationChannel>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'channel', subBuilder: NotificationChannel.create)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  UpdateNotificationChannelResponse._() : super();
  factory UpdateNotificationChannelResponse({
    NotificationChannel? channel,
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

class TestNotificationChannelRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TestNotificationChannelRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TestNotificationChannelResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetTelegramBotInfoRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetTelegramBotInfoResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'VerifyTelegramChannelRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'VerifyTelegramChannelResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOM<NotificationChannel>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'channel', subBuilder: NotificationChannel.create)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  VerifyTelegramChannelResponse._() : super();
  factory VerifyTelegramChannelResponse({
    $core.bool? success,
    NotificationChannel? channel,
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

class GetNotificationHistoryRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetNotificationHistoryRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetNotificationHistoryResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..pc<NotificationDelivery>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'deliveries', $pb.PbFieldType.PM, subBuilder: NotificationDelivery.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'total', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOB(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hasMore')
    ..hasRequiredFields = false
  ;

  GetNotificationHistoryResponse._() : super();
  factory GetNotificationHistoryResponse({
    $core.Iterable<NotificationDelivery>? deliveries,
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

class GetCrowdfundLeaderboardRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetCrowdfundLeaderboardRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..e<LeaderboardSortBy>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sortBy', $pb.PbFieldType.OE, defaultOrMaker: LeaderboardSortBy.LEADERBOARD_SORT_UNSPECIFIED, valueOf: LeaderboardSortBy.valueOf, enumValues: LeaderboardSortBy.values)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'category')
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetCrowdfundLeaderboardRequest._() : super();
  factory GetCrowdfundLeaderboardRequest({
    LeaderboardSortBy? sortBy,
    $core.String? category,
    $core.int? limit,
    $core.int? offset,
  }) {
    final _result = create();
    if (sortBy != null) {
      _result.sortBy = sortBy;
    }
    if (category != null) {
      _result.category = category;
    }
    if (limit != null) {
      _result.limit = limit;
    }
    if (offset != null) {
      _result.offset = offset;
    }
    return _result;
  }
  factory GetCrowdfundLeaderboardRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCrowdfundLeaderboardRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCrowdfundLeaderboardRequest clone() => GetCrowdfundLeaderboardRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCrowdfundLeaderboardRequest copyWith(void Function(GetCrowdfundLeaderboardRequest) updates) => super.copyWith((message) => updates(message as GetCrowdfundLeaderboardRequest)) as GetCrowdfundLeaderboardRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetCrowdfundLeaderboardResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..pc<LeaderboardCrowdfundEntry>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'entries', $pb.PbFieldType.PM, subBuilder: LeaderboardCrowdfundEntry.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalCount', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetCrowdfundLeaderboardResponse._() : super();
  factory GetCrowdfundLeaderboardResponse({
    $core.Iterable<LeaderboardCrowdfundEntry>? entries,
    $core.int? totalCount,
  }) {
    final _result = create();
    if (entries != null) {
      _result.entries.addAll(entries);
    }
    if (totalCount != null) {
      _result.totalCount = totalCount;
    }
    return _result;
  }
  factory GetCrowdfundLeaderboardResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCrowdfundLeaderboardResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCrowdfundLeaderboardResponse clone() => GetCrowdfundLeaderboardResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCrowdfundLeaderboardResponse copyWith(void Function(GetCrowdfundLeaderboardResponse) updates) => super.copyWith((message) => updates(message as GetCrowdfundLeaderboardResponse)) as GetCrowdfundLeaderboardResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'LeaderboardCrowdfundEntry', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'rank', $pb.PbFieldType.O3)
    ..aOM<Crowdfund>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'crowdfund', subBuilder: Crowdfund.create)
    ..hasRequiredFields = false
  ;

  LeaderboardCrowdfundEntry._() : super();
  factory LeaderboardCrowdfundEntry({
    $core.int? rank,
    Crowdfund? crowdfund,
  }) {
    final _result = create();
    if (rank != null) {
      _result.rank = rank;
    }
    if (crowdfund != null) {
      _result.crowdfund = crowdfund;
    }
    return _result;
  }
  factory LeaderboardCrowdfundEntry.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LeaderboardCrowdfundEntry.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LeaderboardCrowdfundEntry clone() => LeaderboardCrowdfundEntry()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LeaderboardCrowdfundEntry copyWith(void Function(LeaderboardCrowdfundEntry) updates) => super.copyWith((message) => updates(message as LeaderboardCrowdfundEntry)) as LeaderboardCrowdfundEntry; // ignore: deprecated_member_use
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
  Crowdfund get crowdfund => $_getN(1);
  @$pb.TagNumber(2)
  set crowdfund(Crowdfund v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasCrowdfund() => $_has(1);
  @$pb.TagNumber(2)
  void clearCrowdfund() => clearField(2);
  @$pb.TagNumber(2)
  Crowdfund ensureCrowdfund() => $_ensure(1);
}

class MyCoverCustomer extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MyCoverCustomer', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'firstName')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lastName')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'email')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'phoneNumber')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'gender')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dateOfBirth')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedAt')
    ..hasRequiredFields = false
  ;

  MyCoverCustomer._() : super();
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
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (firstName != null) {
      _result.firstName = firstName;
    }
    if (lastName != null) {
      _result.lastName = lastName;
    }
    if (email != null) {
      _result.email = email;
    }
    if (phoneNumber != null) {
      _result.phoneNumber = phoneNumber;
    }
    if (gender != null) {
      _result.gender = gender;
    }
    if (dateOfBirth != null) {
      _result.dateOfBirth = dateOfBirth;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      _result.updatedAt = updatedAt;
    }
    return _result;
  }
  factory MyCoverCustomer.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MyCoverCustomer.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MyCoverCustomer clone() => MyCoverCustomer()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MyCoverCustomer copyWith(void Function(MyCoverCustomer) updates) => super.copyWith((message) => updates(message as MyCoverCustomer)) as MyCoverCustomer; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MyCoverCustomer create() => MyCoverCustomer._();
  MyCoverCustomer createEmptyInstance() => create();
  static $pb.PbList<MyCoverCustomer> createRepeated() => $pb.PbList<MyCoverCustomer>();
  @$core.pragma('dart2js:noInline')
  static MyCoverCustomer getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MyCoverCustomer>(create);
  static MyCoverCustomer? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get firstName => $_getSZ(1);
  @$pb.TagNumber(2)
  set firstName($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasFirstName() => $_has(1);
  @$pb.TagNumber(2)
  void clearFirstName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get lastName => $_getSZ(2);
  @$pb.TagNumber(3)
  set lastName($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasLastName() => $_has(2);
  @$pb.TagNumber(3)
  void clearLastName() => clearField(3);

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
  $core.String get gender => $_getSZ(5);
  @$pb.TagNumber(6)
  set gender($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasGender() => $_has(5);
  @$pb.TagNumber(6)
  void clearGender() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get dateOfBirth => $_getSZ(6);
  @$pb.TagNumber(7)
  set dateOfBirth($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasDateOfBirth() => $_has(6);
  @$pb.TagNumber(7)
  void clearDateOfBirth() => clearField(7);

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

class MyCoverPurchase extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MyCoverPurchase', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'appMode')
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isRenewal')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'customerId')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'distributorId')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'paymentChannel')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'paymentOption')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'policyId')
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'productCategoryId')
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'productId')
    ..aOS(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerId')
    ..aOS(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'countryId')
    ..aOS(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currencyId')
    ..aOS(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt')
    ..aOS(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedAt')
    ..aOS(17, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'customerName')
    ..aOS(18, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'customerEmail')
    ..aOS(19, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'customerPhone')
    ..aOS(20, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'policyNumber')
    ..aOS(21, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'certificateUrl')
    ..aOB(22, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'policyIsActive')
    ..aOS(23, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'policyAmount')
    ..aOS(24, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerName')
    ..aOS(25, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'productName')
    ..aOS(26, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'productCategoryName')
    ..hasRequiredFields = false
  ;

  MyCoverPurchase._() : super();
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
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (appMode != null) {
      _result.appMode = appMode;
    }
    if (isRenewal != null) {
      _result.isRenewal = isRenewal;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (customerId != null) {
      _result.customerId = customerId;
    }
    if (distributorId != null) {
      _result.distributorId = distributorId;
    }
    if (paymentChannel != null) {
      _result.paymentChannel = paymentChannel;
    }
    if (paymentOption != null) {
      _result.paymentOption = paymentOption;
    }
    if (policyId != null) {
      _result.policyId = policyId;
    }
    if (productCategoryId != null) {
      _result.productCategoryId = productCategoryId;
    }
    if (productId != null) {
      _result.productId = productId;
    }
    if (providerId != null) {
      _result.providerId = providerId;
    }
    if (countryId != null) {
      _result.countryId = countryId;
    }
    if (currencyId != null) {
      _result.currencyId = currencyId;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      _result.updatedAt = updatedAt;
    }
    if (customerName != null) {
      _result.customerName = customerName;
    }
    if (customerEmail != null) {
      _result.customerEmail = customerEmail;
    }
    if (customerPhone != null) {
      _result.customerPhone = customerPhone;
    }
    if (policyNumber != null) {
      _result.policyNumber = policyNumber;
    }
    if (certificateUrl != null) {
      _result.certificateUrl = certificateUrl;
    }
    if (policyIsActive != null) {
      _result.policyIsActive = policyIsActive;
    }
    if (policyAmount != null) {
      _result.policyAmount = policyAmount;
    }
    if (providerName != null) {
      _result.providerName = providerName;
    }
    if (productName != null) {
      _result.productName = productName;
    }
    if (productCategoryName != null) {
      _result.productCategoryName = productCategoryName;
    }
    return _result;
  }
  factory MyCoverPurchase.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MyCoverPurchase.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MyCoverPurchase clone() => MyCoverPurchase()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MyCoverPurchase copyWith(void Function(MyCoverPurchase) updates) => super.copyWith((message) => updates(message as MyCoverPurchase)) as MyCoverPurchase; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MyCoverPurchase create() => MyCoverPurchase._();
  MyCoverPurchase createEmptyInstance() => create();
  static $pb.PbList<MyCoverPurchase> createRepeated() => $pb.PbList<MyCoverPurchase>();
  @$core.pragma('dart2js:noInline')
  static MyCoverPurchase getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MyCoverPurchase>(create);
  static MyCoverPurchase? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get appMode => $_getSZ(1);
  @$pb.TagNumber(2)
  set appMode($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAppMode() => $_has(1);
  @$pb.TagNumber(2)
  void clearAppMode() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get isRenewal => $_getBF(2);
  @$pb.TagNumber(3)
  set isRenewal($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasIsRenewal() => $_has(2);
  @$pb.TagNumber(3)
  void clearIsRenewal() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get amount => $_getSZ(3);
  @$pb.TagNumber(4)
  set amount($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearAmount() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get customerId => $_getSZ(4);
  @$pb.TagNumber(5)
  set customerId($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasCustomerId() => $_has(4);
  @$pb.TagNumber(5)
  void clearCustomerId() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get distributorId => $_getSZ(5);
  @$pb.TagNumber(6)
  set distributorId($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasDistributorId() => $_has(5);
  @$pb.TagNumber(6)
  void clearDistributorId() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get paymentChannel => $_getSZ(6);
  @$pb.TagNumber(7)
  set paymentChannel($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasPaymentChannel() => $_has(6);
  @$pb.TagNumber(7)
  void clearPaymentChannel() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get paymentOption => $_getSZ(7);
  @$pb.TagNumber(8)
  set paymentOption($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasPaymentOption() => $_has(7);
  @$pb.TagNumber(8)
  void clearPaymentOption() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get policyId => $_getSZ(8);
  @$pb.TagNumber(9)
  set policyId($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasPolicyId() => $_has(8);
  @$pb.TagNumber(9)
  void clearPolicyId() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get productCategoryId => $_getSZ(9);
  @$pb.TagNumber(10)
  set productCategoryId($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasProductCategoryId() => $_has(9);
  @$pb.TagNumber(10)
  void clearProductCategoryId() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get productId => $_getSZ(10);
  @$pb.TagNumber(11)
  set productId($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasProductId() => $_has(10);
  @$pb.TagNumber(11)
  void clearProductId() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get providerId => $_getSZ(11);
  @$pb.TagNumber(12)
  set providerId($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasProviderId() => $_has(11);
  @$pb.TagNumber(12)
  void clearProviderId() => clearField(12);

  @$pb.TagNumber(13)
  $core.String get countryId => $_getSZ(12);
  @$pb.TagNumber(13)
  set countryId($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasCountryId() => $_has(12);
  @$pb.TagNumber(13)
  void clearCountryId() => clearField(13);

  @$pb.TagNumber(14)
  $core.String get currencyId => $_getSZ(13);
  @$pb.TagNumber(14)
  set currencyId($core.String v) { $_setString(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasCurrencyId() => $_has(13);
  @$pb.TagNumber(14)
  void clearCurrencyId() => clearField(14);

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

  @$pb.TagNumber(17)
  $core.String get customerName => $_getSZ(16);
  @$pb.TagNumber(17)
  set customerName($core.String v) { $_setString(16, v); }
  @$pb.TagNumber(17)
  $core.bool hasCustomerName() => $_has(16);
  @$pb.TagNumber(17)
  void clearCustomerName() => clearField(17);

  @$pb.TagNumber(18)
  $core.String get customerEmail => $_getSZ(17);
  @$pb.TagNumber(18)
  set customerEmail($core.String v) { $_setString(17, v); }
  @$pb.TagNumber(18)
  $core.bool hasCustomerEmail() => $_has(17);
  @$pb.TagNumber(18)
  void clearCustomerEmail() => clearField(18);

  @$pb.TagNumber(19)
  $core.String get customerPhone => $_getSZ(18);
  @$pb.TagNumber(19)
  set customerPhone($core.String v) { $_setString(18, v); }
  @$pb.TagNumber(19)
  $core.bool hasCustomerPhone() => $_has(18);
  @$pb.TagNumber(19)
  void clearCustomerPhone() => clearField(19);

  @$pb.TagNumber(20)
  $core.String get policyNumber => $_getSZ(19);
  @$pb.TagNumber(20)
  set policyNumber($core.String v) { $_setString(19, v); }
  @$pb.TagNumber(20)
  $core.bool hasPolicyNumber() => $_has(19);
  @$pb.TagNumber(20)
  void clearPolicyNumber() => clearField(20);

  @$pb.TagNumber(21)
  $core.String get certificateUrl => $_getSZ(20);
  @$pb.TagNumber(21)
  set certificateUrl($core.String v) { $_setString(20, v); }
  @$pb.TagNumber(21)
  $core.bool hasCertificateUrl() => $_has(20);
  @$pb.TagNumber(21)
  void clearCertificateUrl() => clearField(21);

  @$pb.TagNumber(22)
  $core.bool get policyIsActive => $_getBF(21);
  @$pb.TagNumber(22)
  set policyIsActive($core.bool v) { $_setBool(21, v); }
  @$pb.TagNumber(22)
  $core.bool hasPolicyIsActive() => $_has(21);
  @$pb.TagNumber(22)
  void clearPolicyIsActive() => clearField(22);

  @$pb.TagNumber(23)
  $core.String get policyAmount => $_getSZ(22);
  @$pb.TagNumber(23)
  set policyAmount($core.String v) { $_setString(22, v); }
  @$pb.TagNumber(23)
  $core.bool hasPolicyAmount() => $_has(22);
  @$pb.TagNumber(23)
  void clearPolicyAmount() => clearField(23);

  @$pb.TagNumber(24)
  $core.String get providerName => $_getSZ(23);
  @$pb.TagNumber(24)
  set providerName($core.String v) { $_setString(23, v); }
  @$pb.TagNumber(24)
  $core.bool hasProviderName() => $_has(23);
  @$pb.TagNumber(24)
  void clearProviderName() => clearField(24);

  @$pb.TagNumber(25)
  $core.String get productName => $_getSZ(24);
  @$pb.TagNumber(25)
  set productName($core.String v) { $_setString(24, v); }
  @$pb.TagNumber(25)
  $core.bool hasProductName() => $_has(24);
  @$pb.TagNumber(25)
  void clearProductName() => clearField(25);

  @$pb.TagNumber(26)
  $core.String get productCategoryName => $_getSZ(25);
  @$pb.TagNumber(26)
  set productCategoryName($core.String v) { $_setString(25, v); }
  @$pb.TagNumber(26)
  $core.bool hasProductCategoryName() => $_has(25);
  @$pb.TagNumber(26)
  void clearProductCategoryName() => clearField(26);
}

class MyCoverClaim extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MyCoverClaim', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type')
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'policyId')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'customerId')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'claimNumber')
    ..pPS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'documents')
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'rejectionReason')
    ..a<$core.double>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'approvedAmount', $pb.PbFieldType.OD)
    ..aOS(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt')
    ..aOS(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedAt')
    ..hasRequiredFields = false
  ;

  MyCoverClaim._() : super();
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
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (status != null) {
      _result.status = status;
    }
    if (type != null) {
      _result.type = type;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (description != null) {
      _result.description = description;
    }
    if (policyId != null) {
      _result.policyId = policyId;
    }
    if (customerId != null) {
      _result.customerId = customerId;
    }
    if (claimNumber != null) {
      _result.claimNumber = claimNumber;
    }
    if (documents != null) {
      _result.documents.addAll(documents);
    }
    if (rejectionReason != null) {
      _result.rejectionReason = rejectionReason;
    }
    if (approvedAmount != null) {
      _result.approvedAmount = approvedAmount;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      _result.updatedAt = updatedAt;
    }
    return _result;
  }
  factory MyCoverClaim.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MyCoverClaim.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MyCoverClaim clone() => MyCoverClaim()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MyCoverClaim copyWith(void Function(MyCoverClaim) updates) => super.copyWith((message) => updates(message as MyCoverClaim)) as MyCoverClaim; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MyCoverClaim create() => MyCoverClaim._();
  MyCoverClaim createEmptyInstance() => create();
  static $pb.PbList<MyCoverClaim> createRepeated() => $pb.PbList<MyCoverClaim>();
  @$core.pragma('dart2js:noInline')
  static MyCoverClaim getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MyCoverClaim>(create);
  static MyCoverClaim? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get status => $_getSZ(1);
  @$pb.TagNumber(2)
  set status($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get type => $_getSZ(2);
  @$pb.TagNumber(3)
  set type($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasType() => $_has(2);
  @$pb.TagNumber(3)
  void clearType() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get amount => $_getN(3);
  @$pb.TagNumber(4)
  set amount($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearAmount() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get description => $_getSZ(4);
  @$pb.TagNumber(5)
  set description($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasDescription() => $_has(4);
  @$pb.TagNumber(5)
  void clearDescription() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get policyId => $_getSZ(5);
  @$pb.TagNumber(6)
  set policyId($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasPolicyId() => $_has(5);
  @$pb.TagNumber(6)
  void clearPolicyId() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get customerId => $_getSZ(6);
  @$pb.TagNumber(7)
  set customerId($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasCustomerId() => $_has(6);
  @$pb.TagNumber(7)
  void clearCustomerId() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get claimNumber => $_getSZ(7);
  @$pb.TagNumber(8)
  set claimNumber($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasClaimNumber() => $_has(7);
  @$pb.TagNumber(8)
  void clearClaimNumber() => clearField(8);

  @$pb.TagNumber(9)
  $core.List<$core.String> get documents => $_getList(8);

  @$pb.TagNumber(10)
  $core.String get rejectionReason => $_getSZ(9);
  @$pb.TagNumber(10)
  set rejectionReason($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasRejectionReason() => $_has(9);
  @$pb.TagNumber(10)
  void clearRejectionReason() => clearField(10);

  @$pb.TagNumber(11)
  $core.double get approvedAmount => $_getN(10);
  @$pb.TagNumber(11)
  set approvedAmount($core.double v) { $_setDouble(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasApprovedAmount() => $_has(10);
  @$pb.TagNumber(11)
  void clearApprovedAmount() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get createdAt => $_getSZ(11);
  @$pb.TagNumber(12)
  set createdAt($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasCreatedAt() => $_has(11);
  @$pb.TagNumber(12)
  void clearCreatedAt() => clearField(12);

  @$pb.TagNumber(13)
  $core.String get updatedAt => $_getSZ(12);
  @$pb.TagNumber(13)
  set updatedAt($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasUpdatedAt() => $_has(12);
  @$pb.TagNumber(13)
  void clearUpdatedAt() => clearField(13);
}

class GetMyCoverCustomersRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetMyCoverCustomersRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetMyCoverCustomersRequest._() : super();
  factory GetMyCoverCustomersRequest({
    $core.int? page,
    $core.int? limit,
  }) {
    final _result = create();
    if (page != null) {
      _result.page = page;
    }
    if (limit != null) {
      _result.limit = limit;
    }
    return _result;
  }
  factory GetMyCoverCustomersRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMyCoverCustomersRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMyCoverCustomersRequest clone() => GetMyCoverCustomersRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMyCoverCustomersRequest copyWith(void Function(GetMyCoverCustomersRequest) updates) => super.copyWith((message) => updates(message as GetMyCoverCustomersRequest)) as GetMyCoverCustomersRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetMyCoverCustomersRequest create() => GetMyCoverCustomersRequest._();
  GetMyCoverCustomersRequest createEmptyInstance() => create();
  static $pb.PbList<GetMyCoverCustomersRequest> createRepeated() => $pb.PbList<GetMyCoverCustomersRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMyCoverCustomersRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMyCoverCustomersRequest>(create);
  static GetMyCoverCustomersRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get page => $_getIZ(0);
  @$pb.TagNumber(1)
  set page($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearPage() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get limit => $_getIZ(1);
  @$pb.TagNumber(2)
  set limit($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearLimit() => clearField(2);
}

class GetMyCoverCustomersResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetMyCoverCustomersResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..pc<MyCoverCustomer>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'customers', $pb.PbFieldType.PM, subBuilder: MyCoverCustomer.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetMyCoverCustomersResponse._() : super();
  factory GetMyCoverCustomersResponse({
    $core.Iterable<MyCoverCustomer>? customers,
    $core.int? total,
  }) {
    final _result = create();
    if (customers != null) {
      _result.customers.addAll(customers);
    }
    if (total != null) {
      _result.total = total;
    }
    return _result;
  }
  factory GetMyCoverCustomersResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMyCoverCustomersResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMyCoverCustomersResponse clone() => GetMyCoverCustomersResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMyCoverCustomersResponse copyWith(void Function(GetMyCoverCustomersResponse) updates) => super.copyWith((message) => updates(message as GetMyCoverCustomersResponse)) as GetMyCoverCustomersResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetMyCoverCustomersResponse create() => GetMyCoverCustomersResponse._();
  GetMyCoverCustomersResponse createEmptyInstance() => create();
  static $pb.PbList<GetMyCoverCustomersResponse> createRepeated() => $pb.PbList<GetMyCoverCustomersResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMyCoverCustomersResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMyCoverCustomersResponse>(create);
  static GetMyCoverCustomersResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<MyCoverCustomer> get customers => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => clearField(2);
}

class GetMyCoverCustomerByIdRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetMyCoverCustomerByIdRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'customerId')
    ..hasRequiredFields = false
  ;

  GetMyCoverCustomerByIdRequest._() : super();
  factory GetMyCoverCustomerByIdRequest({
    $core.String? customerId,
  }) {
    final _result = create();
    if (customerId != null) {
      _result.customerId = customerId;
    }
    return _result;
  }
  factory GetMyCoverCustomerByIdRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMyCoverCustomerByIdRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMyCoverCustomerByIdRequest clone() => GetMyCoverCustomerByIdRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMyCoverCustomerByIdRequest copyWith(void Function(GetMyCoverCustomerByIdRequest) updates) => super.copyWith((message) => updates(message as GetMyCoverCustomerByIdRequest)) as GetMyCoverCustomerByIdRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetMyCoverCustomerByIdRequest create() => GetMyCoverCustomerByIdRequest._();
  GetMyCoverCustomerByIdRequest createEmptyInstance() => create();
  static $pb.PbList<GetMyCoverCustomerByIdRequest> createRepeated() => $pb.PbList<GetMyCoverCustomerByIdRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMyCoverCustomerByIdRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMyCoverCustomerByIdRequest>(create);
  static GetMyCoverCustomerByIdRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get customerId => $_getSZ(0);
  @$pb.TagNumber(1)
  set customerId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCustomerId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCustomerId() => clearField(1);
}

class GetMyCoverCustomerByIdResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetMyCoverCustomerByIdResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOM<MyCoverCustomer>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'customer', subBuilder: MyCoverCustomer.create)
    ..hasRequiredFields = false
  ;

  GetMyCoverCustomerByIdResponse._() : super();
  factory GetMyCoverCustomerByIdResponse({
    MyCoverCustomer? customer,
  }) {
    final _result = create();
    if (customer != null) {
      _result.customer = customer;
    }
    return _result;
  }
  factory GetMyCoverCustomerByIdResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMyCoverCustomerByIdResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMyCoverCustomerByIdResponse clone() => GetMyCoverCustomerByIdResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMyCoverCustomerByIdResponse copyWith(void Function(GetMyCoverCustomerByIdResponse) updates) => super.copyWith((message) => updates(message as GetMyCoverCustomerByIdResponse)) as GetMyCoverCustomerByIdResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetMyCoverCustomerByIdResponse create() => GetMyCoverCustomerByIdResponse._();
  GetMyCoverCustomerByIdResponse createEmptyInstance() => create();
  static $pb.PbList<GetMyCoverCustomerByIdResponse> createRepeated() => $pb.PbList<GetMyCoverCustomerByIdResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMyCoverCustomerByIdResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMyCoverCustomerByIdResponse>(create);
  static GetMyCoverCustomerByIdResponse? _defaultInstance;

  @$pb.TagNumber(1)
  MyCoverCustomer get customer => $_getN(0);
  @$pb.TagNumber(1)
  set customer(MyCoverCustomer v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasCustomer() => $_has(0);
  @$pb.TagNumber(1)
  void clearCustomer() => clearField(1);
  @$pb.TagNumber(1)
  MyCoverCustomer ensureCustomer() => $_ensure(0);
}

class GetMyCoverCustomerPoliciesRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetMyCoverCustomerPoliciesRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'customerId')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetMyCoverCustomerPoliciesRequest._() : super();
  factory GetMyCoverCustomerPoliciesRequest({
    $core.String? customerId,
    $core.int? page,
    $core.int? limit,
  }) {
    final _result = create();
    if (customerId != null) {
      _result.customerId = customerId;
    }
    if (page != null) {
      _result.page = page;
    }
    if (limit != null) {
      _result.limit = limit;
    }
    return _result;
  }
  factory GetMyCoverCustomerPoliciesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMyCoverCustomerPoliciesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMyCoverCustomerPoliciesRequest clone() => GetMyCoverCustomerPoliciesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMyCoverCustomerPoliciesRequest copyWith(void Function(GetMyCoverCustomerPoliciesRequest) updates) => super.copyWith((message) => updates(message as GetMyCoverCustomerPoliciesRequest)) as GetMyCoverCustomerPoliciesRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetMyCoverCustomerPoliciesRequest create() => GetMyCoverCustomerPoliciesRequest._();
  GetMyCoverCustomerPoliciesRequest createEmptyInstance() => create();
  static $pb.PbList<GetMyCoverCustomerPoliciesRequest> createRepeated() => $pb.PbList<GetMyCoverCustomerPoliciesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMyCoverCustomerPoliciesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMyCoverCustomerPoliciesRequest>(create);
  static GetMyCoverCustomerPoliciesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get customerId => $_getSZ(0);
  @$pb.TagNumber(1)
  set customerId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCustomerId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCustomerId() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get page => $_getIZ(1);
  @$pb.TagNumber(2)
  set page($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPage() => $_has(1);
  @$pb.TagNumber(2)
  void clearPage() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get limit => $_getIZ(2);
  @$pb.TagNumber(3)
  set limit($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasLimit() => $_has(2);
  @$pb.TagNumber(3)
  void clearLimit() => clearField(3);
}

class GetMyCoverCustomerPoliciesResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetMyCoverCustomerPoliciesResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..pc<InsurancePolicyDetail>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'policies', $pb.PbFieldType.PM, subBuilder: InsurancePolicyDetail.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetMyCoverCustomerPoliciesResponse._() : super();
  factory GetMyCoverCustomerPoliciesResponse({
    $core.Iterable<InsurancePolicyDetail>? policies,
    $core.int? total,
  }) {
    final _result = create();
    if (policies != null) {
      _result.policies.addAll(policies);
    }
    if (total != null) {
      _result.total = total;
    }
    return _result;
  }
  factory GetMyCoverCustomerPoliciesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMyCoverCustomerPoliciesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMyCoverCustomerPoliciesResponse clone() => GetMyCoverCustomerPoliciesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMyCoverCustomerPoliciesResponse copyWith(void Function(GetMyCoverCustomerPoliciesResponse) updates) => super.copyWith((message) => updates(message as GetMyCoverCustomerPoliciesResponse)) as GetMyCoverCustomerPoliciesResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetMyCoverCustomerPoliciesResponse create() => GetMyCoverCustomerPoliciesResponse._();
  GetMyCoverCustomerPoliciesResponse createEmptyInstance() => create();
  static $pb.PbList<GetMyCoverCustomerPoliciesResponse> createRepeated() => $pb.PbList<GetMyCoverCustomerPoliciesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMyCoverCustomerPoliciesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMyCoverCustomerPoliciesResponse>(create);
  static GetMyCoverCustomerPoliciesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<InsurancePolicyDetail> get policies => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => clearField(2);
}

class GetMyCoverCustomerPurchasesRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetMyCoverCustomerPurchasesRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'customerId')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetMyCoverCustomerPurchasesRequest._() : super();
  factory GetMyCoverCustomerPurchasesRequest({
    $core.String? customerId,
    $core.int? page,
    $core.int? limit,
  }) {
    final _result = create();
    if (customerId != null) {
      _result.customerId = customerId;
    }
    if (page != null) {
      _result.page = page;
    }
    if (limit != null) {
      _result.limit = limit;
    }
    return _result;
  }
  factory GetMyCoverCustomerPurchasesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMyCoverCustomerPurchasesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMyCoverCustomerPurchasesRequest clone() => GetMyCoverCustomerPurchasesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMyCoverCustomerPurchasesRequest copyWith(void Function(GetMyCoverCustomerPurchasesRequest) updates) => super.copyWith((message) => updates(message as GetMyCoverCustomerPurchasesRequest)) as GetMyCoverCustomerPurchasesRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetMyCoverCustomerPurchasesRequest create() => GetMyCoverCustomerPurchasesRequest._();
  GetMyCoverCustomerPurchasesRequest createEmptyInstance() => create();
  static $pb.PbList<GetMyCoverCustomerPurchasesRequest> createRepeated() => $pb.PbList<GetMyCoverCustomerPurchasesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMyCoverCustomerPurchasesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMyCoverCustomerPurchasesRequest>(create);
  static GetMyCoverCustomerPurchasesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get customerId => $_getSZ(0);
  @$pb.TagNumber(1)
  set customerId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCustomerId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCustomerId() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get page => $_getIZ(1);
  @$pb.TagNumber(2)
  set page($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPage() => $_has(1);
  @$pb.TagNumber(2)
  void clearPage() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get limit => $_getIZ(2);
  @$pb.TagNumber(3)
  set limit($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasLimit() => $_has(2);
  @$pb.TagNumber(3)
  void clearLimit() => clearField(3);
}

class GetMyCoverCustomerPurchasesResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetMyCoverCustomerPurchasesResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..pc<MyCoverPurchase>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'purchases', $pb.PbFieldType.PM, subBuilder: MyCoverPurchase.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetMyCoverCustomerPurchasesResponse._() : super();
  factory GetMyCoverCustomerPurchasesResponse({
    $core.Iterable<MyCoverPurchase>? purchases,
    $core.int? total,
  }) {
    final _result = create();
    if (purchases != null) {
      _result.purchases.addAll(purchases);
    }
    if (total != null) {
      _result.total = total;
    }
    return _result;
  }
  factory GetMyCoverCustomerPurchasesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMyCoverCustomerPurchasesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMyCoverCustomerPurchasesResponse clone() => GetMyCoverCustomerPurchasesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMyCoverCustomerPurchasesResponse copyWith(void Function(GetMyCoverCustomerPurchasesResponse) updates) => super.copyWith((message) => updates(message as GetMyCoverCustomerPurchasesResponse)) as GetMyCoverCustomerPurchasesResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetMyCoverCustomerPurchasesResponse create() => GetMyCoverCustomerPurchasesResponse._();
  GetMyCoverCustomerPurchasesResponse createEmptyInstance() => create();
  static $pb.PbList<GetMyCoverCustomerPurchasesResponse> createRepeated() => $pb.PbList<GetMyCoverCustomerPurchasesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMyCoverCustomerPurchasesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMyCoverCustomerPurchasesResponse>(create);
  static GetMyCoverCustomerPurchasesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<MyCoverPurchase> get purchases => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => clearField(2);
}

class GetMyCoverPurchasesRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetMyCoverPurchasesRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetMyCoverPurchasesRequest._() : super();
  factory GetMyCoverPurchasesRequest({
    $core.int? page,
    $core.int? limit,
  }) {
    final _result = create();
    if (page != null) {
      _result.page = page;
    }
    if (limit != null) {
      _result.limit = limit;
    }
    return _result;
  }
  factory GetMyCoverPurchasesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMyCoverPurchasesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMyCoverPurchasesRequest clone() => GetMyCoverPurchasesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMyCoverPurchasesRequest copyWith(void Function(GetMyCoverPurchasesRequest) updates) => super.copyWith((message) => updates(message as GetMyCoverPurchasesRequest)) as GetMyCoverPurchasesRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetMyCoverPurchasesRequest create() => GetMyCoverPurchasesRequest._();
  GetMyCoverPurchasesRequest createEmptyInstance() => create();
  static $pb.PbList<GetMyCoverPurchasesRequest> createRepeated() => $pb.PbList<GetMyCoverPurchasesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMyCoverPurchasesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMyCoverPurchasesRequest>(create);
  static GetMyCoverPurchasesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get page => $_getIZ(0);
  @$pb.TagNumber(1)
  set page($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearPage() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get limit => $_getIZ(1);
  @$pb.TagNumber(2)
  set limit($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearLimit() => clearField(2);
}

class GetMyCoverPurchasesResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetMyCoverPurchasesResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..pc<MyCoverPurchase>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'purchases', $pb.PbFieldType.PM, subBuilder: MyCoverPurchase.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetMyCoverPurchasesResponse._() : super();
  factory GetMyCoverPurchasesResponse({
    $core.Iterable<MyCoverPurchase>? purchases,
    $core.int? total,
  }) {
    final _result = create();
    if (purchases != null) {
      _result.purchases.addAll(purchases);
    }
    if (total != null) {
      _result.total = total;
    }
    return _result;
  }
  factory GetMyCoverPurchasesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMyCoverPurchasesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMyCoverPurchasesResponse clone() => GetMyCoverPurchasesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMyCoverPurchasesResponse copyWith(void Function(GetMyCoverPurchasesResponse) updates) => super.copyWith((message) => updates(message as GetMyCoverPurchasesResponse)) as GetMyCoverPurchasesResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetMyCoverPurchasesResponse create() => GetMyCoverPurchasesResponse._();
  GetMyCoverPurchasesResponse createEmptyInstance() => create();
  static $pb.PbList<GetMyCoverPurchasesResponse> createRepeated() => $pb.PbList<GetMyCoverPurchasesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMyCoverPurchasesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMyCoverPurchasesResponse>(create);
  static GetMyCoverPurchasesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<MyCoverPurchase> get purchases => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => clearField(2);
}

class GetMyCoverPurchaseByIdRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetMyCoverPurchaseByIdRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'purchaseId')
    ..hasRequiredFields = false
  ;

  GetMyCoverPurchaseByIdRequest._() : super();
  factory GetMyCoverPurchaseByIdRequest({
    $core.String? purchaseId,
  }) {
    final _result = create();
    if (purchaseId != null) {
      _result.purchaseId = purchaseId;
    }
    return _result;
  }
  factory GetMyCoverPurchaseByIdRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMyCoverPurchaseByIdRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMyCoverPurchaseByIdRequest clone() => GetMyCoverPurchaseByIdRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMyCoverPurchaseByIdRequest copyWith(void Function(GetMyCoverPurchaseByIdRequest) updates) => super.copyWith((message) => updates(message as GetMyCoverPurchaseByIdRequest)) as GetMyCoverPurchaseByIdRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetMyCoverPurchaseByIdRequest create() => GetMyCoverPurchaseByIdRequest._();
  GetMyCoverPurchaseByIdRequest createEmptyInstance() => create();
  static $pb.PbList<GetMyCoverPurchaseByIdRequest> createRepeated() => $pb.PbList<GetMyCoverPurchaseByIdRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMyCoverPurchaseByIdRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMyCoverPurchaseByIdRequest>(create);
  static GetMyCoverPurchaseByIdRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get purchaseId => $_getSZ(0);
  @$pb.TagNumber(1)
  set purchaseId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPurchaseId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPurchaseId() => clearField(1);
}

class GetMyCoverPurchaseByIdResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetMyCoverPurchaseByIdResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOM<MyCoverPurchase>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'purchase', subBuilder: MyCoverPurchase.create)
    ..hasRequiredFields = false
  ;

  GetMyCoverPurchaseByIdResponse._() : super();
  factory GetMyCoverPurchaseByIdResponse({
    MyCoverPurchase? purchase,
  }) {
    final _result = create();
    if (purchase != null) {
      _result.purchase = purchase;
    }
    return _result;
  }
  factory GetMyCoverPurchaseByIdResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMyCoverPurchaseByIdResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMyCoverPurchaseByIdResponse clone() => GetMyCoverPurchaseByIdResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMyCoverPurchaseByIdResponse copyWith(void Function(GetMyCoverPurchaseByIdResponse) updates) => super.copyWith((message) => updates(message as GetMyCoverPurchaseByIdResponse)) as GetMyCoverPurchaseByIdResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetMyCoverPurchaseByIdResponse create() => GetMyCoverPurchaseByIdResponse._();
  GetMyCoverPurchaseByIdResponse createEmptyInstance() => create();
  static $pb.PbList<GetMyCoverPurchaseByIdResponse> createRepeated() => $pb.PbList<GetMyCoverPurchaseByIdResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMyCoverPurchaseByIdResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMyCoverPurchaseByIdResponse>(create);
  static GetMyCoverPurchaseByIdResponse? _defaultInstance;

  @$pb.TagNumber(1)
  MyCoverPurchase get purchase => $_getN(0);
  @$pb.TagNumber(1)
  set purchase(MyCoverPurchase v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasPurchase() => $_has(0);
  @$pb.TagNumber(1)
  void clearPurchase() => clearField(1);
  @$pb.TagNumber(1)
  MyCoverPurchase ensurePurchase() => $_ensure(0);
}

class GetMyCoverClaimsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetMyCoverClaimsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetMyCoverClaimsRequest._() : super();
  factory GetMyCoverClaimsRequest({
    $core.String? status,
    $core.int? page,
    $core.int? limit,
  }) {
    final _result = create();
    if (status != null) {
      _result.status = status;
    }
    if (page != null) {
      _result.page = page;
    }
    if (limit != null) {
      _result.limit = limit;
    }
    return _result;
  }
  factory GetMyCoverClaimsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMyCoverClaimsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMyCoverClaimsRequest clone() => GetMyCoverClaimsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMyCoverClaimsRequest copyWith(void Function(GetMyCoverClaimsRequest) updates) => super.copyWith((message) => updates(message as GetMyCoverClaimsRequest)) as GetMyCoverClaimsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetMyCoverClaimsRequest create() => GetMyCoverClaimsRequest._();
  GetMyCoverClaimsRequest createEmptyInstance() => create();
  static $pb.PbList<GetMyCoverClaimsRequest> createRepeated() => $pb.PbList<GetMyCoverClaimsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMyCoverClaimsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMyCoverClaimsRequest>(create);
  static GetMyCoverClaimsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get status => $_getSZ(0);
  @$pb.TagNumber(1)
  set status($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get page => $_getIZ(1);
  @$pb.TagNumber(2)
  set page($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPage() => $_has(1);
  @$pb.TagNumber(2)
  void clearPage() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get limit => $_getIZ(2);
  @$pb.TagNumber(3)
  set limit($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasLimit() => $_has(2);
  @$pb.TagNumber(3)
  void clearLimit() => clearField(3);
}

class GetMyCoverClaimsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetMyCoverClaimsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..pc<MyCoverClaim>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'claims', $pb.PbFieldType.PM, subBuilder: MyCoverClaim.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetMyCoverClaimsResponse._() : super();
  factory GetMyCoverClaimsResponse({
    $core.Iterable<MyCoverClaim>? claims,
    $core.int? total,
  }) {
    final _result = create();
    if (claims != null) {
      _result.claims.addAll(claims);
    }
    if (total != null) {
      _result.total = total;
    }
    return _result;
  }
  factory GetMyCoverClaimsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMyCoverClaimsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMyCoverClaimsResponse clone() => GetMyCoverClaimsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMyCoverClaimsResponse copyWith(void Function(GetMyCoverClaimsResponse) updates) => super.copyWith((message) => updates(message as GetMyCoverClaimsResponse)) as GetMyCoverClaimsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetMyCoverClaimsResponse create() => GetMyCoverClaimsResponse._();
  GetMyCoverClaimsResponse createEmptyInstance() => create();
  static $pb.PbList<GetMyCoverClaimsResponse> createRepeated() => $pb.PbList<GetMyCoverClaimsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMyCoverClaimsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMyCoverClaimsResponse>(create);
  static GetMyCoverClaimsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<MyCoverClaim> get claims => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => clearField(2);
}

class GetMyCoverClaimByIdRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetMyCoverClaimByIdRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'claimId')
    ..hasRequiredFields = false
  ;

  GetMyCoverClaimByIdRequest._() : super();
  factory GetMyCoverClaimByIdRequest({
    $core.String? claimId,
  }) {
    final _result = create();
    if (claimId != null) {
      _result.claimId = claimId;
    }
    return _result;
  }
  factory GetMyCoverClaimByIdRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMyCoverClaimByIdRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMyCoverClaimByIdRequest clone() => GetMyCoverClaimByIdRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMyCoverClaimByIdRequest copyWith(void Function(GetMyCoverClaimByIdRequest) updates) => super.copyWith((message) => updates(message as GetMyCoverClaimByIdRequest)) as GetMyCoverClaimByIdRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetMyCoverClaimByIdRequest create() => GetMyCoverClaimByIdRequest._();
  GetMyCoverClaimByIdRequest createEmptyInstance() => create();
  static $pb.PbList<GetMyCoverClaimByIdRequest> createRepeated() => $pb.PbList<GetMyCoverClaimByIdRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMyCoverClaimByIdRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMyCoverClaimByIdRequest>(create);
  static GetMyCoverClaimByIdRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get claimId => $_getSZ(0);
  @$pb.TagNumber(1)
  set claimId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasClaimId() => $_has(0);
  @$pb.TagNumber(1)
  void clearClaimId() => clearField(1);
}

class GetMyCoverClaimByIdResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetMyCoverClaimByIdResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOM<MyCoverClaim>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'claim', subBuilder: MyCoverClaim.create)
    ..hasRequiredFields = false
  ;

  GetMyCoverClaimByIdResponse._() : super();
  factory GetMyCoverClaimByIdResponse({
    MyCoverClaim? claim,
  }) {
    final _result = create();
    if (claim != null) {
      _result.claim = claim;
    }
    return _result;
  }
  factory GetMyCoverClaimByIdResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMyCoverClaimByIdResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMyCoverClaimByIdResponse clone() => GetMyCoverClaimByIdResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMyCoverClaimByIdResponse copyWith(void Function(GetMyCoverClaimByIdResponse) updates) => super.copyWith((message) => updates(message as GetMyCoverClaimByIdResponse)) as GetMyCoverClaimByIdResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetMyCoverClaimByIdResponse create() => GetMyCoverClaimByIdResponse._();
  GetMyCoverClaimByIdResponse createEmptyInstance() => create();
  static $pb.PbList<GetMyCoverClaimByIdResponse> createRepeated() => $pb.PbList<GetMyCoverClaimByIdResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMyCoverClaimByIdResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMyCoverClaimByIdResponse>(create);
  static GetMyCoverClaimByIdResponse? _defaultInstance;

  @$pb.TagNumber(1)
  MyCoverClaim get claim => $_getN(0);
  @$pb.TagNumber(1)
  set claim(MyCoverClaim v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasClaim() => $_has(0);
  @$pb.TagNumber(1)
  void clearClaim() => clearField(1);
  @$pb.TagNumber(1)
  MyCoverClaim ensureClaim() => $_ensure(0);
}

class FileCreditLifeClaimRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'FileCreditLifeClaimRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'policyId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'claimType')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..pPS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'documents')
    ..m<$core.String, $core.String>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'additionalInfo', entryClassName: 'FileCreditLifeClaimRequest.AdditionalInfoEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('financialproducts'))
    ..hasRequiredFields = false
  ;

  FileCreditLifeClaimRequest._() : super();
  factory FileCreditLifeClaimRequest({
    $core.String? policyId,
    $core.String? claimType,
    $core.String? description,
    $core.double? amount,
    $core.Iterable<$core.String>? documents,
    $core.Map<$core.String, $core.String>? additionalInfo,
  }) {
    final _result = create();
    if (policyId != null) {
      _result.policyId = policyId;
    }
    if (claimType != null) {
      _result.claimType = claimType;
    }
    if (description != null) {
      _result.description = description;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (documents != null) {
      _result.documents.addAll(documents);
    }
    if (additionalInfo != null) {
      _result.additionalInfo.addAll(additionalInfo);
    }
    return _result;
  }
  factory FileCreditLifeClaimRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FileCreditLifeClaimRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FileCreditLifeClaimRequest clone() => FileCreditLifeClaimRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FileCreditLifeClaimRequest copyWith(void Function(FileCreditLifeClaimRequest) updates) => super.copyWith((message) => updates(message as FileCreditLifeClaimRequest)) as FileCreditLifeClaimRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FileCreditLifeClaimRequest create() => FileCreditLifeClaimRequest._();
  FileCreditLifeClaimRequest createEmptyInstance() => create();
  static $pb.PbList<FileCreditLifeClaimRequest> createRepeated() => $pb.PbList<FileCreditLifeClaimRequest>();
  @$core.pragma('dart2js:noInline')
  static FileCreditLifeClaimRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FileCreditLifeClaimRequest>(create);
  static FileCreditLifeClaimRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get policyId => $_getSZ(0);
  @$pb.TagNumber(1)
  set policyId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPolicyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPolicyId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get claimType => $_getSZ(1);
  @$pb.TagNumber(2)
  set claimType($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasClaimType() => $_has(1);
  @$pb.TagNumber(2)
  void clearClaimType() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get amount => $_getN(3);
  @$pb.TagNumber(4)
  set amount($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearAmount() => clearField(4);

  @$pb.TagNumber(5)
  $core.List<$core.String> get documents => $_getList(4);

  @$pb.TagNumber(6)
  $core.Map<$core.String, $core.String> get additionalInfo => $_getMap(5);
}

class FileCreditLifeClaimResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'FileCreditLifeClaimResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'claimId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'claimNumber')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  FileCreditLifeClaimResponse._() : super();
  factory FileCreditLifeClaimResponse({
    $core.String? claimId,
    $core.String? claimNumber,
    $core.String? status,
    $core.String? message,
  }) {
    final _result = create();
    if (claimId != null) {
      _result.claimId = claimId;
    }
    if (claimNumber != null) {
      _result.claimNumber = claimNumber;
    }
    if (status != null) {
      _result.status = status;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory FileCreditLifeClaimResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FileCreditLifeClaimResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FileCreditLifeClaimResponse clone() => FileCreditLifeClaimResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FileCreditLifeClaimResponse copyWith(void Function(FileCreditLifeClaimResponse) updates) => super.copyWith((message) => updates(message as FileCreditLifeClaimResponse)) as FileCreditLifeClaimResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FileCreditLifeClaimResponse create() => FileCreditLifeClaimResponse._();
  FileCreditLifeClaimResponse createEmptyInstance() => create();
  static $pb.PbList<FileCreditLifeClaimResponse> createRepeated() => $pb.PbList<FileCreditLifeClaimResponse>();
  @$core.pragma('dart2js:noInline')
  static FileCreditLifeClaimResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FileCreditLifeClaimResponse>(create);
  static FileCreditLifeClaimResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get claimId => $_getSZ(0);
  @$pb.TagNumber(1)
  set claimId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasClaimId() => $_has(0);
  @$pb.TagNumber(1)
  void clearClaimId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get claimNumber => $_getSZ(1);
  @$pb.TagNumber(2)
  set claimNumber($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasClaimNumber() => $_has(1);
  @$pb.TagNumber(2)
  void clearClaimNumber() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get status => $_getSZ(2);
  @$pb.TagNumber(3)
  set status($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasStatus() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatus() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get message => $_getSZ(3);
  @$pb.TagNumber(4)
  set message($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasMessage() => $_has(3);
  @$pb.TagNumber(4)
  void clearMessage() => clearField(4);
}

class GetInsuranceStatesRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInsuranceStatesRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GetInsuranceStatesRequest._() : super();
  factory GetInsuranceStatesRequest() => create();
  factory GetInsuranceStatesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInsuranceStatesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInsuranceStatesRequest clone() => GetInsuranceStatesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInsuranceStatesRequest copyWith(void Function(GetInsuranceStatesRequest) updates) => super.copyWith((message) => updates(message as GetInsuranceStatesRequest)) as GetInsuranceStatesRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetInsuranceStatesRequest create() => GetInsuranceStatesRequest._();
  GetInsuranceStatesRequest createEmptyInstance() => create();
  static $pb.PbList<GetInsuranceStatesRequest> createRepeated() => $pb.PbList<GetInsuranceStatesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInsuranceStatesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInsuranceStatesRequest>(create);
  static GetInsuranceStatesRequest? _defaultInstance;
}

class GetInsuranceStatesResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInsuranceStatesResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..pc<InsuranceAuxiliaryItem>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'states', $pb.PbFieldType.PM, subBuilder: InsuranceAuxiliaryItem.create)
    ..hasRequiredFields = false
  ;

  GetInsuranceStatesResponse._() : super();
  factory GetInsuranceStatesResponse({
    $core.Iterable<InsuranceAuxiliaryItem>? states,
  }) {
    final _result = create();
    if (states != null) {
      _result.states.addAll(states);
    }
    return _result;
  }
  factory GetInsuranceStatesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInsuranceStatesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInsuranceStatesResponse clone() => GetInsuranceStatesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInsuranceStatesResponse copyWith(void Function(GetInsuranceStatesResponse) updates) => super.copyWith((message) => updates(message as GetInsuranceStatesResponse)) as GetInsuranceStatesResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetInsuranceStatesResponse create() => GetInsuranceStatesResponse._();
  GetInsuranceStatesResponse createEmptyInstance() => create();
  static $pb.PbList<GetInsuranceStatesResponse> createRepeated() => $pb.PbList<GetInsuranceStatesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInsuranceStatesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInsuranceStatesResponse>(create);
  static GetInsuranceStatesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<InsuranceAuxiliaryItem> get states => $_getList(0);
}

class GetInsuranceVehicleMakesRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInsuranceVehicleMakesRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GetInsuranceVehicleMakesRequest._() : super();
  factory GetInsuranceVehicleMakesRequest() => create();
  factory GetInsuranceVehicleMakesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInsuranceVehicleMakesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInsuranceVehicleMakesRequest clone() => GetInsuranceVehicleMakesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInsuranceVehicleMakesRequest copyWith(void Function(GetInsuranceVehicleMakesRequest) updates) => super.copyWith((message) => updates(message as GetInsuranceVehicleMakesRequest)) as GetInsuranceVehicleMakesRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetInsuranceVehicleMakesRequest create() => GetInsuranceVehicleMakesRequest._();
  GetInsuranceVehicleMakesRequest createEmptyInstance() => create();
  static $pb.PbList<GetInsuranceVehicleMakesRequest> createRepeated() => $pb.PbList<GetInsuranceVehicleMakesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInsuranceVehicleMakesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInsuranceVehicleMakesRequest>(create);
  static GetInsuranceVehicleMakesRequest? _defaultInstance;
}

class GetInsuranceVehicleMakesResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInsuranceVehicleMakesResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..pc<InsuranceAuxiliaryItem>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'makes', $pb.PbFieldType.PM, subBuilder: InsuranceAuxiliaryItem.create)
    ..hasRequiredFields = false
  ;

  GetInsuranceVehicleMakesResponse._() : super();
  factory GetInsuranceVehicleMakesResponse({
    $core.Iterable<InsuranceAuxiliaryItem>? makes,
  }) {
    final _result = create();
    if (makes != null) {
      _result.makes.addAll(makes);
    }
    return _result;
  }
  factory GetInsuranceVehicleMakesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInsuranceVehicleMakesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInsuranceVehicleMakesResponse clone() => GetInsuranceVehicleMakesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInsuranceVehicleMakesResponse copyWith(void Function(GetInsuranceVehicleMakesResponse) updates) => super.copyWith((message) => updates(message as GetInsuranceVehicleMakesResponse)) as GetInsuranceVehicleMakesResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetInsuranceVehicleMakesResponse create() => GetInsuranceVehicleMakesResponse._();
  GetInsuranceVehicleMakesResponse createEmptyInstance() => create();
  static $pb.PbList<GetInsuranceVehicleMakesResponse> createRepeated() => $pb.PbList<GetInsuranceVehicleMakesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInsuranceVehicleMakesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInsuranceVehicleMakesResponse>(create);
  static GetInsuranceVehicleMakesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<InsuranceAuxiliaryItem> get makes => $_getList(0);
}

class InsurancePolicyDetail extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'InsurancePolicyDetail', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'appMode')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'firstName')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lastName')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'email')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'phoneNumber')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dateOfBirth')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'activationDate')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'startDate')
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'expirationDate')
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount')
    ..aOB(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isActive')
    ..aOB(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isSubmittedToProvider')
    ..aOS(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'customerId')
    ..aOS(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'productId')
    ..aOS(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'productCategoryId')
    ..aOS(17, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerId')
    ..aOS(18, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'purchaseId')
    ..aOS(19, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'policyNumber')
    ..aOS(20, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'certificateUrl')
    ..aOS(21, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt')
    ..aOS(22, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedAt')
    ..aOS(23, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerName')
    ..aOS(24, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'productName')
    ..hasRequiredFields = false
  ;

  InsurancePolicyDetail._() : super();
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
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (appMode != null) {
      _result.appMode = appMode;
    }
    if (firstName != null) {
      _result.firstName = firstName;
    }
    if (lastName != null) {
      _result.lastName = lastName;
    }
    if (email != null) {
      _result.email = email;
    }
    if (phoneNumber != null) {
      _result.phoneNumber = phoneNumber;
    }
    if (dateOfBirth != null) {
      _result.dateOfBirth = dateOfBirth;
    }
    if (activationDate != null) {
      _result.activationDate = activationDate;
    }
    if (startDate != null) {
      _result.startDate = startDate;
    }
    if (expirationDate != null) {
      _result.expirationDate = expirationDate;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (isActive != null) {
      _result.isActive = isActive;
    }
    if (isSubmittedToProvider != null) {
      _result.isSubmittedToProvider = isSubmittedToProvider;
    }
    if (customerId != null) {
      _result.customerId = customerId;
    }
    if (productId != null) {
      _result.productId = productId;
    }
    if (productCategoryId != null) {
      _result.productCategoryId = productCategoryId;
    }
    if (providerId != null) {
      _result.providerId = providerId;
    }
    if (purchaseId != null) {
      _result.purchaseId = purchaseId;
    }
    if (policyNumber != null) {
      _result.policyNumber = policyNumber;
    }
    if (certificateUrl != null) {
      _result.certificateUrl = certificateUrl;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      _result.updatedAt = updatedAt;
    }
    if (providerName != null) {
      _result.providerName = providerName;
    }
    if (productName != null) {
      _result.productName = productName;
    }
    return _result;
  }
  factory InsurancePolicyDetail.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InsurancePolicyDetail.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InsurancePolicyDetail clone() => InsurancePolicyDetail()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InsurancePolicyDetail copyWith(void Function(InsurancePolicyDetail) updates) => super.copyWith((message) => updates(message as InsurancePolicyDetail)) as InsurancePolicyDetail; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static InsurancePolicyDetail create() => InsurancePolicyDetail._();
  InsurancePolicyDetail createEmptyInstance() => create();
  static $pb.PbList<InsurancePolicyDetail> createRepeated() => $pb.PbList<InsurancePolicyDetail>();
  @$core.pragma('dart2js:noInline')
  static InsurancePolicyDetail getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InsurancePolicyDetail>(create);
  static InsurancePolicyDetail? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get appMode => $_getSZ(1);
  @$pb.TagNumber(2)
  set appMode($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAppMode() => $_has(1);
  @$pb.TagNumber(2)
  void clearAppMode() => clearField(2);

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
  $core.String get email => $_getSZ(4);
  @$pb.TagNumber(5)
  set email($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasEmail() => $_has(4);
  @$pb.TagNumber(5)
  void clearEmail() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get phoneNumber => $_getSZ(5);
  @$pb.TagNumber(6)
  set phoneNumber($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasPhoneNumber() => $_has(5);
  @$pb.TagNumber(6)
  void clearPhoneNumber() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get dateOfBirth => $_getSZ(6);
  @$pb.TagNumber(7)
  set dateOfBirth($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasDateOfBirth() => $_has(6);
  @$pb.TagNumber(7)
  void clearDateOfBirth() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get activationDate => $_getSZ(7);
  @$pb.TagNumber(8)
  set activationDate($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasActivationDate() => $_has(7);
  @$pb.TagNumber(8)
  void clearActivationDate() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get startDate => $_getSZ(8);
  @$pb.TagNumber(9)
  set startDate($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasStartDate() => $_has(8);
  @$pb.TagNumber(9)
  void clearStartDate() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get expirationDate => $_getSZ(9);
  @$pb.TagNumber(10)
  set expirationDate($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasExpirationDate() => $_has(9);
  @$pb.TagNumber(10)
  void clearExpirationDate() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get amount => $_getSZ(10);
  @$pb.TagNumber(11)
  set amount($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasAmount() => $_has(10);
  @$pb.TagNumber(11)
  void clearAmount() => clearField(11);

  @$pb.TagNumber(12)
  $core.bool get isActive => $_getBF(11);
  @$pb.TagNumber(12)
  set isActive($core.bool v) { $_setBool(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasIsActive() => $_has(11);
  @$pb.TagNumber(12)
  void clearIsActive() => clearField(12);

  @$pb.TagNumber(13)
  $core.bool get isSubmittedToProvider => $_getBF(12);
  @$pb.TagNumber(13)
  set isSubmittedToProvider($core.bool v) { $_setBool(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasIsSubmittedToProvider() => $_has(12);
  @$pb.TagNumber(13)
  void clearIsSubmittedToProvider() => clearField(13);

  @$pb.TagNumber(14)
  $core.String get customerId => $_getSZ(13);
  @$pb.TagNumber(14)
  set customerId($core.String v) { $_setString(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasCustomerId() => $_has(13);
  @$pb.TagNumber(14)
  void clearCustomerId() => clearField(14);

  @$pb.TagNumber(15)
  $core.String get productId => $_getSZ(14);
  @$pb.TagNumber(15)
  set productId($core.String v) { $_setString(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasProductId() => $_has(14);
  @$pb.TagNumber(15)
  void clearProductId() => clearField(15);

  @$pb.TagNumber(16)
  $core.String get productCategoryId => $_getSZ(15);
  @$pb.TagNumber(16)
  set productCategoryId($core.String v) { $_setString(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasProductCategoryId() => $_has(15);
  @$pb.TagNumber(16)
  void clearProductCategoryId() => clearField(16);

  @$pb.TagNumber(17)
  $core.String get providerId => $_getSZ(16);
  @$pb.TagNumber(17)
  set providerId($core.String v) { $_setString(16, v); }
  @$pb.TagNumber(17)
  $core.bool hasProviderId() => $_has(16);
  @$pb.TagNumber(17)
  void clearProviderId() => clearField(17);

  @$pb.TagNumber(18)
  $core.String get purchaseId => $_getSZ(17);
  @$pb.TagNumber(18)
  set purchaseId($core.String v) { $_setString(17, v); }
  @$pb.TagNumber(18)
  $core.bool hasPurchaseId() => $_has(17);
  @$pb.TagNumber(18)
  void clearPurchaseId() => clearField(18);

  @$pb.TagNumber(19)
  $core.String get policyNumber => $_getSZ(18);
  @$pb.TagNumber(19)
  set policyNumber($core.String v) { $_setString(18, v); }
  @$pb.TagNumber(19)
  $core.bool hasPolicyNumber() => $_has(18);
  @$pb.TagNumber(19)
  void clearPolicyNumber() => clearField(19);

  @$pb.TagNumber(20)
  $core.String get certificateUrl => $_getSZ(19);
  @$pb.TagNumber(20)
  set certificateUrl($core.String v) { $_setString(19, v); }
  @$pb.TagNumber(20)
  $core.bool hasCertificateUrl() => $_has(19);
  @$pb.TagNumber(20)
  void clearCertificateUrl() => clearField(20);

  @$pb.TagNumber(21)
  $core.String get createdAt => $_getSZ(20);
  @$pb.TagNumber(21)
  set createdAt($core.String v) { $_setString(20, v); }
  @$pb.TagNumber(21)
  $core.bool hasCreatedAt() => $_has(20);
  @$pb.TagNumber(21)
  void clearCreatedAt() => clearField(21);

  @$pb.TagNumber(22)
  $core.String get updatedAt => $_getSZ(21);
  @$pb.TagNumber(22)
  set updatedAt($core.String v) { $_setString(21, v); }
  @$pb.TagNumber(22)
  $core.bool hasUpdatedAt() => $_has(21);
  @$pb.TagNumber(22)
  void clearUpdatedAt() => clearField(22);

  @$pb.TagNumber(23)
  $core.String get providerName => $_getSZ(22);
  @$pb.TagNumber(23)
  set providerName($core.String v) { $_setString(22, v); }
  @$pb.TagNumber(23)
  $core.bool hasProviderName() => $_has(22);
  @$pb.TagNumber(23)
  void clearProviderName() => clearField(23);

  @$pb.TagNumber(24)
  $core.String get productName => $_getSZ(23);
  @$pb.TagNumber(24)
  set productName($core.String v) { $_setString(23, v); }
  @$pb.TagNumber(24)
  $core.bool hasProductName() => $_has(23);
  @$pb.TagNumber(24)
  void clearProductName() => clearField(24);
}

class MyCoverNotificationPreference extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MyCoverNotificationPreference', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'key')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'category')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'label')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..aOB(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'enabled')
    ..hasRequiredFields = false
  ;

  MyCoverNotificationPreference._() : super();
  factory MyCoverNotificationPreference({
    $core.String? key,
    $core.String? category,
    $core.String? label,
    $core.String? description,
    $core.bool? enabled,
  }) {
    final _result = create();
    if (key != null) {
      _result.key = key;
    }
    if (category != null) {
      _result.category = category;
    }
    if (label != null) {
      _result.label = label;
    }
    if (description != null) {
      _result.description = description;
    }
    if (enabled != null) {
      _result.enabled = enabled;
    }
    return _result;
  }
  factory MyCoverNotificationPreference.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MyCoverNotificationPreference.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MyCoverNotificationPreference clone() => MyCoverNotificationPreference()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MyCoverNotificationPreference copyWith(void Function(MyCoverNotificationPreference) updates) => super.copyWith((message) => updates(message as MyCoverNotificationPreference)) as MyCoverNotificationPreference; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MyCoverNotificationPreference create() => MyCoverNotificationPreference._();
  MyCoverNotificationPreference createEmptyInstance() => create();
  static $pb.PbList<MyCoverNotificationPreference> createRepeated() => $pb.PbList<MyCoverNotificationPreference>();
  @$core.pragma('dart2js:noInline')
  static MyCoverNotificationPreference getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MyCoverNotificationPreference>(create);
  static MyCoverNotificationPreference? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get key => $_getSZ(0);
  @$pb.TagNumber(1)
  set key($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearKey() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get category => $_getSZ(1);
  @$pb.TagNumber(2)
  set category($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCategory() => $_has(1);
  @$pb.TagNumber(2)
  void clearCategory() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get label => $_getSZ(2);
  @$pb.TagNumber(3)
  set label($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasLabel() => $_has(2);
  @$pb.TagNumber(3)
  void clearLabel() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get description => $_getSZ(3);
  @$pb.TagNumber(4)
  set description($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasDescription() => $_has(3);
  @$pb.TagNumber(4)
  void clearDescription() => clearField(4);

  @$pb.TagNumber(5)
  $core.bool get enabled => $_getBF(4);
  @$pb.TagNumber(5)
  set enabled($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasEnabled() => $_has(4);
  @$pb.TagNumber(5)
  void clearEnabled() => clearField(5);
}

class GetMyCoverNotificationPreferencesRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetMyCoverNotificationPreferencesRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GetMyCoverNotificationPreferencesRequest._() : super();
  factory GetMyCoverNotificationPreferencesRequest() => create();
  factory GetMyCoverNotificationPreferencesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMyCoverNotificationPreferencesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMyCoverNotificationPreferencesRequest clone() => GetMyCoverNotificationPreferencesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMyCoverNotificationPreferencesRequest copyWith(void Function(GetMyCoverNotificationPreferencesRequest) updates) => super.copyWith((message) => updates(message as GetMyCoverNotificationPreferencesRequest)) as GetMyCoverNotificationPreferencesRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetMyCoverNotificationPreferencesRequest create() => GetMyCoverNotificationPreferencesRequest._();
  GetMyCoverNotificationPreferencesRequest createEmptyInstance() => create();
  static $pb.PbList<GetMyCoverNotificationPreferencesRequest> createRepeated() => $pb.PbList<GetMyCoverNotificationPreferencesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMyCoverNotificationPreferencesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMyCoverNotificationPreferencesRequest>(create);
  static GetMyCoverNotificationPreferencesRequest? _defaultInstance;
}

class GetMyCoverNotificationPreferencesResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetMyCoverNotificationPreferencesResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..pc<MyCoverNotificationPreference>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'preferences', $pb.PbFieldType.PM, subBuilder: MyCoverNotificationPreference.create)
    ..hasRequiredFields = false
  ;

  GetMyCoverNotificationPreferencesResponse._() : super();
  factory GetMyCoverNotificationPreferencesResponse({
    $core.Iterable<MyCoverNotificationPreference>? preferences,
  }) {
    final _result = create();
    if (preferences != null) {
      _result.preferences.addAll(preferences);
    }
    return _result;
  }
  factory GetMyCoverNotificationPreferencesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMyCoverNotificationPreferencesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMyCoverNotificationPreferencesResponse clone() => GetMyCoverNotificationPreferencesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMyCoverNotificationPreferencesResponse copyWith(void Function(GetMyCoverNotificationPreferencesResponse) updates) => super.copyWith((message) => updates(message as GetMyCoverNotificationPreferencesResponse)) as GetMyCoverNotificationPreferencesResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetMyCoverNotificationPreferencesResponse create() => GetMyCoverNotificationPreferencesResponse._();
  GetMyCoverNotificationPreferencesResponse createEmptyInstance() => create();
  static $pb.PbList<GetMyCoverNotificationPreferencesResponse> createRepeated() => $pb.PbList<GetMyCoverNotificationPreferencesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMyCoverNotificationPreferencesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMyCoverNotificationPreferencesResponse>(create);
  static GetMyCoverNotificationPreferencesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<MyCoverNotificationPreference> get preferences => $_getList(0);
}

class UpdateMyCoverNotificationPreferencesRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateMyCoverNotificationPreferencesRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..pc<MyCoverNotificationPreference>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'preferences', $pb.PbFieldType.PM, subBuilder: MyCoverNotificationPreference.create)
    ..hasRequiredFields = false
  ;

  UpdateMyCoverNotificationPreferencesRequest._() : super();
  factory UpdateMyCoverNotificationPreferencesRequest({
    $core.Iterable<MyCoverNotificationPreference>? preferences,
  }) {
    final _result = create();
    if (preferences != null) {
      _result.preferences.addAll(preferences);
    }
    return _result;
  }
  factory UpdateMyCoverNotificationPreferencesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateMyCoverNotificationPreferencesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateMyCoverNotificationPreferencesRequest clone() => UpdateMyCoverNotificationPreferencesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateMyCoverNotificationPreferencesRequest copyWith(void Function(UpdateMyCoverNotificationPreferencesRequest) updates) => super.copyWith((message) => updates(message as UpdateMyCoverNotificationPreferencesRequest)) as UpdateMyCoverNotificationPreferencesRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UpdateMyCoverNotificationPreferencesRequest create() => UpdateMyCoverNotificationPreferencesRequest._();
  UpdateMyCoverNotificationPreferencesRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateMyCoverNotificationPreferencesRequest> createRepeated() => $pb.PbList<UpdateMyCoverNotificationPreferencesRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateMyCoverNotificationPreferencesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateMyCoverNotificationPreferencesRequest>(create);
  static UpdateMyCoverNotificationPreferencesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<MyCoverNotificationPreference> get preferences => $_getList(0);
}

class UpdateMyCoverNotificationPreferencesResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateMyCoverNotificationPreferencesResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  UpdateMyCoverNotificationPreferencesResponse._() : super();
  factory UpdateMyCoverNotificationPreferencesResponse({
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
  factory UpdateMyCoverNotificationPreferencesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateMyCoverNotificationPreferencesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateMyCoverNotificationPreferencesResponse clone() => UpdateMyCoverNotificationPreferencesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateMyCoverNotificationPreferencesResponse copyWith(void Function(UpdateMyCoverNotificationPreferencesResponse) updates) => super.copyWith((message) => updates(message as UpdateMyCoverNotificationPreferencesResponse)) as UpdateMyCoverNotificationPreferencesResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UpdateMyCoverNotificationPreferencesResponse create() => UpdateMyCoverNotificationPreferencesResponse._();
  UpdateMyCoverNotificationPreferencesResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateMyCoverNotificationPreferencesResponse> createRepeated() => $pb.PbList<UpdateMyCoverNotificationPreferencesResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateMyCoverNotificationPreferencesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateMyCoverNotificationPreferencesResponse>(create);
  static UpdateMyCoverNotificationPreferencesResponse? _defaultInstance;

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

class GetMyCoverWalletBalanceRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetMyCoverWalletBalanceRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GetMyCoverWalletBalanceRequest._() : super();
  factory GetMyCoverWalletBalanceRequest() => create();
  factory GetMyCoverWalletBalanceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMyCoverWalletBalanceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMyCoverWalletBalanceRequest clone() => GetMyCoverWalletBalanceRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMyCoverWalletBalanceRequest copyWith(void Function(GetMyCoverWalletBalanceRequest) updates) => super.copyWith((message) => updates(message as GetMyCoverWalletBalanceRequest)) as GetMyCoverWalletBalanceRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetMyCoverWalletBalanceRequest create() => GetMyCoverWalletBalanceRequest._();
  GetMyCoverWalletBalanceRequest createEmptyInstance() => create();
  static $pb.PbList<GetMyCoverWalletBalanceRequest> createRepeated() => $pb.PbList<GetMyCoverWalletBalanceRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMyCoverWalletBalanceRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMyCoverWalletBalanceRequest>(create);
  static GetMyCoverWalletBalanceRequest? _defaultInstance;
}

class GetMyCoverWalletBalanceResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetMyCoverWalletBalanceResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..a<$core.double>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'balance', $pb.PbFieldType.OD)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  GetMyCoverWalletBalanceResponse._() : super();
  factory GetMyCoverWalletBalanceResponse({
    $core.double? balance,
    $core.String? currency,
    $core.bool? success,
    $core.String? message,
  }) {
    final _result = create();
    if (balance != null) {
      _result.balance = balance;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory GetMyCoverWalletBalanceResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMyCoverWalletBalanceResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMyCoverWalletBalanceResponse clone() => GetMyCoverWalletBalanceResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMyCoverWalletBalanceResponse copyWith(void Function(GetMyCoverWalletBalanceResponse) updates) => super.copyWith((message) => updates(message as GetMyCoverWalletBalanceResponse)) as GetMyCoverWalletBalanceResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetMyCoverWalletBalanceResponse create() => GetMyCoverWalletBalanceResponse._();
  GetMyCoverWalletBalanceResponse createEmptyInstance() => create();
  static $pb.PbList<GetMyCoverWalletBalanceResponse> createRepeated() => $pb.PbList<GetMyCoverWalletBalanceResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMyCoverWalletBalanceResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMyCoverWalletBalanceResponse>(create);
  static GetMyCoverWalletBalanceResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get balance => $_getN(0);
  @$pb.TagNumber(1)
  set balance($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasBalance() => $_has(0);
  @$pb.TagNumber(1)
  void clearBalance() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get currency => $_getSZ(1);
  @$pb.TagNumber(2)
  set currency($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCurrency() => $_has(1);
  @$pb.TagNumber(2)
  void clearCurrency() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get success => $_getBF(2);
  @$pb.TagNumber(3)
  set success($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSuccess() => $_has(2);
  @$pb.TagNumber(3)
  void clearSuccess() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get message => $_getSZ(3);
  @$pb.TagNumber(4)
  set message($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasMessage() => $_has(3);
  @$pb.TagNumber(4)
  void clearMessage() => clearField(4);
}

class RequestInsuranceRefundRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RequestInsuranceRefundRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'policyReference')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reason')
    ..hasRequiredFields = false
  ;

  RequestInsuranceRefundRequest._() : super();
  factory RequestInsuranceRefundRequest({
    $core.String? policyReference,
    $core.String? reason,
  }) {
    final _result = create();
    if (policyReference != null) {
      _result.policyReference = policyReference;
    }
    if (reason != null) {
      _result.reason = reason;
    }
    return _result;
  }
  factory RequestInsuranceRefundRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RequestInsuranceRefundRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RequestInsuranceRefundRequest clone() => RequestInsuranceRefundRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RequestInsuranceRefundRequest copyWith(void Function(RequestInsuranceRefundRequest) updates) => super.copyWith((message) => updates(message as RequestInsuranceRefundRequest)) as RequestInsuranceRefundRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RequestInsuranceRefundRequest create() => RequestInsuranceRefundRequest._();
  RequestInsuranceRefundRequest createEmptyInstance() => create();
  static $pb.PbList<RequestInsuranceRefundRequest> createRepeated() => $pb.PbList<RequestInsuranceRefundRequest>();
  @$core.pragma('dart2js:noInline')
  static RequestInsuranceRefundRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RequestInsuranceRefundRequest>(create);
  static RequestInsuranceRefundRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get policyReference => $_getSZ(0);
  @$pb.TagNumber(1)
  set policyReference($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPolicyReference() => $_has(0);
  @$pb.TagNumber(1)
  void clearPolicyReference() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get reason => $_getSZ(1);
  @$pb.TagNumber(2)
  set reason($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasReason() => $_has(1);
  @$pb.TagNumber(2)
  void clearReason() => clearField(2);
}

class RequestInsuranceRefundResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RequestInsuranceRefundResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOM<InsuranceRefundInfo>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'refund', subBuilder: InsuranceRefundInfo.create)
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  RequestInsuranceRefundResponse._() : super();
  factory RequestInsuranceRefundResponse({
    InsuranceRefundInfo? refund,
    $core.bool? success,
    $core.String? message,
  }) {
    final _result = create();
    if (refund != null) {
      _result.refund = refund;
    }
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory RequestInsuranceRefundResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RequestInsuranceRefundResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RequestInsuranceRefundResponse clone() => RequestInsuranceRefundResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RequestInsuranceRefundResponse copyWith(void Function(RequestInsuranceRefundResponse) updates) => super.copyWith((message) => updates(message as RequestInsuranceRefundResponse)) as RequestInsuranceRefundResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RequestInsuranceRefundResponse create() => RequestInsuranceRefundResponse._();
  RequestInsuranceRefundResponse createEmptyInstance() => create();
  static $pb.PbList<RequestInsuranceRefundResponse> createRepeated() => $pb.PbList<RequestInsuranceRefundResponse>();
  @$core.pragma('dart2js:noInline')
  static RequestInsuranceRefundResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RequestInsuranceRefundResponse>(create);
  static RequestInsuranceRefundResponse? _defaultInstance;

  @$pb.TagNumber(1)
  InsuranceRefundInfo get refund => $_getN(0);
  @$pb.TagNumber(1)
  set refund(InsuranceRefundInfo v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasRefund() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefund() => clearField(1);
  @$pb.TagNumber(1)
  InsuranceRefundInfo ensureRefund() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => clearField(3);
}

class GetInsuranceRefundStatusRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInsuranceRefundStatusRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'policyReference')
    ..hasRequiredFields = false
  ;

  GetInsuranceRefundStatusRequest._() : super();
  factory GetInsuranceRefundStatusRequest({
    $core.String? policyReference,
  }) {
    final _result = create();
    if (policyReference != null) {
      _result.policyReference = policyReference;
    }
    return _result;
  }
  factory GetInsuranceRefundStatusRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInsuranceRefundStatusRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInsuranceRefundStatusRequest clone() => GetInsuranceRefundStatusRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInsuranceRefundStatusRequest copyWith(void Function(GetInsuranceRefundStatusRequest) updates) => super.copyWith((message) => updates(message as GetInsuranceRefundStatusRequest)) as GetInsuranceRefundStatusRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetInsuranceRefundStatusRequest create() => GetInsuranceRefundStatusRequest._();
  GetInsuranceRefundStatusRequest createEmptyInstance() => create();
  static $pb.PbList<GetInsuranceRefundStatusRequest> createRepeated() => $pb.PbList<GetInsuranceRefundStatusRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInsuranceRefundStatusRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInsuranceRefundStatusRequest>(create);
  static GetInsuranceRefundStatusRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get policyReference => $_getSZ(0);
  @$pb.TagNumber(1)
  set policyReference($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPolicyReference() => $_has(0);
  @$pb.TagNumber(1)
  void clearPolicyReference() => clearField(1);
}

class GetInsuranceRefundStatusResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInsuranceRefundStatusResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOM<InsuranceRefundInfo>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'refund', subBuilder: InsuranceRefundInfo.create)
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  GetInsuranceRefundStatusResponse._() : super();
  factory GetInsuranceRefundStatusResponse({
    InsuranceRefundInfo? refund,
    $core.bool? success,
    $core.String? message,
  }) {
    final _result = create();
    if (refund != null) {
      _result.refund = refund;
    }
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory GetInsuranceRefundStatusResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInsuranceRefundStatusResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInsuranceRefundStatusResponse clone() => GetInsuranceRefundStatusResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInsuranceRefundStatusResponse copyWith(void Function(GetInsuranceRefundStatusResponse) updates) => super.copyWith((message) => updates(message as GetInsuranceRefundStatusResponse)) as GetInsuranceRefundStatusResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetInsuranceRefundStatusResponse create() => GetInsuranceRefundStatusResponse._();
  GetInsuranceRefundStatusResponse createEmptyInstance() => create();
  static $pb.PbList<GetInsuranceRefundStatusResponse> createRepeated() => $pb.PbList<GetInsuranceRefundStatusResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInsuranceRefundStatusResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInsuranceRefundStatusResponse>(create);
  static GetInsuranceRefundStatusResponse? _defaultInstance;

  @$pb.TagNumber(1)
  InsuranceRefundInfo get refund => $_getN(0);
  @$pb.TagNumber(1)
  set refund(InsuranceRefundInfo v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasRefund() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefund() => clearField(1);
  @$pb.TagNumber(1)
  InsuranceRefundInfo ensureRefund() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => clearField(3);
}

class InsuranceRefundInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'InsuranceRefundInfo', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'refundId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'policyReference')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOB(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerRefunded')
    ..aOB(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'walletCredited')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reason')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'failureReason')
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'initiatedAt')
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'completedAt')
    ..hasRequiredFields = false
  ;

  InsuranceRefundInfo._() : super();
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
    final _result = create();
    if (refundId != null) {
      _result.refundId = refundId;
    }
    if (policyReference != null) {
      _result.policyReference = policyReference;
    }
    if (status != null) {
      _result.status = status;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (providerRefunded != null) {
      _result.providerRefunded = providerRefunded;
    }
    if (walletCredited != null) {
      _result.walletCredited = walletCredited;
    }
    if (reason != null) {
      _result.reason = reason;
    }
    if (failureReason != null) {
      _result.failureReason = failureReason;
    }
    if (initiatedAt != null) {
      _result.initiatedAt = initiatedAt;
    }
    if (completedAt != null) {
      _result.completedAt = completedAt;
    }
    return _result;
  }
  factory InsuranceRefundInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InsuranceRefundInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InsuranceRefundInfo clone() => InsuranceRefundInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InsuranceRefundInfo copyWith(void Function(InsuranceRefundInfo) updates) => super.copyWith((message) => updates(message as InsuranceRefundInfo)) as InsuranceRefundInfo; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static InsuranceRefundInfo create() => InsuranceRefundInfo._();
  InsuranceRefundInfo createEmptyInstance() => create();
  static $pb.PbList<InsuranceRefundInfo> createRepeated() => $pb.PbList<InsuranceRefundInfo>();
  @$core.pragma('dart2js:noInline')
  static InsuranceRefundInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InsuranceRefundInfo>(create);
  static InsuranceRefundInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refundId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refundId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRefundId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefundId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get policyReference => $_getSZ(1);
  @$pb.TagNumber(2)
  set policyReference($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPolicyReference() => $_has(1);
  @$pb.TagNumber(2)
  void clearPolicyReference() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get status => $_getSZ(2);
  @$pb.TagNumber(3)
  set status($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasStatus() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatus() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get amount => $_getN(3);
  @$pb.TagNumber(4)
  set amount($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearAmount() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get currency => $_getSZ(4);
  @$pb.TagNumber(5)
  set currency($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasCurrency() => $_has(4);
  @$pb.TagNumber(5)
  void clearCurrency() => clearField(5);

  @$pb.TagNumber(6)
  $core.bool get providerRefunded => $_getBF(5);
  @$pb.TagNumber(6)
  set providerRefunded($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasProviderRefunded() => $_has(5);
  @$pb.TagNumber(6)
  void clearProviderRefunded() => clearField(6);

  @$pb.TagNumber(7)
  $core.bool get walletCredited => $_getBF(6);
  @$pb.TagNumber(7)
  set walletCredited($core.bool v) { $_setBool(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasWalletCredited() => $_has(6);
  @$pb.TagNumber(7)
  void clearWalletCredited() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get reason => $_getSZ(7);
  @$pb.TagNumber(8)
  set reason($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasReason() => $_has(7);
  @$pb.TagNumber(8)
  void clearReason() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get failureReason => $_getSZ(8);
  @$pb.TagNumber(9)
  set failureReason($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasFailureReason() => $_has(8);
  @$pb.TagNumber(9)
  void clearFailureReason() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get initiatedAt => $_getSZ(9);
  @$pb.TagNumber(10)
  set initiatedAt($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasInitiatedAt() => $_has(9);
  @$pb.TagNumber(10)
  void clearInitiatedAt() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get completedAt => $_getSZ(10);
  @$pb.TagNumber(11)
  set completedAt($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasCompletedAt() => $_has(10);
  @$pb.TagNumber(11)
  void clearCompletedAt() => clearField(11);
}

