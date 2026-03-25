// This is a generated file - do not edit.
//
// Generated from banking.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'banking.pbenum.dart';
import 'google/protobuf/timestamp.pb.dart' as $1;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'banking.pbenum.dart';

class CreateVirtualAccountRequest extends $pb.GeneratedMessage {
  factory CreateVirtualAccountRequest({
    $core.String? userId,
    $core.String? email,
    $core.String? firstName,
    $core.String? lastName,
    $core.String? phoneNumber,
    $core.String? bvn,
    $core.String? currency,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    if (email != null) result.email = email;
    if (firstName != null) result.firstName = firstName;
    if (lastName != null) result.lastName = lastName;
    if (phoneNumber != null) result.phoneNumber = phoneNumber;
    if (bvn != null) result.bvn = bvn;
    if (currency != null) result.currency = currency;
    return result;
  }

  CreateVirtualAccountRequest._();

  factory CreateVirtualAccountRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateVirtualAccountRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateVirtualAccountRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'email')
    ..aOS(3, _omitFieldNames ? '' : 'firstName')
    ..aOS(4, _omitFieldNames ? '' : 'lastName')
    ..aOS(5, _omitFieldNames ? '' : 'phoneNumber')
    ..aOS(6, _omitFieldNames ? '' : 'bvn')
    ..aOS(7, _omitFieldNames ? '' : 'currency')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateVirtualAccountRequest clone() =>
      CreateVirtualAccountRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateVirtualAccountRequest copyWith(
          void Function(CreateVirtualAccountRequest) updates) =>
      super.copyWith(
              (message) => updates(message as CreateVirtualAccountRequest))
          as CreateVirtualAccountRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateVirtualAccountRequest create() =>
      CreateVirtualAccountRequest._();
  @$core.override
  CreateVirtualAccountRequest createEmptyInstance() => create();
  static $pb.PbList<CreateVirtualAccountRequest> createRepeated() =>
      $pb.PbList<CreateVirtualAccountRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateVirtualAccountRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateVirtualAccountRequest>(create);
  static CreateVirtualAccountRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get email => $_getSZ(1);
  @$pb.TagNumber(2)
  set email($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasEmail() => $_has(1);
  @$pb.TagNumber(2)
  void clearEmail() => $_clearField(2);

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
  $core.String get phoneNumber => $_getSZ(4);
  @$pb.TagNumber(5)
  set phoneNumber($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasPhoneNumber() => $_has(4);
  @$pb.TagNumber(5)
  void clearPhoneNumber() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get bvn => $_getSZ(5);
  @$pb.TagNumber(6)
  set bvn($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasBvn() => $_has(5);
  @$pb.TagNumber(6)
  void clearBvn() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get currency => $_getSZ(6);
  @$pb.TagNumber(7)
  set currency($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasCurrency() => $_has(6);
  @$pb.TagNumber(7)
  void clearCurrency() => $_clearField(7);
}

class GetVirtualAccountRequest extends $pb.GeneratedMessage {
  factory GetVirtualAccountRequest({
    $core.String? accountNumber,
  }) {
    final result = create();
    if (accountNumber != null) result.accountNumber = accountNumber;
    return result;
  }

  GetVirtualAccountRequest._();

  factory GetVirtualAccountRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetVirtualAccountRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetVirtualAccountRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountNumber')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetVirtualAccountRequest clone() =>
      GetVirtualAccountRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetVirtualAccountRequest copyWith(
          void Function(GetVirtualAccountRequest) updates) =>
      super.copyWith((message) => updates(message as GetVirtualAccountRequest))
          as GetVirtualAccountRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetVirtualAccountRequest create() => GetVirtualAccountRequest._();
  @$core.override
  GetVirtualAccountRequest createEmptyInstance() => create();
  static $pb.PbList<GetVirtualAccountRequest> createRepeated() =>
      $pb.PbList<GetVirtualAccountRequest>();
  @$core.pragma('dart2js:noInline')
  static GetVirtualAccountRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetVirtualAccountRequest>(create);
  static GetVirtualAccountRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountNumber => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountNumber($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAccountNumber() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountNumber() => $_clearField(1);
}

class GetUserVirtualAccountsRequest extends $pb.GeneratedMessage {
  factory GetUserVirtualAccountsRequest({
    $core.String? userId,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    return result;
  }

  GetUserVirtualAccountsRequest._();

  factory GetUserVirtualAccountsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetUserVirtualAccountsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUserVirtualAccountsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserVirtualAccountsRequest clone() =>
      GetUserVirtualAccountsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserVirtualAccountsRequest copyWith(
          void Function(GetUserVirtualAccountsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetUserVirtualAccountsRequest))
          as GetUserVirtualAccountsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserVirtualAccountsRequest create() =>
      GetUserVirtualAccountsRequest._();
  @$core.override
  GetUserVirtualAccountsRequest createEmptyInstance() => create();
  static $pb.PbList<GetUserVirtualAccountsRequest> createRepeated() =>
      $pb.PbList<GetUserVirtualAccountsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetUserVirtualAccountsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetUserVirtualAccountsRequest>(create);
  static GetUserVirtualAccountsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);
}

class VirtualAccountResponse extends $pb.GeneratedMessage {
  factory VirtualAccountResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
    VirtualAccount? account,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (errorCode != null) result.errorCode = errorCode;
    if (errorMessage != null) result.errorMessage = errorMessage;
    if (account != null) result.account = account;
    return result;
  }

  VirtualAccountResponse._();

  factory VirtualAccountResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VirtualAccountResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VirtualAccountResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'errorCode')
    ..aOS(3, _omitFieldNames ? '' : 'errorMessage')
    ..aOM<VirtualAccount>(4, _omitFieldNames ? '' : 'account',
        subBuilder: VirtualAccount.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VirtualAccountResponse clone() =>
      VirtualAccountResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VirtualAccountResponse copyWith(
          void Function(VirtualAccountResponse) updates) =>
      super.copyWith((message) => updates(message as VirtualAccountResponse))
          as VirtualAccountResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VirtualAccountResponse create() => VirtualAccountResponse._();
  @$core.override
  VirtualAccountResponse createEmptyInstance() => create();
  static $pb.PbList<VirtualAccountResponse> createRepeated() =>
      $pb.PbList<VirtualAccountResponse>();
  @$core.pragma('dart2js:noInline')
  static VirtualAccountResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VirtualAccountResponse>(create);
  static VirtualAccountResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => $_clearField(3);

  @$pb.TagNumber(4)
  VirtualAccount get account => $_getN(3);
  @$pb.TagNumber(4)
  set account(VirtualAccount value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasAccount() => $_has(3);
  @$pb.TagNumber(4)
  void clearAccount() => $_clearField(4);
  @$pb.TagNumber(4)
  VirtualAccount ensureAccount() => $_ensure(3);
}

class VirtualAccountsResponse extends $pb.GeneratedMessage {
  factory VirtualAccountsResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
    $core.Iterable<VirtualAccount>? accounts,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (errorCode != null) result.errorCode = errorCode;
    if (errorMessage != null) result.errorMessage = errorMessage;
    if (accounts != null) result.accounts.addAll(accounts);
    return result;
  }

  VirtualAccountsResponse._();

  factory VirtualAccountsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VirtualAccountsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VirtualAccountsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'errorCode')
    ..aOS(3, _omitFieldNames ? '' : 'errorMessage')
    ..pc<VirtualAccount>(
        4, _omitFieldNames ? '' : 'accounts', $pb.PbFieldType.PM,
        subBuilder: VirtualAccount.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VirtualAccountsResponse clone() =>
      VirtualAccountsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VirtualAccountsResponse copyWith(
          void Function(VirtualAccountsResponse) updates) =>
      super.copyWith((message) => updates(message as VirtualAccountsResponse))
          as VirtualAccountsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VirtualAccountsResponse create() => VirtualAccountsResponse._();
  @$core.override
  VirtualAccountsResponse createEmptyInstance() => create();
  static $pb.PbList<VirtualAccountsResponse> createRepeated() =>
      $pb.PbList<VirtualAccountsResponse>();
  @$core.pragma('dart2js:noInline')
  static VirtualAccountsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VirtualAccountsResponse>(create);
  static VirtualAccountsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => $_clearField(3);

  @$pb.TagNumber(4)
  $pb.PbList<VirtualAccount> get accounts => $_getList(3);
}

class VirtualAccount extends $pb.GeneratedMessage {
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
    final result = create();
    if (id != null) result.id = id;
    if (userId != null) result.userId = userId;
    if (accountNumber != null) result.accountNumber = accountNumber;
    if (accountName != null) result.accountName = accountName;
    if (bankCode != null) result.bankCode = bankCode;
    if (bankName != null) result.bankName = bankName;
    if (currency != null) result.currency = currency;
    if (provider != null) result.provider = provider;
    if (status != null) result.status = status;
    if (balance != null) result.balance = balance;
    if (availableBalance != null) result.availableBalance = availableBalance;
    if (createdAt != null) result.createdAt = createdAt;
    if (pendingCredits != null) result.pendingCredits = pendingCredits;
    if (pendingDebits != null) result.pendingDebits = pendingDebits;
    if (accountType != null) result.accountType = accountType;
    if (isPrimary != null) result.isPrimary = isPrimary;
    if (kycTier != null) result.kycTier = kycTier;
    return result;
  }

  VirtualAccount._();

  factory VirtualAccount.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VirtualAccount.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VirtualAccount',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'accountNumber')
    ..aOS(4, _omitFieldNames ? '' : 'accountName')
    ..aOS(5, _omitFieldNames ? '' : 'bankCode')
    ..aOS(6, _omitFieldNames ? '' : 'bankName')
    ..aOS(7, _omitFieldNames ? '' : 'currency')
    ..aOS(8, _omitFieldNames ? '' : 'provider')
    ..aOS(9, _omitFieldNames ? '' : 'status')
    ..aInt64(10, _omitFieldNames ? '' : 'balance')
    ..aInt64(11, _omitFieldNames ? '' : 'availableBalance')
    ..aOM<$1.Timestamp>(12, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $1.Timestamp.create)
    ..aInt64(13, _omitFieldNames ? '' : 'pendingCredits')
    ..aInt64(14, _omitFieldNames ? '' : 'pendingDebits')
    ..aOS(15, _omitFieldNames ? '' : 'accountType')
    ..aOB(16, _omitFieldNames ? '' : 'isPrimary')
    ..a<$core.int>(17, _omitFieldNames ? '' : 'kycTier', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VirtualAccount clone() => VirtualAccount()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VirtualAccount copyWith(void Function(VirtualAccount) updates) =>
      super.copyWith((message) => updates(message as VirtualAccount))
          as VirtualAccount;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VirtualAccount create() => VirtualAccount._();
  @$core.override
  VirtualAccount createEmptyInstance() => create();
  static $pb.PbList<VirtualAccount> createRepeated() =>
      $pb.PbList<VirtualAccount>();
  @$core.pragma('dart2js:noInline')
  static VirtualAccount getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VirtualAccount>(create);
  static VirtualAccount? _defaultInstance;

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
  $core.String get accountNumber => $_getSZ(2);
  @$pb.TagNumber(3)
  set accountNumber($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAccountNumber() => $_has(2);
  @$pb.TagNumber(3)
  void clearAccountNumber() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get accountName => $_getSZ(3);
  @$pb.TagNumber(4)
  set accountName($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAccountName() => $_has(3);
  @$pb.TagNumber(4)
  void clearAccountName() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get bankCode => $_getSZ(4);
  @$pb.TagNumber(5)
  set bankCode($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasBankCode() => $_has(4);
  @$pb.TagNumber(5)
  void clearBankCode() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get bankName => $_getSZ(5);
  @$pb.TagNumber(6)
  set bankName($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasBankName() => $_has(5);
  @$pb.TagNumber(6)
  void clearBankName() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get currency => $_getSZ(6);
  @$pb.TagNumber(7)
  set currency($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasCurrency() => $_has(6);
  @$pb.TagNumber(7)
  void clearCurrency() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get provider => $_getSZ(7);
  @$pb.TagNumber(8)
  set provider($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasProvider() => $_has(7);
  @$pb.TagNumber(8)
  void clearProvider() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get status => $_getSZ(8);
  @$pb.TagNumber(9)
  set status($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasStatus() => $_has(8);
  @$pb.TagNumber(9)
  void clearStatus() => $_clearField(9);

  @$pb.TagNumber(10)
  $fixnum.Int64 get balance => $_getI64(9);
  @$pb.TagNumber(10)
  set balance($fixnum.Int64 value) => $_setInt64(9, value);
  @$pb.TagNumber(10)
  $core.bool hasBalance() => $_has(9);
  @$pb.TagNumber(10)
  void clearBalance() => $_clearField(10);

  @$pb.TagNumber(11)
  $fixnum.Int64 get availableBalance => $_getI64(10);
  @$pb.TagNumber(11)
  set availableBalance($fixnum.Int64 value) => $_setInt64(10, value);
  @$pb.TagNumber(11)
  $core.bool hasAvailableBalance() => $_has(10);
  @$pb.TagNumber(11)
  void clearAvailableBalance() => $_clearField(11);

  @$pb.TagNumber(12)
  $1.Timestamp get createdAt => $_getN(11);
  @$pb.TagNumber(12)
  set createdAt($1.Timestamp value) => $_setField(12, value);
  @$pb.TagNumber(12)
  $core.bool hasCreatedAt() => $_has(11);
  @$pb.TagNumber(12)
  void clearCreatedAt() => $_clearField(12);
  @$pb.TagNumber(12)
  $1.Timestamp ensureCreatedAt() => $_ensure(11);

  /// Pooled architecture fields
  @$pb.TagNumber(13)
  $fixnum.Int64 get pendingCredits => $_getI64(12);
  @$pb.TagNumber(13)
  set pendingCredits($fixnum.Int64 value) => $_setInt64(12, value);
  @$pb.TagNumber(13)
  $core.bool hasPendingCredits() => $_has(12);
  @$pb.TagNumber(13)
  void clearPendingCredits() => $_clearField(13);

  @$pb.TagNumber(14)
  $fixnum.Int64 get pendingDebits => $_getI64(13);
  @$pb.TagNumber(14)
  set pendingDebits($fixnum.Int64 value) => $_setInt64(13, value);
  @$pb.TagNumber(14)
  $core.bool hasPendingDebits() => $_has(13);
  @$pb.TagNumber(14)
  void clearPendingDebits() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.String get accountType => $_getSZ(14);
  @$pb.TagNumber(15)
  set accountType($core.String value) => $_setString(14, value);
  @$pb.TagNumber(15)
  $core.bool hasAccountType() => $_has(14);
  @$pb.TagNumber(15)
  void clearAccountType() => $_clearField(15);

  @$pb.TagNumber(16)
  $core.bool get isPrimary => $_getBF(15);
  @$pb.TagNumber(16)
  set isPrimary($core.bool value) => $_setBool(15, value);
  @$pb.TagNumber(16)
  $core.bool hasIsPrimary() => $_has(15);
  @$pb.TagNumber(16)
  void clearIsPrimary() => $_clearField(16);

  @$pb.TagNumber(17)
  $core.int get kycTier => $_getIZ(16);
  @$pb.TagNumber(17)
  set kycTier($core.int value) => $_setSignedInt32(16, value);
  @$pb.TagNumber(17)
  $core.bool hasKycTier() => $_has(16);
  @$pb.TagNumber(17)
  void clearKycTier() => $_clearField(17);
}

class DomesticTransferRequest extends $pb.GeneratedMessage {
  factory DomesticTransferRequest({
    $core.String? userId,
    $core.String? sourceAccountId,
    $fixnum.Int64? amount,
    $core.String? currency,
    $core.String? destinationAccount,
    $core.String? destinationBankCode,
    $core.String? destinationName,
    $core.String? narration,
    $core.String? reference,
    $core.String? idempotencyKey,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    if (sourceAccountId != null) result.sourceAccountId = sourceAccountId;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    if (destinationAccount != null)
      result.destinationAccount = destinationAccount;
    if (destinationBankCode != null)
      result.destinationBankCode = destinationBankCode;
    if (destinationName != null) result.destinationName = destinationName;
    if (narration != null) result.narration = narration;
    if (reference != null) result.reference = reference;
    if (idempotencyKey != null) result.idempotencyKey = idempotencyKey;
    return result;
  }

  DomesticTransferRequest._();

  factory DomesticTransferRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DomesticTransferRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DomesticTransferRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'sourceAccountId')
    ..aInt64(3, _omitFieldNames ? '' : 'amount')
    ..aOS(4, _omitFieldNames ? '' : 'currency')
    ..aOS(5, _omitFieldNames ? '' : 'destinationAccount')
    ..aOS(6, _omitFieldNames ? '' : 'destinationBankCode')
    ..aOS(7, _omitFieldNames ? '' : 'destinationName')
    ..aOS(8, _omitFieldNames ? '' : 'narration')
    ..aOS(9, _omitFieldNames ? '' : 'reference')
    ..aOS(10, _omitFieldNames ? '' : 'idempotencyKey')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DomesticTransferRequest clone() =>
      DomesticTransferRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DomesticTransferRequest copyWith(
          void Function(DomesticTransferRequest) updates) =>
      super.copyWith((message) => updates(message as DomesticTransferRequest))
          as DomesticTransferRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DomesticTransferRequest create() => DomesticTransferRequest._();
  @$core.override
  DomesticTransferRequest createEmptyInstance() => create();
  static $pb.PbList<DomesticTransferRequest> createRepeated() =>
      $pb.PbList<DomesticTransferRequest>();
  @$core.pragma('dart2js:noInline')
  static DomesticTransferRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DomesticTransferRequest>(create);
  static DomesticTransferRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get sourceAccountId => $_getSZ(1);
  @$pb.TagNumber(2)
  set sourceAccountId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSourceAccountId() => $_has(1);
  @$pb.TagNumber(2)
  void clearSourceAccountId() => $_clearField(2);

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
  $core.String get destinationAccount => $_getSZ(4);
  @$pb.TagNumber(5)
  set destinationAccount($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasDestinationAccount() => $_has(4);
  @$pb.TagNumber(5)
  void clearDestinationAccount() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get destinationBankCode => $_getSZ(5);
  @$pb.TagNumber(6)
  set destinationBankCode($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasDestinationBankCode() => $_has(5);
  @$pb.TagNumber(6)
  void clearDestinationBankCode() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get destinationName => $_getSZ(6);
  @$pb.TagNumber(7)
  set destinationName($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasDestinationName() => $_has(6);
  @$pb.TagNumber(7)
  void clearDestinationName() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get narration => $_getSZ(7);
  @$pb.TagNumber(8)
  set narration($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasNarration() => $_has(7);
  @$pb.TagNumber(8)
  void clearNarration() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get reference => $_getSZ(8);
  @$pb.TagNumber(9)
  set reference($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasReference() => $_has(8);
  @$pb.TagNumber(9)
  void clearReference() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get idempotencyKey => $_getSZ(9);
  @$pb.TagNumber(10)
  set idempotencyKey($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasIdempotencyKey() => $_has(9);
  @$pb.TagNumber(10)
  void clearIdempotencyKey() => $_clearField(10);
}

class InternalTransferRequest extends $pb.GeneratedMessage {
  factory InternalTransferRequest({
    $core.String? fromUserId,
    $core.String? fromAccountId,
    $core.String? toUserId,
    $core.String? toAccountId,
    $fixnum.Int64? amount,
    $core.String? currency,
    $core.String? narration,
    $core.String? reference,
    $core.String? idempotencyKey,
    RecipientDetails? recipientDetails,
  }) {
    final result = create();
    if (fromUserId != null) result.fromUserId = fromUserId;
    if (fromAccountId != null) result.fromAccountId = fromAccountId;
    if (toUserId != null) result.toUserId = toUserId;
    if (toAccountId != null) result.toAccountId = toAccountId;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    if (narration != null) result.narration = narration;
    if (reference != null) result.reference = reference;
    if (idempotencyKey != null) result.idempotencyKey = idempotencyKey;
    if (recipientDetails != null) result.recipientDetails = recipientDetails;
    return result;
  }

  InternalTransferRequest._();

  factory InternalTransferRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InternalTransferRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InternalTransferRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'fromUserId')
    ..aOS(2, _omitFieldNames ? '' : 'fromAccountId')
    ..aOS(3, _omitFieldNames ? '' : 'toUserId')
    ..aOS(4, _omitFieldNames ? '' : 'toAccountId')
    ..aInt64(5, _omitFieldNames ? '' : 'amount')
    ..aOS(6, _omitFieldNames ? '' : 'currency')
    ..aOS(7, _omitFieldNames ? '' : 'narration')
    ..aOS(8, _omitFieldNames ? '' : 'reference')
    ..aOS(9, _omitFieldNames ? '' : 'idempotencyKey')
    ..aOM<RecipientDetails>(10, _omitFieldNames ? '' : 'recipientDetails',
        subBuilder: RecipientDetails.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InternalTransferRequest clone() =>
      InternalTransferRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InternalTransferRequest copyWith(
          void Function(InternalTransferRequest) updates) =>
      super.copyWith((message) => updates(message as InternalTransferRequest))
          as InternalTransferRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InternalTransferRequest create() => InternalTransferRequest._();
  @$core.override
  InternalTransferRequest createEmptyInstance() => create();
  static $pb.PbList<InternalTransferRequest> createRepeated() =>
      $pb.PbList<InternalTransferRequest>();
  @$core.pragma('dart2js:noInline')
  static InternalTransferRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InternalTransferRequest>(create);
  static InternalTransferRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get fromUserId => $_getSZ(0);
  @$pb.TagNumber(1)
  set fromUserId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFromUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFromUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get fromAccountId => $_getSZ(1);
  @$pb.TagNumber(2)
  set fromAccountId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasFromAccountId() => $_has(1);
  @$pb.TagNumber(2)
  void clearFromAccountId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get toUserId => $_getSZ(2);
  @$pb.TagNumber(3)
  set toUserId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasToUserId() => $_has(2);
  @$pb.TagNumber(3)
  void clearToUserId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get toAccountId => $_getSZ(3);
  @$pb.TagNumber(4)
  set toAccountId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasToAccountId() => $_has(3);
  @$pb.TagNumber(4)
  void clearToAccountId() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get amount => $_getI64(4);
  @$pb.TagNumber(5)
  set amount($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasAmount() => $_has(4);
  @$pb.TagNumber(5)
  void clearAmount() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get currency => $_getSZ(5);
  @$pb.TagNumber(6)
  set currency($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasCurrency() => $_has(5);
  @$pb.TagNumber(6)
  void clearCurrency() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get narration => $_getSZ(6);
  @$pb.TagNumber(7)
  set narration($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasNarration() => $_has(6);
  @$pb.TagNumber(7)
  void clearNarration() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get reference => $_getSZ(7);
  @$pb.TagNumber(8)
  set reference($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasReference() => $_has(7);
  @$pb.TagNumber(8)
  void clearReference() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get idempotencyKey => $_getSZ(8);
  @$pb.TagNumber(9)
  set idempotencyKey($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasIdempotencyKey() => $_has(8);
  @$pb.TagNumber(9)
  void clearIdempotencyKey() => $_clearField(9);

  /// Recipient details (required when to_user_id is not set, or for creating recipient record)
  @$pb.TagNumber(10)
  RecipientDetails get recipientDetails => $_getN(9);
  @$pb.TagNumber(10)
  set recipientDetails(RecipientDetails value) => $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasRecipientDetails() => $_has(9);
  @$pb.TagNumber(10)
  void clearRecipientDetails() => $_clearField(10);
  @$pb.TagNumber(10)
  RecipientDetails ensureRecipientDetails() => $_ensure(9);
}

/// Recipient details for on-the-fly recipient creation
class RecipientDetails extends $pb.GeneratedMessage {
  factory RecipientDetails({
    $core.String? name,
    $core.String? recipientType,
    $core.String? recipientSource,
    $core.String? username,
    $core.String? userId,
    $core.String? accountNumber,
    $core.String? bankCode,
    $core.String? bankName,
    $core.String? phoneNumber,
  }) {
    final result = create();
    if (name != null) result.name = name;
    if (recipientType != null) result.recipientType = recipientType;
    if (recipientSource != null) result.recipientSource = recipientSource;
    if (username != null) result.username = username;
    if (userId != null) result.userId = userId;
    if (accountNumber != null) result.accountNumber = accountNumber;
    if (bankCode != null) result.bankCode = bankCode;
    if (bankName != null) result.bankName = bankName;
    if (phoneNumber != null) result.phoneNumber = phoneNumber;
    return result;
  }

  RecipientDetails._();

  factory RecipientDetails.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RecipientDetails.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RecipientDetails',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOS(2, _omitFieldNames ? '' : 'recipientType')
    ..aOS(3, _omitFieldNames ? '' : 'recipientSource')
    ..aOS(4, _omitFieldNames ? '' : 'username')
    ..aOS(5, _omitFieldNames ? '' : 'userId')
    ..aOS(6, _omitFieldNames ? '' : 'accountNumber')
    ..aOS(7, _omitFieldNames ? '' : 'bankCode')
    ..aOS(8, _omitFieldNames ? '' : 'bankName')
    ..aOS(9, _omitFieldNames ? '' : 'phoneNumber')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RecipientDetails clone() => RecipientDetails()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RecipientDetails copyWith(void Function(RecipientDetails) updates) =>
      super.copyWith((message) => updates(message as RecipientDetails))
          as RecipientDetails;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RecipientDetails create() => RecipientDetails._();
  @$core.override
  RecipientDetails createEmptyInstance() => create();
  static $pb.PbList<RecipientDetails> createRepeated() =>
      $pb.PbList<RecipientDetails>();
  @$core.pragma('dart2js:noInline')
  static RecipientDetails getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RecipientDetails>(create);
  static RecipientDetails? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get recipientType => $_getSZ(1);
  @$pb.TagNumber(2)
  set recipientType($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRecipientType() => $_has(1);
  @$pb.TagNumber(2)
  void clearRecipientType() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get recipientSource => $_getSZ(2);
  @$pb.TagNumber(3)
  set recipientSource($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasRecipientSource() => $_has(2);
  @$pb.TagNumber(3)
  void clearRecipientSource() => $_clearField(3);

  /// For internal recipients (LazerVault users)
  @$pb.TagNumber(4)
  $core.String get username => $_getSZ(3);
  @$pb.TagNumber(4)
  set username($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasUsername() => $_has(3);
  @$pb.TagNumber(4)
  void clearUsername() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get userId => $_getSZ(4);
  @$pb.TagNumber(5)
  set userId($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasUserId() => $_has(4);
  @$pb.TagNumber(5)
  void clearUserId() => $_clearField(5);

  /// For external recipients (bank accounts)
  @$pb.TagNumber(6)
  $core.String get accountNumber => $_getSZ(5);
  @$pb.TagNumber(6)
  set accountNumber($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasAccountNumber() => $_has(5);
  @$pb.TagNumber(6)
  void clearAccountNumber() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get bankCode => $_getSZ(6);
  @$pb.TagNumber(7)
  set bankCode($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasBankCode() => $_has(6);
  @$pb.TagNumber(7)
  void clearBankCode() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get bankName => $_getSZ(7);
  @$pb.TagNumber(8)
  set bankName($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasBankName() => $_has(7);
  @$pb.TagNumber(8)
  void clearBankName() => $_clearField(8);

  /// For phone recipients
  @$pb.TagNumber(9)
  $core.String get phoneNumber => $_getSZ(8);
  @$pb.TagNumber(9)
  set phoneNumber($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasPhoneNumber() => $_has(8);
  @$pb.TagNumber(9)
  void clearPhoneNumber() => $_clearField(9);
}

class InternationalTransferRequest extends $pb.GeneratedMessage {
  factory InternationalTransferRequest({
    $core.String? userId,
    $core.String? sourceAccountId,
    $fixnum.Int64? amount,
    $core.String? sourceCurrency,
    $core.String? destinationCurrency,
    $core.String? destinationCountry,
    $core.String? recipientType,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>?
        recipientDetails,
    $core.String? narration,
    $core.String? reference,
    $core.String? idempotencyKey,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    if (sourceAccountId != null) result.sourceAccountId = sourceAccountId;
    if (amount != null) result.amount = amount;
    if (sourceCurrency != null) result.sourceCurrency = sourceCurrency;
    if (destinationCurrency != null)
      result.destinationCurrency = destinationCurrency;
    if (destinationCountry != null)
      result.destinationCountry = destinationCountry;
    if (recipientType != null) result.recipientType = recipientType;
    if (recipientDetails != null)
      result.recipientDetails.addEntries(recipientDetails);
    if (narration != null) result.narration = narration;
    if (reference != null) result.reference = reference;
    if (idempotencyKey != null) result.idempotencyKey = idempotencyKey;
    return result;
  }

  InternationalTransferRequest._();

  factory InternationalTransferRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InternationalTransferRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InternationalTransferRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'sourceAccountId')
    ..aInt64(3, _omitFieldNames ? '' : 'amount')
    ..aOS(4, _omitFieldNames ? '' : 'sourceCurrency')
    ..aOS(5, _omitFieldNames ? '' : 'destinationCurrency')
    ..aOS(6, _omitFieldNames ? '' : 'destinationCountry')
    ..aOS(7, _omitFieldNames ? '' : 'recipientType')
    ..m<$core.String, $core.String>(
        8, _omitFieldNames ? '' : 'recipientDetails',
        entryClassName: 'InternationalTransferRequest.RecipientDetailsEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('banking'))
    ..aOS(9, _omitFieldNames ? '' : 'narration')
    ..aOS(10, _omitFieldNames ? '' : 'reference')
    ..aOS(11, _omitFieldNames ? '' : 'idempotencyKey')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InternationalTransferRequest clone() =>
      InternationalTransferRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InternationalTransferRequest copyWith(
          void Function(InternationalTransferRequest) updates) =>
      super.copyWith(
              (message) => updates(message as InternationalTransferRequest))
          as InternationalTransferRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InternationalTransferRequest create() =>
      InternationalTransferRequest._();
  @$core.override
  InternationalTransferRequest createEmptyInstance() => create();
  static $pb.PbList<InternationalTransferRequest> createRepeated() =>
      $pb.PbList<InternationalTransferRequest>();
  @$core.pragma('dart2js:noInline')
  static InternationalTransferRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InternationalTransferRequest>(create);
  static InternationalTransferRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get sourceAccountId => $_getSZ(1);
  @$pb.TagNumber(2)
  set sourceAccountId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSourceAccountId() => $_has(1);
  @$pb.TagNumber(2)
  void clearSourceAccountId() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get amount => $_getI64(2);
  @$pb.TagNumber(3)
  set amount($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get sourceCurrency => $_getSZ(3);
  @$pb.TagNumber(4)
  set sourceCurrency($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasSourceCurrency() => $_has(3);
  @$pb.TagNumber(4)
  void clearSourceCurrency() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get destinationCurrency => $_getSZ(4);
  @$pb.TagNumber(5)
  set destinationCurrency($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasDestinationCurrency() => $_has(4);
  @$pb.TagNumber(5)
  void clearDestinationCurrency() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get destinationCountry => $_getSZ(5);
  @$pb.TagNumber(6)
  set destinationCountry($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasDestinationCountry() => $_has(5);
  @$pb.TagNumber(6)
  void clearDestinationCountry() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get recipientType => $_getSZ(6);
  @$pb.TagNumber(7)
  set recipientType($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasRecipientType() => $_has(6);
  @$pb.TagNumber(7)
  void clearRecipientType() => $_clearField(7);

  @$pb.TagNumber(8)
  $pb.PbMap<$core.String, $core.String> get recipientDetails => $_getMap(7);

  @$pb.TagNumber(9)
  $core.String get narration => $_getSZ(8);
  @$pb.TagNumber(9)
  set narration($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasNarration() => $_has(8);
  @$pb.TagNumber(9)
  void clearNarration() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get reference => $_getSZ(9);
  @$pb.TagNumber(10)
  set reference($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasReference() => $_has(9);
  @$pb.TagNumber(10)
  void clearReference() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get idempotencyKey => $_getSZ(10);
  @$pb.TagNumber(11)
  set idempotencyKey($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasIdempotencyKey() => $_has(10);
  @$pb.TagNumber(11)
  void clearIdempotencyKey() => $_clearField(11);
}

class GetTransferStatusRequest extends $pb.GeneratedMessage {
  factory GetTransferStatusRequest({
    $core.String? reference,
  }) {
    final result = create();
    if (reference != null) result.reference = reference;
    return result;
  }

  GetTransferStatusRequest._();

  factory GetTransferStatusRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTransferStatusRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetTransferStatusRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'reference')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTransferStatusRequest clone() =>
      GetTransferStatusRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTransferStatusRequest copyWith(
          void Function(GetTransferStatusRequest) updates) =>
      super.copyWith((message) => updates(message as GetTransferStatusRequest))
          as GetTransferStatusRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTransferStatusRequest create() => GetTransferStatusRequest._();
  @$core.override
  GetTransferStatusRequest createEmptyInstance() => create();
  static $pb.PbList<GetTransferStatusRequest> createRepeated() =>
      $pb.PbList<GetTransferStatusRequest>();
  @$core.pragma('dart2js:noInline')
  static GetTransferStatusRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetTransferStatusRequest>(create);
  static GetTransferStatusRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get reference => $_getSZ(0);
  @$pb.TagNumber(1)
  set reference($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasReference() => $_has(0);
  @$pb.TagNumber(1)
  void clearReference() => $_clearField(1);
}

class GetUserTransfersRequest extends $pb.GeneratedMessage {
  factory GetUserTransfersRequest({
    $core.String? userId,
    $core.int? limit,
    $core.int? offset,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    if (limit != null) result.limit = limit;
    if (offset != null) result.offset = offset;
    return result;
  }

  GetUserTransfersRequest._();

  factory GetUserTransfersRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetUserTransfersRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUserTransfersRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserTransfersRequest clone() =>
      GetUserTransfersRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserTransfersRequest copyWith(
          void Function(GetUserTransfersRequest) updates) =>
      super.copyWith((message) => updates(message as GetUserTransfersRequest))
          as GetUserTransfersRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserTransfersRequest create() => GetUserTransfersRequest._();
  @$core.override
  GetUserTransfersRequest createEmptyInstance() => create();
  static $pb.PbList<GetUserTransfersRequest> createRepeated() =>
      $pb.PbList<GetUserTransfersRequest>();
  @$core.pragma('dart2js:noInline')
  static GetUserTransfersRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetUserTransfersRequest>(create);
  static GetUserTransfersRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

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

class TransferResponse extends $pb.GeneratedMessage {
  factory TransferResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
    Transfer? transfer,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (errorCode != null) result.errorCode = errorCode;
    if (errorMessage != null) result.errorMessage = errorMessage;
    if (transfer != null) result.transfer = transfer;
    return result;
  }

  TransferResponse._();

  factory TransferResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TransferResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TransferResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'errorCode')
    ..aOS(3, _omitFieldNames ? '' : 'errorMessage')
    ..aOM<Transfer>(4, _omitFieldNames ? '' : 'transfer',
        subBuilder: Transfer.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TransferResponse clone() => TransferResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TransferResponse copyWith(void Function(TransferResponse) updates) =>
      super.copyWith((message) => updates(message as TransferResponse))
          as TransferResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TransferResponse create() => TransferResponse._();
  @$core.override
  TransferResponse createEmptyInstance() => create();
  static $pb.PbList<TransferResponse> createRepeated() =>
      $pb.PbList<TransferResponse>();
  @$core.pragma('dart2js:noInline')
  static TransferResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TransferResponse>(create);
  static TransferResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => $_clearField(3);

  @$pb.TagNumber(4)
  Transfer get transfer => $_getN(3);
  @$pb.TagNumber(4)
  set transfer(Transfer value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasTransfer() => $_has(3);
  @$pb.TagNumber(4)
  void clearTransfer() => $_clearField(4);
  @$pb.TagNumber(4)
  Transfer ensureTransfer() => $_ensure(3);
}

class TransfersResponse extends $pb.GeneratedMessage {
  factory TransfersResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
    $core.Iterable<Transfer>? transfers,
    $core.int? total,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (errorCode != null) result.errorCode = errorCode;
    if (errorMessage != null) result.errorMessage = errorMessage;
    if (transfers != null) result.transfers.addAll(transfers);
    if (total != null) result.total = total;
    return result;
  }

  TransfersResponse._();

  factory TransfersResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TransfersResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TransfersResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'errorCode')
    ..aOS(3, _omitFieldNames ? '' : 'errorMessage')
    ..pc<Transfer>(4, _omitFieldNames ? '' : 'transfers', $pb.PbFieldType.PM,
        subBuilder: Transfer.create)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TransfersResponse clone() => TransfersResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TransfersResponse copyWith(void Function(TransfersResponse) updates) =>
      super.copyWith((message) => updates(message as TransfersResponse))
          as TransfersResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TransfersResponse create() => TransfersResponse._();
  @$core.override
  TransfersResponse createEmptyInstance() => create();
  static $pb.PbList<TransfersResponse> createRepeated() =>
      $pb.PbList<TransfersResponse>();
  @$core.pragma('dart2js:noInline')
  static TransfersResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TransfersResponse>(create);
  static TransfersResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => $_clearField(3);

  @$pb.TagNumber(4)
  $pb.PbList<Transfer> get transfers => $_getList(3);

  @$pb.TagNumber(5)
  $core.int get total => $_getIZ(4);
  @$pb.TagNumber(5)
  set total($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTotal() => $_has(4);
  @$pb.TagNumber(5)
  void clearTotal() => $_clearField(5);
}

class Transfer extends $pb.GeneratedMessage {
  factory Transfer({
    $core.String? id,
    $core.String? userId,
    $core.String? type,
    $core.String? status,
    $fixnum.Int64? amount,
    $core.String? currency,
    $fixnum.Int64? fee,
    $core.String? sourceAccountId,
    $core.String? destinationAccount,
    $core.String? destinationBankCode,
    $core.String? destinationBankName,
    $core.String? destinationName,
    $core.String? destinationCountry,
    $core.String? reference,
    $core.String? providerRef,
    $core.String? provider,
    $core.String? narration,
    $core.String? failureReason,
    $1.Timestamp? createdAt,
    $1.Timestamp? completedAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (userId != null) result.userId = userId;
    if (type != null) result.type = type;
    if (status != null) result.status = status;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    if (fee != null) result.fee = fee;
    if (sourceAccountId != null) result.sourceAccountId = sourceAccountId;
    if (destinationAccount != null)
      result.destinationAccount = destinationAccount;
    if (destinationBankCode != null)
      result.destinationBankCode = destinationBankCode;
    if (destinationBankName != null)
      result.destinationBankName = destinationBankName;
    if (destinationName != null) result.destinationName = destinationName;
    if (destinationCountry != null)
      result.destinationCountry = destinationCountry;
    if (reference != null) result.reference = reference;
    if (providerRef != null) result.providerRef = providerRef;
    if (provider != null) result.provider = provider;
    if (narration != null) result.narration = narration;
    if (failureReason != null) result.failureReason = failureReason;
    if (createdAt != null) result.createdAt = createdAt;
    if (completedAt != null) result.completedAt = completedAt;
    return result;
  }

  Transfer._();

  factory Transfer.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Transfer.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Transfer',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'type')
    ..aOS(4, _omitFieldNames ? '' : 'status')
    ..aInt64(5, _omitFieldNames ? '' : 'amount')
    ..aOS(6, _omitFieldNames ? '' : 'currency')
    ..aInt64(7, _omitFieldNames ? '' : 'fee')
    ..aOS(8, _omitFieldNames ? '' : 'sourceAccountId')
    ..aOS(9, _omitFieldNames ? '' : 'destinationAccount')
    ..aOS(10, _omitFieldNames ? '' : 'destinationBankCode')
    ..aOS(11, _omitFieldNames ? '' : 'destinationBankName')
    ..aOS(12, _omitFieldNames ? '' : 'destinationName')
    ..aOS(13, _omitFieldNames ? '' : 'destinationCountry')
    ..aOS(14, _omitFieldNames ? '' : 'reference')
    ..aOS(15, _omitFieldNames ? '' : 'providerRef')
    ..aOS(16, _omitFieldNames ? '' : 'provider')
    ..aOS(17, _omitFieldNames ? '' : 'narration')
    ..aOS(18, _omitFieldNames ? '' : 'failureReason')
    ..aOM<$1.Timestamp>(19, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(20, _omitFieldNames ? '' : 'completedAt',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Transfer clone() => Transfer()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Transfer copyWith(void Function(Transfer) updates) =>
      super.copyWith((message) => updates(message as Transfer)) as Transfer;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Transfer create() => Transfer._();
  @$core.override
  Transfer createEmptyInstance() => create();
  static $pb.PbList<Transfer> createRepeated() => $pb.PbList<Transfer>();
  @$core.pragma('dart2js:noInline')
  static Transfer getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Transfer>(create);
  static Transfer? _defaultInstance;

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
  $core.String get type => $_getSZ(2);
  @$pb.TagNumber(3)
  set type($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasType() => $_has(2);
  @$pb.TagNumber(3)
  void clearType() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get status => $_getSZ(3);
  @$pb.TagNumber(4)
  set status($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasStatus() => $_has(3);
  @$pb.TagNumber(4)
  void clearStatus() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get amount => $_getI64(4);
  @$pb.TagNumber(5)
  set amount($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasAmount() => $_has(4);
  @$pb.TagNumber(5)
  void clearAmount() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get currency => $_getSZ(5);
  @$pb.TagNumber(6)
  set currency($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasCurrency() => $_has(5);
  @$pb.TagNumber(6)
  void clearCurrency() => $_clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get fee => $_getI64(6);
  @$pb.TagNumber(7)
  set fee($fixnum.Int64 value) => $_setInt64(6, value);
  @$pb.TagNumber(7)
  $core.bool hasFee() => $_has(6);
  @$pb.TagNumber(7)
  void clearFee() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get sourceAccountId => $_getSZ(7);
  @$pb.TagNumber(8)
  set sourceAccountId($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasSourceAccountId() => $_has(7);
  @$pb.TagNumber(8)
  void clearSourceAccountId() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get destinationAccount => $_getSZ(8);
  @$pb.TagNumber(9)
  set destinationAccount($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasDestinationAccount() => $_has(8);
  @$pb.TagNumber(9)
  void clearDestinationAccount() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get destinationBankCode => $_getSZ(9);
  @$pb.TagNumber(10)
  set destinationBankCode($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasDestinationBankCode() => $_has(9);
  @$pb.TagNumber(10)
  void clearDestinationBankCode() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get destinationBankName => $_getSZ(10);
  @$pb.TagNumber(11)
  set destinationBankName($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasDestinationBankName() => $_has(10);
  @$pb.TagNumber(11)
  void clearDestinationBankName() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get destinationName => $_getSZ(11);
  @$pb.TagNumber(12)
  set destinationName($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasDestinationName() => $_has(11);
  @$pb.TagNumber(12)
  void clearDestinationName() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.String get destinationCountry => $_getSZ(12);
  @$pb.TagNumber(13)
  set destinationCountry($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasDestinationCountry() => $_has(12);
  @$pb.TagNumber(13)
  void clearDestinationCountry() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.String get reference => $_getSZ(13);
  @$pb.TagNumber(14)
  set reference($core.String value) => $_setString(13, value);
  @$pb.TagNumber(14)
  $core.bool hasReference() => $_has(13);
  @$pb.TagNumber(14)
  void clearReference() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.String get providerRef => $_getSZ(14);
  @$pb.TagNumber(15)
  set providerRef($core.String value) => $_setString(14, value);
  @$pb.TagNumber(15)
  $core.bool hasProviderRef() => $_has(14);
  @$pb.TagNumber(15)
  void clearProviderRef() => $_clearField(15);

  @$pb.TagNumber(16)
  $core.String get provider => $_getSZ(15);
  @$pb.TagNumber(16)
  set provider($core.String value) => $_setString(15, value);
  @$pb.TagNumber(16)
  $core.bool hasProvider() => $_has(15);
  @$pb.TagNumber(16)
  void clearProvider() => $_clearField(16);

  @$pb.TagNumber(17)
  $core.String get narration => $_getSZ(16);
  @$pb.TagNumber(17)
  set narration($core.String value) => $_setString(16, value);
  @$pb.TagNumber(17)
  $core.bool hasNarration() => $_has(16);
  @$pb.TagNumber(17)
  void clearNarration() => $_clearField(17);

  @$pb.TagNumber(18)
  $core.String get failureReason => $_getSZ(17);
  @$pb.TagNumber(18)
  set failureReason($core.String value) => $_setString(17, value);
  @$pb.TagNumber(18)
  $core.bool hasFailureReason() => $_has(17);
  @$pb.TagNumber(18)
  void clearFailureReason() => $_clearField(18);

  @$pb.TagNumber(19)
  $1.Timestamp get createdAt => $_getN(18);
  @$pb.TagNumber(19)
  set createdAt($1.Timestamp value) => $_setField(19, value);
  @$pb.TagNumber(19)
  $core.bool hasCreatedAt() => $_has(18);
  @$pb.TagNumber(19)
  void clearCreatedAt() => $_clearField(19);
  @$pb.TagNumber(19)
  $1.Timestamp ensureCreatedAt() => $_ensure(18);

  @$pb.TagNumber(20)
  $1.Timestamp get completedAt => $_getN(19);
  @$pb.TagNumber(20)
  set completedAt($1.Timestamp value) => $_setField(20, value);
  @$pb.TagNumber(20)
  $core.bool hasCompletedAt() => $_has(19);
  @$pb.TagNumber(20)
  void clearCompletedAt() => $_clearField(20);
  @$pb.TagNumber(20)
  $1.Timestamp ensureCompletedAt() => $_ensure(19);
}

class GetExchangeRateRequest extends $pb.GeneratedMessage {
  factory GetExchangeRateRequest({
    $core.String? sourceCurrency,
    $core.String? destinationCurrency,
    $fixnum.Int64? amount,
  }) {
    final result = create();
    if (sourceCurrency != null) result.sourceCurrency = sourceCurrency;
    if (destinationCurrency != null)
      result.destinationCurrency = destinationCurrency;
    if (amount != null) result.amount = amount;
    return result;
  }

  GetExchangeRateRequest._();

  factory GetExchangeRateRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetExchangeRateRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetExchangeRateRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'sourceCurrency')
    ..aOS(2, _omitFieldNames ? '' : 'destinationCurrency')
    ..aInt64(3, _omitFieldNames ? '' : 'amount')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetExchangeRateRequest clone() =>
      GetExchangeRateRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetExchangeRateRequest copyWith(
          void Function(GetExchangeRateRequest) updates) =>
      super.copyWith((message) => updates(message as GetExchangeRateRequest))
          as GetExchangeRateRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetExchangeRateRequest create() => GetExchangeRateRequest._();
  @$core.override
  GetExchangeRateRequest createEmptyInstance() => create();
  static $pb.PbList<GetExchangeRateRequest> createRepeated() =>
      $pb.PbList<GetExchangeRateRequest>();
  @$core.pragma('dart2js:noInline')
  static GetExchangeRateRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetExchangeRateRequest>(create);
  static GetExchangeRateRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get sourceCurrency => $_getSZ(0);
  @$pb.TagNumber(1)
  set sourceCurrency($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSourceCurrency() => $_has(0);
  @$pb.TagNumber(1)
  void clearSourceCurrency() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get destinationCurrency => $_getSZ(1);
  @$pb.TagNumber(2)
  set destinationCurrency($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDestinationCurrency() => $_has(1);
  @$pb.TagNumber(2)
  void clearDestinationCurrency() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get amount => $_getI64(2);
  @$pb.TagNumber(3)
  set amount($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => $_clearField(3);
}

class ExchangeRateResponse extends $pb.GeneratedMessage {
  factory ExchangeRateResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
    $core.String? sourceCurrency,
    $core.String? destinationCurrency,
    $core.double? rate,
    $fixnum.Int64? fee,
    $fixnum.Int64? destinationAmount,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (errorCode != null) result.errorCode = errorCode;
    if (errorMessage != null) result.errorMessage = errorMessage;
    if (sourceCurrency != null) result.sourceCurrency = sourceCurrency;
    if (destinationCurrency != null)
      result.destinationCurrency = destinationCurrency;
    if (rate != null) result.rate = rate;
    if (fee != null) result.fee = fee;
    if (destinationAmount != null) result.destinationAmount = destinationAmount;
    return result;
  }

  ExchangeRateResponse._();

  factory ExchangeRateResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ExchangeRateResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ExchangeRateResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'errorCode')
    ..aOS(3, _omitFieldNames ? '' : 'errorMessage')
    ..aOS(4, _omitFieldNames ? '' : 'sourceCurrency')
    ..aOS(5, _omitFieldNames ? '' : 'destinationCurrency')
    ..a<$core.double>(6, _omitFieldNames ? '' : 'rate', $pb.PbFieldType.OD)
    ..aInt64(7, _omitFieldNames ? '' : 'fee')
    ..aInt64(8, _omitFieldNames ? '' : 'destinationAmount')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExchangeRateResponse clone() =>
      ExchangeRateResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExchangeRateResponse copyWith(void Function(ExchangeRateResponse) updates) =>
      super.copyWith((message) => updates(message as ExchangeRateResponse))
          as ExchangeRateResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ExchangeRateResponse create() => ExchangeRateResponse._();
  @$core.override
  ExchangeRateResponse createEmptyInstance() => create();
  static $pb.PbList<ExchangeRateResponse> createRepeated() =>
      $pb.PbList<ExchangeRateResponse>();
  @$core.pragma('dart2js:noInline')
  static ExchangeRateResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ExchangeRateResponse>(create);
  static ExchangeRateResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get sourceCurrency => $_getSZ(3);
  @$pb.TagNumber(4)
  set sourceCurrency($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasSourceCurrency() => $_has(3);
  @$pb.TagNumber(4)
  void clearSourceCurrency() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get destinationCurrency => $_getSZ(4);
  @$pb.TagNumber(5)
  set destinationCurrency($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasDestinationCurrency() => $_has(4);
  @$pb.TagNumber(5)
  void clearDestinationCurrency() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.double get rate => $_getN(5);
  @$pb.TagNumber(6)
  set rate($core.double value) => $_setDouble(5, value);
  @$pb.TagNumber(6)
  $core.bool hasRate() => $_has(5);
  @$pb.TagNumber(6)
  void clearRate() => $_clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get fee => $_getI64(6);
  @$pb.TagNumber(7)
  set fee($fixnum.Int64 value) => $_setInt64(6, value);
  @$pb.TagNumber(7)
  $core.bool hasFee() => $_has(6);
  @$pb.TagNumber(7)
  void clearFee() => $_clearField(7);

  @$pb.TagNumber(8)
  $fixnum.Int64 get destinationAmount => $_getI64(7);
  @$pb.TagNumber(8)
  set destinationAmount($fixnum.Int64 value) => $_setInt64(7, value);
  @$pb.TagNumber(8)
  $core.bool hasDestinationAmount() => $_has(7);
  @$pb.TagNumber(8)
  void clearDestinationAmount() => $_clearField(8);
}

class GetSupportedCountriesRequest extends $pb.GeneratedMessage {
  factory GetSupportedCountriesRequest() => create();

  GetSupportedCountriesRequest._();

  factory GetSupportedCountriesRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetSupportedCountriesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetSupportedCountriesRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSupportedCountriesRequest clone() =>
      GetSupportedCountriesRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSupportedCountriesRequest copyWith(
          void Function(GetSupportedCountriesRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetSupportedCountriesRequest))
          as GetSupportedCountriesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSupportedCountriesRequest create() =>
      GetSupportedCountriesRequest._();
  @$core.override
  GetSupportedCountriesRequest createEmptyInstance() => create();
  static $pb.PbList<GetSupportedCountriesRequest> createRepeated() =>
      $pb.PbList<GetSupportedCountriesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetSupportedCountriesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetSupportedCountriesRequest>(create);
  static GetSupportedCountriesRequest? _defaultInstance;
}

class SupportedCountriesResponse extends $pb.GeneratedMessage {
  factory SupportedCountriesResponse({
    $core.bool? success,
    $core.Iterable<$core.String>? countries,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (countries != null) result.countries.addAll(countries);
    return result;
  }

  SupportedCountriesResponse._();

  factory SupportedCountriesResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SupportedCountriesResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SupportedCountriesResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..pPS(2, _omitFieldNames ? '' : 'countries')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SupportedCountriesResponse clone() =>
      SupportedCountriesResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SupportedCountriesResponse copyWith(
          void Function(SupportedCountriesResponse) updates) =>
      super.copyWith(
              (message) => updates(message as SupportedCountriesResponse))
          as SupportedCountriesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SupportedCountriesResponse create() => SupportedCountriesResponse._();
  @$core.override
  SupportedCountriesResponse createEmptyInstance() => create();
  static $pb.PbList<SupportedCountriesResponse> createRepeated() =>
      $pb.PbList<SupportedCountriesResponse>();
  @$core.pragma('dart2js:noInline')
  static SupportedCountriesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SupportedCountriesResponse>(create);
  static SupportedCountriesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<$core.String> get countries => $_getList(1);
}

class VerifyBankAccountRequest extends $pb.GeneratedMessage {
  factory VerifyBankAccountRequest({
    $core.String? accountNumber,
    $core.String? bankCode,
  }) {
    final result = create();
    if (accountNumber != null) result.accountNumber = accountNumber;
    if (bankCode != null) result.bankCode = bankCode;
    return result;
  }

  VerifyBankAccountRequest._();

  factory VerifyBankAccountRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VerifyBankAccountRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VerifyBankAccountRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountNumber')
    ..aOS(2, _omitFieldNames ? '' : 'bankCode')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyBankAccountRequest clone() =>
      VerifyBankAccountRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyBankAccountRequest copyWith(
          void Function(VerifyBankAccountRequest) updates) =>
      super.copyWith((message) => updates(message as VerifyBankAccountRequest))
          as VerifyBankAccountRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VerifyBankAccountRequest create() => VerifyBankAccountRequest._();
  @$core.override
  VerifyBankAccountRequest createEmptyInstance() => create();
  static $pb.PbList<VerifyBankAccountRequest> createRepeated() =>
      $pb.PbList<VerifyBankAccountRequest>();
  @$core.pragma('dart2js:noInline')
  static VerifyBankAccountRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VerifyBankAccountRequest>(create);
  static VerifyBankAccountRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountNumber => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountNumber($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAccountNumber() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountNumber() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get bankCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set bankCode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasBankCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearBankCode() => $_clearField(2);
}

class VerifyBankAccountResponse extends $pb.GeneratedMessage {
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
    final result = create();
    if (success != null) result.success = success;
    if (errorCode != null) result.errorCode = errorCode;
    if (errorMessage != null) result.errorMessage = errorMessage;
    if (accountNumber != null) result.accountNumber = accountNumber;
    if (accountName != null) result.accountName = accountName;
    if (bankCode != null) result.bankCode = bankCode;
    if (bankName != null) result.bankName = bankName;
    if (isValid != null) result.isValid = isValid;
    return result;
  }

  VerifyBankAccountResponse._();

  factory VerifyBankAccountResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VerifyBankAccountResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VerifyBankAccountResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'errorCode')
    ..aOS(3, _omitFieldNames ? '' : 'errorMessage')
    ..aOS(4, _omitFieldNames ? '' : 'accountNumber')
    ..aOS(5, _omitFieldNames ? '' : 'accountName')
    ..aOS(6, _omitFieldNames ? '' : 'bankCode')
    ..aOS(7, _omitFieldNames ? '' : 'bankName')
    ..aOB(8, _omitFieldNames ? '' : 'isValid')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyBankAccountResponse clone() =>
      VerifyBankAccountResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyBankAccountResponse copyWith(
          void Function(VerifyBankAccountResponse) updates) =>
      super.copyWith((message) => updates(message as VerifyBankAccountResponse))
          as VerifyBankAccountResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VerifyBankAccountResponse create() => VerifyBankAccountResponse._();
  @$core.override
  VerifyBankAccountResponse createEmptyInstance() => create();
  static $pb.PbList<VerifyBankAccountResponse> createRepeated() =>
      $pb.PbList<VerifyBankAccountResponse>();
  @$core.pragma('dart2js:noInline')
  static VerifyBankAccountResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VerifyBankAccountResponse>(create);
  static VerifyBankAccountResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get accountNumber => $_getSZ(3);
  @$pb.TagNumber(4)
  set accountNumber($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAccountNumber() => $_has(3);
  @$pb.TagNumber(4)
  void clearAccountNumber() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get accountName => $_getSZ(4);
  @$pb.TagNumber(5)
  set accountName($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasAccountName() => $_has(4);
  @$pb.TagNumber(5)
  void clearAccountName() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get bankCode => $_getSZ(5);
  @$pb.TagNumber(6)
  set bankCode($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasBankCode() => $_has(5);
  @$pb.TagNumber(6)
  void clearBankCode() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get bankName => $_getSZ(6);
  @$pb.TagNumber(7)
  set bankName($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasBankName() => $_has(6);
  @$pb.TagNumber(7)
  void clearBankName() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.bool get isValid => $_getBF(7);
  @$pb.TagNumber(8)
  set isValid($core.bool value) => $_setBool(7, value);
  @$pb.TagNumber(8)
  $core.bool hasIsValid() => $_has(7);
  @$pb.TagNumber(8)
  void clearIsValid() => $_clearField(8);
}

class GetBanksRequest extends $pb.GeneratedMessage {
  factory GetBanksRequest({
    $core.String? country,
  }) {
    final result = create();
    if (country != null) result.country = country;
    return result;
  }

  GetBanksRequest._();

  factory GetBanksRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetBanksRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetBanksRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'country')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetBanksRequest clone() => GetBanksRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetBanksRequest copyWith(void Function(GetBanksRequest) updates) =>
      super.copyWith((message) => updates(message as GetBanksRequest))
          as GetBanksRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetBanksRequest create() => GetBanksRequest._();
  @$core.override
  GetBanksRequest createEmptyInstance() => create();
  static $pb.PbList<GetBanksRequest> createRepeated() =>
      $pb.PbList<GetBanksRequest>();
  @$core.pragma('dart2js:noInline')
  static GetBanksRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetBanksRequest>(create);
  static GetBanksRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get country => $_getSZ(0);
  @$pb.TagNumber(1)
  set country($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCountry() => $_has(0);
  @$pb.TagNumber(1)
  void clearCountry() => $_clearField(1);
}

class BanksResponse extends $pb.GeneratedMessage {
  factory BanksResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
    $core.Iterable<Bank>? banks,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (errorCode != null) result.errorCode = errorCode;
    if (errorMessage != null) result.errorMessage = errorMessage;
    if (banks != null) result.banks.addAll(banks);
    return result;
  }

  BanksResponse._();

  factory BanksResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory BanksResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BanksResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'errorCode')
    ..aOS(3, _omitFieldNames ? '' : 'errorMessage')
    ..pc<Bank>(4, _omitFieldNames ? '' : 'banks', $pb.PbFieldType.PM,
        subBuilder: Bank.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BanksResponse clone() => BanksResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BanksResponse copyWith(void Function(BanksResponse) updates) =>
      super.copyWith((message) => updates(message as BanksResponse))
          as BanksResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BanksResponse create() => BanksResponse._();
  @$core.override
  BanksResponse createEmptyInstance() => create();
  static $pb.PbList<BanksResponse> createRepeated() =>
      $pb.PbList<BanksResponse>();
  @$core.pragma('dart2js:noInline')
  static BanksResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BanksResponse>(create);
  static BanksResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => $_clearField(3);

  @$pb.TagNumber(4)
  $pb.PbList<Bank> get banks => $_getList(3);
}

class Bank extends $pb.GeneratedMessage {
  factory Bank({
    $core.String? code,
    $core.String? name,
    $core.String? country,
    $core.String? nipCode,
    $core.bool? isActive,
  }) {
    final result = create();
    if (code != null) result.code = code;
    if (name != null) result.name = name;
    if (country != null) result.country = country;
    if (nipCode != null) result.nipCode = nipCode;
    if (isActive != null) result.isActive = isActive;
    return result;
  }

  Bank._();

  factory Bank.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Bank.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Bank',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'code')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'country')
    ..aOS(4, _omitFieldNames ? '' : 'nipCode')
    ..aOB(5, _omitFieldNames ? '' : 'isActive')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Bank clone() => Bank()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Bank copyWith(void Function(Bank) updates) =>
      super.copyWith((message) => updates(message as Bank)) as Bank;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Bank create() => Bank._();
  @$core.override
  Bank createEmptyInstance() => create();
  static $pb.PbList<Bank> createRepeated() => $pb.PbList<Bank>();
  @$core.pragma('dart2js:noInline')
  static Bank getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Bank>(create);
  static Bank? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get code => $_getSZ(0);
  @$pb.TagNumber(1)
  set code($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearCode() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get country => $_getSZ(2);
  @$pb.TagNumber(3)
  set country($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCountry() => $_has(2);
  @$pb.TagNumber(3)
  void clearCountry() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get nipCode => $_getSZ(3);
  @$pb.TagNumber(4)
  set nipCode($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasNipCode() => $_has(3);
  @$pb.TagNumber(4)
  void clearNipCode() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.bool get isActive => $_getBF(4);
  @$pb.TagNumber(5)
  set isActive($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasIsActive() => $_has(4);
  @$pb.TagNumber(5)
  void clearIsActive() => $_clearField(5);
}

class VerifyBVNRequest extends $pb.GeneratedMessage {
  factory VerifyBVNRequest({
    $core.String? userId,
    $core.String? bvn,
    $core.String? firstName,
    $core.String? lastName,
    $core.String? dateOfBirth,
    $core.String? phoneNumber,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    if (bvn != null) result.bvn = bvn;
    if (firstName != null) result.firstName = firstName;
    if (lastName != null) result.lastName = lastName;
    if (dateOfBirth != null) result.dateOfBirth = dateOfBirth;
    if (phoneNumber != null) result.phoneNumber = phoneNumber;
    return result;
  }

  VerifyBVNRequest._();

  factory VerifyBVNRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VerifyBVNRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VerifyBVNRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'bvn')
    ..aOS(3, _omitFieldNames ? '' : 'firstName')
    ..aOS(4, _omitFieldNames ? '' : 'lastName')
    ..aOS(5, _omitFieldNames ? '' : 'dateOfBirth')
    ..aOS(6, _omitFieldNames ? '' : 'phoneNumber')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyBVNRequest clone() => VerifyBVNRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyBVNRequest copyWith(void Function(VerifyBVNRequest) updates) =>
      super.copyWith((message) => updates(message as VerifyBVNRequest))
          as VerifyBVNRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VerifyBVNRequest create() => VerifyBVNRequest._();
  @$core.override
  VerifyBVNRequest createEmptyInstance() => create();
  static $pb.PbList<VerifyBVNRequest> createRepeated() =>
      $pb.PbList<VerifyBVNRequest>();
  @$core.pragma('dart2js:noInline')
  static VerifyBVNRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VerifyBVNRequest>(create);
  static VerifyBVNRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get bvn => $_getSZ(1);
  @$pb.TagNumber(2)
  set bvn($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasBvn() => $_has(1);
  @$pb.TagNumber(2)
  void clearBvn() => $_clearField(2);

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
  $core.String get dateOfBirth => $_getSZ(4);
  @$pb.TagNumber(5)
  set dateOfBirth($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasDateOfBirth() => $_has(4);
  @$pb.TagNumber(5)
  void clearDateOfBirth() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get phoneNumber => $_getSZ(5);
  @$pb.TagNumber(6)
  set phoneNumber($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasPhoneNumber() => $_has(5);
  @$pb.TagNumber(6)
  void clearPhoneNumber() => $_clearField(6);
}

class GetVerificationStatusRequest extends $pb.GeneratedMessage {
  factory GetVerificationStatusRequest({
    $core.String? userId,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    return result;
  }

  GetVerificationStatusRequest._();

  factory GetVerificationStatusRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetVerificationStatusRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetVerificationStatusRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetVerificationStatusRequest clone() =>
      GetVerificationStatusRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetVerificationStatusRequest copyWith(
          void Function(GetVerificationStatusRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetVerificationStatusRequest))
          as GetVerificationStatusRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetVerificationStatusRequest create() =>
      GetVerificationStatusRequest._();
  @$core.override
  GetVerificationStatusRequest createEmptyInstance() => create();
  static $pb.PbList<GetVerificationStatusRequest> createRepeated() =>
      $pb.PbList<GetVerificationStatusRequest>();
  @$core.pragma('dart2js:noInline')
  static GetVerificationStatusRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetVerificationStatusRequest>(create);
  static GetVerificationStatusRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);
}

class IdentityVerificationResponse extends $pb.GeneratedMessage {
  factory IdentityVerificationResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
    IdentityVerification? verification,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (errorCode != null) result.errorCode = errorCode;
    if (errorMessage != null) result.errorMessage = errorMessage;
    if (verification != null) result.verification = verification;
    return result;
  }

  IdentityVerificationResponse._();

  factory IdentityVerificationResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory IdentityVerificationResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'IdentityVerificationResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'errorCode')
    ..aOS(3, _omitFieldNames ? '' : 'errorMessage')
    ..aOM<IdentityVerification>(4, _omitFieldNames ? '' : 'verification',
        subBuilder: IdentityVerification.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  IdentityVerificationResponse clone() =>
      IdentityVerificationResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  IdentityVerificationResponse copyWith(
          void Function(IdentityVerificationResponse) updates) =>
      super.copyWith(
              (message) => updates(message as IdentityVerificationResponse))
          as IdentityVerificationResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static IdentityVerificationResponse create() =>
      IdentityVerificationResponse._();
  @$core.override
  IdentityVerificationResponse createEmptyInstance() => create();
  static $pb.PbList<IdentityVerificationResponse> createRepeated() =>
      $pb.PbList<IdentityVerificationResponse>();
  @$core.pragma('dart2js:noInline')
  static IdentityVerificationResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<IdentityVerificationResponse>(create);
  static IdentityVerificationResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => $_clearField(3);

  @$pb.TagNumber(4)
  IdentityVerification get verification => $_getN(3);
  @$pb.TagNumber(4)
  set verification(IdentityVerification value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasVerification() => $_has(3);
  @$pb.TagNumber(4)
  void clearVerification() => $_clearField(4);
  @$pb.TagNumber(4)
  IdentityVerification ensureVerification() => $_ensure(3);
}

class IdentityVerification extends $pb.GeneratedMessage {
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
    final result = create();
    if (userId != null) result.userId = userId;
    if (bvn != null) result.bvn = bvn;
    if (firstName != null) result.firstName = firstName;
    if (lastName != null) result.lastName = lastName;
    if (middleName != null) result.middleName = middleName;
    if (dateOfBirth != null) result.dateOfBirth = dateOfBirth;
    if (phoneNumber != null) result.phoneNumber = phoneNumber;
    if (gender != null) result.gender = gender;
    if (status != null) result.status = status;
    if (provider != null) result.provider = provider;
    if (verifiedAt != null) result.verifiedAt = verifiedAt;
    return result;
  }

  IdentityVerification._();

  factory IdentityVerification.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory IdentityVerification.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'IdentityVerification',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'bvn')
    ..aOS(3, _omitFieldNames ? '' : 'firstName')
    ..aOS(4, _omitFieldNames ? '' : 'lastName')
    ..aOS(5, _omitFieldNames ? '' : 'middleName')
    ..aOS(6, _omitFieldNames ? '' : 'dateOfBirth')
    ..aOS(7, _omitFieldNames ? '' : 'phoneNumber')
    ..aOS(8, _omitFieldNames ? '' : 'gender')
    ..aOS(9, _omitFieldNames ? '' : 'status')
    ..aOS(10, _omitFieldNames ? '' : 'provider')
    ..aOM<$1.Timestamp>(11, _omitFieldNames ? '' : 'verifiedAt',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  IdentityVerification clone() =>
      IdentityVerification()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  IdentityVerification copyWith(void Function(IdentityVerification) updates) =>
      super.copyWith((message) => updates(message as IdentityVerification))
          as IdentityVerification;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static IdentityVerification create() => IdentityVerification._();
  @$core.override
  IdentityVerification createEmptyInstance() => create();
  static $pb.PbList<IdentityVerification> createRepeated() =>
      $pb.PbList<IdentityVerification>();
  @$core.pragma('dart2js:noInline')
  static IdentityVerification getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<IdentityVerification>(create);
  static IdentityVerification? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get bvn => $_getSZ(1);
  @$pb.TagNumber(2)
  set bvn($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasBvn() => $_has(1);
  @$pb.TagNumber(2)
  void clearBvn() => $_clearField(2);

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
  $core.String get middleName => $_getSZ(4);
  @$pb.TagNumber(5)
  set middleName($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasMiddleName() => $_has(4);
  @$pb.TagNumber(5)
  void clearMiddleName() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get dateOfBirth => $_getSZ(5);
  @$pb.TagNumber(6)
  set dateOfBirth($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasDateOfBirth() => $_has(5);
  @$pb.TagNumber(6)
  void clearDateOfBirth() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get phoneNumber => $_getSZ(6);
  @$pb.TagNumber(7)
  set phoneNumber($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasPhoneNumber() => $_has(6);
  @$pb.TagNumber(7)
  void clearPhoneNumber() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get gender => $_getSZ(7);
  @$pb.TagNumber(8)
  set gender($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasGender() => $_has(7);
  @$pb.TagNumber(8)
  void clearGender() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get status => $_getSZ(8);
  @$pb.TagNumber(9)
  set status($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasStatus() => $_has(8);
  @$pb.TagNumber(9)
  void clearStatus() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get provider => $_getSZ(9);
  @$pb.TagNumber(10)
  set provider($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasProvider() => $_has(9);
  @$pb.TagNumber(10)
  void clearProvider() => $_clearField(10);

  @$pb.TagNumber(11)
  $1.Timestamp get verifiedAt => $_getN(10);
  @$pb.TagNumber(11)
  set verifiedAt($1.Timestamp value) => $_setField(11, value);
  @$pb.TagNumber(11)
  $core.bool hasVerifiedAt() => $_has(10);
  @$pb.TagNumber(11)
  void clearVerifiedAt() => $_clearField(11);
  @$pb.TagNumber(11)
  $1.Timestamp ensureVerifiedAt() => $_ensure(10);
}

class GetProviderStatusRequest extends $pb.GeneratedMessage {
  factory GetProviderStatusRequest() => create();

  GetProviderStatusRequest._();

  factory GetProviderStatusRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetProviderStatusRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetProviderStatusRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetProviderStatusRequest clone() =>
      GetProviderStatusRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetProviderStatusRequest copyWith(
          void Function(GetProviderStatusRequest) updates) =>
      super.copyWith((message) => updates(message as GetProviderStatusRequest))
          as GetProviderStatusRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetProviderStatusRequest create() => GetProviderStatusRequest._();
  @$core.override
  GetProviderStatusRequest createEmptyInstance() => create();
  static $pb.PbList<GetProviderStatusRequest> createRepeated() =>
      $pb.PbList<GetProviderStatusRequest>();
  @$core.pragma('dart2js:noInline')
  static GetProviderStatusRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetProviderStatusRequest>(create);
  static GetProviderStatusRequest? _defaultInstance;
}

class ProviderStatusResponse extends $pb.GeneratedMessage {
  factory ProviderStatusResponse({
    $core.bool? success,
    $core.Iterable<$core.MapEntry<$core.String, ProviderHealth>>? providers,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (providers != null) result.providers.addEntries(providers);
    return result;
  }

  ProviderStatusResponse._();

  factory ProviderStatusResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ProviderStatusResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ProviderStatusResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..m<$core.String, ProviderHealth>(2, _omitFieldNames ? '' : 'providers',
        entryClassName: 'ProviderStatusResponse.ProvidersEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: ProviderHealth.create,
        valueDefaultOrMaker: ProviderHealth.getDefault,
        packageName: const $pb.PackageName('banking'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProviderStatusResponse clone() =>
      ProviderStatusResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProviderStatusResponse copyWith(
          void Function(ProviderStatusResponse) updates) =>
      super.copyWith((message) => updates(message as ProviderStatusResponse))
          as ProviderStatusResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ProviderStatusResponse create() => ProviderStatusResponse._();
  @$core.override
  ProviderStatusResponse createEmptyInstance() => create();
  static $pb.PbList<ProviderStatusResponse> createRepeated() =>
      $pb.PbList<ProviderStatusResponse>();
  @$core.pragma('dart2js:noInline')
  static ProviderStatusResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ProviderStatusResponse>(create);
  static ProviderStatusResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbMap<$core.String, ProviderHealth> get providers => $_getMap(1);
}

class ProviderHealth extends $pb.GeneratedMessage {
  factory ProviderHealth({
    $core.String? provider,
    $core.bool? isHealthy,
    $core.bool? isEnabled,
    $core.double? successRate,
    $core.int? avgLatencyMs,
    $1.Timestamp? lastCheck,
  }) {
    final result = create();
    if (provider != null) result.provider = provider;
    if (isHealthy != null) result.isHealthy = isHealthy;
    if (isEnabled != null) result.isEnabled = isEnabled;
    if (successRate != null) result.successRate = successRate;
    if (avgLatencyMs != null) result.avgLatencyMs = avgLatencyMs;
    if (lastCheck != null) result.lastCheck = lastCheck;
    return result;
  }

  ProviderHealth._();

  factory ProviderHealth.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ProviderHealth.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ProviderHealth',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'provider')
    ..aOB(2, _omitFieldNames ? '' : 'isHealthy')
    ..aOB(3, _omitFieldNames ? '' : 'isEnabled')
    ..a<$core.double>(
        4, _omitFieldNames ? '' : 'successRate', $pb.PbFieldType.OD)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'avgLatencyMs', $pb.PbFieldType.O3)
    ..aOM<$1.Timestamp>(6, _omitFieldNames ? '' : 'lastCheck',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProviderHealth clone() => ProviderHealth()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProviderHealth copyWith(void Function(ProviderHealth) updates) =>
      super.copyWith((message) => updates(message as ProviderHealth))
          as ProviderHealth;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ProviderHealth create() => ProviderHealth._();
  @$core.override
  ProviderHealth createEmptyInstance() => create();
  static $pb.PbList<ProviderHealth> createRepeated() =>
      $pb.PbList<ProviderHealth>();
  @$core.pragma('dart2js:noInline')
  static ProviderHealth getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ProviderHealth>(create);
  static ProviderHealth? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get provider => $_getSZ(0);
  @$pb.TagNumber(1)
  set provider($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasProvider() => $_has(0);
  @$pb.TagNumber(1)
  void clearProvider() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get isHealthy => $_getBF(1);
  @$pb.TagNumber(2)
  set isHealthy($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasIsHealthy() => $_has(1);
  @$pb.TagNumber(2)
  void clearIsHealthy() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.bool get isEnabled => $_getBF(2);
  @$pb.TagNumber(3)
  set isEnabled($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasIsEnabled() => $_has(2);
  @$pb.TagNumber(3)
  void clearIsEnabled() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get successRate => $_getN(3);
  @$pb.TagNumber(4)
  set successRate($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasSuccessRate() => $_has(3);
  @$pb.TagNumber(4)
  void clearSuccessRate() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get avgLatencyMs => $_getIZ(4);
  @$pb.TagNumber(5)
  set avgLatencyMs($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasAvgLatencyMs() => $_has(4);
  @$pb.TagNumber(5)
  void clearAvgLatencyMs() => $_clearField(5);

  @$pb.TagNumber(6)
  $1.Timestamp get lastCheck => $_getN(5);
  @$pb.TagNumber(6)
  set lastCheck($1.Timestamp value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasLastCheck() => $_has(5);
  @$pb.TagNumber(6)
  void clearLastCheck() => $_clearField(6);
  @$pb.TagNumber(6)
  $1.Timestamp ensureLastCheck() => $_ensure(5);
}

class GetActiveProvidersRequest extends $pb.GeneratedMessage {
  factory GetActiveProvidersRequest() => create();

  GetActiveProvidersRequest._();

  factory GetActiveProvidersRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetActiveProvidersRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetActiveProvidersRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetActiveProvidersRequest clone() =>
      GetActiveProvidersRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetActiveProvidersRequest copyWith(
          void Function(GetActiveProvidersRequest) updates) =>
      super.copyWith((message) => updates(message as GetActiveProvidersRequest))
          as GetActiveProvidersRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetActiveProvidersRequest create() => GetActiveProvidersRequest._();
  @$core.override
  GetActiveProvidersRequest createEmptyInstance() => create();
  static $pb.PbList<GetActiveProvidersRequest> createRepeated() =>
      $pb.PbList<GetActiveProvidersRequest>();
  @$core.pragma('dart2js:noInline')
  static GetActiveProvidersRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetActiveProvidersRequest>(create);
  static GetActiveProvidersRequest? _defaultInstance;
}

class ActiveProvidersResponse extends $pb.GeneratedMessage {
  factory ActiveProvidersResponse({
    $core.bool? success,
    $core.String? virtualAccounts,
    $core.String? domesticTransfers,
    $core.String? internationalTransfers,
    $core.String? accountVerification,
    $core.String? identityVerification,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (virtualAccounts != null) result.virtualAccounts = virtualAccounts;
    if (domesticTransfers != null) result.domesticTransfers = domesticTransfers;
    if (internationalTransfers != null)
      result.internationalTransfers = internationalTransfers;
    if (accountVerification != null)
      result.accountVerification = accountVerification;
    if (identityVerification != null)
      result.identityVerification = identityVerification;
    return result;
  }

  ActiveProvidersResponse._();

  factory ActiveProvidersResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ActiveProvidersResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ActiveProvidersResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'virtualAccounts')
    ..aOS(3, _omitFieldNames ? '' : 'domesticTransfers')
    ..aOS(4, _omitFieldNames ? '' : 'internationalTransfers')
    ..aOS(5, _omitFieldNames ? '' : 'accountVerification')
    ..aOS(6, _omitFieldNames ? '' : 'identityVerification')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ActiveProvidersResponse clone() =>
      ActiveProvidersResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ActiveProvidersResponse copyWith(
          void Function(ActiveProvidersResponse) updates) =>
      super.copyWith((message) => updates(message as ActiveProvidersResponse))
          as ActiveProvidersResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ActiveProvidersResponse create() => ActiveProvidersResponse._();
  @$core.override
  ActiveProvidersResponse createEmptyInstance() => create();
  static $pb.PbList<ActiveProvidersResponse> createRepeated() =>
      $pb.PbList<ActiveProvidersResponse>();
  @$core.pragma('dart2js:noInline')
  static ActiveProvidersResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ActiveProvidersResponse>(create);
  static ActiveProvidersResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get virtualAccounts => $_getSZ(1);
  @$pb.TagNumber(2)
  set virtualAccounts($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasVirtualAccounts() => $_has(1);
  @$pb.TagNumber(2)
  void clearVirtualAccounts() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get domesticTransfers => $_getSZ(2);
  @$pb.TagNumber(3)
  set domesticTransfers($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDomesticTransfers() => $_has(2);
  @$pb.TagNumber(3)
  void clearDomesticTransfers() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get internationalTransfers => $_getSZ(3);
  @$pb.TagNumber(4)
  set internationalTransfers($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasInternationalTransfers() => $_has(3);
  @$pb.TagNumber(4)
  void clearInternationalTransfers() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get accountVerification => $_getSZ(4);
  @$pb.TagNumber(5)
  set accountVerification($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasAccountVerification() => $_has(4);
  @$pb.TagNumber(5)
  void clearAccountVerification() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get identityVerification => $_getSZ(5);
  @$pb.TagNumber(6)
  set identityVerification($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasIdentityVerification() => $_has(5);
  @$pb.TagNumber(6)
  void clearIdentityVerification() => $_clearField(6);
}

class WebhookEvent extends $pb.GeneratedMessage {
  factory WebhookEvent({
    $core.String? provider,
    $core.String? eventType,
    $core.String? eventId,
    $core.List<$core.int>? payload,
    $1.Timestamp? timestamp,
  }) {
    final result = create();
    if (provider != null) result.provider = provider;
    if (eventType != null) result.eventType = eventType;
    if (eventId != null) result.eventId = eventId;
    if (payload != null) result.payload = payload;
    if (timestamp != null) result.timestamp = timestamp;
    return result;
  }

  WebhookEvent._();

  factory WebhookEvent.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory WebhookEvent.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'WebhookEvent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'provider')
    ..aOS(2, _omitFieldNames ? '' : 'eventType')
    ..aOS(3, _omitFieldNames ? '' : 'eventId')
    ..a<$core.List<$core.int>>(
        4, _omitFieldNames ? '' : 'payload', $pb.PbFieldType.OY)
    ..aOM<$1.Timestamp>(5, _omitFieldNames ? '' : 'timestamp',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WebhookEvent clone() => WebhookEvent()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WebhookEvent copyWith(void Function(WebhookEvent) updates) =>
      super.copyWith((message) => updates(message as WebhookEvent))
          as WebhookEvent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WebhookEvent create() => WebhookEvent._();
  @$core.override
  WebhookEvent createEmptyInstance() => create();
  static $pb.PbList<WebhookEvent> createRepeated() =>
      $pb.PbList<WebhookEvent>();
  @$core.pragma('dart2js:noInline')
  static WebhookEvent getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<WebhookEvent>(create);
  static WebhookEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get provider => $_getSZ(0);
  @$pb.TagNumber(1)
  set provider($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasProvider() => $_has(0);
  @$pb.TagNumber(1)
  void clearProvider() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get eventType => $_getSZ(1);
  @$pb.TagNumber(2)
  set eventType($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasEventType() => $_has(1);
  @$pb.TagNumber(2)
  void clearEventType() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get eventId => $_getSZ(2);
  @$pb.TagNumber(3)
  set eventId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasEventId() => $_has(2);
  @$pb.TagNumber(3)
  void clearEventId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.List<$core.int> get payload => $_getN(3);
  @$pb.TagNumber(4)
  set payload($core.List<$core.int> value) => $_setBytes(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPayload() => $_has(3);
  @$pb.TagNumber(4)
  void clearPayload() => $_clearField(4);

  @$pb.TagNumber(5)
  $1.Timestamp get timestamp => $_getN(4);
  @$pb.TagNumber(5)
  set timestamp($1.Timestamp value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasTimestamp() => $_has(4);
  @$pb.TagNumber(5)
  void clearTimestamp() => $_clearField(5);
  @$pb.TagNumber(5)
  $1.Timestamp ensureTimestamp() => $_ensure(4);
}

class ProcessWebhookRequest extends $pb.GeneratedMessage {
  factory ProcessWebhookRequest({
    $core.String? provider,
    $core.List<$core.int>? payload,
    $core.String? signature,
  }) {
    final result = create();
    if (provider != null) result.provider = provider;
    if (payload != null) result.payload = payload;
    if (signature != null) result.signature = signature;
    return result;
  }

  ProcessWebhookRequest._();

  factory ProcessWebhookRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ProcessWebhookRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ProcessWebhookRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'provider')
    ..a<$core.List<$core.int>>(
        2, _omitFieldNames ? '' : 'payload', $pb.PbFieldType.OY)
    ..aOS(3, _omitFieldNames ? '' : 'signature')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProcessWebhookRequest clone() =>
      ProcessWebhookRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProcessWebhookRequest copyWith(
          void Function(ProcessWebhookRequest) updates) =>
      super.copyWith((message) => updates(message as ProcessWebhookRequest))
          as ProcessWebhookRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ProcessWebhookRequest create() => ProcessWebhookRequest._();
  @$core.override
  ProcessWebhookRequest createEmptyInstance() => create();
  static $pb.PbList<ProcessWebhookRequest> createRepeated() =>
      $pb.PbList<ProcessWebhookRequest>();
  @$core.pragma('dart2js:noInline')
  static ProcessWebhookRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ProcessWebhookRequest>(create);
  static ProcessWebhookRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get provider => $_getSZ(0);
  @$pb.TagNumber(1)
  set provider($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasProvider() => $_has(0);
  @$pb.TagNumber(1)
  void clearProvider() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get payload => $_getN(1);
  @$pb.TagNumber(2)
  set payload($core.List<$core.int> value) => $_setBytes(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPayload() => $_has(1);
  @$pb.TagNumber(2)
  void clearPayload() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get signature => $_getSZ(2);
  @$pb.TagNumber(3)
  set signature($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSignature() => $_has(2);
  @$pb.TagNumber(3)
  void clearSignature() => $_clearField(3);
}

class ProcessWebhookResponse extends $pb.GeneratedMessage {
  factory ProcessWebhookResponse({
    $core.bool? success,
    $core.String? message,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    return result;
  }

  ProcessWebhookResponse._();

  factory ProcessWebhookResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ProcessWebhookResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ProcessWebhookResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProcessWebhookResponse clone() =>
      ProcessWebhookResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProcessWebhookResponse copyWith(
          void Function(ProcessWebhookResponse) updates) =>
      super.copyWith((message) => updates(message as ProcessWebhookResponse))
          as ProcessWebhookResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ProcessWebhookResponse create() => ProcessWebhookResponse._();
  @$core.override
  ProcessWebhookResponse createEmptyInstance() => create();
  static $pb.PbList<ProcessWebhookResponse> createRepeated() =>
      $pb.PbList<ProcessWebhookResponse>();
  @$core.pragma('dart2js:noInline')
  static ProcessWebhookResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ProcessWebhookResponse>(create);
  static ProcessWebhookResponse? _defaultInstance;

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

class VerifyBVNForSignupRequest extends $pb.GeneratedMessage {
  factory VerifyBVNForSignupRequest({
    $core.String? userId,
    $core.String? bvn,
    $core.String? firstName,
    $core.String? lastName,
    $core.String? dateOfBirth,
    $core.String? phoneNumber,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    if (bvn != null) result.bvn = bvn;
    if (firstName != null) result.firstName = firstName;
    if (lastName != null) result.lastName = lastName;
    if (dateOfBirth != null) result.dateOfBirth = dateOfBirth;
    if (phoneNumber != null) result.phoneNumber = phoneNumber;
    return result;
  }

  VerifyBVNForSignupRequest._();

  factory VerifyBVNForSignupRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VerifyBVNForSignupRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VerifyBVNForSignupRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'bvn')
    ..aOS(3, _omitFieldNames ? '' : 'firstName')
    ..aOS(4, _omitFieldNames ? '' : 'lastName')
    ..aOS(5, _omitFieldNames ? '' : 'dateOfBirth')
    ..aOS(6, _omitFieldNames ? '' : 'phoneNumber')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyBVNForSignupRequest clone() =>
      VerifyBVNForSignupRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyBVNForSignupRequest copyWith(
          void Function(VerifyBVNForSignupRequest) updates) =>
      super.copyWith((message) => updates(message as VerifyBVNForSignupRequest))
          as VerifyBVNForSignupRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VerifyBVNForSignupRequest create() => VerifyBVNForSignupRequest._();
  @$core.override
  VerifyBVNForSignupRequest createEmptyInstance() => create();
  static $pb.PbList<VerifyBVNForSignupRequest> createRepeated() =>
      $pb.PbList<VerifyBVNForSignupRequest>();
  @$core.pragma('dart2js:noInline')
  static VerifyBVNForSignupRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VerifyBVNForSignupRequest>(create);
  static VerifyBVNForSignupRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get bvn => $_getSZ(1);
  @$pb.TagNumber(2)
  set bvn($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasBvn() => $_has(1);
  @$pb.TagNumber(2)
  void clearBvn() => $_clearField(2);

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
  $core.String get dateOfBirth => $_getSZ(4);
  @$pb.TagNumber(5)
  set dateOfBirth($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasDateOfBirth() => $_has(4);
  @$pb.TagNumber(5)
  void clearDateOfBirth() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get phoneNumber => $_getSZ(5);
  @$pb.TagNumber(6)
  set phoneNumber($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasPhoneNumber() => $_has(5);
  @$pb.TagNumber(6)
  void clearPhoneNumber() => $_clearField(6);
}

class VerifyNINForSignupRequest extends $pb.GeneratedMessage {
  factory VerifyNINForSignupRequest({
    $core.String? userId,
    $core.String? nin,
    $core.String? firstName,
    $core.String? lastName,
    $core.String? dateOfBirth,
    $core.String? phoneNumber,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    if (nin != null) result.nin = nin;
    if (firstName != null) result.firstName = firstName;
    if (lastName != null) result.lastName = lastName;
    if (dateOfBirth != null) result.dateOfBirth = dateOfBirth;
    if (phoneNumber != null) result.phoneNumber = phoneNumber;
    return result;
  }

  VerifyNINForSignupRequest._();

  factory VerifyNINForSignupRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VerifyNINForSignupRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VerifyNINForSignupRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'nin')
    ..aOS(3, _omitFieldNames ? '' : 'firstName')
    ..aOS(4, _omitFieldNames ? '' : 'lastName')
    ..aOS(5, _omitFieldNames ? '' : 'dateOfBirth')
    ..aOS(6, _omitFieldNames ? '' : 'phoneNumber')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyNINForSignupRequest clone() =>
      VerifyNINForSignupRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyNINForSignupRequest copyWith(
          void Function(VerifyNINForSignupRequest) updates) =>
      super.copyWith((message) => updates(message as VerifyNINForSignupRequest))
          as VerifyNINForSignupRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VerifyNINForSignupRequest create() => VerifyNINForSignupRequest._();
  @$core.override
  VerifyNINForSignupRequest createEmptyInstance() => create();
  static $pb.PbList<VerifyNINForSignupRequest> createRepeated() =>
      $pb.PbList<VerifyNINForSignupRequest>();
  @$core.pragma('dart2js:noInline')
  static VerifyNINForSignupRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VerifyNINForSignupRequest>(create);
  static VerifyNINForSignupRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get nin => $_getSZ(1);
  @$pb.TagNumber(2)
  set nin($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNin() => $_has(1);
  @$pb.TagNumber(2)
  void clearNin() => $_clearField(2);

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
  $core.String get dateOfBirth => $_getSZ(4);
  @$pb.TagNumber(5)
  set dateOfBirth($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasDateOfBirth() => $_has(4);
  @$pb.TagNumber(5)
  void clearDateOfBirth() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get phoneNumber => $_getSZ(5);
  @$pb.TagNumber(6)
  set phoneNumber($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasPhoneNumber() => $_has(5);
  @$pb.TagNumber(6)
  void clearPhoneNumber() => $_clearField(6);
}

class SignupIdentityVerificationResponse extends $pb.GeneratedMessage {
  factory SignupIdentityVerificationResponse({
    $core.bool? success,
    $core.bool? verified,
    $core.String? errorCode,
    $core.String? errorMessage,
    VerifiedIdentityDetails? identity,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (verified != null) result.verified = verified;
    if (errorCode != null) result.errorCode = errorCode;
    if (errorMessage != null) result.errorMessage = errorMessage;
    if (identity != null) result.identity = identity;
    return result;
  }

  SignupIdentityVerificationResponse._();

  factory SignupIdentityVerificationResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SignupIdentityVerificationResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SignupIdentityVerificationResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOB(2, _omitFieldNames ? '' : 'verified')
    ..aOS(3, _omitFieldNames ? '' : 'errorCode')
    ..aOS(4, _omitFieldNames ? '' : 'errorMessage')
    ..aOM<VerifiedIdentityDetails>(5, _omitFieldNames ? '' : 'identity',
        subBuilder: VerifiedIdentityDetails.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SignupIdentityVerificationResponse clone() =>
      SignupIdentityVerificationResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SignupIdentityVerificationResponse copyWith(
          void Function(SignupIdentityVerificationResponse) updates) =>
      super.copyWith((message) =>
              updates(message as SignupIdentityVerificationResponse))
          as SignupIdentityVerificationResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SignupIdentityVerificationResponse create() =>
      SignupIdentityVerificationResponse._();
  @$core.override
  SignupIdentityVerificationResponse createEmptyInstance() => create();
  static $pb.PbList<SignupIdentityVerificationResponse> createRepeated() =>
      $pb.PbList<SignupIdentityVerificationResponse>();
  @$core.pragma('dart2js:noInline')
  static SignupIdentityVerificationResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SignupIdentityVerificationResponse>(
          create);
  static SignupIdentityVerificationResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get verified => $_getBF(1);
  @$pb.TagNumber(2)
  set verified($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasVerified() => $_has(1);
  @$pb.TagNumber(2)
  void clearVerified() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorCode => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorCode($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasErrorCode() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorCode() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get errorMessage => $_getSZ(3);
  @$pb.TagNumber(4)
  set errorMessage($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasErrorMessage() => $_has(3);
  @$pb.TagNumber(4)
  void clearErrorMessage() => $_clearField(4);

  @$pb.TagNumber(5)
  VerifiedIdentityDetails get identity => $_getN(4);
  @$pb.TagNumber(5)
  set identity(VerifiedIdentityDetails value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasIdentity() => $_has(4);
  @$pb.TagNumber(5)
  void clearIdentity() => $_clearField(5);
  @$pb.TagNumber(5)
  VerifiedIdentityDetails ensureIdentity() => $_ensure(4);
}

class VerifiedIdentityDetails extends $pb.GeneratedMessage {
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
    final result = create();
    if (firstName != null) result.firstName = firstName;
    if (lastName != null) result.lastName = lastName;
    if (middleName != null) result.middleName = middleName;
    if (phoneNumber != null) result.phoneNumber = phoneNumber;
    if (dateOfBirth != null) result.dateOfBirth = dateOfBirth;
    if (gender != null) result.gender = gender;
    if (photoUrl != null) result.photoUrl = photoUrl;
    if (address != null) result.address = address;
    if (stateOfOrigin != null) result.stateOfOrigin = stateOfOrigin;
    if (lgaOfOrigin != null) result.lgaOfOrigin = lgaOfOrigin;
    return result;
  }

  VerifiedIdentityDetails._();

  factory VerifiedIdentityDetails.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VerifiedIdentityDetails.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VerifiedIdentityDetails',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'firstName')
    ..aOS(2, _omitFieldNames ? '' : 'lastName')
    ..aOS(3, _omitFieldNames ? '' : 'middleName')
    ..aOS(4, _omitFieldNames ? '' : 'phoneNumber')
    ..aOS(5, _omitFieldNames ? '' : 'dateOfBirth')
    ..aOS(6, _omitFieldNames ? '' : 'gender')
    ..aOS(7, _omitFieldNames ? '' : 'photoUrl')
    ..aOS(8, _omitFieldNames ? '' : 'address')
    ..aOS(9, _omitFieldNames ? '' : 'stateOfOrigin')
    ..aOS(10, _omitFieldNames ? '' : 'lgaOfOrigin')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifiedIdentityDetails clone() =>
      VerifiedIdentityDetails()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifiedIdentityDetails copyWith(
          void Function(VerifiedIdentityDetails) updates) =>
      super.copyWith((message) => updates(message as VerifiedIdentityDetails))
          as VerifiedIdentityDetails;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VerifiedIdentityDetails create() => VerifiedIdentityDetails._();
  @$core.override
  VerifiedIdentityDetails createEmptyInstance() => create();
  static $pb.PbList<VerifiedIdentityDetails> createRepeated() =>
      $pb.PbList<VerifiedIdentityDetails>();
  @$core.pragma('dart2js:noInline')
  static VerifiedIdentityDetails getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VerifiedIdentityDetails>(create);
  static VerifiedIdentityDetails? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get firstName => $_getSZ(0);
  @$pb.TagNumber(1)
  set firstName($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFirstName() => $_has(0);
  @$pb.TagNumber(1)
  void clearFirstName() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get lastName => $_getSZ(1);
  @$pb.TagNumber(2)
  set lastName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLastName() => $_has(1);
  @$pb.TagNumber(2)
  void clearLastName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get middleName => $_getSZ(2);
  @$pb.TagNumber(3)
  set middleName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMiddleName() => $_has(2);
  @$pb.TagNumber(3)
  void clearMiddleName() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get phoneNumber => $_getSZ(3);
  @$pb.TagNumber(4)
  set phoneNumber($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPhoneNumber() => $_has(3);
  @$pb.TagNumber(4)
  void clearPhoneNumber() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get dateOfBirth => $_getSZ(4);
  @$pb.TagNumber(5)
  set dateOfBirth($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasDateOfBirth() => $_has(4);
  @$pb.TagNumber(5)
  void clearDateOfBirth() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get gender => $_getSZ(5);
  @$pb.TagNumber(6)
  set gender($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasGender() => $_has(5);
  @$pb.TagNumber(6)
  void clearGender() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get photoUrl => $_getSZ(6);
  @$pb.TagNumber(7)
  set photoUrl($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasPhotoUrl() => $_has(6);
  @$pb.TagNumber(7)
  void clearPhotoUrl() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get address => $_getSZ(7);
  @$pb.TagNumber(8)
  set address($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasAddress() => $_has(7);
  @$pb.TagNumber(8)
  void clearAddress() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get stateOfOrigin => $_getSZ(8);
  @$pb.TagNumber(9)
  set stateOfOrigin($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasStateOfOrigin() => $_has(8);
  @$pb.TagNumber(9)
  void clearStateOfOrigin() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get lgaOfOrigin => $_getSZ(9);
  @$pb.TagNumber(10)
  set lgaOfOrigin($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasLgaOfOrigin() => $_has(9);
  @$pb.TagNumber(10)
  void clearLgaOfOrigin() => $_clearField(10);
}

class CreateVirtualAccountForUserRequest extends $pb.GeneratedMessage {
  factory CreateVirtualAccountForUserRequest({
    $core.String? userId,
    $core.String? firstName,
    $core.String? lastName,
    $core.String? email,
    $core.String? phoneNumber,
    $core.String? bvn,
    $core.String? identityType,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    if (firstName != null) result.firstName = firstName;
    if (lastName != null) result.lastName = lastName;
    if (email != null) result.email = email;
    if (phoneNumber != null) result.phoneNumber = phoneNumber;
    if (bvn != null) result.bvn = bvn;
    if (identityType != null) result.identityType = identityType;
    return result;
  }

  CreateVirtualAccountForUserRequest._();

  factory CreateVirtualAccountForUserRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateVirtualAccountForUserRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateVirtualAccountForUserRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'firstName')
    ..aOS(3, _omitFieldNames ? '' : 'lastName')
    ..aOS(4, _omitFieldNames ? '' : 'email')
    ..aOS(5, _omitFieldNames ? '' : 'phoneNumber')
    ..aOS(6, _omitFieldNames ? '' : 'bvn')
    ..aOS(7, _omitFieldNames ? '' : 'identityType')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateVirtualAccountForUserRequest clone() =>
      CreateVirtualAccountForUserRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateVirtualAccountForUserRequest copyWith(
          void Function(CreateVirtualAccountForUserRequest) updates) =>
      super.copyWith((message) =>
              updates(message as CreateVirtualAccountForUserRequest))
          as CreateVirtualAccountForUserRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateVirtualAccountForUserRequest create() =>
      CreateVirtualAccountForUserRequest._();
  @$core.override
  CreateVirtualAccountForUserRequest createEmptyInstance() => create();
  static $pb.PbList<CreateVirtualAccountForUserRequest> createRepeated() =>
      $pb.PbList<CreateVirtualAccountForUserRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateVirtualAccountForUserRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateVirtualAccountForUserRequest>(
          create);
  static CreateVirtualAccountForUserRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

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
  $core.String get bvn => $_getSZ(5);
  @$pb.TagNumber(6)
  set bvn($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasBvn() => $_has(5);
  @$pb.TagNumber(6)
  void clearBvn() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get identityType => $_getSZ(6);
  @$pb.TagNumber(7)
  set identityType($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasIdentityType() => $_has(6);
  @$pb.TagNumber(7)
  void clearIdentityType() => $_clearField(7);
}

class UsernameTransferRequest extends $pb.GeneratedMessage {
  factory UsernameTransferRequest({
    $core.String? userId,
    $core.String? toUsername,
    $fixnum.Int64? amount,
    $core.String? currency,
    $core.String? narration,
    $core.String? idempotencyKey,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    if (toUsername != null) result.toUsername = toUsername;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    if (narration != null) result.narration = narration;
    if (idempotencyKey != null) result.idempotencyKey = idempotencyKey;
    return result;
  }

  UsernameTransferRequest._();

  factory UsernameTransferRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UsernameTransferRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UsernameTransferRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'toUsername')
    ..aInt64(3, _omitFieldNames ? '' : 'amount')
    ..aOS(4, _omitFieldNames ? '' : 'currency')
    ..aOS(5, _omitFieldNames ? '' : 'narration')
    ..aOS(6, _omitFieldNames ? '' : 'idempotencyKey')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UsernameTransferRequest clone() =>
      UsernameTransferRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UsernameTransferRequest copyWith(
          void Function(UsernameTransferRequest) updates) =>
      super.copyWith((message) => updates(message as UsernameTransferRequest))
          as UsernameTransferRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UsernameTransferRequest create() => UsernameTransferRequest._();
  @$core.override
  UsernameTransferRequest createEmptyInstance() => create();
  static $pb.PbList<UsernameTransferRequest> createRepeated() =>
      $pb.PbList<UsernameTransferRequest>();
  @$core.pragma('dart2js:noInline')
  static UsernameTransferRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UsernameTransferRequest>(create);
  static UsernameTransferRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get toUsername => $_getSZ(1);
  @$pb.TagNumber(2)
  set toUsername($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasToUsername() => $_has(1);
  @$pb.TagNumber(2)
  void clearToUsername() => $_clearField(2);

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
  $core.String get narration => $_getSZ(4);
  @$pb.TagNumber(5)
  set narration($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasNarration() => $_has(4);
  @$pb.TagNumber(5)
  void clearNarration() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get idempotencyKey => $_getSZ(5);
  @$pb.TagNumber(6)
  set idempotencyKey($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasIdempotencyKey() => $_has(5);
  @$pb.TagNumber(6)
  void clearIdempotencyKey() => $_clearField(6);
}

class PhoneTransferRequest extends $pb.GeneratedMessage {
  factory PhoneTransferRequest({
    $core.String? userId,
    $core.String? toPhone,
    $fixnum.Int64? amount,
    $core.String? currency,
    $core.String? narration,
    $core.String? idempotencyKey,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    if (toPhone != null) result.toPhone = toPhone;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    if (narration != null) result.narration = narration;
    if (idempotencyKey != null) result.idempotencyKey = idempotencyKey;
    return result;
  }

  PhoneTransferRequest._();

  factory PhoneTransferRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PhoneTransferRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PhoneTransferRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'toPhone')
    ..aInt64(3, _omitFieldNames ? '' : 'amount')
    ..aOS(4, _omitFieldNames ? '' : 'currency')
    ..aOS(5, _omitFieldNames ? '' : 'narration')
    ..aOS(6, _omitFieldNames ? '' : 'idempotencyKey')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PhoneTransferRequest clone() =>
      PhoneTransferRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PhoneTransferRequest copyWith(void Function(PhoneTransferRequest) updates) =>
      super.copyWith((message) => updates(message as PhoneTransferRequest))
          as PhoneTransferRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PhoneTransferRequest create() => PhoneTransferRequest._();
  @$core.override
  PhoneTransferRequest createEmptyInstance() => create();
  static $pb.PbList<PhoneTransferRequest> createRepeated() =>
      $pb.PbList<PhoneTransferRequest>();
  @$core.pragma('dart2js:noInline')
  static PhoneTransferRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PhoneTransferRequest>(create);
  static PhoneTransferRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get toPhone => $_getSZ(1);
  @$pb.TagNumber(2)
  set toPhone($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasToPhone() => $_has(1);
  @$pb.TagNumber(2)
  void clearToPhone() => $_clearField(2);

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
  $core.String get narration => $_getSZ(4);
  @$pb.TagNumber(5)
  set narration($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasNarration() => $_has(4);
  @$pb.TagNumber(5)
  void clearNarration() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get idempotencyKey => $_getSZ(5);
  @$pb.TagNumber(6)
  set idempotencyKey($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasIdempotencyKey() => $_has(5);
  @$pb.TagNumber(6)
  void clearIdempotencyKey() => $_clearField(6);
}

class SearchRecipientsRequest extends $pb.GeneratedMessage {
  factory SearchRecipientsRequest({
    $core.String? userId,
    $core.String? query,
    $core.int? limit,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    if (query != null) result.query = query;
    if (limit != null) result.limit = limit;
    return result;
  }

  SearchRecipientsRequest._();

  factory SearchRecipientsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SearchRecipientsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SearchRecipientsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'query')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchRecipientsRequest clone() =>
      SearchRecipientsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchRecipientsRequest copyWith(
          void Function(SearchRecipientsRequest) updates) =>
      super.copyWith((message) => updates(message as SearchRecipientsRequest))
          as SearchRecipientsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SearchRecipientsRequest create() => SearchRecipientsRequest._();
  @$core.override
  SearchRecipientsRequest createEmptyInstance() => create();
  static $pb.PbList<SearchRecipientsRequest> createRepeated() =>
      $pb.PbList<SearchRecipientsRequest>();
  @$core.pragma('dart2js:noInline')
  static SearchRecipientsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SearchRecipientsRequest>(create);
  static SearchRecipientsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get query => $_getSZ(1);
  @$pb.TagNumber(2)
  set query($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasQuery() => $_has(1);
  @$pb.TagNumber(2)
  void clearQuery() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get limit => $_getIZ(2);
  @$pb.TagNumber(3)
  set limit($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasLimit() => $_has(2);
  @$pb.TagNumber(3)
  void clearLimit() => $_clearField(3);
}

class GetRecentRecipientsRequest extends $pb.GeneratedMessage {
  factory GetRecentRecipientsRequest({
    $core.String? userId,
    $core.int? limit,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    if (limit != null) result.limit = limit;
    return result;
  }

  GetRecentRecipientsRequest._();

  factory GetRecentRecipientsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetRecentRecipientsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetRecentRecipientsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetRecentRecipientsRequest clone() =>
      GetRecentRecipientsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetRecentRecipientsRequest copyWith(
          void Function(GetRecentRecipientsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetRecentRecipientsRequest))
          as GetRecentRecipientsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetRecentRecipientsRequest create() => GetRecentRecipientsRequest._();
  @$core.override
  GetRecentRecipientsRequest createEmptyInstance() => create();
  static $pb.PbList<GetRecentRecipientsRequest> createRepeated() =>
      $pb.PbList<GetRecentRecipientsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetRecentRecipientsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetRecentRecipientsRequest>(create);
  static GetRecentRecipientsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get limit => $_getIZ(1);
  @$pb.TagNumber(2)
  set limit($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearLimit() => $_clearField(2);
}

class RecipientsResponse extends $pb.GeneratedMessage {
  factory RecipientsResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
    $core.Iterable<TransferRecipient>? recipients,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (errorCode != null) result.errorCode = errorCode;
    if (errorMessage != null) result.errorMessage = errorMessage;
    if (recipients != null) result.recipients.addAll(recipients);
    return result;
  }

  RecipientsResponse._();

  factory RecipientsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RecipientsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RecipientsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'errorCode')
    ..aOS(3, _omitFieldNames ? '' : 'errorMessage')
    ..pc<TransferRecipient>(
        4, _omitFieldNames ? '' : 'recipients', $pb.PbFieldType.PM,
        subBuilder: TransferRecipient.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RecipientsResponse clone() => RecipientsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RecipientsResponse copyWith(void Function(RecipientsResponse) updates) =>
      super.copyWith((message) => updates(message as RecipientsResponse))
          as RecipientsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RecipientsResponse create() => RecipientsResponse._();
  @$core.override
  RecipientsResponse createEmptyInstance() => create();
  static $pb.PbList<RecipientsResponse> createRepeated() =>
      $pb.PbList<RecipientsResponse>();
  @$core.pragma('dart2js:noInline')
  static RecipientsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RecipientsResponse>(create);
  static RecipientsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => $_clearField(3);

  @$pb.TagNumber(4)
  $pb.PbList<TransferRecipient> get recipients => $_getList(3);
}

class TransferRecipient extends $pb.GeneratedMessage {
  factory TransferRecipient({
    $core.String? id,
    $core.String? userId,
    $core.String? recipientType,
    $core.String? identifier,
    $core.String? name,
    $core.String? profilePicture,
    $core.String? bankCode,
    $core.String? bankName,
    $core.String? accountNumber,
    $core.bool? isLazervaultUser,
    $1.Timestamp? lastTransferAt,
    $core.int? transferCount,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (userId != null) result.userId = userId;
    if (recipientType != null) result.recipientType = recipientType;
    if (identifier != null) result.identifier = identifier;
    if (name != null) result.name = name;
    if (profilePicture != null) result.profilePicture = profilePicture;
    if (bankCode != null) result.bankCode = bankCode;
    if (bankName != null) result.bankName = bankName;
    if (accountNumber != null) result.accountNumber = accountNumber;
    if (isLazervaultUser != null) result.isLazervaultUser = isLazervaultUser;
    if (lastTransferAt != null) result.lastTransferAt = lastTransferAt;
    if (transferCount != null) result.transferCount = transferCount;
    return result;
  }

  TransferRecipient._();

  factory TransferRecipient.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TransferRecipient.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TransferRecipient',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'recipientType')
    ..aOS(4, _omitFieldNames ? '' : 'identifier')
    ..aOS(5, _omitFieldNames ? '' : 'name')
    ..aOS(6, _omitFieldNames ? '' : 'profilePicture')
    ..aOS(7, _omitFieldNames ? '' : 'bankCode')
    ..aOS(8, _omitFieldNames ? '' : 'bankName')
    ..aOS(9, _omitFieldNames ? '' : 'accountNumber')
    ..aOB(10, _omitFieldNames ? '' : 'isLazervaultUser')
    ..aOM<$1.Timestamp>(11, _omitFieldNames ? '' : 'lastTransferAt',
        subBuilder: $1.Timestamp.create)
    ..a<$core.int>(
        12, _omitFieldNames ? '' : 'transferCount', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TransferRecipient clone() => TransferRecipient()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TransferRecipient copyWith(void Function(TransferRecipient) updates) =>
      super.copyWith((message) => updates(message as TransferRecipient))
          as TransferRecipient;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TransferRecipient create() => TransferRecipient._();
  @$core.override
  TransferRecipient createEmptyInstance() => create();
  static $pb.PbList<TransferRecipient> createRepeated() =>
      $pb.PbList<TransferRecipient>();
  @$core.pragma('dart2js:noInline')
  static TransferRecipient getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TransferRecipient>(create);
  static TransferRecipient? _defaultInstance;

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
  $core.String get recipientType => $_getSZ(2);
  @$pb.TagNumber(3)
  set recipientType($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasRecipientType() => $_has(2);
  @$pb.TagNumber(3)
  void clearRecipientType() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get identifier => $_getSZ(3);
  @$pb.TagNumber(4)
  set identifier($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasIdentifier() => $_has(3);
  @$pb.TagNumber(4)
  void clearIdentifier() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get name => $_getSZ(4);
  @$pb.TagNumber(5)
  set name($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasName() => $_has(4);
  @$pb.TagNumber(5)
  void clearName() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get profilePicture => $_getSZ(5);
  @$pb.TagNumber(6)
  set profilePicture($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasProfilePicture() => $_has(5);
  @$pb.TagNumber(6)
  void clearProfilePicture() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get bankCode => $_getSZ(6);
  @$pb.TagNumber(7)
  set bankCode($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasBankCode() => $_has(6);
  @$pb.TagNumber(7)
  void clearBankCode() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get bankName => $_getSZ(7);
  @$pb.TagNumber(8)
  set bankName($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasBankName() => $_has(7);
  @$pb.TagNumber(8)
  void clearBankName() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get accountNumber => $_getSZ(8);
  @$pb.TagNumber(9)
  set accountNumber($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasAccountNumber() => $_has(8);
  @$pb.TagNumber(9)
  void clearAccountNumber() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.bool get isLazervaultUser => $_getBF(9);
  @$pb.TagNumber(10)
  set isLazervaultUser($core.bool value) => $_setBool(9, value);
  @$pb.TagNumber(10)
  $core.bool hasIsLazervaultUser() => $_has(9);
  @$pb.TagNumber(10)
  void clearIsLazervaultUser() => $_clearField(10);

  @$pb.TagNumber(11)
  $1.Timestamp get lastTransferAt => $_getN(10);
  @$pb.TagNumber(11)
  set lastTransferAt($1.Timestamp value) => $_setField(11, value);
  @$pb.TagNumber(11)
  $core.bool hasLastTransferAt() => $_has(10);
  @$pb.TagNumber(11)
  void clearLastTransferAt() => $_clearField(11);
  @$pb.TagNumber(11)
  $1.Timestamp ensureLastTransferAt() => $_ensure(10);

  @$pb.TagNumber(12)
  $core.int get transferCount => $_getIZ(11);
  @$pb.TagNumber(12)
  set transferCount($core.int value) => $_setSignedInt32(11, value);
  @$pb.TagNumber(12)
  $core.bool hasTransferCount() => $_has(11);
  @$pb.TagNumber(12)
  void clearTransferCount() => $_clearField(12);
}

/// Account Balance
class GetAccountBalanceRequest extends $pb.GeneratedMessage {
  factory GetAccountBalanceRequest({
    $core.String? accountId,
  }) {
    final result = create();
    if (accountId != null) result.accountId = accountId;
    return result;
  }

  GetAccountBalanceRequest._();

  factory GetAccountBalanceRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetAccountBalanceRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetAccountBalanceRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAccountBalanceRequest clone() =>
      GetAccountBalanceRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAccountBalanceRequest copyWith(
          void Function(GetAccountBalanceRequest) updates) =>
      super.copyWith((message) => updates(message as GetAccountBalanceRequest))
          as GetAccountBalanceRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAccountBalanceRequest create() => GetAccountBalanceRequest._();
  @$core.override
  GetAccountBalanceRequest createEmptyInstance() => create();
  static $pb.PbList<GetAccountBalanceRequest> createRepeated() =>
      $pb.PbList<GetAccountBalanceRequest>();
  @$core.pragma('dart2js:noInline')
  static GetAccountBalanceRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetAccountBalanceRequest>(create);
  static GetAccountBalanceRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => $_clearField(1);
}

class AccountBalanceResponse extends $pb.GeneratedMessage {
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
    final result = create();
    if (success != null) result.success = success;
    if (errorCode != null) result.errorCode = errorCode;
    if (errorMessage != null) result.errorMessage = errorMessage;
    if (accountId != null) result.accountId = accountId;
    if (ledgerBalance != null) result.ledgerBalance = ledgerBalance;
    if (availableBalance != null) result.availableBalance = availableBalance;
    if (pendingCredits != null) result.pendingCredits = pendingCredits;
    if (pendingDebits != null) result.pendingDebits = pendingDebits;
    if (currency != null) result.currency = currency;
    return result;
  }

  AccountBalanceResponse._();

  factory AccountBalanceResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AccountBalanceResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AccountBalanceResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'errorCode')
    ..aOS(3, _omitFieldNames ? '' : 'errorMessage')
    ..aOS(4, _omitFieldNames ? '' : 'accountId')
    ..aInt64(5, _omitFieldNames ? '' : 'ledgerBalance')
    ..aInt64(6, _omitFieldNames ? '' : 'availableBalance')
    ..aInt64(7, _omitFieldNames ? '' : 'pendingCredits')
    ..aInt64(8, _omitFieldNames ? '' : 'pendingDebits')
    ..aOS(9, _omitFieldNames ? '' : 'currency')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AccountBalanceResponse clone() =>
      AccountBalanceResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AccountBalanceResponse copyWith(
          void Function(AccountBalanceResponse) updates) =>
      super.copyWith((message) => updates(message as AccountBalanceResponse))
          as AccountBalanceResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AccountBalanceResponse create() => AccountBalanceResponse._();
  @$core.override
  AccountBalanceResponse createEmptyInstance() => create();
  static $pb.PbList<AccountBalanceResponse> createRepeated() =>
      $pb.PbList<AccountBalanceResponse>();
  @$core.pragma('dart2js:noInline')
  static AccountBalanceResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AccountBalanceResponse>(create);
  static AccountBalanceResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get accountId => $_getSZ(3);
  @$pb.TagNumber(4)
  set accountId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAccountId() => $_has(3);
  @$pb.TagNumber(4)
  void clearAccountId() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get ledgerBalance => $_getI64(4);
  @$pb.TagNumber(5)
  set ledgerBalance($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasLedgerBalance() => $_has(4);
  @$pb.TagNumber(5)
  void clearLedgerBalance() => $_clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get availableBalance => $_getI64(5);
  @$pb.TagNumber(6)
  set availableBalance($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasAvailableBalance() => $_has(5);
  @$pb.TagNumber(6)
  void clearAvailableBalance() => $_clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get pendingCredits => $_getI64(6);
  @$pb.TagNumber(7)
  set pendingCredits($fixnum.Int64 value) => $_setInt64(6, value);
  @$pb.TagNumber(7)
  $core.bool hasPendingCredits() => $_has(6);
  @$pb.TagNumber(7)
  void clearPendingCredits() => $_clearField(7);

  @$pb.TagNumber(8)
  $fixnum.Int64 get pendingDebits => $_getI64(7);
  @$pb.TagNumber(8)
  set pendingDebits($fixnum.Int64 value) => $_setInt64(7, value);
  @$pb.TagNumber(8)
  $core.bool hasPendingDebits() => $_has(7);
  @$pb.TagNumber(8)
  void clearPendingDebits() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get currency => $_getSZ(8);
  @$pb.TagNumber(9)
  set currency($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasCurrency() => $_has(8);
  @$pb.TagNumber(9)
  void clearCurrency() => $_clearField(9);
}

/// Account Transactions
class GetAccountTransactionsRequest extends $pb.GeneratedMessage {
  factory GetAccountTransactionsRequest({
    $core.String? accountId,
    $core.int? limit,
    $core.int? offset,
  }) {
    final result = create();
    if (accountId != null) result.accountId = accountId;
    if (limit != null) result.limit = limit;
    if (offset != null) result.offset = offset;
    return result;
  }

  GetAccountTransactionsRequest._();

  factory GetAccountTransactionsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetAccountTransactionsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetAccountTransactionsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountId')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAccountTransactionsRequest clone() =>
      GetAccountTransactionsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAccountTransactionsRequest copyWith(
          void Function(GetAccountTransactionsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetAccountTransactionsRequest))
          as GetAccountTransactionsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAccountTransactionsRequest create() =>
      GetAccountTransactionsRequest._();
  @$core.override
  GetAccountTransactionsRequest createEmptyInstance() => create();
  static $pb.PbList<GetAccountTransactionsRequest> createRepeated() =>
      $pb.PbList<GetAccountTransactionsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetAccountTransactionsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetAccountTransactionsRequest>(create);
  static GetAccountTransactionsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => $_clearField(1);

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

class TransactionsResponse extends $pb.GeneratedMessage {
  factory TransactionsResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
    $core.Iterable<Transaction>? transactions,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (errorCode != null) result.errorCode = errorCode;
    if (errorMessage != null) result.errorMessage = errorMessage;
    if (transactions != null) result.transactions.addAll(transactions);
    return result;
  }

  TransactionsResponse._();

  factory TransactionsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TransactionsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TransactionsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'errorCode')
    ..aOS(3, _omitFieldNames ? '' : 'errorMessage')
    ..pc<Transaction>(
        4, _omitFieldNames ? '' : 'transactions', $pb.PbFieldType.PM,
        subBuilder: Transaction.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TransactionsResponse clone() =>
      TransactionsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TransactionsResponse copyWith(void Function(TransactionsResponse) updates) =>
      super.copyWith((message) => updates(message as TransactionsResponse))
          as TransactionsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TransactionsResponse create() => TransactionsResponse._();
  @$core.override
  TransactionsResponse createEmptyInstance() => create();
  static $pb.PbList<TransactionsResponse> createRepeated() =>
      $pb.PbList<TransactionsResponse>();
  @$core.pragma('dart2js:noInline')
  static TransactionsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TransactionsResponse>(create);
  static TransactionsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => $_clearField(3);

  @$pb.TagNumber(4)
  $pb.PbList<Transaction> get transactions => $_getList(3);
}

class Transaction extends $pb.GeneratedMessage {
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
    final result = create();
    if (id != null) result.id = id;
    if (accountId != null) result.accountId = accountId;
    if (userId != null) result.userId = userId;
    if (transferId != null) result.transferId = transferId;
    if (type != null) result.type = type;
    if (category != null) result.category = category;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    if (ledgerBalanceBefore != null)
      result.ledgerBalanceBefore = ledgerBalanceBefore;
    if (ledgerBalanceAfter != null)
      result.ledgerBalanceAfter = ledgerBalanceAfter;
    if (availableBalanceBefore != null)
      result.availableBalanceBefore = availableBalanceBefore;
    if (availableBalanceAfter != null)
      result.availableBalanceAfter = availableBalanceAfter;
    if (reference != null) result.reference = reference;
    if (description != null) result.description = description;
    if (narration != null) result.narration = narration;
    if (counterpartyAccountId != null)
      result.counterpartyAccountId = counterpartyAccountId;
    if (counterpartyName != null) result.counterpartyName = counterpartyName;
    if (counterpartyBank != null) result.counterpartyBank = counterpartyBank;
    if (counterpartyAccount != null)
      result.counterpartyAccount = counterpartyAccount;
    if (status != null) result.status = status;
    if (createdAt != null) result.createdAt = createdAt;
    if (settledAt != null) result.settledAt = settledAt;
    return result;
  }

  Transaction._();

  factory Transaction.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Transaction.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Transaction',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'accountId')
    ..aOS(3, _omitFieldNames ? '' : 'userId')
    ..aOS(4, _omitFieldNames ? '' : 'transferId')
    ..aOS(5, _omitFieldNames ? '' : 'type')
    ..aOS(6, _omitFieldNames ? '' : 'category')
    ..aInt64(7, _omitFieldNames ? '' : 'amount')
    ..aOS(8, _omitFieldNames ? '' : 'currency')
    ..aInt64(9, _omitFieldNames ? '' : 'ledgerBalanceBefore')
    ..aInt64(10, _omitFieldNames ? '' : 'ledgerBalanceAfter')
    ..aInt64(11, _omitFieldNames ? '' : 'availableBalanceBefore')
    ..aInt64(12, _omitFieldNames ? '' : 'availableBalanceAfter')
    ..aOS(13, _omitFieldNames ? '' : 'reference')
    ..aOS(14, _omitFieldNames ? '' : 'description')
    ..aOS(15, _omitFieldNames ? '' : 'narration')
    ..aOS(16, _omitFieldNames ? '' : 'counterpartyAccountId')
    ..aOS(17, _omitFieldNames ? '' : 'counterpartyName')
    ..aOS(18, _omitFieldNames ? '' : 'counterpartyBank')
    ..aOS(19, _omitFieldNames ? '' : 'counterpartyAccount')
    ..aOS(20, _omitFieldNames ? '' : 'status')
    ..aOM<$1.Timestamp>(21, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(22, _omitFieldNames ? '' : 'settledAt',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Transaction clone() => Transaction()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Transaction copyWith(void Function(Transaction) updates) =>
      super.copyWith((message) => updates(message as Transaction))
          as Transaction;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Transaction create() => Transaction._();
  @$core.override
  Transaction createEmptyInstance() => create();
  static $pb.PbList<Transaction> createRepeated() => $pb.PbList<Transaction>();
  @$core.pragma('dart2js:noInline')
  static Transaction getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Transaction>(create);
  static Transaction? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get accountId => $_getSZ(1);
  @$pb.TagNumber(2)
  set accountId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAccountId() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccountId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get userId => $_getSZ(2);
  @$pb.TagNumber(3)
  set userId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasUserId() => $_has(2);
  @$pb.TagNumber(3)
  void clearUserId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get transferId => $_getSZ(3);
  @$pb.TagNumber(4)
  set transferId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTransferId() => $_has(3);
  @$pb.TagNumber(4)
  void clearTransferId() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get type => $_getSZ(4);
  @$pb.TagNumber(5)
  set type($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasType() => $_has(4);
  @$pb.TagNumber(5)
  void clearType() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get category => $_getSZ(5);
  @$pb.TagNumber(6)
  set category($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasCategory() => $_has(5);
  @$pb.TagNumber(6)
  void clearCategory() => $_clearField(6);

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
  $fixnum.Int64 get ledgerBalanceBefore => $_getI64(8);
  @$pb.TagNumber(9)
  set ledgerBalanceBefore($fixnum.Int64 value) => $_setInt64(8, value);
  @$pb.TagNumber(9)
  $core.bool hasLedgerBalanceBefore() => $_has(8);
  @$pb.TagNumber(9)
  void clearLedgerBalanceBefore() => $_clearField(9);

  @$pb.TagNumber(10)
  $fixnum.Int64 get ledgerBalanceAfter => $_getI64(9);
  @$pb.TagNumber(10)
  set ledgerBalanceAfter($fixnum.Int64 value) => $_setInt64(9, value);
  @$pb.TagNumber(10)
  $core.bool hasLedgerBalanceAfter() => $_has(9);
  @$pb.TagNumber(10)
  void clearLedgerBalanceAfter() => $_clearField(10);

  @$pb.TagNumber(11)
  $fixnum.Int64 get availableBalanceBefore => $_getI64(10);
  @$pb.TagNumber(11)
  set availableBalanceBefore($fixnum.Int64 value) => $_setInt64(10, value);
  @$pb.TagNumber(11)
  $core.bool hasAvailableBalanceBefore() => $_has(10);
  @$pb.TagNumber(11)
  void clearAvailableBalanceBefore() => $_clearField(11);

  @$pb.TagNumber(12)
  $fixnum.Int64 get availableBalanceAfter => $_getI64(11);
  @$pb.TagNumber(12)
  set availableBalanceAfter($fixnum.Int64 value) => $_setInt64(11, value);
  @$pb.TagNumber(12)
  $core.bool hasAvailableBalanceAfter() => $_has(11);
  @$pb.TagNumber(12)
  void clearAvailableBalanceAfter() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.String get reference => $_getSZ(12);
  @$pb.TagNumber(13)
  set reference($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasReference() => $_has(12);
  @$pb.TagNumber(13)
  void clearReference() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.String get description => $_getSZ(13);
  @$pb.TagNumber(14)
  set description($core.String value) => $_setString(13, value);
  @$pb.TagNumber(14)
  $core.bool hasDescription() => $_has(13);
  @$pb.TagNumber(14)
  void clearDescription() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.String get narration => $_getSZ(14);
  @$pb.TagNumber(15)
  set narration($core.String value) => $_setString(14, value);
  @$pb.TagNumber(15)
  $core.bool hasNarration() => $_has(14);
  @$pb.TagNumber(15)
  void clearNarration() => $_clearField(15);

  @$pb.TagNumber(16)
  $core.String get counterpartyAccountId => $_getSZ(15);
  @$pb.TagNumber(16)
  set counterpartyAccountId($core.String value) => $_setString(15, value);
  @$pb.TagNumber(16)
  $core.bool hasCounterpartyAccountId() => $_has(15);
  @$pb.TagNumber(16)
  void clearCounterpartyAccountId() => $_clearField(16);

  @$pb.TagNumber(17)
  $core.String get counterpartyName => $_getSZ(16);
  @$pb.TagNumber(17)
  set counterpartyName($core.String value) => $_setString(16, value);
  @$pb.TagNumber(17)
  $core.bool hasCounterpartyName() => $_has(16);
  @$pb.TagNumber(17)
  void clearCounterpartyName() => $_clearField(17);

  @$pb.TagNumber(18)
  $core.String get counterpartyBank => $_getSZ(17);
  @$pb.TagNumber(18)
  set counterpartyBank($core.String value) => $_setString(17, value);
  @$pb.TagNumber(18)
  $core.bool hasCounterpartyBank() => $_has(17);
  @$pb.TagNumber(18)
  void clearCounterpartyBank() => $_clearField(18);

  @$pb.TagNumber(19)
  $core.String get counterpartyAccount => $_getSZ(18);
  @$pb.TagNumber(19)
  set counterpartyAccount($core.String value) => $_setString(18, value);
  @$pb.TagNumber(19)
  $core.bool hasCounterpartyAccount() => $_has(18);
  @$pb.TagNumber(19)
  void clearCounterpartyAccount() => $_clearField(19);

  @$pb.TagNumber(20)
  $core.String get status => $_getSZ(19);
  @$pb.TagNumber(20)
  set status($core.String value) => $_setString(19, value);
  @$pb.TagNumber(20)
  $core.bool hasStatus() => $_has(19);
  @$pb.TagNumber(20)
  void clearStatus() => $_clearField(20);

  @$pb.TagNumber(21)
  $1.Timestamp get createdAt => $_getN(20);
  @$pb.TagNumber(21)
  set createdAt($1.Timestamp value) => $_setField(21, value);
  @$pb.TagNumber(21)
  $core.bool hasCreatedAt() => $_has(20);
  @$pb.TagNumber(21)
  void clearCreatedAt() => $_clearField(21);
  @$pb.TagNumber(21)
  $1.Timestamp ensureCreatedAt() => $_ensure(20);

  @$pb.TagNumber(22)
  $1.Timestamp get settledAt => $_getN(21);
  @$pb.TagNumber(22)
  set settledAt($1.Timestamp value) => $_setField(22, value);
  @$pb.TagNumber(22)
  $core.bool hasSettledAt() => $_has(21);
  @$pb.TagNumber(22)
  void clearSettledAt() => $_clearField(22);
  @$pb.TagNumber(22)
  $1.Timestamp ensureSettledAt() => $_ensure(21);
}

/// Primary Account
class GetPrimaryAccountRequest extends $pb.GeneratedMessage {
  factory GetPrimaryAccountRequest({
    $core.String? userId,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    return result;
  }

  GetPrimaryAccountRequest._();

  factory GetPrimaryAccountRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetPrimaryAccountRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetPrimaryAccountRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPrimaryAccountRequest clone() =>
      GetPrimaryAccountRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPrimaryAccountRequest copyWith(
          void Function(GetPrimaryAccountRequest) updates) =>
      super.copyWith((message) => updates(message as GetPrimaryAccountRequest))
          as GetPrimaryAccountRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPrimaryAccountRequest create() => GetPrimaryAccountRequest._();
  @$core.override
  GetPrimaryAccountRequest createEmptyInstance() => create();
  static $pb.PbList<GetPrimaryAccountRequest> createRepeated() =>
      $pb.PbList<GetPrimaryAccountRequest>();
  @$core.pragma('dart2js:noInline')
  static GetPrimaryAccountRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetPrimaryAccountRequest>(create);
  static GetPrimaryAccountRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);
}

/// Account Freeze/Unfreeze
class FreezeAccountRequest extends $pb.GeneratedMessage {
  factory FreezeAccountRequest({
    $core.String? accountId,
    $core.String? reason,
    $core.String? description,
    $core.String? frozenBy,
  }) {
    final result = create();
    if (accountId != null) result.accountId = accountId;
    if (reason != null) result.reason = reason;
    if (description != null) result.description = description;
    if (frozenBy != null) result.frozenBy = frozenBy;
    return result;
  }

  FreezeAccountRequest._();

  factory FreezeAccountRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FreezeAccountRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FreezeAccountRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountId')
    ..aOS(2, _omitFieldNames ? '' : 'reason')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..aOS(4, _omitFieldNames ? '' : 'frozenBy')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FreezeAccountRequest clone() =>
      FreezeAccountRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FreezeAccountRequest copyWith(void Function(FreezeAccountRequest) updates) =>
      super.copyWith((message) => updates(message as FreezeAccountRequest))
          as FreezeAccountRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FreezeAccountRequest create() => FreezeAccountRequest._();
  @$core.override
  FreezeAccountRequest createEmptyInstance() => create();
  static $pb.PbList<FreezeAccountRequest> createRepeated() =>
      $pb.PbList<FreezeAccountRequest>();
  @$core.pragma('dart2js:noInline')
  static FreezeAccountRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FreezeAccountRequest>(create);
  static FreezeAccountRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get reason => $_getSZ(1);
  @$pb.TagNumber(2)
  set reason($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasReason() => $_has(1);
  @$pb.TagNumber(2)
  void clearReason() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get frozenBy => $_getSZ(3);
  @$pb.TagNumber(4)
  set frozenBy($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasFrozenBy() => $_has(3);
  @$pb.TagNumber(4)
  void clearFrozenBy() => $_clearField(4);
}

class FreezeAccountResponse extends $pb.GeneratedMessage {
  factory FreezeAccountResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (errorCode != null) result.errorCode = errorCode;
    if (errorMessage != null) result.errorMessage = errorMessage;
    return result;
  }

  FreezeAccountResponse._();

  factory FreezeAccountResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FreezeAccountResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FreezeAccountResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'errorCode')
    ..aOS(3, _omitFieldNames ? '' : 'errorMessage')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FreezeAccountResponse clone() =>
      FreezeAccountResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FreezeAccountResponse copyWith(
          void Function(FreezeAccountResponse) updates) =>
      super.copyWith((message) => updates(message as FreezeAccountResponse))
          as FreezeAccountResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FreezeAccountResponse create() => FreezeAccountResponse._();
  @$core.override
  FreezeAccountResponse createEmptyInstance() => create();
  static $pb.PbList<FreezeAccountResponse> createRepeated() =>
      $pb.PbList<FreezeAccountResponse>();
  @$core.pragma('dart2js:noInline')
  static FreezeAccountResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FreezeAccountResponse>(create);
  static FreezeAccountResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => $_clearField(3);
}

class UnfreezeAccountRequest extends $pb.GeneratedMessage {
  factory UnfreezeAccountRequest({
    $core.String? accountId,
    $core.String? unfrozenBy,
    $core.String? note,
  }) {
    final result = create();
    if (accountId != null) result.accountId = accountId;
    if (unfrozenBy != null) result.unfrozenBy = unfrozenBy;
    if (note != null) result.note = note;
    return result;
  }

  UnfreezeAccountRequest._();

  factory UnfreezeAccountRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UnfreezeAccountRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UnfreezeAccountRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountId')
    ..aOS(2, _omitFieldNames ? '' : 'unfrozenBy')
    ..aOS(3, _omitFieldNames ? '' : 'note')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UnfreezeAccountRequest clone() =>
      UnfreezeAccountRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UnfreezeAccountRequest copyWith(
          void Function(UnfreezeAccountRequest) updates) =>
      super.copyWith((message) => updates(message as UnfreezeAccountRequest))
          as UnfreezeAccountRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UnfreezeAccountRequest create() => UnfreezeAccountRequest._();
  @$core.override
  UnfreezeAccountRequest createEmptyInstance() => create();
  static $pb.PbList<UnfreezeAccountRequest> createRepeated() =>
      $pb.PbList<UnfreezeAccountRequest>();
  @$core.pragma('dart2js:noInline')
  static UnfreezeAccountRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UnfreezeAccountRequest>(create);
  static UnfreezeAccountRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get unfrozenBy => $_getSZ(1);
  @$pb.TagNumber(2)
  set unfrozenBy($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUnfrozenBy() => $_has(1);
  @$pb.TagNumber(2)
  void clearUnfrozenBy() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get note => $_getSZ(2);
  @$pb.TagNumber(3)
  set note($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasNote() => $_has(2);
  @$pb.TagNumber(3)
  void clearNote() => $_clearField(3);
}

class UnfreezeAccountResponse extends $pb.GeneratedMessage {
  factory UnfreezeAccountResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (errorCode != null) result.errorCode = errorCode;
    if (errorMessage != null) result.errorMessage = errorMessage;
    return result;
  }

  UnfreezeAccountResponse._();

  factory UnfreezeAccountResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UnfreezeAccountResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UnfreezeAccountResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'errorCode')
    ..aOS(3, _omitFieldNames ? '' : 'errorMessage')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UnfreezeAccountResponse clone() =>
      UnfreezeAccountResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UnfreezeAccountResponse copyWith(
          void Function(UnfreezeAccountResponse) updates) =>
      super.copyWith((message) => updates(message as UnfreezeAccountResponse))
          as UnfreezeAccountResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UnfreezeAccountResponse create() => UnfreezeAccountResponse._();
  @$core.override
  UnfreezeAccountResponse createEmptyInstance() => create();
  static $pb.PbList<UnfreezeAccountResponse> createRepeated() =>
      $pb.PbList<UnfreezeAccountResponse>();
  @$core.pragma('dart2js:noInline')
  static UnfreezeAccountResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UnfreezeAccountResponse>(create);
  static UnfreezeAccountResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => $_clearField(3);
}

/// Daily Usage
class GetDailyUsageRequest extends $pb.GeneratedMessage {
  factory GetDailyUsageRequest({
    $core.String? userId,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    return result;
  }

  GetDailyUsageRequest._();

  factory GetDailyUsageRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetDailyUsageRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetDailyUsageRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetDailyUsageRequest clone() =>
      GetDailyUsageRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetDailyUsageRequest copyWith(void Function(GetDailyUsageRequest) updates) =>
      super.copyWith((message) => updates(message as GetDailyUsageRequest))
          as GetDailyUsageRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetDailyUsageRequest create() => GetDailyUsageRequest._();
  @$core.override
  GetDailyUsageRequest createEmptyInstance() => create();
  static $pb.PbList<GetDailyUsageRequest> createRepeated() =>
      $pb.PbList<GetDailyUsageRequest>();
  @$core.pragma('dart2js:noInline')
  static GetDailyUsageRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetDailyUsageRequest>(create);
  static GetDailyUsageRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);
}

class DailyUsageResponse extends $pb.GeneratedMessage {
  factory DailyUsageResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
    $fixnum.Int64? totalTransferred,
    $core.int? transferCount,
    $fixnum.Int64? dailyLimit,
    $fixnum.Int64? remainingLimit,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (errorCode != null) result.errorCode = errorCode;
    if (errorMessage != null) result.errorMessage = errorMessage;
    if (totalTransferred != null) result.totalTransferred = totalTransferred;
    if (transferCount != null) result.transferCount = transferCount;
    if (dailyLimit != null) result.dailyLimit = dailyLimit;
    if (remainingLimit != null) result.remainingLimit = remainingLimit;
    return result;
  }

  DailyUsageResponse._();

  factory DailyUsageResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DailyUsageResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DailyUsageResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'errorCode')
    ..aOS(3, _omitFieldNames ? '' : 'errorMessage')
    ..aInt64(4, _omitFieldNames ? '' : 'totalTransferred')
    ..a<$core.int>(
        5, _omitFieldNames ? '' : 'transferCount', $pb.PbFieldType.O3)
    ..aInt64(6, _omitFieldNames ? '' : 'dailyLimit')
    ..aInt64(7, _omitFieldNames ? '' : 'remainingLimit')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DailyUsageResponse clone() => DailyUsageResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DailyUsageResponse copyWith(void Function(DailyUsageResponse) updates) =>
      super.copyWith((message) => updates(message as DailyUsageResponse))
          as DailyUsageResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DailyUsageResponse create() => DailyUsageResponse._();
  @$core.override
  DailyUsageResponse createEmptyInstance() => create();
  static $pb.PbList<DailyUsageResponse> createRepeated() =>
      $pb.PbList<DailyUsageResponse>();
  @$core.pragma('dart2js:noInline')
  static DailyUsageResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DailyUsageResponse>(create);
  static DailyUsageResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get totalTransferred => $_getI64(3);
  @$pb.TagNumber(4)
  set totalTransferred($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTotalTransferred() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalTransferred() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get transferCount => $_getIZ(4);
  @$pb.TagNumber(5)
  set transferCount($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTransferCount() => $_has(4);
  @$pb.TagNumber(5)
  void clearTransferCount() => $_clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get dailyLimit => $_getI64(5);
  @$pb.TagNumber(6)
  set dailyLimit($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasDailyLimit() => $_has(5);
  @$pb.TagNumber(6)
  void clearDailyLimit() => $_clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get remainingLimit => $_getI64(6);
  @$pb.TagNumber(7)
  set remainingLimit($fixnum.Int64 value) => $_setInt64(6, value);
  @$pb.TagNumber(7)
  $core.bool hasRemainingLimit() => $_has(6);
  @$pb.TagNumber(7)
  void clearRemainingLimit() => $_clearField(7);
}

/// Reconciliation
class RunReconciliationRequest extends $pb.GeneratedMessage {
  factory RunReconciliationRequest() => create();

  RunReconciliationRequest._();

  factory RunReconciliationRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RunReconciliationRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RunReconciliationRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RunReconciliationRequest clone() =>
      RunReconciliationRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RunReconciliationRequest copyWith(
          void Function(RunReconciliationRequest) updates) =>
      super.copyWith((message) => updates(message as RunReconciliationRequest))
          as RunReconciliationRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RunReconciliationRequest create() => RunReconciliationRequest._();
  @$core.override
  RunReconciliationRequest createEmptyInstance() => create();
  static $pb.PbList<RunReconciliationRequest> createRepeated() =>
      $pb.PbList<RunReconciliationRequest>();
  @$core.pragma('dart2js:noInline')
  static RunReconciliationRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RunReconciliationRequest>(create);
  static RunReconciliationRequest? _defaultInstance;
}

class ReconciliationResponse extends $pb.GeneratedMessage {
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
    final result = create();
    if (success != null) result.success = success;
    if (errorCode != null) result.errorCode = errorCode;
    if (errorMessage != null) result.errorMessage = errorMessage;
    if (reconciliationId != null) result.reconciliationId = reconciliationId;
    if (totalLedgerBalance != null)
      result.totalLedgerBalance = totalLedgerBalance;
    if (pooledAccountBalance != null)
      result.pooledAccountBalance = pooledAccountBalance;
    if (discrepancy != null) result.discrepancy = discrepancy;
    if (status != null) result.status = status;
    if (expiredHoldsReleased != null)
      result.expiredHoldsReleased = expiredHoldsReleased;
    if (stuckTransfersFixed != null)
      result.stuckTransfersFixed = stuckTransfersFixed;
    return result;
  }

  ReconciliationResponse._();

  factory ReconciliationResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ReconciliationResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ReconciliationResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'errorCode')
    ..aOS(3, _omitFieldNames ? '' : 'errorMessage')
    ..aOS(4, _omitFieldNames ? '' : 'reconciliationId')
    ..aInt64(5, _omitFieldNames ? '' : 'totalLedgerBalance')
    ..aInt64(6, _omitFieldNames ? '' : 'pooledAccountBalance')
    ..aInt64(7, _omitFieldNames ? '' : 'discrepancy')
    ..aOS(8, _omitFieldNames ? '' : 'status')
    ..a<$core.int>(
        9, _omitFieldNames ? '' : 'expiredHoldsReleased', $pb.PbFieldType.O3)
    ..a<$core.int>(
        10, _omitFieldNames ? '' : 'stuckTransfersFixed', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReconciliationResponse clone() =>
      ReconciliationResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReconciliationResponse copyWith(
          void Function(ReconciliationResponse) updates) =>
      super.copyWith((message) => updates(message as ReconciliationResponse))
          as ReconciliationResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ReconciliationResponse create() => ReconciliationResponse._();
  @$core.override
  ReconciliationResponse createEmptyInstance() => create();
  static $pb.PbList<ReconciliationResponse> createRepeated() =>
      $pb.PbList<ReconciliationResponse>();
  @$core.pragma('dart2js:noInline')
  static ReconciliationResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ReconciliationResponse>(create);
  static ReconciliationResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get reconciliationId => $_getSZ(3);
  @$pb.TagNumber(4)
  set reconciliationId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasReconciliationId() => $_has(3);
  @$pb.TagNumber(4)
  void clearReconciliationId() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get totalLedgerBalance => $_getI64(4);
  @$pb.TagNumber(5)
  set totalLedgerBalance($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTotalLedgerBalance() => $_has(4);
  @$pb.TagNumber(5)
  void clearTotalLedgerBalance() => $_clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get pooledAccountBalance => $_getI64(5);
  @$pb.TagNumber(6)
  set pooledAccountBalance($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasPooledAccountBalance() => $_has(5);
  @$pb.TagNumber(6)
  void clearPooledAccountBalance() => $_clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get discrepancy => $_getI64(6);
  @$pb.TagNumber(7)
  set discrepancy($fixnum.Int64 value) => $_setInt64(6, value);
  @$pb.TagNumber(7)
  $core.bool hasDiscrepancy() => $_has(6);
  @$pb.TagNumber(7)
  void clearDiscrepancy() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get status => $_getSZ(7);
  @$pb.TagNumber(8)
  set status($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasStatus() => $_has(7);
  @$pb.TagNumber(8)
  void clearStatus() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.int get expiredHoldsReleased => $_getIZ(8);
  @$pb.TagNumber(9)
  set expiredHoldsReleased($core.int value) => $_setSignedInt32(8, value);
  @$pb.TagNumber(9)
  $core.bool hasExpiredHoldsReleased() => $_has(8);
  @$pb.TagNumber(9)
  void clearExpiredHoldsReleased() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.int get stuckTransfersFixed => $_getIZ(9);
  @$pb.TagNumber(10)
  set stuckTransfersFixed($core.int value) => $_setSignedInt32(9, value);
  @$pb.TagNumber(10)
  $core.bool hasStuckTransfersFixed() => $_has(9);
  @$pb.TagNumber(10)
  void clearStuckTransfersFixed() => $_clearField(10);
}

class GetReconciliationHistoryRequest extends $pb.GeneratedMessage {
  factory GetReconciliationHistoryRequest({
    $core.int? days,
  }) {
    final result = create();
    if (days != null) result.days = days;
    return result;
  }

  GetReconciliationHistoryRequest._();

  factory GetReconciliationHistoryRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetReconciliationHistoryRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetReconciliationHistoryRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'days', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetReconciliationHistoryRequest clone() =>
      GetReconciliationHistoryRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetReconciliationHistoryRequest copyWith(
          void Function(GetReconciliationHistoryRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetReconciliationHistoryRequest))
          as GetReconciliationHistoryRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetReconciliationHistoryRequest create() =>
      GetReconciliationHistoryRequest._();
  @$core.override
  GetReconciliationHistoryRequest createEmptyInstance() => create();
  static $pb.PbList<GetReconciliationHistoryRequest> createRepeated() =>
      $pb.PbList<GetReconciliationHistoryRequest>();
  @$core.pragma('dart2js:noInline')
  static GetReconciliationHistoryRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetReconciliationHistoryRequest>(
          create);
  static GetReconciliationHistoryRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get days => $_getIZ(0);
  @$pb.TagNumber(1)
  set days($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDays() => $_has(0);
  @$pb.TagNumber(1)
  void clearDays() => $_clearField(1);
}

class ReconciliationHistoryResponse extends $pb.GeneratedMessage {
  factory ReconciliationHistoryResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
    $core.Iterable<ReconciliationLog>? logs,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (errorCode != null) result.errorCode = errorCode;
    if (errorMessage != null) result.errorMessage = errorMessage;
    if (logs != null) result.logs.addAll(logs);
    return result;
  }

  ReconciliationHistoryResponse._();

  factory ReconciliationHistoryResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ReconciliationHistoryResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ReconciliationHistoryResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'errorCode')
    ..aOS(3, _omitFieldNames ? '' : 'errorMessage')
    ..pc<ReconciliationLog>(
        4, _omitFieldNames ? '' : 'logs', $pb.PbFieldType.PM,
        subBuilder: ReconciliationLog.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReconciliationHistoryResponse clone() =>
      ReconciliationHistoryResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReconciliationHistoryResponse copyWith(
          void Function(ReconciliationHistoryResponse) updates) =>
      super.copyWith(
              (message) => updates(message as ReconciliationHistoryResponse))
          as ReconciliationHistoryResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ReconciliationHistoryResponse create() =>
      ReconciliationHistoryResponse._();
  @$core.override
  ReconciliationHistoryResponse createEmptyInstance() => create();
  static $pb.PbList<ReconciliationHistoryResponse> createRepeated() =>
      $pb.PbList<ReconciliationHistoryResponse>();
  @$core.pragma('dart2js:noInline')
  static ReconciliationHistoryResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ReconciliationHistoryResponse>(create);
  static ReconciliationHistoryResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => $_clearField(3);

  @$pb.TagNumber(4)
  $pb.PbList<ReconciliationLog> get logs => $_getList(3);
}

class ReconciliationLog extends $pb.GeneratedMessage {
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
    final result = create();
    if (id != null) result.id = id;
    if (reconciliationDate != null)
      result.reconciliationDate = reconciliationDate;
    if (totalLedgerBalance != null)
      result.totalLedgerBalance = totalLedgerBalance;
    if (pooledAccountBalance != null)
      result.pooledAccountBalance = pooledAccountBalance;
    if (discrepancy != null) result.discrepancy = discrepancy;
    if (status != null) result.status = status;
    if (notes != null) result.notes = notes;
    if (createdAt != null) result.createdAt = createdAt;
    if (resolvedAt != null) result.resolvedAt = resolvedAt;
    return result;
  }

  ReconciliationLog._();

  factory ReconciliationLog.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ReconciliationLog.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ReconciliationLog',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOM<$1.Timestamp>(2, _omitFieldNames ? '' : 'reconciliationDate',
        subBuilder: $1.Timestamp.create)
    ..aInt64(3, _omitFieldNames ? '' : 'totalLedgerBalance')
    ..aInt64(4, _omitFieldNames ? '' : 'pooledAccountBalance')
    ..aInt64(5, _omitFieldNames ? '' : 'discrepancy')
    ..aOS(6, _omitFieldNames ? '' : 'status')
    ..aOS(7, _omitFieldNames ? '' : 'notes')
    ..aOM<$1.Timestamp>(8, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(9, _omitFieldNames ? '' : 'resolvedAt',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReconciliationLog clone() => ReconciliationLog()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReconciliationLog copyWith(void Function(ReconciliationLog) updates) =>
      super.copyWith((message) => updates(message as ReconciliationLog))
          as ReconciliationLog;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ReconciliationLog create() => ReconciliationLog._();
  @$core.override
  ReconciliationLog createEmptyInstance() => create();
  static $pb.PbList<ReconciliationLog> createRepeated() =>
      $pb.PbList<ReconciliationLog>();
  @$core.pragma('dart2js:noInline')
  static ReconciliationLog getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ReconciliationLog>(create);
  static ReconciliationLog? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $1.Timestamp get reconciliationDate => $_getN(1);
  @$pb.TagNumber(2)
  set reconciliationDate($1.Timestamp value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasReconciliationDate() => $_has(1);
  @$pb.TagNumber(2)
  void clearReconciliationDate() => $_clearField(2);
  @$pb.TagNumber(2)
  $1.Timestamp ensureReconciliationDate() => $_ensure(1);

  @$pb.TagNumber(3)
  $fixnum.Int64 get totalLedgerBalance => $_getI64(2);
  @$pb.TagNumber(3)
  set totalLedgerBalance($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTotalLedgerBalance() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalLedgerBalance() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get pooledAccountBalance => $_getI64(3);
  @$pb.TagNumber(4)
  set pooledAccountBalance($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPooledAccountBalance() => $_has(3);
  @$pb.TagNumber(4)
  void clearPooledAccountBalance() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get discrepancy => $_getI64(4);
  @$pb.TagNumber(5)
  set discrepancy($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasDiscrepancy() => $_has(4);
  @$pb.TagNumber(5)
  void clearDiscrepancy() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get status => $_getSZ(5);
  @$pb.TagNumber(6)
  set status($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasStatus() => $_has(5);
  @$pb.TagNumber(6)
  void clearStatus() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get notes => $_getSZ(6);
  @$pb.TagNumber(7)
  set notes($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasNotes() => $_has(6);
  @$pb.TagNumber(7)
  void clearNotes() => $_clearField(7);

  @$pb.TagNumber(8)
  $1.Timestamp get createdAt => $_getN(7);
  @$pb.TagNumber(8)
  set createdAt($1.Timestamp value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasCreatedAt() => $_has(7);
  @$pb.TagNumber(8)
  void clearCreatedAt() => $_clearField(8);
  @$pb.TagNumber(8)
  $1.Timestamp ensureCreatedAt() => $_ensure(7);

  @$pb.TagNumber(9)
  $1.Timestamp get resolvedAt => $_getN(8);
  @$pb.TagNumber(9)
  set resolvedAt($1.Timestamp value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasResolvedAt() => $_has(8);
  @$pb.TagNumber(9)
  void clearResolvedAt() => $_clearField(9);
  @$pb.TagNumber(9)
  $1.Timestamp ensureResolvedAt() => $_ensure(8);
}

/// Daily Report
class GetDailyReportRequest extends $pb.GeneratedMessage {
  factory GetDailyReportRequest({
    $1.Timestamp? date,
  }) {
    final result = create();
    if (date != null) result.date = date;
    return result;
  }

  GetDailyReportRequest._();

  factory GetDailyReportRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetDailyReportRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetDailyReportRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOM<$1.Timestamp>(1, _omitFieldNames ? '' : 'date',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetDailyReportRequest clone() =>
      GetDailyReportRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetDailyReportRequest copyWith(
          void Function(GetDailyReportRequest) updates) =>
      super.copyWith((message) => updates(message as GetDailyReportRequest))
          as GetDailyReportRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetDailyReportRequest create() => GetDailyReportRequest._();
  @$core.override
  GetDailyReportRequest createEmptyInstance() => create();
  static $pb.PbList<GetDailyReportRequest> createRepeated() =>
      $pb.PbList<GetDailyReportRequest>();
  @$core.pragma('dart2js:noInline')
  static GetDailyReportRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetDailyReportRequest>(create);
  static GetDailyReportRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $1.Timestamp get date => $_getN(0);
  @$pb.TagNumber(1)
  set date($1.Timestamp value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasDate() => $_has(0);
  @$pb.TagNumber(1)
  void clearDate() => $_clearField(1);
  @$pb.TagNumber(1)
  $1.Timestamp ensureDate() => $_ensure(0);
}

class DailyReportResponse extends $pb.GeneratedMessage {
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
    final result = create();
    if (success != null) result.success = success;
    if (errorCode != null) result.errorCode = errorCode;
    if (errorMessage != null) result.errorMessage = errorMessage;
    if (date != null) result.date = date;
    if (totalCredits != null) result.totalCredits = totalCredits;
    if (totalDebits != null) result.totalDebits = totalDebits;
    if (creditCount != null) result.creditCount = creditCount;
    if (debitCount != null) result.debitCount = debitCount;
    if (netChange != null) result.netChange = netChange;
    if (internalTransferVolume != null)
      result.internalTransferVolume = internalTransferVolume;
    if (internalTransferCount != null)
      result.internalTransferCount = internalTransferCount;
    if (externalTransferVolume != null)
      result.externalTransferVolume = externalTransferVolume;
    if (externalTransferCount != null)
      result.externalTransferCount = externalTransferCount;
    if (failedTransferCount != null)
      result.failedTransferCount = failedTransferCount;
    if (newAccountsCreated != null)
      result.newAccountsCreated = newAccountsCreated;
    if (totalLedgerBalance != null)
      result.totalLedgerBalance = totalLedgerBalance;
    return result;
  }

  DailyReportResponse._();

  factory DailyReportResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DailyReportResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DailyReportResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'errorCode')
    ..aOS(3, _omitFieldNames ? '' : 'errorMessage')
    ..aOM<$1.Timestamp>(4, _omitFieldNames ? '' : 'date',
        subBuilder: $1.Timestamp.create)
    ..aInt64(5, _omitFieldNames ? '' : 'totalCredits')
    ..aInt64(6, _omitFieldNames ? '' : 'totalDebits')
    ..a<$core.int>(7, _omitFieldNames ? '' : 'creditCount', $pb.PbFieldType.O3)
    ..a<$core.int>(8, _omitFieldNames ? '' : 'debitCount', $pb.PbFieldType.O3)
    ..aInt64(9, _omitFieldNames ? '' : 'netChange')
    ..aInt64(10, _omitFieldNames ? '' : 'internalTransferVolume')
    ..a<$core.int>(
        11, _omitFieldNames ? '' : 'internalTransferCount', $pb.PbFieldType.O3)
    ..aInt64(12, _omitFieldNames ? '' : 'externalTransferVolume')
    ..a<$core.int>(
        13, _omitFieldNames ? '' : 'externalTransferCount', $pb.PbFieldType.O3)
    ..a<$core.int>(
        14, _omitFieldNames ? '' : 'failedTransferCount', $pb.PbFieldType.O3)
    ..a<$core.int>(
        15, _omitFieldNames ? '' : 'newAccountsCreated', $pb.PbFieldType.O3)
    ..aInt64(16, _omitFieldNames ? '' : 'totalLedgerBalance')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DailyReportResponse clone() => DailyReportResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DailyReportResponse copyWith(void Function(DailyReportResponse) updates) =>
      super.copyWith((message) => updates(message as DailyReportResponse))
          as DailyReportResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DailyReportResponse create() => DailyReportResponse._();
  @$core.override
  DailyReportResponse createEmptyInstance() => create();
  static $pb.PbList<DailyReportResponse> createRepeated() =>
      $pb.PbList<DailyReportResponse>();
  @$core.pragma('dart2js:noInline')
  static DailyReportResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DailyReportResponse>(create);
  static DailyReportResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => $_clearField(3);

  @$pb.TagNumber(4)
  $1.Timestamp get date => $_getN(3);
  @$pb.TagNumber(4)
  set date($1.Timestamp value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasDate() => $_has(3);
  @$pb.TagNumber(4)
  void clearDate() => $_clearField(4);
  @$pb.TagNumber(4)
  $1.Timestamp ensureDate() => $_ensure(3);

  @$pb.TagNumber(5)
  $fixnum.Int64 get totalCredits => $_getI64(4);
  @$pb.TagNumber(5)
  set totalCredits($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTotalCredits() => $_has(4);
  @$pb.TagNumber(5)
  void clearTotalCredits() => $_clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get totalDebits => $_getI64(5);
  @$pb.TagNumber(6)
  set totalDebits($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasTotalDebits() => $_has(5);
  @$pb.TagNumber(6)
  void clearTotalDebits() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.int get creditCount => $_getIZ(6);
  @$pb.TagNumber(7)
  set creditCount($core.int value) => $_setSignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasCreditCount() => $_has(6);
  @$pb.TagNumber(7)
  void clearCreditCount() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.int get debitCount => $_getIZ(7);
  @$pb.TagNumber(8)
  set debitCount($core.int value) => $_setSignedInt32(7, value);
  @$pb.TagNumber(8)
  $core.bool hasDebitCount() => $_has(7);
  @$pb.TagNumber(8)
  void clearDebitCount() => $_clearField(8);

  @$pb.TagNumber(9)
  $fixnum.Int64 get netChange => $_getI64(8);
  @$pb.TagNumber(9)
  set netChange($fixnum.Int64 value) => $_setInt64(8, value);
  @$pb.TagNumber(9)
  $core.bool hasNetChange() => $_has(8);
  @$pb.TagNumber(9)
  void clearNetChange() => $_clearField(9);

  @$pb.TagNumber(10)
  $fixnum.Int64 get internalTransferVolume => $_getI64(9);
  @$pb.TagNumber(10)
  set internalTransferVolume($fixnum.Int64 value) => $_setInt64(9, value);
  @$pb.TagNumber(10)
  $core.bool hasInternalTransferVolume() => $_has(9);
  @$pb.TagNumber(10)
  void clearInternalTransferVolume() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.int get internalTransferCount => $_getIZ(10);
  @$pb.TagNumber(11)
  set internalTransferCount($core.int value) => $_setSignedInt32(10, value);
  @$pb.TagNumber(11)
  $core.bool hasInternalTransferCount() => $_has(10);
  @$pb.TagNumber(11)
  void clearInternalTransferCount() => $_clearField(11);

  @$pb.TagNumber(12)
  $fixnum.Int64 get externalTransferVolume => $_getI64(11);
  @$pb.TagNumber(12)
  set externalTransferVolume($fixnum.Int64 value) => $_setInt64(11, value);
  @$pb.TagNumber(12)
  $core.bool hasExternalTransferVolume() => $_has(11);
  @$pb.TagNumber(12)
  void clearExternalTransferVolume() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.int get externalTransferCount => $_getIZ(12);
  @$pb.TagNumber(13)
  set externalTransferCount($core.int value) => $_setSignedInt32(12, value);
  @$pb.TagNumber(13)
  $core.bool hasExternalTransferCount() => $_has(12);
  @$pb.TagNumber(13)
  void clearExternalTransferCount() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.int get failedTransferCount => $_getIZ(13);
  @$pb.TagNumber(14)
  set failedTransferCount($core.int value) => $_setSignedInt32(13, value);
  @$pb.TagNumber(14)
  $core.bool hasFailedTransferCount() => $_has(13);
  @$pb.TagNumber(14)
  void clearFailedTransferCount() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.int get newAccountsCreated => $_getIZ(14);
  @$pb.TagNumber(15)
  set newAccountsCreated($core.int value) => $_setSignedInt32(14, value);
  @$pb.TagNumber(15)
  $core.bool hasNewAccountsCreated() => $_has(14);
  @$pb.TagNumber(15)
  void clearNewAccountsCreated() => $_clearField(15);

  @$pb.TagNumber(16)
  $fixnum.Int64 get totalLedgerBalance => $_getI64(15);
  @$pb.TagNumber(16)
  set totalLedgerBalance($fixnum.Int64 value) => $_setInt64(15, value);
  @$pb.TagNumber(16)
  $core.bool hasTotalLedgerBalance() => $_has(15);
  @$pb.TagNumber(16)
  void clearTotalLedgerBalance() => $_clearField(16);
}

/// Get Mono Institutions
class GetMonoInstitutionsRequest extends $pb.GeneratedMessage {
  factory GetMonoInstitutionsRequest({
    $core.String? scope,
    $core.String? country,
  }) {
    final result = create();
    if (scope != null) result.scope = scope;
    if (country != null) result.country = country;
    return result;
  }

  GetMonoInstitutionsRequest._();

  factory GetMonoInstitutionsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMonoInstitutionsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMonoInstitutionsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'scope')
    ..aOS(2, _omitFieldNames ? '' : 'country')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMonoInstitutionsRequest clone() =>
      GetMonoInstitutionsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMonoInstitutionsRequest copyWith(
          void Function(GetMonoInstitutionsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetMonoInstitutionsRequest))
          as GetMonoInstitutionsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMonoInstitutionsRequest create() => GetMonoInstitutionsRequest._();
  @$core.override
  GetMonoInstitutionsRequest createEmptyInstance() => create();
  static $pb.PbList<GetMonoInstitutionsRequest> createRepeated() =>
      $pb.PbList<GetMonoInstitutionsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMonoInstitutionsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetMonoInstitutionsRequest>(create);
  static GetMonoInstitutionsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get scope => $_getSZ(0);
  @$pb.TagNumber(1)
  set scope($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasScope() => $_has(0);
  @$pb.TagNumber(1)
  void clearScope() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get country => $_getSZ(1);
  @$pb.TagNumber(2)
  set country($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCountry() => $_has(1);
  @$pb.TagNumber(2)
  void clearCountry() => $_clearField(2);
}

class MonoInstitutionsResponse extends $pb.GeneratedMessage {
  factory MonoInstitutionsResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
    $core.Iterable<MonoInstitution>? institutions,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (errorCode != null) result.errorCode = errorCode;
    if (errorMessage != null) result.errorMessage = errorMessage;
    if (institutions != null) result.institutions.addAll(institutions);
    return result;
  }

  MonoInstitutionsResponse._();

  factory MonoInstitutionsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MonoInstitutionsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MonoInstitutionsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'errorCode')
    ..aOS(3, _omitFieldNames ? '' : 'errorMessage')
    ..pc<MonoInstitution>(
        4, _omitFieldNames ? '' : 'institutions', $pb.PbFieldType.PM,
        subBuilder: MonoInstitution.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MonoInstitutionsResponse clone() =>
      MonoInstitutionsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MonoInstitutionsResponse copyWith(
          void Function(MonoInstitutionsResponse) updates) =>
      super.copyWith((message) => updates(message as MonoInstitutionsResponse))
          as MonoInstitutionsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MonoInstitutionsResponse create() => MonoInstitutionsResponse._();
  @$core.override
  MonoInstitutionsResponse createEmptyInstance() => create();
  static $pb.PbList<MonoInstitutionsResponse> createRepeated() =>
      $pb.PbList<MonoInstitutionsResponse>();
  @$core.pragma('dart2js:noInline')
  static MonoInstitutionsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MonoInstitutionsResponse>(create);
  static MonoInstitutionsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => $_clearField(3);

  @$pb.TagNumber(4)
  $pb.PbList<MonoInstitution> get institutions => $_getList(3);
}

class MonoInstitution extends $pb.GeneratedMessage {
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
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (bankCode != null) result.bankCode = bankCode;
    if (icon != null) result.icon = icon;
    if (type != null) result.type = type;
    if (country != null) result.country = country;
    if (authMethods != null) result.authMethods.addAll(authMethods);
    if (supportsMobileBanking != null)
      result.supportsMobileBanking = supportsMobileBanking;
    if (supportsInternetBanking != null)
      result.supportsInternetBanking = supportsInternetBanking;
    return result;
  }

  MonoInstitution._();

  factory MonoInstitution.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MonoInstitution.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MonoInstitution',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'bankCode')
    ..aOS(4, _omitFieldNames ? '' : 'icon')
    ..aOS(5, _omitFieldNames ? '' : 'type')
    ..aOS(6, _omitFieldNames ? '' : 'country')
    ..pc<MonoAuthMethod>(
        7, _omitFieldNames ? '' : 'authMethods', $pb.PbFieldType.PM,
        subBuilder: MonoAuthMethod.create)
    ..aOB(8, _omitFieldNames ? '' : 'supportsMobileBanking')
    ..aOB(9, _omitFieldNames ? '' : 'supportsInternetBanking')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MonoInstitution clone() => MonoInstitution()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MonoInstitution copyWith(void Function(MonoInstitution) updates) =>
      super.copyWith((message) => updates(message as MonoInstitution))
          as MonoInstitution;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MonoInstitution create() => MonoInstitution._();
  @$core.override
  MonoInstitution createEmptyInstance() => create();
  static $pb.PbList<MonoInstitution> createRepeated() =>
      $pb.PbList<MonoInstitution>();
  @$core.pragma('dart2js:noInline')
  static MonoInstitution getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MonoInstitution>(create);
  static MonoInstitution? _defaultInstance;

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
  $core.String get bankCode => $_getSZ(2);
  @$pb.TagNumber(3)
  set bankCode($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasBankCode() => $_has(2);
  @$pb.TagNumber(3)
  void clearBankCode() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get icon => $_getSZ(3);
  @$pb.TagNumber(4)
  set icon($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasIcon() => $_has(3);
  @$pb.TagNumber(4)
  void clearIcon() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get type => $_getSZ(4);
  @$pb.TagNumber(5)
  set type($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasType() => $_has(4);
  @$pb.TagNumber(5)
  void clearType() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get country => $_getSZ(5);
  @$pb.TagNumber(6)
  set country($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasCountry() => $_has(5);
  @$pb.TagNumber(6)
  void clearCountry() => $_clearField(6);

  @$pb.TagNumber(7)
  $pb.PbList<MonoAuthMethod> get authMethods => $_getList(6);

  @$pb.TagNumber(8)
  $core.bool get supportsMobileBanking => $_getBF(7);
  @$pb.TagNumber(8)
  set supportsMobileBanking($core.bool value) => $_setBool(7, value);
  @$pb.TagNumber(8)
  $core.bool hasSupportsMobileBanking() => $_has(7);
  @$pb.TagNumber(8)
  void clearSupportsMobileBanking() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.bool get supportsInternetBanking => $_getBF(8);
  @$pb.TagNumber(9)
  set supportsInternetBanking($core.bool value) => $_setBool(8, value);
  @$pb.TagNumber(9)
  $core.bool hasSupportsInternetBanking() => $_has(8);
  @$pb.TagNumber(9)
  void clearSupportsInternetBanking() => $_clearField(9);
}

class MonoAuthMethod extends $pb.GeneratedMessage {
  factory MonoAuthMethod({
    $core.String? type,
    $core.String? name,
  }) {
    final result = create();
    if (type != null) result.type = type;
    if (name != null) result.name = name;
    return result;
  }

  MonoAuthMethod._();

  factory MonoAuthMethod.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MonoAuthMethod.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MonoAuthMethod',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'type')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MonoAuthMethod clone() => MonoAuthMethod()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MonoAuthMethod copyWith(void Function(MonoAuthMethod) updates) =>
      super.copyWith((message) => updates(message as MonoAuthMethod))
          as MonoAuthMethod;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MonoAuthMethod create() => MonoAuthMethod._();
  @$core.override
  MonoAuthMethod createEmptyInstance() => create();
  static $pb.PbList<MonoAuthMethod> createRepeated() =>
      $pb.PbList<MonoAuthMethod>();
  @$core.pragma('dart2js:noInline')
  static MonoAuthMethod getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MonoAuthMethod>(create);
  static MonoAuthMethod? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get type => $_getSZ(0);
  @$pb.TagNumber(1)
  set type($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);
}

/// Connect Widget Config
class GetConnectWidgetConfigRequest extends $pb.GeneratedMessage {
  factory GetConnectWidgetConfigRequest() => create();

  GetConnectWidgetConfigRequest._();

  factory GetConnectWidgetConfigRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetConnectWidgetConfigRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetConnectWidgetConfigRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetConnectWidgetConfigRequest clone() =>
      GetConnectWidgetConfigRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetConnectWidgetConfigRequest copyWith(
          void Function(GetConnectWidgetConfigRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetConnectWidgetConfigRequest))
          as GetConnectWidgetConfigRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetConnectWidgetConfigRequest create() =>
      GetConnectWidgetConfigRequest._();
  @$core.override
  GetConnectWidgetConfigRequest createEmptyInstance() => create();
  static $pb.PbList<GetConnectWidgetConfigRequest> createRepeated() =>
      $pb.PbList<GetConnectWidgetConfigRequest>();
  @$core.pragma('dart2js:noInline')
  static GetConnectWidgetConfigRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetConnectWidgetConfigRequest>(create);
  static GetConnectWidgetConfigRequest? _defaultInstance;
}

class ConnectWidgetConfigResponse extends $pb.GeneratedMessage {
  factory ConnectWidgetConfigResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
    $core.String? publicKey,
    $core.String? appId,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (errorCode != null) result.errorCode = errorCode;
    if (errorMessage != null) result.errorMessage = errorMessage;
    if (publicKey != null) result.publicKey = publicKey;
    if (appId != null) result.appId = appId;
    return result;
  }

  ConnectWidgetConfigResponse._();

  factory ConnectWidgetConfigResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ConnectWidgetConfigResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ConnectWidgetConfigResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'errorCode')
    ..aOS(3, _omitFieldNames ? '' : 'errorMessage')
    ..aOS(4, _omitFieldNames ? '' : 'publicKey')
    ..aOS(5, _omitFieldNames ? '' : 'appId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ConnectWidgetConfigResponse clone() =>
      ConnectWidgetConfigResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ConnectWidgetConfigResponse copyWith(
          void Function(ConnectWidgetConfigResponse) updates) =>
      super.copyWith(
              (message) => updates(message as ConnectWidgetConfigResponse))
          as ConnectWidgetConfigResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ConnectWidgetConfigResponse create() =>
      ConnectWidgetConfigResponse._();
  @$core.override
  ConnectWidgetConfigResponse createEmptyInstance() => create();
  static $pb.PbList<ConnectWidgetConfigResponse> createRepeated() =>
      $pb.PbList<ConnectWidgetConfigResponse>();
  @$core.pragma('dart2js:noInline')
  static ConnectWidgetConfigResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ConnectWidgetConfigResponse>(create);
  static ConnectWidgetConfigResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get publicKey => $_getSZ(3);
  @$pb.TagNumber(4)
  set publicKey($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPublicKey() => $_has(3);
  @$pb.TagNumber(4)
  void clearPublicKey() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get appId => $_getSZ(4);
  @$pb.TagNumber(5)
  set appId($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasAppId() => $_has(4);
  @$pb.TagNumber(5)
  void clearAppId() => $_clearField(5);
}

/// Link Bank Account
class LinkBankAccountRequest extends $pb.GeneratedMessage {
  factory LinkBankAccountRequest({
    $core.String? userId,
    $core.String? code,
    $core.bool? setAsDefault,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    if (code != null) result.code = code;
    if (setAsDefault != null) result.setAsDefault = setAsDefault;
    return result;
  }

  LinkBankAccountRequest._();

  factory LinkBankAccountRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory LinkBankAccountRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LinkBankAccountRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'code')
    ..aOB(3, _omitFieldNames ? '' : 'setAsDefault')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LinkBankAccountRequest clone() =>
      LinkBankAccountRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LinkBankAccountRequest copyWith(
          void Function(LinkBankAccountRequest) updates) =>
      super.copyWith((message) => updates(message as LinkBankAccountRequest))
          as LinkBankAccountRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LinkBankAccountRequest create() => LinkBankAccountRequest._();
  @$core.override
  LinkBankAccountRequest createEmptyInstance() => create();
  static $pb.PbList<LinkBankAccountRequest> createRepeated() =>
      $pb.PbList<LinkBankAccountRequest>();
  @$core.pragma('dart2js:noInline')
  static LinkBankAccountRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LinkBankAccountRequest>(create);
  static LinkBankAccountRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get code => $_getSZ(1);
  @$pb.TagNumber(2)
  set code($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearCode() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.bool get setAsDefault => $_getBF(2);
  @$pb.TagNumber(3)
  set setAsDefault($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSetAsDefault() => $_has(2);
  @$pb.TagNumber(3)
  void clearSetAsDefault() => $_clearField(3);
}

class LinkBankAccountResponse extends $pb.GeneratedMessage {
  factory LinkBankAccountResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
    LinkedBankAccount? account,
    $core.bool? isNewAccount,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (errorCode != null) result.errorCode = errorCode;
    if (errorMessage != null) result.errorMessage = errorMessage;
    if (account != null) result.account = account;
    if (isNewAccount != null) result.isNewAccount = isNewAccount;
    return result;
  }

  LinkBankAccountResponse._();

  factory LinkBankAccountResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory LinkBankAccountResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LinkBankAccountResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'errorCode')
    ..aOS(3, _omitFieldNames ? '' : 'errorMessage')
    ..aOM<LinkedBankAccount>(4, _omitFieldNames ? '' : 'account',
        subBuilder: LinkedBankAccount.create)
    ..aOB(5, _omitFieldNames ? '' : 'isNewAccount')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LinkBankAccountResponse clone() =>
      LinkBankAccountResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LinkBankAccountResponse copyWith(
          void Function(LinkBankAccountResponse) updates) =>
      super.copyWith((message) => updates(message as LinkBankAccountResponse))
          as LinkBankAccountResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LinkBankAccountResponse create() => LinkBankAccountResponse._();
  @$core.override
  LinkBankAccountResponse createEmptyInstance() => create();
  static $pb.PbList<LinkBankAccountResponse> createRepeated() =>
      $pb.PbList<LinkBankAccountResponse>();
  @$core.pragma('dart2js:noInline')
  static LinkBankAccountResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LinkBankAccountResponse>(create);
  static LinkBankAccountResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => $_clearField(3);

  @$pb.TagNumber(4)
  LinkedBankAccount get account => $_getN(3);
  @$pb.TagNumber(4)
  set account(LinkedBankAccount value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasAccount() => $_has(3);
  @$pb.TagNumber(4)
  void clearAccount() => $_clearField(4);
  @$pb.TagNumber(4)
  LinkedBankAccount ensureAccount() => $_ensure(3);

  @$pb.TagNumber(5)
  $core.bool get isNewAccount => $_getBF(4);
  @$pb.TagNumber(5)
  set isNewAccount($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasIsNewAccount() => $_has(4);
  @$pb.TagNumber(5)
  void clearIsNewAccount() => $_clearField(5);
}

/// Get Linked Accounts
class GetLinkedAccountsRequest extends $pb.GeneratedMessage {
  factory GetLinkedAccountsRequest({
    $core.String? userId,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    return result;
  }

  GetLinkedAccountsRequest._();

  factory GetLinkedAccountsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetLinkedAccountsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetLinkedAccountsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetLinkedAccountsRequest clone() =>
      GetLinkedAccountsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetLinkedAccountsRequest copyWith(
          void Function(GetLinkedAccountsRequest) updates) =>
      super.copyWith((message) => updates(message as GetLinkedAccountsRequest))
          as GetLinkedAccountsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetLinkedAccountsRequest create() => GetLinkedAccountsRequest._();
  @$core.override
  GetLinkedAccountsRequest createEmptyInstance() => create();
  static $pb.PbList<GetLinkedAccountsRequest> createRepeated() =>
      $pb.PbList<GetLinkedAccountsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetLinkedAccountsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetLinkedAccountsRequest>(create);
  static GetLinkedAccountsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);
}

class LinkedAccountsResponse extends $pb.GeneratedMessage {
  factory LinkedAccountsResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
    $core.Iterable<LinkedBankAccount>? accounts,
    LinkedBankAccount? defaultAccount,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (errorCode != null) result.errorCode = errorCode;
    if (errorMessage != null) result.errorMessage = errorMessage;
    if (accounts != null) result.accounts.addAll(accounts);
    if (defaultAccount != null) result.defaultAccount = defaultAccount;
    return result;
  }

  LinkedAccountsResponse._();

  factory LinkedAccountsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory LinkedAccountsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LinkedAccountsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'errorCode')
    ..aOS(3, _omitFieldNames ? '' : 'errorMessage')
    ..pc<LinkedBankAccount>(
        4, _omitFieldNames ? '' : 'accounts', $pb.PbFieldType.PM,
        subBuilder: LinkedBankAccount.create)
    ..aOM<LinkedBankAccount>(5, _omitFieldNames ? '' : 'defaultAccount',
        subBuilder: LinkedBankAccount.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LinkedAccountsResponse clone() =>
      LinkedAccountsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LinkedAccountsResponse copyWith(
          void Function(LinkedAccountsResponse) updates) =>
      super.copyWith((message) => updates(message as LinkedAccountsResponse))
          as LinkedAccountsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LinkedAccountsResponse create() => LinkedAccountsResponse._();
  @$core.override
  LinkedAccountsResponse createEmptyInstance() => create();
  static $pb.PbList<LinkedAccountsResponse> createRepeated() =>
      $pb.PbList<LinkedAccountsResponse>();
  @$core.pragma('dart2js:noInline')
  static LinkedAccountsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LinkedAccountsResponse>(create);
  static LinkedAccountsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => $_clearField(3);

  @$pb.TagNumber(4)
  $pb.PbList<LinkedBankAccount> get accounts => $_getList(3);

  @$pb.TagNumber(5)
  LinkedBankAccount get defaultAccount => $_getN(4);
  @$pb.TagNumber(5)
  set defaultAccount(LinkedBankAccount value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasDefaultAccount() => $_has(4);
  @$pb.TagNumber(5)
  void clearDefaultAccount() => $_clearField(5);
  @$pb.TagNumber(5)
  LinkedBankAccount ensureDefaultAccount() => $_ensure(4);
}

/// Get Single Linked Account
class GetLinkedAccountRequest extends $pb.GeneratedMessage {
  factory GetLinkedAccountRequest({
    $core.String? accountId,
  }) {
    final result = create();
    if (accountId != null) result.accountId = accountId;
    return result;
  }

  GetLinkedAccountRequest._();

  factory GetLinkedAccountRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetLinkedAccountRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetLinkedAccountRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetLinkedAccountRequest clone() =>
      GetLinkedAccountRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetLinkedAccountRequest copyWith(
          void Function(GetLinkedAccountRequest) updates) =>
      super.copyWith((message) => updates(message as GetLinkedAccountRequest))
          as GetLinkedAccountRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetLinkedAccountRequest create() => GetLinkedAccountRequest._();
  @$core.override
  GetLinkedAccountRequest createEmptyInstance() => create();
  static $pb.PbList<GetLinkedAccountRequest> createRepeated() =>
      $pb.PbList<GetLinkedAccountRequest>();
  @$core.pragma('dart2js:noInline')
  static GetLinkedAccountRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetLinkedAccountRequest>(create);
  static GetLinkedAccountRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => $_clearField(1);
}

class LinkedAccountResponse extends $pb.GeneratedMessage {
  factory LinkedAccountResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
    LinkedBankAccount? account,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (errorCode != null) result.errorCode = errorCode;
    if (errorMessage != null) result.errorMessage = errorMessage;
    if (account != null) result.account = account;
    return result;
  }

  LinkedAccountResponse._();

  factory LinkedAccountResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory LinkedAccountResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LinkedAccountResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'errorCode')
    ..aOS(3, _omitFieldNames ? '' : 'errorMessage')
    ..aOM<LinkedBankAccount>(4, _omitFieldNames ? '' : 'account',
        subBuilder: LinkedBankAccount.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LinkedAccountResponse clone() =>
      LinkedAccountResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LinkedAccountResponse copyWith(
          void Function(LinkedAccountResponse) updates) =>
      super.copyWith((message) => updates(message as LinkedAccountResponse))
          as LinkedAccountResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LinkedAccountResponse create() => LinkedAccountResponse._();
  @$core.override
  LinkedAccountResponse createEmptyInstance() => create();
  static $pb.PbList<LinkedAccountResponse> createRepeated() =>
      $pb.PbList<LinkedAccountResponse>();
  @$core.pragma('dart2js:noInline')
  static LinkedAccountResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LinkedAccountResponse>(create);
  static LinkedAccountResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => $_clearField(3);

  @$pb.TagNumber(4)
  LinkedBankAccount get account => $_getN(3);
  @$pb.TagNumber(4)
  set account(LinkedBankAccount value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasAccount() => $_has(3);
  @$pb.TagNumber(4)
  void clearAccount() => $_clearField(4);
  @$pb.TagNumber(4)
  LinkedBankAccount ensureAccount() => $_ensure(3);
}

/// Linked Bank Account Message
class LinkedBankAccount extends $pb.GeneratedMessage {
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
    $1.Timestamp? lastSyncAt,
    $core.String? lastSyncStatus,
    $core.int? transactionCount,
    $core.int? syncErrorCount,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (userId != null) result.userId = userId;
    if (provider != null) result.provider = provider;
    if (bankName != null) result.bankName = bankName;
    if (bankCode != null) result.bankCode = bankCode;
    if (accountNumber != null) result.accountNumber = accountNumber;
    if (accountName != null) result.accountName = accountName;
    if (accountType != null) result.accountType = accountType;
    if (currency != null) result.currency = currency;
    if (lastKnownBalance != null) result.lastKnownBalance = lastKnownBalance;
    if (status != null) result.status = status;
    if (isDefault != null) result.isDefault = isDefault;
    if (isVerified != null) result.isVerified = isVerified;
    if (linkedAt != null) result.linkedAt = linkedAt;
    if (balanceUpdatedAt != null) result.balanceUpdatedAt = balanceUpdatedAt;
    if (lastUsedAt != null) result.lastUsedAt = lastUsedAt;
    if (needsReauthorize != null) result.needsReauthorize = needsReauthorize;
    if (lastSyncAt != null) result.lastSyncAt = lastSyncAt;
    if (lastSyncStatus != null) result.lastSyncStatus = lastSyncStatus;
    if (transactionCount != null) result.transactionCount = transactionCount;
    if (syncErrorCount != null) result.syncErrorCount = syncErrorCount;
    return result;
  }

  LinkedBankAccount._();

  factory LinkedBankAccount.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory LinkedBankAccount.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LinkedBankAccount',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'provider')
    ..aOS(4, _omitFieldNames ? '' : 'bankName')
    ..aOS(5, _omitFieldNames ? '' : 'bankCode')
    ..aOS(6, _omitFieldNames ? '' : 'accountNumber')
    ..aOS(7, _omitFieldNames ? '' : 'accountName')
    ..aOS(8, _omitFieldNames ? '' : 'accountType')
    ..aOS(9, _omitFieldNames ? '' : 'currency')
    ..aInt64(10, _omitFieldNames ? '' : 'lastKnownBalance')
    ..aOS(11, _omitFieldNames ? '' : 'status')
    ..aOB(12, _omitFieldNames ? '' : 'isDefault')
    ..aOB(13, _omitFieldNames ? '' : 'isVerified')
    ..aOM<$1.Timestamp>(14, _omitFieldNames ? '' : 'linkedAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(15, _omitFieldNames ? '' : 'balanceUpdatedAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(16, _omitFieldNames ? '' : 'lastUsedAt',
        subBuilder: $1.Timestamp.create)
    ..aOB(17, _omitFieldNames ? '' : 'needsReauthorize')
    ..aOM<$1.Timestamp>(18, _omitFieldNames ? '' : 'lastSyncAt',
        subBuilder: $1.Timestamp.create)
    ..aOS(19, _omitFieldNames ? '' : 'lastSyncStatus')
    ..a<$core.int>(
        20, _omitFieldNames ? '' : 'transactionCount', $pb.PbFieldType.O3)
    ..a<$core.int>(
        21, _omitFieldNames ? '' : 'syncErrorCount', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LinkedBankAccount clone() => LinkedBankAccount()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LinkedBankAccount copyWith(void Function(LinkedBankAccount) updates) =>
      super.copyWith((message) => updates(message as LinkedBankAccount))
          as LinkedBankAccount;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LinkedBankAccount create() => LinkedBankAccount._();
  @$core.override
  LinkedBankAccount createEmptyInstance() => create();
  static $pb.PbList<LinkedBankAccount> createRepeated() =>
      $pb.PbList<LinkedBankAccount>();
  @$core.pragma('dart2js:noInline')
  static LinkedBankAccount getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LinkedBankAccount>(create);
  static LinkedBankAccount? _defaultInstance;

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
  $core.String get provider => $_getSZ(2);
  @$pb.TagNumber(3)
  set provider($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasProvider() => $_has(2);
  @$pb.TagNumber(3)
  void clearProvider() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get bankName => $_getSZ(3);
  @$pb.TagNumber(4)
  set bankName($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasBankName() => $_has(3);
  @$pb.TagNumber(4)
  void clearBankName() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get bankCode => $_getSZ(4);
  @$pb.TagNumber(5)
  set bankCode($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasBankCode() => $_has(4);
  @$pb.TagNumber(5)
  void clearBankCode() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get accountNumber => $_getSZ(5);
  @$pb.TagNumber(6)
  set accountNumber($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasAccountNumber() => $_has(5);
  @$pb.TagNumber(6)
  void clearAccountNumber() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get accountName => $_getSZ(6);
  @$pb.TagNumber(7)
  set accountName($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasAccountName() => $_has(6);
  @$pb.TagNumber(7)
  void clearAccountName() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get accountType => $_getSZ(7);
  @$pb.TagNumber(8)
  set accountType($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasAccountType() => $_has(7);
  @$pb.TagNumber(8)
  void clearAccountType() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get currency => $_getSZ(8);
  @$pb.TagNumber(9)
  set currency($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasCurrency() => $_has(8);
  @$pb.TagNumber(9)
  void clearCurrency() => $_clearField(9);

  @$pb.TagNumber(10)
  $fixnum.Int64 get lastKnownBalance => $_getI64(9);
  @$pb.TagNumber(10)
  set lastKnownBalance($fixnum.Int64 value) => $_setInt64(9, value);
  @$pb.TagNumber(10)
  $core.bool hasLastKnownBalance() => $_has(9);
  @$pb.TagNumber(10)
  void clearLastKnownBalance() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get status => $_getSZ(10);
  @$pb.TagNumber(11)
  set status($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasStatus() => $_has(10);
  @$pb.TagNumber(11)
  void clearStatus() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.bool get isDefault => $_getBF(11);
  @$pb.TagNumber(12)
  set isDefault($core.bool value) => $_setBool(11, value);
  @$pb.TagNumber(12)
  $core.bool hasIsDefault() => $_has(11);
  @$pb.TagNumber(12)
  void clearIsDefault() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.bool get isVerified => $_getBF(12);
  @$pb.TagNumber(13)
  set isVerified($core.bool value) => $_setBool(12, value);
  @$pb.TagNumber(13)
  $core.bool hasIsVerified() => $_has(12);
  @$pb.TagNumber(13)
  void clearIsVerified() => $_clearField(13);

  @$pb.TagNumber(14)
  $1.Timestamp get linkedAt => $_getN(13);
  @$pb.TagNumber(14)
  set linkedAt($1.Timestamp value) => $_setField(14, value);
  @$pb.TagNumber(14)
  $core.bool hasLinkedAt() => $_has(13);
  @$pb.TagNumber(14)
  void clearLinkedAt() => $_clearField(14);
  @$pb.TagNumber(14)
  $1.Timestamp ensureLinkedAt() => $_ensure(13);

  @$pb.TagNumber(15)
  $1.Timestamp get balanceUpdatedAt => $_getN(14);
  @$pb.TagNumber(15)
  set balanceUpdatedAt($1.Timestamp value) => $_setField(15, value);
  @$pb.TagNumber(15)
  $core.bool hasBalanceUpdatedAt() => $_has(14);
  @$pb.TagNumber(15)
  void clearBalanceUpdatedAt() => $_clearField(15);
  @$pb.TagNumber(15)
  $1.Timestamp ensureBalanceUpdatedAt() => $_ensure(14);

  @$pb.TagNumber(16)
  $1.Timestamp get lastUsedAt => $_getN(15);
  @$pb.TagNumber(16)
  set lastUsedAt($1.Timestamp value) => $_setField(16, value);
  @$pb.TagNumber(16)
  $core.bool hasLastUsedAt() => $_has(15);
  @$pb.TagNumber(16)
  void clearLastUsedAt() => $_clearField(16);
  @$pb.TagNumber(16)
  $1.Timestamp ensureLastUsedAt() => $_ensure(15);

  @$pb.TagNumber(17)
  $core.bool get needsReauthorize => $_getBF(16);
  @$pb.TagNumber(17)
  set needsReauthorize($core.bool value) => $_setBool(16, value);
  @$pb.TagNumber(17)
  $core.bool hasNeedsReauthorize() => $_has(16);
  @$pb.TagNumber(17)
  void clearNeedsReauthorize() => $_clearField(17);

  /// Transaction Sync Tracking
  @$pb.TagNumber(18)
  $1.Timestamp get lastSyncAt => $_getN(17);
  @$pb.TagNumber(18)
  set lastSyncAt($1.Timestamp value) => $_setField(18, value);
  @$pb.TagNumber(18)
  $core.bool hasLastSyncAt() => $_has(17);
  @$pb.TagNumber(18)
  void clearLastSyncAt() => $_clearField(18);
  @$pb.TagNumber(18)
  $1.Timestamp ensureLastSyncAt() => $_ensure(17);

  @$pb.TagNumber(19)
  $core.String get lastSyncStatus => $_getSZ(18);
  @$pb.TagNumber(19)
  set lastSyncStatus($core.String value) => $_setString(18, value);
  @$pb.TagNumber(19)
  $core.bool hasLastSyncStatus() => $_has(18);
  @$pb.TagNumber(19)
  void clearLastSyncStatus() => $_clearField(19);

  @$pb.TagNumber(20)
  $core.int get transactionCount => $_getIZ(19);
  @$pb.TagNumber(20)
  set transactionCount($core.int value) => $_setSignedInt32(19, value);
  @$pb.TagNumber(20)
  $core.bool hasTransactionCount() => $_has(19);
  @$pb.TagNumber(20)
  void clearTransactionCount() => $_clearField(20);

  @$pb.TagNumber(21)
  $core.int get syncErrorCount => $_getIZ(20);
  @$pb.TagNumber(21)
  set syncErrorCount($core.int value) => $_setSignedInt32(20, value);
  @$pb.TagNumber(21)
  $core.bool hasSyncErrorCount() => $_has(20);
  @$pb.TagNumber(21)
  void clearSyncErrorCount() => $_clearField(21);
}

/// Unlink Bank Account
class UnlinkBankAccountRequest extends $pb.GeneratedMessage {
  factory UnlinkBankAccountRequest({
    $core.String? accountId,
    $core.String? userId,
  }) {
    final result = create();
    if (accountId != null) result.accountId = accountId;
    if (userId != null) result.userId = userId;
    return result;
  }

  UnlinkBankAccountRequest._();

  factory UnlinkBankAccountRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UnlinkBankAccountRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UnlinkBankAccountRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountId')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UnlinkBankAccountRequest clone() =>
      UnlinkBankAccountRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UnlinkBankAccountRequest copyWith(
          void Function(UnlinkBankAccountRequest) updates) =>
      super.copyWith((message) => updates(message as UnlinkBankAccountRequest))
          as UnlinkBankAccountRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UnlinkBankAccountRequest create() => UnlinkBankAccountRequest._();
  @$core.override
  UnlinkBankAccountRequest createEmptyInstance() => create();
  static $pb.PbList<UnlinkBankAccountRequest> createRepeated() =>
      $pb.PbList<UnlinkBankAccountRequest>();
  @$core.pragma('dart2js:noInline')
  static UnlinkBankAccountRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UnlinkBankAccountRequest>(create);
  static UnlinkBankAccountRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => $_clearField(2);
}

class UnlinkBankAccountResponse extends $pb.GeneratedMessage {
  factory UnlinkBankAccountResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (errorCode != null) result.errorCode = errorCode;
    if (errorMessage != null) result.errorMessage = errorMessage;
    return result;
  }

  UnlinkBankAccountResponse._();

  factory UnlinkBankAccountResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UnlinkBankAccountResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UnlinkBankAccountResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'errorCode')
    ..aOS(3, _omitFieldNames ? '' : 'errorMessage')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UnlinkBankAccountResponse clone() =>
      UnlinkBankAccountResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UnlinkBankAccountResponse copyWith(
          void Function(UnlinkBankAccountResponse) updates) =>
      super.copyWith((message) => updates(message as UnlinkBankAccountResponse))
          as UnlinkBankAccountResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UnlinkBankAccountResponse create() => UnlinkBankAccountResponse._();
  @$core.override
  UnlinkBankAccountResponse createEmptyInstance() => create();
  static $pb.PbList<UnlinkBankAccountResponse> createRepeated() =>
      $pb.PbList<UnlinkBankAccountResponse>();
  @$core.pragma('dart2js:noInline')
  static UnlinkBankAccountResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UnlinkBankAccountResponse>(create);
  static UnlinkBankAccountResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => $_clearField(3);
}

/// Set Default Linked Account
class SetDefaultLinkedAccountRequest extends $pb.GeneratedMessage {
  factory SetDefaultLinkedAccountRequest({
    $core.String? accountId,
    $core.String? userId,
  }) {
    final result = create();
    if (accountId != null) result.accountId = accountId;
    if (userId != null) result.userId = userId;
    return result;
  }

  SetDefaultLinkedAccountRequest._();

  factory SetDefaultLinkedAccountRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SetDefaultLinkedAccountRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SetDefaultLinkedAccountRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountId')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetDefaultLinkedAccountRequest clone() =>
      SetDefaultLinkedAccountRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetDefaultLinkedAccountRequest copyWith(
          void Function(SetDefaultLinkedAccountRequest) updates) =>
      super.copyWith(
              (message) => updates(message as SetDefaultLinkedAccountRequest))
          as SetDefaultLinkedAccountRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SetDefaultLinkedAccountRequest create() =>
      SetDefaultLinkedAccountRequest._();
  @$core.override
  SetDefaultLinkedAccountRequest createEmptyInstance() => create();
  static $pb.PbList<SetDefaultLinkedAccountRequest> createRepeated() =>
      $pb.PbList<SetDefaultLinkedAccountRequest>();
  @$core.pragma('dart2js:noInline')
  static SetDefaultLinkedAccountRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SetDefaultLinkedAccountRequest>(create);
  static SetDefaultLinkedAccountRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => $_clearField(2);
}

class SetDefaultLinkedAccountResponse extends $pb.GeneratedMessage {
  factory SetDefaultLinkedAccountResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (errorCode != null) result.errorCode = errorCode;
    if (errorMessage != null) result.errorMessage = errorMessage;
    return result;
  }

  SetDefaultLinkedAccountResponse._();

  factory SetDefaultLinkedAccountResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SetDefaultLinkedAccountResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SetDefaultLinkedAccountResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'errorCode')
    ..aOS(3, _omitFieldNames ? '' : 'errorMessage')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetDefaultLinkedAccountResponse clone() =>
      SetDefaultLinkedAccountResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetDefaultLinkedAccountResponse copyWith(
          void Function(SetDefaultLinkedAccountResponse) updates) =>
      super.copyWith(
              (message) => updates(message as SetDefaultLinkedAccountResponse))
          as SetDefaultLinkedAccountResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SetDefaultLinkedAccountResponse create() =>
      SetDefaultLinkedAccountResponse._();
  @$core.override
  SetDefaultLinkedAccountResponse createEmptyInstance() => create();
  static $pb.PbList<SetDefaultLinkedAccountResponse> createRepeated() =>
      $pb.PbList<SetDefaultLinkedAccountResponse>();
  @$core.pragma('dart2js:noInline')
  static SetDefaultLinkedAccountResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SetDefaultLinkedAccountResponse>(
          create);
  static SetDefaultLinkedAccountResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => $_clearField(3);
}

/// Refresh Linked Account Balance
class RefreshLinkedAccountBalanceRequest extends $pb.GeneratedMessage {
  factory RefreshLinkedAccountBalanceRequest({
    $core.String? accountId,
    $core.String? userId,
  }) {
    final result = create();
    if (accountId != null) result.accountId = accountId;
    if (userId != null) result.userId = userId;
    return result;
  }

  RefreshLinkedAccountBalanceRequest._();

  factory RefreshLinkedAccountBalanceRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RefreshLinkedAccountBalanceRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RefreshLinkedAccountBalanceRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountId')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RefreshLinkedAccountBalanceRequest clone() =>
      RefreshLinkedAccountBalanceRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RefreshLinkedAccountBalanceRequest copyWith(
          void Function(RefreshLinkedAccountBalanceRequest) updates) =>
      super.copyWith((message) =>
              updates(message as RefreshLinkedAccountBalanceRequest))
          as RefreshLinkedAccountBalanceRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RefreshLinkedAccountBalanceRequest create() =>
      RefreshLinkedAccountBalanceRequest._();
  @$core.override
  RefreshLinkedAccountBalanceRequest createEmptyInstance() => create();
  static $pb.PbList<RefreshLinkedAccountBalanceRequest> createRepeated() =>
      $pb.PbList<RefreshLinkedAccountBalanceRequest>();
  @$core.pragma('dart2js:noInline')
  static RefreshLinkedAccountBalanceRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RefreshLinkedAccountBalanceRequest>(
          create);
  static RefreshLinkedAccountBalanceRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => $_clearField(2);
}

class RefreshLinkedAccountBalanceResponse extends $pb.GeneratedMessage {
  factory RefreshLinkedAccountBalanceResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
    $fixnum.Int64? newBalance,
    $core.String? currency,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (errorCode != null) result.errorCode = errorCode;
    if (errorMessage != null) result.errorMessage = errorMessage;
    if (newBalance != null) result.newBalance = newBalance;
    if (currency != null) result.currency = currency;
    return result;
  }

  RefreshLinkedAccountBalanceResponse._();

  factory RefreshLinkedAccountBalanceResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RefreshLinkedAccountBalanceResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RefreshLinkedAccountBalanceResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'errorCode')
    ..aOS(3, _omitFieldNames ? '' : 'errorMessage')
    ..aInt64(4, _omitFieldNames ? '' : 'newBalance')
    ..aOS(5, _omitFieldNames ? '' : 'currency')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RefreshLinkedAccountBalanceResponse clone() =>
      RefreshLinkedAccountBalanceResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RefreshLinkedAccountBalanceResponse copyWith(
          void Function(RefreshLinkedAccountBalanceResponse) updates) =>
      super.copyWith((message) =>
              updates(message as RefreshLinkedAccountBalanceResponse))
          as RefreshLinkedAccountBalanceResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RefreshLinkedAccountBalanceResponse create() =>
      RefreshLinkedAccountBalanceResponse._();
  @$core.override
  RefreshLinkedAccountBalanceResponse createEmptyInstance() => create();
  static $pb.PbList<RefreshLinkedAccountBalanceResponse> createRepeated() =>
      $pb.PbList<RefreshLinkedAccountBalanceResponse>();
  @$core.pragma('dart2js:noInline')
  static RefreshLinkedAccountBalanceResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          RefreshLinkedAccountBalanceResponse>(create);
  static RefreshLinkedAccountBalanceResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get newBalance => $_getI64(3);
  @$pb.TagNumber(4)
  set newBalance($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasNewBalance() => $_has(3);
  @$pb.TagNumber(4)
  void clearNewBalance() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get currency => $_getSZ(4);
  @$pb.TagNumber(5)
  set currency($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasCurrency() => $_has(4);
  @$pb.TagNumber(5)
  void clearCurrency() => $_clearField(5);
}

/// Reauthorization Token
class GetReauthorizationTokenRequest extends $pb.GeneratedMessage {
  factory GetReauthorizationTokenRequest({
    $core.String? accountId,
    $core.String? userId,
  }) {
    final result = create();
    if (accountId != null) result.accountId = accountId;
    if (userId != null) result.userId = userId;
    return result;
  }

  GetReauthorizationTokenRequest._();

  factory GetReauthorizationTokenRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetReauthorizationTokenRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetReauthorizationTokenRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountId')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetReauthorizationTokenRequest clone() =>
      GetReauthorizationTokenRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetReauthorizationTokenRequest copyWith(
          void Function(GetReauthorizationTokenRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetReauthorizationTokenRequest))
          as GetReauthorizationTokenRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetReauthorizationTokenRequest create() =>
      GetReauthorizationTokenRequest._();
  @$core.override
  GetReauthorizationTokenRequest createEmptyInstance() => create();
  static $pb.PbList<GetReauthorizationTokenRequest> createRepeated() =>
      $pb.PbList<GetReauthorizationTokenRequest>();
  @$core.pragma('dart2js:noInline')
  static GetReauthorizationTokenRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetReauthorizationTokenRequest>(create);
  static GetReauthorizationTokenRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => $_clearField(2);
}

class GetReauthorizationTokenResponse extends $pb.GeneratedMessage {
  factory GetReauthorizationTokenResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
    $core.String? token,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (errorCode != null) result.errorCode = errorCode;
    if (errorMessage != null) result.errorMessage = errorMessage;
    if (token != null) result.token = token;
    return result;
  }

  GetReauthorizationTokenResponse._();

  factory GetReauthorizationTokenResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetReauthorizationTokenResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetReauthorizationTokenResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'errorCode')
    ..aOS(3, _omitFieldNames ? '' : 'errorMessage')
    ..aOS(4, _omitFieldNames ? '' : 'token')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetReauthorizationTokenResponse clone() =>
      GetReauthorizationTokenResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetReauthorizationTokenResponse copyWith(
          void Function(GetReauthorizationTokenResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetReauthorizationTokenResponse))
          as GetReauthorizationTokenResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetReauthorizationTokenResponse create() =>
      GetReauthorizationTokenResponse._();
  @$core.override
  GetReauthorizationTokenResponse createEmptyInstance() => create();
  static $pb.PbList<GetReauthorizationTokenResponse> createRepeated() =>
      $pb.PbList<GetReauthorizationTokenResponse>();
  @$core.pragma('dart2js:noInline')
  static GetReauthorizationTokenResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetReauthorizationTokenResponse>(
          create);
  static GetReauthorizationTokenResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get token => $_getSZ(3);
  @$pb.TagNumber(4)
  set token($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasToken() => $_has(3);
  @$pb.TagNumber(4)
  void clearToken() => $_clearField(4);
}

/// External Bank Transaction
class ExternalBankTransaction extends $pb.GeneratedMessage {
  factory ExternalBankTransaction({
    $core.String? id,
    $core.String? userId,
    $core.String? linkedBankAccountId,
    $core.String? externalTransactionId,
    $core.String? externalAccountId,
    $fixnum.Int64? amount,
    $core.String? currency,
    $core.String? transactionType,
    $core.String? category,
    $core.String? description,
    $core.String? bankName,
    $core.String? accountName,
    $core.String? accountNumberMasked,
    $1.Timestamp? transactionDate,
    $1.Timestamp? valueDate,
    $1.Timestamp? clearedAt,
    $1.Timestamp? createdAt,
    $core.String? syncStatus,
    $1.Timestamp? lastSyncAt,
    $core.String? metadata,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (userId != null) result.userId = userId;
    if (linkedBankAccountId != null)
      result.linkedBankAccountId = linkedBankAccountId;
    if (externalTransactionId != null)
      result.externalTransactionId = externalTransactionId;
    if (externalAccountId != null) result.externalAccountId = externalAccountId;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    if (transactionType != null) result.transactionType = transactionType;
    if (category != null) result.category = category;
    if (description != null) result.description = description;
    if (bankName != null) result.bankName = bankName;
    if (accountName != null) result.accountName = accountName;
    if (accountNumberMasked != null)
      result.accountNumberMasked = accountNumberMasked;
    if (transactionDate != null) result.transactionDate = transactionDate;
    if (valueDate != null) result.valueDate = valueDate;
    if (clearedAt != null) result.clearedAt = clearedAt;
    if (createdAt != null) result.createdAt = createdAt;
    if (syncStatus != null) result.syncStatus = syncStatus;
    if (lastSyncAt != null) result.lastSyncAt = lastSyncAt;
    if (metadata != null) result.metadata = metadata;
    return result;
  }

  ExternalBankTransaction._();

  factory ExternalBankTransaction.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ExternalBankTransaction.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ExternalBankTransaction',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'linkedBankAccountId')
    ..aOS(4, _omitFieldNames ? '' : 'externalTransactionId')
    ..aOS(5, _omitFieldNames ? '' : 'externalAccountId')
    ..aInt64(6, _omitFieldNames ? '' : 'amount')
    ..aOS(7, _omitFieldNames ? '' : 'currency')
    ..aOS(8, _omitFieldNames ? '' : 'transactionType')
    ..aOS(9, _omitFieldNames ? '' : 'category')
    ..aOS(10, _omitFieldNames ? '' : 'description')
    ..aOS(11, _omitFieldNames ? '' : 'bankName')
    ..aOS(12, _omitFieldNames ? '' : 'accountName')
    ..aOS(13, _omitFieldNames ? '' : 'accountNumberMasked')
    ..aOM<$1.Timestamp>(14, _omitFieldNames ? '' : 'transactionDate',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(15, _omitFieldNames ? '' : 'valueDate',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(16, _omitFieldNames ? '' : 'clearedAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(17, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $1.Timestamp.create)
    ..aOS(18, _omitFieldNames ? '' : 'syncStatus')
    ..aOM<$1.Timestamp>(19, _omitFieldNames ? '' : 'lastSyncAt',
        subBuilder: $1.Timestamp.create)
    ..aOS(20, _omitFieldNames ? '' : 'metadata')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExternalBankTransaction clone() =>
      ExternalBankTransaction()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExternalBankTransaction copyWith(
          void Function(ExternalBankTransaction) updates) =>
      super.copyWith((message) => updates(message as ExternalBankTransaction))
          as ExternalBankTransaction;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ExternalBankTransaction create() => ExternalBankTransaction._();
  @$core.override
  ExternalBankTransaction createEmptyInstance() => create();
  static $pb.PbList<ExternalBankTransaction> createRepeated() =>
      $pb.PbList<ExternalBankTransaction>();
  @$core.pragma('dart2js:noInline')
  static ExternalBankTransaction getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ExternalBankTransaction>(create);
  static ExternalBankTransaction? _defaultInstance;

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
  $core.String get linkedBankAccountId => $_getSZ(2);
  @$pb.TagNumber(3)
  set linkedBankAccountId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasLinkedBankAccountId() => $_has(2);
  @$pb.TagNumber(3)
  void clearLinkedBankAccountId() => $_clearField(3);

  /// External identifiers
  @$pb.TagNumber(4)
  $core.String get externalTransactionId => $_getSZ(3);
  @$pb.TagNumber(4)
  set externalTransactionId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasExternalTransactionId() => $_has(3);
  @$pb.TagNumber(4)
  void clearExternalTransactionId() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get externalAccountId => $_getSZ(4);
  @$pb.TagNumber(5)
  set externalAccountId($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasExternalAccountId() => $_has(4);
  @$pb.TagNumber(5)
  void clearExternalAccountId() => $_clearField(5);

  /// Transaction details
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
  $core.String get transactionType => $_getSZ(7);
  @$pb.TagNumber(8)
  set transactionType($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasTransactionType() => $_has(7);
  @$pb.TagNumber(8)
  void clearTransactionType() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get category => $_getSZ(8);
  @$pb.TagNumber(9)
  set category($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasCategory() => $_has(8);
  @$pb.TagNumber(9)
  void clearCategory() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get description => $_getSZ(9);
  @$pb.TagNumber(10)
  set description($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasDescription() => $_has(9);
  @$pb.TagNumber(10)
  void clearDescription() => $_clearField(10);

  /// Bank info
  @$pb.TagNumber(11)
  $core.String get bankName => $_getSZ(10);
  @$pb.TagNumber(11)
  set bankName($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasBankName() => $_has(10);
  @$pb.TagNumber(11)
  void clearBankName() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get accountName => $_getSZ(11);
  @$pb.TagNumber(12)
  set accountName($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasAccountName() => $_has(11);
  @$pb.TagNumber(12)
  void clearAccountName() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.String get accountNumberMasked => $_getSZ(12);
  @$pb.TagNumber(13)
  set accountNumberMasked($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasAccountNumberMasked() => $_has(12);
  @$pb.TagNumber(13)
  void clearAccountNumberMasked() => $_clearField(13);

  /// Dates
  @$pb.TagNumber(14)
  $1.Timestamp get transactionDate => $_getN(13);
  @$pb.TagNumber(14)
  set transactionDate($1.Timestamp value) => $_setField(14, value);
  @$pb.TagNumber(14)
  $core.bool hasTransactionDate() => $_has(13);
  @$pb.TagNumber(14)
  void clearTransactionDate() => $_clearField(14);
  @$pb.TagNumber(14)
  $1.Timestamp ensureTransactionDate() => $_ensure(13);

  @$pb.TagNumber(15)
  $1.Timestamp get valueDate => $_getN(14);
  @$pb.TagNumber(15)
  set valueDate($1.Timestamp value) => $_setField(15, value);
  @$pb.TagNumber(15)
  $core.bool hasValueDate() => $_has(14);
  @$pb.TagNumber(15)
  void clearValueDate() => $_clearField(15);
  @$pb.TagNumber(15)
  $1.Timestamp ensureValueDate() => $_ensure(14);

  @$pb.TagNumber(16)
  $1.Timestamp get clearedAt => $_getN(15);
  @$pb.TagNumber(16)
  set clearedAt($1.Timestamp value) => $_setField(16, value);
  @$pb.TagNumber(16)
  $core.bool hasClearedAt() => $_has(15);
  @$pb.TagNumber(16)
  void clearClearedAt() => $_clearField(16);
  @$pb.TagNumber(16)
  $1.Timestamp ensureClearedAt() => $_ensure(15);

  @$pb.TagNumber(17)
  $1.Timestamp get createdAt => $_getN(16);
  @$pb.TagNumber(17)
  set createdAt($1.Timestamp value) => $_setField(17, value);
  @$pb.TagNumber(17)
  $core.bool hasCreatedAt() => $_has(16);
  @$pb.TagNumber(17)
  void clearCreatedAt() => $_clearField(17);
  @$pb.TagNumber(17)
  $1.Timestamp ensureCreatedAt() => $_ensure(16);

  /// Sync status
  @$pb.TagNumber(18)
  $core.String get syncStatus => $_getSZ(17);
  @$pb.TagNumber(18)
  set syncStatus($core.String value) => $_setString(17, value);
  @$pb.TagNumber(18)
  $core.bool hasSyncStatus() => $_has(17);
  @$pb.TagNumber(18)
  void clearSyncStatus() => $_clearField(18);

  @$pb.TagNumber(19)
  $1.Timestamp get lastSyncAt => $_getN(18);
  @$pb.TagNumber(19)
  set lastSyncAt($1.Timestamp value) => $_setField(19, value);
  @$pb.TagNumber(19)
  $core.bool hasLastSyncAt() => $_has(18);
  @$pb.TagNumber(19)
  void clearLastSyncAt() => $_clearField(19);
  @$pb.TagNumber(19)
  $1.Timestamp ensureLastSyncAt() => $_ensure(18);

  /// Additional
  @$pb.TagNumber(20)
  $core.String get metadata => $_getSZ(19);
  @$pb.TagNumber(20)
  set metadata($core.String value) => $_setString(19, value);
  @$pb.TagNumber(20)
  $core.bool hasMetadata() => $_has(19);
  @$pb.TagNumber(20)
  void clearMetadata() => $_clearField(20);
}

/// Sync All Account Transactions
class SyncAllAccountTransactionsRequest extends $pb.GeneratedMessage {
  factory SyncAllAccountTransactionsRequest({
    $core.String? userId,
    $core.String? syncType,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    if (syncType != null) result.syncType = syncType;
    return result;
  }

  SyncAllAccountTransactionsRequest._();

  factory SyncAllAccountTransactionsRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SyncAllAccountTransactionsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SyncAllAccountTransactionsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'syncType')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SyncAllAccountTransactionsRequest clone() =>
      SyncAllAccountTransactionsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SyncAllAccountTransactionsRequest copyWith(
          void Function(SyncAllAccountTransactionsRequest) updates) =>
      super.copyWith((message) =>
              updates(message as SyncAllAccountTransactionsRequest))
          as SyncAllAccountTransactionsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SyncAllAccountTransactionsRequest create() =>
      SyncAllAccountTransactionsRequest._();
  @$core.override
  SyncAllAccountTransactionsRequest createEmptyInstance() => create();
  static $pb.PbList<SyncAllAccountTransactionsRequest> createRepeated() =>
      $pb.PbList<SyncAllAccountTransactionsRequest>();
  @$core.pragma('dart2js:noInline')
  static SyncAllAccountTransactionsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SyncAllAccountTransactionsRequest>(
          create);
  static SyncAllAccountTransactionsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get syncType => $_getSZ(1);
  @$pb.TagNumber(2)
  set syncType($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSyncType() => $_has(1);
  @$pb.TagNumber(2)
  void clearSyncType() => $_clearField(2);
}

class SyncAllAccountTransactionsResponse extends $pb.GeneratedMessage {
  factory SyncAllAccountTransactionsResponse({
    $core.bool? success,
    $core.int? totalAccountsSynced,
    $core.int? totalTransactionsSynced,
    $core.Iterable<AccountSyncResult>? accounts,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (totalAccountsSynced != null)
      result.totalAccountsSynced = totalAccountsSynced;
    if (totalTransactionsSynced != null)
      result.totalTransactionsSynced = totalTransactionsSynced;
    if (accounts != null) result.accounts.addAll(accounts);
    return result;
  }

  SyncAllAccountTransactionsResponse._();

  factory SyncAllAccountTransactionsResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SyncAllAccountTransactionsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SyncAllAccountTransactionsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..a<$core.int>(
        2, _omitFieldNames ? '' : 'totalAccountsSynced', $pb.PbFieldType.O3)
    ..a<$core.int>(
        3, _omitFieldNames ? '' : 'totalTransactionsSynced', $pb.PbFieldType.O3)
    ..pc<AccountSyncResult>(
        4, _omitFieldNames ? '' : 'accounts', $pb.PbFieldType.PM,
        subBuilder: AccountSyncResult.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SyncAllAccountTransactionsResponse clone() =>
      SyncAllAccountTransactionsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SyncAllAccountTransactionsResponse copyWith(
          void Function(SyncAllAccountTransactionsResponse) updates) =>
      super.copyWith((message) =>
              updates(message as SyncAllAccountTransactionsResponse))
          as SyncAllAccountTransactionsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SyncAllAccountTransactionsResponse create() =>
      SyncAllAccountTransactionsResponse._();
  @$core.override
  SyncAllAccountTransactionsResponse createEmptyInstance() => create();
  static $pb.PbList<SyncAllAccountTransactionsResponse> createRepeated() =>
      $pb.PbList<SyncAllAccountTransactionsResponse>();
  @$core.pragma('dart2js:noInline')
  static SyncAllAccountTransactionsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SyncAllAccountTransactionsResponse>(
          create);
  static SyncAllAccountTransactionsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get totalAccountsSynced => $_getIZ(1);
  @$pb.TagNumber(2)
  set totalAccountsSynced($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotalAccountsSynced() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalAccountsSynced() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get totalTransactionsSynced => $_getIZ(2);
  @$pb.TagNumber(3)
  set totalTransactionsSynced($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTotalTransactionsSynced() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalTransactionsSynced() => $_clearField(3);

  @$pb.TagNumber(4)
  $pb.PbList<AccountSyncResult> get accounts => $_getList(3);
}

class AccountSyncResult extends $pb.GeneratedMessage {
  factory AccountSyncResult({
    $core.String? accountId,
    $core.String? bankName,
    $core.int? transactionsSynced,
    $core.bool? success,
    $core.String? error,
  }) {
    final result = create();
    if (accountId != null) result.accountId = accountId;
    if (bankName != null) result.bankName = bankName;
    if (transactionsSynced != null)
      result.transactionsSynced = transactionsSynced;
    if (success != null) result.success = success;
    if (error != null) result.error = error;
    return result;
  }

  AccountSyncResult._();

  factory AccountSyncResult.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AccountSyncResult.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AccountSyncResult',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountId')
    ..aOS(2, _omitFieldNames ? '' : 'bankName')
    ..a<$core.int>(
        3, _omitFieldNames ? '' : 'transactionsSynced', $pb.PbFieldType.O3)
    ..aOB(4, _omitFieldNames ? '' : 'success')
    ..aOS(5, _omitFieldNames ? '' : 'error')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AccountSyncResult clone() => AccountSyncResult()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AccountSyncResult copyWith(void Function(AccountSyncResult) updates) =>
      super.copyWith((message) => updates(message as AccountSyncResult))
          as AccountSyncResult;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AccountSyncResult create() => AccountSyncResult._();
  @$core.override
  AccountSyncResult createEmptyInstance() => create();
  static $pb.PbList<AccountSyncResult> createRepeated() =>
      $pb.PbList<AccountSyncResult>();
  @$core.pragma('dart2js:noInline')
  static AccountSyncResult getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AccountSyncResult>(create);
  static AccountSyncResult? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get bankName => $_getSZ(1);
  @$pb.TagNumber(2)
  set bankName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasBankName() => $_has(1);
  @$pb.TagNumber(2)
  void clearBankName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get transactionsSynced => $_getIZ(2);
  @$pb.TagNumber(3)
  set transactionsSynced($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTransactionsSynced() => $_has(2);
  @$pb.TagNumber(3)
  void clearTransactionsSynced() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.bool get success => $_getBF(3);
  @$pb.TagNumber(4)
  set success($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasSuccess() => $_has(3);
  @$pb.TagNumber(4)
  void clearSuccess() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get error => $_getSZ(4);
  @$pb.TagNumber(5)
  set error($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasError() => $_has(4);
  @$pb.TagNumber(5)
  void clearError() => $_clearField(5);
}

/// Sync External Transactions
class SyncExternalTransactionsRequest extends $pb.GeneratedMessage {
  factory SyncExternalTransactionsRequest({
    $core.String? accountId,
    $core.String? syncType,
    $1.Timestamp? startDate,
    $1.Timestamp? endDate,
  }) {
    final result = create();
    if (accountId != null) result.accountId = accountId;
    if (syncType != null) result.syncType = syncType;
    if (startDate != null) result.startDate = startDate;
    if (endDate != null) result.endDate = endDate;
    return result;
  }

  SyncExternalTransactionsRequest._();

  factory SyncExternalTransactionsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SyncExternalTransactionsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SyncExternalTransactionsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountId')
    ..aOS(2, _omitFieldNames ? '' : 'syncType')
    ..aOM<$1.Timestamp>(3, _omitFieldNames ? '' : 'startDate',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(4, _omitFieldNames ? '' : 'endDate',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SyncExternalTransactionsRequest clone() =>
      SyncExternalTransactionsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SyncExternalTransactionsRequest copyWith(
          void Function(SyncExternalTransactionsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as SyncExternalTransactionsRequest))
          as SyncExternalTransactionsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SyncExternalTransactionsRequest create() =>
      SyncExternalTransactionsRequest._();
  @$core.override
  SyncExternalTransactionsRequest createEmptyInstance() => create();
  static $pb.PbList<SyncExternalTransactionsRequest> createRepeated() =>
      $pb.PbList<SyncExternalTransactionsRequest>();
  @$core.pragma('dart2js:noInline')
  static SyncExternalTransactionsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SyncExternalTransactionsRequest>(
          create);
  static SyncExternalTransactionsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get syncType => $_getSZ(1);
  @$pb.TagNumber(2)
  set syncType($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSyncType() => $_has(1);
  @$pb.TagNumber(2)
  void clearSyncType() => $_clearField(2);

  @$pb.TagNumber(3)
  $1.Timestamp get startDate => $_getN(2);
  @$pb.TagNumber(3)
  set startDate($1.Timestamp value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasStartDate() => $_has(2);
  @$pb.TagNumber(3)
  void clearStartDate() => $_clearField(3);
  @$pb.TagNumber(3)
  $1.Timestamp ensureStartDate() => $_ensure(2);

  @$pb.TagNumber(4)
  $1.Timestamp get endDate => $_getN(3);
  @$pb.TagNumber(4)
  set endDate($1.Timestamp value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasEndDate() => $_has(3);
  @$pb.TagNumber(4)
  void clearEndDate() => $_clearField(4);
  @$pb.TagNumber(4)
  $1.Timestamp ensureEndDate() => $_ensure(3);
}

class SyncExternalTransactionsResponse extends $pb.GeneratedMessage {
  factory SyncExternalTransactionsResponse({
    $core.bool? success,
    $core.int? transactionsSynced,
    $core.int? transactionsSkipped,
    $core.String? syncId,
    $core.Iterable<ExternalBankTransaction>? transactions,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (transactionsSynced != null)
      result.transactionsSynced = transactionsSynced;
    if (transactionsSkipped != null)
      result.transactionsSkipped = transactionsSkipped;
    if (syncId != null) result.syncId = syncId;
    if (transactions != null) result.transactions.addAll(transactions);
    return result;
  }

  SyncExternalTransactionsResponse._();

  factory SyncExternalTransactionsResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SyncExternalTransactionsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SyncExternalTransactionsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..a<$core.int>(
        2, _omitFieldNames ? '' : 'transactionsSynced', $pb.PbFieldType.O3)
    ..a<$core.int>(
        3, _omitFieldNames ? '' : 'transactionsSkipped', $pb.PbFieldType.O3)
    ..aOS(4, _omitFieldNames ? '' : 'syncId')
    ..pc<ExternalBankTransaction>(
        5, _omitFieldNames ? '' : 'transactions', $pb.PbFieldType.PM,
        subBuilder: ExternalBankTransaction.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SyncExternalTransactionsResponse clone() =>
      SyncExternalTransactionsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SyncExternalTransactionsResponse copyWith(
          void Function(SyncExternalTransactionsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as SyncExternalTransactionsResponse))
          as SyncExternalTransactionsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SyncExternalTransactionsResponse create() =>
      SyncExternalTransactionsResponse._();
  @$core.override
  SyncExternalTransactionsResponse createEmptyInstance() => create();
  static $pb.PbList<SyncExternalTransactionsResponse> createRepeated() =>
      $pb.PbList<SyncExternalTransactionsResponse>();
  @$core.pragma('dart2js:noInline')
  static SyncExternalTransactionsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SyncExternalTransactionsResponse>(
          create);
  static SyncExternalTransactionsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get transactionsSynced => $_getIZ(1);
  @$pb.TagNumber(2)
  set transactionsSynced($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTransactionsSynced() => $_has(1);
  @$pb.TagNumber(2)
  void clearTransactionsSynced() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get transactionsSkipped => $_getIZ(2);
  @$pb.TagNumber(3)
  set transactionsSkipped($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTransactionsSkipped() => $_has(2);
  @$pb.TagNumber(3)
  void clearTransactionsSkipped() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get syncId => $_getSZ(3);
  @$pb.TagNumber(4)
  set syncId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasSyncId() => $_has(3);
  @$pb.TagNumber(4)
  void clearSyncId() => $_clearField(4);

  @$pb.TagNumber(5)
  $pb.PbList<ExternalBankTransaction> get transactions => $_getList(4);
}

/// Get Account With Transactions
class GetAccountWithTransactionsRequest extends $pb.GeneratedMessage {
  factory GetAccountWithTransactionsRequest({
    $core.String? accountId,
    $core.int? limit,
    $core.int? offset,
  }) {
    final result = create();
    if (accountId != null) result.accountId = accountId;
    if (limit != null) result.limit = limit;
    if (offset != null) result.offset = offset;
    return result;
  }

  GetAccountWithTransactionsRequest._();

  factory GetAccountWithTransactionsRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetAccountWithTransactionsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetAccountWithTransactionsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountId')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAccountWithTransactionsRequest clone() =>
      GetAccountWithTransactionsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAccountWithTransactionsRequest copyWith(
          void Function(GetAccountWithTransactionsRequest) updates) =>
      super.copyWith((message) =>
              updates(message as GetAccountWithTransactionsRequest))
          as GetAccountWithTransactionsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAccountWithTransactionsRequest create() =>
      GetAccountWithTransactionsRequest._();
  @$core.override
  GetAccountWithTransactionsRequest createEmptyInstance() => create();
  static $pb.PbList<GetAccountWithTransactionsRequest> createRepeated() =>
      $pb.PbList<GetAccountWithTransactionsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetAccountWithTransactionsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetAccountWithTransactionsRequest>(
          create);
  static GetAccountWithTransactionsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => $_clearField(1);

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

class GetAccountWithTransactionsResponse extends $pb.GeneratedMessage {
  factory GetAccountWithTransactionsResponse({
    LinkedBankAccount? account,
    $core.Iterable<ExternalBankTransaction>? transactions,
    $fixnum.Int64? totalTransactions,
    $1.Timestamp? lastSyncAt,
  }) {
    final result = create();
    if (account != null) result.account = account;
    if (transactions != null) result.transactions.addAll(transactions);
    if (totalTransactions != null) result.totalTransactions = totalTransactions;
    if (lastSyncAt != null) result.lastSyncAt = lastSyncAt;
    return result;
  }

  GetAccountWithTransactionsResponse._();

  factory GetAccountWithTransactionsResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetAccountWithTransactionsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetAccountWithTransactionsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOM<LinkedBankAccount>(1, _omitFieldNames ? '' : 'account',
        subBuilder: LinkedBankAccount.create)
    ..pc<ExternalBankTransaction>(
        2, _omitFieldNames ? '' : 'transactions', $pb.PbFieldType.PM,
        subBuilder: ExternalBankTransaction.create)
    ..aInt64(3, _omitFieldNames ? '' : 'totalTransactions')
    ..aOM<$1.Timestamp>(4, _omitFieldNames ? '' : 'lastSyncAt',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAccountWithTransactionsResponse clone() =>
      GetAccountWithTransactionsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAccountWithTransactionsResponse copyWith(
          void Function(GetAccountWithTransactionsResponse) updates) =>
      super.copyWith((message) =>
              updates(message as GetAccountWithTransactionsResponse))
          as GetAccountWithTransactionsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAccountWithTransactionsResponse create() =>
      GetAccountWithTransactionsResponse._();
  @$core.override
  GetAccountWithTransactionsResponse createEmptyInstance() => create();
  static $pb.PbList<GetAccountWithTransactionsResponse> createRepeated() =>
      $pb.PbList<GetAccountWithTransactionsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetAccountWithTransactionsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetAccountWithTransactionsResponse>(
          create);
  static GetAccountWithTransactionsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  LinkedBankAccount get account => $_getN(0);
  @$pb.TagNumber(1)
  set account(LinkedBankAccount value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasAccount() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccount() => $_clearField(1);
  @$pb.TagNumber(1)
  LinkedBankAccount ensureAccount() => $_ensure(0);

  @$pb.TagNumber(2)
  $pb.PbList<ExternalBankTransaction> get transactions => $_getList(1);

  @$pb.TagNumber(3)
  $fixnum.Int64 get totalTransactions => $_getI64(2);
  @$pb.TagNumber(3)
  set totalTransactions($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTotalTransactions() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalTransactions() => $_clearField(3);

  @$pb.TagNumber(4)
  $1.Timestamp get lastSyncAt => $_getN(3);
  @$pb.TagNumber(4)
  set lastSyncAt($1.Timestamp value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasLastSyncAt() => $_has(3);
  @$pb.TagNumber(4)
  void clearLastSyncAt() => $_clearField(4);
  @$pb.TagNumber(4)
  $1.Timestamp ensureLastSyncAt() => $_ensure(3);
}

/// Refresh Account Transactions
class RefreshAccountTransactionsRequest extends $pb.GeneratedMessage {
  factory RefreshAccountTransactionsRequest({
    $core.String? accountId,
  }) {
    final result = create();
    if (accountId != null) result.accountId = accountId;
    return result;
  }

  RefreshAccountTransactionsRequest._();

  factory RefreshAccountTransactionsRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RefreshAccountTransactionsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RefreshAccountTransactionsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RefreshAccountTransactionsRequest clone() =>
      RefreshAccountTransactionsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RefreshAccountTransactionsRequest copyWith(
          void Function(RefreshAccountTransactionsRequest) updates) =>
      super.copyWith((message) =>
              updates(message as RefreshAccountTransactionsRequest))
          as RefreshAccountTransactionsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RefreshAccountTransactionsRequest create() =>
      RefreshAccountTransactionsRequest._();
  @$core.override
  RefreshAccountTransactionsRequest createEmptyInstance() => create();
  static $pb.PbList<RefreshAccountTransactionsRequest> createRepeated() =>
      $pb.PbList<RefreshAccountTransactionsRequest>();
  @$core.pragma('dart2js:noInline')
  static RefreshAccountTransactionsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RefreshAccountTransactionsRequest>(
          create);
  static RefreshAccountTransactionsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => $_clearField(1);
}

class RefreshAccountTransactionsResponse extends $pb.GeneratedMessage {
  factory RefreshAccountTransactionsResponse({
    $core.bool? success,
    $core.int? transactionsSynced,
    $fixnum.Int64? newBalance,
    $core.String? syncId,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (transactionsSynced != null)
      result.transactionsSynced = transactionsSynced;
    if (newBalance != null) result.newBalance = newBalance;
    if (syncId != null) result.syncId = syncId;
    return result;
  }

  RefreshAccountTransactionsResponse._();

  factory RefreshAccountTransactionsResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RefreshAccountTransactionsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RefreshAccountTransactionsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..a<$core.int>(
        2, _omitFieldNames ? '' : 'transactionsSynced', $pb.PbFieldType.O3)
    ..aInt64(3, _omitFieldNames ? '' : 'newBalance')
    ..aOS(4, _omitFieldNames ? '' : 'syncId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RefreshAccountTransactionsResponse clone() =>
      RefreshAccountTransactionsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RefreshAccountTransactionsResponse copyWith(
          void Function(RefreshAccountTransactionsResponse) updates) =>
      super.copyWith((message) =>
              updates(message as RefreshAccountTransactionsResponse))
          as RefreshAccountTransactionsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RefreshAccountTransactionsResponse create() =>
      RefreshAccountTransactionsResponse._();
  @$core.override
  RefreshAccountTransactionsResponse createEmptyInstance() => create();
  static $pb.PbList<RefreshAccountTransactionsResponse> createRepeated() =>
      $pb.PbList<RefreshAccountTransactionsResponse>();
  @$core.pragma('dart2js:noInline')
  static RefreshAccountTransactionsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RefreshAccountTransactionsResponse>(
          create);
  static RefreshAccountTransactionsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get transactionsSynced => $_getIZ(1);
  @$pb.TagNumber(2)
  set transactionsSynced($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTransactionsSynced() => $_has(1);
  @$pb.TagNumber(2)
  void clearTransactionsSynced() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get newBalance => $_getI64(2);
  @$pb.TagNumber(3)
  set newBalance($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasNewBalance() => $_has(2);
  @$pb.TagNumber(3)
  void clearNewBalance() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get syncId => $_getSZ(3);
  @$pb.TagNumber(4)
  set syncId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasSyncId() => $_has(3);
  @$pb.TagNumber(4)
  void clearSyncId() => $_clearField(4);
}

/// Initiate Deposit
class InitiateDepositRequest extends $pb.GeneratedMessage {
  factory InitiateDepositRequest({
    $core.String? userId,
    $core.String? linkedAccountId,
    $core.String? destinationAccountId,
    $fixnum.Int64? amount,
    $core.String? narration,
    $core.String? idempotencyKey,
    $core.bool? useRecurringAccess,
    $core.String? countryCode,
    $core.String? currency,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    if (linkedAccountId != null) result.linkedAccountId = linkedAccountId;
    if (destinationAccountId != null)
      result.destinationAccountId = destinationAccountId;
    if (amount != null) result.amount = amount;
    if (narration != null) result.narration = narration;
    if (idempotencyKey != null) result.idempotencyKey = idempotencyKey;
    if (useRecurringAccess != null)
      result.useRecurringAccess = useRecurringAccess;
    if (countryCode != null) result.countryCode = countryCode;
    if (currency != null) result.currency = currency;
    return result;
  }

  InitiateDepositRequest._();

  factory InitiateDepositRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InitiateDepositRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InitiateDepositRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'linkedAccountId')
    ..aOS(3, _omitFieldNames ? '' : 'destinationAccountId')
    ..aInt64(4, _omitFieldNames ? '' : 'amount')
    ..aOS(5, _omitFieldNames ? '' : 'narration')
    ..aOS(6, _omitFieldNames ? '' : 'idempotencyKey')
    ..aOB(7, _omitFieldNames ? '' : 'useRecurringAccess')
    ..aOS(8, _omitFieldNames ? '' : 'countryCode')
    ..aOS(9, _omitFieldNames ? '' : 'currency')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InitiateDepositRequest clone() =>
      InitiateDepositRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InitiateDepositRequest copyWith(
          void Function(InitiateDepositRequest) updates) =>
      super.copyWith((message) => updates(message as InitiateDepositRequest))
          as InitiateDepositRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InitiateDepositRequest create() => InitiateDepositRequest._();
  @$core.override
  InitiateDepositRequest createEmptyInstance() => create();
  static $pb.PbList<InitiateDepositRequest> createRepeated() =>
      $pb.PbList<InitiateDepositRequest>();
  @$core.pragma('dart2js:noInline')
  static InitiateDepositRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InitiateDepositRequest>(create);
  static InitiateDepositRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get linkedAccountId => $_getSZ(1);
  @$pb.TagNumber(2)
  set linkedAccountId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLinkedAccountId() => $_has(1);
  @$pb.TagNumber(2)
  void clearLinkedAccountId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get destinationAccountId => $_getSZ(2);
  @$pb.TagNumber(3)
  set destinationAccountId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDestinationAccountId() => $_has(2);
  @$pb.TagNumber(3)
  void clearDestinationAccountId() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get amount => $_getI64(3);
  @$pb.TagNumber(4)
  set amount($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearAmount() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get narration => $_getSZ(4);
  @$pb.TagNumber(5)
  set narration($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasNarration() => $_has(4);
  @$pb.TagNumber(5)
  void clearNarration() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get idempotencyKey => $_getSZ(5);
  @$pb.TagNumber(6)
  set idempotencyKey($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasIdempotencyKey() => $_has(5);
  @$pb.TagNumber(6)
  void clearIdempotencyKey() => $_clearField(6);

  /// Access type control for DirectPay vs Mandate
  @$pb.TagNumber(7)
  $core.bool get useRecurringAccess => $_getBF(6);
  @$pb.TagNumber(7)
  set useRecurringAccess($core.bool value) => $_setBool(6, value);
  @$pb.TagNumber(7)
  $core.bool hasUseRecurringAccess() => $_has(6);
  @$pb.TagNumber(7)
  void clearUseRecurringAccess() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get countryCode => $_getSZ(7);
  @$pb.TagNumber(8)
  set countryCode($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasCountryCode() => $_has(7);
  @$pb.TagNumber(8)
  void clearCountryCode() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get currency => $_getSZ(8);
  @$pb.TagNumber(9)
  set currency($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasCurrency() => $_has(8);
  @$pb.TagNumber(9)
  void clearCurrency() => $_clearField(9);
}

class DepositResponse extends $pb.GeneratedMessage {
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
    $core.String? provider,
    $core.String? countryCode,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (errorCode != null) result.errorCode = errorCode;
    if (errorMessage != null) result.errorMessage = errorMessage;
    if (deposit != null) result.deposit = deposit;
    if (message != null) result.message = message;
    if (needsMandate != null) result.needsMandate = needsMandate;
    if (mandateId != null) result.mandateId = mandateId;
    if (authorizationUrl != null) result.authorizationUrl = authorizationUrl;
    if (requiresAuthorization != null)
      result.requiresAuthorization = requiresAuthorization;
    if (paymentUrl != null) result.paymentUrl = paymentUrl;
    if (paymentId != null) result.paymentId = paymentId;
    if (provider != null) result.provider = provider;
    if (countryCode != null) result.countryCode = countryCode;
    return result;
  }

  DepositResponse._();

  factory DepositResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DepositResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DepositResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'errorCode')
    ..aOS(3, _omitFieldNames ? '' : 'errorMessage')
    ..aOM<Deposit>(4, _omitFieldNames ? '' : 'deposit',
        subBuilder: Deposit.create)
    ..aOS(5, _omitFieldNames ? '' : 'message')
    ..aOB(6, _omitFieldNames ? '' : 'needsMandate')
    ..aOS(7, _omitFieldNames ? '' : 'mandateId')
    ..aOS(8, _omitFieldNames ? '' : 'authorizationUrl')
    ..aOB(9, _omitFieldNames ? '' : 'requiresAuthorization')
    ..aOS(10, _omitFieldNames ? '' : 'paymentUrl')
    ..aOS(11, _omitFieldNames ? '' : 'paymentId')
    ..aOS(12, _omitFieldNames ? '' : 'provider')
    ..aOS(13, _omitFieldNames ? '' : 'countryCode')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DepositResponse clone() => DepositResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DepositResponse copyWith(void Function(DepositResponse) updates) =>
      super.copyWith((message) => updates(message as DepositResponse))
          as DepositResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DepositResponse create() => DepositResponse._();
  @$core.override
  DepositResponse createEmptyInstance() => create();
  static $pb.PbList<DepositResponse> createRepeated() =>
      $pb.PbList<DepositResponse>();
  @$core.pragma('dart2js:noInline')
  static DepositResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DepositResponse>(create);
  static DepositResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => $_clearField(3);

  @$pb.TagNumber(4)
  Deposit get deposit => $_getN(3);
  @$pb.TagNumber(4)
  set deposit(Deposit value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasDeposit() => $_has(3);
  @$pb.TagNumber(4)
  void clearDeposit() => $_clearField(4);
  @$pb.TagNumber(4)
  Deposit ensureDeposit() => $_ensure(3);

  @$pb.TagNumber(5)
  $core.String get message => $_getSZ(4);
  @$pb.TagNumber(5)
  set message($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasMessage() => $_has(4);
  @$pb.TagNumber(5)
  void clearMessage() => $_clearField(5);

  /// Mandate-related fields (for production direct debit flow)
  @$pb.TagNumber(6)
  $core.bool get needsMandate => $_getBF(5);
  @$pb.TagNumber(6)
  set needsMandate($core.bool value) => $_setBool(5, value);
  @$pb.TagNumber(6)
  $core.bool hasNeedsMandate() => $_has(5);
  @$pb.TagNumber(6)
  void clearNeedsMandate() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get mandateId => $_getSZ(6);
  @$pb.TagNumber(7)
  set mandateId($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasMandateId() => $_has(6);
  @$pb.TagNumber(7)
  void clearMandateId() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get authorizationUrl => $_getSZ(7);
  @$pb.TagNumber(8)
  set authorizationUrl($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasAuthorizationUrl() => $_has(7);
  @$pb.TagNumber(8)
  void clearAuthorizationUrl() => $_clearField(8);

  /// DirectPay fields (for one-time payments)
  @$pb.TagNumber(9)
  $core.bool get requiresAuthorization => $_getBF(8);
  @$pb.TagNumber(9)
  set requiresAuthorization($core.bool value) => $_setBool(8, value);
  @$pb.TagNumber(9)
  $core.bool hasRequiresAuthorization() => $_has(8);
  @$pb.TagNumber(9)
  void clearRequiresAuthorization() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get paymentUrl => $_getSZ(9);
  @$pb.TagNumber(10)
  set paymentUrl($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasPaymentUrl() => $_has(9);
  @$pb.TagNumber(10)
  void clearPaymentUrl() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get paymentId => $_getSZ(10);
  @$pb.TagNumber(11)
  set paymentId($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasPaymentId() => $_has(10);
  @$pb.TagNumber(11)
  void clearPaymentId() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get provider => $_getSZ(11);
  @$pb.TagNumber(12)
  set provider($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasProvider() => $_has(11);
  @$pb.TagNumber(12)
  void clearProvider() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.String get countryCode => $_getSZ(12);
  @$pb.TagNumber(13)
  set countryCode($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasCountryCode() => $_has(12);
  @$pb.TagNumber(13)
  void clearCountryCode() => $_clearField(13);
}

/// Deposit Message
class Deposit extends $pb.GeneratedMessage {
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
    $core.String? countryCode,
    $core.String? provider,
    $core.String? paymentType,
    $core.bool? isSimulated,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (userId != null) result.userId = userId;
    if (linkedAccountId != null) result.linkedAccountId = linkedAccountId;
    if (destinationAccountId != null)
      result.destinationAccountId = destinationAccountId;
    if (sourceBankName != null) result.sourceBankName = sourceBankName;
    if (sourceAccountNumber != null)
      result.sourceAccountNumber = sourceAccountNumber;
    if (amount != null) result.amount = amount;
    if (fee != null) result.fee = fee;
    if (currency != null) result.currency = currency;
    if (status != null) result.status = status;
    if (reference != null) result.reference = reference;
    if (narration != null) result.narration = narration;
    if (failureCode != null) result.failureCode = failureCode;
    if (failureReason != null) result.failureReason = failureReason;
    if (createdAt != null) result.createdAt = createdAt;
    if (completedAt != null) result.completedAt = completedAt;
    if (countryCode != null) result.countryCode = countryCode;
    if (provider != null) result.provider = provider;
    if (paymentType != null) result.paymentType = paymentType;
    if (isSimulated != null) result.isSimulated = isSimulated;
    return result;
  }

  Deposit._();

  factory Deposit.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Deposit.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Deposit',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'linkedAccountId')
    ..aOS(4, _omitFieldNames ? '' : 'destinationAccountId')
    ..aOS(5, _omitFieldNames ? '' : 'sourceBankName')
    ..aOS(6, _omitFieldNames ? '' : 'sourceAccountNumber')
    ..aInt64(7, _omitFieldNames ? '' : 'amount')
    ..aInt64(8, _omitFieldNames ? '' : 'fee')
    ..aOS(9, _omitFieldNames ? '' : 'currency')
    ..aOS(10, _omitFieldNames ? '' : 'status')
    ..aOS(11, _omitFieldNames ? '' : 'reference')
    ..aOS(12, _omitFieldNames ? '' : 'narration')
    ..aOS(13, _omitFieldNames ? '' : 'failureCode')
    ..aOS(14, _omitFieldNames ? '' : 'failureReason')
    ..aOM<$1.Timestamp>(15, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(16, _omitFieldNames ? '' : 'completedAt',
        subBuilder: $1.Timestamp.create)
    ..aOS(17, _omitFieldNames ? '' : 'countryCode')
    ..aOS(18, _omitFieldNames ? '' : 'provider')
    ..aOS(19, _omitFieldNames ? '' : 'paymentType')
    ..aOB(20, _omitFieldNames ? '' : 'isSimulated')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Deposit clone() => Deposit()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Deposit copyWith(void Function(Deposit) updates) =>
      super.copyWith((message) => updates(message as Deposit)) as Deposit;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Deposit create() => Deposit._();
  @$core.override
  Deposit createEmptyInstance() => create();
  static $pb.PbList<Deposit> createRepeated() => $pb.PbList<Deposit>();
  @$core.pragma('dart2js:noInline')
  static Deposit getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Deposit>(create);
  static Deposit? _defaultInstance;

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
  $core.String get linkedAccountId => $_getSZ(2);
  @$pb.TagNumber(3)
  set linkedAccountId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasLinkedAccountId() => $_has(2);
  @$pb.TagNumber(3)
  void clearLinkedAccountId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get destinationAccountId => $_getSZ(3);
  @$pb.TagNumber(4)
  set destinationAccountId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDestinationAccountId() => $_has(3);
  @$pb.TagNumber(4)
  void clearDestinationAccountId() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get sourceBankName => $_getSZ(4);
  @$pb.TagNumber(5)
  set sourceBankName($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasSourceBankName() => $_has(4);
  @$pb.TagNumber(5)
  void clearSourceBankName() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get sourceAccountNumber => $_getSZ(5);
  @$pb.TagNumber(6)
  set sourceAccountNumber($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasSourceAccountNumber() => $_has(5);
  @$pb.TagNumber(6)
  void clearSourceAccountNumber() => $_clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get amount => $_getI64(6);
  @$pb.TagNumber(7)
  set amount($fixnum.Int64 value) => $_setInt64(6, value);
  @$pb.TagNumber(7)
  $core.bool hasAmount() => $_has(6);
  @$pb.TagNumber(7)
  void clearAmount() => $_clearField(7);

  @$pb.TagNumber(8)
  $fixnum.Int64 get fee => $_getI64(7);
  @$pb.TagNumber(8)
  set fee($fixnum.Int64 value) => $_setInt64(7, value);
  @$pb.TagNumber(8)
  $core.bool hasFee() => $_has(7);
  @$pb.TagNumber(8)
  void clearFee() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get currency => $_getSZ(8);
  @$pb.TagNumber(9)
  set currency($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasCurrency() => $_has(8);
  @$pb.TagNumber(9)
  void clearCurrency() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get status => $_getSZ(9);
  @$pb.TagNumber(10)
  set status($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasStatus() => $_has(9);
  @$pb.TagNumber(10)
  void clearStatus() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get reference => $_getSZ(10);
  @$pb.TagNumber(11)
  set reference($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasReference() => $_has(10);
  @$pb.TagNumber(11)
  void clearReference() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get narration => $_getSZ(11);
  @$pb.TagNumber(12)
  set narration($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasNarration() => $_has(11);
  @$pb.TagNumber(12)
  void clearNarration() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.String get failureCode => $_getSZ(12);
  @$pb.TagNumber(13)
  set failureCode($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasFailureCode() => $_has(12);
  @$pb.TagNumber(13)
  void clearFailureCode() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.String get failureReason => $_getSZ(13);
  @$pb.TagNumber(14)
  set failureReason($core.String value) => $_setString(13, value);
  @$pb.TagNumber(14)
  $core.bool hasFailureReason() => $_has(13);
  @$pb.TagNumber(14)
  void clearFailureReason() => $_clearField(14);

  @$pb.TagNumber(15)
  $1.Timestamp get createdAt => $_getN(14);
  @$pb.TagNumber(15)
  set createdAt($1.Timestamp value) => $_setField(15, value);
  @$pb.TagNumber(15)
  $core.bool hasCreatedAt() => $_has(14);
  @$pb.TagNumber(15)
  void clearCreatedAt() => $_clearField(15);
  @$pb.TagNumber(15)
  $1.Timestamp ensureCreatedAt() => $_ensure(14);

  @$pb.TagNumber(16)
  $1.Timestamp get completedAt => $_getN(15);
  @$pb.TagNumber(16)
  set completedAt($1.Timestamp value) => $_setField(16, value);
  @$pb.TagNumber(16)
  $core.bool hasCompletedAt() => $_has(15);
  @$pb.TagNumber(16)
  void clearCompletedAt() => $_clearField(16);
  @$pb.TagNumber(16)
  $1.Timestamp ensureCompletedAt() => $_ensure(15);

  @$pb.TagNumber(17)
  $core.String get countryCode => $_getSZ(16);
  @$pb.TagNumber(17)
  set countryCode($core.String value) => $_setString(16, value);
  @$pb.TagNumber(17)
  $core.bool hasCountryCode() => $_has(16);
  @$pb.TagNumber(17)
  void clearCountryCode() => $_clearField(17);

  @$pb.TagNumber(18)
  $core.String get provider => $_getSZ(17);
  @$pb.TagNumber(18)
  set provider($core.String value) => $_setString(17, value);
  @$pb.TagNumber(18)
  $core.bool hasProvider() => $_has(17);
  @$pb.TagNumber(18)
  void clearProvider() => $_clearField(18);

  @$pb.TagNumber(19)
  $core.String get paymentType => $_getSZ(18);
  @$pb.TagNumber(19)
  set paymentType($core.String value) => $_setString(18, value);
  @$pb.TagNumber(19)
  $core.bool hasPaymentType() => $_has(18);
  @$pb.TagNumber(19)
  void clearPaymentType() => $_clearField(19);

  @$pb.TagNumber(20)
  $core.bool get isSimulated => $_getBF(19);
  @$pb.TagNumber(20)
  set isSimulated($core.bool value) => $_setBool(19, value);
  @$pb.TagNumber(20)
  $core.bool hasIsSimulated() => $_has(19);
  @$pb.TagNumber(20)
  void clearIsSimulated() => $_clearField(20);
}

/// Get Deposit Status
class GetDepositStatusRequest extends $pb.GeneratedMessage {
  factory GetDepositStatusRequest({
    $core.String? depositId,
    $core.String? userId,
  }) {
    final result = create();
    if (depositId != null) result.depositId = depositId;
    if (userId != null) result.userId = userId;
    return result;
  }

  GetDepositStatusRequest._();

  factory GetDepositStatusRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetDepositStatusRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetDepositStatusRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'depositId')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetDepositStatusRequest clone() =>
      GetDepositStatusRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetDepositStatusRequest copyWith(
          void Function(GetDepositStatusRequest) updates) =>
      super.copyWith((message) => updates(message as GetDepositStatusRequest))
          as GetDepositStatusRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetDepositStatusRequest create() => GetDepositStatusRequest._();
  @$core.override
  GetDepositStatusRequest createEmptyInstance() => create();
  static $pb.PbList<GetDepositStatusRequest> createRepeated() =>
      $pb.PbList<GetDepositStatusRequest>();
  @$core.pragma('dart2js:noInline')
  static GetDepositStatusRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetDepositStatusRequest>(create);
  static GetDepositStatusRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get depositId => $_getSZ(0);
  @$pb.TagNumber(1)
  set depositId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDepositId() => $_has(0);
  @$pb.TagNumber(1)
  void clearDepositId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => $_clearField(2);
}

/// Get User Deposits
class GetUserDepositsRequest extends $pb.GeneratedMessage {
  factory GetUserDepositsRequest({
    $core.String? userId,
    $core.int? limit,
    $core.int? offset,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    if (limit != null) result.limit = limit;
    if (offset != null) result.offset = offset;
    return result;
  }

  GetUserDepositsRequest._();

  factory GetUserDepositsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetUserDepositsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUserDepositsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserDepositsRequest clone() =>
      GetUserDepositsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserDepositsRequest copyWith(
          void Function(GetUserDepositsRequest) updates) =>
      super.copyWith((message) => updates(message as GetUserDepositsRequest))
          as GetUserDepositsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserDepositsRequest create() => GetUserDepositsRequest._();
  @$core.override
  GetUserDepositsRequest createEmptyInstance() => create();
  static $pb.PbList<GetUserDepositsRequest> createRepeated() =>
      $pb.PbList<GetUserDepositsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetUserDepositsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetUserDepositsRequest>(create);
  static GetUserDepositsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

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

class DepositsResponse extends $pb.GeneratedMessage {
  factory DepositsResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
    $core.Iterable<Deposit>? deposits,
    $core.int? total,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (errorCode != null) result.errorCode = errorCode;
    if (errorMessage != null) result.errorMessage = errorMessage;
    if (deposits != null) result.deposits.addAll(deposits);
    if (total != null) result.total = total;
    return result;
  }

  DepositsResponse._();

  factory DepositsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DepositsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DepositsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'errorCode')
    ..aOS(3, _omitFieldNames ? '' : 'errorMessage')
    ..pc<Deposit>(4, _omitFieldNames ? '' : 'deposits', $pb.PbFieldType.PM,
        subBuilder: Deposit.create)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DepositsResponse clone() => DepositsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DepositsResponse copyWith(void Function(DepositsResponse) updates) =>
      super.copyWith((message) => updates(message as DepositsResponse))
          as DepositsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DepositsResponse create() => DepositsResponse._();
  @$core.override
  DepositsResponse createEmptyInstance() => create();
  static $pb.PbList<DepositsResponse> createRepeated() =>
      $pb.PbList<DepositsResponse>();
  @$core.pragma('dart2js:noInline')
  static DepositsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DepositsResponse>(create);
  static DepositsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => $_clearField(3);

  @$pb.TagNumber(4)
  $pb.PbList<Deposit> get deposits => $_getList(3);

  @$pb.TagNumber(5)
  $core.int get total => $_getIZ(4);
  @$pb.TagNumber(5)
  set total($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTotal() => $_has(4);
  @$pb.TagNumber(5)
  void clearTotal() => $_clearField(5);
}

/// Cancel Deposit
class CancelDepositRequest extends $pb.GeneratedMessage {
  factory CancelDepositRequest({
    $core.String? depositId,
    $core.String? userId,
  }) {
    final result = create();
    if (depositId != null) result.depositId = depositId;
    if (userId != null) result.userId = userId;
    return result;
  }

  CancelDepositRequest._();

  factory CancelDepositRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CancelDepositRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CancelDepositRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'depositId')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CancelDepositRequest clone() =>
      CancelDepositRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CancelDepositRequest copyWith(void Function(CancelDepositRequest) updates) =>
      super.copyWith((message) => updates(message as CancelDepositRequest))
          as CancelDepositRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CancelDepositRequest create() => CancelDepositRequest._();
  @$core.override
  CancelDepositRequest createEmptyInstance() => create();
  static $pb.PbList<CancelDepositRequest> createRepeated() =>
      $pb.PbList<CancelDepositRequest>();
  @$core.pragma('dart2js:noInline')
  static CancelDepositRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CancelDepositRequest>(create);
  static CancelDepositRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get depositId => $_getSZ(0);
  @$pb.TagNumber(1)
  set depositId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDepositId() => $_has(0);
  @$pb.TagNumber(1)
  void clearDepositId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => $_clearField(2);
}

class CancelDepositResponse extends $pb.GeneratedMessage {
  factory CancelDepositResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (errorCode != null) result.errorCode = errorCode;
    if (errorMessage != null) result.errorMessage = errorMessage;
    return result;
  }

  CancelDepositResponse._();

  factory CancelDepositResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CancelDepositResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CancelDepositResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'errorCode')
    ..aOS(3, _omitFieldNames ? '' : 'errorMessage')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CancelDepositResponse clone() =>
      CancelDepositResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CancelDepositResponse copyWith(
          void Function(CancelDepositResponse) updates) =>
      super.copyWith((message) => updates(message as CancelDepositResponse))
          as CancelDepositResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CancelDepositResponse create() => CancelDepositResponse._();
  @$core.override
  CancelDepositResponse createEmptyInstance() => create();
  static $pb.PbList<CancelDepositResponse> createRepeated() =>
      $pb.PbList<CancelDepositResponse>();
  @$core.pragma('dart2js:noInline')
  static CancelDepositResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CancelDepositResponse>(create);
  static CancelDepositResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => $_clearField(3);
}

/// Calculate Deposit Fee
class CalculateDepositFeeRequest extends $pb.GeneratedMessage {
  factory CalculateDepositFeeRequest({
    $fixnum.Int64? amount,
  }) {
    final result = create();
    if (amount != null) result.amount = amount;
    return result;
  }

  CalculateDepositFeeRequest._();

  factory CalculateDepositFeeRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CalculateDepositFeeRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CalculateDepositFeeRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'amount')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CalculateDepositFeeRequest clone() =>
      CalculateDepositFeeRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CalculateDepositFeeRequest copyWith(
          void Function(CalculateDepositFeeRequest) updates) =>
      super.copyWith(
              (message) => updates(message as CalculateDepositFeeRequest))
          as CalculateDepositFeeRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CalculateDepositFeeRequest create() => CalculateDepositFeeRequest._();
  @$core.override
  CalculateDepositFeeRequest createEmptyInstance() => create();
  static $pb.PbList<CalculateDepositFeeRequest> createRepeated() =>
      $pb.PbList<CalculateDepositFeeRequest>();
  @$core.pragma('dart2js:noInline')
  static CalculateDepositFeeRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CalculateDepositFeeRequest>(create);
  static CalculateDepositFeeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get amount => $_getI64(0);
  @$pb.TagNumber(1)
  set amount($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAmount() => $_has(0);
  @$pb.TagNumber(1)
  void clearAmount() => $_clearField(1);
}

class CalculateDepositFeeResponse extends $pb.GeneratedMessage {
  factory CalculateDepositFeeResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
    $fixnum.Int64? amount,
    $fixnum.Int64? fee,
    $fixnum.Int64? netAmount,
    $core.String? currency,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (errorCode != null) result.errorCode = errorCode;
    if (errorMessage != null) result.errorMessage = errorMessage;
    if (amount != null) result.amount = amount;
    if (fee != null) result.fee = fee;
    if (netAmount != null) result.netAmount = netAmount;
    if (currency != null) result.currency = currency;
    return result;
  }

  CalculateDepositFeeResponse._();

  factory CalculateDepositFeeResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CalculateDepositFeeResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CalculateDepositFeeResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'errorCode')
    ..aOS(3, _omitFieldNames ? '' : 'errorMessage')
    ..aInt64(4, _omitFieldNames ? '' : 'amount')
    ..aInt64(5, _omitFieldNames ? '' : 'fee')
    ..aInt64(6, _omitFieldNames ? '' : 'netAmount')
    ..aOS(7, _omitFieldNames ? '' : 'currency')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CalculateDepositFeeResponse clone() =>
      CalculateDepositFeeResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CalculateDepositFeeResponse copyWith(
          void Function(CalculateDepositFeeResponse) updates) =>
      super.copyWith(
              (message) => updates(message as CalculateDepositFeeResponse))
          as CalculateDepositFeeResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CalculateDepositFeeResponse create() =>
      CalculateDepositFeeResponse._();
  @$core.override
  CalculateDepositFeeResponse createEmptyInstance() => create();
  static $pb.PbList<CalculateDepositFeeResponse> createRepeated() =>
      $pb.PbList<CalculateDepositFeeResponse>();
  @$core.pragma('dart2js:noInline')
  static CalculateDepositFeeResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CalculateDepositFeeResponse>(create);
  static CalculateDepositFeeResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get amount => $_getI64(3);
  @$pb.TagNumber(4)
  set amount($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearAmount() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get fee => $_getI64(4);
  @$pb.TagNumber(5)
  set fee($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasFee() => $_has(4);
  @$pb.TagNumber(5)
  void clearFee() => $_clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get netAmount => $_getI64(5);
  @$pb.TagNumber(6)
  set netAmount($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasNetAmount() => $_has(5);
  @$pb.TagNumber(6)
  void clearNetAmount() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get currency => $_getSZ(6);
  @$pb.TagNumber(7)
  set currency($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasCurrency() => $_has(6);
  @$pb.TagNumber(7)
  void clearCurrency() => $_clearField(7);
}

/// Simulate Test Deposit (sandbox only)
class SimulateTestDepositRequest extends $pb.GeneratedMessage {
  factory SimulateTestDepositRequest({
    $core.String? destinationAccountId,
    $fixnum.Int64? amount,
    $core.String? currency,
    $core.String? countryCode,
  }) {
    final result = create();
    if (destinationAccountId != null)
      result.destinationAccountId = destinationAccountId;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    if (countryCode != null) result.countryCode = countryCode;
    return result;
  }

  SimulateTestDepositRequest._();

  factory SimulateTestDepositRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SimulateTestDepositRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SimulateTestDepositRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'destinationAccountId')
    ..aInt64(2, _omitFieldNames ? '' : 'amount')
    ..aOS(3, _omitFieldNames ? '' : 'currency')
    ..aOS(4, _omitFieldNames ? '' : 'countryCode')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SimulateTestDepositRequest clone() =>
      SimulateTestDepositRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SimulateTestDepositRequest copyWith(
          void Function(SimulateTestDepositRequest) updates) =>
      super.copyWith(
              (message) => updates(message as SimulateTestDepositRequest))
          as SimulateTestDepositRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SimulateTestDepositRequest create() => SimulateTestDepositRequest._();
  @$core.override
  SimulateTestDepositRequest createEmptyInstance() => create();
  static $pb.PbList<SimulateTestDepositRequest> createRepeated() =>
      $pb.PbList<SimulateTestDepositRequest>();
  @$core.pragma('dart2js:noInline')
  static SimulateTestDepositRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SimulateTestDepositRequest>(create);
  static SimulateTestDepositRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get destinationAccountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set destinationAccountId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDestinationAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearDestinationAccountId() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get amount => $_getI64(1);
  @$pb.TagNumber(2)
  set amount($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get currency => $_getSZ(2);
  @$pb.TagNumber(3)
  set currency($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCurrency() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrency() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get countryCode => $_getSZ(3);
  @$pb.TagNumber(4)
  set countryCode($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCountryCode() => $_has(3);
  @$pb.TagNumber(4)
  void clearCountryCode() => $_clearField(4);
}

/// Get Deposit Methods for a Country
class GetDepositMethodsRequest extends $pb.GeneratedMessage {
  factory GetDepositMethodsRequest({
    $core.String? countryCode,
    $core.String? currency,
  }) {
    final result = create();
    if (countryCode != null) result.countryCode = countryCode;
    if (currency != null) result.currency = currency;
    return result;
  }

  GetDepositMethodsRequest._();

  factory GetDepositMethodsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetDepositMethodsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetDepositMethodsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'countryCode')
    ..aOS(2, _omitFieldNames ? '' : 'currency')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetDepositMethodsRequest clone() =>
      GetDepositMethodsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetDepositMethodsRequest copyWith(
          void Function(GetDepositMethodsRequest) updates) =>
      super.copyWith((message) => updates(message as GetDepositMethodsRequest))
          as GetDepositMethodsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetDepositMethodsRequest create() => GetDepositMethodsRequest._();
  @$core.override
  GetDepositMethodsRequest createEmptyInstance() => create();
  static $pb.PbList<GetDepositMethodsRequest> createRepeated() =>
      $pb.PbList<GetDepositMethodsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetDepositMethodsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetDepositMethodsRequest>(create);
  static GetDepositMethodsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get countryCode => $_getSZ(0);
  @$pb.TagNumber(1)
  set countryCode($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCountryCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearCountryCode() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get currency => $_getSZ(1);
  @$pb.TagNumber(2)
  set currency($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCurrency() => $_has(1);
  @$pb.TagNumber(2)
  void clearCurrency() => $_clearField(2);
}

class GetDepositMethodsResponse extends $pb.GeneratedMessage {
  factory GetDepositMethodsResponse({
    $core.Iterable<DepositMethodInfo>? methods,
    $core.String? countryCode,
    $core.String? currency,
    $core.String? provider,
  }) {
    final result = create();
    if (methods != null) result.methods.addAll(methods);
    if (countryCode != null) result.countryCode = countryCode;
    if (currency != null) result.currency = currency;
    if (provider != null) result.provider = provider;
    return result;
  }

  GetDepositMethodsResponse._();

  factory GetDepositMethodsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetDepositMethodsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetDepositMethodsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..pc<DepositMethodInfo>(
        1, _omitFieldNames ? '' : 'methods', $pb.PbFieldType.PM,
        subBuilder: DepositMethodInfo.create)
    ..aOS(2, _omitFieldNames ? '' : 'countryCode')
    ..aOS(3, _omitFieldNames ? '' : 'currency')
    ..aOS(4, _omitFieldNames ? '' : 'provider')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetDepositMethodsResponse clone() =>
      GetDepositMethodsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetDepositMethodsResponse copyWith(
          void Function(GetDepositMethodsResponse) updates) =>
      super.copyWith((message) => updates(message as GetDepositMethodsResponse))
          as GetDepositMethodsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetDepositMethodsResponse create() => GetDepositMethodsResponse._();
  @$core.override
  GetDepositMethodsResponse createEmptyInstance() => create();
  static $pb.PbList<GetDepositMethodsResponse> createRepeated() =>
      $pb.PbList<GetDepositMethodsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetDepositMethodsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetDepositMethodsResponse>(create);
  static GetDepositMethodsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<DepositMethodInfo> get methods => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get countryCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set countryCode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCountryCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearCountryCode() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get currency => $_getSZ(2);
  @$pb.TagNumber(3)
  set currency($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCurrency() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrency() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get provider => $_getSZ(3);
  @$pb.TagNumber(4)
  set provider($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasProvider() => $_has(3);
  @$pb.TagNumber(4)
  void clearProvider() => $_clearField(4);
}

class DepositMethodInfo extends $pb.GeneratedMessage {
  factory DepositMethodInfo({
    $core.String? id,
    $core.String? name,
    $core.String? description,
    $core.String? icon,
    $core.String? feeDescription,
    $core.String? processingTime,
    $core.bool? available,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (description != null) result.description = description;
    if (icon != null) result.icon = icon;
    if (feeDescription != null) result.feeDescription = feeDescription;
    if (processingTime != null) result.processingTime = processingTime;
    if (available != null) result.available = available;
    return result;
  }

  DepositMethodInfo._();

  factory DepositMethodInfo.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DepositMethodInfo.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DepositMethodInfo',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..aOS(4, _omitFieldNames ? '' : 'icon')
    ..aOS(5, _omitFieldNames ? '' : 'feeDescription')
    ..aOS(6, _omitFieldNames ? '' : 'processingTime')
    ..aOB(7, _omitFieldNames ? '' : 'available')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DepositMethodInfo clone() => DepositMethodInfo()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DepositMethodInfo copyWith(void Function(DepositMethodInfo) updates) =>
      super.copyWith((message) => updates(message as DepositMethodInfo))
          as DepositMethodInfo;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DepositMethodInfo create() => DepositMethodInfo._();
  @$core.override
  DepositMethodInfo createEmptyInstance() => create();
  static $pb.PbList<DepositMethodInfo> createRepeated() =>
      $pb.PbList<DepositMethodInfo>();
  @$core.pragma('dart2js:noInline')
  static DepositMethodInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DepositMethodInfo>(create);
  static DepositMethodInfo? _defaultInstance;

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
  $core.String get icon => $_getSZ(3);
  @$pb.TagNumber(4)
  set icon($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasIcon() => $_has(3);
  @$pb.TagNumber(4)
  void clearIcon() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get feeDescription => $_getSZ(4);
  @$pb.TagNumber(5)
  set feeDescription($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasFeeDescription() => $_has(4);
  @$pb.TagNumber(5)
  void clearFeeDescription() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get processingTime => $_getSZ(5);
  @$pb.TagNumber(6)
  set processingTime($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasProcessingTime() => $_has(5);
  @$pb.TagNumber(6)
  void clearProcessingTime() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.bool get available => $_getBF(6);
  @$pb.TagNumber(7)
  set available($core.bool value) => $_setBool(6, value);
  @$pb.TagNumber(7)
  $core.bool hasAvailable() => $_has(6);
  @$pb.TagNumber(7)
  void clearAvailable() => $_clearField(7);
}

/// Initiate Withdrawal
class InitiateWithdrawalRequest extends $pb.GeneratedMessage {
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
    final result = create();
    if (userId != null) result.userId = userId;
    if (sourceAccountId != null) result.sourceAccountId = sourceAccountId;
    if (bankCode != null) result.bankCode = bankCode;
    if (accountNumber != null) result.accountNumber = accountNumber;
    if (accountName != null) result.accountName = accountName;
    if (amount != null) result.amount = amount;
    if (narration != null) result.narration = narration;
    if (idempotencyKey != null) result.idempotencyKey = idempotencyKey;
    return result;
  }

  InitiateWithdrawalRequest._();

  factory InitiateWithdrawalRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InitiateWithdrawalRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InitiateWithdrawalRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'sourceAccountId')
    ..aOS(3, _omitFieldNames ? '' : 'bankCode')
    ..aOS(4, _omitFieldNames ? '' : 'accountNumber')
    ..aOS(5, _omitFieldNames ? '' : 'accountName')
    ..aInt64(6, _omitFieldNames ? '' : 'amount')
    ..aOS(7, _omitFieldNames ? '' : 'narration')
    ..aOS(8, _omitFieldNames ? '' : 'idempotencyKey')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InitiateWithdrawalRequest clone() =>
      InitiateWithdrawalRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InitiateWithdrawalRequest copyWith(
          void Function(InitiateWithdrawalRequest) updates) =>
      super.copyWith((message) => updates(message as InitiateWithdrawalRequest))
          as InitiateWithdrawalRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InitiateWithdrawalRequest create() => InitiateWithdrawalRequest._();
  @$core.override
  InitiateWithdrawalRequest createEmptyInstance() => create();
  static $pb.PbList<InitiateWithdrawalRequest> createRepeated() =>
      $pb.PbList<InitiateWithdrawalRequest>();
  @$core.pragma('dart2js:noInline')
  static InitiateWithdrawalRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InitiateWithdrawalRequest>(create);
  static InitiateWithdrawalRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get sourceAccountId => $_getSZ(1);
  @$pb.TagNumber(2)
  set sourceAccountId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSourceAccountId() => $_has(1);
  @$pb.TagNumber(2)
  void clearSourceAccountId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get bankCode => $_getSZ(2);
  @$pb.TagNumber(3)
  set bankCode($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasBankCode() => $_has(2);
  @$pb.TagNumber(3)
  void clearBankCode() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get accountNumber => $_getSZ(3);
  @$pb.TagNumber(4)
  set accountNumber($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAccountNumber() => $_has(3);
  @$pb.TagNumber(4)
  void clearAccountNumber() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get accountName => $_getSZ(4);
  @$pb.TagNumber(5)
  set accountName($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasAccountName() => $_has(4);
  @$pb.TagNumber(5)
  void clearAccountName() => $_clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get amount => $_getI64(5);
  @$pb.TagNumber(6)
  set amount($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasAmount() => $_has(5);
  @$pb.TagNumber(6)
  void clearAmount() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get narration => $_getSZ(6);
  @$pb.TagNumber(7)
  set narration($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasNarration() => $_has(6);
  @$pb.TagNumber(7)
  void clearNarration() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get idempotencyKey => $_getSZ(7);
  @$pb.TagNumber(8)
  set idempotencyKey($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasIdempotencyKey() => $_has(7);
  @$pb.TagNumber(8)
  void clearIdempotencyKey() => $_clearField(8);
}

class WithdrawalResponse extends $pb.GeneratedMessage {
  factory WithdrawalResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
    Withdrawal? withdrawal,
    $core.String? message,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (errorCode != null) result.errorCode = errorCode;
    if (errorMessage != null) result.errorMessage = errorMessage;
    if (withdrawal != null) result.withdrawal = withdrawal;
    if (message != null) result.message = message;
    return result;
  }

  WithdrawalResponse._();

  factory WithdrawalResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory WithdrawalResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'WithdrawalResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'errorCode')
    ..aOS(3, _omitFieldNames ? '' : 'errorMessage')
    ..aOM<Withdrawal>(4, _omitFieldNames ? '' : 'withdrawal',
        subBuilder: Withdrawal.create)
    ..aOS(5, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WithdrawalResponse clone() => WithdrawalResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WithdrawalResponse copyWith(void Function(WithdrawalResponse) updates) =>
      super.copyWith((message) => updates(message as WithdrawalResponse))
          as WithdrawalResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WithdrawalResponse create() => WithdrawalResponse._();
  @$core.override
  WithdrawalResponse createEmptyInstance() => create();
  static $pb.PbList<WithdrawalResponse> createRepeated() =>
      $pb.PbList<WithdrawalResponse>();
  @$core.pragma('dart2js:noInline')
  static WithdrawalResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<WithdrawalResponse>(create);
  static WithdrawalResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => $_clearField(3);

  @$pb.TagNumber(4)
  Withdrawal get withdrawal => $_getN(3);
  @$pb.TagNumber(4)
  set withdrawal(Withdrawal value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasWithdrawal() => $_has(3);
  @$pb.TagNumber(4)
  void clearWithdrawal() => $_clearField(4);
  @$pb.TagNumber(4)
  Withdrawal ensureWithdrawal() => $_ensure(3);

  @$pb.TagNumber(5)
  $core.String get message => $_getSZ(4);
  @$pb.TagNumber(5)
  set message($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasMessage() => $_has(4);
  @$pb.TagNumber(5)
  void clearMessage() => $_clearField(5);
}

class Withdrawal extends $pb.GeneratedMessage {
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
    final result = create();
    if (id != null) result.id = id;
    if (userId != null) result.userId = userId;
    if (sourceAccountId != null) result.sourceAccountId = sourceAccountId;
    if (destinationBankCode != null)
      result.destinationBankCode = destinationBankCode;
    if (destinationBankName != null)
      result.destinationBankName = destinationBankName;
    if (destinationAccount != null)
      result.destinationAccount = destinationAccount;
    if (destinationName != null) result.destinationName = destinationName;
    if (amount != null) result.amount = amount;
    if (fee != null) result.fee = fee;
    if (totalAmount != null) result.totalAmount = totalAmount;
    if (currency != null) result.currency = currency;
    if (status != null) result.status = status;
    if (reference != null) result.reference = reference;
    if (narration != null) result.narration = narration;
    if (failureCode != null) result.failureCode = failureCode;
    if (failureReason != null) result.failureReason = failureReason;
    if (createdAt != null) result.createdAt = createdAt;
    if (completedAt != null) result.completedAt = completedAt;
    return result;
  }

  Withdrawal._();

  factory Withdrawal.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Withdrawal.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Withdrawal',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'sourceAccountId')
    ..aOS(4, _omitFieldNames ? '' : 'destinationBankCode')
    ..aOS(5, _omitFieldNames ? '' : 'destinationBankName')
    ..aOS(6, _omitFieldNames ? '' : 'destinationAccount')
    ..aOS(7, _omitFieldNames ? '' : 'destinationName')
    ..aInt64(8, _omitFieldNames ? '' : 'amount')
    ..aInt64(9, _omitFieldNames ? '' : 'fee')
    ..aInt64(10, _omitFieldNames ? '' : 'totalAmount')
    ..aOS(11, _omitFieldNames ? '' : 'currency')
    ..aOS(12, _omitFieldNames ? '' : 'status')
    ..aOS(13, _omitFieldNames ? '' : 'reference')
    ..aOS(14, _omitFieldNames ? '' : 'narration')
    ..aOS(15, _omitFieldNames ? '' : 'failureCode')
    ..aOS(16, _omitFieldNames ? '' : 'failureReason')
    ..aOM<$1.Timestamp>(17, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(18, _omitFieldNames ? '' : 'completedAt',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Withdrawal clone() => Withdrawal()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Withdrawal copyWith(void Function(Withdrawal) updates) =>
      super.copyWith((message) => updates(message as Withdrawal)) as Withdrawal;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Withdrawal create() => Withdrawal._();
  @$core.override
  Withdrawal createEmptyInstance() => create();
  static $pb.PbList<Withdrawal> createRepeated() => $pb.PbList<Withdrawal>();
  @$core.pragma('dart2js:noInline')
  static Withdrawal getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Withdrawal>(create);
  static Withdrawal? _defaultInstance;

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
  $core.String get sourceAccountId => $_getSZ(2);
  @$pb.TagNumber(3)
  set sourceAccountId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSourceAccountId() => $_has(2);
  @$pb.TagNumber(3)
  void clearSourceAccountId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get destinationBankCode => $_getSZ(3);
  @$pb.TagNumber(4)
  set destinationBankCode($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDestinationBankCode() => $_has(3);
  @$pb.TagNumber(4)
  void clearDestinationBankCode() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get destinationBankName => $_getSZ(4);
  @$pb.TagNumber(5)
  set destinationBankName($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasDestinationBankName() => $_has(4);
  @$pb.TagNumber(5)
  void clearDestinationBankName() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get destinationAccount => $_getSZ(5);
  @$pb.TagNumber(6)
  set destinationAccount($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasDestinationAccount() => $_has(5);
  @$pb.TagNumber(6)
  void clearDestinationAccount() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get destinationName => $_getSZ(6);
  @$pb.TagNumber(7)
  set destinationName($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasDestinationName() => $_has(6);
  @$pb.TagNumber(7)
  void clearDestinationName() => $_clearField(7);

  @$pb.TagNumber(8)
  $fixnum.Int64 get amount => $_getI64(7);
  @$pb.TagNumber(8)
  set amount($fixnum.Int64 value) => $_setInt64(7, value);
  @$pb.TagNumber(8)
  $core.bool hasAmount() => $_has(7);
  @$pb.TagNumber(8)
  void clearAmount() => $_clearField(8);

  @$pb.TagNumber(9)
  $fixnum.Int64 get fee => $_getI64(8);
  @$pb.TagNumber(9)
  set fee($fixnum.Int64 value) => $_setInt64(8, value);
  @$pb.TagNumber(9)
  $core.bool hasFee() => $_has(8);
  @$pb.TagNumber(9)
  void clearFee() => $_clearField(9);

  @$pb.TagNumber(10)
  $fixnum.Int64 get totalAmount => $_getI64(9);
  @$pb.TagNumber(10)
  set totalAmount($fixnum.Int64 value) => $_setInt64(9, value);
  @$pb.TagNumber(10)
  $core.bool hasTotalAmount() => $_has(9);
  @$pb.TagNumber(10)
  void clearTotalAmount() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get currency => $_getSZ(10);
  @$pb.TagNumber(11)
  set currency($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasCurrency() => $_has(10);
  @$pb.TagNumber(11)
  void clearCurrency() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get status => $_getSZ(11);
  @$pb.TagNumber(12)
  set status($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasStatus() => $_has(11);
  @$pb.TagNumber(12)
  void clearStatus() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.String get reference => $_getSZ(12);
  @$pb.TagNumber(13)
  set reference($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasReference() => $_has(12);
  @$pb.TagNumber(13)
  void clearReference() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.String get narration => $_getSZ(13);
  @$pb.TagNumber(14)
  set narration($core.String value) => $_setString(13, value);
  @$pb.TagNumber(14)
  $core.bool hasNarration() => $_has(13);
  @$pb.TagNumber(14)
  void clearNarration() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.String get failureCode => $_getSZ(14);
  @$pb.TagNumber(15)
  set failureCode($core.String value) => $_setString(14, value);
  @$pb.TagNumber(15)
  $core.bool hasFailureCode() => $_has(14);
  @$pb.TagNumber(15)
  void clearFailureCode() => $_clearField(15);

  @$pb.TagNumber(16)
  $core.String get failureReason => $_getSZ(15);
  @$pb.TagNumber(16)
  set failureReason($core.String value) => $_setString(15, value);
  @$pb.TagNumber(16)
  $core.bool hasFailureReason() => $_has(15);
  @$pb.TagNumber(16)
  void clearFailureReason() => $_clearField(16);

  @$pb.TagNumber(17)
  $1.Timestamp get createdAt => $_getN(16);
  @$pb.TagNumber(17)
  set createdAt($1.Timestamp value) => $_setField(17, value);
  @$pb.TagNumber(17)
  $core.bool hasCreatedAt() => $_has(16);
  @$pb.TagNumber(17)
  void clearCreatedAt() => $_clearField(17);
  @$pb.TagNumber(17)
  $1.Timestamp ensureCreatedAt() => $_ensure(16);

  @$pb.TagNumber(18)
  $1.Timestamp get completedAt => $_getN(17);
  @$pb.TagNumber(18)
  set completedAt($1.Timestamp value) => $_setField(18, value);
  @$pb.TagNumber(18)
  $core.bool hasCompletedAt() => $_has(17);
  @$pb.TagNumber(18)
  void clearCompletedAt() => $_clearField(18);
  @$pb.TagNumber(18)
  $1.Timestamp ensureCompletedAt() => $_ensure(17);
}

/// Get Withdrawal Status
class GetWithdrawalStatusRequest extends $pb.GeneratedMessage {
  factory GetWithdrawalStatusRequest({
    $core.String? withdrawalId,
    $core.String? userId,
  }) {
    final result = create();
    if (withdrawalId != null) result.withdrawalId = withdrawalId;
    if (userId != null) result.userId = userId;
    return result;
  }

  GetWithdrawalStatusRequest._();

  factory GetWithdrawalStatusRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetWithdrawalStatusRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetWithdrawalStatusRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'withdrawalId')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetWithdrawalStatusRequest clone() =>
      GetWithdrawalStatusRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetWithdrawalStatusRequest copyWith(
          void Function(GetWithdrawalStatusRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetWithdrawalStatusRequest))
          as GetWithdrawalStatusRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetWithdrawalStatusRequest create() => GetWithdrawalStatusRequest._();
  @$core.override
  GetWithdrawalStatusRequest createEmptyInstance() => create();
  static $pb.PbList<GetWithdrawalStatusRequest> createRepeated() =>
      $pb.PbList<GetWithdrawalStatusRequest>();
  @$core.pragma('dart2js:noInline')
  static GetWithdrawalStatusRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetWithdrawalStatusRequest>(create);
  static GetWithdrawalStatusRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get withdrawalId => $_getSZ(0);
  @$pb.TagNumber(1)
  set withdrawalId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasWithdrawalId() => $_has(0);
  @$pb.TagNumber(1)
  void clearWithdrawalId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => $_clearField(2);
}

/// Get User Withdrawals
class GetUserWithdrawalsRequest extends $pb.GeneratedMessage {
  factory GetUserWithdrawalsRequest({
    $core.String? userId,
    $core.int? limit,
    $core.int? offset,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    if (limit != null) result.limit = limit;
    if (offset != null) result.offset = offset;
    return result;
  }

  GetUserWithdrawalsRequest._();

  factory GetUserWithdrawalsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetUserWithdrawalsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUserWithdrawalsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserWithdrawalsRequest clone() =>
      GetUserWithdrawalsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserWithdrawalsRequest copyWith(
          void Function(GetUserWithdrawalsRequest) updates) =>
      super.copyWith((message) => updates(message as GetUserWithdrawalsRequest))
          as GetUserWithdrawalsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserWithdrawalsRequest create() => GetUserWithdrawalsRequest._();
  @$core.override
  GetUserWithdrawalsRequest createEmptyInstance() => create();
  static $pb.PbList<GetUserWithdrawalsRequest> createRepeated() =>
      $pb.PbList<GetUserWithdrawalsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetUserWithdrawalsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetUserWithdrawalsRequest>(create);
  static GetUserWithdrawalsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

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

class WithdrawalsResponse extends $pb.GeneratedMessage {
  factory WithdrawalsResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
    $core.Iterable<Withdrawal>? withdrawals,
    $core.int? total,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (errorCode != null) result.errorCode = errorCode;
    if (errorMessage != null) result.errorMessage = errorMessage;
    if (withdrawals != null) result.withdrawals.addAll(withdrawals);
    if (total != null) result.total = total;
    return result;
  }

  WithdrawalsResponse._();

  factory WithdrawalsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory WithdrawalsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'WithdrawalsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'errorCode')
    ..aOS(3, _omitFieldNames ? '' : 'errorMessage')
    ..pc<Withdrawal>(
        4, _omitFieldNames ? '' : 'withdrawals', $pb.PbFieldType.PM,
        subBuilder: Withdrawal.create)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WithdrawalsResponse clone() => WithdrawalsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WithdrawalsResponse copyWith(void Function(WithdrawalsResponse) updates) =>
      super.copyWith((message) => updates(message as WithdrawalsResponse))
          as WithdrawalsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WithdrawalsResponse create() => WithdrawalsResponse._();
  @$core.override
  WithdrawalsResponse createEmptyInstance() => create();
  static $pb.PbList<WithdrawalsResponse> createRepeated() =>
      $pb.PbList<WithdrawalsResponse>();
  @$core.pragma('dart2js:noInline')
  static WithdrawalsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<WithdrawalsResponse>(create);
  static WithdrawalsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => $_clearField(3);

  @$pb.TagNumber(4)
  $pb.PbList<Withdrawal> get withdrawals => $_getList(3);

  @$pb.TagNumber(5)
  $core.int get total => $_getIZ(4);
  @$pb.TagNumber(5)
  set total($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTotal() => $_has(4);
  @$pb.TagNumber(5)
  void clearTotal() => $_clearField(5);
}

/// Calculate Withdrawal Fee
class CalculateWithdrawalFeeRequest extends $pb.GeneratedMessage {
  factory CalculateWithdrawalFeeRequest({
    $fixnum.Int64? amount,
  }) {
    final result = create();
    if (amount != null) result.amount = amount;
    return result;
  }

  CalculateWithdrawalFeeRequest._();

  factory CalculateWithdrawalFeeRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CalculateWithdrawalFeeRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CalculateWithdrawalFeeRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'amount')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CalculateWithdrawalFeeRequest clone() =>
      CalculateWithdrawalFeeRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CalculateWithdrawalFeeRequest copyWith(
          void Function(CalculateWithdrawalFeeRequest) updates) =>
      super.copyWith(
              (message) => updates(message as CalculateWithdrawalFeeRequest))
          as CalculateWithdrawalFeeRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CalculateWithdrawalFeeRequest create() =>
      CalculateWithdrawalFeeRequest._();
  @$core.override
  CalculateWithdrawalFeeRequest createEmptyInstance() => create();
  static $pb.PbList<CalculateWithdrawalFeeRequest> createRepeated() =>
      $pb.PbList<CalculateWithdrawalFeeRequest>();
  @$core.pragma('dart2js:noInline')
  static CalculateWithdrawalFeeRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CalculateWithdrawalFeeRequest>(create);
  static CalculateWithdrawalFeeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get amount => $_getI64(0);
  @$pb.TagNumber(1)
  set amount($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAmount() => $_has(0);
  @$pb.TagNumber(1)
  void clearAmount() => $_clearField(1);
}

class CalculateWithdrawalFeeResponse extends $pb.GeneratedMessage {
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
    final result = create();
    if (success != null) result.success = success;
    if (errorCode != null) result.errorCode = errorCode;
    if (errorMessage != null) result.errorMessage = errorMessage;
    if (amount != null) result.amount = amount;
    if (fee != null) result.fee = fee;
    if (totalDebit != null) result.totalDebit = totalDebit;
    if (minAmount != null) result.minAmount = minAmount;
    if (maxAmount != null) result.maxAmount = maxAmount;
    if (currency != null) result.currency = currency;
    return result;
  }

  CalculateWithdrawalFeeResponse._();

  factory CalculateWithdrawalFeeResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CalculateWithdrawalFeeResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CalculateWithdrawalFeeResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'errorCode')
    ..aOS(3, _omitFieldNames ? '' : 'errorMessage')
    ..aInt64(4, _omitFieldNames ? '' : 'amount')
    ..aInt64(5, _omitFieldNames ? '' : 'fee')
    ..aInt64(6, _omitFieldNames ? '' : 'totalDebit')
    ..aInt64(7, _omitFieldNames ? '' : 'minAmount')
    ..aInt64(8, _omitFieldNames ? '' : 'maxAmount')
    ..aOS(9, _omitFieldNames ? '' : 'currency')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CalculateWithdrawalFeeResponse clone() =>
      CalculateWithdrawalFeeResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CalculateWithdrawalFeeResponse copyWith(
          void Function(CalculateWithdrawalFeeResponse) updates) =>
      super.copyWith(
              (message) => updates(message as CalculateWithdrawalFeeResponse))
          as CalculateWithdrawalFeeResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CalculateWithdrawalFeeResponse create() =>
      CalculateWithdrawalFeeResponse._();
  @$core.override
  CalculateWithdrawalFeeResponse createEmptyInstance() => create();
  static $pb.PbList<CalculateWithdrawalFeeResponse> createRepeated() =>
      $pb.PbList<CalculateWithdrawalFeeResponse>();
  @$core.pragma('dart2js:noInline')
  static CalculateWithdrawalFeeResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CalculateWithdrawalFeeResponse>(create);
  static CalculateWithdrawalFeeResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get amount => $_getI64(3);
  @$pb.TagNumber(4)
  set amount($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearAmount() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get fee => $_getI64(4);
  @$pb.TagNumber(5)
  set fee($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasFee() => $_has(4);
  @$pb.TagNumber(5)
  void clearFee() => $_clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get totalDebit => $_getI64(5);
  @$pb.TagNumber(6)
  set totalDebit($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasTotalDebit() => $_has(5);
  @$pb.TagNumber(6)
  void clearTotalDebit() => $_clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get minAmount => $_getI64(6);
  @$pb.TagNumber(7)
  set minAmount($fixnum.Int64 value) => $_setInt64(6, value);
  @$pb.TagNumber(7)
  $core.bool hasMinAmount() => $_has(6);
  @$pb.TagNumber(7)
  void clearMinAmount() => $_clearField(7);

  @$pb.TagNumber(8)
  $fixnum.Int64 get maxAmount => $_getI64(7);
  @$pb.TagNumber(8)
  set maxAmount($fixnum.Int64 value) => $_setInt64(7, value);
  @$pb.TagNumber(8)
  $core.bool hasMaxAmount() => $_has(7);
  @$pb.TagNumber(8)
  void clearMaxAmount() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get currency => $_getSZ(8);
  @$pb.TagNumber(9)
  set currency($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasCurrency() => $_has(8);
  @$pb.TagNumber(9)
  void clearCurrency() => $_clearField(9);
}

/// Resolve Account Name
class ResolveAccountNameRequest extends $pb.GeneratedMessage {
  factory ResolveAccountNameRequest({
    $core.String? accountNumber,
    $core.String? bankCode,
  }) {
    final result = create();
    if (accountNumber != null) result.accountNumber = accountNumber;
    if (bankCode != null) result.bankCode = bankCode;
    return result;
  }

  ResolveAccountNameRequest._();

  factory ResolveAccountNameRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ResolveAccountNameRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ResolveAccountNameRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountNumber')
    ..aOS(2, _omitFieldNames ? '' : 'bankCode')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ResolveAccountNameRequest clone() =>
      ResolveAccountNameRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ResolveAccountNameRequest copyWith(
          void Function(ResolveAccountNameRequest) updates) =>
      super.copyWith((message) => updates(message as ResolveAccountNameRequest))
          as ResolveAccountNameRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ResolveAccountNameRequest create() => ResolveAccountNameRequest._();
  @$core.override
  ResolveAccountNameRequest createEmptyInstance() => create();
  static $pb.PbList<ResolveAccountNameRequest> createRepeated() =>
      $pb.PbList<ResolveAccountNameRequest>();
  @$core.pragma('dart2js:noInline')
  static ResolveAccountNameRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ResolveAccountNameRequest>(create);
  static ResolveAccountNameRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountNumber => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountNumber($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAccountNumber() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountNumber() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get bankCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set bankCode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasBankCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearBankCode() => $_clearField(2);
}

class ResolveAccountNameResponse extends $pb.GeneratedMessage {
  factory ResolveAccountNameResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
    $core.String? accountNumber,
    $core.String? accountName,
    $core.String? bankCode,
    $core.String? bankName,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (errorCode != null) result.errorCode = errorCode;
    if (errorMessage != null) result.errorMessage = errorMessage;
    if (accountNumber != null) result.accountNumber = accountNumber;
    if (accountName != null) result.accountName = accountName;
    if (bankCode != null) result.bankCode = bankCode;
    if (bankName != null) result.bankName = bankName;
    return result;
  }

  ResolveAccountNameResponse._();

  factory ResolveAccountNameResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ResolveAccountNameResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ResolveAccountNameResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'errorCode')
    ..aOS(3, _omitFieldNames ? '' : 'errorMessage')
    ..aOS(4, _omitFieldNames ? '' : 'accountNumber')
    ..aOS(5, _omitFieldNames ? '' : 'accountName')
    ..aOS(6, _omitFieldNames ? '' : 'bankCode')
    ..aOS(7, _omitFieldNames ? '' : 'bankName')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ResolveAccountNameResponse clone() =>
      ResolveAccountNameResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ResolveAccountNameResponse copyWith(
          void Function(ResolveAccountNameResponse) updates) =>
      super.copyWith(
              (message) => updates(message as ResolveAccountNameResponse))
          as ResolveAccountNameResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ResolveAccountNameResponse create() => ResolveAccountNameResponse._();
  @$core.override
  ResolveAccountNameResponse createEmptyInstance() => create();
  static $pb.PbList<ResolveAccountNameResponse> createRepeated() =>
      $pb.PbList<ResolveAccountNameResponse>();
  @$core.pragma('dart2js:noInline')
  static ResolveAccountNameResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ResolveAccountNameResponse>(create);
  static ResolveAccountNameResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get accountNumber => $_getSZ(3);
  @$pb.TagNumber(4)
  set accountNumber($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAccountNumber() => $_has(3);
  @$pb.TagNumber(4)
  void clearAccountNumber() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get accountName => $_getSZ(4);
  @$pb.TagNumber(5)
  set accountName($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasAccountName() => $_has(4);
  @$pb.TagNumber(5)
  void clearAccountName() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get bankCode => $_getSZ(5);
  @$pb.TagNumber(6)
  set bankCode($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasBankCode() => $_has(5);
  @$pb.TagNumber(6)
  void clearBankCode() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get bankName => $_getSZ(6);
  @$pb.TagNumber(7)
  set bankName($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasBankName() => $_has(6);
  @$pb.TagNumber(7)
  void clearBankName() => $_clearField(7);
}

/// Create Mandate Request
class CreateMandateRequest extends $pb.GeneratedMessage {
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
    final result = create();
    if (userId != null) result.userId = userId;
    if (linkedAccountId != null) result.linkedAccountId = linkedAccountId;
    if (mandateType != null) result.mandateType = mandateType;
    if (amountLimit != null) result.amountLimit = amountLimit;
    if (debitLimit != null) result.debitLimit = debitLimit;
    if (startDate != null) result.startDate = startDate;
    if (endDate != null) result.endDate = endDate;
    if (description != null) result.description = description;
    return result;
  }

  CreateMandateRequest._();

  factory CreateMandateRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateMandateRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateMandateRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'linkedAccountId')
    ..aOS(3, _omitFieldNames ? '' : 'mandateType')
    ..aInt64(4, _omitFieldNames ? '' : 'amountLimit')
    ..a<$core.int>(5, _omitFieldNames ? '' : 'debitLimit', $pb.PbFieldType.O3)
    ..aOS(6, _omitFieldNames ? '' : 'startDate')
    ..aOS(7, _omitFieldNames ? '' : 'endDate')
    ..aOS(8, _omitFieldNames ? '' : 'description')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateMandateRequest clone() =>
      CreateMandateRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateMandateRequest copyWith(void Function(CreateMandateRequest) updates) =>
      super.copyWith((message) => updates(message as CreateMandateRequest))
          as CreateMandateRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateMandateRequest create() => CreateMandateRequest._();
  @$core.override
  CreateMandateRequest createEmptyInstance() => create();
  static $pb.PbList<CreateMandateRequest> createRepeated() =>
      $pb.PbList<CreateMandateRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateMandateRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateMandateRequest>(create);
  static CreateMandateRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get linkedAccountId => $_getSZ(1);
  @$pb.TagNumber(2)
  set linkedAccountId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLinkedAccountId() => $_has(1);
  @$pb.TagNumber(2)
  void clearLinkedAccountId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get mandateType => $_getSZ(2);
  @$pb.TagNumber(3)
  set mandateType($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMandateType() => $_has(2);
  @$pb.TagNumber(3)
  void clearMandateType() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get amountLimit => $_getI64(3);
  @$pb.TagNumber(4)
  set amountLimit($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAmountLimit() => $_has(3);
  @$pb.TagNumber(4)
  void clearAmountLimit() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get debitLimit => $_getIZ(4);
  @$pb.TagNumber(5)
  set debitLimit($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasDebitLimit() => $_has(4);
  @$pb.TagNumber(5)
  void clearDebitLimit() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get startDate => $_getSZ(5);
  @$pb.TagNumber(6)
  set startDate($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasStartDate() => $_has(5);
  @$pb.TagNumber(6)
  void clearStartDate() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get endDate => $_getSZ(6);
  @$pb.TagNumber(7)
  set endDate($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasEndDate() => $_has(6);
  @$pb.TagNumber(7)
  void clearEndDate() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get description => $_getSZ(7);
  @$pb.TagNumber(8)
  set description($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasDescription() => $_has(7);
  @$pb.TagNumber(8)
  void clearDescription() => $_clearField(8);
}

/// Mandate Response (single)
class MandateResponse extends $pb.GeneratedMessage {
  factory MandateResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
    DirectDebitMandate? mandate,
    $core.bool? needsAuthorization,
    $core.String? authorizationUrl,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (errorCode != null) result.errorCode = errorCode;
    if (errorMessage != null) result.errorMessage = errorMessage;
    if (mandate != null) result.mandate = mandate;
    if (needsAuthorization != null)
      result.needsAuthorization = needsAuthorization;
    if (authorizationUrl != null) result.authorizationUrl = authorizationUrl;
    return result;
  }

  MandateResponse._();

  factory MandateResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MandateResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MandateResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'errorCode')
    ..aOS(3, _omitFieldNames ? '' : 'errorMessage')
    ..aOM<DirectDebitMandate>(4, _omitFieldNames ? '' : 'mandate',
        subBuilder: DirectDebitMandate.create)
    ..aOB(5, _omitFieldNames ? '' : 'needsAuthorization')
    ..aOS(6, _omitFieldNames ? '' : 'authorizationUrl')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MandateResponse clone() => MandateResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MandateResponse copyWith(void Function(MandateResponse) updates) =>
      super.copyWith((message) => updates(message as MandateResponse))
          as MandateResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MandateResponse create() => MandateResponse._();
  @$core.override
  MandateResponse createEmptyInstance() => create();
  static $pb.PbList<MandateResponse> createRepeated() =>
      $pb.PbList<MandateResponse>();
  @$core.pragma('dart2js:noInline')
  static MandateResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MandateResponse>(create);
  static MandateResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => $_clearField(3);

  @$pb.TagNumber(4)
  DirectDebitMandate get mandate => $_getN(3);
  @$pb.TagNumber(4)
  set mandate(DirectDebitMandate value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasMandate() => $_has(3);
  @$pb.TagNumber(4)
  void clearMandate() => $_clearField(4);
  @$pb.TagNumber(4)
  DirectDebitMandate ensureMandate() => $_ensure(3);

  /// Authorization flow fields (only set when mandate needs authorization)
  @$pb.TagNumber(5)
  $core.bool get needsAuthorization => $_getBF(4);
  @$pb.TagNumber(5)
  set needsAuthorization($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasNeedsAuthorization() => $_has(4);
  @$pb.TagNumber(5)
  void clearNeedsAuthorization() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get authorizationUrl => $_getSZ(5);
  @$pb.TagNumber(6)
  set authorizationUrl($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasAuthorizationUrl() => $_has(5);
  @$pb.TagNumber(6)
  void clearAuthorizationUrl() => $_clearField(6);
}

/// Mandates Response (list)
class MandatesResponse extends $pb.GeneratedMessage {
  factory MandatesResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
    $core.Iterable<DirectDebitMandate>? mandates,
    $core.int? total,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (errorCode != null) result.errorCode = errorCode;
    if (errorMessage != null) result.errorMessage = errorMessage;
    if (mandates != null) result.mandates.addAll(mandates);
    if (total != null) result.total = total;
    return result;
  }

  MandatesResponse._();

  factory MandatesResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MandatesResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MandatesResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'errorCode')
    ..aOS(3, _omitFieldNames ? '' : 'errorMessage')
    ..pc<DirectDebitMandate>(
        4, _omitFieldNames ? '' : 'mandates', $pb.PbFieldType.PM,
        subBuilder: DirectDebitMandate.create)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MandatesResponse clone() => MandatesResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MandatesResponse copyWith(void Function(MandatesResponse) updates) =>
      super.copyWith((message) => updates(message as MandatesResponse))
          as MandatesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MandatesResponse create() => MandatesResponse._();
  @$core.override
  MandatesResponse createEmptyInstance() => create();
  static $pb.PbList<MandatesResponse> createRepeated() =>
      $pb.PbList<MandatesResponse>();
  @$core.pragma('dart2js:noInline')
  static MandatesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MandatesResponse>(create);
  static MandatesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => $_clearField(3);

  @$pb.TagNumber(4)
  $pb.PbList<DirectDebitMandate> get mandates => $_getList(3);

  @$pb.TagNumber(5)
  $core.int get total => $_getIZ(4);
  @$pb.TagNumber(5)
  set total($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTotal() => $_has(4);
  @$pb.TagNumber(5)
  void clearTotal() => $_clearField(5);
}

/// Direct Debit Mandate Message
class DirectDebitMandate extends $pb.GeneratedMessage {
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
    final result = create();
    if (id != null) result.id = id;
    if (monoMandateId != null) result.monoMandateId = monoMandateId;
    if (userId != null) result.userId = userId;
    if (linkedAccountId != null) result.linkedAccountId = linkedAccountId;
    if (monoCustomerId != null) result.monoCustomerId = monoCustomerId;
    if (bankName != null) result.bankName = bankName;
    if (bankCode != null) result.bankCode = bankCode;
    if (accountNumber != null) result.accountNumber = accountNumber;
    if (accountName != null) result.accountName = accountName;
    if (mandateType != null) result.mandateType = mandateType;
    if (status != null) result.status = status;
    if (amountLimit != null) result.amountLimit = amountLimit;
    if (debitLimit != null) result.debitLimit = debitLimit;
    if (debitCount != null) result.debitCount = debitCount;
    if (totalDebited != null) result.totalDebited = totalDebited;
    if (startDate != null) result.startDate = startDate;
    if (endDate != null) result.endDate = endDate;
    if (createdAt != null) result.createdAt = createdAt;
    if (authorizedAt != null) result.authorizedAt = authorizedAt;
    if (readyAt != null) result.readyAt = readyAt;
    if (lastDebitAt != null) result.lastDebitAt = lastDebitAt;
    if (cancelledAt != null) result.cancelledAt = cancelledAt;
    if (reference != null) result.reference = reference;
    if (description != null) result.description = description;
    if (canDebit != null) result.canDebit = canDebit;
    if (isExpired != null) result.isExpired = isExpired;
    if (remainingLimit != null) result.remainingLimit = remainingLimit;
    return result;
  }

  DirectDebitMandate._();

  factory DirectDebitMandate.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DirectDebitMandate.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DirectDebitMandate',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'monoMandateId')
    ..aOS(3, _omitFieldNames ? '' : 'userId')
    ..aOS(4, _omitFieldNames ? '' : 'linkedAccountId')
    ..aOS(5, _omitFieldNames ? '' : 'monoCustomerId')
    ..aOS(6, _omitFieldNames ? '' : 'bankName')
    ..aOS(7, _omitFieldNames ? '' : 'bankCode')
    ..aOS(8, _omitFieldNames ? '' : 'accountNumber')
    ..aOS(9, _omitFieldNames ? '' : 'accountName')
    ..aOS(10, _omitFieldNames ? '' : 'mandateType')
    ..aOS(11, _omitFieldNames ? '' : 'status')
    ..aInt64(12, _omitFieldNames ? '' : 'amountLimit')
    ..a<$core.int>(13, _omitFieldNames ? '' : 'debitLimit', $pb.PbFieldType.O3)
    ..a<$core.int>(14, _omitFieldNames ? '' : 'debitCount', $pb.PbFieldType.O3)
    ..aInt64(15, _omitFieldNames ? '' : 'totalDebited')
    ..aOM<$1.Timestamp>(16, _omitFieldNames ? '' : 'startDate',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(17, _omitFieldNames ? '' : 'endDate',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(18, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(19, _omitFieldNames ? '' : 'authorizedAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(20, _omitFieldNames ? '' : 'readyAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(21, _omitFieldNames ? '' : 'lastDebitAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(22, _omitFieldNames ? '' : 'cancelledAt',
        subBuilder: $1.Timestamp.create)
    ..aOS(23, _omitFieldNames ? '' : 'reference')
    ..aOS(24, _omitFieldNames ? '' : 'description')
    ..aOB(25, _omitFieldNames ? '' : 'canDebit')
    ..aOB(26, _omitFieldNames ? '' : 'isExpired')
    ..aInt64(27, _omitFieldNames ? '' : 'remainingLimit')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DirectDebitMandate clone() => DirectDebitMandate()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DirectDebitMandate copyWith(void Function(DirectDebitMandate) updates) =>
      super.copyWith((message) => updates(message as DirectDebitMandate))
          as DirectDebitMandate;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DirectDebitMandate create() => DirectDebitMandate._();
  @$core.override
  DirectDebitMandate createEmptyInstance() => create();
  static $pb.PbList<DirectDebitMandate> createRepeated() =>
      $pb.PbList<DirectDebitMandate>();
  @$core.pragma('dart2js:noInline')
  static DirectDebitMandate getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DirectDebitMandate>(create);
  static DirectDebitMandate? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get monoMandateId => $_getSZ(1);
  @$pb.TagNumber(2)
  set monoMandateId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMonoMandateId() => $_has(1);
  @$pb.TagNumber(2)
  void clearMonoMandateId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get userId => $_getSZ(2);
  @$pb.TagNumber(3)
  set userId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasUserId() => $_has(2);
  @$pb.TagNumber(3)
  void clearUserId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get linkedAccountId => $_getSZ(3);
  @$pb.TagNumber(4)
  set linkedAccountId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasLinkedAccountId() => $_has(3);
  @$pb.TagNumber(4)
  void clearLinkedAccountId() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get monoCustomerId => $_getSZ(4);
  @$pb.TagNumber(5)
  set monoCustomerId($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasMonoCustomerId() => $_has(4);
  @$pb.TagNumber(5)
  void clearMonoCustomerId() => $_clearField(5);

  /// Bank account details
  @$pb.TagNumber(6)
  $core.String get bankName => $_getSZ(5);
  @$pb.TagNumber(6)
  set bankName($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasBankName() => $_has(5);
  @$pb.TagNumber(6)
  void clearBankName() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get bankCode => $_getSZ(6);
  @$pb.TagNumber(7)
  set bankCode($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasBankCode() => $_has(6);
  @$pb.TagNumber(7)
  void clearBankCode() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get accountNumber => $_getSZ(7);
  @$pb.TagNumber(8)
  set accountNumber($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasAccountNumber() => $_has(7);
  @$pb.TagNumber(8)
  void clearAccountNumber() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get accountName => $_getSZ(8);
  @$pb.TagNumber(9)
  set accountName($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasAccountName() => $_has(8);
  @$pb.TagNumber(9)
  void clearAccountName() => $_clearField(9);

  /// Mandate configuration
  @$pb.TagNumber(10)
  $core.String get mandateType => $_getSZ(9);
  @$pb.TagNumber(10)
  set mandateType($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasMandateType() => $_has(9);
  @$pb.TagNumber(10)
  void clearMandateType() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get status => $_getSZ(10);
  @$pb.TagNumber(11)
  set status($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasStatus() => $_has(10);
  @$pb.TagNumber(11)
  void clearStatus() => $_clearField(11);

  /// ready_to_debit, paused, cancelled, expired
  @$pb.TagNumber(12)
  $fixnum.Int64 get amountLimit => $_getI64(11);
  @$pb.TagNumber(12)
  set amountLimit($fixnum.Int64 value) => $_setInt64(11, value);
  @$pb.TagNumber(12)
  $core.bool hasAmountLimit() => $_has(11);
  @$pb.TagNumber(12)
  void clearAmountLimit() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.int get debitLimit => $_getIZ(12);
  @$pb.TagNumber(13)
  set debitLimit($core.int value) => $_setSignedInt32(12, value);
  @$pb.TagNumber(13)
  $core.bool hasDebitLimit() => $_has(12);
  @$pb.TagNumber(13)
  void clearDebitLimit() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.int get debitCount => $_getIZ(13);
  @$pb.TagNumber(14)
  set debitCount($core.int value) => $_setSignedInt32(13, value);
  @$pb.TagNumber(14)
  $core.bool hasDebitCount() => $_has(13);
  @$pb.TagNumber(14)
  void clearDebitCount() => $_clearField(14);

  @$pb.TagNumber(15)
  $fixnum.Int64 get totalDebited => $_getI64(14);
  @$pb.TagNumber(15)
  set totalDebited($fixnum.Int64 value) => $_setInt64(14, value);
  @$pb.TagNumber(15)
  $core.bool hasTotalDebited() => $_has(14);
  @$pb.TagNumber(15)
  void clearTotalDebited() => $_clearField(15);

  /// Validity period
  @$pb.TagNumber(16)
  $1.Timestamp get startDate => $_getN(15);
  @$pb.TagNumber(16)
  set startDate($1.Timestamp value) => $_setField(16, value);
  @$pb.TagNumber(16)
  $core.bool hasStartDate() => $_has(15);
  @$pb.TagNumber(16)
  void clearStartDate() => $_clearField(16);
  @$pb.TagNumber(16)
  $1.Timestamp ensureStartDate() => $_ensure(15);

  @$pb.TagNumber(17)
  $1.Timestamp get endDate => $_getN(16);
  @$pb.TagNumber(17)
  set endDate($1.Timestamp value) => $_setField(17, value);
  @$pb.TagNumber(17)
  $core.bool hasEndDate() => $_has(16);
  @$pb.TagNumber(17)
  void clearEndDate() => $_clearField(17);
  @$pb.TagNumber(17)
  $1.Timestamp ensureEndDate() => $_ensure(16);

  /// Timestamps
  @$pb.TagNumber(18)
  $1.Timestamp get createdAt => $_getN(17);
  @$pb.TagNumber(18)
  set createdAt($1.Timestamp value) => $_setField(18, value);
  @$pb.TagNumber(18)
  $core.bool hasCreatedAt() => $_has(17);
  @$pb.TagNumber(18)
  void clearCreatedAt() => $_clearField(18);
  @$pb.TagNumber(18)
  $1.Timestamp ensureCreatedAt() => $_ensure(17);

  @$pb.TagNumber(19)
  $1.Timestamp get authorizedAt => $_getN(18);
  @$pb.TagNumber(19)
  set authorizedAt($1.Timestamp value) => $_setField(19, value);
  @$pb.TagNumber(19)
  $core.bool hasAuthorizedAt() => $_has(18);
  @$pb.TagNumber(19)
  void clearAuthorizedAt() => $_clearField(19);
  @$pb.TagNumber(19)
  $1.Timestamp ensureAuthorizedAt() => $_ensure(18);

  @$pb.TagNumber(20)
  $1.Timestamp get readyAt => $_getN(19);
  @$pb.TagNumber(20)
  set readyAt($1.Timestamp value) => $_setField(20, value);
  @$pb.TagNumber(20)
  $core.bool hasReadyAt() => $_has(19);
  @$pb.TagNumber(20)
  void clearReadyAt() => $_clearField(20);
  @$pb.TagNumber(20)
  $1.Timestamp ensureReadyAt() => $_ensure(19);

  @$pb.TagNumber(21)
  $1.Timestamp get lastDebitAt => $_getN(20);
  @$pb.TagNumber(21)
  set lastDebitAt($1.Timestamp value) => $_setField(21, value);
  @$pb.TagNumber(21)
  $core.bool hasLastDebitAt() => $_has(20);
  @$pb.TagNumber(21)
  void clearLastDebitAt() => $_clearField(21);
  @$pb.TagNumber(21)
  $1.Timestamp ensureLastDebitAt() => $_ensure(20);

  @$pb.TagNumber(22)
  $1.Timestamp get cancelledAt => $_getN(21);
  @$pb.TagNumber(22)
  set cancelledAt($1.Timestamp value) => $_setField(22, value);
  @$pb.TagNumber(22)
  $core.bool hasCancelledAt() => $_has(21);
  @$pb.TagNumber(22)
  void clearCancelledAt() => $_clearField(22);
  @$pb.TagNumber(22)
  $1.Timestamp ensureCancelledAt() => $_ensure(21);

  /// Reference
  @$pb.TagNumber(23)
  $core.String get reference => $_getSZ(22);
  @$pb.TagNumber(23)
  set reference($core.String value) => $_setString(22, value);
  @$pb.TagNumber(23)
  $core.bool hasReference() => $_has(22);
  @$pb.TagNumber(23)
  void clearReference() => $_clearField(23);

  @$pb.TagNumber(24)
  $core.String get description => $_getSZ(23);
  @$pb.TagNumber(24)
  set description($core.String value) => $_setString(23, value);
  @$pb.TagNumber(24)
  $core.bool hasDescription() => $_has(23);
  @$pb.TagNumber(24)
  void clearDescription() => $_clearField(24);

  /// Flags
  @$pb.TagNumber(25)
  $core.bool get canDebit => $_getBF(24);
  @$pb.TagNumber(25)
  set canDebit($core.bool value) => $_setBool(24, value);
  @$pb.TagNumber(25)
  $core.bool hasCanDebit() => $_has(24);
  @$pb.TagNumber(25)
  void clearCanDebit() => $_clearField(25);

  @$pb.TagNumber(26)
  $core.bool get isExpired => $_getBF(25);
  @$pb.TagNumber(26)
  set isExpired($core.bool value) => $_setBool(25, value);
  @$pb.TagNumber(26)
  $core.bool hasIsExpired() => $_has(25);
  @$pb.TagNumber(26)
  void clearIsExpired() => $_clearField(26);

  @$pb.TagNumber(27)
  $fixnum.Int64 get remainingLimit => $_getI64(26);
  @$pb.TagNumber(27)
  set remainingLimit($fixnum.Int64 value) => $_setInt64(26, value);
  @$pb.TagNumber(27)
  $core.bool hasRemainingLimit() => $_has(26);
  @$pb.TagNumber(27)
  void clearRemainingLimit() => $_clearField(27);
}

/// Get Mandate Request
class GetMandateRequest extends $pb.GeneratedMessage {
  factory GetMandateRequest({
    $core.String? mandateId,
    $core.String? userId,
  }) {
    final result = create();
    if (mandateId != null) result.mandateId = mandateId;
    if (userId != null) result.userId = userId;
    return result;
  }

  GetMandateRequest._();

  factory GetMandateRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMandateRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMandateRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'mandateId')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMandateRequest clone() => GetMandateRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMandateRequest copyWith(void Function(GetMandateRequest) updates) =>
      super.copyWith((message) => updates(message as GetMandateRequest))
          as GetMandateRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMandateRequest create() => GetMandateRequest._();
  @$core.override
  GetMandateRequest createEmptyInstance() => create();
  static $pb.PbList<GetMandateRequest> createRepeated() =>
      $pb.PbList<GetMandateRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMandateRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetMandateRequest>(create);
  static GetMandateRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get mandateId => $_getSZ(0);
  @$pb.TagNumber(1)
  set mandateId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMandateId() => $_has(0);
  @$pb.TagNumber(1)
  void clearMandateId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => $_clearField(2);
}

/// Get User Mandates Request
class GetUserMandatesRequest extends $pb.GeneratedMessage {
  factory GetUserMandatesRequest({
    $core.String? userId,
    $core.bool? activeOnly,
    $core.int? limit,
    $core.int? offset,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    if (activeOnly != null) result.activeOnly = activeOnly;
    if (limit != null) result.limit = limit;
    if (offset != null) result.offset = offset;
    return result;
  }

  GetUserMandatesRequest._();

  factory GetUserMandatesRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetUserMandatesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUserMandatesRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOB(2, _omitFieldNames ? '' : 'activeOnly')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserMandatesRequest clone() =>
      GetUserMandatesRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserMandatesRequest copyWith(
          void Function(GetUserMandatesRequest) updates) =>
      super.copyWith((message) => updates(message as GetUserMandatesRequest))
          as GetUserMandatesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserMandatesRequest create() => GetUserMandatesRequest._();
  @$core.override
  GetUserMandatesRequest createEmptyInstance() => create();
  static $pb.PbList<GetUserMandatesRequest> createRepeated() =>
      $pb.PbList<GetUserMandatesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetUserMandatesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetUserMandatesRequest>(create);
  static GetUserMandatesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get activeOnly => $_getBF(1);
  @$pb.TagNumber(2)
  set activeOnly($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasActiveOnly() => $_has(1);
  @$pb.TagNumber(2)
  void clearActiveOnly() => $_clearField(2);

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

/// Pause Mandate Request
class PauseMandateRequest extends $pb.GeneratedMessage {
  factory PauseMandateRequest({
    $core.String? mandateId,
    $core.String? userId,
    $core.String? reason,
  }) {
    final result = create();
    if (mandateId != null) result.mandateId = mandateId;
    if (userId != null) result.userId = userId;
    if (reason != null) result.reason = reason;
    return result;
  }

  PauseMandateRequest._();

  factory PauseMandateRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PauseMandateRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PauseMandateRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'mandateId')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'reason')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PauseMandateRequest clone() => PauseMandateRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PauseMandateRequest copyWith(void Function(PauseMandateRequest) updates) =>
      super.copyWith((message) => updates(message as PauseMandateRequest))
          as PauseMandateRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PauseMandateRequest create() => PauseMandateRequest._();
  @$core.override
  PauseMandateRequest createEmptyInstance() => create();
  static $pb.PbList<PauseMandateRequest> createRepeated() =>
      $pb.PbList<PauseMandateRequest>();
  @$core.pragma('dart2js:noInline')
  static PauseMandateRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PauseMandateRequest>(create);
  static PauseMandateRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get mandateId => $_getSZ(0);
  @$pb.TagNumber(1)
  set mandateId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMandateId() => $_has(0);
  @$pb.TagNumber(1)
  void clearMandateId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get reason => $_getSZ(2);
  @$pb.TagNumber(3)
  set reason($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasReason() => $_has(2);
  @$pb.TagNumber(3)
  void clearReason() => $_clearField(3);
}

class PauseMandateResponse extends $pb.GeneratedMessage {
  factory PauseMandateResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
    DirectDebitMandate? mandate,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (errorCode != null) result.errorCode = errorCode;
    if (errorMessage != null) result.errorMessage = errorMessage;
    if (mandate != null) result.mandate = mandate;
    return result;
  }

  PauseMandateResponse._();

  factory PauseMandateResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PauseMandateResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PauseMandateResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'errorCode')
    ..aOS(3, _omitFieldNames ? '' : 'errorMessage')
    ..aOM<DirectDebitMandate>(4, _omitFieldNames ? '' : 'mandate',
        subBuilder: DirectDebitMandate.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PauseMandateResponse clone() =>
      PauseMandateResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PauseMandateResponse copyWith(void Function(PauseMandateResponse) updates) =>
      super.copyWith((message) => updates(message as PauseMandateResponse))
          as PauseMandateResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PauseMandateResponse create() => PauseMandateResponse._();
  @$core.override
  PauseMandateResponse createEmptyInstance() => create();
  static $pb.PbList<PauseMandateResponse> createRepeated() =>
      $pb.PbList<PauseMandateResponse>();
  @$core.pragma('dart2js:noInline')
  static PauseMandateResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PauseMandateResponse>(create);
  static PauseMandateResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => $_clearField(3);

  @$pb.TagNumber(4)
  DirectDebitMandate get mandate => $_getN(3);
  @$pb.TagNumber(4)
  set mandate(DirectDebitMandate value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasMandate() => $_has(3);
  @$pb.TagNumber(4)
  void clearMandate() => $_clearField(4);
  @$pb.TagNumber(4)
  DirectDebitMandate ensureMandate() => $_ensure(3);
}

/// Reinstate Mandate Request
class ReinstateMandateRequest extends $pb.GeneratedMessage {
  factory ReinstateMandateRequest({
    $core.String? mandateId,
    $core.String? userId,
  }) {
    final result = create();
    if (mandateId != null) result.mandateId = mandateId;
    if (userId != null) result.userId = userId;
    return result;
  }

  ReinstateMandateRequest._();

  factory ReinstateMandateRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ReinstateMandateRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ReinstateMandateRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'mandateId')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReinstateMandateRequest clone() =>
      ReinstateMandateRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReinstateMandateRequest copyWith(
          void Function(ReinstateMandateRequest) updates) =>
      super.copyWith((message) => updates(message as ReinstateMandateRequest))
          as ReinstateMandateRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ReinstateMandateRequest create() => ReinstateMandateRequest._();
  @$core.override
  ReinstateMandateRequest createEmptyInstance() => create();
  static $pb.PbList<ReinstateMandateRequest> createRepeated() =>
      $pb.PbList<ReinstateMandateRequest>();
  @$core.pragma('dart2js:noInline')
  static ReinstateMandateRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ReinstateMandateRequest>(create);
  static ReinstateMandateRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get mandateId => $_getSZ(0);
  @$pb.TagNumber(1)
  set mandateId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMandateId() => $_has(0);
  @$pb.TagNumber(1)
  void clearMandateId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => $_clearField(2);
}

class ReinstateMandateResponse extends $pb.GeneratedMessage {
  factory ReinstateMandateResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
    DirectDebitMandate? mandate,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (errorCode != null) result.errorCode = errorCode;
    if (errorMessage != null) result.errorMessage = errorMessage;
    if (mandate != null) result.mandate = mandate;
    return result;
  }

  ReinstateMandateResponse._();

  factory ReinstateMandateResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ReinstateMandateResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ReinstateMandateResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'errorCode')
    ..aOS(3, _omitFieldNames ? '' : 'errorMessage')
    ..aOM<DirectDebitMandate>(4, _omitFieldNames ? '' : 'mandate',
        subBuilder: DirectDebitMandate.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReinstateMandateResponse clone() =>
      ReinstateMandateResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReinstateMandateResponse copyWith(
          void Function(ReinstateMandateResponse) updates) =>
      super.copyWith((message) => updates(message as ReinstateMandateResponse))
          as ReinstateMandateResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ReinstateMandateResponse create() => ReinstateMandateResponse._();
  @$core.override
  ReinstateMandateResponse createEmptyInstance() => create();
  static $pb.PbList<ReinstateMandateResponse> createRepeated() =>
      $pb.PbList<ReinstateMandateResponse>();
  @$core.pragma('dart2js:noInline')
  static ReinstateMandateResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ReinstateMandateResponse>(create);
  static ReinstateMandateResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => $_clearField(3);

  @$pb.TagNumber(4)
  DirectDebitMandate get mandate => $_getN(3);
  @$pb.TagNumber(4)
  set mandate(DirectDebitMandate value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasMandate() => $_has(3);
  @$pb.TagNumber(4)
  void clearMandate() => $_clearField(4);
  @$pb.TagNumber(4)
  DirectDebitMandate ensureMandate() => $_ensure(3);
}

/// Cancel Mandate Request
class CancelMandateRequest extends $pb.GeneratedMessage {
  factory CancelMandateRequest({
    $core.String? mandateId,
    $core.String? userId,
    $core.String? reason,
  }) {
    final result = create();
    if (mandateId != null) result.mandateId = mandateId;
    if (userId != null) result.userId = userId;
    if (reason != null) result.reason = reason;
    return result;
  }

  CancelMandateRequest._();

  factory CancelMandateRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CancelMandateRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CancelMandateRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'mandateId')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'reason')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CancelMandateRequest clone() =>
      CancelMandateRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CancelMandateRequest copyWith(void Function(CancelMandateRequest) updates) =>
      super.copyWith((message) => updates(message as CancelMandateRequest))
          as CancelMandateRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CancelMandateRequest create() => CancelMandateRequest._();
  @$core.override
  CancelMandateRequest createEmptyInstance() => create();
  static $pb.PbList<CancelMandateRequest> createRepeated() =>
      $pb.PbList<CancelMandateRequest>();
  @$core.pragma('dart2js:noInline')
  static CancelMandateRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CancelMandateRequest>(create);
  static CancelMandateRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get mandateId => $_getSZ(0);
  @$pb.TagNumber(1)
  set mandateId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMandateId() => $_has(0);
  @$pb.TagNumber(1)
  void clearMandateId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get reason => $_getSZ(2);
  @$pb.TagNumber(3)
  set reason($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasReason() => $_has(2);
  @$pb.TagNumber(3)
  void clearReason() => $_clearField(3);
}

class CancelMandateResponse extends $pb.GeneratedMessage {
  factory CancelMandateResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (errorCode != null) result.errorCode = errorCode;
    if (errorMessage != null) result.errorMessage = errorMessage;
    return result;
  }

  CancelMandateResponse._();

  factory CancelMandateResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CancelMandateResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CancelMandateResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'errorCode')
    ..aOS(3, _omitFieldNames ? '' : 'errorMessage')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CancelMandateResponse clone() =>
      CancelMandateResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CancelMandateResponse copyWith(
          void Function(CancelMandateResponse) updates) =>
      super.copyWith((message) => updates(message as CancelMandateResponse))
          as CancelMandateResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CancelMandateResponse create() => CancelMandateResponse._();
  @$core.override
  CancelMandateResponse createEmptyInstance() => create();
  static $pb.PbList<CancelMandateResponse> createRepeated() =>
      $pb.PbList<CancelMandateResponse>();
  @$core.pragma('dart2js:noInline')
  static CancelMandateResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CancelMandateResponse>(create);
  static CancelMandateResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => $_clearField(3);
}

/// Check Mandate Balance Request (Balance inquiry before debit)
class CheckMandateBalanceRequest extends $pb.GeneratedMessage {
  factory CheckMandateBalanceRequest({
    $core.String? mandateId,
    $core.String? userId,
    $fixnum.Int64? amount,
  }) {
    final result = create();
    if (mandateId != null) result.mandateId = mandateId;
    if (userId != null) result.userId = userId;
    if (amount != null) result.amount = amount;
    return result;
  }

  CheckMandateBalanceRequest._();

  factory CheckMandateBalanceRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CheckMandateBalanceRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CheckMandateBalanceRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'mandateId')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aInt64(3, _omitFieldNames ? '' : 'amount')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CheckMandateBalanceRequest clone() =>
      CheckMandateBalanceRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CheckMandateBalanceRequest copyWith(
          void Function(CheckMandateBalanceRequest) updates) =>
      super.copyWith(
              (message) => updates(message as CheckMandateBalanceRequest))
          as CheckMandateBalanceRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CheckMandateBalanceRequest create() => CheckMandateBalanceRequest._();
  @$core.override
  CheckMandateBalanceRequest createEmptyInstance() => create();
  static $pb.PbList<CheckMandateBalanceRequest> createRepeated() =>
      $pb.PbList<CheckMandateBalanceRequest>();
  @$core.pragma('dart2js:noInline')
  static CheckMandateBalanceRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CheckMandateBalanceRequest>(create);
  static CheckMandateBalanceRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get mandateId => $_getSZ(0);
  @$pb.TagNumber(1)
  set mandateId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMandateId() => $_has(0);
  @$pb.TagNumber(1)
  void clearMandateId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get amount => $_getI64(2);
  @$pb.TagNumber(3)
  set amount($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => $_clearField(3);
}

class CheckMandateBalanceResponse extends $pb.GeneratedMessage {
  factory CheckMandateBalanceResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
    $fixnum.Int64? availableBalance,
    $core.bool? sufficientFunds,
    $core.String? currency,
    $1.Timestamp? checkedAt,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (errorCode != null) result.errorCode = errorCode;
    if (errorMessage != null) result.errorMessage = errorMessage;
    if (availableBalance != null) result.availableBalance = availableBalance;
    if (sufficientFunds != null) result.sufficientFunds = sufficientFunds;
    if (currency != null) result.currency = currency;
    if (checkedAt != null) result.checkedAt = checkedAt;
    return result;
  }

  CheckMandateBalanceResponse._();

  factory CheckMandateBalanceResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CheckMandateBalanceResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CheckMandateBalanceResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'errorCode')
    ..aOS(3, _omitFieldNames ? '' : 'errorMessage')
    ..aInt64(4, _omitFieldNames ? '' : 'availableBalance')
    ..aOB(5, _omitFieldNames ? '' : 'sufficientFunds')
    ..aOS(6, _omitFieldNames ? '' : 'currency')
    ..aOM<$1.Timestamp>(7, _omitFieldNames ? '' : 'checkedAt',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CheckMandateBalanceResponse clone() =>
      CheckMandateBalanceResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CheckMandateBalanceResponse copyWith(
          void Function(CheckMandateBalanceResponse) updates) =>
      super.copyWith(
              (message) => updates(message as CheckMandateBalanceResponse))
          as CheckMandateBalanceResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CheckMandateBalanceResponse create() =>
      CheckMandateBalanceResponse._();
  @$core.override
  CheckMandateBalanceResponse createEmptyInstance() => create();
  static $pb.PbList<CheckMandateBalanceResponse> createRepeated() =>
      $pb.PbList<CheckMandateBalanceResponse>();
  @$core.pragma('dart2js:noInline')
  static CheckMandateBalanceResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CheckMandateBalanceResponse>(create);
  static CheckMandateBalanceResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get availableBalance => $_getI64(3);
  @$pb.TagNumber(4)
  set availableBalance($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAvailableBalance() => $_has(3);
  @$pb.TagNumber(4)
  void clearAvailableBalance() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.bool get sufficientFunds => $_getBF(4);
  @$pb.TagNumber(5)
  set sufficientFunds($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasSufficientFunds() => $_has(4);
  @$pb.TagNumber(5)
  void clearSufficientFunds() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get currency => $_getSZ(5);
  @$pb.TagNumber(6)
  set currency($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasCurrency() => $_has(5);
  @$pb.TagNumber(6)
  void clearCurrency() => $_clearField(6);

  @$pb.TagNumber(7)
  $1.Timestamp get checkedAt => $_getN(6);
  @$pb.TagNumber(7)
  set checkedAt($1.Timestamp value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasCheckedAt() => $_has(6);
  @$pb.TagNumber(7)
  void clearCheckedAt() => $_clearField(7);
  @$pb.TagNumber(7)
  $1.Timestamp ensureCheckedAt() => $_ensure(6);
}

class GetTransferFeeRequest extends $pb.GeneratedMessage {
  factory GetTransferFeeRequest({
    $fixnum.Int64? amount,
    $core.String? currency,
    $core.String? transferType,
    $core.String? destinationBankCode,
  }) {
    final result = create();
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    if (transferType != null) result.transferType = transferType;
    if (destinationBankCode != null)
      result.destinationBankCode = destinationBankCode;
    return result;
  }

  GetTransferFeeRequest._();

  factory GetTransferFeeRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTransferFeeRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetTransferFeeRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'amount')
    ..aOS(2, _omitFieldNames ? '' : 'currency')
    ..aOS(3, _omitFieldNames ? '' : 'transferType')
    ..aOS(4, _omitFieldNames ? '' : 'destinationBankCode')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTransferFeeRequest clone() =>
      GetTransferFeeRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTransferFeeRequest copyWith(
          void Function(GetTransferFeeRequest) updates) =>
      super.copyWith((message) => updates(message as GetTransferFeeRequest))
          as GetTransferFeeRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTransferFeeRequest create() => GetTransferFeeRequest._();
  @$core.override
  GetTransferFeeRequest createEmptyInstance() => create();
  static $pb.PbList<GetTransferFeeRequest> createRepeated() =>
      $pb.PbList<GetTransferFeeRequest>();
  @$core.pragma('dart2js:noInline')
  static GetTransferFeeRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetTransferFeeRequest>(create);
  static GetTransferFeeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get amount => $_getI64(0);
  @$pb.TagNumber(1)
  set amount($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAmount() => $_has(0);
  @$pb.TagNumber(1)
  void clearAmount() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get currency => $_getSZ(1);
  @$pb.TagNumber(2)
  set currency($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCurrency() => $_has(1);
  @$pb.TagNumber(2)
  void clearCurrency() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get transferType => $_getSZ(2);
  @$pb.TagNumber(3)
  set transferType($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTransferType() => $_has(2);
  @$pb.TagNumber(3)
  void clearTransferType() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get destinationBankCode => $_getSZ(3);
  @$pb.TagNumber(4)
  set destinationBankCode($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDestinationBankCode() => $_has(3);
  @$pb.TagNumber(4)
  void clearDestinationBankCode() => $_clearField(4);
}

class GetTransferFeeResponse extends $pb.GeneratedMessage {
  factory GetTransferFeeResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
    $fixnum.Int64? fee,
    $core.String? currency,
    $core.String? feeType,
    $fixnum.Int64? totalAmount,
    $core.Iterable<FeeItem>? breakdown,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (errorCode != null) result.errorCode = errorCode;
    if (errorMessage != null) result.errorMessage = errorMessage;
    if (fee != null) result.fee = fee;
    if (currency != null) result.currency = currency;
    if (feeType != null) result.feeType = feeType;
    if (totalAmount != null) result.totalAmount = totalAmount;
    if (breakdown != null) result.breakdown.addAll(breakdown);
    return result;
  }

  GetTransferFeeResponse._();

  factory GetTransferFeeResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTransferFeeResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetTransferFeeResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'errorCode')
    ..aOS(3, _omitFieldNames ? '' : 'errorMessage')
    ..aInt64(4, _omitFieldNames ? '' : 'fee')
    ..aOS(5, _omitFieldNames ? '' : 'currency')
    ..aOS(6, _omitFieldNames ? '' : 'feeType')
    ..aInt64(7, _omitFieldNames ? '' : 'totalAmount')
    ..pc<FeeItem>(8, _omitFieldNames ? '' : 'breakdown', $pb.PbFieldType.PM,
        subBuilder: FeeItem.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTransferFeeResponse clone() =>
      GetTransferFeeResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTransferFeeResponse copyWith(
          void Function(GetTransferFeeResponse) updates) =>
      super.copyWith((message) => updates(message as GetTransferFeeResponse))
          as GetTransferFeeResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTransferFeeResponse create() => GetTransferFeeResponse._();
  @$core.override
  GetTransferFeeResponse createEmptyInstance() => create();
  static $pb.PbList<GetTransferFeeResponse> createRepeated() =>
      $pb.PbList<GetTransferFeeResponse>();
  @$core.pragma('dart2js:noInline')
  static GetTransferFeeResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetTransferFeeResponse>(create);
  static GetTransferFeeResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get fee => $_getI64(3);
  @$pb.TagNumber(4)
  set fee($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasFee() => $_has(3);
  @$pb.TagNumber(4)
  void clearFee() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get currency => $_getSZ(4);
  @$pb.TagNumber(5)
  set currency($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasCurrency() => $_has(4);
  @$pb.TagNumber(5)
  void clearCurrency() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get feeType => $_getSZ(5);
  @$pb.TagNumber(6)
  set feeType($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasFeeType() => $_has(5);
  @$pb.TagNumber(6)
  void clearFeeType() => $_clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get totalAmount => $_getI64(6);
  @$pb.TagNumber(7)
  set totalAmount($fixnum.Int64 value) => $_setInt64(6, value);
  @$pb.TagNumber(7)
  $core.bool hasTotalAmount() => $_has(6);
  @$pb.TagNumber(7)
  void clearTotalAmount() => $_clearField(7);

  @$pb.TagNumber(8)
  $pb.PbList<FeeItem> get breakdown => $_getList(7);
}

class FeeItem extends $pb.GeneratedMessage {
  factory FeeItem({
    $core.String? label,
    $fixnum.Int64? amount,
  }) {
    final result = create();
    if (label != null) result.label = label;
    if (amount != null) result.amount = amount;
    return result;
  }

  FeeItem._();

  factory FeeItem.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FeeItem.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FeeItem',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'label')
    ..aInt64(2, _omitFieldNames ? '' : 'amount')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FeeItem clone() => FeeItem()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FeeItem copyWith(void Function(FeeItem) updates) =>
      super.copyWith((message) => updates(message as FeeItem)) as FeeItem;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FeeItem create() => FeeItem._();
  @$core.override
  FeeItem createEmptyInstance() => create();
  static $pb.PbList<FeeItem> createRepeated() => $pb.PbList<FeeItem>();
  @$core.pragma('dart2js:noInline')
  static FeeItem getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FeeItem>(create);
  static FeeItem? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get label => $_getSZ(0);
  @$pb.TagNumber(1)
  set label($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasLabel() => $_has(0);
  @$pb.TagNumber(1)
  void clearLabel() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get amount => $_getI64(1);
  @$pb.TagNumber(2)
  set amount($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => $_clearField(2);
}

class GetCreditScoreRequest extends $pb.GeneratedMessage {
  factory GetCreditScoreRequest({
    $core.String? userId,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    return result;
  }

  GetCreditScoreRequest._();

  factory GetCreditScoreRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetCreditScoreRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetCreditScoreRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCreditScoreRequest clone() =>
      GetCreditScoreRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCreditScoreRequest copyWith(
          void Function(GetCreditScoreRequest) updates) =>
      super.copyWith((message) => updates(message as GetCreditScoreRequest))
          as GetCreditScoreRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetCreditScoreRequest create() => GetCreditScoreRequest._();
  @$core.override
  GetCreditScoreRequest createEmptyInstance() => create();
  static $pb.PbList<GetCreditScoreRequest> createRepeated() =>
      $pb.PbList<GetCreditScoreRequest>();
  @$core.pragma('dart2js:noInline')
  static GetCreditScoreRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetCreditScoreRequest>(create);
  static GetCreditScoreRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);
}

class CreditScoreResponse extends $pb.GeneratedMessage {
  factory CreditScoreResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
    CreditScore? creditScore,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (errorCode != null) result.errorCode = errorCode;
    if (errorMessage != null) result.errorMessage = errorMessage;
    if (creditScore != null) result.creditScore = creditScore;
    return result;
  }

  CreditScoreResponse._();

  factory CreditScoreResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreditScoreResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreditScoreResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'errorCode')
    ..aOS(3, _omitFieldNames ? '' : 'errorMessage')
    ..aOM<CreditScore>(4, _omitFieldNames ? '' : 'creditScore',
        subBuilder: CreditScore.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreditScoreResponse clone() => CreditScoreResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreditScoreResponse copyWith(void Function(CreditScoreResponse) updates) =>
      super.copyWith((message) => updates(message as CreditScoreResponse))
          as CreditScoreResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreditScoreResponse create() => CreditScoreResponse._();
  @$core.override
  CreditScoreResponse createEmptyInstance() => create();
  static $pb.PbList<CreditScoreResponse> createRepeated() =>
      $pb.PbList<CreditScoreResponse>();
  @$core.pragma('dart2js:noInline')
  static CreditScoreResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreditScoreResponse>(create);
  static CreditScoreResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => $_clearField(3);

  @$pb.TagNumber(4)
  CreditScore get creditScore => $_getN(3);
  @$pb.TagNumber(4)
  set creditScore(CreditScore value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasCreditScore() => $_has(3);
  @$pb.TagNumber(4)
  void clearCreditScore() => $_clearField(4);
  @$pb.TagNumber(4)
  CreditScore ensureCreditScore() => $_ensure(3);
}

class CreditScore extends $pb.GeneratedMessage {
  factory CreditScore({
    $core.String? id,
    $core.String? userId,
    $core.int? score,
    $core.String? rating,
    $core.String? linkedAccountId,
    $core.String? bankName,
    $core.double? paymentHistoryScore,
    $core.double? incomeStabilityScore,
    $core.double? spendingDisciplineScore,
    $core.double? accountAgeScore,
    $core.double? balanceConsistencyScore,
    $core.int? transactionsAnalyzed,
    $core.int? monthsOfData,
    $1.Timestamp? calculatedAt,
    $1.Timestamp? nextRefreshAt,
    $core.Iterable<CreditScoreTip>? tips,
    CreditScoreSource? source,
    $core.String? sourceLabel,
    $core.double? confidence,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (userId != null) result.userId = userId;
    if (score != null) result.score = score;
    if (rating != null) result.rating = rating;
    if (linkedAccountId != null) result.linkedAccountId = linkedAccountId;
    if (bankName != null) result.bankName = bankName;
    if (paymentHistoryScore != null)
      result.paymentHistoryScore = paymentHistoryScore;
    if (incomeStabilityScore != null)
      result.incomeStabilityScore = incomeStabilityScore;
    if (spendingDisciplineScore != null)
      result.spendingDisciplineScore = spendingDisciplineScore;
    if (accountAgeScore != null) result.accountAgeScore = accountAgeScore;
    if (balanceConsistencyScore != null)
      result.balanceConsistencyScore = balanceConsistencyScore;
    if (transactionsAnalyzed != null)
      result.transactionsAnalyzed = transactionsAnalyzed;
    if (monthsOfData != null) result.monthsOfData = monthsOfData;
    if (calculatedAt != null) result.calculatedAt = calculatedAt;
    if (nextRefreshAt != null) result.nextRefreshAt = nextRefreshAt;
    if (tips != null) result.tips.addAll(tips);
    if (source != null) result.source = source;
    if (sourceLabel != null) result.sourceLabel = sourceLabel;
    if (confidence != null) result.confidence = confidence;
    return result;
  }

  CreditScore._();

  factory CreditScore.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreditScore.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreditScore',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'score', $pb.PbFieldType.O3)
    ..aOS(4, _omitFieldNames ? '' : 'rating')
    ..aOS(5, _omitFieldNames ? '' : 'linkedAccountId')
    ..aOS(6, _omitFieldNames ? '' : 'bankName')
    ..a<$core.double>(
        7, _omitFieldNames ? '' : 'paymentHistoryScore', $pb.PbFieldType.OD)
    ..a<$core.double>(
        8, _omitFieldNames ? '' : 'incomeStabilityScore', $pb.PbFieldType.OD)
    ..a<$core.double>(
        9, _omitFieldNames ? '' : 'spendingDisciplineScore', $pb.PbFieldType.OD)
    ..a<$core.double>(
        10, _omitFieldNames ? '' : 'accountAgeScore', $pb.PbFieldType.OD)
    ..a<$core.double>(11, _omitFieldNames ? '' : 'balanceConsistencyScore',
        $pb.PbFieldType.OD)
    ..a<$core.int>(
        12, _omitFieldNames ? '' : 'transactionsAnalyzed', $pb.PbFieldType.O3)
    ..a<$core.int>(
        13, _omitFieldNames ? '' : 'monthsOfData', $pb.PbFieldType.O3)
    ..aOM<$1.Timestamp>(14, _omitFieldNames ? '' : 'calculatedAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(15, _omitFieldNames ? '' : 'nextRefreshAt',
        subBuilder: $1.Timestamp.create)
    ..pc<CreditScoreTip>(16, _omitFieldNames ? '' : 'tips', $pb.PbFieldType.PM,
        subBuilder: CreditScoreTip.create)
    ..e<CreditScoreSource>(
        17, _omitFieldNames ? '' : 'source', $pb.PbFieldType.OE,
        defaultOrMaker: CreditScoreSource.CREDIT_SCORE_SOURCE_UNSPECIFIED,
        valueOf: CreditScoreSource.valueOf,
        enumValues: CreditScoreSource.values)
    ..aOS(18, _omitFieldNames ? '' : 'sourceLabel')
    ..a<$core.double>(
        19, _omitFieldNames ? '' : 'confidence', $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreditScore clone() => CreditScore()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreditScore copyWith(void Function(CreditScore) updates) =>
      super.copyWith((message) => updates(message as CreditScore))
          as CreditScore;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreditScore create() => CreditScore._();
  @$core.override
  CreditScore createEmptyInstance() => create();
  static $pb.PbList<CreditScore> createRepeated() => $pb.PbList<CreditScore>();
  @$core.pragma('dart2js:noInline')
  static CreditScore getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreditScore>(create);
  static CreditScore? _defaultInstance;

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
  $core.int get score => $_getIZ(2);
  @$pb.TagNumber(3)
  set score($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasScore() => $_has(2);
  @$pb.TagNumber(3)
  void clearScore() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get rating => $_getSZ(3);
  @$pb.TagNumber(4)
  set rating($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasRating() => $_has(3);
  @$pb.TagNumber(4)
  void clearRating() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get linkedAccountId => $_getSZ(4);
  @$pb.TagNumber(5)
  set linkedAccountId($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasLinkedAccountId() => $_has(4);
  @$pb.TagNumber(5)
  void clearLinkedAccountId() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get bankName => $_getSZ(5);
  @$pb.TagNumber(6)
  set bankName($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasBankName() => $_has(5);
  @$pb.TagNumber(6)
  void clearBankName() => $_clearField(6);

  /// Score breakdown factors
  @$pb.TagNumber(7)
  $core.double get paymentHistoryScore => $_getN(6);
  @$pb.TagNumber(7)
  set paymentHistoryScore($core.double value) => $_setDouble(6, value);
  @$pb.TagNumber(7)
  $core.bool hasPaymentHistoryScore() => $_has(6);
  @$pb.TagNumber(7)
  void clearPaymentHistoryScore() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.double get incomeStabilityScore => $_getN(7);
  @$pb.TagNumber(8)
  set incomeStabilityScore($core.double value) => $_setDouble(7, value);
  @$pb.TagNumber(8)
  $core.bool hasIncomeStabilityScore() => $_has(7);
  @$pb.TagNumber(8)
  void clearIncomeStabilityScore() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.double get spendingDisciplineScore => $_getN(8);
  @$pb.TagNumber(9)
  set spendingDisciplineScore($core.double value) => $_setDouble(8, value);
  @$pb.TagNumber(9)
  $core.bool hasSpendingDisciplineScore() => $_has(8);
  @$pb.TagNumber(9)
  void clearSpendingDisciplineScore() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.double get accountAgeScore => $_getN(9);
  @$pb.TagNumber(10)
  set accountAgeScore($core.double value) => $_setDouble(9, value);
  @$pb.TagNumber(10)
  $core.bool hasAccountAgeScore() => $_has(9);
  @$pb.TagNumber(10)
  void clearAccountAgeScore() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.double get balanceConsistencyScore => $_getN(10);
  @$pb.TagNumber(11)
  set balanceConsistencyScore($core.double value) => $_setDouble(10, value);
  @$pb.TagNumber(11)
  $core.bool hasBalanceConsistencyScore() => $_has(10);
  @$pb.TagNumber(11)
  void clearBalanceConsistencyScore() => $_clearField(11);

  /// Context
  @$pb.TagNumber(12)
  $core.int get transactionsAnalyzed => $_getIZ(11);
  @$pb.TagNumber(12)
  set transactionsAnalyzed($core.int value) => $_setSignedInt32(11, value);
  @$pb.TagNumber(12)
  $core.bool hasTransactionsAnalyzed() => $_has(11);
  @$pb.TagNumber(12)
  void clearTransactionsAnalyzed() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.int get monthsOfData => $_getIZ(12);
  @$pb.TagNumber(13)
  set monthsOfData($core.int value) => $_setSignedInt32(12, value);
  @$pb.TagNumber(13)
  $core.bool hasMonthsOfData() => $_has(12);
  @$pb.TagNumber(13)
  void clearMonthsOfData() => $_clearField(13);

  @$pb.TagNumber(14)
  $1.Timestamp get calculatedAt => $_getN(13);
  @$pb.TagNumber(14)
  set calculatedAt($1.Timestamp value) => $_setField(14, value);
  @$pb.TagNumber(14)
  $core.bool hasCalculatedAt() => $_has(13);
  @$pb.TagNumber(14)
  void clearCalculatedAt() => $_clearField(14);
  @$pb.TagNumber(14)
  $1.Timestamp ensureCalculatedAt() => $_ensure(13);

  @$pb.TagNumber(15)
  $1.Timestamp get nextRefreshAt => $_getN(14);
  @$pb.TagNumber(15)
  set nextRefreshAt($1.Timestamp value) => $_setField(15, value);
  @$pb.TagNumber(15)
  $core.bool hasNextRefreshAt() => $_has(14);
  @$pb.TagNumber(15)
  void clearNextRefreshAt() => $_clearField(15);
  @$pb.TagNumber(15)
  $1.Timestamp ensureNextRefreshAt() => $_ensure(14);

  /// Tips for improvement
  @$pb.TagNumber(16)
  $pb.PbList<CreditScoreTip> get tips => $_getList(15);

  /// Multi-source fields
  @$pb.TagNumber(17)
  CreditScoreSource get source => $_getN(16);
  @$pb.TagNumber(17)
  set source(CreditScoreSource value) => $_setField(17, value);
  @$pb.TagNumber(17)
  $core.bool hasSource() => $_has(16);
  @$pb.TagNumber(17)
  void clearSource() => $_clearField(17);

  @$pb.TagNumber(18)
  $core.String get sourceLabel => $_getSZ(17);
  @$pb.TagNumber(18)
  set sourceLabel($core.String value) => $_setString(17, value);
  @$pb.TagNumber(18)
  $core.bool hasSourceLabel() => $_has(17);
  @$pb.TagNumber(18)
  void clearSourceLabel() => $_clearField(18);

  @$pb.TagNumber(19)
  $core.double get confidence => $_getN(18);
  @$pb.TagNumber(19)
  set confidence($core.double value) => $_setDouble(18, value);
  @$pb.TagNumber(19)
  $core.bool hasConfidence() => $_has(18);
  @$pb.TagNumber(19)
  void clearConfidence() => $_clearField(19);
}

class CreditScoreTip extends $pb.GeneratedMessage {
  factory CreditScoreTip({
    $core.String? title,
    $core.String? description,
    $core.String? category,
    $core.int? potentialImpact,
  }) {
    final result = create();
    if (title != null) result.title = title;
    if (description != null) result.description = description;
    if (category != null) result.category = category;
    if (potentialImpact != null) result.potentialImpact = potentialImpact;
    return result;
  }

  CreditScoreTip._();

  factory CreditScoreTip.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreditScoreTip.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreditScoreTip',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'title')
    ..aOS(2, _omitFieldNames ? '' : 'description')
    ..aOS(3, _omitFieldNames ? '' : 'category')
    ..a<$core.int>(
        4, _omitFieldNames ? '' : 'potentialImpact', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreditScoreTip clone() => CreditScoreTip()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreditScoreTip copyWith(void Function(CreditScoreTip) updates) =>
      super.copyWith((message) => updates(message as CreditScoreTip))
          as CreditScoreTip;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreditScoreTip create() => CreditScoreTip._();
  @$core.override
  CreditScoreTip createEmptyInstance() => create();
  static $pb.PbList<CreditScoreTip> createRepeated() =>
      $pb.PbList<CreditScoreTip>();
  @$core.pragma('dart2js:noInline')
  static CreditScoreTip getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreditScoreTip>(create);
  static CreditScoreTip? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get title => $_getSZ(0);
  @$pb.TagNumber(1)
  set title($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTitle() => $_has(0);
  @$pb.TagNumber(1)
  void clearTitle() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get description => $_getSZ(1);
  @$pb.TagNumber(2)
  set description($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDescription() => $_has(1);
  @$pb.TagNumber(2)
  void clearDescription() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get category => $_getSZ(2);
  @$pb.TagNumber(3)
  set category($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCategory() => $_has(2);
  @$pb.TagNumber(3)
  void clearCategory() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get potentialImpact => $_getIZ(3);
  @$pb.TagNumber(4)
  set potentialImpact($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPotentialImpact() => $_has(3);
  @$pb.TagNumber(4)
  void clearPotentialImpact() => $_clearField(4);
}

class GetCreditScoreHistoryRequest extends $pb.GeneratedMessage {
  factory GetCreditScoreHistoryRequest({
    $core.String? userId,
    $core.int? months,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    if (months != null) result.months = months;
    return result;
  }

  GetCreditScoreHistoryRequest._();

  factory GetCreditScoreHistoryRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetCreditScoreHistoryRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetCreditScoreHistoryRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'months', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCreditScoreHistoryRequest clone() =>
      GetCreditScoreHistoryRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCreditScoreHistoryRequest copyWith(
          void Function(GetCreditScoreHistoryRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetCreditScoreHistoryRequest))
          as GetCreditScoreHistoryRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetCreditScoreHistoryRequest create() =>
      GetCreditScoreHistoryRequest._();
  @$core.override
  GetCreditScoreHistoryRequest createEmptyInstance() => create();
  static $pb.PbList<GetCreditScoreHistoryRequest> createRepeated() =>
      $pb.PbList<GetCreditScoreHistoryRequest>();
  @$core.pragma('dart2js:noInline')
  static GetCreditScoreHistoryRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetCreditScoreHistoryRequest>(create);
  static GetCreditScoreHistoryRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get months => $_getIZ(1);
  @$pb.TagNumber(2)
  set months($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMonths() => $_has(1);
  @$pb.TagNumber(2)
  void clearMonths() => $_clearField(2);
}

class CreditScoreHistoryResponse extends $pb.GeneratedMessage {
  factory CreditScoreHistoryResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
    $core.Iterable<CreditScoreHistoryPoint>? history,
    $core.int? scoreChange,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (errorCode != null) result.errorCode = errorCode;
    if (errorMessage != null) result.errorMessage = errorMessage;
    if (history != null) result.history.addAll(history);
    if (scoreChange != null) result.scoreChange = scoreChange;
    return result;
  }

  CreditScoreHistoryResponse._();

  factory CreditScoreHistoryResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreditScoreHistoryResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreditScoreHistoryResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'errorCode')
    ..aOS(3, _omitFieldNames ? '' : 'errorMessage')
    ..pc<CreditScoreHistoryPoint>(
        4, _omitFieldNames ? '' : 'history', $pb.PbFieldType.PM,
        subBuilder: CreditScoreHistoryPoint.create)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'scoreChange', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreditScoreHistoryResponse clone() =>
      CreditScoreHistoryResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreditScoreHistoryResponse copyWith(
          void Function(CreditScoreHistoryResponse) updates) =>
      super.copyWith(
              (message) => updates(message as CreditScoreHistoryResponse))
          as CreditScoreHistoryResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreditScoreHistoryResponse create() => CreditScoreHistoryResponse._();
  @$core.override
  CreditScoreHistoryResponse createEmptyInstance() => create();
  static $pb.PbList<CreditScoreHistoryResponse> createRepeated() =>
      $pb.PbList<CreditScoreHistoryResponse>();
  @$core.pragma('dart2js:noInline')
  static CreditScoreHistoryResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreditScoreHistoryResponse>(create);
  static CreditScoreHistoryResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => $_clearField(3);

  @$pb.TagNumber(4)
  $pb.PbList<CreditScoreHistoryPoint> get history => $_getList(3);

  @$pb.TagNumber(5)
  $core.int get scoreChange => $_getIZ(4);
  @$pb.TagNumber(5)
  set scoreChange($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasScoreChange() => $_has(4);
  @$pb.TagNumber(5)
  void clearScoreChange() => $_clearField(5);
}

class CreditScoreHistoryPoint extends $pb.GeneratedMessage {
  factory CreditScoreHistoryPoint({
    $core.int? score,
    $core.String? rating,
    $1.Timestamp? date,
  }) {
    final result = create();
    if (score != null) result.score = score;
    if (rating != null) result.rating = rating;
    if (date != null) result.date = date;
    return result;
  }

  CreditScoreHistoryPoint._();

  factory CreditScoreHistoryPoint.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreditScoreHistoryPoint.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreditScoreHistoryPoint',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'score', $pb.PbFieldType.O3)
    ..aOS(2, _omitFieldNames ? '' : 'rating')
    ..aOM<$1.Timestamp>(3, _omitFieldNames ? '' : 'date',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreditScoreHistoryPoint clone() =>
      CreditScoreHistoryPoint()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreditScoreHistoryPoint copyWith(
          void Function(CreditScoreHistoryPoint) updates) =>
      super.copyWith((message) => updates(message as CreditScoreHistoryPoint))
          as CreditScoreHistoryPoint;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreditScoreHistoryPoint create() => CreditScoreHistoryPoint._();
  @$core.override
  CreditScoreHistoryPoint createEmptyInstance() => create();
  static $pb.PbList<CreditScoreHistoryPoint> createRepeated() =>
      $pb.PbList<CreditScoreHistoryPoint>();
  @$core.pragma('dart2js:noInline')
  static CreditScoreHistoryPoint getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreditScoreHistoryPoint>(create);
  static CreditScoreHistoryPoint? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get score => $_getIZ(0);
  @$pb.TagNumber(1)
  set score($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasScore() => $_has(0);
  @$pb.TagNumber(1)
  void clearScore() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get rating => $_getSZ(1);
  @$pb.TagNumber(2)
  set rating($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRating() => $_has(1);
  @$pb.TagNumber(2)
  void clearRating() => $_clearField(2);

  @$pb.TagNumber(3)
  $1.Timestamp get date => $_getN(2);
  @$pb.TagNumber(3)
  set date($1.Timestamp value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasDate() => $_has(2);
  @$pb.TagNumber(3)
  void clearDate() => $_clearField(3);
  @$pb.TagNumber(3)
  $1.Timestamp ensureDate() => $_ensure(2);
}

class RefreshCreditScoreRequest extends $pb.GeneratedMessage {
  factory RefreshCreditScoreRequest({
    $core.String? userId,
    $core.String? linkedAccountId,
    CreditScoreSource? source,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    if (linkedAccountId != null) result.linkedAccountId = linkedAccountId;
    if (source != null) result.source = source;
    return result;
  }

  RefreshCreditScoreRequest._();

  factory RefreshCreditScoreRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RefreshCreditScoreRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RefreshCreditScoreRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'linkedAccountId')
    ..e<CreditScoreSource>(
        3, _omitFieldNames ? '' : 'source', $pb.PbFieldType.OE,
        defaultOrMaker: CreditScoreSource.CREDIT_SCORE_SOURCE_UNSPECIFIED,
        valueOf: CreditScoreSource.valueOf,
        enumValues: CreditScoreSource.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RefreshCreditScoreRequest clone() =>
      RefreshCreditScoreRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RefreshCreditScoreRequest copyWith(
          void Function(RefreshCreditScoreRequest) updates) =>
      super.copyWith((message) => updates(message as RefreshCreditScoreRequest))
          as RefreshCreditScoreRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RefreshCreditScoreRequest create() => RefreshCreditScoreRequest._();
  @$core.override
  RefreshCreditScoreRequest createEmptyInstance() => create();
  static $pb.PbList<RefreshCreditScoreRequest> createRepeated() =>
      $pb.PbList<RefreshCreditScoreRequest>();
  @$core.pragma('dart2js:noInline')
  static RefreshCreditScoreRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RefreshCreditScoreRequest>(create);
  static RefreshCreditScoreRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get linkedAccountId => $_getSZ(1);
  @$pb.TagNumber(2)
  set linkedAccountId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLinkedAccountId() => $_has(1);
  @$pb.TagNumber(2)
  void clearLinkedAccountId() => $_clearField(2);

  @$pb.TagNumber(3)
  CreditScoreSource get source => $_getN(2);
  @$pb.TagNumber(3)
  set source(CreditScoreSource value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasSource() => $_has(2);
  @$pb.TagNumber(3)
  void clearSource() => $_clearField(3);
}

class GetMultiSourceCreditScoresRequest extends $pb.GeneratedMessage {
  factory GetMultiSourceCreditScoresRequest({
    $core.String? userId,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    return result;
  }

  GetMultiSourceCreditScoresRequest._();

  factory GetMultiSourceCreditScoresRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMultiSourceCreditScoresRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMultiSourceCreditScoresRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMultiSourceCreditScoresRequest clone() =>
      GetMultiSourceCreditScoresRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMultiSourceCreditScoresRequest copyWith(
          void Function(GetMultiSourceCreditScoresRequest) updates) =>
      super.copyWith((message) =>
              updates(message as GetMultiSourceCreditScoresRequest))
          as GetMultiSourceCreditScoresRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMultiSourceCreditScoresRequest create() =>
      GetMultiSourceCreditScoresRequest._();
  @$core.override
  GetMultiSourceCreditScoresRequest createEmptyInstance() => create();
  static $pb.PbList<GetMultiSourceCreditScoresRequest> createRepeated() =>
      $pb.PbList<GetMultiSourceCreditScoresRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMultiSourceCreditScoresRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetMultiSourceCreditScoresRequest>(
          create);
  static GetMultiSourceCreditScoresRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);
}

class MultiSourceCreditScoresResponse extends $pb.GeneratedMessage {
  factory MultiSourceCreditScoresResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
    CreditScore? lazervaultScore,
    CreditScore? externalScore,
    CreditScore? combinedScore,
    $core.bool? hasLinkedBanks,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (errorCode != null) result.errorCode = errorCode;
    if (errorMessage != null) result.errorMessage = errorMessage;
    if (lazervaultScore != null) result.lazervaultScore = lazervaultScore;
    if (externalScore != null) result.externalScore = externalScore;
    if (combinedScore != null) result.combinedScore = combinedScore;
    if (hasLinkedBanks != null) result.hasLinkedBanks = hasLinkedBanks;
    return result;
  }

  MultiSourceCreditScoresResponse._();

  factory MultiSourceCreditScoresResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MultiSourceCreditScoresResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MultiSourceCreditScoresResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'errorCode')
    ..aOS(3, _omitFieldNames ? '' : 'errorMessage')
    ..aOM<CreditScore>(4, _omitFieldNames ? '' : 'lazervaultScore',
        subBuilder: CreditScore.create)
    ..aOM<CreditScore>(5, _omitFieldNames ? '' : 'externalScore',
        subBuilder: CreditScore.create)
    ..aOM<CreditScore>(6, _omitFieldNames ? '' : 'combinedScore',
        subBuilder: CreditScore.create)
    ..aOB(7, _omitFieldNames ? '' : 'hasLinkedBanks')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MultiSourceCreditScoresResponse clone() =>
      MultiSourceCreditScoresResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MultiSourceCreditScoresResponse copyWith(
          void Function(MultiSourceCreditScoresResponse) updates) =>
      super.copyWith(
              (message) => updates(message as MultiSourceCreditScoresResponse))
          as MultiSourceCreditScoresResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MultiSourceCreditScoresResponse create() =>
      MultiSourceCreditScoresResponse._();
  @$core.override
  MultiSourceCreditScoresResponse createEmptyInstance() => create();
  static $pb.PbList<MultiSourceCreditScoresResponse> createRepeated() =>
      $pb.PbList<MultiSourceCreditScoresResponse>();
  @$core.pragma('dart2js:noInline')
  static MultiSourceCreditScoresResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MultiSourceCreditScoresResponse>(
          create);
  static MultiSourceCreditScoresResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => $_clearField(3);

  @$pb.TagNumber(4)
  CreditScore get lazervaultScore => $_getN(3);
  @$pb.TagNumber(4)
  set lazervaultScore(CreditScore value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasLazervaultScore() => $_has(3);
  @$pb.TagNumber(4)
  void clearLazervaultScore() => $_clearField(4);
  @$pb.TagNumber(4)
  CreditScore ensureLazervaultScore() => $_ensure(3);

  @$pb.TagNumber(5)
  CreditScore get externalScore => $_getN(4);
  @$pb.TagNumber(5)
  set externalScore(CreditScore value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasExternalScore() => $_has(4);
  @$pb.TagNumber(5)
  void clearExternalScore() => $_clearField(5);
  @$pb.TagNumber(5)
  CreditScore ensureExternalScore() => $_ensure(4);

  @$pb.TagNumber(6)
  CreditScore get combinedScore => $_getN(5);
  @$pb.TagNumber(6)
  set combinedScore(CreditScore value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasCombinedScore() => $_has(5);
  @$pb.TagNumber(6)
  void clearCombinedScore() => $_clearField(6);
  @$pb.TagNumber(6)
  CreditScore ensureCombinedScore() => $_ensure(5);

  @$pb.TagNumber(7)
  $core.bool get hasLinkedBanks => $_getBF(6);
  @$pb.TagNumber(7)
  set hasLinkedBanks($core.bool value) => $_setBool(6, value);
  @$pb.TagNumber(7)
  $core.bool hasHasLinkedBanks() => $_has(6);
  @$pb.TagNumber(7)
  void clearHasLinkedBanks() => $_clearField(7);
}

/// Initiate Move Transfer
class InitiateMoveTransferRequest extends $pb.GeneratedMessage {
  factory InitiateMoveTransferRequest({
    $core.String? userId,
    $core.String? sourceLinkedAccountId,
    $core.String? destinationLinkedAccountId,
    $fixnum.Int64? amount,
    $core.String? currency,
    $core.String? narration,
    $core.String? transactionPin,
    $core.String? idempotencyKey,
    $core.String? verificationToken,
    $core.String? transactionId,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    if (sourceLinkedAccountId != null)
      result.sourceLinkedAccountId = sourceLinkedAccountId;
    if (destinationLinkedAccountId != null)
      result.destinationLinkedAccountId = destinationLinkedAccountId;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    if (narration != null) result.narration = narration;
    if (transactionPin != null) result.transactionPin = transactionPin;
    if (idempotencyKey != null) result.idempotencyKey = idempotencyKey;
    if (verificationToken != null) result.verificationToken = verificationToken;
    if (transactionId != null) result.transactionId = transactionId;
    return result;
  }

  InitiateMoveTransferRequest._();

  factory InitiateMoveTransferRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InitiateMoveTransferRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InitiateMoveTransferRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'sourceLinkedAccountId')
    ..aOS(3, _omitFieldNames ? '' : 'destinationLinkedAccountId')
    ..aInt64(4, _omitFieldNames ? '' : 'amount')
    ..aOS(5, _omitFieldNames ? '' : 'currency')
    ..aOS(6, _omitFieldNames ? '' : 'narration')
    ..aOS(7, _omitFieldNames ? '' : 'transactionPin')
    ..aOS(8, _omitFieldNames ? '' : 'idempotencyKey')
    ..aOS(9, _omitFieldNames ? '' : 'verificationToken')
    ..aOS(10, _omitFieldNames ? '' : 'transactionId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InitiateMoveTransferRequest clone() =>
      InitiateMoveTransferRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InitiateMoveTransferRequest copyWith(
          void Function(InitiateMoveTransferRequest) updates) =>
      super.copyWith(
              (message) => updates(message as InitiateMoveTransferRequest))
          as InitiateMoveTransferRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InitiateMoveTransferRequest create() =>
      InitiateMoveTransferRequest._();
  @$core.override
  InitiateMoveTransferRequest createEmptyInstance() => create();
  static $pb.PbList<InitiateMoveTransferRequest> createRepeated() =>
      $pb.PbList<InitiateMoveTransferRequest>();
  @$core.pragma('dart2js:noInline')
  static InitiateMoveTransferRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InitiateMoveTransferRequest>(create);
  static InitiateMoveTransferRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get sourceLinkedAccountId => $_getSZ(1);
  @$pb.TagNumber(2)
  set sourceLinkedAccountId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSourceLinkedAccountId() => $_has(1);
  @$pb.TagNumber(2)
  void clearSourceLinkedAccountId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get destinationLinkedAccountId => $_getSZ(2);
  @$pb.TagNumber(3)
  set destinationLinkedAccountId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDestinationLinkedAccountId() => $_has(2);
  @$pb.TagNumber(3)
  void clearDestinationLinkedAccountId() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get amount => $_getI64(3);
  @$pb.TagNumber(4)
  set amount($fixnum.Int64 value) => $_setInt64(3, value);
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
  $core.String get narration => $_getSZ(5);
  @$pb.TagNumber(6)
  set narration($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasNarration() => $_has(5);
  @$pb.TagNumber(6)
  void clearNarration() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get transactionPin => $_getSZ(6);
  @$pb.TagNumber(7)
  set transactionPin($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasTransactionPin() => $_has(6);
  @$pb.TagNumber(7)
  void clearTransactionPin() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get idempotencyKey => $_getSZ(7);
  @$pb.TagNumber(8)
  set idempotencyKey($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasIdempotencyKey() => $_has(7);
  @$pb.TagNumber(8)
  void clearIdempotencyKey() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get verificationToken => $_getSZ(8);
  @$pb.TagNumber(9)
  set verificationToken($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasVerificationToken() => $_has(8);
  @$pb.TagNumber(9)
  void clearVerificationToken() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get transactionId => $_getSZ(9);
  @$pb.TagNumber(10)
  set transactionId($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasTransactionId() => $_has(9);
  @$pb.TagNumber(10)
  void clearTransactionId() => $_clearField(10);
}

class MoveTransferResponse extends $pb.GeneratedMessage {
  factory MoveTransferResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
    MoveTransfer? transfer,
    $core.String? message,
    $core.bool? requiresAuthorization,
    $core.String? paymentUrl,
    $core.String? paymentId,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (errorCode != null) result.errorCode = errorCode;
    if (errorMessage != null) result.errorMessage = errorMessage;
    if (transfer != null) result.transfer = transfer;
    if (message != null) result.message = message;
    if (requiresAuthorization != null)
      result.requiresAuthorization = requiresAuthorization;
    if (paymentUrl != null) result.paymentUrl = paymentUrl;
    if (paymentId != null) result.paymentId = paymentId;
    return result;
  }

  MoveTransferResponse._();

  factory MoveTransferResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MoveTransferResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MoveTransferResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'errorCode')
    ..aOS(3, _omitFieldNames ? '' : 'errorMessage')
    ..aOM<MoveTransfer>(4, _omitFieldNames ? '' : 'transfer',
        subBuilder: MoveTransfer.create)
    ..aOS(5, _omitFieldNames ? '' : 'message')
    ..aOB(6, _omitFieldNames ? '' : 'requiresAuthorization')
    ..aOS(7, _omitFieldNames ? '' : 'paymentUrl')
    ..aOS(8, _omitFieldNames ? '' : 'paymentId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MoveTransferResponse clone() =>
      MoveTransferResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MoveTransferResponse copyWith(void Function(MoveTransferResponse) updates) =>
      super.copyWith((message) => updates(message as MoveTransferResponse))
          as MoveTransferResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MoveTransferResponse create() => MoveTransferResponse._();
  @$core.override
  MoveTransferResponse createEmptyInstance() => create();
  static $pb.PbList<MoveTransferResponse> createRepeated() =>
      $pb.PbList<MoveTransferResponse>();
  @$core.pragma('dart2js:noInline')
  static MoveTransferResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MoveTransferResponse>(create);
  static MoveTransferResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => $_clearField(3);

  @$pb.TagNumber(4)
  MoveTransfer get transfer => $_getN(3);
  @$pb.TagNumber(4)
  set transfer(MoveTransfer value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasTransfer() => $_has(3);
  @$pb.TagNumber(4)
  void clearTransfer() => $_clearField(4);
  @$pb.TagNumber(4)
  MoveTransfer ensureTransfer() => $_ensure(3);

  @$pb.TagNumber(5)
  $core.String get message => $_getSZ(4);
  @$pb.TagNumber(5)
  set message($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasMessage() => $_has(4);
  @$pb.TagNumber(5)
  void clearMessage() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.bool get requiresAuthorization => $_getBF(5);
  @$pb.TagNumber(6)
  set requiresAuthorization($core.bool value) => $_setBool(5, value);
  @$pb.TagNumber(6)
  $core.bool hasRequiresAuthorization() => $_has(5);
  @$pb.TagNumber(6)
  void clearRequiresAuthorization() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get paymentUrl => $_getSZ(6);
  @$pb.TagNumber(7)
  set paymentUrl($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasPaymentUrl() => $_has(6);
  @$pb.TagNumber(7)
  void clearPaymentUrl() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get paymentId => $_getSZ(7);
  @$pb.TagNumber(8)
  set paymentId($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasPaymentId() => $_has(7);
  @$pb.TagNumber(8)
  void clearPaymentId() => $_clearField(8);
}

/// Move Transfer record
class MoveTransfer extends $pb.GeneratedMessage {
  factory MoveTransfer({
    $core.String? id,
    $core.String? userId,
    $core.String? sourceLinkedAccountId,
    $core.String? sourceBankName,
    $core.String? sourceAccountNumber,
    $core.String? sourceAccountName,
    $core.String? destinationLinkedAccountId,
    $core.String? destinationBankName,
    $core.String? destinationAccountNumber,
    $core.String? destinationAccountName,
    $fixnum.Int64? amount,
    $fixnum.Int64? debitFee,
    $fixnum.Int64? transferFee,
    $fixnum.Int64? stampDuty,
    $fixnum.Int64? serviceFee,
    $fixnum.Int64? totalFee,
    $fixnum.Int64? totalDebit,
    $core.String? status,
    $core.String? reference,
    $core.String? debitReference,
    $core.String? payoutReference,
    $core.String? failureCode,
    $core.String? failureReason,
    $core.String? failureStage,
    $core.String? paymentUrl,
    $core.String? paymentId,
    $core.String? currency,
    $core.String? narration,
    $1.Timestamp? createdAt,
    $1.Timestamp? debitCompletedAt,
    $1.Timestamp? payoutCompletedAt,
    $1.Timestamp? completedAt,
    $1.Timestamp? failedAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (userId != null) result.userId = userId;
    if (sourceLinkedAccountId != null)
      result.sourceLinkedAccountId = sourceLinkedAccountId;
    if (sourceBankName != null) result.sourceBankName = sourceBankName;
    if (sourceAccountNumber != null)
      result.sourceAccountNumber = sourceAccountNumber;
    if (sourceAccountName != null) result.sourceAccountName = sourceAccountName;
    if (destinationLinkedAccountId != null)
      result.destinationLinkedAccountId = destinationLinkedAccountId;
    if (destinationBankName != null)
      result.destinationBankName = destinationBankName;
    if (destinationAccountNumber != null)
      result.destinationAccountNumber = destinationAccountNumber;
    if (destinationAccountName != null)
      result.destinationAccountName = destinationAccountName;
    if (amount != null) result.amount = amount;
    if (debitFee != null) result.debitFee = debitFee;
    if (transferFee != null) result.transferFee = transferFee;
    if (stampDuty != null) result.stampDuty = stampDuty;
    if (serviceFee != null) result.serviceFee = serviceFee;
    if (totalFee != null) result.totalFee = totalFee;
    if (totalDebit != null) result.totalDebit = totalDebit;
    if (status != null) result.status = status;
    if (reference != null) result.reference = reference;
    if (debitReference != null) result.debitReference = debitReference;
    if (payoutReference != null) result.payoutReference = payoutReference;
    if (failureCode != null) result.failureCode = failureCode;
    if (failureReason != null) result.failureReason = failureReason;
    if (failureStage != null) result.failureStage = failureStage;
    if (paymentUrl != null) result.paymentUrl = paymentUrl;
    if (paymentId != null) result.paymentId = paymentId;
    if (currency != null) result.currency = currency;
    if (narration != null) result.narration = narration;
    if (createdAt != null) result.createdAt = createdAt;
    if (debitCompletedAt != null) result.debitCompletedAt = debitCompletedAt;
    if (payoutCompletedAt != null) result.payoutCompletedAt = payoutCompletedAt;
    if (completedAt != null) result.completedAt = completedAt;
    if (failedAt != null) result.failedAt = failedAt;
    return result;
  }

  MoveTransfer._();

  factory MoveTransfer.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MoveTransfer.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MoveTransfer',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'sourceLinkedAccountId')
    ..aOS(4, _omitFieldNames ? '' : 'sourceBankName')
    ..aOS(5, _omitFieldNames ? '' : 'sourceAccountNumber')
    ..aOS(6, _omitFieldNames ? '' : 'sourceAccountName')
    ..aOS(7, _omitFieldNames ? '' : 'destinationLinkedAccountId')
    ..aOS(8, _omitFieldNames ? '' : 'destinationBankName')
    ..aOS(9, _omitFieldNames ? '' : 'destinationAccountNumber')
    ..aOS(10, _omitFieldNames ? '' : 'destinationAccountName')
    ..aInt64(11, _omitFieldNames ? '' : 'amount')
    ..aInt64(12, _omitFieldNames ? '' : 'debitFee')
    ..aInt64(13, _omitFieldNames ? '' : 'transferFee')
    ..aInt64(14, _omitFieldNames ? '' : 'stampDuty')
    ..aInt64(15, _omitFieldNames ? '' : 'serviceFee')
    ..aInt64(16, _omitFieldNames ? '' : 'totalFee')
    ..aInt64(17, _omitFieldNames ? '' : 'totalDebit')
    ..aOS(18, _omitFieldNames ? '' : 'status')
    ..aOS(19, _omitFieldNames ? '' : 'reference')
    ..aOS(20, _omitFieldNames ? '' : 'debitReference')
    ..aOS(21, _omitFieldNames ? '' : 'payoutReference')
    ..aOS(22, _omitFieldNames ? '' : 'failureCode')
    ..aOS(23, _omitFieldNames ? '' : 'failureReason')
    ..aOS(24, _omitFieldNames ? '' : 'failureStage')
    ..aOS(25, _omitFieldNames ? '' : 'paymentUrl')
    ..aOS(26, _omitFieldNames ? '' : 'paymentId')
    ..aOS(27, _omitFieldNames ? '' : 'currency')
    ..aOS(28, _omitFieldNames ? '' : 'narration')
    ..aOM<$1.Timestamp>(29, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(30, _omitFieldNames ? '' : 'debitCompletedAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(31, _omitFieldNames ? '' : 'payoutCompletedAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(32, _omitFieldNames ? '' : 'completedAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(33, _omitFieldNames ? '' : 'failedAt',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MoveTransfer clone() => MoveTransfer()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MoveTransfer copyWith(void Function(MoveTransfer) updates) =>
      super.copyWith((message) => updates(message as MoveTransfer))
          as MoveTransfer;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MoveTransfer create() => MoveTransfer._();
  @$core.override
  MoveTransfer createEmptyInstance() => create();
  static $pb.PbList<MoveTransfer> createRepeated() =>
      $pb.PbList<MoveTransfer>();
  @$core.pragma('dart2js:noInline')
  static MoveTransfer getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MoveTransfer>(create);
  static MoveTransfer? _defaultInstance;

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

  /// Source (debit via Mono)
  @$pb.TagNumber(3)
  $core.String get sourceLinkedAccountId => $_getSZ(2);
  @$pb.TagNumber(3)
  set sourceLinkedAccountId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSourceLinkedAccountId() => $_has(2);
  @$pb.TagNumber(3)
  void clearSourceLinkedAccountId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get sourceBankName => $_getSZ(3);
  @$pb.TagNumber(4)
  set sourceBankName($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasSourceBankName() => $_has(3);
  @$pb.TagNumber(4)
  void clearSourceBankName() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get sourceAccountNumber => $_getSZ(4);
  @$pb.TagNumber(5)
  set sourceAccountNumber($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasSourceAccountNumber() => $_has(4);
  @$pb.TagNumber(5)
  void clearSourceAccountNumber() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get sourceAccountName => $_getSZ(5);
  @$pb.TagNumber(6)
  set sourceAccountName($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasSourceAccountName() => $_has(5);
  @$pb.TagNumber(6)
  void clearSourceAccountName() => $_clearField(6);

  /// Destination (credit via Flutterwave payout)
  @$pb.TagNumber(7)
  $core.String get destinationLinkedAccountId => $_getSZ(6);
  @$pb.TagNumber(7)
  set destinationLinkedAccountId($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasDestinationLinkedAccountId() => $_has(6);
  @$pb.TagNumber(7)
  void clearDestinationLinkedAccountId() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get destinationBankName => $_getSZ(7);
  @$pb.TagNumber(8)
  set destinationBankName($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasDestinationBankName() => $_has(7);
  @$pb.TagNumber(8)
  void clearDestinationBankName() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get destinationAccountNumber => $_getSZ(8);
  @$pb.TagNumber(9)
  set destinationAccountNumber($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasDestinationAccountNumber() => $_has(8);
  @$pb.TagNumber(9)
  void clearDestinationAccountNumber() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get destinationAccountName => $_getSZ(9);
  @$pb.TagNumber(10)
  set destinationAccountName($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasDestinationAccountName() => $_has(9);
  @$pb.TagNumber(10)
  void clearDestinationAccountName() => $_clearField(10);

  /// Amounts (all in minor units / kobo)
  @$pb.TagNumber(11)
  $fixnum.Int64 get amount => $_getI64(10);
  @$pb.TagNumber(11)
  set amount($fixnum.Int64 value) => $_setInt64(10, value);
  @$pb.TagNumber(11)
  $core.bool hasAmount() => $_has(10);
  @$pb.TagNumber(11)
  void clearAmount() => $_clearField(11);

  @$pb.TagNumber(12)
  $fixnum.Int64 get debitFee => $_getI64(11);
  @$pb.TagNumber(12)
  set debitFee($fixnum.Int64 value) => $_setInt64(11, value);
  @$pb.TagNumber(12)
  $core.bool hasDebitFee() => $_has(11);
  @$pb.TagNumber(12)
  void clearDebitFee() => $_clearField(12);

  @$pb.TagNumber(13)
  $fixnum.Int64 get transferFee => $_getI64(12);
  @$pb.TagNumber(13)
  set transferFee($fixnum.Int64 value) => $_setInt64(12, value);
  @$pb.TagNumber(13)
  $core.bool hasTransferFee() => $_has(12);
  @$pb.TagNumber(13)
  void clearTransferFee() => $_clearField(13);

  @$pb.TagNumber(14)
  $fixnum.Int64 get stampDuty => $_getI64(13);
  @$pb.TagNumber(14)
  set stampDuty($fixnum.Int64 value) => $_setInt64(13, value);
  @$pb.TagNumber(14)
  $core.bool hasStampDuty() => $_has(13);
  @$pb.TagNumber(14)
  void clearStampDuty() => $_clearField(14);

  @$pb.TagNumber(15)
  $fixnum.Int64 get serviceFee => $_getI64(14);
  @$pb.TagNumber(15)
  set serviceFee($fixnum.Int64 value) => $_setInt64(14, value);
  @$pb.TagNumber(15)
  $core.bool hasServiceFee() => $_has(14);
  @$pb.TagNumber(15)
  void clearServiceFee() => $_clearField(15);

  @$pb.TagNumber(16)
  $fixnum.Int64 get totalFee => $_getI64(15);
  @$pb.TagNumber(16)
  set totalFee($fixnum.Int64 value) => $_setInt64(15, value);
  @$pb.TagNumber(16)
  $core.bool hasTotalFee() => $_has(15);
  @$pb.TagNumber(16)
  void clearTotalFee() => $_clearField(16);

  @$pb.TagNumber(17)
  $fixnum.Int64 get totalDebit => $_getI64(16);
  @$pb.TagNumber(17)
  set totalDebit($fixnum.Int64 value) => $_setInt64(16, value);
  @$pb.TagNumber(17)
  $core.bool hasTotalDebit() => $_has(16);
  @$pb.TagNumber(17)
  void clearTotalDebit() => $_clearField(17);

  /// Status tracking
  @$pb.TagNumber(18)
  $core.String get status => $_getSZ(17);
  @$pb.TagNumber(18)
  set status($core.String value) => $_setString(17, value);
  @$pb.TagNumber(18)
  $core.bool hasStatus() => $_has(17);
  @$pb.TagNumber(18)
  void clearStatus() => $_clearField(18);

  /// debit_completed, payout_initiated, payout_processing,
  /// completed, failed, refunding, refunded
  @$pb.TagNumber(19)
  $core.String get reference => $_getSZ(18);
  @$pb.TagNumber(19)
  set reference($core.String value) => $_setString(18, value);
  @$pb.TagNumber(19)
  $core.bool hasReference() => $_has(18);
  @$pb.TagNumber(19)
  void clearReference() => $_clearField(19);

  @$pb.TagNumber(20)
  $core.String get debitReference => $_getSZ(19);
  @$pb.TagNumber(20)
  set debitReference($core.String value) => $_setString(19, value);
  @$pb.TagNumber(20)
  $core.bool hasDebitReference() => $_has(19);
  @$pb.TagNumber(20)
  void clearDebitReference() => $_clearField(20);

  @$pb.TagNumber(21)
  $core.String get payoutReference => $_getSZ(20);
  @$pb.TagNumber(21)
  set payoutReference($core.String value) => $_setString(20, value);
  @$pb.TagNumber(21)
  $core.bool hasPayoutReference() => $_has(20);
  @$pb.TagNumber(21)
  void clearPayoutReference() => $_clearField(21);

  /// Failure info
  @$pb.TagNumber(22)
  $core.String get failureCode => $_getSZ(21);
  @$pb.TagNumber(22)
  set failureCode($core.String value) => $_setString(21, value);
  @$pb.TagNumber(22)
  $core.bool hasFailureCode() => $_has(21);
  @$pb.TagNumber(22)
  void clearFailureCode() => $_clearField(22);

  @$pb.TagNumber(23)
  $core.String get failureReason => $_getSZ(22);
  @$pb.TagNumber(23)
  set failureReason($core.String value) => $_setString(22, value);
  @$pb.TagNumber(23)
  $core.bool hasFailureReason() => $_has(22);
  @$pb.TagNumber(23)
  void clearFailureReason() => $_clearField(23);

  @$pb.TagNumber(24)
  $core.String get failureStage => $_getSZ(23);
  @$pb.TagNumber(24)
  set failureStage($core.String value) => $_setString(23, value);
  @$pb.TagNumber(24)
  $core.bool hasFailureStage() => $_has(23);
  @$pb.TagNumber(24)
  void clearFailureStage() => $_clearField(24);

  /// DirectPay fields
  @$pb.TagNumber(25)
  $core.String get paymentUrl => $_getSZ(24);
  @$pb.TagNumber(25)
  set paymentUrl($core.String value) => $_setString(24, value);
  @$pb.TagNumber(25)
  $core.bool hasPaymentUrl() => $_has(24);
  @$pb.TagNumber(25)
  void clearPaymentUrl() => $_clearField(25);

  @$pb.TagNumber(26)
  $core.String get paymentId => $_getSZ(25);
  @$pb.TagNumber(26)
  set paymentId($core.String value) => $_setString(25, value);
  @$pb.TagNumber(26)
  $core.bool hasPaymentId() => $_has(25);
  @$pb.TagNumber(26)
  void clearPaymentId() => $_clearField(26);

  @$pb.TagNumber(27)
  $core.String get currency => $_getSZ(26);
  @$pb.TagNumber(27)
  set currency($core.String value) => $_setString(26, value);
  @$pb.TagNumber(27)
  $core.bool hasCurrency() => $_has(26);
  @$pb.TagNumber(27)
  void clearCurrency() => $_clearField(27);

  @$pb.TagNumber(28)
  $core.String get narration => $_getSZ(27);
  @$pb.TagNumber(28)
  set narration($core.String value) => $_setString(27, value);
  @$pb.TagNumber(28)
  $core.bool hasNarration() => $_has(27);
  @$pb.TagNumber(28)
  void clearNarration() => $_clearField(28);

  /// Timestamps
  @$pb.TagNumber(29)
  $1.Timestamp get createdAt => $_getN(28);
  @$pb.TagNumber(29)
  set createdAt($1.Timestamp value) => $_setField(29, value);
  @$pb.TagNumber(29)
  $core.bool hasCreatedAt() => $_has(28);
  @$pb.TagNumber(29)
  void clearCreatedAt() => $_clearField(29);
  @$pb.TagNumber(29)
  $1.Timestamp ensureCreatedAt() => $_ensure(28);

  @$pb.TagNumber(30)
  $1.Timestamp get debitCompletedAt => $_getN(29);
  @$pb.TagNumber(30)
  set debitCompletedAt($1.Timestamp value) => $_setField(30, value);
  @$pb.TagNumber(30)
  $core.bool hasDebitCompletedAt() => $_has(29);
  @$pb.TagNumber(30)
  void clearDebitCompletedAt() => $_clearField(30);
  @$pb.TagNumber(30)
  $1.Timestamp ensureDebitCompletedAt() => $_ensure(29);

  @$pb.TagNumber(31)
  $1.Timestamp get payoutCompletedAt => $_getN(30);
  @$pb.TagNumber(31)
  set payoutCompletedAt($1.Timestamp value) => $_setField(31, value);
  @$pb.TagNumber(31)
  $core.bool hasPayoutCompletedAt() => $_has(30);
  @$pb.TagNumber(31)
  void clearPayoutCompletedAt() => $_clearField(31);
  @$pb.TagNumber(31)
  $1.Timestamp ensurePayoutCompletedAt() => $_ensure(30);

  @$pb.TagNumber(32)
  $1.Timestamp get completedAt => $_getN(31);
  @$pb.TagNumber(32)
  set completedAt($1.Timestamp value) => $_setField(32, value);
  @$pb.TagNumber(32)
  $core.bool hasCompletedAt() => $_has(31);
  @$pb.TagNumber(32)
  void clearCompletedAt() => $_clearField(32);
  @$pb.TagNumber(32)
  $1.Timestamp ensureCompletedAt() => $_ensure(31);

  @$pb.TagNumber(33)
  $1.Timestamp get failedAt => $_getN(32);
  @$pb.TagNumber(33)
  set failedAt($1.Timestamp value) => $_setField(33, value);
  @$pb.TagNumber(33)
  $core.bool hasFailedAt() => $_has(32);
  @$pb.TagNumber(33)
  void clearFailedAt() => $_clearField(33);
  @$pb.TagNumber(33)
  $1.Timestamp ensureFailedAt() => $_ensure(32);
}

/// Get Move Transfer Status
class GetMoveTransferStatusRequest extends $pb.GeneratedMessage {
  factory GetMoveTransferStatusRequest({
    $core.String? transferId,
    $core.String? userId,
  }) {
    final result = create();
    if (transferId != null) result.transferId = transferId;
    if (userId != null) result.userId = userId;
    return result;
  }

  GetMoveTransferStatusRequest._();

  factory GetMoveTransferStatusRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMoveTransferStatusRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMoveTransferStatusRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'transferId')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMoveTransferStatusRequest clone() =>
      GetMoveTransferStatusRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMoveTransferStatusRequest copyWith(
          void Function(GetMoveTransferStatusRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetMoveTransferStatusRequest))
          as GetMoveTransferStatusRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMoveTransferStatusRequest create() =>
      GetMoveTransferStatusRequest._();
  @$core.override
  GetMoveTransferStatusRequest createEmptyInstance() => create();
  static $pb.PbList<GetMoveTransferStatusRequest> createRepeated() =>
      $pb.PbList<GetMoveTransferStatusRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMoveTransferStatusRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetMoveTransferStatusRequest>(create);
  static GetMoveTransferStatusRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get transferId => $_getSZ(0);
  @$pb.TagNumber(1)
  set transferId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTransferId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransferId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => $_clearField(2);
}

/// Get User Move Transfers
class GetMoveTransfersRequest extends $pb.GeneratedMessage {
  factory GetMoveTransfersRequest({
    $core.String? userId,
    $core.int? limit,
    $core.int? offset,
    $core.String? statusFilter,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    if (limit != null) result.limit = limit;
    if (offset != null) result.offset = offset;
    if (statusFilter != null) result.statusFilter = statusFilter;
    return result;
  }

  GetMoveTransfersRequest._();

  factory GetMoveTransfersRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMoveTransfersRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMoveTransfersRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'offset', $pb.PbFieldType.O3)
    ..aOS(4, _omitFieldNames ? '' : 'statusFilter')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMoveTransfersRequest clone() =>
      GetMoveTransfersRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMoveTransfersRequest copyWith(
          void Function(GetMoveTransfersRequest) updates) =>
      super.copyWith((message) => updates(message as GetMoveTransfersRequest))
          as GetMoveTransfersRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMoveTransfersRequest create() => GetMoveTransfersRequest._();
  @$core.override
  GetMoveTransfersRequest createEmptyInstance() => create();
  static $pb.PbList<GetMoveTransfersRequest> createRepeated() =>
      $pb.PbList<GetMoveTransfersRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMoveTransfersRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetMoveTransfersRequest>(create);
  static GetMoveTransfersRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

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

  @$pb.TagNumber(4)
  $core.String get statusFilter => $_getSZ(3);
  @$pb.TagNumber(4)
  set statusFilter($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasStatusFilter() => $_has(3);
  @$pb.TagNumber(4)
  void clearStatusFilter() => $_clearField(4);
}

class MoveTransfersResponse extends $pb.GeneratedMessage {
  factory MoveTransfersResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
    $core.Iterable<MoveTransfer>? transfers,
    $core.int? total,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (errorCode != null) result.errorCode = errorCode;
    if (errorMessage != null) result.errorMessage = errorMessage;
    if (transfers != null) result.transfers.addAll(transfers);
    if (total != null) result.total = total;
    return result;
  }

  MoveTransfersResponse._();

  factory MoveTransfersResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MoveTransfersResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MoveTransfersResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'errorCode')
    ..aOS(3, _omitFieldNames ? '' : 'errorMessage')
    ..pc<MoveTransfer>(
        4, _omitFieldNames ? '' : 'transfers', $pb.PbFieldType.PM,
        subBuilder: MoveTransfer.create)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MoveTransfersResponse clone() =>
      MoveTransfersResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MoveTransfersResponse copyWith(
          void Function(MoveTransfersResponse) updates) =>
      super.copyWith((message) => updates(message as MoveTransfersResponse))
          as MoveTransfersResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MoveTransfersResponse create() => MoveTransfersResponse._();
  @$core.override
  MoveTransfersResponse createEmptyInstance() => create();
  static $pb.PbList<MoveTransfersResponse> createRepeated() =>
      $pb.PbList<MoveTransfersResponse>();
  @$core.pragma('dart2js:noInline')
  static MoveTransfersResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MoveTransfersResponse>(create);
  static MoveTransfersResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => $_clearField(3);

  @$pb.TagNumber(4)
  $pb.PbList<MoveTransfer> get transfers => $_getList(3);

  @$pb.TagNumber(5)
  $core.int get total => $_getIZ(4);
  @$pb.TagNumber(5)
  set total($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTotal() => $_has(4);
  @$pb.TagNumber(5)
  void clearTotal() => $_clearField(5);
}

/// Calculate Move Fee
class CalculateMoveFeeRequest extends $pb.GeneratedMessage {
  factory CalculateMoveFeeRequest({
    $fixnum.Int64? amount,
    $core.String? countryCode,
  }) {
    final result = create();
    if (amount != null) result.amount = amount;
    if (countryCode != null) result.countryCode = countryCode;
    return result;
  }

  CalculateMoveFeeRequest._();

  factory CalculateMoveFeeRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CalculateMoveFeeRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CalculateMoveFeeRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'amount')
    ..aOS(2, _omitFieldNames ? '' : 'countryCode')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CalculateMoveFeeRequest clone() =>
      CalculateMoveFeeRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CalculateMoveFeeRequest copyWith(
          void Function(CalculateMoveFeeRequest) updates) =>
      super.copyWith((message) => updates(message as CalculateMoveFeeRequest))
          as CalculateMoveFeeRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CalculateMoveFeeRequest create() => CalculateMoveFeeRequest._();
  @$core.override
  CalculateMoveFeeRequest createEmptyInstance() => create();
  static $pb.PbList<CalculateMoveFeeRequest> createRepeated() =>
      $pb.PbList<CalculateMoveFeeRequest>();
  @$core.pragma('dart2js:noInline')
  static CalculateMoveFeeRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CalculateMoveFeeRequest>(create);
  static CalculateMoveFeeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get amount => $_getI64(0);
  @$pb.TagNumber(1)
  set amount($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAmount() => $_has(0);
  @$pb.TagNumber(1)
  void clearAmount() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get countryCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set countryCode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCountryCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearCountryCode() => $_clearField(2);
}

class CalculateMoveFeeResponse extends $pb.GeneratedMessage {
  factory CalculateMoveFeeResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
    $fixnum.Int64? amount,
    $fixnum.Int64? debitFee,
    $fixnum.Int64? transferFee,
    $fixnum.Int64? stampDuty,
    $fixnum.Int64? serviceFee,
    $fixnum.Int64? totalFee,
    $fixnum.Int64? totalDebit,
    $core.String? currency,
    $core.Iterable<FeeItem>? breakdown,
    $fixnum.Int64? minAmount,
    $fixnum.Int64? maxAmount,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (errorCode != null) result.errorCode = errorCode;
    if (errorMessage != null) result.errorMessage = errorMessage;
    if (amount != null) result.amount = amount;
    if (debitFee != null) result.debitFee = debitFee;
    if (transferFee != null) result.transferFee = transferFee;
    if (stampDuty != null) result.stampDuty = stampDuty;
    if (serviceFee != null) result.serviceFee = serviceFee;
    if (totalFee != null) result.totalFee = totalFee;
    if (totalDebit != null) result.totalDebit = totalDebit;
    if (currency != null) result.currency = currency;
    if (breakdown != null) result.breakdown.addAll(breakdown);
    if (minAmount != null) result.minAmount = minAmount;
    if (maxAmount != null) result.maxAmount = maxAmount;
    return result;
  }

  CalculateMoveFeeResponse._();

  factory CalculateMoveFeeResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CalculateMoveFeeResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CalculateMoveFeeResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'banking'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'errorCode')
    ..aOS(3, _omitFieldNames ? '' : 'errorMessage')
    ..aInt64(4, _omitFieldNames ? '' : 'amount')
    ..aInt64(5, _omitFieldNames ? '' : 'debitFee')
    ..aInt64(6, _omitFieldNames ? '' : 'transferFee')
    ..aInt64(7, _omitFieldNames ? '' : 'stampDuty')
    ..aInt64(8, _omitFieldNames ? '' : 'serviceFee')
    ..aInt64(9, _omitFieldNames ? '' : 'totalFee')
    ..aInt64(10, _omitFieldNames ? '' : 'totalDebit')
    ..aOS(11, _omitFieldNames ? '' : 'currency')
    ..pc<FeeItem>(12, _omitFieldNames ? '' : 'breakdown', $pb.PbFieldType.PM,
        subBuilder: FeeItem.create)
    ..aInt64(13, _omitFieldNames ? '' : 'minAmount')
    ..aInt64(14, _omitFieldNames ? '' : 'maxAmount')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CalculateMoveFeeResponse clone() =>
      CalculateMoveFeeResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CalculateMoveFeeResponse copyWith(
          void Function(CalculateMoveFeeResponse) updates) =>
      super.copyWith((message) => updates(message as CalculateMoveFeeResponse))
          as CalculateMoveFeeResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CalculateMoveFeeResponse create() => CalculateMoveFeeResponse._();
  @$core.override
  CalculateMoveFeeResponse createEmptyInstance() => create();
  static $pb.PbList<CalculateMoveFeeResponse> createRepeated() =>
      $pb.PbList<CalculateMoveFeeResponse>();
  @$core.pragma('dart2js:noInline')
  static CalculateMoveFeeResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CalculateMoveFeeResponse>(create);
  static CalculateMoveFeeResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get amount => $_getI64(3);
  @$pb.TagNumber(4)
  set amount($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearAmount() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get debitFee => $_getI64(4);
  @$pb.TagNumber(5)
  set debitFee($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasDebitFee() => $_has(4);
  @$pb.TagNumber(5)
  void clearDebitFee() => $_clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get transferFee => $_getI64(5);
  @$pb.TagNumber(6)
  set transferFee($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasTransferFee() => $_has(5);
  @$pb.TagNumber(6)
  void clearTransferFee() => $_clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get stampDuty => $_getI64(6);
  @$pb.TagNumber(7)
  set stampDuty($fixnum.Int64 value) => $_setInt64(6, value);
  @$pb.TagNumber(7)
  $core.bool hasStampDuty() => $_has(6);
  @$pb.TagNumber(7)
  void clearStampDuty() => $_clearField(7);

  @$pb.TagNumber(8)
  $fixnum.Int64 get serviceFee => $_getI64(7);
  @$pb.TagNumber(8)
  set serviceFee($fixnum.Int64 value) => $_setInt64(7, value);
  @$pb.TagNumber(8)
  $core.bool hasServiceFee() => $_has(7);
  @$pb.TagNumber(8)
  void clearServiceFee() => $_clearField(8);

  @$pb.TagNumber(9)
  $fixnum.Int64 get totalFee => $_getI64(8);
  @$pb.TagNumber(9)
  set totalFee($fixnum.Int64 value) => $_setInt64(8, value);
  @$pb.TagNumber(9)
  $core.bool hasTotalFee() => $_has(8);
  @$pb.TagNumber(9)
  void clearTotalFee() => $_clearField(9);

  @$pb.TagNumber(10)
  $fixnum.Int64 get totalDebit => $_getI64(9);
  @$pb.TagNumber(10)
  set totalDebit($fixnum.Int64 value) => $_setInt64(9, value);
  @$pb.TagNumber(10)
  $core.bool hasTotalDebit() => $_has(9);
  @$pb.TagNumber(10)
  void clearTotalDebit() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get currency => $_getSZ(10);
  @$pb.TagNumber(11)
  set currency($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasCurrency() => $_has(10);
  @$pb.TagNumber(11)
  void clearCurrency() => $_clearField(11);

  @$pb.TagNumber(12)
  $pb.PbList<FeeItem> get breakdown => $_getList(11);

  @$pb.TagNumber(13)
  $fixnum.Int64 get minAmount => $_getI64(12);
  @$pb.TagNumber(13)
  set minAmount($fixnum.Int64 value) => $_setInt64(12, value);
  @$pb.TagNumber(13)
  $core.bool hasMinAmount() => $_has(12);
  @$pb.TagNumber(13)
  void clearMinAmount() => $_clearField(13);

  @$pb.TagNumber(14)
  $fixnum.Int64 get maxAmount => $_getI64(13);
  @$pb.TagNumber(14)
  set maxAmount($fixnum.Int64 value) => $_setInt64(13, value);
  @$pb.TagNumber(14)
  $core.bool hasMaxAmount() => $_has(13);
  @$pb.TagNumber(14)
  void clearMaxAmount() => $_clearField(14);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
