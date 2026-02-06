//
//  Generated code. Do not modify.
//  source: account.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/timestamp.pb.dart' as $42;

export 'account.pbenum.dart';

/// The Account message represents a user's financial account.
class Account extends $pb.GeneratedMessage {
  factory Account({
    $fixnum.Int64? id,
    $core.String? accountType,
    $core.String? currency,
    $core.double? balance,
    $core.String? accountNumber,
    $core.bool? isActive,
    $42.Timestamp? createdAt,
    $42.Timestamp? updatedAt,
    $core.bool? isPrimary,
    $core.String? accountLabel,
    $core.String? bankName,
    $core.String? bankCode,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (accountType != null) {
      $result.accountType = accountType;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (balance != null) {
      $result.balance = balance;
    }
    if (accountNumber != null) {
      $result.accountNumber = accountNumber;
    }
    if (isActive != null) {
      $result.isActive = isActive;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      $result.updatedAt = updatedAt;
    }
    if (isPrimary != null) {
      $result.isPrimary = isPrimary;
    }
    if (accountLabel != null) {
      $result.accountLabel = accountLabel;
    }
    if (bankName != null) {
      $result.bankName = bankName;
    }
    if (bankCode != null) {
      $result.bankCode = bankCode;
    }
    return $result;
  }
  Account._() : super();
  factory Account.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Account.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Account', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(2, _omitFieldNames ? '' : 'accountType')
    ..aOS(3, _omitFieldNames ? '' : 'currency')
    ..a<$core.double>(4, _omitFieldNames ? '' : 'balance', $pb.PbFieldType.OD)
    ..aOS(5, _omitFieldNames ? '' : 'accountNumber')
    ..aOB(6, _omitFieldNames ? '' : 'isActive')
    ..aOM<$42.Timestamp>(7, _omitFieldNames ? '' : 'createdAt', subBuilder: $42.Timestamp.create)
    ..aOM<$42.Timestamp>(8, _omitFieldNames ? '' : 'updatedAt', subBuilder: $42.Timestamp.create)
    ..aOB(9, _omitFieldNames ? '' : 'isPrimary')
    ..aOS(10, _omitFieldNames ? '' : 'accountLabel')
    ..aOS(11, _omitFieldNames ? '' : 'bankName')
    ..aOS(12, _omitFieldNames ? '' : 'bankCode')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Account clone() => Account()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Account copyWith(void Function(Account) updates) => super.copyWith((message) => updates(message as Account)) as Account;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Account create() => Account._();
  Account createEmptyInstance() => create();
  static $pb.PbList<Account> createRepeated() => $pb.PbList<Account>();
  @$core.pragma('dart2js:noInline')
  static Account getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Account>(create);
  static Account? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get id => $_getI64(0);
  @$pb.TagNumber(1)
  set id($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get accountType => $_getSZ(1);
  @$pb.TagNumber(2)
  set accountType($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAccountType() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccountType() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get currency => $_getSZ(2);
  @$pb.TagNumber(3)
  set currency($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCurrency() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrency() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get balance => $_getN(3);
  @$pb.TagNumber(4)
  set balance($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasBalance() => $_has(3);
  @$pb.TagNumber(4)
  void clearBalance() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get accountNumber => $_getSZ(4);
  @$pb.TagNumber(5)
  set accountNumber($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasAccountNumber() => $_has(4);
  @$pb.TagNumber(5)
  void clearAccountNumber() => clearField(5);

  @$pb.TagNumber(6)
  $core.bool get isActive => $_getBF(5);
  @$pb.TagNumber(6)
  set isActive($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasIsActive() => $_has(5);
  @$pb.TagNumber(6)
  void clearIsActive() => clearField(6);

  @$pb.TagNumber(7)
  $42.Timestamp get createdAt => $_getN(6);
  @$pb.TagNumber(7)
  set createdAt($42.Timestamp v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasCreatedAt() => $_has(6);
  @$pb.TagNumber(7)
  void clearCreatedAt() => clearField(7);
  @$pb.TagNumber(7)
  $42.Timestamp ensureCreatedAt() => $_ensure(6);

  @$pb.TagNumber(8)
  $42.Timestamp get updatedAt => $_getN(7);
  @$pb.TagNumber(8)
  set updatedAt($42.Timestamp v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasUpdatedAt() => $_has(7);
  @$pb.TagNumber(8)
  void clearUpdatedAt() => clearField(8);
  @$pb.TagNumber(8)
  $42.Timestamp ensureUpdatedAt() => $_ensure(7);

  @$pb.TagNumber(9)
  $core.bool get isPrimary => $_getBF(8);
  @$pb.TagNumber(9)
  set isPrimary($core.bool v) { $_setBool(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasIsPrimary() => $_has(8);
  @$pb.TagNumber(9)
  void clearIsPrimary() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get accountLabel => $_getSZ(9);
  @$pb.TagNumber(10)
  set accountLabel($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasAccountLabel() => $_has(9);
  @$pb.TagNumber(10)
  void clearAccountLabel() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get bankName => $_getSZ(10);
  @$pb.TagNumber(11)
  set bankName($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasBankName() => $_has(10);
  @$pb.TagNumber(11)
  void clearBankName() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get bankCode => $_getSZ(11);
  @$pb.TagNumber(12)
  set bankCode($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasBankCode() => $_has(11);
  @$pb.TagNumber(12)
  void clearBankCode() => clearField(12);
}

/// Request message for creating a new account.
class CreateAccountRequest extends $pb.GeneratedMessage {
  factory CreateAccountRequest({
    $core.String? accountType,
    $core.String? currency,
    $core.String? pin,
  }) {
    final $result = create();
    if (accountType != null) {
      $result.accountType = accountType;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (pin != null) {
      $result.pin = pin;
    }
    return $result;
  }
  CreateAccountRequest._() : super();
  factory CreateAccountRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateAccountRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateAccountRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'account_type')
    ..aOS(2, _omitFieldNames ? '' : 'currency')
    ..aOS(3, _omitFieldNames ? '' : 'pin')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateAccountRequest clone() => CreateAccountRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateAccountRequest copyWith(void Function(CreateAccountRequest) updates) => super.copyWith((message) => updates(message as CreateAccountRequest)) as CreateAccountRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateAccountRequest create() => CreateAccountRequest._();
  CreateAccountRequest createEmptyInstance() => create();
  static $pb.PbList<CreateAccountRequest> createRepeated() => $pb.PbList<CreateAccountRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateAccountRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateAccountRequest>(create);
  static CreateAccountRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountType => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountType($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccountType() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountType() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get currency => $_getSZ(1);
  @$pb.TagNumber(2)
  set currency($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCurrency() => $_has(1);
  @$pb.TagNumber(2)
  void clearCurrency() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get pin => $_getSZ(2);
  @$pb.TagNumber(3)
  set pin($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPin() => $_has(2);
  @$pb.TagNumber(3)
  void clearPin() => clearField(3);
}

/// Response message after creating an account.
class CreateAccountResponse extends $pb.GeneratedMessage {
  factory CreateAccountResponse({
    AccountDetails? account,
  }) {
    final $result = create();
    if (account != null) {
      $result.account = account;
    }
    return $result;
  }
  CreateAccountResponse._() : super();
  factory CreateAccountResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateAccountResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateAccountResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<AccountDetails>(1, _omitFieldNames ? '' : 'account', subBuilder: AccountDetails.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateAccountResponse clone() => CreateAccountResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateAccountResponse copyWith(void Function(CreateAccountResponse) updates) => super.copyWith((message) => updates(message as CreateAccountResponse)) as CreateAccountResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateAccountResponse create() => CreateAccountResponse._();
  CreateAccountResponse createEmptyInstance() => create();
  static $pb.PbList<CreateAccountResponse> createRepeated() => $pb.PbList<CreateAccountResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateAccountResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateAccountResponse>(create);
  static CreateAccountResponse? _defaultInstance;

  @$pb.TagNumber(1)
  AccountDetails get account => $_getN(0);
  @$pb.TagNumber(1)
  set account(AccountDetails v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccount() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccount() => clearField(1);
  @$pb.TagNumber(1)
  AccountDetails ensureAccount() => $_ensure(0);
}

/// Request message for retrieving accounts (currently no parameters needed).
class GetAccountsRequest extends $pb.GeneratedMessage {
  factory GetAccountsRequest() => create();
  GetAccountsRequest._() : super();
  factory GetAccountsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAccountsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetAccountsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAccountsRequest clone() => GetAccountsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAccountsRequest copyWith(void Function(GetAccountsRequest) updates) => super.copyWith((message) => updates(message as GetAccountsRequest)) as GetAccountsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAccountsRequest create() => GetAccountsRequest._();
  GetAccountsRequest createEmptyInstance() => create();
  static $pb.PbList<GetAccountsRequest> createRepeated() => $pb.PbList<GetAccountsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetAccountsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAccountsRequest>(create);
  static GetAccountsRequest? _defaultInstance;
}

/// Response message containing a list of accounts.
class GetAccountsResponse extends $pb.GeneratedMessage {
  factory GetAccountsResponse({
    $core.Iterable<Account>? accounts,
  }) {
    final $result = create();
    if (accounts != null) {
      $result.accounts.addAll(accounts);
    }
    return $result;
  }
  GetAccountsResponse._() : super();
  factory GetAccountsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAccountsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetAccountsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pc<Account>(1, _omitFieldNames ? '' : 'accounts', $pb.PbFieldType.PM, subBuilder: Account.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAccountsResponse clone() => GetAccountsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAccountsResponse copyWith(void Function(GetAccountsResponse) updates) => super.copyWith((message) => updates(message as GetAccountsResponse)) as GetAccountsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAccountsResponse create() => GetAccountsResponse._();
  GetAccountsResponse createEmptyInstance() => create();
  static $pb.PbList<GetAccountsResponse> createRepeated() => $pb.PbList<GetAccountsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetAccountsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAccountsResponse>(create);
  static GetAccountsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Account> get accounts => $_getList(0);
}

/// AccountSummary: Used for listing accounts (e.g., in the carousel)
class AccountSummary extends $pb.GeneratedMessage {
  factory AccountSummary({
    $fixnum.Int64? id,
    $core.String? accountType,
    $core.String? currency,
    $fixnum.Int64? balance,
    $core.String? maskedAccountNumber,
    $core.String? status,
    $core.bool? isPrimary,
    $core.String? accountLabel,
    $core.String? bankName,
    $core.double? trendPercentage,
    $core.bool? isFamilyAccount,
    $fixnum.Int64? familyTotalBalance,
    $fixnum.Int64? memberAllocatedBalance,
    $core.int? memberCount,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (accountType != null) {
      $result.accountType = accountType;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (balance != null) {
      $result.balance = balance;
    }
    if (maskedAccountNumber != null) {
      $result.maskedAccountNumber = maskedAccountNumber;
    }
    if (status != null) {
      $result.status = status;
    }
    if (isPrimary != null) {
      $result.isPrimary = isPrimary;
    }
    if (accountLabel != null) {
      $result.accountLabel = accountLabel;
    }
    if (bankName != null) {
      $result.bankName = bankName;
    }
    if (trendPercentage != null) {
      $result.trendPercentage = trendPercentage;
    }
    if (isFamilyAccount != null) {
      $result.isFamilyAccount = isFamilyAccount;
    }
    if (familyTotalBalance != null) {
      $result.familyTotalBalance = familyTotalBalance;
    }
    if (memberAllocatedBalance != null) {
      $result.memberAllocatedBalance = memberAllocatedBalance;
    }
    if (memberCount != null) {
      $result.memberCount = memberCount;
    }
    return $result;
  }
  AccountSummary._() : super();
  factory AccountSummary.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AccountSummary.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AccountSummary', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(2, _omitFieldNames ? '' : 'accountType')
    ..aOS(3, _omitFieldNames ? '' : 'currency')
    ..a<$fixnum.Int64>(4, _omitFieldNames ? '' : 'balance', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(5, _omitFieldNames ? '' : 'maskedAccountNumber')
    ..aOS(6, _omitFieldNames ? '' : 'status')
    ..aOB(7, _omitFieldNames ? '' : 'isPrimary')
    ..aOS(8, _omitFieldNames ? '' : 'accountLabel')
    ..aOS(9, _omitFieldNames ? '' : 'bankName')
    ..a<$core.double>(10, _omitFieldNames ? '' : 'trendPercentage', $pb.PbFieldType.OD)
    ..aOB(11, _omitFieldNames ? '' : 'isFamilyAccount')
    ..a<$fixnum.Int64>(12, _omitFieldNames ? '' : 'familyTotalBalance', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(13, _omitFieldNames ? '' : 'memberAllocatedBalance', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(14, _omitFieldNames ? '' : 'memberCount', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AccountSummary clone() => AccountSummary()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AccountSummary copyWith(void Function(AccountSummary) updates) => super.copyWith((message) => updates(message as AccountSummary)) as AccountSummary;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AccountSummary create() => AccountSummary._();
  AccountSummary createEmptyInstance() => create();
  static $pb.PbList<AccountSummary> createRepeated() => $pb.PbList<AccountSummary>();
  @$core.pragma('dart2js:noInline')
  static AccountSummary getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AccountSummary>(create);
  static AccountSummary? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get id => $_getI64(0);
  @$pb.TagNumber(1)
  set id($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get accountType => $_getSZ(1);
  @$pb.TagNumber(2)
  set accountType($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAccountType() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccountType() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get currency => $_getSZ(2);
  @$pb.TagNumber(3)
  set currency($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCurrency() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrency() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get balance => $_getI64(3);
  @$pb.TagNumber(4)
  set balance($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasBalance() => $_has(3);
  @$pb.TagNumber(4)
  void clearBalance() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get maskedAccountNumber => $_getSZ(4);
  @$pb.TagNumber(5)
  set maskedAccountNumber($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasMaskedAccountNumber() => $_has(4);
  @$pb.TagNumber(5)
  void clearMaskedAccountNumber() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get status => $_getSZ(5);
  @$pb.TagNumber(6)
  set status($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasStatus() => $_has(5);
  @$pb.TagNumber(6)
  void clearStatus() => clearField(6);

  @$pb.TagNumber(7)
  $core.bool get isPrimary => $_getBF(6);
  @$pb.TagNumber(7)
  set isPrimary($core.bool v) { $_setBool(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasIsPrimary() => $_has(6);
  @$pb.TagNumber(7)
  void clearIsPrimary() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get accountLabel => $_getSZ(7);
  @$pb.TagNumber(8)
  set accountLabel($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasAccountLabel() => $_has(7);
  @$pb.TagNumber(8)
  void clearAccountLabel() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get bankName => $_getSZ(8);
  @$pb.TagNumber(9)
  set bankName($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasBankName() => $_has(8);
  @$pb.TagNumber(9)
  void clearBankName() => clearField(9);

  @$pb.TagNumber(10)
  $core.double get trendPercentage => $_getN(9);
  @$pb.TagNumber(10)
  set trendPercentage($core.double v) { $_setDouble(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasTrendPercentage() => $_has(9);
  @$pb.TagNumber(10)
  void clearTrendPercentage() => clearField(10);

  /// Family account specific fields
  @$pb.TagNumber(11)
  $core.bool get isFamilyAccount => $_getBF(10);
  @$pb.TagNumber(11)
  set isFamilyAccount($core.bool v) { $_setBool(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasIsFamilyAccount() => $_has(10);
  @$pb.TagNumber(11)
  void clearIsFamilyAccount() => clearField(11);

  @$pb.TagNumber(12)
  $fixnum.Int64 get familyTotalBalance => $_getI64(11);
  @$pb.TagNumber(12)
  set familyTotalBalance($fixnum.Int64 v) { $_setInt64(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasFamilyTotalBalance() => $_has(11);
  @$pb.TagNumber(12)
  void clearFamilyTotalBalance() => clearField(12);

  @$pb.TagNumber(13)
  $fixnum.Int64 get memberAllocatedBalance => $_getI64(12);
  @$pb.TagNumber(13)
  set memberAllocatedBalance($fixnum.Int64 v) { $_setInt64(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasMemberAllocatedBalance() => $_has(12);
  @$pb.TagNumber(13)
  void clearMemberAllocatedBalance() => clearField(13);

  @$pb.TagNumber(14)
  $core.int get memberCount => $_getIZ(13);
  @$pb.TagNumber(14)
  set memberCount($core.int v) { $_setSignedInt32(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasMemberCount() => $_has(13);
  @$pb.TagNumber(14)
  void clearMemberCount() => clearField(14);
}

/// AccountDetails: Used for the detailed view
class AccountDetails extends $pb.GeneratedMessage {
  factory AccountDetails({
    $fixnum.Int64? id,
    $core.String? accountType,
    $core.String? currency,
    $fixnum.Int64? balance,
    $core.String? status,
    $core.String? cardHolderName,
    $core.String? cardType,
    $core.String? expiryDate,
    $fixnum.Int64? dailyLimit,
    $fixnum.Int64? monthlyLimit,
    $core.bool? enable3dSecure,
    $core.bool? enableContactless,
    $core.bool? enableOnlinePayments,
    $core.String? accountNumber,
    $core.String? iban,
    $core.String? bicSwift,
    $42.Timestamp? createdAt,
    $42.Timestamp? updatedAt,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (accountType != null) {
      $result.accountType = accountType;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (balance != null) {
      $result.balance = balance;
    }
    if (status != null) {
      $result.status = status;
    }
    if (cardHolderName != null) {
      $result.cardHolderName = cardHolderName;
    }
    if (cardType != null) {
      $result.cardType = cardType;
    }
    if (expiryDate != null) {
      $result.expiryDate = expiryDate;
    }
    if (dailyLimit != null) {
      $result.dailyLimit = dailyLimit;
    }
    if (monthlyLimit != null) {
      $result.monthlyLimit = monthlyLimit;
    }
    if (enable3dSecure != null) {
      $result.enable3dSecure = enable3dSecure;
    }
    if (enableContactless != null) {
      $result.enableContactless = enableContactless;
    }
    if (enableOnlinePayments != null) {
      $result.enableOnlinePayments = enableOnlinePayments;
    }
    if (accountNumber != null) {
      $result.accountNumber = accountNumber;
    }
    if (iban != null) {
      $result.iban = iban;
    }
    if (bicSwift != null) {
      $result.bicSwift = bicSwift;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      $result.updatedAt = updatedAt;
    }
    return $result;
  }
  AccountDetails._() : super();
  factory AccountDetails.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AccountDetails.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AccountDetails', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(2, _omitFieldNames ? '' : 'accountType')
    ..aOS(3, _omitFieldNames ? '' : 'currency')
    ..a<$fixnum.Int64>(4, _omitFieldNames ? '' : 'balance', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(6, _omitFieldNames ? '' : 'status')
    ..aOS(7, _omitFieldNames ? '' : 'cardHolderName')
    ..aOS(8, _omitFieldNames ? '' : 'cardType')
    ..aOS(9, _omitFieldNames ? '' : 'expiryDate')
    ..a<$fixnum.Int64>(10, _omitFieldNames ? '' : 'dailyLimit', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(11, _omitFieldNames ? '' : 'monthlyLimit', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOB(12, _omitFieldNames ? '' : 'enable3dSecure', protoName: 'enable_3d_secure')
    ..aOB(13, _omitFieldNames ? '' : 'enableContactless')
    ..aOB(14, _omitFieldNames ? '' : 'enableOnlinePayments')
    ..aOS(15, _omitFieldNames ? '' : 'accountNumber')
    ..aOS(16, _omitFieldNames ? '' : 'iban')
    ..aOS(17, _omitFieldNames ? '' : 'bicSwift')
    ..aOM<$42.Timestamp>(18, _omitFieldNames ? '' : 'createdAt', subBuilder: $42.Timestamp.create)
    ..aOM<$42.Timestamp>(19, _omitFieldNames ? '' : 'updatedAt', subBuilder: $42.Timestamp.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AccountDetails clone() => AccountDetails()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AccountDetails copyWith(void Function(AccountDetails) updates) => super.copyWith((message) => updates(message as AccountDetails)) as AccountDetails;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AccountDetails create() => AccountDetails._();
  AccountDetails createEmptyInstance() => create();
  static $pb.PbList<AccountDetails> createRepeated() => $pb.PbList<AccountDetails>();
  @$core.pragma('dart2js:noInline')
  static AccountDetails getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AccountDetails>(create);
  static AccountDetails? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get id => $_getI64(0);
  @$pb.TagNumber(1)
  set id($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get accountType => $_getSZ(1);
  @$pb.TagNumber(2)
  set accountType($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAccountType() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccountType() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get currency => $_getSZ(2);
  @$pb.TagNumber(3)
  set currency($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCurrency() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrency() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get balance => $_getI64(3);
  @$pb.TagNumber(4)
  set balance($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasBalance() => $_has(3);
  @$pb.TagNumber(4)
  void clearBalance() => clearField(4);

  @$pb.TagNumber(6)
  $core.String get status => $_getSZ(4);
  @$pb.TagNumber(6)
  set status($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(6)
  $core.bool hasStatus() => $_has(4);
  @$pb.TagNumber(6)
  void clearStatus() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get cardHolderName => $_getSZ(5);
  @$pb.TagNumber(7)
  set cardHolderName($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(7)
  $core.bool hasCardHolderName() => $_has(5);
  @$pb.TagNumber(7)
  void clearCardHolderName() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get cardType => $_getSZ(6);
  @$pb.TagNumber(8)
  set cardType($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(8)
  $core.bool hasCardType() => $_has(6);
  @$pb.TagNumber(8)
  void clearCardType() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get expiryDate => $_getSZ(7);
  @$pb.TagNumber(9)
  set expiryDate($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(9)
  $core.bool hasExpiryDate() => $_has(7);
  @$pb.TagNumber(9)
  void clearExpiryDate() => clearField(9);

  @$pb.TagNumber(10)
  $fixnum.Int64 get dailyLimit => $_getI64(8);
  @$pb.TagNumber(10)
  set dailyLimit($fixnum.Int64 v) { $_setInt64(8, v); }
  @$pb.TagNumber(10)
  $core.bool hasDailyLimit() => $_has(8);
  @$pb.TagNumber(10)
  void clearDailyLimit() => clearField(10);

  @$pb.TagNumber(11)
  $fixnum.Int64 get monthlyLimit => $_getI64(9);
  @$pb.TagNumber(11)
  set monthlyLimit($fixnum.Int64 v) { $_setInt64(9, v); }
  @$pb.TagNumber(11)
  $core.bool hasMonthlyLimit() => $_has(9);
  @$pb.TagNumber(11)
  void clearMonthlyLimit() => clearField(11);

  @$pb.TagNumber(12)
  $core.bool get enable3dSecure => $_getBF(10);
  @$pb.TagNumber(12)
  set enable3dSecure($core.bool v) { $_setBool(10, v); }
  @$pb.TagNumber(12)
  $core.bool hasEnable3dSecure() => $_has(10);
  @$pb.TagNumber(12)
  void clearEnable3dSecure() => clearField(12);

  @$pb.TagNumber(13)
  $core.bool get enableContactless => $_getBF(11);
  @$pb.TagNumber(13)
  set enableContactless($core.bool v) { $_setBool(11, v); }
  @$pb.TagNumber(13)
  $core.bool hasEnableContactless() => $_has(11);
  @$pb.TagNumber(13)
  void clearEnableContactless() => clearField(13);

  @$pb.TagNumber(14)
  $core.bool get enableOnlinePayments => $_getBF(12);
  @$pb.TagNumber(14)
  set enableOnlinePayments($core.bool v) { $_setBool(12, v); }
  @$pb.TagNumber(14)
  $core.bool hasEnableOnlinePayments() => $_has(12);
  @$pb.TagNumber(14)
  void clearEnableOnlinePayments() => clearField(14);

  @$pb.TagNumber(15)
  $core.String get accountNumber => $_getSZ(13);
  @$pb.TagNumber(15)
  set accountNumber($core.String v) { $_setString(13, v); }
  @$pb.TagNumber(15)
  $core.bool hasAccountNumber() => $_has(13);
  @$pb.TagNumber(15)
  void clearAccountNumber() => clearField(15);

  @$pb.TagNumber(16)
  $core.String get iban => $_getSZ(14);
  @$pb.TagNumber(16)
  set iban($core.String v) { $_setString(14, v); }
  @$pb.TagNumber(16)
  $core.bool hasIban() => $_has(14);
  @$pb.TagNumber(16)
  void clearIban() => clearField(16);

  @$pb.TagNumber(17)
  $core.String get bicSwift => $_getSZ(15);
  @$pb.TagNumber(17)
  set bicSwift($core.String v) { $_setString(15, v); }
  @$pb.TagNumber(17)
  $core.bool hasBicSwift() => $_has(15);
  @$pb.TagNumber(17)
  void clearBicSwift() => clearField(17);

  @$pb.TagNumber(18)
  $42.Timestamp get createdAt => $_getN(16);
  @$pb.TagNumber(18)
  set createdAt($42.Timestamp v) { setField(18, v); }
  @$pb.TagNumber(18)
  $core.bool hasCreatedAt() => $_has(16);
  @$pb.TagNumber(18)
  void clearCreatedAt() => clearField(18);
  @$pb.TagNumber(18)
  $42.Timestamp ensureCreatedAt() => $_ensure(16);

  @$pb.TagNumber(19)
  $42.Timestamp get updatedAt => $_getN(17);
  @$pb.TagNumber(19)
  set updatedAt($42.Timestamp v) { setField(19, v); }
  @$pb.TagNumber(19)
  $core.bool hasUpdatedAt() => $_has(17);
  @$pb.TagNumber(19)
  void clearUpdatedAt() => clearField(19);
  @$pb.TagNumber(19)
  $42.Timestamp ensureUpdatedAt() => $_ensure(17);
}

/// SecuritySettings: Used for updating security flags
class SecuritySettings extends $pb.GeneratedMessage {
  factory SecuritySettings({
    $core.bool? enable3dSecure,
    $core.bool? enableContactless,
    $core.bool? enableOnlinePayments,
  }) {
    final $result = create();
    if (enable3dSecure != null) {
      $result.enable3dSecure = enable3dSecure;
    }
    if (enableContactless != null) {
      $result.enableContactless = enableContactless;
    }
    if (enableOnlinePayments != null) {
      $result.enableOnlinePayments = enableOnlinePayments;
    }
    return $result;
  }
  SecuritySettings._() : super();
  factory SecuritySettings.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SecuritySettings.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SecuritySettings', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'enable3dSecure', protoName: 'enable_3d_secure')
    ..aOB(2, _omitFieldNames ? '' : 'enableContactless')
    ..aOB(3, _omitFieldNames ? '' : 'enableOnlinePayments')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SecuritySettings clone() => SecuritySettings()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SecuritySettings copyWith(void Function(SecuritySettings) updates) => super.copyWith((message) => updates(message as SecuritySettings)) as SecuritySettings;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SecuritySettings create() => SecuritySettings._();
  SecuritySettings createEmptyInstance() => create();
  static $pb.PbList<SecuritySettings> createRepeated() => $pb.PbList<SecuritySettings>();
  @$core.pragma('dart2js:noInline')
  static SecuritySettings getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SecuritySettings>(create);
  static SecuritySettings? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get enable3dSecure => $_getBF(0);
  @$pb.TagNumber(1)
  set enable3dSecure($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasEnable3dSecure() => $_has(0);
  @$pb.TagNumber(1)
  void clearEnable3dSecure() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get enableContactless => $_getBF(1);
  @$pb.TagNumber(2)
  set enableContactless($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasEnableContactless() => $_has(1);
  @$pb.TagNumber(2)
  void clearEnableContactless() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get enableOnlinePayments => $_getBF(2);
  @$pb.TagNumber(3)
  set enableOnlinePayments($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasEnableOnlinePayments() => $_has(2);
  @$pb.TagNumber(3)
  void clearEnableOnlinePayments() => clearField(3);
}

/// GetUserAccounts (Renamed from ListUserAccounts)
class GetUserAccountsRequest extends $pb.GeneratedMessage {
  factory GetUserAccountsRequest() => create();
  GetUserAccountsRequest._() : super();
  factory GetUserAccountsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUserAccountsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetUserAccountsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUserAccountsRequest clone() => GetUserAccountsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUserAccountsRequest copyWith(void Function(GetUserAccountsRequest) updates) => super.copyWith((message) => updates(message as GetUserAccountsRequest)) as GetUserAccountsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserAccountsRequest create() => GetUserAccountsRequest._();
  GetUserAccountsRequest createEmptyInstance() => create();
  static $pb.PbList<GetUserAccountsRequest> createRepeated() => $pb.PbList<GetUserAccountsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetUserAccountsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetUserAccountsRequest>(create);
  static GetUserAccountsRequest? _defaultInstance;
}

class GetUserAccountsResponse extends $pb.GeneratedMessage {
  factory GetUserAccountsResponse({
    $core.Iterable<AccountSummary>? accounts,
  }) {
    final $result = create();
    if (accounts != null) {
      $result.accounts.addAll(accounts);
    }
    return $result;
  }
  GetUserAccountsResponse._() : super();
  factory GetUserAccountsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUserAccountsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetUserAccountsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pc<AccountSummary>(1, _omitFieldNames ? '' : 'accounts', $pb.PbFieldType.PM, subBuilder: AccountSummary.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUserAccountsResponse clone() => GetUserAccountsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUserAccountsResponse copyWith(void Function(GetUserAccountsResponse) updates) => super.copyWith((message) => updates(message as GetUserAccountsResponse)) as GetUserAccountsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserAccountsResponse create() => GetUserAccountsResponse._();
  GetUserAccountsResponse createEmptyInstance() => create();
  static $pb.PbList<GetUserAccountsResponse> createRepeated() => $pb.PbList<GetUserAccountsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetUserAccountsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetUserAccountsResponse>(create);
  static GetUserAccountsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<AccountSummary> get accounts => $_getList(0);
}

/// GetAccountDetails
class GetAccountDetailsRequest extends $pb.GeneratedMessage {
  factory GetAccountDetailsRequest({
    $fixnum.Int64? accountId,
  }) {
    final $result = create();
    if (accountId != null) {
      $result.accountId = accountId;
    }
    return $result;
  }
  GetAccountDetailsRequest._() : super();
  factory GetAccountDetailsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAccountDetailsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetAccountDetailsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'accountId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAccountDetailsRequest clone() => GetAccountDetailsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAccountDetailsRequest copyWith(void Function(GetAccountDetailsRequest) updates) => super.copyWith((message) => updates(message as GetAccountDetailsRequest)) as GetAccountDetailsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAccountDetailsRequest create() => GetAccountDetailsRequest._();
  GetAccountDetailsRequest createEmptyInstance() => create();
  static $pb.PbList<GetAccountDetailsRequest> createRepeated() => $pb.PbList<GetAccountDetailsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetAccountDetailsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAccountDetailsRequest>(create);
  static GetAccountDetailsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get accountId => $_getI64(0);
  @$pb.TagNumber(1)
  set accountId($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => clearField(1);
}

class GetAccountDetailsResponse extends $pb.GeneratedMessage {
  factory GetAccountDetailsResponse({
    AccountDetails? account,
  }) {
    final $result = create();
    if (account != null) {
      $result.account = account;
    }
    return $result;
  }
  GetAccountDetailsResponse._() : super();
  factory GetAccountDetailsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAccountDetailsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetAccountDetailsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<AccountDetails>(1, _omitFieldNames ? '' : 'account', subBuilder: AccountDetails.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAccountDetailsResponse clone() => GetAccountDetailsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAccountDetailsResponse copyWith(void Function(GetAccountDetailsResponse) updates) => super.copyWith((message) => updates(message as GetAccountDetailsResponse)) as GetAccountDetailsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAccountDetailsResponse create() => GetAccountDetailsResponse._();
  GetAccountDetailsResponse createEmptyInstance() => create();
  static $pb.PbList<GetAccountDetailsResponse> createRepeated() => $pb.PbList<GetAccountDetailsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetAccountDetailsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAccountDetailsResponse>(create);
  static GetAccountDetailsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  AccountDetails get account => $_getN(0);
  @$pb.TagNumber(1)
  set account(AccountDetails v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccount() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccount() => clearField(1);
  @$pb.TagNumber(1)
  AccountDetails ensureAccount() => $_ensure(0);
}

/// UpdateAccountStatus
class UpdateAccountStatusRequest extends $pb.GeneratedMessage {
  factory UpdateAccountStatusRequest({
    $fixnum.Int64? accountId,
    $core.String? status,
    $core.String? reason,
  }) {
    final $result = create();
    if (accountId != null) {
      $result.accountId = accountId;
    }
    if (status != null) {
      $result.status = status;
    }
    if (reason != null) {
      $result.reason = reason;
    }
    return $result;
  }
  UpdateAccountStatusRequest._() : super();
  factory UpdateAccountStatusRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateAccountStatusRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateAccountStatusRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'accountId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(2, _omitFieldNames ? '' : 'status')
    ..aOS(3, _omitFieldNames ? '' : 'reason')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateAccountStatusRequest clone() => UpdateAccountStatusRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateAccountStatusRequest copyWith(void Function(UpdateAccountStatusRequest) updates) => super.copyWith((message) => updates(message as UpdateAccountStatusRequest)) as UpdateAccountStatusRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateAccountStatusRequest create() => UpdateAccountStatusRequest._();
  UpdateAccountStatusRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateAccountStatusRequest> createRepeated() => $pb.PbList<UpdateAccountStatusRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateAccountStatusRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateAccountStatusRequest>(create);
  static UpdateAccountStatusRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get accountId => $_getI64(0);
  @$pb.TagNumber(1)
  set accountId($fixnum.Int64 v) { $_setInt64(0, v); }
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

  @$pb.TagNumber(3)
  $core.String get reason => $_getSZ(2);
  @$pb.TagNumber(3)
  set reason($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasReason() => $_has(2);
  @$pb.TagNumber(3)
  void clearReason() => clearField(3);
}

class UpdateAccountStatusResponse extends $pb.GeneratedMessage {
  factory UpdateAccountStatusResponse({
    AccountDetails? account,
  }) {
    final $result = create();
    if (account != null) {
      $result.account = account;
    }
    return $result;
  }
  UpdateAccountStatusResponse._() : super();
  factory UpdateAccountStatusResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateAccountStatusResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateAccountStatusResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<AccountDetails>(1, _omitFieldNames ? '' : 'account', subBuilder: AccountDetails.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateAccountStatusResponse clone() => UpdateAccountStatusResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateAccountStatusResponse copyWith(void Function(UpdateAccountStatusResponse) updates) => super.copyWith((message) => updates(message as UpdateAccountStatusResponse)) as UpdateAccountStatusResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateAccountStatusResponse create() => UpdateAccountStatusResponse._();
  UpdateAccountStatusResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateAccountStatusResponse> createRepeated() => $pb.PbList<UpdateAccountStatusResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateAccountStatusResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateAccountStatusResponse>(create);
  static UpdateAccountStatusResponse? _defaultInstance;

  @$pb.TagNumber(1)
  AccountDetails get account => $_getN(0);
  @$pb.TagNumber(1)
  set account(AccountDetails v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccount() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccount() => clearField(1);
  @$pb.TagNumber(1)
  AccountDetails ensureAccount() => $_ensure(0);
}

/// UpdateSecuritySettings
class UpdateSecuritySettingsRequest extends $pb.GeneratedMessage {
  factory UpdateSecuritySettingsRequest({
    $fixnum.Int64? accountId,
    SecuritySettings? settings,
  }) {
    final $result = create();
    if (accountId != null) {
      $result.accountId = accountId;
    }
    if (settings != null) {
      $result.settings = settings;
    }
    return $result;
  }
  UpdateSecuritySettingsRequest._() : super();
  factory UpdateSecuritySettingsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateSecuritySettingsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateSecuritySettingsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'accountId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<SecuritySettings>(2, _omitFieldNames ? '' : 'settings', subBuilder: SecuritySettings.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateSecuritySettingsRequest clone() => UpdateSecuritySettingsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateSecuritySettingsRequest copyWith(void Function(UpdateSecuritySettingsRequest) updates) => super.copyWith((message) => updates(message as UpdateSecuritySettingsRequest)) as UpdateSecuritySettingsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateSecuritySettingsRequest create() => UpdateSecuritySettingsRequest._();
  UpdateSecuritySettingsRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateSecuritySettingsRequest> createRepeated() => $pb.PbList<UpdateSecuritySettingsRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateSecuritySettingsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateSecuritySettingsRequest>(create);
  static UpdateSecuritySettingsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get accountId => $_getI64(0);
  @$pb.TagNumber(1)
  set accountId($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => clearField(1);

  @$pb.TagNumber(2)
  SecuritySettings get settings => $_getN(1);
  @$pb.TagNumber(2)
  set settings(SecuritySettings v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasSettings() => $_has(1);
  @$pb.TagNumber(2)
  void clearSettings() => clearField(2);
  @$pb.TagNumber(2)
  SecuritySettings ensureSettings() => $_ensure(1);
}

class UpdateSecuritySettingsResponse extends $pb.GeneratedMessage {
  factory UpdateSecuritySettingsResponse({
    AccountDetails? account,
  }) {
    final $result = create();
    if (account != null) {
      $result.account = account;
    }
    return $result;
  }
  UpdateSecuritySettingsResponse._() : super();
  factory UpdateSecuritySettingsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateSecuritySettingsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateSecuritySettingsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<AccountDetails>(1, _omitFieldNames ? '' : 'account', subBuilder: AccountDetails.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateSecuritySettingsResponse clone() => UpdateSecuritySettingsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateSecuritySettingsResponse copyWith(void Function(UpdateSecuritySettingsResponse) updates) => super.copyWith((message) => updates(message as UpdateSecuritySettingsResponse)) as UpdateSecuritySettingsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateSecuritySettingsResponse create() => UpdateSecuritySettingsResponse._();
  UpdateSecuritySettingsResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateSecuritySettingsResponse> createRepeated() => $pb.PbList<UpdateSecuritySettingsResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateSecuritySettingsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateSecuritySettingsResponse>(create);
  static UpdateSecuritySettingsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  AccountDetails get account => $_getN(0);
  @$pb.TagNumber(1)
  set account(AccountDetails v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccount() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccount() => clearField(1);
  @$pb.TagNumber(1)
  AccountDetails ensureAccount() => $_ensure(0);
}

/// RevealPIN (Placeholder - requires security review)
class RevealPINRequest extends $pb.GeneratedMessage {
  factory RevealPINRequest({
    $fixnum.Int64? accountId,
  }) {
    final $result = create();
    if (accountId != null) {
      $result.accountId = accountId;
    }
    return $result;
  }
  RevealPINRequest._() : super();
  factory RevealPINRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RevealPINRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RevealPINRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'accountId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RevealPINRequest clone() => RevealPINRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RevealPINRequest copyWith(void Function(RevealPINRequest) updates) => super.copyWith((message) => updates(message as RevealPINRequest)) as RevealPINRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RevealPINRequest create() => RevealPINRequest._();
  RevealPINRequest createEmptyInstance() => create();
  static $pb.PbList<RevealPINRequest> createRepeated() => $pb.PbList<RevealPINRequest>();
  @$core.pragma('dart2js:noInline')
  static RevealPINRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RevealPINRequest>(create);
  static RevealPINRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get accountId => $_getI64(0);
  @$pb.TagNumber(1)
  set accountId($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => clearField(1);
}

class RevealPINResponse extends $pb.GeneratedMessage {
  factory RevealPINResponse({
    $core.String? pin,
  }) {
    final $result = create();
    if (pin != null) {
      $result.pin = pin;
    }
    return $result;
  }
  RevealPINResponse._() : super();
  factory RevealPINResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RevealPINResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RevealPINResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'pin')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RevealPINResponse clone() => RevealPINResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RevealPINResponse copyWith(void Function(RevealPINResponse) updates) => super.copyWith((message) => updates(message as RevealPINResponse)) as RevealPINResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RevealPINResponse create() => RevealPINResponse._();
  RevealPINResponse createEmptyInstance() => create();
  static $pb.PbList<RevealPINResponse> createRepeated() => $pb.PbList<RevealPINResponse>();
  @$core.pragma('dart2js:noInline')
  static RevealPINResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RevealPINResponse>(create);
  static RevealPINResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get pin => $_getSZ(0);
  @$pb.TagNumber(1)
  set pin($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPin() => $_has(0);
  @$pb.TagNumber(1)
  void clearPin() => clearField(1);
}

/// CreateSignupAccountsRequest: Request to create multiple accounts during signup (Nigeria only)
class CreateSignupAccountsRequest extends $pb.GeneratedMessage {
  factory CreateSignupAccountsRequest({
    $core.String? userId,
    $core.String? firstName,
    $core.String? lastName,
    $core.String? email,
    $core.String? phoneNumber,
    $core.String? countryCode,
    $core.String? bvn,
  }) {
    final $result = create();
    if (userId != null) {
      $result.userId = userId;
    }
    if (firstName != null) {
      $result.firstName = firstName;
    }
    if (lastName != null) {
      $result.lastName = lastName;
    }
    if (email != null) {
      $result.email = email;
    }
    if (phoneNumber != null) {
      $result.phoneNumber = phoneNumber;
    }
    if (countryCode != null) {
      $result.countryCode = countryCode;
    }
    if (bvn != null) {
      $result.bvn = bvn;
    }
    return $result;
  }
  CreateSignupAccountsRequest._() : super();
  factory CreateSignupAccountsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateSignupAccountsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateSignupAccountsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'firstName')
    ..aOS(3, _omitFieldNames ? '' : 'lastName')
    ..aOS(4, _omitFieldNames ? '' : 'email')
    ..aOS(5, _omitFieldNames ? '' : 'phoneNumber')
    ..aOS(6, _omitFieldNames ? '' : 'countryCode')
    ..aOS(7, _omitFieldNames ? '' : 'bvn')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateSignupAccountsRequest clone() => CreateSignupAccountsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateSignupAccountsRequest copyWith(void Function(CreateSignupAccountsRequest) updates) => super.copyWith((message) => updates(message as CreateSignupAccountsRequest)) as CreateSignupAccountsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateSignupAccountsRequest create() => CreateSignupAccountsRequest._();
  CreateSignupAccountsRequest createEmptyInstance() => create();
  static $pb.PbList<CreateSignupAccountsRequest> createRepeated() => $pb.PbList<CreateSignupAccountsRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateSignupAccountsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateSignupAccountsRequest>(create);
  static CreateSignupAccountsRequest? _defaultInstance;

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
  $core.String get countryCode => $_getSZ(5);
  @$pb.TagNumber(6)
  set countryCode($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasCountryCode() => $_has(5);
  @$pb.TagNumber(6)
  void clearCountryCode() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get bvn => $_getSZ(6);
  @$pb.TagNumber(7)
  set bvn($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasBvn() => $_has(6);
  @$pb.TagNumber(7)
  void clearBvn() => clearField(7);
}

/// SignupAccountInfo: Information about a created account
class SignupAccountInfo extends $pb.GeneratedMessage {
  factory SignupAccountInfo({
    $core.String? accountId,
    $core.String? accountNumber,
    $core.String? accountName,
    $core.String? accountType,
    $core.String? accountLabel,
    $core.String? bankName,
    $core.String? bankCode,
    $core.String? currency,
    $core.bool? isPrimary,
  }) {
    final $result = create();
    if (accountId != null) {
      $result.accountId = accountId;
    }
    if (accountNumber != null) {
      $result.accountNumber = accountNumber;
    }
    if (accountName != null) {
      $result.accountName = accountName;
    }
    if (accountType != null) {
      $result.accountType = accountType;
    }
    if (accountLabel != null) {
      $result.accountLabel = accountLabel;
    }
    if (bankName != null) {
      $result.bankName = bankName;
    }
    if (bankCode != null) {
      $result.bankCode = bankCode;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (isPrimary != null) {
      $result.isPrimary = isPrimary;
    }
    return $result;
  }
  SignupAccountInfo._() : super();
  factory SignupAccountInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SignupAccountInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SignupAccountInfo', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountId')
    ..aOS(2, _omitFieldNames ? '' : 'accountNumber')
    ..aOS(3, _omitFieldNames ? '' : 'accountName')
    ..aOS(4, _omitFieldNames ? '' : 'accountType')
    ..aOS(5, _omitFieldNames ? '' : 'accountLabel')
    ..aOS(6, _omitFieldNames ? '' : 'bankName')
    ..aOS(7, _omitFieldNames ? '' : 'bankCode')
    ..aOS(8, _omitFieldNames ? '' : 'currency')
    ..aOB(9, _omitFieldNames ? '' : 'isPrimary')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SignupAccountInfo clone() => SignupAccountInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SignupAccountInfo copyWith(void Function(SignupAccountInfo) updates) => super.copyWith((message) => updates(message as SignupAccountInfo)) as SignupAccountInfo;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SignupAccountInfo create() => SignupAccountInfo._();
  SignupAccountInfo createEmptyInstance() => create();
  static $pb.PbList<SignupAccountInfo> createRepeated() => $pb.PbList<SignupAccountInfo>();
  @$core.pragma('dart2js:noInline')
  static SignupAccountInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SignupAccountInfo>(create);
  static SignupAccountInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get accountNumber => $_getSZ(1);
  @$pb.TagNumber(2)
  set accountNumber($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAccountNumber() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccountNumber() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get accountName => $_getSZ(2);
  @$pb.TagNumber(3)
  set accountName($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAccountName() => $_has(2);
  @$pb.TagNumber(3)
  void clearAccountName() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get accountType => $_getSZ(3);
  @$pb.TagNumber(4)
  set accountType($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasAccountType() => $_has(3);
  @$pb.TagNumber(4)
  void clearAccountType() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get accountLabel => $_getSZ(4);
  @$pb.TagNumber(5)
  set accountLabel($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasAccountLabel() => $_has(4);
  @$pb.TagNumber(5)
  void clearAccountLabel() => clearField(5);

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
  $core.String get currency => $_getSZ(7);
  @$pb.TagNumber(8)
  set currency($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasCurrency() => $_has(7);
  @$pb.TagNumber(8)
  void clearCurrency() => clearField(8);

  @$pb.TagNumber(9)
  $core.bool get isPrimary => $_getBF(8);
  @$pb.TagNumber(9)
  set isPrimary($core.bool v) { $_setBool(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasIsPrimary() => $_has(8);
  @$pb.TagNumber(9)
  void clearIsPrimary() => clearField(9);
}

/// CreateSignupAccountsResponse: Response after creating signup accounts
class CreateSignupAccountsResponse extends $pb.GeneratedMessage {
  factory CreateSignupAccountsResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
    $core.Iterable<SignupAccountInfo>? accounts,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (errorCode != null) {
      $result.errorCode = errorCode;
    }
    if (errorMessage != null) {
      $result.errorMessage = errorMessage;
    }
    if (accounts != null) {
      $result.accounts.addAll(accounts);
    }
    return $result;
  }
  CreateSignupAccountsResponse._() : super();
  factory CreateSignupAccountsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateSignupAccountsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateSignupAccountsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'errorCode')
    ..aOS(3, _omitFieldNames ? '' : 'errorMessage')
    ..pc<SignupAccountInfo>(4, _omitFieldNames ? '' : 'accounts', $pb.PbFieldType.PM, subBuilder: SignupAccountInfo.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateSignupAccountsResponse clone() => CreateSignupAccountsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateSignupAccountsResponse copyWith(void Function(CreateSignupAccountsResponse) updates) => super.copyWith((message) => updates(message as CreateSignupAccountsResponse)) as CreateSignupAccountsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateSignupAccountsResponse create() => CreateSignupAccountsResponse._();
  CreateSignupAccountsResponse createEmptyInstance() => create();
  static $pb.PbList<CreateSignupAccountsResponse> createRepeated() => $pb.PbList<CreateSignupAccountsResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateSignupAccountsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateSignupAccountsResponse>(create);
  static CreateSignupAccountsResponse? _defaultInstance;

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
  $core.List<SignupAccountInfo> get accounts => $_getList(3);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
