///
//  Generated code. Do not modify.
//  source: banking.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/timestamp.pb.dart' as $1;

class CreateVirtualAccountRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateVirtualAccountRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'email')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'firstName')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lastName')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'phoneNumber')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bvn')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..hasRequiredFields = false
  ;

  CreateVirtualAccountRequest._() : super();
  factory CreateVirtualAccountRequest({
    $core.String? userId,
    $core.String? email,
    $core.String? firstName,
    $core.String? lastName,
    $core.String? phoneNumber,
    $core.String? bvn,
    $core.String? currency,
  }) {
    final _result = create();
    if (userId != null) {
      _result.userId = userId;
    }
    if (email != null) {
      _result.email = email;
    }
    if (firstName != null) {
      _result.firstName = firstName;
    }
    if (lastName != null) {
      _result.lastName = lastName;
    }
    if (phoneNumber != null) {
      _result.phoneNumber = phoneNumber;
    }
    if (bvn != null) {
      _result.bvn = bvn;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    return _result;
  }
  factory CreateVirtualAccountRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateVirtualAccountRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateVirtualAccountRequest clone() => CreateVirtualAccountRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateVirtualAccountRequest copyWith(void Function(CreateVirtualAccountRequest) updates) => super.copyWith((message) => updates(message as CreateVirtualAccountRequest)) as CreateVirtualAccountRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateVirtualAccountRequest create() => CreateVirtualAccountRequest._();
  CreateVirtualAccountRequest createEmptyInstance() => create();
  static $pb.PbList<CreateVirtualAccountRequest> createRepeated() => $pb.PbList<CreateVirtualAccountRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateVirtualAccountRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateVirtualAccountRequest>(create);
  static CreateVirtualAccountRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get email => $_getSZ(1);
  @$pb.TagNumber(2)
  set email($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasEmail() => $_has(1);
  @$pb.TagNumber(2)
  void clearEmail() => clearField(2);

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
  $core.String get phoneNumber => $_getSZ(4);
  @$pb.TagNumber(5)
  set phoneNumber($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasPhoneNumber() => $_has(4);
  @$pb.TagNumber(5)
  void clearPhoneNumber() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get bvn => $_getSZ(5);
  @$pb.TagNumber(6)
  set bvn($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasBvn() => $_has(5);
  @$pb.TagNumber(6)
  void clearBvn() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get currency => $_getSZ(6);
  @$pb.TagNumber(7)
  set currency($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasCurrency() => $_has(6);
  @$pb.TagNumber(7)
  void clearCurrency() => clearField(7);
}

class GetVirtualAccountRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetVirtualAccountRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountNumber')
    ..hasRequiredFields = false
  ;

  GetVirtualAccountRequest._() : super();
  factory GetVirtualAccountRequest({
    $core.String? accountNumber,
  }) {
    final _result = create();
    if (accountNumber != null) {
      _result.accountNumber = accountNumber;
    }
    return _result;
  }
  factory GetVirtualAccountRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetVirtualAccountRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetVirtualAccountRequest clone() => GetVirtualAccountRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetVirtualAccountRequest copyWith(void Function(GetVirtualAccountRequest) updates) => super.copyWith((message) => updates(message as GetVirtualAccountRequest)) as GetVirtualAccountRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetVirtualAccountRequest create() => GetVirtualAccountRequest._();
  GetVirtualAccountRequest createEmptyInstance() => create();
  static $pb.PbList<GetVirtualAccountRequest> createRepeated() => $pb.PbList<GetVirtualAccountRequest>();
  @$core.pragma('dart2js:noInline')
  static GetVirtualAccountRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetVirtualAccountRequest>(create);
  static GetVirtualAccountRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountNumber => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountNumber($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccountNumber() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountNumber() => clearField(1);
}

class GetUserVirtualAccountsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetUserVirtualAccountsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..hasRequiredFields = false
  ;

  GetUserVirtualAccountsRequest._() : super();
  factory GetUserVirtualAccountsRequest({
    $core.String? userId,
  }) {
    final _result = create();
    if (userId != null) {
      _result.userId = userId;
    }
    return _result;
  }
  factory GetUserVirtualAccountsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUserVirtualAccountsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUserVirtualAccountsRequest clone() => GetUserVirtualAccountsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUserVirtualAccountsRequest copyWith(void Function(GetUserVirtualAccountsRequest) updates) => super.copyWith((message) => updates(message as GetUserVirtualAccountsRequest)) as GetUserVirtualAccountsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetUserVirtualAccountsRequest create() => GetUserVirtualAccountsRequest._();
  GetUserVirtualAccountsRequest createEmptyInstance() => create();
  static $pb.PbList<GetUserVirtualAccountsRequest> createRepeated() => $pb.PbList<GetUserVirtualAccountsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetUserVirtualAccountsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetUserVirtualAccountsRequest>(create);
  static GetUserVirtualAccountsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);
}

class VirtualAccountResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'VirtualAccountResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errorCode')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errorMessage')
    ..aOM<VirtualAccount>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'account', subBuilder: VirtualAccount.create)
    ..hasRequiredFields = false
  ;

  VirtualAccountResponse._() : super();
  factory VirtualAccountResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
    VirtualAccount? account,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (errorCode != null) {
      _result.errorCode = errorCode;
    }
    if (errorMessage != null) {
      _result.errorMessage = errorMessage;
    }
    if (account != null) {
      _result.account = account;
    }
    return _result;
  }
  factory VirtualAccountResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VirtualAccountResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VirtualAccountResponse clone() => VirtualAccountResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VirtualAccountResponse copyWith(void Function(VirtualAccountResponse) updates) => super.copyWith((message) => updates(message as VirtualAccountResponse)) as VirtualAccountResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static VirtualAccountResponse create() => VirtualAccountResponse._();
  VirtualAccountResponse createEmptyInstance() => create();
  static $pb.PbList<VirtualAccountResponse> createRepeated() => $pb.PbList<VirtualAccountResponse>();
  @$core.pragma('dart2js:noInline')
  static VirtualAccountResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VirtualAccountResponse>(create);
  static VirtualAccountResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => clearField(3);

  @$pb.TagNumber(4)
  VirtualAccount get account => $_getN(3);
  @$pb.TagNumber(4)
  set account(VirtualAccount v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasAccount() => $_has(3);
  @$pb.TagNumber(4)
  void clearAccount() => clearField(4);
  @$pb.TagNumber(4)
  VirtualAccount ensureAccount() => $_ensure(3);
}

class VirtualAccountsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'VirtualAccountsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errorCode')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errorMessage')
    ..pc<VirtualAccount>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accounts', $pb.PbFieldType.PM, subBuilder: VirtualAccount.create)
    ..hasRequiredFields = false
  ;

  VirtualAccountsResponse._() : super();
  factory VirtualAccountsResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
    $core.Iterable<VirtualAccount>? accounts,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (errorCode != null) {
      _result.errorCode = errorCode;
    }
    if (errorMessage != null) {
      _result.errorMessage = errorMessage;
    }
    if (accounts != null) {
      _result.accounts.addAll(accounts);
    }
    return _result;
  }
  factory VirtualAccountsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VirtualAccountsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VirtualAccountsResponse clone() => VirtualAccountsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VirtualAccountsResponse copyWith(void Function(VirtualAccountsResponse) updates) => super.copyWith((message) => updates(message as VirtualAccountsResponse)) as VirtualAccountsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static VirtualAccountsResponse create() => VirtualAccountsResponse._();
  VirtualAccountsResponse createEmptyInstance() => create();
  static $pb.PbList<VirtualAccountsResponse> createRepeated() => $pb.PbList<VirtualAccountsResponse>();
  @$core.pragma('dart2js:noInline')
  static VirtualAccountsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VirtualAccountsResponse>(create);
  static VirtualAccountsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<VirtualAccount> get accounts => $_getList(3);
}

