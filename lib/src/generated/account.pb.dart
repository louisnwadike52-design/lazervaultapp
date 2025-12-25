///
//  Generated code. Do not modify.
//  source: account.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/timestamp.pb.dart' as $28;

class Account extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Account', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountType')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'balance', $pb.PbFieldType.OD)
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountNumber')
    ..aOB(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isActive')
    ..aOM<$28.Timestamp>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $28.Timestamp.create)
    ..aOM<$28.Timestamp>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedAt', subBuilder: $28.Timestamp.create)
    ..hasRequiredFields = false
  ;

  Account._() : super();
  factory Account({
    $fixnum.Int64? id,
    $core.String? accountType,
    $core.String? currency,
    $core.double? balance,
    $core.String? accountNumber,
    $core.bool? isActive,
    $28.Timestamp? createdAt,
    $28.Timestamp? updatedAt,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (accountType != null) {
      _result.accountType = accountType;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (balance != null) {
      _result.balance = balance;
    }
    if (accountNumber != null) {
      _result.accountNumber = accountNumber;
    }
    if (isActive != null) {
      _result.isActive = isActive;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      _result.updatedAt = updatedAt;
    }
    return _result;
  }
  factory Account.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Account.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Account clone() => Account()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Account copyWith(void Function(Account) updates) => super.copyWith((message) => updates(message as Account)) as Account; // ignore: deprecated_member_use
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
  $28.Timestamp get createdAt => $_getN(6);
  @$pb.TagNumber(7)
  set createdAt($28.Timestamp v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasCreatedAt() => $_has(6);
  @$pb.TagNumber(7)
  void clearCreatedAt() => clearField(7);
  @$pb.TagNumber(7)
  $28.Timestamp ensureCreatedAt() => $_ensure(6);

  @$pb.TagNumber(8)
  $28.Timestamp get updatedAt => $_getN(7);
  @$pb.TagNumber(8)
  set updatedAt($28.Timestamp v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasUpdatedAt() => $_has(7);
  @$pb.TagNumber(8)
  void clearUpdatedAt() => clearField(8);
  @$pb.TagNumber(8)
  $28.Timestamp ensureUpdatedAt() => $_ensure(7);
}

class CreateAccountRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateAccountRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'account_type')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pin')
    ..hasRequiredFields = false
  ;

  CreateAccountRequest._() : super();
  factory CreateAccountRequest({
    $core.String? accountType,
    $core.String? currency,
    $core.String? pin,
  }) {
    final _result = create();
    if (accountType != null) {
      _result.accountType = accountType;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (pin != null) {
      _result.pin = pin;
    }
    return _result;
  }
  factory CreateAccountRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateAccountRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateAccountRequest clone() => CreateAccountRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateAccountRequest copyWith(void Function(CreateAccountRequest) updates) => super.copyWith((message) => updates(message as CreateAccountRequest)) as CreateAccountRequest; // ignore: deprecated_member_use
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

class CreateAccountResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateAccountResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<AccountDetails>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'account', subBuilder: AccountDetails.create)
    ..hasRequiredFields = false
  ;

  CreateAccountResponse._() : super();
  factory CreateAccountResponse({
    AccountDetails? account,
  }) {
    final _result = create();
    if (account != null) {
      _result.account = account;
    }
    return _result;
  }
  factory CreateAccountResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateAccountResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateAccountResponse clone() => CreateAccountResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateAccountResponse copyWith(void Function(CreateAccountResponse) updates) => super.copyWith((message) => updates(message as CreateAccountResponse)) as CreateAccountResponse; // ignore: deprecated_member_use
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

class GetAccountsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetAccountsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GetAccountsRequest._() : super();
  factory GetAccountsRequest() => create();
  factory GetAccountsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAccountsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAccountsRequest clone() => GetAccountsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAccountsRequest copyWith(void Function(GetAccountsRequest) updates) => super.copyWith((message) => updates(message as GetAccountsRequest)) as GetAccountsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetAccountsRequest create() => GetAccountsRequest._();
  GetAccountsRequest createEmptyInstance() => create();
  static $pb.PbList<GetAccountsRequest> createRepeated() => $pb.PbList<GetAccountsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetAccountsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAccountsRequest>(create);
  static GetAccountsRequest? _defaultInstance;
}

class GetAccountsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetAccountsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<Account>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accounts', $pb.PbFieldType.PM, subBuilder: Account.create)
    ..hasRequiredFields = false
  ;

  GetAccountsResponse._() : super();
  factory GetAccountsResponse({
    $core.Iterable<Account>? accounts,
  }) {
    final _result = create();
    if (accounts != null) {
      _result.accounts.addAll(accounts);
    }
    return _result;
  }
  factory GetAccountsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAccountsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAccountsResponse clone() => GetAccountsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAccountsResponse copyWith(void Function(GetAccountsResponse) updates) => super.copyWith((message) => updates(message as GetAccountsResponse)) as GetAccountsResponse; // ignore: deprecated_member_use
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

class AccountSummary extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AccountSummary', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountType')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..a<$fixnum.Int64>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'balance', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'maskedAccountNumber')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..hasRequiredFields = false
  ;

  AccountSummary._() : super();
  factory AccountSummary({
    $fixnum.Int64? id,
    $core.String? accountType,
    $core.String? currency,
    $fixnum.Int64? balance,
    $core.String? maskedAccountNumber,
    $core.String? status,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (accountType != null) {
      _result.accountType = accountType;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (balance != null) {
      _result.balance = balance;
    }
    if (maskedAccountNumber != null) {
      _result.maskedAccountNumber = maskedAccountNumber;
    }
    if (status != null) {
      _result.status = status;
    }
    return _result;
  }
  factory AccountSummary.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AccountSummary.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AccountSummary clone() => AccountSummary()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AccountSummary copyWith(void Function(AccountSummary) updates) => super.copyWith((message) => updates(message as AccountSummary)) as AccountSummary; // ignore: deprecated_member_use
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
}

class AccountDetails extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AccountDetails', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountType')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..a<$fixnum.Int64>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'balance', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cardHolderName')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cardType')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'expiryDate')
    ..a<$fixnum.Int64>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dailyLimit', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'monthlyLimit', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOB(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'enable3dSecure', protoName: 'enable_3d_secure')
    ..aOB(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'enableContactless')
    ..aOB(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'enableOnlinePayments')
    ..aOS(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountNumber')
    ..aOS(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'iban')
    ..aOS(17, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bicSwift')
    ..aOM<$28.Timestamp>(18, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $28.Timestamp.create)
    ..aOM<$28.Timestamp>(19, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedAt', subBuilder: $28.Timestamp.create)
    ..hasRequiredFields = false
  ;

  AccountDetails._() : super();
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
    $28.Timestamp? createdAt,
    $28.Timestamp? updatedAt,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (accountType != null) {
      _result.accountType = accountType;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (balance != null) {
      _result.balance = balance;
    }
    if (status != null) {
      _result.status = status;
    }
    if (cardHolderName != null) {
      _result.cardHolderName = cardHolderName;
    }
    if (cardType != null) {
      _result.cardType = cardType;
    }
    if (expiryDate != null) {
      _result.expiryDate = expiryDate;
    }
    if (dailyLimit != null) {
      _result.dailyLimit = dailyLimit;
    }
    if (monthlyLimit != null) {
      _result.monthlyLimit = monthlyLimit;
    }
    if (enable3dSecure != null) {
      _result.enable3dSecure = enable3dSecure;
    }
    if (enableContactless != null) {
      _result.enableContactless = enableContactless;
    }
    if (enableOnlinePayments != null) {
      _result.enableOnlinePayments = enableOnlinePayments;
    }
    if (accountNumber != null) {
      _result.accountNumber = accountNumber;
    }
    if (iban != null) {
      _result.iban = iban;
    }
    if (bicSwift != null) {
      _result.bicSwift = bicSwift;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      _result.updatedAt = updatedAt;
    }
    return _result;
  }
  factory AccountDetails.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AccountDetails.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AccountDetails clone() => AccountDetails()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AccountDetails copyWith(void Function(AccountDetails) updates) => super.copyWith((message) => updates(message as AccountDetails)) as AccountDetails; // ignore: deprecated_member_use
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
  $28.Timestamp get createdAt => $_getN(16);
  @$pb.TagNumber(18)
  set createdAt($28.Timestamp v) { setField(18, v); }
  @$pb.TagNumber(18)
  $core.bool hasCreatedAt() => $_has(16);
  @$pb.TagNumber(18)
  void clearCreatedAt() => clearField(18);
  @$pb.TagNumber(18)
  $28.Timestamp ensureCreatedAt() => $_ensure(16);

  @$pb.TagNumber(19)
  $28.Timestamp get updatedAt => $_getN(17);
  @$pb.TagNumber(19)
  set updatedAt($28.Timestamp v) { setField(19, v); }
  @$pb.TagNumber(19)
  $core.bool hasUpdatedAt() => $_has(17);
  @$pb.TagNumber(19)
  void clearUpdatedAt() => clearField(19);
  @$pb.TagNumber(19)
  $28.Timestamp ensureUpdatedAt() => $_ensure(17);
}

class SecuritySettings extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SecuritySettings', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'enable3dSecure', protoName: 'enable_3d_secure')
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'enableContactless')
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'enableOnlinePayments')
    ..hasRequiredFields = false
  ;

  SecuritySettings._() : super();
  factory SecuritySettings({
    $core.bool? enable3dSecure,
    $core.bool? enableContactless,
    $core.bool? enableOnlinePayments,
  }) {
    final _result = create();
    if (enable3dSecure != null) {
      _result.enable3dSecure = enable3dSecure;
    }
    if (enableContactless != null) {
      _result.enableContactless = enableContactless;
    }
    if (enableOnlinePayments != null) {
      _result.enableOnlinePayments = enableOnlinePayments;
    }
    return _result;
  }
  factory SecuritySettings.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SecuritySettings.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SecuritySettings clone() => SecuritySettings()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SecuritySettings copyWith(void Function(SecuritySettings) updates) => super.copyWith((message) => updates(message as SecuritySettings)) as SecuritySettings; // ignore: deprecated_member_use
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

class GetUserAccountsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetUserAccountsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GetUserAccountsRequest._() : super();
  factory GetUserAccountsRequest() => create();
  factory GetUserAccountsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUserAccountsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUserAccountsRequest clone() => GetUserAccountsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUserAccountsRequest copyWith(void Function(GetUserAccountsRequest) updates) => super.copyWith((message) => updates(message as GetUserAccountsRequest)) as GetUserAccountsRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetUserAccountsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<AccountSummary>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accounts', $pb.PbFieldType.PM, subBuilder: AccountSummary.create)
    ..hasRequiredFields = false
  ;

  GetUserAccountsResponse._() : super();
  factory GetUserAccountsResponse({
    $core.Iterable<AccountSummary>? accounts,
  }) {
    final _result = create();
    if (accounts != null) {
      _result.accounts.addAll(accounts);
    }
    return _result;
  }
  factory GetUserAccountsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUserAccountsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUserAccountsResponse clone() => GetUserAccountsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUserAccountsResponse copyWith(void Function(GetUserAccountsResponse) updates) => super.copyWith((message) => updates(message as GetUserAccountsResponse)) as GetUserAccountsResponse; // ignore: deprecated_member_use
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

class GetAccountDetailsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetAccountDetailsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  GetAccountDetailsRequest._() : super();
  factory GetAccountDetailsRequest({
    $fixnum.Int64? accountId,
  }) {
    final _result = create();
    if (accountId != null) {
      _result.accountId = accountId;
    }
    return _result;
  }
  factory GetAccountDetailsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAccountDetailsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAccountDetailsRequest clone() => GetAccountDetailsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAccountDetailsRequest copyWith(void Function(GetAccountDetailsRequest) updates) => super.copyWith((message) => updates(message as GetAccountDetailsRequest)) as GetAccountDetailsRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetAccountDetailsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<AccountDetails>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'account', subBuilder: AccountDetails.create)
    ..hasRequiredFields = false
  ;

  GetAccountDetailsResponse._() : super();
  factory GetAccountDetailsResponse({
    AccountDetails? account,
  }) {
    final _result = create();
    if (account != null) {
      _result.account = account;
    }
    return _result;
  }
  factory GetAccountDetailsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAccountDetailsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAccountDetailsResponse clone() => GetAccountDetailsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAccountDetailsResponse copyWith(void Function(GetAccountDetailsResponse) updates) => super.copyWith((message) => updates(message as GetAccountDetailsResponse)) as GetAccountDetailsResponse; // ignore: deprecated_member_use
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

class UpdateAccountStatusRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateAccountStatusRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reason')
    ..hasRequiredFields = false
  ;

  UpdateAccountStatusRequest._() : super();
  factory UpdateAccountStatusRequest({
    $fixnum.Int64? accountId,
    $core.String? status,
    $core.String? reason,
  }) {
    final _result = create();
    if (accountId != null) {
      _result.accountId = accountId;
    }
    if (status != null) {
      _result.status = status;
    }
    if (reason != null) {
      _result.reason = reason;
    }
    return _result;
  }
  factory UpdateAccountStatusRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateAccountStatusRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateAccountStatusRequest clone() => UpdateAccountStatusRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateAccountStatusRequest copyWith(void Function(UpdateAccountStatusRequest) updates) => super.copyWith((message) => updates(message as UpdateAccountStatusRequest)) as UpdateAccountStatusRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateAccountStatusResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<AccountDetails>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'account', subBuilder: AccountDetails.create)
    ..hasRequiredFields = false
  ;

  UpdateAccountStatusResponse._() : super();
  factory UpdateAccountStatusResponse({
    AccountDetails? account,
  }) {
    final _result = create();
    if (account != null) {
      _result.account = account;
    }
    return _result;
  }
  factory UpdateAccountStatusResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateAccountStatusResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateAccountStatusResponse clone() => UpdateAccountStatusResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateAccountStatusResponse copyWith(void Function(UpdateAccountStatusResponse) updates) => super.copyWith((message) => updates(message as UpdateAccountStatusResponse)) as UpdateAccountStatusResponse; // ignore: deprecated_member_use
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

class UpdateSecuritySettingsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateSecuritySettingsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<SecuritySettings>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'settings', subBuilder: SecuritySettings.create)
    ..hasRequiredFields = false
  ;

  UpdateSecuritySettingsRequest._() : super();
  factory UpdateSecuritySettingsRequest({
    $fixnum.Int64? accountId,
    SecuritySettings? settings,
  }) {
    final _result = create();
    if (accountId != null) {
      _result.accountId = accountId;
    }
    if (settings != null) {
      _result.settings = settings;
    }
    return _result;
  }
  factory UpdateSecuritySettingsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateSecuritySettingsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateSecuritySettingsRequest clone() => UpdateSecuritySettingsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateSecuritySettingsRequest copyWith(void Function(UpdateSecuritySettingsRequest) updates) => super.copyWith((message) => updates(message as UpdateSecuritySettingsRequest)) as UpdateSecuritySettingsRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateSecuritySettingsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<AccountDetails>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'account', subBuilder: AccountDetails.create)
    ..hasRequiredFields = false
  ;

  UpdateSecuritySettingsResponse._() : super();
  factory UpdateSecuritySettingsResponse({
    AccountDetails? account,
  }) {
    final _result = create();
    if (account != null) {
      _result.account = account;
    }
    return _result;
  }
  factory UpdateSecuritySettingsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateSecuritySettingsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateSecuritySettingsResponse clone() => UpdateSecuritySettingsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateSecuritySettingsResponse copyWith(void Function(UpdateSecuritySettingsResponse) updates) => super.copyWith((message) => updates(message as UpdateSecuritySettingsResponse)) as UpdateSecuritySettingsResponse; // ignore: deprecated_member_use
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

class RevealPINRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RevealPINRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  RevealPINRequest._() : super();
  factory RevealPINRequest({
    $fixnum.Int64? accountId,
  }) {
    final _result = create();
    if (accountId != null) {
      _result.accountId = accountId;
    }
    return _result;
  }
  factory RevealPINRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RevealPINRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RevealPINRequest clone() => RevealPINRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RevealPINRequest copyWith(void Function(RevealPINRequest) updates) => super.copyWith((message) => updates(message as RevealPINRequest)) as RevealPINRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RevealPINResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pin')
    ..hasRequiredFields = false
  ;

  RevealPINResponse._() : super();
  factory RevealPINResponse({
    $core.String? pin,
  }) {
    final _result = create();
    if (pin != null) {
      _result.pin = pin;
    }
    return _result;
  }
  factory RevealPINResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RevealPINResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RevealPINResponse clone() => RevealPINResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RevealPINResponse copyWith(void Function(RevealPINResponse) updates) => super.copyWith((message) => updates(message as RevealPINResponse)) as RevealPINResponse; // ignore: deprecated_member_use
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

