///
//  Generated code. Do not modify.
//  source: family_accounts.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class CreateFamilyAccountRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateFamilyAccountRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'accounts.v1'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'initialCurrency')
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'initialFunding', $pb.PbFieldType.OD)
    ..aOB(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'allowMemberContributions')
    ..hasRequiredFields = false
  ;

  CreateFamilyAccountRequest._() : super();
  factory CreateFamilyAccountRequest({
    $core.String? name,
    $core.String? description,
    $core.String? initialCurrency,
    $core.double? initialFunding,
    $core.bool? allowMemberContributions,
  }) {
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    if (description != null) {
      _result.description = description;
    }
    if (initialCurrency != null) {
      _result.initialCurrency = initialCurrency;
    }
    if (initialFunding != null) {
      _result.initialFunding = initialFunding;
    }
    if (allowMemberContributions != null) {
      _result.allowMemberContributions = allowMemberContributions;
    }
    return _result;
  }
  factory CreateFamilyAccountRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateFamilyAccountRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateFamilyAccountRequest clone() => CreateFamilyAccountRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateFamilyAccountRequest copyWith(void Function(CreateFamilyAccountRequest) updates) => super.copyWith((message) => updates(message as CreateFamilyAccountRequest)) as CreateFamilyAccountRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateFamilyAccountRequest create() => CreateFamilyAccountRequest._();
  CreateFamilyAccountRequest createEmptyInstance() => create();
  static $pb.PbList<CreateFamilyAccountRequest> createRepeated() => $pb.PbList<CreateFamilyAccountRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateFamilyAccountRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateFamilyAccountRequest>(create);
  static CreateFamilyAccountRequest? _defaultInstance;

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
  $core.String get initialCurrency => $_getSZ(2);
  @$pb.TagNumber(3)
  set initialCurrency($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasInitialCurrency() => $_has(2);
  @$pb.TagNumber(3)
  void clearInitialCurrency() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get initialFunding => $_getN(3);
  @$pb.TagNumber(4)
  set initialFunding($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasInitialFunding() => $_has(3);
  @$pb.TagNumber(4)
  void clearInitialFunding() => clearField(4);

  @$pb.TagNumber(5)
  $core.bool get allowMemberContributions => $_getBF(4);
  @$pb.TagNumber(5)
  set allowMemberContributions($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasAllowMemberContributions() => $_has(4);
  @$pb.TagNumber(5)
  void clearAllowMemberContributions() => clearField(5);
}

class CreateFamilyAccountResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateFamilyAccountResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'accounts.v1'), createEmptyInstance: create)
    ..aOM<FamilyAccount>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'familyAccount', subBuilder: FamilyAccount.create)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  CreateFamilyAccountResponse._() : super();
  factory CreateFamilyAccountResponse({
    FamilyAccount? familyAccount,
    $core.String? message,
  }) {
    final _result = create();
    if (familyAccount != null) {
      _result.familyAccount = familyAccount;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory CreateFamilyAccountResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateFamilyAccountResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateFamilyAccountResponse clone() => CreateFamilyAccountResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateFamilyAccountResponse copyWith(void Function(CreateFamilyAccountResponse) updates) => super.copyWith((message) => updates(message as CreateFamilyAccountResponse)) as CreateFamilyAccountResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateFamilyAccountResponse create() => CreateFamilyAccountResponse._();
  CreateFamilyAccountResponse createEmptyInstance() => create();
  static $pb.PbList<CreateFamilyAccountResponse> createRepeated() => $pb.PbList<CreateFamilyAccountResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateFamilyAccountResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateFamilyAccountResponse>(create);
  static CreateFamilyAccountResponse? _defaultInstance;

  @$pb.TagNumber(1)
  FamilyAccount get familyAccount => $_getN(0);
  @$pb.TagNumber(1)
  set familyAccount(FamilyAccount v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasFamilyAccount() => $_has(0);
  @$pb.TagNumber(1)
  void clearFamilyAccount() => clearField(1);
  @$pb.TagNumber(1)
  FamilyAccount ensureFamilyAccount() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

class GetFamilyAccountsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetFamilyAccountsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'accounts.v1'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..hasRequiredFields = false
  ;

  GetFamilyAccountsRequest._() : super();
  factory GetFamilyAccountsRequest({
    $core.String? status,
  }) {
    final _result = create();
    if (status != null) {
      _result.status = status;
    }
    return _result;
  }
  factory GetFamilyAccountsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetFamilyAccountsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetFamilyAccountsRequest clone() => GetFamilyAccountsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetFamilyAccountsRequest copyWith(void Function(GetFamilyAccountsRequest) updates) => super.copyWith((message) => updates(message as GetFamilyAccountsRequest)) as GetFamilyAccountsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetFamilyAccountsRequest create() => GetFamilyAccountsRequest._();
  GetFamilyAccountsRequest createEmptyInstance() => create();
  static $pb.PbList<GetFamilyAccountsRequest> createRepeated() => $pb.PbList<GetFamilyAccountsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetFamilyAccountsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetFamilyAccountsRequest>(create);
  static GetFamilyAccountsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get status => $_getSZ(0);
  @$pb.TagNumber(1)
  set status($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => clearField(1);
}

class GetFamilyAccountsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetFamilyAccountsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'accounts.v1'), createEmptyInstance: create)
    ..pc<FamilyAccount>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'familyAccounts', $pb.PbFieldType.PM, subBuilder: FamilyAccount.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalCount', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetFamilyAccountsResponse._() : super();
  factory GetFamilyAccountsResponse({
    $core.Iterable<FamilyAccount>? familyAccounts,
    $core.int? totalCount,
  }) {
    final _result = create();
    if (familyAccounts != null) {
      _result.familyAccounts.addAll(familyAccounts);
    }
    if (totalCount != null) {
      _result.totalCount = totalCount;
    }
    return _result;
  }
  factory GetFamilyAccountsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetFamilyAccountsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetFamilyAccountsResponse clone() => GetFamilyAccountsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetFamilyAccountsResponse copyWith(void Function(GetFamilyAccountsResponse) updates) => super.copyWith((message) => updates(message as GetFamilyAccountsResponse)) as GetFamilyAccountsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetFamilyAccountsResponse create() => GetFamilyAccountsResponse._();
  GetFamilyAccountsResponse createEmptyInstance() => create();
  static $pb.PbList<GetFamilyAccountsResponse> createRepeated() => $pb.PbList<GetFamilyAccountsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetFamilyAccountsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetFamilyAccountsResponse>(create);
  static GetFamilyAccountsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<FamilyAccount> get familyAccounts => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get totalCount => $_getIZ(1);
  @$pb.TagNumber(2)
  set totalCount($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotalCount() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalCount() => clearField(2);
}

class GetFamilyAccountRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetFamilyAccountRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'accounts.v1'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'familyId')
    ..hasRequiredFields = false
  ;

  GetFamilyAccountRequest._() : super();
  factory GetFamilyAccountRequest({
    $core.String? familyId,
  }) {
    final _result = create();
    if (familyId != null) {
      _result.familyId = familyId;
    }
    return _result;
  }
  factory GetFamilyAccountRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetFamilyAccountRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetFamilyAccountRequest clone() => GetFamilyAccountRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetFamilyAccountRequest copyWith(void Function(GetFamilyAccountRequest) updates) => super.copyWith((message) => updates(message as GetFamilyAccountRequest)) as GetFamilyAccountRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetFamilyAccountRequest create() => GetFamilyAccountRequest._();
  GetFamilyAccountRequest createEmptyInstance() => create();
  static $pb.PbList<GetFamilyAccountRequest> createRepeated() => $pb.PbList<GetFamilyAccountRequest>();
  @$core.pragma('dart2js:noInline')
  static GetFamilyAccountRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetFamilyAccountRequest>(create);
  static GetFamilyAccountRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get familyId => $_getSZ(0);
  @$pb.TagNumber(1)
  set familyId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFamilyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFamilyId() => clearField(1);
}

class GetFamilyAccountResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetFamilyAccountResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'accounts.v1'), createEmptyInstance: create)
    ..aOM<FamilyAccount>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'familyAccount', subBuilder: FamilyAccount.create)
    ..pc<FamilyTransaction>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recentTransactions', $pb.PbFieldType.PM, subBuilder: FamilyTransaction.create)
    ..aOM<FamilyAccountSummary>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'summary', subBuilder: FamilyAccountSummary.create)
    ..hasRequiredFields = false
  ;

  GetFamilyAccountResponse._() : super();
  factory GetFamilyAccountResponse({
    FamilyAccount? familyAccount,
    $core.Iterable<FamilyTransaction>? recentTransactions,
    FamilyAccountSummary? summary,
  }) {
    final _result = create();
    if (familyAccount != null) {
      _result.familyAccount = familyAccount;
    }
    if (recentTransactions != null) {
      _result.recentTransactions.addAll(recentTransactions);
    }
    if (summary != null) {
      _result.summary = summary;
    }
    return _result;
  }
  factory GetFamilyAccountResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetFamilyAccountResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetFamilyAccountResponse clone() => GetFamilyAccountResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetFamilyAccountResponse copyWith(void Function(GetFamilyAccountResponse) updates) => super.copyWith((message) => updates(message as GetFamilyAccountResponse)) as GetFamilyAccountResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetFamilyAccountResponse create() => GetFamilyAccountResponse._();
  GetFamilyAccountResponse createEmptyInstance() => create();
  static $pb.PbList<GetFamilyAccountResponse> createRepeated() => $pb.PbList<GetFamilyAccountResponse>();
  @$core.pragma('dart2js:noInline')
  static GetFamilyAccountResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetFamilyAccountResponse>(create);
  static GetFamilyAccountResponse? _defaultInstance;

  @$pb.TagNumber(1)
  FamilyAccount get familyAccount => $_getN(0);
  @$pb.TagNumber(1)
  set familyAccount(FamilyAccount v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasFamilyAccount() => $_has(0);
  @$pb.TagNumber(1)
  void clearFamilyAccount() => clearField(1);
  @$pb.TagNumber(1)
  FamilyAccount ensureFamilyAccount() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.List<FamilyTransaction> get recentTransactions => $_getList(1);

  @$pb.TagNumber(3)
  FamilyAccountSummary get summary => $_getN(2);
  @$pb.TagNumber(3)
  set summary(FamilyAccountSummary v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasSummary() => $_has(2);
  @$pb.TagNumber(3)
  void clearSummary() => clearField(3);
  @$pb.TagNumber(3)
  FamilyAccountSummary ensureSummary() => $_ensure(2);
}

class AddFamilyMemberRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AddFamilyMemberRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'accounts.v1'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'familyId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'invitationMethod')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'invitationDestination')
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'initialAllocation', $pb.PbFieldType.OD)
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dailyLimit', $pb.PbFieldType.OD)
    ..a<$core.double>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'monthlyLimit', $pb.PbFieldType.OD)
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'role')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'personalMessage')
    ..a<$core.double>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'perTransactionLimit', $pb.PbFieldType.OD)
    ..a<$core.double>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'allocationPercentageCap', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  AddFamilyMemberRequest._() : super();
  factory AddFamilyMemberRequest({
    $core.String? familyId,
    $core.String? invitationMethod,
    $core.String? invitationDestination,
    $core.double? initialAllocation,
    $core.double? dailyLimit,
    $core.double? monthlyLimit,
    $core.String? role,
    $core.String? personalMessage,
    $core.double? perTransactionLimit,
    $core.double? allocationPercentageCap,
  }) {
    final _result = create();
    if (familyId != null) {
      _result.familyId = familyId;
    }
    if (invitationMethod != null) {
      _result.invitationMethod = invitationMethod;
    }
    if (invitationDestination != null) {
      _result.invitationDestination = invitationDestination;
    }
    if (initialAllocation != null) {
      _result.initialAllocation = initialAllocation;
    }
    if (dailyLimit != null) {
      _result.dailyLimit = dailyLimit;
    }
    if (monthlyLimit != null) {
      _result.monthlyLimit = monthlyLimit;
    }
    if (role != null) {
      _result.role = role;
    }
    if (personalMessage != null) {
      _result.personalMessage = personalMessage;
    }
    if (perTransactionLimit != null) {
      _result.perTransactionLimit = perTransactionLimit;
    }
    if (allocationPercentageCap != null) {
      _result.allocationPercentageCap = allocationPercentageCap;
    }
    return _result;
  }
  factory AddFamilyMemberRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddFamilyMemberRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddFamilyMemberRequest clone() => AddFamilyMemberRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddFamilyMemberRequest copyWith(void Function(AddFamilyMemberRequest) updates) => super.copyWith((message) => updates(message as AddFamilyMemberRequest)) as AddFamilyMemberRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AddFamilyMemberRequest create() => AddFamilyMemberRequest._();
  AddFamilyMemberRequest createEmptyInstance() => create();
  static $pb.PbList<AddFamilyMemberRequest> createRepeated() => $pb.PbList<AddFamilyMemberRequest>();
  @$core.pragma('dart2js:noInline')
  static AddFamilyMemberRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddFamilyMemberRequest>(create);
  static AddFamilyMemberRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get familyId => $_getSZ(0);
  @$pb.TagNumber(1)
  set familyId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFamilyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFamilyId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get invitationMethod => $_getSZ(1);
  @$pb.TagNumber(2)
  set invitationMethod($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasInvitationMethod() => $_has(1);
  @$pb.TagNumber(2)
  void clearInvitationMethod() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get invitationDestination => $_getSZ(2);
  @$pb.TagNumber(3)
  set invitationDestination($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasInvitationDestination() => $_has(2);
  @$pb.TagNumber(3)
  void clearInvitationDestination() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get initialAllocation => $_getN(3);
  @$pb.TagNumber(4)
  set initialAllocation($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasInitialAllocation() => $_has(3);
  @$pb.TagNumber(4)
  void clearInitialAllocation() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get dailyLimit => $_getN(4);
  @$pb.TagNumber(5)
  set dailyLimit($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasDailyLimit() => $_has(4);
  @$pb.TagNumber(5)
  void clearDailyLimit() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get monthlyLimit => $_getN(5);
  @$pb.TagNumber(6)
  set monthlyLimit($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasMonthlyLimit() => $_has(5);
  @$pb.TagNumber(6)
  void clearMonthlyLimit() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get role => $_getSZ(6);
  @$pb.TagNumber(7)
  set role($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasRole() => $_has(6);
  @$pb.TagNumber(7)
  void clearRole() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get personalMessage => $_getSZ(7);
  @$pb.TagNumber(8)
  set personalMessage($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasPersonalMessage() => $_has(7);
  @$pb.TagNumber(8)
  void clearPersonalMessage() => clearField(8);

  @$pb.TagNumber(9)
  $core.double get perTransactionLimit => $_getN(8);
  @$pb.TagNumber(9)
  set perTransactionLimit($core.double v) { $_setDouble(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasPerTransactionLimit() => $_has(8);
  @$pb.TagNumber(9)
  void clearPerTransactionLimit() => clearField(9);

  @$pb.TagNumber(10)
  $core.double get allocationPercentageCap => $_getN(9);
  @$pb.TagNumber(10)
  set allocationPercentageCap($core.double v) { $_setDouble(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasAllocationPercentageCap() => $_has(9);
  @$pb.TagNumber(10)
  void clearAllocationPercentageCap() => clearField(10);
}

class AddFamilyMemberResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AddFamilyMemberResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'accounts.v1'), createEmptyInstance: create)
    ..aOM<FamilyMember>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'member', subBuilder: FamilyMember.create)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'invitationMessage')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'invitationLink')
    ..hasRequiredFields = false
  ;

  AddFamilyMemberResponse._() : super();
  factory AddFamilyMemberResponse({
    FamilyMember? member,
    $core.String? invitationMessage,
    $core.String? invitationLink,
  }) {
    final _result = create();
    if (member != null) {
      _result.member = member;
    }
    if (invitationMessage != null) {
      _result.invitationMessage = invitationMessage;
    }
    if (invitationLink != null) {
      _result.invitationLink = invitationLink;
    }
    return _result;
  }
  factory AddFamilyMemberResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddFamilyMemberResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddFamilyMemberResponse clone() => AddFamilyMemberResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddFamilyMemberResponse copyWith(void Function(AddFamilyMemberResponse) updates) => super.copyWith((message) => updates(message as AddFamilyMemberResponse)) as AddFamilyMemberResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AddFamilyMemberResponse create() => AddFamilyMemberResponse._();
  AddFamilyMemberResponse createEmptyInstance() => create();
  static $pb.PbList<AddFamilyMemberResponse> createRepeated() => $pb.PbList<AddFamilyMemberResponse>();
  @$core.pragma('dart2js:noInline')
  static AddFamilyMemberResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddFamilyMemberResponse>(create);
  static AddFamilyMemberResponse? _defaultInstance;

  @$pb.TagNumber(1)
  FamilyMember get member => $_getN(0);
  @$pb.TagNumber(1)
  set member(FamilyMember v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasMember() => $_has(0);
  @$pb.TagNumber(1)
  void clearMember() => clearField(1);
  @$pb.TagNumber(1)
  FamilyMember ensureMember() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get invitationMessage => $_getSZ(1);
  @$pb.TagNumber(2)
  set invitationMessage($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasInvitationMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearInvitationMessage() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get invitationLink => $_getSZ(2);
  @$pb.TagNumber(3)
  set invitationLink($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasInvitationLink() => $_has(2);
  @$pb.TagNumber(3)
  void clearInvitationLink() => clearField(3);
}

class UpdateFamilyMemberRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateFamilyMemberRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'accounts.v1'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'familyId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'memberId')
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'allocatedBalance', $pb.PbFieldType.OD)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dailySpendingLimit', $pb.PbFieldType.OD)
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'monthlySpendingLimit', $pb.PbFieldType.OD)
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'role')
    ..a<$core.double>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'perTransactionLimit', $pb.PbFieldType.OD)
    ..a<$core.double>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'allocationPercentageCap', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  UpdateFamilyMemberRequest._() : super();
  factory UpdateFamilyMemberRequest({
    $core.String? familyId,
    $core.String? memberId,
    $core.double? allocatedBalance,
    $core.double? dailySpendingLimit,
    $core.double? monthlySpendingLimit,
    $core.String? role,
    $core.double? perTransactionLimit,
    $core.double? allocationPercentageCap,
  }) {
    final _result = create();
    if (familyId != null) {
      _result.familyId = familyId;
    }
    if (memberId != null) {
      _result.memberId = memberId;
    }
    if (allocatedBalance != null) {
      _result.allocatedBalance = allocatedBalance;
    }
    if (dailySpendingLimit != null) {
      _result.dailySpendingLimit = dailySpendingLimit;
    }
    if (monthlySpendingLimit != null) {
      _result.monthlySpendingLimit = monthlySpendingLimit;
    }
    if (role != null) {
      _result.role = role;
    }
    if (perTransactionLimit != null) {
      _result.perTransactionLimit = perTransactionLimit;
    }
    if (allocationPercentageCap != null) {
      _result.allocationPercentageCap = allocationPercentageCap;
    }
    return _result;
  }
  factory UpdateFamilyMemberRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateFamilyMemberRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateFamilyMemberRequest clone() => UpdateFamilyMemberRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateFamilyMemberRequest copyWith(void Function(UpdateFamilyMemberRequest) updates) => super.copyWith((message) => updates(message as UpdateFamilyMemberRequest)) as UpdateFamilyMemberRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UpdateFamilyMemberRequest create() => UpdateFamilyMemberRequest._();
  UpdateFamilyMemberRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateFamilyMemberRequest> createRepeated() => $pb.PbList<UpdateFamilyMemberRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateFamilyMemberRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateFamilyMemberRequest>(create);
  static UpdateFamilyMemberRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get familyId => $_getSZ(0);
  @$pb.TagNumber(1)
  set familyId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFamilyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFamilyId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get memberId => $_getSZ(1);
  @$pb.TagNumber(2)
  set memberId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMemberId() => $_has(1);
  @$pb.TagNumber(2)
  void clearMemberId() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get allocatedBalance => $_getN(2);
  @$pb.TagNumber(3)
  set allocatedBalance($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAllocatedBalance() => $_has(2);
  @$pb.TagNumber(3)
  void clearAllocatedBalance() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get dailySpendingLimit => $_getN(3);
  @$pb.TagNumber(4)
  set dailySpendingLimit($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasDailySpendingLimit() => $_has(3);
  @$pb.TagNumber(4)
  void clearDailySpendingLimit() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get monthlySpendingLimit => $_getN(4);
  @$pb.TagNumber(5)
  set monthlySpendingLimit($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasMonthlySpendingLimit() => $_has(4);
  @$pb.TagNumber(5)
  void clearMonthlySpendingLimit() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get role => $_getSZ(5);
  @$pb.TagNumber(6)
  set role($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasRole() => $_has(5);
  @$pb.TagNumber(6)
  void clearRole() => clearField(6);

  @$pb.TagNumber(7)
  $core.double get perTransactionLimit => $_getN(6);
  @$pb.TagNumber(7)
  set perTransactionLimit($core.double v) { $_setDouble(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasPerTransactionLimit() => $_has(6);
  @$pb.TagNumber(7)
  void clearPerTransactionLimit() => clearField(7);

  @$pb.TagNumber(8)
  $core.double get allocationPercentageCap => $_getN(7);
  @$pb.TagNumber(8)
  set allocationPercentageCap($core.double v) { $_setDouble(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasAllocationPercentageCap() => $_has(7);
  @$pb.TagNumber(8)
  void clearAllocationPercentageCap() => clearField(8);
}

class UpdateFamilyMemberResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateFamilyMemberResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'accounts.v1'), createEmptyInstance: create)
    ..aOM<FamilyMember>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'member', subBuilder: FamilyMember.create)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  UpdateFamilyMemberResponse._() : super();
  factory UpdateFamilyMemberResponse({
    FamilyMember? member,
    $core.String? message,
  }) {
    final _result = create();
    if (member != null) {
      _result.member = member;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory UpdateFamilyMemberResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateFamilyMemberResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateFamilyMemberResponse clone() => UpdateFamilyMemberResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateFamilyMemberResponse copyWith(void Function(UpdateFamilyMemberResponse) updates) => super.copyWith((message) => updates(message as UpdateFamilyMemberResponse)) as UpdateFamilyMemberResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UpdateFamilyMemberResponse create() => UpdateFamilyMemberResponse._();
  UpdateFamilyMemberResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateFamilyMemberResponse> createRepeated() => $pb.PbList<UpdateFamilyMemberResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateFamilyMemberResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateFamilyMemberResponse>(create);
  static UpdateFamilyMemberResponse? _defaultInstance;

  @$pb.TagNumber(1)
  FamilyMember get member => $_getN(0);
  @$pb.TagNumber(1)
  set member(FamilyMember v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasMember() => $_has(0);
  @$pb.TagNumber(1)
  void clearMember() => clearField(1);
  @$pb.TagNumber(1)
  FamilyMember ensureMember() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

class RemoveFamilyMemberRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RemoveFamilyMemberRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'accounts.v1'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'familyId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'memberId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reason')
    ..aOB(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'returnBalanceToPool')
    ..hasRequiredFields = false
  ;

  RemoveFamilyMemberRequest._() : super();
  factory RemoveFamilyMemberRequest({
    $core.String? familyId,
    $core.String? memberId,
    $core.String? reason,
    $core.bool? returnBalanceToPool,
  }) {
    final _result = create();
    if (familyId != null) {
      _result.familyId = familyId;
    }
    if (memberId != null) {
      _result.memberId = memberId;
    }
    if (reason != null) {
      _result.reason = reason;
    }
    if (returnBalanceToPool != null) {
      _result.returnBalanceToPool = returnBalanceToPool;
    }
    return _result;
  }
  factory RemoveFamilyMemberRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RemoveFamilyMemberRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RemoveFamilyMemberRequest clone() => RemoveFamilyMemberRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RemoveFamilyMemberRequest copyWith(void Function(RemoveFamilyMemberRequest) updates) => super.copyWith((message) => updates(message as RemoveFamilyMemberRequest)) as RemoveFamilyMemberRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RemoveFamilyMemberRequest create() => RemoveFamilyMemberRequest._();
  RemoveFamilyMemberRequest createEmptyInstance() => create();
  static $pb.PbList<RemoveFamilyMemberRequest> createRepeated() => $pb.PbList<RemoveFamilyMemberRequest>();
  @$core.pragma('dart2js:noInline')
  static RemoveFamilyMemberRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RemoveFamilyMemberRequest>(create);
  static RemoveFamilyMemberRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get familyId => $_getSZ(0);
  @$pb.TagNumber(1)
  set familyId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFamilyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFamilyId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get memberId => $_getSZ(1);
  @$pb.TagNumber(2)
  set memberId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMemberId() => $_has(1);
  @$pb.TagNumber(2)
  void clearMemberId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get reason => $_getSZ(2);
  @$pb.TagNumber(3)
  set reason($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasReason() => $_has(2);
  @$pb.TagNumber(3)
  void clearReason() => clearField(3);

  @$pb.TagNumber(4)
  $core.bool get returnBalanceToPool => $_getBF(3);
  @$pb.TagNumber(4)
  set returnBalanceToPool($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasReturnBalanceToPool() => $_has(3);
  @$pb.TagNumber(4)
  void clearReturnBalanceToPool() => clearField(4);
}

class RemoveFamilyMemberResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RemoveFamilyMemberResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'accounts.v1'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'returnedBalance', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  RemoveFamilyMemberResponse._() : super();
  factory RemoveFamilyMemberResponse({
    $core.bool? success,
    $core.String? message,
    $core.double? returnedBalance,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (returnedBalance != null) {
      _result.returnedBalance = returnedBalance;
    }
    return _result;
  }
  factory RemoveFamilyMemberResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RemoveFamilyMemberResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RemoveFamilyMemberResponse clone() => RemoveFamilyMemberResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RemoveFamilyMemberResponse copyWith(void Function(RemoveFamilyMemberResponse) updates) => super.copyWith((message) => updates(message as RemoveFamilyMemberResponse)) as RemoveFamilyMemberResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RemoveFamilyMemberResponse create() => RemoveFamilyMemberResponse._();
  RemoveFamilyMemberResponse createEmptyInstance() => create();
  static $pb.PbList<RemoveFamilyMemberResponse> createRepeated() => $pb.PbList<RemoveFamilyMemberResponse>();
  @$core.pragma('dart2js:noInline')
  static RemoveFamilyMemberResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RemoveFamilyMemberResponse>(create);
  static RemoveFamilyMemberResponse? _defaultInstance;

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
  $core.double get returnedBalance => $_getN(2);
  @$pb.TagNumber(3)
  set returnedBalance($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasReturnedBalance() => $_has(2);
  @$pb.TagNumber(3)
  void clearReturnedBalance() => clearField(3);
}

class AcceptFamilyInvitationRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AcceptFamilyInvitationRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'accounts.v1'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'invitationToken')
    ..hasRequiredFields = false
  ;

  AcceptFamilyInvitationRequest._() : super();
  factory AcceptFamilyInvitationRequest({
    $core.String? invitationToken,
  }) {
    final _result = create();
    if (invitationToken != null) {
      _result.invitationToken = invitationToken;
    }
    return _result;
  }
  factory AcceptFamilyInvitationRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AcceptFamilyInvitationRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AcceptFamilyInvitationRequest clone() => AcceptFamilyInvitationRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AcceptFamilyInvitationRequest copyWith(void Function(AcceptFamilyInvitationRequest) updates) => super.copyWith((message) => updates(message as AcceptFamilyInvitationRequest)) as AcceptFamilyInvitationRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AcceptFamilyInvitationRequest create() => AcceptFamilyInvitationRequest._();
  AcceptFamilyInvitationRequest createEmptyInstance() => create();
  static $pb.PbList<AcceptFamilyInvitationRequest> createRepeated() => $pb.PbList<AcceptFamilyInvitationRequest>();
  @$core.pragma('dart2js:noInline')
  static AcceptFamilyInvitationRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AcceptFamilyInvitationRequest>(create);
  static AcceptFamilyInvitationRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get invitationToken => $_getSZ(0);
  @$pb.TagNumber(1)
  set invitationToken($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasInvitationToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvitationToken() => clearField(1);
}

class AcceptFamilyInvitationResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AcceptFamilyInvitationResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'accounts.v1'), createEmptyInstance: create)
    ..aOM<FamilyAccount>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'familyAccount', subBuilder: FamilyAccount.create)
    ..aOM<FamilyMember>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'member', subBuilder: FamilyMember.create)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  AcceptFamilyInvitationResponse._() : super();
  factory AcceptFamilyInvitationResponse({
    FamilyAccount? familyAccount,
    FamilyMember? member,
    $core.String? message,
  }) {
    final _result = create();
    if (familyAccount != null) {
      _result.familyAccount = familyAccount;
    }
    if (member != null) {
      _result.member = member;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory AcceptFamilyInvitationResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AcceptFamilyInvitationResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AcceptFamilyInvitationResponse clone() => AcceptFamilyInvitationResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AcceptFamilyInvitationResponse copyWith(void Function(AcceptFamilyInvitationResponse) updates) => super.copyWith((message) => updates(message as AcceptFamilyInvitationResponse)) as AcceptFamilyInvitationResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AcceptFamilyInvitationResponse create() => AcceptFamilyInvitationResponse._();
  AcceptFamilyInvitationResponse createEmptyInstance() => create();
  static $pb.PbList<AcceptFamilyInvitationResponse> createRepeated() => $pb.PbList<AcceptFamilyInvitationResponse>();
  @$core.pragma('dart2js:noInline')
  static AcceptFamilyInvitationResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AcceptFamilyInvitationResponse>(create);
  static AcceptFamilyInvitationResponse? _defaultInstance;

  @$pb.TagNumber(1)
  FamilyAccount get familyAccount => $_getN(0);
  @$pb.TagNumber(1)
  set familyAccount(FamilyAccount v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasFamilyAccount() => $_has(0);
  @$pb.TagNumber(1)
  void clearFamilyAccount() => clearField(1);
  @$pb.TagNumber(1)
  FamilyAccount ensureFamilyAccount() => $_ensure(0);

  @$pb.TagNumber(2)
  FamilyMember get member => $_getN(1);
  @$pb.TagNumber(2)
  set member(FamilyMember v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasMember() => $_has(1);
  @$pb.TagNumber(2)
  void clearMember() => clearField(2);
  @$pb.TagNumber(2)
  FamilyMember ensureMember() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => clearField(3);
}

class DeclineFamilyInvitationRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DeclineFamilyInvitationRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'accounts.v1'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'invitationToken')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reason')
    ..hasRequiredFields = false
  ;

  DeclineFamilyInvitationRequest._() : super();
  factory DeclineFamilyInvitationRequest({
    $core.String? invitationToken,
    $core.String? reason,
  }) {
    final _result = create();
    if (invitationToken != null) {
      _result.invitationToken = invitationToken;
    }
    if (reason != null) {
      _result.reason = reason;
    }
    return _result;
  }
  factory DeclineFamilyInvitationRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeclineFamilyInvitationRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeclineFamilyInvitationRequest clone() => DeclineFamilyInvitationRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeclineFamilyInvitationRequest copyWith(void Function(DeclineFamilyInvitationRequest) updates) => super.copyWith((message) => updates(message as DeclineFamilyInvitationRequest)) as DeclineFamilyInvitationRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DeclineFamilyInvitationRequest create() => DeclineFamilyInvitationRequest._();
  DeclineFamilyInvitationRequest createEmptyInstance() => create();
  static $pb.PbList<DeclineFamilyInvitationRequest> createRepeated() => $pb.PbList<DeclineFamilyInvitationRequest>();
  @$core.pragma('dart2js:noInline')
  static DeclineFamilyInvitationRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeclineFamilyInvitationRequest>(create);
  static DeclineFamilyInvitationRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get invitationToken => $_getSZ(0);
  @$pb.TagNumber(1)
  set invitationToken($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasInvitationToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvitationToken() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get reason => $_getSZ(1);
  @$pb.TagNumber(2)
  set reason($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasReason() => $_has(1);
  @$pb.TagNumber(2)
  void clearReason() => clearField(2);
}

class DeclineFamilyInvitationResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DeclineFamilyInvitationResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'accounts.v1'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  DeclineFamilyInvitationResponse._() : super();
  factory DeclineFamilyInvitationResponse({
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
  factory DeclineFamilyInvitationResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeclineFamilyInvitationResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeclineFamilyInvitationResponse clone() => DeclineFamilyInvitationResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeclineFamilyInvitationResponse copyWith(void Function(DeclineFamilyInvitationResponse) updates) => super.copyWith((message) => updates(message as DeclineFamilyInvitationResponse)) as DeclineFamilyInvitationResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DeclineFamilyInvitationResponse create() => DeclineFamilyInvitationResponse._();
  DeclineFamilyInvitationResponse createEmptyInstance() => create();
  static $pb.PbList<DeclineFamilyInvitationResponse> createRepeated() => $pb.PbList<DeclineFamilyInvitationResponse>();
  @$core.pragma('dart2js:noInline')
  static DeclineFamilyInvitationResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeclineFamilyInvitationResponse>(create);
  static DeclineFamilyInvitationResponse? _defaultInstance;

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

class GetPendingInvitationsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetPendingInvitationsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'accounts.v1'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GetPendingInvitationsRequest._() : super();
  factory GetPendingInvitationsRequest() => create();
  factory GetPendingInvitationsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPendingInvitationsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPendingInvitationsRequest clone() => GetPendingInvitationsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPendingInvitationsRequest copyWith(void Function(GetPendingInvitationsRequest) updates) => super.copyWith((message) => updates(message as GetPendingInvitationsRequest)) as GetPendingInvitationsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetPendingInvitationsRequest create() => GetPendingInvitationsRequest._();
  GetPendingInvitationsRequest createEmptyInstance() => create();
  static $pb.PbList<GetPendingInvitationsRequest> createRepeated() => $pb.PbList<GetPendingInvitationsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetPendingInvitationsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetPendingInvitationsRequest>(create);
  static GetPendingInvitationsRequest? _defaultInstance;
}

class GetPendingInvitationsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetPendingInvitationsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'accounts.v1'), createEmptyInstance: create)
    ..pc<PendingInvitation>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'invitations', $pb.PbFieldType.PM, subBuilder: PendingInvitation.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalCount', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetPendingInvitationsResponse._() : super();
  factory GetPendingInvitationsResponse({
    $core.Iterable<PendingInvitation>? invitations,
    $core.int? totalCount,
  }) {
    final _result = create();
    if (invitations != null) {
      _result.invitations.addAll(invitations);
    }
    if (totalCount != null) {
      _result.totalCount = totalCount;
    }
    return _result;
  }
  factory GetPendingInvitationsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPendingInvitationsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPendingInvitationsResponse clone() => GetPendingInvitationsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPendingInvitationsResponse copyWith(void Function(GetPendingInvitationsResponse) updates) => super.copyWith((message) => updates(message as GetPendingInvitationsResponse)) as GetPendingInvitationsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetPendingInvitationsResponse create() => GetPendingInvitationsResponse._();
  GetPendingInvitationsResponse createEmptyInstance() => create();
  static $pb.PbList<GetPendingInvitationsResponse> createRepeated() => $pb.PbList<GetPendingInvitationsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetPendingInvitationsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetPendingInvitationsResponse>(create);
  static GetPendingInvitationsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<PendingInvitation> get invitations => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get totalCount => $_getIZ(1);
  @$pb.TagNumber(2)
  set totalCount($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotalCount() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalCount() => clearField(2);
}

class GetFamilyTransactionsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetFamilyTransactionsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'accounts.v1'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'familyId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'memberId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type')
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'startDate')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'endDate')
    ..hasRequiredFields = false
  ;

  GetFamilyTransactionsRequest._() : super();
  factory GetFamilyTransactionsRequest({
    $core.String? familyId,
    $core.String? memberId,
    $core.String? type,
    $core.int? page,
    $core.int? pageSize,
    $core.String? startDate,
    $core.String? endDate,
  }) {
    final _result = create();
    if (familyId != null) {
      _result.familyId = familyId;
    }
    if (memberId != null) {
      _result.memberId = memberId;
    }
    if (type != null) {
      _result.type = type;
    }
    if (page != null) {
      _result.page = page;
    }
    if (pageSize != null) {
      _result.pageSize = pageSize;
    }
    if (startDate != null) {
      _result.startDate = startDate;
    }
    if (endDate != null) {
      _result.endDate = endDate;
    }
    return _result;
  }
  factory GetFamilyTransactionsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetFamilyTransactionsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetFamilyTransactionsRequest clone() => GetFamilyTransactionsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetFamilyTransactionsRequest copyWith(void Function(GetFamilyTransactionsRequest) updates) => super.copyWith((message) => updates(message as GetFamilyTransactionsRequest)) as GetFamilyTransactionsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetFamilyTransactionsRequest create() => GetFamilyTransactionsRequest._();
  GetFamilyTransactionsRequest createEmptyInstance() => create();
  static $pb.PbList<GetFamilyTransactionsRequest> createRepeated() => $pb.PbList<GetFamilyTransactionsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetFamilyTransactionsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetFamilyTransactionsRequest>(create);
  static GetFamilyTransactionsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get familyId => $_getSZ(0);
  @$pb.TagNumber(1)
  set familyId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFamilyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFamilyId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get memberId => $_getSZ(1);
  @$pb.TagNumber(2)
  set memberId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMemberId() => $_has(1);
  @$pb.TagNumber(2)
  void clearMemberId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get type => $_getSZ(2);
  @$pb.TagNumber(3)
  set type($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasType() => $_has(2);
  @$pb.TagNumber(3)
  void clearType() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get page => $_getIZ(3);
  @$pb.TagNumber(4)
  set page($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPage() => $_has(3);
  @$pb.TagNumber(4)
  void clearPage() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get pageSize => $_getIZ(4);
  @$pb.TagNumber(5)
  set pageSize($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasPageSize() => $_has(4);
  @$pb.TagNumber(5)
  void clearPageSize() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get startDate => $_getSZ(5);
  @$pb.TagNumber(6)
  set startDate($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasStartDate() => $_has(5);
  @$pb.TagNumber(6)
  void clearStartDate() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get endDate => $_getSZ(6);
  @$pb.TagNumber(7)
  set endDate($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasEndDate() => $_has(6);
  @$pb.TagNumber(7)
  void clearEndDate() => clearField(7);
}

class GetFamilyTransactionsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetFamilyTransactionsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'accounts.v1'), createEmptyInstance: create)
    ..pc<FamilyTransaction>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactions', $pb.PbFieldType.PM, subBuilder: FamilyTransaction.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalCount', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..a<$core.int>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalPages', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetFamilyTransactionsResponse._() : super();
  factory GetFamilyTransactionsResponse({
    $core.Iterable<FamilyTransaction>? transactions,
    $core.int? totalCount,
    $core.int? page,
    $core.int? pageSize,
    $core.int? totalPages,
  }) {
    final _result = create();
    if (transactions != null) {
      _result.transactions.addAll(transactions);
    }
    if (totalCount != null) {
      _result.totalCount = totalCount;
    }
    if (page != null) {
      _result.page = page;
    }
    if (pageSize != null) {
      _result.pageSize = pageSize;
    }
    if (totalPages != null) {
      _result.totalPages = totalPages;
    }
    return _result;
  }
  factory GetFamilyTransactionsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetFamilyTransactionsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetFamilyTransactionsResponse clone() => GetFamilyTransactionsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetFamilyTransactionsResponse copyWith(void Function(GetFamilyTransactionsResponse) updates) => super.copyWith((message) => updates(message as GetFamilyTransactionsResponse)) as GetFamilyTransactionsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetFamilyTransactionsResponse create() => GetFamilyTransactionsResponse._();
  GetFamilyTransactionsResponse createEmptyInstance() => create();
  static $pb.PbList<GetFamilyTransactionsResponse> createRepeated() => $pb.PbList<GetFamilyTransactionsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetFamilyTransactionsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetFamilyTransactionsResponse>(create);
  static GetFamilyTransactionsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<FamilyTransaction> get transactions => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get totalCount => $_getIZ(1);
  @$pb.TagNumber(2)
  set totalCount($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotalCount() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalCount() => clearField(2);

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
  $core.int get totalPages => $_getIZ(4);
  @$pb.TagNumber(5)
  set totalPages($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTotalPages() => $_has(4);
  @$pb.TagNumber(5)
  void clearTotalPages() => clearField(5);
}

class AllocateFundsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AllocateFundsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'accounts.v1'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'familyId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'memberId')
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..hasRequiredFields = false
  ;

  AllocateFundsRequest._() : super();
  factory AllocateFundsRequest({
    $core.String? familyId,
    $core.String? memberId,
    $core.double? amount,
    $core.String? description,
  }) {
    final _result = create();
    if (familyId != null) {
      _result.familyId = familyId;
    }
    if (memberId != null) {
      _result.memberId = memberId;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (description != null) {
      _result.description = description;
    }
    return _result;
  }
  factory AllocateFundsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AllocateFundsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AllocateFundsRequest clone() => AllocateFundsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AllocateFundsRequest copyWith(void Function(AllocateFundsRequest) updates) => super.copyWith((message) => updates(message as AllocateFundsRequest)) as AllocateFundsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AllocateFundsRequest create() => AllocateFundsRequest._();
  AllocateFundsRequest createEmptyInstance() => create();
  static $pb.PbList<AllocateFundsRequest> createRepeated() => $pb.PbList<AllocateFundsRequest>();
  @$core.pragma('dart2js:noInline')
  static AllocateFundsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AllocateFundsRequest>(create);
  static AllocateFundsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get familyId => $_getSZ(0);
  @$pb.TagNumber(1)
  set familyId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFamilyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFamilyId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get memberId => $_getSZ(1);
  @$pb.TagNumber(2)
  set memberId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMemberId() => $_has(1);
  @$pb.TagNumber(2)
  void clearMemberId() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get amount => $_getN(2);
  @$pb.TagNumber(3)
  set amount($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get description => $_getSZ(3);
  @$pb.TagNumber(4)
  set description($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasDescription() => $_has(3);
  @$pb.TagNumber(4)
  void clearDescription() => clearField(4);
}

class AllocateFundsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AllocateFundsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'accounts.v1'), createEmptyInstance: create)
    ..aOM<FamilyMember>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'member', subBuilder: FamilyMember.create)
    ..aOM<FamilyTransaction>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transaction', subBuilder: FamilyTransaction.create)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'remainingPoolBalance', $pb.PbFieldType.OD)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  AllocateFundsResponse._() : super();
  factory AllocateFundsResponse({
    FamilyMember? member,
    FamilyTransaction? transaction,
    $core.double? remainingPoolBalance,
    $core.String? message,
  }) {
    final _result = create();
    if (member != null) {
      _result.member = member;
    }
    if (transaction != null) {
      _result.transaction = transaction;
    }
    if (remainingPoolBalance != null) {
      _result.remainingPoolBalance = remainingPoolBalance;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory AllocateFundsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AllocateFundsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AllocateFundsResponse clone() => AllocateFundsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AllocateFundsResponse copyWith(void Function(AllocateFundsResponse) updates) => super.copyWith((message) => updates(message as AllocateFundsResponse)) as AllocateFundsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AllocateFundsResponse create() => AllocateFundsResponse._();
  AllocateFundsResponse createEmptyInstance() => create();
  static $pb.PbList<AllocateFundsResponse> createRepeated() => $pb.PbList<AllocateFundsResponse>();
  @$core.pragma('dart2js:noInline')
  static AllocateFundsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AllocateFundsResponse>(create);
  static AllocateFundsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  FamilyMember get member => $_getN(0);
  @$pb.TagNumber(1)
  set member(FamilyMember v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasMember() => $_has(0);
  @$pb.TagNumber(1)
  void clearMember() => clearField(1);
  @$pb.TagNumber(1)
  FamilyMember ensureMember() => $_ensure(0);

  @$pb.TagNumber(2)
  FamilyTransaction get transaction => $_getN(1);
  @$pb.TagNumber(2)
  set transaction(FamilyTransaction v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasTransaction() => $_has(1);
  @$pb.TagNumber(2)
  void clearTransaction() => clearField(2);
  @$pb.TagNumber(2)
  FamilyTransaction ensureTransaction() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.double get remainingPoolBalance => $_getN(2);
  @$pb.TagNumber(3)
  set remainingPoolBalance($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasRemainingPoolBalance() => $_has(2);
  @$pb.TagNumber(3)
  void clearRemainingPoolBalance() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get message => $_getSZ(3);
  @$pb.TagNumber(4)
  set message($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasMessage() => $_has(3);
  @$pb.TagNumber(4)
  void clearMessage() => clearField(4);
}

class GenerateMemberCardRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GenerateMemberCardRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'accounts.v1'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'familyId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'memberId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cardName')
    ..hasRequiredFields = false
  ;

  GenerateMemberCardRequest._() : super();
  factory GenerateMemberCardRequest({
    $core.String? familyId,
    $core.String? memberId,
    $core.String? cardName,
  }) {
    final _result = create();
    if (familyId != null) {
      _result.familyId = familyId;
    }
    if (memberId != null) {
      _result.memberId = memberId;
    }
    if (cardName != null) {
      _result.cardName = cardName;
    }
    return _result;
  }
  factory GenerateMemberCardRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GenerateMemberCardRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GenerateMemberCardRequest clone() => GenerateMemberCardRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GenerateMemberCardRequest copyWith(void Function(GenerateMemberCardRequest) updates) => super.copyWith((message) => updates(message as GenerateMemberCardRequest)) as GenerateMemberCardRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GenerateMemberCardRequest create() => GenerateMemberCardRequest._();
  GenerateMemberCardRequest createEmptyInstance() => create();
  static $pb.PbList<GenerateMemberCardRequest> createRepeated() => $pb.PbList<GenerateMemberCardRequest>();
  @$core.pragma('dart2js:noInline')
  static GenerateMemberCardRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GenerateMemberCardRequest>(create);
  static GenerateMemberCardRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get familyId => $_getSZ(0);
  @$pb.TagNumber(1)
  set familyId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFamilyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFamilyId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get memberId => $_getSZ(1);
  @$pb.TagNumber(2)
  set memberId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMemberId() => $_has(1);
  @$pb.TagNumber(2)
  void clearMemberId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get cardName => $_getSZ(2);
  @$pb.TagNumber(3)
  set cardName($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCardName() => $_has(2);
  @$pb.TagNumber(3)
  void clearCardName() => clearField(3);
}

class GenerateMemberCardResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GenerateMemberCardResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'accounts.v1'), createEmptyInstance: create)
    ..aOM<AccountCard>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'card', subBuilder: AccountCard.create)
    ..aOM<FamilyMember>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'member', subBuilder: FamilyMember.create)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  GenerateMemberCardResponse._() : super();
  factory GenerateMemberCardResponse({
    AccountCard? card,
    FamilyMember? member,
    $core.String? message,
  }) {
    final _result = create();
    if (card != null) {
      _result.card = card;
    }
    if (member != null) {
      _result.member = member;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory GenerateMemberCardResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GenerateMemberCardResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GenerateMemberCardResponse clone() => GenerateMemberCardResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GenerateMemberCardResponse copyWith(void Function(GenerateMemberCardResponse) updates) => super.copyWith((message) => updates(message as GenerateMemberCardResponse)) as GenerateMemberCardResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GenerateMemberCardResponse create() => GenerateMemberCardResponse._();
  GenerateMemberCardResponse createEmptyInstance() => create();
  static $pb.PbList<GenerateMemberCardResponse> createRepeated() => $pb.PbList<GenerateMemberCardResponse>();
  @$core.pragma('dart2js:noInline')
  static GenerateMemberCardResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GenerateMemberCardResponse>(create);
  static GenerateMemberCardResponse? _defaultInstance;

  @$pb.TagNumber(1)
  AccountCard get card => $_getN(0);
  @$pb.TagNumber(1)
  set card(AccountCard v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasCard() => $_has(0);
  @$pb.TagNumber(1)
  void clearCard() => clearField(1);
  @$pb.TagNumber(1)
  AccountCard ensureCard() => $_ensure(0);

  @$pb.TagNumber(2)
  FamilyMember get member => $_getN(1);
  @$pb.TagNumber(2)
  set member(FamilyMember v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasMember() => $_has(1);
  @$pb.TagNumber(2)
  void clearMember() => clearField(2);
  @$pb.TagNumber(2)
  FamilyMember ensureMember() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => clearField(3);
}

class FreezeFamilyAccountRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'FreezeFamilyAccountRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'accounts.v1'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'familyId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reason')
    ..hasRequiredFields = false
  ;

  FreezeFamilyAccountRequest._() : super();
  factory FreezeFamilyAccountRequest({
    $core.String? familyId,
    $core.String? reason,
  }) {
    final _result = create();
    if (familyId != null) {
      _result.familyId = familyId;
    }
    if (reason != null) {
      _result.reason = reason;
    }
    return _result;
  }
  factory FreezeFamilyAccountRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FreezeFamilyAccountRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FreezeFamilyAccountRequest clone() => FreezeFamilyAccountRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FreezeFamilyAccountRequest copyWith(void Function(FreezeFamilyAccountRequest) updates) => super.copyWith((message) => updates(message as FreezeFamilyAccountRequest)) as FreezeFamilyAccountRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FreezeFamilyAccountRequest create() => FreezeFamilyAccountRequest._();
  FreezeFamilyAccountRequest createEmptyInstance() => create();
  static $pb.PbList<FreezeFamilyAccountRequest> createRepeated() => $pb.PbList<FreezeFamilyAccountRequest>();
  @$core.pragma('dart2js:noInline')
  static FreezeFamilyAccountRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FreezeFamilyAccountRequest>(create);
  static FreezeFamilyAccountRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get familyId => $_getSZ(0);
  @$pb.TagNumber(1)
  set familyId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFamilyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFamilyId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get reason => $_getSZ(1);
  @$pb.TagNumber(2)
  set reason($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasReason() => $_has(1);
  @$pb.TagNumber(2)
  void clearReason() => clearField(2);
}

class FreezeFamilyAccountResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'FreezeFamilyAccountResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'accounts.v1'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOM<FamilyAccount>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'familyAccount', subBuilder: FamilyAccount.create)
    ..hasRequiredFields = false
  ;

  FreezeFamilyAccountResponse._() : super();
  factory FreezeFamilyAccountResponse({
    $core.bool? success,
    $core.String? message,
    FamilyAccount? familyAccount,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (familyAccount != null) {
      _result.familyAccount = familyAccount;
    }
    return _result;
  }
  factory FreezeFamilyAccountResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FreezeFamilyAccountResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FreezeFamilyAccountResponse clone() => FreezeFamilyAccountResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FreezeFamilyAccountResponse copyWith(void Function(FreezeFamilyAccountResponse) updates) => super.copyWith((message) => updates(message as FreezeFamilyAccountResponse)) as FreezeFamilyAccountResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FreezeFamilyAccountResponse create() => FreezeFamilyAccountResponse._();
  FreezeFamilyAccountResponse createEmptyInstance() => create();
  static $pb.PbList<FreezeFamilyAccountResponse> createRepeated() => $pb.PbList<FreezeFamilyAccountResponse>();
  @$core.pragma('dart2js:noInline')
  static FreezeFamilyAccountResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FreezeFamilyAccountResponse>(create);
  static FreezeFamilyAccountResponse? _defaultInstance;

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
  FamilyAccount get familyAccount => $_getN(2);
  @$pb.TagNumber(3)
  set familyAccount(FamilyAccount v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasFamilyAccount() => $_has(2);
  @$pb.TagNumber(3)
  void clearFamilyAccount() => clearField(3);
  @$pb.TagNumber(3)
  FamilyAccount ensureFamilyAccount() => $_ensure(2);
}

class UnfreezeFamilyAccountRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UnfreezeFamilyAccountRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'accounts.v1'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'familyId')
    ..hasRequiredFields = false
  ;

  UnfreezeFamilyAccountRequest._() : super();
  factory UnfreezeFamilyAccountRequest({
    $core.String? familyId,
  }) {
    final _result = create();
    if (familyId != null) {
      _result.familyId = familyId;
    }
    return _result;
  }
  factory UnfreezeFamilyAccountRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UnfreezeFamilyAccountRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UnfreezeFamilyAccountRequest clone() => UnfreezeFamilyAccountRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UnfreezeFamilyAccountRequest copyWith(void Function(UnfreezeFamilyAccountRequest) updates) => super.copyWith((message) => updates(message as UnfreezeFamilyAccountRequest)) as UnfreezeFamilyAccountRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UnfreezeFamilyAccountRequest create() => UnfreezeFamilyAccountRequest._();
  UnfreezeFamilyAccountRequest createEmptyInstance() => create();
  static $pb.PbList<UnfreezeFamilyAccountRequest> createRepeated() => $pb.PbList<UnfreezeFamilyAccountRequest>();
  @$core.pragma('dart2js:noInline')
  static UnfreezeFamilyAccountRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UnfreezeFamilyAccountRequest>(create);
  static UnfreezeFamilyAccountRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get familyId => $_getSZ(0);
  @$pb.TagNumber(1)
  set familyId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFamilyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFamilyId() => clearField(1);
}

class UnfreezeFamilyAccountResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UnfreezeFamilyAccountResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'accounts.v1'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOM<FamilyAccount>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'familyAccount', subBuilder: FamilyAccount.create)
    ..hasRequiredFields = false
  ;

  UnfreezeFamilyAccountResponse._() : super();
  factory UnfreezeFamilyAccountResponse({
    $core.bool? success,
    $core.String? message,
    FamilyAccount? familyAccount,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (familyAccount != null) {
      _result.familyAccount = familyAccount;
    }
    return _result;
  }
  factory UnfreezeFamilyAccountResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UnfreezeFamilyAccountResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UnfreezeFamilyAccountResponse clone() => UnfreezeFamilyAccountResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UnfreezeFamilyAccountResponse copyWith(void Function(UnfreezeFamilyAccountResponse) updates) => super.copyWith((message) => updates(message as UnfreezeFamilyAccountResponse)) as UnfreezeFamilyAccountResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UnfreezeFamilyAccountResponse create() => UnfreezeFamilyAccountResponse._();
  UnfreezeFamilyAccountResponse createEmptyInstance() => create();
  static $pb.PbList<UnfreezeFamilyAccountResponse> createRepeated() => $pb.PbList<UnfreezeFamilyAccountResponse>();
  @$core.pragma('dart2js:noInline')
  static UnfreezeFamilyAccountResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UnfreezeFamilyAccountResponse>(create);
  static UnfreezeFamilyAccountResponse? _defaultInstance;

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
  FamilyAccount get familyAccount => $_getN(2);
  @$pb.TagNumber(3)
  set familyAccount(FamilyAccount v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasFamilyAccount() => $_has(2);
  @$pb.TagNumber(3)
  void clearFamilyAccount() => clearField(3);
  @$pb.TagNumber(3)
  FamilyAccount ensureFamilyAccount() => $_ensure(2);
}

class DeleteFamilyAccountRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DeleteFamilyAccountRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'accounts.v1'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'familyId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'confirmationCode')
    ..hasRequiredFields = false
  ;

  DeleteFamilyAccountRequest._() : super();
  factory DeleteFamilyAccountRequest({
    $core.String? familyId,
    $core.String? confirmationCode,
  }) {
    final _result = create();
    if (familyId != null) {
      _result.familyId = familyId;
    }
    if (confirmationCode != null) {
      _result.confirmationCode = confirmationCode;
    }
    return _result;
  }
  factory DeleteFamilyAccountRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteFamilyAccountRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteFamilyAccountRequest clone() => DeleteFamilyAccountRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteFamilyAccountRequest copyWith(void Function(DeleteFamilyAccountRequest) updates) => super.copyWith((message) => updates(message as DeleteFamilyAccountRequest)) as DeleteFamilyAccountRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DeleteFamilyAccountRequest create() => DeleteFamilyAccountRequest._();
  DeleteFamilyAccountRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteFamilyAccountRequest> createRepeated() => $pb.PbList<DeleteFamilyAccountRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteFamilyAccountRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteFamilyAccountRequest>(create);
  static DeleteFamilyAccountRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get familyId => $_getSZ(0);
  @$pb.TagNumber(1)
  set familyId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFamilyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFamilyId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get confirmationCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set confirmationCode($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasConfirmationCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearConfirmationCode() => clearField(2);
}

class DeleteFamilyAccountResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DeleteFamilyAccountResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'accounts.v1'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'returnedBalance', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  DeleteFamilyAccountResponse._() : super();
  factory DeleteFamilyAccountResponse({
    $core.bool? success,
    $core.String? message,
    $core.double? returnedBalance,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (returnedBalance != null) {
      _result.returnedBalance = returnedBalance;
    }
    return _result;
  }
  factory DeleteFamilyAccountResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteFamilyAccountResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteFamilyAccountResponse clone() => DeleteFamilyAccountResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteFamilyAccountResponse copyWith(void Function(DeleteFamilyAccountResponse) updates) => super.copyWith((message) => updates(message as DeleteFamilyAccountResponse)) as DeleteFamilyAccountResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DeleteFamilyAccountResponse create() => DeleteFamilyAccountResponse._();
  DeleteFamilyAccountResponse createEmptyInstance() => create();
  static $pb.PbList<DeleteFamilyAccountResponse> createRepeated() => $pb.PbList<DeleteFamilyAccountResponse>();
  @$core.pragma('dart2js:noInline')
  static DeleteFamilyAccountResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteFamilyAccountResponse>(create);
  static DeleteFamilyAccountResponse? _defaultInstance;

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
  $core.double get returnedBalance => $_getN(2);
  @$pb.TagNumber(3)
  set returnedBalance($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasReturnedBalance() => $_has(2);
  @$pb.TagNumber(3)
  void clearReturnedBalance() => clearField(3);
}

class FamilyAccount extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'FamilyAccount', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'accounts.v1'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'creatorId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'creatorName')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..a<$core.double>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalAllocatedBalance', $pb.PbFieldType.OD)
    ..a<$core.double>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalPoolBalance', $pb.PbFieldType.OD)
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt')
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedAt')
    ..pc<FamilyMember>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'members', $pb.PbFieldType.PM, subBuilder: FamilyMember.create)
    ..a<$core.int>(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'memberCount', $pb.PbFieldType.O3)
    ..a<$core.int>(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'activeMemberCount', $pb.PbFieldType.O3)
    ..aOB(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'allowMemberContributions')
    ..a<$core.double>(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalBalance', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  FamilyAccount._() : super();
  factory FamilyAccount({
    $core.String? id,
    $core.String? creatorId,
    $core.String? creatorName,
    $core.String? name,
    $core.String? description,
    $core.double? totalAllocatedBalance,
    $core.double? totalPoolBalance,
    $core.String? status,
    $core.String? createdAt,
    $core.String? updatedAt,
    $core.Iterable<FamilyMember>? members,
    $core.int? memberCount,
    $core.int? activeMemberCount,
    $core.bool? allowMemberContributions,
    $core.double? totalBalance,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (creatorId != null) {
      _result.creatorId = creatorId;
    }
    if (creatorName != null) {
      _result.creatorName = creatorName;
    }
    if (name != null) {
      _result.name = name;
    }
    if (description != null) {
      _result.description = description;
    }
    if (totalAllocatedBalance != null) {
      _result.totalAllocatedBalance = totalAllocatedBalance;
    }
    if (totalPoolBalance != null) {
      _result.totalPoolBalance = totalPoolBalance;
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
    if (members != null) {
      _result.members.addAll(members);
    }
    if (memberCount != null) {
      _result.memberCount = memberCount;
    }
    if (activeMemberCount != null) {
      _result.activeMemberCount = activeMemberCount;
    }
    if (allowMemberContributions != null) {
      _result.allowMemberContributions = allowMemberContributions;
    }
    if (totalBalance != null) {
      _result.totalBalance = totalBalance;
    }
    return _result;
  }
  factory FamilyAccount.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FamilyAccount.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FamilyAccount clone() => FamilyAccount()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FamilyAccount copyWith(void Function(FamilyAccount) updates) => super.copyWith((message) => updates(message as FamilyAccount)) as FamilyAccount; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FamilyAccount create() => FamilyAccount._();
  FamilyAccount createEmptyInstance() => create();
  static $pb.PbList<FamilyAccount> createRepeated() => $pb.PbList<FamilyAccount>();
  @$core.pragma('dart2js:noInline')
  static FamilyAccount getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FamilyAccount>(create);
  static FamilyAccount? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get creatorId => $_getSZ(1);
  @$pb.TagNumber(2)
  set creatorId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCreatorId() => $_has(1);
  @$pb.TagNumber(2)
  void clearCreatorId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get creatorName => $_getSZ(2);
  @$pb.TagNumber(3)
  set creatorName($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCreatorName() => $_has(2);
  @$pb.TagNumber(3)
  void clearCreatorName() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get name => $_getSZ(3);
  @$pb.TagNumber(4)
  set name($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasName() => $_has(3);
  @$pb.TagNumber(4)
  void clearName() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get description => $_getSZ(4);
  @$pb.TagNumber(5)
  set description($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasDescription() => $_has(4);
  @$pb.TagNumber(5)
  void clearDescription() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get totalAllocatedBalance => $_getN(5);
  @$pb.TagNumber(6)
  set totalAllocatedBalance($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasTotalAllocatedBalance() => $_has(5);
  @$pb.TagNumber(6)
  void clearTotalAllocatedBalance() => clearField(6);

  @$pb.TagNumber(7)
  $core.double get totalPoolBalance => $_getN(6);
  @$pb.TagNumber(7)
  set totalPoolBalance($core.double v) { $_setDouble(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasTotalPoolBalance() => $_has(6);
  @$pb.TagNumber(7)
  void clearTotalPoolBalance() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get status => $_getSZ(7);
  @$pb.TagNumber(8)
  set status($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasStatus() => $_has(7);
  @$pb.TagNumber(8)
  void clearStatus() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get createdAt => $_getSZ(8);
  @$pb.TagNumber(9)
  set createdAt($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasCreatedAt() => $_has(8);
  @$pb.TagNumber(9)
  void clearCreatedAt() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get updatedAt => $_getSZ(9);
  @$pb.TagNumber(10)
  set updatedAt($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasUpdatedAt() => $_has(9);
  @$pb.TagNumber(10)
  void clearUpdatedAt() => clearField(10);

  @$pb.TagNumber(11)
  $core.List<FamilyMember> get members => $_getList(10);

  @$pb.TagNumber(12)
  $core.int get memberCount => $_getIZ(11);
  @$pb.TagNumber(12)
  set memberCount($core.int v) { $_setSignedInt32(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasMemberCount() => $_has(11);
  @$pb.TagNumber(12)
  void clearMemberCount() => clearField(12);

  @$pb.TagNumber(13)
  $core.int get activeMemberCount => $_getIZ(12);
  @$pb.TagNumber(13)
  set activeMemberCount($core.int v) { $_setSignedInt32(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasActiveMemberCount() => $_has(12);
  @$pb.TagNumber(13)
  void clearActiveMemberCount() => clearField(13);

  @$pb.TagNumber(14)
  $core.bool get allowMemberContributions => $_getBF(13);
  @$pb.TagNumber(14)
  set allowMemberContributions($core.bool v) { $_setBool(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasAllowMemberContributions() => $_has(13);
  @$pb.TagNumber(14)
  void clearAllowMemberContributions() => clearField(14);

  @$pb.TagNumber(15)
  $core.double get totalBalance => $_getN(14);
  @$pb.TagNumber(15)
  set totalBalance($core.double v) { $_setDouble(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasTotalBalance() => $_has(14);
  @$pb.TagNumber(15)
  void clearTotalBalance() => clearField(15);
}

class FamilyMember extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'FamilyMember', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'accounts.v1'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'familyId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fullName')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'email')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'phone')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'username')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'avatarUrl')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'role')
    ..a<$core.double>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'allocatedBalance', $pb.PbFieldType.OD)
    ..a<$core.double>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dailySpendingLimit', $pb.PbFieldType.OD)
    ..a<$core.double>(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'monthlySpendingLimit', $pb.PbFieldType.OD)
    ..a<$core.double>(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'spentThisMonth', $pb.PbFieldType.OD)
    ..a<$core.double>(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'spentToday', $pb.PbFieldType.OD)
    ..aOS(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'invitationStatus')
    ..aOS(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'invitationToken')
    ..aOS(17, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'invitationExpiresAt')
    ..aOS(18, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cardLastFour')
    ..aOB(19, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hasCard')
    ..aOS(20, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'joinedAt')
    ..aOS(21, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt')
    ..aOS(22, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedAt')
    ..a<$core.double>(23, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'perTransactionLimit', $pb.PbFieldType.OD)
    ..a<$core.double>(24, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'allocationPercentageCap', $pb.PbFieldType.OD)
    ..a<$core.double>(25, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'remainingBalance', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  FamilyMember._() : super();
  factory FamilyMember({
    $core.String? id,
    $core.String? familyId,
    $core.String? userId,
    $core.String? fullName,
    $core.String? email,
    $core.String? phone,
    $core.String? username,
    $core.String? avatarUrl,
    $core.String? role,
    $core.double? allocatedBalance,
    $core.double? dailySpendingLimit,
    $core.double? monthlySpendingLimit,
    $core.double? spentThisMonth,
    $core.double? spentToday,
    $core.String? invitationStatus,
    $core.String? invitationToken,
    $core.String? invitationExpiresAt,
    $core.String? cardLastFour,
    $core.bool? hasCard,
    $core.String? joinedAt,
    $core.String? createdAt,
    $core.String? updatedAt,
    $core.double? perTransactionLimit,
    $core.double? allocationPercentageCap,
    $core.double? remainingBalance,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (familyId != null) {
      _result.familyId = familyId;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    if (fullName != null) {
      _result.fullName = fullName;
    }
    if (email != null) {
      _result.email = email;
    }
    if (phone != null) {
      _result.phone = phone;
    }
    if (username != null) {
      _result.username = username;
    }
    if (avatarUrl != null) {
      _result.avatarUrl = avatarUrl;
    }
    if (role != null) {
      _result.role = role;
    }
    if (allocatedBalance != null) {
      _result.allocatedBalance = allocatedBalance;
    }
    if (dailySpendingLimit != null) {
      _result.dailySpendingLimit = dailySpendingLimit;
    }
    if (monthlySpendingLimit != null) {
      _result.monthlySpendingLimit = monthlySpendingLimit;
    }
    if (spentThisMonth != null) {
      _result.spentThisMonth = spentThisMonth;
    }
    if (spentToday != null) {
      _result.spentToday = spentToday;
    }
    if (invitationStatus != null) {
      _result.invitationStatus = invitationStatus;
    }
    if (invitationToken != null) {
      _result.invitationToken = invitationToken;
    }
    if (invitationExpiresAt != null) {
      _result.invitationExpiresAt = invitationExpiresAt;
    }
    if (cardLastFour != null) {
      _result.cardLastFour = cardLastFour;
    }
    if (hasCard != null) {
      _result.hasCard = hasCard;
    }
    if (joinedAt != null) {
      _result.joinedAt = joinedAt;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      _result.updatedAt = updatedAt;
    }
    if (perTransactionLimit != null) {
      _result.perTransactionLimit = perTransactionLimit;
    }
    if (allocationPercentageCap != null) {
      _result.allocationPercentageCap = allocationPercentageCap;
    }
    if (remainingBalance != null) {
      _result.remainingBalance = remainingBalance;
    }
    return _result;
  }
  factory FamilyMember.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FamilyMember.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FamilyMember clone() => FamilyMember()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FamilyMember copyWith(void Function(FamilyMember) updates) => super.copyWith((message) => updates(message as FamilyMember)) as FamilyMember; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FamilyMember create() => FamilyMember._();
  FamilyMember createEmptyInstance() => create();
  static $pb.PbList<FamilyMember> createRepeated() => $pb.PbList<FamilyMember>();
  @$core.pragma('dart2js:noInline')
  static FamilyMember getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FamilyMember>(create);
  static FamilyMember? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get familyId => $_getSZ(1);
  @$pb.TagNumber(2)
  set familyId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasFamilyId() => $_has(1);
  @$pb.TagNumber(2)
  void clearFamilyId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get userId => $_getSZ(2);
  @$pb.TagNumber(3)
  set userId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasUserId() => $_has(2);
  @$pb.TagNumber(3)
  void clearUserId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get fullName => $_getSZ(3);
  @$pb.TagNumber(4)
  set fullName($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasFullName() => $_has(3);
  @$pb.TagNumber(4)
  void clearFullName() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get email => $_getSZ(4);
  @$pb.TagNumber(5)
  set email($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasEmail() => $_has(4);
  @$pb.TagNumber(5)
  void clearEmail() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get phone => $_getSZ(5);
  @$pb.TagNumber(6)
  set phone($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasPhone() => $_has(5);
  @$pb.TagNumber(6)
  void clearPhone() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get username => $_getSZ(6);
  @$pb.TagNumber(7)
  set username($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasUsername() => $_has(6);
  @$pb.TagNumber(7)
  void clearUsername() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get avatarUrl => $_getSZ(7);
  @$pb.TagNumber(8)
  set avatarUrl($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasAvatarUrl() => $_has(7);
  @$pb.TagNumber(8)
  void clearAvatarUrl() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get role => $_getSZ(8);
  @$pb.TagNumber(9)
  set role($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasRole() => $_has(8);
  @$pb.TagNumber(9)
  void clearRole() => clearField(9);

  @$pb.TagNumber(10)
  $core.double get allocatedBalance => $_getN(9);
  @$pb.TagNumber(10)
  set allocatedBalance($core.double v) { $_setDouble(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasAllocatedBalance() => $_has(9);
  @$pb.TagNumber(10)
  void clearAllocatedBalance() => clearField(10);

  @$pb.TagNumber(11)
  $core.double get dailySpendingLimit => $_getN(10);
  @$pb.TagNumber(11)
  set dailySpendingLimit($core.double v) { $_setDouble(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasDailySpendingLimit() => $_has(10);
  @$pb.TagNumber(11)
  void clearDailySpendingLimit() => clearField(11);

  @$pb.TagNumber(12)
  $core.double get monthlySpendingLimit => $_getN(11);
  @$pb.TagNumber(12)
  set monthlySpendingLimit($core.double v) { $_setDouble(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasMonthlySpendingLimit() => $_has(11);
  @$pb.TagNumber(12)
  void clearMonthlySpendingLimit() => clearField(12);

  @$pb.TagNumber(13)
  $core.double get spentThisMonth => $_getN(12);
  @$pb.TagNumber(13)
  set spentThisMonth($core.double v) { $_setDouble(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasSpentThisMonth() => $_has(12);
  @$pb.TagNumber(13)
  void clearSpentThisMonth() => clearField(13);

  @$pb.TagNumber(14)
  $core.double get spentToday => $_getN(13);
  @$pb.TagNumber(14)
  set spentToday($core.double v) { $_setDouble(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasSpentToday() => $_has(13);
  @$pb.TagNumber(14)
  void clearSpentToday() => clearField(14);

  @$pb.TagNumber(15)
  $core.String get invitationStatus => $_getSZ(14);
  @$pb.TagNumber(15)
  set invitationStatus($core.String v) { $_setString(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasInvitationStatus() => $_has(14);
  @$pb.TagNumber(15)
  void clearInvitationStatus() => clearField(15);

  @$pb.TagNumber(16)
  $core.String get invitationToken => $_getSZ(15);
  @$pb.TagNumber(16)
  set invitationToken($core.String v) { $_setString(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasInvitationToken() => $_has(15);
  @$pb.TagNumber(16)
  void clearInvitationToken() => clearField(16);

  @$pb.TagNumber(17)
  $core.String get invitationExpiresAt => $_getSZ(16);
  @$pb.TagNumber(17)
  set invitationExpiresAt($core.String v) { $_setString(16, v); }
  @$pb.TagNumber(17)
  $core.bool hasInvitationExpiresAt() => $_has(16);
  @$pb.TagNumber(17)
  void clearInvitationExpiresAt() => clearField(17);

  @$pb.TagNumber(18)
  $core.String get cardLastFour => $_getSZ(17);
  @$pb.TagNumber(18)
  set cardLastFour($core.String v) { $_setString(17, v); }
  @$pb.TagNumber(18)
  $core.bool hasCardLastFour() => $_has(17);
  @$pb.TagNumber(18)
  void clearCardLastFour() => clearField(18);

  @$pb.TagNumber(19)
  $core.bool get hasCard => $_getBF(18);
  @$pb.TagNumber(19)
  set hasCard($core.bool v) { $_setBool(18, v); }
  @$pb.TagNumber(19)
  $core.bool hasHasCard() => $_has(18);
  @$pb.TagNumber(19)
  void clearHasCard() => clearField(19);

  @$pb.TagNumber(20)
  $core.String get joinedAt => $_getSZ(19);
  @$pb.TagNumber(20)
  set joinedAt($core.String v) { $_setString(19, v); }
  @$pb.TagNumber(20)
  $core.bool hasJoinedAt() => $_has(19);
  @$pb.TagNumber(20)
  void clearJoinedAt() => clearField(20);

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
  $core.double get perTransactionLimit => $_getN(22);
  @$pb.TagNumber(23)
  set perTransactionLimit($core.double v) { $_setDouble(22, v); }
  @$pb.TagNumber(23)
  $core.bool hasPerTransactionLimit() => $_has(22);
  @$pb.TagNumber(23)
  void clearPerTransactionLimit() => clearField(23);

  @$pb.TagNumber(24)
  $core.double get allocationPercentageCap => $_getN(23);
  @$pb.TagNumber(24)
  set allocationPercentageCap($core.double v) { $_setDouble(23, v); }
  @$pb.TagNumber(24)
  $core.bool hasAllocationPercentageCap() => $_has(23);
  @$pb.TagNumber(24)
  void clearAllocationPercentageCap() => clearField(24);

  @$pb.TagNumber(25)
  $core.double get remainingBalance => $_getN(24);
  @$pb.TagNumber(25)
  set remainingBalance($core.double v) { $_setDouble(24, v); }
  @$pb.TagNumber(25)
  $core.bool hasRemainingBalance() => $_has(24);
  @$pb.TagNumber(25)
  void clearRemainingBalance() => clearField(25);
}

class FamilyTransaction extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'FamilyTransaction', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'accounts.v1'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'familyId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'memberId')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'memberName')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'memberAvatar')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionId')
    ..a<$core.double>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'merchantName')
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'merchantCategory')
    ..m<$core.String, $core.String>(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'metadata', entryClassName: 'FamilyTransaction.MetadataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('accounts.v1'))
    ..aOS(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt')
    ..hasRequiredFields = false
  ;

  FamilyTransaction._() : super();
  factory FamilyTransaction({
    $core.String? id,
    $core.String? familyId,
    $core.String? memberId,
    $core.String? memberName,
    $core.String? memberAvatar,
    $core.String? transactionId,
    $core.double? amount,
    $core.String? type,
    $core.String? description,
    $core.String? merchantName,
    $core.String? merchantCategory,
    $core.Map<$core.String, $core.String>? metadata,
    $core.String? createdAt,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (familyId != null) {
      _result.familyId = familyId;
    }
    if (memberId != null) {
      _result.memberId = memberId;
    }
    if (memberName != null) {
      _result.memberName = memberName;
    }
    if (memberAvatar != null) {
      _result.memberAvatar = memberAvatar;
    }
    if (transactionId != null) {
      _result.transactionId = transactionId;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (type != null) {
      _result.type = type;
    }
    if (description != null) {
      _result.description = description;
    }
    if (merchantName != null) {
      _result.merchantName = merchantName;
    }
    if (merchantCategory != null) {
      _result.merchantCategory = merchantCategory;
    }
    if (metadata != null) {
      _result.metadata.addAll(metadata);
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    return _result;
  }
  factory FamilyTransaction.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FamilyTransaction.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FamilyTransaction clone() => FamilyTransaction()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FamilyTransaction copyWith(void Function(FamilyTransaction) updates) => super.copyWith((message) => updates(message as FamilyTransaction)) as FamilyTransaction; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FamilyTransaction create() => FamilyTransaction._();
  FamilyTransaction createEmptyInstance() => create();
  static $pb.PbList<FamilyTransaction> createRepeated() => $pb.PbList<FamilyTransaction>();
  @$core.pragma('dart2js:noInline')
  static FamilyTransaction getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FamilyTransaction>(create);
  static FamilyTransaction? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get familyId => $_getSZ(1);
  @$pb.TagNumber(2)
  set familyId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasFamilyId() => $_has(1);
  @$pb.TagNumber(2)
  void clearFamilyId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get memberId => $_getSZ(2);
  @$pb.TagNumber(3)
  set memberId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMemberId() => $_has(2);
  @$pb.TagNumber(3)
  void clearMemberId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get memberName => $_getSZ(3);
  @$pb.TagNumber(4)
  set memberName($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasMemberName() => $_has(3);
  @$pb.TagNumber(4)
  void clearMemberName() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get memberAvatar => $_getSZ(4);
  @$pb.TagNumber(5)
  set memberAvatar($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasMemberAvatar() => $_has(4);
  @$pb.TagNumber(5)
  void clearMemberAvatar() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get transactionId => $_getSZ(5);
  @$pb.TagNumber(6)
  set transactionId($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasTransactionId() => $_has(5);
  @$pb.TagNumber(6)
  void clearTransactionId() => clearField(6);

  @$pb.TagNumber(7)
  $core.double get amount => $_getN(6);
  @$pb.TagNumber(7)
  set amount($core.double v) { $_setDouble(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasAmount() => $_has(6);
  @$pb.TagNumber(7)
  void clearAmount() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get type => $_getSZ(7);
  @$pb.TagNumber(8)
  set type($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasType() => $_has(7);
  @$pb.TagNumber(8)
  void clearType() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get description => $_getSZ(8);
  @$pb.TagNumber(9)
  set description($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasDescription() => $_has(8);
  @$pb.TagNumber(9)
  void clearDescription() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get merchantName => $_getSZ(9);
  @$pb.TagNumber(10)
  set merchantName($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasMerchantName() => $_has(9);
  @$pb.TagNumber(10)
  void clearMerchantName() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get merchantCategory => $_getSZ(10);
  @$pb.TagNumber(11)
  set merchantCategory($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasMerchantCategory() => $_has(10);
  @$pb.TagNumber(11)
  void clearMerchantCategory() => clearField(11);

  @$pb.TagNumber(12)
  $core.Map<$core.String, $core.String> get metadata => $_getMap(11);

  @$pb.TagNumber(13)
  $core.String get createdAt => $_getSZ(12);
  @$pb.TagNumber(13)
  set createdAt($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasCreatedAt() => $_has(12);
  @$pb.TagNumber(13)
  void clearCreatedAt() => clearField(13);
}

class PendingInvitation extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PendingInvitation', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'accounts.v1'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'invitationToken')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'familyId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'familyName')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'creatorName')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'creatorAvatar')
    ..a<$core.double>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'initialAllocation', $pb.PbFieldType.OD)
    ..a<$core.double>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dailyLimit', $pb.PbFieldType.OD)
    ..a<$core.double>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'monthlyLimit', $pb.PbFieldType.OD)
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'invitedBy')
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'expiresAt')
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt')
    ..hasRequiredFields = false
  ;

  PendingInvitation._() : super();
  factory PendingInvitation({
    $core.String? invitationToken,
    $core.String? familyId,
    $core.String? familyName,
    $core.String? creatorName,
    $core.String? creatorAvatar,
    $core.double? initialAllocation,
    $core.double? dailyLimit,
    $core.double? monthlyLimit,
    $core.String? invitedBy,
    $core.String? expiresAt,
    $core.String? createdAt,
  }) {
    final _result = create();
    if (invitationToken != null) {
      _result.invitationToken = invitationToken;
    }
    if (familyId != null) {
      _result.familyId = familyId;
    }
    if (familyName != null) {
      _result.familyName = familyName;
    }
    if (creatorName != null) {
      _result.creatorName = creatorName;
    }
    if (creatorAvatar != null) {
      _result.creatorAvatar = creatorAvatar;
    }
    if (initialAllocation != null) {
      _result.initialAllocation = initialAllocation;
    }
    if (dailyLimit != null) {
      _result.dailyLimit = dailyLimit;
    }
    if (monthlyLimit != null) {
      _result.monthlyLimit = monthlyLimit;
    }
    if (invitedBy != null) {
      _result.invitedBy = invitedBy;
    }
    if (expiresAt != null) {
      _result.expiresAt = expiresAt;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    return _result;
  }
  factory PendingInvitation.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PendingInvitation.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PendingInvitation clone() => PendingInvitation()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PendingInvitation copyWith(void Function(PendingInvitation) updates) => super.copyWith((message) => updates(message as PendingInvitation)) as PendingInvitation; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PendingInvitation create() => PendingInvitation._();
  PendingInvitation createEmptyInstance() => create();
  static $pb.PbList<PendingInvitation> createRepeated() => $pb.PbList<PendingInvitation>();
  @$core.pragma('dart2js:noInline')
  static PendingInvitation getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PendingInvitation>(create);
  static PendingInvitation? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get invitationToken => $_getSZ(0);
  @$pb.TagNumber(1)
  set invitationToken($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasInvitationToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvitationToken() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get familyId => $_getSZ(1);
  @$pb.TagNumber(2)
  set familyId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasFamilyId() => $_has(1);
  @$pb.TagNumber(2)
  void clearFamilyId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get familyName => $_getSZ(2);
  @$pb.TagNumber(3)
  set familyName($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasFamilyName() => $_has(2);
  @$pb.TagNumber(3)
  void clearFamilyName() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get creatorName => $_getSZ(3);
  @$pb.TagNumber(4)
  set creatorName($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCreatorName() => $_has(3);
  @$pb.TagNumber(4)
  void clearCreatorName() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get creatorAvatar => $_getSZ(4);
  @$pb.TagNumber(5)
  set creatorAvatar($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasCreatorAvatar() => $_has(4);
  @$pb.TagNumber(5)
  void clearCreatorAvatar() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get initialAllocation => $_getN(5);
  @$pb.TagNumber(6)
  set initialAllocation($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasInitialAllocation() => $_has(5);
  @$pb.TagNumber(6)
  void clearInitialAllocation() => clearField(6);

  @$pb.TagNumber(7)
  $core.double get dailyLimit => $_getN(6);
  @$pb.TagNumber(7)
  set dailyLimit($core.double v) { $_setDouble(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasDailyLimit() => $_has(6);
  @$pb.TagNumber(7)
  void clearDailyLimit() => clearField(7);

  @$pb.TagNumber(8)
  $core.double get monthlyLimit => $_getN(7);
  @$pb.TagNumber(8)
  set monthlyLimit($core.double v) { $_setDouble(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasMonthlyLimit() => $_has(7);
  @$pb.TagNumber(8)
  void clearMonthlyLimit() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get invitedBy => $_getSZ(8);
  @$pb.TagNumber(9)
  set invitedBy($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasInvitedBy() => $_has(8);
  @$pb.TagNumber(9)
  void clearInvitedBy() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get expiresAt => $_getSZ(9);
  @$pb.TagNumber(10)
  set expiresAt($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasExpiresAt() => $_has(9);
  @$pb.TagNumber(10)
  void clearExpiresAt() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get createdAt => $_getSZ(10);
  @$pb.TagNumber(11)
  set createdAt($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasCreatedAt() => $_has(10);
  @$pb.TagNumber(11)
  void clearCreatedAt() => clearField(11);
}

class FamilyAccountSummary extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'FamilyAccountSummary', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'accounts.v1'), createEmptyInstance: create)
    ..a<$core.double>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalAllocated', $pb.PbFieldType.OD)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalSpentThisMonth', $pb.PbFieldType.OD)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalSpentToday', $pb.PbFieldType.OD)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionCountThisMonth', $pb.PbFieldType.O3)
    ..pc<FamilyMemberSpending>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'topSpenders', $pb.PbFieldType.PM, subBuilder: FamilyMemberSpending.create)
    ..hasRequiredFields = false
  ;

  FamilyAccountSummary._() : super();
  factory FamilyAccountSummary({
    $core.double? totalAllocated,
    $core.double? totalSpentThisMonth,
    $core.double? totalSpentToday,
    $core.int? transactionCountThisMonth,
    $core.Iterable<FamilyMemberSpending>? topSpenders,
  }) {
    final _result = create();
    if (totalAllocated != null) {
      _result.totalAllocated = totalAllocated;
    }
    if (totalSpentThisMonth != null) {
      _result.totalSpentThisMonth = totalSpentThisMonth;
    }
    if (totalSpentToday != null) {
      _result.totalSpentToday = totalSpentToday;
    }
    if (transactionCountThisMonth != null) {
      _result.transactionCountThisMonth = transactionCountThisMonth;
    }
    if (topSpenders != null) {
      _result.topSpenders.addAll(topSpenders);
    }
    return _result;
  }
  factory FamilyAccountSummary.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FamilyAccountSummary.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FamilyAccountSummary clone() => FamilyAccountSummary()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FamilyAccountSummary copyWith(void Function(FamilyAccountSummary) updates) => super.copyWith((message) => updates(message as FamilyAccountSummary)) as FamilyAccountSummary; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FamilyAccountSummary create() => FamilyAccountSummary._();
  FamilyAccountSummary createEmptyInstance() => create();
  static $pb.PbList<FamilyAccountSummary> createRepeated() => $pb.PbList<FamilyAccountSummary>();
  @$core.pragma('dart2js:noInline')
  static FamilyAccountSummary getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FamilyAccountSummary>(create);
  static FamilyAccountSummary? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get totalAllocated => $_getN(0);
  @$pb.TagNumber(1)
  set totalAllocated($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTotalAllocated() => $_has(0);
  @$pb.TagNumber(1)
  void clearTotalAllocated() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get totalSpentThisMonth => $_getN(1);
  @$pb.TagNumber(2)
  set totalSpentThisMonth($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotalSpentThisMonth() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalSpentThisMonth() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get totalSpentToday => $_getN(2);
  @$pb.TagNumber(3)
  set totalSpentToday($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTotalSpentToday() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalSpentToday() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get transactionCountThisMonth => $_getIZ(3);
  @$pb.TagNumber(4)
  set transactionCountThisMonth($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTransactionCountThisMonth() => $_has(3);
  @$pb.TagNumber(4)
  void clearTransactionCountThisMonth() => clearField(4);

  @$pb.TagNumber(5)
  $core.List<FamilyMemberSpending> get topSpenders => $_getList(4);
}

class FamilyMemberSpending extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'FamilyMemberSpending', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'accounts.v1'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'memberId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'memberName')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'memberAvatar')
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amountSpent', $pb.PbFieldType.OD)
    ..a<$core.int>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionCount', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  FamilyMemberSpending._() : super();
  factory FamilyMemberSpending({
    $core.String? memberId,
    $core.String? memberName,
    $core.String? memberAvatar,
    $core.double? amountSpent,
    $core.int? transactionCount,
  }) {
    final _result = create();
    if (memberId != null) {
      _result.memberId = memberId;
    }
    if (memberName != null) {
      _result.memberName = memberName;
    }
    if (memberAvatar != null) {
      _result.memberAvatar = memberAvatar;
    }
    if (amountSpent != null) {
      _result.amountSpent = amountSpent;
    }
    if (transactionCount != null) {
      _result.transactionCount = transactionCount;
    }
    return _result;
  }
  factory FamilyMemberSpending.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FamilyMemberSpending.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FamilyMemberSpending clone() => FamilyMemberSpending()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FamilyMemberSpending copyWith(void Function(FamilyMemberSpending) updates) => super.copyWith((message) => updates(message as FamilyMemberSpending)) as FamilyMemberSpending; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FamilyMemberSpending create() => FamilyMemberSpending._();
  FamilyMemberSpending createEmptyInstance() => create();
  static $pb.PbList<FamilyMemberSpending> createRepeated() => $pb.PbList<FamilyMemberSpending>();
  @$core.pragma('dart2js:noInline')
  static FamilyMemberSpending getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FamilyMemberSpending>(create);
  static FamilyMemberSpending? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get memberId => $_getSZ(0);
  @$pb.TagNumber(1)
  set memberId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMemberId() => $_has(0);
  @$pb.TagNumber(1)
  void clearMemberId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get memberName => $_getSZ(1);
  @$pb.TagNumber(2)
  set memberName($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMemberName() => $_has(1);
  @$pb.TagNumber(2)
  void clearMemberName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get memberAvatar => $_getSZ(2);
  @$pb.TagNumber(3)
  set memberAvatar($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMemberAvatar() => $_has(2);
  @$pb.TagNumber(3)
  void clearMemberAvatar() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get amountSpent => $_getN(3);
  @$pb.TagNumber(4)
  set amountSpent($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasAmountSpent() => $_has(3);
  @$pb.TagNumber(4)
  void clearAmountSpent() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get transactionCount => $_getIZ(4);
  @$pb.TagNumber(5)
  set transactionCount($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTransactionCount() => $_has(4);
  @$pb.TagNumber(5)
  void clearTransactionCount() => clearField(5);
}

class AccountCard extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AccountCard', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'accounts.v1'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  AccountCard._() : super();
  factory AccountCard() => create();
  factory AccountCard.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AccountCard.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AccountCard clone() => AccountCard()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AccountCard copyWith(void Function(AccountCard) updates) => super.copyWith((message) => updates(message as AccountCard)) as AccountCard; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AccountCard create() => AccountCard._();
  AccountCard createEmptyInstance() => create();
  static $pb.PbList<AccountCard> createRepeated() => $pb.PbList<AccountCard>();
  @$core.pragma('dart2js:noInline')
  static AccountCard getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AccountCard>(create);
  static AccountCard? _defaultInstance;
}

