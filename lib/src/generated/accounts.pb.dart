//
//  Generated code. Do not modify.
//  source: accounts.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

/// ===== Account Model =====
class Account extends $pb.GeneratedMessage {
  factory Account({
    $core.String? id,
    $core.String? userId,
    $core.String? accountNumber,
    $core.String? accountName,
    $core.String? accountType,
    $core.String? currency,
    $core.String? locale,
    $core.double? balance,
    $core.double? availableBalance,
    $core.String? status,
    $core.bool? isPrimary,
    $core.String? bankCode,
    $core.String? branchCode,
    $core.int? freezeReasonCode,
    $core.String? freezeReason,
    $core.String? frozenAt,
    $core.String? frozenBy,
    $core.double? dailyLimit,
    $core.double? monthlyLimit,
    $core.String? createdAt,
    $core.String? updatedAt,
    $core.bool? isVirtual,
    $core.String? provider,
    $core.String? providerRef,
    $core.String? bankName,
    $core.double? singleTransactionLimit,
    $core.double? reservedBalance,
    $core.int? kycTier,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (userId != null) {
      $result.userId = userId;
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
    if (currency != null) {
      $result.currency = currency;
    }
    if (locale != null) {
      $result.locale = locale;
    }
    if (balance != null) {
      $result.balance = balance;
    }
    if (availableBalance != null) {
      $result.availableBalance = availableBalance;
    }
    if (status != null) {
      $result.status = status;
    }
    if (isPrimary != null) {
      $result.isPrimary = isPrimary;
    }
    if (bankCode != null) {
      $result.bankCode = bankCode;
    }
    if (branchCode != null) {
      $result.branchCode = branchCode;
    }
    if (freezeReasonCode != null) {
      $result.freezeReasonCode = freezeReasonCode;
    }
    if (freezeReason != null) {
      $result.freezeReason = freezeReason;
    }
    if (frozenAt != null) {
      $result.frozenAt = frozenAt;
    }
    if (frozenBy != null) {
      $result.frozenBy = frozenBy;
    }
    if (dailyLimit != null) {
      $result.dailyLimit = dailyLimit;
    }
    if (monthlyLimit != null) {
      $result.monthlyLimit = monthlyLimit;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      $result.updatedAt = updatedAt;
    }
    if (isVirtual != null) {
      $result.isVirtual = isVirtual;
    }
    if (provider != null) {
      $result.provider = provider;
    }
    if (providerRef != null) {
      $result.providerRef = providerRef;
    }
    if (bankName != null) {
      $result.bankName = bankName;
    }
    if (singleTransactionLimit != null) {
      $result.singleTransactionLimit = singleTransactionLimit;
    }
    if (reservedBalance != null) {
      $result.reservedBalance = reservedBalance;
    }
    if (kycTier != null) {
      $result.kycTier = kycTier;
    }
    return $result;
  }
  Account._() : super();
  factory Account.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Account.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Account', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'accountNumber')
    ..aOS(4, _omitFieldNames ? '' : 'accountName')
    ..aOS(5, _omitFieldNames ? '' : 'accountType')
    ..aOS(6, _omitFieldNames ? '' : 'currency')
    ..aOS(7, _omitFieldNames ? '' : 'locale')
    ..a<$core.double>(8, _omitFieldNames ? '' : 'balance', $pb.PbFieldType.OD)
    ..a<$core.double>(9, _omitFieldNames ? '' : 'availableBalance', $pb.PbFieldType.OD)
    ..aOS(10, _omitFieldNames ? '' : 'status')
    ..aOB(11, _omitFieldNames ? '' : 'isPrimary')
    ..aOS(12, _omitFieldNames ? '' : 'bankCode')
    ..aOS(13, _omitFieldNames ? '' : 'branchCode')
    ..a<$core.int>(14, _omitFieldNames ? '' : 'freezeReasonCode', $pb.PbFieldType.O3)
    ..aOS(15, _omitFieldNames ? '' : 'freezeReason')
    ..aOS(16, _omitFieldNames ? '' : 'frozenAt')
    ..aOS(17, _omitFieldNames ? '' : 'frozenBy')
    ..a<$core.double>(18, _omitFieldNames ? '' : 'dailyLimit', $pb.PbFieldType.OD)
    ..a<$core.double>(19, _omitFieldNames ? '' : 'monthlyLimit', $pb.PbFieldType.OD)
    ..aOS(20, _omitFieldNames ? '' : 'createdAt')
    ..aOS(21, _omitFieldNames ? '' : 'updatedAt')
    ..aOB(22, _omitFieldNames ? '' : 'isVirtual')
    ..aOS(23, _omitFieldNames ? '' : 'provider')
    ..aOS(24, _omitFieldNames ? '' : 'providerRef')
    ..aOS(25, _omitFieldNames ? '' : 'bankName')
    ..a<$core.double>(26, _omitFieldNames ? '' : 'singleTransactionLimit', $pb.PbFieldType.OD)
    ..a<$core.double>(27, _omitFieldNames ? '' : 'reservedBalance', $pb.PbFieldType.OD)
    ..a<$core.int>(28, _omitFieldNames ? '' : 'kycTier', $pb.PbFieldType.O3)
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
  $core.String get accountType => $_getSZ(4);
  @$pb.TagNumber(5)
  set accountType($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasAccountType() => $_has(4);
  @$pb.TagNumber(5)
  void clearAccountType() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get currency => $_getSZ(5);
  @$pb.TagNumber(6)
  set currency($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasCurrency() => $_has(5);
  @$pb.TagNumber(6)
  void clearCurrency() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get locale => $_getSZ(6);
  @$pb.TagNumber(7)
  set locale($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasLocale() => $_has(6);
  @$pb.TagNumber(7)
  void clearLocale() => clearField(7);

  @$pb.TagNumber(8)
  $core.double get balance => $_getN(7);
  @$pb.TagNumber(8)
  set balance($core.double v) { $_setDouble(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasBalance() => $_has(7);
  @$pb.TagNumber(8)
  void clearBalance() => clearField(8);

  @$pb.TagNumber(9)
  $core.double get availableBalance => $_getN(8);
  @$pb.TagNumber(9)
  set availableBalance($core.double v) { $_setDouble(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasAvailableBalance() => $_has(8);
  @$pb.TagNumber(9)
  void clearAvailableBalance() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get status => $_getSZ(9);
  @$pb.TagNumber(10)
  set status($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasStatus() => $_has(9);
  @$pb.TagNumber(10)
  void clearStatus() => clearField(10);

  @$pb.TagNumber(11)
  $core.bool get isPrimary => $_getBF(10);
  @$pb.TagNumber(11)
  set isPrimary($core.bool v) { $_setBool(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasIsPrimary() => $_has(10);
  @$pb.TagNumber(11)
  void clearIsPrimary() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get bankCode => $_getSZ(11);
  @$pb.TagNumber(12)
  set bankCode($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasBankCode() => $_has(11);
  @$pb.TagNumber(12)
  void clearBankCode() => clearField(12);

  @$pb.TagNumber(13)
  $core.String get branchCode => $_getSZ(12);
  @$pb.TagNumber(13)
  set branchCode($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasBranchCode() => $_has(12);
  @$pb.TagNumber(13)
  void clearBranchCode() => clearField(13);

  @$pb.TagNumber(14)
  $core.int get freezeReasonCode => $_getIZ(13);
  @$pb.TagNumber(14)
  set freezeReasonCode($core.int v) { $_setSignedInt32(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasFreezeReasonCode() => $_has(13);
  @$pb.TagNumber(14)
  void clearFreezeReasonCode() => clearField(14);

  @$pb.TagNumber(15)
  $core.String get freezeReason => $_getSZ(14);
  @$pb.TagNumber(15)
  set freezeReason($core.String v) { $_setString(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasFreezeReason() => $_has(14);
  @$pb.TagNumber(15)
  void clearFreezeReason() => clearField(15);

  @$pb.TagNumber(16)
  $core.String get frozenAt => $_getSZ(15);
  @$pb.TagNumber(16)
  set frozenAt($core.String v) { $_setString(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasFrozenAt() => $_has(15);
  @$pb.TagNumber(16)
  void clearFrozenAt() => clearField(16);

  @$pb.TagNumber(17)
  $core.String get frozenBy => $_getSZ(16);
  @$pb.TagNumber(17)
  set frozenBy($core.String v) { $_setString(16, v); }
  @$pb.TagNumber(17)
  $core.bool hasFrozenBy() => $_has(16);
  @$pb.TagNumber(17)
  void clearFrozenBy() => clearField(17);

  @$pb.TagNumber(18)
  $core.double get dailyLimit => $_getN(17);
  @$pb.TagNumber(18)
  set dailyLimit($core.double v) { $_setDouble(17, v); }
  @$pb.TagNumber(18)
  $core.bool hasDailyLimit() => $_has(17);
  @$pb.TagNumber(18)
  void clearDailyLimit() => clearField(18);

  @$pb.TagNumber(19)
  $core.double get monthlyLimit => $_getN(18);
  @$pb.TagNumber(19)
  set monthlyLimit($core.double v) { $_setDouble(18, v); }
  @$pb.TagNumber(19)
  $core.bool hasMonthlyLimit() => $_has(18);
  @$pb.TagNumber(19)
  void clearMonthlyLimit() => clearField(19);

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

  /// Virtual Account Fields (Flutterwave integration)
  @$pb.TagNumber(22)
  $core.bool get isVirtual => $_getBF(21);
  @$pb.TagNumber(22)
  set isVirtual($core.bool v) { $_setBool(21, v); }
  @$pb.TagNumber(22)
  $core.bool hasIsVirtual() => $_has(21);
  @$pb.TagNumber(22)
  void clearIsVirtual() => clearField(22);

  @$pb.TagNumber(23)
  $core.String get provider => $_getSZ(22);
  @$pb.TagNumber(23)
  set provider($core.String v) { $_setString(22, v); }
  @$pb.TagNumber(23)
  $core.bool hasProvider() => $_has(22);
  @$pb.TagNumber(23)
  void clearProvider() => clearField(23);

  @$pb.TagNumber(24)
  $core.String get providerRef => $_getSZ(23);
  @$pb.TagNumber(24)
  set providerRef($core.String v) { $_setString(23, v); }
  @$pb.TagNumber(24)
  $core.bool hasProviderRef() => $_has(23);
  @$pb.TagNumber(24)
  void clearProviderRef() => clearField(24);

  @$pb.TagNumber(25)
  $core.String get bankName => $_getSZ(24);
  @$pb.TagNumber(25)
  set bankName($core.String v) { $_setString(24, v); }
  @$pb.TagNumber(25)
  $core.bool hasBankName() => $_has(24);
  @$pb.TagNumber(25)
  void clearBankName() => clearField(25);

  @$pb.TagNumber(26)
  $core.double get singleTransactionLimit => $_getN(25);
  @$pb.TagNumber(26)
  set singleTransactionLimit($core.double v) { $_setDouble(25, v); }
  @$pb.TagNumber(26)
  $core.bool hasSingleTransactionLimit() => $_has(25);
  @$pb.TagNumber(26)
  void clearSingleTransactionLimit() => clearField(26);

  @$pb.TagNumber(27)
  $core.double get reservedBalance => $_getN(26);
  @$pb.TagNumber(27)
  set reservedBalance($core.double v) { $_setDouble(26, v); }
  @$pb.TagNumber(27)
  $core.bool hasReservedBalance() => $_has(26);
  @$pb.TagNumber(27)
  void clearReservedBalance() => clearField(27);

  @$pb.TagNumber(28)
  $core.int get kycTier => $_getIZ(27);
  @$pb.TagNumber(28)
  set kycTier($core.int v) { $_setSignedInt32(27, v); }
  @$pb.TagNumber(28)
  $core.bool hasKycTier() => $_has(27);
  @$pb.TagNumber(28)
  void clearKycTier() => clearField(28);
}

/// ===== Account Summary Model (for carousel/list views) =====
/// Lightweight version of Account for UI display
class AccountSummary extends $pb.GeneratedMessage {
  factory AccountSummary({
    $fixnum.Int64? id,
    $core.String? accountType,
    $core.String? currency,
    $fixnum.Int64? balance,
    $core.String? maskedAccountNumber,
    $core.String? status,
    $core.String? uuid,
    $core.String? accountNumber,
    $fixnum.Int64? availableBalance,
    $fixnum.Int64? reservedBalance,
    $core.String? accountName,
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
    if (uuid != null) {
      $result.uuid = uuid;
    }
    if (accountNumber != null) {
      $result.accountNumber = accountNumber;
    }
    if (availableBalance != null) {
      $result.availableBalance = availableBalance;
    }
    if (reservedBalance != null) {
      $result.reservedBalance = reservedBalance;
    }
    if (accountName != null) {
      $result.accountName = accountName;
    }
    return $result;
  }
  AccountSummary._() : super();
  factory AccountSummary.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AccountSummary.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AccountSummary', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(2, _omitFieldNames ? '' : 'accountType')
    ..aOS(3, _omitFieldNames ? '' : 'currency')
    ..a<$fixnum.Int64>(4, _omitFieldNames ? '' : 'balance', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(5, _omitFieldNames ? '' : 'maskedAccountNumber')
    ..aOS(6, _omitFieldNames ? '' : 'status')
    ..aOS(7, _omitFieldNames ? '' : 'uuid')
    ..aOS(8, _omitFieldNames ? '' : 'accountNumber')
    ..a<$fixnum.Int64>(9, _omitFieldNames ? '' : 'availableBalance', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(10, _omitFieldNames ? '' : 'reservedBalance', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(11, _omitFieldNames ? '' : 'accountName')
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
  $core.String get uuid => $_getSZ(6);
  @$pb.TagNumber(7)
  set uuid($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasUuid() => $_has(6);
  @$pb.TagNumber(7)
  void clearUuid() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get accountNumber => $_getSZ(7);
  @$pb.TagNumber(8)
  set accountNumber($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasAccountNumber() => $_has(7);
  @$pb.TagNumber(8)
  void clearAccountNumber() => clearField(8);

  @$pb.TagNumber(9)
  $fixnum.Int64 get availableBalance => $_getI64(8);
  @$pb.TagNumber(9)
  set availableBalance($fixnum.Int64 v) { $_setInt64(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasAvailableBalance() => $_has(8);
  @$pb.TagNumber(9)
  void clearAvailableBalance() => clearField(9);

  @$pb.TagNumber(10)
  $fixnum.Int64 get reservedBalance => $_getI64(9);
  @$pb.TagNumber(10)
  set reservedBalance($fixnum.Int64 v) { $_setInt64(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasReservedBalance() => $_has(9);
  @$pb.TagNumber(10)
  void clearReservedBalance() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get accountName => $_getSZ(10);
  @$pb.TagNumber(11)
  set accountName($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasAccountName() => $_has(10);
  @$pb.TagNumber(11)
  void clearAccountName() => clearField(11);
}

/// ===== Get User Accounts Summary (for dashboard carousel) =====
/// NOTE: user_id extracted from JWT token, not from request
class GetUserAccountsRequest extends $pb.GeneratedMessage {
  factory GetUserAccountsRequest({
    $core.String? targetUserId,
  }) {
    final $result = create();
    if (targetUserId != null) {
      $result.targetUserId = targetUserId;
    }
    return $result;
  }
  GetUserAccountsRequest._() : super();
  factory GetUserAccountsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUserAccountsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetUserAccountsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'targetUserId')
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

  /// User ID is inferred from the auth token by default.
  /// If target_user_id is set, fetch accounts for that user instead (for internal lookups).
  @$pb.TagNumber(1)
  $core.String get targetUserId => $_getSZ(0);
  @$pb.TagNumber(1)
  set targetUserId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTargetUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTargetUserId() => clearField(1);
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

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetUserAccountsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
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

/// ===== Transaction Model =====
class Transaction extends $pb.GeneratedMessage {
  factory Transaction({
    $core.String? id,
    $core.String? accountId,
    $core.String? reference,
    $core.String? type,
    $core.String? category,
    $core.double? amount,
    $core.double? balanceBefore,
    $core.double? balanceAfter,
    $core.String? description,
    $core.String? metadata,
    $core.String? status,
    $core.String? locale,
    $core.String? serviceName,
    $core.String? createdAt,
    $core.String? counterpartyName,
    $core.String? counterpartyAccount,
    $core.String? updatedAt,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (accountId != null) {
      $result.accountId = accountId;
    }
    if (reference != null) {
      $result.reference = reference;
    }
    if (type != null) {
      $result.type = type;
    }
    if (category != null) {
      $result.category = category;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (balanceBefore != null) {
      $result.balanceBefore = balanceBefore;
    }
    if (balanceAfter != null) {
      $result.balanceAfter = balanceAfter;
    }
    if (description != null) {
      $result.description = description;
    }
    if (metadata != null) {
      $result.metadata = metadata;
    }
    if (status != null) {
      $result.status = status;
    }
    if (locale != null) {
      $result.locale = locale;
    }
    if (serviceName != null) {
      $result.serviceName = serviceName;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    if (counterpartyName != null) {
      $result.counterpartyName = counterpartyName;
    }
    if (counterpartyAccount != null) {
      $result.counterpartyAccount = counterpartyAccount;
    }
    if (updatedAt != null) {
      $result.updatedAt = updatedAt;
    }
    return $result;
  }
  Transaction._() : super();
  factory Transaction.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Transaction.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Transaction', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'accountId')
    ..aOS(3, _omitFieldNames ? '' : 'reference')
    ..aOS(4, _omitFieldNames ? '' : 'type')
    ..aOS(5, _omitFieldNames ? '' : 'category')
    ..a<$core.double>(6, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..a<$core.double>(7, _omitFieldNames ? '' : 'balanceBefore', $pb.PbFieldType.OD)
    ..a<$core.double>(8, _omitFieldNames ? '' : 'balanceAfter', $pb.PbFieldType.OD)
    ..aOS(9, _omitFieldNames ? '' : 'description')
    ..aOS(10, _omitFieldNames ? '' : 'metadata')
    ..aOS(11, _omitFieldNames ? '' : 'status')
    ..aOS(12, _omitFieldNames ? '' : 'locale')
    ..aOS(13, _omitFieldNames ? '' : 'serviceName')
    ..aOS(14, _omitFieldNames ? '' : 'createdAt')
    ..aOS(15, _omitFieldNames ? '' : 'counterpartyName')
    ..aOS(16, _omitFieldNames ? '' : 'counterpartyAccount')
    ..aOS(17, _omitFieldNames ? '' : 'updatedAt')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Transaction clone() => Transaction()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Transaction copyWith(void Function(Transaction) updates) => super.copyWith((message) => updates(message as Transaction)) as Transaction;

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
  $core.String get reference => $_getSZ(2);
  @$pb.TagNumber(3)
  set reference($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasReference() => $_has(2);
  @$pb.TagNumber(3)
  void clearReference() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get type => $_getSZ(3);
  @$pb.TagNumber(4)
  set type($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasType() => $_has(3);
  @$pb.TagNumber(4)
  void clearType() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get category => $_getSZ(4);
  @$pb.TagNumber(5)
  set category($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasCategory() => $_has(4);
  @$pb.TagNumber(5)
  void clearCategory() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get amount => $_getN(5);
  @$pb.TagNumber(6)
  set amount($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasAmount() => $_has(5);
  @$pb.TagNumber(6)
  void clearAmount() => clearField(6);

  @$pb.TagNumber(7)
  $core.double get balanceBefore => $_getN(6);
  @$pb.TagNumber(7)
  set balanceBefore($core.double v) { $_setDouble(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasBalanceBefore() => $_has(6);
  @$pb.TagNumber(7)
  void clearBalanceBefore() => clearField(7);

  @$pb.TagNumber(8)
  $core.double get balanceAfter => $_getN(7);
  @$pb.TagNumber(8)
  set balanceAfter($core.double v) { $_setDouble(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasBalanceAfter() => $_has(7);
  @$pb.TagNumber(8)
  void clearBalanceAfter() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get description => $_getSZ(8);
  @$pb.TagNumber(9)
  set description($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasDescription() => $_has(8);
  @$pb.TagNumber(9)
  void clearDescription() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get metadata => $_getSZ(9);
  @$pb.TagNumber(10)
  set metadata($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasMetadata() => $_has(9);
  @$pb.TagNumber(10)
  void clearMetadata() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get status => $_getSZ(10);
  @$pb.TagNumber(11)
  set status($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasStatus() => $_has(10);
  @$pb.TagNumber(11)
  void clearStatus() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get locale => $_getSZ(11);
  @$pb.TagNumber(12)
  set locale($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasLocale() => $_has(11);
  @$pb.TagNumber(12)
  void clearLocale() => clearField(12);

  @$pb.TagNumber(13)
  $core.String get serviceName => $_getSZ(12);
  @$pb.TagNumber(13)
  set serviceName($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasServiceName() => $_has(12);
  @$pb.TagNumber(13)
  void clearServiceName() => clearField(13);

  @$pb.TagNumber(14)
  $core.String get createdAt => $_getSZ(13);
  @$pb.TagNumber(14)
  set createdAt($core.String v) { $_setString(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasCreatedAt() => $_has(13);
  @$pb.TagNumber(14)
  void clearCreatedAt() => clearField(14);

  @$pb.TagNumber(15)
  $core.String get counterpartyName => $_getSZ(14);
  @$pb.TagNumber(15)
  set counterpartyName($core.String v) { $_setString(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasCounterpartyName() => $_has(14);
  @$pb.TagNumber(15)
  void clearCounterpartyName() => clearField(15);

  @$pb.TagNumber(16)
  $core.String get counterpartyAccount => $_getSZ(15);
  @$pb.TagNumber(16)
  set counterpartyAccount($core.String v) { $_setString(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasCounterpartyAccount() => $_has(15);
  @$pb.TagNumber(16)
  void clearCounterpartyAccount() => clearField(16);

  @$pb.TagNumber(17)
  $core.String get updatedAt => $_getSZ(16);
  @$pb.TagNumber(17)
  set updatedAt($core.String v) { $_setString(16, v); }
  @$pb.TagNumber(17)
  $core.bool hasUpdatedAt() => $_has(16);
  @$pb.TagNumber(17)
  void clearUpdatedAt() => clearField(17);
}

/// ===== Create Account =====
/// NOTE: user_id extracted from JWT token, not from request
class CreateAccountRequest extends $pb.GeneratedMessage {
  factory CreateAccountRequest({
    $core.String? accountName,
    $core.String? accountType,
    $core.String? currency,
    $core.String? locale,
    $core.bool? isPrimary,
    $core.double? dailyLimit,
    $core.double? monthlyLimit,
  }) {
    final $result = create();
    if (accountName != null) {
      $result.accountName = accountName;
    }
    if (accountType != null) {
      $result.accountType = accountType;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (locale != null) {
      $result.locale = locale;
    }
    if (isPrimary != null) {
      $result.isPrimary = isPrimary;
    }
    if (dailyLimit != null) {
      $result.dailyLimit = dailyLimit;
    }
    if (monthlyLimit != null) {
      $result.monthlyLimit = monthlyLimit;
    }
    return $result;
  }
  CreateAccountRequest._() : super();
  factory CreateAccountRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateAccountRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateAccountRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountName')
    ..aOS(2, _omitFieldNames ? '' : 'accountType')
    ..aOS(3, _omitFieldNames ? '' : 'currency')
    ..aOS(4, _omitFieldNames ? '' : 'locale')
    ..aOB(5, _omitFieldNames ? '' : 'isPrimary')
    ..a<$core.double>(6, _omitFieldNames ? '' : 'dailyLimit', $pb.PbFieldType.OD)
    ..a<$core.double>(7, _omitFieldNames ? '' : 'monthlyLimit', $pb.PbFieldType.OD)
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
  $core.String get accountName => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountName($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccountName() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountName() => clearField(1);

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
  $core.String get locale => $_getSZ(3);
  @$pb.TagNumber(4)
  set locale($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasLocale() => $_has(3);
  @$pb.TagNumber(4)
  void clearLocale() => clearField(4);

  @$pb.TagNumber(5)
  $core.bool get isPrimary => $_getBF(4);
  @$pb.TagNumber(5)
  set isPrimary($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasIsPrimary() => $_has(4);
  @$pb.TagNumber(5)
  void clearIsPrimary() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get dailyLimit => $_getN(5);
  @$pb.TagNumber(6)
  set dailyLimit($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasDailyLimit() => $_has(5);
  @$pb.TagNumber(6)
  void clearDailyLimit() => clearField(6);

  @$pb.TagNumber(7)
  $core.double get monthlyLimit => $_getN(6);
  @$pb.TagNumber(7)
  set monthlyLimit($core.double v) { $_setDouble(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasMonthlyLimit() => $_has(6);
  @$pb.TagNumber(7)
  void clearMonthlyLimit() => clearField(7);
}

class CreateAccountResponse extends $pb.GeneratedMessage {
  factory CreateAccountResponse({
    Account? account,
    $core.String? message,
  }) {
    final $result = create();
    if (account != null) {
      $result.account = account;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  CreateAccountResponse._() : super();
  factory CreateAccountResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateAccountResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateAccountResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOM<Account>(1, _omitFieldNames ? '' : 'account', subBuilder: Account.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
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
  Account get account => $_getN(0);
  @$pb.TagNumber(1)
  set account(Account v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccount() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccount() => clearField(1);
  @$pb.TagNumber(1)
  Account ensureAccount() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

/// ===== Get Accounts =====
/// NOTE: user_id extracted from JWT token, not from request
class GetAccountsRequest extends $pb.GeneratedMessage {
  factory GetAccountsRequest({
    $core.String? accountType,
    $core.String? status,
    $core.int? limit,
    $core.int? offset,
  }) {
    final $result = create();
    if (accountType != null) {
      $result.accountType = accountType;
    }
    if (status != null) {
      $result.status = status;
    }
    if (limit != null) {
      $result.limit = limit;
    }
    if (offset != null) {
      $result.offset = offset;
    }
    return $result;
  }
  GetAccountsRequest._() : super();
  factory GetAccountsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAccountsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetAccountsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountType')
    ..aOS(2, _omitFieldNames ? '' : 'status')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'offset', $pb.PbFieldType.O3)
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

  @$pb.TagNumber(1)
  $core.String get accountType => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountType($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccountType() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountType() => clearField(1);

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

class GetAccountsResponse extends $pb.GeneratedMessage {
  factory GetAccountsResponse({
    $core.Iterable<Account>? accounts,
    $core.int? total,
  }) {
    final $result = create();
    if (accounts != null) {
      $result.accounts.addAll(accounts);
    }
    if (total != null) {
      $result.total = total;
    }
    return $result;
  }
  GetAccountsResponse._() : super();
  factory GetAccountsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAccountsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetAccountsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..pc<Account>(1, _omitFieldNames ? '' : 'accounts', $pb.PbFieldType.PM, subBuilder: Account.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
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

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => clearField(2);
}

/// ===== Get Account =====
/// NOTE: user_id extracted from JWT token, not from request
class GetAccountRequest extends $pb.GeneratedMessage {
  factory GetAccountRequest({
    $core.String? accountId,
  }) {
    final $result = create();
    if (accountId != null) {
      $result.accountId = accountId;
    }
    return $result;
  }
  GetAccountRequest._() : super();
  factory GetAccountRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAccountRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetAccountRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAccountRequest clone() => GetAccountRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAccountRequest copyWith(void Function(GetAccountRequest) updates) => super.copyWith((message) => updates(message as GetAccountRequest)) as GetAccountRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAccountRequest create() => GetAccountRequest._();
  GetAccountRequest createEmptyInstance() => create();
  static $pb.PbList<GetAccountRequest> createRepeated() => $pb.PbList<GetAccountRequest>();
  @$core.pragma('dart2js:noInline')
  static GetAccountRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAccountRequest>(create);
  static GetAccountRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => clearField(1);
}

class GetAccountResponse extends $pb.GeneratedMessage {
  factory GetAccountResponse({
    Account? account,
  }) {
    final $result = create();
    if (account != null) {
      $result.account = account;
    }
    return $result;
  }
  GetAccountResponse._() : super();
  factory GetAccountResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAccountResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetAccountResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOM<Account>(1, _omitFieldNames ? '' : 'account', subBuilder: Account.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAccountResponse clone() => GetAccountResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAccountResponse copyWith(void Function(GetAccountResponse) updates) => super.copyWith((message) => updates(message as GetAccountResponse)) as GetAccountResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAccountResponse create() => GetAccountResponse._();
  GetAccountResponse createEmptyInstance() => create();
  static $pb.PbList<GetAccountResponse> createRepeated() => $pb.PbList<GetAccountResponse>();
  @$core.pragma('dart2js:noInline')
  static GetAccountResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAccountResponse>(create);
  static GetAccountResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Account get account => $_getN(0);
  @$pb.TagNumber(1)
  set account(Account v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccount() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccount() => clearField(1);
  @$pb.TagNumber(1)
  Account ensureAccount() => $_ensure(0);
}

/// ===== Get Account By Number =====
class GetAccountByNumberRequest extends $pb.GeneratedMessage {
  factory GetAccountByNumberRequest({
    $core.String? accountNumber,
  }) {
    final $result = create();
    if (accountNumber != null) {
      $result.accountNumber = accountNumber;
    }
    return $result;
  }
  GetAccountByNumberRequest._() : super();
  factory GetAccountByNumberRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAccountByNumberRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetAccountByNumberRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountNumber')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAccountByNumberRequest clone() => GetAccountByNumberRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAccountByNumberRequest copyWith(void Function(GetAccountByNumberRequest) updates) => super.copyWith((message) => updates(message as GetAccountByNumberRequest)) as GetAccountByNumberRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAccountByNumberRequest create() => GetAccountByNumberRequest._();
  GetAccountByNumberRequest createEmptyInstance() => create();
  static $pb.PbList<GetAccountByNumberRequest> createRepeated() => $pb.PbList<GetAccountByNumberRequest>();
  @$core.pragma('dart2js:noInline')
  static GetAccountByNumberRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAccountByNumberRequest>(create);
  static GetAccountByNumberRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountNumber => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountNumber($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccountNumber() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountNumber() => clearField(1);
}

class GetAccountByNumberResponse extends $pb.GeneratedMessage {
  factory GetAccountByNumberResponse({
    Account? account,
  }) {
    final $result = create();
    if (account != null) {
      $result.account = account;
    }
    return $result;
  }
  GetAccountByNumberResponse._() : super();
  factory GetAccountByNumberResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAccountByNumberResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetAccountByNumberResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOM<Account>(1, _omitFieldNames ? '' : 'account', subBuilder: Account.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAccountByNumberResponse clone() => GetAccountByNumberResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAccountByNumberResponse copyWith(void Function(GetAccountByNumberResponse) updates) => super.copyWith((message) => updates(message as GetAccountByNumberResponse)) as GetAccountByNumberResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAccountByNumberResponse create() => GetAccountByNumberResponse._();
  GetAccountByNumberResponse createEmptyInstance() => create();
  static $pb.PbList<GetAccountByNumberResponse> createRepeated() => $pb.PbList<GetAccountByNumberResponse>();
  @$core.pragma('dart2js:noInline')
  static GetAccountByNumberResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAccountByNumberResponse>(create);
  static GetAccountByNumberResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Account get account => $_getN(0);
  @$pb.TagNumber(1)
  set account(Account v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccount() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccount() => clearField(1);
  @$pb.TagNumber(1)
  Account ensureAccount() => $_ensure(0);
}

/// ===== Update Account =====
/// NOTE: user_id extracted from JWT token, not from request
class UpdateAccountRequest extends $pb.GeneratedMessage {
  factory UpdateAccountRequest({
    $core.String? accountId,
    $core.String? accountName,
    $core.double? dailyLimit,
    $core.double? monthlyLimit,
    $core.bool? isPrimary,
  }) {
    final $result = create();
    if (accountId != null) {
      $result.accountId = accountId;
    }
    if (accountName != null) {
      $result.accountName = accountName;
    }
    if (dailyLimit != null) {
      $result.dailyLimit = dailyLimit;
    }
    if (monthlyLimit != null) {
      $result.monthlyLimit = monthlyLimit;
    }
    if (isPrimary != null) {
      $result.isPrimary = isPrimary;
    }
    return $result;
  }
  UpdateAccountRequest._() : super();
  factory UpdateAccountRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateAccountRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateAccountRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountId')
    ..aOS(2, _omitFieldNames ? '' : 'accountName')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'dailyLimit', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'monthlyLimit', $pb.PbFieldType.OD)
    ..aOB(5, _omitFieldNames ? '' : 'isPrimary')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateAccountRequest clone() => UpdateAccountRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateAccountRequest copyWith(void Function(UpdateAccountRequest) updates) => super.copyWith((message) => updates(message as UpdateAccountRequest)) as UpdateAccountRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateAccountRequest create() => UpdateAccountRequest._();
  UpdateAccountRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateAccountRequest> createRepeated() => $pb.PbList<UpdateAccountRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateAccountRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateAccountRequest>(create);
  static UpdateAccountRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get accountName => $_getSZ(1);
  @$pb.TagNumber(2)
  set accountName($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAccountName() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccountName() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get dailyLimit => $_getN(2);
  @$pb.TagNumber(3)
  set dailyLimit($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDailyLimit() => $_has(2);
  @$pb.TagNumber(3)
  void clearDailyLimit() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get monthlyLimit => $_getN(3);
  @$pb.TagNumber(4)
  set monthlyLimit($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasMonthlyLimit() => $_has(3);
  @$pb.TagNumber(4)
  void clearMonthlyLimit() => clearField(4);

  @$pb.TagNumber(5)
  $core.bool get isPrimary => $_getBF(4);
  @$pb.TagNumber(5)
  set isPrimary($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasIsPrimary() => $_has(4);
  @$pb.TagNumber(5)
  void clearIsPrimary() => clearField(5);
}

class UpdateAccountResponse extends $pb.GeneratedMessage {
  factory UpdateAccountResponse({
    Account? account,
    $core.String? message,
  }) {
    final $result = create();
    if (account != null) {
      $result.account = account;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  UpdateAccountResponse._() : super();
  factory UpdateAccountResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateAccountResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateAccountResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOM<Account>(1, _omitFieldNames ? '' : 'account', subBuilder: Account.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateAccountResponse clone() => UpdateAccountResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateAccountResponse copyWith(void Function(UpdateAccountResponse) updates) => super.copyWith((message) => updates(message as UpdateAccountResponse)) as UpdateAccountResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateAccountResponse create() => UpdateAccountResponse._();
  UpdateAccountResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateAccountResponse> createRepeated() => $pb.PbList<UpdateAccountResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateAccountResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateAccountResponse>(create);
  static UpdateAccountResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Account get account => $_getN(0);
  @$pb.TagNumber(1)
  set account(Account v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccount() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccount() => clearField(1);
  @$pb.TagNumber(1)
  Account ensureAccount() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

/// ===== Delete Account =====
/// NOTE: user_id extracted from JWT token, not from request
class DeleteAccountRequest extends $pb.GeneratedMessage {
  factory DeleteAccountRequest({
    $core.String? accountId,
  }) {
    final $result = create();
    if (accountId != null) {
      $result.accountId = accountId;
    }
    return $result;
  }
  DeleteAccountRequest._() : super();
  factory DeleteAccountRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteAccountRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DeleteAccountRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteAccountRequest clone() => DeleteAccountRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteAccountRequest copyWith(void Function(DeleteAccountRequest) updates) => super.copyWith((message) => updates(message as DeleteAccountRequest)) as DeleteAccountRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteAccountRequest create() => DeleteAccountRequest._();
  DeleteAccountRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteAccountRequest> createRepeated() => $pb.PbList<DeleteAccountRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteAccountRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteAccountRequest>(create);
  static DeleteAccountRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => clearField(1);
}

class DeleteAccountResponse extends $pb.GeneratedMessage {
  factory DeleteAccountResponse({
    $core.String? message,
    $core.bool? success,
  }) {
    final $result = create();
    if (message != null) {
      $result.message = message;
    }
    if (success != null) {
      $result.success = success;
    }
    return $result;
  }
  DeleteAccountResponse._() : super();
  factory DeleteAccountResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteAccountResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DeleteAccountResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'message')
    ..aOB(2, _omitFieldNames ? '' : 'success')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteAccountResponse clone() => DeleteAccountResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteAccountResponse copyWith(void Function(DeleteAccountResponse) updates) => super.copyWith((message) => updates(message as DeleteAccountResponse)) as DeleteAccountResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteAccountResponse create() => DeleteAccountResponse._();
  DeleteAccountResponse createEmptyInstance() => create();
  static $pb.PbList<DeleteAccountResponse> createRepeated() => $pb.PbList<DeleteAccountResponse>();
  @$core.pragma('dart2js:noInline')
  static DeleteAccountResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteAccountResponse>(create);
  static DeleteAccountResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get message => $_getSZ(0);
  @$pb.TagNumber(1)
  set message($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMessage() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessage() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => clearField(2);
}

/// ===== Get Balance =====
/// NOTE: user_id extracted from JWT token, not from request
class GetBalanceRequest extends $pb.GeneratedMessage {
  factory GetBalanceRequest({
    $core.String? accountId,
  }) {
    final $result = create();
    if (accountId != null) {
      $result.accountId = accountId;
    }
    return $result;
  }
  GetBalanceRequest._() : super();
  factory GetBalanceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetBalanceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetBalanceRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetBalanceRequest clone() => GetBalanceRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetBalanceRequest copyWith(void Function(GetBalanceRequest) updates) => super.copyWith((message) => updates(message as GetBalanceRequest)) as GetBalanceRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetBalanceRequest create() => GetBalanceRequest._();
  GetBalanceRequest createEmptyInstance() => create();
  static $pb.PbList<GetBalanceRequest> createRepeated() => $pb.PbList<GetBalanceRequest>();
  @$core.pragma('dart2js:noInline')
  static GetBalanceRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetBalanceRequest>(create);
  static GetBalanceRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => clearField(1);
}

class GetBalanceResponse extends $pb.GeneratedMessage {
  factory GetBalanceResponse({
    $core.double? balance,
    $core.double? availableBalance,
    $core.String? currency,
    $core.String? lastUpdated,
  }) {
    final $result = create();
    if (balance != null) {
      $result.balance = balance;
    }
    if (availableBalance != null) {
      $result.availableBalance = availableBalance;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (lastUpdated != null) {
      $result.lastUpdated = lastUpdated;
    }
    return $result;
  }
  GetBalanceResponse._() : super();
  factory GetBalanceResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetBalanceResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetBalanceResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'balance', $pb.PbFieldType.OD)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'availableBalance', $pb.PbFieldType.OD)
    ..aOS(3, _omitFieldNames ? '' : 'currency')
    ..aOS(4, _omitFieldNames ? '' : 'lastUpdated')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetBalanceResponse clone() => GetBalanceResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetBalanceResponse copyWith(void Function(GetBalanceResponse) updates) => super.copyWith((message) => updates(message as GetBalanceResponse)) as GetBalanceResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetBalanceResponse create() => GetBalanceResponse._();
  GetBalanceResponse createEmptyInstance() => create();
  static $pb.PbList<GetBalanceResponse> createRepeated() => $pb.PbList<GetBalanceResponse>();
  @$core.pragma('dart2js:noInline')
  static GetBalanceResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetBalanceResponse>(create);
  static GetBalanceResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get balance => $_getN(0);
  @$pb.TagNumber(1)
  set balance($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasBalance() => $_has(0);
  @$pb.TagNumber(1)
  void clearBalance() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get availableBalance => $_getN(1);
  @$pb.TagNumber(2)
  set availableBalance($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAvailableBalance() => $_has(1);
  @$pb.TagNumber(2)
  void clearAvailableBalance() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get currency => $_getSZ(2);
  @$pb.TagNumber(3)
  set currency($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCurrency() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrency() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get lastUpdated => $_getSZ(3);
  @$pb.TagNumber(4)
  set lastUpdated($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasLastUpdated() => $_has(3);
  @$pb.TagNumber(4)
  void clearLastUpdated() => clearField(4);
}

/// ===== Update Balance (Internal) =====
class UpdateBalanceRequest extends $pb.GeneratedMessage {
  factory UpdateBalanceRequest({
    $core.String? accountId,
    $core.double? amount,
    $core.String? operation,
    $core.String? reference,
    $core.String? description,
    $core.String? category,
  }) {
    final $result = create();
    if (accountId != null) {
      $result.accountId = accountId;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (operation != null) {
      $result.operation = operation;
    }
    if (reference != null) {
      $result.reference = reference;
    }
    if (description != null) {
      $result.description = description;
    }
    if (category != null) {
      $result.category = category;
    }
    return $result;
  }
  UpdateBalanceRequest._() : super();
  factory UpdateBalanceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateBalanceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateBalanceRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountId')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(3, _omitFieldNames ? '' : 'operation')
    ..aOS(4, _omitFieldNames ? '' : 'reference')
    ..aOS(5, _omitFieldNames ? '' : 'description')
    ..aOS(6, _omitFieldNames ? '' : 'category')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateBalanceRequest clone() => UpdateBalanceRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateBalanceRequest copyWith(void Function(UpdateBalanceRequest) updates) => super.copyWith((message) => updates(message as UpdateBalanceRequest)) as UpdateBalanceRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateBalanceRequest create() => UpdateBalanceRequest._();
  UpdateBalanceRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateBalanceRequest> createRepeated() => $pb.PbList<UpdateBalanceRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateBalanceRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateBalanceRequest>(create);
  static UpdateBalanceRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get amount => $_getN(1);
  @$pb.TagNumber(2)
  set amount($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get operation => $_getSZ(2);
  @$pb.TagNumber(3)
  set operation($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasOperation() => $_has(2);
  @$pb.TagNumber(3)
  void clearOperation() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get reference => $_getSZ(3);
  @$pb.TagNumber(4)
  set reference($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasReference() => $_has(3);
  @$pb.TagNumber(4)
  void clearReference() => clearField(4);

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
}

class UpdateBalanceResponse extends $pb.GeneratedMessage {
  factory UpdateBalanceResponse({
    $core.double? newBalance,
    $core.double? availableBalance,
    Transaction? transaction,
  }) {
    final $result = create();
    if (newBalance != null) {
      $result.newBalance = newBalance;
    }
    if (availableBalance != null) {
      $result.availableBalance = availableBalance;
    }
    if (transaction != null) {
      $result.transaction = transaction;
    }
    return $result;
  }
  UpdateBalanceResponse._() : super();
  factory UpdateBalanceResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateBalanceResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateBalanceResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'newBalance', $pb.PbFieldType.OD)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'availableBalance', $pb.PbFieldType.OD)
    ..aOM<Transaction>(3, _omitFieldNames ? '' : 'transaction', subBuilder: Transaction.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateBalanceResponse clone() => UpdateBalanceResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateBalanceResponse copyWith(void Function(UpdateBalanceResponse) updates) => super.copyWith((message) => updates(message as UpdateBalanceResponse)) as UpdateBalanceResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateBalanceResponse create() => UpdateBalanceResponse._();
  UpdateBalanceResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateBalanceResponse> createRepeated() => $pb.PbList<UpdateBalanceResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateBalanceResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateBalanceResponse>(create);
  static UpdateBalanceResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get newBalance => $_getN(0);
  @$pb.TagNumber(1)
  set newBalance($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasNewBalance() => $_has(0);
  @$pb.TagNumber(1)
  void clearNewBalance() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get availableBalance => $_getN(1);
  @$pb.TagNumber(2)
  set availableBalance($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAvailableBalance() => $_has(1);
  @$pb.TagNumber(2)
  void clearAvailableBalance() => clearField(2);

  @$pb.TagNumber(3)
  Transaction get transaction => $_getN(2);
  @$pb.TagNumber(3)
  set transaction(Transaction v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasTransaction() => $_has(2);
  @$pb.TagNumber(3)
  void clearTransaction() => clearField(3);
  @$pb.TagNumber(3)
  Transaction ensureTransaction() => $_ensure(2);
}

/// ===== Get Transactions =====
/// NOTE: user_id extracted from JWT token, not from request
class GetTransactionsRequest extends $pb.GeneratedMessage {
  factory GetTransactionsRequest({
    $core.String? accountId,
    $core.String? type,
    $core.String? category,
    $core.String? status,
    $core.String? startDate,
    $core.String? endDate,
    $core.int? limit,
    $core.int? offset,
  }) {
    final $result = create();
    if (accountId != null) {
      $result.accountId = accountId;
    }
    if (type != null) {
      $result.type = type;
    }
    if (category != null) {
      $result.category = category;
    }
    if (status != null) {
      $result.status = status;
    }
    if (startDate != null) {
      $result.startDate = startDate;
    }
    if (endDate != null) {
      $result.endDate = endDate;
    }
    if (limit != null) {
      $result.limit = limit;
    }
    if (offset != null) {
      $result.offset = offset;
    }
    return $result;
  }
  GetTransactionsRequest._() : super();
  factory GetTransactionsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTransactionsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetTransactionsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountId')
    ..aOS(2, _omitFieldNames ? '' : 'type')
    ..aOS(3, _omitFieldNames ? '' : 'category')
    ..aOS(4, _omitFieldNames ? '' : 'status')
    ..aOS(5, _omitFieldNames ? '' : 'startDate')
    ..aOS(6, _omitFieldNames ? '' : 'endDate')
    ..a<$core.int>(7, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(8, _omitFieldNames ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetTransactionsRequest clone() => GetTransactionsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetTransactionsRequest copyWith(void Function(GetTransactionsRequest) updates) => super.copyWith((message) => updates(message as GetTransactionsRequest)) as GetTransactionsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTransactionsRequest create() => GetTransactionsRequest._();
  GetTransactionsRequest createEmptyInstance() => create();
  static $pb.PbList<GetTransactionsRequest> createRepeated() => $pb.PbList<GetTransactionsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetTransactionsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetTransactionsRequest>(create);
  static GetTransactionsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get type => $_getSZ(1);
  @$pb.TagNumber(2)
  set type($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasType() => $_has(1);
  @$pb.TagNumber(2)
  void clearType() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get category => $_getSZ(2);
  @$pb.TagNumber(3)
  set category($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCategory() => $_has(2);
  @$pb.TagNumber(3)
  void clearCategory() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get status => $_getSZ(3);
  @$pb.TagNumber(4)
  set status($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasStatus() => $_has(3);
  @$pb.TagNumber(4)
  void clearStatus() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get startDate => $_getSZ(4);
  @$pb.TagNumber(5)
  set startDate($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasStartDate() => $_has(4);
  @$pb.TagNumber(5)
  void clearStartDate() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get endDate => $_getSZ(5);
  @$pb.TagNumber(6)
  set endDate($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasEndDate() => $_has(5);
  @$pb.TagNumber(6)
  void clearEndDate() => clearField(6);

  @$pb.TagNumber(7)
  $core.int get limit => $_getIZ(6);
  @$pb.TagNumber(7)
  set limit($core.int v) { $_setSignedInt32(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasLimit() => $_has(6);
  @$pb.TagNumber(7)
  void clearLimit() => clearField(7);

  @$pb.TagNumber(8)
  $core.int get offset => $_getIZ(7);
  @$pb.TagNumber(8)
  set offset($core.int v) { $_setSignedInt32(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasOffset() => $_has(7);
  @$pb.TagNumber(8)
  void clearOffset() => clearField(8);
}

class GetTransactionsResponse extends $pb.GeneratedMessage {
  factory GetTransactionsResponse({
    $core.Iterable<Transaction>? transactions,
    $core.int? total,
    $core.double? totalCredits,
    $core.double? totalDebits,
  }) {
    final $result = create();
    if (transactions != null) {
      $result.transactions.addAll(transactions);
    }
    if (total != null) {
      $result.total = total;
    }
    if (totalCredits != null) {
      $result.totalCredits = totalCredits;
    }
    if (totalDebits != null) {
      $result.totalDebits = totalDebits;
    }
    return $result;
  }
  GetTransactionsResponse._() : super();
  factory GetTransactionsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTransactionsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetTransactionsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..pc<Transaction>(1, _omitFieldNames ? '' : 'transactions', $pb.PbFieldType.PM, subBuilder: Transaction.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'totalCredits', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'totalDebits', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetTransactionsResponse clone() => GetTransactionsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetTransactionsResponse copyWith(void Function(GetTransactionsResponse) updates) => super.copyWith((message) => updates(message as GetTransactionsResponse)) as GetTransactionsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTransactionsResponse create() => GetTransactionsResponse._();
  GetTransactionsResponse createEmptyInstance() => create();
  static $pb.PbList<GetTransactionsResponse> createRepeated() => $pb.PbList<GetTransactionsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetTransactionsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetTransactionsResponse>(create);
  static GetTransactionsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Transaction> get transactions => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get totalCredits => $_getN(2);
  @$pb.TagNumber(3)
  set totalCredits($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTotalCredits() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalCredits() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get totalDebits => $_getN(3);
  @$pb.TagNumber(4)
  set totalDebits($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTotalDebits() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalDebits() => clearField(4);
}

/// ===== Freeze Account =====
/// NOTE: user_id extracted from JWT token, not from request
class FreezeAccountRequest extends $pb.GeneratedMessage {
  factory FreezeAccountRequest({
    $core.String? accountId,
    $core.String? reason,
    $core.int? reasonCode,
    $core.String? frozenBy,
  }) {
    final $result = create();
    if (accountId != null) {
      $result.accountId = accountId;
    }
    if (reason != null) {
      $result.reason = reason;
    }
    if (reasonCode != null) {
      $result.reasonCode = reasonCode;
    }
    if (frozenBy != null) {
      $result.frozenBy = frozenBy;
    }
    return $result;
  }
  FreezeAccountRequest._() : super();
  factory FreezeAccountRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FreezeAccountRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'FreezeAccountRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountId')
    ..aOS(2, _omitFieldNames ? '' : 'reason')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'reasonCode', $pb.PbFieldType.O3)
    ..aOS(4, _omitFieldNames ? '' : 'frozenBy')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FreezeAccountRequest clone() => FreezeAccountRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FreezeAccountRequest copyWith(void Function(FreezeAccountRequest) updates) => super.copyWith((message) => updates(message as FreezeAccountRequest)) as FreezeAccountRequest;

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
  $core.int get reasonCode => $_getIZ(2);
  @$pb.TagNumber(3)
  set reasonCode($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasReasonCode() => $_has(2);
  @$pb.TagNumber(3)
  void clearReasonCode() => clearField(3);

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
  factory FreezeAccountResponse({
    Account? account,
    $core.String? message,
  }) {
    final $result = create();
    if (account != null) {
      $result.account = account;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  FreezeAccountResponse._() : super();
  factory FreezeAccountResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FreezeAccountResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'FreezeAccountResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOM<Account>(1, _omitFieldNames ? '' : 'account', subBuilder: Account.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FreezeAccountResponse clone() => FreezeAccountResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FreezeAccountResponse copyWith(void Function(FreezeAccountResponse) updates) => super.copyWith((message) => updates(message as FreezeAccountResponse)) as FreezeAccountResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FreezeAccountResponse create() => FreezeAccountResponse._();
  FreezeAccountResponse createEmptyInstance() => create();
  static $pb.PbList<FreezeAccountResponse> createRepeated() => $pb.PbList<FreezeAccountResponse>();
  @$core.pragma('dart2js:noInline')
  static FreezeAccountResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FreezeAccountResponse>(create);
  static FreezeAccountResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Account get account => $_getN(0);
  @$pb.TagNumber(1)
  set account(Account v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccount() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccount() => clearField(1);
  @$pb.TagNumber(1)
  Account ensureAccount() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

/// ===== Unfreeze Account =====
/// NOTE: user_id extracted from JWT token, not from request
class UnfreezeAccountRequest extends $pb.GeneratedMessage {
  factory UnfreezeAccountRequest({
    $core.String? accountId,
    $core.String? unfrozenBy,
  }) {
    final $result = create();
    if (accountId != null) {
      $result.accountId = accountId;
    }
    if (unfrozenBy != null) {
      $result.unfrozenBy = unfrozenBy;
    }
    return $result;
  }
  UnfreezeAccountRequest._() : super();
  factory UnfreezeAccountRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UnfreezeAccountRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UnfreezeAccountRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountId')
    ..aOS(2, _omitFieldNames ? '' : 'unfrozenBy')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UnfreezeAccountRequest clone() => UnfreezeAccountRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UnfreezeAccountRequest copyWith(void Function(UnfreezeAccountRequest) updates) => super.copyWith((message) => updates(message as UnfreezeAccountRequest)) as UnfreezeAccountRequest;

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
}

class UnfreezeAccountResponse extends $pb.GeneratedMessage {
  factory UnfreezeAccountResponse({
    Account? account,
    $core.String? message,
  }) {
    final $result = create();
    if (account != null) {
      $result.account = account;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  UnfreezeAccountResponse._() : super();
  factory UnfreezeAccountResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UnfreezeAccountResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UnfreezeAccountResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOM<Account>(1, _omitFieldNames ? '' : 'account', subBuilder: Account.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UnfreezeAccountResponse clone() => UnfreezeAccountResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UnfreezeAccountResponse copyWith(void Function(UnfreezeAccountResponse) updates) => super.copyWith((message) => updates(message as UnfreezeAccountResponse)) as UnfreezeAccountResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UnfreezeAccountResponse create() => UnfreezeAccountResponse._();
  UnfreezeAccountResponse createEmptyInstance() => create();
  static $pb.PbList<UnfreezeAccountResponse> createRepeated() => $pb.PbList<UnfreezeAccountResponse>();
  @$core.pragma('dart2js:noInline')
  static UnfreezeAccountResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UnfreezeAccountResponse>(create);
  static UnfreezeAccountResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Account get account => $_getN(0);
  @$pb.TagNumber(1)
  set account(Account v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccount() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccount() => clearField(1);
  @$pb.TagNumber(1)
  Account ensureAccount() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

/// === AutoSave ===
class AutoSave extends $pb.GeneratedMessage {
  factory AutoSave({
    $core.String? id,
    $core.String? accountId,
    $core.String? userId,
    $core.String? name,
    $core.double? amount,
    $core.String? frequency,
    $core.String? trigger,
    $core.String? status,
    $core.String? targetAccountId,
    $core.double? targetAmount,
    $core.String? createdAt,
    $core.String? updatedAt,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (accountId != null) {
      $result.accountId = accountId;
    }
    if (userId != null) {
      $result.userId = userId;
    }
    if (name != null) {
      $result.name = name;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (frequency != null) {
      $result.frequency = frequency;
    }
    if (trigger != null) {
      $result.trigger = trigger;
    }
    if (status != null) {
      $result.status = status;
    }
    if (targetAccountId != null) {
      $result.targetAccountId = targetAccountId;
    }
    if (targetAmount != null) {
      $result.targetAmount = targetAmount;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      $result.updatedAt = updatedAt;
    }
    return $result;
  }
  AutoSave._() : super();
  factory AutoSave.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AutoSave.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AutoSave', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'accountId')
    ..aOS(3, _omitFieldNames ? '' : 'userId')
    ..aOS(4, _omitFieldNames ? '' : 'name')
    ..a<$core.double>(5, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(6, _omitFieldNames ? '' : 'frequency')
    ..aOS(7, _omitFieldNames ? '' : 'trigger')
    ..aOS(8, _omitFieldNames ? '' : 'status')
    ..aOS(9, _omitFieldNames ? '' : 'targetAccountId')
    ..a<$core.double>(10, _omitFieldNames ? '' : 'targetAmount', $pb.PbFieldType.OD)
    ..aOS(11, _omitFieldNames ? '' : 'createdAt')
    ..aOS(12, _omitFieldNames ? '' : 'updatedAt')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AutoSave clone() => AutoSave()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AutoSave copyWith(void Function(AutoSave) updates) => super.copyWith((message) => updates(message as AutoSave)) as AutoSave;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AutoSave create() => AutoSave._();
  AutoSave createEmptyInstance() => create();
  static $pb.PbList<AutoSave> createRepeated() => $pb.PbList<AutoSave>();
  @$core.pragma('dart2js:noInline')
  static AutoSave getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AutoSave>(create);
  static AutoSave? _defaultInstance;

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
  $core.String get name => $_getSZ(3);
  @$pb.TagNumber(4)
  set name($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasName() => $_has(3);
  @$pb.TagNumber(4)
  void clearName() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get amount => $_getN(4);
  @$pb.TagNumber(5)
  set amount($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasAmount() => $_has(4);
  @$pb.TagNumber(5)
  void clearAmount() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get frequency => $_getSZ(5);
  @$pb.TagNumber(6)
  set frequency($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasFrequency() => $_has(5);
  @$pb.TagNumber(6)
  void clearFrequency() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get trigger => $_getSZ(6);
  @$pb.TagNumber(7)
  set trigger($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasTrigger() => $_has(6);
  @$pb.TagNumber(7)
  void clearTrigger() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get status => $_getSZ(7);
  @$pb.TagNumber(8)
  set status($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasStatus() => $_has(7);
  @$pb.TagNumber(8)
  void clearStatus() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get targetAccountId => $_getSZ(8);
  @$pb.TagNumber(9)
  set targetAccountId($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasTargetAccountId() => $_has(8);
  @$pb.TagNumber(9)
  void clearTargetAccountId() => clearField(9);

  @$pb.TagNumber(10)
  $core.double get targetAmount => $_getN(9);
  @$pb.TagNumber(10)
  set targetAmount($core.double v) { $_setDouble(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasTargetAmount() => $_has(9);
  @$pb.TagNumber(10)
  void clearTargetAmount() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get createdAt => $_getSZ(10);
  @$pb.TagNumber(11)
  set createdAt($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasCreatedAt() => $_has(10);
  @$pb.TagNumber(11)
  void clearCreatedAt() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get updatedAt => $_getSZ(11);
  @$pb.TagNumber(12)
  set updatedAt($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasUpdatedAt() => $_has(11);
  @$pb.TagNumber(12)
  void clearUpdatedAt() => clearField(12);
}

/// NOTE: user_id extracted from JWT token, not from request
class CreateAutoSaveRequest extends $pb.GeneratedMessage {
  factory CreateAutoSaveRequest({
    $core.String? accountId,
    $core.String? name,
    $core.double? amount,
    $core.String? frequency,
    $core.String? trigger,
    $core.String? targetAccountId,
    $core.double? targetAmount,
  }) {
    final $result = create();
    if (accountId != null) {
      $result.accountId = accountId;
    }
    if (name != null) {
      $result.name = name;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (frequency != null) {
      $result.frequency = frequency;
    }
    if (trigger != null) {
      $result.trigger = trigger;
    }
    if (targetAccountId != null) {
      $result.targetAccountId = targetAccountId;
    }
    if (targetAmount != null) {
      $result.targetAmount = targetAmount;
    }
    return $result;
  }
  CreateAutoSaveRequest._() : super();
  factory CreateAutoSaveRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateAutoSaveRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateAutoSaveRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountId')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(4, _omitFieldNames ? '' : 'frequency')
    ..aOS(5, _omitFieldNames ? '' : 'trigger')
    ..aOS(6, _omitFieldNames ? '' : 'targetAccountId')
    ..a<$core.double>(7, _omitFieldNames ? '' : 'targetAmount', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateAutoSaveRequest clone() => CreateAutoSaveRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateAutoSaveRequest copyWith(void Function(CreateAutoSaveRequest) updates) => super.copyWith((message) => updates(message as CreateAutoSaveRequest)) as CreateAutoSaveRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateAutoSaveRequest create() => CreateAutoSaveRequest._();
  CreateAutoSaveRequest createEmptyInstance() => create();
  static $pb.PbList<CreateAutoSaveRequest> createRepeated() => $pb.PbList<CreateAutoSaveRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateAutoSaveRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateAutoSaveRequest>(create);
  static CreateAutoSaveRequest? _defaultInstance;

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
  $core.double get amount => $_getN(2);
  @$pb.TagNumber(3)
  set amount($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get frequency => $_getSZ(3);
  @$pb.TagNumber(4)
  set frequency($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasFrequency() => $_has(3);
  @$pb.TagNumber(4)
  void clearFrequency() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get trigger => $_getSZ(4);
  @$pb.TagNumber(5)
  set trigger($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTrigger() => $_has(4);
  @$pb.TagNumber(5)
  void clearTrigger() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get targetAccountId => $_getSZ(5);
  @$pb.TagNumber(6)
  set targetAccountId($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasTargetAccountId() => $_has(5);
  @$pb.TagNumber(6)
  void clearTargetAccountId() => clearField(6);

  @$pb.TagNumber(7)
  $core.double get targetAmount => $_getN(6);
  @$pb.TagNumber(7)
  set targetAmount($core.double v) { $_setDouble(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasTargetAmount() => $_has(6);
  @$pb.TagNumber(7)
  void clearTargetAmount() => clearField(7);
}

class CreateAutoSaveResponse extends $pb.GeneratedMessage {
  factory CreateAutoSaveResponse({
    AutoSave? autosave,
    $core.String? message,
  }) {
    final $result = create();
    if (autosave != null) {
      $result.autosave = autosave;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  CreateAutoSaveResponse._() : super();
  factory CreateAutoSaveResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateAutoSaveResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateAutoSaveResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOM<AutoSave>(1, _omitFieldNames ? '' : 'autosave', subBuilder: AutoSave.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateAutoSaveResponse clone() => CreateAutoSaveResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateAutoSaveResponse copyWith(void Function(CreateAutoSaveResponse) updates) => super.copyWith((message) => updates(message as CreateAutoSaveResponse)) as CreateAutoSaveResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateAutoSaveResponse create() => CreateAutoSaveResponse._();
  CreateAutoSaveResponse createEmptyInstance() => create();
  static $pb.PbList<CreateAutoSaveResponse> createRepeated() => $pb.PbList<CreateAutoSaveResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateAutoSaveResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateAutoSaveResponse>(create);
  static CreateAutoSaveResponse? _defaultInstance;

  @$pb.TagNumber(1)
  AutoSave get autosave => $_getN(0);
  @$pb.TagNumber(1)
  set autosave(AutoSave v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasAutosave() => $_has(0);
  @$pb.TagNumber(1)
  void clearAutosave() => clearField(1);
  @$pb.TagNumber(1)
  AutoSave ensureAutosave() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

/// NOTE: user_id extracted from JWT token, not from request
class GetAutoSavesRequest extends $pb.GeneratedMessage {
  factory GetAutoSavesRequest({
    $core.String? accountId,
    $core.String? status,
  }) {
    final $result = create();
    if (accountId != null) {
      $result.accountId = accountId;
    }
    if (status != null) {
      $result.status = status;
    }
    return $result;
  }
  GetAutoSavesRequest._() : super();
  factory GetAutoSavesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAutoSavesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetAutoSavesRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountId')
    ..aOS(2, _omitFieldNames ? '' : 'status')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAutoSavesRequest clone() => GetAutoSavesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAutoSavesRequest copyWith(void Function(GetAutoSavesRequest) updates) => super.copyWith((message) => updates(message as GetAutoSavesRequest)) as GetAutoSavesRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAutoSavesRequest create() => GetAutoSavesRequest._();
  GetAutoSavesRequest createEmptyInstance() => create();
  static $pb.PbList<GetAutoSavesRequest> createRepeated() => $pb.PbList<GetAutoSavesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetAutoSavesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAutoSavesRequest>(create);
  static GetAutoSavesRequest? _defaultInstance;

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

class GetAutoSavesResponse extends $pb.GeneratedMessage {
  factory GetAutoSavesResponse({
    $core.Iterable<AutoSave>? autosaves,
    $core.int? total,
  }) {
    final $result = create();
    if (autosaves != null) {
      $result.autosaves.addAll(autosaves);
    }
    if (total != null) {
      $result.total = total;
    }
    return $result;
  }
  GetAutoSavesResponse._() : super();
  factory GetAutoSavesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAutoSavesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetAutoSavesResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..pc<AutoSave>(1, _omitFieldNames ? '' : 'autosaves', $pb.PbFieldType.PM, subBuilder: AutoSave.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAutoSavesResponse clone() => GetAutoSavesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAutoSavesResponse copyWith(void Function(GetAutoSavesResponse) updates) => super.copyWith((message) => updates(message as GetAutoSavesResponse)) as GetAutoSavesResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAutoSavesResponse create() => GetAutoSavesResponse._();
  GetAutoSavesResponse createEmptyInstance() => create();
  static $pb.PbList<GetAutoSavesResponse> createRepeated() => $pb.PbList<GetAutoSavesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetAutoSavesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAutoSavesResponse>(create);
  static GetAutoSavesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<AutoSave> get autosaves => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => clearField(2);
}

/// NOTE: user_id extracted from JWT token, not from request
class UpdateAutoSaveRequest extends $pb.GeneratedMessage {
  factory UpdateAutoSaveRequest({
    $core.String? autosaveId,
    $core.double? amount,
    $core.String? frequency,
    $core.String? status,
    $core.double? targetAmount,
  }) {
    final $result = create();
    if (autosaveId != null) {
      $result.autosaveId = autosaveId;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (frequency != null) {
      $result.frequency = frequency;
    }
    if (status != null) {
      $result.status = status;
    }
    if (targetAmount != null) {
      $result.targetAmount = targetAmount;
    }
    return $result;
  }
  UpdateAutoSaveRequest._() : super();
  factory UpdateAutoSaveRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateAutoSaveRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateAutoSaveRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'autosaveId')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(3, _omitFieldNames ? '' : 'frequency')
    ..aOS(4, _omitFieldNames ? '' : 'status')
    ..a<$core.double>(5, _omitFieldNames ? '' : 'targetAmount', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateAutoSaveRequest clone() => UpdateAutoSaveRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateAutoSaveRequest copyWith(void Function(UpdateAutoSaveRequest) updates) => super.copyWith((message) => updates(message as UpdateAutoSaveRequest)) as UpdateAutoSaveRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateAutoSaveRequest create() => UpdateAutoSaveRequest._();
  UpdateAutoSaveRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateAutoSaveRequest> createRepeated() => $pb.PbList<UpdateAutoSaveRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateAutoSaveRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateAutoSaveRequest>(create);
  static UpdateAutoSaveRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get autosaveId => $_getSZ(0);
  @$pb.TagNumber(1)
  set autosaveId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAutosaveId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAutosaveId() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get amount => $_getN(1);
  @$pb.TagNumber(2)
  set amount($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get frequency => $_getSZ(2);
  @$pb.TagNumber(3)
  set frequency($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasFrequency() => $_has(2);
  @$pb.TagNumber(3)
  void clearFrequency() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get status => $_getSZ(3);
  @$pb.TagNumber(4)
  set status($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasStatus() => $_has(3);
  @$pb.TagNumber(4)
  void clearStatus() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get targetAmount => $_getN(4);
  @$pb.TagNumber(5)
  set targetAmount($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTargetAmount() => $_has(4);
  @$pb.TagNumber(5)
  void clearTargetAmount() => clearField(5);
}

class UpdateAutoSaveResponse extends $pb.GeneratedMessage {
  factory UpdateAutoSaveResponse({
    AutoSave? autosave,
    $core.String? message,
  }) {
    final $result = create();
    if (autosave != null) {
      $result.autosave = autosave;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  UpdateAutoSaveResponse._() : super();
  factory UpdateAutoSaveResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateAutoSaveResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateAutoSaveResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOM<AutoSave>(1, _omitFieldNames ? '' : 'autosave', subBuilder: AutoSave.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateAutoSaveResponse clone() => UpdateAutoSaveResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateAutoSaveResponse copyWith(void Function(UpdateAutoSaveResponse) updates) => super.copyWith((message) => updates(message as UpdateAutoSaveResponse)) as UpdateAutoSaveResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateAutoSaveResponse create() => UpdateAutoSaveResponse._();
  UpdateAutoSaveResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateAutoSaveResponse> createRepeated() => $pb.PbList<UpdateAutoSaveResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateAutoSaveResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateAutoSaveResponse>(create);
  static UpdateAutoSaveResponse? _defaultInstance;

  @$pb.TagNumber(1)
  AutoSave get autosave => $_getN(0);
  @$pb.TagNumber(1)
  set autosave(AutoSave v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasAutosave() => $_has(0);
  @$pb.TagNumber(1)
  void clearAutosave() => clearField(1);
  @$pb.TagNumber(1)
  AutoSave ensureAutosave() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

/// NOTE: user_id extracted from JWT token, not from request
class DeleteAutoSaveRequest extends $pb.GeneratedMessage {
  factory DeleteAutoSaveRequest({
    $core.String? autosaveId,
  }) {
    final $result = create();
    if (autosaveId != null) {
      $result.autosaveId = autosaveId;
    }
    return $result;
  }
  DeleteAutoSaveRequest._() : super();
  factory DeleteAutoSaveRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteAutoSaveRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DeleteAutoSaveRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'autosaveId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteAutoSaveRequest clone() => DeleteAutoSaveRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteAutoSaveRequest copyWith(void Function(DeleteAutoSaveRequest) updates) => super.copyWith((message) => updates(message as DeleteAutoSaveRequest)) as DeleteAutoSaveRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteAutoSaveRequest create() => DeleteAutoSaveRequest._();
  DeleteAutoSaveRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteAutoSaveRequest> createRepeated() => $pb.PbList<DeleteAutoSaveRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteAutoSaveRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteAutoSaveRequest>(create);
  static DeleteAutoSaveRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get autosaveId => $_getSZ(0);
  @$pb.TagNumber(1)
  set autosaveId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAutosaveId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAutosaveId() => clearField(1);
}

class DeleteAutoSaveResponse extends $pb.GeneratedMessage {
  factory DeleteAutoSaveResponse({
    $core.bool? success,
    $core.String? message,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  DeleteAutoSaveResponse._() : super();
  factory DeleteAutoSaveResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteAutoSaveResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DeleteAutoSaveResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteAutoSaveResponse clone() => DeleteAutoSaveResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteAutoSaveResponse copyWith(void Function(DeleteAutoSaveResponse) updates) => super.copyWith((message) => updates(message as DeleteAutoSaveResponse)) as DeleteAutoSaveResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteAutoSaveResponse create() => DeleteAutoSaveResponse._();
  DeleteAutoSaveResponse createEmptyInstance() => create();
  static $pb.PbList<DeleteAutoSaveResponse> createRepeated() => $pb.PbList<DeleteAutoSaveResponse>();
  @$core.pragma('dart2js:noInline')
  static DeleteAutoSaveResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteAutoSaveResponse>(create);
  static DeleteAutoSaveResponse? _defaultInstance;

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

/// === LockFunds / PiggyVault ===
class LockFunds extends $pb.GeneratedMessage {
  factory LockFunds({
    $core.String? id,
    $core.String? accountId,
    $core.String? userId,
    $core.String? name,
    $core.double? amount,
    $core.String? lockType,
    $core.String? status,
    $core.String? unlockDate,
    $core.double? targetAmount,
    $core.double? penaltyRate,
    $core.String? createdAt,
    $core.String? maturedAt,
    $core.bool? autoRenew,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (accountId != null) {
      $result.accountId = accountId;
    }
    if (userId != null) {
      $result.userId = userId;
    }
    if (name != null) {
      $result.name = name;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (lockType != null) {
      $result.lockType = lockType;
    }
    if (status != null) {
      $result.status = status;
    }
    if (unlockDate != null) {
      $result.unlockDate = unlockDate;
    }
    if (targetAmount != null) {
      $result.targetAmount = targetAmount;
    }
    if (penaltyRate != null) {
      $result.penaltyRate = penaltyRate;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    if (maturedAt != null) {
      $result.maturedAt = maturedAt;
    }
    if (autoRenew != null) {
      $result.autoRenew = autoRenew;
    }
    return $result;
  }
  LockFunds._() : super();
  factory LockFunds.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LockFunds.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'LockFunds', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'accountId')
    ..aOS(3, _omitFieldNames ? '' : 'userId')
    ..aOS(4, _omitFieldNames ? '' : 'name')
    ..a<$core.double>(5, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(6, _omitFieldNames ? '' : 'lockType')
    ..aOS(7, _omitFieldNames ? '' : 'status')
    ..aOS(8, _omitFieldNames ? '' : 'unlockDate')
    ..a<$core.double>(9, _omitFieldNames ? '' : 'targetAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(10, _omitFieldNames ? '' : 'penaltyRate', $pb.PbFieldType.OD)
    ..aOS(11, _omitFieldNames ? '' : 'createdAt')
    ..aOS(12, _omitFieldNames ? '' : 'maturedAt')
    ..aOB(13, _omitFieldNames ? '' : 'autoRenew')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LockFunds clone() => LockFunds()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LockFunds copyWith(void Function(LockFunds) updates) => super.copyWith((message) => updates(message as LockFunds)) as LockFunds;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LockFunds create() => LockFunds._();
  LockFunds createEmptyInstance() => create();
  static $pb.PbList<LockFunds> createRepeated() => $pb.PbList<LockFunds>();
  @$core.pragma('dart2js:noInline')
  static LockFunds getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LockFunds>(create);
  static LockFunds? _defaultInstance;

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
  $core.String get name => $_getSZ(3);
  @$pb.TagNumber(4)
  set name($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasName() => $_has(3);
  @$pb.TagNumber(4)
  void clearName() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get amount => $_getN(4);
  @$pb.TagNumber(5)
  set amount($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasAmount() => $_has(4);
  @$pb.TagNumber(5)
  void clearAmount() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get lockType => $_getSZ(5);
  @$pb.TagNumber(6)
  set lockType($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasLockType() => $_has(5);
  @$pb.TagNumber(6)
  void clearLockType() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get status => $_getSZ(6);
  @$pb.TagNumber(7)
  set status($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasStatus() => $_has(6);
  @$pb.TagNumber(7)
  void clearStatus() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get unlockDate => $_getSZ(7);
  @$pb.TagNumber(8)
  set unlockDate($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasUnlockDate() => $_has(7);
  @$pb.TagNumber(8)
  void clearUnlockDate() => clearField(8);

  @$pb.TagNumber(9)
  $core.double get targetAmount => $_getN(8);
  @$pb.TagNumber(9)
  set targetAmount($core.double v) { $_setDouble(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasTargetAmount() => $_has(8);
  @$pb.TagNumber(9)
  void clearTargetAmount() => clearField(9);

  @$pb.TagNumber(10)
  $core.double get penaltyRate => $_getN(9);
  @$pb.TagNumber(10)
  set penaltyRate($core.double v) { $_setDouble(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasPenaltyRate() => $_has(9);
  @$pb.TagNumber(10)
  void clearPenaltyRate() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get createdAt => $_getSZ(10);
  @$pb.TagNumber(11)
  set createdAt($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasCreatedAt() => $_has(10);
  @$pb.TagNumber(11)
  void clearCreatedAt() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get maturedAt => $_getSZ(11);
  @$pb.TagNumber(12)
  set maturedAt($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasMaturedAt() => $_has(11);
  @$pb.TagNumber(12)
  void clearMaturedAt() => clearField(12);

  @$pb.TagNumber(13)
  $core.bool get autoRenew => $_getBF(12);
  @$pb.TagNumber(13)
  set autoRenew($core.bool v) { $_setBool(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasAutoRenew() => $_has(12);
  @$pb.TagNumber(13)
  void clearAutoRenew() => clearField(13);
}

/// NOTE: user_id extracted from JWT token, not from request
class CreateLockFundsRequest extends $pb.GeneratedMessage {
  factory CreateLockFundsRequest({
    $core.String? accountId,
    $core.String? name,
    $core.double? amount,
    $core.String? lockType,
    $core.String? unlockDate,
    $core.double? targetAmount,
    $core.double? penaltyRate,
    $core.String? pin,
    $core.bool? autoRenew,
  }) {
    final $result = create();
    if (accountId != null) {
      $result.accountId = accountId;
    }
    if (name != null) {
      $result.name = name;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (lockType != null) {
      $result.lockType = lockType;
    }
    if (unlockDate != null) {
      $result.unlockDate = unlockDate;
    }
    if (targetAmount != null) {
      $result.targetAmount = targetAmount;
    }
    if (penaltyRate != null) {
      $result.penaltyRate = penaltyRate;
    }
    if (pin != null) {
      $result.pin = pin;
    }
    if (autoRenew != null) {
      $result.autoRenew = autoRenew;
    }
    return $result;
  }
  CreateLockFundsRequest._() : super();
  factory CreateLockFundsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateLockFundsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateLockFundsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountId')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(4, _omitFieldNames ? '' : 'lockType')
    ..aOS(5, _omitFieldNames ? '' : 'unlockDate')
    ..a<$core.double>(6, _omitFieldNames ? '' : 'targetAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(7, _omitFieldNames ? '' : 'penaltyRate', $pb.PbFieldType.OD)
    ..aOS(8, _omitFieldNames ? '' : 'pin')
    ..aOB(9, _omitFieldNames ? '' : 'autoRenew')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateLockFundsRequest clone() => CreateLockFundsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateLockFundsRequest copyWith(void Function(CreateLockFundsRequest) updates) => super.copyWith((message) => updates(message as CreateLockFundsRequest)) as CreateLockFundsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateLockFundsRequest create() => CreateLockFundsRequest._();
  CreateLockFundsRequest createEmptyInstance() => create();
  static $pb.PbList<CreateLockFundsRequest> createRepeated() => $pb.PbList<CreateLockFundsRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateLockFundsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateLockFundsRequest>(create);
  static CreateLockFundsRequest? _defaultInstance;

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
  $core.double get amount => $_getN(2);
  @$pb.TagNumber(3)
  set amount($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get lockType => $_getSZ(3);
  @$pb.TagNumber(4)
  set lockType($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasLockType() => $_has(3);
  @$pb.TagNumber(4)
  void clearLockType() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get unlockDate => $_getSZ(4);
  @$pb.TagNumber(5)
  set unlockDate($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasUnlockDate() => $_has(4);
  @$pb.TagNumber(5)
  void clearUnlockDate() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get targetAmount => $_getN(5);
  @$pb.TagNumber(6)
  set targetAmount($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasTargetAmount() => $_has(5);
  @$pb.TagNumber(6)
  void clearTargetAmount() => clearField(6);

  @$pb.TagNumber(7)
  $core.double get penaltyRate => $_getN(6);
  @$pb.TagNumber(7)
  set penaltyRate($core.double v) { $_setDouble(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasPenaltyRate() => $_has(6);
  @$pb.TagNumber(7)
  void clearPenaltyRate() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get pin => $_getSZ(7);
  @$pb.TagNumber(8)
  set pin($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasPin() => $_has(7);
  @$pb.TagNumber(8)
  void clearPin() => clearField(8);

  @$pb.TagNumber(9)
  $core.bool get autoRenew => $_getBF(8);
  @$pb.TagNumber(9)
  set autoRenew($core.bool v) { $_setBool(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasAutoRenew() => $_has(8);
  @$pb.TagNumber(9)
  void clearAutoRenew() => clearField(9);
}

class CreateLockFundsResponse extends $pb.GeneratedMessage {
  factory CreateLockFundsResponse({
    LockFunds? lockfunds,
    Transaction? transaction,
    $core.double? newAvailableBalance,
    $core.String? message,
  }) {
    final $result = create();
    if (lockfunds != null) {
      $result.lockfunds = lockfunds;
    }
    if (transaction != null) {
      $result.transaction = transaction;
    }
    if (newAvailableBalance != null) {
      $result.newAvailableBalance = newAvailableBalance;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  CreateLockFundsResponse._() : super();
  factory CreateLockFundsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateLockFundsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateLockFundsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOM<LockFunds>(1, _omitFieldNames ? '' : 'lockfunds', subBuilder: LockFunds.create)
    ..aOM<Transaction>(2, _omitFieldNames ? '' : 'transaction', subBuilder: Transaction.create)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'newAvailableBalance', $pb.PbFieldType.OD)
    ..aOS(4, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateLockFundsResponse clone() => CreateLockFundsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateLockFundsResponse copyWith(void Function(CreateLockFundsResponse) updates) => super.copyWith((message) => updates(message as CreateLockFundsResponse)) as CreateLockFundsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateLockFundsResponse create() => CreateLockFundsResponse._();
  CreateLockFundsResponse createEmptyInstance() => create();
  static $pb.PbList<CreateLockFundsResponse> createRepeated() => $pb.PbList<CreateLockFundsResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateLockFundsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateLockFundsResponse>(create);
  static CreateLockFundsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  LockFunds get lockfunds => $_getN(0);
  @$pb.TagNumber(1)
  set lockfunds(LockFunds v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasLockfunds() => $_has(0);
  @$pb.TagNumber(1)
  void clearLockfunds() => clearField(1);
  @$pb.TagNumber(1)
  LockFunds ensureLockfunds() => $_ensure(0);

  @$pb.TagNumber(2)
  Transaction get transaction => $_getN(1);
  @$pb.TagNumber(2)
  set transaction(Transaction v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasTransaction() => $_has(1);
  @$pb.TagNumber(2)
  void clearTransaction() => clearField(2);
  @$pb.TagNumber(2)
  Transaction ensureTransaction() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.double get newAvailableBalance => $_getN(2);
  @$pb.TagNumber(3)
  set newAvailableBalance($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasNewAvailableBalance() => $_has(2);
  @$pb.TagNumber(3)
  void clearNewAvailableBalance() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get message => $_getSZ(3);
  @$pb.TagNumber(4)
  set message($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasMessage() => $_has(3);
  @$pb.TagNumber(4)
  void clearMessage() => clearField(4);
}

/// NOTE: user_id extracted from JWT token, not from request
class GetLockFundsRequest extends $pb.GeneratedMessage {
  factory GetLockFundsRequest({
    $core.String? accountId,
    $core.String? status,
  }) {
    final $result = create();
    if (accountId != null) {
      $result.accountId = accountId;
    }
    if (status != null) {
      $result.status = status;
    }
    return $result;
  }
  GetLockFundsRequest._() : super();
  factory GetLockFundsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetLockFundsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetLockFundsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountId')
    ..aOS(2, _omitFieldNames ? '' : 'status')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetLockFundsRequest clone() => GetLockFundsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetLockFundsRequest copyWith(void Function(GetLockFundsRequest) updates) => super.copyWith((message) => updates(message as GetLockFundsRequest)) as GetLockFundsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetLockFundsRequest create() => GetLockFundsRequest._();
  GetLockFundsRequest createEmptyInstance() => create();
  static $pb.PbList<GetLockFundsRequest> createRepeated() => $pb.PbList<GetLockFundsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetLockFundsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetLockFundsRequest>(create);
  static GetLockFundsRequest? _defaultInstance;

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

class GetLockFundsResponse extends $pb.GeneratedMessage {
  factory GetLockFundsResponse({
    $core.Iterable<LockFunds>? lockfunds,
    $core.int? total,
    $core.double? totalLockedAmount,
  }) {
    final $result = create();
    if (lockfunds != null) {
      $result.lockfunds.addAll(lockfunds);
    }
    if (total != null) {
      $result.total = total;
    }
    if (totalLockedAmount != null) {
      $result.totalLockedAmount = totalLockedAmount;
    }
    return $result;
  }
  GetLockFundsResponse._() : super();
  factory GetLockFundsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetLockFundsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetLockFundsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..pc<LockFunds>(1, _omitFieldNames ? '' : 'lockfunds', $pb.PbFieldType.PM, subBuilder: LockFunds.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'totalLockedAmount', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetLockFundsResponse clone() => GetLockFundsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetLockFundsResponse copyWith(void Function(GetLockFundsResponse) updates) => super.copyWith((message) => updates(message as GetLockFundsResponse)) as GetLockFundsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetLockFundsResponse create() => GetLockFundsResponse._();
  GetLockFundsResponse createEmptyInstance() => create();
  static $pb.PbList<GetLockFundsResponse> createRepeated() => $pb.PbList<GetLockFundsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetLockFundsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetLockFundsResponse>(create);
  static GetLockFundsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<LockFunds> get lockfunds => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get totalLockedAmount => $_getN(2);
  @$pb.TagNumber(3)
  set totalLockedAmount($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTotalLockedAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalLockedAmount() => clearField(3);
}

/// NOTE: user_id extracted from JWT token, not from request
class UnlockFundsRequest extends $pb.GeneratedMessage {
  factory UnlockFundsRequest({
    $core.String? lockfundsId,
    $core.String? pin,
    $core.bool? forceUnlock,
  }) {
    final $result = create();
    if (lockfundsId != null) {
      $result.lockfundsId = lockfundsId;
    }
    if (pin != null) {
      $result.pin = pin;
    }
    if (forceUnlock != null) {
      $result.forceUnlock = forceUnlock;
    }
    return $result;
  }
  UnlockFundsRequest._() : super();
  factory UnlockFundsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UnlockFundsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UnlockFundsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'lockfundsId')
    ..aOS(2, _omitFieldNames ? '' : 'pin')
    ..aOB(3, _omitFieldNames ? '' : 'forceUnlock')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UnlockFundsRequest clone() => UnlockFundsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UnlockFundsRequest copyWith(void Function(UnlockFundsRequest) updates) => super.copyWith((message) => updates(message as UnlockFundsRequest)) as UnlockFundsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UnlockFundsRequest create() => UnlockFundsRequest._();
  UnlockFundsRequest createEmptyInstance() => create();
  static $pb.PbList<UnlockFundsRequest> createRepeated() => $pb.PbList<UnlockFundsRequest>();
  @$core.pragma('dart2js:noInline')
  static UnlockFundsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UnlockFundsRequest>(create);
  static UnlockFundsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get lockfundsId => $_getSZ(0);
  @$pb.TagNumber(1)
  set lockfundsId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLockfundsId() => $_has(0);
  @$pb.TagNumber(1)
  void clearLockfundsId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get pin => $_getSZ(1);
  @$pb.TagNumber(2)
  set pin($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPin() => $_has(1);
  @$pb.TagNumber(2)
  void clearPin() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get forceUnlock => $_getBF(2);
  @$pb.TagNumber(3)
  set forceUnlock($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasForceUnlock() => $_has(2);
  @$pb.TagNumber(3)
  void clearForceUnlock() => clearField(3);
}

class UnlockFundsResponse extends $pb.GeneratedMessage {
  factory UnlockFundsResponse({
    LockFunds? lockfunds,
    Transaction? transaction,
    $core.double? penaltyAmount,
    $core.double? releasedAmount,
    $core.double? newAvailableBalance,
    $core.String? message,
  }) {
    final $result = create();
    if (lockfunds != null) {
      $result.lockfunds = lockfunds;
    }
    if (transaction != null) {
      $result.transaction = transaction;
    }
    if (penaltyAmount != null) {
      $result.penaltyAmount = penaltyAmount;
    }
    if (releasedAmount != null) {
      $result.releasedAmount = releasedAmount;
    }
    if (newAvailableBalance != null) {
      $result.newAvailableBalance = newAvailableBalance;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  UnlockFundsResponse._() : super();
  factory UnlockFundsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UnlockFundsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UnlockFundsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOM<LockFunds>(1, _omitFieldNames ? '' : 'lockfunds', subBuilder: LockFunds.create)
    ..aOM<Transaction>(2, _omitFieldNames ? '' : 'transaction', subBuilder: Transaction.create)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'penaltyAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'releasedAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(5, _omitFieldNames ? '' : 'newAvailableBalance', $pb.PbFieldType.OD)
    ..aOS(6, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UnlockFundsResponse clone() => UnlockFundsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UnlockFundsResponse copyWith(void Function(UnlockFundsResponse) updates) => super.copyWith((message) => updates(message as UnlockFundsResponse)) as UnlockFundsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UnlockFundsResponse create() => UnlockFundsResponse._();
  UnlockFundsResponse createEmptyInstance() => create();
  static $pb.PbList<UnlockFundsResponse> createRepeated() => $pb.PbList<UnlockFundsResponse>();
  @$core.pragma('dart2js:noInline')
  static UnlockFundsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UnlockFundsResponse>(create);
  static UnlockFundsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  LockFunds get lockfunds => $_getN(0);
  @$pb.TagNumber(1)
  set lockfunds(LockFunds v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasLockfunds() => $_has(0);
  @$pb.TagNumber(1)
  void clearLockfunds() => clearField(1);
  @$pb.TagNumber(1)
  LockFunds ensureLockfunds() => $_ensure(0);

  @$pb.TagNumber(2)
  Transaction get transaction => $_getN(1);
  @$pb.TagNumber(2)
  set transaction(Transaction v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasTransaction() => $_has(1);
  @$pb.TagNumber(2)
  void clearTransaction() => clearField(2);
  @$pb.TagNumber(2)
  Transaction ensureTransaction() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.double get penaltyAmount => $_getN(2);
  @$pb.TagNumber(3)
  set penaltyAmount($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPenaltyAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearPenaltyAmount() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get releasedAmount => $_getN(3);
  @$pb.TagNumber(4)
  set releasedAmount($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasReleasedAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearReleasedAmount() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get newAvailableBalance => $_getN(4);
  @$pb.TagNumber(5)
  set newAvailableBalance($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasNewAvailableBalance() => $_has(4);
  @$pb.TagNumber(5)
  void clearNewAvailableBalance() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get message => $_getSZ(5);
  @$pb.TagNumber(6)
  set message($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasMessage() => $_has(5);
  @$pb.TagNumber(6)
  void clearMessage() => clearField(6);
}

/// === PiggyVault Config (Backend-Configurable ROI) ===
class PiggyVaultConfigProto extends $pb.GeneratedMessage {
  factory PiggyVaultConfigProto({
    $core.String? id,
    $core.String? lockType,
    $core.String? currency,
    $core.String? displayName,
    $core.double? baseInterestRate,
    $core.double? maxInterestRate,
    $core.double? earlyWithdrawalPenalty,
    $core.int? minDurationDays,
    $core.int? maxDurationDays,
    $core.double? minAmount,
    $core.double? maxAmount,
    $core.bool? allowsEarlyWithdrawal,
    $core.bool? supportsAutoRenew,
    $core.bool? supportsTopUp,
    $core.bool? supportsAutoSave,
    $core.bool? supportsUpfrontInterest,
    $core.String? durationBonusTiers,
    $core.bool? isActive,
    $core.String? description,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (lockType != null) {
      $result.lockType = lockType;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (displayName != null) {
      $result.displayName = displayName;
    }
    if (baseInterestRate != null) {
      $result.baseInterestRate = baseInterestRate;
    }
    if (maxInterestRate != null) {
      $result.maxInterestRate = maxInterestRate;
    }
    if (earlyWithdrawalPenalty != null) {
      $result.earlyWithdrawalPenalty = earlyWithdrawalPenalty;
    }
    if (minDurationDays != null) {
      $result.minDurationDays = minDurationDays;
    }
    if (maxDurationDays != null) {
      $result.maxDurationDays = maxDurationDays;
    }
    if (minAmount != null) {
      $result.minAmount = minAmount;
    }
    if (maxAmount != null) {
      $result.maxAmount = maxAmount;
    }
    if (allowsEarlyWithdrawal != null) {
      $result.allowsEarlyWithdrawal = allowsEarlyWithdrawal;
    }
    if (supportsAutoRenew != null) {
      $result.supportsAutoRenew = supportsAutoRenew;
    }
    if (supportsTopUp != null) {
      $result.supportsTopUp = supportsTopUp;
    }
    if (supportsAutoSave != null) {
      $result.supportsAutoSave = supportsAutoSave;
    }
    if (supportsUpfrontInterest != null) {
      $result.supportsUpfrontInterest = supportsUpfrontInterest;
    }
    if (durationBonusTiers != null) {
      $result.durationBonusTiers = durationBonusTiers;
    }
    if (isActive != null) {
      $result.isActive = isActive;
    }
    if (description != null) {
      $result.description = description;
    }
    return $result;
  }
  PiggyVaultConfigProto._() : super();
  factory PiggyVaultConfigProto.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PiggyVaultConfigProto.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PiggyVaultConfigProto', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'lockType')
    ..aOS(3, _omitFieldNames ? '' : 'currency')
    ..aOS(4, _omitFieldNames ? '' : 'displayName')
    ..a<$core.double>(5, _omitFieldNames ? '' : 'baseInterestRate', $pb.PbFieldType.OD)
    ..a<$core.double>(6, _omitFieldNames ? '' : 'maxInterestRate', $pb.PbFieldType.OD)
    ..a<$core.double>(7, _omitFieldNames ? '' : 'earlyWithdrawalPenalty', $pb.PbFieldType.OD)
    ..a<$core.int>(8, _omitFieldNames ? '' : 'minDurationDays', $pb.PbFieldType.O3)
    ..a<$core.int>(9, _omitFieldNames ? '' : 'maxDurationDays', $pb.PbFieldType.O3)
    ..a<$core.double>(10, _omitFieldNames ? '' : 'minAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(11, _omitFieldNames ? '' : 'maxAmount', $pb.PbFieldType.OD)
    ..aOB(12, _omitFieldNames ? '' : 'allowsEarlyWithdrawal')
    ..aOB(13, _omitFieldNames ? '' : 'supportsAutoRenew')
    ..aOB(14, _omitFieldNames ? '' : 'supportsTopUp')
    ..aOB(15, _omitFieldNames ? '' : 'supportsAutoSave')
    ..aOB(16, _omitFieldNames ? '' : 'supportsUpfrontInterest')
    ..aOS(17, _omitFieldNames ? '' : 'durationBonusTiers')
    ..aOB(18, _omitFieldNames ? '' : 'isActive')
    ..aOS(19, _omitFieldNames ? '' : 'description')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PiggyVaultConfigProto clone() => PiggyVaultConfigProto()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PiggyVaultConfigProto copyWith(void Function(PiggyVaultConfigProto) updates) => super.copyWith((message) => updates(message as PiggyVaultConfigProto)) as PiggyVaultConfigProto;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PiggyVaultConfigProto create() => PiggyVaultConfigProto._();
  PiggyVaultConfigProto createEmptyInstance() => create();
  static $pb.PbList<PiggyVaultConfigProto> createRepeated() => $pb.PbList<PiggyVaultConfigProto>();
  @$core.pragma('dart2js:noInline')
  static PiggyVaultConfigProto getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PiggyVaultConfigProto>(create);
  static PiggyVaultConfigProto? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get lockType => $_getSZ(1);
  @$pb.TagNumber(2)
  set lockType($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLockType() => $_has(1);
  @$pb.TagNumber(2)
  void clearLockType() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get currency => $_getSZ(2);
  @$pb.TagNumber(3)
  set currency($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCurrency() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrency() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get displayName => $_getSZ(3);
  @$pb.TagNumber(4)
  set displayName($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasDisplayName() => $_has(3);
  @$pb.TagNumber(4)
  void clearDisplayName() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get baseInterestRate => $_getN(4);
  @$pb.TagNumber(5)
  set baseInterestRate($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasBaseInterestRate() => $_has(4);
  @$pb.TagNumber(5)
  void clearBaseInterestRate() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get maxInterestRate => $_getN(5);
  @$pb.TagNumber(6)
  set maxInterestRate($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasMaxInterestRate() => $_has(5);
  @$pb.TagNumber(6)
  void clearMaxInterestRate() => clearField(6);

  @$pb.TagNumber(7)
  $core.double get earlyWithdrawalPenalty => $_getN(6);
  @$pb.TagNumber(7)
  set earlyWithdrawalPenalty($core.double v) { $_setDouble(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasEarlyWithdrawalPenalty() => $_has(6);
  @$pb.TagNumber(7)
  void clearEarlyWithdrawalPenalty() => clearField(7);

  @$pb.TagNumber(8)
  $core.int get minDurationDays => $_getIZ(7);
  @$pb.TagNumber(8)
  set minDurationDays($core.int v) { $_setSignedInt32(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasMinDurationDays() => $_has(7);
  @$pb.TagNumber(8)
  void clearMinDurationDays() => clearField(8);

  @$pb.TagNumber(9)
  $core.int get maxDurationDays => $_getIZ(8);
  @$pb.TagNumber(9)
  set maxDurationDays($core.int v) { $_setSignedInt32(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasMaxDurationDays() => $_has(8);
  @$pb.TagNumber(9)
  void clearMaxDurationDays() => clearField(9);

  @$pb.TagNumber(10)
  $core.double get minAmount => $_getN(9);
  @$pb.TagNumber(10)
  set minAmount($core.double v) { $_setDouble(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasMinAmount() => $_has(9);
  @$pb.TagNumber(10)
  void clearMinAmount() => clearField(10);

  @$pb.TagNumber(11)
  $core.double get maxAmount => $_getN(10);
  @$pb.TagNumber(11)
  set maxAmount($core.double v) { $_setDouble(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasMaxAmount() => $_has(10);
  @$pb.TagNumber(11)
  void clearMaxAmount() => clearField(11);

  @$pb.TagNumber(12)
  $core.bool get allowsEarlyWithdrawal => $_getBF(11);
  @$pb.TagNumber(12)
  set allowsEarlyWithdrawal($core.bool v) { $_setBool(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasAllowsEarlyWithdrawal() => $_has(11);
  @$pb.TagNumber(12)
  void clearAllowsEarlyWithdrawal() => clearField(12);

  @$pb.TagNumber(13)
  $core.bool get supportsAutoRenew => $_getBF(12);
  @$pb.TagNumber(13)
  set supportsAutoRenew($core.bool v) { $_setBool(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasSupportsAutoRenew() => $_has(12);
  @$pb.TagNumber(13)
  void clearSupportsAutoRenew() => clearField(13);

  @$pb.TagNumber(14)
  $core.bool get supportsTopUp => $_getBF(13);
  @$pb.TagNumber(14)
  set supportsTopUp($core.bool v) { $_setBool(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasSupportsTopUp() => $_has(13);
  @$pb.TagNumber(14)
  void clearSupportsTopUp() => clearField(14);

  @$pb.TagNumber(15)
  $core.bool get supportsAutoSave => $_getBF(14);
  @$pb.TagNumber(15)
  set supportsAutoSave($core.bool v) { $_setBool(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasSupportsAutoSave() => $_has(14);
  @$pb.TagNumber(15)
  void clearSupportsAutoSave() => clearField(15);

  @$pb.TagNumber(16)
  $core.bool get supportsUpfrontInterest => $_getBF(15);
  @$pb.TagNumber(16)
  set supportsUpfrontInterest($core.bool v) { $_setBool(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasSupportsUpfrontInterest() => $_has(15);
  @$pb.TagNumber(16)
  void clearSupportsUpfrontInterest() => clearField(16);

  @$pb.TagNumber(17)
  $core.String get durationBonusTiers => $_getSZ(16);
  @$pb.TagNumber(17)
  set durationBonusTiers($core.String v) { $_setString(16, v); }
  @$pb.TagNumber(17)
  $core.bool hasDurationBonusTiers() => $_has(16);
  @$pb.TagNumber(17)
  void clearDurationBonusTiers() => clearField(17);

  @$pb.TagNumber(18)
  $core.bool get isActive => $_getBF(17);
  @$pb.TagNumber(18)
  set isActive($core.bool v) { $_setBool(17, v); }
  @$pb.TagNumber(18)
  $core.bool hasIsActive() => $_has(17);
  @$pb.TagNumber(18)
  void clearIsActive() => clearField(18);

  @$pb.TagNumber(19)
  $core.String get description => $_getSZ(18);
  @$pb.TagNumber(19)
  set description($core.String v) { $_setString(18, v); }
  @$pb.TagNumber(19)
  $core.bool hasDescription() => $_has(18);
  @$pb.TagNumber(19)
  void clearDescription() => clearField(19);
}

class GetPiggyVaultConfigRequest extends $pb.GeneratedMessage {
  factory GetPiggyVaultConfigRequest({
    $core.String? lockType,
    $core.String? currency,
  }) {
    final $result = create();
    if (lockType != null) {
      $result.lockType = lockType;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    return $result;
  }
  GetPiggyVaultConfigRequest._() : super();
  factory GetPiggyVaultConfigRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPiggyVaultConfigRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetPiggyVaultConfigRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'lockType')
    ..aOS(2, _omitFieldNames ? '' : 'currency')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPiggyVaultConfigRequest clone() => GetPiggyVaultConfigRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPiggyVaultConfigRequest copyWith(void Function(GetPiggyVaultConfigRequest) updates) => super.copyWith((message) => updates(message as GetPiggyVaultConfigRequest)) as GetPiggyVaultConfigRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPiggyVaultConfigRequest create() => GetPiggyVaultConfigRequest._();
  GetPiggyVaultConfigRequest createEmptyInstance() => create();
  static $pb.PbList<GetPiggyVaultConfigRequest> createRepeated() => $pb.PbList<GetPiggyVaultConfigRequest>();
  @$core.pragma('dart2js:noInline')
  static GetPiggyVaultConfigRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetPiggyVaultConfigRequest>(create);
  static GetPiggyVaultConfigRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get lockType => $_getSZ(0);
  @$pb.TagNumber(1)
  set lockType($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLockType() => $_has(0);
  @$pb.TagNumber(1)
  void clearLockType() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get currency => $_getSZ(1);
  @$pb.TagNumber(2)
  set currency($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCurrency() => $_has(1);
  @$pb.TagNumber(2)
  void clearCurrency() => clearField(2);
}

class GetPiggyVaultConfigResponse extends $pb.GeneratedMessage {
  factory GetPiggyVaultConfigResponse({
    PiggyVaultConfigProto? config,
  }) {
    final $result = create();
    if (config != null) {
      $result.config = config;
    }
    return $result;
  }
  GetPiggyVaultConfigResponse._() : super();
  factory GetPiggyVaultConfigResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPiggyVaultConfigResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetPiggyVaultConfigResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOM<PiggyVaultConfigProto>(1, _omitFieldNames ? '' : 'config', subBuilder: PiggyVaultConfigProto.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPiggyVaultConfigResponse clone() => GetPiggyVaultConfigResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPiggyVaultConfigResponse copyWith(void Function(GetPiggyVaultConfigResponse) updates) => super.copyWith((message) => updates(message as GetPiggyVaultConfigResponse)) as GetPiggyVaultConfigResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPiggyVaultConfigResponse create() => GetPiggyVaultConfigResponse._();
  GetPiggyVaultConfigResponse createEmptyInstance() => create();
  static $pb.PbList<GetPiggyVaultConfigResponse> createRepeated() => $pb.PbList<GetPiggyVaultConfigResponse>();
  @$core.pragma('dart2js:noInline')
  static GetPiggyVaultConfigResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetPiggyVaultConfigResponse>(create);
  static GetPiggyVaultConfigResponse? _defaultInstance;

  @$pb.TagNumber(1)
  PiggyVaultConfigProto get config => $_getN(0);
  @$pb.TagNumber(1)
  set config(PiggyVaultConfigProto v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasConfig() => $_has(0);
  @$pb.TagNumber(1)
  void clearConfig() => clearField(1);
  @$pb.TagNumber(1)
  PiggyVaultConfigProto ensureConfig() => $_ensure(0);
}

class GetAllPiggyVaultConfigsRequest extends $pb.GeneratedMessage {
  factory GetAllPiggyVaultConfigsRequest({
    $core.String? currency,
  }) {
    final $result = create();
    if (currency != null) {
      $result.currency = currency;
    }
    return $result;
  }
  GetAllPiggyVaultConfigsRequest._() : super();
  factory GetAllPiggyVaultConfigsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAllPiggyVaultConfigsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetAllPiggyVaultConfigsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'currency')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAllPiggyVaultConfigsRequest clone() => GetAllPiggyVaultConfigsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAllPiggyVaultConfigsRequest copyWith(void Function(GetAllPiggyVaultConfigsRequest) updates) => super.copyWith((message) => updates(message as GetAllPiggyVaultConfigsRequest)) as GetAllPiggyVaultConfigsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAllPiggyVaultConfigsRequest create() => GetAllPiggyVaultConfigsRequest._();
  GetAllPiggyVaultConfigsRequest createEmptyInstance() => create();
  static $pb.PbList<GetAllPiggyVaultConfigsRequest> createRepeated() => $pb.PbList<GetAllPiggyVaultConfigsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetAllPiggyVaultConfigsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAllPiggyVaultConfigsRequest>(create);
  static GetAllPiggyVaultConfigsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get currency => $_getSZ(0);
  @$pb.TagNumber(1)
  set currency($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCurrency() => $_has(0);
  @$pb.TagNumber(1)
  void clearCurrency() => clearField(1);
}

class GetAllPiggyVaultConfigsResponse extends $pb.GeneratedMessage {
  factory GetAllPiggyVaultConfigsResponse({
    $core.Iterable<PiggyVaultConfigProto>? configs,
  }) {
    final $result = create();
    if (configs != null) {
      $result.configs.addAll(configs);
    }
    return $result;
  }
  GetAllPiggyVaultConfigsResponse._() : super();
  factory GetAllPiggyVaultConfigsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAllPiggyVaultConfigsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetAllPiggyVaultConfigsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..pc<PiggyVaultConfigProto>(1, _omitFieldNames ? '' : 'configs', $pb.PbFieldType.PM, subBuilder: PiggyVaultConfigProto.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAllPiggyVaultConfigsResponse clone() => GetAllPiggyVaultConfigsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAllPiggyVaultConfigsResponse copyWith(void Function(GetAllPiggyVaultConfigsResponse) updates) => super.copyWith((message) => updates(message as GetAllPiggyVaultConfigsResponse)) as GetAllPiggyVaultConfigsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAllPiggyVaultConfigsResponse create() => GetAllPiggyVaultConfigsResponse._();
  GetAllPiggyVaultConfigsResponse createEmptyInstance() => create();
  static $pb.PbList<GetAllPiggyVaultConfigsResponse> createRepeated() => $pb.PbList<GetAllPiggyVaultConfigsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetAllPiggyVaultConfigsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAllPiggyVaultConfigsResponse>(create);
  static GetAllPiggyVaultConfigsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<PiggyVaultConfigProto> get configs => $_getList(0);
}

class UpdatePiggyVaultConfigRequest extends $pb.GeneratedMessage {
  factory UpdatePiggyVaultConfigRequest({
    $core.String? lockType,
    $core.String? currency,
    $core.double? baseInterestRate,
    $core.double? maxInterestRate,
    $core.double? earlyWithdrawalPenalty,
    $core.int? minDurationDays,
    $core.int? maxDurationDays,
    $core.double? minAmount,
    $core.double? maxAmount,
    $core.bool? allowsEarlyWithdrawal,
    $core.bool? supportsAutoRenew,
    $core.bool? supportsTopUp,
    $core.bool? supportsAutoSave,
    $core.bool? supportsUpfrontInterest,
    $core.String? durationBonusTiers,
    $core.bool? isActive,
    $core.String? description,
    $core.String? displayName,
  }) {
    final $result = create();
    if (lockType != null) {
      $result.lockType = lockType;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (baseInterestRate != null) {
      $result.baseInterestRate = baseInterestRate;
    }
    if (maxInterestRate != null) {
      $result.maxInterestRate = maxInterestRate;
    }
    if (earlyWithdrawalPenalty != null) {
      $result.earlyWithdrawalPenalty = earlyWithdrawalPenalty;
    }
    if (minDurationDays != null) {
      $result.minDurationDays = minDurationDays;
    }
    if (maxDurationDays != null) {
      $result.maxDurationDays = maxDurationDays;
    }
    if (minAmount != null) {
      $result.minAmount = minAmount;
    }
    if (maxAmount != null) {
      $result.maxAmount = maxAmount;
    }
    if (allowsEarlyWithdrawal != null) {
      $result.allowsEarlyWithdrawal = allowsEarlyWithdrawal;
    }
    if (supportsAutoRenew != null) {
      $result.supportsAutoRenew = supportsAutoRenew;
    }
    if (supportsTopUp != null) {
      $result.supportsTopUp = supportsTopUp;
    }
    if (supportsAutoSave != null) {
      $result.supportsAutoSave = supportsAutoSave;
    }
    if (supportsUpfrontInterest != null) {
      $result.supportsUpfrontInterest = supportsUpfrontInterest;
    }
    if (durationBonusTiers != null) {
      $result.durationBonusTiers = durationBonusTiers;
    }
    if (isActive != null) {
      $result.isActive = isActive;
    }
    if (description != null) {
      $result.description = description;
    }
    if (displayName != null) {
      $result.displayName = displayName;
    }
    return $result;
  }
  UpdatePiggyVaultConfigRequest._() : super();
  factory UpdatePiggyVaultConfigRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdatePiggyVaultConfigRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdatePiggyVaultConfigRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'lockType')
    ..aOS(2, _omitFieldNames ? '' : 'currency')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'baseInterestRate', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'maxInterestRate', $pb.PbFieldType.OD)
    ..a<$core.double>(5, _omitFieldNames ? '' : 'earlyWithdrawalPenalty', $pb.PbFieldType.OD)
    ..a<$core.int>(6, _omitFieldNames ? '' : 'minDurationDays', $pb.PbFieldType.O3)
    ..a<$core.int>(7, _omitFieldNames ? '' : 'maxDurationDays', $pb.PbFieldType.O3)
    ..a<$core.double>(8, _omitFieldNames ? '' : 'minAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(9, _omitFieldNames ? '' : 'maxAmount', $pb.PbFieldType.OD)
    ..aOB(10, _omitFieldNames ? '' : 'allowsEarlyWithdrawal')
    ..aOB(11, _omitFieldNames ? '' : 'supportsAutoRenew')
    ..aOB(12, _omitFieldNames ? '' : 'supportsTopUp')
    ..aOB(13, _omitFieldNames ? '' : 'supportsAutoSave')
    ..aOB(14, _omitFieldNames ? '' : 'supportsUpfrontInterest')
    ..aOS(15, _omitFieldNames ? '' : 'durationBonusTiers')
    ..aOB(16, _omitFieldNames ? '' : 'isActive')
    ..aOS(17, _omitFieldNames ? '' : 'description')
    ..aOS(18, _omitFieldNames ? '' : 'displayName')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdatePiggyVaultConfigRequest clone() => UpdatePiggyVaultConfigRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdatePiggyVaultConfigRequest copyWith(void Function(UpdatePiggyVaultConfigRequest) updates) => super.copyWith((message) => updates(message as UpdatePiggyVaultConfigRequest)) as UpdatePiggyVaultConfigRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdatePiggyVaultConfigRequest create() => UpdatePiggyVaultConfigRequest._();
  UpdatePiggyVaultConfigRequest createEmptyInstance() => create();
  static $pb.PbList<UpdatePiggyVaultConfigRequest> createRepeated() => $pb.PbList<UpdatePiggyVaultConfigRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdatePiggyVaultConfigRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdatePiggyVaultConfigRequest>(create);
  static UpdatePiggyVaultConfigRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get lockType => $_getSZ(0);
  @$pb.TagNumber(1)
  set lockType($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLockType() => $_has(0);
  @$pb.TagNumber(1)
  void clearLockType() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get currency => $_getSZ(1);
  @$pb.TagNumber(2)
  set currency($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCurrency() => $_has(1);
  @$pb.TagNumber(2)
  void clearCurrency() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get baseInterestRate => $_getN(2);
  @$pb.TagNumber(3)
  set baseInterestRate($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasBaseInterestRate() => $_has(2);
  @$pb.TagNumber(3)
  void clearBaseInterestRate() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get maxInterestRate => $_getN(3);
  @$pb.TagNumber(4)
  set maxInterestRate($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasMaxInterestRate() => $_has(3);
  @$pb.TagNumber(4)
  void clearMaxInterestRate() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get earlyWithdrawalPenalty => $_getN(4);
  @$pb.TagNumber(5)
  set earlyWithdrawalPenalty($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasEarlyWithdrawalPenalty() => $_has(4);
  @$pb.TagNumber(5)
  void clearEarlyWithdrawalPenalty() => clearField(5);

  @$pb.TagNumber(6)
  $core.int get minDurationDays => $_getIZ(5);
  @$pb.TagNumber(6)
  set minDurationDays($core.int v) { $_setSignedInt32(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasMinDurationDays() => $_has(5);
  @$pb.TagNumber(6)
  void clearMinDurationDays() => clearField(6);

  @$pb.TagNumber(7)
  $core.int get maxDurationDays => $_getIZ(6);
  @$pb.TagNumber(7)
  set maxDurationDays($core.int v) { $_setSignedInt32(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasMaxDurationDays() => $_has(6);
  @$pb.TagNumber(7)
  void clearMaxDurationDays() => clearField(7);

  @$pb.TagNumber(8)
  $core.double get minAmount => $_getN(7);
  @$pb.TagNumber(8)
  set minAmount($core.double v) { $_setDouble(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasMinAmount() => $_has(7);
  @$pb.TagNumber(8)
  void clearMinAmount() => clearField(8);

  @$pb.TagNumber(9)
  $core.double get maxAmount => $_getN(8);
  @$pb.TagNumber(9)
  set maxAmount($core.double v) { $_setDouble(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasMaxAmount() => $_has(8);
  @$pb.TagNumber(9)
  void clearMaxAmount() => clearField(9);

  @$pb.TagNumber(10)
  $core.bool get allowsEarlyWithdrawal => $_getBF(9);
  @$pb.TagNumber(10)
  set allowsEarlyWithdrawal($core.bool v) { $_setBool(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasAllowsEarlyWithdrawal() => $_has(9);
  @$pb.TagNumber(10)
  void clearAllowsEarlyWithdrawal() => clearField(10);

  @$pb.TagNumber(11)
  $core.bool get supportsAutoRenew => $_getBF(10);
  @$pb.TagNumber(11)
  set supportsAutoRenew($core.bool v) { $_setBool(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasSupportsAutoRenew() => $_has(10);
  @$pb.TagNumber(11)
  void clearSupportsAutoRenew() => clearField(11);

  @$pb.TagNumber(12)
  $core.bool get supportsTopUp => $_getBF(11);
  @$pb.TagNumber(12)
  set supportsTopUp($core.bool v) { $_setBool(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasSupportsTopUp() => $_has(11);
  @$pb.TagNumber(12)
  void clearSupportsTopUp() => clearField(12);

  @$pb.TagNumber(13)
  $core.bool get supportsAutoSave => $_getBF(12);
  @$pb.TagNumber(13)
  set supportsAutoSave($core.bool v) { $_setBool(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasSupportsAutoSave() => $_has(12);
  @$pb.TagNumber(13)
  void clearSupportsAutoSave() => clearField(13);

  @$pb.TagNumber(14)
  $core.bool get supportsUpfrontInterest => $_getBF(13);
  @$pb.TagNumber(14)
  set supportsUpfrontInterest($core.bool v) { $_setBool(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasSupportsUpfrontInterest() => $_has(13);
  @$pb.TagNumber(14)
  void clearSupportsUpfrontInterest() => clearField(14);

  @$pb.TagNumber(15)
  $core.String get durationBonusTiers => $_getSZ(14);
  @$pb.TagNumber(15)
  set durationBonusTiers($core.String v) { $_setString(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasDurationBonusTiers() => $_has(14);
  @$pb.TagNumber(15)
  void clearDurationBonusTiers() => clearField(15);

  @$pb.TagNumber(16)
  $core.bool get isActive => $_getBF(15);
  @$pb.TagNumber(16)
  set isActive($core.bool v) { $_setBool(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasIsActive() => $_has(15);
  @$pb.TagNumber(16)
  void clearIsActive() => clearField(16);

  @$pb.TagNumber(17)
  $core.String get description => $_getSZ(16);
  @$pb.TagNumber(17)
  set description($core.String v) { $_setString(16, v); }
  @$pb.TagNumber(17)
  $core.bool hasDescription() => $_has(16);
  @$pb.TagNumber(17)
  void clearDescription() => clearField(17);

  @$pb.TagNumber(18)
  $core.String get displayName => $_getSZ(17);
  @$pb.TagNumber(18)
  set displayName($core.String v) { $_setString(17, v); }
  @$pb.TagNumber(18)
  $core.bool hasDisplayName() => $_has(17);
  @$pb.TagNumber(18)
  void clearDisplayName() => clearField(18);
}

class UpdatePiggyVaultConfigResponse extends $pb.GeneratedMessage {
  factory UpdatePiggyVaultConfigResponse({
    PiggyVaultConfigProto? config,
    $core.String? message,
  }) {
    final $result = create();
    if (config != null) {
      $result.config = config;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  UpdatePiggyVaultConfigResponse._() : super();
  factory UpdatePiggyVaultConfigResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdatePiggyVaultConfigResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdatePiggyVaultConfigResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOM<PiggyVaultConfigProto>(1, _omitFieldNames ? '' : 'config', subBuilder: PiggyVaultConfigProto.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdatePiggyVaultConfigResponse clone() => UpdatePiggyVaultConfigResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdatePiggyVaultConfigResponse copyWith(void Function(UpdatePiggyVaultConfigResponse) updates) => super.copyWith((message) => updates(message as UpdatePiggyVaultConfigResponse)) as UpdatePiggyVaultConfigResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdatePiggyVaultConfigResponse create() => UpdatePiggyVaultConfigResponse._();
  UpdatePiggyVaultConfigResponse createEmptyInstance() => create();
  static $pb.PbList<UpdatePiggyVaultConfigResponse> createRepeated() => $pb.PbList<UpdatePiggyVaultConfigResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdatePiggyVaultConfigResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdatePiggyVaultConfigResponse>(create);
  static UpdatePiggyVaultConfigResponse? _defaultInstance;

  @$pb.TagNumber(1)
  PiggyVaultConfigProto get config => $_getN(0);
  @$pb.TagNumber(1)
  set config(PiggyVaultConfigProto v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasConfig() => $_has(0);
  @$pb.TagNumber(1)
  void clearConfig() => clearField(1);
  @$pb.TagNumber(1)
  PiggyVaultConfigProto ensureConfig() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

/// === TopUp Lock Fund ===
class TopUpLockFundsRequest extends $pb.GeneratedMessage {
  factory TopUpLockFundsRequest({
    $core.String? lockfundsId,
    $core.double? amount,
    $core.String? pin,
    $core.String? sourceAccountId,
  }) {
    final $result = create();
    if (lockfundsId != null) {
      $result.lockfundsId = lockfundsId;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (pin != null) {
      $result.pin = pin;
    }
    if (sourceAccountId != null) {
      $result.sourceAccountId = sourceAccountId;
    }
    return $result;
  }
  TopUpLockFundsRequest._() : super();
  factory TopUpLockFundsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TopUpLockFundsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TopUpLockFundsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'lockfundsId')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(3, _omitFieldNames ? '' : 'pin')
    ..aOS(4, _omitFieldNames ? '' : 'sourceAccountId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TopUpLockFundsRequest clone() => TopUpLockFundsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TopUpLockFundsRequest copyWith(void Function(TopUpLockFundsRequest) updates) => super.copyWith((message) => updates(message as TopUpLockFundsRequest)) as TopUpLockFundsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TopUpLockFundsRequest create() => TopUpLockFundsRequest._();
  TopUpLockFundsRequest createEmptyInstance() => create();
  static $pb.PbList<TopUpLockFundsRequest> createRepeated() => $pb.PbList<TopUpLockFundsRequest>();
  @$core.pragma('dart2js:noInline')
  static TopUpLockFundsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TopUpLockFundsRequest>(create);
  static TopUpLockFundsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get lockfundsId => $_getSZ(0);
  @$pb.TagNumber(1)
  set lockfundsId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLockfundsId() => $_has(0);
  @$pb.TagNumber(1)
  void clearLockfundsId() => clearField(1);

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
  $core.String get sourceAccountId => $_getSZ(3);
  @$pb.TagNumber(4)
  set sourceAccountId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasSourceAccountId() => $_has(3);
  @$pb.TagNumber(4)
  void clearSourceAccountId() => clearField(4);
}

class TopUpLockFundsResponse extends $pb.GeneratedMessage {
  factory TopUpLockFundsResponse({
    LockFunds? lockfunds,
    Transaction? transaction,
    $core.double? newAvailableBalance,
    $core.String? message,
  }) {
    final $result = create();
    if (lockfunds != null) {
      $result.lockfunds = lockfunds;
    }
    if (transaction != null) {
      $result.transaction = transaction;
    }
    if (newAvailableBalance != null) {
      $result.newAvailableBalance = newAvailableBalance;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  TopUpLockFundsResponse._() : super();
  factory TopUpLockFundsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TopUpLockFundsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TopUpLockFundsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOM<LockFunds>(1, _omitFieldNames ? '' : 'lockfunds', subBuilder: LockFunds.create)
    ..aOM<Transaction>(2, _omitFieldNames ? '' : 'transaction', subBuilder: Transaction.create)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'newAvailableBalance', $pb.PbFieldType.OD)
    ..aOS(4, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TopUpLockFundsResponse clone() => TopUpLockFundsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TopUpLockFundsResponse copyWith(void Function(TopUpLockFundsResponse) updates) => super.copyWith((message) => updates(message as TopUpLockFundsResponse)) as TopUpLockFundsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TopUpLockFundsResponse create() => TopUpLockFundsResponse._();
  TopUpLockFundsResponse createEmptyInstance() => create();
  static $pb.PbList<TopUpLockFundsResponse> createRepeated() => $pb.PbList<TopUpLockFundsResponse>();
  @$core.pragma('dart2js:noInline')
  static TopUpLockFundsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TopUpLockFundsResponse>(create);
  static TopUpLockFundsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  LockFunds get lockfunds => $_getN(0);
  @$pb.TagNumber(1)
  set lockfunds(LockFunds v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasLockfunds() => $_has(0);
  @$pb.TagNumber(1)
  void clearLockfunds() => clearField(1);
  @$pb.TagNumber(1)
  LockFunds ensureLockfunds() => $_ensure(0);

  @$pb.TagNumber(2)
  Transaction get transaction => $_getN(1);
  @$pb.TagNumber(2)
  set transaction(Transaction v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasTransaction() => $_has(1);
  @$pb.TagNumber(2)
  void clearTransaction() => clearField(2);
  @$pb.TagNumber(2)
  Transaction ensureTransaction() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.double get newAvailableBalance => $_getN(2);
  @$pb.TagNumber(3)
  set newAvailableBalance($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasNewAvailableBalance() => $_has(2);
  @$pb.TagNumber(3)
  void clearNewAvailableBalance() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get message => $_getSZ(3);
  @$pb.TagNumber(4)
  set message($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasMessage() => $_has(3);
  @$pb.TagNumber(4)
  void clearMessage() => clearField(4);
}

/// === Lock Fund AutoSave ===
class LockFundAutoSaveProto extends $pb.GeneratedMessage {
  factory LockFundAutoSaveProto({
    $core.String? id,
    $core.String? lockFundId,
    $core.String? userId,
    $core.String? sourceAccountId,
    $core.double? amount,
    $core.String? frequency,
    $core.String? status,
    $core.String? nextRunAt,
    $core.String? lastRunAt,
    $core.double? totalSaved,
    $core.int? runCount,
    $core.String? createdAt,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (lockFundId != null) {
      $result.lockFundId = lockFundId;
    }
    if (userId != null) {
      $result.userId = userId;
    }
    if (sourceAccountId != null) {
      $result.sourceAccountId = sourceAccountId;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (frequency != null) {
      $result.frequency = frequency;
    }
    if (status != null) {
      $result.status = status;
    }
    if (nextRunAt != null) {
      $result.nextRunAt = nextRunAt;
    }
    if (lastRunAt != null) {
      $result.lastRunAt = lastRunAt;
    }
    if (totalSaved != null) {
      $result.totalSaved = totalSaved;
    }
    if (runCount != null) {
      $result.runCount = runCount;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    return $result;
  }
  LockFundAutoSaveProto._() : super();
  factory LockFundAutoSaveProto.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LockFundAutoSaveProto.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'LockFundAutoSaveProto', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'lockFundId')
    ..aOS(3, _omitFieldNames ? '' : 'userId')
    ..aOS(4, _omitFieldNames ? '' : 'sourceAccountId')
    ..a<$core.double>(5, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(6, _omitFieldNames ? '' : 'frequency')
    ..aOS(7, _omitFieldNames ? '' : 'status')
    ..aOS(8, _omitFieldNames ? '' : 'nextRunAt')
    ..aOS(9, _omitFieldNames ? '' : 'lastRunAt')
    ..a<$core.double>(10, _omitFieldNames ? '' : 'totalSaved', $pb.PbFieldType.OD)
    ..a<$core.int>(11, _omitFieldNames ? '' : 'runCount', $pb.PbFieldType.O3)
    ..aOS(12, _omitFieldNames ? '' : 'createdAt')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LockFundAutoSaveProto clone() => LockFundAutoSaveProto()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LockFundAutoSaveProto copyWith(void Function(LockFundAutoSaveProto) updates) => super.copyWith((message) => updates(message as LockFundAutoSaveProto)) as LockFundAutoSaveProto;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LockFundAutoSaveProto create() => LockFundAutoSaveProto._();
  LockFundAutoSaveProto createEmptyInstance() => create();
  static $pb.PbList<LockFundAutoSaveProto> createRepeated() => $pb.PbList<LockFundAutoSaveProto>();
  @$core.pragma('dart2js:noInline')
  static LockFundAutoSaveProto getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LockFundAutoSaveProto>(create);
  static LockFundAutoSaveProto? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get lockFundId => $_getSZ(1);
  @$pb.TagNumber(2)
  set lockFundId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLockFundId() => $_has(1);
  @$pb.TagNumber(2)
  void clearLockFundId() => clearField(2);

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
  $core.double get amount => $_getN(4);
  @$pb.TagNumber(5)
  set amount($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasAmount() => $_has(4);
  @$pb.TagNumber(5)
  void clearAmount() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get frequency => $_getSZ(5);
  @$pb.TagNumber(6)
  set frequency($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasFrequency() => $_has(5);
  @$pb.TagNumber(6)
  void clearFrequency() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get status => $_getSZ(6);
  @$pb.TagNumber(7)
  set status($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasStatus() => $_has(6);
  @$pb.TagNumber(7)
  void clearStatus() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get nextRunAt => $_getSZ(7);
  @$pb.TagNumber(8)
  set nextRunAt($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasNextRunAt() => $_has(7);
  @$pb.TagNumber(8)
  void clearNextRunAt() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get lastRunAt => $_getSZ(8);
  @$pb.TagNumber(9)
  set lastRunAt($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasLastRunAt() => $_has(8);
  @$pb.TagNumber(9)
  void clearLastRunAt() => clearField(9);

  @$pb.TagNumber(10)
  $core.double get totalSaved => $_getN(9);
  @$pb.TagNumber(10)
  set totalSaved($core.double v) { $_setDouble(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasTotalSaved() => $_has(9);
  @$pb.TagNumber(10)
  void clearTotalSaved() => clearField(10);

  @$pb.TagNumber(11)
  $core.int get runCount => $_getIZ(10);
  @$pb.TagNumber(11)
  set runCount($core.int v) { $_setSignedInt32(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasRunCount() => $_has(10);
  @$pb.TagNumber(11)
  void clearRunCount() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get createdAt => $_getSZ(11);
  @$pb.TagNumber(12)
  set createdAt($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasCreatedAt() => $_has(11);
  @$pb.TagNumber(12)
  void clearCreatedAt() => clearField(12);
}

class CreateLockFundAutoSaveRequest extends $pb.GeneratedMessage {
  factory CreateLockFundAutoSaveRequest({
    $core.String? lockFundId,
    $core.String? sourceAccountId,
    $core.double? amount,
    $core.String? frequency,
  }) {
    final $result = create();
    if (lockFundId != null) {
      $result.lockFundId = lockFundId;
    }
    if (sourceAccountId != null) {
      $result.sourceAccountId = sourceAccountId;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (frequency != null) {
      $result.frequency = frequency;
    }
    return $result;
  }
  CreateLockFundAutoSaveRequest._() : super();
  factory CreateLockFundAutoSaveRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateLockFundAutoSaveRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateLockFundAutoSaveRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'lockFundId')
    ..aOS(2, _omitFieldNames ? '' : 'sourceAccountId')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(4, _omitFieldNames ? '' : 'frequency')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateLockFundAutoSaveRequest clone() => CreateLockFundAutoSaveRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateLockFundAutoSaveRequest copyWith(void Function(CreateLockFundAutoSaveRequest) updates) => super.copyWith((message) => updates(message as CreateLockFundAutoSaveRequest)) as CreateLockFundAutoSaveRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateLockFundAutoSaveRequest create() => CreateLockFundAutoSaveRequest._();
  CreateLockFundAutoSaveRequest createEmptyInstance() => create();
  static $pb.PbList<CreateLockFundAutoSaveRequest> createRepeated() => $pb.PbList<CreateLockFundAutoSaveRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateLockFundAutoSaveRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateLockFundAutoSaveRequest>(create);
  static CreateLockFundAutoSaveRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get lockFundId => $_getSZ(0);
  @$pb.TagNumber(1)
  set lockFundId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLockFundId() => $_has(0);
  @$pb.TagNumber(1)
  void clearLockFundId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get sourceAccountId => $_getSZ(1);
  @$pb.TagNumber(2)
  set sourceAccountId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSourceAccountId() => $_has(1);
  @$pb.TagNumber(2)
  void clearSourceAccountId() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get amount => $_getN(2);
  @$pb.TagNumber(3)
  set amount($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get frequency => $_getSZ(3);
  @$pb.TagNumber(4)
  set frequency($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasFrequency() => $_has(3);
  @$pb.TagNumber(4)
  void clearFrequency() => clearField(4);
}

class CreateLockFundAutoSaveResponse extends $pb.GeneratedMessage {
  factory CreateLockFundAutoSaveResponse({
    LockFundAutoSaveProto? autosave,
    $core.String? message,
  }) {
    final $result = create();
    if (autosave != null) {
      $result.autosave = autosave;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  CreateLockFundAutoSaveResponse._() : super();
  factory CreateLockFundAutoSaveResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateLockFundAutoSaveResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateLockFundAutoSaveResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOM<LockFundAutoSaveProto>(1, _omitFieldNames ? '' : 'autosave', subBuilder: LockFundAutoSaveProto.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateLockFundAutoSaveResponse clone() => CreateLockFundAutoSaveResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateLockFundAutoSaveResponse copyWith(void Function(CreateLockFundAutoSaveResponse) updates) => super.copyWith((message) => updates(message as CreateLockFundAutoSaveResponse)) as CreateLockFundAutoSaveResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateLockFundAutoSaveResponse create() => CreateLockFundAutoSaveResponse._();
  CreateLockFundAutoSaveResponse createEmptyInstance() => create();
  static $pb.PbList<CreateLockFundAutoSaveResponse> createRepeated() => $pb.PbList<CreateLockFundAutoSaveResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateLockFundAutoSaveResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateLockFundAutoSaveResponse>(create);
  static CreateLockFundAutoSaveResponse? _defaultInstance;

  @$pb.TagNumber(1)
  LockFundAutoSaveProto get autosave => $_getN(0);
  @$pb.TagNumber(1)
  set autosave(LockFundAutoSaveProto v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasAutosave() => $_has(0);
  @$pb.TagNumber(1)
  void clearAutosave() => clearField(1);
  @$pb.TagNumber(1)
  LockFundAutoSaveProto ensureAutosave() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

class GetLockFundAutoSaveRequest extends $pb.GeneratedMessage {
  factory GetLockFundAutoSaveRequest({
    $core.String? lockFundId,
  }) {
    final $result = create();
    if (lockFundId != null) {
      $result.lockFundId = lockFundId;
    }
    return $result;
  }
  GetLockFundAutoSaveRequest._() : super();
  factory GetLockFundAutoSaveRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetLockFundAutoSaveRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetLockFundAutoSaveRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'lockFundId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetLockFundAutoSaveRequest clone() => GetLockFundAutoSaveRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetLockFundAutoSaveRequest copyWith(void Function(GetLockFundAutoSaveRequest) updates) => super.copyWith((message) => updates(message as GetLockFundAutoSaveRequest)) as GetLockFundAutoSaveRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetLockFundAutoSaveRequest create() => GetLockFundAutoSaveRequest._();
  GetLockFundAutoSaveRequest createEmptyInstance() => create();
  static $pb.PbList<GetLockFundAutoSaveRequest> createRepeated() => $pb.PbList<GetLockFundAutoSaveRequest>();
  @$core.pragma('dart2js:noInline')
  static GetLockFundAutoSaveRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetLockFundAutoSaveRequest>(create);
  static GetLockFundAutoSaveRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get lockFundId => $_getSZ(0);
  @$pb.TagNumber(1)
  set lockFundId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLockFundId() => $_has(0);
  @$pb.TagNumber(1)
  void clearLockFundId() => clearField(1);
}

class GetLockFundAutoSaveResponse extends $pb.GeneratedMessage {
  factory GetLockFundAutoSaveResponse({
    LockFundAutoSaveProto? autosave,
  }) {
    final $result = create();
    if (autosave != null) {
      $result.autosave = autosave;
    }
    return $result;
  }
  GetLockFundAutoSaveResponse._() : super();
  factory GetLockFundAutoSaveResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetLockFundAutoSaveResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetLockFundAutoSaveResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOM<LockFundAutoSaveProto>(1, _omitFieldNames ? '' : 'autosave', subBuilder: LockFundAutoSaveProto.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetLockFundAutoSaveResponse clone() => GetLockFundAutoSaveResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetLockFundAutoSaveResponse copyWith(void Function(GetLockFundAutoSaveResponse) updates) => super.copyWith((message) => updates(message as GetLockFundAutoSaveResponse)) as GetLockFundAutoSaveResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetLockFundAutoSaveResponse create() => GetLockFundAutoSaveResponse._();
  GetLockFundAutoSaveResponse createEmptyInstance() => create();
  static $pb.PbList<GetLockFundAutoSaveResponse> createRepeated() => $pb.PbList<GetLockFundAutoSaveResponse>();
  @$core.pragma('dart2js:noInline')
  static GetLockFundAutoSaveResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetLockFundAutoSaveResponse>(create);
  static GetLockFundAutoSaveResponse? _defaultInstance;

  @$pb.TagNumber(1)
  LockFundAutoSaveProto get autosave => $_getN(0);
  @$pb.TagNumber(1)
  set autosave(LockFundAutoSaveProto v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasAutosave() => $_has(0);
  @$pb.TagNumber(1)
  void clearAutosave() => clearField(1);
  @$pb.TagNumber(1)
  LockFundAutoSaveProto ensureAutosave() => $_ensure(0);
}

class UpdateLockFundAutoSaveRequest extends $pb.GeneratedMessage {
  factory UpdateLockFundAutoSaveRequest({
    $core.String? autosaveId,
    $core.double? amount,
    $core.String? frequency,
    $core.String? status,
  }) {
    final $result = create();
    if (autosaveId != null) {
      $result.autosaveId = autosaveId;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (frequency != null) {
      $result.frequency = frequency;
    }
    if (status != null) {
      $result.status = status;
    }
    return $result;
  }
  UpdateLockFundAutoSaveRequest._() : super();
  factory UpdateLockFundAutoSaveRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateLockFundAutoSaveRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateLockFundAutoSaveRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'autosaveId')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(3, _omitFieldNames ? '' : 'frequency')
    ..aOS(4, _omitFieldNames ? '' : 'status')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateLockFundAutoSaveRequest clone() => UpdateLockFundAutoSaveRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateLockFundAutoSaveRequest copyWith(void Function(UpdateLockFundAutoSaveRequest) updates) => super.copyWith((message) => updates(message as UpdateLockFundAutoSaveRequest)) as UpdateLockFundAutoSaveRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateLockFundAutoSaveRequest create() => UpdateLockFundAutoSaveRequest._();
  UpdateLockFundAutoSaveRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateLockFundAutoSaveRequest> createRepeated() => $pb.PbList<UpdateLockFundAutoSaveRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateLockFundAutoSaveRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateLockFundAutoSaveRequest>(create);
  static UpdateLockFundAutoSaveRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get autosaveId => $_getSZ(0);
  @$pb.TagNumber(1)
  set autosaveId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAutosaveId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAutosaveId() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get amount => $_getN(1);
  @$pb.TagNumber(2)
  set amount($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get frequency => $_getSZ(2);
  @$pb.TagNumber(3)
  set frequency($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasFrequency() => $_has(2);
  @$pb.TagNumber(3)
  void clearFrequency() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get status => $_getSZ(3);
  @$pb.TagNumber(4)
  set status($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasStatus() => $_has(3);
  @$pb.TagNumber(4)
  void clearStatus() => clearField(4);
}

class UpdateLockFundAutoSaveResponse extends $pb.GeneratedMessage {
  factory UpdateLockFundAutoSaveResponse({
    LockFundAutoSaveProto? autosave,
    $core.String? message,
  }) {
    final $result = create();
    if (autosave != null) {
      $result.autosave = autosave;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  UpdateLockFundAutoSaveResponse._() : super();
  factory UpdateLockFundAutoSaveResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateLockFundAutoSaveResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateLockFundAutoSaveResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOM<LockFundAutoSaveProto>(1, _omitFieldNames ? '' : 'autosave', subBuilder: LockFundAutoSaveProto.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateLockFundAutoSaveResponse clone() => UpdateLockFundAutoSaveResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateLockFundAutoSaveResponse copyWith(void Function(UpdateLockFundAutoSaveResponse) updates) => super.copyWith((message) => updates(message as UpdateLockFundAutoSaveResponse)) as UpdateLockFundAutoSaveResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateLockFundAutoSaveResponse create() => UpdateLockFundAutoSaveResponse._();
  UpdateLockFundAutoSaveResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateLockFundAutoSaveResponse> createRepeated() => $pb.PbList<UpdateLockFundAutoSaveResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateLockFundAutoSaveResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateLockFundAutoSaveResponse>(create);
  static UpdateLockFundAutoSaveResponse? _defaultInstance;

  @$pb.TagNumber(1)
  LockFundAutoSaveProto get autosave => $_getN(0);
  @$pb.TagNumber(1)
  set autosave(LockFundAutoSaveProto v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasAutosave() => $_has(0);
  @$pb.TagNumber(1)
  void clearAutosave() => clearField(1);
  @$pb.TagNumber(1)
  LockFundAutoSaveProto ensureAutosave() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

class DeleteLockFundAutoSaveRequest extends $pb.GeneratedMessage {
  factory DeleteLockFundAutoSaveRequest({
    $core.String? autosaveId,
  }) {
    final $result = create();
    if (autosaveId != null) {
      $result.autosaveId = autosaveId;
    }
    return $result;
  }
  DeleteLockFundAutoSaveRequest._() : super();
  factory DeleteLockFundAutoSaveRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteLockFundAutoSaveRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DeleteLockFundAutoSaveRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'autosaveId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteLockFundAutoSaveRequest clone() => DeleteLockFundAutoSaveRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteLockFundAutoSaveRequest copyWith(void Function(DeleteLockFundAutoSaveRequest) updates) => super.copyWith((message) => updates(message as DeleteLockFundAutoSaveRequest)) as DeleteLockFundAutoSaveRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteLockFundAutoSaveRequest create() => DeleteLockFundAutoSaveRequest._();
  DeleteLockFundAutoSaveRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteLockFundAutoSaveRequest> createRepeated() => $pb.PbList<DeleteLockFundAutoSaveRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteLockFundAutoSaveRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteLockFundAutoSaveRequest>(create);
  static DeleteLockFundAutoSaveRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get autosaveId => $_getSZ(0);
  @$pb.TagNumber(1)
  set autosaveId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAutosaveId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAutosaveId() => clearField(1);
}

class DeleteLockFundAutoSaveResponse extends $pb.GeneratedMessage {
  factory DeleteLockFundAutoSaveResponse({
    $core.bool? success,
    $core.String? message,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  DeleteLockFundAutoSaveResponse._() : super();
  factory DeleteLockFundAutoSaveResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteLockFundAutoSaveResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DeleteLockFundAutoSaveResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteLockFundAutoSaveResponse clone() => DeleteLockFundAutoSaveResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteLockFundAutoSaveResponse copyWith(void Function(DeleteLockFundAutoSaveResponse) updates) => super.copyWith((message) => updates(message as DeleteLockFundAutoSaveResponse)) as DeleteLockFundAutoSaveResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteLockFundAutoSaveResponse create() => DeleteLockFundAutoSaveResponse._();
  DeleteLockFundAutoSaveResponse createEmptyInstance() => create();
  static $pb.PbList<DeleteLockFundAutoSaveResponse> createRepeated() => $pb.PbList<DeleteLockFundAutoSaveResponse>();
  @$core.pragma('dart2js:noInline')
  static DeleteLockFundAutoSaveResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteLockFundAutoSaveResponse>(create);
  static DeleteLockFundAutoSaveResponse? _defaultInstance;

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

/// CreateTransaction - Called by other services (core-payments, giftcards, etc.) via mTLS
/// Locale is automatically derived from the account
class CreateTransactionRequest extends $pb.GeneratedMessage {
  factory CreateTransactionRequest({
    $core.String? accountId,
    $core.String? type,
    $core.String? category,
    $core.double? amount,
    $core.String? description,
    $core.String? metadata,
    $core.String? serviceName,
    $core.String? reference,
    $core.String? status,
    $core.String? counterpartyName,
    $core.String? counterpartyAccount,
  }) {
    final $result = create();
    if (accountId != null) {
      $result.accountId = accountId;
    }
    if (type != null) {
      $result.type = type;
    }
    if (category != null) {
      $result.category = category;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (description != null) {
      $result.description = description;
    }
    if (metadata != null) {
      $result.metadata = metadata;
    }
    if (serviceName != null) {
      $result.serviceName = serviceName;
    }
    if (reference != null) {
      $result.reference = reference;
    }
    if (status != null) {
      $result.status = status;
    }
    if (counterpartyName != null) {
      $result.counterpartyName = counterpartyName;
    }
    if (counterpartyAccount != null) {
      $result.counterpartyAccount = counterpartyAccount;
    }
    return $result;
  }
  CreateTransactionRequest._() : super();
  factory CreateTransactionRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateTransactionRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateTransactionRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountId')
    ..aOS(2, _omitFieldNames ? '' : 'type')
    ..aOS(3, _omitFieldNames ? '' : 'category')
    ..a<$core.double>(4, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(5, _omitFieldNames ? '' : 'description')
    ..aOS(6, _omitFieldNames ? '' : 'metadata')
    ..aOS(7, _omitFieldNames ? '' : 'serviceName')
    ..aOS(8, _omitFieldNames ? '' : 'reference')
    ..aOS(9, _omitFieldNames ? '' : 'status')
    ..aOS(10, _omitFieldNames ? '' : 'counterpartyName')
    ..aOS(11, _omitFieldNames ? '' : 'counterpartyAccount')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateTransactionRequest clone() => CreateTransactionRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateTransactionRequest copyWith(void Function(CreateTransactionRequest) updates) => super.copyWith((message) => updates(message as CreateTransactionRequest)) as CreateTransactionRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateTransactionRequest create() => CreateTransactionRequest._();
  CreateTransactionRequest createEmptyInstance() => create();
  static $pb.PbList<CreateTransactionRequest> createRepeated() => $pb.PbList<CreateTransactionRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateTransactionRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateTransactionRequest>(create);
  static CreateTransactionRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get type => $_getSZ(1);
  @$pb.TagNumber(2)
  set type($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasType() => $_has(1);
  @$pb.TagNumber(2)
  void clearType() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get category => $_getSZ(2);
  @$pb.TagNumber(3)
  set category($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCategory() => $_has(2);
  @$pb.TagNumber(3)
  void clearCategory() => clearField(3);

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
  $core.String get metadata => $_getSZ(5);
  @$pb.TagNumber(6)
  set metadata($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasMetadata() => $_has(5);
  @$pb.TagNumber(6)
  void clearMetadata() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get serviceName => $_getSZ(6);
  @$pb.TagNumber(7)
  set serviceName($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasServiceName() => $_has(6);
  @$pb.TagNumber(7)
  void clearServiceName() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get reference => $_getSZ(7);
  @$pb.TagNumber(8)
  set reference($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasReference() => $_has(7);
  @$pb.TagNumber(8)
  void clearReference() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get status => $_getSZ(8);
  @$pb.TagNumber(9)
  set status($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasStatus() => $_has(8);
  @$pb.TagNumber(9)
  void clearStatus() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get counterpartyName => $_getSZ(9);
  @$pb.TagNumber(10)
  set counterpartyName($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasCounterpartyName() => $_has(9);
  @$pb.TagNumber(10)
  void clearCounterpartyName() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get counterpartyAccount => $_getSZ(10);
  @$pb.TagNumber(11)
  set counterpartyAccount($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasCounterpartyAccount() => $_has(10);
  @$pb.TagNumber(11)
  void clearCounterpartyAccount() => clearField(11);
}

class CreateTransactionResponse extends $pb.GeneratedMessage {
  factory CreateTransactionResponse({
    Transaction? transaction,
    $core.String? message,
  }) {
    final $result = create();
    if (transaction != null) {
      $result.transaction = transaction;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  CreateTransactionResponse._() : super();
  factory CreateTransactionResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateTransactionResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateTransactionResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOM<Transaction>(1, _omitFieldNames ? '' : 'transaction', subBuilder: Transaction.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateTransactionResponse clone() => CreateTransactionResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateTransactionResponse copyWith(void Function(CreateTransactionResponse) updates) => super.copyWith((message) => updates(message as CreateTransactionResponse)) as CreateTransactionResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateTransactionResponse create() => CreateTransactionResponse._();
  CreateTransactionResponse createEmptyInstance() => create();
  static $pb.PbList<CreateTransactionResponse> createRepeated() => $pb.PbList<CreateTransactionResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateTransactionResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateTransactionResponse>(create);
  static CreateTransactionResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Transaction get transaction => $_getN(0);
  @$pb.TagNumber(1)
  set transaction(Transaction v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasTransaction() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransaction() => clearField(1);
  @$pb.TagNumber(1)
  Transaction ensureTransaction() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

/// UpdateTransactionStatus - Called by other services to update processing -> completed/failed
class UpdateTransactionStatusRequest extends $pb.GeneratedMessage {
  factory UpdateTransactionStatusRequest({
    $core.String? reference,
    $core.String? status,
    $core.String? failureReason,
  }) {
    final $result = create();
    if (reference != null) {
      $result.reference = reference;
    }
    if (status != null) {
      $result.status = status;
    }
    if (failureReason != null) {
      $result.failureReason = failureReason;
    }
    return $result;
  }
  UpdateTransactionStatusRequest._() : super();
  factory UpdateTransactionStatusRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateTransactionStatusRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateTransactionStatusRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'reference')
    ..aOS(2, _omitFieldNames ? '' : 'status')
    ..aOS(3, _omitFieldNames ? '' : 'failureReason')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateTransactionStatusRequest clone() => UpdateTransactionStatusRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateTransactionStatusRequest copyWith(void Function(UpdateTransactionStatusRequest) updates) => super.copyWith((message) => updates(message as UpdateTransactionStatusRequest)) as UpdateTransactionStatusRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateTransactionStatusRequest create() => UpdateTransactionStatusRequest._();
  UpdateTransactionStatusRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateTransactionStatusRequest> createRepeated() => $pb.PbList<UpdateTransactionStatusRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateTransactionStatusRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateTransactionStatusRequest>(create);
  static UpdateTransactionStatusRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get reference => $_getSZ(0);
  @$pb.TagNumber(1)
  set reference($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasReference() => $_has(0);
  @$pb.TagNumber(1)
  void clearReference() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get status => $_getSZ(1);
  @$pb.TagNumber(2)
  set status($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get failureReason => $_getSZ(2);
  @$pb.TagNumber(3)
  set failureReason($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasFailureReason() => $_has(2);
  @$pb.TagNumber(3)
  void clearFailureReason() => clearField(3);
}

class UpdateTransactionStatusResponse extends $pb.GeneratedMessage {
  factory UpdateTransactionStatusResponse({
    $core.bool? success,
    $core.String? message,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  UpdateTransactionStatusResponse._() : super();
  factory UpdateTransactionStatusResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateTransactionStatusResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateTransactionStatusResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateTransactionStatusResponse clone() => UpdateTransactionStatusResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateTransactionStatusResponse copyWith(void Function(UpdateTransactionStatusResponse) updates) => super.copyWith((message) => updates(message as UpdateTransactionStatusResponse)) as UpdateTransactionStatusResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateTransactionStatusResponse create() => UpdateTransactionStatusResponse._();
  UpdateTransactionStatusResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateTransactionStatusResponse> createRepeated() => $pb.PbList<UpdateTransactionStatusResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateTransactionStatusResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateTransactionStatusResponse>(create);
  static UpdateTransactionStatusResponse? _defaultInstance;

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

/// GetTransactionHistory - Get transactions for an account
/// Locale can be passed explicitly; falls back to account locale if empty
class GetTransactionHistoryRequest extends $pb.GeneratedMessage {
  factory GetTransactionHistoryRequest({
    $core.String? accountId,
    $core.String? type,
    $core.String? category,
    $core.String? status,
    $core.String? serviceName,
    $core.String? startDate,
    $core.String? endDate,
    $core.int? limit,
    $core.int? offset,
    $core.bool? includeExternalBanks,
    $core.String? counterpartyAccount,
    $core.String? locale,
  }) {
    final $result = create();
    if (accountId != null) {
      $result.accountId = accountId;
    }
    if (type != null) {
      $result.type = type;
    }
    if (category != null) {
      $result.category = category;
    }
    if (status != null) {
      $result.status = status;
    }
    if (serviceName != null) {
      $result.serviceName = serviceName;
    }
    if (startDate != null) {
      $result.startDate = startDate;
    }
    if (endDate != null) {
      $result.endDate = endDate;
    }
    if (limit != null) {
      $result.limit = limit;
    }
    if (offset != null) {
      $result.offset = offset;
    }
    if (includeExternalBanks != null) {
      $result.includeExternalBanks = includeExternalBanks;
    }
    if (counterpartyAccount != null) {
      $result.counterpartyAccount = counterpartyAccount;
    }
    if (locale != null) {
      $result.locale = locale;
    }
    return $result;
  }
  GetTransactionHistoryRequest._() : super();
  factory GetTransactionHistoryRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTransactionHistoryRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetTransactionHistoryRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountId')
    ..aOS(2, _omitFieldNames ? '' : 'type')
    ..aOS(3, _omitFieldNames ? '' : 'category')
    ..aOS(4, _omitFieldNames ? '' : 'status')
    ..aOS(5, _omitFieldNames ? '' : 'serviceName')
    ..aOS(6, _omitFieldNames ? '' : 'startDate')
    ..aOS(7, _omitFieldNames ? '' : 'endDate')
    ..a<$core.int>(8, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(9, _omitFieldNames ? '' : 'offset', $pb.PbFieldType.O3)
    ..aOB(10, _omitFieldNames ? '' : 'includeExternalBanks')
    ..aOS(11, _omitFieldNames ? '' : 'counterpartyAccount')
    ..aOS(12, _omitFieldNames ? '' : 'locale')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetTransactionHistoryRequest clone() => GetTransactionHistoryRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetTransactionHistoryRequest copyWith(void Function(GetTransactionHistoryRequest) updates) => super.copyWith((message) => updates(message as GetTransactionHistoryRequest)) as GetTransactionHistoryRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTransactionHistoryRequest create() => GetTransactionHistoryRequest._();
  GetTransactionHistoryRequest createEmptyInstance() => create();
  static $pb.PbList<GetTransactionHistoryRequest> createRepeated() => $pb.PbList<GetTransactionHistoryRequest>();
  @$core.pragma('dart2js:noInline')
  static GetTransactionHistoryRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetTransactionHistoryRequest>(create);
  static GetTransactionHistoryRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get type => $_getSZ(1);
  @$pb.TagNumber(2)
  set type($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasType() => $_has(1);
  @$pb.TagNumber(2)
  void clearType() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get category => $_getSZ(2);
  @$pb.TagNumber(3)
  set category($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCategory() => $_has(2);
  @$pb.TagNumber(3)
  void clearCategory() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get status => $_getSZ(3);
  @$pb.TagNumber(4)
  set status($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasStatus() => $_has(3);
  @$pb.TagNumber(4)
  void clearStatus() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get serviceName => $_getSZ(4);
  @$pb.TagNumber(5)
  set serviceName($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasServiceName() => $_has(4);
  @$pb.TagNumber(5)
  void clearServiceName() => clearField(5);

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
  $core.int get limit => $_getIZ(7);
  @$pb.TagNumber(8)
  set limit($core.int v) { $_setSignedInt32(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasLimit() => $_has(7);
  @$pb.TagNumber(8)
  void clearLimit() => clearField(8);

  @$pb.TagNumber(9)
  $core.int get offset => $_getIZ(8);
  @$pb.TagNumber(9)
  set offset($core.int v) { $_setSignedInt32(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasOffset() => $_has(8);
  @$pb.TagNumber(9)
  void clearOffset() => clearField(9);

  @$pb.TagNumber(10)
  $core.bool get includeExternalBanks => $_getBF(9);
  @$pb.TagNumber(10)
  set includeExternalBanks($core.bool v) { $_setBool(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasIncludeExternalBanks() => $_has(9);
  @$pb.TagNumber(10)
  void clearIncludeExternalBanks() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get counterpartyAccount => $_getSZ(10);
  @$pb.TagNumber(11)
  set counterpartyAccount($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasCounterpartyAccount() => $_has(10);
  @$pb.TagNumber(11)
  void clearCounterpartyAccount() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get locale => $_getSZ(11);
  @$pb.TagNumber(12)
  set locale($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasLocale() => $_has(11);
  @$pb.TagNumber(12)
  void clearLocale() => clearField(12);
}

class GetTransactionHistoryResponse extends $pb.GeneratedMessage {
  factory GetTransactionHistoryResponse({
    $core.Iterable<Transaction>? transactions,
    $core.int? total,
    $core.double? totalCredits,
    $core.double? totalDebits,
  }) {
    final $result = create();
    if (transactions != null) {
      $result.transactions.addAll(transactions);
    }
    if (total != null) {
      $result.total = total;
    }
    if (totalCredits != null) {
      $result.totalCredits = totalCredits;
    }
    if (totalDebits != null) {
      $result.totalDebits = totalDebits;
    }
    return $result;
  }
  GetTransactionHistoryResponse._() : super();
  factory GetTransactionHistoryResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTransactionHistoryResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetTransactionHistoryResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..pc<Transaction>(1, _omitFieldNames ? '' : 'transactions', $pb.PbFieldType.PM, subBuilder: Transaction.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'totalCredits', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'totalDebits', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetTransactionHistoryResponse clone() => GetTransactionHistoryResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetTransactionHistoryResponse copyWith(void Function(GetTransactionHistoryResponse) updates) => super.copyWith((message) => updates(message as GetTransactionHistoryResponse)) as GetTransactionHistoryResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTransactionHistoryResponse create() => GetTransactionHistoryResponse._();
  GetTransactionHistoryResponse createEmptyInstance() => create();
  static $pb.PbList<GetTransactionHistoryResponse> createRepeated() => $pb.PbList<GetTransactionHistoryResponse>();
  @$core.pragma('dart2js:noInline')
  static GetTransactionHistoryResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetTransactionHistoryResponse>(create);
  static GetTransactionHistoryResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Transaction> get transactions => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get totalCredits => $_getN(2);
  @$pb.TagNumber(3)
  set totalCredits($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTotalCredits() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalCredits() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get totalDebits => $_getN(3);
  @$pb.TagNumber(4)
  set totalDebits($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTotalDebits() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalDebits() => clearField(4);
}

/// GetTransactionStatistics - Get statistics grouped by service
/// Locale can be passed explicitly; falls back to account locale if empty
class GetTransactionStatisticsRequest extends $pb.GeneratedMessage {
  factory GetTransactionStatisticsRequest({
    $core.String? accountId,
    $core.String? startDate,
    $core.String? endDate,
    $core.bool? includeExternalBanks,
    $core.String? locale,
  }) {
    final $result = create();
    if (accountId != null) {
      $result.accountId = accountId;
    }
    if (startDate != null) {
      $result.startDate = startDate;
    }
    if (endDate != null) {
      $result.endDate = endDate;
    }
    if (includeExternalBanks != null) {
      $result.includeExternalBanks = includeExternalBanks;
    }
    if (locale != null) {
      $result.locale = locale;
    }
    return $result;
  }
  GetTransactionStatisticsRequest._() : super();
  factory GetTransactionStatisticsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTransactionStatisticsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetTransactionStatisticsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountId')
    ..aOS(2, _omitFieldNames ? '' : 'startDate')
    ..aOS(3, _omitFieldNames ? '' : 'endDate')
    ..aOB(4, _omitFieldNames ? '' : 'includeExternalBanks')
    ..aOS(5, _omitFieldNames ? '' : 'locale')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetTransactionStatisticsRequest clone() => GetTransactionStatisticsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetTransactionStatisticsRequest copyWith(void Function(GetTransactionStatisticsRequest) updates) => super.copyWith((message) => updates(message as GetTransactionStatisticsRequest)) as GetTransactionStatisticsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTransactionStatisticsRequest create() => GetTransactionStatisticsRequest._();
  GetTransactionStatisticsRequest createEmptyInstance() => create();
  static $pb.PbList<GetTransactionStatisticsRequest> createRepeated() => $pb.PbList<GetTransactionStatisticsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetTransactionStatisticsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetTransactionStatisticsRequest>(create);
  static GetTransactionStatisticsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get startDate => $_getSZ(1);
  @$pb.TagNumber(2)
  set startDate($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasStartDate() => $_has(1);
  @$pb.TagNumber(2)
  void clearStartDate() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get endDate => $_getSZ(2);
  @$pb.TagNumber(3)
  set endDate($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasEndDate() => $_has(2);
  @$pb.TagNumber(3)
  void clearEndDate() => clearField(3);

  @$pb.TagNumber(4)
  $core.bool get includeExternalBanks => $_getBF(3);
  @$pb.TagNumber(4)
  set includeExternalBanks($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasIncludeExternalBanks() => $_has(3);
  @$pb.TagNumber(4)
  void clearIncludeExternalBanks() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get locale => $_getSZ(4);
  @$pb.TagNumber(5)
  set locale($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasLocale() => $_has(4);
  @$pb.TagNumber(5)
  void clearLocale() => clearField(5);
}

class GetTransactionStatisticsResponse extends $pb.GeneratedMessage {
  factory GetTransactionStatisticsResponse({
    $core.int? totalTransactions,
    $core.double? totalCredits,
    $core.double? totalDebits,
    $core.double? netBalance,
    $core.Map<$core.String, $fixnum.Int64>? transactionsByService,
    $core.Map<$core.String, $core.double>? amountByService,
  }) {
    final $result = create();
    if (totalTransactions != null) {
      $result.totalTransactions = totalTransactions;
    }
    if (totalCredits != null) {
      $result.totalCredits = totalCredits;
    }
    if (totalDebits != null) {
      $result.totalDebits = totalDebits;
    }
    if (netBalance != null) {
      $result.netBalance = netBalance;
    }
    if (transactionsByService != null) {
      $result.transactionsByService.addAll(transactionsByService);
    }
    if (amountByService != null) {
      $result.amountByService.addAll(amountByService);
    }
    return $result;
  }
  GetTransactionStatisticsResponse._() : super();
  factory GetTransactionStatisticsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTransactionStatisticsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetTransactionStatisticsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'totalTransactions', $pb.PbFieldType.O3)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'totalCredits', $pb.PbFieldType.OD)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'totalDebits', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'netBalance', $pb.PbFieldType.OD)
    ..m<$core.String, $fixnum.Int64>(5, _omitFieldNames ? '' : 'transactionsByService', entryClassName: 'GetTransactionStatisticsResponse.TransactionsByServiceEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.O6, packageName: const $pb.PackageName('accounts'))
    ..m<$core.String, $core.double>(6, _omitFieldNames ? '' : 'amountByService', entryClassName: 'GetTransactionStatisticsResponse.AmountByServiceEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OD, packageName: const $pb.PackageName('accounts'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetTransactionStatisticsResponse clone() => GetTransactionStatisticsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetTransactionStatisticsResponse copyWith(void Function(GetTransactionStatisticsResponse) updates) => super.copyWith((message) => updates(message as GetTransactionStatisticsResponse)) as GetTransactionStatisticsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTransactionStatisticsResponse create() => GetTransactionStatisticsResponse._();
  GetTransactionStatisticsResponse createEmptyInstance() => create();
  static $pb.PbList<GetTransactionStatisticsResponse> createRepeated() => $pb.PbList<GetTransactionStatisticsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetTransactionStatisticsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetTransactionStatisticsResponse>(create);
  static GetTransactionStatisticsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get totalTransactions => $_getIZ(0);
  @$pb.TagNumber(1)
  set totalTransactions($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTotalTransactions() => $_has(0);
  @$pb.TagNumber(1)
  void clearTotalTransactions() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get totalCredits => $_getN(1);
  @$pb.TagNumber(2)
  set totalCredits($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotalCredits() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalCredits() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get totalDebits => $_getN(2);
  @$pb.TagNumber(3)
  set totalDebits($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTotalDebits() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalDebits() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get netBalance => $_getN(3);
  @$pb.TagNumber(4)
  set netBalance($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasNetBalance() => $_has(3);
  @$pb.TagNumber(4)
  void clearNetBalance() => clearField(4);

  @$pb.TagNumber(5)
  $core.Map<$core.String, $fixnum.Int64> get transactionsByService => $_getMap(4);

  @$pb.TagNumber(6)
  $core.Map<$core.String, $core.double> get amountByService => $_getMap(5);
}

/// ===== Transfer Model (for transfers between accounts) =====
class Transfer extends $pb.GeneratedMessage {
  factory Transfer({
    $core.String? transferId,
    $core.String? fromAccountId,
    $core.String? toAccountId,
    $core.String? fromAccountNumber,
    $core.String? toAccountNumber,
    $core.double? amount,
    $core.String? currency,
    $core.String? description,
    $core.String? reference,
    $core.String? status,
    $core.String? category,
    $core.double? fee,
    $core.double? totalAmount,
    $core.String? createdAt,
    $core.String? completedAt,
    $core.String? failureReason,
  }) {
    final $result = create();
    if (transferId != null) {
      $result.transferId = transferId;
    }
    if (fromAccountId != null) {
      $result.fromAccountId = fromAccountId;
    }
    if (toAccountId != null) {
      $result.toAccountId = toAccountId;
    }
    if (fromAccountNumber != null) {
      $result.fromAccountNumber = fromAccountNumber;
    }
    if (toAccountNumber != null) {
      $result.toAccountNumber = toAccountNumber;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (description != null) {
      $result.description = description;
    }
    if (reference != null) {
      $result.reference = reference;
    }
    if (status != null) {
      $result.status = status;
    }
    if (category != null) {
      $result.category = category;
    }
    if (fee != null) {
      $result.fee = fee;
    }
    if (totalAmount != null) {
      $result.totalAmount = totalAmount;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    if (completedAt != null) {
      $result.completedAt = completedAt;
    }
    if (failureReason != null) {
      $result.failureReason = failureReason;
    }
    return $result;
  }
  Transfer._() : super();
  factory Transfer.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Transfer.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Transfer', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'transferId')
    ..aOS(2, _omitFieldNames ? '' : 'fromAccountId')
    ..aOS(3, _omitFieldNames ? '' : 'toAccountId')
    ..aOS(4, _omitFieldNames ? '' : 'fromAccountNumber')
    ..aOS(5, _omitFieldNames ? '' : 'toAccountNumber')
    ..a<$core.double>(6, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(7, _omitFieldNames ? '' : 'currency')
    ..aOS(8, _omitFieldNames ? '' : 'description')
    ..aOS(9, _omitFieldNames ? '' : 'reference')
    ..aOS(10, _omitFieldNames ? '' : 'status')
    ..aOS(11, _omitFieldNames ? '' : 'category')
    ..a<$core.double>(12, _omitFieldNames ? '' : 'fee', $pb.PbFieldType.OD)
    ..a<$core.double>(13, _omitFieldNames ? '' : 'totalAmount', $pb.PbFieldType.OD)
    ..aOS(14, _omitFieldNames ? '' : 'createdAt')
    ..aOS(15, _omitFieldNames ? '' : 'completedAt')
    ..aOS(16, _omitFieldNames ? '' : 'failureReason')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Transfer clone() => Transfer()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Transfer copyWith(void Function(Transfer) updates) => super.copyWith((message) => updates(message as Transfer)) as Transfer;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Transfer create() => Transfer._();
  Transfer createEmptyInstance() => create();
  static $pb.PbList<Transfer> createRepeated() => $pb.PbList<Transfer>();
  @$core.pragma('dart2js:noInline')
  static Transfer getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Transfer>(create);
  static Transfer? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get transferId => $_getSZ(0);
  @$pb.TagNumber(1)
  set transferId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTransferId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransferId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get fromAccountId => $_getSZ(1);
  @$pb.TagNumber(2)
  set fromAccountId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasFromAccountId() => $_has(1);
  @$pb.TagNumber(2)
  void clearFromAccountId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get toAccountId => $_getSZ(2);
  @$pb.TagNumber(3)
  set toAccountId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasToAccountId() => $_has(2);
  @$pb.TagNumber(3)
  void clearToAccountId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get fromAccountNumber => $_getSZ(3);
  @$pb.TagNumber(4)
  set fromAccountNumber($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasFromAccountNumber() => $_has(3);
  @$pb.TagNumber(4)
  void clearFromAccountNumber() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get toAccountNumber => $_getSZ(4);
  @$pb.TagNumber(5)
  set toAccountNumber($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasToAccountNumber() => $_has(4);
  @$pb.TagNumber(5)
  void clearToAccountNumber() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get amount => $_getN(5);
  @$pb.TagNumber(6)
  set amount($core.double v) { $_setDouble(5, v); }
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
  $core.String get description => $_getSZ(7);
  @$pb.TagNumber(8)
  set description($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasDescription() => $_has(7);
  @$pb.TagNumber(8)
  void clearDescription() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get reference => $_getSZ(8);
  @$pb.TagNumber(9)
  set reference($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasReference() => $_has(8);
  @$pb.TagNumber(9)
  void clearReference() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get status => $_getSZ(9);
  @$pb.TagNumber(10)
  set status($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasStatus() => $_has(9);
  @$pb.TagNumber(10)
  void clearStatus() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get category => $_getSZ(10);
  @$pb.TagNumber(11)
  set category($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasCategory() => $_has(10);
  @$pb.TagNumber(11)
  void clearCategory() => clearField(11);

  @$pb.TagNumber(12)
  $core.double get fee => $_getN(11);
  @$pb.TagNumber(12)
  set fee($core.double v) { $_setDouble(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasFee() => $_has(11);
  @$pb.TagNumber(12)
  void clearFee() => clearField(12);

  @$pb.TagNumber(13)
  $core.double get totalAmount => $_getN(12);
  @$pb.TagNumber(13)
  set totalAmount($core.double v) { $_setDouble(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasTotalAmount() => $_has(12);
  @$pb.TagNumber(13)
  void clearTotalAmount() => clearField(13);

  @$pb.TagNumber(14)
  $core.String get createdAt => $_getSZ(13);
  @$pb.TagNumber(14)
  set createdAt($core.String v) { $_setString(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasCreatedAt() => $_has(13);
  @$pb.TagNumber(14)
  void clearCreatedAt() => clearField(14);

  @$pb.TagNumber(15)
  $core.String get completedAt => $_getSZ(14);
  @$pb.TagNumber(15)
  set completedAt($core.String v) { $_setString(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasCompletedAt() => $_has(14);
  @$pb.TagNumber(15)
  void clearCompletedAt() => clearField(15);

  @$pb.TagNumber(16)
  $core.String get failureReason => $_getSZ(15);
  @$pb.TagNumber(16)
  set failureReason($core.String v) { $_setString(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasFailureReason() => $_has(15);
  @$pb.TagNumber(16)
  void clearFailureReason() => clearField(16);
}

/// ===== Create Transfer =====
class CreateTransferRequest extends $pb.GeneratedMessage {
  factory CreateTransferRequest({
    $core.String? userId,
    $core.String? fromAccount,
    $core.String? toAccount,
    $core.double? amount,
    $core.String? currency,
    $core.String? description,
    $core.String? pin,
    $core.String? reference,
  }) {
    final $result = create();
    if (userId != null) {
      $result.userId = userId;
    }
    if (fromAccount != null) {
      $result.fromAccount = fromAccount;
    }
    if (toAccount != null) {
      $result.toAccount = toAccount;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (description != null) {
      $result.description = description;
    }
    if (pin != null) {
      $result.pin = pin;
    }
    if (reference != null) {
      $result.reference = reference;
    }
    return $result;
  }
  CreateTransferRequest._() : super();
  factory CreateTransferRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateTransferRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateTransferRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'fromAccount')
    ..aOS(3, _omitFieldNames ? '' : 'toAccount')
    ..a<$core.double>(4, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(5, _omitFieldNames ? '' : 'currency')
    ..aOS(6, _omitFieldNames ? '' : 'description')
    ..aOS(7, _omitFieldNames ? '' : 'pin')
    ..aOS(8, _omitFieldNames ? '' : 'reference')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateTransferRequest clone() => CreateTransferRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateTransferRequest copyWith(void Function(CreateTransferRequest) updates) => super.copyWith((message) => updates(message as CreateTransferRequest)) as CreateTransferRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateTransferRequest create() => CreateTransferRequest._();
  CreateTransferRequest createEmptyInstance() => create();
  static $pb.PbList<CreateTransferRequest> createRepeated() => $pb.PbList<CreateTransferRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateTransferRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateTransferRequest>(create);
  static CreateTransferRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get fromAccount => $_getSZ(1);
  @$pb.TagNumber(2)
  set fromAccount($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasFromAccount() => $_has(1);
  @$pb.TagNumber(2)
  void clearFromAccount() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get toAccount => $_getSZ(2);
  @$pb.TagNumber(3)
  set toAccount($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasToAccount() => $_has(2);
  @$pb.TagNumber(3)
  void clearToAccount() => clearField(3);

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
  $core.String get description => $_getSZ(5);
  @$pb.TagNumber(6)
  set description($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasDescription() => $_has(5);
  @$pb.TagNumber(6)
  void clearDescription() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get pin => $_getSZ(6);
  @$pb.TagNumber(7)
  set pin($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasPin() => $_has(6);
  @$pb.TagNumber(7)
  void clearPin() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get reference => $_getSZ(7);
  @$pb.TagNumber(8)
  set reference($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasReference() => $_has(7);
  @$pb.TagNumber(8)
  void clearReference() => clearField(8);
}

class CreateTransferResponse extends $pb.GeneratedMessage {
  factory CreateTransferResponse({
    Transfer? transfer,
    $core.String? message,
  }) {
    final $result = create();
    if (transfer != null) {
      $result.transfer = transfer;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  CreateTransferResponse._() : super();
  factory CreateTransferResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateTransferResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateTransferResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOM<Transfer>(1, _omitFieldNames ? '' : 'transfer', subBuilder: Transfer.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateTransferResponse clone() => CreateTransferResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateTransferResponse copyWith(void Function(CreateTransferResponse) updates) => super.copyWith((message) => updates(message as CreateTransferResponse)) as CreateTransferResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateTransferResponse create() => CreateTransferResponse._();
  CreateTransferResponse createEmptyInstance() => create();
  static $pb.PbList<CreateTransferResponse> createRepeated() => $pb.PbList<CreateTransferResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateTransferResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateTransferResponse>(create);
  static CreateTransferResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Transfer get transfer => $_getN(0);
  @$pb.TagNumber(1)
  set transfer(Transfer v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasTransfer() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransfer() => clearField(1);
  @$pb.TagNumber(1)
  Transfer ensureTransfer() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

/// ===== Get Transfer =====
class GetTransferRequest extends $pb.GeneratedMessage {
  factory GetTransferRequest({
    $core.String? transferId,
  }) {
    final $result = create();
    if (transferId != null) {
      $result.transferId = transferId;
    }
    return $result;
  }
  GetTransferRequest._() : super();
  factory GetTransferRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTransferRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetTransferRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'transferId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetTransferRequest clone() => GetTransferRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetTransferRequest copyWith(void Function(GetTransferRequest) updates) => super.copyWith((message) => updates(message as GetTransferRequest)) as GetTransferRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTransferRequest create() => GetTransferRequest._();
  GetTransferRequest createEmptyInstance() => create();
  static $pb.PbList<GetTransferRequest> createRepeated() => $pb.PbList<GetTransferRequest>();
  @$core.pragma('dart2js:noInline')
  static GetTransferRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetTransferRequest>(create);
  static GetTransferRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get transferId => $_getSZ(0);
  @$pb.TagNumber(1)
  set transferId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTransferId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransferId() => clearField(1);
}

class GetTransferResponse extends $pb.GeneratedMessage {
  factory GetTransferResponse({
    Transfer? transfer,
  }) {
    final $result = create();
    if (transfer != null) {
      $result.transfer = transfer;
    }
    return $result;
  }
  GetTransferResponse._() : super();
  factory GetTransferResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTransferResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetTransferResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOM<Transfer>(1, _omitFieldNames ? '' : 'transfer', subBuilder: Transfer.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetTransferResponse clone() => GetTransferResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetTransferResponse copyWith(void Function(GetTransferResponse) updates) => super.copyWith((message) => updates(message as GetTransferResponse)) as GetTransferResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTransferResponse create() => GetTransferResponse._();
  GetTransferResponse createEmptyInstance() => create();
  static $pb.PbList<GetTransferResponse> createRepeated() => $pb.PbList<GetTransferResponse>();
  @$core.pragma('dart2js:noInline')
  static GetTransferResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetTransferResponse>(create);
  static GetTransferResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Transfer get transfer => $_getN(0);
  @$pb.TagNumber(1)
  set transfer(Transfer v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasTransfer() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransfer() => clearField(1);
  @$pb.TagNumber(1)
  Transfer ensureTransfer() => $_ensure(0);
}

/// CreateVirtualAccountRequest - Create a real virtual NUBAN account
/// NOTE: user_id extracted from JWT token, not from request
class CreateVirtualAccountRequest extends $pb.GeneratedMessage {
  factory CreateVirtualAccountRequest({
    $core.String? accountName,
    $core.String? accountType,
    $core.String? currency,
    $core.String? locale,
    $core.bool? isPrimary,
    $core.double? dailyLimit,
    $core.double? monthlyLimit,
    $core.String? email,
    $core.String? firstName,
    $core.String? lastName,
    $core.String? phoneNumber,
    $core.String? bvn,
  }) {
    final $result = create();
    if (accountName != null) {
      $result.accountName = accountName;
    }
    if (accountType != null) {
      $result.accountType = accountType;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (locale != null) {
      $result.locale = locale;
    }
    if (isPrimary != null) {
      $result.isPrimary = isPrimary;
    }
    if (dailyLimit != null) {
      $result.dailyLimit = dailyLimit;
    }
    if (monthlyLimit != null) {
      $result.monthlyLimit = monthlyLimit;
    }
    if (email != null) {
      $result.email = email;
    }
    if (firstName != null) {
      $result.firstName = firstName;
    }
    if (lastName != null) {
      $result.lastName = lastName;
    }
    if (phoneNumber != null) {
      $result.phoneNumber = phoneNumber;
    }
    if (bvn != null) {
      $result.bvn = bvn;
    }
    return $result;
  }
  CreateVirtualAccountRequest._() : super();
  factory CreateVirtualAccountRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateVirtualAccountRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateVirtualAccountRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountName')
    ..aOS(2, _omitFieldNames ? '' : 'accountType')
    ..aOS(3, _omitFieldNames ? '' : 'currency')
    ..aOS(4, _omitFieldNames ? '' : 'locale')
    ..aOB(5, _omitFieldNames ? '' : 'isPrimary')
    ..a<$core.double>(6, _omitFieldNames ? '' : 'dailyLimit', $pb.PbFieldType.OD)
    ..a<$core.double>(7, _omitFieldNames ? '' : 'monthlyLimit', $pb.PbFieldType.OD)
    ..aOS(8, _omitFieldNames ? '' : 'email')
    ..aOS(9, _omitFieldNames ? '' : 'firstName')
    ..aOS(10, _omitFieldNames ? '' : 'lastName')
    ..aOS(11, _omitFieldNames ? '' : 'phoneNumber')
    ..aOS(12, _omitFieldNames ? '' : 'bvn')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateVirtualAccountRequest clone() => CreateVirtualAccountRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateVirtualAccountRequest copyWith(void Function(CreateVirtualAccountRequest) updates) => super.copyWith((message) => updates(message as CreateVirtualAccountRequest)) as CreateVirtualAccountRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateVirtualAccountRequest create() => CreateVirtualAccountRequest._();
  CreateVirtualAccountRequest createEmptyInstance() => create();
  static $pb.PbList<CreateVirtualAccountRequest> createRepeated() => $pb.PbList<CreateVirtualAccountRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateVirtualAccountRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateVirtualAccountRequest>(create);
  static CreateVirtualAccountRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountName => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountName($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccountName() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountName() => clearField(1);

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
  $core.String get locale => $_getSZ(3);
  @$pb.TagNumber(4)
  set locale($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasLocale() => $_has(3);
  @$pb.TagNumber(4)
  void clearLocale() => clearField(4);

  @$pb.TagNumber(5)
  $core.bool get isPrimary => $_getBF(4);
  @$pb.TagNumber(5)
  set isPrimary($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasIsPrimary() => $_has(4);
  @$pb.TagNumber(5)
  void clearIsPrimary() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get dailyLimit => $_getN(5);
  @$pb.TagNumber(6)
  set dailyLimit($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasDailyLimit() => $_has(5);
  @$pb.TagNumber(6)
  void clearDailyLimit() => clearField(6);

  @$pb.TagNumber(7)
  $core.double get monthlyLimit => $_getN(6);
  @$pb.TagNumber(7)
  set monthlyLimit($core.double v) { $_setDouble(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasMonthlyLimit() => $_has(6);
  @$pb.TagNumber(7)
  void clearMonthlyLimit() => clearField(7);

  /// User details required for virtual account creation
  @$pb.TagNumber(8)
  $core.String get email => $_getSZ(7);
  @$pb.TagNumber(8)
  set email($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasEmail() => $_has(7);
  @$pb.TagNumber(8)
  void clearEmail() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get firstName => $_getSZ(8);
  @$pb.TagNumber(9)
  set firstName($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasFirstName() => $_has(8);
  @$pb.TagNumber(9)
  void clearFirstName() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get lastName => $_getSZ(9);
  @$pb.TagNumber(10)
  set lastName($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasLastName() => $_has(9);
  @$pb.TagNumber(10)
  void clearLastName() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get phoneNumber => $_getSZ(10);
  @$pb.TagNumber(11)
  set phoneNumber($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasPhoneNumber() => $_has(10);
  @$pb.TagNumber(11)
  void clearPhoneNumber() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get bvn => $_getSZ(11);
  @$pb.TagNumber(12)
  set bvn($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasBvn() => $_has(11);
  @$pb.TagNumber(12)
  void clearBvn() => clearField(12);
}

class CreateVirtualAccountResponse extends $pb.GeneratedMessage {
  factory CreateVirtualAccountResponse({
    Account? account,
    $core.String? message,
    $core.String? provider,
  }) {
    final $result = create();
    if (account != null) {
      $result.account = account;
    }
    if (message != null) {
      $result.message = message;
    }
    if (provider != null) {
      $result.provider = provider;
    }
    return $result;
  }
  CreateVirtualAccountResponse._() : super();
  factory CreateVirtualAccountResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateVirtualAccountResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateVirtualAccountResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOM<Account>(1, _omitFieldNames ? '' : 'account', subBuilder: Account.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOS(3, _omitFieldNames ? '' : 'provider')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateVirtualAccountResponse clone() => CreateVirtualAccountResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateVirtualAccountResponse copyWith(void Function(CreateVirtualAccountResponse) updates) => super.copyWith((message) => updates(message as CreateVirtualAccountResponse)) as CreateVirtualAccountResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateVirtualAccountResponse create() => CreateVirtualAccountResponse._();
  CreateVirtualAccountResponse createEmptyInstance() => create();
  static $pb.PbList<CreateVirtualAccountResponse> createRepeated() => $pb.PbList<CreateVirtualAccountResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateVirtualAccountResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateVirtualAccountResponse>(create);
  static CreateVirtualAccountResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Account get account => $_getN(0);
  @$pb.TagNumber(1)
  set account(Account v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccount() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccount() => clearField(1);
  @$pb.TagNumber(1)
  Account ensureAccount() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get provider => $_getSZ(2);
  @$pb.TagNumber(3)
  set provider($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasProvider() => $_has(2);
  @$pb.TagNumber(3)
  void clearProvider() => clearField(3);
}

/// CreditBalanceRequest - Request to credit/add funds to an account
class CreditBalanceRequest extends $pb.GeneratedMessage {
  factory CreditBalanceRequest({
    $core.String? accountId,
    $core.String? userId,
    $fixnum.Int64? amount,
    $core.String? currency,
    $core.String? reference,
    $core.String? type,
    $core.String? description,
    $core.String? metadata,
    $core.String? serviceName,
    $core.String? idempotencyKey,
    $core.String? counterpartyName,
    $core.String? counterpartyAccount,
  }) {
    final $result = create();
    if (accountId != null) {
      $result.accountId = accountId;
    }
    if (userId != null) {
      $result.userId = userId;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (reference != null) {
      $result.reference = reference;
    }
    if (type != null) {
      $result.type = type;
    }
    if (description != null) {
      $result.description = description;
    }
    if (metadata != null) {
      $result.metadata = metadata;
    }
    if (serviceName != null) {
      $result.serviceName = serviceName;
    }
    if (idempotencyKey != null) {
      $result.idempotencyKey = idempotencyKey;
    }
    if (counterpartyName != null) {
      $result.counterpartyName = counterpartyName;
    }
    if (counterpartyAccount != null) {
      $result.counterpartyAccount = counterpartyAccount;
    }
    return $result;
  }
  CreditBalanceRequest._() : super();
  factory CreditBalanceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreditBalanceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreditBalanceRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountId')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aInt64(3, _omitFieldNames ? '' : 'amount')
    ..aOS(4, _omitFieldNames ? '' : 'currency')
    ..aOS(5, _omitFieldNames ? '' : 'reference')
    ..aOS(6, _omitFieldNames ? '' : 'type')
    ..aOS(7, _omitFieldNames ? '' : 'description')
    ..aOS(8, _omitFieldNames ? '' : 'metadata')
    ..aOS(9, _omitFieldNames ? '' : 'serviceName')
    ..aOS(10, _omitFieldNames ? '' : 'idempotencyKey')
    ..aOS(11, _omitFieldNames ? '' : 'counterpartyName')
    ..aOS(12, _omitFieldNames ? '' : 'counterpartyAccount')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreditBalanceRequest clone() => CreditBalanceRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreditBalanceRequest copyWith(void Function(CreditBalanceRequest) updates) => super.copyWith((message) => updates(message as CreditBalanceRequest)) as CreditBalanceRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreditBalanceRequest create() => CreditBalanceRequest._();
  CreditBalanceRequest createEmptyInstance() => create();
  static $pb.PbList<CreditBalanceRequest> createRepeated() => $pb.PbList<CreditBalanceRequest>();
  @$core.pragma('dart2js:noInline')
  static CreditBalanceRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreditBalanceRequest>(create);
  static CreditBalanceRequest? _defaultInstance;

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
  $core.String get reference => $_getSZ(4);
  @$pb.TagNumber(5)
  set reference($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasReference() => $_has(4);
  @$pb.TagNumber(5)
  void clearReference() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get type => $_getSZ(5);
  @$pb.TagNumber(6)
  set type($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasType() => $_has(5);
  @$pb.TagNumber(6)
  void clearType() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get description => $_getSZ(6);
  @$pb.TagNumber(7)
  set description($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasDescription() => $_has(6);
  @$pb.TagNumber(7)
  void clearDescription() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get metadata => $_getSZ(7);
  @$pb.TagNumber(8)
  set metadata($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasMetadata() => $_has(7);
  @$pb.TagNumber(8)
  void clearMetadata() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get serviceName => $_getSZ(8);
  @$pb.TagNumber(9)
  set serviceName($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasServiceName() => $_has(8);
  @$pb.TagNumber(9)
  void clearServiceName() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get idempotencyKey => $_getSZ(9);
  @$pb.TagNumber(10)
  set idempotencyKey($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasIdempotencyKey() => $_has(9);
  @$pb.TagNumber(10)
  void clearIdempotencyKey() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get counterpartyName => $_getSZ(10);
  @$pb.TagNumber(11)
  set counterpartyName($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasCounterpartyName() => $_has(10);
  @$pb.TagNumber(11)
  void clearCounterpartyName() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get counterpartyAccount => $_getSZ(11);
  @$pb.TagNumber(12)
  set counterpartyAccount($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasCounterpartyAccount() => $_has(11);
  @$pb.TagNumber(12)
  void clearCounterpartyAccount() => clearField(12);
}

class CreditBalanceResponse extends $pb.GeneratedMessage {
  factory CreditBalanceResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
    $core.String? transactionId,
    $fixnum.Int64? newBalance,
    $fixnum.Int64? newAvailableBalance,
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
    if (transactionId != null) {
      $result.transactionId = transactionId;
    }
    if (newBalance != null) {
      $result.newBalance = newBalance;
    }
    if (newAvailableBalance != null) {
      $result.newAvailableBalance = newAvailableBalance;
    }
    return $result;
  }
  CreditBalanceResponse._() : super();
  factory CreditBalanceResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreditBalanceResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreditBalanceResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'errorCode')
    ..aOS(3, _omitFieldNames ? '' : 'errorMessage')
    ..aOS(4, _omitFieldNames ? '' : 'transactionId')
    ..aInt64(5, _omitFieldNames ? '' : 'newBalance')
    ..aInt64(6, _omitFieldNames ? '' : 'newAvailableBalance')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreditBalanceResponse clone() => CreditBalanceResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreditBalanceResponse copyWith(void Function(CreditBalanceResponse) updates) => super.copyWith((message) => updates(message as CreditBalanceResponse)) as CreditBalanceResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreditBalanceResponse create() => CreditBalanceResponse._();
  CreditBalanceResponse createEmptyInstance() => create();
  static $pb.PbList<CreditBalanceResponse> createRepeated() => $pb.PbList<CreditBalanceResponse>();
  @$core.pragma('dart2js:noInline')
  static CreditBalanceResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreditBalanceResponse>(create);
  static CreditBalanceResponse? _defaultInstance;

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
  $core.String get transactionId => $_getSZ(3);
  @$pb.TagNumber(4)
  set transactionId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTransactionId() => $_has(3);
  @$pb.TagNumber(4)
  void clearTransactionId() => clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get newBalance => $_getI64(4);
  @$pb.TagNumber(5)
  set newBalance($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasNewBalance() => $_has(4);
  @$pb.TagNumber(5)
  void clearNewBalance() => clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get newAvailableBalance => $_getI64(5);
  @$pb.TagNumber(6)
  set newAvailableBalance($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasNewAvailableBalance() => $_has(5);
  @$pb.TagNumber(6)
  void clearNewAvailableBalance() => clearField(6);
}

/// DebitBalanceRequest - Request to debit/remove funds from an account
class DebitBalanceRequest extends $pb.GeneratedMessage {
  factory DebitBalanceRequest({
    $core.String? accountId,
    $core.String? userId,
    $fixnum.Int64? amount,
    $core.String? currency,
    $core.String? reference,
    $core.String? type,
    $core.String? description,
    $core.String? metadata,
    $core.String? serviceName,
    $core.String? idempotencyKey,
    $core.bool? requireHold,
    $core.String? holdId,
    $core.String? counterpartyName,
    $core.String? counterpartyAccount,
  }) {
    final $result = create();
    if (accountId != null) {
      $result.accountId = accountId;
    }
    if (userId != null) {
      $result.userId = userId;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (reference != null) {
      $result.reference = reference;
    }
    if (type != null) {
      $result.type = type;
    }
    if (description != null) {
      $result.description = description;
    }
    if (metadata != null) {
      $result.metadata = metadata;
    }
    if (serviceName != null) {
      $result.serviceName = serviceName;
    }
    if (idempotencyKey != null) {
      $result.idempotencyKey = idempotencyKey;
    }
    if (requireHold != null) {
      $result.requireHold = requireHold;
    }
    if (holdId != null) {
      $result.holdId = holdId;
    }
    if (counterpartyName != null) {
      $result.counterpartyName = counterpartyName;
    }
    if (counterpartyAccount != null) {
      $result.counterpartyAccount = counterpartyAccount;
    }
    return $result;
  }
  DebitBalanceRequest._() : super();
  factory DebitBalanceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DebitBalanceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DebitBalanceRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountId')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aInt64(3, _omitFieldNames ? '' : 'amount')
    ..aOS(4, _omitFieldNames ? '' : 'currency')
    ..aOS(5, _omitFieldNames ? '' : 'reference')
    ..aOS(6, _omitFieldNames ? '' : 'type')
    ..aOS(7, _omitFieldNames ? '' : 'description')
    ..aOS(8, _omitFieldNames ? '' : 'metadata')
    ..aOS(9, _omitFieldNames ? '' : 'serviceName')
    ..aOS(10, _omitFieldNames ? '' : 'idempotencyKey')
    ..aOB(11, _omitFieldNames ? '' : 'requireHold')
    ..aOS(12, _omitFieldNames ? '' : 'holdId')
    ..aOS(13, _omitFieldNames ? '' : 'counterpartyName')
    ..aOS(14, _omitFieldNames ? '' : 'counterpartyAccount')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DebitBalanceRequest clone() => DebitBalanceRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DebitBalanceRequest copyWith(void Function(DebitBalanceRequest) updates) => super.copyWith((message) => updates(message as DebitBalanceRequest)) as DebitBalanceRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DebitBalanceRequest create() => DebitBalanceRequest._();
  DebitBalanceRequest createEmptyInstance() => create();
  static $pb.PbList<DebitBalanceRequest> createRepeated() => $pb.PbList<DebitBalanceRequest>();
  @$core.pragma('dart2js:noInline')
  static DebitBalanceRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DebitBalanceRequest>(create);
  static DebitBalanceRequest? _defaultInstance;

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
  $core.String get reference => $_getSZ(4);
  @$pb.TagNumber(5)
  set reference($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasReference() => $_has(4);
  @$pb.TagNumber(5)
  void clearReference() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get type => $_getSZ(5);
  @$pb.TagNumber(6)
  set type($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasType() => $_has(5);
  @$pb.TagNumber(6)
  void clearType() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get description => $_getSZ(6);
  @$pb.TagNumber(7)
  set description($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasDescription() => $_has(6);
  @$pb.TagNumber(7)
  void clearDescription() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get metadata => $_getSZ(7);
  @$pb.TagNumber(8)
  set metadata($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasMetadata() => $_has(7);
  @$pb.TagNumber(8)
  void clearMetadata() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get serviceName => $_getSZ(8);
  @$pb.TagNumber(9)
  set serviceName($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasServiceName() => $_has(8);
  @$pb.TagNumber(9)
  void clearServiceName() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get idempotencyKey => $_getSZ(9);
  @$pb.TagNumber(10)
  set idempotencyKey($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasIdempotencyKey() => $_has(9);
  @$pb.TagNumber(10)
  void clearIdempotencyKey() => clearField(10);

  @$pb.TagNumber(11)
  $core.bool get requireHold => $_getBF(10);
  @$pb.TagNumber(11)
  set requireHold($core.bool v) { $_setBool(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasRequireHold() => $_has(10);
  @$pb.TagNumber(11)
  void clearRequireHold() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get holdId => $_getSZ(11);
  @$pb.TagNumber(12)
  set holdId($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasHoldId() => $_has(11);
  @$pb.TagNumber(12)
  void clearHoldId() => clearField(12);

  @$pb.TagNumber(13)
  $core.String get counterpartyName => $_getSZ(12);
  @$pb.TagNumber(13)
  set counterpartyName($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasCounterpartyName() => $_has(12);
  @$pb.TagNumber(13)
  void clearCounterpartyName() => clearField(13);

  @$pb.TagNumber(14)
  $core.String get counterpartyAccount => $_getSZ(13);
  @$pb.TagNumber(14)
  set counterpartyAccount($core.String v) { $_setString(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasCounterpartyAccount() => $_has(13);
  @$pb.TagNumber(14)
  void clearCounterpartyAccount() => clearField(14);
}

class DebitBalanceResponse extends $pb.GeneratedMessage {
  factory DebitBalanceResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
    $core.String? transactionId,
    $fixnum.Int64? newBalance,
    $fixnum.Int64? newAvailableBalance,
    $fixnum.Int64? dailySpentToday,
    $fixnum.Int64? monthlySpent,
    $fixnum.Int64? remainingDailyLimit,
    $fixnum.Int64? remainingMonthlyLimit,
    $fixnum.Int64? remainingSingleTransactionLimit,
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
    if (transactionId != null) {
      $result.transactionId = transactionId;
    }
    if (newBalance != null) {
      $result.newBalance = newBalance;
    }
    if (newAvailableBalance != null) {
      $result.newAvailableBalance = newAvailableBalance;
    }
    if (dailySpentToday != null) {
      $result.dailySpentToday = dailySpentToday;
    }
    if (monthlySpent != null) {
      $result.monthlySpent = monthlySpent;
    }
    if (remainingDailyLimit != null) {
      $result.remainingDailyLimit = remainingDailyLimit;
    }
    if (remainingMonthlyLimit != null) {
      $result.remainingMonthlyLimit = remainingMonthlyLimit;
    }
    if (remainingSingleTransactionLimit != null) {
      $result.remainingSingleTransactionLimit = remainingSingleTransactionLimit;
    }
    return $result;
  }
  DebitBalanceResponse._() : super();
  factory DebitBalanceResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DebitBalanceResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DebitBalanceResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'errorCode')
    ..aOS(3, _omitFieldNames ? '' : 'errorMessage')
    ..aOS(4, _omitFieldNames ? '' : 'transactionId')
    ..aInt64(5, _omitFieldNames ? '' : 'newBalance')
    ..aInt64(6, _omitFieldNames ? '' : 'newAvailableBalance')
    ..aInt64(7, _omitFieldNames ? '' : 'dailySpentToday')
    ..aInt64(8, _omitFieldNames ? '' : 'monthlySpent')
    ..aInt64(9, _omitFieldNames ? '' : 'remainingDailyLimit')
    ..aInt64(10, _omitFieldNames ? '' : 'remainingMonthlyLimit')
    ..aInt64(11, _omitFieldNames ? '' : 'remainingSingleTransactionLimit')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DebitBalanceResponse clone() => DebitBalanceResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DebitBalanceResponse copyWith(void Function(DebitBalanceResponse) updates) => super.copyWith((message) => updates(message as DebitBalanceResponse)) as DebitBalanceResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DebitBalanceResponse create() => DebitBalanceResponse._();
  DebitBalanceResponse createEmptyInstance() => create();
  static $pb.PbList<DebitBalanceResponse> createRepeated() => $pb.PbList<DebitBalanceResponse>();
  @$core.pragma('dart2js:noInline')
  static DebitBalanceResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DebitBalanceResponse>(create);
  static DebitBalanceResponse? _defaultInstance;

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
  $core.String get transactionId => $_getSZ(3);
  @$pb.TagNumber(4)
  set transactionId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTransactionId() => $_has(3);
  @$pb.TagNumber(4)
  void clearTransactionId() => clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get newBalance => $_getI64(4);
  @$pb.TagNumber(5)
  set newBalance($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasNewBalance() => $_has(4);
  @$pb.TagNumber(5)
  void clearNewBalance() => clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get newAvailableBalance => $_getI64(5);
  @$pb.TagNumber(6)
  set newAvailableBalance($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasNewAvailableBalance() => $_has(5);
  @$pb.TagNumber(6)
  void clearNewAvailableBalance() => clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get dailySpentToday => $_getI64(6);
  @$pb.TagNumber(7)
  set dailySpentToday($fixnum.Int64 v) { $_setInt64(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasDailySpentToday() => $_has(6);
  @$pb.TagNumber(7)
  void clearDailySpentToday() => clearField(7);

  @$pb.TagNumber(8)
  $fixnum.Int64 get monthlySpent => $_getI64(7);
  @$pb.TagNumber(8)
  set monthlySpent($fixnum.Int64 v) { $_setInt64(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasMonthlySpent() => $_has(7);
  @$pb.TagNumber(8)
  void clearMonthlySpent() => clearField(8);

  @$pb.TagNumber(9)
  $fixnum.Int64 get remainingDailyLimit => $_getI64(8);
  @$pb.TagNumber(9)
  set remainingDailyLimit($fixnum.Int64 v) { $_setInt64(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasRemainingDailyLimit() => $_has(8);
  @$pb.TagNumber(9)
  void clearRemainingDailyLimit() => clearField(9);

  @$pb.TagNumber(10)
  $fixnum.Int64 get remainingMonthlyLimit => $_getI64(9);
  @$pb.TagNumber(10)
  set remainingMonthlyLimit($fixnum.Int64 v) { $_setInt64(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasRemainingMonthlyLimit() => $_has(9);
  @$pb.TagNumber(10)
  void clearRemainingMonthlyLimit() => clearField(10);

  @$pb.TagNumber(11)
  $fixnum.Int64 get remainingSingleTransactionLimit => $_getI64(10);
  @$pb.TagNumber(11)
  set remainingSingleTransactionLimit($fixnum.Int64 v) { $_setInt64(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasRemainingSingleTransactionLimit() => $_has(10);
  @$pb.TagNumber(11)
  void clearRemainingSingleTransactionLimit() => clearField(11);
}

/// TransferBalanceRequest - Atomic internal transfer between accounts
class TransferBalanceRequest extends $pb.GeneratedMessage {
  factory TransferBalanceRequest({
    $core.String? fromAccountId,
    $core.String? toAccountId,
    $core.String? fromUserId,
    $core.String? toUserId,
    $fixnum.Int64? amount,
    $core.String? currency,
    $core.String? reference,
    $core.String? description,
    $core.String? metadata,
    $core.String? serviceName,
    $core.String? idempotencyKey,
  }) {
    final $result = create();
    if (fromAccountId != null) {
      $result.fromAccountId = fromAccountId;
    }
    if (toAccountId != null) {
      $result.toAccountId = toAccountId;
    }
    if (fromUserId != null) {
      $result.fromUserId = fromUserId;
    }
    if (toUserId != null) {
      $result.toUserId = toUserId;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (reference != null) {
      $result.reference = reference;
    }
    if (description != null) {
      $result.description = description;
    }
    if (metadata != null) {
      $result.metadata = metadata;
    }
    if (serviceName != null) {
      $result.serviceName = serviceName;
    }
    if (idempotencyKey != null) {
      $result.idempotencyKey = idempotencyKey;
    }
    return $result;
  }
  TransferBalanceRequest._() : super();
  factory TransferBalanceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TransferBalanceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TransferBalanceRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'fromAccountId')
    ..aOS(2, _omitFieldNames ? '' : 'toAccountId')
    ..aOS(3, _omitFieldNames ? '' : 'fromUserId')
    ..aOS(4, _omitFieldNames ? '' : 'toUserId')
    ..aInt64(5, _omitFieldNames ? '' : 'amount')
    ..aOS(6, _omitFieldNames ? '' : 'currency')
    ..aOS(7, _omitFieldNames ? '' : 'reference')
    ..aOS(8, _omitFieldNames ? '' : 'description')
    ..aOS(9, _omitFieldNames ? '' : 'metadata')
    ..aOS(10, _omitFieldNames ? '' : 'serviceName')
    ..aOS(11, _omitFieldNames ? '' : 'idempotencyKey')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TransferBalanceRequest clone() => TransferBalanceRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TransferBalanceRequest copyWith(void Function(TransferBalanceRequest) updates) => super.copyWith((message) => updates(message as TransferBalanceRequest)) as TransferBalanceRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TransferBalanceRequest create() => TransferBalanceRequest._();
  TransferBalanceRequest createEmptyInstance() => create();
  static $pb.PbList<TransferBalanceRequest> createRepeated() => $pb.PbList<TransferBalanceRequest>();
  @$core.pragma('dart2js:noInline')
  static TransferBalanceRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TransferBalanceRequest>(create);
  static TransferBalanceRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get fromAccountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set fromAccountId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFromAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFromAccountId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get toAccountId => $_getSZ(1);
  @$pb.TagNumber(2)
  set toAccountId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasToAccountId() => $_has(1);
  @$pb.TagNumber(2)
  void clearToAccountId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get fromUserId => $_getSZ(2);
  @$pb.TagNumber(3)
  set fromUserId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasFromUserId() => $_has(2);
  @$pb.TagNumber(3)
  void clearFromUserId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get toUserId => $_getSZ(3);
  @$pb.TagNumber(4)
  set toUserId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasToUserId() => $_has(3);
  @$pb.TagNumber(4)
  void clearToUserId() => clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get amount => $_getI64(4);
  @$pb.TagNumber(5)
  set amount($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasAmount() => $_has(4);
  @$pb.TagNumber(5)
  void clearAmount() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get currency => $_getSZ(5);
  @$pb.TagNumber(6)
  set currency($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasCurrency() => $_has(5);
  @$pb.TagNumber(6)
  void clearCurrency() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get reference => $_getSZ(6);
  @$pb.TagNumber(7)
  set reference($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasReference() => $_has(6);
  @$pb.TagNumber(7)
  void clearReference() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get description => $_getSZ(7);
  @$pb.TagNumber(8)
  set description($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasDescription() => $_has(7);
  @$pb.TagNumber(8)
  void clearDescription() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get metadata => $_getSZ(8);
  @$pb.TagNumber(9)
  set metadata($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasMetadata() => $_has(8);
  @$pb.TagNumber(9)
  void clearMetadata() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get serviceName => $_getSZ(9);
  @$pb.TagNumber(10)
  set serviceName($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasServiceName() => $_has(9);
  @$pb.TagNumber(10)
  void clearServiceName() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get idempotencyKey => $_getSZ(10);
  @$pb.TagNumber(11)
  set idempotencyKey($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasIdempotencyKey() => $_has(10);
  @$pb.TagNumber(11)
  void clearIdempotencyKey() => clearField(11);
}

class TransferBalanceResponse extends $pb.GeneratedMessage {
  factory TransferBalanceResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
    $core.String? debitTransactionId,
    $core.String? creditTransactionId,
    $fixnum.Int64? fromNewBalance,
    $fixnum.Int64? toNewBalance,
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
    if (debitTransactionId != null) {
      $result.debitTransactionId = debitTransactionId;
    }
    if (creditTransactionId != null) {
      $result.creditTransactionId = creditTransactionId;
    }
    if (fromNewBalance != null) {
      $result.fromNewBalance = fromNewBalance;
    }
    if (toNewBalance != null) {
      $result.toNewBalance = toNewBalance;
    }
    return $result;
  }
  TransferBalanceResponse._() : super();
  factory TransferBalanceResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TransferBalanceResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TransferBalanceResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'errorCode')
    ..aOS(3, _omitFieldNames ? '' : 'errorMessage')
    ..aOS(4, _omitFieldNames ? '' : 'debitTransactionId')
    ..aOS(5, _omitFieldNames ? '' : 'creditTransactionId')
    ..aInt64(6, _omitFieldNames ? '' : 'fromNewBalance')
    ..aInt64(7, _omitFieldNames ? '' : 'toNewBalance')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TransferBalanceResponse clone() => TransferBalanceResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TransferBalanceResponse copyWith(void Function(TransferBalanceResponse) updates) => super.copyWith((message) => updates(message as TransferBalanceResponse)) as TransferBalanceResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TransferBalanceResponse create() => TransferBalanceResponse._();
  TransferBalanceResponse createEmptyInstance() => create();
  static $pb.PbList<TransferBalanceResponse> createRepeated() => $pb.PbList<TransferBalanceResponse>();
  @$core.pragma('dart2js:noInline')
  static TransferBalanceResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TransferBalanceResponse>(create);
  static TransferBalanceResponse? _defaultInstance;

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
  $core.String get debitTransactionId => $_getSZ(3);
  @$pb.TagNumber(4)
  set debitTransactionId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasDebitTransactionId() => $_has(3);
  @$pb.TagNumber(4)
  void clearDebitTransactionId() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get creditTransactionId => $_getSZ(4);
  @$pb.TagNumber(5)
  set creditTransactionId($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasCreditTransactionId() => $_has(4);
  @$pb.TagNumber(5)
  void clearCreditTransactionId() => clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get fromNewBalance => $_getI64(5);
  @$pb.TagNumber(6)
  set fromNewBalance($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasFromNewBalance() => $_has(5);
  @$pb.TagNumber(6)
  void clearFromNewBalance() => clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get toNewBalance => $_getI64(6);
  @$pb.TagNumber(7)
  set toNewBalance($fixnum.Int64 v) { $_setInt64(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasToNewBalance() => $_has(6);
  @$pb.TagNumber(7)
  void clearToNewBalance() => clearField(7);
}

/// HoldFundsRequest - Create temporary hold on funds
class HoldFundsRequest extends $pb.GeneratedMessage {
  factory HoldFundsRequest({
    $core.String? accountId,
    $core.String? userId,
    $fixnum.Int64? amount,
    $core.String? currency,
    $core.String? reference,
    $core.String? reason,
    $core.int? expiresInSeconds,
    $core.String? serviceName,
    $core.String? idempotencyKey,
  }) {
    final $result = create();
    if (accountId != null) {
      $result.accountId = accountId;
    }
    if (userId != null) {
      $result.userId = userId;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (reference != null) {
      $result.reference = reference;
    }
    if (reason != null) {
      $result.reason = reason;
    }
    if (expiresInSeconds != null) {
      $result.expiresInSeconds = expiresInSeconds;
    }
    if (serviceName != null) {
      $result.serviceName = serviceName;
    }
    if (idempotencyKey != null) {
      $result.idempotencyKey = idempotencyKey;
    }
    return $result;
  }
  HoldFundsRequest._() : super();
  factory HoldFundsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HoldFundsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'HoldFundsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountId')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aInt64(3, _omitFieldNames ? '' : 'amount')
    ..aOS(4, _omitFieldNames ? '' : 'currency')
    ..aOS(5, _omitFieldNames ? '' : 'reference')
    ..aOS(6, _omitFieldNames ? '' : 'reason')
    ..a<$core.int>(7, _omitFieldNames ? '' : 'expiresInSeconds', $pb.PbFieldType.O3)
    ..aOS(8, _omitFieldNames ? '' : 'serviceName')
    ..aOS(9, _omitFieldNames ? '' : 'idempotencyKey')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  HoldFundsRequest clone() => HoldFundsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  HoldFundsRequest copyWith(void Function(HoldFundsRequest) updates) => super.copyWith((message) => updates(message as HoldFundsRequest)) as HoldFundsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static HoldFundsRequest create() => HoldFundsRequest._();
  HoldFundsRequest createEmptyInstance() => create();
  static $pb.PbList<HoldFundsRequest> createRepeated() => $pb.PbList<HoldFundsRequest>();
  @$core.pragma('dart2js:noInline')
  static HoldFundsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<HoldFundsRequest>(create);
  static HoldFundsRequest? _defaultInstance;

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
  $core.String get reference => $_getSZ(4);
  @$pb.TagNumber(5)
  set reference($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasReference() => $_has(4);
  @$pb.TagNumber(5)
  void clearReference() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get reason => $_getSZ(5);
  @$pb.TagNumber(6)
  set reason($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasReason() => $_has(5);
  @$pb.TagNumber(6)
  void clearReason() => clearField(6);

  @$pb.TagNumber(7)
  $core.int get expiresInSeconds => $_getIZ(6);
  @$pb.TagNumber(7)
  set expiresInSeconds($core.int v) { $_setSignedInt32(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasExpiresInSeconds() => $_has(6);
  @$pb.TagNumber(7)
  void clearExpiresInSeconds() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get serviceName => $_getSZ(7);
  @$pb.TagNumber(8)
  set serviceName($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasServiceName() => $_has(7);
  @$pb.TagNumber(8)
  void clearServiceName() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get idempotencyKey => $_getSZ(8);
  @$pb.TagNumber(9)
  set idempotencyKey($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasIdempotencyKey() => $_has(8);
  @$pb.TagNumber(9)
  void clearIdempotencyKey() => clearField(9);
}

class HoldFundsResponse extends $pb.GeneratedMessage {
  factory HoldFundsResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
    $core.String? holdId,
    $fixnum.Int64? newAvailableBalance,
    $core.String? expiresAt,
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
    if (holdId != null) {
      $result.holdId = holdId;
    }
    if (newAvailableBalance != null) {
      $result.newAvailableBalance = newAvailableBalance;
    }
    if (expiresAt != null) {
      $result.expiresAt = expiresAt;
    }
    return $result;
  }
  HoldFundsResponse._() : super();
  factory HoldFundsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HoldFundsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'HoldFundsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'errorCode')
    ..aOS(3, _omitFieldNames ? '' : 'errorMessage')
    ..aOS(4, _omitFieldNames ? '' : 'holdId')
    ..aInt64(5, _omitFieldNames ? '' : 'newAvailableBalance')
    ..aOS(6, _omitFieldNames ? '' : 'expiresAt')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  HoldFundsResponse clone() => HoldFundsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  HoldFundsResponse copyWith(void Function(HoldFundsResponse) updates) => super.copyWith((message) => updates(message as HoldFundsResponse)) as HoldFundsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static HoldFundsResponse create() => HoldFundsResponse._();
  HoldFundsResponse createEmptyInstance() => create();
  static $pb.PbList<HoldFundsResponse> createRepeated() => $pb.PbList<HoldFundsResponse>();
  @$core.pragma('dart2js:noInline')
  static HoldFundsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<HoldFundsResponse>(create);
  static HoldFundsResponse? _defaultInstance;

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
  $core.String get holdId => $_getSZ(3);
  @$pb.TagNumber(4)
  set holdId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasHoldId() => $_has(3);
  @$pb.TagNumber(4)
  void clearHoldId() => clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get newAvailableBalance => $_getI64(4);
  @$pb.TagNumber(5)
  set newAvailableBalance($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasNewAvailableBalance() => $_has(4);
  @$pb.TagNumber(5)
  void clearNewAvailableBalance() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get expiresAt => $_getSZ(5);
  @$pb.TagNumber(6)
  set expiresAt($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasExpiresAt() => $_has(5);
  @$pb.TagNumber(6)
  void clearExpiresAt() => clearField(6);
}

/// CaptureHoldRequest - Convert hold to actual debit
class CaptureHoldRequest extends $pb.GeneratedMessage {
  factory CaptureHoldRequest({
    $core.String? holdId,
    $core.String? serviceName,
    $core.String? description,
    $core.String? metadata,
  }) {
    final $result = create();
    if (holdId != null) {
      $result.holdId = holdId;
    }
    if (serviceName != null) {
      $result.serviceName = serviceName;
    }
    if (description != null) {
      $result.description = description;
    }
    if (metadata != null) {
      $result.metadata = metadata;
    }
    return $result;
  }
  CaptureHoldRequest._() : super();
  factory CaptureHoldRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CaptureHoldRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CaptureHoldRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'holdId')
    ..aOS(2, _omitFieldNames ? '' : 'serviceName')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..aOS(4, _omitFieldNames ? '' : 'metadata')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CaptureHoldRequest clone() => CaptureHoldRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CaptureHoldRequest copyWith(void Function(CaptureHoldRequest) updates) => super.copyWith((message) => updates(message as CaptureHoldRequest)) as CaptureHoldRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CaptureHoldRequest create() => CaptureHoldRequest._();
  CaptureHoldRequest createEmptyInstance() => create();
  static $pb.PbList<CaptureHoldRequest> createRepeated() => $pb.PbList<CaptureHoldRequest>();
  @$core.pragma('dart2js:noInline')
  static CaptureHoldRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CaptureHoldRequest>(create);
  static CaptureHoldRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get holdId => $_getSZ(0);
  @$pb.TagNumber(1)
  set holdId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasHoldId() => $_has(0);
  @$pb.TagNumber(1)
  void clearHoldId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get serviceName => $_getSZ(1);
  @$pb.TagNumber(2)
  set serviceName($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasServiceName() => $_has(1);
  @$pb.TagNumber(2)
  void clearServiceName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get metadata => $_getSZ(3);
  @$pb.TagNumber(4)
  set metadata($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasMetadata() => $_has(3);
  @$pb.TagNumber(4)
  void clearMetadata() => clearField(4);
}

class CaptureHoldResponse extends $pb.GeneratedMessage {
  factory CaptureHoldResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
    $core.String? transactionId,
    $fixnum.Int64? newBalance,
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
    if (transactionId != null) {
      $result.transactionId = transactionId;
    }
    if (newBalance != null) {
      $result.newBalance = newBalance;
    }
    return $result;
  }
  CaptureHoldResponse._() : super();
  factory CaptureHoldResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CaptureHoldResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CaptureHoldResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'errorCode')
    ..aOS(3, _omitFieldNames ? '' : 'errorMessage')
    ..aOS(4, _omitFieldNames ? '' : 'transactionId')
    ..aInt64(5, _omitFieldNames ? '' : 'newBalance')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CaptureHoldResponse clone() => CaptureHoldResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CaptureHoldResponse copyWith(void Function(CaptureHoldResponse) updates) => super.copyWith((message) => updates(message as CaptureHoldResponse)) as CaptureHoldResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CaptureHoldResponse create() => CaptureHoldResponse._();
  CaptureHoldResponse createEmptyInstance() => create();
  static $pb.PbList<CaptureHoldResponse> createRepeated() => $pb.PbList<CaptureHoldResponse>();
  @$core.pragma('dart2js:noInline')
  static CaptureHoldResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CaptureHoldResponse>(create);
  static CaptureHoldResponse? _defaultInstance;

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
  $core.String get transactionId => $_getSZ(3);
  @$pb.TagNumber(4)
  set transactionId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTransactionId() => $_has(3);
  @$pb.TagNumber(4)
  void clearTransactionId() => clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get newBalance => $_getI64(4);
  @$pb.TagNumber(5)
  set newBalance($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasNewBalance() => $_has(4);
  @$pb.TagNumber(5)
  void clearNewBalance() => clearField(5);
}

/// ReleaseHoldRequest - Release hold without debiting
class ReleaseHoldRequest extends $pb.GeneratedMessage {
  factory ReleaseHoldRequest({
    $core.String? holdId,
    $core.String? serviceName,
    $core.String? reason,
  }) {
    final $result = create();
    if (holdId != null) {
      $result.holdId = holdId;
    }
    if (serviceName != null) {
      $result.serviceName = serviceName;
    }
    if (reason != null) {
      $result.reason = reason;
    }
    return $result;
  }
  ReleaseHoldRequest._() : super();
  factory ReleaseHoldRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ReleaseHoldRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ReleaseHoldRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'holdId')
    ..aOS(2, _omitFieldNames ? '' : 'serviceName')
    ..aOS(3, _omitFieldNames ? '' : 'reason')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ReleaseHoldRequest clone() => ReleaseHoldRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ReleaseHoldRequest copyWith(void Function(ReleaseHoldRequest) updates) => super.copyWith((message) => updates(message as ReleaseHoldRequest)) as ReleaseHoldRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ReleaseHoldRequest create() => ReleaseHoldRequest._();
  ReleaseHoldRequest createEmptyInstance() => create();
  static $pb.PbList<ReleaseHoldRequest> createRepeated() => $pb.PbList<ReleaseHoldRequest>();
  @$core.pragma('dart2js:noInline')
  static ReleaseHoldRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ReleaseHoldRequest>(create);
  static ReleaseHoldRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get holdId => $_getSZ(0);
  @$pb.TagNumber(1)
  set holdId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasHoldId() => $_has(0);
  @$pb.TagNumber(1)
  void clearHoldId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get serviceName => $_getSZ(1);
  @$pb.TagNumber(2)
  set serviceName($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasServiceName() => $_has(1);
  @$pb.TagNumber(2)
  void clearServiceName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get reason => $_getSZ(2);
  @$pb.TagNumber(3)
  set reason($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasReason() => $_has(2);
  @$pb.TagNumber(3)
  void clearReason() => clearField(3);
}

class ReleaseHoldResponse extends $pb.GeneratedMessage {
  factory ReleaseHoldResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
    $fixnum.Int64? newAvailableBalance,
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
    if (newAvailableBalance != null) {
      $result.newAvailableBalance = newAvailableBalance;
    }
    return $result;
  }
  ReleaseHoldResponse._() : super();
  factory ReleaseHoldResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ReleaseHoldResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ReleaseHoldResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'errorCode')
    ..aOS(3, _omitFieldNames ? '' : 'errorMessage')
    ..aInt64(4, _omitFieldNames ? '' : 'newAvailableBalance')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ReleaseHoldResponse clone() => ReleaseHoldResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ReleaseHoldResponse copyWith(void Function(ReleaseHoldResponse) updates) => super.copyWith((message) => updates(message as ReleaseHoldResponse)) as ReleaseHoldResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ReleaseHoldResponse create() => ReleaseHoldResponse._();
  ReleaseHoldResponse createEmptyInstance() => create();
  static $pb.PbList<ReleaseHoldResponse> createRepeated() => $pb.PbList<ReleaseHoldResponse>();
  @$core.pragma('dart2js:noInline')
  static ReleaseHoldResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ReleaseHoldResponse>(create);
  static ReleaseHoldResponse? _defaultInstance;

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
  $fixnum.Int64 get newAvailableBalance => $_getI64(3);
  @$pb.TagNumber(4)
  set newAvailableBalance($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasNewAvailableBalance() => $_has(3);
  @$pb.TagNumber(4)
  void clearNewAvailableBalance() => clearField(4);
}

class PlatformWalletMsg extends $pb.GeneratedMessage {
  factory PlatformWalletMsg({
    $core.String? id,
    $core.String? walletCode,
    $core.String? walletName,
    $core.String? currency,
    $fixnum.Int64? balance,
    $fixnum.Int64? availableBalance,
    $core.String? status,
    $core.String? description,
    $core.String? createdAt,
    $core.String? updatedAt,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (walletCode != null) {
      $result.walletCode = walletCode;
    }
    if (walletName != null) {
      $result.walletName = walletName;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (balance != null) {
      $result.balance = balance;
    }
    if (availableBalance != null) {
      $result.availableBalance = availableBalance;
    }
    if (status != null) {
      $result.status = status;
    }
    if (description != null) {
      $result.description = description;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      $result.updatedAt = updatedAt;
    }
    return $result;
  }
  PlatformWalletMsg._() : super();
  factory PlatformWalletMsg.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PlatformWalletMsg.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PlatformWalletMsg', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'walletCode')
    ..aOS(3, _omitFieldNames ? '' : 'walletName')
    ..aOS(4, _omitFieldNames ? '' : 'currency')
    ..aInt64(5, _omitFieldNames ? '' : 'balance')
    ..aInt64(6, _omitFieldNames ? '' : 'availableBalance')
    ..aOS(7, _omitFieldNames ? '' : 'status')
    ..aOS(8, _omitFieldNames ? '' : 'description')
    ..aOS(9, _omitFieldNames ? '' : 'createdAt')
    ..aOS(10, _omitFieldNames ? '' : 'updatedAt')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PlatformWalletMsg clone() => PlatformWalletMsg()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PlatformWalletMsg copyWith(void Function(PlatformWalletMsg) updates) => super.copyWith((message) => updates(message as PlatformWalletMsg)) as PlatformWalletMsg;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PlatformWalletMsg create() => PlatformWalletMsg._();
  PlatformWalletMsg createEmptyInstance() => create();
  static $pb.PbList<PlatformWalletMsg> createRepeated() => $pb.PbList<PlatformWalletMsg>();
  @$core.pragma('dart2js:noInline')
  static PlatformWalletMsg getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PlatformWalletMsg>(create);
  static PlatformWalletMsg? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get walletCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set walletCode($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasWalletCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearWalletCode() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get walletName => $_getSZ(2);
  @$pb.TagNumber(3)
  set walletName($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasWalletName() => $_has(2);
  @$pb.TagNumber(3)
  void clearWalletName() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get currency => $_getSZ(3);
  @$pb.TagNumber(4)
  set currency($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCurrency() => $_has(3);
  @$pb.TagNumber(4)
  void clearCurrency() => clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get balance => $_getI64(4);
  @$pb.TagNumber(5)
  set balance($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasBalance() => $_has(4);
  @$pb.TagNumber(5)
  void clearBalance() => clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get availableBalance => $_getI64(5);
  @$pb.TagNumber(6)
  set availableBalance($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasAvailableBalance() => $_has(5);
  @$pb.TagNumber(6)
  void clearAvailableBalance() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get status => $_getSZ(6);
  @$pb.TagNumber(7)
  set status($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasStatus() => $_has(6);
  @$pb.TagNumber(7)
  void clearStatus() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get description => $_getSZ(7);
  @$pb.TagNumber(8)
  set description($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasDescription() => $_has(7);
  @$pb.TagNumber(8)
  void clearDescription() => clearField(8);

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
}

class PlatformWalletTransactionMsg extends $pb.GeneratedMessage {
  factory PlatformWalletTransactionMsg({
    $core.String? id,
    $core.String? walletId,
    $core.String? reference,
    $core.String? type,
    $core.String? category,
    $fixnum.Int64? amount,
    $fixnum.Int64? balanceBefore,
    $fixnum.Int64? balanceAfter,
    $core.String? counterpartyAccountId,
    $core.String? counterpartyUserId,
    $core.String? description,
    $core.String? metadata,
    $core.String? serviceName,
    $core.String? status,
    $core.String? createdAt,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (walletId != null) {
      $result.walletId = walletId;
    }
    if (reference != null) {
      $result.reference = reference;
    }
    if (type != null) {
      $result.type = type;
    }
    if (category != null) {
      $result.category = category;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (balanceBefore != null) {
      $result.balanceBefore = balanceBefore;
    }
    if (balanceAfter != null) {
      $result.balanceAfter = balanceAfter;
    }
    if (counterpartyAccountId != null) {
      $result.counterpartyAccountId = counterpartyAccountId;
    }
    if (counterpartyUserId != null) {
      $result.counterpartyUserId = counterpartyUserId;
    }
    if (description != null) {
      $result.description = description;
    }
    if (metadata != null) {
      $result.metadata = metadata;
    }
    if (serviceName != null) {
      $result.serviceName = serviceName;
    }
    if (status != null) {
      $result.status = status;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    return $result;
  }
  PlatformWalletTransactionMsg._() : super();
  factory PlatformWalletTransactionMsg.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PlatformWalletTransactionMsg.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PlatformWalletTransactionMsg', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'walletId')
    ..aOS(3, _omitFieldNames ? '' : 'reference')
    ..aOS(4, _omitFieldNames ? '' : 'type')
    ..aOS(5, _omitFieldNames ? '' : 'category')
    ..aInt64(6, _omitFieldNames ? '' : 'amount')
    ..aInt64(7, _omitFieldNames ? '' : 'balanceBefore')
    ..aInt64(8, _omitFieldNames ? '' : 'balanceAfter')
    ..aOS(9, _omitFieldNames ? '' : 'counterpartyAccountId')
    ..aOS(10, _omitFieldNames ? '' : 'counterpartyUserId')
    ..aOS(11, _omitFieldNames ? '' : 'description')
    ..aOS(12, _omitFieldNames ? '' : 'metadata')
    ..aOS(13, _omitFieldNames ? '' : 'serviceName')
    ..aOS(14, _omitFieldNames ? '' : 'status')
    ..aOS(15, _omitFieldNames ? '' : 'createdAt')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PlatformWalletTransactionMsg clone() => PlatformWalletTransactionMsg()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PlatformWalletTransactionMsg copyWith(void Function(PlatformWalletTransactionMsg) updates) => super.copyWith((message) => updates(message as PlatformWalletTransactionMsg)) as PlatformWalletTransactionMsg;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PlatformWalletTransactionMsg create() => PlatformWalletTransactionMsg._();
  PlatformWalletTransactionMsg createEmptyInstance() => create();
  static $pb.PbList<PlatformWalletTransactionMsg> createRepeated() => $pb.PbList<PlatformWalletTransactionMsg>();
  @$core.pragma('dart2js:noInline')
  static PlatformWalletTransactionMsg getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PlatformWalletTransactionMsg>(create);
  static PlatformWalletTransactionMsg? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get walletId => $_getSZ(1);
  @$pb.TagNumber(2)
  set walletId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasWalletId() => $_has(1);
  @$pb.TagNumber(2)
  void clearWalletId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get reference => $_getSZ(2);
  @$pb.TagNumber(3)
  set reference($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasReference() => $_has(2);
  @$pb.TagNumber(3)
  void clearReference() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get type => $_getSZ(3);
  @$pb.TagNumber(4)
  set type($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasType() => $_has(3);
  @$pb.TagNumber(4)
  void clearType() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get category => $_getSZ(4);
  @$pb.TagNumber(5)
  set category($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasCategory() => $_has(4);
  @$pb.TagNumber(5)
  void clearCategory() => clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get amount => $_getI64(5);
  @$pb.TagNumber(6)
  set amount($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasAmount() => $_has(5);
  @$pb.TagNumber(6)
  void clearAmount() => clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get balanceBefore => $_getI64(6);
  @$pb.TagNumber(7)
  set balanceBefore($fixnum.Int64 v) { $_setInt64(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasBalanceBefore() => $_has(6);
  @$pb.TagNumber(7)
  void clearBalanceBefore() => clearField(7);

  @$pb.TagNumber(8)
  $fixnum.Int64 get balanceAfter => $_getI64(7);
  @$pb.TagNumber(8)
  set balanceAfter($fixnum.Int64 v) { $_setInt64(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasBalanceAfter() => $_has(7);
  @$pb.TagNumber(8)
  void clearBalanceAfter() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get counterpartyAccountId => $_getSZ(8);
  @$pb.TagNumber(9)
  set counterpartyAccountId($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasCounterpartyAccountId() => $_has(8);
  @$pb.TagNumber(9)
  void clearCounterpartyAccountId() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get counterpartyUserId => $_getSZ(9);
  @$pb.TagNumber(10)
  set counterpartyUserId($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasCounterpartyUserId() => $_has(9);
  @$pb.TagNumber(10)
  void clearCounterpartyUserId() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get description => $_getSZ(10);
  @$pb.TagNumber(11)
  set description($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasDescription() => $_has(10);
  @$pb.TagNumber(11)
  void clearDescription() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get metadata => $_getSZ(11);
  @$pb.TagNumber(12)
  set metadata($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasMetadata() => $_has(11);
  @$pb.TagNumber(12)
  void clearMetadata() => clearField(12);

  @$pb.TagNumber(13)
  $core.String get serviceName => $_getSZ(12);
  @$pb.TagNumber(13)
  set serviceName($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasServiceName() => $_has(12);
  @$pb.TagNumber(13)
  void clearServiceName() => clearField(13);

  @$pb.TagNumber(14)
  $core.String get status => $_getSZ(13);
  @$pb.TagNumber(14)
  set status($core.String v) { $_setString(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasStatus() => $_has(13);
  @$pb.TagNumber(14)
  void clearStatus() => clearField(14);

  @$pb.TagNumber(15)
  $core.String get createdAt => $_getSZ(14);
  @$pb.TagNumber(15)
  set createdAt($core.String v) { $_setString(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasCreatedAt() => $_has(14);
  @$pb.TagNumber(15)
  void clearCreatedAt() => clearField(15);
}

/// TransferToPlatformWallet - Debit user account, credit platform wallet
class TransferToPlatformWalletRequest extends $pb.GeneratedMessage {
  factory TransferToPlatformWalletRequest({
    $core.String? userAccountId,
    $core.String? userId,
    $core.String? walletCode,
    $fixnum.Int64? amount,
    $core.String? currency,
    $core.String? reference,
    $core.String? category,
    $core.String? description,
    $core.String? metadata,
    $core.String? serviceName,
    $core.String? idempotencyKey,
  }) {
    final $result = create();
    if (userAccountId != null) {
      $result.userAccountId = userAccountId;
    }
    if (userId != null) {
      $result.userId = userId;
    }
    if (walletCode != null) {
      $result.walletCode = walletCode;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (reference != null) {
      $result.reference = reference;
    }
    if (category != null) {
      $result.category = category;
    }
    if (description != null) {
      $result.description = description;
    }
    if (metadata != null) {
      $result.metadata = metadata;
    }
    if (serviceName != null) {
      $result.serviceName = serviceName;
    }
    if (idempotencyKey != null) {
      $result.idempotencyKey = idempotencyKey;
    }
    return $result;
  }
  TransferToPlatformWalletRequest._() : super();
  factory TransferToPlatformWalletRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TransferToPlatformWalletRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TransferToPlatformWalletRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userAccountId')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'walletCode')
    ..aInt64(4, _omitFieldNames ? '' : 'amount')
    ..aOS(5, _omitFieldNames ? '' : 'currency')
    ..aOS(6, _omitFieldNames ? '' : 'reference')
    ..aOS(7, _omitFieldNames ? '' : 'category')
    ..aOS(8, _omitFieldNames ? '' : 'description')
    ..aOS(9, _omitFieldNames ? '' : 'metadata')
    ..aOS(10, _omitFieldNames ? '' : 'serviceName')
    ..aOS(11, _omitFieldNames ? '' : 'idempotencyKey')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TransferToPlatformWalletRequest clone() => TransferToPlatformWalletRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TransferToPlatformWalletRequest copyWith(void Function(TransferToPlatformWalletRequest) updates) => super.copyWith((message) => updates(message as TransferToPlatformWalletRequest)) as TransferToPlatformWalletRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TransferToPlatformWalletRequest create() => TransferToPlatformWalletRequest._();
  TransferToPlatformWalletRequest createEmptyInstance() => create();
  static $pb.PbList<TransferToPlatformWalletRequest> createRepeated() => $pb.PbList<TransferToPlatformWalletRequest>();
  @$core.pragma('dart2js:noInline')
  static TransferToPlatformWalletRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TransferToPlatformWalletRequest>(create);
  static TransferToPlatformWalletRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userAccountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userAccountId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserAccountId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get walletCode => $_getSZ(2);
  @$pb.TagNumber(3)
  set walletCode($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasWalletCode() => $_has(2);
  @$pb.TagNumber(3)
  void clearWalletCode() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get amount => $_getI64(3);
  @$pb.TagNumber(4)
  set amount($fixnum.Int64 v) { $_setInt64(3, v); }
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
  $core.String get reference => $_getSZ(5);
  @$pb.TagNumber(6)
  set reference($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasReference() => $_has(5);
  @$pb.TagNumber(6)
  void clearReference() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get category => $_getSZ(6);
  @$pb.TagNumber(7)
  set category($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasCategory() => $_has(6);
  @$pb.TagNumber(7)
  void clearCategory() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get description => $_getSZ(7);
  @$pb.TagNumber(8)
  set description($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasDescription() => $_has(7);
  @$pb.TagNumber(8)
  void clearDescription() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get metadata => $_getSZ(8);
  @$pb.TagNumber(9)
  set metadata($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasMetadata() => $_has(8);
  @$pb.TagNumber(9)
  void clearMetadata() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get serviceName => $_getSZ(9);
  @$pb.TagNumber(10)
  set serviceName($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasServiceName() => $_has(9);
  @$pb.TagNumber(10)
  void clearServiceName() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get idempotencyKey => $_getSZ(10);
  @$pb.TagNumber(11)
  set idempotencyKey($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasIdempotencyKey() => $_has(10);
  @$pb.TagNumber(11)
  void clearIdempotencyKey() => clearField(11);
}

class TransferToPlatformWalletResponse extends $pb.GeneratedMessage {
  factory TransferToPlatformWalletResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
    $core.String? debitTransactionId,
    $core.String? platformTransactionId,
    $fixnum.Int64? userNewBalance,
    $fixnum.Int64? walletNewBalance,
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
    if (debitTransactionId != null) {
      $result.debitTransactionId = debitTransactionId;
    }
    if (platformTransactionId != null) {
      $result.platformTransactionId = platformTransactionId;
    }
    if (userNewBalance != null) {
      $result.userNewBalance = userNewBalance;
    }
    if (walletNewBalance != null) {
      $result.walletNewBalance = walletNewBalance;
    }
    return $result;
  }
  TransferToPlatformWalletResponse._() : super();
  factory TransferToPlatformWalletResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TransferToPlatformWalletResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TransferToPlatformWalletResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'errorCode')
    ..aOS(3, _omitFieldNames ? '' : 'errorMessage')
    ..aOS(4, _omitFieldNames ? '' : 'debitTransactionId')
    ..aOS(5, _omitFieldNames ? '' : 'platformTransactionId')
    ..aInt64(6, _omitFieldNames ? '' : 'userNewBalance')
    ..aInt64(7, _omitFieldNames ? '' : 'walletNewBalance')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TransferToPlatformWalletResponse clone() => TransferToPlatformWalletResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TransferToPlatformWalletResponse copyWith(void Function(TransferToPlatformWalletResponse) updates) => super.copyWith((message) => updates(message as TransferToPlatformWalletResponse)) as TransferToPlatformWalletResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TransferToPlatformWalletResponse create() => TransferToPlatformWalletResponse._();
  TransferToPlatformWalletResponse createEmptyInstance() => create();
  static $pb.PbList<TransferToPlatformWalletResponse> createRepeated() => $pb.PbList<TransferToPlatformWalletResponse>();
  @$core.pragma('dart2js:noInline')
  static TransferToPlatformWalletResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TransferToPlatformWalletResponse>(create);
  static TransferToPlatformWalletResponse? _defaultInstance;

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
  $core.String get debitTransactionId => $_getSZ(3);
  @$pb.TagNumber(4)
  set debitTransactionId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasDebitTransactionId() => $_has(3);
  @$pb.TagNumber(4)
  void clearDebitTransactionId() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get platformTransactionId => $_getSZ(4);
  @$pb.TagNumber(5)
  set platformTransactionId($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasPlatformTransactionId() => $_has(4);
  @$pb.TagNumber(5)
  void clearPlatformTransactionId() => clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get userNewBalance => $_getI64(5);
  @$pb.TagNumber(6)
  set userNewBalance($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasUserNewBalance() => $_has(5);
  @$pb.TagNumber(6)
  void clearUserNewBalance() => clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get walletNewBalance => $_getI64(6);
  @$pb.TagNumber(7)
  set walletNewBalance($fixnum.Int64 v) { $_setInt64(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasWalletNewBalance() => $_has(6);
  @$pb.TagNumber(7)
  void clearWalletNewBalance() => clearField(7);
}

/// TransferFromPlatformWallet - Debit platform wallet, credit user account (refunds)
class TransferFromPlatformWalletRequest extends $pb.GeneratedMessage {
  factory TransferFromPlatformWalletRequest({
    $core.String? walletCode,
    $core.String? userAccountId,
    $core.String? userId,
    $fixnum.Int64? amount,
    $core.String? currency,
    $core.String? reference,
    $core.String? category,
    $core.String? description,
    $core.String? metadata,
    $core.String? serviceName,
    $core.String? idempotencyKey,
  }) {
    final $result = create();
    if (walletCode != null) {
      $result.walletCode = walletCode;
    }
    if (userAccountId != null) {
      $result.userAccountId = userAccountId;
    }
    if (userId != null) {
      $result.userId = userId;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (reference != null) {
      $result.reference = reference;
    }
    if (category != null) {
      $result.category = category;
    }
    if (description != null) {
      $result.description = description;
    }
    if (metadata != null) {
      $result.metadata = metadata;
    }
    if (serviceName != null) {
      $result.serviceName = serviceName;
    }
    if (idempotencyKey != null) {
      $result.idempotencyKey = idempotencyKey;
    }
    return $result;
  }
  TransferFromPlatformWalletRequest._() : super();
  factory TransferFromPlatformWalletRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TransferFromPlatformWalletRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TransferFromPlatformWalletRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'walletCode')
    ..aOS(2, _omitFieldNames ? '' : 'userAccountId')
    ..aOS(3, _omitFieldNames ? '' : 'userId')
    ..aInt64(4, _omitFieldNames ? '' : 'amount')
    ..aOS(5, _omitFieldNames ? '' : 'currency')
    ..aOS(6, _omitFieldNames ? '' : 'reference')
    ..aOS(7, _omitFieldNames ? '' : 'category')
    ..aOS(8, _omitFieldNames ? '' : 'description')
    ..aOS(9, _omitFieldNames ? '' : 'metadata')
    ..aOS(10, _omitFieldNames ? '' : 'serviceName')
    ..aOS(11, _omitFieldNames ? '' : 'idempotencyKey')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TransferFromPlatformWalletRequest clone() => TransferFromPlatformWalletRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TransferFromPlatformWalletRequest copyWith(void Function(TransferFromPlatformWalletRequest) updates) => super.copyWith((message) => updates(message as TransferFromPlatformWalletRequest)) as TransferFromPlatformWalletRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TransferFromPlatformWalletRequest create() => TransferFromPlatformWalletRequest._();
  TransferFromPlatformWalletRequest createEmptyInstance() => create();
  static $pb.PbList<TransferFromPlatformWalletRequest> createRepeated() => $pb.PbList<TransferFromPlatformWalletRequest>();
  @$core.pragma('dart2js:noInline')
  static TransferFromPlatformWalletRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TransferFromPlatformWalletRequest>(create);
  static TransferFromPlatformWalletRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get walletCode => $_getSZ(0);
  @$pb.TagNumber(1)
  set walletCode($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasWalletCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearWalletCode() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get userAccountId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userAccountId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUserAccountId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserAccountId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get userId => $_getSZ(2);
  @$pb.TagNumber(3)
  set userId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasUserId() => $_has(2);
  @$pb.TagNumber(3)
  void clearUserId() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get amount => $_getI64(3);
  @$pb.TagNumber(4)
  set amount($fixnum.Int64 v) { $_setInt64(3, v); }
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
  $core.String get reference => $_getSZ(5);
  @$pb.TagNumber(6)
  set reference($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasReference() => $_has(5);
  @$pb.TagNumber(6)
  void clearReference() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get category => $_getSZ(6);
  @$pb.TagNumber(7)
  set category($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasCategory() => $_has(6);
  @$pb.TagNumber(7)
  void clearCategory() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get description => $_getSZ(7);
  @$pb.TagNumber(8)
  set description($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasDescription() => $_has(7);
  @$pb.TagNumber(8)
  void clearDescription() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get metadata => $_getSZ(8);
  @$pb.TagNumber(9)
  set metadata($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasMetadata() => $_has(8);
  @$pb.TagNumber(9)
  void clearMetadata() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get serviceName => $_getSZ(9);
  @$pb.TagNumber(10)
  set serviceName($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasServiceName() => $_has(9);
  @$pb.TagNumber(10)
  void clearServiceName() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get idempotencyKey => $_getSZ(10);
  @$pb.TagNumber(11)
  set idempotencyKey($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasIdempotencyKey() => $_has(10);
  @$pb.TagNumber(11)
  void clearIdempotencyKey() => clearField(11);
}

class TransferFromPlatformWalletResponse extends $pb.GeneratedMessage {
  factory TransferFromPlatformWalletResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
    $core.String? creditTransactionId,
    $core.String? platformTransactionId,
    $fixnum.Int64? userNewBalance,
    $fixnum.Int64? walletNewBalance,
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
    if (creditTransactionId != null) {
      $result.creditTransactionId = creditTransactionId;
    }
    if (platformTransactionId != null) {
      $result.platformTransactionId = platformTransactionId;
    }
    if (userNewBalance != null) {
      $result.userNewBalance = userNewBalance;
    }
    if (walletNewBalance != null) {
      $result.walletNewBalance = walletNewBalance;
    }
    return $result;
  }
  TransferFromPlatformWalletResponse._() : super();
  factory TransferFromPlatformWalletResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TransferFromPlatformWalletResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TransferFromPlatformWalletResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'errorCode')
    ..aOS(3, _omitFieldNames ? '' : 'errorMessage')
    ..aOS(4, _omitFieldNames ? '' : 'creditTransactionId')
    ..aOS(5, _omitFieldNames ? '' : 'platformTransactionId')
    ..aInt64(6, _omitFieldNames ? '' : 'userNewBalance')
    ..aInt64(7, _omitFieldNames ? '' : 'walletNewBalance')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TransferFromPlatformWalletResponse clone() => TransferFromPlatformWalletResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TransferFromPlatformWalletResponse copyWith(void Function(TransferFromPlatformWalletResponse) updates) => super.copyWith((message) => updates(message as TransferFromPlatformWalletResponse)) as TransferFromPlatformWalletResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TransferFromPlatformWalletResponse create() => TransferFromPlatformWalletResponse._();
  TransferFromPlatformWalletResponse createEmptyInstance() => create();
  static $pb.PbList<TransferFromPlatformWalletResponse> createRepeated() => $pb.PbList<TransferFromPlatformWalletResponse>();
  @$core.pragma('dart2js:noInline')
  static TransferFromPlatformWalletResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TransferFromPlatformWalletResponse>(create);
  static TransferFromPlatformWalletResponse? _defaultInstance;

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
  $core.String get creditTransactionId => $_getSZ(3);
  @$pb.TagNumber(4)
  set creditTransactionId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCreditTransactionId() => $_has(3);
  @$pb.TagNumber(4)
  void clearCreditTransactionId() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get platformTransactionId => $_getSZ(4);
  @$pb.TagNumber(5)
  set platformTransactionId($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasPlatformTransactionId() => $_has(4);
  @$pb.TagNumber(5)
  void clearPlatformTransactionId() => clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get userNewBalance => $_getI64(5);
  @$pb.TagNumber(6)
  set userNewBalance($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasUserNewBalance() => $_has(5);
  @$pb.TagNumber(6)
  void clearUserNewBalance() => clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get walletNewBalance => $_getI64(6);
  @$pb.TagNumber(7)
  set walletNewBalance($fixnum.Int64 v) { $_setInt64(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasWalletNewBalance() => $_has(6);
  @$pb.TagNumber(7)
  void clearWalletNewBalance() => clearField(7);
}

/// CreditPlatformWallet - Credit-only (internal fee settlement after fund hold capture)
class CreditPlatformWalletRequest extends $pb.GeneratedMessage {
  factory CreditPlatformWalletRequest({
    $core.String? walletCode,
    $fixnum.Int64? amount,
    $core.String? currency,
    $core.String? reference,
    $core.String? category,
    $core.String? description,
    $core.String? metadata,
    $core.String? serviceName,
    $core.String? idempotencyKey,
    $core.String? sourceAccountId,
    $core.String? sourceUserId,
    $core.String? sourcePaymentId,
  }) {
    final $result = create();
    if (walletCode != null) {
      $result.walletCode = walletCode;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (reference != null) {
      $result.reference = reference;
    }
    if (category != null) {
      $result.category = category;
    }
    if (description != null) {
      $result.description = description;
    }
    if (metadata != null) {
      $result.metadata = metadata;
    }
    if (serviceName != null) {
      $result.serviceName = serviceName;
    }
    if (idempotencyKey != null) {
      $result.idempotencyKey = idempotencyKey;
    }
    if (sourceAccountId != null) {
      $result.sourceAccountId = sourceAccountId;
    }
    if (sourceUserId != null) {
      $result.sourceUserId = sourceUserId;
    }
    if (sourcePaymentId != null) {
      $result.sourcePaymentId = sourcePaymentId;
    }
    return $result;
  }
  CreditPlatformWalletRequest._() : super();
  factory CreditPlatformWalletRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreditPlatformWalletRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreditPlatformWalletRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'walletCode')
    ..aInt64(2, _omitFieldNames ? '' : 'amount')
    ..aOS(3, _omitFieldNames ? '' : 'currency')
    ..aOS(4, _omitFieldNames ? '' : 'reference')
    ..aOS(5, _omitFieldNames ? '' : 'category')
    ..aOS(6, _omitFieldNames ? '' : 'description')
    ..aOS(7, _omitFieldNames ? '' : 'metadata')
    ..aOS(8, _omitFieldNames ? '' : 'serviceName')
    ..aOS(9, _omitFieldNames ? '' : 'idempotencyKey')
    ..aOS(10, _omitFieldNames ? '' : 'sourceAccountId')
    ..aOS(11, _omitFieldNames ? '' : 'sourceUserId')
    ..aOS(12, _omitFieldNames ? '' : 'sourcePaymentId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreditPlatformWalletRequest clone() => CreditPlatformWalletRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreditPlatformWalletRequest copyWith(void Function(CreditPlatformWalletRequest) updates) => super.copyWith((message) => updates(message as CreditPlatformWalletRequest)) as CreditPlatformWalletRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreditPlatformWalletRequest create() => CreditPlatformWalletRequest._();
  CreditPlatformWalletRequest createEmptyInstance() => create();
  static $pb.PbList<CreditPlatformWalletRequest> createRepeated() => $pb.PbList<CreditPlatformWalletRequest>();
  @$core.pragma('dart2js:noInline')
  static CreditPlatformWalletRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreditPlatformWalletRequest>(create);
  static CreditPlatformWalletRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get walletCode => $_getSZ(0);
  @$pb.TagNumber(1)
  set walletCode($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasWalletCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearWalletCode() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get amount => $_getI64(1);
  @$pb.TagNumber(2)
  set amount($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get currency => $_getSZ(2);
  @$pb.TagNumber(3)
  set currency($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCurrency() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrency() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get reference => $_getSZ(3);
  @$pb.TagNumber(4)
  set reference($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasReference() => $_has(3);
  @$pb.TagNumber(4)
  void clearReference() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get category => $_getSZ(4);
  @$pb.TagNumber(5)
  set category($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasCategory() => $_has(4);
  @$pb.TagNumber(5)
  void clearCategory() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get description => $_getSZ(5);
  @$pb.TagNumber(6)
  set description($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasDescription() => $_has(5);
  @$pb.TagNumber(6)
  void clearDescription() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get metadata => $_getSZ(6);
  @$pb.TagNumber(7)
  set metadata($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasMetadata() => $_has(6);
  @$pb.TagNumber(7)
  void clearMetadata() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get serviceName => $_getSZ(7);
  @$pb.TagNumber(8)
  set serviceName($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasServiceName() => $_has(7);
  @$pb.TagNumber(8)
  void clearServiceName() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get idempotencyKey => $_getSZ(8);
  @$pb.TagNumber(9)
  set idempotencyKey($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasIdempotencyKey() => $_has(8);
  @$pb.TagNumber(9)
  void clearIdempotencyKey() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get sourceAccountId => $_getSZ(9);
  @$pb.TagNumber(10)
  set sourceAccountId($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasSourceAccountId() => $_has(9);
  @$pb.TagNumber(10)
  void clearSourceAccountId() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get sourceUserId => $_getSZ(10);
  @$pb.TagNumber(11)
  set sourceUserId($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasSourceUserId() => $_has(10);
  @$pb.TagNumber(11)
  void clearSourceUserId() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get sourcePaymentId => $_getSZ(11);
  @$pb.TagNumber(12)
  set sourcePaymentId($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasSourcePaymentId() => $_has(11);
  @$pb.TagNumber(12)
  void clearSourcePaymentId() => clearField(12);
}

class CreditPlatformWalletResponse extends $pb.GeneratedMessage {
  factory CreditPlatformWalletResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
    $core.String? platformTransactionId,
    $fixnum.Int64? walletNewBalance,
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
    if (platformTransactionId != null) {
      $result.platformTransactionId = platformTransactionId;
    }
    if (walletNewBalance != null) {
      $result.walletNewBalance = walletNewBalance;
    }
    return $result;
  }
  CreditPlatformWalletResponse._() : super();
  factory CreditPlatformWalletResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreditPlatformWalletResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreditPlatformWalletResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'errorCode')
    ..aOS(3, _omitFieldNames ? '' : 'errorMessage')
    ..aOS(4, _omitFieldNames ? '' : 'platformTransactionId')
    ..aInt64(5, _omitFieldNames ? '' : 'walletNewBalance')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreditPlatformWalletResponse clone() => CreditPlatformWalletResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreditPlatformWalletResponse copyWith(void Function(CreditPlatformWalletResponse) updates) => super.copyWith((message) => updates(message as CreditPlatformWalletResponse)) as CreditPlatformWalletResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreditPlatformWalletResponse create() => CreditPlatformWalletResponse._();
  CreditPlatformWalletResponse createEmptyInstance() => create();
  static $pb.PbList<CreditPlatformWalletResponse> createRepeated() => $pb.PbList<CreditPlatformWalletResponse>();
  @$core.pragma('dart2js:noInline')
  static CreditPlatformWalletResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreditPlatformWalletResponse>(create);
  static CreditPlatformWalletResponse? _defaultInstance;

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
  $core.String get platformTransactionId => $_getSZ(3);
  @$pb.TagNumber(4)
  set platformTransactionId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPlatformTransactionId() => $_has(3);
  @$pb.TagNumber(4)
  void clearPlatformTransactionId() => clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get walletNewBalance => $_getI64(4);
  @$pb.TagNumber(5)
  set walletNewBalance($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasWalletNewBalance() => $_has(4);
  @$pb.TagNumber(5)
  void clearWalletNewBalance() => clearField(5);
}

/// DebitPlatformWallet - Debit-only (internal settlement for hold captures/releases)
class DebitPlatformWalletRequest extends $pb.GeneratedMessage {
  factory DebitPlatformWalletRequest({
    $core.String? walletCode,
    $fixnum.Int64? amount,
    $core.String? currency,
    $core.String? reference,
    $core.String? category,
    $core.String? description,
    $core.String? metadata,
    $core.String? serviceName,
    $core.String? idempotencyKey,
    $core.String? sourceAccountId,
    $core.String? sourceUserId,
    $core.String? sourcePaymentId,
  }) {
    final $result = create();
    if (walletCode != null) {
      $result.walletCode = walletCode;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (reference != null) {
      $result.reference = reference;
    }
    if (category != null) {
      $result.category = category;
    }
    if (description != null) {
      $result.description = description;
    }
    if (metadata != null) {
      $result.metadata = metadata;
    }
    if (serviceName != null) {
      $result.serviceName = serviceName;
    }
    if (idempotencyKey != null) {
      $result.idempotencyKey = idempotencyKey;
    }
    if (sourceAccountId != null) {
      $result.sourceAccountId = sourceAccountId;
    }
    if (sourceUserId != null) {
      $result.sourceUserId = sourceUserId;
    }
    if (sourcePaymentId != null) {
      $result.sourcePaymentId = sourcePaymentId;
    }
    return $result;
  }
  DebitPlatformWalletRequest._() : super();
  factory DebitPlatformWalletRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DebitPlatformWalletRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DebitPlatformWalletRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'walletCode')
    ..aInt64(2, _omitFieldNames ? '' : 'amount')
    ..aOS(3, _omitFieldNames ? '' : 'currency')
    ..aOS(4, _omitFieldNames ? '' : 'reference')
    ..aOS(5, _omitFieldNames ? '' : 'category')
    ..aOS(6, _omitFieldNames ? '' : 'description')
    ..aOS(7, _omitFieldNames ? '' : 'metadata')
    ..aOS(8, _omitFieldNames ? '' : 'serviceName')
    ..aOS(9, _omitFieldNames ? '' : 'idempotencyKey')
    ..aOS(10, _omitFieldNames ? '' : 'sourceAccountId')
    ..aOS(11, _omitFieldNames ? '' : 'sourceUserId')
    ..aOS(12, _omitFieldNames ? '' : 'sourcePaymentId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DebitPlatformWalletRequest clone() => DebitPlatformWalletRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DebitPlatformWalletRequest copyWith(void Function(DebitPlatformWalletRequest) updates) => super.copyWith((message) => updates(message as DebitPlatformWalletRequest)) as DebitPlatformWalletRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DebitPlatformWalletRequest create() => DebitPlatformWalletRequest._();
  DebitPlatformWalletRequest createEmptyInstance() => create();
  static $pb.PbList<DebitPlatformWalletRequest> createRepeated() => $pb.PbList<DebitPlatformWalletRequest>();
  @$core.pragma('dart2js:noInline')
  static DebitPlatformWalletRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DebitPlatformWalletRequest>(create);
  static DebitPlatformWalletRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get walletCode => $_getSZ(0);
  @$pb.TagNumber(1)
  set walletCode($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasWalletCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearWalletCode() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get amount => $_getI64(1);
  @$pb.TagNumber(2)
  set amount($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get currency => $_getSZ(2);
  @$pb.TagNumber(3)
  set currency($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCurrency() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrency() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get reference => $_getSZ(3);
  @$pb.TagNumber(4)
  set reference($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasReference() => $_has(3);
  @$pb.TagNumber(4)
  void clearReference() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get category => $_getSZ(4);
  @$pb.TagNumber(5)
  set category($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasCategory() => $_has(4);
  @$pb.TagNumber(5)
  void clearCategory() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get description => $_getSZ(5);
  @$pb.TagNumber(6)
  set description($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasDescription() => $_has(5);
  @$pb.TagNumber(6)
  void clearDescription() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get metadata => $_getSZ(6);
  @$pb.TagNumber(7)
  set metadata($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasMetadata() => $_has(6);
  @$pb.TagNumber(7)
  void clearMetadata() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get serviceName => $_getSZ(7);
  @$pb.TagNumber(8)
  set serviceName($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasServiceName() => $_has(7);
  @$pb.TagNumber(8)
  void clearServiceName() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get idempotencyKey => $_getSZ(8);
  @$pb.TagNumber(9)
  set idempotencyKey($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasIdempotencyKey() => $_has(8);
  @$pb.TagNumber(9)
  void clearIdempotencyKey() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get sourceAccountId => $_getSZ(9);
  @$pb.TagNumber(10)
  set sourceAccountId($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasSourceAccountId() => $_has(9);
  @$pb.TagNumber(10)
  void clearSourceAccountId() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get sourceUserId => $_getSZ(10);
  @$pb.TagNumber(11)
  set sourceUserId($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasSourceUserId() => $_has(10);
  @$pb.TagNumber(11)
  void clearSourceUserId() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get sourcePaymentId => $_getSZ(11);
  @$pb.TagNumber(12)
  set sourcePaymentId($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasSourcePaymentId() => $_has(11);
  @$pb.TagNumber(12)
  void clearSourcePaymentId() => clearField(12);
}

class DebitPlatformWalletResponse extends $pb.GeneratedMessage {
  factory DebitPlatformWalletResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
    $core.String? platformTransactionId,
    $fixnum.Int64? walletNewBalance,
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
    if (platformTransactionId != null) {
      $result.platformTransactionId = platformTransactionId;
    }
    if (walletNewBalance != null) {
      $result.walletNewBalance = walletNewBalance;
    }
    return $result;
  }
  DebitPlatformWalletResponse._() : super();
  factory DebitPlatformWalletResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DebitPlatformWalletResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DebitPlatformWalletResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'errorCode')
    ..aOS(3, _omitFieldNames ? '' : 'errorMessage')
    ..aOS(4, _omitFieldNames ? '' : 'platformTransactionId')
    ..aInt64(5, _omitFieldNames ? '' : 'walletNewBalance')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DebitPlatformWalletResponse clone() => DebitPlatformWalletResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DebitPlatformWalletResponse copyWith(void Function(DebitPlatformWalletResponse) updates) => super.copyWith((message) => updates(message as DebitPlatformWalletResponse)) as DebitPlatformWalletResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DebitPlatformWalletResponse create() => DebitPlatformWalletResponse._();
  DebitPlatformWalletResponse createEmptyInstance() => create();
  static $pb.PbList<DebitPlatformWalletResponse> createRepeated() => $pb.PbList<DebitPlatformWalletResponse>();
  @$core.pragma('dart2js:noInline')
  static DebitPlatformWalletResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DebitPlatformWalletResponse>(create);
  static DebitPlatformWalletResponse? _defaultInstance;

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
  $core.String get platformTransactionId => $_getSZ(3);
  @$pb.TagNumber(4)
  set platformTransactionId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPlatformTransactionId() => $_has(3);
  @$pb.TagNumber(4)
  void clearPlatformTransactionId() => clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get walletNewBalance => $_getI64(4);
  @$pb.TagNumber(5)
  set walletNewBalance($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasWalletNewBalance() => $_has(4);
  @$pb.TagNumber(5)
  void clearWalletNewBalance() => clearField(5);
}

/// GetPlatformWallet - Get wallet by ID or code
class GetPlatformWalletRequest extends $pb.GeneratedMessage {
  factory GetPlatformWalletRequest({
    $core.String? walletId,
    $core.String? walletCode,
  }) {
    final $result = create();
    if (walletId != null) {
      $result.walletId = walletId;
    }
    if (walletCode != null) {
      $result.walletCode = walletCode;
    }
    return $result;
  }
  GetPlatformWalletRequest._() : super();
  factory GetPlatformWalletRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPlatformWalletRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetPlatformWalletRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'walletId')
    ..aOS(2, _omitFieldNames ? '' : 'walletCode')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPlatformWalletRequest clone() => GetPlatformWalletRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPlatformWalletRequest copyWith(void Function(GetPlatformWalletRequest) updates) => super.copyWith((message) => updates(message as GetPlatformWalletRequest)) as GetPlatformWalletRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPlatformWalletRequest create() => GetPlatformWalletRequest._();
  GetPlatformWalletRequest createEmptyInstance() => create();
  static $pb.PbList<GetPlatformWalletRequest> createRepeated() => $pb.PbList<GetPlatformWalletRequest>();
  @$core.pragma('dart2js:noInline')
  static GetPlatformWalletRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetPlatformWalletRequest>(create);
  static GetPlatformWalletRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get walletId => $_getSZ(0);
  @$pb.TagNumber(1)
  set walletId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasWalletId() => $_has(0);
  @$pb.TagNumber(1)
  void clearWalletId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get walletCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set walletCode($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasWalletCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearWalletCode() => clearField(2);
}

class GetPlatformWalletResponse extends $pb.GeneratedMessage {
  factory GetPlatformWalletResponse({
    PlatformWalletMsg? wallet,
  }) {
    final $result = create();
    if (wallet != null) {
      $result.wallet = wallet;
    }
    return $result;
  }
  GetPlatformWalletResponse._() : super();
  factory GetPlatformWalletResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPlatformWalletResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetPlatformWalletResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOM<PlatformWalletMsg>(1, _omitFieldNames ? '' : 'wallet', subBuilder: PlatformWalletMsg.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPlatformWalletResponse clone() => GetPlatformWalletResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPlatformWalletResponse copyWith(void Function(GetPlatformWalletResponse) updates) => super.copyWith((message) => updates(message as GetPlatformWalletResponse)) as GetPlatformWalletResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPlatformWalletResponse create() => GetPlatformWalletResponse._();
  GetPlatformWalletResponse createEmptyInstance() => create();
  static $pb.PbList<GetPlatformWalletResponse> createRepeated() => $pb.PbList<GetPlatformWalletResponse>();
  @$core.pragma('dart2js:noInline')
  static GetPlatformWalletResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetPlatformWalletResponse>(create);
  static GetPlatformWalletResponse? _defaultInstance;

  @$pb.TagNumber(1)
  PlatformWalletMsg get wallet => $_getN(0);
  @$pb.TagNumber(1)
  set wallet(PlatformWalletMsg v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasWallet() => $_has(0);
  @$pb.TagNumber(1)
  void clearWallet() => clearField(1);
  @$pb.TagNumber(1)
  PlatformWalletMsg ensureWallet() => $_ensure(0);
}

/// GetPlatformWalletTransactions - Paginated transaction history
class GetPlatformWalletTransactionsRequest extends $pb.GeneratedMessage {
  factory GetPlatformWalletTransactionsRequest({
    $core.String? walletId,
    $core.String? walletCode,
    $core.String? type,
    $core.String? category,
    $core.String? startDate,
    $core.String? endDate,
    $core.int? limit,
    $core.int? offset,
  }) {
    final $result = create();
    if (walletId != null) {
      $result.walletId = walletId;
    }
    if (walletCode != null) {
      $result.walletCode = walletCode;
    }
    if (type != null) {
      $result.type = type;
    }
    if (category != null) {
      $result.category = category;
    }
    if (startDate != null) {
      $result.startDate = startDate;
    }
    if (endDate != null) {
      $result.endDate = endDate;
    }
    if (limit != null) {
      $result.limit = limit;
    }
    if (offset != null) {
      $result.offset = offset;
    }
    return $result;
  }
  GetPlatformWalletTransactionsRequest._() : super();
  factory GetPlatformWalletTransactionsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPlatformWalletTransactionsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetPlatformWalletTransactionsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'walletId')
    ..aOS(2, _omitFieldNames ? '' : 'walletCode')
    ..aOS(3, _omitFieldNames ? '' : 'type')
    ..aOS(4, _omitFieldNames ? '' : 'category')
    ..aOS(5, _omitFieldNames ? '' : 'startDate')
    ..aOS(6, _omitFieldNames ? '' : 'endDate')
    ..a<$core.int>(7, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(8, _omitFieldNames ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPlatformWalletTransactionsRequest clone() => GetPlatformWalletTransactionsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPlatformWalletTransactionsRequest copyWith(void Function(GetPlatformWalletTransactionsRequest) updates) => super.copyWith((message) => updates(message as GetPlatformWalletTransactionsRequest)) as GetPlatformWalletTransactionsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPlatformWalletTransactionsRequest create() => GetPlatformWalletTransactionsRequest._();
  GetPlatformWalletTransactionsRequest createEmptyInstance() => create();
  static $pb.PbList<GetPlatformWalletTransactionsRequest> createRepeated() => $pb.PbList<GetPlatformWalletTransactionsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetPlatformWalletTransactionsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetPlatformWalletTransactionsRequest>(create);
  static GetPlatformWalletTransactionsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get walletId => $_getSZ(0);
  @$pb.TagNumber(1)
  set walletId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasWalletId() => $_has(0);
  @$pb.TagNumber(1)
  void clearWalletId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get walletCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set walletCode($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasWalletCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearWalletCode() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get type => $_getSZ(2);
  @$pb.TagNumber(3)
  set type($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasType() => $_has(2);
  @$pb.TagNumber(3)
  void clearType() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get category => $_getSZ(3);
  @$pb.TagNumber(4)
  set category($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCategory() => $_has(3);
  @$pb.TagNumber(4)
  void clearCategory() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get startDate => $_getSZ(4);
  @$pb.TagNumber(5)
  set startDate($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasStartDate() => $_has(4);
  @$pb.TagNumber(5)
  void clearStartDate() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get endDate => $_getSZ(5);
  @$pb.TagNumber(6)
  set endDate($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasEndDate() => $_has(5);
  @$pb.TagNumber(6)
  void clearEndDate() => clearField(6);

  @$pb.TagNumber(7)
  $core.int get limit => $_getIZ(6);
  @$pb.TagNumber(7)
  set limit($core.int v) { $_setSignedInt32(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasLimit() => $_has(6);
  @$pb.TagNumber(7)
  void clearLimit() => clearField(7);

  @$pb.TagNumber(8)
  $core.int get offset => $_getIZ(7);
  @$pb.TagNumber(8)
  set offset($core.int v) { $_setSignedInt32(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasOffset() => $_has(7);
  @$pb.TagNumber(8)
  void clearOffset() => clearField(8);
}

class GetPlatformWalletTransactionsResponse extends $pb.GeneratedMessage {
  factory GetPlatformWalletTransactionsResponse({
    $core.Iterable<PlatformWalletTransactionMsg>? transactions,
    $core.int? total,
  }) {
    final $result = create();
    if (transactions != null) {
      $result.transactions.addAll(transactions);
    }
    if (total != null) {
      $result.total = total;
    }
    return $result;
  }
  GetPlatformWalletTransactionsResponse._() : super();
  factory GetPlatformWalletTransactionsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPlatformWalletTransactionsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetPlatformWalletTransactionsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..pc<PlatformWalletTransactionMsg>(1, _omitFieldNames ? '' : 'transactions', $pb.PbFieldType.PM, subBuilder: PlatformWalletTransactionMsg.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPlatformWalletTransactionsResponse clone() => GetPlatformWalletTransactionsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPlatformWalletTransactionsResponse copyWith(void Function(GetPlatformWalletTransactionsResponse) updates) => super.copyWith((message) => updates(message as GetPlatformWalletTransactionsResponse)) as GetPlatformWalletTransactionsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPlatformWalletTransactionsResponse create() => GetPlatformWalletTransactionsResponse._();
  GetPlatformWalletTransactionsResponse createEmptyInstance() => create();
  static $pb.PbList<GetPlatformWalletTransactionsResponse> createRepeated() => $pb.PbList<GetPlatformWalletTransactionsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetPlatformWalletTransactionsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetPlatformWalletTransactionsResponse>(create);
  static GetPlatformWalletTransactionsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<PlatformWalletTransactionMsg> get transactions => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => clearField(2);
}

/// Period totals for income and expenses
class PeriodTotals extends $pb.GeneratedMessage {
  factory PeriodTotals({
    $core.double? totalIncome,
    $core.double? totalExpenses,
    $core.double? net,
    $core.int? transactionCount,
  }) {
    final $result = create();
    if (totalIncome != null) {
      $result.totalIncome = totalIncome;
    }
    if (totalExpenses != null) {
      $result.totalExpenses = totalExpenses;
    }
    if (net != null) {
      $result.net = net;
    }
    if (transactionCount != null) {
      $result.transactionCount = transactionCount;
    }
    return $result;
  }
  PeriodTotals._() : super();
  factory PeriodTotals.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PeriodTotals.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PeriodTotals', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'totalIncome', $pb.PbFieldType.OD)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'totalExpenses', $pb.PbFieldType.OD)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'net', $pb.PbFieldType.OD)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'transactionCount', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PeriodTotals clone() => PeriodTotals()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PeriodTotals copyWith(void Function(PeriodTotals) updates) => super.copyWith((message) => updates(message as PeriodTotals)) as PeriodTotals;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PeriodTotals create() => PeriodTotals._();
  PeriodTotals createEmptyInstance() => create();
  static $pb.PbList<PeriodTotals> createRepeated() => $pb.PbList<PeriodTotals>();
  @$core.pragma('dart2js:noInline')
  static PeriodTotals getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PeriodTotals>(create);
  static PeriodTotals? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get totalIncome => $_getN(0);
  @$pb.TagNumber(1)
  set totalIncome($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTotalIncome() => $_has(0);
  @$pb.TagNumber(1)
  void clearTotalIncome() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get totalExpenses => $_getN(1);
  @$pb.TagNumber(2)
  set totalExpenses($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotalExpenses() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalExpenses() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get net => $_getN(2);
  @$pb.TagNumber(3)
  set net($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasNet() => $_has(2);
  @$pb.TagNumber(3)
  void clearNet() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get transactionCount => $_getIZ(3);
  @$pb.TagNumber(4)
  set transactionCount($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTransactionCount() => $_has(3);
  @$pb.TagNumber(4)
  void clearTransactionCount() => clearField(4);
}

/// GetFinancialAnalytics - Compare current vs previous period
class GetFinancialAnalyticsRequest extends $pb.GeneratedMessage {
  factory GetFinancialAnalyticsRequest({
    $core.String? accountId,
    $core.String? period,
    $core.String? startDate,
    $core.String? endDate,
    $core.bool? includeExternalBanks,
    $core.String? locale,
  }) {
    final $result = create();
    if (accountId != null) {
      $result.accountId = accountId;
    }
    if (period != null) {
      $result.period = period;
    }
    if (startDate != null) {
      $result.startDate = startDate;
    }
    if (endDate != null) {
      $result.endDate = endDate;
    }
    if (includeExternalBanks != null) {
      $result.includeExternalBanks = includeExternalBanks;
    }
    if (locale != null) {
      $result.locale = locale;
    }
    return $result;
  }
  GetFinancialAnalyticsRequest._() : super();
  factory GetFinancialAnalyticsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetFinancialAnalyticsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetFinancialAnalyticsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountId')
    ..aOS(2, _omitFieldNames ? '' : 'period')
    ..aOS(3, _omitFieldNames ? '' : 'startDate')
    ..aOS(4, _omitFieldNames ? '' : 'endDate')
    ..aOB(5, _omitFieldNames ? '' : 'includeExternalBanks')
    ..aOS(6, _omitFieldNames ? '' : 'locale')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetFinancialAnalyticsRequest clone() => GetFinancialAnalyticsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetFinancialAnalyticsRequest copyWith(void Function(GetFinancialAnalyticsRequest) updates) => super.copyWith((message) => updates(message as GetFinancialAnalyticsRequest)) as GetFinancialAnalyticsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetFinancialAnalyticsRequest create() => GetFinancialAnalyticsRequest._();
  GetFinancialAnalyticsRequest createEmptyInstance() => create();
  static $pb.PbList<GetFinancialAnalyticsRequest> createRepeated() => $pb.PbList<GetFinancialAnalyticsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetFinancialAnalyticsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetFinancialAnalyticsRequest>(create);
  static GetFinancialAnalyticsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get period => $_getSZ(1);
  @$pb.TagNumber(2)
  set period($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPeriod() => $_has(1);
  @$pb.TagNumber(2)
  void clearPeriod() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get startDate => $_getSZ(2);
  @$pb.TagNumber(3)
  set startDate($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasStartDate() => $_has(2);
  @$pb.TagNumber(3)
  void clearStartDate() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get endDate => $_getSZ(3);
  @$pb.TagNumber(4)
  set endDate($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasEndDate() => $_has(3);
  @$pb.TagNumber(4)
  void clearEndDate() => clearField(4);

  @$pb.TagNumber(5)
  $core.bool get includeExternalBanks => $_getBF(4);
  @$pb.TagNumber(5)
  set includeExternalBanks($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasIncludeExternalBanks() => $_has(4);
  @$pb.TagNumber(5)
  void clearIncludeExternalBanks() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get locale => $_getSZ(5);
  @$pb.TagNumber(6)
  set locale($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasLocale() => $_has(5);
  @$pb.TagNumber(6)
  void clearLocale() => clearField(6);
}

class GetFinancialAnalyticsResponse extends $pb.GeneratedMessage {
  factory GetFinancialAnalyticsResponse({
    PeriodTotals? currentPeriod,
    PeriodTotals? previousPeriod,
    $core.double? incomeChangePercent,
    $core.double? expenseChangePercent,
    $core.String? periodLabel,
  }) {
    final $result = create();
    if (currentPeriod != null) {
      $result.currentPeriod = currentPeriod;
    }
    if (previousPeriod != null) {
      $result.previousPeriod = previousPeriod;
    }
    if (incomeChangePercent != null) {
      $result.incomeChangePercent = incomeChangePercent;
    }
    if (expenseChangePercent != null) {
      $result.expenseChangePercent = expenseChangePercent;
    }
    if (periodLabel != null) {
      $result.periodLabel = periodLabel;
    }
    return $result;
  }
  GetFinancialAnalyticsResponse._() : super();
  factory GetFinancialAnalyticsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetFinancialAnalyticsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetFinancialAnalyticsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOM<PeriodTotals>(1, _omitFieldNames ? '' : 'currentPeriod', subBuilder: PeriodTotals.create)
    ..aOM<PeriodTotals>(2, _omitFieldNames ? '' : 'previousPeriod', subBuilder: PeriodTotals.create)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'incomeChangePercent', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'expenseChangePercent', $pb.PbFieldType.OD)
    ..aOS(5, _omitFieldNames ? '' : 'periodLabel')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetFinancialAnalyticsResponse clone() => GetFinancialAnalyticsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetFinancialAnalyticsResponse copyWith(void Function(GetFinancialAnalyticsResponse) updates) => super.copyWith((message) => updates(message as GetFinancialAnalyticsResponse)) as GetFinancialAnalyticsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetFinancialAnalyticsResponse create() => GetFinancialAnalyticsResponse._();
  GetFinancialAnalyticsResponse createEmptyInstance() => create();
  static $pb.PbList<GetFinancialAnalyticsResponse> createRepeated() => $pb.PbList<GetFinancialAnalyticsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetFinancialAnalyticsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetFinancialAnalyticsResponse>(create);
  static GetFinancialAnalyticsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  PeriodTotals get currentPeriod => $_getN(0);
  @$pb.TagNumber(1)
  set currentPeriod(PeriodTotals v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasCurrentPeriod() => $_has(0);
  @$pb.TagNumber(1)
  void clearCurrentPeriod() => clearField(1);
  @$pb.TagNumber(1)
  PeriodTotals ensureCurrentPeriod() => $_ensure(0);

  @$pb.TagNumber(2)
  PeriodTotals get previousPeriod => $_getN(1);
  @$pb.TagNumber(2)
  set previousPeriod(PeriodTotals v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPreviousPeriod() => $_has(1);
  @$pb.TagNumber(2)
  void clearPreviousPeriod() => clearField(2);
  @$pb.TagNumber(2)
  PeriodTotals ensurePreviousPeriod() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.double get incomeChangePercent => $_getN(2);
  @$pb.TagNumber(3)
  set incomeChangePercent($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasIncomeChangePercent() => $_has(2);
  @$pb.TagNumber(3)
  void clearIncomeChangePercent() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get expenseChangePercent => $_getN(3);
  @$pb.TagNumber(4)
  set expenseChangePercent($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasExpenseChangePercent() => $_has(3);
  @$pb.TagNumber(4)
  void clearExpenseChangePercent() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get periodLabel => $_getSZ(4);
  @$pb.TagNumber(5)
  set periodLabel($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasPeriodLabel() => $_has(4);
  @$pb.TagNumber(5)
  void clearPeriodLabel() => clearField(5);
}

/// Sub-category breakdown item (e.g., Airtime within Bills & Utilities)
class SubCategoryItem extends $pb.GeneratedMessage {
  factory SubCategoryItem({
    $core.String? name,
    $core.double? amount,
    $core.int? transactionCount,
    $core.double? percentage,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (transactionCount != null) {
      $result.transactionCount = transactionCount;
    }
    if (percentage != null) {
      $result.percentage = percentage;
    }
    return $result;
  }
  SubCategoryItem._() : super();
  factory SubCategoryItem.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SubCategoryItem.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SubCategoryItem', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'transactionCount', $pb.PbFieldType.O3)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'percentage', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SubCategoryItem clone() => SubCategoryItem()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SubCategoryItem copyWith(void Function(SubCategoryItem) updates) => super.copyWith((message) => updates(message as SubCategoryItem)) as SubCategoryItem;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SubCategoryItem create() => SubCategoryItem._();
  SubCategoryItem createEmptyInstance() => create();
  static $pb.PbList<SubCategoryItem> createRepeated() => $pb.PbList<SubCategoryItem>();
  @$core.pragma('dart2js:noInline')
  static SubCategoryItem getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SubCategoryItem>(create);
  static SubCategoryItem? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get amount => $_getN(1);
  @$pb.TagNumber(2)
  set amount($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get transactionCount => $_getIZ(2);
  @$pb.TagNumber(3)
  set transactionCount($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTransactionCount() => $_has(2);
  @$pb.TagNumber(3)
  void clearTransactionCount() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get percentage => $_getN(3);
  @$pb.TagNumber(4)
  set percentage($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPercentage() => $_has(3);
  @$pb.TagNumber(4)
  void clearPercentage() => clearField(4);
}

/// Category breakdown item
class CategoryBreakdownItem extends $pb.GeneratedMessage {
  factory CategoryBreakdownItem({
    $core.String? categoryName,
    $core.double? amount,
    $core.int? transactionCount,
    $core.double? percentage,
    $core.Iterable<SubCategoryItem>? subCategories,
  }) {
    final $result = create();
    if (categoryName != null) {
      $result.categoryName = categoryName;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (transactionCount != null) {
      $result.transactionCount = transactionCount;
    }
    if (percentage != null) {
      $result.percentage = percentage;
    }
    if (subCategories != null) {
      $result.subCategories.addAll(subCategories);
    }
    return $result;
  }
  CategoryBreakdownItem._() : super();
  factory CategoryBreakdownItem.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CategoryBreakdownItem.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CategoryBreakdownItem', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'categoryName')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'transactionCount', $pb.PbFieldType.O3)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'percentage', $pb.PbFieldType.OD)
    ..pc<SubCategoryItem>(5, _omitFieldNames ? '' : 'subCategories', $pb.PbFieldType.PM, subBuilder: SubCategoryItem.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CategoryBreakdownItem clone() => CategoryBreakdownItem()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CategoryBreakdownItem copyWith(void Function(CategoryBreakdownItem) updates) => super.copyWith((message) => updates(message as CategoryBreakdownItem)) as CategoryBreakdownItem;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CategoryBreakdownItem create() => CategoryBreakdownItem._();
  CategoryBreakdownItem createEmptyInstance() => create();
  static $pb.PbList<CategoryBreakdownItem> createRepeated() => $pb.PbList<CategoryBreakdownItem>();
  @$core.pragma('dart2js:noInline')
  static CategoryBreakdownItem getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CategoryBreakdownItem>(create);
  static CategoryBreakdownItem? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get categoryName => $_getSZ(0);
  @$pb.TagNumber(1)
  set categoryName($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCategoryName() => $_has(0);
  @$pb.TagNumber(1)
  void clearCategoryName() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get amount => $_getN(1);
  @$pb.TagNumber(2)
  set amount($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get transactionCount => $_getIZ(2);
  @$pb.TagNumber(3)
  set transactionCount($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTransactionCount() => $_has(2);
  @$pb.TagNumber(3)
  void clearTransactionCount() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get percentage => $_getN(3);
  @$pb.TagNumber(4)
  set percentage($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPercentage() => $_has(3);
  @$pb.TagNumber(4)
  void clearPercentage() => clearField(4);

  @$pb.TagNumber(5)
  $core.List<SubCategoryItem> get subCategories => $_getList(4);
}

/// GetCategoryAnalytics - Breakdown by category for income and expenses
class GetCategoryAnalyticsRequest extends $pb.GeneratedMessage {
  factory GetCategoryAnalyticsRequest({
    $core.String? accountId,
    $core.String? startDate,
    $core.String? endDate,
    $core.bool? includeExternalBanks,
    $core.String? locale,
  }) {
    final $result = create();
    if (accountId != null) {
      $result.accountId = accountId;
    }
    if (startDate != null) {
      $result.startDate = startDate;
    }
    if (endDate != null) {
      $result.endDate = endDate;
    }
    if (includeExternalBanks != null) {
      $result.includeExternalBanks = includeExternalBanks;
    }
    if (locale != null) {
      $result.locale = locale;
    }
    return $result;
  }
  GetCategoryAnalyticsRequest._() : super();
  factory GetCategoryAnalyticsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCategoryAnalyticsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetCategoryAnalyticsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountId')
    ..aOS(2, _omitFieldNames ? '' : 'startDate')
    ..aOS(3, _omitFieldNames ? '' : 'endDate')
    ..aOB(4, _omitFieldNames ? '' : 'includeExternalBanks')
    ..aOS(5, _omitFieldNames ? '' : 'locale')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCategoryAnalyticsRequest clone() => GetCategoryAnalyticsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCategoryAnalyticsRequest copyWith(void Function(GetCategoryAnalyticsRequest) updates) => super.copyWith((message) => updates(message as GetCategoryAnalyticsRequest)) as GetCategoryAnalyticsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetCategoryAnalyticsRequest create() => GetCategoryAnalyticsRequest._();
  GetCategoryAnalyticsRequest createEmptyInstance() => create();
  static $pb.PbList<GetCategoryAnalyticsRequest> createRepeated() => $pb.PbList<GetCategoryAnalyticsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetCategoryAnalyticsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetCategoryAnalyticsRequest>(create);
  static GetCategoryAnalyticsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get startDate => $_getSZ(1);
  @$pb.TagNumber(2)
  set startDate($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasStartDate() => $_has(1);
  @$pb.TagNumber(2)
  void clearStartDate() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get endDate => $_getSZ(2);
  @$pb.TagNumber(3)
  set endDate($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasEndDate() => $_has(2);
  @$pb.TagNumber(3)
  void clearEndDate() => clearField(3);

  @$pb.TagNumber(4)
  $core.bool get includeExternalBanks => $_getBF(3);
  @$pb.TagNumber(4)
  set includeExternalBanks($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasIncludeExternalBanks() => $_has(3);
  @$pb.TagNumber(4)
  void clearIncludeExternalBanks() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get locale => $_getSZ(4);
  @$pb.TagNumber(5)
  set locale($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasLocale() => $_has(4);
  @$pb.TagNumber(5)
  void clearLocale() => clearField(5);
}

class GetCategoryAnalyticsResponse extends $pb.GeneratedMessage {
  factory GetCategoryAnalyticsResponse({
    $core.Iterable<CategoryBreakdownItem>? expenseCategories,
    $core.Iterable<CategoryBreakdownItem>? incomeCategories,
    $core.double? totalExpenses,
    $core.double? totalIncome,
  }) {
    final $result = create();
    if (expenseCategories != null) {
      $result.expenseCategories.addAll(expenseCategories);
    }
    if (incomeCategories != null) {
      $result.incomeCategories.addAll(incomeCategories);
    }
    if (totalExpenses != null) {
      $result.totalExpenses = totalExpenses;
    }
    if (totalIncome != null) {
      $result.totalIncome = totalIncome;
    }
    return $result;
  }
  GetCategoryAnalyticsResponse._() : super();
  factory GetCategoryAnalyticsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCategoryAnalyticsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetCategoryAnalyticsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..pc<CategoryBreakdownItem>(1, _omitFieldNames ? '' : 'expenseCategories', $pb.PbFieldType.PM, subBuilder: CategoryBreakdownItem.create)
    ..pc<CategoryBreakdownItem>(2, _omitFieldNames ? '' : 'incomeCategories', $pb.PbFieldType.PM, subBuilder: CategoryBreakdownItem.create)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'totalExpenses', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'totalIncome', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCategoryAnalyticsResponse clone() => GetCategoryAnalyticsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCategoryAnalyticsResponse copyWith(void Function(GetCategoryAnalyticsResponse) updates) => super.copyWith((message) => updates(message as GetCategoryAnalyticsResponse)) as GetCategoryAnalyticsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetCategoryAnalyticsResponse create() => GetCategoryAnalyticsResponse._();
  GetCategoryAnalyticsResponse createEmptyInstance() => create();
  static $pb.PbList<GetCategoryAnalyticsResponse> createRepeated() => $pb.PbList<GetCategoryAnalyticsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetCategoryAnalyticsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetCategoryAnalyticsResponse>(create);
  static GetCategoryAnalyticsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<CategoryBreakdownItem> get expenseCategories => $_getList(0);

  @$pb.TagNumber(2)
  $core.List<CategoryBreakdownItem> get incomeCategories => $_getList(1);

  @$pb.TagNumber(3)
  $core.double get totalExpenses => $_getN(2);
  @$pb.TagNumber(3)
  set totalExpenses($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTotalExpenses() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalExpenses() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get totalIncome => $_getN(3);
  @$pb.TagNumber(4)
  set totalIncome($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTotalIncome() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalIncome() => clearField(4);
}

/// Monthly data point for trends
class MonthlyDataPoint extends $pb.GeneratedMessage {
  factory MonthlyDataPoint({
    $core.String? month,
    $core.String? monthLabel,
    $core.double? income,
    $core.double? expenses,
  }) {
    final $result = create();
    if (month != null) {
      $result.month = month;
    }
    if (monthLabel != null) {
      $result.monthLabel = monthLabel;
    }
    if (income != null) {
      $result.income = income;
    }
    if (expenses != null) {
      $result.expenses = expenses;
    }
    return $result;
  }
  MonthlyDataPoint._() : super();
  factory MonthlyDataPoint.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MonthlyDataPoint.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MonthlyDataPoint', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'month')
    ..aOS(2, _omitFieldNames ? '' : 'monthLabel')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'income', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'expenses', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MonthlyDataPoint clone() => MonthlyDataPoint()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MonthlyDataPoint copyWith(void Function(MonthlyDataPoint) updates) => super.copyWith((message) => updates(message as MonthlyDataPoint)) as MonthlyDataPoint;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MonthlyDataPoint create() => MonthlyDataPoint._();
  MonthlyDataPoint createEmptyInstance() => create();
  static $pb.PbList<MonthlyDataPoint> createRepeated() => $pb.PbList<MonthlyDataPoint>();
  @$core.pragma('dart2js:noInline')
  static MonthlyDataPoint getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MonthlyDataPoint>(create);
  static MonthlyDataPoint? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get month => $_getSZ(0);
  @$pb.TagNumber(1)
  set month($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMonth() => $_has(0);
  @$pb.TagNumber(1)
  void clearMonth() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get monthLabel => $_getSZ(1);
  @$pb.TagNumber(2)
  set monthLabel($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMonthLabel() => $_has(1);
  @$pb.TagNumber(2)
  void clearMonthLabel() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get income => $_getN(2);
  @$pb.TagNumber(3)
  set income($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasIncome() => $_has(2);
  @$pb.TagNumber(3)
  void clearIncome() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get expenses => $_getN(3);
  @$pb.TagNumber(4)
  set expenses($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasExpenses() => $_has(3);
  @$pb.TagNumber(4)
  void clearExpenses() => clearField(4);
}

/// GetMonthlyTrends - Monthly income/expense for last N months
class GetMonthlyTrendsRequest extends $pb.GeneratedMessage {
  factory GetMonthlyTrendsRequest({
    $core.String? accountId,
    $core.int? months,
    $core.String? locale,
  }) {
    final $result = create();
    if (accountId != null) {
      $result.accountId = accountId;
    }
    if (months != null) {
      $result.months = months;
    }
    if (locale != null) {
      $result.locale = locale;
    }
    return $result;
  }
  GetMonthlyTrendsRequest._() : super();
  factory GetMonthlyTrendsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMonthlyTrendsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetMonthlyTrendsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountId')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'months', $pb.PbFieldType.O3)
    ..aOS(3, _omitFieldNames ? '' : 'locale')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMonthlyTrendsRequest clone() => GetMonthlyTrendsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMonthlyTrendsRequest copyWith(void Function(GetMonthlyTrendsRequest) updates) => super.copyWith((message) => updates(message as GetMonthlyTrendsRequest)) as GetMonthlyTrendsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMonthlyTrendsRequest create() => GetMonthlyTrendsRequest._();
  GetMonthlyTrendsRequest createEmptyInstance() => create();
  static $pb.PbList<GetMonthlyTrendsRequest> createRepeated() => $pb.PbList<GetMonthlyTrendsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMonthlyTrendsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMonthlyTrendsRequest>(create);
  static GetMonthlyTrendsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get months => $_getIZ(1);
  @$pb.TagNumber(2)
  set months($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMonths() => $_has(1);
  @$pb.TagNumber(2)
  void clearMonths() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get locale => $_getSZ(2);
  @$pb.TagNumber(3)
  set locale($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasLocale() => $_has(2);
  @$pb.TagNumber(3)
  void clearLocale() => clearField(3);
}

class GetMonthlyTrendsResponse extends $pb.GeneratedMessage {
  factory GetMonthlyTrendsResponse({
    $core.Iterable<MonthlyDataPoint>? months,
  }) {
    final $result = create();
    if (months != null) {
      $result.months.addAll(months);
    }
    return $result;
  }
  GetMonthlyTrendsResponse._() : super();
  factory GetMonthlyTrendsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMonthlyTrendsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetMonthlyTrendsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..pc<MonthlyDataPoint>(1, _omitFieldNames ? '' : 'months', $pb.PbFieldType.PM, subBuilder: MonthlyDataPoint.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMonthlyTrendsResponse clone() => GetMonthlyTrendsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMonthlyTrendsResponse copyWith(void Function(GetMonthlyTrendsResponse) updates) => super.copyWith((message) => updates(message as GetMonthlyTrendsResponse)) as GetMonthlyTrendsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMonthlyTrendsResponse create() => GetMonthlyTrendsResponse._();
  GetMonthlyTrendsResponse createEmptyInstance() => create();
  static $pb.PbList<GetMonthlyTrendsResponse> createRepeated() => $pb.PbList<GetMonthlyTrendsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMonthlyTrendsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMonthlyTrendsResponse>(create);
  static GetMonthlyTrendsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<MonthlyDataPoint> get months => $_getList(0);
}

/// Daily expense point for time series
class DailyExpensePoint extends $pb.GeneratedMessage {
  factory DailyExpensePoint({
    $core.String? date,
    $core.double? amount,
  }) {
    final $result = create();
    if (date != null) {
      $result.date = date;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    return $result;
  }
  DailyExpensePoint._() : super();
  factory DailyExpensePoint.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DailyExpensePoint.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DailyExpensePoint', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'date')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DailyExpensePoint clone() => DailyExpensePoint()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DailyExpensePoint copyWith(void Function(DailyExpensePoint) updates) => super.copyWith((message) => updates(message as DailyExpensePoint)) as DailyExpensePoint;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DailyExpensePoint create() => DailyExpensePoint._();
  DailyExpensePoint createEmptyInstance() => create();
  static $pb.PbList<DailyExpensePoint> createRepeated() => $pb.PbList<DailyExpensePoint>();
  @$core.pragma('dart2js:noInline')
  static DailyExpensePoint getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DailyExpensePoint>(create);
  static DailyExpensePoint? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get date => $_getSZ(0);
  @$pb.TagNumber(1)
  set date($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDate() => $_has(0);
  @$pb.TagNumber(1)
  void clearDate() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get amount => $_getN(1);
  @$pb.TagNumber(2)
  set amount($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => clearField(2);
}

/// GetExpenseTimeSeries - Daily expense totals
class GetExpenseTimeSeriesRequest extends $pb.GeneratedMessage {
  factory GetExpenseTimeSeriesRequest({
    $core.String? accountId,
    $core.String? startDate,
    $core.String? endDate,
    $core.bool? includeExternalBanks,
    $core.String? locale,
  }) {
    final $result = create();
    if (accountId != null) {
      $result.accountId = accountId;
    }
    if (startDate != null) {
      $result.startDate = startDate;
    }
    if (endDate != null) {
      $result.endDate = endDate;
    }
    if (includeExternalBanks != null) {
      $result.includeExternalBanks = includeExternalBanks;
    }
    if (locale != null) {
      $result.locale = locale;
    }
    return $result;
  }
  GetExpenseTimeSeriesRequest._() : super();
  factory GetExpenseTimeSeriesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetExpenseTimeSeriesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetExpenseTimeSeriesRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountId')
    ..aOS(2, _omitFieldNames ? '' : 'startDate')
    ..aOS(3, _omitFieldNames ? '' : 'endDate')
    ..aOB(4, _omitFieldNames ? '' : 'includeExternalBanks')
    ..aOS(5, _omitFieldNames ? '' : 'locale')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetExpenseTimeSeriesRequest clone() => GetExpenseTimeSeriesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetExpenseTimeSeriesRequest copyWith(void Function(GetExpenseTimeSeriesRequest) updates) => super.copyWith((message) => updates(message as GetExpenseTimeSeriesRequest)) as GetExpenseTimeSeriesRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetExpenseTimeSeriesRequest create() => GetExpenseTimeSeriesRequest._();
  GetExpenseTimeSeriesRequest createEmptyInstance() => create();
  static $pb.PbList<GetExpenseTimeSeriesRequest> createRepeated() => $pb.PbList<GetExpenseTimeSeriesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetExpenseTimeSeriesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetExpenseTimeSeriesRequest>(create);
  static GetExpenseTimeSeriesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get startDate => $_getSZ(1);
  @$pb.TagNumber(2)
  set startDate($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasStartDate() => $_has(1);
  @$pb.TagNumber(2)
  void clearStartDate() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get endDate => $_getSZ(2);
  @$pb.TagNumber(3)
  set endDate($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasEndDate() => $_has(2);
  @$pb.TagNumber(3)
  void clearEndDate() => clearField(3);

  @$pb.TagNumber(4)
  $core.bool get includeExternalBanks => $_getBF(3);
  @$pb.TagNumber(4)
  set includeExternalBanks($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasIncludeExternalBanks() => $_has(3);
  @$pb.TagNumber(4)
  void clearIncludeExternalBanks() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get locale => $_getSZ(4);
  @$pb.TagNumber(5)
  set locale($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasLocale() => $_has(4);
  @$pb.TagNumber(5)
  void clearLocale() => clearField(5);
}

class GetExpenseTimeSeriesResponse extends $pb.GeneratedMessage {
  factory GetExpenseTimeSeriesResponse({
    $core.Iterable<DailyExpensePoint>? dataPoints,
    $core.double? totalExpenses,
    $core.double? dailyAverage,
  }) {
    final $result = create();
    if (dataPoints != null) {
      $result.dataPoints.addAll(dataPoints);
    }
    if (totalExpenses != null) {
      $result.totalExpenses = totalExpenses;
    }
    if (dailyAverage != null) {
      $result.dailyAverage = dailyAverage;
    }
    return $result;
  }
  GetExpenseTimeSeriesResponse._() : super();
  factory GetExpenseTimeSeriesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetExpenseTimeSeriesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetExpenseTimeSeriesResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..pc<DailyExpensePoint>(1, _omitFieldNames ? '' : 'dataPoints', $pb.PbFieldType.PM, subBuilder: DailyExpensePoint.create)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'totalExpenses', $pb.PbFieldType.OD)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'dailyAverage', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetExpenseTimeSeriesResponse clone() => GetExpenseTimeSeriesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetExpenseTimeSeriesResponse copyWith(void Function(GetExpenseTimeSeriesResponse) updates) => super.copyWith((message) => updates(message as GetExpenseTimeSeriesResponse)) as GetExpenseTimeSeriesResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetExpenseTimeSeriesResponse create() => GetExpenseTimeSeriesResponse._();
  GetExpenseTimeSeriesResponse createEmptyInstance() => create();
  static $pb.PbList<GetExpenseTimeSeriesResponse> createRepeated() => $pb.PbList<GetExpenseTimeSeriesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetExpenseTimeSeriesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetExpenseTimeSeriesResponse>(create);
  static GetExpenseTimeSeriesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<DailyExpensePoint> get dataPoints => $_getList(0);

  @$pb.TagNumber(2)
  $core.double get totalExpenses => $_getN(1);
  @$pb.TagNumber(2)
  set totalExpenses($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotalExpenses() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalExpenses() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get dailyAverage => $_getN(2);
  @$pb.TagNumber(3)
  set dailyAverage($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDailyAverage() => $_has(2);
  @$pb.TagNumber(3)
  void clearDailyAverage() => clearField(3);
}

/// A single category mapping entry
class UserCategoryMappingItem extends $pb.GeneratedMessage {
  factory UserCategoryMappingItem({
    $core.String? id,
    $core.String? originalCategory,
    $core.String? customCategory,
    $core.int? displayOrder,
    $core.String? parentCategory,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (originalCategory != null) {
      $result.originalCategory = originalCategory;
    }
    if (customCategory != null) {
      $result.customCategory = customCategory;
    }
    if (displayOrder != null) {
      $result.displayOrder = displayOrder;
    }
    if (parentCategory != null) {
      $result.parentCategory = parentCategory;
    }
    return $result;
  }
  UserCategoryMappingItem._() : super();
  factory UserCategoryMappingItem.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UserCategoryMappingItem.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UserCategoryMappingItem', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'originalCategory')
    ..aOS(3, _omitFieldNames ? '' : 'customCategory')
    ..a<$core.int>(4, _omitFieldNames ? '' : 'displayOrder', $pb.PbFieldType.O3)
    ..aOS(5, _omitFieldNames ? '' : 'parentCategory')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UserCategoryMappingItem clone() => UserCategoryMappingItem()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UserCategoryMappingItem copyWith(void Function(UserCategoryMappingItem) updates) => super.copyWith((message) => updates(message as UserCategoryMappingItem)) as UserCategoryMappingItem;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UserCategoryMappingItem create() => UserCategoryMappingItem._();
  UserCategoryMappingItem createEmptyInstance() => create();
  static $pb.PbList<UserCategoryMappingItem> createRepeated() => $pb.PbList<UserCategoryMappingItem>();
  @$core.pragma('dart2js:noInline')
  static UserCategoryMappingItem getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UserCategoryMappingItem>(create);
  static UserCategoryMappingItem? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get originalCategory => $_getSZ(1);
  @$pb.TagNumber(2)
  set originalCategory($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasOriginalCategory() => $_has(1);
  @$pb.TagNumber(2)
  void clearOriginalCategory() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get customCategory => $_getSZ(2);
  @$pb.TagNumber(3)
  set customCategory($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCustomCategory() => $_has(2);
  @$pb.TagNumber(3)
  void clearCustomCategory() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get displayOrder => $_getIZ(3);
  @$pb.TagNumber(4)
  set displayOrder($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasDisplayOrder() => $_has(3);
  @$pb.TagNumber(4)
  void clearDisplayOrder() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get parentCategory => $_getSZ(4);
  @$pb.TagNumber(5)
  set parentCategory($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasParentCategory() => $_has(4);
  @$pb.TagNumber(5)
  void clearParentCategory() => clearField(5);
}

/// GetUserCategoryMappings
class GetUserCategoryMappingsRequest extends $pb.GeneratedMessage {
  factory GetUserCategoryMappingsRequest() => create();
  GetUserCategoryMappingsRequest._() : super();
  factory GetUserCategoryMappingsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUserCategoryMappingsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetUserCategoryMappingsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUserCategoryMappingsRequest clone() => GetUserCategoryMappingsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUserCategoryMappingsRequest copyWith(void Function(GetUserCategoryMappingsRequest) updates) => super.copyWith((message) => updates(message as GetUserCategoryMappingsRequest)) as GetUserCategoryMappingsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserCategoryMappingsRequest create() => GetUserCategoryMappingsRequest._();
  GetUserCategoryMappingsRequest createEmptyInstance() => create();
  static $pb.PbList<GetUserCategoryMappingsRequest> createRepeated() => $pb.PbList<GetUserCategoryMappingsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetUserCategoryMappingsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetUserCategoryMappingsRequest>(create);
  static GetUserCategoryMappingsRequest? _defaultInstance;
}

class GetUserCategoryMappingsResponse extends $pb.GeneratedMessage {
  factory GetUserCategoryMappingsResponse({
    $core.Iterable<UserCategoryMappingItem>? mappings,
  }) {
    final $result = create();
    if (mappings != null) {
      $result.mappings.addAll(mappings);
    }
    return $result;
  }
  GetUserCategoryMappingsResponse._() : super();
  factory GetUserCategoryMappingsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUserCategoryMappingsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetUserCategoryMappingsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..pc<UserCategoryMappingItem>(1, _omitFieldNames ? '' : 'mappings', $pb.PbFieldType.PM, subBuilder: UserCategoryMappingItem.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUserCategoryMappingsResponse clone() => GetUserCategoryMappingsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUserCategoryMappingsResponse copyWith(void Function(GetUserCategoryMappingsResponse) updates) => super.copyWith((message) => updates(message as GetUserCategoryMappingsResponse)) as GetUserCategoryMappingsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserCategoryMappingsResponse create() => GetUserCategoryMappingsResponse._();
  GetUserCategoryMappingsResponse createEmptyInstance() => create();
  static $pb.PbList<GetUserCategoryMappingsResponse> createRepeated() => $pb.PbList<GetUserCategoryMappingsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetUserCategoryMappingsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetUserCategoryMappingsResponse>(create);
  static GetUserCategoryMappingsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<UserCategoryMappingItem> get mappings => $_getList(0);
}

/// UpdateUserCategoryMapping
class UpdateUserCategoryMappingRequest extends $pb.GeneratedMessage {
  factory UpdateUserCategoryMappingRequest({
    $core.String? originalCategory,
    $core.String? customCategory,
    $core.String? parentCategory,
  }) {
    final $result = create();
    if (originalCategory != null) {
      $result.originalCategory = originalCategory;
    }
    if (customCategory != null) {
      $result.customCategory = customCategory;
    }
    if (parentCategory != null) {
      $result.parentCategory = parentCategory;
    }
    return $result;
  }
  UpdateUserCategoryMappingRequest._() : super();
  factory UpdateUserCategoryMappingRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateUserCategoryMappingRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateUserCategoryMappingRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'originalCategory')
    ..aOS(2, _omitFieldNames ? '' : 'customCategory')
    ..aOS(3, _omitFieldNames ? '' : 'parentCategory')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateUserCategoryMappingRequest clone() => UpdateUserCategoryMappingRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateUserCategoryMappingRequest copyWith(void Function(UpdateUserCategoryMappingRequest) updates) => super.copyWith((message) => updates(message as UpdateUserCategoryMappingRequest)) as UpdateUserCategoryMappingRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateUserCategoryMappingRequest create() => UpdateUserCategoryMappingRequest._();
  UpdateUserCategoryMappingRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateUserCategoryMappingRequest> createRepeated() => $pb.PbList<UpdateUserCategoryMappingRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateUserCategoryMappingRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateUserCategoryMappingRequest>(create);
  static UpdateUserCategoryMappingRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get originalCategory => $_getSZ(0);
  @$pb.TagNumber(1)
  set originalCategory($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasOriginalCategory() => $_has(0);
  @$pb.TagNumber(1)
  void clearOriginalCategory() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get customCategory => $_getSZ(1);
  @$pb.TagNumber(2)
  set customCategory($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCustomCategory() => $_has(1);
  @$pb.TagNumber(2)
  void clearCustomCategory() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get parentCategory => $_getSZ(2);
  @$pb.TagNumber(3)
  set parentCategory($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasParentCategory() => $_has(2);
  @$pb.TagNumber(3)
  void clearParentCategory() => clearField(3);
}

class UpdateUserCategoryMappingResponse extends $pb.GeneratedMessage {
  factory UpdateUserCategoryMappingResponse({
    UserCategoryMappingItem? mapping,
  }) {
    final $result = create();
    if (mapping != null) {
      $result.mapping = mapping;
    }
    return $result;
  }
  UpdateUserCategoryMappingResponse._() : super();
  factory UpdateUserCategoryMappingResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateUserCategoryMappingResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateUserCategoryMappingResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOM<UserCategoryMappingItem>(1, _omitFieldNames ? '' : 'mapping', subBuilder: UserCategoryMappingItem.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateUserCategoryMappingResponse clone() => UpdateUserCategoryMappingResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateUserCategoryMappingResponse copyWith(void Function(UpdateUserCategoryMappingResponse) updates) => super.copyWith((message) => updates(message as UpdateUserCategoryMappingResponse)) as UpdateUserCategoryMappingResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateUserCategoryMappingResponse create() => UpdateUserCategoryMappingResponse._();
  UpdateUserCategoryMappingResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateUserCategoryMappingResponse> createRepeated() => $pb.PbList<UpdateUserCategoryMappingResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateUserCategoryMappingResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateUserCategoryMappingResponse>(create);
  static UpdateUserCategoryMappingResponse? _defaultInstance;

  @$pb.TagNumber(1)
  UserCategoryMappingItem get mapping => $_getN(0);
  @$pb.TagNumber(1)
  set mapping(UserCategoryMappingItem v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasMapping() => $_has(0);
  @$pb.TagNumber(1)
  void clearMapping() => clearField(1);
  @$pb.TagNumber(1)
  UserCategoryMappingItem ensureMapping() => $_ensure(0);
}

/// ReorderCategories - batch update display order
class CategoryOrderItem extends $pb.GeneratedMessage {
  factory CategoryOrderItem({
    $core.String? originalCategory,
    $core.int? displayOrder,
  }) {
    final $result = create();
    if (originalCategory != null) {
      $result.originalCategory = originalCategory;
    }
    if (displayOrder != null) {
      $result.displayOrder = displayOrder;
    }
    return $result;
  }
  CategoryOrderItem._() : super();
  factory CategoryOrderItem.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CategoryOrderItem.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CategoryOrderItem', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'originalCategory')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'displayOrder', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CategoryOrderItem clone() => CategoryOrderItem()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CategoryOrderItem copyWith(void Function(CategoryOrderItem) updates) => super.copyWith((message) => updates(message as CategoryOrderItem)) as CategoryOrderItem;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CategoryOrderItem create() => CategoryOrderItem._();
  CategoryOrderItem createEmptyInstance() => create();
  static $pb.PbList<CategoryOrderItem> createRepeated() => $pb.PbList<CategoryOrderItem>();
  @$core.pragma('dart2js:noInline')
  static CategoryOrderItem getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CategoryOrderItem>(create);
  static CategoryOrderItem? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get originalCategory => $_getSZ(0);
  @$pb.TagNumber(1)
  set originalCategory($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasOriginalCategory() => $_has(0);
  @$pb.TagNumber(1)
  void clearOriginalCategory() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get displayOrder => $_getIZ(1);
  @$pb.TagNumber(2)
  set displayOrder($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasDisplayOrder() => $_has(1);
  @$pb.TagNumber(2)
  void clearDisplayOrder() => clearField(2);
}

class ReorderCategoriesRequest extends $pb.GeneratedMessage {
  factory ReorderCategoriesRequest({
    $core.Iterable<CategoryOrderItem>? orderings,
  }) {
    final $result = create();
    if (orderings != null) {
      $result.orderings.addAll(orderings);
    }
    return $result;
  }
  ReorderCategoriesRequest._() : super();
  factory ReorderCategoriesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ReorderCategoriesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ReorderCategoriesRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..pc<CategoryOrderItem>(1, _omitFieldNames ? '' : 'orderings', $pb.PbFieldType.PM, subBuilder: CategoryOrderItem.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ReorderCategoriesRequest clone() => ReorderCategoriesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ReorderCategoriesRequest copyWith(void Function(ReorderCategoriesRequest) updates) => super.copyWith((message) => updates(message as ReorderCategoriesRequest)) as ReorderCategoriesRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ReorderCategoriesRequest create() => ReorderCategoriesRequest._();
  ReorderCategoriesRequest createEmptyInstance() => create();
  static $pb.PbList<ReorderCategoriesRequest> createRepeated() => $pb.PbList<ReorderCategoriesRequest>();
  @$core.pragma('dart2js:noInline')
  static ReorderCategoriesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ReorderCategoriesRequest>(create);
  static ReorderCategoriesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<CategoryOrderItem> get orderings => $_getList(0);
}

class ReorderCategoriesResponse extends $pb.GeneratedMessage {
  factory ReorderCategoriesResponse({
    $core.bool? success,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    return $result;
  }
  ReorderCategoriesResponse._() : super();
  factory ReorderCategoriesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ReorderCategoriesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ReorderCategoriesResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ReorderCategoriesResponse clone() => ReorderCategoriesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ReorderCategoriesResponse copyWith(void Function(ReorderCategoriesResponse) updates) => super.copyWith((message) => updates(message as ReorderCategoriesResponse)) as ReorderCategoriesResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ReorderCategoriesResponse create() => ReorderCategoriesResponse._();
  ReorderCategoriesResponse createEmptyInstance() => create();
  static $pb.PbList<ReorderCategoriesResponse> createRepeated() => $pb.PbList<ReorderCategoriesResponse>();
  @$core.pragma('dart2js:noInline')
  static ReorderCategoriesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ReorderCategoriesResponse>(create);
  static ReorderCategoriesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);
}

/// Update spending limits request
class UpdateSpendingLimitsRequest extends $pb.GeneratedMessage {
  factory UpdateSpendingLimitsRequest({
    $core.String? accountId,
    $core.double? dailyLimit,
    $core.double? monthlyLimit,
    $core.double? singleTransactionLimit,
  }) {
    final $result = create();
    if (accountId != null) {
      $result.accountId = accountId;
    }
    if (dailyLimit != null) {
      $result.dailyLimit = dailyLimit;
    }
    if (monthlyLimit != null) {
      $result.monthlyLimit = monthlyLimit;
    }
    if (singleTransactionLimit != null) {
      $result.singleTransactionLimit = singleTransactionLimit;
    }
    return $result;
  }
  UpdateSpendingLimitsRequest._() : super();
  factory UpdateSpendingLimitsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateSpendingLimitsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateSpendingLimitsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountId')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'dailyLimit', $pb.PbFieldType.OD)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'monthlyLimit', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'singleTransactionLimit', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateSpendingLimitsRequest clone() => UpdateSpendingLimitsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateSpendingLimitsRequest copyWith(void Function(UpdateSpendingLimitsRequest) updates) => super.copyWith((message) => updates(message as UpdateSpendingLimitsRequest)) as UpdateSpendingLimitsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateSpendingLimitsRequest create() => UpdateSpendingLimitsRequest._();
  UpdateSpendingLimitsRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateSpendingLimitsRequest> createRepeated() => $pb.PbList<UpdateSpendingLimitsRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateSpendingLimitsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateSpendingLimitsRequest>(create);
  static UpdateSpendingLimitsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get dailyLimit => $_getN(1);
  @$pb.TagNumber(2)
  set dailyLimit($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasDailyLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearDailyLimit() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get monthlyLimit => $_getN(2);
  @$pb.TagNumber(3)
  set monthlyLimit($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMonthlyLimit() => $_has(2);
  @$pb.TagNumber(3)
  void clearMonthlyLimit() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get singleTransactionLimit => $_getN(3);
  @$pb.TagNumber(4)
  set singleTransactionLimit($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasSingleTransactionLimit() => $_has(3);
  @$pb.TagNumber(4)
  void clearSingleTransactionLimit() => clearField(4);
}

class UpdateSpendingLimitsResponse extends $pb.GeneratedMessage {
  factory UpdateSpendingLimitsResponse({
    Account? account,
  }) {
    final $result = create();
    if (account != null) {
      $result.account = account;
    }
    return $result;
  }
  UpdateSpendingLimitsResponse._() : super();
  factory UpdateSpendingLimitsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateSpendingLimitsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateSpendingLimitsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOM<Account>(1, _omitFieldNames ? '' : 'account', subBuilder: Account.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateSpendingLimitsResponse clone() => UpdateSpendingLimitsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateSpendingLimitsResponse copyWith(void Function(UpdateSpendingLimitsResponse) updates) => super.copyWith((message) => updates(message as UpdateSpendingLimitsResponse)) as UpdateSpendingLimitsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateSpendingLimitsResponse create() => UpdateSpendingLimitsResponse._();
  UpdateSpendingLimitsResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateSpendingLimitsResponse> createRepeated() => $pb.PbList<UpdateSpendingLimitsResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateSpendingLimitsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateSpendingLimitsResponse>(create);
  static UpdateSpendingLimitsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Account get account => $_getN(0);
  @$pb.TagNumber(1)
  set account(Account v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccount() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccount() => clearField(1);
  @$pb.TagNumber(1)
  Account ensureAccount() => $_ensure(0);
}

/// Reveal PIN request
class RevealPINRequest extends $pb.GeneratedMessage {
  factory RevealPINRequest({
    $core.String? accountId,
    $core.String? transactionPin,
  }) {
    final $result = create();
    if (accountId != null) {
      $result.accountId = accountId;
    }
    if (transactionPin != null) {
      $result.transactionPin = transactionPin;
    }
    return $result;
  }
  RevealPINRequest._() : super();
  factory RevealPINRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RevealPINRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RevealPINRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountId')
    ..aOS(2, _omitFieldNames ? '' : 'transactionPin')
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
  $core.String get accountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get transactionPin => $_getSZ(1);
  @$pb.TagNumber(2)
  set transactionPin($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTransactionPin() => $_has(1);
  @$pb.TagNumber(2)
  void clearTransactionPin() => clearField(2);
}

class RevealPINResponse extends $pb.GeneratedMessage {
  factory RevealPINResponse({
    $core.String? pin,
    $core.String? message,
  }) {
    final $result = create();
    if (pin != null) {
      $result.pin = pin;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  RevealPINResponse._() : super();
  factory RevealPINResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RevealPINResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RevealPINResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'pin')
    ..aOS(2, _omitFieldNames ? '' : 'message')
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

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

/// Reveal card details request
class RevealCardDetailsRequest extends $pb.GeneratedMessage {
  factory RevealCardDetailsRequest({
    $core.String? accountId,
    $core.String? transactionPin,
  }) {
    final $result = create();
    if (accountId != null) {
      $result.accountId = accountId;
    }
    if (transactionPin != null) {
      $result.transactionPin = transactionPin;
    }
    return $result;
  }
  RevealCardDetailsRequest._() : super();
  factory RevealCardDetailsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RevealCardDetailsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RevealCardDetailsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountId')
    ..aOS(2, _omitFieldNames ? '' : 'transactionPin')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RevealCardDetailsRequest clone() => RevealCardDetailsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RevealCardDetailsRequest copyWith(void Function(RevealCardDetailsRequest) updates) => super.copyWith((message) => updates(message as RevealCardDetailsRequest)) as RevealCardDetailsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RevealCardDetailsRequest create() => RevealCardDetailsRequest._();
  RevealCardDetailsRequest createEmptyInstance() => create();
  static $pb.PbList<RevealCardDetailsRequest> createRepeated() => $pb.PbList<RevealCardDetailsRequest>();
  @$core.pragma('dart2js:noInline')
  static RevealCardDetailsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RevealCardDetailsRequest>(create);
  static RevealCardDetailsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get transactionPin => $_getSZ(1);
  @$pb.TagNumber(2)
  set transactionPin($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTransactionPin() => $_has(1);
  @$pb.TagNumber(2)
  void clearTransactionPin() => clearField(2);
}

class RevealCardDetailsResponse extends $pb.GeneratedMessage {
  factory RevealCardDetailsResponse({
    $core.String? cardNumber,
    $core.String? cardHolderName,
    $core.String? expiryDate,
    $core.String? cvv,
    $core.String? message,
  }) {
    final $result = create();
    if (cardNumber != null) {
      $result.cardNumber = cardNumber;
    }
    if (cardHolderName != null) {
      $result.cardHolderName = cardHolderName;
    }
    if (expiryDate != null) {
      $result.expiryDate = expiryDate;
    }
    if (cvv != null) {
      $result.cvv = cvv;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  RevealCardDetailsResponse._() : super();
  factory RevealCardDetailsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RevealCardDetailsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RevealCardDetailsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'cardNumber')
    ..aOS(2, _omitFieldNames ? '' : 'cardHolderName')
    ..aOS(3, _omitFieldNames ? '' : 'expiryDate')
    ..aOS(4, _omitFieldNames ? '' : 'cvv')
    ..aOS(5, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RevealCardDetailsResponse clone() => RevealCardDetailsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RevealCardDetailsResponse copyWith(void Function(RevealCardDetailsResponse) updates) => super.copyWith((message) => updates(message as RevealCardDetailsResponse)) as RevealCardDetailsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RevealCardDetailsResponse create() => RevealCardDetailsResponse._();
  RevealCardDetailsResponse createEmptyInstance() => create();
  static $pb.PbList<RevealCardDetailsResponse> createRepeated() => $pb.PbList<RevealCardDetailsResponse>();
  @$core.pragma('dart2js:noInline')
  static RevealCardDetailsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RevealCardDetailsResponse>(create);
  static RevealCardDetailsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get cardNumber => $_getSZ(0);
  @$pb.TagNumber(1)
  set cardNumber($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCardNumber() => $_has(0);
  @$pb.TagNumber(1)
  void clearCardNumber() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get cardHolderName => $_getSZ(1);
  @$pb.TagNumber(2)
  set cardHolderName($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCardHolderName() => $_has(1);
  @$pb.TagNumber(2)
  void clearCardHolderName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get expiryDate => $_getSZ(2);
  @$pb.TagNumber(3)
  set expiryDate($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasExpiryDate() => $_has(2);
  @$pb.TagNumber(3)
  void clearExpiryDate() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get cvv => $_getSZ(3);
  @$pb.TagNumber(4)
  set cvv($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCvv() => $_has(3);
  @$pb.TagNumber(4)
  void clearCvv() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get message => $_getSZ(4);
  @$pb.TagNumber(5)
  set message($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasMessage() => $_has(4);
  @$pb.TagNumber(5)
  void clearMessage() => clearField(5);
}

/// Generate statement request
class GenerateStatementRequest extends $pb.GeneratedMessage {
  factory GenerateStatementRequest({
    $core.String? accountId,
    $fixnum.Int64? startDate,
    $fixnum.Int64? endDate,
    $core.String? format,
  }) {
    final $result = create();
    if (accountId != null) {
      $result.accountId = accountId;
    }
    if (startDate != null) {
      $result.startDate = startDate;
    }
    if (endDate != null) {
      $result.endDate = endDate;
    }
    if (format != null) {
      $result.format = format;
    }
    return $result;
  }
  GenerateStatementRequest._() : super();
  factory GenerateStatementRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GenerateStatementRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GenerateStatementRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountId')
    ..aInt64(2, _omitFieldNames ? '' : 'startDate')
    ..aInt64(3, _omitFieldNames ? '' : 'endDate')
    ..aOS(4, _omitFieldNames ? '' : 'format')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GenerateStatementRequest clone() => GenerateStatementRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GenerateStatementRequest copyWith(void Function(GenerateStatementRequest) updates) => super.copyWith((message) => updates(message as GenerateStatementRequest)) as GenerateStatementRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GenerateStatementRequest create() => GenerateStatementRequest._();
  GenerateStatementRequest createEmptyInstance() => create();
  static $pb.PbList<GenerateStatementRequest> createRepeated() => $pb.PbList<GenerateStatementRequest>();
  @$core.pragma('dart2js:noInline')
  static GenerateStatementRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GenerateStatementRequest>(create);
  static GenerateStatementRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get startDate => $_getI64(1);
  @$pb.TagNumber(2)
  set startDate($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasStartDate() => $_has(1);
  @$pb.TagNumber(2)
  void clearStartDate() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get endDate => $_getI64(2);
  @$pb.TagNumber(3)
  set endDate($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasEndDate() => $_has(2);
  @$pb.TagNumber(3)
  void clearEndDate() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get format => $_getSZ(3);
  @$pb.TagNumber(4)
  set format($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasFormat() => $_has(3);
  @$pb.TagNumber(4)
  void clearFormat() => clearField(4);
}

class GenerateStatementResponse extends $pb.GeneratedMessage {
  factory GenerateStatementResponse({
    $core.String? documentId,
    $core.String? downloadUrl,
    $fixnum.Int64? validUntil,
    $core.String? message,
  }) {
    final $result = create();
    if (documentId != null) {
      $result.documentId = documentId;
    }
    if (downloadUrl != null) {
      $result.downloadUrl = downloadUrl;
    }
    if (validUntil != null) {
      $result.validUntil = validUntil;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  GenerateStatementResponse._() : super();
  factory GenerateStatementResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GenerateStatementResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GenerateStatementResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'documentId')
    ..aOS(2, _omitFieldNames ? '' : 'downloadUrl')
    ..aInt64(3, _omitFieldNames ? '' : 'validUntil')
    ..aOS(4, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GenerateStatementResponse clone() => GenerateStatementResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GenerateStatementResponse copyWith(void Function(GenerateStatementResponse) updates) => super.copyWith((message) => updates(message as GenerateStatementResponse)) as GenerateStatementResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GenerateStatementResponse create() => GenerateStatementResponse._();
  GenerateStatementResponse createEmptyInstance() => create();
  static $pb.PbList<GenerateStatementResponse> createRepeated() => $pb.PbList<GenerateStatementResponse>();
  @$core.pragma('dart2js:noInline')
  static GenerateStatementResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GenerateStatementResponse>(create);
  static GenerateStatementResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get documentId => $_getSZ(0);
  @$pb.TagNumber(1)
  set documentId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDocumentId() => $_has(0);
  @$pb.TagNumber(1)
  void clearDocumentId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get downloadUrl => $_getSZ(1);
  @$pb.TagNumber(2)
  set downloadUrl($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasDownloadUrl() => $_has(1);
  @$pb.TagNumber(2)
  void clearDownloadUrl() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get validUntil => $_getI64(2);
  @$pb.TagNumber(3)
  set validUntil($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasValidUntil() => $_has(2);
  @$pb.TagNumber(3)
  void clearValidUntil() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get message => $_getSZ(3);
  @$pb.TagNumber(4)
  set message($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasMessage() => $_has(3);
  @$pb.TagNumber(4)
  void clearMessage() => clearField(4);
}

/// Generate account confirmation request
class GenerateAccountConfirmationRequest extends $pb.GeneratedMessage {
  factory GenerateAccountConfirmationRequest({
    $core.String? accountId,
  }) {
    final $result = create();
    if (accountId != null) {
      $result.accountId = accountId;
    }
    return $result;
  }
  GenerateAccountConfirmationRequest._() : super();
  factory GenerateAccountConfirmationRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GenerateAccountConfirmationRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GenerateAccountConfirmationRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GenerateAccountConfirmationRequest clone() => GenerateAccountConfirmationRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GenerateAccountConfirmationRequest copyWith(void Function(GenerateAccountConfirmationRequest) updates) => super.copyWith((message) => updates(message as GenerateAccountConfirmationRequest)) as GenerateAccountConfirmationRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GenerateAccountConfirmationRequest create() => GenerateAccountConfirmationRequest._();
  GenerateAccountConfirmationRequest createEmptyInstance() => create();
  static $pb.PbList<GenerateAccountConfirmationRequest> createRepeated() => $pb.PbList<GenerateAccountConfirmationRequest>();
  @$core.pragma('dart2js:noInline')
  static GenerateAccountConfirmationRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GenerateAccountConfirmationRequest>(create);
  static GenerateAccountConfirmationRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => clearField(1);
}

class GenerateAccountConfirmationResponse extends $pb.GeneratedMessage {
  factory GenerateAccountConfirmationResponse({
    $core.String? documentId,
    $core.String? downloadUrl,
    $fixnum.Int64? validUntil,
    $core.String? message,
  }) {
    final $result = create();
    if (documentId != null) {
      $result.documentId = documentId;
    }
    if (downloadUrl != null) {
      $result.downloadUrl = downloadUrl;
    }
    if (validUntil != null) {
      $result.validUntil = validUntil;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  GenerateAccountConfirmationResponse._() : super();
  factory GenerateAccountConfirmationResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GenerateAccountConfirmationResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GenerateAccountConfirmationResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'documentId')
    ..aOS(2, _omitFieldNames ? '' : 'downloadUrl')
    ..aInt64(3, _omitFieldNames ? '' : 'validUntil')
    ..aOS(4, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GenerateAccountConfirmationResponse clone() => GenerateAccountConfirmationResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GenerateAccountConfirmationResponse copyWith(void Function(GenerateAccountConfirmationResponse) updates) => super.copyWith((message) => updates(message as GenerateAccountConfirmationResponse)) as GenerateAccountConfirmationResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GenerateAccountConfirmationResponse create() => GenerateAccountConfirmationResponse._();
  GenerateAccountConfirmationResponse createEmptyInstance() => create();
  static $pb.PbList<GenerateAccountConfirmationResponse> createRepeated() => $pb.PbList<GenerateAccountConfirmationResponse>();
  @$core.pragma('dart2js:noInline')
  static GenerateAccountConfirmationResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GenerateAccountConfirmationResponse>(create);
  static GenerateAccountConfirmationResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get documentId => $_getSZ(0);
  @$pb.TagNumber(1)
  set documentId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDocumentId() => $_has(0);
  @$pb.TagNumber(1)
  void clearDocumentId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get downloadUrl => $_getSZ(1);
  @$pb.TagNumber(2)
  set downloadUrl($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasDownloadUrl() => $_has(1);
  @$pb.TagNumber(2)
  void clearDownloadUrl() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get validUntil => $_getI64(2);
  @$pb.TagNumber(3)
  set validUntil($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasValidUntil() => $_has(2);
  @$pb.TagNumber(3)
  void clearValidUntil() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get message => $_getSZ(3);
  @$pb.TagNumber(4)
  set message($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasMessage() => $_has(3);
  @$pb.TagNumber(4)
  void clearMessage() => clearField(4);
}

/// Generate proof of funds request
class GenerateProofOfFundsRequest extends $pb.GeneratedMessage {
  factory GenerateProofOfFundsRequest({
    $core.String? accountId,
  }) {
    final $result = create();
    if (accountId != null) {
      $result.accountId = accountId;
    }
    return $result;
  }
  GenerateProofOfFundsRequest._() : super();
  factory GenerateProofOfFundsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GenerateProofOfFundsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GenerateProofOfFundsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GenerateProofOfFundsRequest clone() => GenerateProofOfFundsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GenerateProofOfFundsRequest copyWith(void Function(GenerateProofOfFundsRequest) updates) => super.copyWith((message) => updates(message as GenerateProofOfFundsRequest)) as GenerateProofOfFundsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GenerateProofOfFundsRequest create() => GenerateProofOfFundsRequest._();
  GenerateProofOfFundsRequest createEmptyInstance() => create();
  static $pb.PbList<GenerateProofOfFundsRequest> createRepeated() => $pb.PbList<GenerateProofOfFundsRequest>();
  @$core.pragma('dart2js:noInline')
  static GenerateProofOfFundsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GenerateProofOfFundsRequest>(create);
  static GenerateProofOfFundsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => clearField(1);
}

class GenerateProofOfFundsResponse extends $pb.GeneratedMessage {
  factory GenerateProofOfFundsResponse({
    $core.String? documentId,
    $core.String? downloadUrl,
    $fixnum.Int64? validUntil,
    $core.double? currentBalance,
    $core.String? currency,
    $core.String? message,
  }) {
    final $result = create();
    if (documentId != null) {
      $result.documentId = documentId;
    }
    if (downloadUrl != null) {
      $result.downloadUrl = downloadUrl;
    }
    if (validUntil != null) {
      $result.validUntil = validUntil;
    }
    if (currentBalance != null) {
      $result.currentBalance = currentBalance;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  GenerateProofOfFundsResponse._() : super();
  factory GenerateProofOfFundsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GenerateProofOfFundsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GenerateProofOfFundsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'documentId')
    ..aOS(2, _omitFieldNames ? '' : 'downloadUrl')
    ..aInt64(3, _omitFieldNames ? '' : 'validUntil')
    ..a<$core.double>(4, _omitFieldNames ? '' : 'currentBalance', $pb.PbFieldType.OD)
    ..aOS(5, _omitFieldNames ? '' : 'currency')
    ..aOS(6, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GenerateProofOfFundsResponse clone() => GenerateProofOfFundsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GenerateProofOfFundsResponse copyWith(void Function(GenerateProofOfFundsResponse) updates) => super.copyWith((message) => updates(message as GenerateProofOfFundsResponse)) as GenerateProofOfFundsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GenerateProofOfFundsResponse create() => GenerateProofOfFundsResponse._();
  GenerateProofOfFundsResponse createEmptyInstance() => create();
  static $pb.PbList<GenerateProofOfFundsResponse> createRepeated() => $pb.PbList<GenerateProofOfFundsResponse>();
  @$core.pragma('dart2js:noInline')
  static GenerateProofOfFundsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GenerateProofOfFundsResponse>(create);
  static GenerateProofOfFundsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get documentId => $_getSZ(0);
  @$pb.TagNumber(1)
  set documentId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDocumentId() => $_has(0);
  @$pb.TagNumber(1)
  void clearDocumentId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get downloadUrl => $_getSZ(1);
  @$pb.TagNumber(2)
  set downloadUrl($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasDownloadUrl() => $_has(1);
  @$pb.TagNumber(2)
  void clearDownloadUrl() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get validUntil => $_getI64(2);
  @$pb.TagNumber(3)
  set validUntil($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasValidUntil() => $_has(2);
  @$pb.TagNumber(3)
  void clearValidUntil() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get currentBalance => $_getN(3);
  @$pb.TagNumber(4)
  set currentBalance($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCurrentBalance() => $_has(3);
  @$pb.TagNumber(4)
  void clearCurrentBalance() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get currency => $_getSZ(4);
  @$pb.TagNumber(5)
  set currency($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasCurrency() => $_has(4);
  @$pb.TagNumber(5)
  void clearCurrency() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get message => $_getSZ(5);
  @$pb.TagNumber(6)
  set message($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasMessage() => $_has(5);
  @$pb.TagNumber(6)
  void clearMessage() => clearField(6);
}

/// Update security settings request
class UpdateSecuritySettingsRequest extends $pb.GeneratedMessage {
  factory UpdateSecuritySettingsRequest({
    $core.String? accountId,
    $core.bool? enable3dSecure,
    $core.bool? enableContactless,
    $core.bool? enableOnlinePayments,
    $core.bool? enableAtmWithdrawals,
    $core.bool? enableInternationalPayments,
  }) {
    final $result = create();
    if (accountId != null) {
      $result.accountId = accountId;
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
    if (enableAtmWithdrawals != null) {
      $result.enableAtmWithdrawals = enableAtmWithdrawals;
    }
    if (enableInternationalPayments != null) {
      $result.enableInternationalPayments = enableInternationalPayments;
    }
    return $result;
  }
  UpdateSecuritySettingsRequest._() : super();
  factory UpdateSecuritySettingsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateSecuritySettingsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateSecuritySettingsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountId')
    ..aOB(2, _omitFieldNames ? '' : 'enable3dSecure', protoName: 'enable_3d_secure')
    ..aOB(3, _omitFieldNames ? '' : 'enableContactless')
    ..aOB(4, _omitFieldNames ? '' : 'enableOnlinePayments')
    ..aOB(5, _omitFieldNames ? '' : 'enableAtmWithdrawals')
    ..aOB(6, _omitFieldNames ? '' : 'enableInternationalPayments')
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
  $core.String get accountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get enable3dSecure => $_getBF(1);
  @$pb.TagNumber(2)
  set enable3dSecure($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasEnable3dSecure() => $_has(1);
  @$pb.TagNumber(2)
  void clearEnable3dSecure() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get enableContactless => $_getBF(2);
  @$pb.TagNumber(3)
  set enableContactless($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasEnableContactless() => $_has(2);
  @$pb.TagNumber(3)
  void clearEnableContactless() => clearField(3);

  @$pb.TagNumber(4)
  $core.bool get enableOnlinePayments => $_getBF(3);
  @$pb.TagNumber(4)
  set enableOnlinePayments($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasEnableOnlinePayments() => $_has(3);
  @$pb.TagNumber(4)
  void clearEnableOnlinePayments() => clearField(4);

  @$pb.TagNumber(5)
  $core.bool get enableAtmWithdrawals => $_getBF(4);
  @$pb.TagNumber(5)
  set enableAtmWithdrawals($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasEnableAtmWithdrawals() => $_has(4);
  @$pb.TagNumber(5)
  void clearEnableAtmWithdrawals() => clearField(5);

  @$pb.TagNumber(6)
  $core.bool get enableInternationalPayments => $_getBF(5);
  @$pb.TagNumber(6)
  set enableInternationalPayments($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasEnableInternationalPayments() => $_has(5);
  @$pb.TagNumber(6)
  void clearEnableInternationalPayments() => clearField(6);
}

class UpdateSecuritySettingsResponse extends $pb.GeneratedMessage {
  factory UpdateSecuritySettingsResponse({
    Account? account,
    $core.String? message,
    $core.bool? enable3dSecure,
    $core.bool? enableContactless,
    $core.bool? enableOnlinePayments,
    $core.bool? enableAtmWithdrawals,
    $core.bool? enableInternationalPayments,
  }) {
    final $result = create();
    if (account != null) {
      $result.account = account;
    }
    if (message != null) {
      $result.message = message;
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
    if (enableAtmWithdrawals != null) {
      $result.enableAtmWithdrawals = enableAtmWithdrawals;
    }
    if (enableInternationalPayments != null) {
      $result.enableInternationalPayments = enableInternationalPayments;
    }
    return $result;
  }
  UpdateSecuritySettingsResponse._() : super();
  factory UpdateSecuritySettingsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateSecuritySettingsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateSecuritySettingsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOM<Account>(1, _omitFieldNames ? '' : 'account', subBuilder: Account.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOB(3, _omitFieldNames ? '' : 'enable3dSecure', protoName: 'enable_3d_secure')
    ..aOB(4, _omitFieldNames ? '' : 'enableContactless')
    ..aOB(5, _omitFieldNames ? '' : 'enableOnlinePayments')
    ..aOB(6, _omitFieldNames ? '' : 'enableAtmWithdrawals')
    ..aOB(7, _omitFieldNames ? '' : 'enableInternationalPayments')
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
  Account get account => $_getN(0);
  @$pb.TagNumber(1)
  set account(Account v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccount() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccount() => clearField(1);
  @$pb.TagNumber(1)
  Account ensureAccount() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get enable3dSecure => $_getBF(2);
  @$pb.TagNumber(3)
  set enable3dSecure($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasEnable3dSecure() => $_has(2);
  @$pb.TagNumber(3)
  void clearEnable3dSecure() => clearField(3);

  @$pb.TagNumber(4)
  $core.bool get enableContactless => $_getBF(3);
  @$pb.TagNumber(4)
  set enableContactless($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasEnableContactless() => $_has(3);
  @$pb.TagNumber(4)
  void clearEnableContactless() => clearField(4);

  @$pb.TagNumber(5)
  $core.bool get enableOnlinePayments => $_getBF(4);
  @$pb.TagNumber(5)
  set enableOnlinePayments($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasEnableOnlinePayments() => $_has(4);
  @$pb.TagNumber(5)
  void clearEnableOnlinePayments() => clearField(5);

  @$pb.TagNumber(6)
  $core.bool get enableAtmWithdrawals => $_getBF(5);
  @$pb.TagNumber(6)
  set enableAtmWithdrawals($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasEnableAtmWithdrawals() => $_has(5);
  @$pb.TagNumber(6)
  void clearEnableAtmWithdrawals() => clearField(6);

  @$pb.TagNumber(7)
  $core.bool get enableInternationalPayments => $_getBF(6);
  @$pb.TagNumber(7)
  set enableInternationalPayments($core.bool v) { $_setBool(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasEnableInternationalPayments() => $_has(6);
  @$pb.TagNumber(7)
  void clearEnableInternationalPayments() => clearField(7);
}

/// CreditToClearingRequest - Credit deposit to balance but NOT available_balance
class CreditToClearingRequest extends $pb.GeneratedMessage {
  factory CreditToClearingRequest({
    $core.String? accountId,
    $core.String? userId,
    $fixnum.Int64? amount,
    $core.String? currency,
    $core.String? reference,
    $core.String? description,
    $core.String? metadata,
    $core.String? serviceName,
    $core.String? idempotencyKey,
    $core.String? provider,
    $core.String? providerTxId,
    $core.int? kycTier,
    $core.String? depositType,
  }) {
    final $result = create();
    if (accountId != null) {
      $result.accountId = accountId;
    }
    if (userId != null) {
      $result.userId = userId;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (reference != null) {
      $result.reference = reference;
    }
    if (description != null) {
      $result.description = description;
    }
    if (metadata != null) {
      $result.metadata = metadata;
    }
    if (serviceName != null) {
      $result.serviceName = serviceName;
    }
    if (idempotencyKey != null) {
      $result.idempotencyKey = idempotencyKey;
    }
    if (provider != null) {
      $result.provider = provider;
    }
    if (providerTxId != null) {
      $result.providerTxId = providerTxId;
    }
    if (kycTier != null) {
      $result.kycTier = kycTier;
    }
    if (depositType != null) {
      $result.depositType = depositType;
    }
    return $result;
  }
  CreditToClearingRequest._() : super();
  factory CreditToClearingRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreditToClearingRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreditToClearingRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountId')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aInt64(3, _omitFieldNames ? '' : 'amount')
    ..aOS(4, _omitFieldNames ? '' : 'currency')
    ..aOS(5, _omitFieldNames ? '' : 'reference')
    ..aOS(6, _omitFieldNames ? '' : 'description')
    ..aOS(7, _omitFieldNames ? '' : 'metadata')
    ..aOS(8, _omitFieldNames ? '' : 'serviceName')
    ..aOS(9, _omitFieldNames ? '' : 'idempotencyKey')
    ..aOS(10, _omitFieldNames ? '' : 'provider')
    ..aOS(11, _omitFieldNames ? '' : 'providerTxId')
    ..a<$core.int>(12, _omitFieldNames ? '' : 'kycTier', $pb.PbFieldType.O3)
    ..aOS(13, _omitFieldNames ? '' : 'depositType')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreditToClearingRequest clone() => CreditToClearingRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreditToClearingRequest copyWith(void Function(CreditToClearingRequest) updates) => super.copyWith((message) => updates(message as CreditToClearingRequest)) as CreditToClearingRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreditToClearingRequest create() => CreditToClearingRequest._();
  CreditToClearingRequest createEmptyInstance() => create();
  static $pb.PbList<CreditToClearingRequest> createRepeated() => $pb.PbList<CreditToClearingRequest>();
  @$core.pragma('dart2js:noInline')
  static CreditToClearingRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreditToClearingRequest>(create);
  static CreditToClearingRequest? _defaultInstance;

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
  $core.String get reference => $_getSZ(4);
  @$pb.TagNumber(5)
  set reference($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasReference() => $_has(4);
  @$pb.TagNumber(5)
  void clearReference() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get description => $_getSZ(5);
  @$pb.TagNumber(6)
  set description($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasDescription() => $_has(5);
  @$pb.TagNumber(6)
  void clearDescription() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get metadata => $_getSZ(6);
  @$pb.TagNumber(7)
  set metadata($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasMetadata() => $_has(6);
  @$pb.TagNumber(7)
  void clearMetadata() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get serviceName => $_getSZ(7);
  @$pb.TagNumber(8)
  set serviceName($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasServiceName() => $_has(7);
  @$pb.TagNumber(8)
  void clearServiceName() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get idempotencyKey => $_getSZ(8);
  @$pb.TagNumber(9)
  set idempotencyKey($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasIdempotencyKey() => $_has(8);
  @$pb.TagNumber(9)
  void clearIdempotencyKey() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get provider => $_getSZ(9);
  @$pb.TagNumber(10)
  set provider($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasProvider() => $_has(9);
  @$pb.TagNumber(10)
  void clearProvider() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get providerTxId => $_getSZ(10);
  @$pb.TagNumber(11)
  set providerTxId($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasProviderTxId() => $_has(10);
  @$pb.TagNumber(11)
  void clearProviderTxId() => clearField(11);

  @$pb.TagNumber(12)
  $core.int get kycTier => $_getIZ(11);
  @$pb.TagNumber(12)
  set kycTier($core.int v) { $_setSignedInt32(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasKycTier() => $_has(11);
  @$pb.TagNumber(12)
  void clearKycTier() => clearField(12);

  @$pb.TagNumber(13)
  $core.String get depositType => $_getSZ(12);
  @$pb.TagNumber(13)
  set depositType($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasDepositType() => $_has(12);
  @$pb.TagNumber(13)
  void clearDepositType() => clearField(13);
}

class CreditToClearingResponse extends $pb.GeneratedMessage {
  factory CreditToClearingResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
    $core.String? clearingRecordId,
    $core.String? transactionId,
    $fixnum.Int64? newBalance,
    $fixnum.Int64? newAvailableBalance,
    $core.String? clearsAt,
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
    if (clearingRecordId != null) {
      $result.clearingRecordId = clearingRecordId;
    }
    if (transactionId != null) {
      $result.transactionId = transactionId;
    }
    if (newBalance != null) {
      $result.newBalance = newBalance;
    }
    if (newAvailableBalance != null) {
      $result.newAvailableBalance = newAvailableBalance;
    }
    if (clearsAt != null) {
      $result.clearsAt = clearsAt;
    }
    return $result;
  }
  CreditToClearingResponse._() : super();
  factory CreditToClearingResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreditToClearingResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreditToClearingResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'errorCode')
    ..aOS(3, _omitFieldNames ? '' : 'errorMessage')
    ..aOS(4, _omitFieldNames ? '' : 'clearingRecordId')
    ..aOS(5, _omitFieldNames ? '' : 'transactionId')
    ..aInt64(6, _omitFieldNames ? '' : 'newBalance')
    ..aInt64(7, _omitFieldNames ? '' : 'newAvailableBalance')
    ..aOS(8, _omitFieldNames ? '' : 'clearsAt')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreditToClearingResponse clone() => CreditToClearingResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreditToClearingResponse copyWith(void Function(CreditToClearingResponse) updates) => super.copyWith((message) => updates(message as CreditToClearingResponse)) as CreditToClearingResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreditToClearingResponse create() => CreditToClearingResponse._();
  CreditToClearingResponse createEmptyInstance() => create();
  static $pb.PbList<CreditToClearingResponse> createRepeated() => $pb.PbList<CreditToClearingResponse>();
  @$core.pragma('dart2js:noInline')
  static CreditToClearingResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreditToClearingResponse>(create);
  static CreditToClearingResponse? _defaultInstance;

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
  $core.String get clearingRecordId => $_getSZ(3);
  @$pb.TagNumber(4)
  set clearingRecordId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasClearingRecordId() => $_has(3);
  @$pb.TagNumber(4)
  void clearClearingRecordId() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get transactionId => $_getSZ(4);
  @$pb.TagNumber(5)
  set transactionId($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTransactionId() => $_has(4);
  @$pb.TagNumber(5)
  void clearTransactionId() => clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get newBalance => $_getI64(5);
  @$pb.TagNumber(6)
  set newBalance($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasNewBalance() => $_has(5);
  @$pb.TagNumber(6)
  void clearNewBalance() => clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get newAvailableBalance => $_getI64(6);
  @$pb.TagNumber(7)
  set newAvailableBalance($fixnum.Int64 v) { $_setInt64(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasNewAvailableBalance() => $_has(6);
  @$pb.TagNumber(7)
  void clearNewAvailableBalance() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get clearsAt => $_getSZ(7);
  @$pb.TagNumber(8)
  set clearsAt($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasClearsAt() => $_has(7);
  @$pb.TagNumber(8)
  void clearClearsAt() => clearField(8);
}

/// ClearDepositRequest - Move cleared deposit to available balance
class ClearDepositRequest extends $pb.GeneratedMessage {
  factory ClearDepositRequest({
    $core.String? clearingRecordId,
    $core.String? serviceName,
  }) {
    final $result = create();
    if (clearingRecordId != null) {
      $result.clearingRecordId = clearingRecordId;
    }
    if (serviceName != null) {
      $result.serviceName = serviceName;
    }
    return $result;
  }
  ClearDepositRequest._() : super();
  factory ClearDepositRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ClearDepositRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ClearDepositRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'clearingRecordId')
    ..aOS(2, _omitFieldNames ? '' : 'serviceName')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ClearDepositRequest clone() => ClearDepositRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ClearDepositRequest copyWith(void Function(ClearDepositRequest) updates) => super.copyWith((message) => updates(message as ClearDepositRequest)) as ClearDepositRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ClearDepositRequest create() => ClearDepositRequest._();
  ClearDepositRequest createEmptyInstance() => create();
  static $pb.PbList<ClearDepositRequest> createRepeated() => $pb.PbList<ClearDepositRequest>();
  @$core.pragma('dart2js:noInline')
  static ClearDepositRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ClearDepositRequest>(create);
  static ClearDepositRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get clearingRecordId => $_getSZ(0);
  @$pb.TagNumber(1)
  set clearingRecordId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasClearingRecordId() => $_has(0);
  @$pb.TagNumber(1)
  void clearClearingRecordId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get serviceName => $_getSZ(1);
  @$pb.TagNumber(2)
  set serviceName($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasServiceName() => $_has(1);
  @$pb.TagNumber(2)
  void clearServiceName() => clearField(2);
}

class ClearDepositResponse extends $pb.GeneratedMessage {
  factory ClearDepositResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
    $fixnum.Int64? newAvailableBalance,
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
    if (newAvailableBalance != null) {
      $result.newAvailableBalance = newAvailableBalance;
    }
    return $result;
  }
  ClearDepositResponse._() : super();
  factory ClearDepositResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ClearDepositResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ClearDepositResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'errorCode')
    ..aOS(3, _omitFieldNames ? '' : 'errorMessage')
    ..aInt64(4, _omitFieldNames ? '' : 'newAvailableBalance')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ClearDepositResponse clone() => ClearDepositResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ClearDepositResponse copyWith(void Function(ClearDepositResponse) updates) => super.copyWith((message) => updates(message as ClearDepositResponse)) as ClearDepositResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ClearDepositResponse create() => ClearDepositResponse._();
  ClearDepositResponse createEmptyInstance() => create();
  static $pb.PbList<ClearDepositResponse> createRepeated() => $pb.PbList<ClearDepositResponse>();
  @$core.pragma('dart2js:noInline')
  static ClearDepositResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ClearDepositResponse>(create);
  static ClearDepositResponse? _defaultInstance;

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
  $fixnum.Int64 get newAvailableBalance => $_getI64(3);
  @$pb.TagNumber(4)
  set newAvailableBalance($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasNewAvailableBalance() => $_has(3);
  @$pb.TagNumber(4)
  void clearNewAvailableBalance() => clearField(4);
}

/// ReverseClearingDepositRequest - Reverse a deposit in clearing
class ReverseClearingDepositRequest extends $pb.GeneratedMessage {
  factory ReverseClearingDepositRequest({
    $core.String? clearingRecordId,
    $core.String? reason,
    $core.String? serviceName,
  }) {
    final $result = create();
    if (clearingRecordId != null) {
      $result.clearingRecordId = clearingRecordId;
    }
    if (reason != null) {
      $result.reason = reason;
    }
    if (serviceName != null) {
      $result.serviceName = serviceName;
    }
    return $result;
  }
  ReverseClearingDepositRequest._() : super();
  factory ReverseClearingDepositRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ReverseClearingDepositRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ReverseClearingDepositRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'clearingRecordId')
    ..aOS(2, _omitFieldNames ? '' : 'reason')
    ..aOS(3, _omitFieldNames ? '' : 'serviceName')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ReverseClearingDepositRequest clone() => ReverseClearingDepositRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ReverseClearingDepositRequest copyWith(void Function(ReverseClearingDepositRequest) updates) => super.copyWith((message) => updates(message as ReverseClearingDepositRequest)) as ReverseClearingDepositRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ReverseClearingDepositRequest create() => ReverseClearingDepositRequest._();
  ReverseClearingDepositRequest createEmptyInstance() => create();
  static $pb.PbList<ReverseClearingDepositRequest> createRepeated() => $pb.PbList<ReverseClearingDepositRequest>();
  @$core.pragma('dart2js:noInline')
  static ReverseClearingDepositRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ReverseClearingDepositRequest>(create);
  static ReverseClearingDepositRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get clearingRecordId => $_getSZ(0);
  @$pb.TagNumber(1)
  set clearingRecordId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasClearingRecordId() => $_has(0);
  @$pb.TagNumber(1)
  void clearClearingRecordId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get reason => $_getSZ(1);
  @$pb.TagNumber(2)
  set reason($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasReason() => $_has(1);
  @$pb.TagNumber(2)
  void clearReason() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get serviceName => $_getSZ(2);
  @$pb.TagNumber(3)
  set serviceName($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasServiceName() => $_has(2);
  @$pb.TagNumber(3)
  void clearServiceName() => clearField(3);
}

class ReverseClearingDepositResponse extends $pb.GeneratedMessage {
  factory ReverseClearingDepositResponse({
    $core.bool? success,
    $core.String? errorCode,
    $core.String? errorMessage,
    $fixnum.Int64? newBalance,
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
    if (newBalance != null) {
      $result.newBalance = newBalance;
    }
    return $result;
  }
  ReverseClearingDepositResponse._() : super();
  factory ReverseClearingDepositResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ReverseClearingDepositResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ReverseClearingDepositResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'errorCode')
    ..aOS(3, _omitFieldNames ? '' : 'errorMessage')
    ..aInt64(4, _omitFieldNames ? '' : 'newBalance')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ReverseClearingDepositResponse clone() => ReverseClearingDepositResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ReverseClearingDepositResponse copyWith(void Function(ReverseClearingDepositResponse) updates) => super.copyWith((message) => updates(message as ReverseClearingDepositResponse)) as ReverseClearingDepositResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ReverseClearingDepositResponse create() => ReverseClearingDepositResponse._();
  ReverseClearingDepositResponse createEmptyInstance() => create();
  static $pb.PbList<ReverseClearingDepositResponse> createRepeated() => $pb.PbList<ReverseClearingDepositResponse>();
  @$core.pragma('dart2js:noInline')
  static ReverseClearingDepositResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ReverseClearingDepositResponse>(create);
  static ReverseClearingDepositResponse? _defaultInstance;

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
}

class AdminSearchAccountsRequest extends $pb.GeneratedMessage {
  factory AdminSearchAccountsRequest({
    $core.String? query,
    $core.String? searchType,
    $core.int? page,
    $core.int? perPage,
  }) {
    final $result = create();
    if (query != null) {
      $result.query = query;
    }
    if (searchType != null) {
      $result.searchType = searchType;
    }
    if (page != null) {
      $result.page = page;
    }
    if (perPage != null) {
      $result.perPage = perPage;
    }
    return $result;
  }
  AdminSearchAccountsRequest._() : super();
  factory AdminSearchAccountsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AdminSearchAccountsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AdminSearchAccountsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'query')
    ..aOS(2, _omitFieldNames ? '' : 'searchType')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'perPage', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AdminSearchAccountsRequest clone() => AdminSearchAccountsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AdminSearchAccountsRequest copyWith(void Function(AdminSearchAccountsRequest) updates) => super.copyWith((message) => updates(message as AdminSearchAccountsRequest)) as AdminSearchAccountsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminSearchAccountsRequest create() => AdminSearchAccountsRequest._();
  AdminSearchAccountsRequest createEmptyInstance() => create();
  static $pb.PbList<AdminSearchAccountsRequest> createRepeated() => $pb.PbList<AdminSearchAccountsRequest>();
  @$core.pragma('dart2js:noInline')
  static AdminSearchAccountsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdminSearchAccountsRequest>(create);
  static AdminSearchAccountsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get query => $_getSZ(0);
  @$pb.TagNumber(1)
  set query($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasQuery() => $_has(0);
  @$pb.TagNumber(1)
  void clearQuery() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get searchType => $_getSZ(1);
  @$pb.TagNumber(2)
  set searchType($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSearchType() => $_has(1);
  @$pb.TagNumber(2)
  void clearSearchType() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get page => $_getIZ(2);
  @$pb.TagNumber(3)
  set page($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPage() => $_has(2);
  @$pb.TagNumber(3)
  void clearPage() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get perPage => $_getIZ(3);
  @$pb.TagNumber(4)
  set perPage($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPerPage() => $_has(3);
  @$pb.TagNumber(4)
  void clearPerPage() => clearField(4);
}

class AdminSearchAccountsResponse extends $pb.GeneratedMessage {
  factory AdminSearchAccountsResponse({
    $core.Iterable<AdminAccountSummary>? accounts,
    $fixnum.Int64? total,
  }) {
    final $result = create();
    if (accounts != null) {
      $result.accounts.addAll(accounts);
    }
    if (total != null) {
      $result.total = total;
    }
    return $result;
  }
  AdminSearchAccountsResponse._() : super();
  factory AdminSearchAccountsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AdminSearchAccountsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AdminSearchAccountsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..pc<AdminAccountSummary>(1, _omitFieldNames ? '' : 'accounts', $pb.PbFieldType.PM, subBuilder: AdminAccountSummary.create)
    ..aInt64(2, _omitFieldNames ? '' : 'total')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AdminSearchAccountsResponse clone() => AdminSearchAccountsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AdminSearchAccountsResponse copyWith(void Function(AdminSearchAccountsResponse) updates) => super.copyWith((message) => updates(message as AdminSearchAccountsResponse)) as AdminSearchAccountsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminSearchAccountsResponse create() => AdminSearchAccountsResponse._();
  AdminSearchAccountsResponse createEmptyInstance() => create();
  static $pb.PbList<AdminSearchAccountsResponse> createRepeated() => $pb.PbList<AdminSearchAccountsResponse>();
  @$core.pragma('dart2js:noInline')
  static AdminSearchAccountsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdminSearchAccountsResponse>(create);
  static AdminSearchAccountsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<AdminAccountSummary> get accounts => $_getList(0);

  @$pb.TagNumber(2)
  $fixnum.Int64 get total => $_getI64(1);
  @$pb.TagNumber(2)
  set total($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => clearField(2);
}

class AdminAccountSummary extends $pb.GeneratedMessage {
  factory AdminAccountSummary({
    $core.String? id,
    $core.String? userId,
    $core.String? currency,
    $fixnum.Int64? balance,
    $fixnum.Int64? availableBalance,
    $fixnum.Int64? reservedBalance,
    $core.String? status,
    $core.String? accountType,
    $core.String? createdAt,
    $core.String? userEmail,
    $core.String? userName,
    $core.String? userPhone,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (userId != null) {
      $result.userId = userId;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (balance != null) {
      $result.balance = balance;
    }
    if (availableBalance != null) {
      $result.availableBalance = availableBalance;
    }
    if (reservedBalance != null) {
      $result.reservedBalance = reservedBalance;
    }
    if (status != null) {
      $result.status = status;
    }
    if (accountType != null) {
      $result.accountType = accountType;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    if (userEmail != null) {
      $result.userEmail = userEmail;
    }
    if (userName != null) {
      $result.userName = userName;
    }
    if (userPhone != null) {
      $result.userPhone = userPhone;
    }
    return $result;
  }
  AdminAccountSummary._() : super();
  factory AdminAccountSummary.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AdminAccountSummary.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AdminAccountSummary', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'currency')
    ..aInt64(4, _omitFieldNames ? '' : 'balance')
    ..aInt64(5, _omitFieldNames ? '' : 'availableBalance')
    ..aInt64(6, _omitFieldNames ? '' : 'reservedBalance')
    ..aOS(7, _omitFieldNames ? '' : 'status')
    ..aOS(8, _omitFieldNames ? '' : 'accountType')
    ..aOS(9, _omitFieldNames ? '' : 'createdAt')
    ..aOS(10, _omitFieldNames ? '' : 'userEmail')
    ..aOS(11, _omitFieldNames ? '' : 'userName')
    ..aOS(12, _omitFieldNames ? '' : 'userPhone')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AdminAccountSummary clone() => AdminAccountSummary()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AdminAccountSummary copyWith(void Function(AdminAccountSummary) updates) => super.copyWith((message) => updates(message as AdminAccountSummary)) as AdminAccountSummary;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminAccountSummary create() => AdminAccountSummary._();
  AdminAccountSummary createEmptyInstance() => create();
  static $pb.PbList<AdminAccountSummary> createRepeated() => $pb.PbList<AdminAccountSummary>();
  @$core.pragma('dart2js:noInline')
  static AdminAccountSummary getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdminAccountSummary>(create);
  static AdminAccountSummary? _defaultInstance;

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
  $fixnum.Int64 get availableBalance => $_getI64(4);
  @$pb.TagNumber(5)
  set availableBalance($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasAvailableBalance() => $_has(4);
  @$pb.TagNumber(5)
  void clearAvailableBalance() => clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get reservedBalance => $_getI64(5);
  @$pb.TagNumber(6)
  set reservedBalance($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasReservedBalance() => $_has(5);
  @$pb.TagNumber(6)
  void clearReservedBalance() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get status => $_getSZ(6);
  @$pb.TagNumber(7)
  set status($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasStatus() => $_has(6);
  @$pb.TagNumber(7)
  void clearStatus() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get accountType => $_getSZ(7);
  @$pb.TagNumber(8)
  set accountType($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasAccountType() => $_has(7);
  @$pb.TagNumber(8)
  void clearAccountType() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get createdAt => $_getSZ(8);
  @$pb.TagNumber(9)
  set createdAt($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasCreatedAt() => $_has(8);
  @$pb.TagNumber(9)
  void clearCreatedAt() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get userEmail => $_getSZ(9);
  @$pb.TagNumber(10)
  set userEmail($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasUserEmail() => $_has(9);
  @$pb.TagNumber(10)
  void clearUserEmail() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get userName => $_getSZ(10);
  @$pb.TagNumber(11)
  set userName($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasUserName() => $_has(10);
  @$pb.TagNumber(11)
  void clearUserName() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get userPhone => $_getSZ(11);
  @$pb.TagNumber(12)
  set userPhone($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasUserPhone() => $_has(11);
  @$pb.TagNumber(12)
  void clearUserPhone() => clearField(12);
}

class AdminGetAccountDetailRequest extends $pb.GeneratedMessage {
  factory AdminGetAccountDetailRequest({
    $core.String? accountId,
  }) {
    final $result = create();
    if (accountId != null) {
      $result.accountId = accountId;
    }
    return $result;
  }
  AdminGetAccountDetailRequest._() : super();
  factory AdminGetAccountDetailRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AdminGetAccountDetailRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AdminGetAccountDetailRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AdminGetAccountDetailRequest clone() => AdminGetAccountDetailRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AdminGetAccountDetailRequest copyWith(void Function(AdminGetAccountDetailRequest) updates) => super.copyWith((message) => updates(message as AdminGetAccountDetailRequest)) as AdminGetAccountDetailRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminGetAccountDetailRequest create() => AdminGetAccountDetailRequest._();
  AdminGetAccountDetailRequest createEmptyInstance() => create();
  static $pb.PbList<AdminGetAccountDetailRequest> createRepeated() => $pb.PbList<AdminGetAccountDetailRequest>();
  @$core.pragma('dart2js:noInline')
  static AdminGetAccountDetailRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdminGetAccountDetailRequest>(create);
  static AdminGetAccountDetailRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => clearField(1);
}

class AdminAccountDetailResponse extends $pb.GeneratedMessage {
  factory AdminAccountDetailResponse({
    AdminAccountSummary? account,
    $fixnum.Int64? pendingClearingAmount,
    $core.int? activeHoldsCount,
    $fixnum.Int64? activeHoldsAmount,
    $core.int? pendingClearingCount,
    $core.String? kycTier,
    $core.String? locale,
    $core.Iterable<AdminVirtualAccount>? virtualAccounts,
  }) {
    final $result = create();
    if (account != null) {
      $result.account = account;
    }
    if (pendingClearingAmount != null) {
      $result.pendingClearingAmount = pendingClearingAmount;
    }
    if (activeHoldsCount != null) {
      $result.activeHoldsCount = activeHoldsCount;
    }
    if (activeHoldsAmount != null) {
      $result.activeHoldsAmount = activeHoldsAmount;
    }
    if (pendingClearingCount != null) {
      $result.pendingClearingCount = pendingClearingCount;
    }
    if (kycTier != null) {
      $result.kycTier = kycTier;
    }
    if (locale != null) {
      $result.locale = locale;
    }
    if (virtualAccounts != null) {
      $result.virtualAccounts.addAll(virtualAccounts);
    }
    return $result;
  }
  AdminAccountDetailResponse._() : super();
  factory AdminAccountDetailResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AdminAccountDetailResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AdminAccountDetailResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOM<AdminAccountSummary>(1, _omitFieldNames ? '' : 'account', subBuilder: AdminAccountSummary.create)
    ..aInt64(2, _omitFieldNames ? '' : 'pendingClearingAmount')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'activeHoldsCount', $pb.PbFieldType.O3)
    ..aInt64(4, _omitFieldNames ? '' : 'activeHoldsAmount')
    ..a<$core.int>(5, _omitFieldNames ? '' : 'pendingClearingCount', $pb.PbFieldType.O3)
    ..aOS(6, _omitFieldNames ? '' : 'kycTier')
    ..aOS(7, _omitFieldNames ? '' : 'locale')
    ..pc<AdminVirtualAccount>(8, _omitFieldNames ? '' : 'virtualAccounts', $pb.PbFieldType.PM, subBuilder: AdminVirtualAccount.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AdminAccountDetailResponse clone() => AdminAccountDetailResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AdminAccountDetailResponse copyWith(void Function(AdminAccountDetailResponse) updates) => super.copyWith((message) => updates(message as AdminAccountDetailResponse)) as AdminAccountDetailResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminAccountDetailResponse create() => AdminAccountDetailResponse._();
  AdminAccountDetailResponse createEmptyInstance() => create();
  static $pb.PbList<AdminAccountDetailResponse> createRepeated() => $pb.PbList<AdminAccountDetailResponse>();
  @$core.pragma('dart2js:noInline')
  static AdminAccountDetailResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdminAccountDetailResponse>(create);
  static AdminAccountDetailResponse? _defaultInstance;

  @$pb.TagNumber(1)
  AdminAccountSummary get account => $_getN(0);
  @$pb.TagNumber(1)
  set account(AdminAccountSummary v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccount() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccount() => clearField(1);
  @$pb.TagNumber(1)
  AdminAccountSummary ensureAccount() => $_ensure(0);

  @$pb.TagNumber(2)
  $fixnum.Int64 get pendingClearingAmount => $_getI64(1);
  @$pb.TagNumber(2)
  set pendingClearingAmount($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPendingClearingAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearPendingClearingAmount() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get activeHoldsCount => $_getIZ(2);
  @$pb.TagNumber(3)
  set activeHoldsCount($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasActiveHoldsCount() => $_has(2);
  @$pb.TagNumber(3)
  void clearActiveHoldsCount() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get activeHoldsAmount => $_getI64(3);
  @$pb.TagNumber(4)
  set activeHoldsAmount($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasActiveHoldsAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearActiveHoldsAmount() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get pendingClearingCount => $_getIZ(4);
  @$pb.TagNumber(5)
  set pendingClearingCount($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasPendingClearingCount() => $_has(4);
  @$pb.TagNumber(5)
  void clearPendingClearingCount() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get kycTier => $_getSZ(5);
  @$pb.TagNumber(6)
  set kycTier($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasKycTier() => $_has(5);
  @$pb.TagNumber(6)
  void clearKycTier() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get locale => $_getSZ(6);
  @$pb.TagNumber(7)
  set locale($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasLocale() => $_has(6);
  @$pb.TagNumber(7)
  void clearLocale() => clearField(7);

  @$pb.TagNumber(8)
  $core.List<AdminVirtualAccount> get virtualAccounts => $_getList(7);
}

class AdminVirtualAccount extends $pb.GeneratedMessage {
  factory AdminVirtualAccount({
    $core.String? id,
    $core.String? bankName,
    $core.String? accountNumber,
    $core.String? accountName,
    $core.String? provider,
    $core.String? status,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (bankName != null) {
      $result.bankName = bankName;
    }
    if (accountNumber != null) {
      $result.accountNumber = accountNumber;
    }
    if (accountName != null) {
      $result.accountName = accountName;
    }
    if (provider != null) {
      $result.provider = provider;
    }
    if (status != null) {
      $result.status = status;
    }
    return $result;
  }
  AdminVirtualAccount._() : super();
  factory AdminVirtualAccount.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AdminVirtualAccount.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AdminVirtualAccount', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'bankName')
    ..aOS(3, _omitFieldNames ? '' : 'accountNumber')
    ..aOS(4, _omitFieldNames ? '' : 'accountName')
    ..aOS(5, _omitFieldNames ? '' : 'provider')
    ..aOS(6, _omitFieldNames ? '' : 'status')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AdminVirtualAccount clone() => AdminVirtualAccount()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AdminVirtualAccount copyWith(void Function(AdminVirtualAccount) updates) => super.copyWith((message) => updates(message as AdminVirtualAccount)) as AdminVirtualAccount;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminVirtualAccount create() => AdminVirtualAccount._();
  AdminVirtualAccount createEmptyInstance() => create();
  static $pb.PbList<AdminVirtualAccount> createRepeated() => $pb.PbList<AdminVirtualAccount>();
  @$core.pragma('dart2js:noInline')
  static AdminVirtualAccount getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdminVirtualAccount>(create);
  static AdminVirtualAccount? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get bankName => $_getSZ(1);
  @$pb.TagNumber(2)
  set bankName($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasBankName() => $_has(1);
  @$pb.TagNumber(2)
  void clearBankName() => clearField(2);

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
  $core.String get provider => $_getSZ(4);
  @$pb.TagNumber(5)
  set provider($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasProvider() => $_has(4);
  @$pb.TagNumber(5)
  void clearProvider() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get status => $_getSZ(5);
  @$pb.TagNumber(6)
  set status($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasStatus() => $_has(5);
  @$pb.TagNumber(6)
  void clearStatus() => clearField(6);
}

class AdminGetAccountTransactionsRequest extends $pb.GeneratedMessage {
  factory AdminGetAccountTransactionsRequest({
    $core.String? accountId,
    $core.String? type,
    $core.String? category,
    $core.String? fromDate,
    $core.String? toDate,
    $core.int? page,
    $core.int? perPage,
  }) {
    final $result = create();
    if (accountId != null) {
      $result.accountId = accountId;
    }
    if (type != null) {
      $result.type = type;
    }
    if (category != null) {
      $result.category = category;
    }
    if (fromDate != null) {
      $result.fromDate = fromDate;
    }
    if (toDate != null) {
      $result.toDate = toDate;
    }
    if (page != null) {
      $result.page = page;
    }
    if (perPage != null) {
      $result.perPage = perPage;
    }
    return $result;
  }
  AdminGetAccountTransactionsRequest._() : super();
  factory AdminGetAccountTransactionsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AdminGetAccountTransactionsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AdminGetAccountTransactionsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountId')
    ..aOS(2, _omitFieldNames ? '' : 'type')
    ..aOS(3, _omitFieldNames ? '' : 'category')
    ..aOS(4, _omitFieldNames ? '' : 'fromDate')
    ..aOS(5, _omitFieldNames ? '' : 'toDate')
    ..a<$core.int>(6, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(7, _omitFieldNames ? '' : 'perPage', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AdminGetAccountTransactionsRequest clone() => AdminGetAccountTransactionsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AdminGetAccountTransactionsRequest copyWith(void Function(AdminGetAccountTransactionsRequest) updates) => super.copyWith((message) => updates(message as AdminGetAccountTransactionsRequest)) as AdminGetAccountTransactionsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminGetAccountTransactionsRequest create() => AdminGetAccountTransactionsRequest._();
  AdminGetAccountTransactionsRequest createEmptyInstance() => create();
  static $pb.PbList<AdminGetAccountTransactionsRequest> createRepeated() => $pb.PbList<AdminGetAccountTransactionsRequest>();
  @$core.pragma('dart2js:noInline')
  static AdminGetAccountTransactionsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdminGetAccountTransactionsRequest>(create);
  static AdminGetAccountTransactionsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get type => $_getSZ(1);
  @$pb.TagNumber(2)
  set type($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasType() => $_has(1);
  @$pb.TagNumber(2)
  void clearType() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get category => $_getSZ(2);
  @$pb.TagNumber(3)
  set category($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCategory() => $_has(2);
  @$pb.TagNumber(3)
  void clearCategory() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get fromDate => $_getSZ(3);
  @$pb.TagNumber(4)
  set fromDate($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasFromDate() => $_has(3);
  @$pb.TagNumber(4)
  void clearFromDate() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get toDate => $_getSZ(4);
  @$pb.TagNumber(5)
  set toDate($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasToDate() => $_has(4);
  @$pb.TagNumber(5)
  void clearToDate() => clearField(5);

  @$pb.TagNumber(6)
  $core.int get page => $_getIZ(5);
  @$pb.TagNumber(6)
  set page($core.int v) { $_setSignedInt32(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasPage() => $_has(5);
  @$pb.TagNumber(6)
  void clearPage() => clearField(6);

  @$pb.TagNumber(7)
  $core.int get perPage => $_getIZ(6);
  @$pb.TagNumber(7)
  set perPage($core.int v) { $_setSignedInt32(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasPerPage() => $_has(6);
  @$pb.TagNumber(7)
  void clearPerPage() => clearField(7);
}

class AdminAccountTransactionsResponse extends $pb.GeneratedMessage {
  factory AdminAccountTransactionsResponse({
    $core.Iterable<AdminTransaction>? transactions,
    $fixnum.Int64? total,
  }) {
    final $result = create();
    if (transactions != null) {
      $result.transactions.addAll(transactions);
    }
    if (total != null) {
      $result.total = total;
    }
    return $result;
  }
  AdminAccountTransactionsResponse._() : super();
  factory AdminAccountTransactionsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AdminAccountTransactionsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AdminAccountTransactionsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..pc<AdminTransaction>(1, _omitFieldNames ? '' : 'transactions', $pb.PbFieldType.PM, subBuilder: AdminTransaction.create)
    ..aInt64(2, _omitFieldNames ? '' : 'total')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AdminAccountTransactionsResponse clone() => AdminAccountTransactionsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AdminAccountTransactionsResponse copyWith(void Function(AdminAccountTransactionsResponse) updates) => super.copyWith((message) => updates(message as AdminAccountTransactionsResponse)) as AdminAccountTransactionsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminAccountTransactionsResponse create() => AdminAccountTransactionsResponse._();
  AdminAccountTransactionsResponse createEmptyInstance() => create();
  static $pb.PbList<AdminAccountTransactionsResponse> createRepeated() => $pb.PbList<AdminAccountTransactionsResponse>();
  @$core.pragma('dart2js:noInline')
  static AdminAccountTransactionsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdminAccountTransactionsResponse>(create);
  static AdminAccountTransactionsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<AdminTransaction> get transactions => $_getList(0);

  @$pb.TagNumber(2)
  $fixnum.Int64 get total => $_getI64(1);
  @$pb.TagNumber(2)
  set total($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => clearField(2);
}

class AdminTransaction extends $pb.GeneratedMessage {
  factory AdminTransaction({
    $core.String? id,
    $core.String? reference,
    $core.String? type,
    $core.String? category,
    $fixnum.Int64? amount,
    $fixnum.Int64? balanceBefore,
    $fixnum.Int64? balanceAfter,
    $core.String? description,
    $core.String? status,
    $core.String? serviceName,
    $core.String? createdAt,
    $core.String? metadata,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (reference != null) {
      $result.reference = reference;
    }
    if (type != null) {
      $result.type = type;
    }
    if (category != null) {
      $result.category = category;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (balanceBefore != null) {
      $result.balanceBefore = balanceBefore;
    }
    if (balanceAfter != null) {
      $result.balanceAfter = balanceAfter;
    }
    if (description != null) {
      $result.description = description;
    }
    if (status != null) {
      $result.status = status;
    }
    if (serviceName != null) {
      $result.serviceName = serviceName;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    if (metadata != null) {
      $result.metadata = metadata;
    }
    return $result;
  }
  AdminTransaction._() : super();
  factory AdminTransaction.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AdminTransaction.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AdminTransaction', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'reference')
    ..aOS(3, _omitFieldNames ? '' : 'type')
    ..aOS(4, _omitFieldNames ? '' : 'category')
    ..aInt64(5, _omitFieldNames ? '' : 'amount')
    ..aInt64(6, _omitFieldNames ? '' : 'balanceBefore')
    ..aInt64(7, _omitFieldNames ? '' : 'balanceAfter')
    ..aOS(8, _omitFieldNames ? '' : 'description')
    ..aOS(9, _omitFieldNames ? '' : 'status')
    ..aOS(10, _omitFieldNames ? '' : 'serviceName')
    ..aOS(11, _omitFieldNames ? '' : 'createdAt')
    ..aOS(12, _omitFieldNames ? '' : 'metadata')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AdminTransaction clone() => AdminTransaction()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AdminTransaction copyWith(void Function(AdminTransaction) updates) => super.copyWith((message) => updates(message as AdminTransaction)) as AdminTransaction;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminTransaction create() => AdminTransaction._();
  AdminTransaction createEmptyInstance() => create();
  static $pb.PbList<AdminTransaction> createRepeated() => $pb.PbList<AdminTransaction>();
  @$core.pragma('dart2js:noInline')
  static AdminTransaction getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdminTransaction>(create);
  static AdminTransaction? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get reference => $_getSZ(1);
  @$pb.TagNumber(2)
  set reference($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasReference() => $_has(1);
  @$pb.TagNumber(2)
  void clearReference() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get type => $_getSZ(2);
  @$pb.TagNumber(3)
  set type($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasType() => $_has(2);
  @$pb.TagNumber(3)
  void clearType() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get category => $_getSZ(3);
  @$pb.TagNumber(4)
  set category($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCategory() => $_has(3);
  @$pb.TagNumber(4)
  void clearCategory() => clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get amount => $_getI64(4);
  @$pb.TagNumber(5)
  set amount($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasAmount() => $_has(4);
  @$pb.TagNumber(5)
  void clearAmount() => clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get balanceBefore => $_getI64(5);
  @$pb.TagNumber(6)
  set balanceBefore($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasBalanceBefore() => $_has(5);
  @$pb.TagNumber(6)
  void clearBalanceBefore() => clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get balanceAfter => $_getI64(6);
  @$pb.TagNumber(7)
  set balanceAfter($fixnum.Int64 v) { $_setInt64(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasBalanceAfter() => $_has(6);
  @$pb.TagNumber(7)
  void clearBalanceAfter() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get description => $_getSZ(7);
  @$pb.TagNumber(8)
  set description($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasDescription() => $_has(7);
  @$pb.TagNumber(8)
  void clearDescription() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get status => $_getSZ(8);
  @$pb.TagNumber(9)
  set status($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasStatus() => $_has(8);
  @$pb.TagNumber(9)
  void clearStatus() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get serviceName => $_getSZ(9);
  @$pb.TagNumber(10)
  set serviceName($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasServiceName() => $_has(9);
  @$pb.TagNumber(10)
  void clearServiceName() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get createdAt => $_getSZ(10);
  @$pb.TagNumber(11)
  set createdAt($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasCreatedAt() => $_has(10);
  @$pb.TagNumber(11)
  void clearCreatedAt() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get metadata => $_getSZ(11);
  @$pb.TagNumber(12)
  set metadata($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasMetadata() => $_has(11);
  @$pb.TagNumber(12)
  void clearMetadata() => clearField(12);
}

class AdminGetAccountHoldsRequest extends $pb.GeneratedMessage {
  factory AdminGetAccountHoldsRequest({
    $core.String? accountId,
    $core.String? status,
    $core.int? page,
    $core.int? perPage,
  }) {
    final $result = create();
    if (accountId != null) {
      $result.accountId = accountId;
    }
    if (status != null) {
      $result.status = status;
    }
    if (page != null) {
      $result.page = page;
    }
    if (perPage != null) {
      $result.perPage = perPage;
    }
    return $result;
  }
  AdminGetAccountHoldsRequest._() : super();
  factory AdminGetAccountHoldsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AdminGetAccountHoldsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AdminGetAccountHoldsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountId')
    ..aOS(2, _omitFieldNames ? '' : 'status')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'perPage', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AdminGetAccountHoldsRequest clone() => AdminGetAccountHoldsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AdminGetAccountHoldsRequest copyWith(void Function(AdminGetAccountHoldsRequest) updates) => super.copyWith((message) => updates(message as AdminGetAccountHoldsRequest)) as AdminGetAccountHoldsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminGetAccountHoldsRequest create() => AdminGetAccountHoldsRequest._();
  AdminGetAccountHoldsRequest createEmptyInstance() => create();
  static $pb.PbList<AdminGetAccountHoldsRequest> createRepeated() => $pb.PbList<AdminGetAccountHoldsRequest>();
  @$core.pragma('dart2js:noInline')
  static AdminGetAccountHoldsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdminGetAccountHoldsRequest>(create);
  static AdminGetAccountHoldsRequest? _defaultInstance;

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

  @$pb.TagNumber(3)
  $core.int get page => $_getIZ(2);
  @$pb.TagNumber(3)
  set page($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPage() => $_has(2);
  @$pb.TagNumber(3)
  void clearPage() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get perPage => $_getIZ(3);
  @$pb.TagNumber(4)
  set perPage($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPerPage() => $_has(3);
  @$pb.TagNumber(4)
  void clearPerPage() => clearField(4);
}

class AdminAccountHoldsResponse extends $pb.GeneratedMessage {
  factory AdminAccountHoldsResponse({
    $core.Iterable<AdminHold>? holds,
    $fixnum.Int64? total,
  }) {
    final $result = create();
    if (holds != null) {
      $result.holds.addAll(holds);
    }
    if (total != null) {
      $result.total = total;
    }
    return $result;
  }
  AdminAccountHoldsResponse._() : super();
  factory AdminAccountHoldsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AdminAccountHoldsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AdminAccountHoldsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..pc<AdminHold>(1, _omitFieldNames ? '' : 'holds', $pb.PbFieldType.PM, subBuilder: AdminHold.create)
    ..aInt64(2, _omitFieldNames ? '' : 'total')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AdminAccountHoldsResponse clone() => AdminAccountHoldsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AdminAccountHoldsResponse copyWith(void Function(AdminAccountHoldsResponse) updates) => super.copyWith((message) => updates(message as AdminAccountHoldsResponse)) as AdminAccountHoldsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminAccountHoldsResponse create() => AdminAccountHoldsResponse._();
  AdminAccountHoldsResponse createEmptyInstance() => create();
  static $pb.PbList<AdminAccountHoldsResponse> createRepeated() => $pb.PbList<AdminAccountHoldsResponse>();
  @$core.pragma('dart2js:noInline')
  static AdminAccountHoldsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdminAccountHoldsResponse>(create);
  static AdminAccountHoldsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<AdminHold> get holds => $_getList(0);

  @$pb.TagNumber(2)
  $fixnum.Int64 get total => $_getI64(1);
  @$pb.TagNumber(2)
  set total($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => clearField(2);
}

class AdminHold extends $pb.GeneratedMessage {
  factory AdminHold({
    $core.String? id,
    $core.String? accountId,
    $fixnum.Int64? amount,
    $core.String? currency,
    $core.String? reference,
    $core.String? reason,
    $core.String? status,
    $core.String? serviceName,
    $core.String? createdAt,
    $core.String? expiresAt,
    $core.String? capturedAt,
    $core.String? releasedAt,
    $core.String? idempotencyKey,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (accountId != null) {
      $result.accountId = accountId;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (reference != null) {
      $result.reference = reference;
    }
    if (reason != null) {
      $result.reason = reason;
    }
    if (status != null) {
      $result.status = status;
    }
    if (serviceName != null) {
      $result.serviceName = serviceName;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    if (expiresAt != null) {
      $result.expiresAt = expiresAt;
    }
    if (capturedAt != null) {
      $result.capturedAt = capturedAt;
    }
    if (releasedAt != null) {
      $result.releasedAt = releasedAt;
    }
    if (idempotencyKey != null) {
      $result.idempotencyKey = idempotencyKey;
    }
    return $result;
  }
  AdminHold._() : super();
  factory AdminHold.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AdminHold.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AdminHold', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'accountId')
    ..aInt64(3, _omitFieldNames ? '' : 'amount')
    ..aOS(4, _omitFieldNames ? '' : 'currency')
    ..aOS(5, _omitFieldNames ? '' : 'reference')
    ..aOS(6, _omitFieldNames ? '' : 'reason')
    ..aOS(7, _omitFieldNames ? '' : 'status')
    ..aOS(8, _omitFieldNames ? '' : 'serviceName')
    ..aOS(9, _omitFieldNames ? '' : 'createdAt')
    ..aOS(10, _omitFieldNames ? '' : 'expiresAt')
    ..aOS(11, _omitFieldNames ? '' : 'capturedAt')
    ..aOS(12, _omitFieldNames ? '' : 'releasedAt')
    ..aOS(13, _omitFieldNames ? '' : 'idempotencyKey')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AdminHold clone() => AdminHold()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AdminHold copyWith(void Function(AdminHold) updates) => super.copyWith((message) => updates(message as AdminHold)) as AdminHold;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminHold create() => AdminHold._();
  AdminHold createEmptyInstance() => create();
  static $pb.PbList<AdminHold> createRepeated() => $pb.PbList<AdminHold>();
  @$core.pragma('dart2js:noInline')
  static AdminHold getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdminHold>(create);
  static AdminHold? _defaultInstance;

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
  $core.String get reference => $_getSZ(4);
  @$pb.TagNumber(5)
  set reference($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasReference() => $_has(4);
  @$pb.TagNumber(5)
  void clearReference() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get reason => $_getSZ(5);
  @$pb.TagNumber(6)
  set reason($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasReason() => $_has(5);
  @$pb.TagNumber(6)
  void clearReason() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get status => $_getSZ(6);
  @$pb.TagNumber(7)
  set status($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasStatus() => $_has(6);
  @$pb.TagNumber(7)
  void clearStatus() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get serviceName => $_getSZ(7);
  @$pb.TagNumber(8)
  set serviceName($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasServiceName() => $_has(7);
  @$pb.TagNumber(8)
  void clearServiceName() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get createdAt => $_getSZ(8);
  @$pb.TagNumber(9)
  set createdAt($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasCreatedAt() => $_has(8);
  @$pb.TagNumber(9)
  void clearCreatedAt() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get expiresAt => $_getSZ(9);
  @$pb.TagNumber(10)
  set expiresAt($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasExpiresAt() => $_has(9);
  @$pb.TagNumber(10)
  void clearExpiresAt() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get capturedAt => $_getSZ(10);
  @$pb.TagNumber(11)
  set capturedAt($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasCapturedAt() => $_has(10);
  @$pb.TagNumber(11)
  void clearCapturedAt() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get releasedAt => $_getSZ(11);
  @$pb.TagNumber(12)
  set releasedAt($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasReleasedAt() => $_has(11);
  @$pb.TagNumber(12)
  void clearReleasedAt() => clearField(12);

  @$pb.TagNumber(13)
  $core.String get idempotencyKey => $_getSZ(12);
  @$pb.TagNumber(13)
  set idempotencyKey($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasIdempotencyKey() => $_has(12);
  @$pb.TagNumber(13)
  void clearIdempotencyKey() => clearField(13);
}

class AdminGetAccountClearingRequest extends $pb.GeneratedMessage {
  factory AdminGetAccountClearingRequest({
    $core.String? accountId,
    $core.String? status,
    $core.int? page,
    $core.int? perPage,
  }) {
    final $result = create();
    if (accountId != null) {
      $result.accountId = accountId;
    }
    if (status != null) {
      $result.status = status;
    }
    if (page != null) {
      $result.page = page;
    }
    if (perPage != null) {
      $result.perPage = perPage;
    }
    return $result;
  }
  AdminGetAccountClearingRequest._() : super();
  factory AdminGetAccountClearingRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AdminGetAccountClearingRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AdminGetAccountClearingRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountId')
    ..aOS(2, _omitFieldNames ? '' : 'status')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'perPage', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AdminGetAccountClearingRequest clone() => AdminGetAccountClearingRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AdminGetAccountClearingRequest copyWith(void Function(AdminGetAccountClearingRequest) updates) => super.copyWith((message) => updates(message as AdminGetAccountClearingRequest)) as AdminGetAccountClearingRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminGetAccountClearingRequest create() => AdminGetAccountClearingRequest._();
  AdminGetAccountClearingRequest createEmptyInstance() => create();
  static $pb.PbList<AdminGetAccountClearingRequest> createRepeated() => $pb.PbList<AdminGetAccountClearingRequest>();
  @$core.pragma('dart2js:noInline')
  static AdminGetAccountClearingRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdminGetAccountClearingRequest>(create);
  static AdminGetAccountClearingRequest? _defaultInstance;

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

  @$pb.TagNumber(3)
  $core.int get page => $_getIZ(2);
  @$pb.TagNumber(3)
  set page($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPage() => $_has(2);
  @$pb.TagNumber(3)
  void clearPage() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get perPage => $_getIZ(3);
  @$pb.TagNumber(4)
  set perPage($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPerPage() => $_has(3);
  @$pb.TagNumber(4)
  void clearPerPage() => clearField(4);
}

class AdminAccountClearingResponse extends $pb.GeneratedMessage {
  factory AdminAccountClearingResponse({
    $core.Iterable<AdminClearingRecord>? records,
    $fixnum.Int64? total,
  }) {
    final $result = create();
    if (records != null) {
      $result.records.addAll(records);
    }
    if (total != null) {
      $result.total = total;
    }
    return $result;
  }
  AdminAccountClearingResponse._() : super();
  factory AdminAccountClearingResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AdminAccountClearingResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AdminAccountClearingResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..pc<AdminClearingRecord>(1, _omitFieldNames ? '' : 'records', $pb.PbFieldType.PM, subBuilder: AdminClearingRecord.create)
    ..aInt64(2, _omitFieldNames ? '' : 'total')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AdminAccountClearingResponse clone() => AdminAccountClearingResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AdminAccountClearingResponse copyWith(void Function(AdminAccountClearingResponse) updates) => super.copyWith((message) => updates(message as AdminAccountClearingResponse)) as AdminAccountClearingResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminAccountClearingResponse create() => AdminAccountClearingResponse._();
  AdminAccountClearingResponse createEmptyInstance() => create();
  static $pb.PbList<AdminAccountClearingResponse> createRepeated() => $pb.PbList<AdminAccountClearingResponse>();
  @$core.pragma('dart2js:noInline')
  static AdminAccountClearingResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdminAccountClearingResponse>(create);
  static AdminAccountClearingResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<AdminClearingRecord> get records => $_getList(0);

  @$pb.TagNumber(2)
  $fixnum.Int64 get total => $_getI64(1);
  @$pb.TagNumber(2)
  set total($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => clearField(2);
}

class AdminListAllHoldsRequest extends $pb.GeneratedMessage {
  factory AdminListAllHoldsRequest({
    $core.String? status,
    $core.String? accountId,
    $core.int? ageHours,
    $core.int? page,
    $core.int? perPage,
  }) {
    final $result = create();
    if (status != null) {
      $result.status = status;
    }
    if (accountId != null) {
      $result.accountId = accountId;
    }
    if (ageHours != null) {
      $result.ageHours = ageHours;
    }
    if (page != null) {
      $result.page = page;
    }
    if (perPage != null) {
      $result.perPage = perPage;
    }
    return $result;
  }
  AdminListAllHoldsRequest._() : super();
  factory AdminListAllHoldsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AdminListAllHoldsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AdminListAllHoldsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'status')
    ..aOS(2, _omitFieldNames ? '' : 'accountId')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'ageHours', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'perPage', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AdminListAllHoldsRequest clone() => AdminListAllHoldsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AdminListAllHoldsRequest copyWith(void Function(AdminListAllHoldsRequest) updates) => super.copyWith((message) => updates(message as AdminListAllHoldsRequest)) as AdminListAllHoldsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminListAllHoldsRequest create() => AdminListAllHoldsRequest._();
  AdminListAllHoldsRequest createEmptyInstance() => create();
  static $pb.PbList<AdminListAllHoldsRequest> createRepeated() => $pb.PbList<AdminListAllHoldsRequest>();
  @$core.pragma('dart2js:noInline')
  static AdminListAllHoldsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdminListAllHoldsRequest>(create);
  static AdminListAllHoldsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get status => $_getSZ(0);
  @$pb.TagNumber(1)
  set status($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get accountId => $_getSZ(1);
  @$pb.TagNumber(2)
  set accountId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAccountId() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccountId() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get ageHours => $_getIZ(2);
  @$pb.TagNumber(3)
  set ageHours($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAgeHours() => $_has(2);
  @$pb.TagNumber(3)
  void clearAgeHours() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get page => $_getIZ(3);
  @$pb.TagNumber(4)
  set page($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPage() => $_has(3);
  @$pb.TagNumber(4)
  void clearPage() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get perPage => $_getIZ(4);
  @$pb.TagNumber(5)
  set perPage($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasPerPage() => $_has(4);
  @$pb.TagNumber(5)
  void clearPerPage() => clearField(5);
}

class AdminListAllHoldsResponse extends $pb.GeneratedMessage {
  factory AdminListAllHoldsResponse({
    $core.Iterable<AdminHold>? holds,
    $fixnum.Int64? total,
  }) {
    final $result = create();
    if (holds != null) {
      $result.holds.addAll(holds);
    }
    if (total != null) {
      $result.total = total;
    }
    return $result;
  }
  AdminListAllHoldsResponse._() : super();
  factory AdminListAllHoldsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AdminListAllHoldsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AdminListAllHoldsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..pc<AdminHold>(1, _omitFieldNames ? '' : 'holds', $pb.PbFieldType.PM, subBuilder: AdminHold.create)
    ..aInt64(2, _omitFieldNames ? '' : 'total')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AdminListAllHoldsResponse clone() => AdminListAllHoldsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AdminListAllHoldsResponse copyWith(void Function(AdminListAllHoldsResponse) updates) => super.copyWith((message) => updates(message as AdminListAllHoldsResponse)) as AdminListAllHoldsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminListAllHoldsResponse create() => AdminListAllHoldsResponse._();
  AdminListAllHoldsResponse createEmptyInstance() => create();
  static $pb.PbList<AdminListAllHoldsResponse> createRepeated() => $pb.PbList<AdminListAllHoldsResponse>();
  @$core.pragma('dart2js:noInline')
  static AdminListAllHoldsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdminListAllHoldsResponse>(create);
  static AdminListAllHoldsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<AdminHold> get holds => $_getList(0);

  @$pb.TagNumber(2)
  $fixnum.Int64 get total => $_getI64(1);
  @$pb.TagNumber(2)
  set total($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => clearField(2);
}

class AdminGetStaleHoldsRequest extends $pb.GeneratedMessage {
  factory AdminGetStaleHoldsRequest({
    $core.int? page,
    $core.int? perPage,
  }) {
    final $result = create();
    if (page != null) {
      $result.page = page;
    }
    if (perPage != null) {
      $result.perPage = perPage;
    }
    return $result;
  }
  AdminGetStaleHoldsRequest._() : super();
  factory AdminGetStaleHoldsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AdminGetStaleHoldsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AdminGetStaleHoldsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'perPage', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AdminGetStaleHoldsRequest clone() => AdminGetStaleHoldsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AdminGetStaleHoldsRequest copyWith(void Function(AdminGetStaleHoldsRequest) updates) => super.copyWith((message) => updates(message as AdminGetStaleHoldsRequest)) as AdminGetStaleHoldsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminGetStaleHoldsRequest create() => AdminGetStaleHoldsRequest._();
  AdminGetStaleHoldsRequest createEmptyInstance() => create();
  static $pb.PbList<AdminGetStaleHoldsRequest> createRepeated() => $pb.PbList<AdminGetStaleHoldsRequest>();
  @$core.pragma('dart2js:noInline')
  static AdminGetStaleHoldsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdminGetStaleHoldsRequest>(create);
  static AdminGetStaleHoldsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get page => $_getIZ(0);
  @$pb.TagNumber(1)
  set page($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearPage() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get perPage => $_getIZ(1);
  @$pb.TagNumber(2)
  set perPage($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPerPage() => $_has(1);
  @$pb.TagNumber(2)
  void clearPerPage() => clearField(2);
}

class AdminGetStaleHoldsResponse extends $pb.GeneratedMessage {
  factory AdminGetStaleHoldsResponse({
    $core.Iterable<AdminHold>? holds,
    $fixnum.Int64? total,
  }) {
    final $result = create();
    if (holds != null) {
      $result.holds.addAll(holds);
    }
    if (total != null) {
      $result.total = total;
    }
    return $result;
  }
  AdminGetStaleHoldsResponse._() : super();
  factory AdminGetStaleHoldsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AdminGetStaleHoldsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AdminGetStaleHoldsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..pc<AdminHold>(1, _omitFieldNames ? '' : 'holds', $pb.PbFieldType.PM, subBuilder: AdminHold.create)
    ..aInt64(2, _omitFieldNames ? '' : 'total')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AdminGetStaleHoldsResponse clone() => AdminGetStaleHoldsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AdminGetStaleHoldsResponse copyWith(void Function(AdminGetStaleHoldsResponse) updates) => super.copyWith((message) => updates(message as AdminGetStaleHoldsResponse)) as AdminGetStaleHoldsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminGetStaleHoldsResponse create() => AdminGetStaleHoldsResponse._();
  AdminGetStaleHoldsResponse createEmptyInstance() => create();
  static $pb.PbList<AdminGetStaleHoldsResponse> createRepeated() => $pb.PbList<AdminGetStaleHoldsResponse>();
  @$core.pragma('dart2js:noInline')
  static AdminGetStaleHoldsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdminGetStaleHoldsResponse>(create);
  static AdminGetStaleHoldsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<AdminHold> get holds => $_getList(0);

  @$pb.TagNumber(2)
  $fixnum.Int64 get total => $_getI64(1);
  @$pb.TagNumber(2)
  set total($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => clearField(2);
}

class AdminGetAllPlatformWalletsRequest extends $pb.GeneratedMessage {
  factory AdminGetAllPlatformWalletsRequest() => create();
  AdminGetAllPlatformWalletsRequest._() : super();
  factory AdminGetAllPlatformWalletsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AdminGetAllPlatformWalletsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AdminGetAllPlatformWalletsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AdminGetAllPlatformWalletsRequest clone() => AdminGetAllPlatformWalletsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AdminGetAllPlatformWalletsRequest copyWith(void Function(AdminGetAllPlatformWalletsRequest) updates) => super.copyWith((message) => updates(message as AdminGetAllPlatformWalletsRequest)) as AdminGetAllPlatformWalletsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminGetAllPlatformWalletsRequest create() => AdminGetAllPlatformWalletsRequest._();
  AdminGetAllPlatformWalletsRequest createEmptyInstance() => create();
  static $pb.PbList<AdminGetAllPlatformWalletsRequest> createRepeated() => $pb.PbList<AdminGetAllPlatformWalletsRequest>();
  @$core.pragma('dart2js:noInline')
  static AdminGetAllPlatformWalletsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdminGetAllPlatformWalletsRequest>(create);
  static AdminGetAllPlatformWalletsRequest? _defaultInstance;
}

class AdminGetAllPlatformWalletsResponse extends $pb.GeneratedMessage {
  factory AdminGetAllPlatformWalletsResponse({
    $core.Iterable<AdminPlatformWallet>? wallets,
  }) {
    final $result = create();
    if (wallets != null) {
      $result.wallets.addAll(wallets);
    }
    return $result;
  }
  AdminGetAllPlatformWalletsResponse._() : super();
  factory AdminGetAllPlatformWalletsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AdminGetAllPlatformWalletsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AdminGetAllPlatformWalletsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..pc<AdminPlatformWallet>(1, _omitFieldNames ? '' : 'wallets', $pb.PbFieldType.PM, subBuilder: AdminPlatformWallet.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AdminGetAllPlatformWalletsResponse clone() => AdminGetAllPlatformWalletsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AdminGetAllPlatformWalletsResponse copyWith(void Function(AdminGetAllPlatformWalletsResponse) updates) => super.copyWith((message) => updates(message as AdminGetAllPlatformWalletsResponse)) as AdminGetAllPlatformWalletsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminGetAllPlatformWalletsResponse create() => AdminGetAllPlatformWalletsResponse._();
  AdminGetAllPlatformWalletsResponse createEmptyInstance() => create();
  static $pb.PbList<AdminGetAllPlatformWalletsResponse> createRepeated() => $pb.PbList<AdminGetAllPlatformWalletsResponse>();
  @$core.pragma('dart2js:noInline')
  static AdminGetAllPlatformWalletsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdminGetAllPlatformWalletsResponse>(create);
  static AdminGetAllPlatformWalletsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<AdminPlatformWallet> get wallets => $_getList(0);
}

class AdminPlatformWallet extends $pb.GeneratedMessage {
  factory AdminPlatformWallet({
    $core.String? id,
    $core.String? code,
    $core.String? name,
    $fixnum.Int64? balance,
    $core.String? currency,
    $core.String? description,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (code != null) {
      $result.code = code;
    }
    if (name != null) {
      $result.name = name;
    }
    if (balance != null) {
      $result.balance = balance;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (description != null) {
      $result.description = description;
    }
    return $result;
  }
  AdminPlatformWallet._() : super();
  factory AdminPlatformWallet.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AdminPlatformWallet.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AdminPlatformWallet', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'code')
    ..aOS(3, _omitFieldNames ? '' : 'name')
    ..aInt64(4, _omitFieldNames ? '' : 'balance')
    ..aOS(5, _omitFieldNames ? '' : 'currency')
    ..aOS(6, _omitFieldNames ? '' : 'description')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AdminPlatformWallet clone() => AdminPlatformWallet()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AdminPlatformWallet copyWith(void Function(AdminPlatformWallet) updates) => super.copyWith((message) => updates(message as AdminPlatformWallet)) as AdminPlatformWallet;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminPlatformWallet create() => AdminPlatformWallet._();
  AdminPlatformWallet createEmptyInstance() => create();
  static $pb.PbList<AdminPlatformWallet> createRepeated() => $pb.PbList<AdminPlatformWallet>();
  @$core.pragma('dart2js:noInline')
  static AdminPlatformWallet getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdminPlatformWallet>(create);
  static AdminPlatformWallet? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get code => $_getSZ(1);
  @$pb.TagNumber(2)
  set code($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearCode() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(3)
  set name($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get balance => $_getI64(3);
  @$pb.TagNumber(4)
  set balance($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasBalance() => $_has(3);
  @$pb.TagNumber(4)
  void clearBalance() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get currency => $_getSZ(4);
  @$pb.TagNumber(5)
  set currency($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasCurrency() => $_has(4);
  @$pb.TagNumber(5)
  void clearCurrency() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get description => $_getSZ(5);
  @$pb.TagNumber(6)
  set description($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasDescription() => $_has(5);
  @$pb.TagNumber(6)
  void clearDescription() => clearField(6);
}

class AdminGetPlatformWalletTransactionsRequest extends $pb.GeneratedMessage {
  factory AdminGetPlatformWalletTransactionsRequest({
    $core.String? walletCode,
    $core.int? page,
    $core.int? perPage,
  }) {
    final $result = create();
    if (walletCode != null) {
      $result.walletCode = walletCode;
    }
    if (page != null) {
      $result.page = page;
    }
    if (perPage != null) {
      $result.perPage = perPage;
    }
    return $result;
  }
  AdminGetPlatformWalletTransactionsRequest._() : super();
  factory AdminGetPlatformWalletTransactionsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AdminGetPlatformWalletTransactionsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AdminGetPlatformWalletTransactionsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'walletCode')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'perPage', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AdminGetPlatformWalletTransactionsRequest clone() => AdminGetPlatformWalletTransactionsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AdminGetPlatformWalletTransactionsRequest copyWith(void Function(AdminGetPlatformWalletTransactionsRequest) updates) => super.copyWith((message) => updates(message as AdminGetPlatformWalletTransactionsRequest)) as AdminGetPlatformWalletTransactionsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminGetPlatformWalletTransactionsRequest create() => AdminGetPlatformWalletTransactionsRequest._();
  AdminGetPlatformWalletTransactionsRequest createEmptyInstance() => create();
  static $pb.PbList<AdminGetPlatformWalletTransactionsRequest> createRepeated() => $pb.PbList<AdminGetPlatformWalletTransactionsRequest>();
  @$core.pragma('dart2js:noInline')
  static AdminGetPlatformWalletTransactionsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdminGetPlatformWalletTransactionsRequest>(create);
  static AdminGetPlatformWalletTransactionsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get walletCode => $_getSZ(0);
  @$pb.TagNumber(1)
  set walletCode($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasWalletCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearWalletCode() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get page => $_getIZ(1);
  @$pb.TagNumber(2)
  set page($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPage() => $_has(1);
  @$pb.TagNumber(2)
  void clearPage() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get perPage => $_getIZ(2);
  @$pb.TagNumber(3)
  set perPage($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPerPage() => $_has(2);
  @$pb.TagNumber(3)
  void clearPerPage() => clearField(3);
}

class AdminGetPlatformWalletTransactionsResponse extends $pb.GeneratedMessage {
  factory AdminGetPlatformWalletTransactionsResponse({
    $core.Iterable<AdminTransaction>? transactions,
    $fixnum.Int64? total,
  }) {
    final $result = create();
    if (transactions != null) {
      $result.transactions.addAll(transactions);
    }
    if (total != null) {
      $result.total = total;
    }
    return $result;
  }
  AdminGetPlatformWalletTransactionsResponse._() : super();
  factory AdminGetPlatformWalletTransactionsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AdminGetPlatformWalletTransactionsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AdminGetPlatformWalletTransactionsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..pc<AdminTransaction>(1, _omitFieldNames ? '' : 'transactions', $pb.PbFieldType.PM, subBuilder: AdminTransaction.create)
    ..aInt64(2, _omitFieldNames ? '' : 'total')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AdminGetPlatformWalletTransactionsResponse clone() => AdminGetPlatformWalletTransactionsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AdminGetPlatformWalletTransactionsResponse copyWith(void Function(AdminGetPlatformWalletTransactionsResponse) updates) => super.copyWith((message) => updates(message as AdminGetPlatformWalletTransactionsResponse)) as AdminGetPlatformWalletTransactionsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminGetPlatformWalletTransactionsResponse create() => AdminGetPlatformWalletTransactionsResponse._();
  AdminGetPlatformWalletTransactionsResponse createEmptyInstance() => create();
  static $pb.PbList<AdminGetPlatformWalletTransactionsResponse> createRepeated() => $pb.PbList<AdminGetPlatformWalletTransactionsResponse>();
  @$core.pragma('dart2js:noInline')
  static AdminGetPlatformWalletTransactionsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdminGetPlatformWalletTransactionsResponse>(create);
  static AdminGetPlatformWalletTransactionsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<AdminTransaction> get transactions => $_getList(0);

  @$pb.TagNumber(2)
  $fixnum.Int64 get total => $_getI64(1);
  @$pb.TagNumber(2)
  set total($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => clearField(2);
}

class AdminGetClearingRecordsRequest extends $pb.GeneratedMessage {
  factory AdminGetClearingRecordsRequest({
    $core.String? status,
    $core.String? accountId,
    $core.int? page,
    $core.int? perPage,
  }) {
    final $result = create();
    if (status != null) {
      $result.status = status;
    }
    if (accountId != null) {
      $result.accountId = accountId;
    }
    if (page != null) {
      $result.page = page;
    }
    if (perPage != null) {
      $result.perPage = perPage;
    }
    return $result;
  }
  AdminGetClearingRecordsRequest._() : super();
  factory AdminGetClearingRecordsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AdminGetClearingRecordsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AdminGetClearingRecordsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'status')
    ..aOS(2, _omitFieldNames ? '' : 'accountId')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'perPage', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AdminGetClearingRecordsRequest clone() => AdminGetClearingRecordsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AdminGetClearingRecordsRequest copyWith(void Function(AdminGetClearingRecordsRequest) updates) => super.copyWith((message) => updates(message as AdminGetClearingRecordsRequest)) as AdminGetClearingRecordsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminGetClearingRecordsRequest create() => AdminGetClearingRecordsRequest._();
  AdminGetClearingRecordsRequest createEmptyInstance() => create();
  static $pb.PbList<AdminGetClearingRecordsRequest> createRepeated() => $pb.PbList<AdminGetClearingRecordsRequest>();
  @$core.pragma('dart2js:noInline')
  static AdminGetClearingRecordsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdminGetClearingRecordsRequest>(create);
  static AdminGetClearingRecordsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get status => $_getSZ(0);
  @$pb.TagNumber(1)
  set status($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get accountId => $_getSZ(1);
  @$pb.TagNumber(2)
  set accountId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAccountId() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccountId() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get page => $_getIZ(2);
  @$pb.TagNumber(3)
  set page($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPage() => $_has(2);
  @$pb.TagNumber(3)
  void clearPage() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get perPage => $_getIZ(3);
  @$pb.TagNumber(4)
  set perPage($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPerPage() => $_has(3);
  @$pb.TagNumber(4)
  void clearPerPage() => clearField(4);
}

class AdminGetClearingRecordsResponse extends $pb.GeneratedMessage {
  factory AdminGetClearingRecordsResponse({
    $core.Iterable<AdminClearingRecord>? records,
    $fixnum.Int64? total,
  }) {
    final $result = create();
    if (records != null) {
      $result.records.addAll(records);
    }
    if (total != null) {
      $result.total = total;
    }
    return $result;
  }
  AdminGetClearingRecordsResponse._() : super();
  factory AdminGetClearingRecordsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AdminGetClearingRecordsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AdminGetClearingRecordsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..pc<AdminClearingRecord>(1, _omitFieldNames ? '' : 'records', $pb.PbFieldType.PM, subBuilder: AdminClearingRecord.create)
    ..aInt64(2, _omitFieldNames ? '' : 'total')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AdminGetClearingRecordsResponse clone() => AdminGetClearingRecordsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AdminGetClearingRecordsResponse copyWith(void Function(AdminGetClearingRecordsResponse) updates) => super.copyWith((message) => updates(message as AdminGetClearingRecordsResponse)) as AdminGetClearingRecordsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminGetClearingRecordsResponse create() => AdminGetClearingRecordsResponse._();
  AdminGetClearingRecordsResponse createEmptyInstance() => create();
  static $pb.PbList<AdminGetClearingRecordsResponse> createRepeated() => $pb.PbList<AdminGetClearingRecordsResponse>();
  @$core.pragma('dart2js:noInline')
  static AdminGetClearingRecordsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdminGetClearingRecordsResponse>(create);
  static AdminGetClearingRecordsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<AdminClearingRecord> get records => $_getList(0);

  @$pb.TagNumber(2)
  $fixnum.Int64 get total => $_getI64(1);
  @$pb.TagNumber(2)
  set total($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => clearField(2);
}

class AdminClearingRecord extends $pb.GeneratedMessage {
  factory AdminClearingRecord({
    $core.String? id,
    $core.String? accountId,
    $core.String? userId,
    $fixnum.Int64? amount,
    $core.String? currency,
    $core.String? status,
    $core.String? clearingTier,
    $core.String? sourceReference,
    $core.String? provider,
    $core.String? providerTxId,
    $core.String? createdAt,
    $core.String? clearsAt,
    $core.String? clearedAt,
    $core.String? failureReason,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (accountId != null) {
      $result.accountId = accountId;
    }
    if (userId != null) {
      $result.userId = userId;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (status != null) {
      $result.status = status;
    }
    if (clearingTier != null) {
      $result.clearingTier = clearingTier;
    }
    if (sourceReference != null) {
      $result.sourceReference = sourceReference;
    }
    if (provider != null) {
      $result.provider = provider;
    }
    if (providerTxId != null) {
      $result.providerTxId = providerTxId;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    if (clearsAt != null) {
      $result.clearsAt = clearsAt;
    }
    if (clearedAt != null) {
      $result.clearedAt = clearedAt;
    }
    if (failureReason != null) {
      $result.failureReason = failureReason;
    }
    return $result;
  }
  AdminClearingRecord._() : super();
  factory AdminClearingRecord.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AdminClearingRecord.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AdminClearingRecord', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'accountId')
    ..aOS(3, _omitFieldNames ? '' : 'userId')
    ..aInt64(4, _omitFieldNames ? '' : 'amount')
    ..aOS(5, _omitFieldNames ? '' : 'currency')
    ..aOS(6, _omitFieldNames ? '' : 'status')
    ..aOS(7, _omitFieldNames ? '' : 'clearingTier')
    ..aOS(8, _omitFieldNames ? '' : 'sourceReference')
    ..aOS(9, _omitFieldNames ? '' : 'provider')
    ..aOS(10, _omitFieldNames ? '' : 'providerTxId')
    ..aOS(11, _omitFieldNames ? '' : 'createdAt')
    ..aOS(12, _omitFieldNames ? '' : 'clearsAt')
    ..aOS(13, _omitFieldNames ? '' : 'clearedAt')
    ..aOS(14, _omitFieldNames ? '' : 'failureReason')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AdminClearingRecord clone() => AdminClearingRecord()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AdminClearingRecord copyWith(void Function(AdminClearingRecord) updates) => super.copyWith((message) => updates(message as AdminClearingRecord)) as AdminClearingRecord;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminClearingRecord create() => AdminClearingRecord._();
  AdminClearingRecord createEmptyInstance() => create();
  static $pb.PbList<AdminClearingRecord> createRepeated() => $pb.PbList<AdminClearingRecord>();
  @$core.pragma('dart2js:noInline')
  static AdminClearingRecord getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdminClearingRecord>(create);
  static AdminClearingRecord? _defaultInstance;

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
  $fixnum.Int64 get amount => $_getI64(3);
  @$pb.TagNumber(4)
  set amount($fixnum.Int64 v) { $_setInt64(3, v); }
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
  $core.String get status => $_getSZ(5);
  @$pb.TagNumber(6)
  set status($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasStatus() => $_has(5);
  @$pb.TagNumber(6)
  void clearStatus() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get clearingTier => $_getSZ(6);
  @$pb.TagNumber(7)
  set clearingTier($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasClearingTier() => $_has(6);
  @$pb.TagNumber(7)
  void clearClearingTier() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get sourceReference => $_getSZ(7);
  @$pb.TagNumber(8)
  set sourceReference($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasSourceReference() => $_has(7);
  @$pb.TagNumber(8)
  void clearSourceReference() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get provider => $_getSZ(8);
  @$pb.TagNumber(9)
  set provider($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasProvider() => $_has(8);
  @$pb.TagNumber(9)
  void clearProvider() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get providerTxId => $_getSZ(9);
  @$pb.TagNumber(10)
  set providerTxId($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasProviderTxId() => $_has(9);
  @$pb.TagNumber(10)
  void clearProviderTxId() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get createdAt => $_getSZ(10);
  @$pb.TagNumber(11)
  set createdAt($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasCreatedAt() => $_has(10);
  @$pb.TagNumber(11)
  void clearCreatedAt() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get clearsAt => $_getSZ(11);
  @$pb.TagNumber(12)
  set clearsAt($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasClearsAt() => $_has(11);
  @$pb.TagNumber(12)
  void clearClearsAt() => clearField(12);

  @$pb.TagNumber(13)
  $core.String get clearedAt => $_getSZ(12);
  @$pb.TagNumber(13)
  set clearedAt($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasClearedAt() => $_has(12);
  @$pb.TagNumber(13)
  void clearClearedAt() => clearField(13);

  @$pb.TagNumber(14)
  $core.String get failureReason => $_getSZ(13);
  @$pb.TagNumber(14)
  set failureReason($core.String v) { $_setString(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasFailureReason() => $_has(13);
  @$pb.TagNumber(14)
  void clearFailureReason() => clearField(14);
}

class AdminGetClearingHealthRequest extends $pb.GeneratedMessage {
  factory AdminGetClearingHealthRequest() => create();
  AdminGetClearingHealthRequest._() : super();
  factory AdminGetClearingHealthRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AdminGetClearingHealthRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AdminGetClearingHealthRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AdminGetClearingHealthRequest clone() => AdminGetClearingHealthRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AdminGetClearingHealthRequest copyWith(void Function(AdminGetClearingHealthRequest) updates) => super.copyWith((message) => updates(message as AdminGetClearingHealthRequest)) as AdminGetClearingHealthRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminGetClearingHealthRequest create() => AdminGetClearingHealthRequest._();
  AdminGetClearingHealthRequest createEmptyInstance() => create();
  static $pb.PbList<AdminGetClearingHealthRequest> createRepeated() => $pb.PbList<AdminGetClearingHealthRequest>();
  @$core.pragma('dart2js:noInline')
  static AdminGetClearingHealthRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdminGetClearingHealthRequest>(create);
  static AdminGetClearingHealthRequest? _defaultInstance;
}

class AdminGetClearingHealthResponse extends $pb.GeneratedMessage {
  factory AdminGetClearingHealthResponse({
    $core.int? pendingCount,
    $core.int? clearedToday,
    $core.int? reversedToday,
    $core.int? failedToday,
    $core.int? stuckCount,
    $core.double? avgClearSeconds,
  }) {
    final $result = create();
    if (pendingCount != null) {
      $result.pendingCount = pendingCount;
    }
    if (clearedToday != null) {
      $result.clearedToday = clearedToday;
    }
    if (reversedToday != null) {
      $result.reversedToday = reversedToday;
    }
    if (failedToday != null) {
      $result.failedToday = failedToday;
    }
    if (stuckCount != null) {
      $result.stuckCount = stuckCount;
    }
    if (avgClearSeconds != null) {
      $result.avgClearSeconds = avgClearSeconds;
    }
    return $result;
  }
  AdminGetClearingHealthResponse._() : super();
  factory AdminGetClearingHealthResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AdminGetClearingHealthResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AdminGetClearingHealthResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'pendingCount', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'clearedToday', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'reversedToday', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'failedToday', $pb.PbFieldType.O3)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'stuckCount', $pb.PbFieldType.O3)
    ..a<$core.double>(6, _omitFieldNames ? '' : 'avgClearSeconds', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AdminGetClearingHealthResponse clone() => AdminGetClearingHealthResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AdminGetClearingHealthResponse copyWith(void Function(AdminGetClearingHealthResponse) updates) => super.copyWith((message) => updates(message as AdminGetClearingHealthResponse)) as AdminGetClearingHealthResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminGetClearingHealthResponse create() => AdminGetClearingHealthResponse._();
  AdminGetClearingHealthResponse createEmptyInstance() => create();
  static $pb.PbList<AdminGetClearingHealthResponse> createRepeated() => $pb.PbList<AdminGetClearingHealthResponse>();
  @$core.pragma('dart2js:noInline')
  static AdminGetClearingHealthResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdminGetClearingHealthResponse>(create);
  static AdminGetClearingHealthResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get pendingCount => $_getIZ(0);
  @$pb.TagNumber(1)
  set pendingCount($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPendingCount() => $_has(0);
  @$pb.TagNumber(1)
  void clearPendingCount() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get clearedToday => $_getIZ(1);
  @$pb.TagNumber(2)
  set clearedToday($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasClearedToday() => $_has(1);
  @$pb.TagNumber(2)
  void clearClearedToday() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get reversedToday => $_getIZ(2);
  @$pb.TagNumber(3)
  set reversedToday($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasReversedToday() => $_has(2);
  @$pb.TagNumber(3)
  void clearReversedToday() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get failedToday => $_getIZ(3);
  @$pb.TagNumber(4)
  set failedToday($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasFailedToday() => $_has(3);
  @$pb.TagNumber(4)
  void clearFailedToday() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get stuckCount => $_getIZ(4);
  @$pb.TagNumber(5)
  set stuckCount($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasStuckCount() => $_has(4);
  @$pb.TagNumber(5)
  void clearStuckCount() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get avgClearSeconds => $_getN(5);
  @$pb.TagNumber(6)
  set avgClearSeconds($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasAvgClearSeconds() => $_has(5);
  @$pb.TagNumber(6)
  void clearAvgClearSeconds() => clearField(6);
}

class AdminFreezeAccountRequest extends $pb.GeneratedMessage {
  factory AdminFreezeAccountRequest({
    $core.String? accountId,
    $core.String? reason,
    $core.String? adminUserId,
  }) {
    final $result = create();
    if (accountId != null) {
      $result.accountId = accountId;
    }
    if (reason != null) {
      $result.reason = reason;
    }
    if (adminUserId != null) {
      $result.adminUserId = adminUserId;
    }
    return $result;
  }
  AdminFreezeAccountRequest._() : super();
  factory AdminFreezeAccountRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AdminFreezeAccountRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AdminFreezeAccountRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountId')
    ..aOS(2, _omitFieldNames ? '' : 'reason')
    ..aOS(3, _omitFieldNames ? '' : 'adminUserId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AdminFreezeAccountRequest clone() => AdminFreezeAccountRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AdminFreezeAccountRequest copyWith(void Function(AdminFreezeAccountRequest) updates) => super.copyWith((message) => updates(message as AdminFreezeAccountRequest)) as AdminFreezeAccountRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminFreezeAccountRequest create() => AdminFreezeAccountRequest._();
  AdminFreezeAccountRequest createEmptyInstance() => create();
  static $pb.PbList<AdminFreezeAccountRequest> createRepeated() => $pb.PbList<AdminFreezeAccountRequest>();
  @$core.pragma('dart2js:noInline')
  static AdminFreezeAccountRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdminFreezeAccountRequest>(create);
  static AdminFreezeAccountRequest? _defaultInstance;

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
  $core.String get adminUserId => $_getSZ(2);
  @$pb.TagNumber(3)
  set adminUserId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAdminUserId() => $_has(2);
  @$pb.TagNumber(3)
  void clearAdminUserId() => clearField(3);
}

class AdminFreezeAccountResponse extends $pb.GeneratedMessage {
  factory AdminFreezeAccountResponse({
    $core.bool? success,
    $core.String? message,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  AdminFreezeAccountResponse._() : super();
  factory AdminFreezeAccountResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AdminFreezeAccountResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AdminFreezeAccountResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AdminFreezeAccountResponse clone() => AdminFreezeAccountResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AdminFreezeAccountResponse copyWith(void Function(AdminFreezeAccountResponse) updates) => super.copyWith((message) => updates(message as AdminFreezeAccountResponse)) as AdminFreezeAccountResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminFreezeAccountResponse create() => AdminFreezeAccountResponse._();
  AdminFreezeAccountResponse createEmptyInstance() => create();
  static $pb.PbList<AdminFreezeAccountResponse> createRepeated() => $pb.PbList<AdminFreezeAccountResponse>();
  @$core.pragma('dart2js:noInline')
  static AdminFreezeAccountResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdminFreezeAccountResponse>(create);
  static AdminFreezeAccountResponse? _defaultInstance;

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

class AdminUnfreezeAccountRequest extends $pb.GeneratedMessage {
  factory AdminUnfreezeAccountRequest({
    $core.String? accountId,
    $core.String? reason,
    $core.String? adminUserId,
  }) {
    final $result = create();
    if (accountId != null) {
      $result.accountId = accountId;
    }
    if (reason != null) {
      $result.reason = reason;
    }
    if (adminUserId != null) {
      $result.adminUserId = adminUserId;
    }
    return $result;
  }
  AdminUnfreezeAccountRequest._() : super();
  factory AdminUnfreezeAccountRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AdminUnfreezeAccountRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AdminUnfreezeAccountRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountId')
    ..aOS(2, _omitFieldNames ? '' : 'reason')
    ..aOS(3, _omitFieldNames ? '' : 'adminUserId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AdminUnfreezeAccountRequest clone() => AdminUnfreezeAccountRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AdminUnfreezeAccountRequest copyWith(void Function(AdminUnfreezeAccountRequest) updates) => super.copyWith((message) => updates(message as AdminUnfreezeAccountRequest)) as AdminUnfreezeAccountRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminUnfreezeAccountRequest create() => AdminUnfreezeAccountRequest._();
  AdminUnfreezeAccountRequest createEmptyInstance() => create();
  static $pb.PbList<AdminUnfreezeAccountRequest> createRepeated() => $pb.PbList<AdminUnfreezeAccountRequest>();
  @$core.pragma('dart2js:noInline')
  static AdminUnfreezeAccountRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdminUnfreezeAccountRequest>(create);
  static AdminUnfreezeAccountRequest? _defaultInstance;

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
  $core.String get adminUserId => $_getSZ(2);
  @$pb.TagNumber(3)
  set adminUserId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAdminUserId() => $_has(2);
  @$pb.TagNumber(3)
  void clearAdminUserId() => clearField(3);
}

class AdminUnfreezeAccountResponse extends $pb.GeneratedMessage {
  factory AdminUnfreezeAccountResponse({
    $core.bool? success,
    $core.String? message,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  AdminUnfreezeAccountResponse._() : super();
  factory AdminUnfreezeAccountResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AdminUnfreezeAccountResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AdminUnfreezeAccountResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AdminUnfreezeAccountResponse clone() => AdminUnfreezeAccountResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AdminUnfreezeAccountResponse copyWith(void Function(AdminUnfreezeAccountResponse) updates) => super.copyWith((message) => updates(message as AdminUnfreezeAccountResponse)) as AdminUnfreezeAccountResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminUnfreezeAccountResponse create() => AdminUnfreezeAccountResponse._();
  AdminUnfreezeAccountResponse createEmptyInstance() => create();
  static $pb.PbList<AdminUnfreezeAccountResponse> createRepeated() => $pb.PbList<AdminUnfreezeAccountResponse>();
  @$core.pragma('dart2js:noInline')
  static AdminUnfreezeAccountResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdminUnfreezeAccountResponse>(create);
  static AdminUnfreezeAccountResponse? _defaultInstance;

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


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