class VirtualAccount extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'VirtualAccount', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountNumber')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountName')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bankCode')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bankName')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'provider')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..aInt64(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'balance')
    ..aInt64(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'availableBalance')
    ..aOM<$1.Timestamp>(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $1.Timestamp.create)
    ..aInt64(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pendingCredits')
    ..aInt64(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pendingDebits')
    ..aOS(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountType')
    ..aOB(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isPrimary')
    ..a<$core.int>(17, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'kycTier', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  VirtualAccount._() : super();
  factory VirtualAccount({
    $core.String? id,
    $core.String? userId,
    $core.String? accountNumber,
    $core.String? accountName,
    $core.String? bankCode,
    $core.String? bankName,
    $core.String? currency,
    $core.String? provider,
    $core.String? status,
    $fixnum.Int64? balance,
    $fixnum.Int64? availableBalance,
    $1.Timestamp? createdAt,
    $fixnum.Int64? pendingCredits,
    $fixnum.Int64? pendingDebits,
    $core.String? accountType,
    $core.bool? isPrimary,
    $core.int? kycTier,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    if (accountNumber != null) {
      _result.accountNumber = accountNumber;
    }
    if (accountName != null) {
      _result.accountName = accountName;
    }
    if (bankCode != null) {
      _result.bankCode = bankCode;
    }
    if (bankName != null) {
      _result.bankName = bankName;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (provider != null) {
      _result.provider = provider;
    }
    if (status != null) {
      _result.status = status;
    }
    if (balance != null) {
      _result.balance = balance;
    }
    if (availableBalance != null) {
      _result.availableBalance = availableBalance;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (pendingCredits != null) {
      _result.pendingCredits = pendingCredits;
    }
    if (pendingDebits != null) {
      _result.pendingDebits = pendingDebits;
    }
    if (accountType != null) {
      _result.accountType = accountType;
    }
    if (isPrimary != null) {
      _result.isPrimary = isPrimary;
    }
    if (kycTier != null) {
      _result.kycTier = kycTier;
    }
    return _result;
  }
  factory VirtualAccount.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VirtualAccount.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VirtualAccount clone() => VirtualAccount()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VirtualAccount copyWith(void Function(VirtualAccount) updates) => super.copyWith((message) => updates(message as VirtualAccount)) as VirtualAccount; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static VirtualAccount create() => VirtualAccount._();
  VirtualAccount createEmptyInstance() => create();
  static $pb.PbList<VirtualAccount> createRepeated() => $pb.PbList<VirtualAccount>();
  @$core.pragma('dart2js:noInline')
  static VirtualAccount getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VirtualAccount>(create);
  static VirtualAccount? _defaultInstance;

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
  $core.String get accountNumber => $_getSZ(2);
  @$pb.TagNumber(3)
  set accountNumber($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAccountNumber() => $_has(2);
  @$pb.TagNumber(3)
  void clearAccountNumber() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get accountName => $_getSZ(3);
  @$pb.TagNumber(4)
  set accountName($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasAccountName() => $_has(3);
  @$pb.TagNumber(4)
  void clearAccountName() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get bankCode => $_getSZ(4);
  @$pb.TagNumber(5)
  set bankCode($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasBankCode() => $_has(4);
  @$pb.TagNumber(5)
  void clearBankCode() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get bankName => $_getSZ(5);
  @$pb.TagNumber(6)
  set bankName($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasBankName() => $_has(5);
  @$pb.TagNumber(6)
  void clearBankName() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get currency => $_getSZ(6);
  @$pb.TagNumber(7)
  set currency($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasCurrency() => $_has(6);
  @$pb.TagNumber(7)
  void clearCurrency() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get provider => $_getSZ(7);
  @$pb.TagNumber(8)
  set provider($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasProvider() => $_has(7);
  @$pb.TagNumber(8)
  void clearProvider() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get status => $_getSZ(8);
  @$pb.TagNumber(9)
  set status($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasStatus() => $_has(8);
  @$pb.TagNumber(9)
  void clearStatus() => clearField(9);

  @$pb.TagNumber(10)
  $fixnum.Int64 get balance => $_getI64(9);
  @$pb.TagNumber(10)
  set balance($fixnum.Int64 v) { $_setInt64(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasBalance() => $_has(9);
  @$pb.TagNumber(10)
  void clearBalance() => clearField(10);

  @$pb.TagNumber(11)
  $fixnum.Int64 get availableBalance => $_getI64(10);
  @$pb.TagNumber(11)
  set availableBalance($fixnum.Int64 v) { $_setInt64(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasAvailableBalance() => $_has(10);
  @$pb.TagNumber(11)
  void clearAvailableBalance() => clearField(11);

  @$pb.TagNumber(12)
  $1.Timestamp get createdAt => $_getN(11);
  @$pb.TagNumber(12)
  set createdAt($1.Timestamp v) { setField(12, v); }
  @$pb.TagNumber(12)
  $core.bool hasCreatedAt() => $_has(11);
  @$pb.TagNumber(12)
  void clearCreatedAt() => clearField(12);
  @$pb.TagNumber(12)
  $1.Timestamp ensureCreatedAt() => $_ensure(11);

  @$pb.TagNumber(13)
  $fixnum.Int64 get pendingCredits => $_getI64(12);
  @$pb.TagNumber(13)
  set pendingCredits($fixnum.Int64 v) { $_setInt64(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasPendingCredits() => $_has(12);
  @$pb.TagNumber(13)
  void clearPendingCredits() => clearField(13);

  @$pb.TagNumber(14)
  $fixnum.Int64 get pendingDebits => $_getI64(13);
  @$pb.TagNumber(14)
  set pendingDebits($fixnum.Int64 v) { $_setInt64(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasPendingDebits() => $_has(13);
  @$pb.TagNumber(14)
  void clearPendingDebits() => clearField(14);

  @$pb.TagNumber(15)
  $core.String get accountType => $_getSZ(14);
  @$pb.TagNumber(15)
  set accountType($core.String v) { $_setString(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasAccountType() => $_has(14);
  @$pb.TagNumber(15)
  void clearAccountType() => clearField(15);

  @$pb.TagNumber(16)
  $core.bool get isPrimary => $_getBF(15);
  @$pb.TagNumber(16)
  set isPrimary($core.bool v) { $_setBool(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasIsPrimary() => $_has(15);
  @$pb.TagNumber(16)
  void clearIsPrimary() => clearField(16);

  @$pb.TagNumber(17)
  $core.int get kycTier => $_getIZ(16);
  @$pb.TagNumber(17)
  set kycTier($core.int v) { $_setSignedInt32(16, v); }
  @$pb.TagNumber(17)
  $core.bool hasKycTier() => $_has(16);
  @$pb.TagNumber(17)
  void clearKycTier() => clearField(17);
}

class VerifyBankAccountRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'VerifyBankAccountRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountNumber')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bankCode')
    ..hasRequiredFields = false
  ;

  VerifyBankAccountRequest._() : super();
  factory VerifyBankAccountRequest({
    $core.String? accountNumber,
    $core.String? bankCode,
  }) {
    final _result = create();
    if (accountNumber != null) {
      _result.accountNumber = accountNumber;
    }
    if (bankCode != null) {
      _result.bankCode = bankCode;
    }
    return _result;
  }
  factory VerifyBankAccountRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VerifyBankAccountRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VerifyBankAccountRequest clone() => VerifyBankAccountRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VerifyBankAccountRequest copyWith(void Function(VerifyBankAccountRequest) updates) => super.copyWith((message) => updates(message as VerifyBankAccountRequest)) as VerifyBankAccountRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static VerifyBankAccountRequest create() => VerifyBankAccountRequest._();
  VerifyBankAccountRequest createEmptyInstance() => create();
  static $pb.PbList<VerifyBankAccountRequest> createRepeated() => $pb.PbList<VerifyBankAccountRequest>();
  @$core.pragma('dart2js:noInline')
  static VerifyBankAccountRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VerifyBankAccountRequest>(create);
  static VerifyBankAccountRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountNumber => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountNumber($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccountNumber() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountNumber() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get bankCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set bankCode($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasBankCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearBankCode() => clearField(2);
}

class VerifyBankAccountResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'VerifyBankAccountResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errorCode')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errorMessage')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountNumber')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountName')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bankCode')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bankName')
    ..aOB(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isValid')
    ..hasRequiredFields = false
  ;

  VerifyBankAccountResponse._() : super();
  factory VerifyBankAccountResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
    $core.String? accountNumber,
    $core.String? accountName,
    $core.String? bankCode,
    $core.String? bankName,
    $core.bool? isValid,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (errorCode != null) {
      _result.errorCode = errorCode;
    }
    if (errorMessage != null) {
      _result.errorMessage = errorMessage;
    }
    if (accountNumber != null) {
      _result.accountNumber = accountNumber;
    }
    if (accountName != null) {
      _result.accountName = accountName;
    }
    if (bankCode != null) {
      _result.bankCode = bankCode;
    }
    if (bankName != null) {
      _result.bankName = bankName;
    }
    if (isValid != null) {
      _result.isValid = isValid;
    }
    return _result;
  }
  factory VerifyBankAccountResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VerifyBankAccountResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VerifyBankAccountResponse clone() => VerifyBankAccountResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VerifyBankAccountResponse copyWith(void Function(VerifyBankAccountResponse) updates) => super.copyWith((message) => updates(message as VerifyBankAccountResponse)) as VerifyBankAccountResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static VerifyBankAccountResponse create() => VerifyBankAccountResponse._();
  VerifyBankAccountResponse createEmptyInstance() => create();
  static $pb.PbList<VerifyBankAccountResponse> createRepeated() => $pb.PbList<VerifyBankAccountResponse>();
  @$core.pragma('dart2js:noInline')
  static VerifyBankAccountResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VerifyBankAccountResponse>(create);
  static VerifyBankAccountResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get accountNumber => $_getSZ(3);
  @$pb.TagNumber(4)
  set accountNumber($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasAccountNumber() => $_has(3);
  @$pb.TagNumber(4)
  void clearAccountNumber() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get accountName => $_getSZ(4);
  @$pb.TagNumber(5)
  set accountName($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasAccountName() => $_has(4);
  @$pb.TagNumber(5)
  void clearAccountName() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get bankCode => $_getSZ(5);
  @$pb.TagNumber(6)
  set bankCode($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasBankCode() => $_has(5);
  @$pb.TagNumber(6)
  void clearBankCode() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get bankName => $_getSZ(6);
  @$pb.TagNumber(7)
  set bankName($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasBankName() => $_has(6);
  @$pb.TagNumber(7)
  void clearBankName() => clearField(7);

  @$pb.TagNumber(8)
  $core.bool get isValid => $_getBF(7);
  @$pb.TagNumber(8)
  set isValid($core.bool v) { $_setBool(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasIsValid() => $_has(7);
  @$pb.TagNumber(8)
  void clearIsValid() => clearField(8);
}

class GetBanksRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetBanksRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'country')
    ..hasRequiredFields = false
  ;

  GetBanksRequest._() : super();
  factory GetBanksRequest({
    $core.String? country,
  }) {
    final _result = create();
    if (country != null) {
      _result.country = country;
    }
    return _result;
  }
  factory GetBanksRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetBanksRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetBanksRequest clone() => GetBanksRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetBanksRequest copyWith(void Function(GetBanksRequest) updates) => super.copyWith((message) => updates(message as GetBanksRequest)) as GetBanksRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetBanksRequest create() => GetBanksRequest._();
  GetBanksRequest createEmptyInstance() => create();
  static $pb.PbList<GetBanksRequest> createRepeated() => $pb.PbList<GetBanksRequest>();
  @$core.pragma('dart2js:noInline')
  static GetBanksRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetBanksRequest>(create);
  static GetBanksRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get country => $_getSZ(0);
  @$pb.TagNumber(1)
  set country($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCountry() => $_has(0);
  @$pb.TagNumber(1)
  void clearCountry() => clearField(1);
}

class BanksResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'BanksResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errorCode')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errorMessage')
    ..pc<Bank>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'banks', $pb.PbFieldType.PM, subBuilder: Bank.create)
    ..hasRequiredFields = false
  ;

  BanksResponse._() : super();
  factory BanksResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
    $core.Iterable<Bank>? banks,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (errorCode != null) {
      _result.errorCode = errorCode;
    }
    if (errorMessage != null) {
      _result.errorMessage = errorMessage;
    }
    if (banks != null) {
      _result.banks.addAll(banks);
    }
    return _result;
  }
  factory BanksResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BanksResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BanksResponse clone() => BanksResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BanksResponse copyWith(void Function(BanksResponse) updates) => super.copyWith((message) => updates(message as BanksResponse)) as BanksResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static BanksResponse create() => BanksResponse._();
  BanksResponse createEmptyInstance() => create();
  static $pb.PbList<BanksResponse> createRepeated() => $pb.PbList<BanksResponse>();
  @$core.pragma('dart2js:noInline')
  static BanksResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BanksResponse>(create);
  static BanksResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<Bank> get banks => $_getList(3);
}

class Bank extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Bank', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'code')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'country')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'nipCode')
    ..aOB(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isActive')
    ..hasRequiredFields = false
  ;

  Bank._() : super();
  factory Bank({
    $core.String? code,
    $core.String? name,
    $core.String? country,
    $core.String? nipCode,
    $core.bool? isActive,
  }) {
    final _result = create();
    if (code != null) {
      _result.code = code;
    }
    if (name != null) {
      _result.name = name;
    }
    if (country != null) {
      _result.country = country;
    }
    if (nipCode != null) {
      _result.nipCode = nipCode;
    }
    if (isActive != null) {
      _result.isActive = isActive;
    }
    return _result;
  }
  factory Bank.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Bank.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Bank clone() => Bank()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Bank copyWith(void Function(Bank) updates) => super.copyWith((message) => updates(message as Bank)) as Bank; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Bank create() => Bank._();
  Bank createEmptyInstance() => create();
  static $pb.PbList<Bank> createRepeated() => $pb.PbList<Bank>();
  @$core.pragma('dart2js:noInline')
  static Bank getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Bank>(create);
  static Bank? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get code => $_getSZ(0);
  @$pb.TagNumber(1)
  set code($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearCode() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get country => $_getSZ(2);
  @$pb.TagNumber(3)
  set country($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCountry() => $_has(2);
  @$pb.TagNumber(3)
  void clearCountry() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get nipCode => $_getSZ(3);
  @$pb.TagNumber(4)
  set nipCode($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasNipCode() => $_has(3);
  @$pb.TagNumber(4)
  void clearNipCode() => clearField(4);

  @$pb.TagNumber(5)
  $core.bool get isActive => $_getBF(4);
  @$pb.TagNumber(5)
  set isActive($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasIsActive() => $_has(4);
  @$pb.TagNumber(5)
  void clearIsActive() => clearField(5);
}

class VerifyBVNRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'VerifyBVNRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bvn')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'firstName')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lastName')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dateOfBirth')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'phoneNumber')
    ..hasRequiredFields = false
  ;

  VerifyBVNRequest._() : super();
  factory VerifyBVNRequest({
    $core.String? userId,
    $core.String? bvn,
    $core.String? firstName,
    $core.String? lastName,
    $core.String? dateOfBirth,
    $core.String? phoneNumber,
  }) {
    final _result = create();
    if (userId != null) {
      _result.userId = userId;
    }
    if (bvn != null) {
      _result.bvn = bvn;
    }
    if (firstName != null) {
      _result.firstName = firstName;
    }
    if (lastName != null) {
      _result.lastName = lastName;
    }
    if (dateOfBirth != null) {
      _result.dateOfBirth = dateOfBirth;
    }
    if (phoneNumber != null) {
      _result.phoneNumber = phoneNumber;
    }
    return _result;
  }
  factory VerifyBVNRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VerifyBVNRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VerifyBVNRequest clone() => VerifyBVNRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VerifyBVNRequest copyWith(void Function(VerifyBVNRequest) updates) => super.copyWith((message) => updates(message as VerifyBVNRequest)) as VerifyBVNRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static VerifyBVNRequest create() => VerifyBVNRequest._();
  VerifyBVNRequest createEmptyInstance() => create();
  static $pb.PbList<VerifyBVNRequest> createRepeated() => $pb.PbList<VerifyBVNRequest>();
  @$core.pragma('dart2js:noInline')
  static VerifyBVNRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VerifyBVNRequest>(create);
  static VerifyBVNRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get bvn => $_getSZ(1);
  @$pb.TagNumber(2)
  set bvn($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasBvn() => $_has(1);
  @$pb.TagNumber(2)
  void clearBvn() => clearField(2);

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
  $core.String get dateOfBirth => $_getSZ(4);
  @$pb.TagNumber(5)
  set dateOfBirth($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasDateOfBirth() => $_has(4);
  @$pb.TagNumber(5)
  void clearDateOfBirth() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get phoneNumber => $_getSZ(5);
  @$pb.TagNumber(6)
  set phoneNumber($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasPhoneNumber() => $_has(5);
  @$pb.TagNumber(6)
  void clearPhoneNumber() => clearField(6);
}

class GetVerificationStatusRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetVerificationStatusRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..hasRequiredFields = false
  ;

  GetVerificationStatusRequest._() : super();
  factory GetVerificationStatusRequest({
    $core.String? userId,
  }) {
    final _result = create();
    if (userId != null) {
      _result.userId = userId;
    }
    return _result;
  }
  factory GetVerificationStatusRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetVerificationStatusRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetVerificationStatusRequest clone() => GetVerificationStatusRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetVerificationStatusRequest copyWith(void Function(GetVerificationStatusRequest) updates) => super.copyWith((message) => updates(message as GetVerificationStatusRequest)) as GetVerificationStatusRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetVerificationStatusRequest create() => GetVerificationStatusRequest._();
  GetVerificationStatusRequest createEmptyInstance() => create();
  static $pb.PbList<GetVerificationStatusRequest> createRepeated() => $pb.PbList<GetVerificationStatusRequest>();
  @$core.pragma('dart2js:noInline')
  static GetVerificationStatusRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetVerificationStatusRequest>(create);
  static GetVerificationStatusRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);
}

class IdentityVerificationResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'IdentityVerificationResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errorCode')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errorMessage')
    ..aOM<IdentityVerification>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'verification', subBuilder: IdentityVerification.create)
    ..hasRequiredFields = false
  ;

  IdentityVerificationResponse._() : super();
  factory IdentityVerificationResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
    IdentityVerification? verification,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (errorCode != null) {
      _result.errorCode = errorCode;
    }
    if (errorMessage != null) {
      _result.errorMessage = errorMessage;
    }
    if (verification != null) {
      _result.verification = verification;
    }
    return _result;
  }
  factory IdentityVerificationResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory IdentityVerificationResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  IdentityVerificationResponse clone() => IdentityVerificationResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  IdentityVerificationResponse copyWith(void Function(IdentityVerificationResponse) updates) => super.copyWith((message) => updates(message as IdentityVerificationResponse)) as IdentityVerificationResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static IdentityVerificationResponse create() => IdentityVerificationResponse._();
  IdentityVerificationResponse createEmptyInstance() => create();
  static $pb.PbList<IdentityVerificationResponse> createRepeated() => $pb.PbList<IdentityVerificationResponse>();
  @$core.pragma('dart2js:noInline')
  static IdentityVerificationResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<IdentityVerificationResponse>(create);
  static IdentityVerificationResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => clearField(3);

  @$pb.TagNumber(4)
  IdentityVerification get verification => $_getN(3);
  @$pb.TagNumber(4)
  set verification(IdentityVerification v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasVerification() => $_has(3);
  @$pb.TagNumber(4)
  void clearVerification() => clearField(4);
  @$pb.TagNumber(4)
  IdentityVerification ensureVerification() => $_ensure(3);
}

class IdentityVerification extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'IdentityVerification', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bvn')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'firstName')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lastName')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'middleName')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dateOfBirth')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'phoneNumber')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'gender')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'provider')
    ..aOM<$1.Timestamp>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'verifiedAt', subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false
  ;

  IdentityVerification._() : super();
  factory IdentityVerification({
    $core.String? userId,
    $core.String? bvn,
    $core.String? firstName,
    $core.String? lastName,
    $core.String? middleName,
    $core.String? dateOfBirth,
    $core.String? phoneNumber,
    $core.String? gender,
    $core.String? status,
    $core.String? provider,
    $1.Timestamp? verifiedAt,
  }) {
    final _result = create();
    if (userId != null) {
      _result.userId = userId;
    }
    if (bvn != null) {
      _result.bvn = bvn;
    }
    if (firstName != null) {
      _result.firstName = firstName;
    }
    if (lastName != null) {
      _result.lastName = lastName;
    }
    if (middleName != null) {
      _result.middleName = middleName;
    }
    if (dateOfBirth != null) {
      _result.dateOfBirth = dateOfBirth;
    }
    if (phoneNumber != null) {
      _result.phoneNumber = phoneNumber;
    }
    if (gender != null) {
      _result.gender = gender;
    }
    if (status != null) {
      _result.status = status;
    }
    if (provider != null) {
      _result.provider = provider;
    }
    if (verifiedAt != null) {
      _result.verifiedAt = verifiedAt;
    }
    return _result;
  }
  factory IdentityVerification.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory IdentityVerification.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  IdentityVerification clone() => IdentityVerification()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  IdentityVerification copyWith(void Function(IdentityVerification) updates) => super.copyWith((message) => updates(message as IdentityVerification)) as IdentityVerification; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static IdentityVerification create() => IdentityVerification._();
  IdentityVerification createEmptyInstance() => create();
  static $pb.PbList<IdentityVerification> createRepeated() => $pb.PbList<IdentityVerification>();
  @$core.pragma('dart2js:noInline')
  static IdentityVerification getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<IdentityVerification>(create);
  static IdentityVerification? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get bvn => $_getSZ(1);
  @$pb.TagNumber(2)
  set bvn($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasBvn() => $_has(1);
  @$pb.TagNumber(2)
  void clearBvn() => clearField(2);

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
  $core.String get middleName => $_getSZ(4);
  @$pb.TagNumber(5)
  set middleName($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasMiddleName() => $_has(4);
  @$pb.TagNumber(5)
  void clearMiddleName() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get dateOfBirth => $_getSZ(5);
  @$pb.TagNumber(6)
  set dateOfBirth($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasDateOfBirth() => $_has(5);
  @$pb.TagNumber(6)
  void clearDateOfBirth() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get phoneNumber => $_getSZ(6);
  @$pb.TagNumber(7)
  set phoneNumber($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasPhoneNumber() => $_has(6);
  @$pb.TagNumber(7)
  void clearPhoneNumber() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get gender => $_getSZ(7);
  @$pb.TagNumber(8)
  set gender($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasGender() => $_has(7);
  @$pb.TagNumber(8)
  void clearGender() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get status => $_getSZ(8);
  @$pb.TagNumber(9)
  set status($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasStatus() => $_has(8);
  @$pb.TagNumber(9)
  void clearStatus() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get provider => $_getSZ(9);
  @$pb.TagNumber(10)
  set provider($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasProvider() => $_has(9);
  @$pb.TagNumber(10)
  void clearProvider() => clearField(10);

  @$pb.TagNumber(11)
  $1.Timestamp get verifiedAt => $_getN(10);
  @$pb.TagNumber(11)
  set verifiedAt($1.Timestamp v) { setField(11, v); }
  @$pb.TagNumber(11)
  $core.bool hasVerifiedAt() => $_has(10);
  @$pb.TagNumber(11)
  void clearVerifiedAt() => clearField(11);
  @$pb.TagNumber(11)
  $1.Timestamp ensureVerifiedAt() => $_ensure(10);
}

class GetProviderStatusRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetProviderStatusRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GetProviderStatusRequest._() : super();
  factory GetProviderStatusRequest() => create();
  factory GetProviderStatusRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetProviderStatusRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetProviderStatusRequest clone() => GetProviderStatusRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetProviderStatusRequest copyWith(void Function(GetProviderStatusRequest) updates) => super.copyWith((message) => updates(message as GetProviderStatusRequest)) as GetProviderStatusRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetProviderStatusRequest create() => GetProviderStatusRequest._();
  GetProviderStatusRequest createEmptyInstance() => create();
  static $pb.PbList<GetProviderStatusRequest> createRepeated() => $pb.PbList<GetProviderStatusRequest>();
  @$core.pragma('dart2js:noInline')
  static GetProviderStatusRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetProviderStatusRequest>(create);
  static GetProviderStatusRequest? _defaultInstance;
}

class ProviderStatusResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProviderStatusResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..m<$core.String, ProviderHealth>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providers', entryClassName: 'ProviderStatusResponse.ProvidersEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OM, valueCreator: ProviderHealth.create, packageName: const $pb.PackageName('banking'))
    ..hasRequiredFields = false
  ;

  ProviderStatusResponse._() : super();
  factory ProviderStatusResponse({
    $core.bool? success,
    $core.Map<$core.String, ProviderHealth>? providers,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (providers != null) {
      _result.providers.addAll(providers);
    }
    return _result;
  }
  factory ProviderStatusResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProviderStatusResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProviderStatusResponse clone() => ProviderStatusResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProviderStatusResponse copyWith(void Function(ProviderStatusResponse) updates) => super.copyWith((message) => updates(message as ProviderStatusResponse)) as ProviderStatusResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProviderStatusResponse create() => ProviderStatusResponse._();
  ProviderStatusResponse createEmptyInstance() => create();
  static $pb.PbList<ProviderStatusResponse> createRepeated() => $pb.PbList<ProviderStatusResponse>();
  @$core.pragma('dart2js:noInline')
  static ProviderStatusResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProviderStatusResponse>(create);
  static ProviderStatusResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.Map<$core.String, ProviderHealth> get providers => $_getMap(1);
}

class ProviderHealth extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProviderHealth', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'provider')
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isHealthy')
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isEnabled')
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'successRate', $pb.PbFieldType.OD)
    ..a<$core.int>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'avgLatencyMs', $pb.PbFieldType.O3)
    ..aOM<$1.Timestamp>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lastCheck', subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false
  ;

  ProviderHealth._() : super();
  factory ProviderHealth({
    $core.String? provider,
    $core.bool? isHealthy,
    $core.bool? isEnabled,
    $core.double? successRate,
    $core.int? avgLatencyMs,
    $1.Timestamp? lastCheck,
  }) {
    final _result = create();
    if (provider != null) {
      _result.provider = provider;
    }
    if (isHealthy != null) {
      _result.isHealthy = isHealthy;
    }
    if (isEnabled != null) {
      _result.isEnabled = isEnabled;
    }
    if (successRate != null) {
      _result.successRate = successRate;
    }
    if (avgLatencyMs != null) {
      _result.avgLatencyMs = avgLatencyMs;
    }
    if (lastCheck != null) {
      _result.lastCheck = lastCheck;
    }
    return _result;
  }
  factory ProviderHealth.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProviderHealth.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProviderHealth clone() => ProviderHealth()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProviderHealth copyWith(void Function(ProviderHealth) updates) => super.copyWith((message) => updates(message as ProviderHealth)) as ProviderHealth; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProviderHealth create() => ProviderHealth._();
  ProviderHealth createEmptyInstance() => create();
  static $pb.PbList<ProviderHealth> createRepeated() => $pb.PbList<ProviderHealth>();
  @$core.pragma('dart2js:noInline')
  static ProviderHealth getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProviderHealth>(create);
  static ProviderHealth? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get provider => $_getSZ(0);
  @$pb.TagNumber(1)
  set provider($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasProvider() => $_has(0);
  @$pb.TagNumber(1)
  void clearProvider() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get isHealthy => $_getBF(1);
  @$pb.TagNumber(2)
  set isHealthy($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasIsHealthy() => $_has(1);
  @$pb.TagNumber(2)
  void clearIsHealthy() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get isEnabled => $_getBF(2);
  @$pb.TagNumber(3)
  set isEnabled($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasIsEnabled() => $_has(2);
  @$pb.TagNumber(3)
  void clearIsEnabled() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get successRate => $_getN(3);
  @$pb.TagNumber(4)
  set successRate($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasSuccessRate() => $_has(3);
  @$pb.TagNumber(4)
  void clearSuccessRate() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get avgLatencyMs => $_getIZ(4);
  @$pb.TagNumber(5)
  set avgLatencyMs($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasAvgLatencyMs() => $_has(4);
  @$pb.TagNumber(5)
  void clearAvgLatencyMs() => clearField(5);

  @$pb.TagNumber(6)
  $1.Timestamp get lastCheck => $_getN(5);
  @$pb.TagNumber(6)
  set lastCheck($1.Timestamp v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasLastCheck() => $_has(5);
  @$pb.TagNumber(6)
  void clearLastCheck() => clearField(6);
  @$pb.TagNumber(6)
  $1.Timestamp ensureLastCheck() => $_ensure(5);
}

class GetActiveProvidersRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetActiveProvidersRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GetActiveProvidersRequest._() : super();
  factory GetActiveProvidersRequest() => create();
  factory GetActiveProvidersRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetActiveProvidersRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetActiveProvidersRequest clone() => GetActiveProvidersRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetActiveProvidersRequest copyWith(void Function(GetActiveProvidersRequest) updates) => super.copyWith((message) => updates(message as GetActiveProvidersRequest)) as GetActiveProvidersRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetActiveProvidersRequest create() => GetActiveProvidersRequest._();
  GetActiveProvidersRequest createEmptyInstance() => create();
  static $pb.PbList<GetActiveProvidersRequest> createRepeated() => $pb.PbList<GetActiveProvidersRequest>();
  @$core.pragma('dart2js:noInline')
  static GetActiveProvidersRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetActiveProvidersRequest>(create);
  static GetActiveProvidersRequest? _defaultInstance;
}

class ActiveProvidersResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ActiveProvidersResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'virtualAccounts')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'domesticTransfers')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'internationalTransfers')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountVerification')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'identityVerification')
    ..hasRequiredFields = false
  ;

  ActiveProvidersResponse._() : super();
  factory ActiveProvidersResponse({
    $core.bool? success,
    $core.String? virtualAccounts,
    $core.String? domesticTransfers,
    $core.String? internationalTransfers,
    $core.String? accountVerification,
    $core.String? identityVerification,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (virtualAccounts != null) {
      _result.virtualAccounts = virtualAccounts;
    }
    if (domesticTransfers != null) {
      _result.domesticTransfers = domesticTransfers;
    }
    if (internationalTransfers != null) {
      _result.internationalTransfers = internationalTransfers;
    }
    if (accountVerification != null) {
      _result.accountVerification = accountVerification;
    }
    if (identityVerification != null) {
      _result.identityVerification = identityVerification;
    }
    return _result;
  }
  factory ActiveProvidersResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ActiveProvidersResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ActiveProvidersResponse clone() => ActiveProvidersResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ActiveProvidersResponse copyWith(void Function(ActiveProvidersResponse) updates) => super.copyWith((message) => updates(message as ActiveProvidersResponse)) as ActiveProvidersResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ActiveProvidersResponse create() => ActiveProvidersResponse._();
  ActiveProvidersResponse createEmptyInstance() => create();
  static $pb.PbList<ActiveProvidersResponse> createRepeated() => $pb.PbList<ActiveProvidersResponse>();
  @$core.pragma('dart2js:noInline')
  static ActiveProvidersResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ActiveProvidersResponse>(create);
  static ActiveProvidersResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get virtualAccounts => $_getSZ(1);
  @$pb.TagNumber(2)
  set virtualAccounts($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasVirtualAccounts() => $_has(1);
  @$pb.TagNumber(2)
  void clearVirtualAccounts() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get domesticTransfers => $_getSZ(2);
  @$pb.TagNumber(3)
  set domesticTransfers($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDomesticTransfers() => $_has(2);
  @$pb.TagNumber(3)
  void clearDomesticTransfers() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get internationalTransfers => $_getSZ(3);
  @$pb.TagNumber(4)
  set internationalTransfers($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasInternationalTransfers() => $_has(3);
  @$pb.TagNumber(4)
  void clearInternationalTransfers() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get accountVerification => $_getSZ(4);
  @$pb.TagNumber(5)
  set accountVerification($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasAccountVerification() => $_has(4);
  @$pb.TagNumber(5)
  void clearAccountVerification() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get identityVerification => $_getSZ(5);
  @$pb.TagNumber(6)
  set identityVerification($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasIdentityVerification() => $_has(5);
  @$pb.TagNumber(6)
  void clearIdentityVerification() => clearField(6);
}

class VerifyBVNForSignupRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'VerifyBVNForSignupRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bvn')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'firstName')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lastName')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dateOfBirth')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'phoneNumber')
    ..hasRequiredFields = false
  ;

  VerifyBVNForSignupRequest._() : super();
  factory VerifyBVNForSignupRequest({
    $core.String? userId,
    $core.String? bvn,
    $core.String? firstName,
    $core.String? lastName,
    $core.String? dateOfBirth,
    $core.String? phoneNumber,
  }) {
    final _result = create();
    if (userId != null) {
      _result.userId = userId;
    }
    if (bvn != null) {
      _result.bvn = bvn;
    }
    if (firstName != null) {
      _result.firstName = firstName;
    }
    if (lastName != null) {
      _result.lastName = lastName;
    }
    if (dateOfBirth != null) {
      _result.dateOfBirth = dateOfBirth;
    }
    if (phoneNumber != null) {
      _result.phoneNumber = phoneNumber;
    }
    return _result;
  }
  factory VerifyBVNForSignupRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VerifyBVNForSignupRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VerifyBVNForSignupRequest clone() => VerifyBVNForSignupRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VerifyBVNForSignupRequest copyWith(void Function(VerifyBVNForSignupRequest) updates) => super.copyWith((message) => updates(message as VerifyBVNForSignupRequest)) as VerifyBVNForSignupRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static VerifyBVNForSignupRequest create() => VerifyBVNForSignupRequest._();
  VerifyBVNForSignupRequest createEmptyInstance() => create();
  static $pb.PbList<VerifyBVNForSignupRequest> createRepeated() => $pb.PbList<VerifyBVNForSignupRequest>();
  @$core.pragma('dart2js:noInline')
  static VerifyBVNForSignupRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VerifyBVNForSignupRequest>(create);
  static VerifyBVNForSignupRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get bvn => $_getSZ(1);
  @$pb.TagNumber(2)
  set bvn($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasBvn() => $_has(1);
  @$pb.TagNumber(2)
  void clearBvn() => clearField(2);

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
  $core.String get dateOfBirth => $_getSZ(4);
  @$pb.TagNumber(5)
  set dateOfBirth($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasDateOfBirth() => $_has(4);
  @$pb.TagNumber(5)
  void clearDateOfBirth() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get phoneNumber => $_getSZ(5);
  @$pb.TagNumber(6)
  set phoneNumber($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasPhoneNumber() => $_has(5);
  @$pb.TagNumber(6)
  void clearPhoneNumber() => clearField(6);
}

class VerifyNINForSignupRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'VerifyNINForSignupRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'nin')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'firstName')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lastName')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dateOfBirth')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'phoneNumber')
    ..hasRequiredFields = false
  ;

  VerifyNINForSignupRequest._() : super();
  factory VerifyNINForSignupRequest({
    $core.String? userId,
    $core.String? nin,
    $core.String? firstName,
    $core.String? lastName,
    $core.String? dateOfBirth,
    $core.String? phoneNumber,
  }) {
    final _result = create();
    if (userId != null) {
      _result.userId = userId;
    }
    if (nin != null) {
      _result.nin = nin;
    }
    if (firstName != null) {
      _result.firstName = firstName;
    }
    if (lastName != null) {
      _result.lastName = lastName;
    }
    if (dateOfBirth != null) {
      _result.dateOfBirth = dateOfBirth;
    }
    if (phoneNumber != null) {
      _result.phoneNumber = phoneNumber;
    }
    return _result;
  }
  factory VerifyNINForSignupRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VerifyNINForSignupRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VerifyNINForSignupRequest clone() => VerifyNINForSignupRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VerifyNINForSignupRequest copyWith(void Function(VerifyNINForSignupRequest) updates) => super.copyWith((message) => updates(message as VerifyNINForSignupRequest)) as VerifyNINForSignupRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static VerifyNINForSignupRequest create() => VerifyNINForSignupRequest._();
  VerifyNINForSignupRequest createEmptyInstance() => create();
  static $pb.PbList<VerifyNINForSignupRequest> createRepeated() => $pb.PbList<VerifyNINForSignupRequest>();
  @$core.pragma('dart2js:noInline')
  static VerifyNINForSignupRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VerifyNINForSignupRequest>(create);
  static VerifyNINForSignupRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get nin => $_getSZ(1);
  @$pb.TagNumber(2)
  set nin($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasNin() => $_has(1);
  @$pb.TagNumber(2)
  void clearNin() => clearField(2);

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
  $core.String get dateOfBirth => $_getSZ(4);
  @$pb.TagNumber(5)
  set dateOfBirth($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasDateOfBirth() => $_has(4);
  @$pb.TagNumber(5)
  void clearDateOfBirth() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get phoneNumber => $_getSZ(5);
  @$pb.TagNumber(6)
  set phoneNumber($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasPhoneNumber() => $_has(5);
  @$pb.TagNumber(6)
  void clearPhoneNumber() => clearField(6);
}

class SignupIdentityVerificationResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SignupIdentityVerificationResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'verified')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errorCode')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errorMessage')
    ..aOM<VerifiedIdentityDetails>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'identity', subBuilder: VerifiedIdentityDetails.create)
    ..hasRequiredFields = false
  ;

  SignupIdentityVerificationResponse._() : super();
  factory SignupIdentityVerificationResponse({
    $core.bool? success,
    $core.bool? verified,
    $core.String? errorCode,
    $core.String? errorMessage,
    VerifiedIdentityDetails? identity,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (verified != null) {
      _result.verified = verified;
    }
    if (errorCode != null) {
      _result.errorCode = errorCode;
    }
    if (errorMessage != null) {
      _result.errorMessage = errorMessage;
    }
    if (identity != null) {
      _result.identity = identity;
    }
    return _result;
  }
  factory SignupIdentityVerificationResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SignupIdentityVerificationResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SignupIdentityVerificationResponse clone() => SignupIdentityVerificationResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SignupIdentityVerificationResponse copyWith(void Function(SignupIdentityVerificationResponse) updates) => super.copyWith((message) => updates(message as SignupIdentityVerificationResponse)) as SignupIdentityVerificationResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SignupIdentityVerificationResponse create() => SignupIdentityVerificationResponse._();
  SignupIdentityVerificationResponse createEmptyInstance() => create();
  static $pb.PbList<SignupIdentityVerificationResponse> createRepeated() => $pb.PbList<SignupIdentityVerificationResponse>();
  @$core.pragma('dart2js:noInline')
  static SignupIdentityVerificationResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SignupIdentityVerificationResponse>(create);
  static SignupIdentityVerificationResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get verified => $_getBF(1);
  @$pb.TagNumber(2)
  set verified($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasVerified() => $_has(1);
  @$pb.TagNumber(2)
  void clearVerified() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorCode => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorCode($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasErrorCode() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorCode() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get errorMessage => $_getSZ(3);
  @$pb.TagNumber(4)
  set errorMessage($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasErrorMessage() => $_has(3);
  @$pb.TagNumber(4)
  void clearErrorMessage() => clearField(4);

  @$pb.TagNumber(5)
  VerifiedIdentityDetails get identity => $_getN(4);
  @$pb.TagNumber(5)
  set identity(VerifiedIdentityDetails v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasIdentity() => $_has(4);
  @$pb.TagNumber(5)
  void clearIdentity() => clearField(5);
  @$pb.TagNumber(5)
  VerifiedIdentityDetails ensureIdentity() => $_ensure(4);
}

class VerifiedIdentityDetails extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'VerifiedIdentityDetails', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'firstName')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lastName')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'middleName')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'phoneNumber')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dateOfBirth')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'gender')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'photoUrl')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'address')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'stateOfOrigin')
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lgaOfOrigin')
    ..hasRequiredFields = false
  ;

  VerifiedIdentityDetails._() : super();
  factory VerifiedIdentityDetails({
    $core.String? firstName,
    $core.String? lastName,
    $core.String? middleName,
    $core.String? phoneNumber,
    $core.String? dateOfBirth,
    $core.String? gender,
    $core.String? photoUrl,
    $core.String? address,
    $core.String? stateOfOrigin,
    $core.String? lgaOfOrigin,
  }) {
    final _result = create();
    if (firstName != null) {
      _result.firstName = firstName;
    }
    if (lastName != null) {
      _result.lastName = lastName;
    }
    if (middleName != null) {
      _result.middleName = middleName;
    }
    if (phoneNumber != null) {
      _result.phoneNumber = phoneNumber;
    }
    if (dateOfBirth != null) {
      _result.dateOfBirth = dateOfBirth;
    }
    if (gender != null) {
      _result.gender = gender;
    }
    if (photoUrl != null) {
      _result.photoUrl = photoUrl;
    }
    if (address != null) {
      _result.address = address;
    }
    if (stateOfOrigin != null) {
      _result.stateOfOrigin = stateOfOrigin;
    }
    if (lgaOfOrigin != null) {
      _result.lgaOfOrigin = lgaOfOrigin;
    }
    return _result;
  }
  factory VerifiedIdentityDetails.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VerifiedIdentityDetails.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VerifiedIdentityDetails clone() => VerifiedIdentityDetails()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VerifiedIdentityDetails copyWith(void Function(VerifiedIdentityDetails) updates) => super.copyWith((message) => updates(message as VerifiedIdentityDetails)) as VerifiedIdentityDetails; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static VerifiedIdentityDetails create() => VerifiedIdentityDetails._();
  VerifiedIdentityDetails createEmptyInstance() => create();
  static $pb.PbList<VerifiedIdentityDetails> createRepeated() => $pb.PbList<VerifiedIdentityDetails>();
  @$core.pragma('dart2js:noInline')
  static VerifiedIdentityDetails getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VerifiedIdentityDetails>(create);
  static VerifiedIdentityDetails? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get firstName => $_getSZ(0);
  @$pb.TagNumber(1)
  set firstName($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFirstName() => $_has(0);
  @$pb.TagNumber(1)
  void clearFirstName() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get lastName => $_getSZ(1);
  @$pb.TagNumber(2)
  set lastName($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLastName() => $_has(1);
  @$pb.TagNumber(2)
  void clearLastName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get middleName => $_getSZ(2);
  @$pb.TagNumber(3)
  set middleName($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMiddleName() => $_has(2);
  @$pb.TagNumber(3)
  void clearMiddleName() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get phoneNumber => $_getSZ(3);
  @$pb.TagNumber(4)
  set phoneNumber($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPhoneNumber() => $_has(3);
  @$pb.TagNumber(4)
  void clearPhoneNumber() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get dateOfBirth => $_getSZ(4);
  @$pb.TagNumber(5)
  set dateOfBirth($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasDateOfBirth() => $_has(4);
  @$pb.TagNumber(5)
  void clearDateOfBirth() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get gender => $_getSZ(5);
  @$pb.TagNumber(6)
  set gender($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasGender() => $_has(5);
  @$pb.TagNumber(6)
  void clearGender() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get photoUrl => $_getSZ(6);
  @$pb.TagNumber(7)
  set photoUrl($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasPhotoUrl() => $_has(6);
  @$pb.TagNumber(7)
  void clearPhotoUrl() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get address => $_getSZ(7);
  @$pb.TagNumber(8)
  set address($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasAddress() => $_has(7);
  @$pb.TagNumber(8)
  void clearAddress() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get stateOfOrigin => $_getSZ(8);
  @$pb.TagNumber(9)
  set stateOfOrigin($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasStateOfOrigin() => $_has(8);
  @$pb.TagNumber(9)
  void clearStateOfOrigin() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get lgaOfOrigin => $_getSZ(9);
  @$pb.TagNumber(10)
  set lgaOfOrigin($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasLgaOfOrigin() => $_has(9);
  @$pb.TagNumber(10)
  void clearLgaOfOrigin() => clearField(10);
}

class CreateVirtualAccountForUserRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateVirtualAccountForUserRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'firstName')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lastName')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'email')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'phoneNumber')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bvn')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'identityType')
    ..hasRequiredFields = false
  ;

  CreateVirtualAccountForUserRequest._() : super();
  factory CreateVirtualAccountForUserRequest({
    $core.String? userId,
    $core.String? firstName,
    $core.String? lastName,
    $core.String? email,
    $core.String? phoneNumber,
    $core.String? bvn,
    $core.String? identityType,
  }) {
    final _result = create();
    if (userId != null) {
      _result.userId = userId;
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
    if (bvn != null) {
      _result.bvn = bvn;
    }
    if (identityType != null) {
      _result.identityType = identityType;
    }
    return _result;
  }
  factory CreateVirtualAccountForUserRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateVirtualAccountForUserRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateVirtualAccountForUserRequest clone() => CreateVirtualAccountForUserRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateVirtualAccountForUserRequest copyWith(void Function(CreateVirtualAccountForUserRequest) updates) => super.copyWith((message) => updates(message as CreateVirtualAccountForUserRequest)) as CreateVirtualAccountForUserRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateVirtualAccountForUserRequest create() => CreateVirtualAccountForUserRequest._();
  CreateVirtualAccountForUserRequest createEmptyInstance() => create();
  static $pb.PbList<CreateVirtualAccountForUserRequest> createRepeated() => $pb.PbList<CreateVirtualAccountForUserRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateVirtualAccountForUserRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateVirtualAccountForUserRequest>(create);
  static CreateVirtualAccountForUserRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

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
  $core.String get bvn => $_getSZ(5);
  @$pb.TagNumber(6)
  set bvn($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasBvn() => $_has(5);
  @$pb.TagNumber(6)
  void clearBvn() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get identityType => $_getSZ(6);
  @$pb.TagNumber(7)
  set identityType($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasIdentityType() => $_has(6);
  @$pb.TagNumber(7)
  void clearIdentityType() => clearField(7);
}

class GetAccountBalanceRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetAccountBalanceRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountId')
    ..hasRequiredFields = false
  ;

  GetAccountBalanceRequest._() : super();
  factory GetAccountBalanceRequest({
    $core.String? accountId,
  }) {
    final _result = create();
    if (accountId != null) {
      _result.accountId = accountId;
    }
    return _result;
  }
  factory GetAccountBalanceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAccountBalanceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAccountBalanceRequest clone() => GetAccountBalanceRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAccountBalanceRequest copyWith(void Function(GetAccountBalanceRequest) updates) => super.copyWith((message) => updates(message as GetAccountBalanceRequest)) as GetAccountBalanceRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetAccountBalanceRequest create() => GetAccountBalanceRequest._();
  GetAccountBalanceRequest createEmptyInstance() => create();
  static $pb.PbList<GetAccountBalanceRequest> createRepeated() => $pb.PbList<GetAccountBalanceRequest>();
  @$core.pragma('dart2js:noInline')
  static GetAccountBalanceRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAccountBalanceRequest>(create);
  static GetAccountBalanceRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => clearField(1);
}

class AccountBalanceResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AccountBalanceResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errorCode')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errorMessage')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountId')
    ..aInt64(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ledgerBalance')
    ..aInt64(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'availableBalance')
    ..aInt64(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pendingCredits')
    ..aInt64(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pendingDebits')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..hasRequiredFields = false
  ;

  AccountBalanceResponse._() : super();
  factory AccountBalanceResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
    $core.String? accountId,
    $fixnum.Int64? ledgerBalance,
    $fixnum.Int64? availableBalance,
    $fixnum.Int64? pendingCredits,
    $fixnum.Int64? pendingDebits,
    $core.String? currency,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (errorCode != null) {
      _result.errorCode = errorCode;
    }
    if (errorMessage != null) {
      _result.errorMessage = errorMessage;
    }
    if (accountId != null) {
      _result.accountId = accountId;
    }
    if (ledgerBalance != null) {
      _result.ledgerBalance = ledgerBalance;
    }
    if (availableBalance != null) {
      _result.availableBalance = availableBalance;
    }
    if (pendingCredits != null) {
      _result.pendingCredits = pendingCredits;
    }
    if (pendingDebits != null) {
      _result.pendingDebits = pendingDebits;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    return _result;
  }
  factory AccountBalanceResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AccountBalanceResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AccountBalanceResponse clone() => AccountBalanceResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AccountBalanceResponse copyWith(void Function(AccountBalanceResponse) updates) => super.copyWith((message) => updates(message as AccountBalanceResponse)) as AccountBalanceResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AccountBalanceResponse create() => AccountBalanceResponse._();
  AccountBalanceResponse createEmptyInstance() => create();
  static $pb.PbList<AccountBalanceResponse> createRepeated() => $pb.PbList<AccountBalanceResponse>();
  @$core.pragma('dart2js:noInline')
  static AccountBalanceResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AccountBalanceResponse>(create);
  static AccountBalanceResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get accountId => $_getSZ(3);
  @$pb.TagNumber(4)
  set accountId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasAccountId() => $_has(3);
  @$pb.TagNumber(4)
  void clearAccountId() => clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get ledgerBalance => $_getI64(4);
  @$pb.TagNumber(5)
  set ledgerBalance($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasLedgerBalance() => $_has(4);
  @$pb.TagNumber(5)
  void clearLedgerBalance() => clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get availableBalance => $_getI64(5);
  @$pb.TagNumber(6)
  set availableBalance($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasAvailableBalance() => $_has(5);
  @$pb.TagNumber(6)
  void clearAvailableBalance() => clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get pendingCredits => $_getI64(6);
  @$pb.TagNumber(7)
  set pendingCredits($fixnum.Int64 v) { $_setInt64(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasPendingCredits() => $_has(6);
  @$pb.TagNumber(7)
  void clearPendingCredits() => clearField(7);

  @$pb.TagNumber(8)
  $fixnum.Int64 get pendingDebits => $_getI64(7);
  @$pb.TagNumber(8)
  set pendingDebits($fixnum.Int64 v) { $_setInt64(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasPendingDebits() => $_has(7);
  @$pb.TagNumber(8)
  void clearPendingDebits() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get currency => $_getSZ(8);
  @$pb.TagNumber(9)
  set currency($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasCurrency() => $_has(8);
  @$pb.TagNumber(9)
  void clearCurrency() => clearField(9);
}

class GetAccountTransactionsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetAccountTransactionsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountId')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetAccountTransactionsRequest._() : super();
  factory GetAccountTransactionsRequest({
    $core.String? accountId,
    $core.int? limit,
    $core.int? offset,
  }) {
    final _result = create();
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
  factory GetAccountTransactionsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAccountTransactionsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAccountTransactionsRequest clone() => GetAccountTransactionsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAccountTransactionsRequest copyWith(void Function(GetAccountTransactionsRequest) updates) => super.copyWith((message) => updates(message as GetAccountTransactionsRequest)) as GetAccountTransactionsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetAccountTransactionsRequest create() => GetAccountTransactionsRequest._();
  GetAccountTransactionsRequest createEmptyInstance() => create();
  static $pb.PbList<GetAccountTransactionsRequest> createRepeated() => $pb.PbList<GetAccountTransactionsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetAccountTransactionsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAccountTransactionsRequest>(create);
  static GetAccountTransactionsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => clearField(1);

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

class TransactionsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TransactionsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errorCode')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errorMessage')
    ..pc<Transaction>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactions', $pb.PbFieldType.PM, subBuilder: Transaction.create)
    ..hasRequiredFields = false
  ;

  TransactionsResponse._() : super();
  factory TransactionsResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
    $core.Iterable<Transaction>? transactions,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (errorCode != null) {
      _result.errorCode = errorCode;
    }
    if (errorMessage != null) {
      _result.errorMessage = errorMessage;
    }
    if (transactions != null) {
      _result.transactions.addAll(transactions);
    }
    return _result;
  }
  factory TransactionsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TransactionsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TransactionsResponse clone() => TransactionsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TransactionsResponse copyWith(void Function(TransactionsResponse) updates) => super.copyWith((message) => updates(message as TransactionsResponse)) as TransactionsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TransactionsResponse create() => TransactionsResponse._();
  TransactionsResponse createEmptyInstance() => create();
  static $pb.PbList<TransactionsResponse> createRepeated() => $pb.PbList<TransactionsResponse>();
  @$core.pragma('dart2js:noInline')
  static TransactionsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TransactionsResponse>(create);
  static TransactionsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<Transaction> get transactions => $_getList(3);
}

class Transaction extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Transaction', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transferId')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'category')
    ..aInt64(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aInt64(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ledgerBalanceBefore')
    ..aInt64(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ledgerBalanceAfter')
    ..aInt64(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'availableBalanceBefore')
    ..aInt64(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'availableBalanceAfter')
    ..aOS(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reference')
    ..aOS(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..aOS(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'narration')
    ..aOS(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'counterpartyAccountId')
    ..aOS(17, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'counterpartyName')
    ..aOS(18, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'counterpartyBank')
    ..aOS(19, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'counterpartyAccount')
    ..aOS(20, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..aOM<$1.Timestamp>(21, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(22, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'settledAt', subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false
  ;

  Transaction._() : super();
  factory Transaction({
    $core.String? id,
    $core.String? accountId,
    $core.String? userId,
    $core.String? transferId,
    $core.String? type,
    $core.String? category,
    $fixnum.Int64? amount,
    $core.String? currency,
    $fixnum.Int64? ledgerBalanceBefore,
    $fixnum.Int64? ledgerBalanceAfter,
    $fixnum.Int64? availableBalanceBefore,
    $fixnum.Int64? availableBalanceAfter,
    $core.String? reference,
    $core.String? description,
    $core.String? narration,
    $core.String? counterpartyAccountId,
    $core.String? counterpartyName,
    $core.String? counterpartyBank,
    $core.String? counterpartyAccount,
    $core.String? status,
    $1.Timestamp? createdAt,
    $1.Timestamp? settledAt,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (accountId != null) {
      _result.accountId = accountId;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    if (transferId != null) {
      _result.transferId = transferId;
    }
    if (type != null) {
      _result.type = type;
    }
    if (category != null) {
      _result.category = category;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (ledgerBalanceBefore != null) {
      _result.ledgerBalanceBefore = ledgerBalanceBefore;
    }
    if (ledgerBalanceAfter != null) {
      _result.ledgerBalanceAfter = ledgerBalanceAfter;
    }
    if (availableBalanceBefore != null) {
      _result.availableBalanceBefore = availableBalanceBefore;
    }
    if (availableBalanceAfter != null) {
      _result.availableBalanceAfter = availableBalanceAfter;
    }
    if (reference != null) {
      _result.reference = reference;
    }
    if (description != null) {
      _result.description = description;
    }
    if (narration != null) {
      _result.narration = narration;
    }
    if (counterpartyAccountId != null) {
      _result.counterpartyAccountId = counterpartyAccountId;
    }
    if (counterpartyName != null) {
      _result.counterpartyName = counterpartyName;
    }
    if (counterpartyBank != null) {
      _result.counterpartyBank = counterpartyBank;
    }
    if (counterpartyAccount != null) {
      _result.counterpartyAccount = counterpartyAccount;
    }
    if (status != null) {
      _result.status = status;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (settledAt != null) {
      _result.settledAt = settledAt;
    }
    return _result;
  }
  factory Transaction.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Transaction.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Transaction clone() => Transaction()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Transaction copyWith(void Function(Transaction) updates) => super.copyWith((message) => updates(message as Transaction)) as Transaction; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Transaction create() => Transaction._();
  Transaction createEmptyInstance() => create();
  static $pb.PbList<Transaction> createRepeated() => $pb.PbList<Transaction>();
  @$core.pragma('dart2js:noInline')
  static Transaction getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Transaction>(create);
  static Transaction? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get accountId => $_getSZ(1);
  @$pb.TagNumber(2)
  set accountId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAccountId() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccountId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get userId => $_getSZ(2);
  @$pb.TagNumber(3)
  set userId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasUserId() => $_has(2);
  @$pb.TagNumber(3)
  void clearUserId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get transferId => $_getSZ(3);
  @$pb.TagNumber(4)
  set transferId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTransferId() => $_has(3);
  @$pb.TagNumber(4)
  void clearTransferId() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get type => $_getSZ(4);
  @$pb.TagNumber(5)
  set type($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasType() => $_has(4);
  @$pb.TagNumber(5)
  void clearType() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get category => $_getSZ(5);
  @$pb.TagNumber(6)
  set category($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasCategory() => $_has(5);
  @$pb.TagNumber(6)
  void clearCategory() => clearField(6);

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
  $fixnum.Int64 get ledgerBalanceBefore => $_getI64(8);
  @$pb.TagNumber(9)
  set ledgerBalanceBefore($fixnum.Int64 v) { $_setInt64(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasLedgerBalanceBefore() => $_has(8);
  @$pb.TagNumber(9)
  void clearLedgerBalanceBefore() => clearField(9);

  @$pb.TagNumber(10)
  $fixnum.Int64 get ledgerBalanceAfter => $_getI64(9);
  @$pb.TagNumber(10)
  set ledgerBalanceAfter($fixnum.Int64 v) { $_setInt64(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasLedgerBalanceAfter() => $_has(9);
  @$pb.TagNumber(10)
  void clearLedgerBalanceAfter() => clearField(10);

  @$pb.TagNumber(11)
  $fixnum.Int64 get availableBalanceBefore => $_getI64(10);
  @$pb.TagNumber(11)
  set availableBalanceBefore($fixnum.Int64 v) { $_setInt64(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasAvailableBalanceBefore() => $_has(10);
  @$pb.TagNumber(11)
  void clearAvailableBalanceBefore() => clearField(11);

  @$pb.TagNumber(12)
  $fixnum.Int64 get availableBalanceAfter => $_getI64(11);
  @$pb.TagNumber(12)
  set availableBalanceAfter($fixnum.Int64 v) { $_setInt64(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasAvailableBalanceAfter() => $_has(11);
  @$pb.TagNumber(12)
  void clearAvailableBalanceAfter() => clearField(12);

  @$pb.TagNumber(13)
  $core.String get reference => $_getSZ(12);
  @$pb.TagNumber(13)
  set reference($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasReference() => $_has(12);
  @$pb.TagNumber(13)
  void clearReference() => clearField(13);

  @$pb.TagNumber(14)
  $core.String get description => $_getSZ(13);
  @$pb.TagNumber(14)
  set description($core.String v) { $_setString(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasDescription() => $_has(13);
  @$pb.TagNumber(14)
  void clearDescription() => clearField(14);

  @$pb.TagNumber(15)
  $core.String get narration => $_getSZ(14);
  @$pb.TagNumber(15)
  set narration($core.String v) { $_setString(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasNarration() => $_has(14);
  @$pb.TagNumber(15)
  void clearNarration() => clearField(15);

  @$pb.TagNumber(16)
  $core.String get counterpartyAccountId => $_getSZ(15);
  @$pb.TagNumber(16)
  set counterpartyAccountId($core.String v) { $_setString(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasCounterpartyAccountId() => $_has(15);
  @$pb.TagNumber(16)
  void clearCounterpartyAccountId() => clearField(16);

  @$pb.TagNumber(17)
  $core.String get counterpartyName => $_getSZ(16);
  @$pb.TagNumber(17)
  set counterpartyName($core.String v) { $_setString(16, v); }
  @$pb.TagNumber(17)
  $core.bool hasCounterpartyName() => $_has(16);
  @$pb.TagNumber(17)
  void clearCounterpartyName() => clearField(17);

  @$pb.TagNumber(18)
  $core.String get counterpartyBank => $_getSZ(17);
  @$pb.TagNumber(18)
  set counterpartyBank($core.String v) { $_setString(17, v); }
  @$pb.TagNumber(18)
  $core.bool hasCounterpartyBank() => $_has(17);
  @$pb.TagNumber(18)
  void clearCounterpartyBank() => clearField(18);

  @$pb.TagNumber(19)
  $core.String get counterpartyAccount => $_getSZ(18);
  @$pb.TagNumber(19)
  set counterpartyAccount($core.String v) { $_setString(18, v); }
  @$pb.TagNumber(19)
  $core.bool hasCounterpartyAccount() => $_has(18);
  @$pb.TagNumber(19)
  void clearCounterpartyAccount() => clearField(19);

  @$pb.TagNumber(20)
  $core.String get status => $_getSZ(19);
  @$pb.TagNumber(20)
  set status($core.String v) { $_setString(19, v); }
  @$pb.TagNumber(20)
  $core.bool hasStatus() => $_has(19);
  @$pb.TagNumber(20)
  void clearStatus() => clearField(20);

  @$pb.TagNumber(21)
  $1.Timestamp get createdAt => $_getN(20);
  @$pb.TagNumber(21)
  set createdAt($1.Timestamp v) { setField(21, v); }
  @$pb.TagNumber(21)
  $core.bool hasCreatedAt() => $_has(20);
  @$pb.TagNumber(21)
  void clearCreatedAt() => clearField(21);
  @$pb.TagNumber(21)
  $1.Timestamp ensureCreatedAt() => $_ensure(20);

  @$pb.TagNumber(22)
  $1.Timestamp get settledAt => $_getN(21);
  @$pb.TagNumber(22)
  set settledAt($1.Timestamp v) { setField(22, v); }
  @$pb.TagNumber(22)
  $core.bool hasSettledAt() => $_has(21);
  @$pb.TagNumber(22)
  void clearSettledAt() => clearField(22);
  @$pb.TagNumber(22)
  $1.Timestamp ensureSettledAt() => $_ensure(21);
}

class GetPrimaryAccountRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetPrimaryAccountRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..hasRequiredFields = false
  ;

  GetPrimaryAccountRequest._() : super();
  factory GetPrimaryAccountRequest({
    $core.String? userId,
  }) {
    final _result = create();
    if (userId != null) {
      _result.userId = userId;
    }
    return _result;
  }
  factory GetPrimaryAccountRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPrimaryAccountRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPrimaryAccountRequest clone() => GetPrimaryAccountRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPrimaryAccountRequest copyWith(void Function(GetPrimaryAccountRequest) updates) => super.copyWith((message) => updates(message as GetPrimaryAccountRequest)) as GetPrimaryAccountRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetPrimaryAccountRequest create() => GetPrimaryAccountRequest._();
  GetPrimaryAccountRequest createEmptyInstance() => create();
  static $pb.PbList<GetPrimaryAccountRequest> createRepeated() => $pb.PbList<GetPrimaryAccountRequest>();
  @$core.pragma('dart2js:noInline')
  static GetPrimaryAccountRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetPrimaryAccountRequest>(create);
  static GetPrimaryAccountRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);
}

class FreezeAccountRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'FreezeAccountRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reason')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'frozenBy')
    ..hasRequiredFields = false
  ;

  FreezeAccountRequest._() : super();
  factory FreezeAccountRequest({
    $core.String? accountId,
    $core.String? reason,
    $core.String? description,
    $core.String? frozenBy,
  }) {
    final _result = create();
    if (accountId != null) {
      _result.accountId = accountId;
    }
    if (reason != null) {
      _result.reason = reason;
    }
    if (description != null) {
      _result.description = description;
    }
    if (frozenBy != null) {
      _result.frozenBy = frozenBy;
    }
    return _result;
  }
  factory FreezeAccountRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FreezeAccountRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FreezeAccountRequest clone() => FreezeAccountRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FreezeAccountRequest copyWith(void Function(FreezeAccountRequest) updates) => super.copyWith((message) => updates(message as FreezeAccountRequest)) as FreezeAccountRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FreezeAccountRequest create() => FreezeAccountRequest._();
  FreezeAccountRequest createEmptyInstance() => create();
  static $pb.PbList<FreezeAccountRequest> createRepeated() => $pb.PbList<FreezeAccountRequest>();
  @$core.pragma('dart2js:noInline')
  static FreezeAccountRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FreezeAccountRequest>(create);
  static FreezeAccountRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get reason => $_getSZ(1);
  @$pb.TagNumber(2)
  set reason($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasReason() => $_has(1);
  @$pb.TagNumber(2)
  void clearReason() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get frozenBy => $_getSZ(3);
  @$pb.TagNumber(4)
  set frozenBy($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasFrozenBy() => $_has(3);
  @$pb.TagNumber(4)
  void clearFrozenBy() => clearField(4);
}

class FreezeAccountResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'FreezeAccountResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errorCode')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errorMessage')
    ..hasRequiredFields = false
  ;

  FreezeAccountResponse._() : super();
  factory FreezeAccountResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (errorCode != null) {
      _result.errorCode = errorCode;
    }
    if (errorMessage != null) {
      _result.errorMessage = errorMessage;
    }
    return _result;
  }
  factory FreezeAccountResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FreezeAccountResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FreezeAccountResponse clone() => FreezeAccountResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FreezeAccountResponse copyWith(void Function(FreezeAccountResponse) updates) => super.copyWith((message) => updates(message as FreezeAccountResponse)) as FreezeAccountResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FreezeAccountResponse create() => FreezeAccountResponse._();
  FreezeAccountResponse createEmptyInstance() => create();
  static $pb.PbList<FreezeAccountResponse> createRepeated() => $pb.PbList<FreezeAccountResponse>();
  @$core.pragma('dart2js:noInline')
  static FreezeAccountResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FreezeAccountResponse>(create);
  static FreezeAccountResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => clearField(3);
}

class UnfreezeAccountRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UnfreezeAccountRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'unfrozenBy')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'note')
    ..hasRequiredFields = false
  ;

  UnfreezeAccountRequest._() : super();
  factory UnfreezeAccountRequest({
    $core.String? accountId,
    $core.String? unfrozenBy,
    $core.String? note,
  }) {
    final _result = create();
    if (accountId != null) {
      _result.accountId = accountId;
    }
    if (unfrozenBy != null) {
      _result.unfrozenBy = unfrozenBy;
    }
    if (note != null) {
      _result.note = note;
    }
    return _result;
  }
  factory UnfreezeAccountRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UnfreezeAccountRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UnfreezeAccountRequest clone() => UnfreezeAccountRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UnfreezeAccountRequest copyWith(void Function(UnfreezeAccountRequest) updates) => super.copyWith((message) => updates(message as UnfreezeAccountRequest)) as UnfreezeAccountRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UnfreezeAccountRequest create() => UnfreezeAccountRequest._();
  UnfreezeAccountRequest createEmptyInstance() => create();
  static $pb.PbList<UnfreezeAccountRequest> createRepeated() => $pb.PbList<UnfreezeAccountRequest>();
  @$core.pragma('dart2js:noInline')
  static UnfreezeAccountRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UnfreezeAccountRequest>(create);
  static UnfreezeAccountRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get unfrozenBy => $_getSZ(1);
  @$pb.TagNumber(2)
  set unfrozenBy($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUnfrozenBy() => $_has(1);
  @$pb.TagNumber(2)
  void clearUnfrozenBy() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get note => $_getSZ(2);
  @$pb.TagNumber(3)
  set note($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasNote() => $_has(2);
  @$pb.TagNumber(3)
  void clearNote() => clearField(3);
}

class UnfreezeAccountResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UnfreezeAccountResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errorCode')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errorMessage')
    ..hasRequiredFields = false
  ;

  UnfreezeAccountResponse._() : super();
  factory UnfreezeAccountResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (errorCode != null) {
      _result.errorCode = errorCode;
    }
    if (errorMessage != null) {
      _result.errorMessage = errorMessage;
    }
    return _result;
  }
  factory UnfreezeAccountResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UnfreezeAccountResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UnfreezeAccountResponse clone() => UnfreezeAccountResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UnfreezeAccountResponse copyWith(void Function(UnfreezeAccountResponse) updates) => super.copyWith((message) => updates(message as UnfreezeAccountResponse)) as UnfreezeAccountResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UnfreezeAccountResponse create() => UnfreezeAccountResponse._();
  UnfreezeAccountResponse createEmptyInstance() => create();
  static $pb.PbList<UnfreezeAccountResponse> createRepeated() => $pb.PbList<UnfreezeAccountResponse>();
  @$core.pragma('dart2js:noInline')
  static UnfreezeAccountResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UnfreezeAccountResponse>(create);
  static UnfreezeAccountResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => clearField(3);
}

class RunReconciliationRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RunReconciliationRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  RunReconciliationRequest._() : super();
  factory RunReconciliationRequest() => create();
  factory RunReconciliationRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RunReconciliationRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RunReconciliationRequest clone() => RunReconciliationRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RunReconciliationRequest copyWith(void Function(RunReconciliationRequest) updates) => super.copyWith((message) => updates(message as RunReconciliationRequest)) as RunReconciliationRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RunReconciliationRequest create() => RunReconciliationRequest._();
  RunReconciliationRequest createEmptyInstance() => create();
  static $pb.PbList<RunReconciliationRequest> createRepeated() => $pb.PbList<RunReconciliationRequest>();
  @$core.pragma('dart2js:noInline')
  static RunReconciliationRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RunReconciliationRequest>(create);
  static RunReconciliationRequest? _defaultInstance;
}

class ReconciliationResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ReconciliationResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errorCode')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errorMessage')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reconciliationId')
    ..aInt64(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalLedgerBalance')
    ..aInt64(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pooledAccountBalance')
    ..aInt64(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'discrepancy')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..a<$core.int>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'expiredHoldsReleased', $pb.PbFieldType.O3)
    ..a<$core.int>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'stuckTransfersFixed', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  ReconciliationResponse._() : super();
  factory ReconciliationResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
    $core.String? reconciliationId,
    $fixnum.Int64? totalLedgerBalance,
    $fixnum.Int64? pooledAccountBalance,
    $fixnum.Int64? discrepancy,
    $core.String? status,
    $core.int? expiredHoldsReleased,
    $core.int? stuckTransfersFixed,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (errorCode != null) {
      _result.errorCode = errorCode;
    }
    if (errorMessage != null) {
      _result.errorMessage = errorMessage;
    }
    if (reconciliationId != null) {
      _result.reconciliationId = reconciliationId;
    }
    if (totalLedgerBalance != null) {
      _result.totalLedgerBalance = totalLedgerBalance;
    }
    if (pooledAccountBalance != null) {
      _result.pooledAccountBalance = pooledAccountBalance;
    }
    if (discrepancy != null) {
      _result.discrepancy = discrepancy;
    }
    if (status != null) {
      _result.status = status;
    }
    if (expiredHoldsReleased != null) {
      _result.expiredHoldsReleased = expiredHoldsReleased;
    }
    if (stuckTransfersFixed != null) {
      _result.stuckTransfersFixed = stuckTransfersFixed;
    }
    return _result;
  }
  factory ReconciliationResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ReconciliationResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ReconciliationResponse clone() => ReconciliationResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ReconciliationResponse copyWith(void Function(ReconciliationResponse) updates) => super.copyWith((message) => updates(message as ReconciliationResponse)) as ReconciliationResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ReconciliationResponse create() => ReconciliationResponse._();
  ReconciliationResponse createEmptyInstance() => create();
  static $pb.PbList<ReconciliationResponse> createRepeated() => $pb.PbList<ReconciliationResponse>();
  @$core.pragma('dart2js:noInline')
  static ReconciliationResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ReconciliationResponse>(create);
  static ReconciliationResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get reconciliationId => $_getSZ(3);
  @$pb.TagNumber(4)
  set reconciliationId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasReconciliationId() => $_has(3);
  @$pb.TagNumber(4)
  void clearReconciliationId() => clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get totalLedgerBalance => $_getI64(4);
  @$pb.TagNumber(5)
  set totalLedgerBalance($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTotalLedgerBalance() => $_has(4);
  @$pb.TagNumber(5)
  void clearTotalLedgerBalance() => clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get pooledAccountBalance => $_getI64(5);
  @$pb.TagNumber(6)
  set pooledAccountBalance($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasPooledAccountBalance() => $_has(5);
  @$pb.TagNumber(6)
  void clearPooledAccountBalance() => clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get discrepancy => $_getI64(6);
  @$pb.TagNumber(7)
  set discrepancy($fixnum.Int64 v) { $_setInt64(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasDiscrepancy() => $_has(6);
  @$pb.TagNumber(7)
  void clearDiscrepancy() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get status => $_getSZ(7);
  @$pb.TagNumber(8)
  set status($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasStatus() => $_has(7);
  @$pb.TagNumber(8)
  void clearStatus() => clearField(8);

  @$pb.TagNumber(9)
  $core.int get expiredHoldsReleased => $_getIZ(8);
  @$pb.TagNumber(9)
  set expiredHoldsReleased($core.int v) { $_setSignedInt32(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasExpiredHoldsReleased() => $_has(8);
  @$pb.TagNumber(9)
  void clearExpiredHoldsReleased() => clearField(9);

  @$pb.TagNumber(10)
  $core.int get stuckTransfersFixed => $_getIZ(9);
  @$pb.TagNumber(10)
  set stuckTransfersFixed($core.int v) { $_setSignedInt32(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasStuckTransfersFixed() => $_has(9);
  @$pb.TagNumber(10)
  void clearStuckTransfersFixed() => clearField(10);
}

class GetReconciliationHistoryRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetReconciliationHistoryRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'days', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetReconciliationHistoryRequest._() : super();
  factory GetReconciliationHistoryRequest({
    $core.int? days,
  }) {
    final _result = create();
    if (days != null) {
      _result.days = days;
    }
    return _result;
  }
  factory GetReconciliationHistoryRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetReconciliationHistoryRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetReconciliationHistoryRequest clone() => GetReconciliationHistoryRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetReconciliationHistoryRequest copyWith(void Function(GetReconciliationHistoryRequest) updates) => super.copyWith((message) => updates(message as GetReconciliationHistoryRequest)) as GetReconciliationHistoryRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetReconciliationHistoryRequest create() => GetReconciliationHistoryRequest._();
  GetReconciliationHistoryRequest createEmptyInstance() => create();
  static $pb.PbList<GetReconciliationHistoryRequest> createRepeated() => $pb.PbList<GetReconciliationHistoryRequest>();
  @$core.pragma('dart2js:noInline')
  static GetReconciliationHistoryRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetReconciliationHistoryRequest>(create);
  static GetReconciliationHistoryRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get days => $_getIZ(0);
  @$pb.TagNumber(1)
  set days($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDays() => $_has(0);
  @$pb.TagNumber(1)
  void clearDays() => clearField(1);
}

class ReconciliationHistoryResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ReconciliationHistoryResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errorCode')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errorMessage')
    ..pc<ReconciliationLog>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'logs', $pb.PbFieldType.PM, subBuilder: ReconciliationLog.create)
    ..hasRequiredFields = false
  ;

  ReconciliationHistoryResponse._() : super();
  factory ReconciliationHistoryResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
    $core.Iterable<ReconciliationLog>? logs,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (errorCode != null) {
      _result.errorCode = errorCode;
    }
    if (errorMessage != null) {
      _result.errorMessage = errorMessage;
    }
    if (logs != null) {
      _result.logs.addAll(logs);
    }
    return _result;
  }
  factory ReconciliationHistoryResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ReconciliationHistoryResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ReconciliationHistoryResponse clone() => ReconciliationHistoryResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ReconciliationHistoryResponse copyWith(void Function(ReconciliationHistoryResponse) updates) => super.copyWith((message) => updates(message as ReconciliationHistoryResponse)) as ReconciliationHistoryResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ReconciliationHistoryResponse create() => ReconciliationHistoryResponse._();
  ReconciliationHistoryResponse createEmptyInstance() => create();
  static $pb.PbList<ReconciliationHistoryResponse> createRepeated() => $pb.PbList<ReconciliationHistoryResponse>();
  @$core.pragma('dart2js:noInline')
  static ReconciliationHistoryResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ReconciliationHistoryResponse>(create);
  static ReconciliationHistoryResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<ReconciliationLog> get logs => $_getList(3);
}

class ReconciliationLog extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ReconciliationLog', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOM<$1.Timestamp>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reconciliationDate', subBuilder: $1.Timestamp.create)
    ..aInt64(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalLedgerBalance')
    ..aInt64(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pooledAccountBalance')
    ..aInt64(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'discrepancy')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'notes')
    ..aOM<$1.Timestamp>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'resolvedAt', subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false
  ;

  ReconciliationLog._() : super();
  factory ReconciliationLog({
    $core.String? id,
    $1.Timestamp? reconciliationDate,
    $fixnum.Int64? totalLedgerBalance,
    $fixnum.Int64? pooledAccountBalance,
    $fixnum.Int64? discrepancy,
    $core.String? status,
    $core.String? notes,
    $1.Timestamp? createdAt,
    $1.Timestamp? resolvedAt,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (reconciliationDate != null) {
      _result.reconciliationDate = reconciliationDate;
    }
    if (totalLedgerBalance != null) {
      _result.totalLedgerBalance = totalLedgerBalance;
    }
    if (pooledAccountBalance != null) {
      _result.pooledAccountBalance = pooledAccountBalance;
    }
    if (discrepancy != null) {
      _result.discrepancy = discrepancy;
    }
    if (status != null) {
      _result.status = status;
    }
    if (notes != null) {
      _result.notes = notes;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (resolvedAt != null) {
      _result.resolvedAt = resolvedAt;
    }
    return _result;
  }
  factory ReconciliationLog.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ReconciliationLog.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ReconciliationLog clone() => ReconciliationLog()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ReconciliationLog copyWith(void Function(ReconciliationLog) updates) => super.copyWith((message) => updates(message as ReconciliationLog)) as ReconciliationLog; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ReconciliationLog create() => ReconciliationLog._();
  ReconciliationLog createEmptyInstance() => create();
  static $pb.PbList<ReconciliationLog> createRepeated() => $pb.PbList<ReconciliationLog>();
  @$core.pragma('dart2js:noInline')
  static ReconciliationLog getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ReconciliationLog>(create);
  static ReconciliationLog? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $1.Timestamp get reconciliationDate => $_getN(1);
  @$pb.TagNumber(2)
  set reconciliationDate($1.Timestamp v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasReconciliationDate() => $_has(1);
  @$pb.TagNumber(2)
  void clearReconciliationDate() => clearField(2);
  @$pb.TagNumber(2)
  $1.Timestamp ensureReconciliationDate() => $_ensure(1);

  @$pb.TagNumber(3)
  $fixnum.Int64 get totalLedgerBalance => $_getI64(2);
  @$pb.TagNumber(3)
  set totalLedgerBalance($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTotalLedgerBalance() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalLedgerBalance() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get pooledAccountBalance => $_getI64(3);
  @$pb.TagNumber(4)
  set pooledAccountBalance($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPooledAccountBalance() => $_has(3);
  @$pb.TagNumber(4)
  void clearPooledAccountBalance() => clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get discrepancy => $_getI64(4);
  @$pb.TagNumber(5)
  set discrepancy($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasDiscrepancy() => $_has(4);
  @$pb.TagNumber(5)
  void clearDiscrepancy() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get status => $_getSZ(5);
  @$pb.TagNumber(6)
  set status($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasStatus() => $_has(5);
  @$pb.TagNumber(6)
  void clearStatus() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get notes => $_getSZ(6);
  @$pb.TagNumber(7)
  set notes($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasNotes() => $_has(6);
  @$pb.TagNumber(7)
  void clearNotes() => clearField(7);

  @$pb.TagNumber(8)
  $1.Timestamp get createdAt => $_getN(7);
  @$pb.TagNumber(8)
  set createdAt($1.Timestamp v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasCreatedAt() => $_has(7);
  @$pb.TagNumber(8)
  void clearCreatedAt() => clearField(8);
  @$pb.TagNumber(8)
  $1.Timestamp ensureCreatedAt() => $_ensure(7);

  @$pb.TagNumber(9)
  $1.Timestamp get resolvedAt => $_getN(8);
  @$pb.TagNumber(9)
  set resolvedAt($1.Timestamp v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasResolvedAt() => $_has(8);
  @$pb.TagNumber(9)
  void clearResolvedAt() => clearField(9);
  @$pb.TagNumber(9)
  $1.Timestamp ensureResolvedAt() => $_ensure(8);
}

class GetDailyReportRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetDailyReportRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aOM<$1.Timestamp>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'date', subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false
  ;

  GetDailyReportRequest._() : super();
  factory GetDailyReportRequest({
    $1.Timestamp? date,
  }) {
    final _result = create();
    if (date != null) {
      _result.date = date;
    }
    return _result;
  }
  factory GetDailyReportRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetDailyReportRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetDailyReportRequest clone() => GetDailyReportRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetDailyReportRequest copyWith(void Function(GetDailyReportRequest) updates) => super.copyWith((message) => updates(message as GetDailyReportRequest)) as GetDailyReportRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetDailyReportRequest create() => GetDailyReportRequest._();
  GetDailyReportRequest createEmptyInstance() => create();
  static $pb.PbList<GetDailyReportRequest> createRepeated() => $pb.PbList<GetDailyReportRequest>();
  @$core.pragma('dart2js:noInline')
  static GetDailyReportRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetDailyReportRequest>(create);
  static GetDailyReportRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $1.Timestamp get date => $_getN(0);
  @$pb.TagNumber(1)
  set date($1.Timestamp v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasDate() => $_has(0);
  @$pb.TagNumber(1)
  void clearDate() => clearField(1);
  @$pb.TagNumber(1)
  $1.Timestamp ensureDate() => $_ensure(0);
}

class DailyReportResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DailyReportResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errorCode')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errorMessage')
    ..aOM<$1.Timestamp>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'date', subBuilder: $1.Timestamp.create)
    ..aInt64(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalCredits')
    ..aInt64(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalDebits')
    ..a<$core.int>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'creditCount', $pb.PbFieldType.O3)
    ..a<$core.int>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'debitCount', $pb.PbFieldType.O3)
    ..aInt64(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'netChange')
    ..aInt64(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'internalTransferVolume')
    ..a<$core.int>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'internalTransferCount', $pb.PbFieldType.O3)
    ..aInt64(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'externalTransferVolume')
    ..a<$core.int>(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'externalTransferCount', $pb.PbFieldType.O3)
    ..a<$core.int>(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'failedTransferCount', $pb.PbFieldType.O3)
    ..a<$core.int>(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'newAccountsCreated', $pb.PbFieldType.O3)
    ..aInt64(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalLedgerBalance')
    ..hasRequiredFields = false
  ;

  DailyReportResponse._() : super();
  factory DailyReportResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
    $1.Timestamp? date,
    $fixnum.Int64? totalCredits,
    $fixnum.Int64? totalDebits,
    $core.int? creditCount,
    $core.int? debitCount,
    $fixnum.Int64? netChange,
    $fixnum.Int64? internalTransferVolume,
    $core.int? internalTransferCount,
    $fixnum.Int64? externalTransferVolume,
    $core.int? externalTransferCount,
    $core.int? failedTransferCount,
    $core.int? newAccountsCreated,
    $fixnum.Int64? totalLedgerBalance,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (errorCode != null) {
      _result.errorCode = errorCode;
    }
    if (errorMessage != null) {
      _result.errorMessage = errorMessage;
    }
    if (date != null) {
      _result.date = date;
    }
    if (totalCredits != null) {
      _result.totalCredits = totalCredits;
    }
    if (totalDebits != null) {
      _result.totalDebits = totalDebits;
    }
    if (creditCount != null) {
      _result.creditCount = creditCount;
    }
    if (debitCount != null) {
      _result.debitCount = debitCount;
    }
    if (netChange != null) {
      _result.netChange = netChange;
    }
    if (internalTransferVolume != null) {
      _result.internalTransferVolume = internalTransferVolume;
    }
    if (internalTransferCount != null) {
      _result.internalTransferCount = internalTransferCount;
    }
    if (externalTransferVolume != null) {
      _result.externalTransferVolume = externalTransferVolume;
    }
    if (externalTransferCount != null) {
      _result.externalTransferCount = externalTransferCount;
    }
    if (failedTransferCount != null) {
      _result.failedTransferCount = failedTransferCount;
    }
    if (newAccountsCreated != null) {
      _result.newAccountsCreated = newAccountsCreated;
    }
    if (totalLedgerBalance != null) {
      _result.totalLedgerBalance = totalLedgerBalance;
    }
    return _result;
  }
  factory DailyReportResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DailyReportResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DailyReportResponse clone() => DailyReportResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DailyReportResponse copyWith(void Function(DailyReportResponse) updates) => super.copyWith((message) => updates(message as DailyReportResponse)) as DailyReportResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DailyReportResponse create() => DailyReportResponse._();
  DailyReportResponse createEmptyInstance() => create();
  static $pb.PbList<DailyReportResponse> createRepeated() => $pb.PbList<DailyReportResponse>();
  @$core.pragma('dart2js:noInline')
  static DailyReportResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DailyReportResponse>(create);
  static DailyReportResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => clearField(3);

  @$pb.TagNumber(4)
  $1.Timestamp get date => $_getN(3);
  @$pb.TagNumber(4)
  set date($1.Timestamp v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasDate() => $_has(3);
  @$pb.TagNumber(4)
  void clearDate() => clearField(4);
  @$pb.TagNumber(4)
  $1.Timestamp ensureDate() => $_ensure(3);

  @$pb.TagNumber(5)
  $fixnum.Int64 get totalCredits => $_getI64(4);
  @$pb.TagNumber(5)
  set totalCredits($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTotalCredits() => $_has(4);
  @$pb.TagNumber(5)
  void clearTotalCredits() => clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get totalDebits => $_getI64(5);
  @$pb.TagNumber(6)
  set totalDebits($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasTotalDebits() => $_has(5);
  @$pb.TagNumber(6)
  void clearTotalDebits() => clearField(6);

  @$pb.TagNumber(7)
  $core.int get creditCount => $_getIZ(6);
  @$pb.TagNumber(7)
  set creditCount($core.int v) { $_setSignedInt32(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasCreditCount() => $_has(6);
  @$pb.TagNumber(7)
  void clearCreditCount() => clearField(7);

  @$pb.TagNumber(8)
  $core.int get debitCount => $_getIZ(7);
  @$pb.TagNumber(8)
  set debitCount($core.int v) { $_setSignedInt32(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasDebitCount() => $_has(7);
  @$pb.TagNumber(8)
  void clearDebitCount() => clearField(8);

  @$pb.TagNumber(9)
  $fixnum.Int64 get netChange => $_getI64(8);
  @$pb.TagNumber(9)
  set netChange($fixnum.Int64 v) { $_setInt64(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasNetChange() => $_has(8);
  @$pb.TagNumber(9)
  void clearNetChange() => clearField(9);

  @$pb.TagNumber(10)
  $fixnum.Int64 get internalTransferVolume => $_getI64(9);
  @$pb.TagNumber(10)
  set internalTransferVolume($fixnum.Int64 v) { $_setInt64(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasInternalTransferVolume() => $_has(9);
  @$pb.TagNumber(10)
  void clearInternalTransferVolume() => clearField(10);

  @$pb.TagNumber(11)
  $core.int get internalTransferCount => $_getIZ(10);
  @$pb.TagNumber(11)
  set internalTransferCount($core.int v) { $_setSignedInt32(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasInternalTransferCount() => $_has(10);
  @$pb.TagNumber(11)
  void clearInternalTransferCount() => clearField(11);

  @$pb.TagNumber(12)
  $fixnum.Int64 get externalTransferVolume => $_getI64(11);
  @$pb.TagNumber(12)
  set externalTransferVolume($fixnum.Int64 v) { $_setInt64(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasExternalTransferVolume() => $_has(11);
  @$pb.TagNumber(12)
  void clearExternalTransferVolume() => clearField(12);

  @$pb.TagNumber(13)
  $core.int get externalTransferCount => $_getIZ(12);
  @$pb.TagNumber(13)
  set externalTransferCount($core.int v) { $_setSignedInt32(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasExternalTransferCount() => $_has(12);
  @$pb.TagNumber(13)
  void clearExternalTransferCount() => clearField(13);

  @$pb.TagNumber(14)
  $core.int get failedTransferCount => $_getIZ(13);
  @$pb.TagNumber(14)
  set failedTransferCount($core.int v) { $_setSignedInt32(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasFailedTransferCount() => $_has(13);
  @$pb.TagNumber(14)
  void clearFailedTransferCount() => clearField(14);

  @$pb.TagNumber(15)
  $core.int get newAccountsCreated => $_getIZ(14);
  @$pb.TagNumber(15)
  set newAccountsCreated($core.int v) { $_setSignedInt32(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasNewAccountsCreated() => $_has(14);
  @$pb.TagNumber(15)
  void clearNewAccountsCreated() => clearField(15);

  @$pb.TagNumber(16)
  $fixnum.Int64 get totalLedgerBalance => $_getI64(15);
  @$pb.TagNumber(16)
  set totalLedgerBalance($fixnum.Int64 v) { $_setInt64(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasTotalLedgerBalance() => $_has(15);
  @$pb.TagNumber(16)
  void clearTotalLedgerBalance() => clearField(16);
}

class GetMonoInstitutionsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetMonoInstitutionsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'scope')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'country')
    ..hasRequiredFields = false
  ;

  GetMonoInstitutionsRequest._() : super();
  factory GetMonoInstitutionsRequest({
    $core.String? scope,
    $core.String? country,
  }) {
    final _result = create();
    if (scope != null) {
      _result.scope = scope;
    }
    if (country != null) {
      _result.country = country;
    }
    return _result;
  }
  factory GetMonoInstitutionsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMonoInstitutionsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMonoInstitutionsRequest clone() => GetMonoInstitutionsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMonoInstitutionsRequest copyWith(void Function(GetMonoInstitutionsRequest) updates) => super.copyWith((message) => updates(message as GetMonoInstitutionsRequest)) as GetMonoInstitutionsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetMonoInstitutionsRequest create() => GetMonoInstitutionsRequest._();
  GetMonoInstitutionsRequest createEmptyInstance() => create();
  static $pb.PbList<GetMonoInstitutionsRequest> createRepeated() => $pb.PbList<GetMonoInstitutionsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMonoInstitutionsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMonoInstitutionsRequest>(create);
  static GetMonoInstitutionsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get scope => $_getSZ(0);
  @$pb.TagNumber(1)
  set scope($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasScope() => $_has(0);
  @$pb.TagNumber(1)
  void clearScope() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get country => $_getSZ(1);
  @$pb.TagNumber(2)
  set country($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCountry() => $_has(1);
  @$pb.TagNumber(2)
  void clearCountry() => clearField(2);
}

class MonoInstitutionsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MonoInstitutionsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errorCode')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errorMessage')
    ..pc<MonoInstitution>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'institutions', $pb.PbFieldType.PM, subBuilder: MonoInstitution.create)
    ..hasRequiredFields = false
  ;

  MonoInstitutionsResponse._() : super();
  factory MonoInstitutionsResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
    $core.Iterable<MonoInstitution>? institutions,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (errorCode != null) {
      _result.errorCode = errorCode;
    }
    if (errorMessage != null) {
      _result.errorMessage = errorMessage;
    }
    if (institutions != null) {
      _result.institutions.addAll(institutions);
    }
    return _result;
  }
  factory MonoInstitutionsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MonoInstitutionsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MonoInstitutionsResponse clone() => MonoInstitutionsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MonoInstitutionsResponse copyWith(void Function(MonoInstitutionsResponse) updates) => super.copyWith((message) => updates(message as MonoInstitutionsResponse)) as MonoInstitutionsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MonoInstitutionsResponse create() => MonoInstitutionsResponse._();
  MonoInstitutionsResponse createEmptyInstance() => create();
  static $pb.PbList<MonoInstitutionsResponse> createRepeated() => $pb.PbList<MonoInstitutionsResponse>();
  @$core.pragma('dart2js:noInline')
  static MonoInstitutionsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MonoInstitutionsResponse>(create);
  static MonoInstitutionsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<MonoInstitution> get institutions => $_getList(3);
}

class MonoInstitution extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MonoInstitution', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bankCode')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'icon')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'country')
    ..pc<MonoAuthMethod>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'authMethods', $pb.PbFieldType.PM, subBuilder: MonoAuthMethod.create)
    ..aOB(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'supportsMobileBanking')
    ..aOB(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'supportsInternetBanking')
    ..hasRequiredFields = false
  ;

  MonoInstitution._() : super();
  factory MonoInstitution({
    $core.String? id,
    $core.String? name,
    $core.String? bankCode,
    $core.String? icon,
    $core.String? type,
    $core.String? country,
    $core.Iterable<MonoAuthMethod>? authMethods,
    $core.bool? supportsMobileBanking,
    $core.bool? supportsInternetBanking,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (name != null) {
      _result.name = name;
    }
    if (bankCode != null) {
      _result.bankCode = bankCode;
    }
    if (icon != null) {
      _result.icon = icon;
    }
    if (type != null) {
      _result.type = type;
    }
    if (country != null) {
      _result.country = country;
    }
    if (authMethods != null) {
      _result.authMethods.addAll(authMethods);
    }
    if (supportsMobileBanking != null) {
      _result.supportsMobileBanking = supportsMobileBanking;
    }
    if (supportsInternetBanking != null) {
      _result.supportsInternetBanking = supportsInternetBanking;
    }
    return _result;
  }
  factory MonoInstitution.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MonoInstitution.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MonoInstitution clone() => MonoInstitution()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MonoInstitution copyWith(void Function(MonoInstitution) updates) => super.copyWith((message) => updates(message as MonoInstitution)) as MonoInstitution; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MonoInstitution create() => MonoInstitution._();
  MonoInstitution createEmptyInstance() => create();
  static $pb.PbList<MonoInstitution> createRepeated() => $pb.PbList<MonoInstitution>();
  @$core.pragma('dart2js:noInline')
  static MonoInstitution getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MonoInstitution>(create);
  static MonoInstitution? _defaultInstance;

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
  $core.String get bankCode => $_getSZ(2);
  @$pb.TagNumber(3)
  set bankCode($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasBankCode() => $_has(2);
  @$pb.TagNumber(3)
  void clearBankCode() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get icon => $_getSZ(3);
  @$pb.TagNumber(4)
  set icon($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasIcon() => $_has(3);
  @$pb.TagNumber(4)
  void clearIcon() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get type => $_getSZ(4);
  @$pb.TagNumber(5)
  set type($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasType() => $_has(4);
  @$pb.TagNumber(5)
  void clearType() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get country => $_getSZ(5);
  @$pb.TagNumber(6)
  set country($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasCountry() => $_has(5);
  @$pb.TagNumber(6)
  void clearCountry() => clearField(6);

  @$pb.TagNumber(7)
  $core.List<MonoAuthMethod> get authMethods => $_getList(6);

  @$pb.TagNumber(8)
  $core.bool get supportsMobileBanking => $_getBF(7);
  @$pb.TagNumber(8)
  set supportsMobileBanking($core.bool v) { $_setBool(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasSupportsMobileBanking() => $_has(7);
  @$pb.TagNumber(8)
  void clearSupportsMobileBanking() => clearField(8);

  @$pb.TagNumber(9)
  $core.bool get supportsInternetBanking => $_getBF(8);
  @$pb.TagNumber(9)
  set supportsInternetBanking($core.bool v) { $_setBool(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasSupportsInternetBanking() => $_has(8);
  @$pb.TagNumber(9)
  void clearSupportsInternetBanking() => clearField(9);
}

class MonoAuthMethod extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MonoAuthMethod', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..hasRequiredFields = false
  ;

  MonoAuthMethod._() : super();
  factory MonoAuthMethod({
    $core.String? type,
    $core.String? name,
  }) {
    final _result = create();
    if (type != null) {
      _result.type = type;
    }
    if (name != null) {
      _result.name = name;
    }
    return _result;
  }
  factory MonoAuthMethod.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MonoAuthMethod.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MonoAuthMethod clone() => MonoAuthMethod()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MonoAuthMethod copyWith(void Function(MonoAuthMethod) updates) => super.copyWith((message) => updates(message as MonoAuthMethod)) as MonoAuthMethod; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MonoAuthMethod create() => MonoAuthMethod._();
  MonoAuthMethod createEmptyInstance() => create();
  static $pb.PbList<MonoAuthMethod> createRepeated() => $pb.PbList<MonoAuthMethod>();
  @$core.pragma('dart2js:noInline')
  static MonoAuthMethod getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MonoAuthMethod>(create);
  static MonoAuthMethod? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get type => $_getSZ(0);
  @$pb.TagNumber(1)
  set type($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);
}

class GetConnectWidgetConfigRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetConnectWidgetConfigRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GetConnectWidgetConfigRequest._() : super();
  factory GetConnectWidgetConfigRequest() => create();
  factory GetConnectWidgetConfigRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetConnectWidgetConfigRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetConnectWidgetConfigRequest clone() => GetConnectWidgetConfigRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetConnectWidgetConfigRequest copyWith(void Function(GetConnectWidgetConfigRequest) updates) => super.copyWith((message) => updates(message as GetConnectWidgetConfigRequest)) as GetConnectWidgetConfigRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetConnectWidgetConfigRequest create() => GetConnectWidgetConfigRequest._();
  GetConnectWidgetConfigRequest createEmptyInstance() => create();
  static $pb.PbList<GetConnectWidgetConfigRequest> createRepeated() => $pb.PbList<GetConnectWidgetConfigRequest>();
  @$core.pragma('dart2js:noInline')
  static GetConnectWidgetConfigRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetConnectWidgetConfigRequest>(create);
  static GetConnectWidgetConfigRequest? _defaultInstance;
}

class ConnectWidgetConfigResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ConnectWidgetConfigResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errorCode')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errorMessage')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'publicKey')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'appId')
    ..hasRequiredFields = false
  ;

  ConnectWidgetConfigResponse._() : super();
  factory ConnectWidgetConfigResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
    $core.String? publicKey,
    $core.String? appId,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (errorCode != null) {
      _result.errorCode = errorCode;
    }
    if (errorMessage != null) {
      _result.errorMessage = errorMessage;
    }
    if (publicKey != null) {
      _result.publicKey = publicKey;
    }
    if (appId != null) {
      _result.appId = appId;
    }
    return _result;
  }
  factory ConnectWidgetConfigResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ConnectWidgetConfigResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ConnectWidgetConfigResponse clone() => ConnectWidgetConfigResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ConnectWidgetConfigResponse copyWith(void Function(ConnectWidgetConfigResponse) updates) => super.copyWith((message) => updates(message as ConnectWidgetConfigResponse)) as ConnectWidgetConfigResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ConnectWidgetConfigResponse create() => ConnectWidgetConfigResponse._();
  ConnectWidgetConfigResponse createEmptyInstance() => create();
  static $pb.PbList<ConnectWidgetConfigResponse> createRepeated() => $pb.PbList<ConnectWidgetConfigResponse>();
  @$core.pragma('dart2js:noInline')
  static ConnectWidgetConfigResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ConnectWidgetConfigResponse>(create);
  static ConnectWidgetConfigResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get publicKey => $_getSZ(3);
  @$pb.TagNumber(4)
  set publicKey($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPublicKey() => $_has(3);
  @$pb.TagNumber(4)
  void clearPublicKey() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get appId => $_getSZ(4);
  @$pb.TagNumber(5)
  set appId($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasAppId() => $_has(4);
  @$pb.TagNumber(5)
  void clearAppId() => clearField(5);
}

class LinkBankAccountRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'LinkBankAccountRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'code')
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'setAsDefault')
    ..hasRequiredFields = false
  ;

  LinkBankAccountRequest._() : super();
  factory LinkBankAccountRequest({
    $core.String? userId,
    $core.String? code,
    $core.bool? setAsDefault,
  }) {
    final _result = create();
    if (userId != null) {
      _result.userId = userId;
    }
    if (code != null) {
      _result.code = code;
    }
    if (setAsDefault != null) {
      _result.setAsDefault = setAsDefault;
    }
    return _result;
  }
  factory LinkBankAccountRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LinkBankAccountRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LinkBankAccountRequest clone() => LinkBankAccountRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LinkBankAccountRequest copyWith(void Function(LinkBankAccountRequest) updates) => super.copyWith((message) => updates(message as LinkBankAccountRequest)) as LinkBankAccountRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static LinkBankAccountRequest create() => LinkBankAccountRequest._();
  LinkBankAccountRequest createEmptyInstance() => create();
  static $pb.PbList<LinkBankAccountRequest> createRepeated() => $pb.PbList<LinkBankAccountRequest>();
  @$core.pragma('dart2js:noInline')
  static LinkBankAccountRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LinkBankAccountRequest>(create);
  static LinkBankAccountRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get code => $_getSZ(1);
  @$pb.TagNumber(2)
  set code($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearCode() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get setAsDefault => $_getBF(2);
  @$pb.TagNumber(3)
  set setAsDefault($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSetAsDefault() => $_has(2);
  @$pb.TagNumber(3)
  void clearSetAsDefault() => clearField(3);
}

class LinkBankAccountResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'LinkBankAccountResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errorCode')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errorMessage')
    ..aOM<LinkedBankAccount>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'account', subBuilder: LinkedBankAccount.create)
    ..aOB(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isNewAccount')
    ..hasRequiredFields = false
  ;

  LinkBankAccountResponse._() : super();
  factory LinkBankAccountResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
    LinkedBankAccount? account,
    $core.bool? isNewAccount,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (errorCode != null) {
      _result.errorCode = errorCode;
    }
    if (errorMessage != null) {
      _result.errorMessage = errorMessage;
    }
    if (account != null) {
      _result.account = account;
    }
    if (isNewAccount != null) {
      _result.isNewAccount = isNewAccount;
    }
    return _result;
  }
  factory LinkBankAccountResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LinkBankAccountResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LinkBankAccountResponse clone() => LinkBankAccountResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LinkBankAccountResponse copyWith(void Function(LinkBankAccountResponse) updates) => super.copyWith((message) => updates(message as LinkBankAccountResponse)) as LinkBankAccountResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static LinkBankAccountResponse create() => LinkBankAccountResponse._();
  LinkBankAccountResponse createEmptyInstance() => create();
  static $pb.PbList<LinkBankAccountResponse> createRepeated() => $pb.PbList<LinkBankAccountResponse>();
  @$core.pragma('dart2js:noInline')
  static LinkBankAccountResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LinkBankAccountResponse>(create);
  static LinkBankAccountResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => clearField(3);

  @$pb.TagNumber(4)
  LinkedBankAccount get account => $_getN(3);
  @$pb.TagNumber(4)
  set account(LinkedBankAccount v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasAccount() => $_has(3);
  @$pb.TagNumber(4)
  void clearAccount() => clearField(4);
  @$pb.TagNumber(4)
  LinkedBankAccount ensureAccount() => $_ensure(3);

  @$pb.TagNumber(5)
  $core.bool get isNewAccount => $_getBF(4);
  @$pb.TagNumber(5)
  set isNewAccount($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasIsNewAccount() => $_has(4);
  @$pb.TagNumber(5)
  void clearIsNewAccount() => clearField(5);
}

class GetLinkedAccountsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetLinkedAccountsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..hasRequiredFields = false
  ;

  GetLinkedAccountsRequest._() : super();
  factory GetLinkedAccountsRequest({
    $core.String? userId,
  }) {
    final _result = create();
    if (userId != null) {
      _result.userId = userId;
    }
    return _result;
  }
  factory GetLinkedAccountsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetLinkedAccountsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetLinkedAccountsRequest clone() => GetLinkedAccountsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetLinkedAccountsRequest copyWith(void Function(GetLinkedAccountsRequest) updates) => super.copyWith((message) => updates(message as GetLinkedAccountsRequest)) as GetLinkedAccountsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetLinkedAccountsRequest create() => GetLinkedAccountsRequest._();
  GetLinkedAccountsRequest createEmptyInstance() => create();
  static $pb.PbList<GetLinkedAccountsRequest> createRepeated() => $pb.PbList<GetLinkedAccountsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetLinkedAccountsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetLinkedAccountsRequest>(create);
  static GetLinkedAccountsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);
}

class LinkedAccountsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'LinkedAccountsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errorCode')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errorMessage')
    ..pc<LinkedBankAccount>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accounts', $pb.PbFieldType.PM, subBuilder: LinkedBankAccount.create)
    ..aOM<LinkedBankAccount>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'defaultAccount', subBuilder: LinkedBankAccount.create)
    ..hasRequiredFields = false
  ;

  LinkedAccountsResponse._() : super();
  factory LinkedAccountsResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
    $core.Iterable<LinkedBankAccount>? accounts,
    LinkedBankAccount? defaultAccount,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (errorCode != null) {
      _result.errorCode = errorCode;
    }
    if (errorMessage != null) {
      _result.errorMessage = errorMessage;
    }
    if (accounts != null) {
      _result.accounts.addAll(accounts);
    }
    if (defaultAccount != null) {
      _result.defaultAccount = defaultAccount;
    }
    return _result;
  }
  factory LinkedAccountsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LinkedAccountsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LinkedAccountsResponse clone() => LinkedAccountsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LinkedAccountsResponse copyWith(void Function(LinkedAccountsResponse) updates) => super.copyWith((message) => updates(message as LinkedAccountsResponse)) as LinkedAccountsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static LinkedAccountsResponse create() => LinkedAccountsResponse._();
  LinkedAccountsResponse createEmptyInstance() => create();
  static $pb.PbList<LinkedAccountsResponse> createRepeated() => $pb.PbList<LinkedAccountsResponse>();
  @$core.pragma('dart2js:noInline')
  static LinkedAccountsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LinkedAccountsResponse>(create);
  static LinkedAccountsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<LinkedBankAccount> get accounts => $_getList(3);

  @$pb.TagNumber(5)
  LinkedBankAccount get defaultAccount => $_getN(4);
  @$pb.TagNumber(5)
  set defaultAccount(LinkedBankAccount v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasDefaultAccount() => $_has(4);
  @$pb.TagNumber(5)
  void clearDefaultAccount() => clearField(5);
  @$pb.TagNumber(5)
  LinkedBankAccount ensureDefaultAccount() => $_ensure(4);
}

class GetLinkedAccountRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetLinkedAccountRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountId')
    ..hasRequiredFields = false
  ;

  GetLinkedAccountRequest._() : super();
  factory GetLinkedAccountRequest({
    $core.String? accountId,
  }) {
    final _result = create();
    if (accountId != null) {
      _result.accountId = accountId;
    }
    return _result;
  }
  factory GetLinkedAccountRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetLinkedAccountRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetLinkedAccountRequest clone() => GetLinkedAccountRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetLinkedAccountRequest copyWith(void Function(GetLinkedAccountRequest) updates) => super.copyWith((message) => updates(message as GetLinkedAccountRequest)) as GetLinkedAccountRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetLinkedAccountRequest create() => GetLinkedAccountRequest._();
  GetLinkedAccountRequest createEmptyInstance() => create();
  static $pb.PbList<GetLinkedAccountRequest> createRepeated() => $pb.PbList<GetLinkedAccountRequest>();
  @$core.pragma('dart2js:noInline')
  static GetLinkedAccountRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetLinkedAccountRequest>(create);
  static GetLinkedAccountRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => clearField(1);
}

class LinkedAccountResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'LinkedAccountResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errorCode')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errorMessage')
    ..aOM<LinkedBankAccount>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'account', subBuilder: LinkedBankAccount.create)
    ..hasRequiredFields = false
  ;

  LinkedAccountResponse._() : super();
  factory LinkedAccountResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
    LinkedBankAccount? account,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (errorCode != null) {
      _result.errorCode = errorCode;
    }
    if (errorMessage != null) {
      _result.errorMessage = errorMessage;
    }
    if (account != null) {
      _result.account = account;
    }
    return _result;
  }
  factory LinkedAccountResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LinkedAccountResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LinkedAccountResponse clone() => LinkedAccountResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LinkedAccountResponse copyWith(void Function(LinkedAccountResponse) updates) => super.copyWith((message) => updates(message as LinkedAccountResponse)) as LinkedAccountResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static LinkedAccountResponse create() => LinkedAccountResponse._();
  LinkedAccountResponse createEmptyInstance() => create();
  static $pb.PbList<LinkedAccountResponse> createRepeated() => $pb.PbList<LinkedAccountResponse>();
  @$core.pragma('dart2js:noInline')
  static LinkedAccountResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LinkedAccountResponse>(create);
  static LinkedAccountResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => clearField(3);

  @$pb.TagNumber(4)
  LinkedBankAccount get account => $_getN(3);
  @$pb.TagNumber(4)
  set account(LinkedBankAccount v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasAccount() => $_has(3);
  @$pb.TagNumber(4)
  void clearAccount() => clearField(4);
  @$pb.TagNumber(4)
  LinkedBankAccount ensureAccount() => $_ensure(3);
}

class LinkedBankAccount extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'LinkedBankAccount', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'provider')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bankName')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bankCode')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountNumber')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountName')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountType')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aInt64(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lastKnownBalance')
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..aOB(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isDefault')
    ..aOB(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isVerified')
    ..aOM<$1.Timestamp>(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'linkedAt', subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'balanceUpdatedAt', subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lastUsedAt', subBuilder: $1.Timestamp.create)
    ..aOB(17, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'needsReauthorize')
    ..hasRequiredFields = false
  ;

  LinkedBankAccount._() : super();
  factory LinkedBankAccount({
    $core.String? id,
    $core.String? userId,
    $core.String? provider,
    $core.String? bankName,
    $core.String? bankCode,
    $core.String? accountNumber,
    $core.String? accountName,
    $core.String? accountType,
    $core.String? currency,
    $fixnum.Int64? lastKnownBalance,
    $core.String? status,
    $core.bool? isDefault,
    $core.bool? isVerified,
    $1.Timestamp? linkedAt,
    $1.Timestamp? balanceUpdatedAt,
    $1.Timestamp? lastUsedAt,
    $core.bool? needsReauthorize,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    if (provider != null) {
      _result.provider = provider;
    }
    if (bankName != null) {
      _result.bankName = bankName;
    }
    if (bankCode != null) {
      _result.bankCode = bankCode;
    }
    if (accountNumber != null) {
      _result.accountNumber = accountNumber;
    }
    if (accountName != null) {
      _result.accountName = accountName;
    }
    if (accountType != null) {
      _result.accountType = accountType;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (lastKnownBalance != null) {
      _result.lastKnownBalance = lastKnownBalance;
    }
    if (status != null) {
      _result.status = status;
    }
    if (isDefault != null) {
      _result.isDefault = isDefault;
    }
    if (isVerified != null) {
      _result.isVerified = isVerified;
    }
    if (linkedAt != null) {
      _result.linkedAt = linkedAt;
    }
    if (balanceUpdatedAt != null) {
      _result.balanceUpdatedAt = balanceUpdatedAt;
    }
    if (lastUsedAt != null) {
      _result.lastUsedAt = lastUsedAt;
    }
    if (needsReauthorize != null) {
      _result.needsReauthorize = needsReauthorize;
    }
    return _result;
  }
  factory LinkedBankAccount.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LinkedBankAccount.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LinkedBankAccount clone() => LinkedBankAccount()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LinkedBankAccount copyWith(void Function(LinkedBankAccount) updates) => super.copyWith((message) => updates(message as LinkedBankAccount)) as LinkedBankAccount; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static LinkedBankAccount create() => LinkedBankAccount._();
  LinkedBankAccount createEmptyInstance() => create();
  static $pb.PbList<LinkedBankAccount> createRepeated() => $pb.PbList<LinkedBankAccount>();
  @$core.pragma('dart2js:noInline')
  static LinkedBankAccount getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LinkedBankAccount>(create);
  static LinkedBankAccount? _defaultInstance;

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
  $core.String get provider => $_getSZ(2);
  @$pb.TagNumber(3)
  set provider($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasProvider() => $_has(2);
  @$pb.TagNumber(3)
  void clearProvider() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get bankName => $_getSZ(3);
  @$pb.TagNumber(4)
  set bankName($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasBankName() => $_has(3);
  @$pb.TagNumber(4)
  void clearBankName() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get bankCode => $_getSZ(4);
  @$pb.TagNumber(5)
  set bankCode($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasBankCode() => $_has(4);
  @$pb.TagNumber(5)
  void clearBankCode() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get accountNumber => $_getSZ(5);
  @$pb.TagNumber(6)
  set accountNumber($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasAccountNumber() => $_has(5);
  @$pb.TagNumber(6)
  void clearAccountNumber() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get accountName => $_getSZ(6);
  @$pb.TagNumber(7)
  set accountName($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasAccountName() => $_has(6);
  @$pb.TagNumber(7)
  void clearAccountName() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get accountType => $_getSZ(7);
  @$pb.TagNumber(8)
  set accountType($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasAccountType() => $_has(7);
  @$pb.TagNumber(8)
  void clearAccountType() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get currency => $_getSZ(8);
  @$pb.TagNumber(9)
  set currency($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasCurrency() => $_has(8);
  @$pb.TagNumber(9)
  void clearCurrency() => clearField(9);

  @$pb.TagNumber(10)
  $fixnum.Int64 get lastKnownBalance => $_getI64(9);
  @$pb.TagNumber(10)
  set lastKnownBalance($fixnum.Int64 v) { $_setInt64(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasLastKnownBalance() => $_has(9);
  @$pb.TagNumber(10)
  void clearLastKnownBalance() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get status => $_getSZ(10);
  @$pb.TagNumber(11)
  set status($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasStatus() => $_has(10);
  @$pb.TagNumber(11)
  void clearStatus() => clearField(11);

  @$pb.TagNumber(12)
  $core.bool get isDefault => $_getBF(11);
  @$pb.TagNumber(12)
  set isDefault($core.bool v) { $_setBool(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasIsDefault() => $_has(11);
  @$pb.TagNumber(12)
  void clearIsDefault() => clearField(12);

  @$pb.TagNumber(13)
  $core.bool get isVerified => $_getBF(12);
  @$pb.TagNumber(13)
  set isVerified($core.bool v) { $_setBool(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasIsVerified() => $_has(12);
  @$pb.TagNumber(13)
  void clearIsVerified() => clearField(13);

  @$pb.TagNumber(14)
  $1.Timestamp get linkedAt => $_getN(13);
  @$pb.TagNumber(14)
  set linkedAt($1.Timestamp v) { setField(14, v); }
  @$pb.TagNumber(14)
  $core.bool hasLinkedAt() => $_has(13);
  @$pb.TagNumber(14)
  void clearLinkedAt() => clearField(14);
  @$pb.TagNumber(14)
  $1.Timestamp ensureLinkedAt() => $_ensure(13);

  @$pb.TagNumber(15)
  $1.Timestamp get balanceUpdatedAt => $_getN(14);
  @$pb.TagNumber(15)
  set balanceUpdatedAt($1.Timestamp v) { setField(15, v); }
  @$pb.TagNumber(15)
  $core.bool hasBalanceUpdatedAt() => $_has(14);
  @$pb.TagNumber(15)
  void clearBalanceUpdatedAt() => clearField(15);
  @$pb.TagNumber(15)
  $1.Timestamp ensureBalanceUpdatedAt() => $_ensure(14);

  @$pb.TagNumber(16)
  $1.Timestamp get lastUsedAt => $_getN(15);
  @$pb.TagNumber(16)
  set lastUsedAt($1.Timestamp v) { setField(16, v); }
  @$pb.TagNumber(16)
  $core.bool hasLastUsedAt() => $_has(15);
  @$pb.TagNumber(16)
  void clearLastUsedAt() => clearField(16);
  @$pb.TagNumber(16)
  $1.Timestamp ensureLastUsedAt() => $_ensure(15);

  @$pb.TagNumber(17)
  $core.bool get needsReauthorize => $_getBF(16);
  @$pb.TagNumber(17)
  set needsReauthorize($core.bool v) { $_setBool(16, v); }
  @$pb.TagNumber(17)
  $core.bool hasNeedsReauthorize() => $_has(16);
  @$pb.TagNumber(17)
  void clearNeedsReauthorize() => clearField(17);
}

class UnlinkBankAccountRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UnlinkBankAccountRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..hasRequiredFields = false
  ;

  UnlinkBankAccountRequest._() : super();
  factory UnlinkBankAccountRequest({
    $core.String? accountId,
    $core.String? userId,
  }) {
    final _result = create();
    if (accountId != null) {
      _result.accountId = accountId;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    return _result;
  }
  factory UnlinkBankAccountRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UnlinkBankAccountRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UnlinkBankAccountRequest clone() => UnlinkBankAccountRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UnlinkBankAccountRequest copyWith(void Function(UnlinkBankAccountRequest) updates) => super.copyWith((message) => updates(message as UnlinkBankAccountRequest)) as UnlinkBankAccountRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UnlinkBankAccountRequest create() => UnlinkBankAccountRequest._();
  UnlinkBankAccountRequest createEmptyInstance() => create();
  static $pb.PbList<UnlinkBankAccountRequest> createRepeated() => $pb.PbList<UnlinkBankAccountRequest>();
  @$core.pragma('dart2js:noInline')
  static UnlinkBankAccountRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UnlinkBankAccountRequest>(create);
  static UnlinkBankAccountRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => clearField(2);
}

class UnlinkBankAccountResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UnlinkBankAccountResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errorCode')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errorMessage')
    ..hasRequiredFields = false
  ;

  UnlinkBankAccountResponse._() : super();
  factory UnlinkBankAccountResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (errorCode != null) {
      _result.errorCode = errorCode;
    }
    if (errorMessage != null) {
      _result.errorMessage = errorMessage;
    }
    return _result;
  }
  factory UnlinkBankAccountResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UnlinkBankAccountResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UnlinkBankAccountResponse clone() => UnlinkBankAccountResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UnlinkBankAccountResponse copyWith(void Function(UnlinkBankAccountResponse) updates) => super.copyWith((message) => updates(message as UnlinkBankAccountResponse)) as UnlinkBankAccountResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UnlinkBankAccountResponse create() => UnlinkBankAccountResponse._();
  UnlinkBankAccountResponse createEmptyInstance() => create();
  static $pb.PbList<UnlinkBankAccountResponse> createRepeated() => $pb.PbList<UnlinkBankAccountResponse>();
  @$core.pragma('dart2js:noInline')
  static UnlinkBankAccountResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UnlinkBankAccountResponse>(create);
  static UnlinkBankAccountResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => clearField(3);
}

class SetDefaultLinkedAccountRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SetDefaultLinkedAccountRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..hasRequiredFields = false
  ;

  SetDefaultLinkedAccountRequest._() : super();
  factory SetDefaultLinkedAccountRequest({
    $core.String? accountId,
    $core.String? userId,
  }) {
    final _result = create();
    if (accountId != null) {
      _result.accountId = accountId;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    return _result;
  }
  factory SetDefaultLinkedAccountRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SetDefaultLinkedAccountRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SetDefaultLinkedAccountRequest clone() => SetDefaultLinkedAccountRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SetDefaultLinkedAccountRequest copyWith(void Function(SetDefaultLinkedAccountRequest) updates) => super.copyWith((message) => updates(message as SetDefaultLinkedAccountRequest)) as SetDefaultLinkedAccountRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SetDefaultLinkedAccountRequest create() => SetDefaultLinkedAccountRequest._();
  SetDefaultLinkedAccountRequest createEmptyInstance() => create();
  static $pb.PbList<SetDefaultLinkedAccountRequest> createRepeated() => $pb.PbList<SetDefaultLinkedAccountRequest>();
  @$core.pragma('dart2js:noInline')
  static SetDefaultLinkedAccountRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SetDefaultLinkedAccountRequest>(create);
  static SetDefaultLinkedAccountRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => clearField(2);
}

class SetDefaultLinkedAccountResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SetDefaultLinkedAccountResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errorCode')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errorMessage')
    ..hasRequiredFields = false
  ;

  SetDefaultLinkedAccountResponse._() : super();
  factory SetDefaultLinkedAccountResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (errorCode != null) {
      _result.errorCode = errorCode;
    }
    if (errorMessage != null) {
      _result.errorMessage = errorMessage;
    }
    return _result;
  }
  factory SetDefaultLinkedAccountResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SetDefaultLinkedAccountResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SetDefaultLinkedAccountResponse clone() => SetDefaultLinkedAccountResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SetDefaultLinkedAccountResponse copyWith(void Function(SetDefaultLinkedAccountResponse) updates) => super.copyWith((message) => updates(message as SetDefaultLinkedAccountResponse)) as SetDefaultLinkedAccountResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SetDefaultLinkedAccountResponse create() => SetDefaultLinkedAccountResponse._();
  SetDefaultLinkedAccountResponse createEmptyInstance() => create();
  static $pb.PbList<SetDefaultLinkedAccountResponse> createRepeated() => $pb.PbList<SetDefaultLinkedAccountResponse>();
  @$core.pragma('dart2js:noInline')
  static SetDefaultLinkedAccountResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SetDefaultLinkedAccountResponse>(create);
  static SetDefaultLinkedAccountResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => clearField(3);
}

class RefreshLinkedAccountBalanceRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RefreshLinkedAccountBalanceRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..hasRequiredFields = false
  ;

  RefreshLinkedAccountBalanceRequest._() : super();
  factory RefreshLinkedAccountBalanceRequest({
    $core.String? accountId,
    $core.String? userId,
  }) {
    final _result = create();
    if (accountId != null) {
      _result.accountId = accountId;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    return _result;
  }
  factory RefreshLinkedAccountBalanceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RefreshLinkedAccountBalanceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RefreshLinkedAccountBalanceRequest clone() => RefreshLinkedAccountBalanceRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RefreshLinkedAccountBalanceRequest copyWith(void Function(RefreshLinkedAccountBalanceRequest) updates) => super.copyWith((message) => updates(message as RefreshLinkedAccountBalanceRequest)) as RefreshLinkedAccountBalanceRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RefreshLinkedAccountBalanceRequest create() => RefreshLinkedAccountBalanceRequest._();
  RefreshLinkedAccountBalanceRequest createEmptyInstance() => create();
  static $pb.PbList<RefreshLinkedAccountBalanceRequest> createRepeated() => $pb.PbList<RefreshLinkedAccountBalanceRequest>();
  @$core.pragma('dart2js:noInline')
  static RefreshLinkedAccountBalanceRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RefreshLinkedAccountBalanceRequest>(create);
  static RefreshLinkedAccountBalanceRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => clearField(2);
}

class RefreshLinkedAccountBalanceResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RefreshLinkedAccountBalanceResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errorCode')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errorMessage')
    ..aInt64(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'newBalance')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..hasRequiredFields = false
  ;

  RefreshLinkedAccountBalanceResponse._() : super();
  factory RefreshLinkedAccountBalanceResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
    $fixnum.Int64? newBalance,
    $core.String? currency,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (errorCode != null) {
      _result.errorCode = errorCode;
    }
    if (errorMessage != null) {
      _result.errorMessage = errorMessage;
    }
    if (newBalance != null) {
      _result.newBalance = newBalance;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    return _result;
  }
  factory RefreshLinkedAccountBalanceResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RefreshLinkedAccountBalanceResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RefreshLinkedAccountBalanceResponse clone() => RefreshLinkedAccountBalanceResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RefreshLinkedAccountBalanceResponse copyWith(void Function(RefreshLinkedAccountBalanceResponse) updates) => super.copyWith((message) => updates(message as RefreshLinkedAccountBalanceResponse)) as RefreshLinkedAccountBalanceResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RefreshLinkedAccountBalanceResponse create() => RefreshLinkedAccountBalanceResponse._();
  RefreshLinkedAccountBalanceResponse createEmptyInstance() => create();
  static $pb.PbList<RefreshLinkedAccountBalanceResponse> createRepeated() => $pb.PbList<RefreshLinkedAccountBalanceResponse>();
  @$core.pragma('dart2js:noInline')
  static RefreshLinkedAccountBalanceResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RefreshLinkedAccountBalanceResponse>(create);
  static RefreshLinkedAccountBalanceResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get newBalance => $_getI64(3);
  @$pb.TagNumber(4)
  set newBalance($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasNewBalance() => $_has(3);
  @$pb.TagNumber(4)
  void clearNewBalance() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get currency => $_getSZ(4);
  @$pb.TagNumber(5)
  set currency($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasCurrency() => $_has(4);
  @$pb.TagNumber(5)
  void clearCurrency() => clearField(5);
}

class GetReauthorizationTokenRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetReauthorizationTokenRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..hasRequiredFields = false
  ;

  GetReauthorizationTokenRequest._() : super();
  factory GetReauthorizationTokenRequest({
    $core.String? accountId,
    $core.String? userId,
  }) {
    final _result = create();
    if (accountId != null) {
      _result.accountId = accountId;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    return _result;
  }
  factory GetReauthorizationTokenRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetReauthorizationTokenRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetReauthorizationTokenRequest clone() => GetReauthorizationTokenRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetReauthorizationTokenRequest copyWith(void Function(GetReauthorizationTokenRequest) updates) => super.copyWith((message) => updates(message as GetReauthorizationTokenRequest)) as GetReauthorizationTokenRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetReauthorizationTokenRequest create() => GetReauthorizationTokenRequest._();
  GetReauthorizationTokenRequest createEmptyInstance() => create();
  static $pb.PbList<GetReauthorizationTokenRequest> createRepeated() => $pb.PbList<GetReauthorizationTokenRequest>();
  @$core.pragma('dart2js:noInline')
  static GetReauthorizationTokenRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetReauthorizationTokenRequest>(create);
  static GetReauthorizationTokenRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => clearField(2);
}

class GetReauthorizationTokenResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetReauthorizationTokenResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errorCode')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errorMessage')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'token')
    ..hasRequiredFields = false
  ;

  GetReauthorizationTokenResponse._() : super();
  factory GetReauthorizationTokenResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
    $core.String? token,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (errorCode != null) {
      _result.errorCode = errorCode;
    }
    if (errorMessage != null) {
      _result.errorMessage = errorMessage;
    }
    if (token != null) {
      _result.token = token;
    }
    return _result;
  }
  factory GetReauthorizationTokenResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetReauthorizationTokenResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetReauthorizationTokenResponse clone() => GetReauthorizationTokenResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetReauthorizationTokenResponse copyWith(void Function(GetReauthorizationTokenResponse) updates) => super.copyWith((message) => updates(message as GetReauthorizationTokenResponse)) as GetReauthorizationTokenResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetReauthorizationTokenResponse create() => GetReauthorizationTokenResponse._();
  GetReauthorizationTokenResponse createEmptyInstance() => create();
  static $pb.PbList<GetReauthorizationTokenResponse> createRepeated() => $pb.PbList<GetReauthorizationTokenResponse>();
  @$core.pragma('dart2js:noInline')
  static GetReauthorizationTokenResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetReauthorizationTokenResponse>(create);
  static GetReauthorizationTokenResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get token => $_getSZ(3);
  @$pb.TagNumber(4)
  set token($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasToken() => $_has(3);
  @$pb.TagNumber(4)
  void clearToken() => clearField(4);
}

class InitiateDepositRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'InitiateDepositRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'linkedAccountId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'destinationAccountId')
    ..aInt64(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'narration')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'idempotencyKey')
    ..aOB(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'useRecurringAccess')
    ..hasRequiredFields = false
  ;

  InitiateDepositRequest._() : super();
  factory InitiateDepositRequest({
    $core.String? userId,
    $core.String? linkedAccountId,
    $core.String? destinationAccountId,
    $fixnum.Int64? amount,
    $core.String? narration,
    $core.String? idempotencyKey,
    $core.bool? useRecurringAccess,
  }) {
    final _result = create();
    if (userId != null) {
      _result.userId = userId;
    }
    if (linkedAccountId != null) {
      _result.linkedAccountId = linkedAccountId;
    }
    if (destinationAccountId != null) {
      _result.destinationAccountId = destinationAccountId;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (narration != null) {
      _result.narration = narration;
    }
    if (idempotencyKey != null) {
      _result.idempotencyKey = idempotencyKey;
    }
    if (useRecurringAccess != null) {
      _result.useRecurringAccess = useRecurringAccess;
    }
    return _result;
  }
  factory InitiateDepositRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InitiateDepositRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InitiateDepositRequest clone() => InitiateDepositRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InitiateDepositRequest copyWith(void Function(InitiateDepositRequest) updates) => super.copyWith((message) => updates(message as InitiateDepositRequest)) as InitiateDepositRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static InitiateDepositRequest create() => InitiateDepositRequest._();
  InitiateDepositRequest createEmptyInstance() => create();
  static $pb.PbList<InitiateDepositRequest> createRepeated() => $pb.PbList<InitiateDepositRequest>();
  @$core.pragma('dart2js:noInline')
  static InitiateDepositRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InitiateDepositRequest>(create);
  static InitiateDepositRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get linkedAccountId => $_getSZ(1);
  @$pb.TagNumber(2)
  set linkedAccountId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLinkedAccountId() => $_has(1);
  @$pb.TagNumber(2)
  void clearLinkedAccountId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get destinationAccountId => $_getSZ(2);
  @$pb.TagNumber(3)
  set destinationAccountId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDestinationAccountId() => $_has(2);
  @$pb.TagNumber(3)
  void clearDestinationAccountId() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get amount => $_getI64(3);
  @$pb.TagNumber(4)
  set amount($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearAmount() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get narration => $_getSZ(4);
  @$pb.TagNumber(5)
  set narration($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasNarration() => $_has(4);
  @$pb.TagNumber(5)
  void clearNarration() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get idempotencyKey => $_getSZ(5);
  @$pb.TagNumber(6)
  set idempotencyKey($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasIdempotencyKey() => $_has(5);
  @$pb.TagNumber(6)
  void clearIdempotencyKey() => clearField(6);

  @$pb.TagNumber(7)
  $core.bool get useRecurringAccess => $_getBF(6);
  @$pb.TagNumber(7)
  set useRecurringAccess($core.bool v) { $_setBool(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasUseRecurringAccess() => $_has(6);
  @$pb.TagNumber(7)
  void clearUseRecurringAccess() => clearField(7);
}

class DepositResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DepositResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errorCode')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errorMessage')
    ..aOM<Deposit>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'deposit', subBuilder: Deposit.create)
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOB(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'needsMandate')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'mandateId')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'authorizationUrl')
    ..aOB(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'requiresAuthorization')
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'paymentUrl')
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'paymentId')
    ..hasRequiredFields = false
  ;

  DepositResponse._() : super();
  factory DepositResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
    Deposit? deposit,
    $core.String? message,
    $core.bool? needsMandate,
    $core.String? mandateId,
    $core.String? authorizationUrl,
    $core.bool? requiresAuthorization,
    $core.String? paymentUrl,
    $core.String? paymentId,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (errorCode != null) {
      _result.errorCode = errorCode;
    }
    if (errorMessage != null) {
      _result.errorMessage = errorMessage;
    }
    if (deposit != null) {
      _result.deposit = deposit;
    }
    if (message != null) {
      _result.message = message;
    }
    if (needsMandate != null) {
      _result.needsMandate = needsMandate;
    }
    if (mandateId != null) {
      _result.mandateId = mandateId;
    }
    if (authorizationUrl != null) {
      _result.authorizationUrl = authorizationUrl;
    }
    if (requiresAuthorization != null) {
      _result.requiresAuthorization = requiresAuthorization;
    }
    if (paymentUrl != null) {
      _result.paymentUrl = paymentUrl;
    }
    if (paymentId != null) {
      _result.paymentId = paymentId;
    }
    return _result;
  }
  factory DepositResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DepositResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DepositResponse clone() => DepositResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DepositResponse copyWith(void Function(DepositResponse) updates) => super.copyWith((message) => updates(message as DepositResponse)) as DepositResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DepositResponse create() => DepositResponse._();
  DepositResponse createEmptyInstance() => create();
  static $pb.PbList<DepositResponse> createRepeated() => $pb.PbList<DepositResponse>();
  @$core.pragma('dart2js:noInline')
  static DepositResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DepositResponse>(create);
  static DepositResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => clearField(3);

  @$pb.TagNumber(4)
  Deposit get deposit => $_getN(3);
  @$pb.TagNumber(4)
  set deposit(Deposit v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasDeposit() => $_has(3);
  @$pb.TagNumber(4)
  void clearDeposit() => clearField(4);
  @$pb.TagNumber(4)
  Deposit ensureDeposit() => $_ensure(3);

  @$pb.TagNumber(5)
  $core.String get message => $_getSZ(4);
  @$pb.TagNumber(5)
  set message($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasMessage() => $_has(4);
  @$pb.TagNumber(5)
  void clearMessage() => clearField(5);

  @$pb.TagNumber(6)
  $core.bool get needsMandate => $_getBF(5);
  @$pb.TagNumber(6)
  set needsMandate($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasNeedsMandate() => $_has(5);
  @$pb.TagNumber(6)
  void clearNeedsMandate() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get mandateId => $_getSZ(6);
  @$pb.TagNumber(7)
  set mandateId($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasMandateId() => $_has(6);
  @$pb.TagNumber(7)
  void clearMandateId() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get authorizationUrl => $_getSZ(7);
  @$pb.TagNumber(8)
  set authorizationUrl($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasAuthorizationUrl() => $_has(7);
  @$pb.TagNumber(8)
  void clearAuthorizationUrl() => clearField(8);

  @$pb.TagNumber(9)
  $core.bool get requiresAuthorization => $_getBF(8);
  @$pb.TagNumber(9)
  set requiresAuthorization($core.bool v) { $_setBool(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasRequiresAuthorization() => $_has(8);
  @$pb.TagNumber(9)
  void clearRequiresAuthorization() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get paymentUrl => $_getSZ(9);
  @$pb.TagNumber(10)
  set paymentUrl($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasPaymentUrl() => $_has(9);
  @$pb.TagNumber(10)
  void clearPaymentUrl() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get paymentId => $_getSZ(10);
  @$pb.TagNumber(11)
  set paymentId($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasPaymentId() => $_has(10);
  @$pb.TagNumber(11)
  void clearPaymentId() => clearField(11);
}

class Deposit extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Deposit', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'linkedAccountId')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'destinationAccountId')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sourceBankName')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sourceAccountNumber')
    ..aInt64(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount')
    ..aInt64(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fee')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reference')
    ..aOS(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'narration')
    ..aOS(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'failureCode')
    ..aOS(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'failureReason')
    ..aOM<$1.Timestamp>(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'completedAt', subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false
  ;

  Deposit._() : super();
  factory Deposit({
    $core.String? id,
    $core.String? userId,
    $core.String? linkedAccountId,
    $core.String? destinationAccountId,
    $core.String? sourceBankName,
    $core.String? sourceAccountNumber,
    $fixnum.Int64? amount,
    $fixnum.Int64? fee,
    $core.String? currency,
    $core.String? status,
    $core.String? reference,
    $core.String? narration,
    $core.String? failureCode,
    $core.String? failureReason,
    $1.Timestamp? createdAt,
    $1.Timestamp? completedAt,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    if (linkedAccountId != null) {
      _result.linkedAccountId = linkedAccountId;
    }
    if (destinationAccountId != null) {
      _result.destinationAccountId = destinationAccountId;
    }
    if (sourceBankName != null) {
      _result.sourceBankName = sourceBankName;
    }
    if (sourceAccountNumber != null) {
      _result.sourceAccountNumber = sourceAccountNumber;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (fee != null) {
      _result.fee = fee;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (status != null) {
      _result.status = status;
    }
    if (reference != null) {
      _result.reference = reference;
    }
    if (narration != null) {
      _result.narration = narration;
    }
    if (failureCode != null) {
      _result.failureCode = failureCode;
    }
    if (failureReason != null) {
      _result.failureReason = failureReason;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (completedAt != null) {
      _result.completedAt = completedAt;
    }
    return _result;
  }
  factory Deposit.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Deposit.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Deposit clone() => Deposit()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Deposit copyWith(void Function(Deposit) updates) => super.copyWith((message) => updates(message as Deposit)) as Deposit; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Deposit create() => Deposit._();
  Deposit createEmptyInstance() => create();
  static $pb.PbList<Deposit> createRepeated() => $pb.PbList<Deposit>();
  @$core.pragma('dart2js:noInline')
  static Deposit getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Deposit>(create);
  static Deposit? _defaultInstance;

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
  $core.String get linkedAccountId => $_getSZ(2);
  @$pb.TagNumber(3)
  set linkedAccountId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasLinkedAccountId() => $_has(2);
  @$pb.TagNumber(3)
  void clearLinkedAccountId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get destinationAccountId => $_getSZ(3);
  @$pb.TagNumber(4)
  set destinationAccountId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasDestinationAccountId() => $_has(3);
  @$pb.TagNumber(4)
  void clearDestinationAccountId() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get sourceBankName => $_getSZ(4);
  @$pb.TagNumber(5)
  set sourceBankName($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasSourceBankName() => $_has(4);
  @$pb.TagNumber(5)
  void clearSourceBankName() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get sourceAccountNumber => $_getSZ(5);
  @$pb.TagNumber(6)
  set sourceAccountNumber($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasSourceAccountNumber() => $_has(5);
  @$pb.TagNumber(6)
  void clearSourceAccountNumber() => clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get amount => $_getI64(6);
  @$pb.TagNumber(7)
  set amount($fixnum.Int64 v) { $_setInt64(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasAmount() => $_has(6);
  @$pb.TagNumber(7)
  void clearAmount() => clearField(7);

  @$pb.TagNumber(8)
  $fixnum.Int64 get fee => $_getI64(7);
  @$pb.TagNumber(8)
  set fee($fixnum.Int64 v) { $_setInt64(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasFee() => $_has(7);
  @$pb.TagNumber(8)
  void clearFee() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get currency => $_getSZ(8);
  @$pb.TagNumber(9)
  set currency($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasCurrency() => $_has(8);
  @$pb.TagNumber(9)
  void clearCurrency() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get status => $_getSZ(9);
  @$pb.TagNumber(10)
  set status($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasStatus() => $_has(9);
  @$pb.TagNumber(10)
  void clearStatus() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get reference => $_getSZ(10);
  @$pb.TagNumber(11)
  set reference($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasReference() => $_has(10);
  @$pb.TagNumber(11)
  void clearReference() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get narration => $_getSZ(11);
  @$pb.TagNumber(12)
  set narration($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasNarration() => $_has(11);
  @$pb.TagNumber(12)
  void clearNarration() => clearField(12);

  @$pb.TagNumber(13)
  $core.String get failureCode => $_getSZ(12);
  @$pb.TagNumber(13)
  set failureCode($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasFailureCode() => $_has(12);
  @$pb.TagNumber(13)
  void clearFailureCode() => clearField(13);

  @$pb.TagNumber(14)
  $core.String get failureReason => $_getSZ(13);
  @$pb.TagNumber(14)
  set failureReason($core.String v) { $_setString(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasFailureReason() => $_has(13);
  @$pb.TagNumber(14)
  void clearFailureReason() => clearField(14);

  @$pb.TagNumber(15)
  $1.Timestamp get createdAt => $_getN(14);
  @$pb.TagNumber(15)
  set createdAt($1.Timestamp v) { setField(15, v); }
  @$pb.TagNumber(15)
  $core.bool hasCreatedAt() => $_has(14);
  @$pb.TagNumber(15)
  void clearCreatedAt() => clearField(15);
  @$pb.TagNumber(15)
  $1.Timestamp ensureCreatedAt() => $_ensure(14);

  @$pb.TagNumber(16)
  $1.Timestamp get completedAt => $_getN(15);
  @$pb.TagNumber(16)
  set completedAt($1.Timestamp v) { setField(16, v); }
  @$pb.TagNumber(16)
  $core.bool hasCompletedAt() => $_has(15);
  @$pb.TagNumber(16)
  void clearCompletedAt() => clearField(16);
  @$pb.TagNumber(16)
  $1.Timestamp ensureCompletedAt() => $_ensure(15);
}

class GetDepositStatusRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetDepositStatusRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'depositId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..hasRequiredFields = false
  ;

  GetDepositStatusRequest._() : super();
  factory GetDepositStatusRequest({
    $core.String? depositId,
    $core.String? userId,
  }) {
    final _result = create();
    if (depositId != null) {
      _result.depositId = depositId;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    return _result;
  }
  factory GetDepositStatusRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetDepositStatusRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetDepositStatusRequest clone() => GetDepositStatusRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetDepositStatusRequest copyWith(void Function(GetDepositStatusRequest) updates) => super.copyWith((message) => updates(message as GetDepositStatusRequest)) as GetDepositStatusRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetDepositStatusRequest create() => GetDepositStatusRequest._();
  GetDepositStatusRequest createEmptyInstance() => create();
  static $pb.PbList<GetDepositStatusRequest> createRepeated() => $pb.PbList<GetDepositStatusRequest>();
  @$core.pragma('dart2js:noInline')
  static GetDepositStatusRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetDepositStatusRequest>(create);
  static GetDepositStatusRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get depositId => $_getSZ(0);
  @$pb.TagNumber(1)
  set depositId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDepositId() => $_has(0);
  @$pb.TagNumber(1)
  void clearDepositId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => clearField(2);
}

class GetUserDepositsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetUserDepositsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetUserDepositsRequest._() : super();
  factory GetUserDepositsRequest({
    $core.String? userId,
    $core.int? limit,
    $core.int? offset,
  }) {
    final _result = create();
    if (userId != null) {
      _result.userId = userId;
    }
    if (limit != null) {
      _result.limit = limit;
    }
    if (offset != null) {
      _result.offset = offset;
    }
    return _result;
  }
  factory GetUserDepositsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUserDepositsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUserDepositsRequest clone() => GetUserDepositsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUserDepositsRequest copyWith(void Function(GetUserDepositsRequest) updates) => super.copyWith((message) => updates(message as GetUserDepositsRequest)) as GetUserDepositsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetUserDepositsRequest create() => GetUserDepositsRequest._();
  GetUserDepositsRequest createEmptyInstance() => create();
  static $pb.PbList<GetUserDepositsRequest> createRepeated() => $pb.PbList<GetUserDepositsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetUserDepositsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetUserDepositsRequest>(create);
  static GetUserDepositsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

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

class DepositsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DepositsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errorCode')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errorMessage')
    ..pc<Deposit>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'deposits', $pb.PbFieldType.PM, subBuilder: Deposit.create)
    ..a<$core.int>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  DepositsResponse._() : super();
  factory DepositsResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
    $core.Iterable<Deposit>? deposits,
    $core.int? total,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (errorCode != null) {
      _result.errorCode = errorCode;
    }
    if (errorMessage != null) {
      _result.errorMessage = errorMessage;
    }
    if (deposits != null) {
      _result.deposits.addAll(deposits);
    }
    if (total != null) {
      _result.total = total;
    }
    return _result;
  }
  factory DepositsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DepositsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DepositsResponse clone() => DepositsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DepositsResponse copyWith(void Function(DepositsResponse) updates) => super.copyWith((message) => updates(message as DepositsResponse)) as DepositsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DepositsResponse create() => DepositsResponse._();
  DepositsResponse createEmptyInstance() => create();
  static $pb.PbList<DepositsResponse> createRepeated() => $pb.PbList<DepositsResponse>();
  @$core.pragma('dart2js:noInline')
  static DepositsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DepositsResponse>(create);
  static DepositsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<Deposit> get deposits => $_getList(3);

  @$pb.TagNumber(5)
  $core.int get total => $_getIZ(4);
  @$pb.TagNumber(5)
  set total($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTotal() => $_has(4);
  @$pb.TagNumber(5)
  void clearTotal() => clearField(5);
}

class CancelDepositRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CancelDepositRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'depositId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..hasRequiredFields = false
  ;

  CancelDepositRequest._() : super();
  factory CancelDepositRequest({
    $core.String? depositId,
    $core.String? userId,
  }) {
    final _result = create();
    if (depositId != null) {
      _result.depositId = depositId;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    return _result;
  }
  factory CancelDepositRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CancelDepositRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CancelDepositRequest clone() => CancelDepositRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CancelDepositRequest copyWith(void Function(CancelDepositRequest) updates) => super.copyWith((message) => updates(message as CancelDepositRequest)) as CancelDepositRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CancelDepositRequest create() => CancelDepositRequest._();
  CancelDepositRequest createEmptyInstance() => create();
  static $pb.PbList<CancelDepositRequest> createRepeated() => $pb.PbList<CancelDepositRequest>();
  @$core.pragma('dart2js:noInline')
  static CancelDepositRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CancelDepositRequest>(create);
  static CancelDepositRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get depositId => $_getSZ(0);
  @$pb.TagNumber(1)
  set depositId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDepositId() => $_has(0);
  @$pb.TagNumber(1)
  void clearDepositId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => clearField(2);
}

class CancelDepositResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CancelDepositResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errorCode')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errorMessage')
    ..hasRequiredFields = false
  ;

  CancelDepositResponse._() : super();
  factory CancelDepositResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (errorCode != null) {
      _result.errorCode = errorCode;
    }
    if (errorMessage != null) {
      _result.errorMessage = errorMessage;
    }
    return _result;
  }
  factory CancelDepositResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CancelDepositResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CancelDepositResponse clone() => CancelDepositResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CancelDepositResponse copyWith(void Function(CancelDepositResponse) updates) => super.copyWith((message) => updates(message as CancelDepositResponse)) as CancelDepositResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CancelDepositResponse create() => CancelDepositResponse._();
  CancelDepositResponse createEmptyInstance() => create();
  static $pb.PbList<CancelDepositResponse> createRepeated() => $pb.PbList<CancelDepositResponse>();
  @$core.pragma('dart2js:noInline')
  static CancelDepositResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CancelDepositResponse>(create);
  static CancelDepositResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => clearField(3);
}

class CalculateDepositFeeRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CalculateDepositFeeRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aInt64(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount')
    ..hasRequiredFields = false
  ;

  CalculateDepositFeeRequest._() : super();
  factory CalculateDepositFeeRequest({
    $fixnum.Int64? amount,
  }) {
    final _result = create();
    if (amount != null) {
      _result.amount = amount;
    }
    return _result;
  }
  factory CalculateDepositFeeRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CalculateDepositFeeRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CalculateDepositFeeRequest clone() => CalculateDepositFeeRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CalculateDepositFeeRequest copyWith(void Function(CalculateDepositFeeRequest) updates) => super.copyWith((message) => updates(message as CalculateDepositFeeRequest)) as CalculateDepositFeeRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CalculateDepositFeeRequest create() => CalculateDepositFeeRequest._();
  CalculateDepositFeeRequest createEmptyInstance() => create();
  static $pb.PbList<CalculateDepositFeeRequest> createRepeated() => $pb.PbList<CalculateDepositFeeRequest>();
  @$core.pragma('dart2js:noInline')
  static CalculateDepositFeeRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CalculateDepositFeeRequest>(create);
  static CalculateDepositFeeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get amount => $_getI64(0);
  @$pb.TagNumber(1)
  set amount($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAmount() => $_has(0);
  @$pb.TagNumber(1)
  void clearAmount() => clearField(1);
}

class CalculateDepositFeeResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CalculateDepositFeeResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errorCode')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errorMessage')
    ..aInt64(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount')
    ..aInt64(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fee')
    ..aInt64(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'netAmount')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..hasRequiredFields = false
  ;

  CalculateDepositFeeResponse._() : super();
  factory CalculateDepositFeeResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
    $fixnum.Int64? amount,
    $fixnum.Int64? fee,
    $fixnum.Int64? netAmount,
    $core.String? currency,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (errorCode != null) {
      _result.errorCode = errorCode;
    }
    if (errorMessage != null) {
      _result.errorMessage = errorMessage;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (fee != null) {
      _result.fee = fee;
    }
    if (netAmount != null) {
      _result.netAmount = netAmount;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    return _result;
  }
  factory CalculateDepositFeeResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CalculateDepositFeeResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CalculateDepositFeeResponse clone() => CalculateDepositFeeResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CalculateDepositFeeResponse copyWith(void Function(CalculateDepositFeeResponse) updates) => super.copyWith((message) => updates(message as CalculateDepositFeeResponse)) as CalculateDepositFeeResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CalculateDepositFeeResponse create() => CalculateDepositFeeResponse._();
  CalculateDepositFeeResponse createEmptyInstance() => create();
  static $pb.PbList<CalculateDepositFeeResponse> createRepeated() => $pb.PbList<CalculateDepositFeeResponse>();
  @$core.pragma('dart2js:noInline')
  static CalculateDepositFeeResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CalculateDepositFeeResponse>(create);
  static CalculateDepositFeeResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get amount => $_getI64(3);
  @$pb.TagNumber(4)
  set amount($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearAmount() => clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get fee => $_getI64(4);
  @$pb.TagNumber(5)
  set fee($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasFee() => $_has(4);
  @$pb.TagNumber(5)
  void clearFee() => clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get netAmount => $_getI64(5);
  @$pb.TagNumber(6)
  set netAmount($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasNetAmount() => $_has(5);
  @$pb.TagNumber(6)
  void clearNetAmount() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get currency => $_getSZ(6);
  @$pb.TagNumber(7)
  set currency($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasCurrency() => $_has(6);
  @$pb.TagNumber(7)
  void clearCurrency() => clearField(7);
}

class InitiateWithdrawalRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'InitiateWithdrawalRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sourceAccountId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bankCode')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountNumber')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountName')
    ..aInt64(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'narration')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'idempotencyKey')
    ..hasRequiredFields = false
  ;

  InitiateWithdrawalRequest._() : super();
  factory InitiateWithdrawalRequest({
    $core.String? userId,
    $core.String? sourceAccountId,
    $core.String? bankCode,
    $core.String? accountNumber,
    $core.String? accountName,
    $fixnum.Int64? amount,
    $core.String? narration,
    $core.String? idempotencyKey,
  }) {
    final _result = create();
    if (userId != null) {
      _result.userId = userId;
    }
    if (sourceAccountId != null) {
      _result.sourceAccountId = sourceAccountId;
    }
    if (bankCode != null) {
      _result.bankCode = bankCode;
    }
    if (accountNumber != null) {
      _result.accountNumber = accountNumber;
    }
    if (accountName != null) {
      _result.accountName = accountName;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (narration != null) {
      _result.narration = narration;
    }
    if (idempotencyKey != null) {
      _result.idempotencyKey = idempotencyKey;
    }
    return _result;
  }
  factory InitiateWithdrawalRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InitiateWithdrawalRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InitiateWithdrawalRequest clone() => InitiateWithdrawalRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InitiateWithdrawalRequest copyWith(void Function(InitiateWithdrawalRequest) updates) => super.copyWith((message) => updates(message as InitiateWithdrawalRequest)) as InitiateWithdrawalRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static InitiateWithdrawalRequest create() => InitiateWithdrawalRequest._();
  InitiateWithdrawalRequest createEmptyInstance() => create();
  static $pb.PbList<InitiateWithdrawalRequest> createRepeated() => $pb.PbList<InitiateWithdrawalRequest>();
  @$core.pragma('dart2js:noInline')
  static InitiateWithdrawalRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InitiateWithdrawalRequest>(create);
  static InitiateWithdrawalRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get sourceAccountId => $_getSZ(1);
  @$pb.TagNumber(2)
  set sourceAccountId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSourceAccountId() => $_has(1);
  @$pb.TagNumber(2)
  void clearSourceAccountId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get bankCode => $_getSZ(2);
  @$pb.TagNumber(3)
  set bankCode($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasBankCode() => $_has(2);
  @$pb.TagNumber(3)
  void clearBankCode() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get accountNumber => $_getSZ(3);
  @$pb.TagNumber(4)
  set accountNumber($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasAccountNumber() => $_has(3);
  @$pb.TagNumber(4)
  void clearAccountNumber() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get accountName => $_getSZ(4);
  @$pb.TagNumber(5)
  set accountName($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasAccountName() => $_has(4);
  @$pb.TagNumber(5)
  void clearAccountName() => clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get amount => $_getI64(5);
  @$pb.TagNumber(6)
  set amount($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasAmount() => $_has(5);
  @$pb.TagNumber(6)
  void clearAmount() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get narration => $_getSZ(6);
  @$pb.TagNumber(7)
  set narration($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasNarration() => $_has(6);
  @$pb.TagNumber(7)
  void clearNarration() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get idempotencyKey => $_getSZ(7);
  @$pb.TagNumber(8)
  set idempotencyKey($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasIdempotencyKey() => $_has(7);
  @$pb.TagNumber(8)
  void clearIdempotencyKey() => clearField(8);
}

class WithdrawalResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'WithdrawalResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errorCode')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errorMessage')
    ..aOM<Withdrawal>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'withdrawal', subBuilder: Withdrawal.create)
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  WithdrawalResponse._() : super();
  factory WithdrawalResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
    Withdrawal? withdrawal,
    $core.String? message,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (errorCode != null) {
      _result.errorCode = errorCode;
    }
    if (errorMessage != null) {
      _result.errorMessage = errorMessage;
    }
    if (withdrawal != null) {
      _result.withdrawal = withdrawal;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory WithdrawalResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WithdrawalResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  WithdrawalResponse clone() => WithdrawalResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  WithdrawalResponse copyWith(void Function(WithdrawalResponse) updates) => super.copyWith((message) => updates(message as WithdrawalResponse)) as WithdrawalResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static WithdrawalResponse create() => WithdrawalResponse._();
  WithdrawalResponse createEmptyInstance() => create();
  static $pb.PbList<WithdrawalResponse> createRepeated() => $pb.PbList<WithdrawalResponse>();
  @$core.pragma('dart2js:noInline')
  static WithdrawalResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WithdrawalResponse>(create);
  static WithdrawalResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => clearField(3);

  @$pb.TagNumber(4)
  Withdrawal get withdrawal => $_getN(3);
  @$pb.TagNumber(4)
  set withdrawal(Withdrawal v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasWithdrawal() => $_has(3);
  @$pb.TagNumber(4)
  void clearWithdrawal() => clearField(4);
  @$pb.TagNumber(4)
  Withdrawal ensureWithdrawal() => $_ensure(3);

  @$pb.TagNumber(5)
  $core.String get message => $_getSZ(4);
  @$pb.TagNumber(5)
  set message($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasMessage() => $_has(4);
  @$pb.TagNumber(5)
  void clearMessage() => clearField(5);
}

class Withdrawal extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Withdrawal', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sourceAccountId')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'destinationBankCode')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'destinationBankName')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'destinationAccount')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'destinationName')
    ..aInt64(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount')
    ..aInt64(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fee')
    ..aInt64(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalAmount')
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOS(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..aOS(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reference')
    ..aOS(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'narration')
    ..aOS(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'failureCode')
    ..aOS(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'failureReason')
    ..aOM<$1.Timestamp>(17, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(18, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'completedAt', subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false
  ;

  Withdrawal._() : super();
  factory Withdrawal({
    $core.String? id,
    $core.String? userId,
    $core.String? sourceAccountId,
    $core.String? destinationBankCode,
    $core.String? destinationBankName,
    $core.String? destinationAccount,
    $core.String? destinationName,
    $fixnum.Int64? amount,
    $fixnum.Int64? fee,
    $fixnum.Int64? totalAmount,
    $core.String? currency,
    $core.String? status,
    $core.String? reference,
    $core.String? narration,
    $core.String? failureCode,
    $core.String? failureReason,
    $1.Timestamp? createdAt,
    $1.Timestamp? completedAt,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    if (sourceAccountId != null) {
      _result.sourceAccountId = sourceAccountId;
    }
    if (destinationBankCode != null) {
      _result.destinationBankCode = destinationBankCode;
    }
    if (destinationBankName != null) {
      _result.destinationBankName = destinationBankName;
    }
    if (destinationAccount != null) {
      _result.destinationAccount = destinationAccount;
    }
    if (destinationName != null) {
      _result.destinationName = destinationName;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (fee != null) {
      _result.fee = fee;
    }
    if (totalAmount != null) {
      _result.totalAmount = totalAmount;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (status != null) {
      _result.status = status;
    }
    if (reference != null) {
      _result.reference = reference;
    }
    if (narration != null) {
      _result.narration = narration;
    }
    if (failureCode != null) {
      _result.failureCode = failureCode;
    }
    if (failureReason != null) {
      _result.failureReason = failureReason;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (completedAt != null) {
      _result.completedAt = completedAt;
    }
    return _result;
  }
  factory Withdrawal.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Withdrawal.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Withdrawal clone() => Withdrawal()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Withdrawal copyWith(void Function(Withdrawal) updates) => super.copyWith((message) => updates(message as Withdrawal)) as Withdrawal; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Withdrawal create() => Withdrawal._();
  Withdrawal createEmptyInstance() => create();
  static $pb.PbList<Withdrawal> createRepeated() => $pb.PbList<Withdrawal>();
  @$core.pragma('dart2js:noInline')
  static Withdrawal getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Withdrawal>(create);
  static Withdrawal? _defaultInstance;

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
  $core.String get sourceAccountId => $_getSZ(2);
  @$pb.TagNumber(3)
  set sourceAccountId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSourceAccountId() => $_has(2);
  @$pb.TagNumber(3)
  void clearSourceAccountId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get destinationBankCode => $_getSZ(3);
  @$pb.TagNumber(4)
  set destinationBankCode($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasDestinationBankCode() => $_has(3);
  @$pb.TagNumber(4)
  void clearDestinationBankCode() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get destinationBankName => $_getSZ(4);
  @$pb.TagNumber(5)
  set destinationBankName($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasDestinationBankName() => $_has(4);
  @$pb.TagNumber(5)
  void clearDestinationBankName() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get destinationAccount => $_getSZ(5);
  @$pb.TagNumber(6)
  set destinationAccount($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasDestinationAccount() => $_has(5);
  @$pb.TagNumber(6)
  void clearDestinationAccount() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get destinationName => $_getSZ(6);
  @$pb.TagNumber(7)
  set destinationName($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasDestinationName() => $_has(6);
  @$pb.TagNumber(7)
  void clearDestinationName() => clearField(7);

  @$pb.TagNumber(8)
  $fixnum.Int64 get amount => $_getI64(7);
  @$pb.TagNumber(8)
  set amount($fixnum.Int64 v) { $_setInt64(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasAmount() => $_has(7);
  @$pb.TagNumber(8)
  void clearAmount() => clearField(8);

  @$pb.TagNumber(9)
  $fixnum.Int64 get fee => $_getI64(8);
  @$pb.TagNumber(9)
  set fee($fixnum.Int64 v) { $_setInt64(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasFee() => $_has(8);
  @$pb.TagNumber(9)
  void clearFee() => clearField(9);

  @$pb.TagNumber(10)
  $fixnum.Int64 get totalAmount => $_getI64(9);
  @$pb.TagNumber(10)
  set totalAmount($fixnum.Int64 v) { $_setInt64(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasTotalAmount() => $_has(9);
  @$pb.TagNumber(10)
  void clearTotalAmount() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get currency => $_getSZ(10);
  @$pb.TagNumber(11)
  set currency($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasCurrency() => $_has(10);
  @$pb.TagNumber(11)
  void clearCurrency() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get status => $_getSZ(11);
  @$pb.TagNumber(12)
  set status($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasStatus() => $_has(11);
  @$pb.TagNumber(12)
  void clearStatus() => clearField(12);

  @$pb.TagNumber(13)
  $core.String get reference => $_getSZ(12);
  @$pb.TagNumber(13)
  set reference($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasReference() => $_has(12);
  @$pb.TagNumber(13)
  void clearReference() => clearField(13);

  @$pb.TagNumber(14)
  $core.String get narration => $_getSZ(13);
  @$pb.TagNumber(14)
  set narration($core.String v) { $_setString(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasNarration() => $_has(13);
  @$pb.TagNumber(14)
  void clearNarration() => clearField(14);

  @$pb.TagNumber(15)
  $core.String get failureCode => $_getSZ(14);
  @$pb.TagNumber(15)
  set failureCode($core.String v) { $_setString(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasFailureCode() => $_has(14);
  @$pb.TagNumber(15)
  void clearFailureCode() => clearField(15);

  @$pb.TagNumber(16)
  $core.String get failureReason => $_getSZ(15);
  @$pb.TagNumber(16)
  set failureReason($core.String v) { $_setString(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasFailureReason() => $_has(15);
  @$pb.TagNumber(16)
  void clearFailureReason() => clearField(16);

  @$pb.TagNumber(17)
  $1.Timestamp get createdAt => $_getN(16);
  @$pb.TagNumber(17)
  set createdAt($1.Timestamp v) { setField(17, v); }
  @$pb.TagNumber(17)
  $core.bool hasCreatedAt() => $_has(16);
  @$pb.TagNumber(17)
  void clearCreatedAt() => clearField(17);
  @$pb.TagNumber(17)
  $1.Timestamp ensureCreatedAt() => $_ensure(16);

  @$pb.TagNumber(18)
  $1.Timestamp get completedAt => $_getN(17);
  @$pb.TagNumber(18)
  set completedAt($1.Timestamp v) { setField(18, v); }
  @$pb.TagNumber(18)
  $core.bool hasCompletedAt() => $_has(17);
  @$pb.TagNumber(18)
  void clearCompletedAt() => clearField(18);
  @$pb.TagNumber(18)
  $1.Timestamp ensureCompletedAt() => $_ensure(17);
}

class GetWithdrawalStatusRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetWithdrawalStatusRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'withdrawalId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..hasRequiredFields = false
  ;

  GetWithdrawalStatusRequest._() : super();
  factory GetWithdrawalStatusRequest({
    $core.String? withdrawalId,
    $core.String? userId,
  }) {
    final _result = create();
    if (withdrawalId != null) {
      _result.withdrawalId = withdrawalId;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    return _result;
  }
  factory GetWithdrawalStatusRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetWithdrawalStatusRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetWithdrawalStatusRequest clone() => GetWithdrawalStatusRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetWithdrawalStatusRequest copyWith(void Function(GetWithdrawalStatusRequest) updates) => super.copyWith((message) => updates(message as GetWithdrawalStatusRequest)) as GetWithdrawalStatusRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetWithdrawalStatusRequest create() => GetWithdrawalStatusRequest._();
  GetWithdrawalStatusRequest createEmptyInstance() => create();
  static $pb.PbList<GetWithdrawalStatusRequest> createRepeated() => $pb.PbList<GetWithdrawalStatusRequest>();
  @$core.pragma('dart2js:noInline')
  static GetWithdrawalStatusRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetWithdrawalStatusRequest>(create);
  static GetWithdrawalStatusRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get withdrawalId => $_getSZ(0);
  @$pb.TagNumber(1)
  set withdrawalId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasWithdrawalId() => $_has(0);
  @$pb.TagNumber(1)
  void clearWithdrawalId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => clearField(2);
}

class GetUserWithdrawalsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetUserWithdrawalsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetUserWithdrawalsRequest._() : super();
  factory GetUserWithdrawalsRequest({
    $core.String? userId,
    $core.int? limit,
    $core.int? offset,
  }) {
    final _result = create();
    if (userId != null) {
      _result.userId = userId;
    }
    if (limit != null) {
      _result.limit = limit;
    }
    if (offset != null) {
      _result.offset = offset;
    }
    return _result;
  }
  factory GetUserWithdrawalsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUserWithdrawalsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUserWithdrawalsRequest clone() => GetUserWithdrawalsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUserWithdrawalsRequest copyWith(void Function(GetUserWithdrawalsRequest) updates) => super.copyWith((message) => updates(message as GetUserWithdrawalsRequest)) as GetUserWithdrawalsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetUserWithdrawalsRequest create() => GetUserWithdrawalsRequest._();
  GetUserWithdrawalsRequest createEmptyInstance() => create();
  static $pb.PbList<GetUserWithdrawalsRequest> createRepeated() => $pb.PbList<GetUserWithdrawalsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetUserWithdrawalsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetUserWithdrawalsRequest>(create);
  static GetUserWithdrawalsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

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

class WithdrawalsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'WithdrawalsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errorCode')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errorMessage')
    ..pc<Withdrawal>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'withdrawals', $pb.PbFieldType.PM, subBuilder: Withdrawal.create)
    ..a<$core.int>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  WithdrawalsResponse._() : super();
  factory WithdrawalsResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
    $core.Iterable<Withdrawal>? withdrawals,
    $core.int? total,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (errorCode != null) {
      _result.errorCode = errorCode;
    }
    if (errorMessage != null) {
      _result.errorMessage = errorMessage;
    }
    if (withdrawals != null) {
      _result.withdrawals.addAll(withdrawals);
    }
    if (total != null) {
      _result.total = total;
    }
    return _result;
  }
  factory WithdrawalsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WithdrawalsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  WithdrawalsResponse clone() => WithdrawalsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  WithdrawalsResponse copyWith(void Function(WithdrawalsResponse) updates) => super.copyWith((message) => updates(message as WithdrawalsResponse)) as WithdrawalsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static WithdrawalsResponse create() => WithdrawalsResponse._();
  WithdrawalsResponse createEmptyInstance() => create();
  static $pb.PbList<WithdrawalsResponse> createRepeated() => $pb.PbList<WithdrawalsResponse>();
  @$core.pragma('dart2js:noInline')
  static WithdrawalsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WithdrawalsResponse>(create);
  static WithdrawalsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<Withdrawal> get withdrawals => $_getList(3);

  @$pb.TagNumber(5)
  $core.int get total => $_getIZ(4);
  @$pb.TagNumber(5)
  set total($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTotal() => $_has(4);
  @$pb.TagNumber(5)
  void clearTotal() => clearField(5);
}

class CalculateWithdrawalFeeRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CalculateWithdrawalFeeRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aInt64(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount')
    ..hasRequiredFields = false
  ;

  CalculateWithdrawalFeeRequest._() : super();
  factory CalculateWithdrawalFeeRequest({
    $fixnum.Int64? amount,
  }) {
    final _result = create();
    if (amount != null) {
      _result.amount = amount;
    }
    return _result;
  }
  factory CalculateWithdrawalFeeRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CalculateWithdrawalFeeRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CalculateWithdrawalFeeRequest clone() => CalculateWithdrawalFeeRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CalculateWithdrawalFeeRequest copyWith(void Function(CalculateWithdrawalFeeRequest) updates) => super.copyWith((message) => updates(message as CalculateWithdrawalFeeRequest)) as CalculateWithdrawalFeeRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CalculateWithdrawalFeeRequest create() => CalculateWithdrawalFeeRequest._();
  CalculateWithdrawalFeeRequest createEmptyInstance() => create();
  static $pb.PbList<CalculateWithdrawalFeeRequest> createRepeated() => $pb.PbList<CalculateWithdrawalFeeRequest>();
  @$core.pragma('dart2js:noInline')
  static CalculateWithdrawalFeeRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CalculateWithdrawalFeeRequest>(create);
  static CalculateWithdrawalFeeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get amount => $_getI64(0);
  @$pb.TagNumber(1)
  set amount($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAmount() => $_has(0);
  @$pb.TagNumber(1)
  void clearAmount() => clearField(1);
}

class CalculateWithdrawalFeeResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CalculateWithdrawalFeeResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errorCode')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errorMessage')
    ..aInt64(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount')
    ..aInt64(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fee')
    ..aInt64(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalDebit')
    ..aInt64(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'minAmount')
    ..aInt64(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'maxAmount')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..hasRequiredFields = false
  ;

  CalculateWithdrawalFeeResponse._() : super();
  factory CalculateWithdrawalFeeResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
    $fixnum.Int64? amount,
    $fixnum.Int64? fee,
    $fixnum.Int64? totalDebit,
    $fixnum.Int64? minAmount,
    $fixnum.Int64? maxAmount,
    $core.String? currency,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (errorCode != null) {
      _result.errorCode = errorCode;
    }
    if (errorMessage != null) {
      _result.errorMessage = errorMessage;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (fee != null) {
      _result.fee = fee;
    }
    if (totalDebit != null) {
      _result.totalDebit = totalDebit;
    }
    if (minAmount != null) {
      _result.minAmount = minAmount;
    }
    if (maxAmount != null) {
      _result.maxAmount = maxAmount;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    return _result;
  }
  factory CalculateWithdrawalFeeResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CalculateWithdrawalFeeResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CalculateWithdrawalFeeResponse clone() => CalculateWithdrawalFeeResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CalculateWithdrawalFeeResponse copyWith(void Function(CalculateWithdrawalFeeResponse) updates) => super.copyWith((message) => updates(message as CalculateWithdrawalFeeResponse)) as CalculateWithdrawalFeeResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CalculateWithdrawalFeeResponse create() => CalculateWithdrawalFeeResponse._();
  CalculateWithdrawalFeeResponse createEmptyInstance() => create();
  static $pb.PbList<CalculateWithdrawalFeeResponse> createRepeated() => $pb.PbList<CalculateWithdrawalFeeResponse>();
  @$core.pragma('dart2js:noInline')
  static CalculateWithdrawalFeeResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CalculateWithdrawalFeeResponse>(create);
  static CalculateWithdrawalFeeResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get amount => $_getI64(3);
  @$pb.TagNumber(4)
  set amount($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearAmount() => clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get fee => $_getI64(4);
  @$pb.TagNumber(5)
  set fee($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasFee() => $_has(4);
  @$pb.TagNumber(5)
  void clearFee() => clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get totalDebit => $_getI64(5);
  @$pb.TagNumber(6)
  set totalDebit($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasTotalDebit() => $_has(5);
  @$pb.TagNumber(6)
  void clearTotalDebit() => clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get minAmount => $_getI64(6);
  @$pb.TagNumber(7)
  set minAmount($fixnum.Int64 v) { $_setInt64(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasMinAmount() => $_has(6);
  @$pb.TagNumber(7)
  void clearMinAmount() => clearField(7);

  @$pb.TagNumber(8)
  $fixnum.Int64 get maxAmount => $_getI64(7);
  @$pb.TagNumber(8)
  set maxAmount($fixnum.Int64 v) { $_setInt64(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasMaxAmount() => $_has(7);
  @$pb.TagNumber(8)
  void clearMaxAmount() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get currency => $_getSZ(8);
  @$pb.TagNumber(9)
  set currency($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasCurrency() => $_has(8);
  @$pb.TagNumber(9)
  void clearCurrency() => clearField(9);
}

class ResolveAccountNameRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ResolveAccountNameRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountNumber')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bankCode')
    ..hasRequiredFields = false
  ;

  ResolveAccountNameRequest._() : super();
  factory ResolveAccountNameRequest({
    $core.String? accountNumber,
    $core.String? bankCode,
  }) {
    final _result = create();
    if (accountNumber != null) {
      _result.accountNumber = accountNumber;
    }
    if (bankCode != null) {
      _result.bankCode = bankCode;
    }
    return _result;
  }
  factory ResolveAccountNameRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ResolveAccountNameRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ResolveAccountNameRequest clone() => ResolveAccountNameRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ResolveAccountNameRequest copyWith(void Function(ResolveAccountNameRequest) updates) => super.copyWith((message) => updates(message as ResolveAccountNameRequest)) as ResolveAccountNameRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ResolveAccountNameRequest create() => ResolveAccountNameRequest._();
  ResolveAccountNameRequest createEmptyInstance() => create();
  static $pb.PbList<ResolveAccountNameRequest> createRepeated() => $pb.PbList<ResolveAccountNameRequest>();
  @$core.pragma('dart2js:noInline')
  static ResolveAccountNameRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ResolveAccountNameRequest>(create);
  static ResolveAccountNameRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountNumber => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountNumber($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccountNumber() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountNumber() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get bankCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set bankCode($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasBankCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearBankCode() => clearField(2);
}

class ResolveAccountNameResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ResolveAccountNameResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errorCode')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errorMessage')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountNumber')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountName')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bankCode')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bankName')
    ..hasRequiredFields = false
  ;

  ResolveAccountNameResponse._() : super();
  factory ResolveAccountNameResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
    $core.String? accountNumber,
    $core.String? accountName,
    $core.String? bankCode,
    $core.String? bankName,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (errorCode != null) {
      _result.errorCode = errorCode;
    }
    if (errorMessage != null) {
      _result.errorMessage = errorMessage;
    }
    if (accountNumber != null) {
      _result.accountNumber = accountNumber;
    }
    if (accountName != null) {
      _result.accountName = accountName;
    }
    if (bankCode != null) {
      _result.bankCode = bankCode;
    }
    if (bankName != null) {
      _result.bankName = bankName;
    }
    return _result;
  }
  factory ResolveAccountNameResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ResolveAccountNameResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ResolveAccountNameResponse clone() => ResolveAccountNameResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ResolveAccountNameResponse copyWith(void Function(ResolveAccountNameResponse) updates) => super.copyWith((message) => updates(message as ResolveAccountNameResponse)) as ResolveAccountNameResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ResolveAccountNameResponse create() => ResolveAccountNameResponse._();
  ResolveAccountNameResponse createEmptyInstance() => create();
  static $pb.PbList<ResolveAccountNameResponse> createRepeated() => $pb.PbList<ResolveAccountNameResponse>();
  @$core.pragma('dart2js:noInline')
  static ResolveAccountNameResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ResolveAccountNameResponse>(create);
  static ResolveAccountNameResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get accountNumber => $_getSZ(3);
  @$pb.TagNumber(4)
  set accountNumber($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasAccountNumber() => $_has(3);
  @$pb.TagNumber(4)
  void clearAccountNumber() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get accountName => $_getSZ(4);
  @$pb.TagNumber(5)
  set accountName($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasAccountName() => $_has(4);
  @$pb.TagNumber(5)
  void clearAccountName() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get bankCode => $_getSZ(5);
  @$pb.TagNumber(6)
  set bankCode($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasBankCode() => $_has(5);
  @$pb.TagNumber(6)
  void clearBankCode() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get bankName => $_getSZ(6);
  @$pb.TagNumber(7)
  set bankName($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasBankName() => $_has(6);
  @$pb.TagNumber(7)
  void clearBankName() => clearField(7);
}

class CreateMandateRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateMandateRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'linkedAccountId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'mandateType')
    ..aInt64(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amountLimit')
    ..a<$core.int>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'debitLimit', $pb.PbFieldType.O3)
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'startDate')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'endDate')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..hasRequiredFields = false
  ;

  CreateMandateRequest._() : super();
  factory CreateMandateRequest({
    $core.String? userId,
    $core.String? linkedAccountId,
    $core.String? mandateType,
    $fixnum.Int64? amountLimit,
    $core.int? debitLimit,
    $core.String? startDate,
    $core.String? endDate,
    $core.String? description,
  }) {
    final _result = create();
    if (userId != null) {
      _result.userId = userId;
    }
    if (linkedAccountId != null) {
      _result.linkedAccountId = linkedAccountId;
    }
    if (mandateType != null) {
      _result.mandateType = mandateType;
    }
    if (amountLimit != null) {
      _result.amountLimit = amountLimit;
    }
    if (debitLimit != null) {
      _result.debitLimit = debitLimit;
    }
    if (startDate != null) {
      _result.startDate = startDate;
    }
    if (endDate != null) {
      _result.endDate = endDate;
    }
    if (description != null) {
      _result.description = description;
    }
    return _result;
  }
  factory CreateMandateRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateMandateRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateMandateRequest clone() => CreateMandateRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateMandateRequest copyWith(void Function(CreateMandateRequest) updates) => super.copyWith((message) => updates(message as CreateMandateRequest)) as CreateMandateRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateMandateRequest create() => CreateMandateRequest._();
  CreateMandateRequest createEmptyInstance() => create();
  static $pb.PbList<CreateMandateRequest> createRepeated() => $pb.PbList<CreateMandateRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateMandateRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateMandateRequest>(create);
  static CreateMandateRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get linkedAccountId => $_getSZ(1);
  @$pb.TagNumber(2)
  set linkedAccountId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLinkedAccountId() => $_has(1);
  @$pb.TagNumber(2)
  void clearLinkedAccountId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get mandateType => $_getSZ(2);
  @$pb.TagNumber(3)
  set mandateType($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMandateType() => $_has(2);
  @$pb.TagNumber(3)
  void clearMandateType() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get amountLimit => $_getI64(3);
  @$pb.TagNumber(4)
  set amountLimit($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasAmountLimit() => $_has(3);
  @$pb.TagNumber(4)
  void clearAmountLimit() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get debitLimit => $_getIZ(4);
  @$pb.TagNumber(5)
  set debitLimit($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasDebitLimit() => $_has(4);
  @$pb.TagNumber(5)
  void clearDebitLimit() => clearField(5);

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

  @$pb.TagNumber(8)
  $core.String get description => $_getSZ(7);
  @$pb.TagNumber(8)
  set description($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasDescription() => $_has(7);
  @$pb.TagNumber(8)
  void clearDescription() => clearField(8);
}

class MandateResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MandateResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errorCode')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errorMessage')
    ..aOM<DirectDebitMandate>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'mandate', subBuilder: DirectDebitMandate.create)
    ..aOB(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'needsAuthorization')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'authorizationUrl')
    ..hasRequiredFields = false
  ;

  MandateResponse._() : super();
  factory MandateResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
    DirectDebitMandate? mandate,
    $core.bool? needsAuthorization,
    $core.String? authorizationUrl,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (errorCode != null) {
      _result.errorCode = errorCode;
    }
    if (errorMessage != null) {
      _result.errorMessage = errorMessage;
    }
    if (mandate != null) {
      _result.mandate = mandate;
    }
    if (needsAuthorization != null) {
      _result.needsAuthorization = needsAuthorization;
    }
    if (authorizationUrl != null) {
      _result.authorizationUrl = authorizationUrl;
    }
    return _result;
  }
  factory MandateResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MandateResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MandateResponse clone() => MandateResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MandateResponse copyWith(void Function(MandateResponse) updates) => super.copyWith((message) => updates(message as MandateResponse)) as MandateResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MandateResponse create() => MandateResponse._();
  MandateResponse createEmptyInstance() => create();
  static $pb.PbList<MandateResponse> createRepeated() => $pb.PbList<MandateResponse>();
  @$core.pragma('dart2js:noInline')
  static MandateResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MandateResponse>(create);
  static MandateResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => clearField(3);

  @$pb.TagNumber(4)
  DirectDebitMandate get mandate => $_getN(3);
  @$pb.TagNumber(4)
  set mandate(DirectDebitMandate v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasMandate() => $_has(3);
  @$pb.TagNumber(4)
  void clearMandate() => clearField(4);
  @$pb.TagNumber(4)
  DirectDebitMandate ensureMandate() => $_ensure(3);

  @$pb.TagNumber(5)
  $core.bool get needsAuthorization => $_getBF(4);
  @$pb.TagNumber(5)
  set needsAuthorization($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasNeedsAuthorization() => $_has(4);
  @$pb.TagNumber(5)
  void clearNeedsAuthorization() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get authorizationUrl => $_getSZ(5);
  @$pb.TagNumber(6)
  set authorizationUrl($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasAuthorizationUrl() => $_has(5);
  @$pb.TagNumber(6)
  void clearAuthorizationUrl() => clearField(6);
}

class MandatesResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MandatesResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errorCode')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errorMessage')
    ..pc<DirectDebitMandate>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'mandates', $pb.PbFieldType.PM, subBuilder: DirectDebitMandate.create)
    ..a<$core.int>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  MandatesResponse._() : super();
  factory MandatesResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
    $core.Iterable<DirectDebitMandate>? mandates,
    $core.int? total,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (errorCode != null) {
      _result.errorCode = errorCode;
    }
    if (errorMessage != null) {
      _result.errorMessage = errorMessage;
    }
    if (mandates != null) {
      _result.mandates.addAll(mandates);
    }
    if (total != null) {
      _result.total = total;
    }
    return _result;
  }
  factory MandatesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MandatesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MandatesResponse clone() => MandatesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MandatesResponse copyWith(void Function(MandatesResponse) updates) => super.copyWith((message) => updates(message as MandatesResponse)) as MandatesResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MandatesResponse create() => MandatesResponse._();
  MandatesResponse createEmptyInstance() => create();
  static $pb.PbList<MandatesResponse> createRepeated() => $pb.PbList<MandatesResponse>();
  @$core.pragma('dart2js:noInline')
  static MandatesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MandatesResponse>(create);
  static MandatesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<DirectDebitMandate> get mandates => $_getList(3);

  @$pb.TagNumber(5)
  $core.int get total => $_getIZ(4);
  @$pb.TagNumber(5)
  set total($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTotal() => $_has(4);
  @$pb.TagNumber(5)
  void clearTotal() => clearField(5);
}

class DirectDebitMandate extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DirectDebitMandate', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'monoMandateId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'linkedAccountId')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'monoCustomerId')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bankName')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bankCode')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountNumber')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountName')
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'mandateType')
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..aInt64(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amountLimit')
    ..a<$core.int>(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'debitLimit', $pb.PbFieldType.O3)
    ..a<$core.int>(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'debitCount', $pb.PbFieldType.O3)
    ..aInt64(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalDebited')
    ..aOM<$1.Timestamp>(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'startDate', subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(17, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'endDate', subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(18, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(19, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'authorizedAt', subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(20, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'readyAt', subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(21, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lastDebitAt', subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(22, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cancelledAt', subBuilder: $1.Timestamp.create)
    ..aOS(23, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reference')
    ..aOS(24, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..aOB(25, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'canDebit')
    ..aOB(26, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isExpired')
    ..aInt64(27, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'remainingLimit')
    ..hasRequiredFields = false
  ;

  DirectDebitMandate._() : super();
  factory DirectDebitMandate({
    $core.String? id,
    $core.String? monoMandateId,
    $core.String? userId,
    $core.String? linkedAccountId,
    $core.String? monoCustomerId,
    $core.String? bankName,
    $core.String? bankCode,
    $core.String? accountNumber,
    $core.String? accountName,
    $core.String? mandateType,
    $core.String? status,
    $fixnum.Int64? amountLimit,
    $core.int? debitLimit,
    $core.int? debitCount,
    $fixnum.Int64? totalDebited,
    $1.Timestamp? startDate,
    $1.Timestamp? endDate,
    $1.Timestamp? createdAt,
    $1.Timestamp? authorizedAt,
    $1.Timestamp? readyAt,
    $1.Timestamp? lastDebitAt,
    $1.Timestamp? cancelledAt,
    $core.String? reference,
    $core.String? description,
    $core.bool? canDebit,
    $core.bool? isExpired,
    $fixnum.Int64? remainingLimit,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (monoMandateId != null) {
      _result.monoMandateId = monoMandateId;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    if (linkedAccountId != null) {
      _result.linkedAccountId = linkedAccountId;
    }
    if (monoCustomerId != null) {
      _result.monoCustomerId = monoCustomerId;
    }
    if (bankName != null) {
      _result.bankName = bankName;
    }
    if (bankCode != null) {
      _result.bankCode = bankCode;
    }
    if (accountNumber != null) {
      _result.accountNumber = accountNumber;
    }
    if (accountName != null) {
      _result.accountName = accountName;
    }
    if (mandateType != null) {
      _result.mandateType = mandateType;
    }
    if (status != null) {
      _result.status = status;
    }
    if (amountLimit != null) {
      _result.amountLimit = amountLimit;
    }
    if (debitLimit != null) {
      _result.debitLimit = debitLimit;
    }
    if (debitCount != null) {
      _result.debitCount = debitCount;
    }
    if (totalDebited != null) {
      _result.totalDebited = totalDebited;
    }
    if (startDate != null) {
      _result.startDate = startDate;
    }
    if (endDate != null) {
      _result.endDate = endDate;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (authorizedAt != null) {
      _result.authorizedAt = authorizedAt;
    }
    if (readyAt != null) {
      _result.readyAt = readyAt;
    }
    if (lastDebitAt != null) {
      _result.lastDebitAt = lastDebitAt;
    }
    if (cancelledAt != null) {
      _result.cancelledAt = cancelledAt;
    }
    if (reference != null) {
      _result.reference = reference;
    }
    if (description != null) {
      _result.description = description;
    }
    if (canDebit != null) {
      _result.canDebit = canDebit;
    }
    if (isExpired != null) {
      _result.isExpired = isExpired;
    }
    if (remainingLimit != null) {
      _result.remainingLimit = remainingLimit;
    }
    return _result;
  }
  factory DirectDebitMandate.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DirectDebitMandate.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DirectDebitMandate clone() => DirectDebitMandate()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DirectDebitMandate copyWith(void Function(DirectDebitMandate) updates) => super.copyWith((message) => updates(message as DirectDebitMandate)) as DirectDebitMandate; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DirectDebitMandate create() => DirectDebitMandate._();
  DirectDebitMandate createEmptyInstance() => create();
  static $pb.PbList<DirectDebitMandate> createRepeated() => $pb.PbList<DirectDebitMandate>();
  @$core.pragma('dart2js:noInline')
  static DirectDebitMandate getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DirectDebitMandate>(create);
  static DirectDebitMandate? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get monoMandateId => $_getSZ(1);
  @$pb.TagNumber(2)
  set monoMandateId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMonoMandateId() => $_has(1);
  @$pb.TagNumber(2)
  void clearMonoMandateId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get userId => $_getSZ(2);
  @$pb.TagNumber(3)
  set userId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasUserId() => $_has(2);
  @$pb.TagNumber(3)
  void clearUserId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get linkedAccountId => $_getSZ(3);
  @$pb.TagNumber(4)
  set linkedAccountId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasLinkedAccountId() => $_has(3);
  @$pb.TagNumber(4)
  void clearLinkedAccountId() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get monoCustomerId => $_getSZ(4);
  @$pb.TagNumber(5)
  set monoCustomerId($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasMonoCustomerId() => $_has(4);
  @$pb.TagNumber(5)
  void clearMonoCustomerId() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get bankName => $_getSZ(5);
  @$pb.TagNumber(6)
  set bankName($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasBankName() => $_has(5);
  @$pb.TagNumber(6)
  void clearBankName() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get bankCode => $_getSZ(6);
  @$pb.TagNumber(7)
  set bankCode($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasBankCode() => $_has(6);
  @$pb.TagNumber(7)
  void clearBankCode() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get accountNumber => $_getSZ(7);
  @$pb.TagNumber(8)
  set accountNumber($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasAccountNumber() => $_has(7);
  @$pb.TagNumber(8)
  void clearAccountNumber() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get accountName => $_getSZ(8);
  @$pb.TagNumber(9)
  set accountName($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasAccountName() => $_has(8);
  @$pb.TagNumber(9)
  void clearAccountName() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get mandateType => $_getSZ(9);
  @$pb.TagNumber(10)
  set mandateType($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasMandateType() => $_has(9);
  @$pb.TagNumber(10)
  void clearMandateType() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get status => $_getSZ(10);
  @$pb.TagNumber(11)
  set status($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasStatus() => $_has(10);
  @$pb.TagNumber(11)
  void clearStatus() => clearField(11);

  @$pb.TagNumber(12)
  $fixnum.Int64 get amountLimit => $_getI64(11);
  @$pb.TagNumber(12)
  set amountLimit($fixnum.Int64 v) { $_setInt64(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasAmountLimit() => $_has(11);
  @$pb.TagNumber(12)
  void clearAmountLimit() => clearField(12);

  @$pb.TagNumber(13)
  $core.int get debitLimit => $_getIZ(12);
  @$pb.TagNumber(13)
  set debitLimit($core.int v) { $_setSignedInt32(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasDebitLimit() => $_has(12);
  @$pb.TagNumber(13)
  void clearDebitLimit() => clearField(13);

  @$pb.TagNumber(14)
  $core.int get debitCount => $_getIZ(13);
  @$pb.TagNumber(14)
  set debitCount($core.int v) { $_setSignedInt32(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasDebitCount() => $_has(13);
  @$pb.TagNumber(14)
  void clearDebitCount() => clearField(14);

  @$pb.TagNumber(15)
  $fixnum.Int64 get totalDebited => $_getI64(14);
  @$pb.TagNumber(15)
  set totalDebited($fixnum.Int64 v) { $_setInt64(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasTotalDebited() => $_has(14);
  @$pb.TagNumber(15)
  void clearTotalDebited() => clearField(15);

  @$pb.TagNumber(16)
  $1.Timestamp get startDate => $_getN(15);
  @$pb.TagNumber(16)
  set startDate($1.Timestamp v) { setField(16, v); }
  @$pb.TagNumber(16)
  $core.bool hasStartDate() => $_has(15);
  @$pb.TagNumber(16)
  void clearStartDate() => clearField(16);
  @$pb.TagNumber(16)
  $1.Timestamp ensureStartDate() => $_ensure(15);

  @$pb.TagNumber(17)
  $1.Timestamp get endDate => $_getN(16);
  @$pb.TagNumber(17)
  set endDate($1.Timestamp v) { setField(17, v); }
  @$pb.TagNumber(17)
  $core.bool hasEndDate() => $_has(16);
  @$pb.TagNumber(17)
  void clearEndDate() => clearField(17);
  @$pb.TagNumber(17)
  $1.Timestamp ensureEndDate() => $_ensure(16);

  @$pb.TagNumber(18)
  $1.Timestamp get createdAt => $_getN(17);
  @$pb.TagNumber(18)
  set createdAt($1.Timestamp v) { setField(18, v); }
  @$pb.TagNumber(18)
  $core.bool hasCreatedAt() => $_has(17);
  @$pb.TagNumber(18)
  void clearCreatedAt() => clearField(18);
  @$pb.TagNumber(18)
  $1.Timestamp ensureCreatedAt() => $_ensure(17);

  @$pb.TagNumber(19)
  $1.Timestamp get authorizedAt => $_getN(18);
  @$pb.TagNumber(19)
  set authorizedAt($1.Timestamp v) { setField(19, v); }
  @$pb.TagNumber(19)
  $core.bool hasAuthorizedAt() => $_has(18);
  @$pb.TagNumber(19)
  void clearAuthorizedAt() => clearField(19);
  @$pb.TagNumber(19)
  $1.Timestamp ensureAuthorizedAt() => $_ensure(18);

  @$pb.TagNumber(20)
  $1.Timestamp get readyAt => $_getN(19);
  @$pb.TagNumber(20)
  set readyAt($1.Timestamp v) { setField(20, v); }
  @$pb.TagNumber(20)
  $core.bool hasReadyAt() => $_has(19);
  @$pb.TagNumber(20)
  void clearReadyAt() => clearField(20);
  @$pb.TagNumber(20)
  $1.Timestamp ensureReadyAt() => $_ensure(19);

  @$pb.TagNumber(21)
  $1.Timestamp get lastDebitAt => $_getN(20);
  @$pb.TagNumber(21)
  set lastDebitAt($1.Timestamp v) { setField(21, v); }
  @$pb.TagNumber(21)
  $core.bool hasLastDebitAt() => $_has(20);
  @$pb.TagNumber(21)
  void clearLastDebitAt() => clearField(21);
  @$pb.TagNumber(21)
  $1.Timestamp ensureLastDebitAt() => $_ensure(20);

  @$pb.TagNumber(22)
  $1.Timestamp get cancelledAt => $_getN(21);
  @$pb.TagNumber(22)
  set cancelledAt($1.Timestamp v) { setField(22, v); }
  @$pb.TagNumber(22)
  $core.bool hasCancelledAt() => $_has(21);
  @$pb.TagNumber(22)
  void clearCancelledAt() => clearField(22);
  @$pb.TagNumber(22)
  $1.Timestamp ensureCancelledAt() => $_ensure(21);

  @$pb.TagNumber(23)
  $core.String get reference => $_getSZ(22);
  @$pb.TagNumber(23)
  set reference($core.String v) { $_setString(22, v); }
  @$pb.TagNumber(23)
  $core.bool hasReference() => $_has(22);
  @$pb.TagNumber(23)
  void clearReference() => clearField(23);

  @$pb.TagNumber(24)
  $core.String get description => $_getSZ(23);
  @$pb.TagNumber(24)
  set description($core.String v) { $_setString(23, v); }
  @$pb.TagNumber(24)
  $core.bool hasDescription() => $_has(23);
  @$pb.TagNumber(24)
  void clearDescription() => clearField(24);

  @$pb.TagNumber(25)
  $core.bool get canDebit => $_getBF(24);
  @$pb.TagNumber(25)
  set canDebit($core.bool v) { $_setBool(24, v); }
  @$pb.TagNumber(25)
  $core.bool hasCanDebit() => $_has(24);
  @$pb.TagNumber(25)
  void clearCanDebit() => clearField(25);

  @$pb.TagNumber(26)
  $core.bool get isExpired => $_getBF(25);
  @$pb.TagNumber(26)
  set isExpired($core.bool v) { $_setBool(25, v); }
  @$pb.TagNumber(26)
  $core.bool hasIsExpired() => $_has(25);
  @$pb.TagNumber(26)
  void clearIsExpired() => clearField(26);

  @$pb.TagNumber(27)
  $fixnum.Int64 get remainingLimit => $_getI64(26);
  @$pb.TagNumber(27)
  set remainingLimit($fixnum.Int64 v) { $_setInt64(26, v); }
  @$pb.TagNumber(27)
  $core.bool hasRemainingLimit() => $_has(26);
  @$pb.TagNumber(27)
  void clearRemainingLimit() => clearField(27);
}

class GetMandateRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetMandateRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'mandateId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..hasRequiredFields = false
  ;

  GetMandateRequest._() : super();
  factory GetMandateRequest({
    $core.String? mandateId,
    $core.String? userId,
  }) {
    final _result = create();
    if (mandateId != null) {
      _result.mandateId = mandateId;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    return _result;
  }
  factory GetMandateRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMandateRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMandateRequest clone() => GetMandateRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMandateRequest copyWith(void Function(GetMandateRequest) updates) => super.copyWith((message) => updates(message as GetMandateRequest)) as GetMandateRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetMandateRequest create() => GetMandateRequest._();
  GetMandateRequest createEmptyInstance() => create();
  static $pb.PbList<GetMandateRequest> createRepeated() => $pb.PbList<GetMandateRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMandateRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMandateRequest>(create);
  static GetMandateRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get mandateId => $_getSZ(0);
  @$pb.TagNumber(1)
  set mandateId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMandateId() => $_has(0);
  @$pb.TagNumber(1)
  void clearMandateId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => clearField(2);
}

class GetUserMandatesRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetUserMandatesRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'activeOnly')
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetUserMandatesRequest._() : super();
  factory GetUserMandatesRequest({
    $core.String? userId,
    $core.bool? activeOnly,
    $core.int? limit,
    $core.int? offset,
  }) {
    final _result = create();
    if (userId != null) {
      _result.userId = userId;
    }
    if (activeOnly != null) {
      _result.activeOnly = activeOnly;
    }
    if (limit != null) {
      _result.limit = limit;
    }
    if (offset != null) {
      _result.offset = offset;
    }
    return _result;
  }
  factory GetUserMandatesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUserMandatesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUserMandatesRequest clone() => GetUserMandatesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUserMandatesRequest copyWith(void Function(GetUserMandatesRequest) updates) => super.copyWith((message) => updates(message as GetUserMandatesRequest)) as GetUserMandatesRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetUserMandatesRequest create() => GetUserMandatesRequest._();
  GetUserMandatesRequest createEmptyInstance() => create();
  static $pb.PbList<GetUserMandatesRequest> createRepeated() => $pb.PbList<GetUserMandatesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetUserMandatesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetUserMandatesRequest>(create);
  static GetUserMandatesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get activeOnly => $_getBF(1);
  @$pb.TagNumber(2)
  set activeOnly($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasActiveOnly() => $_has(1);
  @$pb.TagNumber(2)
  void clearActiveOnly() => clearField(2);

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

class PauseMandateRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PauseMandateRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'mandateId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reason')
    ..hasRequiredFields = false
  ;

  PauseMandateRequest._() : super();
  factory PauseMandateRequest({
    $core.String? mandateId,
    $core.String? userId,
    $core.String? reason,
  }) {
    final _result = create();
    if (mandateId != null) {
      _result.mandateId = mandateId;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    if (reason != null) {
      _result.reason = reason;
    }
    return _result;
  }
  factory PauseMandateRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PauseMandateRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PauseMandateRequest clone() => PauseMandateRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PauseMandateRequest copyWith(void Function(PauseMandateRequest) updates) => super.copyWith((message) => updates(message as PauseMandateRequest)) as PauseMandateRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PauseMandateRequest create() => PauseMandateRequest._();
  PauseMandateRequest createEmptyInstance() => create();
  static $pb.PbList<PauseMandateRequest> createRepeated() => $pb.PbList<PauseMandateRequest>();
  @$core.pragma('dart2js:noInline')
  static PauseMandateRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PauseMandateRequest>(create);
  static PauseMandateRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get mandateId => $_getSZ(0);
  @$pb.TagNumber(1)
  set mandateId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMandateId() => $_has(0);
  @$pb.TagNumber(1)
  void clearMandateId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get reason => $_getSZ(2);
  @$pb.TagNumber(3)
  set reason($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasReason() => $_has(2);
  @$pb.TagNumber(3)
  void clearReason() => clearField(3);
}

class PauseMandateResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PauseMandateResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errorCode')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errorMessage')
    ..aOM<DirectDebitMandate>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'mandate', subBuilder: DirectDebitMandate.create)
    ..hasRequiredFields = false
  ;

  PauseMandateResponse._() : super();
  factory PauseMandateResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
    DirectDebitMandate? mandate,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (errorCode != null) {
      _result.errorCode = errorCode;
    }
    if (errorMessage != null) {
      _result.errorMessage = errorMessage;
    }
    if (mandate != null) {
      _result.mandate = mandate;
    }
    return _result;
  }
  factory PauseMandateResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PauseMandateResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PauseMandateResponse clone() => PauseMandateResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PauseMandateResponse copyWith(void Function(PauseMandateResponse) updates) => super.copyWith((message) => updates(message as PauseMandateResponse)) as PauseMandateResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PauseMandateResponse create() => PauseMandateResponse._();
  PauseMandateResponse createEmptyInstance() => create();
  static $pb.PbList<PauseMandateResponse> createRepeated() => $pb.PbList<PauseMandateResponse>();
  @$core.pragma('dart2js:noInline')
  static PauseMandateResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PauseMandateResponse>(create);
  static PauseMandateResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => clearField(3);

  @$pb.TagNumber(4)
  DirectDebitMandate get mandate => $_getN(3);
  @$pb.TagNumber(4)
  set mandate(DirectDebitMandate v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasMandate() => $_has(3);
  @$pb.TagNumber(4)
  void clearMandate() => clearField(4);
  @$pb.TagNumber(4)
  DirectDebitMandate ensureMandate() => $_ensure(3);
}

class ReinstateMandateRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ReinstateMandateRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'mandateId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..hasRequiredFields = false
  ;

  ReinstateMandateRequest._() : super();
  factory ReinstateMandateRequest({
    $core.String? mandateId,
    $core.String? userId,
  }) {
    final _result = create();
    if (mandateId != null) {
      _result.mandateId = mandateId;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    return _result;
  }
  factory ReinstateMandateRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ReinstateMandateRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ReinstateMandateRequest clone() => ReinstateMandateRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ReinstateMandateRequest copyWith(void Function(ReinstateMandateRequest) updates) => super.copyWith((message) => updates(message as ReinstateMandateRequest)) as ReinstateMandateRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ReinstateMandateRequest create() => ReinstateMandateRequest._();
  ReinstateMandateRequest createEmptyInstance() => create();
  static $pb.PbList<ReinstateMandateRequest> createRepeated() => $pb.PbList<ReinstateMandateRequest>();
  @$core.pragma('dart2js:noInline')
  static ReinstateMandateRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ReinstateMandateRequest>(create);
  static ReinstateMandateRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get mandateId => $_getSZ(0);
  @$pb.TagNumber(1)
  set mandateId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMandateId() => $_has(0);
  @$pb.TagNumber(1)
  void clearMandateId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => clearField(2);
}

class ReinstateMandateResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ReinstateMandateResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errorCode')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errorMessage')
    ..aOM<DirectDebitMandate>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'mandate', subBuilder: DirectDebitMandate.create)
    ..hasRequiredFields = false
  ;

  ReinstateMandateResponse._() : super();
  factory ReinstateMandateResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
    DirectDebitMandate? mandate,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (errorCode != null) {
      _result.errorCode = errorCode;
    }
    if (errorMessage != null) {
      _result.errorMessage = errorMessage;
    }
    if (mandate != null) {
      _result.mandate = mandate;
    }
    return _result;
  }
  factory ReinstateMandateResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ReinstateMandateResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ReinstateMandateResponse clone() => ReinstateMandateResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ReinstateMandateResponse copyWith(void Function(ReinstateMandateResponse) updates) => super.copyWith((message) => updates(message as ReinstateMandateResponse)) as ReinstateMandateResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ReinstateMandateResponse create() => ReinstateMandateResponse._();
  ReinstateMandateResponse createEmptyInstance() => create();
  static $pb.PbList<ReinstateMandateResponse> createRepeated() => $pb.PbList<ReinstateMandateResponse>();
  @$core.pragma('dart2js:noInline')
  static ReinstateMandateResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ReinstateMandateResponse>(create);
  static ReinstateMandateResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => clearField(3);

  @$pb.TagNumber(4)
  DirectDebitMandate get mandate => $_getN(3);
  @$pb.TagNumber(4)
  set mandate(DirectDebitMandate v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasMandate() => $_has(3);
  @$pb.TagNumber(4)
  void clearMandate() => clearField(4);
  @$pb.TagNumber(4)
  DirectDebitMandate ensureMandate() => $_ensure(3);
}

class CancelMandateRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CancelMandateRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'mandateId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reason')
    ..hasRequiredFields = false
  ;

  CancelMandateRequest._() : super();
  factory CancelMandateRequest({
    $core.String? mandateId,
    $core.String? userId,
    $core.String? reason,
  }) {
    final _result = create();
    if (mandateId != null) {
      _result.mandateId = mandateId;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    if (reason != null) {
      _result.reason = reason;
    }
    return _result;
  }
  factory CancelMandateRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CancelMandateRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CancelMandateRequest clone() => CancelMandateRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CancelMandateRequest copyWith(void Function(CancelMandateRequest) updates) => super.copyWith((message) => updates(message as CancelMandateRequest)) as CancelMandateRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CancelMandateRequest create() => CancelMandateRequest._();
  CancelMandateRequest createEmptyInstance() => create();
  static $pb.PbList<CancelMandateRequest> createRepeated() => $pb.PbList<CancelMandateRequest>();
  @$core.pragma('dart2js:noInline')
  static CancelMandateRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CancelMandateRequest>(create);
  static CancelMandateRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get mandateId => $_getSZ(0);
  @$pb.TagNumber(1)
  set mandateId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMandateId() => $_has(0);
  @$pb.TagNumber(1)
  void clearMandateId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get reason => $_getSZ(2);
  @$pb.TagNumber(3)
  set reason($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasReason() => $_has(2);
  @$pb.TagNumber(3)
  void clearReason() => clearField(3);
}

class CancelMandateResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CancelMandateResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errorCode')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errorMessage')
    ..hasRequiredFields = false
  ;

  CancelMandateResponse._() : super();
  factory CancelMandateResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (errorCode != null) {
      _result.errorCode = errorCode;
    }
    if (errorMessage != null) {
      _result.errorMessage = errorMessage;
    }
    return _result;
  }
  factory CancelMandateResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CancelMandateResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CancelMandateResponse clone() => CancelMandateResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CancelMandateResponse copyWith(void Function(CancelMandateResponse) updates) => super.copyWith((message) => updates(message as CancelMandateResponse)) as CancelMandateResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CancelMandateResponse create() => CancelMandateResponse._();
  CancelMandateResponse createEmptyInstance() => create();
  static $pb.PbList<CancelMandateResponse> createRepeated() => $pb.PbList<CancelMandateResponse>();
  @$core.pragma('dart2js:noInline')
  static CancelMandateResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CancelMandateResponse>(create);
  static CancelMandateResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => clearField(3);
}

class CheckMandateBalanceRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CheckMandateBalanceRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'mandateId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aInt64(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount')
    ..hasRequiredFields = false
  ;

  CheckMandateBalanceRequest._() : super();
  factory CheckMandateBalanceRequest({
    $core.String? mandateId,
    $core.String? userId,
    $fixnum.Int64? amount,
  }) {
    final _result = create();
    if (mandateId != null) {
      _result.mandateId = mandateId;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    return _result;
  }
  factory CheckMandateBalanceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CheckMandateBalanceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CheckMandateBalanceRequest clone() => CheckMandateBalanceRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CheckMandateBalanceRequest copyWith(void Function(CheckMandateBalanceRequest) updates) => super.copyWith((message) => updates(message as CheckMandateBalanceRequest)) as CheckMandateBalanceRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CheckMandateBalanceRequest create() => CheckMandateBalanceRequest._();
  CheckMandateBalanceRequest createEmptyInstance() => create();
  static $pb.PbList<CheckMandateBalanceRequest> createRepeated() => $pb.PbList<CheckMandateBalanceRequest>();
  @$core.pragma('dart2js:noInline')
  static CheckMandateBalanceRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CheckMandateBalanceRequest>(create);
  static CheckMandateBalanceRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get mandateId => $_getSZ(0);
  @$pb.TagNumber(1)
  set mandateId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMandateId() => $_has(0);
  @$pb.TagNumber(1)
  void clearMandateId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get amount => $_getI64(2);
  @$pb.TagNumber(3)
  set amount($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => clearField(3);
}

class CheckMandateBalanceResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CheckMandateBalanceResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'banking'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errorCode')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errorMessage')
    ..aInt64(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'availableBalance')
    ..aOB(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sufficientFunds')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOM<$1.Timestamp>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'checkedAt', subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false
  ;

  CheckMandateBalanceResponse._() : super();
  factory CheckMandateBalanceResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
    $fixnum.Int64? availableBalance,
    $core.bool? sufficientFunds,
    $core.String? currency,
    $1.Timestamp? checkedAt,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (errorCode != null) {
      _result.errorCode = errorCode;
    }
    if (errorMessage != null) {
      _result.errorMessage = errorMessage;
    }
    if (availableBalance != null) {
      _result.availableBalance = availableBalance;
    }
    if (sufficientFunds != null) {
      _result.sufficientFunds = sufficientFunds;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (checkedAt != null) {
      _result.checkedAt = checkedAt;
    }
    return _result;
  }
  factory CheckMandateBalanceResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CheckMandateBalanceResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CheckMandateBalanceResponse clone() => CheckMandateBalanceResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CheckMandateBalanceResponse copyWith(void Function(CheckMandateBalanceResponse) updates) => super.copyWith((message) => updates(message as CheckMandateBalanceResponse)) as CheckMandateBalanceResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CheckMandateBalanceResponse create() => CheckMandateBalanceResponse._();
  CheckMandateBalanceResponse createEmptyInstance() => create();
  static $pb.PbList<CheckMandateBalanceResponse> createRepeated() => $pb.PbList<CheckMandateBalanceResponse>();
  @$core.pragma('dart2js:noInline')
  static CheckMandateBalanceResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CheckMandateBalanceResponse>(create);
  static CheckMandateBalanceResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get availableBalance => $_getI64(3);
  @$pb.TagNumber(4)
  set availableBalance($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasAvailableBalance() => $_has(3);
  @$pb.TagNumber(4)
  void clearAvailableBalance() => clearField(4);

  @$pb.TagNumber(5)
  $core.bool get sufficientFunds => $_getBF(4);
  @$pb.TagNumber(5)
  set sufficientFunds($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasSufficientFunds() => $_has(4);
  @$pb.TagNumber(5)
  void clearSufficientFunds() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get currency => $_getSZ(5);
  @$pb.TagNumber(6)
  set currency($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasCurrency() => $_has(5);
  @$pb.TagNumber(6)
  void clearCurrency() => clearField(6);

  @$pb.TagNumber(7)
  $1.Timestamp get checkedAt => $_getN(6);
  @$pb.TagNumber(7)
  set checkedAt($1.Timestamp v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasCheckedAt() => $_has(6);
  @$pb.TagNumber(7)
  void clearCheckedAt() => clearField(7);
  @$pb.TagNumber(7)
  $1.Timestamp ensureCheckedAt() => $_ensure(6);
}

