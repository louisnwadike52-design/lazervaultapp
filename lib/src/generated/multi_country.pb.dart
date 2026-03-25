// This is a generated file - do not edit.
//
// Generated from multi_country.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'accounts.pb.dart' as $1;
import 'google/protobuf/timestamp.pb.dart' as $2;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

/// Account grouped by locale
class LocaleAccountGroup extends $pb.GeneratedMessage {
  factory LocaleAccountGroup({
    $core.String? locale,
    $core.String? countryCode,
    $core.String? countryName,
    $core.String? currencyCode,
    $core.String? currencySymbol,
    $core.String? flagEmoji,
    $core.Iterable<$1.Account>? accounts,
    $core.double? totalBalance,
    $core.bool? hasAccounts,
    $core.bool? isSignupLocale,
  }) {
    final result = create();
    if (locale != null) result.locale = locale;
    if (countryCode != null) result.countryCode = countryCode;
    if (countryName != null) result.countryName = countryName;
    if (currencyCode != null) result.currencyCode = currencyCode;
    if (currencySymbol != null) result.currencySymbol = currencySymbol;
    if (flagEmoji != null) result.flagEmoji = flagEmoji;
    if (accounts != null) result.accounts.addAll(accounts);
    if (totalBalance != null) result.totalBalance = totalBalance;
    if (hasAccounts != null) result.hasAccounts = hasAccounts;
    if (isSignupLocale != null) result.isSignupLocale = isSignupLocale;
    return result;
  }

  LocaleAccountGroup._();

