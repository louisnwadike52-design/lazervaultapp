///
//  Generated code. Do not modify.
//  source: financial-products.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

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
    ..hasRequiredFields = false
  ;

  MakeInsuranceClaimRequest._() : super();
  factory MakeInsuranceClaimRequest({
    $core.String? policyId,
    $core.double? claimAmount,
    $core.String? reason,
    $core.Iterable<$core.String>? documents,
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
}

class MakeInsuranceClaimResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MakeInsuranceClaimResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOM<InsuranceClaim>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'claim', subBuilder: InsuranceClaim.create)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  MakeInsuranceClaimResponse._() : super();
  factory MakeInsuranceClaimResponse({
    InsuranceClaim? claim,
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
    ..hasRequiredFields = false
  ;

  WithdrawFromCrowdfundRequest._() : super();
  factory WithdrawFromCrowdfundRequest({
    $core.String? crowdfundId,
    $core.double? amount,
    $core.String? pin,
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
}

class WithdrawFromCrowdfundResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'WithdrawFromCrowdfundResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'financialproducts'), createEmptyInstance: create)
    ..aOM<Crowdfund>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'crowdfund', subBuilder: Crowdfund.create)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amountWithdrawn', $pb.PbFieldType.OD)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  WithdrawFromCrowdfundResponse._() : super();
  factory WithdrawFromCrowdfundResponse({
    Crowdfund? crowdfund,
    $core.double? amountWithdrawn,
    $core.String? message,
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

