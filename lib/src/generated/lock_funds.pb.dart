///
//  Generated code. Do not modify.
//  source: lock_funds.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/timestamp.pb.dart' as $34;

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
    ..aOM<$34.Timestamp>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lockedAt', subBuilder: $34.Timestamp.create)
    ..aOM<$34.Timestamp>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'unlockAt', subBuilder: $34.Timestamp.create)
    ..e<LockStatus>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: LockStatus.LOCK_STATUS_UNSPECIFIED, valueOf: LockStatus.valueOf, enumValues: LockStatus.values)
    ..aOB(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'autoRenew')
    ..aOS(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'goalName')
    ..aOS(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'goalDescription')
    ..a<$core.double>(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'earlyUnlockPenaltyPercent', $pb.PbFieldType.OD)
    ..a<$core.double>(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accruedInterest', $pb.PbFieldType.OD)
    ..aOS(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'paymentMethod')
    ..aOS(17, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionId')
    ..aOM<$34.Timestamp>(18, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $34.Timestamp.create)
    ..aOM<$34.Timestamp>(19, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedAt', subBuilder: $34.Timestamp.create)
    ..a<$core.int>(20, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'daysRemaining', $pb.PbFieldType.O3)
    ..a<$core.double>(21, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'progressPercent', $pb.PbFieldType.OD)
    ..a<$core.double>(22, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalValue', $pb.PbFieldType.OD)
    ..aOB(23, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'canUnlockEarly')
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
    $34.Timestamp? lockedAt,
    $34.Timestamp? unlockAt,
    LockStatus? status,
    $core.bool? autoRenew,
    $core.String? goalName,
    $core.String? goalDescription,
    $core.double? earlyUnlockPenaltyPercent,
    $core.double? accruedInterest,
    $core.String? paymentMethod,
    $core.String? transactionId,
    $34.Timestamp? createdAt,
    $34.Timestamp? updatedAt,
    $core.int? daysRemaining,
    $core.double? progressPercent,
    $core.double? totalValue,
    $core.bool? canUnlockEarly,
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
  $34.Timestamp get lockedAt => $_getN(7);
  @$pb.TagNumber(8)
  set lockedAt($34.Timestamp v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasLockedAt() => $_has(7);
  @$pb.TagNumber(8)
  void clearLockedAt() => clearField(8);
  @$pb.TagNumber(8)
  $34.Timestamp ensureLockedAt() => $_ensure(7);

  @$pb.TagNumber(9)
  $34.Timestamp get unlockAt => $_getN(8);
  @$pb.TagNumber(9)
  set unlockAt($34.Timestamp v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasUnlockAt() => $_has(8);
  @$pb.TagNumber(9)
  void clearUnlockAt() => clearField(9);
  @$pb.TagNumber(9)
  $34.Timestamp ensureUnlockAt() => $_ensure(8);

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
  $34.Timestamp get createdAt => $_getN(17);
  @$pb.TagNumber(18)
  set createdAt($34.Timestamp v) { setField(18, v); }
  @$pb.TagNumber(18)
  $core.bool hasCreatedAt() => $_has(17);
  @$pb.TagNumber(18)
  void clearCreatedAt() => clearField(18);
  @$pb.TagNumber(18)
  $34.Timestamp ensureCreatedAt() => $_ensure(17);

  @$pb.TagNumber(19)
  $34.Timestamp get updatedAt => $_getN(18);
  @$pb.TagNumber(19)
  set updatedAt($34.Timestamp v) { setField(19, v); }
  @$pb.TagNumber(19)
  $core.bool hasUpdatedAt() => $_has(18);
  @$pb.TagNumber(19)
  void clearUpdatedAt() => clearField(19);
  @$pb.TagNumber(19)
  $34.Timestamp ensureUpdatedAt() => $_ensure(18);

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
    ..aOM<$34.Timestamp>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionDate', subBuilder: $34.Timestamp.create)
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
    $34.Timestamp? transactionDate,
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
  $34.Timestamp get transactionDate => $_getN(8);
  @$pb.TagNumber(9)
  set transactionDate($34.Timestamp v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasTransactionDate() => $_has(8);
  @$pb.TagNumber(9)
  void clearTransactionDate() => clearField(9);
  @$pb.TagNumber(9)
  $34.Timestamp ensureTransactionDate() => $_ensure(8);

  @$pb.TagNumber(10)
  $core.String get description => $_getSZ(9);
  @$pb.TagNumber(10)
  set description($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasDescription() => $_has(9);
  @$pb.TagNumber(10)
  void clearDescription() => clearField(10);
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
    ..hasRequiredFields = false
  ;

  UnlockFundRequest._() : super();
  factory UnlockFundRequest({
    $core.String? lockFundId,
    $core.bool? forceEarlyUnlock,
  }) {
    final _result = create();
    if (lockFundId != null) {
      _result.lockFundId = lockFundId;
    }
    if (forceEarlyUnlock != null) {
      _result.forceEarlyUnlock = forceEarlyUnlock;
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
}

class UnlockFundResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UnlockFundResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amountReturned', $pb.PbFieldType.OD)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'penaltyAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'interestEarned', $pb.PbFieldType.OD)
    ..aOM<LockFund>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedLockFund', subBuilder: LockFund.create)
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

