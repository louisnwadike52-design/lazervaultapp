//
//  Generated code. Do not modify.
//  source: multi_country.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'accounts.pb.dart' as $0;
import 'google/protobuf/timestamp.pb.dart' as $4;

/// Account grouped by locale
class LocaleAccountGroup extends $pb.GeneratedMessage {
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
    final $result = create();
    if (locale != null) {
      $result.locale = locale;
    }
    if (countryCode != null) {
      $result.countryCode = countryCode;
    }
    if (countryName != null) {
      $result.countryName = countryName;
    }
    if (currencyCode != null) {
      $result.currencyCode = currencyCode;
    }
    if (currencySymbol != null) {
      $result.currencySymbol = currencySymbol;
    }
    if (flagEmoji != null) {
      $result.flagEmoji = flagEmoji;
    }
    if (accounts != null) {
      $result.accounts.addAll(accounts);
    }
    if (totalBalance != null) {
      $result.totalBalance = totalBalance;
    }
    if (hasAccounts != null) {
      $result.hasAccounts = hasAccounts;
    }
    if (isSignupLocale != null) {
      $result.isSignupLocale = isSignupLocale;
    }
    return $result;
  }
  LocaleAccountGroup._() : super();
  factory LocaleAccountGroup.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LocaleAccountGroup.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'LocaleAccountGroup', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'locale')
    ..aOS(2, _omitFieldNames ? '' : 'countryCode')
    ..aOS(3, _omitFieldNames ? '' : 'countryName')
    ..aOS(4, _omitFieldNames ? '' : 'currencyCode')
    ..aOS(5, _omitFieldNames ? '' : 'currencySymbol')
    ..aOS(6, _omitFieldNames ? '' : 'flagEmoji')
    ..pc<$0.Account>(7, _omitFieldNames ? '' : 'accounts', $pb.PbFieldType.PM, subBuilder: $0.Account.create)
    ..a<$core.double>(8, _omitFieldNames ? '' : 'totalBalance', $pb.PbFieldType.OD)
    ..aOB(9, _omitFieldNames ? '' : 'hasAccounts')
    ..aOB(10, _omitFieldNames ? '' : 'isSignupLocale')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LocaleAccountGroup clone() => LocaleAccountGroup()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LocaleAccountGroup copyWith(void Function(LocaleAccountGroup) updates) => super.copyWith((message) => updates(message as LocaleAccountGroup)) as LocaleAccountGroup;

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
  factory GetAccountsByLocaleRequest({
    $core.String? status,
  }) {
    final $result = create();
    if (status != null) {
      $result.status = status;
    }
    return $result;
  }
  GetAccountsByLocaleRequest._() : super();
  factory GetAccountsByLocaleRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAccountsByLocaleRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetAccountsByLocaleRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'status')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAccountsByLocaleRequest clone() => GetAccountsByLocaleRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAccountsByLocaleRequest copyWith(void Function(GetAccountsByLocaleRequest) updates) => super.copyWith((message) => updates(message as GetAccountsByLocaleRequest)) as GetAccountsByLocaleRequest;

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
  factory GetAccountsByLocaleResponse({
    $core.Iterable<LocaleAccountGroup>? locales,
    $core.String? activeLocale,
    $core.String? signupLocale,
    $core.int? totalLocales,
    $core.int? localesWithAccounts,
  }) {
    final $result = create();
    if (locales != null) {
      $result.locales.addAll(locales);
    }
    if (activeLocale != null) {
      $result.activeLocale = activeLocale;
    }
    if (signupLocale != null) {
      $result.signupLocale = signupLocale;
    }
    if (totalLocales != null) {
      $result.totalLocales = totalLocales;
    }
    if (localesWithAccounts != null) {
      $result.localesWithAccounts = localesWithAccounts;
    }
    return $result;
  }
  GetAccountsByLocaleResponse._() : super();
  factory GetAccountsByLocaleResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAccountsByLocaleResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetAccountsByLocaleResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..pc<LocaleAccountGroup>(1, _omitFieldNames ? '' : 'locales', $pb.PbFieldType.PM, subBuilder: LocaleAccountGroup.create)
    ..aOS(2, _omitFieldNames ? '' : 'activeLocale')
    ..aOS(3, _omitFieldNames ? '' : 'signupLocale')
    ..a<$core.int>(4, _omitFieldNames ? '' : 'totalLocales', $pb.PbFieldType.O3)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'localesWithAccounts', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAccountsByLocaleResponse clone() => GetAccountsByLocaleResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAccountsByLocaleResponse copyWith(void Function(GetAccountsByLocaleResponse) updates) => super.copyWith((message) => updates(message as GetAccountsByLocaleResponse)) as GetAccountsByLocaleResponse;

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
  factory CreateLocaleAccountRequest({
    $core.String? locale,
    $core.String? accountType,
    $core.String? accountName,
  }) {
    final $result = create();
    if (locale != null) {
      $result.locale = locale;
    }
    if (accountType != null) {
      $result.accountType = accountType;
    }
    if (accountName != null) {
      $result.accountName = accountName;
    }
    return $result;
  }
  CreateLocaleAccountRequest._() : super();
  factory CreateLocaleAccountRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateLocaleAccountRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateLocaleAccountRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'locale')
    ..aOS(2, _omitFieldNames ? '' : 'accountType')
    ..aOS(3, _omitFieldNames ? '' : 'accountName')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateLocaleAccountRequest clone() => CreateLocaleAccountRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateLocaleAccountRequest copyWith(void Function(CreateLocaleAccountRequest) updates) => super.copyWith((message) => updates(message as CreateLocaleAccountRequest)) as CreateLocaleAccountRequest;

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
  factory CreateLocaleAccountResponse({
    $0.Account? account,
    $core.String? message,
    $core.bool? created,
  }) {
    final $result = create();
    if (account != null) {
      $result.account = account;
    }
    if (message != null) {
      $result.message = message;
    }
    if (created != null) {
      $result.created = created;
    }
    return $result;
  }
  CreateLocaleAccountResponse._() : super();
  factory CreateLocaleAccountResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateLocaleAccountResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateLocaleAccountResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOM<$0.Account>(1, _omitFieldNames ? '' : 'account', subBuilder: $0.Account.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOB(3, _omitFieldNames ? '' : 'created')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateLocaleAccountResponse clone() => CreateLocaleAccountResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateLocaleAccountResponse copyWith(void Function(CreateLocaleAccountResponse) updates) => super.copyWith((message) => updates(message as CreateLocaleAccountResponse)) as CreateLocaleAccountResponse;

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
    final $result = create();
    if (locale != null) {
      $result.locale = locale;
    }
    if (countryCode != null) {
      $result.countryCode = countryCode;
    }
    if (countryName != null) {
      $result.countryName = countryName;
    }
    if (currencyCode != null) {
      $result.currencyCode = currencyCode;
    }
    if (currencySymbol != null) {
      $result.currencySymbol = currencySymbol;
    }
    if (flagEmoji != null) {
      $result.flagEmoji = flagEmoji;
    }
    if (isActive != null) {
      $result.isActive = isActive;
    }
    if (isBeta != null) {
      $result.isBeta = isBeta;
    }
    if (availableAccountTypes != null) {
      $result.availableAccountTypes.addAll(availableAccountTypes);
    }
    if (userHasAccount != null) {
      $result.userHasAccount = userHasAccount;
    }
    return $result;
  }
  SupportedLocale._() : super();
  factory SupportedLocale.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SupportedLocale.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SupportedLocale', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
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
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SupportedLocale clone() => SupportedLocale()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SupportedLocale copyWith(void Function(SupportedLocale) updates) => super.copyWith((message) => updates(message as SupportedLocale)) as SupportedLocale;

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
  factory GetSupportedLocalesRequest() => create();
  GetSupportedLocalesRequest._() : super();
  factory GetSupportedLocalesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetSupportedLocalesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetSupportedLocalesRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetSupportedLocalesRequest clone() => GetSupportedLocalesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetSupportedLocalesRequest copyWith(void Function(GetSupportedLocalesRequest) updates) => super.copyWith((message) => updates(message as GetSupportedLocalesRequest)) as GetSupportedLocalesRequest;

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
  factory GetSupportedLocalesResponse({
    $core.Iterable<SupportedLocale>? locales,
  }) {
    final $result = create();
    if (locales != null) {
      $result.locales.addAll(locales);
    }
    return $result;
  }
  GetSupportedLocalesResponse._() : super();
  factory GetSupportedLocalesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetSupportedLocalesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetSupportedLocalesResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..pc<SupportedLocale>(1, _omitFieldNames ? '' : 'locales', $pb.PbFieldType.PM, subBuilder: SupportedLocale.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetSupportedLocalesResponse clone() => GetSupportedLocalesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetSupportedLocalesResponse copyWith(void Function(GetSupportedLocalesResponse) updates) => super.copyWith((message) => updates(message as GetSupportedLocalesResponse)) as GetSupportedLocalesResponse;

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
  factory GetUserLocaleRequest() => create();
  GetUserLocaleRequest._() : super();
  factory GetUserLocaleRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUserLocaleRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetUserLocaleRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUserLocaleRequest clone() => GetUserLocaleRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUserLocaleRequest copyWith(void Function(GetUserLocaleRequest) updates) => super.copyWith((message) => updates(message as GetUserLocaleRequest)) as GetUserLocaleRequest;

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
  factory GetUserLocaleResponse({
    $core.String? locale,
    $core.String? countryCode,
    $core.String? currencyCode,
    $core.String? signupLocale,
  }) {
    final $result = create();
    if (locale != null) {
      $result.locale = locale;
    }
    if (countryCode != null) {
      $result.countryCode = countryCode;
    }
    if (currencyCode != null) {
      $result.currencyCode = currencyCode;
    }
    if (signupLocale != null) {
      $result.signupLocale = signupLocale;
    }
    return $result;
  }
  GetUserLocaleResponse._() : super();
  factory GetUserLocaleResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUserLocaleResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetUserLocaleResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'locale')
    ..aOS(2, _omitFieldNames ? '' : 'countryCode')
    ..aOS(3, _omitFieldNames ? '' : 'currencyCode')
    ..aOS(4, _omitFieldNames ? '' : 'signupLocale')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUserLocaleResponse clone() => GetUserLocaleResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUserLocaleResponse copyWith(void Function(GetUserLocaleResponse) updates) => super.copyWith((message) => updates(message as GetUserLocaleResponse)) as GetUserLocaleResponse;

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
  factory SetUserLocaleRequest({
    $core.String? locale,
  }) {
    final $result = create();
    if (locale != null) {
      $result.locale = locale;
    }
    return $result;
  }
  SetUserLocaleRequest._() : super();
  factory SetUserLocaleRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SetUserLocaleRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SetUserLocaleRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'locale')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SetUserLocaleRequest clone() => SetUserLocaleRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SetUserLocaleRequest copyWith(void Function(SetUserLocaleRequest) updates) => super.copyWith((message) => updates(message as SetUserLocaleRequest)) as SetUserLocaleRequest;

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
  factory SetUserLocaleResponse({
    $core.String? locale,
    $core.String? message,
  }) {
    final $result = create();
    if (locale != null) {
      $result.locale = locale;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  SetUserLocaleResponse._() : super();
  factory SetUserLocaleResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SetUserLocaleResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SetUserLocaleResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'locale')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SetUserLocaleResponse clone() => SetUserLocaleResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SetUserLocaleResponse copyWith(void Function(SetUserLocaleResponse) updates) => super.copyWith((message) => updates(message as SetUserLocaleResponse)) as SetUserLocaleResponse;

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
  factory TriggerMultiCountryCreationRequest({
    $core.String? userId,
    $core.String? signupLocale,
  }) {
    final $result = create();
    if (userId != null) {
      $result.userId = userId;
    }
    if (signupLocale != null) {
      $result.signupLocale = signupLocale;
    }
    return $result;
  }
  TriggerMultiCountryCreationRequest._() : super();
  factory TriggerMultiCountryCreationRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TriggerMultiCountryCreationRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TriggerMultiCountryCreationRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'signupLocale')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TriggerMultiCountryCreationRequest clone() => TriggerMultiCountryCreationRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TriggerMultiCountryCreationRequest copyWith(void Function(TriggerMultiCountryCreationRequest) updates) => super.copyWith((message) => updates(message as TriggerMultiCountryCreationRequest)) as TriggerMultiCountryCreationRequest;

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
  factory TriggerMultiCountryCreationResponse({
    $core.bool? triggered,
    $core.String? message,
    $core.String? jobId,
  }) {
    final $result = create();
    if (triggered != null) {
      $result.triggered = triggered;
    }
    if (message != null) {
      $result.message = message;
    }
    if (jobId != null) {
      $result.jobId = jobId;
    }
    return $result;
  }
  TriggerMultiCountryCreationResponse._() : super();
  factory TriggerMultiCountryCreationResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TriggerMultiCountryCreationResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TriggerMultiCountryCreationResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'triggered')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOS(3, _omitFieldNames ? '' : 'jobId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TriggerMultiCountryCreationResponse clone() => TriggerMultiCountryCreationResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TriggerMultiCountryCreationResponse copyWith(void Function(TriggerMultiCountryCreationResponse) updates) => super.copyWith((message) => updates(message as TriggerMultiCountryCreationResponse)) as TriggerMultiCountryCreationResponse;

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
  factory LocaleAccountCreationStatus({
    $core.String? locale,
    $core.String? countryCode,
    $core.String? status,
    $core.String? errorMessage,
    $4.Timestamp? createdAt,
    $4.Timestamp? completedAt,
  }) {
    final $result = create();
    if (locale != null) {
      $result.locale = locale;
    }
    if (countryCode != null) {
      $result.countryCode = countryCode;
    }
    if (status != null) {
      $result.status = status;
    }
    if (errorMessage != null) {
      $result.errorMessage = errorMessage;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    if (completedAt != null) {
      $result.completedAt = completedAt;
    }
    return $result;
  }
  LocaleAccountCreationStatus._() : super();
  factory LocaleAccountCreationStatus.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LocaleAccountCreationStatus.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'LocaleAccountCreationStatus', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'locale')
    ..aOS(2, _omitFieldNames ? '' : 'countryCode')
    ..aOS(3, _omitFieldNames ? '' : 'status')
    ..aOS(4, _omitFieldNames ? '' : 'errorMessage')
    ..aOM<$4.Timestamp>(5, _omitFieldNames ? '' : 'createdAt', subBuilder: $4.Timestamp.create)
    ..aOM<$4.Timestamp>(6, _omitFieldNames ? '' : 'completedAt', subBuilder: $4.Timestamp.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LocaleAccountCreationStatus clone() => LocaleAccountCreationStatus()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LocaleAccountCreationStatus copyWith(void Function(LocaleAccountCreationStatus) updates) => super.copyWith((message) => updates(message as LocaleAccountCreationStatus)) as LocaleAccountCreationStatus;

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
  factory GetAccountCreationStatusRequest({
    $core.String? jobId,
  }) {
    final $result = create();
    if (jobId != null) {
      $result.jobId = jobId;
    }
    return $result;
  }
  GetAccountCreationStatusRequest._() : super();
  factory GetAccountCreationStatusRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAccountCreationStatusRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetAccountCreationStatusRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'jobId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAccountCreationStatusRequest clone() => GetAccountCreationStatusRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAccountCreationStatusRequest copyWith(void Function(GetAccountCreationStatusRequest) updates) => super.copyWith((message) => updates(message as GetAccountCreationStatusRequest)) as GetAccountCreationStatusRequest;

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
  factory GetAccountCreationStatusResponse({
    $core.String? overallStatus,
    $core.int? totalLocales,
    $core.int? completedLocales,
    $core.Iterable<LocaleAccountCreationStatus>? localeStatuses,
  }) {
    final $result = create();
    if (overallStatus != null) {
      $result.overallStatus = overallStatus;
    }
    if (totalLocales != null) {
      $result.totalLocales = totalLocales;
    }
    if (completedLocales != null) {
      $result.completedLocales = completedLocales;
    }
    if (localeStatuses != null) {
      $result.localeStatuses.addAll(localeStatuses);
    }
    return $result;
  }
  GetAccountCreationStatusResponse._() : super();
  factory GetAccountCreationStatusResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAccountCreationStatusResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetAccountCreationStatusResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'overallStatus')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'totalLocales', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'completedLocales', $pb.PbFieldType.O3)
    ..pc<LocaleAccountCreationStatus>(4, _omitFieldNames ? '' : 'localeStatuses', $pb.PbFieldType.PM, subBuilder: LocaleAccountCreationStatus.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAccountCreationStatusResponse clone() => GetAccountCreationStatusResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAccountCreationStatusResponse copyWith(void Function(GetAccountCreationStatusResponse) updates) => super.copyWith((message) => updates(message as GetAccountCreationStatusResponse)) as GetAccountCreationStatusResponse;

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


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
