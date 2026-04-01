///
//  Generated code. Do not modify.
//  source: multi_country.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'accounts.pb.dart' as $0;
import 'google/protobuf/timestamp.pb.dart' as $4;

class LocaleAccountGroup extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'LocaleAccountGroup', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'locale')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'countryCode')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'countryName')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currencyCode')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currencySymbol')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'flagEmoji')
    ..pc<$0.Account>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accounts', $pb.PbFieldType.PM, subBuilder: $0.Account.create)
    ..a<$core.double>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalBalance', $pb.PbFieldType.OD)
    ..aOB(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hasAccounts')
    ..aOB(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isSignupLocale')
    ..hasRequiredFields = false
  ;

  LocaleAccountGroup._() : super();
  factory LocaleAccountGroup({
    $core.String? locale,
    $core.String? countryCode,
    $core.String? countryName,
    $core.String? currencyCode,
    $core.String? currencySymbol,
    $core.String? flagEmoji,
    $core.Iterable<$0.Account>? accounts,
    $core.double? totalBalance,
    $core.bool? hasAccounts,
    $core.bool? isSignupLocale,
  }) {
    final _result = create();
    if (locale != null) {
      _result.locale = locale;
    }
    if (countryCode != null) {
      _result.countryCode = countryCode;
    }
    if (countryName != null) {
      _result.countryName = countryName;
    }
    if (currencyCode != null) {
      _result.currencyCode = currencyCode;
    }
    if (currencySymbol != null) {
      _result.currencySymbol = currencySymbol;
    }
    if (flagEmoji != null) {
      _result.flagEmoji = flagEmoji;
    }
    if (accounts != null) {
      _result.accounts.addAll(accounts);
    }
    if (totalBalance != null) {
      _result.totalBalance = totalBalance;
    }
    if (hasAccounts != null) {
      _result.hasAccounts = hasAccounts;
    }
    if (isSignupLocale != null) {
      _result.isSignupLocale = isSignupLocale;
    }
    return _result;
  }
  factory LocaleAccountGroup.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LocaleAccountGroup.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LocaleAccountGroup clone() => LocaleAccountGroup()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LocaleAccountGroup copyWith(void Function(LocaleAccountGroup) updates) => super.copyWith((message) => updates(message as LocaleAccountGroup)) as LocaleAccountGroup; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static LocaleAccountGroup create() => LocaleAccountGroup._();
  LocaleAccountGroup createEmptyInstance() => create();
  static $pb.PbList<LocaleAccountGroup> createRepeated() => $pb.PbList<LocaleAccountGroup>();
  @$core.pragma('dart2js:noInline')
  static LocaleAccountGroup getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LocaleAccountGroup>(create);
  static LocaleAccountGroup? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get locale => $_getSZ(0);
  @$pb.TagNumber(1)
  set locale($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLocale() => $_has(0);
  @$pb.TagNumber(1)
  void clearLocale() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get countryCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set countryCode($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCountryCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearCountryCode() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get countryName => $_getSZ(2);
  @$pb.TagNumber(3)
  set countryName($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCountryName() => $_has(2);
  @$pb.TagNumber(3)
  void clearCountryName() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get currencyCode => $_getSZ(3);
  @$pb.TagNumber(4)
  set currencyCode($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCurrencyCode() => $_has(3);
  @$pb.TagNumber(4)
  void clearCurrencyCode() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get currencySymbol => $_getSZ(4);
  @$pb.TagNumber(5)
  set currencySymbol($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasCurrencySymbol() => $_has(4);
  @$pb.TagNumber(5)
  void clearCurrencySymbol() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get flagEmoji => $_getSZ(5);
  @$pb.TagNumber(6)
  set flagEmoji($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasFlagEmoji() => $_has(5);
  @$pb.TagNumber(6)
  void clearFlagEmoji() => clearField(6);

  @$pb.TagNumber(7)
  $core.List<$0.Account> get accounts => $_getList(6);

  @$pb.TagNumber(8)
  $core.double get totalBalance => $_getN(7);
  @$pb.TagNumber(8)
  set totalBalance($core.double v) { $_setDouble(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasTotalBalance() => $_has(7);
  @$pb.TagNumber(8)
  void clearTotalBalance() => clearField(8);

  @$pb.TagNumber(9)
  $core.bool get hasAccounts => $_getBF(8);
  @$pb.TagNumber(9)
  set hasAccounts($core.bool v) { $_setBool(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasHasAccounts() => $_has(8);
  @$pb.TagNumber(9)
  void clearHasAccounts() => clearField(9);

  @$pb.TagNumber(10)
  $core.bool get isSignupLocale => $_getBF(9);
  @$pb.TagNumber(10)
  set isSignupLocale($core.bool v) { $_setBool(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasIsSignupLocale() => $_has(9);
  @$pb.TagNumber(10)
  void clearIsSignupLocale() => clearField(10);
}

class GetAccountsByLocaleRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetAccountsByLocaleRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..hasRequiredFields = false
  ;

  GetAccountsByLocaleRequest._() : super();
  factory GetAccountsByLocaleRequest({
    $core.String? status,
  }) {
    final _result = create();
    if (status != null) {
      _result.status = status;
    }
    return _result;
  }
  factory GetAccountsByLocaleRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAccountsByLocaleRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAccountsByLocaleRequest clone() => GetAccountsByLocaleRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAccountsByLocaleRequest copyWith(void Function(GetAccountsByLocaleRequest) updates) => super.copyWith((message) => updates(message as GetAccountsByLocaleRequest)) as GetAccountsByLocaleRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetAccountsByLocaleRequest create() => GetAccountsByLocaleRequest._();
  GetAccountsByLocaleRequest createEmptyInstance() => create();
  static $pb.PbList<GetAccountsByLocaleRequest> createRepeated() => $pb.PbList<GetAccountsByLocaleRequest>();
  @$core.pragma('dart2js:noInline')
  static GetAccountsByLocaleRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAccountsByLocaleRequest>(create);
  static GetAccountsByLocaleRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get status => $_getSZ(0);
  @$pb.TagNumber(1)
  set status($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => clearField(1);
}

class GetAccountsByLocaleResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetAccountsByLocaleResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'accounts'), createEmptyInstance: create)
    ..pc<LocaleAccountGroup>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'locales', $pb.PbFieldType.PM, subBuilder: LocaleAccountGroup.create)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'activeLocale')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'signupLocale')
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalLocales', $pb.PbFieldType.O3)
    ..a<$core.int>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'localesWithAccounts', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetAccountsByLocaleResponse._() : super();
  factory GetAccountsByLocaleResponse({
    $core.Iterable<LocaleAccountGroup>? locales,
    $core.String? activeLocale,
    $core.String? signupLocale,
    $core.int? totalLocales,
    $core.int? localesWithAccounts,
  }) {
    final _result = create();
    if (locales != null) {
      _result.locales.addAll(locales);
    }
    if (activeLocale != null) {
      _result.activeLocale = activeLocale;
    }
    if (signupLocale != null) {
      _result.signupLocale = signupLocale;
    }
    if (totalLocales != null) {
      _result.totalLocales = totalLocales;
    }
    if (localesWithAccounts != null) {
      _result.localesWithAccounts = localesWithAccounts;
    }
    return _result;
  }
  factory GetAccountsByLocaleResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAccountsByLocaleResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAccountsByLocaleResponse clone() => GetAccountsByLocaleResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAccountsByLocaleResponse copyWith(void Function(GetAccountsByLocaleResponse) updates) => super.copyWith((message) => updates(message as GetAccountsByLocaleResponse)) as GetAccountsByLocaleResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetAccountsByLocaleResponse create() => GetAccountsByLocaleResponse._();
  GetAccountsByLocaleResponse createEmptyInstance() => create();
  static $pb.PbList<GetAccountsByLocaleResponse> createRepeated() => $pb.PbList<GetAccountsByLocaleResponse>();
  @$core.pragma('dart2js:noInline')
  static GetAccountsByLocaleResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAccountsByLocaleResponse>(create);
  static GetAccountsByLocaleResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<LocaleAccountGroup> get locales => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get activeLocale => $_getSZ(1);
  @$pb.TagNumber(2)
  set activeLocale($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasActiveLocale() => $_has(1);
  @$pb.TagNumber(2)
  void clearActiveLocale() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get signupLocale => $_getSZ(2);
  @$pb.TagNumber(3)
  set signupLocale($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSignupLocale() => $_has(2);
  @$pb.TagNumber(3)
  void clearSignupLocale() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get totalLocales => $_getIZ(3);
  @$pb.TagNumber(4)
  set totalLocales($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTotalLocales() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalLocales() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get localesWithAccounts => $_getIZ(4);
  @$pb.TagNumber(5)
  set localesWithAccounts($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasLocalesWithAccounts() => $_has(4);
  @$pb.TagNumber(5)
  void clearLocalesWithAccounts() => clearField(5);
}

class CreateLocaleAccountRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateLocaleAccountRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'locale')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountType')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountName')
    ..hasRequiredFields = false
  ;

  CreateLocaleAccountRequest._() : super();
  factory CreateLocaleAccountRequest({
    $core.String? locale,
    $core.String? accountType,
    $core.String? accountName,
  }) {
    final _result = create();
    if (locale != null) {
      _result.locale = locale;
    }
    if (accountType != null) {
      _result.accountType = accountType;
    }
    if (accountName != null) {
      _result.accountName = accountName;
    }
    return _result;
  }
  factory CreateLocaleAccountRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateLocaleAccountRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateLocaleAccountRequest clone() => CreateLocaleAccountRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateLocaleAccountRequest copyWith(void Function(CreateLocaleAccountRequest) updates) => super.copyWith((message) => updates(message as CreateLocaleAccountRequest)) as CreateLocaleAccountRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateLocaleAccountRequest create() => CreateLocaleAccountRequest._();
  CreateLocaleAccountRequest createEmptyInstance() => create();
  static $pb.PbList<CreateLocaleAccountRequest> createRepeated() => $pb.PbList<CreateLocaleAccountRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateLocaleAccountRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateLocaleAccountRequest>(create);
  static CreateLocaleAccountRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get locale => $_getSZ(0);
  @$pb.TagNumber(1)
  set locale($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLocale() => $_has(0);
  @$pb.TagNumber(1)
  void clearLocale() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get accountType => $_getSZ(1);
  @$pb.TagNumber(2)
  set accountType($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAccountType() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccountType() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get accountName => $_getSZ(2);
  @$pb.TagNumber(3)
  set accountName($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAccountName() => $_has(2);
  @$pb.TagNumber(3)
  void clearAccountName() => clearField(3);
}

class CreateLocaleAccountResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateLocaleAccountResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'accounts'), createEmptyInstance: create)
    ..aOM<$0.Account>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'account', subBuilder: $0.Account.create)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'created')
    ..hasRequiredFields = false
  ;

  CreateLocaleAccountResponse._() : super();
  factory CreateLocaleAccountResponse({
    $0.Account? account,
    $core.String? message,
    $core.bool? created,
  }) {
    final _result = create();
    if (account != null) {
      _result.account = account;
    }
    if (message != null) {
      _result.message = message;
    }
    if (created != null) {
      _result.created = created;
    }
    return _result;
  }
  factory CreateLocaleAccountResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateLocaleAccountResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateLocaleAccountResponse clone() => CreateLocaleAccountResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateLocaleAccountResponse copyWith(void Function(CreateLocaleAccountResponse) updates) => super.copyWith((message) => updates(message as CreateLocaleAccountResponse)) as CreateLocaleAccountResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateLocaleAccountResponse create() => CreateLocaleAccountResponse._();
  CreateLocaleAccountResponse createEmptyInstance() => create();
  static $pb.PbList<CreateLocaleAccountResponse> createRepeated() => $pb.PbList<CreateLocaleAccountResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateLocaleAccountResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateLocaleAccountResponse>(create);
  static CreateLocaleAccountResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $0.Account get account => $_getN(0);
  @$pb.TagNumber(1)
  set account($0.Account v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccount() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccount() => clearField(1);
  @$pb.TagNumber(1)
  $0.Account ensureAccount() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get created => $_getBF(2);
  @$pb.TagNumber(3)
  set created($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCreated() => $_has(2);
  @$pb.TagNumber(3)
  void clearCreated() => clearField(3);
}

class SupportedLocale extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SupportedLocale', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'locale')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'countryCode')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'countryName')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currencyCode')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currencySymbol')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'flagEmoji')
    ..aOB(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isActive')
    ..aOB(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isBeta')
    ..pPS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'availableAccountTypes')
    ..aOB(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userHasAccount')
    ..hasRequiredFields = false
  ;

  SupportedLocale._() : super();
  factory SupportedLocale({
    $core.String? locale,
    $core.String? countryCode,
    $core.String? countryName,
    $core.String? currencyCode,
    $core.String? currencySymbol,
    $core.String? flagEmoji,
    $core.bool? isActive,
    $core.bool? isBeta,
    $core.Iterable<$core.String>? availableAccountTypes,
    $core.bool? userHasAccount,
  }) {
    final _result = create();
    if (locale != null) {
      _result.locale = locale;
    }
    if (countryCode != null) {
      _result.countryCode = countryCode;
    }
    if (countryName != null) {
      _result.countryName = countryName;
    }
    if (currencyCode != null) {
      _result.currencyCode = currencyCode;
    }
    if (currencySymbol != null) {
      _result.currencySymbol = currencySymbol;
    }
    if (flagEmoji != null) {
      _result.flagEmoji = flagEmoji;
    }
    if (isActive != null) {
      _result.isActive = isActive;
    }
    if (isBeta != null) {
      _result.isBeta = isBeta;
    }
    if (availableAccountTypes != null) {
      _result.availableAccountTypes.addAll(availableAccountTypes);
    }
    if (userHasAccount != null) {
      _result.userHasAccount = userHasAccount;
    }
    return _result;
  }
  factory SupportedLocale.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SupportedLocale.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SupportedLocale clone() => SupportedLocale()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SupportedLocale copyWith(void Function(SupportedLocale) updates) => super.copyWith((message) => updates(message as SupportedLocale)) as SupportedLocale; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SupportedLocale create() => SupportedLocale._();
  SupportedLocale createEmptyInstance() => create();
  static $pb.PbList<SupportedLocale> createRepeated() => $pb.PbList<SupportedLocale>();
  @$core.pragma('dart2js:noInline')
  static SupportedLocale getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SupportedLocale>(create);
  static SupportedLocale? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get locale => $_getSZ(0);
  @$pb.TagNumber(1)
  set locale($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLocale() => $_has(0);
  @$pb.TagNumber(1)
  void clearLocale() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get countryCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set countryCode($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCountryCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearCountryCode() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get countryName => $_getSZ(2);
  @$pb.TagNumber(3)
  set countryName($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCountryName() => $_has(2);
  @$pb.TagNumber(3)
  void clearCountryName() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get currencyCode => $_getSZ(3);
  @$pb.TagNumber(4)
  set currencyCode($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCurrencyCode() => $_has(3);
  @$pb.TagNumber(4)
  void clearCurrencyCode() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get currencySymbol => $_getSZ(4);
  @$pb.TagNumber(5)
  set currencySymbol($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasCurrencySymbol() => $_has(4);
  @$pb.TagNumber(5)
  void clearCurrencySymbol() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get flagEmoji => $_getSZ(5);
  @$pb.TagNumber(6)
  set flagEmoji($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasFlagEmoji() => $_has(5);
  @$pb.TagNumber(6)
  void clearFlagEmoji() => clearField(6);

  @$pb.TagNumber(7)
  $core.bool get isActive => $_getBF(6);
  @$pb.TagNumber(7)
  set isActive($core.bool v) { $_setBool(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasIsActive() => $_has(6);
  @$pb.TagNumber(7)
  void clearIsActive() => clearField(7);

  @$pb.TagNumber(8)
  $core.bool get isBeta => $_getBF(7);
  @$pb.TagNumber(8)
  set isBeta($core.bool v) { $_setBool(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasIsBeta() => $_has(7);
  @$pb.TagNumber(8)
  void clearIsBeta() => clearField(8);

  @$pb.TagNumber(9)
  $core.List<$core.String> get availableAccountTypes => $_getList(8);

  @$pb.TagNumber(10)
  $core.bool get userHasAccount => $_getBF(9);
  @$pb.TagNumber(10)
  set userHasAccount($core.bool v) { $_setBool(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasUserHasAccount() => $_has(9);
  @$pb.TagNumber(10)
  void clearUserHasAccount() => clearField(10);
}

class GetSupportedLocalesRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetSupportedLocalesRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'accounts'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GetSupportedLocalesRequest._() : super();
  factory GetSupportedLocalesRequest() => create();
  factory GetSupportedLocalesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetSupportedLocalesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetSupportedLocalesRequest clone() => GetSupportedLocalesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetSupportedLocalesRequest copyWith(void Function(GetSupportedLocalesRequest) updates) => super.copyWith((message) => updates(message as GetSupportedLocalesRequest)) as GetSupportedLocalesRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetSupportedLocalesRequest create() => GetSupportedLocalesRequest._();
  GetSupportedLocalesRequest createEmptyInstance() => create();
  static $pb.PbList<GetSupportedLocalesRequest> createRepeated() => $pb.PbList<GetSupportedLocalesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetSupportedLocalesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetSupportedLocalesRequest>(create);
  static GetSupportedLocalesRequest? _defaultInstance;
}

class GetSupportedLocalesResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetSupportedLocalesResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'accounts'), createEmptyInstance: create)
    ..pc<SupportedLocale>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'locales', $pb.PbFieldType.PM, subBuilder: SupportedLocale.create)
    ..hasRequiredFields = false
  ;

  GetSupportedLocalesResponse._() : super();
  factory GetSupportedLocalesResponse({
    $core.Iterable<SupportedLocale>? locales,
  }) {
    final _result = create();
    if (locales != null) {
      _result.locales.addAll(locales);
    }
    return _result;
  }
  factory GetSupportedLocalesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetSupportedLocalesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetSupportedLocalesResponse clone() => GetSupportedLocalesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetSupportedLocalesResponse copyWith(void Function(GetSupportedLocalesResponse) updates) => super.copyWith((message) => updates(message as GetSupportedLocalesResponse)) as GetSupportedLocalesResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetSupportedLocalesResponse create() => GetSupportedLocalesResponse._();
  GetSupportedLocalesResponse createEmptyInstance() => create();
  static $pb.PbList<GetSupportedLocalesResponse> createRepeated() => $pb.PbList<GetSupportedLocalesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetSupportedLocalesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetSupportedLocalesResponse>(create);
  static GetSupportedLocalesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<SupportedLocale> get locales => $_getList(0);
}

class GetUserLocaleRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetUserLocaleRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'accounts'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GetUserLocaleRequest._() : super();
  factory GetUserLocaleRequest() => create();
  factory GetUserLocaleRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUserLocaleRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUserLocaleRequest clone() => GetUserLocaleRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUserLocaleRequest copyWith(void Function(GetUserLocaleRequest) updates) => super.copyWith((message) => updates(message as GetUserLocaleRequest)) as GetUserLocaleRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetUserLocaleRequest create() => GetUserLocaleRequest._();
  GetUserLocaleRequest createEmptyInstance() => create();
  static $pb.PbList<GetUserLocaleRequest> createRepeated() => $pb.PbList<GetUserLocaleRequest>();
  @$core.pragma('dart2js:noInline')
  static GetUserLocaleRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetUserLocaleRequest>(create);
  static GetUserLocaleRequest? _defaultInstance;
}

class GetUserLocaleResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetUserLocaleResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'locale')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'countryCode')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currencyCode')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'signupLocale')
    ..hasRequiredFields = false
  ;

  GetUserLocaleResponse._() : super();
  factory GetUserLocaleResponse({
    $core.String? locale,
    $core.String? countryCode,
    $core.String? currencyCode,
    $core.String? signupLocale,
  }) {
    final _result = create();
    if (locale != null) {
      _result.locale = locale;
    }
    if (countryCode != null) {
      _result.countryCode = countryCode;
    }
    if (currencyCode != null) {
      _result.currencyCode = currencyCode;
    }
    if (signupLocale != null) {
      _result.signupLocale = signupLocale;
    }
    return _result;
  }
  factory GetUserLocaleResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUserLocaleResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUserLocaleResponse clone() => GetUserLocaleResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUserLocaleResponse copyWith(void Function(GetUserLocaleResponse) updates) => super.copyWith((message) => updates(message as GetUserLocaleResponse)) as GetUserLocaleResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetUserLocaleResponse create() => GetUserLocaleResponse._();
  GetUserLocaleResponse createEmptyInstance() => create();
  static $pb.PbList<GetUserLocaleResponse> createRepeated() => $pb.PbList<GetUserLocaleResponse>();
  @$core.pragma('dart2js:noInline')
  static GetUserLocaleResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetUserLocaleResponse>(create);
  static GetUserLocaleResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get locale => $_getSZ(0);
  @$pb.TagNumber(1)
  set locale($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLocale() => $_has(0);
  @$pb.TagNumber(1)
  void clearLocale() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get countryCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set countryCode($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCountryCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearCountryCode() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get currencyCode => $_getSZ(2);
  @$pb.TagNumber(3)
  set currencyCode($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCurrencyCode() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrencyCode() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get signupLocale => $_getSZ(3);
  @$pb.TagNumber(4)
  set signupLocale($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasSignupLocale() => $_has(3);
  @$pb.TagNumber(4)
  void clearSignupLocale() => clearField(4);
}

class SetUserLocaleRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SetUserLocaleRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'locale')
    ..hasRequiredFields = false
  ;

  SetUserLocaleRequest._() : super();
  factory SetUserLocaleRequest({
    $core.String? locale,
  }) {
    final _result = create();
    if (locale != null) {
      _result.locale = locale;
    }
    return _result;
  }
  factory SetUserLocaleRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SetUserLocaleRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SetUserLocaleRequest clone() => SetUserLocaleRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SetUserLocaleRequest copyWith(void Function(SetUserLocaleRequest) updates) => super.copyWith((message) => updates(message as SetUserLocaleRequest)) as SetUserLocaleRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SetUserLocaleRequest create() => SetUserLocaleRequest._();
  SetUserLocaleRequest createEmptyInstance() => create();
  static $pb.PbList<SetUserLocaleRequest> createRepeated() => $pb.PbList<SetUserLocaleRequest>();
  @$core.pragma('dart2js:noInline')
  static SetUserLocaleRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SetUserLocaleRequest>(create);
  static SetUserLocaleRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get locale => $_getSZ(0);
  @$pb.TagNumber(1)
  set locale($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLocale() => $_has(0);
  @$pb.TagNumber(1)
  void clearLocale() => clearField(1);
}

class SetUserLocaleResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SetUserLocaleResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'locale')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  SetUserLocaleResponse._() : super();
  factory SetUserLocaleResponse({
    $core.String? locale,
    $core.String? message,
  }) {
    final _result = create();
    if (locale != null) {
      _result.locale = locale;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory SetUserLocaleResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SetUserLocaleResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SetUserLocaleResponse clone() => SetUserLocaleResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SetUserLocaleResponse copyWith(void Function(SetUserLocaleResponse) updates) => super.copyWith((message) => updates(message as SetUserLocaleResponse)) as SetUserLocaleResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SetUserLocaleResponse create() => SetUserLocaleResponse._();
  SetUserLocaleResponse createEmptyInstance() => create();
  static $pb.PbList<SetUserLocaleResponse> createRepeated() => $pb.PbList<SetUserLocaleResponse>();
  @$core.pragma('dart2js:noInline')
  static SetUserLocaleResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SetUserLocaleResponse>(create);
  static SetUserLocaleResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get locale => $_getSZ(0);
  @$pb.TagNumber(1)
  set locale($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLocale() => $_has(0);
  @$pb.TagNumber(1)
  void clearLocale() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

class TriggerMultiCountryCreationRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TriggerMultiCountryCreationRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'signupLocale')
    ..hasRequiredFields = false
  ;

  TriggerMultiCountryCreationRequest._() : super();
  factory TriggerMultiCountryCreationRequest({
    $core.String? userId,
    $core.String? signupLocale,
  }) {
    final _result = create();
    if (userId != null) {
      _result.userId = userId;
    }
    if (signupLocale != null) {
      _result.signupLocale = signupLocale;
    }
    return _result;
  }
  factory TriggerMultiCountryCreationRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TriggerMultiCountryCreationRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TriggerMultiCountryCreationRequest clone() => TriggerMultiCountryCreationRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TriggerMultiCountryCreationRequest copyWith(void Function(TriggerMultiCountryCreationRequest) updates) => super.copyWith((message) => updates(message as TriggerMultiCountryCreationRequest)) as TriggerMultiCountryCreationRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TriggerMultiCountryCreationRequest create() => TriggerMultiCountryCreationRequest._();
  TriggerMultiCountryCreationRequest createEmptyInstance() => create();
  static $pb.PbList<TriggerMultiCountryCreationRequest> createRepeated() => $pb.PbList<TriggerMultiCountryCreationRequest>();
  @$core.pragma('dart2js:noInline')
  static TriggerMultiCountryCreationRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TriggerMultiCountryCreationRequest>(create);
  static TriggerMultiCountryCreationRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get signupLocale => $_getSZ(1);
  @$pb.TagNumber(2)
  set signupLocale($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSignupLocale() => $_has(1);
  @$pb.TagNumber(2)
  void clearSignupLocale() => clearField(2);
}

class TriggerMultiCountryCreationResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TriggerMultiCountryCreationResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'accounts'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'triggered')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'jobId')
    ..hasRequiredFields = false
  ;

  TriggerMultiCountryCreationResponse._() : super();
  factory TriggerMultiCountryCreationResponse({
    $core.bool? triggered,
    $core.String? message,
    $core.String? jobId,
  }) {
    final _result = create();
    if (triggered != null) {
      _result.triggered = triggered;
    }
    if (message != null) {
      _result.message = message;
    }
    if (jobId != null) {
      _result.jobId = jobId;
    }
    return _result;
  }
  factory TriggerMultiCountryCreationResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TriggerMultiCountryCreationResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TriggerMultiCountryCreationResponse clone() => TriggerMultiCountryCreationResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TriggerMultiCountryCreationResponse copyWith(void Function(TriggerMultiCountryCreationResponse) updates) => super.copyWith((message) => updates(message as TriggerMultiCountryCreationResponse)) as TriggerMultiCountryCreationResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TriggerMultiCountryCreationResponse create() => TriggerMultiCountryCreationResponse._();
  TriggerMultiCountryCreationResponse createEmptyInstance() => create();
  static $pb.PbList<TriggerMultiCountryCreationResponse> createRepeated() => $pb.PbList<TriggerMultiCountryCreationResponse>();
  @$core.pragma('dart2js:noInline')
  static TriggerMultiCountryCreationResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TriggerMultiCountryCreationResponse>(create);
  static TriggerMultiCountryCreationResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get triggered => $_getBF(0);
  @$pb.TagNumber(1)
  set triggered($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTriggered() => $_has(0);
  @$pb.TagNumber(1)
  void clearTriggered() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get jobId => $_getSZ(2);
  @$pb.TagNumber(3)
  set jobId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasJobId() => $_has(2);
  @$pb.TagNumber(3)
  void clearJobId() => clearField(3);
}

class LocaleAccountCreationStatus extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'LocaleAccountCreationStatus', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'locale')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'countryCode')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errorMessage')
    ..aOM<$4.Timestamp>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $4.Timestamp.create)
    ..aOM<$4.Timestamp>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'completedAt', subBuilder: $4.Timestamp.create)
    ..hasRequiredFields = false
  ;

  LocaleAccountCreationStatus._() : super();
  factory LocaleAccountCreationStatus({
    $core.String? locale,
    $core.String? countryCode,
    $core.String? status,
    $core.String? errorMessage,
    $4.Timestamp? createdAt,
    $4.Timestamp? completedAt,
  }) {
    final _result = create();
    if (locale != null) {
      _result.locale = locale;
    }
    if (countryCode != null) {
      _result.countryCode = countryCode;
    }
    if (status != null) {
      _result.status = status;
    }
    if (errorMessage != null) {
      _result.errorMessage = errorMessage;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (completedAt != null) {
      _result.completedAt = completedAt;
    }
    return _result;
  }
  factory LocaleAccountCreationStatus.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LocaleAccountCreationStatus.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LocaleAccountCreationStatus clone() => LocaleAccountCreationStatus()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LocaleAccountCreationStatus copyWith(void Function(LocaleAccountCreationStatus) updates) => super.copyWith((message) => updates(message as LocaleAccountCreationStatus)) as LocaleAccountCreationStatus; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static LocaleAccountCreationStatus create() => LocaleAccountCreationStatus._();
  LocaleAccountCreationStatus createEmptyInstance() => create();
  static $pb.PbList<LocaleAccountCreationStatus> createRepeated() => $pb.PbList<LocaleAccountCreationStatus>();
  @$core.pragma('dart2js:noInline')
  static LocaleAccountCreationStatus getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LocaleAccountCreationStatus>(create);
  static LocaleAccountCreationStatus? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get locale => $_getSZ(0);
  @$pb.TagNumber(1)
  set locale($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLocale() => $_has(0);
  @$pb.TagNumber(1)
  void clearLocale() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get countryCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set countryCode($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCountryCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearCountryCode() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get status => $_getSZ(2);
  @$pb.TagNumber(3)
  set status($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasStatus() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatus() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get errorMessage => $_getSZ(3);
  @$pb.TagNumber(4)
  set errorMessage($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasErrorMessage() => $_has(3);
  @$pb.TagNumber(4)
  void clearErrorMessage() => clearField(4);

  @$pb.TagNumber(5)
  $4.Timestamp get createdAt => $_getN(4);
  @$pb.TagNumber(5)
  set createdAt($4.Timestamp v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasCreatedAt() => $_has(4);
  @$pb.TagNumber(5)
  void clearCreatedAt() => clearField(5);
  @$pb.TagNumber(5)
  $4.Timestamp ensureCreatedAt() => $_ensure(4);

  @$pb.TagNumber(6)
  $4.Timestamp get completedAt => $_getN(5);
  @$pb.TagNumber(6)
  set completedAt($4.Timestamp v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasCompletedAt() => $_has(5);
  @$pb.TagNumber(6)
  void clearCompletedAt() => clearField(6);
  @$pb.TagNumber(6)
  $4.Timestamp ensureCompletedAt() => $_ensure(5);
}

class GetAccountCreationStatusRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetAccountCreationStatusRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'jobId')
    ..hasRequiredFields = false
  ;

  GetAccountCreationStatusRequest._() : super();
  factory GetAccountCreationStatusRequest({
    $core.String? jobId,
  }) {
    final _result = create();
    if (jobId != null) {
      _result.jobId = jobId;
    }
    return _result;
  }
  factory GetAccountCreationStatusRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAccountCreationStatusRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAccountCreationStatusRequest clone() => GetAccountCreationStatusRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAccountCreationStatusRequest copyWith(void Function(GetAccountCreationStatusRequest) updates) => super.copyWith((message) => updates(message as GetAccountCreationStatusRequest)) as GetAccountCreationStatusRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetAccountCreationStatusRequest create() => GetAccountCreationStatusRequest._();
  GetAccountCreationStatusRequest createEmptyInstance() => create();
  static $pb.PbList<GetAccountCreationStatusRequest> createRepeated() => $pb.PbList<GetAccountCreationStatusRequest>();
  @$core.pragma('dart2js:noInline')
  static GetAccountCreationStatusRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAccountCreationStatusRequest>(create);
  static GetAccountCreationStatusRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get jobId => $_getSZ(0);
  @$pb.TagNumber(1)
  set jobId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasJobId() => $_has(0);
  @$pb.TagNumber(1)
  void clearJobId() => clearField(1);
}

class GetAccountCreationStatusResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetAccountCreationStatusResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'overallStatus')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalLocales', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'completedLocales', $pb.PbFieldType.O3)
    ..pc<LocaleAccountCreationStatus>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'localeStatuses', $pb.PbFieldType.PM, subBuilder: LocaleAccountCreationStatus.create)
    ..hasRequiredFields = false
  ;

  GetAccountCreationStatusResponse._() : super();
  factory GetAccountCreationStatusResponse({
    $core.String? overallStatus,
    $core.int? totalLocales,
    $core.int? completedLocales,
    $core.Iterable<LocaleAccountCreationStatus>? localeStatuses,
  }) {
    final _result = create();
    if (overallStatus != null) {
      _result.overallStatus = overallStatus;
    }
    if (totalLocales != null) {
      _result.totalLocales = totalLocales;
    }
    if (completedLocales != null) {
      _result.completedLocales = completedLocales;
    }
    if (localeStatuses != null) {
      _result.localeStatuses.addAll(localeStatuses);
    }
    return _result;
  }
  factory GetAccountCreationStatusResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAccountCreationStatusResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAccountCreationStatusResponse clone() => GetAccountCreationStatusResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAccountCreationStatusResponse copyWith(void Function(GetAccountCreationStatusResponse) updates) => super.copyWith((message) => updates(message as GetAccountCreationStatusResponse)) as GetAccountCreationStatusResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetAccountCreationStatusResponse create() => GetAccountCreationStatusResponse._();
  GetAccountCreationStatusResponse createEmptyInstance() => create();
  static $pb.PbList<GetAccountCreationStatusResponse> createRepeated() => $pb.PbList<GetAccountCreationStatusResponse>();
  @$core.pragma('dart2js:noInline')
  static GetAccountCreationStatusResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAccountCreationStatusResponse>(create);
  static GetAccountCreationStatusResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get overallStatus => $_getSZ(0);
  @$pb.TagNumber(1)
  set overallStatus($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasOverallStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearOverallStatus() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get totalLocales => $_getIZ(1);
  @$pb.TagNumber(2)
  set totalLocales($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotalLocales() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalLocales() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get completedLocales => $_getIZ(2);
  @$pb.TagNumber(3)
  set completedLocales($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCompletedLocales() => $_has(2);
  @$pb.TagNumber(3)
  void clearCompletedLocales() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<LocaleAccountCreationStatus> get localeStatuses => $_getList(3);
}

