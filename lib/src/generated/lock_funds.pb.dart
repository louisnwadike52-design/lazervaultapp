///
//  Generated code. Do not modify.
//  source: lock_funds.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/timestamp.pb.dart' as $1;

import 'lock_funds.pbenum.dart';

export 'lock_funds.pbenum.dart';

class LockFund extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'LockFund', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..a<$fixnum.Int64>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..e<LockType>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lockType', $pb.PbFieldType.OE, defaultOrMaker: LockType.LOCK_TYPE_UNSPECIFIED, valueOf: LockType.valueOf, enumValues: LockType.values)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..a<$core.int>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lockDurationDays', $pb.PbFieldType.O3)
    ..a<$core.double>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'interestRate', $pb.PbFieldType.OD)
    ..aOM<$1.Timestamp>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lockedAt', subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'unlockAt', subBuilder: $1.Timestamp.create)
    ..e<LockStatus>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: LockStatus.LOCK_STATUS_UNSPECIFIED, valueOf: LockStatus.valueOf, enumValues: LockStatus.values)
    ..aOB(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'autoRenew')
    ..aOS(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'goalName')
    ..aOS(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'goalDescription')
    ..a<$core.double>(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'earlyUnlockPenaltyPercent', $pb.PbFieldType.OD)
    ..a<$core.double>(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accruedInterest', $pb.PbFieldType.OD)
    ..aOS(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'paymentMethod')
    ..aOS(17, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionId')
    ..aOM<$1.Timestamp>(18, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(19, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedAt', subBuilder: $1.Timestamp.create)
    ..a<$core.int>(20, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'daysRemaining', $pb.PbFieldType.O3)
    ..a<$core.double>(21, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'progressPercent', $pb.PbFieldType.OD)
    ..a<$core.double>(22, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalValue', $pb.PbFieldType.OD)
    ..aOB(23, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'canUnlockEarly')
    ..aOS(24, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sourceAccountId')
    ..aOS(25, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'destinationAccountId')
    ..hasRequiredFields = false
  ;

  LockFund._() : super();
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
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    if (lockType != null) {
      _result.lockType = lockType;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (lockDurationDays != null) {
      _result.lockDurationDays = lockDurationDays;
    }
    if (interestRate != null) {
      _result.interestRate = interestRate;
    }
    if (lockedAt != null) {
      _result.lockedAt = lockedAt;
    }
    if (unlockAt != null) {
      _result.unlockAt = unlockAt;
    }
    if (status != null) {
      _result.status = status;
    }
    if (autoRenew != null) {
      _result.autoRenew = autoRenew;
    }
    if (goalName != null) {
      _result.goalName = goalName;
    }
    if (goalDescription != null) {
      _result.goalDescription = goalDescription;
    }
    if (earlyUnlockPenaltyPercent != null) {
      _result.earlyUnlockPenaltyPercent = earlyUnlockPenaltyPercent;
    }
    if (accruedInterest != null) {
      _result.accruedInterest = accruedInterest;
    }
    if (paymentMethod != null) {
      _result.paymentMethod = paymentMethod;
    }
    if (transactionId != null) {
      _result.transactionId = transactionId;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      _result.updatedAt = updatedAt;
    }
    if (daysRemaining != null) {
      _result.daysRemaining = daysRemaining;
    }
    if (progressPercent != null) {
      _result.progressPercent = progressPercent;
    }
    if (totalValue != null) {
      _result.totalValue = totalValue;
    }
    if (canUnlockEarly != null) {
      _result.canUnlockEarly = canUnlockEarly;
    }
    if (sourceAccountId != null) {
      _result.sourceAccountId = sourceAccountId;
    }
    if (destinationAccountId != null) {
      _result.destinationAccountId = destinationAccountId;
    }
    return _result;
  }
  factory LockFund.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LockFund.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LockFund clone() => LockFund()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LockFund copyWith(void Function(LockFund) updates) => super.copyWith((message) => updates(message as LockFund)) as LockFund; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static LockFund create() => LockFund._();
  LockFund createEmptyInstance() => create();
  static $pb.PbList<LockFund> createRepeated() => $pb.PbList<LockFund>();
  @$core.pragma('dart2js:noInline')
  static LockFund getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LockFund>(create);
  static LockFund? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get userId => $_getI64(1);
  @$pb.TagNumber(2)
  set userId($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => clearField(2);

  @$pb.TagNumber(3)
  LockType get lockType => $_getN(2);
  @$pb.TagNumber(3)
  set lockType(LockType v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasLockType() => $_has(2);
  @$pb.TagNumber(3)
  void clearLockType() => clearField(3);

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
  $core.int get lockDurationDays => $_getIZ(5);
  @$pb.TagNumber(6)
  set lockDurationDays($core.int v) { $_setSignedInt32(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasLockDurationDays() => $_has(5);
  @$pb.TagNumber(6)
  void clearLockDurationDays() => clearField(6);

  @$pb.TagNumber(7)
  $core.double get interestRate => $_getN(6);
  @$pb.TagNumber(7)
  set interestRate($core.double v) { $_setDouble(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasInterestRate() => $_has(6);
  @$pb.TagNumber(7)
  void clearInterestRate() => clearField(7);

  @$pb.TagNumber(8)
  $1.Timestamp get lockedAt => $_getN(7);
  @$pb.TagNumber(8)
  set lockedAt($1.Timestamp v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasLockedAt() => $_has(7);
  @$pb.TagNumber(8)
  void clearLockedAt() => clearField(8);
  @$pb.TagNumber(8)
  $1.Timestamp ensureLockedAt() => $_ensure(7);

  @$pb.TagNumber(9)
  $1.Timestamp get unlockAt => $_getN(8);
  @$pb.TagNumber(9)
  set unlockAt($1.Timestamp v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasUnlockAt() => $_has(8);
  @$pb.TagNumber(9)
  void clearUnlockAt() => clearField(9);
  @$pb.TagNumber(9)
  $1.Timestamp ensureUnlockAt() => $_ensure(8);

  @$pb.TagNumber(10)
  LockStatus get status => $_getN(9);
  @$pb.TagNumber(10)
  set status(LockStatus v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasStatus() => $_has(9);
  @$pb.TagNumber(10)
  void clearStatus() => clearField(10);

  @$pb.TagNumber(11)
  $core.bool get autoRenew => $_getBF(10);
  @$pb.TagNumber(11)
  set autoRenew($core.bool v) { $_setBool(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasAutoRenew() => $_has(10);
  @$pb.TagNumber(11)
  void clearAutoRenew() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get goalName => $_getSZ(11);
  @$pb.TagNumber(12)
  set goalName($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasGoalName() => $_has(11);
  @$pb.TagNumber(12)
  void clearGoalName() => clearField(12);

  @$pb.TagNumber(13)
  $core.String get goalDescription => $_getSZ(12);
  @$pb.TagNumber(13)
  set goalDescription($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasGoalDescription() => $_has(12);
  @$pb.TagNumber(13)
  void clearGoalDescription() => clearField(13);

  @$pb.TagNumber(14)
  $core.double get earlyUnlockPenaltyPercent => $_getN(13);
  @$pb.TagNumber(14)
  set earlyUnlockPenaltyPercent($core.double v) { $_setDouble(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasEarlyUnlockPenaltyPercent() => $_has(13);
  @$pb.TagNumber(14)
  void clearEarlyUnlockPenaltyPercent() => clearField(14);

  @$pb.TagNumber(15)
  $core.double get accruedInterest => $_getN(14);
  @$pb.TagNumber(15)
  set accruedInterest($core.double v) { $_setDouble(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasAccruedInterest() => $_has(14);
  @$pb.TagNumber(15)
  void clearAccruedInterest() => clearField(15);

  @$pb.TagNumber(16)
  $core.String get paymentMethod => $_getSZ(15);
  @$pb.TagNumber(16)
  set paymentMethod($core.String v) { $_setString(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasPaymentMethod() => $_has(15);
  @$pb.TagNumber(16)
  void clearPaymentMethod() => clearField(16);

  @$pb.TagNumber(17)
  $core.String get transactionId => $_getSZ(16);
  @$pb.TagNumber(17)
  set transactionId($core.String v) { $_setString(16, v); }
  @$pb.TagNumber(17)
  $core.bool hasTransactionId() => $_has(16);
  @$pb.TagNumber(17)
  void clearTransactionId() => clearField(17);

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
  $1.Timestamp get updatedAt => $_getN(18);
  @$pb.TagNumber(19)
  set updatedAt($1.Timestamp v) { setField(19, v); }
  @$pb.TagNumber(19)
  $core.bool hasUpdatedAt() => $_has(18);
  @$pb.TagNumber(19)
  void clearUpdatedAt() => clearField(19);
  @$pb.TagNumber(19)
  $1.Timestamp ensureUpdatedAt() => $_ensure(18);

  @$pb.TagNumber(20)
  $core.int get daysRemaining => $_getIZ(19);
  @$pb.TagNumber(20)
  set daysRemaining($core.int v) { $_setSignedInt32(19, v); }
  @$pb.TagNumber(20)
  $core.bool hasDaysRemaining() => $_has(19);
  @$pb.TagNumber(20)
  void clearDaysRemaining() => clearField(20);

  @$pb.TagNumber(21)
  $core.double get progressPercent => $_getN(20);
  @$pb.TagNumber(21)
  set progressPercent($core.double v) { $_setDouble(20, v); }
  @$pb.TagNumber(21)
  $core.bool hasProgressPercent() => $_has(20);
  @$pb.TagNumber(21)
  void clearProgressPercent() => clearField(21);

  @$pb.TagNumber(22)
  $core.double get totalValue => $_getN(21);
  @$pb.TagNumber(22)
  set totalValue($core.double v) { $_setDouble(21, v); }
  @$pb.TagNumber(22)
  $core.bool hasTotalValue() => $_has(21);
  @$pb.TagNumber(22)
  void clearTotalValue() => clearField(22);

  @$pb.TagNumber(23)
  $core.bool get canUnlockEarly => $_getBF(22);
  @$pb.TagNumber(23)
  set canUnlockEarly($core.bool v) { $_setBool(22, v); }
  @$pb.TagNumber(23)
  $core.bool hasCanUnlockEarly() => $_has(22);
  @$pb.TagNumber(23)
  void clearCanUnlockEarly() => clearField(23);

  @$pb.TagNumber(24)
  $core.String get sourceAccountId => $_getSZ(23);
  @$pb.TagNumber(24)
  set sourceAccountId($core.String v) { $_setString(23, v); }
  @$pb.TagNumber(24)
  $core.bool hasSourceAccountId() => $_has(23);
  @$pb.TagNumber(24)
  void clearSourceAccountId() => clearField(24);

  @$pb.TagNumber(25)
  $core.String get destinationAccountId => $_getSZ(24);
  @$pb.TagNumber(25)
  set destinationAccountId($core.String v) { $_setString(24, v); }
  @$pb.TagNumber(25)
  $core.bool hasDestinationAccountId() => $_has(24);
  @$pb.TagNumber(25)
  void clearDestinationAccountId() => clearField(25);
}

class LockTransaction extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'LockTransaction', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lockFundId')
    ..a<$fixnum.Int64>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionType')
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'paymentMethod')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..aOM<$1.Timestamp>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionDate', subBuilder: $1.Timestamp.create)
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..hasRequiredFields = false
  ;

  LockTransaction._() : super();
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
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (lockFundId != null) {
      _result.lockFundId = lockFundId;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    if (transactionType != null) {
      _result.transactionType = transactionType;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (paymentMethod != null) {
      _result.paymentMethod = paymentMethod;
    }
    if (status != null) {
      _result.status = status;
    }
    if (transactionDate != null) {
      _result.transactionDate = transactionDate;
    }
    if (description != null) {
      _result.description = description;
    }
    return _result;
  }
  factory LockTransaction.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LockTransaction.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LockTransaction clone() => LockTransaction()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LockTransaction copyWith(void Function(LockTransaction) updates) => super.copyWith((message) => updates(message as LockTransaction)) as LockTransaction; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static LockTransaction create() => LockTransaction._();
  LockTransaction createEmptyInstance() => create();
  static $pb.PbList<LockTransaction> createRepeated() => $pb.PbList<LockTransaction>();
  @$core.pragma('dart2js:noInline')
  static LockTransaction getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LockTransaction>(create);
  static LockTransaction? _defaultInstance;

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
  $fixnum.Int64 get userId => $_getI64(2);
  @$pb.TagNumber(3)
  set userId($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasUserId() => $_has(2);
  @$pb.TagNumber(3)
  void clearUserId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get transactionType => $_getSZ(3);
  @$pb.TagNumber(4)
  set transactionType($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTransactionType() => $_has(3);
  @$pb.TagNumber(4)
  void clearTransactionType() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get amount => $_getN(4);
  @$pb.TagNumber(5)
  set amount($core.double v) { $_setDouble(4, v); }
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
  $core.String get paymentMethod => $_getSZ(6);
  @$pb.TagNumber(7)
  set paymentMethod($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasPaymentMethod() => $_has(6);
  @$pb.TagNumber(7)
  void clearPaymentMethod() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get status => $_getSZ(7);
  @$pb.TagNumber(8)
  set status($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasStatus() => $_has(7);
  @$pb.TagNumber(8)
  void clearStatus() => clearField(8);

  @$pb.TagNumber(9)
  $1.Timestamp get transactionDate => $_getN(8);
  @$pb.TagNumber(9)
  set transactionDate($1.Timestamp v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasTransactionDate() => $_has(8);
  @$pb.TagNumber(9)
  void clearTransactionDate() => clearField(9);
  @$pb.TagNumber(9)
  $1.Timestamp ensureTransactionDate() => $_ensure(8);

  @$pb.TagNumber(10)
  $core.String get description => $_getSZ(9);
  @$pb.TagNumber(10)
  set description($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasDescription() => $_has(9);
  @$pb.TagNumber(10)
  void clearDescription() => clearField(10);
}

class PiggyVaultConfig extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PiggyVaultConfig', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lockType')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'displayName')
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'baseInterestRate', $pb.PbFieldType.OD)
    ..a<$core.double>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'maxInterestRate', $pb.PbFieldType.OD)
    ..a<$core.double>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'earlyWithdrawalPenalty', $pb.PbFieldType.OD)
    ..a<$core.int>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'minDurationDays', $pb.PbFieldType.O3)
    ..a<$core.int>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'maxDurationDays', $pb.PbFieldType.O3)
    ..a<$core.double>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'minAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'maxAmount', $pb.PbFieldType.OD)
    ..aOB(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'allowsEarlyWithdrawal')
    ..aOB(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'supportsAutoRenew')
    ..aOB(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'supportsTopUp')
    ..aOB(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'supportsAutoSave')
    ..aOB(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'supportsUpfrontInterest')
    ..aOS(17, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'durationBonusTiers')
    ..aOB(18, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isActive')
    ..aOS(19, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..hasRequiredFields = false
  ;

  PiggyVaultConfig._() : super();
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
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (lockType != null) {
      _result.lockType = lockType;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (displayName != null) {
      _result.displayName = displayName;
    }
    if (baseInterestRate != null) {
      _result.baseInterestRate = baseInterestRate;
    }
    if (maxInterestRate != null) {
      _result.maxInterestRate = maxInterestRate;
    }
    if (earlyWithdrawalPenalty != null) {
      _result.earlyWithdrawalPenalty = earlyWithdrawalPenalty;
    }
    if (minDurationDays != null) {
      _result.minDurationDays = minDurationDays;
    }
    if (maxDurationDays != null) {
      _result.maxDurationDays = maxDurationDays;
    }
    if (minAmount != null) {
      _result.minAmount = minAmount;
    }
    if (maxAmount != null) {
      _result.maxAmount = maxAmount;
    }
    if (allowsEarlyWithdrawal != null) {
      _result.allowsEarlyWithdrawal = allowsEarlyWithdrawal;
    }
    if (supportsAutoRenew != null) {
      _result.supportsAutoRenew = supportsAutoRenew;
    }
    if (supportsTopUp != null) {
      _result.supportsTopUp = supportsTopUp;
    }
    if (supportsAutoSave != null) {
      _result.supportsAutoSave = supportsAutoSave;
    }
    if (supportsUpfrontInterest != null) {
      _result.supportsUpfrontInterest = supportsUpfrontInterest;
    }
    if (durationBonusTiers != null) {
      _result.durationBonusTiers = durationBonusTiers;
    }
    if (isActive != null) {
      _result.isActive = isActive;
    }
    if (description != null) {
      _result.description = description;
    }
    return _result;
  }
  factory PiggyVaultConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PiggyVaultConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PiggyVaultConfig clone() => PiggyVaultConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PiggyVaultConfig copyWith(void Function(PiggyVaultConfig) updates) => super.copyWith((message) => updates(message as PiggyVaultConfig)) as PiggyVaultConfig; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PiggyVaultConfig create() => PiggyVaultConfig._();
  PiggyVaultConfig createEmptyInstance() => create();
  static $pb.PbList<PiggyVaultConfig> createRepeated() => $pb.PbList<PiggyVaultConfig>();
  @$core.pragma('dart2js:noInline')
  static PiggyVaultConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PiggyVaultConfig>(create);
  static PiggyVaultConfig? _defaultInstance;

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

class LockFundAutoSave extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'LockFundAutoSave', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lockFundId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sourceAccountId')
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'frequency')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'nextRunAt')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lastRunAt')
    ..a<$core.double>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalSaved', $pb.PbFieldType.OD)
    ..a<$core.int>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'runCount', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  LockFundAutoSave._() : super();
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
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (lockFundId != null) {
      _result.lockFundId = lockFundId;
    }
    if (sourceAccountId != null) {
      _result.sourceAccountId = sourceAccountId;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (frequency != null) {
      _result.frequency = frequency;
    }
    if (status != null) {
      _result.status = status;
    }
    if (nextRunAt != null) {
      _result.nextRunAt = nextRunAt;
    }
    if (lastRunAt != null) {
      _result.lastRunAt = lastRunAt;
    }
    if (totalSaved != null) {
      _result.totalSaved = totalSaved;
    }
    if (runCount != null) {
      _result.runCount = runCount;
    }
    return _result;
  }
  factory LockFundAutoSave.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LockFundAutoSave.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LockFundAutoSave clone() => LockFundAutoSave()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LockFundAutoSave copyWith(void Function(LockFundAutoSave) updates) => super.copyWith((message) => updates(message as LockFundAutoSave)) as LockFundAutoSave; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static LockFundAutoSave create() => LockFundAutoSave._();
  LockFundAutoSave createEmptyInstance() => create();
  static $pb.PbList<LockFundAutoSave> createRepeated() => $pb.PbList<LockFundAutoSave>();
  @$core.pragma('dart2js:noInline')
  static LockFundAutoSave getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LockFundAutoSave>(create);
  static LockFundAutoSave? _defaultInstance;

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
  $core.String get sourceAccountId => $_getSZ(2);
  @$pb.TagNumber(3)
  set sourceAccountId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSourceAccountId() => $_has(2);
  @$pb.TagNumber(3)
  void clearSourceAccountId() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get amount => $_getN(3);
  @$pb.TagNumber(4)
  set amount($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearAmount() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get frequency => $_getSZ(4);
  @$pb.TagNumber(5)
  set frequency($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasFrequency() => $_has(4);
  @$pb.TagNumber(5)
  void clearFrequency() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get status => $_getSZ(5);
  @$pb.TagNumber(6)
  set status($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasStatus() => $_has(5);
  @$pb.TagNumber(6)
  void clearStatus() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get nextRunAt => $_getSZ(6);
  @$pb.TagNumber(7)
  set nextRunAt($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasNextRunAt() => $_has(6);
  @$pb.TagNumber(7)
  void clearNextRunAt() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get lastRunAt => $_getSZ(7);
  @$pb.TagNumber(8)
  set lastRunAt($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasLastRunAt() => $_has(7);
  @$pb.TagNumber(8)
  void clearLastRunAt() => clearField(8);

  @$pb.TagNumber(9)
  $core.double get totalSaved => $_getN(8);
  @$pb.TagNumber(9)
  set totalSaved($core.double v) { $_setDouble(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasTotalSaved() => $_has(8);
  @$pb.TagNumber(9)
  void clearTotalSaved() => clearField(9);

  @$pb.TagNumber(10)
  $core.int get runCount => $_getIZ(9);
  @$pb.TagNumber(10)
  set runCount($core.int v) { $_setSignedInt32(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasRunCount() => $_has(9);
  @$pb.TagNumber(10)
  void clearRunCount() => clearField(10);
}

class CreateLockFundRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateLockFundRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..e<LockType>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lockType', $pb.PbFieldType.OE, defaultOrMaker: LockType.LOCK_TYPE_UNSPECIFIED, valueOf: LockType.valueOf, enumValues: LockType.values)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lockDurationDays', $pb.PbFieldType.O3)
    ..aOB(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'autoRenew')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'goalName')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'goalDescription')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'paymentMethod')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sourceAccountId')
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionPin')
    ..hasRequiredFields = false
  ;

  CreateLockFundRequest._() : super();
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
    final _result = create();
    if (lockType != null) {
      _result.lockType = lockType;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (lockDurationDays != null) {
      _result.lockDurationDays = lockDurationDays;
    }
    if (autoRenew != null) {
      _result.autoRenew = autoRenew;
    }
    if (goalName != null) {
      _result.goalName = goalName;
    }
    if (goalDescription != null) {
      _result.goalDescription = goalDescription;
    }
    if (paymentMethod != null) {
      _result.paymentMethod = paymentMethod;
    }
    if (sourceAccountId != null) {
      _result.sourceAccountId = sourceAccountId;
    }
    if (transactionPin != null) {
      _result.transactionPin = transactionPin;
    }
    return _result;
  }
  factory CreateLockFundRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateLockFundRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateLockFundRequest clone() => CreateLockFundRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateLockFundRequest copyWith(void Function(CreateLockFundRequest) updates) => super.copyWith((message) => updates(message as CreateLockFundRequest)) as CreateLockFundRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateLockFundRequest create() => CreateLockFundRequest._();
  CreateLockFundRequest createEmptyInstance() => create();
  static $pb.PbList<CreateLockFundRequest> createRepeated() => $pb.PbList<CreateLockFundRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateLockFundRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateLockFundRequest>(create);
  static CreateLockFundRequest? _defaultInstance;

  @$pb.TagNumber(1)
  LockType get lockType => $_getN(0);
  @$pb.TagNumber(1)
  set lockType(LockType v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasLockType() => $_has(0);
  @$pb.TagNumber(1)
  void clearLockType() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get amount => $_getN(1);
  @$pb.TagNumber(2)
  set amount($core.double v) { $_setDouble(1, v); }
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
  $core.int get lockDurationDays => $_getIZ(3);
  @$pb.TagNumber(4)
  set lockDurationDays($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasLockDurationDays() => $_has(3);
  @$pb.TagNumber(4)
  void clearLockDurationDays() => clearField(4);

  @$pb.TagNumber(5)
  $core.bool get autoRenew => $_getBF(4);
  @$pb.TagNumber(5)
  set autoRenew($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasAutoRenew() => $_has(4);
  @$pb.TagNumber(5)
  void clearAutoRenew() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get goalName => $_getSZ(5);
  @$pb.TagNumber(6)
  set goalName($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasGoalName() => $_has(5);
  @$pb.TagNumber(6)
  void clearGoalName() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get goalDescription => $_getSZ(6);
  @$pb.TagNumber(7)
  set goalDescription($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasGoalDescription() => $_has(6);
  @$pb.TagNumber(7)
  void clearGoalDescription() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get paymentMethod => $_getSZ(7);
  @$pb.TagNumber(8)
  set paymentMethod($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasPaymentMethod() => $_has(7);
  @$pb.TagNumber(8)
  void clearPaymentMethod() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get sourceAccountId => $_getSZ(8);
  @$pb.TagNumber(9)
  set sourceAccountId($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasSourceAccountId() => $_has(8);
  @$pb.TagNumber(9)
  void clearSourceAccountId() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get transactionPin => $_getSZ(9);
  @$pb.TagNumber(10)
  set transactionPin($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasTransactionPin() => $_has(9);
  @$pb.TagNumber(10)
  void clearTransactionPin() => clearField(10);
}

class CreateLockFundResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateLockFundResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOM<LockFund>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lockFund', subBuilder: LockFund.create)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'paymentUrl')
    ..hasRequiredFields = false
  ;

  CreateLockFundResponse._() : super();
  factory CreateLockFundResponse({
    $core.bool? success,
    $core.String? message,
    LockFund? lockFund,
    $core.String? paymentUrl,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (lockFund != null) {
      _result.lockFund = lockFund;
    }
    if (paymentUrl != null) {
      _result.paymentUrl = paymentUrl;
    }
    return _result;
  }
  factory CreateLockFundResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateLockFundResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateLockFundResponse clone() => CreateLockFundResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateLockFundResponse copyWith(void Function(CreateLockFundResponse) updates) => super.copyWith((message) => updates(message as CreateLockFundResponse)) as CreateLockFundResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateLockFundResponse create() => CreateLockFundResponse._();
  CreateLockFundResponse createEmptyInstance() => create();
  static $pb.PbList<CreateLockFundResponse> createRepeated() => $pb.PbList<CreateLockFundResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateLockFundResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateLockFundResponse>(create);
  static CreateLockFundResponse? _defaultInstance;

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
  LockFund get lockFund => $_getN(2);
  @$pb.TagNumber(3)
  set lockFund(LockFund v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasLockFund() => $_has(2);
  @$pb.TagNumber(3)
  void clearLockFund() => clearField(3);
  @$pb.TagNumber(3)
  LockFund ensureLockFund() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.String get paymentUrl => $_getSZ(3);
  @$pb.TagNumber(4)
  set paymentUrl($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPaymentUrl() => $_has(3);
  @$pb.TagNumber(4)
  void clearPaymentUrl() => clearField(4);
}

class GetLockFundsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetLockFundsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..e<LockStatus>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: LockStatus.LOCK_STATUS_UNSPECIFIED, valueOf: LockStatus.valueOf, enumValues: LockStatus.values)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'perPage', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetLockFundsRequest._() : super();
  factory GetLockFundsRequest({
    LockStatus? status,
    $core.int? page,
    $core.int? perPage,
  }) {
    final _result = create();
    if (status != null) {
      _result.status = status;
    }
    if (page != null) {
      _result.page = page;
    }
    if (perPage != null) {
      _result.perPage = perPage;
    }
    return _result;
  }
  factory GetLockFundsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetLockFundsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetLockFundsRequest clone() => GetLockFundsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetLockFundsRequest copyWith(void Function(GetLockFundsRequest) updates) => super.copyWith((message) => updates(message as GetLockFundsRequest)) as GetLockFundsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetLockFundsRequest create() => GetLockFundsRequest._();
  GetLockFundsRequest createEmptyInstance() => create();
  static $pb.PbList<GetLockFundsRequest> createRepeated() => $pb.PbList<GetLockFundsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetLockFundsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetLockFundsRequest>(create);
  static GetLockFundsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  LockStatus get status => $_getN(0);
  @$pb.TagNumber(1)
  set status(LockStatus v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => clearField(1);

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

class GetLockFundsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetLockFundsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<LockFund>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lockFunds', $pb.PbFieldType.PM, subBuilder: LockFund.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalCount', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalPages', $pb.PbFieldType.O3)
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalLockedAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalAccruedInterest', $pb.PbFieldType.OD)
    ..a<$core.int>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'activeLocksCount', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetLockFundsResponse._() : super();
  factory GetLockFundsResponse({
    $core.Iterable<LockFund>? lockFunds,
    $core.int? totalCount,
    $core.int? page,
    $core.int? totalPages,
    $core.double? totalLockedAmount,
    $core.double? totalAccruedInterest,
    $core.int? activeLocksCount,
  }) {
    final _result = create();
    if (lockFunds != null) {
      _result.lockFunds.addAll(lockFunds);
    }
    if (totalCount != null) {
      _result.totalCount = totalCount;
    }
    if (page != null) {
      _result.page = page;
    }
    if (totalPages != null) {
      _result.totalPages = totalPages;
    }
    if (totalLockedAmount != null) {
      _result.totalLockedAmount = totalLockedAmount;
    }
    if (totalAccruedInterest != null) {
      _result.totalAccruedInterest = totalAccruedInterest;
    }
    if (activeLocksCount != null) {
      _result.activeLocksCount = activeLocksCount;
    }
    return _result;
  }
  factory GetLockFundsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetLockFundsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetLockFundsResponse clone() => GetLockFundsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetLockFundsResponse copyWith(void Function(GetLockFundsResponse) updates) => super.copyWith((message) => updates(message as GetLockFundsResponse)) as GetLockFundsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetLockFundsResponse create() => GetLockFundsResponse._();
  GetLockFundsResponse createEmptyInstance() => create();
  static $pb.PbList<GetLockFundsResponse> createRepeated() => $pb.PbList<GetLockFundsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetLockFundsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetLockFundsResponse>(create);
  static GetLockFundsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<LockFund> get lockFunds => $_getList(0);

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
  $core.int get totalPages => $_getIZ(3);
  @$pb.TagNumber(4)
  set totalPages($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTotalPages() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalPages() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get totalLockedAmount => $_getN(4);
  @$pb.TagNumber(5)
  set totalLockedAmount($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTotalLockedAmount() => $_has(4);
  @$pb.TagNumber(5)
  void clearTotalLockedAmount() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get totalAccruedInterest => $_getN(5);
  @$pb.TagNumber(6)
  set totalAccruedInterest($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasTotalAccruedInterest() => $_has(5);
  @$pb.TagNumber(6)
  void clearTotalAccruedInterest() => clearField(6);

  @$pb.TagNumber(7)
  $core.int get activeLocksCount => $_getIZ(6);
  @$pb.TagNumber(7)
  set activeLocksCount($core.int v) { $_setSignedInt32(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasActiveLocksCount() => $_has(6);
  @$pb.TagNumber(7)
  void clearActiveLocksCount() => clearField(7);
}

class GetLockFundRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetLockFundRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lockFundId')
    ..hasRequiredFields = false
  ;

  GetLockFundRequest._() : super();
  factory GetLockFundRequest({
    $core.String? lockFundId,
  }) {
    final _result = create();
    if (lockFundId != null) {
      _result.lockFundId = lockFundId;
    }
    return _result;
  }
  factory GetLockFundRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetLockFundRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetLockFundRequest clone() => GetLockFundRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetLockFundRequest copyWith(void Function(GetLockFundRequest) updates) => super.copyWith((message) => updates(message as GetLockFundRequest)) as GetLockFundRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetLockFundRequest create() => GetLockFundRequest._();
  GetLockFundRequest createEmptyInstance() => create();
  static $pb.PbList<GetLockFundRequest> createRepeated() => $pb.PbList<GetLockFundRequest>();
  @$core.pragma('dart2js:noInline')
  static GetLockFundRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetLockFundRequest>(create);
  static GetLockFundRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get lockFundId => $_getSZ(0);
  @$pb.TagNumber(1)
  set lockFundId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLockFundId() => $_has(0);
  @$pb.TagNumber(1)
  void clearLockFundId() => clearField(1);
}

class GetLockFundResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetLockFundResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOM<LockFund>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lockFund', subBuilder: LockFund.create)
    ..hasRequiredFields = false
  ;

  GetLockFundResponse._() : super();
  factory GetLockFundResponse({
    $core.bool? success,
    LockFund? lockFund,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (lockFund != null) {
      _result.lockFund = lockFund;
    }
    return _result;
  }
  factory GetLockFundResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetLockFundResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetLockFundResponse clone() => GetLockFundResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetLockFundResponse copyWith(void Function(GetLockFundResponse) updates) => super.copyWith((message) => updates(message as GetLockFundResponse)) as GetLockFundResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetLockFundResponse create() => GetLockFundResponse._();
  GetLockFundResponse createEmptyInstance() => create();
  static $pb.PbList<GetLockFundResponse> createRepeated() => $pb.PbList<GetLockFundResponse>();
  @$core.pragma('dart2js:noInline')
  static GetLockFundResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetLockFundResponse>(create);
  static GetLockFundResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  LockFund get lockFund => $_getN(1);
  @$pb.TagNumber(2)
  set lockFund(LockFund v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasLockFund() => $_has(1);
  @$pb.TagNumber(2)
  void clearLockFund() => clearField(2);
  @$pb.TagNumber(2)
  LockFund ensureLockFund() => $_ensure(1);
}

class UnlockFundRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UnlockFundRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lockFundId')
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'forceEarlyUnlock')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionPin')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'destinationAccountId')
    ..hasRequiredFields = false
  ;

  UnlockFundRequest._() : super();
  factory UnlockFundRequest({
    $core.String? lockFundId,
    $core.bool? forceEarlyUnlock,
    $core.String? transactionPin,
    $core.String? destinationAccountId,
  }) {
    final _result = create();
    if (lockFundId != null) {
      _result.lockFundId = lockFundId;
    }
    if (forceEarlyUnlock != null) {
      _result.forceEarlyUnlock = forceEarlyUnlock;
    }
    if (transactionPin != null) {
      _result.transactionPin = transactionPin;
    }
    if (destinationAccountId != null) {
      _result.destinationAccountId = destinationAccountId;
    }
    return _result;
  }
  factory UnlockFundRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UnlockFundRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UnlockFundRequest clone() => UnlockFundRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UnlockFundRequest copyWith(void Function(UnlockFundRequest) updates) => super.copyWith((message) => updates(message as UnlockFundRequest)) as UnlockFundRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UnlockFundRequest create() => UnlockFundRequest._();
  UnlockFundRequest createEmptyInstance() => create();
  static $pb.PbList<UnlockFundRequest> createRepeated() => $pb.PbList<UnlockFundRequest>();
  @$core.pragma('dart2js:noInline')
  static UnlockFundRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UnlockFundRequest>(create);
  static UnlockFundRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get lockFundId => $_getSZ(0);
  @$pb.TagNumber(1)
  set lockFundId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLockFundId() => $_has(0);
  @$pb.TagNumber(1)
  void clearLockFundId() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get forceEarlyUnlock => $_getBF(1);
  @$pb.TagNumber(2)
  set forceEarlyUnlock($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasForceEarlyUnlock() => $_has(1);
  @$pb.TagNumber(2)
  void clearForceEarlyUnlock() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get transactionPin => $_getSZ(2);
  @$pb.TagNumber(3)
  set transactionPin($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTransactionPin() => $_has(2);
  @$pb.TagNumber(3)
  void clearTransactionPin() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get destinationAccountId => $_getSZ(3);
  @$pb.TagNumber(4)
  set destinationAccountId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasDestinationAccountId() => $_has(3);
  @$pb.TagNumber(4)
  void clearDestinationAccountId() => clearField(4);
}

class UnlockFundResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UnlockFundResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amountReturned', $pb.PbFieldType.OD)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'penaltyAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'interestEarned', $pb.PbFieldType.OD)
    ..aOM<LockFund>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedLockFund', subBuilder: LockFund.create)
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'creditedAccountId')
    ..hasRequiredFields = false
  ;

  UnlockFundResponse._() : super();
  factory UnlockFundResponse({
    $core.bool? success,
    $core.String? message,
    $core.double? amountReturned,
    $core.double? penaltyAmount,
    $core.double? interestEarned,
    LockFund? updatedLockFund,
    $core.String? creditedAccountId,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (amountReturned != null) {
      _result.amountReturned = amountReturned;
    }
    if (penaltyAmount != null) {
      _result.penaltyAmount = penaltyAmount;
    }
    if (interestEarned != null) {
      _result.interestEarned = interestEarned;
    }
    if (updatedLockFund != null) {
      _result.updatedLockFund = updatedLockFund;
    }
    if (creditedAccountId != null) {
      _result.creditedAccountId = creditedAccountId;
    }
    return _result;
  }
  factory UnlockFundResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UnlockFundResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UnlockFundResponse clone() => UnlockFundResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UnlockFundResponse copyWith(void Function(UnlockFundResponse) updates) => super.copyWith((message) => updates(message as UnlockFundResponse)) as UnlockFundResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UnlockFundResponse create() => UnlockFundResponse._();
  UnlockFundResponse createEmptyInstance() => create();
  static $pb.PbList<UnlockFundResponse> createRepeated() => $pb.PbList<UnlockFundResponse>();
  @$core.pragma('dart2js:noInline')
  static UnlockFundResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UnlockFundResponse>(create);
  static UnlockFundResponse? _defaultInstance;

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
  $core.double get amountReturned => $_getN(2);
  @$pb.TagNumber(3)
  set amountReturned($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAmountReturned() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmountReturned() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get penaltyAmount => $_getN(3);
  @$pb.TagNumber(4)
  set penaltyAmount($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPenaltyAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearPenaltyAmount() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get interestEarned => $_getN(4);
  @$pb.TagNumber(5)
  set interestEarned($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasInterestEarned() => $_has(4);
  @$pb.TagNumber(5)
  void clearInterestEarned() => clearField(5);

  @$pb.TagNumber(6)
  LockFund get updatedLockFund => $_getN(5);
  @$pb.TagNumber(6)
  set updatedLockFund(LockFund v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasUpdatedLockFund() => $_has(5);
  @$pb.TagNumber(6)
  void clearUpdatedLockFund() => clearField(6);
  @$pb.TagNumber(6)
  LockFund ensureUpdatedLockFund() => $_ensure(5);

  @$pb.TagNumber(7)
  $core.String get creditedAccountId => $_getSZ(6);
  @$pb.TagNumber(7)
  set creditedAccountId($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasCreditedAccountId() => $_has(6);
  @$pb.TagNumber(7)
  void clearCreditedAccountId() => clearField(7);
}

class TopUpLockFundRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TopUpLockFundRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lockFundId')
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionPin')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sourceAccountId')
    ..hasRequiredFields = false
  ;

  TopUpLockFundRequest._() : super();
  factory TopUpLockFundRequest({
    $core.String? lockFundId,
    $core.double? amount,
    $core.String? transactionPin,
    $core.String? sourceAccountId,
  }) {
    final _result = create();
    if (lockFundId != null) {
      _result.lockFundId = lockFundId;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (transactionPin != null) {
      _result.transactionPin = transactionPin;
    }
    if (sourceAccountId != null) {
      _result.sourceAccountId = sourceAccountId;
    }
    return _result;
  }
  factory TopUpLockFundRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TopUpLockFundRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TopUpLockFundRequest clone() => TopUpLockFundRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TopUpLockFundRequest copyWith(void Function(TopUpLockFundRequest) updates) => super.copyWith((message) => updates(message as TopUpLockFundRequest)) as TopUpLockFundRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TopUpLockFundRequest create() => TopUpLockFundRequest._();
  TopUpLockFundRequest createEmptyInstance() => create();
  static $pb.PbList<TopUpLockFundRequest> createRepeated() => $pb.PbList<TopUpLockFundRequest>();
  @$core.pragma('dart2js:noInline')
  static TopUpLockFundRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TopUpLockFundRequest>(create);
  static TopUpLockFundRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get lockFundId => $_getSZ(0);
  @$pb.TagNumber(1)
  set lockFundId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLockFundId() => $_has(0);
  @$pb.TagNumber(1)
  void clearLockFundId() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get amount => $_getN(1);
  @$pb.TagNumber(2)
  set amount($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get transactionPin => $_getSZ(2);
  @$pb.TagNumber(3)
  set transactionPin($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTransactionPin() => $_has(2);
  @$pb.TagNumber(3)
  void clearTransactionPin() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get sourceAccountId => $_getSZ(3);
  @$pb.TagNumber(4)
  set sourceAccountId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasSourceAccountId() => $_has(3);
  @$pb.TagNumber(4)
  void clearSourceAccountId() => clearField(4);
}

class TopUpLockFundResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TopUpLockFundResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOM<LockFund>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedLockFund', subBuilder: LockFund.create)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'newBalance', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  TopUpLockFundResponse._() : super();
  factory TopUpLockFundResponse({
    $core.bool? success,
    $core.String? message,
    LockFund? updatedLockFund,
    $core.double? newBalance,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (updatedLockFund != null) {
      _result.updatedLockFund = updatedLockFund;
    }
    if (newBalance != null) {
      _result.newBalance = newBalance;
    }
    return _result;
  }
  factory TopUpLockFundResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TopUpLockFundResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TopUpLockFundResponse clone() => TopUpLockFundResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TopUpLockFundResponse copyWith(void Function(TopUpLockFundResponse) updates) => super.copyWith((message) => updates(message as TopUpLockFundResponse)) as TopUpLockFundResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TopUpLockFundResponse create() => TopUpLockFundResponse._();
  TopUpLockFundResponse createEmptyInstance() => create();
  static $pb.PbList<TopUpLockFundResponse> createRepeated() => $pb.PbList<TopUpLockFundResponse>();
  @$core.pragma('dart2js:noInline')
  static TopUpLockFundResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TopUpLockFundResponse>(create);
  static TopUpLockFundResponse? _defaultInstance;

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
  LockFund get updatedLockFund => $_getN(2);
  @$pb.TagNumber(3)
  set updatedLockFund(LockFund v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasUpdatedLockFund() => $_has(2);
  @$pb.TagNumber(3)
  void clearUpdatedLockFund() => clearField(3);
  @$pb.TagNumber(3)
  LockFund ensureUpdatedLockFund() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.double get newBalance => $_getN(3);
  @$pb.TagNumber(4)
  set newBalance($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasNewBalance() => $_has(3);
  @$pb.TagNumber(4)
  void clearNewBalance() => clearField(4);
}

class GetLockTransactionsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetLockTransactionsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lockFundId')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'perPage', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetLockTransactionsRequest._() : super();
  factory GetLockTransactionsRequest({
    $core.String? lockFundId,
    $core.int? page,
    $core.int? perPage,
  }) {
    final _result = create();
    if (lockFundId != null) {
      _result.lockFundId = lockFundId;
    }
    if (page != null) {
      _result.page = page;
    }
    if (perPage != null) {
      _result.perPage = perPage;
    }
    return _result;
  }
  factory GetLockTransactionsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetLockTransactionsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetLockTransactionsRequest clone() => GetLockTransactionsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetLockTransactionsRequest copyWith(void Function(GetLockTransactionsRequest) updates) => super.copyWith((message) => updates(message as GetLockTransactionsRequest)) as GetLockTransactionsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetLockTransactionsRequest create() => GetLockTransactionsRequest._();
  GetLockTransactionsRequest createEmptyInstance() => create();
  static $pb.PbList<GetLockTransactionsRequest> createRepeated() => $pb.PbList<GetLockTransactionsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetLockTransactionsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetLockTransactionsRequest>(create);
  static GetLockTransactionsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get lockFundId => $_getSZ(0);
  @$pb.TagNumber(1)
  set lockFundId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLockFundId() => $_has(0);
  @$pb.TagNumber(1)
  void clearLockFundId() => clearField(1);

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

class GetLockTransactionsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetLockTransactionsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<LockTransaction>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactions', $pb.PbFieldType.PM, subBuilder: LockTransaction.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalCount', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalPages', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetLockTransactionsResponse._() : super();
  factory GetLockTransactionsResponse({
    $core.Iterable<LockTransaction>? transactions,
    $core.int? totalCount,
    $core.int? page,
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
    if (totalPages != null) {
      _result.totalPages = totalPages;
    }
    return _result;
  }
  factory GetLockTransactionsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetLockTransactionsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetLockTransactionsResponse clone() => GetLockTransactionsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetLockTransactionsResponse copyWith(void Function(GetLockTransactionsResponse) updates) => super.copyWith((message) => updates(message as GetLockTransactionsResponse)) as GetLockTransactionsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetLockTransactionsResponse create() => GetLockTransactionsResponse._();
  GetLockTransactionsResponse createEmptyInstance() => create();
  static $pb.PbList<GetLockTransactionsResponse> createRepeated() => $pb.PbList<GetLockTransactionsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetLockTransactionsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetLockTransactionsResponse>(create);
  static GetLockTransactionsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<LockTransaction> get transactions => $_getList(0);

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
  $core.int get totalPages => $_getIZ(3);
  @$pb.TagNumber(4)
  set totalPages($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTotalPages() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalPages() => clearField(4);
}

class CalculateInterestRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CalculateInterestRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..e<LockType>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lockType', $pb.PbFieldType.OE, defaultOrMaker: LockType.LOCK_TYPE_UNSPECIFIED, valueOf: LockType.valueOf, enumValues: LockType.values)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lockDurationDays', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  CalculateInterestRequest._() : super();
  factory CalculateInterestRequest({
    LockType? lockType,
    $core.double? amount,
    $core.int? lockDurationDays,
  }) {
    final _result = create();
    if (lockType != null) {
      _result.lockType = lockType;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (lockDurationDays != null) {
      _result.lockDurationDays = lockDurationDays;
    }
    return _result;
  }
  factory CalculateInterestRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CalculateInterestRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CalculateInterestRequest clone() => CalculateInterestRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CalculateInterestRequest copyWith(void Function(CalculateInterestRequest) updates) => super.copyWith((message) => updates(message as CalculateInterestRequest)) as CalculateInterestRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CalculateInterestRequest create() => CalculateInterestRequest._();
  CalculateInterestRequest createEmptyInstance() => create();
  static $pb.PbList<CalculateInterestRequest> createRepeated() => $pb.PbList<CalculateInterestRequest>();
  @$core.pragma('dart2js:noInline')
  static CalculateInterestRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CalculateInterestRequest>(create);
  static CalculateInterestRequest? _defaultInstance;

  @$pb.TagNumber(1)
  LockType get lockType => $_getN(0);
  @$pb.TagNumber(1)
  set lockType(LockType v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasLockType() => $_has(0);
  @$pb.TagNumber(1)
  void clearLockType() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get amount => $_getN(1);
  @$pb.TagNumber(2)
  set amount($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get lockDurationDays => $_getIZ(2);
  @$pb.TagNumber(3)
  set lockDurationDays($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasLockDurationDays() => $_has(2);
  @$pb.TagNumber(3)
  void clearLockDurationDays() => clearField(3);
}

class CalculateInterestResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CalculateInterestResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.double>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'interestRate', $pb.PbFieldType.OD)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'estimatedInterest', $pb.PbFieldType.OD)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalReturn', $pb.PbFieldType.OD)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'apy', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  CalculateInterestResponse._() : super();
  factory CalculateInterestResponse({
    $core.double? interestRate,
    $core.double? estimatedInterest,
    $core.double? totalReturn,
    $core.double? apy,
  }) {
    final _result = create();
    if (interestRate != null) {
      _result.interestRate = interestRate;
    }
    if (estimatedInterest != null) {
      _result.estimatedInterest = estimatedInterest;
    }
    if (totalReturn != null) {
      _result.totalReturn = totalReturn;
    }
    if (apy != null) {
      _result.apy = apy;
    }
    return _result;
  }
  factory CalculateInterestResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CalculateInterestResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CalculateInterestResponse clone() => CalculateInterestResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CalculateInterestResponse copyWith(void Function(CalculateInterestResponse) updates) => super.copyWith((message) => updates(message as CalculateInterestResponse)) as CalculateInterestResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CalculateInterestResponse create() => CalculateInterestResponse._();
  CalculateInterestResponse createEmptyInstance() => create();
  static $pb.PbList<CalculateInterestResponse> createRepeated() => $pb.PbList<CalculateInterestResponse>();
  @$core.pragma('dart2js:noInline')
  static CalculateInterestResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CalculateInterestResponse>(create);
  static CalculateInterestResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get interestRate => $_getN(0);
  @$pb.TagNumber(1)
  set interestRate($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasInterestRate() => $_has(0);
  @$pb.TagNumber(1)
  void clearInterestRate() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get estimatedInterest => $_getN(1);
  @$pb.TagNumber(2)
  set estimatedInterest($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasEstimatedInterest() => $_has(1);
  @$pb.TagNumber(2)
  void clearEstimatedInterest() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get totalReturn => $_getN(2);
  @$pb.TagNumber(3)
  set totalReturn($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTotalReturn() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalReturn() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get apy => $_getN(3);
  @$pb.TagNumber(4)
  set apy($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasApy() => $_has(3);
  @$pb.TagNumber(4)
  void clearApy() => clearField(4);
}

class RenewLockFundRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RenewLockFundRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lockFundId')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'newDurationDays', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  RenewLockFundRequest._() : super();
  factory RenewLockFundRequest({
    $core.String? lockFundId,
    $core.int? newDurationDays,
  }) {
    final _result = create();
    if (lockFundId != null) {
      _result.lockFundId = lockFundId;
    }
    if (newDurationDays != null) {
      _result.newDurationDays = newDurationDays;
    }
    return _result;
  }
  factory RenewLockFundRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RenewLockFundRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RenewLockFundRequest clone() => RenewLockFundRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RenewLockFundRequest copyWith(void Function(RenewLockFundRequest) updates) => super.copyWith((message) => updates(message as RenewLockFundRequest)) as RenewLockFundRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RenewLockFundRequest create() => RenewLockFundRequest._();
  RenewLockFundRequest createEmptyInstance() => create();
  static $pb.PbList<RenewLockFundRequest> createRepeated() => $pb.PbList<RenewLockFundRequest>();
  @$core.pragma('dart2js:noInline')
  static RenewLockFundRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RenewLockFundRequest>(create);
  static RenewLockFundRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get lockFundId => $_getSZ(0);
  @$pb.TagNumber(1)
  set lockFundId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLockFundId() => $_has(0);
  @$pb.TagNumber(1)
  void clearLockFundId() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get newDurationDays => $_getIZ(1);
  @$pb.TagNumber(2)
  set newDurationDays($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasNewDurationDays() => $_has(1);
  @$pb.TagNumber(2)
  void clearNewDurationDays() => clearField(2);
}

class RenewLockFundResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RenewLockFundResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOM<LockFund>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'renewedLockFund', subBuilder: LockFund.create)
    ..hasRequiredFields = false
  ;

  RenewLockFundResponse._() : super();
  factory RenewLockFundResponse({
    $core.bool? success,
    $core.String? message,
    LockFund? renewedLockFund,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (renewedLockFund != null) {
      _result.renewedLockFund = renewedLockFund;
    }
    return _result;
  }
  factory RenewLockFundResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RenewLockFundResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RenewLockFundResponse clone() => RenewLockFundResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RenewLockFundResponse copyWith(void Function(RenewLockFundResponse) updates) => super.copyWith((message) => updates(message as RenewLockFundResponse)) as RenewLockFundResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RenewLockFundResponse create() => RenewLockFundResponse._();
  RenewLockFundResponse createEmptyInstance() => create();
  static $pb.PbList<RenewLockFundResponse> createRepeated() => $pb.PbList<RenewLockFundResponse>();
  @$core.pragma('dart2js:noInline')
  static RenewLockFundResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RenewLockFundResponse>(create);
  static RenewLockFundResponse? _defaultInstance;

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
  LockFund get renewedLockFund => $_getN(2);
  @$pb.TagNumber(3)
  set renewedLockFund(LockFund v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasRenewedLockFund() => $_has(2);
  @$pb.TagNumber(3)
  void clearRenewedLockFund() => clearField(3);
  @$pb.TagNumber(3)
  LockFund ensureRenewedLockFund() => $_ensure(2);
}

class CancelLockFundRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CancelLockFundRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lockFundId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reason')
    ..hasRequiredFields = false
  ;

  CancelLockFundRequest._() : super();
  factory CancelLockFundRequest({
    $core.String? lockFundId,
    $core.String? reason,
  }) {
    final _result = create();
    if (lockFundId != null) {
      _result.lockFundId = lockFundId;
    }
    if (reason != null) {
      _result.reason = reason;
    }
    return _result;
  }
  factory CancelLockFundRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CancelLockFundRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CancelLockFundRequest clone() => CancelLockFundRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CancelLockFundRequest copyWith(void Function(CancelLockFundRequest) updates) => super.copyWith((message) => updates(message as CancelLockFundRequest)) as CancelLockFundRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CancelLockFundRequest create() => CancelLockFundRequest._();
  CancelLockFundRequest createEmptyInstance() => create();
  static $pb.PbList<CancelLockFundRequest> createRepeated() => $pb.PbList<CancelLockFundRequest>();
  @$core.pragma('dart2js:noInline')
  static CancelLockFundRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CancelLockFundRequest>(create);
  static CancelLockFundRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get lockFundId => $_getSZ(0);
  @$pb.TagNumber(1)
  set lockFundId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLockFundId() => $_has(0);
  @$pb.TagNumber(1)
  void clearLockFundId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get reason => $_getSZ(1);
  @$pb.TagNumber(2)
  set reason($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasReason() => $_has(1);
  @$pb.TagNumber(2)
  void clearReason() => clearField(2);
}

class CancelLockFundResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CancelLockFundResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'refundAmount', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  CancelLockFundResponse._() : super();
  factory CancelLockFundResponse({
    $core.bool? success,
    $core.String? message,
    $core.double? refundAmount,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (refundAmount != null) {
      _result.refundAmount = refundAmount;
    }
    return _result;
  }
  factory CancelLockFundResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CancelLockFundResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CancelLockFundResponse clone() => CancelLockFundResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CancelLockFundResponse copyWith(void Function(CancelLockFundResponse) updates) => super.copyWith((message) => updates(message as CancelLockFundResponse)) as CancelLockFundResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CancelLockFundResponse create() => CancelLockFundResponse._();
  CancelLockFundResponse createEmptyInstance() => create();
  static $pb.PbList<CancelLockFundResponse> createRepeated() => $pb.PbList<CancelLockFundResponse>();
  @$core.pragma('dart2js:noInline')
  static CancelLockFundResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CancelLockFundResponse>(create);
  static CancelLockFundResponse? _defaultInstance;

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
  $core.double get refundAmount => $_getN(2);
  @$pb.TagNumber(3)
  set refundAmount($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasRefundAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearRefundAmount() => clearField(3);
}

class GetPiggyVaultConfigsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetPiggyVaultConfigsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..hasRequiredFields = false
  ;

  GetPiggyVaultConfigsRequest._() : super();
  factory GetPiggyVaultConfigsRequest({
    $core.String? currency,
  }) {
    final _result = create();
    if (currency != null) {
      _result.currency = currency;
    }
    return _result;
  }
  factory GetPiggyVaultConfigsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPiggyVaultConfigsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPiggyVaultConfigsRequest clone() => GetPiggyVaultConfigsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPiggyVaultConfigsRequest copyWith(void Function(GetPiggyVaultConfigsRequest) updates) => super.copyWith((message) => updates(message as GetPiggyVaultConfigsRequest)) as GetPiggyVaultConfigsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetPiggyVaultConfigsRequest create() => GetPiggyVaultConfigsRequest._();
  GetPiggyVaultConfigsRequest createEmptyInstance() => create();
  static $pb.PbList<GetPiggyVaultConfigsRequest> createRepeated() => $pb.PbList<GetPiggyVaultConfigsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetPiggyVaultConfigsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetPiggyVaultConfigsRequest>(create);
  static GetPiggyVaultConfigsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get currency => $_getSZ(0);
  @$pb.TagNumber(1)
  set currency($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCurrency() => $_has(0);
  @$pb.TagNumber(1)
  void clearCurrency() => clearField(1);
}

class GetPiggyVaultConfigsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetPiggyVaultConfigsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<PiggyVaultConfig>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'configs', $pb.PbFieldType.PM, subBuilder: PiggyVaultConfig.create)
    ..hasRequiredFields = false
  ;

  GetPiggyVaultConfigsResponse._() : super();
  factory GetPiggyVaultConfigsResponse({
    $core.Iterable<PiggyVaultConfig>? configs,
  }) {
    final _result = create();
    if (configs != null) {
      _result.configs.addAll(configs);
    }
    return _result;
  }
  factory GetPiggyVaultConfigsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPiggyVaultConfigsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPiggyVaultConfigsResponse clone() => GetPiggyVaultConfigsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPiggyVaultConfigsResponse copyWith(void Function(GetPiggyVaultConfigsResponse) updates) => super.copyWith((message) => updates(message as GetPiggyVaultConfigsResponse)) as GetPiggyVaultConfigsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetPiggyVaultConfigsResponse create() => GetPiggyVaultConfigsResponse._();
  GetPiggyVaultConfigsResponse createEmptyInstance() => create();
  static $pb.PbList<GetPiggyVaultConfigsResponse> createRepeated() => $pb.PbList<GetPiggyVaultConfigsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetPiggyVaultConfigsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetPiggyVaultConfigsResponse>(create);
  static GetPiggyVaultConfigsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<PiggyVaultConfig> get configs => $_getList(0);
}

class CreateLockFundAutoSaveRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateLockFundAutoSaveRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lockFundId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sourceAccountId')
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'frequency')
    ..hasRequiredFields = false
  ;

  CreateLockFundAutoSaveRequest._() : super();
  factory CreateLockFundAutoSaveRequest({
    $core.String? lockFundId,
    $core.String? sourceAccountId,
    $core.double? amount,
    $core.String? frequency,
  }) {
    final _result = create();
    if (lockFundId != null) {
      _result.lockFundId = lockFundId;
    }
    if (sourceAccountId != null) {
      _result.sourceAccountId = sourceAccountId;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (frequency != null) {
      _result.frequency = frequency;
    }
    return _result;
  }
  factory CreateLockFundAutoSaveRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateLockFundAutoSaveRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateLockFundAutoSaveRequest clone() => CreateLockFundAutoSaveRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateLockFundAutoSaveRequest copyWith(void Function(CreateLockFundAutoSaveRequest) updates) => super.copyWith((message) => updates(message as CreateLockFundAutoSaveRequest)) as CreateLockFundAutoSaveRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateLockFundAutoSaveResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOM<LockFundAutoSave>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'autosave', subBuilder: LockFundAutoSave.create)
    ..hasRequiredFields = false
  ;

  CreateLockFundAutoSaveResponse._() : super();
  factory CreateLockFundAutoSaveResponse({
    $core.bool? success,
    $core.String? message,
    LockFundAutoSave? autosave,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (autosave != null) {
      _result.autosave = autosave;
    }
    return _result;
  }
  factory CreateLockFundAutoSaveResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateLockFundAutoSaveResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateLockFundAutoSaveResponse clone() => CreateLockFundAutoSaveResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateLockFundAutoSaveResponse copyWith(void Function(CreateLockFundAutoSaveResponse) updates) => super.copyWith((message) => updates(message as CreateLockFundAutoSaveResponse)) as CreateLockFundAutoSaveResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateLockFundAutoSaveResponse create() => CreateLockFundAutoSaveResponse._();
  CreateLockFundAutoSaveResponse createEmptyInstance() => create();
  static $pb.PbList<CreateLockFundAutoSaveResponse> createRepeated() => $pb.PbList<CreateLockFundAutoSaveResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateLockFundAutoSaveResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateLockFundAutoSaveResponse>(create);
  static CreateLockFundAutoSaveResponse? _defaultInstance;

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
  LockFundAutoSave get autosave => $_getN(2);
  @$pb.TagNumber(3)
  set autosave(LockFundAutoSave v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasAutosave() => $_has(2);
  @$pb.TagNumber(3)
  void clearAutosave() => clearField(3);
  @$pb.TagNumber(3)
  LockFundAutoSave ensureAutosave() => $_ensure(2);
}

class GetLockFundAutoSaveRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetLockFundAutoSaveRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lockFundId')
    ..hasRequiredFields = false
  ;

  GetLockFundAutoSaveRequest._() : super();
  factory GetLockFundAutoSaveRequest({
    $core.String? lockFundId,
  }) {
    final _result = create();
    if (lockFundId != null) {
      _result.lockFundId = lockFundId;
    }
    return _result;
  }
  factory GetLockFundAutoSaveRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetLockFundAutoSaveRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetLockFundAutoSaveRequest clone() => GetLockFundAutoSaveRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetLockFundAutoSaveRequest copyWith(void Function(GetLockFundAutoSaveRequest) updates) => super.copyWith((message) => updates(message as GetLockFundAutoSaveRequest)) as GetLockFundAutoSaveRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetLockFundAutoSaveResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<LockFundAutoSave>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'autosave', subBuilder: LockFundAutoSave.create)
    ..hasRequiredFields = false
  ;

  GetLockFundAutoSaveResponse._() : super();
  factory GetLockFundAutoSaveResponse({
    LockFundAutoSave? autosave,
  }) {
    final _result = create();
    if (autosave != null) {
      _result.autosave = autosave;
    }
    return _result;
  }
  factory GetLockFundAutoSaveResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetLockFundAutoSaveResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetLockFundAutoSaveResponse clone() => GetLockFundAutoSaveResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetLockFundAutoSaveResponse copyWith(void Function(GetLockFundAutoSaveResponse) updates) => super.copyWith((message) => updates(message as GetLockFundAutoSaveResponse)) as GetLockFundAutoSaveResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetLockFundAutoSaveResponse create() => GetLockFundAutoSaveResponse._();
  GetLockFundAutoSaveResponse createEmptyInstance() => create();
  static $pb.PbList<GetLockFundAutoSaveResponse> createRepeated() => $pb.PbList<GetLockFundAutoSaveResponse>();
  @$core.pragma('dart2js:noInline')
  static GetLockFundAutoSaveResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetLockFundAutoSaveResponse>(create);
  static GetLockFundAutoSaveResponse? _defaultInstance;

  @$pb.TagNumber(1)
  LockFundAutoSave get autosave => $_getN(0);
  @$pb.TagNumber(1)
  set autosave(LockFundAutoSave v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasAutosave() => $_has(0);
  @$pb.TagNumber(1)
  void clearAutosave() => clearField(1);
  @$pb.TagNumber(1)
  LockFundAutoSave ensureAutosave() => $_ensure(0);
}

class UpdateLockFundAutoSaveRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateLockFundAutoSaveRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'autosaveId')
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'frequency')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..hasRequiredFields = false
  ;

  UpdateLockFundAutoSaveRequest._() : super();
  factory UpdateLockFundAutoSaveRequest({
    $core.String? autosaveId,
    $core.double? amount,
    $core.String? frequency,
    $core.String? status,
  }) {
    final _result = create();
    if (autosaveId != null) {
      _result.autosaveId = autosaveId;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (frequency != null) {
      _result.frequency = frequency;
    }
    if (status != null) {
      _result.status = status;
    }
    return _result;
  }
  factory UpdateLockFundAutoSaveRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateLockFundAutoSaveRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateLockFundAutoSaveRequest clone() => UpdateLockFundAutoSaveRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateLockFundAutoSaveRequest copyWith(void Function(UpdateLockFundAutoSaveRequest) updates) => super.copyWith((message) => updates(message as UpdateLockFundAutoSaveRequest)) as UpdateLockFundAutoSaveRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateLockFundAutoSaveResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOM<LockFundAutoSave>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'autosave', subBuilder: LockFundAutoSave.create)
    ..hasRequiredFields = false
  ;

  UpdateLockFundAutoSaveResponse._() : super();
  factory UpdateLockFundAutoSaveResponse({
    $core.bool? success,
    $core.String? message,
    LockFundAutoSave? autosave,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (autosave != null) {
      _result.autosave = autosave;
    }
    return _result;
  }
  factory UpdateLockFundAutoSaveResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateLockFundAutoSaveResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateLockFundAutoSaveResponse clone() => UpdateLockFundAutoSaveResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateLockFundAutoSaveResponse copyWith(void Function(UpdateLockFundAutoSaveResponse) updates) => super.copyWith((message) => updates(message as UpdateLockFundAutoSaveResponse)) as UpdateLockFundAutoSaveResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UpdateLockFundAutoSaveResponse create() => UpdateLockFundAutoSaveResponse._();
  UpdateLockFundAutoSaveResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateLockFundAutoSaveResponse> createRepeated() => $pb.PbList<UpdateLockFundAutoSaveResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateLockFundAutoSaveResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateLockFundAutoSaveResponse>(create);
  static UpdateLockFundAutoSaveResponse? _defaultInstance;

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
  LockFundAutoSave get autosave => $_getN(2);
  @$pb.TagNumber(3)
  set autosave(LockFundAutoSave v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasAutosave() => $_has(2);
  @$pb.TagNumber(3)
  void clearAutosave() => clearField(3);
  @$pb.TagNumber(3)
  LockFundAutoSave ensureAutosave() => $_ensure(2);
}

class DeleteLockFundAutoSaveRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DeleteLockFundAutoSaveRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'autosaveId')
    ..hasRequiredFields = false
  ;

  DeleteLockFundAutoSaveRequest._() : super();
  factory DeleteLockFundAutoSaveRequest({
    $core.String? autosaveId,
  }) {
    final _result = create();
    if (autosaveId != null) {
      _result.autosaveId = autosaveId;
    }
    return _result;
  }
  factory DeleteLockFundAutoSaveRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteLockFundAutoSaveRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteLockFundAutoSaveRequest clone() => DeleteLockFundAutoSaveRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteLockFundAutoSaveRequest copyWith(void Function(DeleteLockFundAutoSaveRequest) updates) => super.copyWith((message) => updates(message as DeleteLockFundAutoSaveRequest)) as DeleteLockFundAutoSaveRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DeleteLockFundAutoSaveResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  DeleteLockFundAutoSaveResponse._() : super();
  factory DeleteLockFundAutoSaveResponse({
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
  factory DeleteLockFundAutoSaveResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteLockFundAutoSaveResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteLockFundAutoSaveResponse clone() => DeleteLockFundAutoSaveResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteLockFundAutoSaveResponse copyWith(void Function(DeleteLockFundAutoSaveResponse) updates) => super.copyWith((message) => updates(message as DeleteLockFundAutoSaveResponse)) as DeleteLockFundAutoSaveResponse; // ignore: deprecated_member_use
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