  factory LocaleAccountGroup.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory LocaleAccountGroup.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LocaleAccountGroup',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'locale')
    ..aOS(2, _omitFieldNames ? '' : 'countryCode')
    ..aOS(3, _omitFieldNames ? '' : 'countryName')
    ..aOS(4, _omitFieldNames ? '' : 'currencyCode')
    ..aOS(5, _omitFieldNames ? '' : 'currencySymbol')
    ..aOS(6, _omitFieldNames ? '' : 'flagEmoji')
    ..pc<$1.Account>(7, _omitFieldNames ? '' : 'accounts', $pb.PbFieldType.PM,
        subBuilder: $1.Account.create)
    ..a<$core.double>(
        8, _omitFieldNames ? '' : 'totalBalance', $pb.PbFieldType.OD)
    ..aOB(9, _omitFieldNames ? '' : 'hasAccounts')
    ..aOB(10, _omitFieldNames ? '' : 'isSignupLocale')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LocaleAccountGroup clone() => LocaleAccountGroup()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LocaleAccountGroup copyWith(void Function(LocaleAccountGroup) updates) =>
      super.copyWith((message) => updates(message as LocaleAccountGroup))
          as LocaleAccountGroup;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LocaleAccountGroup create() => LocaleAccountGroup._();
  @$core.override
  LocaleAccountGroup createEmptyInstance() => create();
  static $pb.PbList<LocaleAccountGroup> createRepeated() =>
      $pb.PbList<LocaleAccountGroup>();
  @$core.pragma('dart2js:noInline')
  static LocaleAccountGroup getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LocaleAccountGroup>(create);
  static LocaleAccountGroup? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get locale => $_getSZ(0);
  @$pb.TagNumber(1)
  set locale($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasLocale() => $_has(0);
  @$pb.TagNumber(1)
  void clearLocale() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get countryCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set countryCode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCountryCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearCountryCode() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get countryName => $_getSZ(2);
  @$pb.TagNumber(3)
  set countryName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCountryName() => $_has(2);
  @$pb.TagNumber(3)
  void clearCountryName() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get currencyCode => $_getSZ(3);
  @$pb.TagNumber(4)
  set currencyCode($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCurrencyCode() => $_has(3);
  @$pb.TagNumber(4)
  void clearCurrencyCode() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get currencySymbol => $_getSZ(4);
  @$pb.TagNumber(5)
  set currencySymbol($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasCurrencySymbol() => $_has(4);
  @$pb.TagNumber(5)
  void clearCurrencySymbol() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get flagEmoji => $_getSZ(5);
  @$pb.TagNumber(6)
  set flagEmoji($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasFlagEmoji() => $_has(5);
  @$pb.TagNumber(6)
  void clearFlagEmoji() => $_clearField(6);

  @$pb.TagNumber(7)
  $pb.PbList<$1.Account> get accounts => $_getList(6);

  @$pb.TagNumber(8)
  $core.double get totalBalance => $_getN(7);
  @$pb.TagNumber(8)
  set totalBalance($core.double value) => $_setDouble(7, value);
  @$pb.TagNumber(8)
  $core.bool hasTotalBalance() => $_has(7);
  @$pb.TagNumber(8)
  void clearTotalBalance() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.bool get hasAccounts => $_getBF(8);
  @$pb.TagNumber(9)
  set hasAccounts($core.bool value) => $_setBool(8, value);
  @$pb.TagNumber(9)
  $core.bool hasHasAccounts() => $_has(8);
  @$pb.TagNumber(9)
  void clearHasAccounts() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.bool get isSignupLocale => $_getBF(9);
  @$pb.TagNumber(10)
  set isSignupLocale($core.bool value) => $_setBool(9, value);
  @$pb.TagNumber(10)
  $core.bool hasIsSignupLocale() => $_has(9);
  @$pb.TagNumber(10)
  void clearIsSignupLocale() => $_clearField(10);
}

class GetAccountsByLocaleRequest extends $pb.GeneratedMessage {
  factory GetAccountsByLocaleRequest({
    $core.String? status,
  }) {
    final result = create();
    if (status != null) result.status = status;
    return result;
  }

  GetAccountsByLocaleRequest._();

  factory GetAccountsByLocaleRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetAccountsByLocaleRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetAccountsByLocaleRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'status')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAccountsByLocaleRequest clone() =>
      GetAccountsByLocaleRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAccountsByLocaleRequest copyWith(
          void Function(GetAccountsByLocaleRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetAccountsByLocaleRequest))
          as GetAccountsByLocaleRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAccountsByLocaleRequest create() => GetAccountsByLocaleRequest._();
  @$core.override
  GetAccountsByLocaleRequest createEmptyInstance() => create();
  static $pb.PbList<GetAccountsByLocaleRequest> createRepeated() =>
      $pb.PbList<GetAccountsByLocaleRequest>();
  @$core.pragma('dart2js:noInline')
  static GetAccountsByLocaleRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetAccountsByLocaleRequest>(create);
  static GetAccountsByLocaleRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get status => $_getSZ(0);
  @$pb.TagNumber(1)
  set status($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => $_clearField(1);
}

class GetAccountsByLocaleResponse extends $pb.GeneratedMessage {
  factory GetAccountsByLocaleResponse({
    $core.Iterable<LocaleAccountGroup>? locales,
    $core.String? activeLocale,
    $core.String? signupLocale,
    $core.int? totalLocales,
    $core.int? localesWithAccounts,
  }) {
    final result = create();
    if (locales != null) result.locales.addAll(locales);
    if (activeLocale != null) result.activeLocale = activeLocale;
    if (signupLocale != null) result.signupLocale = signupLocale;
    if (totalLocales != null) result.totalLocales = totalLocales;
    if (localesWithAccounts != null)
      result.localesWithAccounts = localesWithAccounts;
    return result;
  }

  GetAccountsByLocaleResponse._();

  factory GetAccountsByLocaleResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetAccountsByLocaleResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetAccountsByLocaleResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'),
      createEmptyInstance: create)
    ..pc<LocaleAccountGroup>(
        1, _omitFieldNames ? '' : 'locales', $pb.PbFieldType.PM,
        subBuilder: LocaleAccountGroup.create)
    ..aOS(2, _omitFieldNames ? '' : 'activeLocale')
    ..aOS(3, _omitFieldNames ? '' : 'signupLocale')
    ..a<$core.int>(4, _omitFieldNames ? '' : 'totalLocales', $pb.PbFieldType.O3)
    ..a<$core.int>(
        5, _omitFieldNames ? '' : 'localesWithAccounts', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAccountsByLocaleResponse clone() =>
      GetAccountsByLocaleResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAccountsByLocaleResponse copyWith(
          void Function(GetAccountsByLocaleResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetAccountsByLocaleResponse))
          as GetAccountsByLocaleResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAccountsByLocaleResponse create() =>
      GetAccountsByLocaleResponse._();
  @$core.override
  GetAccountsByLocaleResponse createEmptyInstance() => create();
  static $pb.PbList<GetAccountsByLocaleResponse> createRepeated() =>
      $pb.PbList<GetAccountsByLocaleResponse>();
  @$core.pragma('dart2js:noInline')
  static GetAccountsByLocaleResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetAccountsByLocaleResponse>(create);
  static GetAccountsByLocaleResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<LocaleAccountGroup> get locales => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get activeLocale => $_getSZ(1);
  @$pb.TagNumber(2)
  set activeLocale($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasActiveLocale() => $_has(1);
  @$pb.TagNumber(2)
  void clearActiveLocale() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get signupLocale => $_getSZ(2);
  @$pb.TagNumber(3)
  set signupLocale($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSignupLocale() => $_has(2);
  @$pb.TagNumber(3)
  void clearSignupLocale() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get totalLocales => $_getIZ(3);
  @$pb.TagNumber(4)
  set totalLocales($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTotalLocales() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalLocales() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get localesWithAccounts => $_getIZ(4);
  @$pb.TagNumber(5)
  set localesWithAccounts($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasLocalesWithAccounts() => $_has(4);
  @$pb.TagNumber(5)
  void clearLocalesWithAccounts() => $_clearField(5);
}

class CreateLocaleAccountRequest extends $pb.GeneratedMessage {
  factory CreateLocaleAccountRequest({
    $core.String? locale,
    $core.String? accountType,
    $core.String? accountName,
  }) {
    final result = create();
    if (locale != null) result.locale = locale;
    if (accountType != null) result.accountType = accountType;
    if (accountName != null) result.accountName = accountName;
    return result;
  }

  CreateLocaleAccountRequest._();

  factory CreateLocaleAccountRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateLocaleAccountRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateLocaleAccountRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'locale')
    ..aOS(2, _omitFieldNames ? '' : 'accountType')
    ..aOS(3, _omitFieldNames ? '' : 'accountName')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateLocaleAccountRequest clone() =>
      CreateLocaleAccountRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateLocaleAccountRequest copyWith(
          void Function(CreateLocaleAccountRequest) updates) =>
      super.copyWith(
              (message) => updates(message as CreateLocaleAccountRequest))
          as CreateLocaleAccountRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateLocaleAccountRequest create() => CreateLocaleAccountRequest._();
  @$core.override
  CreateLocaleAccountRequest createEmptyInstance() => create();
  static $pb.PbList<CreateLocaleAccountRequest> createRepeated() =>
      $pb.PbList<CreateLocaleAccountRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateLocaleAccountRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateLocaleAccountRequest>(create);
  static CreateLocaleAccountRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get locale => $_getSZ(0);
  @$pb.TagNumber(1)
  set locale($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasLocale() => $_has(0);
  @$pb.TagNumber(1)
  void clearLocale() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get accountType => $_getSZ(1);
  @$pb.TagNumber(2)
  set accountType($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAccountType() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccountType() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get accountName => $_getSZ(2);
  @$pb.TagNumber(3)
  set accountName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAccountName() => $_has(2);
  @$pb.TagNumber(3)
  void clearAccountName() => $_clearField(3);
}

class CreateLocaleAccountResponse extends $pb.GeneratedMessage {
  factory CreateLocaleAccountResponse({
    $1.Account? account,
    $core.String? message,
    $core.bool? created,
  }) {
    final result = create();
    if (account != null) result.account = account;
    if (message != null) result.message = message;
    if (created != null) result.created = created;
    return result;
  }

  CreateLocaleAccountResponse._();

  factory CreateLocaleAccountResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateLocaleAccountResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateLocaleAccountResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'),
      createEmptyInstance: create)
    ..aOM<$1.Account>(1, _omitFieldNames ? '' : 'account',
        subBuilder: $1.Account.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOB(3, _omitFieldNames ? '' : 'created')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateLocaleAccountResponse clone() =>
      CreateLocaleAccountResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateLocaleAccountResponse copyWith(
          void Function(CreateLocaleAccountResponse) updates) =>
      super.copyWith(
              (message) => updates(message as CreateLocaleAccountResponse))
          as CreateLocaleAccountResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateLocaleAccountResponse create() =>
      CreateLocaleAccountResponse._();
  @$core.override
  CreateLocaleAccountResponse createEmptyInstance() => create();
  static $pb.PbList<CreateLocaleAccountResponse> createRepeated() =>
      $pb.PbList<CreateLocaleAccountResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateLocaleAccountResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateLocaleAccountResponse>(create);
  static CreateLocaleAccountResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $1.Account get account => $_getN(0);
  @$pb.TagNumber(1)
  set account($1.Account value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasAccount() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccount() => $_clearField(1);
  @$pb.TagNumber(1)
  $1.Account ensureAccount() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.bool get created => $_getBF(2);
  @$pb.TagNumber(3)
  set created($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCreated() => $_has(2);
  @$pb.TagNumber(3)
  void clearCreated() => $_clearField(3);
}

class SupportedLocale extends $pb.GeneratedMessage {
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
    final result = create();
    if (locale != null) result.locale = locale;
    if (countryCode != null) result.countryCode = countryCode;
    if (countryName != null) result.countryName = countryName;
    if (currencyCode != null) result.currencyCode = currencyCode;
    if (currencySymbol != null) result.currencySymbol = currencySymbol;
    if (flagEmoji != null) result.flagEmoji = flagEmoji;
    if (isActive != null) result.isActive = isActive;
    if (isBeta != null) result.isBeta = isBeta;
    if (availableAccountTypes != null)
      result.availableAccountTypes.addAll(availableAccountTypes);
    if (userHasAccount != null) result.userHasAccount = userHasAccount;
    return result;
  }

  SupportedLocale._();

  factory SupportedLocale.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SupportedLocale.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SupportedLocale',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'locale')
    ..aOS(2, _omitFieldNames ? '' : 'countryCode')
    ..aOS(3, _omitFieldNames ? '' : 'countryName')
    ..aOS(4, _omitFieldNames ? '' : 'currencyCode')
    ..aOS(5, _omitFieldNames ? '' : 'currencySymbol')
    ..aOS(6, _omitFieldNames ? '' : 'flagEmoji')
    ..aOB(7, _omitFieldNames ? '' : 'isActive')
    ..aOB(8, _omitFieldNames ? '' : 'isBeta')
    ..pPS(9, _omitFieldNames ? '' : 'availableAccountTypes')
    ..aOB(10, _omitFieldNames ? '' : 'userHasAccount')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SupportedLocale clone() => SupportedLocale()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SupportedLocale copyWith(void Function(SupportedLocale) updates) =>
      super.copyWith((message) => updates(message as SupportedLocale))
          as SupportedLocale;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SupportedLocale create() => SupportedLocale._();
  @$core.override
  SupportedLocale createEmptyInstance() => create();
  static $pb.PbList<SupportedLocale> createRepeated() =>
      $pb.PbList<SupportedLocale>();
  @$core.pragma('dart2js:noInline')
  static SupportedLocale getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SupportedLocale>(create);
  static SupportedLocale? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get locale => $_getSZ(0);
  @$pb.TagNumber(1)
  set locale($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasLocale() => $_has(0);
  @$pb.TagNumber(1)
  void clearLocale() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get countryCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set countryCode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCountryCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearCountryCode() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get countryName => $_getSZ(2);
  @$pb.TagNumber(3)
  set countryName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCountryName() => $_has(2);
  @$pb.TagNumber(3)
  void clearCountryName() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get currencyCode => $_getSZ(3);
  @$pb.TagNumber(4)
  set currencyCode($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCurrencyCode() => $_has(3);
  @$pb.TagNumber(4)
  void clearCurrencyCode() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get currencySymbol => $_getSZ(4);
  @$pb.TagNumber(5)
  set currencySymbol($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasCurrencySymbol() => $_has(4);
  @$pb.TagNumber(5)
  void clearCurrencySymbol() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get flagEmoji => $_getSZ(5);
  @$pb.TagNumber(6)
  set flagEmoji($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasFlagEmoji() => $_has(5);
  @$pb.TagNumber(6)
  void clearFlagEmoji() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.bool get isActive => $_getBF(6);
  @$pb.TagNumber(7)
  set isActive($core.bool value) => $_setBool(6, value);
  @$pb.TagNumber(7)
  $core.bool hasIsActive() => $_has(6);
  @$pb.TagNumber(7)
  void clearIsActive() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.bool get isBeta => $_getBF(7);
  @$pb.TagNumber(8)
  set isBeta($core.bool value) => $_setBool(7, value);
  @$pb.TagNumber(8)
  $core.bool hasIsBeta() => $_has(7);
  @$pb.TagNumber(8)
  void clearIsBeta() => $_clearField(8);

  @$pb.TagNumber(9)
  $pb.PbList<$core.String> get availableAccountTypes => $_getList(8);

  @$pb.TagNumber(10)
  $core.bool get userHasAccount => $_getBF(9);
  @$pb.TagNumber(10)
  set userHasAccount($core.bool value) => $_setBool(9, value);
  @$pb.TagNumber(10)
  $core.bool hasUserHasAccount() => $_has(9);
  @$pb.TagNumber(10)
  void clearUserHasAccount() => $_clearField(10);
}

class GetSupportedLocalesRequest extends $pb.GeneratedMessage {
  factory GetSupportedLocalesRequest() => create();

  GetSupportedLocalesRequest._();

  factory GetSupportedLocalesRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetSupportedLocalesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetSupportedLocalesRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSupportedLocalesRequest clone() =>
      GetSupportedLocalesRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSupportedLocalesRequest copyWith(
          void Function(GetSupportedLocalesRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetSupportedLocalesRequest))
          as GetSupportedLocalesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSupportedLocalesRequest create() => GetSupportedLocalesRequest._();
  @$core.override
  GetSupportedLocalesRequest createEmptyInstance() => create();
  static $pb.PbList<GetSupportedLocalesRequest> createRepeated() =>
      $pb.PbList<GetSupportedLocalesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetSupportedLocalesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetSupportedLocalesRequest>(create);
  static GetSupportedLocalesRequest? _defaultInstance;
}

class GetSupportedLocalesResponse extends $pb.GeneratedMessage {
  factory GetSupportedLocalesResponse({
    $core.Iterable<SupportedLocale>? locales,
  }) {
    final result = create();
    if (locales != null) result.locales.addAll(locales);
    return result;
  }

  GetSupportedLocalesResponse._();

  factory GetSupportedLocalesResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetSupportedLocalesResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetSupportedLocalesResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'),
      createEmptyInstance: create)
    ..pc<SupportedLocale>(
        1, _omitFieldNames ? '' : 'locales', $pb.PbFieldType.PM,
        subBuilder: SupportedLocale.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSupportedLocalesResponse clone() =>
      GetSupportedLocalesResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSupportedLocalesResponse copyWith(
          void Function(GetSupportedLocalesResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetSupportedLocalesResponse))
          as GetSupportedLocalesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSupportedLocalesResponse create() =>
      GetSupportedLocalesResponse._();
  @$core.override
  GetSupportedLocalesResponse createEmptyInstance() => create();
  static $pb.PbList<GetSupportedLocalesResponse> createRepeated() =>
      $pb.PbList<GetSupportedLocalesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetSupportedLocalesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetSupportedLocalesResponse>(create);
  static GetSupportedLocalesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<SupportedLocale> get locales => $_getList(0);
}

class GetUserLocaleRequest extends $pb.GeneratedMessage {
  factory GetUserLocaleRequest() => create();

  GetUserLocaleRequest._();

  factory GetUserLocaleRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetUserLocaleRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUserLocaleRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserLocaleRequest clone() =>
      GetUserLocaleRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserLocaleRequest copyWith(void Function(GetUserLocaleRequest) updates) =>
      super.copyWith((message) => updates(message as GetUserLocaleRequest))
          as GetUserLocaleRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserLocaleRequest create() => GetUserLocaleRequest._();
  @$core.override
  GetUserLocaleRequest createEmptyInstance() => create();
  static $pb.PbList<GetUserLocaleRequest> createRepeated() =>
      $pb.PbList<GetUserLocaleRequest>();
  @$core.pragma('dart2js:noInline')
  static GetUserLocaleRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetUserLocaleRequest>(create);
  static GetUserLocaleRequest? _defaultInstance;
}

class GetUserLocaleResponse extends $pb.GeneratedMessage {
  factory GetUserLocaleResponse({
    $core.String? locale,
    $core.String? countryCode,
    $core.String? currencyCode,
    $core.String? signupLocale,
  }) {
    final result = create();
    if (locale != null) result.locale = locale;
    if (countryCode != null) result.countryCode = countryCode;
    if (currencyCode != null) result.currencyCode = currencyCode;
    if (signupLocale != null) result.signupLocale = signupLocale;
    return result;
  }

  GetUserLocaleResponse._();

  factory GetUserLocaleResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetUserLocaleResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUserLocaleResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'locale')
    ..aOS(2, _omitFieldNames ? '' : 'countryCode')
    ..aOS(3, _omitFieldNames ? '' : 'currencyCode')
    ..aOS(4, _omitFieldNames ? '' : 'signupLocale')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserLocaleResponse clone() =>
      GetUserLocaleResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserLocaleResponse copyWith(
          void Function(GetUserLocaleResponse) updates) =>
      super.copyWith((message) => updates(message as GetUserLocaleResponse))
          as GetUserLocaleResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserLocaleResponse create() => GetUserLocaleResponse._();
  @$core.override
  GetUserLocaleResponse createEmptyInstance() => create();
  static $pb.PbList<GetUserLocaleResponse> createRepeated() =>
      $pb.PbList<GetUserLocaleResponse>();
  @$core.pragma('dart2js:noInline')
  static GetUserLocaleResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetUserLocaleResponse>(create);
  static GetUserLocaleResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get locale => $_getSZ(0);
  @$pb.TagNumber(1)
  set locale($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasLocale() => $_has(0);
  @$pb.TagNumber(1)
  void clearLocale() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get countryCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set countryCode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCountryCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearCountryCode() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get currencyCode => $_getSZ(2);
  @$pb.TagNumber(3)
  set currencyCode($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCurrencyCode() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrencyCode() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get signupLocale => $_getSZ(3);
  @$pb.TagNumber(4)
  set signupLocale($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasSignupLocale() => $_has(3);
  @$pb.TagNumber(4)
  void clearSignupLocale() => $_clearField(4);
}

class SetUserLocaleRequest extends $pb.GeneratedMessage {
  factory SetUserLocaleRequest({
    $core.String? locale,
  }) {
    final result = create();
    if (locale != null) result.locale = locale;
    return result;
  }

  SetUserLocaleRequest._();

  factory SetUserLocaleRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SetUserLocaleRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SetUserLocaleRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'locale')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetUserLocaleRequest clone() =>
      SetUserLocaleRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetUserLocaleRequest copyWith(void Function(SetUserLocaleRequest) updates) =>
      super.copyWith((message) => updates(message as SetUserLocaleRequest))
          as SetUserLocaleRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SetUserLocaleRequest create() => SetUserLocaleRequest._();
  @$core.override
  SetUserLocaleRequest createEmptyInstance() => create();
  static $pb.PbList<SetUserLocaleRequest> createRepeated() =>
      $pb.PbList<SetUserLocaleRequest>();
  @$core.pragma('dart2js:noInline')
  static SetUserLocaleRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SetUserLocaleRequest>(create);
  static SetUserLocaleRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get locale => $_getSZ(0);
  @$pb.TagNumber(1)
  set locale($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasLocale() => $_has(0);
  @$pb.TagNumber(1)
  void clearLocale() => $_clearField(1);
}

class SetUserLocaleResponse extends $pb.GeneratedMessage {
  factory SetUserLocaleResponse({
    $core.String? locale,
    $core.String? message,
  }) {
    final result = create();
    if (locale != null) result.locale = locale;
    if (message != null) result.message = message;
    return result;
  }

  SetUserLocaleResponse._();

  factory SetUserLocaleResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SetUserLocaleResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SetUserLocaleResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'locale')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetUserLocaleResponse clone() =>
      SetUserLocaleResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetUserLocaleResponse copyWith(
          void Function(SetUserLocaleResponse) updates) =>
      super.copyWith((message) => updates(message as SetUserLocaleResponse))
          as SetUserLocaleResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SetUserLocaleResponse create() => SetUserLocaleResponse._();
  @$core.override
  SetUserLocaleResponse createEmptyInstance() => create();
  static $pb.PbList<SetUserLocaleResponse> createRepeated() =>
      $pb.PbList<SetUserLocaleResponse>();
  @$core.pragma('dart2js:noInline')
  static SetUserLocaleResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SetUserLocaleResponse>(create);
  static SetUserLocaleResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get locale => $_getSZ(0);
  @$pb.TagNumber(1)
  set locale($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasLocale() => $_has(0);
  @$pb.TagNumber(1)
  void clearLocale() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);
}

class TriggerMultiCountryCreationRequest extends $pb.GeneratedMessage {
  factory TriggerMultiCountryCreationRequest({
    $core.String? userId,
    $core.String? signupLocale,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    if (signupLocale != null) result.signupLocale = signupLocale;
    return result;
  }

  TriggerMultiCountryCreationRequest._();

  factory TriggerMultiCountryCreationRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TriggerMultiCountryCreationRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TriggerMultiCountryCreationRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'signupLocale')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TriggerMultiCountryCreationRequest clone() =>
      TriggerMultiCountryCreationRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TriggerMultiCountryCreationRequest copyWith(
          void Function(TriggerMultiCountryCreationRequest) updates) =>
      super.copyWith((message) =>
              updates(message as TriggerMultiCountryCreationRequest))
          as TriggerMultiCountryCreationRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TriggerMultiCountryCreationRequest create() =>
      TriggerMultiCountryCreationRequest._();
  @$core.override
  TriggerMultiCountryCreationRequest createEmptyInstance() => create();
  static $pb.PbList<TriggerMultiCountryCreationRequest> createRepeated() =>
      $pb.PbList<TriggerMultiCountryCreationRequest>();
  @$core.pragma('dart2js:noInline')
  static TriggerMultiCountryCreationRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TriggerMultiCountryCreationRequest>(
          create);
  static TriggerMultiCountryCreationRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get signupLocale => $_getSZ(1);
  @$pb.TagNumber(2)
  set signupLocale($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSignupLocale() => $_has(1);
  @$pb.TagNumber(2)
  void clearSignupLocale() => $_clearField(2);
}

class TriggerMultiCountryCreationResponse extends $pb.GeneratedMessage {
  factory TriggerMultiCountryCreationResponse({
    $core.bool? triggered,
    $core.String? message,
    $core.String? jobId,
  }) {
    final result = create();
    if (triggered != null) result.triggered = triggered;
    if (message != null) result.message = message;
    if (jobId != null) result.jobId = jobId;
    return result;
  }

  TriggerMultiCountryCreationResponse._();

  factory TriggerMultiCountryCreationResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TriggerMultiCountryCreationResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TriggerMultiCountryCreationResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'triggered')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOS(3, _omitFieldNames ? '' : 'jobId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TriggerMultiCountryCreationResponse clone() =>
      TriggerMultiCountryCreationResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TriggerMultiCountryCreationResponse copyWith(
          void Function(TriggerMultiCountryCreationResponse) updates) =>
      super.copyWith((message) =>
              updates(message as TriggerMultiCountryCreationResponse))
          as TriggerMultiCountryCreationResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TriggerMultiCountryCreationResponse create() =>
      TriggerMultiCountryCreationResponse._();
  @$core.override
  TriggerMultiCountryCreationResponse createEmptyInstance() => create();
  static $pb.PbList<TriggerMultiCountryCreationResponse> createRepeated() =>
      $pb.PbList<TriggerMultiCountryCreationResponse>();
  @$core.pragma('dart2js:noInline')
  static TriggerMultiCountryCreationResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          TriggerMultiCountryCreationResponse>(create);
  static TriggerMultiCountryCreationResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get triggered => $_getBF(0);
  @$pb.TagNumber(1)
  set triggered($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTriggered() => $_has(0);
  @$pb.TagNumber(1)
  void clearTriggered() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get jobId => $_getSZ(2);
  @$pb.TagNumber(3)
  set jobId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasJobId() => $_has(2);
  @$pb.TagNumber(3)
  void clearJobId() => $_clearField(3);
}

class LocaleAccountCreationStatus extends $pb.GeneratedMessage {
  factory LocaleAccountCreationStatus({
    $core.String? locale,
    $core.String? countryCode,
    $core.String? status,
    $core.String? errorMessage,
    $2.Timestamp? createdAt,
    $2.Timestamp? completedAt,
  }) {
    final result = create();
    if (locale != null) result.locale = locale;
    if (countryCode != null) result.countryCode = countryCode;
    if (status != null) result.status = status;
    if (errorMessage != null) result.errorMessage = errorMessage;
    if (createdAt != null) result.createdAt = createdAt;
    if (completedAt != null) result.completedAt = completedAt;
    return result;
  }

  LocaleAccountCreationStatus._();

  factory LocaleAccountCreationStatus.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory LocaleAccountCreationStatus.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LocaleAccountCreationStatus',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'locale')
    ..aOS(2, _omitFieldNames ? '' : 'countryCode')
    ..aOS(3, _omitFieldNames ? '' : 'status')
    ..aOS(4, _omitFieldNames ? '' : 'errorMessage')
    ..aOM<$2.Timestamp>(5, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $2.Timestamp.create)
    ..aOM<$2.Timestamp>(6, _omitFieldNames ? '' : 'completedAt',
        subBuilder: $2.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LocaleAccountCreationStatus clone() =>
      LocaleAccountCreationStatus()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LocaleAccountCreationStatus copyWith(
          void Function(LocaleAccountCreationStatus) updates) =>
      super.copyWith(
              (message) => updates(message as LocaleAccountCreationStatus))
          as LocaleAccountCreationStatus;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LocaleAccountCreationStatus create() =>
      LocaleAccountCreationStatus._();
  @$core.override
  LocaleAccountCreationStatus createEmptyInstance() => create();
  static $pb.PbList<LocaleAccountCreationStatus> createRepeated() =>
      $pb.PbList<LocaleAccountCreationStatus>();
  @$core.pragma('dart2js:noInline')
  static LocaleAccountCreationStatus getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LocaleAccountCreationStatus>(create);
  static LocaleAccountCreationStatus? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get locale => $_getSZ(0);
  @$pb.TagNumber(1)
  set locale($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasLocale() => $_has(0);
  @$pb.TagNumber(1)
  void clearLocale() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get countryCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set countryCode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCountryCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearCountryCode() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get status => $_getSZ(2);
  @$pb.TagNumber(3)
  set status($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasStatus() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatus() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get errorMessage => $_getSZ(3);
  @$pb.TagNumber(4)
  set errorMessage($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasErrorMessage() => $_has(3);
  @$pb.TagNumber(4)
  void clearErrorMessage() => $_clearField(4);

  @$pb.TagNumber(5)
  $2.Timestamp get createdAt => $_getN(4);
  @$pb.TagNumber(5)
  set createdAt($2.Timestamp value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasCreatedAt() => $_has(4);
  @$pb.TagNumber(5)
  void clearCreatedAt() => $_clearField(5);
  @$pb.TagNumber(5)
  $2.Timestamp ensureCreatedAt() => $_ensure(4);

  @$pb.TagNumber(6)
  $2.Timestamp get completedAt => $_getN(5);
  @$pb.TagNumber(6)
  set completedAt($2.Timestamp value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasCompletedAt() => $_has(5);
  @$pb.TagNumber(6)
  void clearCompletedAt() => $_clearField(6);
  @$pb.TagNumber(6)
  $2.Timestamp ensureCompletedAt() => $_ensure(5);
}

class GetAccountCreationStatusRequest extends $pb.GeneratedMessage {
  factory GetAccountCreationStatusRequest({
    $core.String? jobId,
  }) {
    final result = create();
    if (jobId != null) result.jobId = jobId;
    return result;
  }

  GetAccountCreationStatusRequest._();

  factory GetAccountCreationStatusRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetAccountCreationStatusRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetAccountCreationStatusRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'jobId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAccountCreationStatusRequest clone() =>
      GetAccountCreationStatusRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAccountCreationStatusRequest copyWith(
          void Function(GetAccountCreationStatusRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetAccountCreationStatusRequest))
          as GetAccountCreationStatusRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAccountCreationStatusRequest create() =>
      GetAccountCreationStatusRequest._();
  @$core.override
  GetAccountCreationStatusRequest createEmptyInstance() => create();
  static $pb.PbList<GetAccountCreationStatusRequest> createRepeated() =>
      $pb.PbList<GetAccountCreationStatusRequest>();
  @$core.pragma('dart2js:noInline')
  static GetAccountCreationStatusRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetAccountCreationStatusRequest>(
          create);
  static GetAccountCreationStatusRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get jobId => $_getSZ(0);
  @$pb.TagNumber(1)
  set jobId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasJobId() => $_has(0);
  @$pb.TagNumber(1)
  void clearJobId() => $_clearField(1);
}

class GetAccountCreationStatusResponse extends $pb.GeneratedMessage {
  factory GetAccountCreationStatusResponse({
    $core.String? overallStatus,
    $core.int? totalLocales,
    $core.int? completedLocales,
    $core.Iterable<LocaleAccountCreationStatus>? localeStatuses,
  }) {
    final result = create();
    if (overallStatus != null) result.overallStatus = overallStatus;
    if (totalLocales != null) result.totalLocales = totalLocales;
    if (completedLocales != null) result.completedLocales = completedLocales;
    if (localeStatuses != null) result.localeStatuses.addAll(localeStatuses);
    return result;
  }

  GetAccountCreationStatusResponse._();

  factory GetAccountCreationStatusResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetAccountCreationStatusResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetAccountCreationStatusResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'overallStatus')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'totalLocales', $pb.PbFieldType.O3)
    ..a<$core.int>(
        3, _omitFieldNames ? '' : 'completedLocales', $pb.PbFieldType.O3)
    ..pc<LocaleAccountCreationStatus>(
        4, _omitFieldNames ? '' : 'localeStatuses', $pb.PbFieldType.PM,
        subBuilder: LocaleAccountCreationStatus.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAccountCreationStatusResponse clone() =>
      GetAccountCreationStatusResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAccountCreationStatusResponse copyWith(
          void Function(GetAccountCreationStatusResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetAccountCreationStatusResponse))
          as GetAccountCreationStatusResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAccountCreationStatusResponse create() =>
      GetAccountCreationStatusResponse._();
  @$core.override
  GetAccountCreationStatusResponse createEmptyInstance() => create();
  static $pb.PbList<GetAccountCreationStatusResponse> createRepeated() =>
      $pb.PbList<GetAccountCreationStatusResponse>();
  @$core.pragma('dart2js:noInline')
  static GetAccountCreationStatusResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetAccountCreationStatusResponse>(
          create);
  static GetAccountCreationStatusResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get overallStatus => $_getSZ(0);
  @$pb.TagNumber(1)
  set overallStatus($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasOverallStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearOverallStatus() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get totalLocales => $_getIZ(1);
  @$pb.TagNumber(2)
  set totalLocales($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotalLocales() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalLocales() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get completedLocales => $_getIZ(2);
  @$pb.TagNumber(3)
  set completedLocales($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCompletedLocales() => $_has(2);
  @$pb.TagNumber(3)
  void clearCompletedLocales() => $_clearField(3);

  @$pb.TagNumber(4)
  $pb.PbList<LocaleAccountCreationStatus> get localeStatuses => $_getList(3);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
