// This is a generated file - do not edit.
//
// Generated from lock_funds.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/timestamp.pb.dart' as $1;
import 'lock_funds.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'lock_funds.pbenum.dart';

/// Lock fund message
class LockFund extends $pb.GeneratedMessage {
  factory LockFund({
    $core.String? id,
    $fixnum.Int64? userId,
    LockType? lockType,
    $core.double? amount,
    $core.String? currency,
    $core.int? lockDurationDays,
    $core.double? interestRate,
    $1.Timestamp? lockedAt,
    $1.Timestamp? unlockAt,
    LockStatus? status,
    $core.bool? autoRenew,
    $core.String? goalName,
    $core.String? goalDescription,
    $core.double? earlyUnlockPenaltyPercent,
    $core.double? accruedInterest,
    $core.String? paymentMethod,
    $core.String? transactionId,
    $1.Timestamp? createdAt,
    $1.Timestamp? updatedAt,
    $core.int? daysRemaining,
    $core.double? progressPercent,
    $core.double? totalValue,
    $core.bool? canUnlockEarly,
    $core.String? sourceAccountId,
    $core.String? destinationAccountId,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (userId != null) result.userId = userId;
    if (lockType != null) result.lockType = lockType;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    if (lockDurationDays != null) result.lockDurationDays = lockDurationDays;
    if (interestRate != null) result.interestRate = interestRate;
    if (lockedAt != null) result.lockedAt = lockedAt;
    if (unlockAt != null) result.unlockAt = unlockAt;
    if (status != null) result.status = status;
    if (autoRenew != null) result.autoRenew = autoRenew;
    if (goalName != null) result.goalName = goalName;
    if (goalDescription != null) result.goalDescription = goalDescription;
    if (earlyUnlockPenaltyPercent != null)
      result.earlyUnlockPenaltyPercent = earlyUnlockPenaltyPercent;
    if (accruedInterest != null) result.accruedInterest = accruedInterest;
    if (paymentMethod != null) result.paymentMethod = paymentMethod;
    if (transactionId != null) result.transactionId = transactionId;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    if (daysRemaining != null) result.daysRemaining = daysRemaining;
    if (progressPercent != null) result.progressPercent = progressPercent;
    if (totalValue != null) result.totalValue = totalValue;
    if (canUnlockEarly != null) result.canUnlockEarly = canUnlockEarly;
    if (sourceAccountId != null) result.sourceAccountId = sourceAccountId;
    if (destinationAccountId != null)
      result.destinationAccountId = destinationAccountId;
    return result;
  }

  LockFund._();

  factory LockFund.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory LockFund.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LockFund',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'userId', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..e<LockType>(3, _omitFieldNames ? '' : 'lockType', $pb.PbFieldType.OE,
        defaultOrMaker: LockType.LOCK_TYPE_UNSPECIFIED,
        valueOf: LockType.valueOf,
        enumValues: LockType.values)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(5, _omitFieldNames ? '' : 'currency')
    ..a<$core.int>(
        6, _omitFieldNames ? '' : 'lockDurationDays', $pb.PbFieldType.O3)
    ..a<$core.double>(
        7, _omitFieldNames ? '' : 'interestRate', $pb.PbFieldType.OD)
    ..aOM<$1.Timestamp>(8, _omitFieldNames ? '' : 'lockedAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(9, _omitFieldNames ? '' : 'unlockAt',
        subBuilder: $1.Timestamp.create)
    ..e<LockStatus>(10, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: LockStatus.LOCK_STATUS_UNSPECIFIED,
        valueOf: LockStatus.valueOf,
        enumValues: LockStatus.values)
    ..aOB(11, _omitFieldNames ? '' : 'autoRenew')
    ..aOS(12, _omitFieldNames ? '' : 'goalName')
    ..aOS(13, _omitFieldNames ? '' : 'goalDescription')
    ..a<$core.double>(14, _omitFieldNames ? '' : 'earlyUnlockPenaltyPercent',
        $pb.PbFieldType.OD)
    ..a<$core.double>(
        15, _omitFieldNames ? '' : 'accruedInterest', $pb.PbFieldType.OD)
    ..aOS(16, _omitFieldNames ? '' : 'paymentMethod')
    ..aOS(17, _omitFieldNames ? '' : 'transactionId')
    ..aOM<$1.Timestamp>(18, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(19, _omitFieldNames ? '' : 'updatedAt',
        subBuilder: $1.Timestamp.create)
    ..a<$core.int>(
        20, _omitFieldNames ? '' : 'daysRemaining', $pb.PbFieldType.O3)
    ..a<$core.double>(
        21, _omitFieldNames ? '' : 'progressPercent', $pb.PbFieldType.OD)
    ..a<$core.double>(
        22, _omitFieldNames ? '' : 'totalValue', $pb.PbFieldType.OD)
    ..aOB(23, _omitFieldNames ? '' : 'canUnlockEarly')
    ..aOS(24, _omitFieldNames ? '' : 'sourceAccountId')
    ..aOS(25, _omitFieldNames ? '' : 'destinationAccountId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LockFund clone() => LockFund()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LockFund copyWith(void Function(LockFund) updates) =>
      super.copyWith((message) => updates(message as LockFund)) as LockFund;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LockFund create() => LockFund._();
  @$core.override
  LockFund createEmptyInstance() => create();
  static $pb.PbList<LockFund> createRepeated() => $pb.PbList<LockFund>();
  @$core.pragma('dart2js:noInline')
  static LockFund getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LockFund>(create);
  static LockFund? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get userId => $_getI64(1);
  @$pb.TagNumber(2)
  set userId($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => $_clearField(2);

  @$pb.TagNumber(3)
  LockType get lockType => $_getN(2);
  @$pb.TagNumber(3)
  set lockType(LockType value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasLockType() => $_has(2);
  @$pb.TagNumber(3)
  void clearLockType() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get amount => $_getN(3);
  @$pb.TagNumber(4)
  set amount($core.double value) => $_setDouble(3, value);
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
  $core.int get lockDurationDays => $_getIZ(5);
  @$pb.TagNumber(6)
  set lockDurationDays($core.int value) => $_setSignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasLockDurationDays() => $_has(5);
  @$pb.TagNumber(6)
  void clearLockDurationDays() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.double get interestRate => $_getN(6);
  @$pb.TagNumber(7)
  set interestRate($core.double value) => $_setDouble(6, value);
  @$pb.TagNumber(7)
  $core.bool hasInterestRate() => $_has(6);
  @$pb.TagNumber(7)
  void clearInterestRate() => $_clearField(7);

  @$pb.TagNumber(8)
  $1.Timestamp get lockedAt => $_getN(7);
  @$pb.TagNumber(8)
  set lockedAt($1.Timestamp value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasLockedAt() => $_has(7);
  @$pb.TagNumber(8)
  void clearLockedAt() => $_clearField(8);
  @$pb.TagNumber(8)
  $1.Timestamp ensureLockedAt() => $_ensure(7);

  @$pb.TagNumber(9)
  $1.Timestamp get unlockAt => $_getN(8);
  @$pb.TagNumber(9)
  set unlockAt($1.Timestamp value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasUnlockAt() => $_has(8);
  @$pb.TagNumber(9)
  void clearUnlockAt() => $_clearField(9);
  @$pb.TagNumber(9)
  $1.Timestamp ensureUnlockAt() => $_ensure(8);

  @$pb.TagNumber(10)
  LockStatus get status => $_getN(9);
  @$pb.TagNumber(10)
  set status(LockStatus value) => $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasStatus() => $_has(9);
  @$pb.TagNumber(10)
  void clearStatus() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.bool get autoRenew => $_getBF(10);
  @$pb.TagNumber(11)
  set autoRenew($core.bool value) => $_setBool(10, value);
  @$pb.TagNumber(11)
  $core.bool hasAutoRenew() => $_has(10);
  @$pb.TagNumber(11)
  void clearAutoRenew() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get goalName => $_getSZ(11);
  @$pb.TagNumber(12)
  set goalName($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasGoalName() => $_has(11);
  @$pb.TagNumber(12)
  void clearGoalName() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.String get goalDescription => $_getSZ(12);
  @$pb.TagNumber(13)
  set goalDescription($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasGoalDescription() => $_has(12);
  @$pb.TagNumber(13)
  void clearGoalDescription() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.double get earlyUnlockPenaltyPercent => $_getN(13);
  @$pb.TagNumber(14)
  set earlyUnlockPenaltyPercent($core.double value) => $_setDouble(13, value);
  @$pb.TagNumber(14)
  $core.bool hasEarlyUnlockPenaltyPercent() => $_has(13);
  @$pb.TagNumber(14)
  void clearEarlyUnlockPenaltyPercent() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.double get accruedInterest => $_getN(14);
  @$pb.TagNumber(15)
  set accruedInterest($core.double value) => $_setDouble(14, value);
  @$pb.TagNumber(15)
  $core.bool hasAccruedInterest() => $_has(14);
  @$pb.TagNumber(15)
  void clearAccruedInterest() => $_clearField(15);

  @$pb.TagNumber(16)
  $core.String get paymentMethod => $_getSZ(15);
  @$pb.TagNumber(16)
  set paymentMethod($core.String value) => $_setString(15, value);
  @$pb.TagNumber(16)
  $core.bool hasPaymentMethod() => $_has(15);
  @$pb.TagNumber(16)
  void clearPaymentMethod() => $_clearField(16);

  @$pb.TagNumber(17)
  $core.String get transactionId => $_getSZ(16);
  @$pb.TagNumber(17)
  set transactionId($core.String value) => $_setString(16, value);
  @$pb.TagNumber(17)
  $core.bool hasTransactionId() => $_has(16);
  @$pb.TagNumber(17)
  void clearTransactionId() => $_clearField(17);

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
  $1.Timestamp get updatedAt => $_getN(18);
  @$pb.TagNumber(19)
  set updatedAt($1.Timestamp value) => $_setField(19, value);
  @$pb.TagNumber(19)
  $core.bool hasUpdatedAt() => $_has(18);
  @$pb.TagNumber(19)
  void clearUpdatedAt() => $_clearField(19);
  @$pb.TagNumber(19)
  $1.Timestamp ensureUpdatedAt() => $_ensure(18);

  /// Computed fields
  @$pb.TagNumber(20)
  $core.int get daysRemaining => $_getIZ(19);
  @$pb.TagNumber(20)
  set daysRemaining($core.int value) => $_setSignedInt32(19, value);
  @$pb.TagNumber(20)
  $core.bool hasDaysRemaining() => $_has(19);
  @$pb.TagNumber(20)
  void clearDaysRemaining() => $_clearField(20);

  @$pb.TagNumber(21)
  $core.double get progressPercent => $_getN(20);
  @$pb.TagNumber(21)
  set progressPercent($core.double value) => $_setDouble(20, value);
  @$pb.TagNumber(21)
  $core.bool hasProgressPercent() => $_has(20);
  @$pb.TagNumber(21)
  void clearProgressPercent() => $_clearField(21);

  @$pb.TagNumber(22)
  $core.double get totalValue => $_getN(21);
  @$pb.TagNumber(22)
  set totalValue($core.double value) => $_setDouble(21, value);
  @$pb.TagNumber(22)
  $core.bool hasTotalValue() => $_has(21);
  @$pb.TagNumber(22)
  void clearTotalValue() => $_clearField(22);

  @$pb.TagNumber(23)
  $core.bool get canUnlockEarly => $_getBF(22);
  @$pb.TagNumber(23)
  set canUnlockEarly($core.bool value) => $_setBool(22, value);
  @$pb.TagNumber(23)
  $core.bool hasCanUnlockEarly() => $_has(22);
  @$pb.TagNumber(23)
  void clearCanUnlockEarly() => $_clearField(23);

  /// Account tracking
  @$pb.TagNumber(24)
  $core.String get sourceAccountId => $_getSZ(23);
  @$pb.TagNumber(24)
  set sourceAccountId($core.String value) => $_setString(23, value);
  @$pb.TagNumber(24)
  $core.bool hasSourceAccountId() => $_has(23);
  @$pb.TagNumber(24)
  void clearSourceAccountId() => $_clearField(24);

  @$pb.TagNumber(25)
  $core.String get destinationAccountId => $_getSZ(24);
  @$pb.TagNumber(25)
  set destinationAccountId($core.String value) => $_setString(24, value);
  @$pb.TagNumber(25)
  $core.bool hasDestinationAccountId() => $_has(24);
  @$pb.TagNumber(25)
  void clearDestinationAccountId() => $_clearField(25);
}

/// Lock transaction message
class LockTransaction extends $pb.GeneratedMessage {
  factory LockTransaction({
    $core.String? id,
    $core.String? lockFundId,
    $fixnum.Int64? userId,
    $core.String? transactionType,
    $core.double? amount,
    $core.String? currency,
    $core.String? paymentMethod,
    $core.String? status,
    $1.Timestamp? transactionDate,
    $core.String? description,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (lockFundId != null) result.lockFundId = lockFundId;
    if (userId != null) result.userId = userId;
    if (transactionType != null) result.transactionType = transactionType;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    if (paymentMethod != null) result.paymentMethod = paymentMethod;
    if (status != null) result.status = status;
    if (transactionDate != null) result.transactionDate = transactionDate;
    if (description != null) result.description = description;
    return result;
  }

  LockTransaction._();

  factory LockTransaction.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory LockTransaction.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LockTransaction',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'lockFundId')
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'userId', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(4, _omitFieldNames ? '' : 'transactionType')
    ..a<$core.double>(5, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(6, _omitFieldNames ? '' : 'currency')
    ..aOS(7, _omitFieldNames ? '' : 'paymentMethod')
    ..aOS(8, _omitFieldNames ? '' : 'status')
    ..aOM<$1.Timestamp>(9, _omitFieldNames ? '' : 'transactionDate',
        subBuilder: $1.Timestamp.create)
    ..aOS(10, _omitFieldNames ? '' : 'description')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LockTransaction clone() => LockTransaction()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LockTransaction copyWith(void Function(LockTransaction) updates) =>
      super.copyWith((message) => updates(message as LockTransaction))
          as LockTransaction;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LockTransaction create() => LockTransaction._();
  @$core.override
  LockTransaction createEmptyInstance() => create();
  static $pb.PbList<LockTransaction> createRepeated() =>
      $pb.PbList<LockTransaction>();
  @$core.pragma('dart2js:noInline')
  static LockTransaction getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LockTransaction>(create);
  static LockTransaction? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get lockFundId => $_getSZ(1);
  @$pb.TagNumber(2)
  set lockFundId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLockFundId() => $_has(1);
  @$pb.TagNumber(2)
  void clearLockFundId() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get userId => $_getI64(2);
  @$pb.TagNumber(3)
  set userId($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasUserId() => $_has(2);
  @$pb.TagNumber(3)
  void clearUserId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get transactionType => $_getSZ(3);
  @$pb.TagNumber(4)
  set transactionType($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTransactionType() => $_has(3);
  @$pb.TagNumber(4)
  void clearTransactionType() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get amount => $_getN(4);
  @$pb.TagNumber(5)
  set amount($core.double value) => $_setDouble(4, value);
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
  $core.String get paymentMethod => $_getSZ(6);
  @$pb.TagNumber(7)
  set paymentMethod($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasPaymentMethod() => $_has(6);
  @$pb.TagNumber(7)
  void clearPaymentMethod() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get status => $_getSZ(7);
  @$pb.TagNumber(8)
  set status($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasStatus() => $_has(7);
  @$pb.TagNumber(8)
  void clearStatus() => $_clearField(8);

  @$pb.TagNumber(9)
  $1.Timestamp get transactionDate => $_getN(8);
  @$pb.TagNumber(9)
  set transactionDate($1.Timestamp value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasTransactionDate() => $_has(8);
  @$pb.TagNumber(9)
  void clearTransactionDate() => $_clearField(9);
  @$pb.TagNumber(9)
  $1.Timestamp ensureTransactionDate() => $_ensure(8);

  @$pb.TagNumber(10)
  $core.String get description => $_getSZ(9);
  @$pb.TagNumber(10)
  set description($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasDescription() => $_has(9);
  @$pb.TagNumber(10)
  void clearDescription() => $_clearField(10);
}

/// === PiggyVault Config (backend-configurable rates) ===
class PiggyVaultConfig extends $pb.GeneratedMessage {
  factory PiggyVaultConfig({
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
    final result = create();
    if (id != null) result.id = id;
    if (lockType != null) result.lockType = lockType;
    if (currency != null) result.currency = currency;
    if (displayName != null) result.displayName = displayName;
    if (baseInterestRate != null) result.baseInterestRate = baseInterestRate;
    if (maxInterestRate != null) result.maxInterestRate = maxInterestRate;
    if (earlyWithdrawalPenalty != null)
      result.earlyWithdrawalPenalty = earlyWithdrawalPenalty;
    if (minDurationDays != null) result.minDurationDays = minDurationDays;
    if (maxDurationDays != null) result.maxDurationDays = maxDurationDays;
    if (minAmount != null) result.minAmount = minAmount;
    if (maxAmount != null) result.maxAmount = maxAmount;
    if (allowsEarlyWithdrawal != null)
      result.allowsEarlyWithdrawal = allowsEarlyWithdrawal;
    if (supportsAutoRenew != null) result.supportsAutoRenew = supportsAutoRenew;
    if (supportsTopUp != null) result.supportsTopUp = supportsTopUp;
    if (supportsAutoSave != null) result.supportsAutoSave = supportsAutoSave;
    if (supportsUpfrontInterest != null)
      result.supportsUpfrontInterest = supportsUpfrontInterest;
    if (durationBonusTiers != null)
      result.durationBonusTiers = durationBonusTiers;
    if (isActive != null) result.isActive = isActive;
    if (description != null) result.description = description;
    return result;
  }

  PiggyVaultConfig._();

  factory PiggyVaultConfig.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PiggyVaultConfig.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PiggyVaultConfig',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'lockType')
    ..aOS(3, _omitFieldNames ? '' : 'currency')
    ..aOS(4, _omitFieldNames ? '' : 'displayName')
    ..a<$core.double>(
        5, _omitFieldNames ? '' : 'baseInterestRate', $pb.PbFieldType.OD)
    ..a<$core.double>(
        6, _omitFieldNames ? '' : 'maxInterestRate', $pb.PbFieldType.OD)
    ..a<$core.double>(
        7, _omitFieldNames ? '' : 'earlyWithdrawalPenalty', $pb.PbFieldType.OD)
    ..a<$core.int>(
        8, _omitFieldNames ? '' : 'minDurationDays', $pb.PbFieldType.O3)
    ..a<$core.int>(
        9, _omitFieldNames ? '' : 'maxDurationDays', $pb.PbFieldType.O3)
    ..a<$core.double>(
        10, _omitFieldNames ? '' : 'minAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(
        11, _omitFieldNames ? '' : 'maxAmount', $pb.PbFieldType.OD)
    ..aOB(12, _omitFieldNames ? '' : 'allowsEarlyWithdrawal')
    ..aOB(13, _omitFieldNames ? '' : 'supportsAutoRenew')
    ..aOB(14, _omitFieldNames ? '' : 'supportsTopUp')
    ..aOB(15, _omitFieldNames ? '' : 'supportsAutoSave')
    ..aOB(16, _omitFieldNames ? '' : 'supportsUpfrontInterest')
    ..aOS(17, _omitFieldNames ? '' : 'durationBonusTiers')
    ..aOB(18, _omitFieldNames ? '' : 'isActive')
    ..aOS(19, _omitFieldNames ? '' : 'description')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PiggyVaultConfig clone() => PiggyVaultConfig()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PiggyVaultConfig copyWith(void Function(PiggyVaultConfig) updates) =>
      super.copyWith((message) => updates(message as PiggyVaultConfig))
          as PiggyVaultConfig;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PiggyVaultConfig create() => PiggyVaultConfig._();
  @$core.override
  PiggyVaultConfig createEmptyInstance() => create();
  static $pb.PbList<PiggyVaultConfig> createRepeated() =>
      $pb.PbList<PiggyVaultConfig>();
  @$core.pragma('dart2js:noInline')
  static PiggyVaultConfig getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PiggyVaultConfig>(create);
  static PiggyVaultConfig? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get lockType => $_getSZ(1);
  @$pb.TagNumber(2)
  set lockType($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLockType() => $_has(1);
  @$pb.TagNumber(2)
  void clearLockType() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get currency => $_getSZ(2);
  @$pb.TagNumber(3)
  set currency($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCurrency() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrency() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get displayName => $_getSZ(3);
  @$pb.TagNumber(4)
  set displayName($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDisplayName() => $_has(3);
  @$pb.TagNumber(4)
  void clearDisplayName() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get baseInterestRate => $_getN(4);
  @$pb.TagNumber(5)
  set baseInterestRate($core.double value) => $_setDouble(4, value);
  @$pb.TagNumber(5)
  $core.bool hasBaseInterestRate() => $_has(4);
  @$pb.TagNumber(5)
  void clearBaseInterestRate() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.double get maxInterestRate => $_getN(5);
  @$pb.TagNumber(6)
  set maxInterestRate($core.double value) => $_setDouble(5, value);
  @$pb.TagNumber(6)
  $core.bool hasMaxInterestRate() => $_has(5);
  @$pb.TagNumber(6)
  void clearMaxInterestRate() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.double get earlyWithdrawalPenalty => $_getN(6);
  @$pb.TagNumber(7)
  set earlyWithdrawalPenalty($core.double value) => $_setDouble(6, value);
  @$pb.TagNumber(7)
  $core.bool hasEarlyWithdrawalPenalty() => $_has(6);
  @$pb.TagNumber(7)
  void clearEarlyWithdrawalPenalty() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.int get minDurationDays => $_getIZ(7);
  @$pb.TagNumber(8)
  set minDurationDays($core.int value) => $_setSignedInt32(7, value);
  @$pb.TagNumber(8)
  $core.bool hasMinDurationDays() => $_has(7);
  @$pb.TagNumber(8)
  void clearMinDurationDays() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.int get maxDurationDays => $_getIZ(8);
  @$pb.TagNumber(9)
  set maxDurationDays($core.int value) => $_setSignedInt32(8, value);
  @$pb.TagNumber(9)
  $core.bool hasMaxDurationDays() => $_has(8);
  @$pb.TagNumber(9)
  void clearMaxDurationDays() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.double get minAmount => $_getN(9);
  @$pb.TagNumber(10)
  set minAmount($core.double value) => $_setDouble(9, value);
  @$pb.TagNumber(10)
  $core.bool hasMinAmount() => $_has(9);
  @$pb.TagNumber(10)
  void clearMinAmount() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.double get maxAmount => $_getN(10);
  @$pb.TagNumber(11)
  set maxAmount($core.double value) => $_setDouble(10, value);
  @$pb.TagNumber(11)
  $core.bool hasMaxAmount() => $_has(10);
  @$pb.TagNumber(11)
  void clearMaxAmount() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.bool get allowsEarlyWithdrawal => $_getBF(11);
  @$pb.TagNumber(12)
  set allowsEarlyWithdrawal($core.bool value) => $_setBool(11, value);
  @$pb.TagNumber(12)
  $core.bool hasAllowsEarlyWithdrawal() => $_has(11);
  @$pb.TagNumber(12)
  void clearAllowsEarlyWithdrawal() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.bool get supportsAutoRenew => $_getBF(12);
  @$pb.TagNumber(13)
  set supportsAutoRenew($core.bool value) => $_setBool(12, value);
  @$pb.TagNumber(13)
  $core.bool hasSupportsAutoRenew() => $_has(12);
  @$pb.TagNumber(13)
  void clearSupportsAutoRenew() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.bool get supportsTopUp => $_getBF(13);
  @$pb.TagNumber(14)
  set supportsTopUp($core.bool value) => $_setBool(13, value);
  @$pb.TagNumber(14)
  $core.bool hasSupportsTopUp() => $_has(13);
  @$pb.TagNumber(14)
  void clearSupportsTopUp() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.bool get supportsAutoSave => $_getBF(14);
  @$pb.TagNumber(15)
  set supportsAutoSave($core.bool value) => $_setBool(14, value);
  @$pb.TagNumber(15)
  $core.bool hasSupportsAutoSave() => $_has(14);
  @$pb.TagNumber(15)
  void clearSupportsAutoSave() => $_clearField(15);

  @$pb.TagNumber(16)
  $core.bool get supportsUpfrontInterest => $_getBF(15);
  @$pb.TagNumber(16)
  set supportsUpfrontInterest($core.bool value) => $_setBool(15, value);
  @$pb.TagNumber(16)
  $core.bool hasSupportsUpfrontInterest() => $_has(15);
  @$pb.TagNumber(16)
  void clearSupportsUpfrontInterest() => $_clearField(16);

  @$pb.TagNumber(17)
  $core.String get durationBonusTiers => $_getSZ(16);
  @$pb.TagNumber(17)
  set durationBonusTiers($core.String value) => $_setString(16, value);
  @$pb.TagNumber(17)
  $core.bool hasDurationBonusTiers() => $_has(16);
  @$pb.TagNumber(17)
  void clearDurationBonusTiers() => $_clearField(17);

  @$pb.TagNumber(18)
  $core.bool get isActive => $_getBF(17);
  @$pb.TagNumber(18)
  set isActive($core.bool value) => $_setBool(17, value);
  @$pb.TagNumber(18)
  $core.bool hasIsActive() => $_has(17);
  @$pb.TagNumber(18)
  void clearIsActive() => $_clearField(18);

  @$pb.TagNumber(19)
  $core.String get description => $_getSZ(18);
  @$pb.TagNumber(19)
  set description($core.String value) => $_setString(18, value);
  @$pb.TagNumber(19)
  $core.bool hasDescription() => $_has(18);
  @$pb.TagNumber(19)
  void clearDescription() => $_clearField(19);
}

/// === Lock Fund AutoSave ===
class LockFundAutoSave extends $pb.GeneratedMessage {
  factory LockFundAutoSave({
    $core.String? id,
    $core.String? lockFundId,
    $core.String? sourceAccountId,
    $core.double? amount,
    $core.String? frequency,
    $core.String? status,
    $core.String? nextRunAt,
    $core.String? lastRunAt,
    $core.double? totalSaved,
    $core.int? runCount,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (lockFundId != null) result.lockFundId = lockFundId;
    if (sourceAccountId != null) result.sourceAccountId = sourceAccountId;
    if (amount != null) result.amount = amount;
    if (frequency != null) result.frequency = frequency;
    if (status != null) result.status = status;
    if (nextRunAt != null) result.nextRunAt = nextRunAt;
    if (lastRunAt != null) result.lastRunAt = lastRunAt;
    if (totalSaved != null) result.totalSaved = totalSaved;
    if (runCount != null) result.runCount = runCount;
    return result;
  }

  LockFundAutoSave._();

  factory LockFundAutoSave.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory LockFundAutoSave.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LockFundAutoSave',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'lockFundId')
    ..aOS(3, _omitFieldNames ? '' : 'sourceAccountId')
    ..a<$core.double>(4, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(5, _omitFieldNames ? '' : 'frequency')
    ..aOS(6, _omitFieldNames ? '' : 'status')
    ..aOS(7, _omitFieldNames ? '' : 'nextRunAt')
    ..aOS(8, _omitFieldNames ? '' : 'lastRunAt')
    ..a<$core.double>(
        9, _omitFieldNames ? '' : 'totalSaved', $pb.PbFieldType.OD)
    ..a<$core.int>(10, _omitFieldNames ? '' : 'runCount', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LockFundAutoSave clone() => LockFundAutoSave()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LockFundAutoSave copyWith(void Function(LockFundAutoSave) updates) =>
      super.copyWith((message) => updates(message as LockFundAutoSave))
          as LockFundAutoSave;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LockFundAutoSave create() => LockFundAutoSave._();
  @$core.override
  LockFundAutoSave createEmptyInstance() => create();
  static $pb.PbList<LockFundAutoSave> createRepeated() =>
      $pb.PbList<LockFundAutoSave>();
  @$core.pragma('dart2js:noInline')
  static LockFundAutoSave getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LockFundAutoSave>(create);
  static LockFundAutoSave? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get lockFundId => $_getSZ(1);
  @$pb.TagNumber(2)
  set lockFundId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLockFundId() => $_has(1);
  @$pb.TagNumber(2)
  void clearLockFundId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get sourceAccountId => $_getSZ(2);
  @$pb.TagNumber(3)
  set sourceAccountId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSourceAccountId() => $_has(2);
  @$pb.TagNumber(3)
  void clearSourceAccountId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get amount => $_getN(3);
  @$pb.TagNumber(4)
  set amount($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearAmount() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get frequency => $_getSZ(4);
  @$pb.TagNumber(5)
  set frequency($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasFrequency() => $_has(4);
  @$pb.TagNumber(5)
  void clearFrequency() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get status => $_getSZ(5);
  @$pb.TagNumber(6)
  set status($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasStatus() => $_has(5);
  @$pb.TagNumber(6)
  void clearStatus() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get nextRunAt => $_getSZ(6);
  @$pb.TagNumber(7)
  set nextRunAt($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasNextRunAt() => $_has(6);
  @$pb.TagNumber(7)
  void clearNextRunAt() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get lastRunAt => $_getSZ(7);
  @$pb.TagNumber(8)
  set lastRunAt($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasLastRunAt() => $_has(7);
  @$pb.TagNumber(8)
  void clearLastRunAt() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.double get totalSaved => $_getN(8);
  @$pb.TagNumber(9)
  set totalSaved($core.double value) => $_setDouble(8, value);
  @$pb.TagNumber(9)
  $core.bool hasTotalSaved() => $_has(8);
  @$pb.TagNumber(9)
  void clearTotalSaved() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.int get runCount => $_getIZ(9);
  @$pb.TagNumber(10)
  set runCount($core.int value) => $_setSignedInt32(9, value);
  @$pb.TagNumber(10)
  $core.bool hasRunCount() => $_has(9);
  @$pb.TagNumber(10)
  void clearRunCount() => $_clearField(10);
}

/// Create lock fund
class CreateLockFundRequest extends $pb.GeneratedMessage {
  factory CreateLockFundRequest({
    LockType? lockType,
    $core.double? amount,
    $core.String? currency,
    $core.int? lockDurationDays,
    $core.bool? autoRenew,
    $core.String? goalName,
    $core.String? goalDescription,
    $core.String? paymentMethod,
    $core.String? sourceAccountId,
    $core.String? transactionPin,
  }) {
    final result = create();
    if (lockType != null) result.lockType = lockType;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    if (lockDurationDays != null) result.lockDurationDays = lockDurationDays;
    if (autoRenew != null) result.autoRenew = autoRenew;
    if (goalName != null) result.goalName = goalName;
    if (goalDescription != null) result.goalDescription = goalDescription;
    if (paymentMethod != null) result.paymentMethod = paymentMethod;
    if (sourceAccountId != null) result.sourceAccountId = sourceAccountId;
    if (transactionPin != null) result.transactionPin = transactionPin;
    return result;
  }

  CreateLockFundRequest._();

  factory CreateLockFundRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateLockFundRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateLockFundRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..e<LockType>(1, _omitFieldNames ? '' : 'lockType', $pb.PbFieldType.OE,
        defaultOrMaker: LockType.LOCK_TYPE_UNSPECIFIED,
        valueOf: LockType.valueOf,
        enumValues: LockType.values)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(3, _omitFieldNames ? '' : 'currency')
    ..a<$core.int>(
        4, _omitFieldNames ? '' : 'lockDurationDays', $pb.PbFieldType.O3)
    ..aOB(5, _omitFieldNames ? '' : 'autoRenew')
    ..aOS(6, _omitFieldNames ? '' : 'goalName')
    ..aOS(7, _omitFieldNames ? '' : 'goalDescription')
    ..aOS(8, _omitFieldNames ? '' : 'paymentMethod')
    ..aOS(9, _omitFieldNames ? '' : 'sourceAccountId')
    ..aOS(10, _omitFieldNames ? '' : 'transactionPin')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateLockFundRequest clone() =>
      CreateLockFundRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateLockFundRequest copyWith(
          void Function(CreateLockFundRequest) updates) =>
      super.copyWith((message) => updates(message as CreateLockFundRequest))
          as CreateLockFundRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateLockFundRequest create() => CreateLockFundRequest._();
  @$core.override
  CreateLockFundRequest createEmptyInstance() => create();
  static $pb.PbList<CreateLockFundRequest> createRepeated() =>
      $pb.PbList<CreateLockFundRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateLockFundRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateLockFundRequest>(create);
  static CreateLockFundRequest? _defaultInstance;

  @$pb.TagNumber(1)
  LockType get lockType => $_getN(0);
  @$pb.TagNumber(1)
  set lockType(LockType value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasLockType() => $_has(0);
  @$pb.TagNumber(1)
  void clearLockType() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get amount => $_getN(1);
  @$pb.TagNumber(2)
  set amount($core.double value) => $_setDouble(1, value);
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
  $core.int get lockDurationDays => $_getIZ(3);
  @$pb.TagNumber(4)
  set lockDurationDays($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasLockDurationDays() => $_has(3);
  @$pb.TagNumber(4)
  void clearLockDurationDays() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.bool get autoRenew => $_getBF(4);
  @$pb.TagNumber(5)
  set autoRenew($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasAutoRenew() => $_has(4);
  @$pb.TagNumber(5)
  void clearAutoRenew() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get goalName => $_getSZ(5);
  @$pb.TagNumber(6)
  set goalName($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasGoalName() => $_has(5);
  @$pb.TagNumber(6)
  void clearGoalName() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get goalDescription => $_getSZ(6);
  @$pb.TagNumber(7)
  set goalDescription($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasGoalDescription() => $_has(6);
  @$pb.TagNumber(7)
  void clearGoalDescription() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get paymentMethod => $_getSZ(7);
  @$pb.TagNumber(8)
  set paymentMethod($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasPaymentMethod() => $_has(7);
  @$pb.TagNumber(8)
  void clearPaymentMethod() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get sourceAccountId => $_getSZ(8);
  @$pb.TagNumber(9)
  set sourceAccountId($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasSourceAccountId() => $_has(8);
  @$pb.TagNumber(9)
  void clearSourceAccountId() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get transactionPin => $_getSZ(9);
  @$pb.TagNumber(10)
  set transactionPin($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasTransactionPin() => $_has(9);
  @$pb.TagNumber(10)
  void clearTransactionPin() => $_clearField(10);
}

class CreateLockFundResponse extends $pb.GeneratedMessage {
  factory CreateLockFundResponse({
    $core.bool? success,
    $core.String? message,
    LockFund? lockFund,
    $core.String? paymentUrl,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (lockFund != null) result.lockFund = lockFund;
    if (paymentUrl != null) result.paymentUrl = paymentUrl;
    return result;
  }

  CreateLockFundResponse._();

  factory CreateLockFundResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateLockFundResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateLockFundResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<LockFund>(3, _omitFieldNames ? '' : 'lockFund',
        subBuilder: LockFund.create)
    ..aOS(4, _omitFieldNames ? '' : 'paymentUrl')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateLockFundResponse clone() =>
      CreateLockFundResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateLockFundResponse copyWith(
          void Function(CreateLockFundResponse) updates) =>
      super.copyWith((message) => updates(message as CreateLockFundResponse))
          as CreateLockFundResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateLockFundResponse create() => CreateLockFundResponse._();
  @$core.override
  CreateLockFundResponse createEmptyInstance() => create();
  static $pb.PbList<CreateLockFundResponse> createRepeated() =>
      $pb.PbList<CreateLockFundResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateLockFundResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateLockFundResponse>(create);
  static CreateLockFundResponse? _defaultInstance;

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

  @$pb.TagNumber(3)
  LockFund get lockFund => $_getN(2);
  @$pb.TagNumber(3)
  set lockFund(LockFund value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasLockFund() => $_has(2);
  @$pb.TagNumber(3)
  void clearLockFund() => $_clearField(3);
  @$pb.TagNumber(3)
  LockFund ensureLockFund() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.String get paymentUrl => $_getSZ(3);
  @$pb.TagNumber(4)
  set paymentUrl($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPaymentUrl() => $_has(3);
  @$pb.TagNumber(4)
  void clearPaymentUrl() => $_clearField(4);
}

/// Get lock funds list
class GetLockFundsRequest extends $pb.GeneratedMessage {
  factory GetLockFundsRequest({
    LockStatus? status,
    $core.int? page,
    $core.int? perPage,
  }) {
    final result = create();
    if (status != null) result.status = status;
    if (page != null) result.page = page;
    if (perPage != null) result.perPage = perPage;
    return result;
  }

  GetLockFundsRequest._();

  factory GetLockFundsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetLockFundsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetLockFundsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..e<LockStatus>(1, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: LockStatus.LOCK_STATUS_UNSPECIFIED,
        valueOf: LockStatus.valueOf,
        enumValues: LockStatus.values)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'perPage', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetLockFundsRequest clone() => GetLockFundsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetLockFundsRequest copyWith(void Function(GetLockFundsRequest) updates) =>
      super.copyWith((message) => updates(message as GetLockFundsRequest))
          as GetLockFundsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetLockFundsRequest create() => GetLockFundsRequest._();
  @$core.override
  GetLockFundsRequest createEmptyInstance() => create();
  static $pb.PbList<GetLockFundsRequest> createRepeated() =>
      $pb.PbList<GetLockFundsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetLockFundsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetLockFundsRequest>(create);
  static GetLockFundsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  LockStatus get status => $_getN(0);
  @$pb.TagNumber(1)
  set status(LockStatus value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get page => $_getIZ(1);
  @$pb.TagNumber(2)
  set page($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPage() => $_has(1);
  @$pb.TagNumber(2)
  void clearPage() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get perPage => $_getIZ(2);
  @$pb.TagNumber(3)
  set perPage($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPerPage() => $_has(2);
  @$pb.TagNumber(3)
  void clearPerPage() => $_clearField(3);
}

class GetLockFundsResponse extends $pb.GeneratedMessage {
  factory GetLockFundsResponse({
    $core.Iterable<LockFund>? lockFunds,
    $core.int? totalCount,
    $core.int? page,
    $core.int? totalPages,
    $core.double? totalLockedAmount,
    $core.double? totalAccruedInterest,
    $core.int? activeLocksCount,
  }) {
    final result = create();
    if (lockFunds != null) result.lockFunds.addAll(lockFunds);
    if (totalCount != null) result.totalCount = totalCount;
    if (page != null) result.page = page;
    if (totalPages != null) result.totalPages = totalPages;
    if (totalLockedAmount != null) result.totalLockedAmount = totalLockedAmount;
    if (totalAccruedInterest != null)
      result.totalAccruedInterest = totalAccruedInterest;
    if (activeLocksCount != null) result.activeLocksCount = activeLocksCount;
    return result;
  }

  GetLockFundsResponse._();

  factory GetLockFundsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetLockFundsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetLockFundsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<LockFund>(1, _omitFieldNames ? '' : 'lockFunds', $pb.PbFieldType.PM,
        subBuilder: LockFund.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'totalCount', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'totalPages', $pb.PbFieldType.O3)
    ..a<$core.double>(
        5, _omitFieldNames ? '' : 'totalLockedAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(
        6, _omitFieldNames ? '' : 'totalAccruedInterest', $pb.PbFieldType.OD)
    ..a<$core.int>(
        7, _omitFieldNames ? '' : 'activeLocksCount', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetLockFundsResponse clone() =>
      GetLockFundsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetLockFundsResponse copyWith(void Function(GetLockFundsResponse) updates) =>
      super.copyWith((message) => updates(message as GetLockFundsResponse))
          as GetLockFundsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetLockFundsResponse create() => GetLockFundsResponse._();
  @$core.override
  GetLockFundsResponse createEmptyInstance() => create();
  static $pb.PbList<GetLockFundsResponse> createRepeated() =>
      $pb.PbList<GetLockFundsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetLockFundsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetLockFundsResponse>(create);
  static GetLockFundsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<LockFund> get lockFunds => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get totalCount => $_getIZ(1);
  @$pb.TagNumber(2)
  set totalCount($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotalCount() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalCount() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get page => $_getIZ(2);
  @$pb.TagNumber(3)
  set page($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPage() => $_has(2);
  @$pb.TagNumber(3)
  void clearPage() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get totalPages => $_getIZ(3);
  @$pb.TagNumber(4)
  set totalPages($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTotalPages() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalPages() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get totalLockedAmount => $_getN(4);
  @$pb.TagNumber(5)
  set totalLockedAmount($core.double value) => $_setDouble(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTotalLockedAmount() => $_has(4);
  @$pb.TagNumber(5)
  void clearTotalLockedAmount() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.double get totalAccruedInterest => $_getN(5);
  @$pb.TagNumber(6)
  set totalAccruedInterest($core.double value) => $_setDouble(5, value);
  @$pb.TagNumber(6)
  $core.bool hasTotalAccruedInterest() => $_has(5);
  @$pb.TagNumber(6)
  void clearTotalAccruedInterest() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.int get activeLocksCount => $_getIZ(6);
  @$pb.TagNumber(7)
  set activeLocksCount($core.int value) => $_setSignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasActiveLocksCount() => $_has(6);
  @$pb.TagNumber(7)
  void clearActiveLocksCount() => $_clearField(7);
}

/// Get single lock fund
class GetLockFundRequest extends $pb.GeneratedMessage {
  factory GetLockFundRequest({
    $core.String? lockFundId,
  }) {
    final result = create();
    if (lockFundId != null) result.lockFundId = lockFundId;
    return result;
  }

  GetLockFundRequest._();

  factory GetLockFundRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetLockFundRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetLockFundRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'lockFundId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetLockFundRequest clone() => GetLockFundRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetLockFundRequest copyWith(void Function(GetLockFundRequest) updates) =>
      super.copyWith((message) => updates(message as GetLockFundRequest))
          as GetLockFundRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetLockFundRequest create() => GetLockFundRequest._();
  @$core.override
  GetLockFundRequest createEmptyInstance() => create();
  static $pb.PbList<GetLockFundRequest> createRepeated() =>
      $pb.PbList<GetLockFundRequest>();
  @$core.pragma('dart2js:noInline')
  static GetLockFundRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetLockFundRequest>(create);
  static GetLockFundRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get lockFundId => $_getSZ(0);
  @$pb.TagNumber(1)
  set lockFundId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasLockFundId() => $_has(0);
  @$pb.TagNumber(1)
  void clearLockFundId() => $_clearField(1);
}

class GetLockFundResponse extends $pb.GeneratedMessage {
  factory GetLockFundResponse({
    $core.bool? success,
    LockFund? lockFund,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (lockFund != null) result.lockFund = lockFund;
    return result;
  }

  GetLockFundResponse._();

  factory GetLockFundResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetLockFundResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetLockFundResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOM<LockFund>(2, _omitFieldNames ? '' : 'lockFund',
        subBuilder: LockFund.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetLockFundResponse clone() => GetLockFundResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetLockFundResponse copyWith(void Function(GetLockFundResponse) updates) =>
      super.copyWith((message) => updates(message as GetLockFundResponse))
          as GetLockFundResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetLockFundResponse create() => GetLockFundResponse._();
  @$core.override
  GetLockFundResponse createEmptyInstance() => create();
  static $pb.PbList<GetLockFundResponse> createRepeated() =>
      $pb.PbList<GetLockFundResponse>();
  @$core.pragma('dart2js:noInline')
  static GetLockFundResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetLockFundResponse>(create);
  static GetLockFundResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  LockFund get lockFund => $_getN(1);
  @$pb.TagNumber(2)
  set lockFund(LockFund value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasLockFund() => $_has(1);
  @$pb.TagNumber(2)
  void clearLockFund() => $_clearField(2);
  @$pb.TagNumber(2)
  LockFund ensureLockFund() => $_ensure(1);
}

/// Unlock fund
class UnlockFundRequest extends $pb.GeneratedMessage {
  factory UnlockFundRequest({
    $core.String? lockFundId,
    $core.bool? forceEarlyUnlock,
    $core.String? transactionPin,
    $core.String? destinationAccountId,
  }) {
    final result = create();
    if (lockFundId != null) result.lockFundId = lockFundId;
    if (forceEarlyUnlock != null) result.forceEarlyUnlock = forceEarlyUnlock;
    if (transactionPin != null) result.transactionPin = transactionPin;
    if (destinationAccountId != null)
      result.destinationAccountId = destinationAccountId;
    return result;
  }

  UnlockFundRequest._();

  factory UnlockFundRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UnlockFundRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UnlockFundRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'lockFundId')
    ..aOB(2, _omitFieldNames ? '' : 'forceEarlyUnlock')
    ..aOS(3, _omitFieldNames ? '' : 'transactionPin')
    ..aOS(4, _omitFieldNames ? '' : 'destinationAccountId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UnlockFundRequest clone() => UnlockFundRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UnlockFundRequest copyWith(void Function(UnlockFundRequest) updates) =>
      super.copyWith((message) => updates(message as UnlockFundRequest))
          as UnlockFundRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UnlockFundRequest create() => UnlockFundRequest._();
  @$core.override
  UnlockFundRequest createEmptyInstance() => create();
  static $pb.PbList<UnlockFundRequest> createRepeated() =>
      $pb.PbList<UnlockFundRequest>();
  @$core.pragma('dart2js:noInline')
  static UnlockFundRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UnlockFundRequest>(create);
  static UnlockFundRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get lockFundId => $_getSZ(0);
  @$pb.TagNumber(1)
  set lockFundId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasLockFundId() => $_has(0);
  @$pb.TagNumber(1)
  void clearLockFundId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get forceEarlyUnlock => $_getBF(1);
  @$pb.TagNumber(2)
  set forceEarlyUnlock($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasForceEarlyUnlock() => $_has(1);
  @$pb.TagNumber(2)
  void clearForceEarlyUnlock() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get transactionPin => $_getSZ(2);
  @$pb.TagNumber(3)
  set transactionPin($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTransactionPin() => $_has(2);
  @$pb.TagNumber(3)
  void clearTransactionPin() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get destinationAccountId => $_getSZ(3);
  @$pb.TagNumber(4)
  set destinationAccountId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDestinationAccountId() => $_has(3);
  @$pb.TagNumber(4)
  void clearDestinationAccountId() => $_clearField(4);
}

class UnlockFundResponse extends $pb.GeneratedMessage {
  factory UnlockFundResponse({
    $core.bool? success,
    $core.String? message,
    $core.double? amountReturned,
    $core.double? penaltyAmount,
    $core.double? interestEarned,
    LockFund? updatedLockFund,
    $core.String? creditedAccountId,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (amountReturned != null) result.amountReturned = amountReturned;
    if (penaltyAmount != null) result.penaltyAmount = penaltyAmount;
    if (interestEarned != null) result.interestEarned = interestEarned;
    if (updatedLockFund != null) result.updatedLockFund = updatedLockFund;
    if (creditedAccountId != null) result.creditedAccountId = creditedAccountId;
    return result;
  }

  UnlockFundResponse._();

  factory UnlockFundResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UnlockFundResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UnlockFundResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..a<$core.double>(
        3, _omitFieldNames ? '' : 'amountReturned', $pb.PbFieldType.OD)
    ..a<$core.double>(
        4, _omitFieldNames ? '' : 'penaltyAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(
        5, _omitFieldNames ? '' : 'interestEarned', $pb.PbFieldType.OD)
    ..aOM<LockFund>(6, _omitFieldNames ? '' : 'updatedLockFund',
        subBuilder: LockFund.create)
    ..aOS(7, _omitFieldNames ? '' : 'creditedAccountId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UnlockFundResponse clone() => UnlockFundResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UnlockFundResponse copyWith(void Function(UnlockFundResponse) updates) =>
      super.copyWith((message) => updates(message as UnlockFundResponse))
          as UnlockFundResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UnlockFundResponse create() => UnlockFundResponse._();
  @$core.override
  UnlockFundResponse createEmptyInstance() => create();
  static $pb.PbList<UnlockFundResponse> createRepeated() =>
      $pb.PbList<UnlockFundResponse>();
  @$core.pragma('dart2js:noInline')
  static UnlockFundResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UnlockFundResponse>(create);
  static UnlockFundResponse? _defaultInstance;

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

  @$pb.TagNumber(3)
  $core.double get amountReturned => $_getN(2);
  @$pb.TagNumber(3)
  set amountReturned($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAmountReturned() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmountReturned() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get penaltyAmount => $_getN(3);
  @$pb.TagNumber(4)
  set penaltyAmount($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPenaltyAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearPenaltyAmount() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get interestEarned => $_getN(4);
  @$pb.TagNumber(5)
  set interestEarned($core.double value) => $_setDouble(4, value);
  @$pb.TagNumber(5)
  $core.bool hasInterestEarned() => $_has(4);
  @$pb.TagNumber(5)
  void clearInterestEarned() => $_clearField(5);

  @$pb.TagNumber(6)
  LockFund get updatedLockFund => $_getN(5);
  @$pb.TagNumber(6)
  set updatedLockFund(LockFund value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasUpdatedLockFund() => $_has(5);
  @$pb.TagNumber(6)
  void clearUpdatedLockFund() => $_clearField(6);
  @$pb.TagNumber(6)
  LockFund ensureUpdatedLockFund() => $_ensure(5);

  @$pb.TagNumber(7)
  $core.String get creditedAccountId => $_getSZ(6);
  @$pb.TagNumber(7)
  set creditedAccountId($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasCreditedAccountId() => $_has(6);
  @$pb.TagNumber(7)
  void clearCreditedAccountId() => $_clearField(7);
}

/// Top up lock fund
class TopUpLockFundRequest extends $pb.GeneratedMessage {
  factory TopUpLockFundRequest({
    $core.String? lockFundId,
    $core.double? amount,
    $core.String? transactionPin,
    $core.String? sourceAccountId,
  }) {
    final result = create();
    if (lockFundId != null) result.lockFundId = lockFundId;
    if (amount != null) result.amount = amount;
    if (transactionPin != null) result.transactionPin = transactionPin;
    if (sourceAccountId != null) result.sourceAccountId = sourceAccountId;
    return result;
  }

  TopUpLockFundRequest._();

  factory TopUpLockFundRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TopUpLockFundRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TopUpLockFundRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'lockFundId')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(3, _omitFieldNames ? '' : 'transactionPin')
    ..aOS(4, _omitFieldNames ? '' : 'sourceAccountId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TopUpLockFundRequest clone() =>
      TopUpLockFundRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TopUpLockFundRequest copyWith(void Function(TopUpLockFundRequest) updates) =>
      super.copyWith((message) => updates(message as TopUpLockFundRequest))
          as TopUpLockFundRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TopUpLockFundRequest create() => TopUpLockFundRequest._();
  @$core.override
  TopUpLockFundRequest createEmptyInstance() => create();
  static $pb.PbList<TopUpLockFundRequest> createRepeated() =>
      $pb.PbList<TopUpLockFundRequest>();
  @$core.pragma('dart2js:noInline')
  static TopUpLockFundRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TopUpLockFundRequest>(create);
  static TopUpLockFundRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get lockFundId => $_getSZ(0);
  @$pb.TagNumber(1)
  set lockFundId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasLockFundId() => $_has(0);
  @$pb.TagNumber(1)
  void clearLockFundId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get amount => $_getN(1);
  @$pb.TagNumber(2)
  set amount($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get transactionPin => $_getSZ(2);
  @$pb.TagNumber(3)
  set transactionPin($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTransactionPin() => $_has(2);
  @$pb.TagNumber(3)
  void clearTransactionPin() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get sourceAccountId => $_getSZ(3);
  @$pb.TagNumber(4)
  set sourceAccountId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasSourceAccountId() => $_has(3);
  @$pb.TagNumber(4)
  void clearSourceAccountId() => $_clearField(4);
}

class TopUpLockFundResponse extends $pb.GeneratedMessage {
  factory TopUpLockFundResponse({
    $core.bool? success,
    $core.String? message,
    LockFund? updatedLockFund,
    $core.double? newBalance,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (updatedLockFund != null) result.updatedLockFund = updatedLockFund;
    if (newBalance != null) result.newBalance = newBalance;
    return result;
  }

  TopUpLockFundResponse._();

  factory TopUpLockFundResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TopUpLockFundResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TopUpLockFundResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<LockFund>(3, _omitFieldNames ? '' : 'updatedLockFund',
        subBuilder: LockFund.create)
    ..a<$core.double>(
        4, _omitFieldNames ? '' : 'newBalance', $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TopUpLockFundResponse clone() =>
      TopUpLockFundResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TopUpLockFundResponse copyWith(
          void Function(TopUpLockFundResponse) updates) =>
      super.copyWith((message) => updates(message as TopUpLockFundResponse))
          as TopUpLockFundResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TopUpLockFundResponse create() => TopUpLockFundResponse._();
  @$core.override
  TopUpLockFundResponse createEmptyInstance() => create();
  static $pb.PbList<TopUpLockFundResponse> createRepeated() =>
      $pb.PbList<TopUpLockFundResponse>();
  @$core.pragma('dart2js:noInline')
  static TopUpLockFundResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TopUpLockFundResponse>(create);
  static TopUpLockFundResponse? _defaultInstance;

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

  @$pb.TagNumber(3)
  LockFund get updatedLockFund => $_getN(2);
  @$pb.TagNumber(3)
  set updatedLockFund(LockFund value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasUpdatedLockFund() => $_has(2);
  @$pb.TagNumber(3)
  void clearUpdatedLockFund() => $_clearField(3);
  @$pb.TagNumber(3)
  LockFund ensureUpdatedLockFund() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.double get newBalance => $_getN(3);
  @$pb.TagNumber(4)
  set newBalance($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasNewBalance() => $_has(3);
  @$pb.TagNumber(4)
  void clearNewBalance() => $_clearField(4);
}

/// Get lock transactions
class GetLockTransactionsRequest extends $pb.GeneratedMessage {
  factory GetLockTransactionsRequest({
    $core.String? lockFundId,
    $core.int? page,
    $core.int? perPage,
  }) {
    final result = create();
    if (lockFundId != null) result.lockFundId = lockFundId;
    if (page != null) result.page = page;
    if (perPage != null) result.perPage = perPage;
    return result;
  }

  GetLockTransactionsRequest._();

  factory GetLockTransactionsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetLockTransactionsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetLockTransactionsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'lockFundId')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'perPage', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetLockTransactionsRequest clone() =>
      GetLockTransactionsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetLockTransactionsRequest copyWith(
          void Function(GetLockTransactionsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetLockTransactionsRequest))
          as GetLockTransactionsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetLockTransactionsRequest create() => GetLockTransactionsRequest._();
  @$core.override
  GetLockTransactionsRequest createEmptyInstance() => create();
  static $pb.PbList<GetLockTransactionsRequest> createRepeated() =>
      $pb.PbList<GetLockTransactionsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetLockTransactionsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetLockTransactionsRequest>(create);
  static GetLockTransactionsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get lockFundId => $_getSZ(0);
  @$pb.TagNumber(1)
  set lockFundId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasLockFundId() => $_has(0);
  @$pb.TagNumber(1)
  void clearLockFundId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get page => $_getIZ(1);
  @$pb.TagNumber(2)
  set page($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPage() => $_has(1);
  @$pb.TagNumber(2)
  void clearPage() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get perPage => $_getIZ(2);
  @$pb.TagNumber(3)
  set perPage($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPerPage() => $_has(2);
  @$pb.TagNumber(3)
  void clearPerPage() => $_clearField(3);
}

class GetLockTransactionsResponse extends $pb.GeneratedMessage {
  factory GetLockTransactionsResponse({
    $core.Iterable<LockTransaction>? transactions,
    $core.int? totalCount,
    $core.int? page,
    $core.int? totalPages,
  }) {
    final result = create();
    if (transactions != null) result.transactions.addAll(transactions);
    if (totalCount != null) result.totalCount = totalCount;
    if (page != null) result.page = page;
    if (totalPages != null) result.totalPages = totalPages;
    return result;
  }

  GetLockTransactionsResponse._();

  factory GetLockTransactionsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetLockTransactionsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetLockTransactionsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<LockTransaction>(
        1, _omitFieldNames ? '' : 'transactions', $pb.PbFieldType.PM,
        subBuilder: LockTransaction.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'totalCount', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'totalPages', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetLockTransactionsResponse clone() =>
      GetLockTransactionsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetLockTransactionsResponse copyWith(
          void Function(GetLockTransactionsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetLockTransactionsResponse))
          as GetLockTransactionsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetLockTransactionsResponse create() =>
      GetLockTransactionsResponse._();
  @$core.override
  GetLockTransactionsResponse createEmptyInstance() => create();
  static $pb.PbList<GetLockTransactionsResponse> createRepeated() =>
      $pb.PbList<GetLockTransactionsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetLockTransactionsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetLockTransactionsResponse>(create);
  static GetLockTransactionsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<LockTransaction> get transactions => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get totalCount => $_getIZ(1);
  @$pb.TagNumber(2)
  set totalCount($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotalCount() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalCount() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get page => $_getIZ(2);
  @$pb.TagNumber(3)
  set page($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPage() => $_has(2);
  @$pb.TagNumber(3)
  void clearPage() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get totalPages => $_getIZ(3);
  @$pb.TagNumber(4)
  set totalPages($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTotalPages() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalPages() => $_clearField(4);
}

/// Calculate interest
class CalculateInterestRequest extends $pb.GeneratedMessage {
  factory CalculateInterestRequest({
    LockType? lockType,
    $core.double? amount,
    $core.int? lockDurationDays,
  }) {
    final result = create();
    if (lockType != null) result.lockType = lockType;
    if (amount != null) result.amount = amount;
    if (lockDurationDays != null) result.lockDurationDays = lockDurationDays;
    return result;
  }

  CalculateInterestRequest._();

  factory CalculateInterestRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CalculateInterestRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CalculateInterestRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..e<LockType>(1, _omitFieldNames ? '' : 'lockType', $pb.PbFieldType.OE,
        defaultOrMaker: LockType.LOCK_TYPE_UNSPECIFIED,
        valueOf: LockType.valueOf,
        enumValues: LockType.values)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..a<$core.int>(
        3, _omitFieldNames ? '' : 'lockDurationDays', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CalculateInterestRequest clone() =>
      CalculateInterestRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CalculateInterestRequest copyWith(
          void Function(CalculateInterestRequest) updates) =>
      super.copyWith((message) => updates(message as CalculateInterestRequest))
          as CalculateInterestRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CalculateInterestRequest create() => CalculateInterestRequest._();
  @$core.override
  CalculateInterestRequest createEmptyInstance() => create();
  static $pb.PbList<CalculateInterestRequest> createRepeated() =>
      $pb.PbList<CalculateInterestRequest>();
  @$core.pragma('dart2js:noInline')
  static CalculateInterestRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CalculateInterestRequest>(create);
  static CalculateInterestRequest? _defaultInstance;

  @$pb.TagNumber(1)
  LockType get lockType => $_getN(0);
  @$pb.TagNumber(1)
  set lockType(LockType value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasLockType() => $_has(0);
  @$pb.TagNumber(1)
  void clearLockType() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get amount => $_getN(1);
  @$pb.TagNumber(2)
  set amount($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get lockDurationDays => $_getIZ(2);
  @$pb.TagNumber(3)
  set lockDurationDays($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasLockDurationDays() => $_has(2);
  @$pb.TagNumber(3)
  void clearLockDurationDays() => $_clearField(3);
}

class CalculateInterestResponse extends $pb.GeneratedMessage {
  factory CalculateInterestResponse({
    $core.double? interestRate,
    $core.double? estimatedInterest,
    $core.double? totalReturn,
    $core.double? apy,
  }) {
    final result = create();
    if (interestRate != null) result.interestRate = interestRate;
    if (estimatedInterest != null) result.estimatedInterest = estimatedInterest;
    if (totalReturn != null) result.totalReturn = totalReturn;
    if (apy != null) result.apy = apy;
    return result;
  }

  CalculateInterestResponse._();

  factory CalculateInterestResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CalculateInterestResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CalculateInterestResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..a<$core.double>(
        1, _omitFieldNames ? '' : 'interestRate', $pb.PbFieldType.OD)
    ..a<$core.double>(
        2, _omitFieldNames ? '' : 'estimatedInterest', $pb.PbFieldType.OD)
    ..a<$core.double>(
        3, _omitFieldNames ? '' : 'totalReturn', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'apy', $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CalculateInterestResponse clone() =>
      CalculateInterestResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CalculateInterestResponse copyWith(
          void Function(CalculateInterestResponse) updates) =>
      super.copyWith((message) => updates(message as CalculateInterestResponse))
          as CalculateInterestResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CalculateInterestResponse create() => CalculateInterestResponse._();
  @$core.override
  CalculateInterestResponse createEmptyInstance() => create();
  static $pb.PbList<CalculateInterestResponse> createRepeated() =>
      $pb.PbList<CalculateInterestResponse>();
  @$core.pragma('dart2js:noInline')
  static CalculateInterestResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CalculateInterestResponse>(create);
  static CalculateInterestResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get interestRate => $_getN(0);
  @$pb.TagNumber(1)
  set interestRate($core.double value) => $_setDouble(0, value);
  @$pb.TagNumber(1)
  $core.bool hasInterestRate() => $_has(0);
  @$pb.TagNumber(1)
  void clearInterestRate() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get estimatedInterest => $_getN(1);
  @$pb.TagNumber(2)
  set estimatedInterest($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasEstimatedInterest() => $_has(1);
  @$pb.TagNumber(2)
  void clearEstimatedInterest() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get totalReturn => $_getN(2);
  @$pb.TagNumber(3)
  set totalReturn($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTotalReturn() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalReturn() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get apy => $_getN(3);
  @$pb.TagNumber(4)
  set apy($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasApy() => $_has(3);
  @$pb.TagNumber(4)
  void clearApy() => $_clearField(4);
}

/// Renew lock fund
class RenewLockFundRequest extends $pb.GeneratedMessage {
  factory RenewLockFundRequest({
    $core.String? lockFundId,
    $core.int? newDurationDays,
  }) {
    final result = create();
    if (lockFundId != null) result.lockFundId = lockFundId;
    if (newDurationDays != null) result.newDurationDays = newDurationDays;
    return result;
  }

  RenewLockFundRequest._();

  factory RenewLockFundRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RenewLockFundRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RenewLockFundRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'lockFundId')
    ..a<$core.int>(
        2, _omitFieldNames ? '' : 'newDurationDays', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RenewLockFundRequest clone() =>
      RenewLockFundRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RenewLockFundRequest copyWith(void Function(RenewLockFundRequest) updates) =>
      super.copyWith((message) => updates(message as RenewLockFundRequest))
          as RenewLockFundRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RenewLockFundRequest create() => RenewLockFundRequest._();
  @$core.override
  RenewLockFundRequest createEmptyInstance() => create();
  static $pb.PbList<RenewLockFundRequest> createRepeated() =>
      $pb.PbList<RenewLockFundRequest>();
  @$core.pragma('dart2js:noInline')
  static RenewLockFundRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RenewLockFundRequest>(create);
  static RenewLockFundRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get lockFundId => $_getSZ(0);
  @$pb.TagNumber(1)
  set lockFundId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasLockFundId() => $_has(0);
  @$pb.TagNumber(1)
  void clearLockFundId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get newDurationDays => $_getIZ(1);
  @$pb.TagNumber(2)
  set newDurationDays($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNewDurationDays() => $_has(1);
  @$pb.TagNumber(2)
  void clearNewDurationDays() => $_clearField(2);
}

class RenewLockFundResponse extends $pb.GeneratedMessage {
  factory RenewLockFundResponse({
    $core.bool? success,
    $core.String? message,
    LockFund? renewedLockFund,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (renewedLockFund != null) result.renewedLockFund = renewedLockFund;
    return result;
  }

  RenewLockFundResponse._();

  factory RenewLockFundResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RenewLockFundResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RenewLockFundResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<LockFund>(3, _omitFieldNames ? '' : 'renewedLockFund',
        subBuilder: LockFund.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RenewLockFundResponse clone() =>
      RenewLockFundResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RenewLockFundResponse copyWith(
          void Function(RenewLockFundResponse) updates) =>
      super.copyWith((message) => updates(message as RenewLockFundResponse))
          as RenewLockFundResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RenewLockFundResponse create() => RenewLockFundResponse._();
  @$core.override
  RenewLockFundResponse createEmptyInstance() => create();
  static $pb.PbList<RenewLockFundResponse> createRepeated() =>
      $pb.PbList<RenewLockFundResponse>();
  @$core.pragma('dart2js:noInline')
  static RenewLockFundResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RenewLockFundResponse>(create);
  static RenewLockFundResponse? _defaultInstance;

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

  @$pb.TagNumber(3)
  LockFund get renewedLockFund => $_getN(2);
  @$pb.TagNumber(3)
  set renewedLockFund(LockFund value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasRenewedLockFund() => $_has(2);
  @$pb.TagNumber(3)
  void clearRenewedLockFund() => $_clearField(3);
  @$pb.TagNumber(3)
  LockFund ensureRenewedLockFund() => $_ensure(2);
}

/// Cancel lock fund
class CancelLockFundRequest extends $pb.GeneratedMessage {
  factory CancelLockFundRequest({
    $core.String? lockFundId,
    $core.String? reason,
  }) {
    final result = create();
    if (lockFundId != null) result.lockFundId = lockFundId;
    if (reason != null) result.reason = reason;
    return result;
  }

  CancelLockFundRequest._();

  factory CancelLockFundRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CancelLockFundRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CancelLockFundRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'lockFundId')
    ..aOS(2, _omitFieldNames ? '' : 'reason')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CancelLockFundRequest clone() =>
      CancelLockFundRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CancelLockFundRequest copyWith(
          void Function(CancelLockFundRequest) updates) =>
      super.copyWith((message) => updates(message as CancelLockFundRequest))
          as CancelLockFundRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CancelLockFundRequest create() => CancelLockFundRequest._();
  @$core.override
  CancelLockFundRequest createEmptyInstance() => create();
  static $pb.PbList<CancelLockFundRequest> createRepeated() =>
      $pb.PbList<CancelLockFundRequest>();
  @$core.pragma('dart2js:noInline')
  static CancelLockFundRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CancelLockFundRequest>(create);
  static CancelLockFundRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get lockFundId => $_getSZ(0);
  @$pb.TagNumber(1)
  set lockFundId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasLockFundId() => $_has(0);
  @$pb.TagNumber(1)
  void clearLockFundId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get reason => $_getSZ(1);
  @$pb.TagNumber(2)
  set reason($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasReason() => $_has(1);
  @$pb.TagNumber(2)
  void clearReason() => $_clearField(2);
}

class CancelLockFundResponse extends $pb.GeneratedMessage {
  factory CancelLockFundResponse({
    $core.bool? success,
    $core.String? message,
    $core.double? refundAmount,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (refundAmount != null) result.refundAmount = refundAmount;
    return result;
  }

  CancelLockFundResponse._();

  factory CancelLockFundResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CancelLockFundResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CancelLockFundResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..a<$core.double>(
        3, _omitFieldNames ? '' : 'refundAmount', $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CancelLockFundResponse clone() =>
      CancelLockFundResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CancelLockFundResponse copyWith(
          void Function(CancelLockFundResponse) updates) =>
      super.copyWith((message) => updates(message as CancelLockFundResponse))
          as CancelLockFundResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CancelLockFundResponse create() => CancelLockFundResponse._();
  @$core.override
  CancelLockFundResponse createEmptyInstance() => create();
  static $pb.PbList<CancelLockFundResponse> createRepeated() =>
      $pb.PbList<CancelLockFundResponse>();
  @$core.pragma('dart2js:noInline')
  static CancelLockFundResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CancelLockFundResponse>(create);
  static CancelLockFundResponse? _defaultInstance;

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

  @$pb.TagNumber(3)
  $core.double get refundAmount => $_getN(2);
  @$pb.TagNumber(3)
  set refundAmount($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasRefundAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearRefundAmount() => $_clearField(3);
}

/// PiggyVault configs
class GetPiggyVaultConfigsRequest extends $pb.GeneratedMessage {
  factory GetPiggyVaultConfigsRequest({
    $core.String? currency,
  }) {
    final result = create();
    if (currency != null) result.currency = currency;
    return result;
  }

  GetPiggyVaultConfigsRequest._();

  factory GetPiggyVaultConfigsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetPiggyVaultConfigsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetPiggyVaultConfigsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'currency')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPiggyVaultConfigsRequest clone() =>
      GetPiggyVaultConfigsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPiggyVaultConfigsRequest copyWith(
          void Function(GetPiggyVaultConfigsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetPiggyVaultConfigsRequest))
          as GetPiggyVaultConfigsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPiggyVaultConfigsRequest create() =>
      GetPiggyVaultConfigsRequest._();
  @$core.override
  GetPiggyVaultConfigsRequest createEmptyInstance() => create();
  static $pb.PbList<GetPiggyVaultConfigsRequest> createRepeated() =>
      $pb.PbList<GetPiggyVaultConfigsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetPiggyVaultConfigsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetPiggyVaultConfigsRequest>(create);
  static GetPiggyVaultConfigsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get currency => $_getSZ(0);
  @$pb.TagNumber(1)
  set currency($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCurrency() => $_has(0);
  @$pb.TagNumber(1)
  void clearCurrency() => $_clearField(1);
}

class GetPiggyVaultConfigsResponse extends $pb.GeneratedMessage {
  factory GetPiggyVaultConfigsResponse({
    $core.Iterable<PiggyVaultConfig>? configs,
  }) {
    final result = create();
    if (configs != null) result.configs.addAll(configs);
    return result;
  }

  GetPiggyVaultConfigsResponse._();

  factory GetPiggyVaultConfigsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetPiggyVaultConfigsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetPiggyVaultConfigsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<PiggyVaultConfig>(
        1, _omitFieldNames ? '' : 'configs', $pb.PbFieldType.PM,
        subBuilder: PiggyVaultConfig.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPiggyVaultConfigsResponse clone() =>
      GetPiggyVaultConfigsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPiggyVaultConfigsResponse copyWith(
          void Function(GetPiggyVaultConfigsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetPiggyVaultConfigsResponse))
          as GetPiggyVaultConfigsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPiggyVaultConfigsResponse create() =>
      GetPiggyVaultConfigsResponse._();
  @$core.override
  GetPiggyVaultConfigsResponse createEmptyInstance() => create();
  static $pb.PbList<GetPiggyVaultConfigsResponse> createRepeated() =>
      $pb.PbList<GetPiggyVaultConfigsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetPiggyVaultConfigsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetPiggyVaultConfigsResponse>(create);
  static GetPiggyVaultConfigsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<PiggyVaultConfig> get configs => $_getList(0);
}

/// Lock fund auto-save
class CreateLockFundAutoSaveRequest extends $pb.GeneratedMessage {
  factory CreateLockFundAutoSaveRequest({
    $core.String? lockFundId,
    $core.String? sourceAccountId,
    $core.double? amount,
    $core.String? frequency,
  }) {
    final result = create();
    if (lockFundId != null) result.lockFundId = lockFundId;
    if (sourceAccountId != null) result.sourceAccountId = sourceAccountId;
    if (amount != null) result.amount = amount;
    if (frequency != null) result.frequency = frequency;
    return result;
  }

  CreateLockFundAutoSaveRequest._();

  factory CreateLockFundAutoSaveRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateLockFundAutoSaveRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateLockFundAutoSaveRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'lockFundId')
    ..aOS(2, _omitFieldNames ? '' : 'sourceAccountId')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(4, _omitFieldNames ? '' : 'frequency')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateLockFundAutoSaveRequest clone() =>
      CreateLockFundAutoSaveRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateLockFundAutoSaveRequest copyWith(
          void Function(CreateLockFundAutoSaveRequest) updates) =>
      super.copyWith(
              (message) => updates(message as CreateLockFundAutoSaveRequest))
          as CreateLockFundAutoSaveRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateLockFundAutoSaveRequest create() =>
      CreateLockFundAutoSaveRequest._();
  @$core.override
  CreateLockFundAutoSaveRequest createEmptyInstance() => create();
  static $pb.PbList<CreateLockFundAutoSaveRequest> createRepeated() =>
      $pb.PbList<CreateLockFundAutoSaveRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateLockFundAutoSaveRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateLockFundAutoSaveRequest>(create);
  static CreateLockFundAutoSaveRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get lockFundId => $_getSZ(0);
  @$pb.TagNumber(1)
  set lockFundId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasLockFundId() => $_has(0);
  @$pb.TagNumber(1)
  void clearLockFundId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get sourceAccountId => $_getSZ(1);
  @$pb.TagNumber(2)
  set sourceAccountId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSourceAccountId() => $_has(1);
  @$pb.TagNumber(2)
  void clearSourceAccountId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get amount => $_getN(2);
  @$pb.TagNumber(3)
  set amount($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get frequency => $_getSZ(3);
  @$pb.TagNumber(4)
  set frequency($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasFrequency() => $_has(3);
  @$pb.TagNumber(4)
  void clearFrequency() => $_clearField(4);
}

class CreateLockFundAutoSaveResponse extends $pb.GeneratedMessage {
  factory CreateLockFundAutoSaveResponse({
    $core.bool? success,
    $core.String? message,
    LockFundAutoSave? autosave,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (autosave != null) result.autosave = autosave;
    return result;
  }

  CreateLockFundAutoSaveResponse._();

  factory CreateLockFundAutoSaveResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateLockFundAutoSaveResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateLockFundAutoSaveResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<LockFundAutoSave>(3, _omitFieldNames ? '' : 'autosave',
        subBuilder: LockFundAutoSave.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateLockFundAutoSaveResponse clone() =>
      CreateLockFundAutoSaveResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateLockFundAutoSaveResponse copyWith(
          void Function(CreateLockFundAutoSaveResponse) updates) =>
      super.copyWith(
              (message) => updates(message as CreateLockFundAutoSaveResponse))
          as CreateLockFundAutoSaveResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateLockFundAutoSaveResponse create() =>
      CreateLockFundAutoSaveResponse._();
  @$core.override
  CreateLockFundAutoSaveResponse createEmptyInstance() => create();
  static $pb.PbList<CreateLockFundAutoSaveResponse> createRepeated() =>
      $pb.PbList<CreateLockFundAutoSaveResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateLockFundAutoSaveResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateLockFundAutoSaveResponse>(create);
  static CreateLockFundAutoSaveResponse? _defaultInstance;

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

  @$pb.TagNumber(3)
  LockFundAutoSave get autosave => $_getN(2);
  @$pb.TagNumber(3)
  set autosave(LockFundAutoSave value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasAutosave() => $_has(2);
  @$pb.TagNumber(3)
  void clearAutosave() => $_clearField(3);
  @$pb.TagNumber(3)
  LockFundAutoSave ensureAutosave() => $_ensure(2);
}

class GetLockFundAutoSaveRequest extends $pb.GeneratedMessage {
  factory GetLockFundAutoSaveRequest({
    $core.String? lockFundId,
  }) {
    final result = create();
    if (lockFundId != null) result.lockFundId = lockFundId;
    return result;
  }

  GetLockFundAutoSaveRequest._();

  factory GetLockFundAutoSaveRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetLockFundAutoSaveRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetLockFundAutoSaveRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'lockFundId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetLockFundAutoSaveRequest clone() =>
      GetLockFundAutoSaveRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetLockFundAutoSaveRequest copyWith(
          void Function(GetLockFundAutoSaveRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetLockFundAutoSaveRequest))
          as GetLockFundAutoSaveRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetLockFundAutoSaveRequest create() => GetLockFundAutoSaveRequest._();
  @$core.override
  GetLockFundAutoSaveRequest createEmptyInstance() => create();
  static $pb.PbList<GetLockFundAutoSaveRequest> createRepeated() =>
      $pb.PbList<GetLockFundAutoSaveRequest>();
  @$core.pragma('dart2js:noInline')
  static GetLockFundAutoSaveRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetLockFundAutoSaveRequest>(create);
  static GetLockFundAutoSaveRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get lockFundId => $_getSZ(0);
  @$pb.TagNumber(1)
  set lockFundId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasLockFundId() => $_has(0);
  @$pb.TagNumber(1)
  void clearLockFundId() => $_clearField(1);
}

class GetLockFundAutoSaveResponse extends $pb.GeneratedMessage {
  factory GetLockFundAutoSaveResponse({
    LockFundAutoSave? autosave,
  }) {
    final result = create();
    if (autosave != null) result.autosave = autosave;
    return result;
  }

  GetLockFundAutoSaveResponse._();

  factory GetLockFundAutoSaveResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetLockFundAutoSaveResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetLockFundAutoSaveResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<LockFundAutoSave>(1, _omitFieldNames ? '' : 'autosave',
        subBuilder: LockFundAutoSave.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetLockFundAutoSaveResponse clone() =>
      GetLockFundAutoSaveResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetLockFundAutoSaveResponse copyWith(
          void Function(GetLockFundAutoSaveResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetLockFundAutoSaveResponse))
          as GetLockFundAutoSaveResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetLockFundAutoSaveResponse create() =>
      GetLockFundAutoSaveResponse._();
  @$core.override
  GetLockFundAutoSaveResponse createEmptyInstance() => create();
  static $pb.PbList<GetLockFundAutoSaveResponse> createRepeated() =>
      $pb.PbList<GetLockFundAutoSaveResponse>();
  @$core.pragma('dart2js:noInline')
  static GetLockFundAutoSaveResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetLockFundAutoSaveResponse>(create);
  static GetLockFundAutoSaveResponse? _defaultInstance;

  @$pb.TagNumber(1)
  LockFundAutoSave get autosave => $_getN(0);
  @$pb.TagNumber(1)
  set autosave(LockFundAutoSave value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasAutosave() => $_has(0);
  @$pb.TagNumber(1)
  void clearAutosave() => $_clearField(1);
  @$pb.TagNumber(1)
  LockFundAutoSave ensureAutosave() => $_ensure(0);
}

class UpdateLockFundAutoSaveRequest extends $pb.GeneratedMessage {
  factory UpdateLockFundAutoSaveRequest({
    $core.String? autosaveId,
    $core.double? amount,
    $core.String? frequency,
    $core.String? status,
  }) {
    final result = create();
    if (autosaveId != null) result.autosaveId = autosaveId;
    if (amount != null) result.amount = amount;
    if (frequency != null) result.frequency = frequency;
    if (status != null) result.status = status;
    return result;
  }

  UpdateLockFundAutoSaveRequest._();

  factory UpdateLockFundAutoSaveRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateLockFundAutoSaveRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateLockFundAutoSaveRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'autosaveId')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(3, _omitFieldNames ? '' : 'frequency')
    ..aOS(4, _omitFieldNames ? '' : 'status')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateLockFundAutoSaveRequest clone() =>
      UpdateLockFundAutoSaveRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateLockFundAutoSaveRequest copyWith(
          void Function(UpdateLockFundAutoSaveRequest) updates) =>
      super.copyWith(
              (message) => updates(message as UpdateLockFundAutoSaveRequest))
          as UpdateLockFundAutoSaveRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateLockFundAutoSaveRequest create() =>
      UpdateLockFundAutoSaveRequest._();
  @$core.override
  UpdateLockFundAutoSaveRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateLockFundAutoSaveRequest> createRepeated() =>
      $pb.PbList<UpdateLockFundAutoSaveRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateLockFundAutoSaveRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateLockFundAutoSaveRequest>(create);
  static UpdateLockFundAutoSaveRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get autosaveId => $_getSZ(0);
  @$pb.TagNumber(1)
  set autosaveId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAutosaveId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAutosaveId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get amount => $_getN(1);
  @$pb.TagNumber(2)
  set amount($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get frequency => $_getSZ(2);
  @$pb.TagNumber(3)
  set frequency($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasFrequency() => $_has(2);
  @$pb.TagNumber(3)
  void clearFrequency() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get status => $_getSZ(3);
  @$pb.TagNumber(4)
  set status($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasStatus() => $_has(3);
  @$pb.TagNumber(4)
  void clearStatus() => $_clearField(4);
}

class UpdateLockFundAutoSaveResponse extends $pb.GeneratedMessage {
  factory UpdateLockFundAutoSaveResponse({
    $core.bool? success,
    $core.String? message,
    LockFundAutoSave? autosave,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (autosave != null) result.autosave = autosave;
    return result;
  }

  UpdateLockFundAutoSaveResponse._();

  factory UpdateLockFundAutoSaveResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateLockFundAutoSaveResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateLockFundAutoSaveResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<LockFundAutoSave>(3, _omitFieldNames ? '' : 'autosave',
        subBuilder: LockFundAutoSave.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateLockFundAutoSaveResponse clone() =>
      UpdateLockFundAutoSaveResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateLockFundAutoSaveResponse copyWith(
          void Function(UpdateLockFundAutoSaveResponse) updates) =>
      super.copyWith(
              (message) => updates(message as UpdateLockFundAutoSaveResponse))
          as UpdateLockFundAutoSaveResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateLockFundAutoSaveResponse create() =>
      UpdateLockFundAutoSaveResponse._();
  @$core.override
  UpdateLockFundAutoSaveResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateLockFundAutoSaveResponse> createRepeated() =>
      $pb.PbList<UpdateLockFundAutoSaveResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateLockFundAutoSaveResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateLockFundAutoSaveResponse>(create);
  static UpdateLockFundAutoSaveResponse? _defaultInstance;

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

  @$pb.TagNumber(3)
  LockFundAutoSave get autosave => $_getN(2);
  @$pb.TagNumber(3)
  set autosave(LockFundAutoSave value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasAutosave() => $_has(2);
  @$pb.TagNumber(3)
  void clearAutosave() => $_clearField(3);
  @$pb.TagNumber(3)
  LockFundAutoSave ensureAutosave() => $_ensure(2);
}

class DeleteLockFundAutoSaveRequest extends $pb.GeneratedMessage {
  factory DeleteLockFundAutoSaveRequest({
    $core.String? autosaveId,
  }) {
    final result = create();
    if (autosaveId != null) result.autosaveId = autosaveId;
    return result;
  }

  DeleteLockFundAutoSaveRequest._();

  factory DeleteLockFundAutoSaveRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeleteLockFundAutoSaveRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteLockFundAutoSaveRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'autosaveId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteLockFundAutoSaveRequest clone() =>
      DeleteLockFundAutoSaveRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteLockFundAutoSaveRequest copyWith(
          void Function(DeleteLockFundAutoSaveRequest) updates) =>
      super.copyWith(
              (message) => updates(message as DeleteLockFundAutoSaveRequest))
          as DeleteLockFundAutoSaveRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteLockFundAutoSaveRequest create() =>
      DeleteLockFundAutoSaveRequest._();
  @$core.override
  DeleteLockFundAutoSaveRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteLockFundAutoSaveRequest> createRepeated() =>
      $pb.PbList<DeleteLockFundAutoSaveRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteLockFundAutoSaveRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteLockFundAutoSaveRequest>(create);
  static DeleteLockFundAutoSaveRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get autosaveId => $_getSZ(0);
  @$pb.TagNumber(1)
  set autosaveId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAutosaveId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAutosaveId() => $_clearField(1);
}

class DeleteLockFundAutoSaveResponse extends $pb.GeneratedMessage {
  factory DeleteLockFundAutoSaveResponse({
    $core.bool? success,
    $core.String? message,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    return result;
  }

  DeleteLockFundAutoSaveResponse._();

  factory DeleteLockFundAutoSaveResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeleteLockFundAutoSaveResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteLockFundAutoSaveResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteLockFundAutoSaveResponse clone() =>
      DeleteLockFundAutoSaveResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteLockFundAutoSaveResponse copyWith(
          void Function(DeleteLockFundAutoSaveResponse) updates) =>
      super.copyWith(
              (message) => updates(message as DeleteLockFundAutoSaveResponse))
          as DeleteLockFundAutoSaveResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteLockFundAutoSaveResponse create() =>
      DeleteLockFundAutoSaveResponse._();
  @$core.override
  DeleteLockFundAutoSaveResponse createEmptyInstance() => create();
  static $pb.PbList<DeleteLockFundAutoSaveResponse> createRepeated() =>
      $pb.PbList<DeleteLockFundAutoSaveResponse>();
  @$core.pragma('dart2js:noInline')
  static DeleteLockFundAutoSaveResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteLockFundAutoSaveResponse>(create);
  static DeleteLockFundAutoSaveResponse? _defaultInstance;

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

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
