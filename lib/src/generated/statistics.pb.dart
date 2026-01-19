///
//  Generated code. Do not modify.
//  source: statistics.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/timestamp.pb.dart' as $36;

import 'statistics.pbenum.dart';

export 'statistics.pbenum.dart';

class ExpenseMessage extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ExpenseMessage', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..a<$fixnum.Int64>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountId')
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..e<ExpenseCategory>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'category', $pb.PbFieldType.OE, defaultOrMaker: ExpenseCategory.EXPENSE_CATEGORY_UNSPECIFIED, valueOf: ExpenseCategory.valueOf, enumValues: ExpenseCategory.values)
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'subcategory')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'merchant')
    ..aOM<$36.Timestamp>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionDate', subBuilder: $36.Timestamp.create)
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'paymentMethod')
    ..aOS(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'receiptUrl')
    ..pPS(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'tags')
    ..aOS(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'notes')
    ..aOB(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isRecurring')
    ..aOS(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recurrencePattern')
    ..aOM<$36.Timestamp>(17, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $36.Timestamp.create)
    ..aOM<$36.Timestamp>(18, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedAt', subBuilder: $36.Timestamp.create)
    ..hasRequiredFields = false
  ;

  ExpenseMessage._() : super();
  factory ExpenseMessage({
    $core.String? id,
    $fixnum.Int64? userId,
    $core.String? accountId,
    $core.double? amount,
    $core.String? currency,
    ExpenseCategory? category,
    $core.String? subcategory,
    $core.String? description,
    $core.String? merchant,
    $36.Timestamp? transactionDate,
    $core.String? paymentMethod,
    $core.String? receiptUrl,
    $core.Iterable<$core.String>? tags,
    $core.String? notes,
    $core.bool? isRecurring,
    $core.String? recurrencePattern,
    $36.Timestamp? createdAt,
    $36.Timestamp? updatedAt,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    if (accountId != null) {
      _result.accountId = accountId;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (category != null) {
      _result.category = category;
    }
    if (subcategory != null) {
      _result.subcategory = subcategory;
    }
    if (description != null) {
      _result.description = description;
    }
    if (merchant != null) {
      _result.merchant = merchant;
    }
    if (transactionDate != null) {
      _result.transactionDate = transactionDate;
    }
    if (paymentMethod != null) {
      _result.paymentMethod = paymentMethod;
    }
    if (receiptUrl != null) {
      _result.receiptUrl = receiptUrl;
    }
    if (tags != null) {
      _result.tags.addAll(tags);
    }
    if (notes != null) {
      _result.notes = notes;
    }
    if (isRecurring != null) {
      _result.isRecurring = isRecurring;
    }
    if (recurrencePattern != null) {
      _result.recurrencePattern = recurrencePattern;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      _result.updatedAt = updatedAt;
    }
    return _result;
  }
  factory ExpenseMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ExpenseMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ExpenseMessage clone() => ExpenseMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ExpenseMessage copyWith(void Function(ExpenseMessage) updates) => super.copyWith((message) => updates(message as ExpenseMessage)) as ExpenseMessage; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ExpenseMessage create() => ExpenseMessage._();
  ExpenseMessage createEmptyInstance() => create();
  static $pb.PbList<ExpenseMessage> createRepeated() => $pb.PbList<ExpenseMessage>();
  @$core.pragma('dart2js:noInline')
  static ExpenseMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ExpenseMessage>(create);
  static ExpenseMessage? _defaultInstance;

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
  $core.String get accountId => $_getSZ(2);
  @$pb.TagNumber(3)
  set accountId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAccountId() => $_has(2);
  @$pb.TagNumber(3)
  void clearAccountId() => clearField(3);

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
  ExpenseCategory get category => $_getN(5);
  @$pb.TagNumber(6)
  set category(ExpenseCategory v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasCategory() => $_has(5);
  @$pb.TagNumber(6)
  void clearCategory() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get subcategory => $_getSZ(6);
  @$pb.TagNumber(7)
  set subcategory($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasSubcategory() => $_has(6);
  @$pb.TagNumber(7)
  void clearSubcategory() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get description => $_getSZ(7);
  @$pb.TagNumber(8)
  set description($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasDescription() => $_has(7);
  @$pb.TagNumber(8)
  void clearDescription() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get merchant => $_getSZ(8);
  @$pb.TagNumber(9)
  set merchant($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasMerchant() => $_has(8);
  @$pb.TagNumber(9)
  void clearMerchant() => clearField(9);

  @$pb.TagNumber(10)
  $36.Timestamp get transactionDate => $_getN(9);
  @$pb.TagNumber(10)
  set transactionDate($36.Timestamp v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasTransactionDate() => $_has(9);
  @$pb.TagNumber(10)
  void clearTransactionDate() => clearField(10);
  @$pb.TagNumber(10)
  $36.Timestamp ensureTransactionDate() => $_ensure(9);

  @$pb.TagNumber(11)
  $core.String get paymentMethod => $_getSZ(10);
  @$pb.TagNumber(11)
  set paymentMethod($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasPaymentMethod() => $_has(10);
  @$pb.TagNumber(11)
  void clearPaymentMethod() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get receiptUrl => $_getSZ(11);
  @$pb.TagNumber(12)
  set receiptUrl($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasReceiptUrl() => $_has(11);
  @$pb.TagNumber(12)
  void clearReceiptUrl() => clearField(12);

  @$pb.TagNumber(13)
  $core.List<$core.String> get tags => $_getList(12);

  @$pb.TagNumber(14)
  $core.String get notes => $_getSZ(13);
  @$pb.TagNumber(14)
  set notes($core.String v) { $_setString(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasNotes() => $_has(13);
  @$pb.TagNumber(14)
  void clearNotes() => clearField(14);

  @$pb.TagNumber(15)
  $core.bool get isRecurring => $_getBF(14);
  @$pb.TagNumber(15)
  set isRecurring($core.bool v) { $_setBool(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasIsRecurring() => $_has(14);
  @$pb.TagNumber(15)
  void clearIsRecurring() => clearField(15);

  @$pb.TagNumber(16)
  $core.String get recurrencePattern => $_getSZ(15);
  @$pb.TagNumber(16)
  set recurrencePattern($core.String v) { $_setString(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasRecurrencePattern() => $_has(15);
  @$pb.TagNumber(16)
  void clearRecurrencePattern() => clearField(16);

  @$pb.TagNumber(17)
  $36.Timestamp get createdAt => $_getN(16);
  @$pb.TagNumber(17)
  set createdAt($36.Timestamp v) { setField(17, v); }
  @$pb.TagNumber(17)
  $core.bool hasCreatedAt() => $_has(16);
  @$pb.TagNumber(17)
  void clearCreatedAt() => clearField(17);
  @$pb.TagNumber(17)
  $36.Timestamp ensureCreatedAt() => $_ensure(16);

  @$pb.TagNumber(18)
  $36.Timestamp get updatedAt => $_getN(17);
  @$pb.TagNumber(18)
  set updatedAt($36.Timestamp v) { setField(18, v); }
  @$pb.TagNumber(18)
  $core.bool hasUpdatedAt() => $_has(17);
  @$pb.TagNumber(18)
  void clearUpdatedAt() => clearField(18);
  @$pb.TagNumber(18)
  $36.Timestamp ensureUpdatedAt() => $_ensure(17);
}

class BudgetMessage extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'BudgetMessage', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..a<$fixnum.Int64>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..e<ExpenseCategory>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'category', $pb.PbFieldType.OE, defaultOrMaker: ExpenseCategory.EXPENSE_CATEGORY_UNSPECIFIED, valueOf: ExpenseCategory.valueOf, enumValues: ExpenseCategory.values)
    ..e<BudgetPeriod>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'period', $pb.PbFieldType.OE, defaultOrMaker: BudgetPeriod.BUDGET_PERIOD_UNSPECIFIED, valueOf: BudgetPeriod.valueOf, enumValues: BudgetPeriod.values)
    ..aOM<$36.Timestamp>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'startDate', subBuilder: $36.Timestamp.create)
    ..aOM<$36.Timestamp>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'endDate', subBuilder: $36.Timestamp.create)
    ..a<$core.double>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'spentAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'remainingAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'percentageUsed', $pb.PbFieldType.OD)
    ..e<BudgetStatus>(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: BudgetStatus.BUDGET_STATUS_UNSPECIFIED, valueOf: BudgetStatus.valueOf, enumValues: BudgetStatus.values)
    ..aOB(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'enableAlerts')
    ..a<$core.double>(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'alertThreshold', $pb.PbFieldType.OD)
    ..aOM<$36.Timestamp>(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $36.Timestamp.create)
    ..aOM<$36.Timestamp>(17, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedAt', subBuilder: $36.Timestamp.create)
    ..hasRequiredFields = false
  ;

  BudgetMessage._() : super();
  factory BudgetMessage({
    $core.String? id,
    $fixnum.Int64? userId,
    $core.String? name,
    $core.double? amount,
    $core.String? currency,
    ExpenseCategory? category,
    BudgetPeriod? period,
    $36.Timestamp? startDate,
    $36.Timestamp? endDate,
    $core.double? spentAmount,
    $core.double? remainingAmount,
    $core.double? percentageUsed,
    BudgetStatus? status,
    $core.bool? enableAlerts,
    $core.double? alertThreshold,
    $36.Timestamp? createdAt,
    $36.Timestamp? updatedAt,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    if (name != null) {
      _result.name = name;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (category != null) {
      _result.category = category;
    }
    if (period != null) {
      _result.period = period;
    }
    if (startDate != null) {
      _result.startDate = startDate;
    }
    if (endDate != null) {
      _result.endDate = endDate;
    }
    if (spentAmount != null) {
      _result.spentAmount = spentAmount;
    }
    if (remainingAmount != null) {
      _result.remainingAmount = remainingAmount;
    }
    if (percentageUsed != null) {
      _result.percentageUsed = percentageUsed;
    }
    if (status != null) {
      _result.status = status;
    }
    if (enableAlerts != null) {
      _result.enableAlerts = enableAlerts;
    }
    if (alertThreshold != null) {
      _result.alertThreshold = alertThreshold;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      _result.updatedAt = updatedAt;
    }
    return _result;
  }
  factory BudgetMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BudgetMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BudgetMessage clone() => BudgetMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BudgetMessage copyWith(void Function(BudgetMessage) updates) => super.copyWith((message) => updates(message as BudgetMessage)) as BudgetMessage; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static BudgetMessage create() => BudgetMessage._();
  BudgetMessage createEmptyInstance() => create();
  static $pb.PbList<BudgetMessage> createRepeated() => $pb.PbList<BudgetMessage>();
  @$core.pragma('dart2js:noInline')
  static BudgetMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BudgetMessage>(create);
  static BudgetMessage? _defaultInstance;

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
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(3)
  set name($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => clearField(3);

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
  ExpenseCategory get category => $_getN(5);
  @$pb.TagNumber(6)
  set category(ExpenseCategory v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasCategory() => $_has(5);
  @$pb.TagNumber(6)
  void clearCategory() => clearField(6);

  @$pb.TagNumber(7)
  BudgetPeriod get period => $_getN(6);
  @$pb.TagNumber(7)
  set period(BudgetPeriod v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasPeriod() => $_has(6);
  @$pb.TagNumber(7)
  void clearPeriod() => clearField(7);

  @$pb.TagNumber(8)
  $36.Timestamp get startDate => $_getN(7);
  @$pb.TagNumber(8)
  set startDate($36.Timestamp v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasStartDate() => $_has(7);
  @$pb.TagNumber(8)
  void clearStartDate() => clearField(8);
  @$pb.TagNumber(8)
  $36.Timestamp ensureStartDate() => $_ensure(7);

  @$pb.TagNumber(9)
  $36.Timestamp get endDate => $_getN(8);
  @$pb.TagNumber(9)
  set endDate($36.Timestamp v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasEndDate() => $_has(8);
  @$pb.TagNumber(9)
  void clearEndDate() => clearField(9);
  @$pb.TagNumber(9)
  $36.Timestamp ensureEndDate() => $_ensure(8);

  @$pb.TagNumber(10)
  $core.double get spentAmount => $_getN(9);
  @$pb.TagNumber(10)
  set spentAmount($core.double v) { $_setDouble(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasSpentAmount() => $_has(9);
  @$pb.TagNumber(10)
  void clearSpentAmount() => clearField(10);

  @$pb.TagNumber(11)
  $core.double get remainingAmount => $_getN(10);
  @$pb.TagNumber(11)
  set remainingAmount($core.double v) { $_setDouble(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasRemainingAmount() => $_has(10);
  @$pb.TagNumber(11)
  void clearRemainingAmount() => clearField(11);

  @$pb.TagNumber(12)
  $core.double get percentageUsed => $_getN(11);
  @$pb.TagNumber(12)
  set percentageUsed($core.double v) { $_setDouble(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasPercentageUsed() => $_has(11);
  @$pb.TagNumber(12)
  void clearPercentageUsed() => clearField(12);

  @$pb.TagNumber(13)
  BudgetStatus get status => $_getN(12);
  @$pb.TagNumber(13)
  set status(BudgetStatus v) { setField(13, v); }
  @$pb.TagNumber(13)
  $core.bool hasStatus() => $_has(12);
  @$pb.TagNumber(13)
  void clearStatus() => clearField(13);

  @$pb.TagNumber(14)
  $core.bool get enableAlerts => $_getBF(13);
  @$pb.TagNumber(14)
  set enableAlerts($core.bool v) { $_setBool(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasEnableAlerts() => $_has(13);
  @$pb.TagNumber(14)
  void clearEnableAlerts() => clearField(14);

  @$pb.TagNumber(15)
  $core.double get alertThreshold => $_getN(14);
  @$pb.TagNumber(15)
  set alertThreshold($core.double v) { $_setDouble(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasAlertThreshold() => $_has(14);
  @$pb.TagNumber(15)
  void clearAlertThreshold() => clearField(15);

  @$pb.TagNumber(16)
  $36.Timestamp get createdAt => $_getN(15);
  @$pb.TagNumber(16)
  set createdAt($36.Timestamp v) { setField(16, v); }
  @$pb.TagNumber(16)
  $core.bool hasCreatedAt() => $_has(15);
  @$pb.TagNumber(16)
  void clearCreatedAt() => clearField(16);
  @$pb.TagNumber(16)
  $36.Timestamp ensureCreatedAt() => $_ensure(15);

  @$pb.TagNumber(17)
  $36.Timestamp get updatedAt => $_getN(16);
  @$pb.TagNumber(17)
  set updatedAt($36.Timestamp v) { setField(17, v); }
  @$pb.TagNumber(17)
  $core.bool hasUpdatedAt() => $_has(16);
  @$pb.TagNumber(17)
  void clearUpdatedAt() => clearField(17);
  @$pb.TagNumber(17)
  $36.Timestamp ensureUpdatedAt() => $_ensure(16);
}

class BudgetAlertMessage extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'BudgetAlertMessage', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..a<$fixnum.Int64>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'budgetId')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'budgetName')
    ..e<AlertType>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'alertType', $pb.PbFieldType.OE, defaultOrMaker: AlertType.ALERT_TYPE_UNSPECIFIED, valueOf: AlertType.valueOf, enumValues: AlertType.values)
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..a<$core.double>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currentSpent', $pb.PbFieldType.OD)
    ..a<$core.double>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'budgetLimit', $pb.PbFieldType.OD)
    ..a<$core.double>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'percentageUsed', $pb.PbFieldType.OD)
    ..aOB(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isRead')
    ..aOM<$36.Timestamp>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $36.Timestamp.create)
    ..hasRequiredFields = false
  ;

  BudgetAlertMessage._() : super();
  factory BudgetAlertMessage({
    $core.String? id,
    $fixnum.Int64? userId,
    $core.String? budgetId,
    $core.String? budgetName,
    AlertType? alertType,
    $core.String? message,
    $core.double? currentSpent,
    $core.double? budgetLimit,
    $core.double? percentageUsed,
    $core.bool? isRead,
    $36.Timestamp? createdAt,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    if (budgetId != null) {
      _result.budgetId = budgetId;
    }
    if (budgetName != null) {
      _result.budgetName = budgetName;
    }
    if (alertType != null) {
      _result.alertType = alertType;
    }
    if (message != null) {
      _result.message = message;
    }
    if (currentSpent != null) {
      _result.currentSpent = currentSpent;
    }
    if (budgetLimit != null) {
      _result.budgetLimit = budgetLimit;
    }
    if (percentageUsed != null) {
      _result.percentageUsed = percentageUsed;
    }
    if (isRead != null) {
      _result.isRead = isRead;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    return _result;
  }
  factory BudgetAlertMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BudgetAlertMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BudgetAlertMessage clone() => BudgetAlertMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BudgetAlertMessage copyWith(void Function(BudgetAlertMessage) updates) => super.copyWith((message) => updates(message as BudgetAlertMessage)) as BudgetAlertMessage; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static BudgetAlertMessage create() => BudgetAlertMessage._();
  BudgetAlertMessage createEmptyInstance() => create();
  static $pb.PbList<BudgetAlertMessage> createRepeated() => $pb.PbList<BudgetAlertMessage>();
  @$core.pragma('dart2js:noInline')
  static BudgetAlertMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BudgetAlertMessage>(create);
  static BudgetAlertMessage? _defaultInstance;

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
  $core.String get budgetId => $_getSZ(2);
  @$pb.TagNumber(3)
  set budgetId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasBudgetId() => $_has(2);
  @$pb.TagNumber(3)
  void clearBudgetId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get budgetName => $_getSZ(3);
  @$pb.TagNumber(4)
  set budgetName($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasBudgetName() => $_has(3);
  @$pb.TagNumber(4)
  void clearBudgetName() => clearField(4);

  @$pb.TagNumber(5)
  AlertType get alertType => $_getN(4);
  @$pb.TagNumber(5)
  set alertType(AlertType v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasAlertType() => $_has(4);
  @$pb.TagNumber(5)
  void clearAlertType() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get message => $_getSZ(5);
  @$pb.TagNumber(6)
  set message($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasMessage() => $_has(5);
  @$pb.TagNumber(6)
  void clearMessage() => clearField(6);

  @$pb.TagNumber(7)
  $core.double get currentSpent => $_getN(6);
  @$pb.TagNumber(7)
  set currentSpent($core.double v) { $_setDouble(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasCurrentSpent() => $_has(6);
  @$pb.TagNumber(7)
  void clearCurrentSpent() => clearField(7);

  @$pb.TagNumber(8)
  $core.double get budgetLimit => $_getN(7);
  @$pb.TagNumber(8)
  set budgetLimit($core.double v) { $_setDouble(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasBudgetLimit() => $_has(7);
  @$pb.TagNumber(8)
  void clearBudgetLimit() => clearField(8);

  @$pb.TagNumber(9)
  $core.double get percentageUsed => $_getN(8);
  @$pb.TagNumber(9)
  set percentageUsed($core.double v) { $_setDouble(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasPercentageUsed() => $_has(8);
  @$pb.TagNumber(9)
  void clearPercentageUsed() => clearField(9);

  @$pb.TagNumber(10)
  $core.bool get isRead => $_getBF(9);
  @$pb.TagNumber(10)
  set isRead($core.bool v) { $_setBool(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasIsRead() => $_has(9);
  @$pb.TagNumber(10)
  void clearIsRead() => clearField(10);

  @$pb.TagNumber(11)
  $36.Timestamp get createdAt => $_getN(10);
  @$pb.TagNumber(11)
  set createdAt($36.Timestamp v) { setField(11, v); }
  @$pb.TagNumber(11)
  $core.bool hasCreatedAt() => $_has(10);
  @$pb.TagNumber(11)
  void clearCreatedAt() => clearField(11);
  @$pb.TagNumber(11)
  $36.Timestamp ensureCreatedAt() => $_ensure(10);
}

class SpendingAnalytics extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SpendingAnalytics', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'period')
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalSpent', $pb.PbFieldType.OD)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalBudget', $pb.PbFieldType.OD)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'remainingBudget', $pb.PbFieldType.OD)
    ..a<$core.int>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionCount', $pb.PbFieldType.O3)
    ..a<$core.double>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'averageTransaction', $pb.PbFieldType.OD)
    ..pc<CategorySpending>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'categoryBreakdown', $pb.PbFieldType.PM, subBuilder: CategorySpending.create)
    ..pc<DailySpending>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dailyTrend', $pb.PbFieldType.PM, subBuilder: DailySpending.create)
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'topCategory')
    ..a<$core.double>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'topCategoryAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'savingsRate', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  SpendingAnalytics._() : super();
  factory SpendingAnalytics({
    $core.String? period,
    $core.double? totalSpent,
    $core.double? totalBudget,
    $core.double? remainingBudget,
    $core.int? transactionCount,
    $core.double? averageTransaction,
    $core.Iterable<CategorySpending>? categoryBreakdown,
    $core.Iterable<DailySpending>? dailyTrend,
    $core.String? topCategory,
    $core.double? topCategoryAmount,
    $core.double? savingsRate,
  }) {
    final _result = create();
    if (period != null) {
      _result.period = period;
    }
    if (totalSpent != null) {
      _result.totalSpent = totalSpent;
    }
    if (totalBudget != null) {
      _result.totalBudget = totalBudget;
    }
    if (remainingBudget != null) {
      _result.remainingBudget = remainingBudget;
    }
    if (transactionCount != null) {
      _result.transactionCount = transactionCount;
    }
    if (averageTransaction != null) {
      _result.averageTransaction = averageTransaction;
    }
    if (categoryBreakdown != null) {
      _result.categoryBreakdown.addAll(categoryBreakdown);
    }
    if (dailyTrend != null) {
      _result.dailyTrend.addAll(dailyTrend);
    }
    if (topCategory != null) {
      _result.topCategory = topCategory;
    }
    if (topCategoryAmount != null) {
      _result.topCategoryAmount = topCategoryAmount;
    }
    if (savingsRate != null) {
      _result.savingsRate = savingsRate;
    }
    return _result;
  }
  factory SpendingAnalytics.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SpendingAnalytics.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SpendingAnalytics clone() => SpendingAnalytics()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SpendingAnalytics copyWith(void Function(SpendingAnalytics) updates) => super.copyWith((message) => updates(message as SpendingAnalytics)) as SpendingAnalytics; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SpendingAnalytics create() => SpendingAnalytics._();
  SpendingAnalytics createEmptyInstance() => create();
  static $pb.PbList<SpendingAnalytics> createRepeated() => $pb.PbList<SpendingAnalytics>();
  @$core.pragma('dart2js:noInline')
  static SpendingAnalytics getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SpendingAnalytics>(create);
  static SpendingAnalytics? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get period => $_getSZ(0);
  @$pb.TagNumber(1)
  set period($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPeriod() => $_has(0);
  @$pb.TagNumber(1)
  void clearPeriod() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get totalSpent => $_getN(1);
  @$pb.TagNumber(2)
  set totalSpent($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotalSpent() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalSpent() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get totalBudget => $_getN(2);
  @$pb.TagNumber(3)
  set totalBudget($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTotalBudget() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalBudget() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get remainingBudget => $_getN(3);
  @$pb.TagNumber(4)
  set remainingBudget($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasRemainingBudget() => $_has(3);
  @$pb.TagNumber(4)
  void clearRemainingBudget() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get transactionCount => $_getIZ(4);
  @$pb.TagNumber(5)
  set transactionCount($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTransactionCount() => $_has(4);
  @$pb.TagNumber(5)
  void clearTransactionCount() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get averageTransaction => $_getN(5);
  @$pb.TagNumber(6)
  set averageTransaction($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasAverageTransaction() => $_has(5);
  @$pb.TagNumber(6)
  void clearAverageTransaction() => clearField(6);

  @$pb.TagNumber(7)
  $core.List<CategorySpending> get categoryBreakdown => $_getList(6);

  @$pb.TagNumber(8)
  $core.List<DailySpending> get dailyTrend => $_getList(7);

  @$pb.TagNumber(9)
  $core.String get topCategory => $_getSZ(8);
  @$pb.TagNumber(9)
  set topCategory($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasTopCategory() => $_has(8);
  @$pb.TagNumber(9)
  void clearTopCategory() => clearField(9);

  @$pb.TagNumber(10)
  $core.double get topCategoryAmount => $_getN(9);
  @$pb.TagNumber(10)
  set topCategoryAmount($core.double v) { $_setDouble(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasTopCategoryAmount() => $_has(9);
  @$pb.TagNumber(10)
  void clearTopCategoryAmount() => clearField(10);

  @$pb.TagNumber(11)
  $core.double get savingsRate => $_getN(10);
  @$pb.TagNumber(11)
  set savingsRate($core.double v) { $_setDouble(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasSavingsRate() => $_has(10);
  @$pb.TagNumber(11)
  void clearSavingsRate() => clearField(11);
}

class CategorySpending extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CategorySpending', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..e<ExpenseCategory>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'category', $pb.PbFieldType.OE, defaultOrMaker: ExpenseCategory.EXPENSE_CATEGORY_UNSPECIFIED, valueOf: ExpenseCategory.valueOf, enumValues: ExpenseCategory.values)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'categoryName')
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'percentage', $pb.PbFieldType.OD)
    ..a<$core.int>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionCount', $pb.PbFieldType.O3)
    ..a<$core.double>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'budgetAllocated', $pb.PbFieldType.OD)
    ..a<$core.double>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'budgetRemaining', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  CategorySpending._() : super();
  factory CategorySpending({
    ExpenseCategory? category,
    $core.String? categoryName,
    $core.double? amount,
    $core.double? percentage,
    $core.int? transactionCount,
    $core.double? budgetAllocated,
    $core.double? budgetRemaining,
  }) {
    final _result = create();
    if (category != null) {
      _result.category = category;
    }
    if (categoryName != null) {
      _result.categoryName = categoryName;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (percentage != null) {
      _result.percentage = percentage;
    }
    if (transactionCount != null) {
      _result.transactionCount = transactionCount;
    }
    if (budgetAllocated != null) {
      _result.budgetAllocated = budgetAllocated;
    }
    if (budgetRemaining != null) {
      _result.budgetRemaining = budgetRemaining;
    }
    return _result;
  }
  factory CategorySpending.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CategorySpending.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CategorySpending clone() => CategorySpending()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CategorySpending copyWith(void Function(CategorySpending) updates) => super.copyWith((message) => updates(message as CategorySpending)) as CategorySpending; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CategorySpending create() => CategorySpending._();
  CategorySpending createEmptyInstance() => create();
  static $pb.PbList<CategorySpending> createRepeated() => $pb.PbList<CategorySpending>();
  @$core.pragma('dart2js:noInline')
  static CategorySpending getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CategorySpending>(create);
  static CategorySpending? _defaultInstance;

  @$pb.TagNumber(1)
  ExpenseCategory get category => $_getN(0);
  @$pb.TagNumber(1)
  set category(ExpenseCategory v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasCategory() => $_has(0);
  @$pb.TagNumber(1)
  void clearCategory() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get categoryName => $_getSZ(1);
  @$pb.TagNumber(2)
  set categoryName($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCategoryName() => $_has(1);
  @$pb.TagNumber(2)
  void clearCategoryName() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get amount => $_getN(2);
  @$pb.TagNumber(3)
  set amount($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get percentage => $_getN(3);
  @$pb.TagNumber(4)
  set percentage($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPercentage() => $_has(3);
  @$pb.TagNumber(4)
  void clearPercentage() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get transactionCount => $_getIZ(4);
  @$pb.TagNumber(5)
  set transactionCount($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTransactionCount() => $_has(4);
  @$pb.TagNumber(5)
  void clearTransactionCount() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get budgetAllocated => $_getN(5);
  @$pb.TagNumber(6)
  set budgetAllocated($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasBudgetAllocated() => $_has(5);
  @$pb.TagNumber(6)
  void clearBudgetAllocated() => clearField(6);

  @$pb.TagNumber(7)
  $core.double get budgetRemaining => $_getN(6);
  @$pb.TagNumber(7)
  set budgetRemaining($core.double v) { $_setDouble(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasBudgetRemaining() => $_has(6);
  @$pb.TagNumber(7)
  void clearBudgetRemaining() => clearField(7);
}

class DailySpending extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DailySpending', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<$36.Timestamp>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'date', subBuilder: $36.Timestamp.create)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionCount', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  DailySpending._() : super();
  factory DailySpending({
    $36.Timestamp? date,
    $core.double? amount,
    $core.int? transactionCount,
  }) {
    final _result = create();
    if (date != null) {
      _result.date = date;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (transactionCount != null) {
      _result.transactionCount = transactionCount;
    }
    return _result;
  }
  factory DailySpending.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DailySpending.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DailySpending clone() => DailySpending()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DailySpending copyWith(void Function(DailySpending) updates) => super.copyWith((message) => updates(message as DailySpending)) as DailySpending; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DailySpending create() => DailySpending._();
  DailySpending createEmptyInstance() => create();
  static $pb.PbList<DailySpending> createRepeated() => $pb.PbList<DailySpending>();
  @$core.pragma('dart2js:noInline')
  static DailySpending getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DailySpending>(create);
  static DailySpending? _defaultInstance;

  @$pb.TagNumber(1)
  $36.Timestamp get date => $_getN(0);
  @$pb.TagNumber(1)
  set date($36.Timestamp v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasDate() => $_has(0);
  @$pb.TagNumber(1)
  void clearDate() => clearField(1);
  @$pb.TagNumber(1)
  $36.Timestamp ensureDate() => $_ensure(0);

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
}

class BudgetProgressItem extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'BudgetProgressItem', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'budgetId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'budgetName')
    ..e<ExpenseCategory>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'category', $pb.PbFieldType.OE, defaultOrMaker: ExpenseCategory.EXPENSE_CATEGORY_UNSPECIFIED, valueOf: ExpenseCategory.valueOf, enumValues: ExpenseCategory.values)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'budgetAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'spentAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'remainingAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'percentageUsed', $pb.PbFieldType.OD)
    ..e<BudgetStatus>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: BudgetStatus.BUDGET_STATUS_UNSPECIFIED, valueOf: BudgetStatus.valueOf, enumValues: BudgetStatus.values)
    ..a<$core.int>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'daysRemaining', $pb.PbFieldType.O3)
    ..a<$core.double>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dailyAverageSpend', $pb.PbFieldType.OD)
    ..a<$core.double>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'projectedSpend', $pb.PbFieldType.OD)
    ..aOB(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'willExceed')
    ..hasRequiredFields = false
  ;

  BudgetProgressItem._() : super();
  factory BudgetProgressItem({
    $core.String? budgetId,
    $core.String? budgetName,
    ExpenseCategory? category,
    $core.double? budgetAmount,
    $core.double? spentAmount,
    $core.double? remainingAmount,
    $core.double? percentageUsed,
    BudgetStatus? status,
    $core.int? daysRemaining,
    $core.double? dailyAverageSpend,
    $core.double? projectedSpend,
    $core.bool? willExceed,
  }) {
    final _result = create();
    if (budgetId != null) {
      _result.budgetId = budgetId;
    }
    if (budgetName != null) {
      _result.budgetName = budgetName;
    }
    if (category != null) {
      _result.category = category;
    }
    if (budgetAmount != null) {
      _result.budgetAmount = budgetAmount;
    }
    if (spentAmount != null) {
      _result.spentAmount = spentAmount;
    }
    if (remainingAmount != null) {
      _result.remainingAmount = remainingAmount;
    }
    if (percentageUsed != null) {
      _result.percentageUsed = percentageUsed;
    }
    if (status != null) {
      _result.status = status;
    }
    if (daysRemaining != null) {
      _result.daysRemaining = daysRemaining;
    }
    if (dailyAverageSpend != null) {
      _result.dailyAverageSpend = dailyAverageSpend;
    }
    if (projectedSpend != null) {
      _result.projectedSpend = projectedSpend;
    }
    if (willExceed != null) {
      _result.willExceed = willExceed;
    }
    return _result;
  }
  factory BudgetProgressItem.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BudgetProgressItem.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BudgetProgressItem clone() => BudgetProgressItem()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BudgetProgressItem copyWith(void Function(BudgetProgressItem) updates) => super.copyWith((message) => updates(message as BudgetProgressItem)) as BudgetProgressItem; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static BudgetProgressItem create() => BudgetProgressItem._();
  BudgetProgressItem createEmptyInstance() => create();
  static $pb.PbList<BudgetProgressItem> createRepeated() => $pb.PbList<BudgetProgressItem>();
  @$core.pragma('dart2js:noInline')
  static BudgetProgressItem getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BudgetProgressItem>(create);
  static BudgetProgressItem? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get budgetId => $_getSZ(0);
  @$pb.TagNumber(1)
  set budgetId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasBudgetId() => $_has(0);
  @$pb.TagNumber(1)
  void clearBudgetId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get budgetName => $_getSZ(1);
  @$pb.TagNumber(2)
  set budgetName($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasBudgetName() => $_has(1);
  @$pb.TagNumber(2)
  void clearBudgetName() => clearField(2);

  @$pb.TagNumber(3)
  ExpenseCategory get category => $_getN(2);
  @$pb.TagNumber(3)
  set category(ExpenseCategory v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasCategory() => $_has(2);
  @$pb.TagNumber(3)
  void clearCategory() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get budgetAmount => $_getN(3);
  @$pb.TagNumber(4)
  set budgetAmount($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasBudgetAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearBudgetAmount() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get spentAmount => $_getN(4);
  @$pb.TagNumber(5)
  set spentAmount($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasSpentAmount() => $_has(4);
  @$pb.TagNumber(5)
  void clearSpentAmount() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get remainingAmount => $_getN(5);
  @$pb.TagNumber(6)
  set remainingAmount($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasRemainingAmount() => $_has(5);
  @$pb.TagNumber(6)
  void clearRemainingAmount() => clearField(6);

  @$pb.TagNumber(7)
  $core.double get percentageUsed => $_getN(6);
  @$pb.TagNumber(7)
  set percentageUsed($core.double v) { $_setDouble(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasPercentageUsed() => $_has(6);
  @$pb.TagNumber(7)
  void clearPercentageUsed() => clearField(7);

  @$pb.TagNumber(8)
  BudgetStatus get status => $_getN(7);
  @$pb.TagNumber(8)
  set status(BudgetStatus v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasStatus() => $_has(7);
  @$pb.TagNumber(8)
  void clearStatus() => clearField(8);

  @$pb.TagNumber(9)
  $core.int get daysRemaining => $_getIZ(8);
  @$pb.TagNumber(9)
  set daysRemaining($core.int v) { $_setSignedInt32(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasDaysRemaining() => $_has(8);
  @$pb.TagNumber(9)
  void clearDaysRemaining() => clearField(9);

  @$pb.TagNumber(10)
  $core.double get dailyAverageSpend => $_getN(9);
  @$pb.TagNumber(10)
  set dailyAverageSpend($core.double v) { $_setDouble(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasDailyAverageSpend() => $_has(9);
  @$pb.TagNumber(10)
  void clearDailyAverageSpend() => clearField(10);

  @$pb.TagNumber(11)
  $core.double get projectedSpend => $_getN(10);
  @$pb.TagNumber(11)
  set projectedSpend($core.double v) { $_setDouble(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasProjectedSpend() => $_has(10);
  @$pb.TagNumber(11)
  void clearProjectedSpend() => clearField(11);

  @$pb.TagNumber(12)
  $core.bool get willExceed => $_getBF(11);
  @$pb.TagNumber(12)
  set willExceed($core.bool v) { $_setBool(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasWillExceed() => $_has(11);
  @$pb.TagNumber(12)
  void clearWillExceed() => clearField(12);
}

class SpendingTrend extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SpendingTrend', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'periodLabel')
    ..aOM<$36.Timestamp>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'periodStart', subBuilder: $36.Timestamp.create)
    ..aOM<$36.Timestamp>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'periodEnd', subBuilder: $36.Timestamp.create)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalSpent', $pb.PbFieldType.OD)
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'budgetAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'variance', $pb.PbFieldType.OD)
    ..a<$core.double>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'variancePercentage', $pb.PbFieldType.OD)
    ..pc<CategorySpending>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'categories', $pb.PbFieldType.PM, subBuilder: CategorySpending.create)
    ..hasRequiredFields = false
  ;

  SpendingTrend._() : super();
  factory SpendingTrend({
    $core.String? periodLabel,
    $36.Timestamp? periodStart,
    $36.Timestamp? periodEnd,
    $core.double? totalSpent,
    $core.double? budgetAmount,
    $core.double? variance,
    $core.double? variancePercentage,
    $core.Iterable<CategorySpending>? categories,
  }) {
    final _result = create();
    if (periodLabel != null) {
      _result.periodLabel = periodLabel;
    }
    if (periodStart != null) {
      _result.periodStart = periodStart;
    }
    if (periodEnd != null) {
      _result.periodEnd = periodEnd;
    }
    if (totalSpent != null) {
      _result.totalSpent = totalSpent;
    }
    if (budgetAmount != null) {
      _result.budgetAmount = budgetAmount;
    }
    if (variance != null) {
      _result.variance = variance;
    }
    if (variancePercentage != null) {
      _result.variancePercentage = variancePercentage;
    }
    if (categories != null) {
      _result.categories.addAll(categories);
    }
    return _result;
  }
  factory SpendingTrend.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SpendingTrend.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SpendingTrend clone() => SpendingTrend()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SpendingTrend copyWith(void Function(SpendingTrend) updates) => super.copyWith((message) => updates(message as SpendingTrend)) as SpendingTrend; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SpendingTrend create() => SpendingTrend._();
  SpendingTrend createEmptyInstance() => create();
  static $pb.PbList<SpendingTrend> createRepeated() => $pb.PbList<SpendingTrend>();
  @$core.pragma('dart2js:noInline')
  static SpendingTrend getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SpendingTrend>(create);
  static SpendingTrend? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get periodLabel => $_getSZ(0);
  @$pb.TagNumber(1)
  set periodLabel($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPeriodLabel() => $_has(0);
  @$pb.TagNumber(1)
  void clearPeriodLabel() => clearField(1);

  @$pb.TagNumber(2)
  $36.Timestamp get periodStart => $_getN(1);
  @$pb.TagNumber(2)
  set periodStart($36.Timestamp v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPeriodStart() => $_has(1);
  @$pb.TagNumber(2)
  void clearPeriodStart() => clearField(2);
  @$pb.TagNumber(2)
  $36.Timestamp ensurePeriodStart() => $_ensure(1);

  @$pb.TagNumber(3)
  $36.Timestamp get periodEnd => $_getN(2);
  @$pb.TagNumber(3)
  set periodEnd($36.Timestamp v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasPeriodEnd() => $_has(2);
  @$pb.TagNumber(3)
  void clearPeriodEnd() => clearField(3);
  @$pb.TagNumber(3)
  $36.Timestamp ensurePeriodEnd() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.double get totalSpent => $_getN(3);
  @$pb.TagNumber(4)
  set totalSpent($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTotalSpent() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalSpent() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get budgetAmount => $_getN(4);
  @$pb.TagNumber(5)
  set budgetAmount($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasBudgetAmount() => $_has(4);
  @$pb.TagNumber(5)
  void clearBudgetAmount() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get variance => $_getN(5);
  @$pb.TagNumber(6)
  set variance($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasVariance() => $_has(5);
  @$pb.TagNumber(6)
  void clearVariance() => clearField(6);

  @$pb.TagNumber(7)
  $core.double get variancePercentage => $_getN(6);
  @$pb.TagNumber(7)
  set variancePercentage($core.double v) { $_setDouble(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasVariancePercentage() => $_has(6);
  @$pb.TagNumber(7)
  void clearVariancePercentage() => clearField(7);

  @$pb.TagNumber(8)
  $core.List<CategorySpending> get categories => $_getList(7);
}

class CreateExpenseRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateExpenseRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountId')
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..e<ExpenseCategory>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'category', $pb.PbFieldType.OE, defaultOrMaker: ExpenseCategory.EXPENSE_CATEGORY_UNSPECIFIED, valueOf: ExpenseCategory.valueOf, enumValues: ExpenseCategory.values)
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'subcategory')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'merchant')
    ..aOM<$36.Timestamp>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionDate', subBuilder: $36.Timestamp.create)
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'paymentMethod')
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'receiptUrl')
    ..pPS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'tags')
    ..aOS(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'notes')
    ..aOB(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isRecurring')
    ..aOS(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recurrencePattern')
    ..hasRequiredFields = false
  ;

  CreateExpenseRequest._() : super();
  factory CreateExpenseRequest({
    $core.String? accountId,
    $core.double? amount,
    $core.String? currency,
    ExpenseCategory? category,
    $core.String? subcategory,
    $core.String? description,
    $core.String? merchant,
    $36.Timestamp? transactionDate,
    $core.String? paymentMethod,
    $core.String? receiptUrl,
    $core.Iterable<$core.String>? tags,
    $core.String? notes,
    $core.bool? isRecurring,
    $core.String? recurrencePattern,
  }) {
    final _result = create();
    if (accountId != null) {
      _result.accountId = accountId;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (category != null) {
      _result.category = category;
    }
    if (subcategory != null) {
      _result.subcategory = subcategory;
    }
    if (description != null) {
      _result.description = description;
    }
    if (merchant != null) {
      _result.merchant = merchant;
    }
    if (transactionDate != null) {
      _result.transactionDate = transactionDate;
    }
    if (paymentMethod != null) {
      _result.paymentMethod = paymentMethod;
    }
    if (receiptUrl != null) {
      _result.receiptUrl = receiptUrl;
    }
    if (tags != null) {
      _result.tags.addAll(tags);
    }
    if (notes != null) {
      _result.notes = notes;
    }
    if (isRecurring != null) {
      _result.isRecurring = isRecurring;
    }
    if (recurrencePattern != null) {
      _result.recurrencePattern = recurrencePattern;
    }
    return _result;
  }
  factory CreateExpenseRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateExpenseRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateExpenseRequest clone() => CreateExpenseRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateExpenseRequest copyWith(void Function(CreateExpenseRequest) updates) => super.copyWith((message) => updates(message as CreateExpenseRequest)) as CreateExpenseRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateExpenseRequest create() => CreateExpenseRequest._();
  CreateExpenseRequest createEmptyInstance() => create();
  static $pb.PbList<CreateExpenseRequest> createRepeated() => $pb.PbList<CreateExpenseRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateExpenseRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateExpenseRequest>(create);
  static CreateExpenseRequest? _defaultInstance;

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
  $core.String get currency => $_getSZ(2);
  @$pb.TagNumber(3)
  set currency($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCurrency() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrency() => clearField(3);

  @$pb.TagNumber(4)
  ExpenseCategory get category => $_getN(3);
  @$pb.TagNumber(4)
  set category(ExpenseCategory v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasCategory() => $_has(3);
  @$pb.TagNumber(4)
  void clearCategory() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get subcategory => $_getSZ(4);
  @$pb.TagNumber(5)
  set subcategory($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasSubcategory() => $_has(4);
  @$pb.TagNumber(5)
  void clearSubcategory() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get description => $_getSZ(5);
  @$pb.TagNumber(6)
  set description($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasDescription() => $_has(5);
  @$pb.TagNumber(6)
  void clearDescription() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get merchant => $_getSZ(6);
  @$pb.TagNumber(7)
  set merchant($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasMerchant() => $_has(6);
  @$pb.TagNumber(7)
  void clearMerchant() => clearField(7);

  @$pb.TagNumber(8)
  $36.Timestamp get transactionDate => $_getN(7);
  @$pb.TagNumber(8)
  set transactionDate($36.Timestamp v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasTransactionDate() => $_has(7);
  @$pb.TagNumber(8)
  void clearTransactionDate() => clearField(8);
  @$pb.TagNumber(8)
  $36.Timestamp ensureTransactionDate() => $_ensure(7);

  @$pb.TagNumber(9)
  $core.String get paymentMethod => $_getSZ(8);
  @$pb.TagNumber(9)
  set paymentMethod($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasPaymentMethod() => $_has(8);
  @$pb.TagNumber(9)
  void clearPaymentMethod() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get receiptUrl => $_getSZ(9);
  @$pb.TagNumber(10)
  set receiptUrl($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasReceiptUrl() => $_has(9);
  @$pb.TagNumber(10)
  void clearReceiptUrl() => clearField(10);

  @$pb.TagNumber(11)
  $core.List<$core.String> get tags => $_getList(10);

  @$pb.TagNumber(12)
  $core.String get notes => $_getSZ(11);
  @$pb.TagNumber(12)
  set notes($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasNotes() => $_has(11);
  @$pb.TagNumber(12)
  void clearNotes() => clearField(12);

  @$pb.TagNumber(13)
  $core.bool get isRecurring => $_getBF(12);
  @$pb.TagNumber(13)
  set isRecurring($core.bool v) { $_setBool(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasIsRecurring() => $_has(12);
  @$pb.TagNumber(13)
  void clearIsRecurring() => clearField(13);

  @$pb.TagNumber(14)
  $core.String get recurrencePattern => $_getSZ(13);
  @$pb.TagNumber(14)
  set recurrencePattern($core.String v) { $_setString(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasRecurrencePattern() => $_has(13);
  @$pb.TagNumber(14)
  void clearRecurrencePattern() => clearField(14);
}

class CreateExpenseResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateExpenseResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<ExpenseMessage>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'expense', subBuilder: ExpenseMessage.create)
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  CreateExpenseResponse._() : super();
  factory CreateExpenseResponse({
    ExpenseMessage? expense,
    $core.bool? success,
    $core.String? message,
  }) {
    final _result = create();
    if (expense != null) {
      _result.expense = expense;
    }
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory CreateExpenseResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateExpenseResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateExpenseResponse clone() => CreateExpenseResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateExpenseResponse copyWith(void Function(CreateExpenseResponse) updates) => super.copyWith((message) => updates(message as CreateExpenseResponse)) as CreateExpenseResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateExpenseResponse create() => CreateExpenseResponse._();
  CreateExpenseResponse createEmptyInstance() => create();
  static $pb.PbList<CreateExpenseResponse> createRepeated() => $pb.PbList<CreateExpenseResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateExpenseResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateExpenseResponse>(create);
  static CreateExpenseResponse? _defaultInstance;

  @$pb.TagNumber(1)
  ExpenseMessage get expense => $_getN(0);
  @$pb.TagNumber(1)
  set expense(ExpenseMessage v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasExpense() => $_has(0);
  @$pb.TagNumber(1)
  void clearExpense() => clearField(1);
  @$pb.TagNumber(1)
  ExpenseMessage ensureExpense() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => clearField(3);
}

class GetExpensesRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetExpensesRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'perPage', $pb.PbFieldType.O3)
    ..aOM<$36.Timestamp>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'startDate', subBuilder: $36.Timestamp.create)
    ..aOM<$36.Timestamp>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'endDate', subBuilder: $36.Timestamp.create)
    ..e<ExpenseCategory>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'category', $pb.PbFieldType.OE, defaultOrMaker: ExpenseCategory.EXPENSE_CATEGORY_UNSPECIFIED, valueOf: ExpenseCategory.valueOf, enumValues: ExpenseCategory.values)
    ..a<$core.double>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'minAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'maxAmount', $pb.PbFieldType.OD)
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'searchQuery')
    ..pPS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'tags')
    ..hasRequiredFields = false
  ;

  GetExpensesRequest._() : super();
  factory GetExpensesRequest({
    $core.int? page,
    $core.int? perPage,
    $36.Timestamp? startDate,
    $36.Timestamp? endDate,
    ExpenseCategory? category,
    $core.double? minAmount,
    $core.double? maxAmount,
    $core.String? searchQuery,
    $core.Iterable<$core.String>? tags,
  }) {
    final _result = create();
    if (page != null) {
      _result.page = page;
    }
    if (perPage != null) {
      _result.perPage = perPage;
    }
    if (startDate != null) {
      _result.startDate = startDate;
    }
    if (endDate != null) {
      _result.endDate = endDate;
    }
    if (category != null) {
      _result.category = category;
    }
    if (minAmount != null) {
      _result.minAmount = minAmount;
    }
    if (maxAmount != null) {
      _result.maxAmount = maxAmount;
    }
    if (searchQuery != null) {
      _result.searchQuery = searchQuery;
    }
    if (tags != null) {
      _result.tags.addAll(tags);
    }
    return _result;
  }
  factory GetExpensesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetExpensesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetExpensesRequest clone() => GetExpensesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetExpensesRequest copyWith(void Function(GetExpensesRequest) updates) => super.copyWith((message) => updates(message as GetExpensesRequest)) as GetExpensesRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetExpensesRequest create() => GetExpensesRequest._();
  GetExpensesRequest createEmptyInstance() => create();
  static $pb.PbList<GetExpensesRequest> createRepeated() => $pb.PbList<GetExpensesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetExpensesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetExpensesRequest>(create);
  static GetExpensesRequest? _defaultInstance;

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

  @$pb.TagNumber(3)
  $36.Timestamp get startDate => $_getN(2);
  @$pb.TagNumber(3)
  set startDate($36.Timestamp v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasStartDate() => $_has(2);
  @$pb.TagNumber(3)
  void clearStartDate() => clearField(3);
  @$pb.TagNumber(3)
  $36.Timestamp ensureStartDate() => $_ensure(2);

  @$pb.TagNumber(4)
  $36.Timestamp get endDate => $_getN(3);
  @$pb.TagNumber(4)
  set endDate($36.Timestamp v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasEndDate() => $_has(3);
  @$pb.TagNumber(4)
  void clearEndDate() => clearField(4);
  @$pb.TagNumber(4)
  $36.Timestamp ensureEndDate() => $_ensure(3);

  @$pb.TagNumber(5)
  ExpenseCategory get category => $_getN(4);
  @$pb.TagNumber(5)
  set category(ExpenseCategory v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasCategory() => $_has(4);
  @$pb.TagNumber(5)
  void clearCategory() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get minAmount => $_getN(5);
  @$pb.TagNumber(6)
  set minAmount($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasMinAmount() => $_has(5);
  @$pb.TagNumber(6)
  void clearMinAmount() => clearField(6);

  @$pb.TagNumber(7)
  $core.double get maxAmount => $_getN(6);
  @$pb.TagNumber(7)
  set maxAmount($core.double v) { $_setDouble(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasMaxAmount() => $_has(6);
  @$pb.TagNumber(7)
  void clearMaxAmount() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get searchQuery => $_getSZ(7);
  @$pb.TagNumber(8)
  set searchQuery($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasSearchQuery() => $_has(7);
  @$pb.TagNumber(8)
  void clearSearchQuery() => clearField(8);

  @$pb.TagNumber(9)
  $core.List<$core.String> get tags => $_getList(8);
}

class GetExpensesResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetExpensesResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<ExpenseMessage>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'expenses', $pb.PbFieldType.PM, subBuilder: ExpenseMessage.create)
    ..aOM<PaginationMetadata>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pagination', subBuilder: PaginationMetadata.create)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalAmount', $pb.PbFieldType.OD)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalCount', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetExpensesResponse._() : super();
  factory GetExpensesResponse({
    $core.Iterable<ExpenseMessage>? expenses,
    PaginationMetadata? pagination,
    $core.double? totalAmount,
    $core.int? totalCount,
  }) {
    final _result = create();
    if (expenses != null) {
      _result.expenses.addAll(expenses);
    }
    if (pagination != null) {
      _result.pagination = pagination;
    }
    if (totalAmount != null) {
      _result.totalAmount = totalAmount;
    }
    if (totalCount != null) {
      _result.totalCount = totalCount;
    }
    return _result;
  }
  factory GetExpensesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetExpensesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetExpensesResponse clone() => GetExpensesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetExpensesResponse copyWith(void Function(GetExpensesResponse) updates) => super.copyWith((message) => updates(message as GetExpensesResponse)) as GetExpensesResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetExpensesResponse create() => GetExpensesResponse._();
  GetExpensesResponse createEmptyInstance() => create();
  static $pb.PbList<GetExpensesResponse> createRepeated() => $pb.PbList<GetExpensesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetExpensesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetExpensesResponse>(create);
  static GetExpensesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<ExpenseMessage> get expenses => $_getList(0);

  @$pb.TagNumber(2)
  PaginationMetadata get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination(PaginationMetadata v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => clearField(2);
  @$pb.TagNumber(2)
  PaginationMetadata ensurePagination() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.double get totalAmount => $_getN(2);
  @$pb.TagNumber(3)
  set totalAmount($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTotalAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalAmount() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get totalCount => $_getIZ(3);
  @$pb.TagNumber(4)
  set totalCount($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTotalCount() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalCount() => clearField(4);
}

class GetExpenseByIdRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetExpenseByIdRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'expenseId')
    ..hasRequiredFields = false
  ;

  GetExpenseByIdRequest._() : super();
  factory GetExpenseByIdRequest({
    $core.String? expenseId,
  }) {
    final _result = create();
    if (expenseId != null) {
      _result.expenseId = expenseId;
    }
    return _result;
  }
  factory GetExpenseByIdRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetExpenseByIdRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetExpenseByIdRequest clone() => GetExpenseByIdRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetExpenseByIdRequest copyWith(void Function(GetExpenseByIdRequest) updates) => super.copyWith((message) => updates(message as GetExpenseByIdRequest)) as GetExpenseByIdRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetExpenseByIdRequest create() => GetExpenseByIdRequest._();
  GetExpenseByIdRequest createEmptyInstance() => create();
  static $pb.PbList<GetExpenseByIdRequest> createRepeated() => $pb.PbList<GetExpenseByIdRequest>();
  @$core.pragma('dart2js:noInline')
  static GetExpenseByIdRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetExpenseByIdRequest>(create);
  static GetExpenseByIdRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get expenseId => $_getSZ(0);
  @$pb.TagNumber(1)
  set expenseId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasExpenseId() => $_has(0);
  @$pb.TagNumber(1)
  void clearExpenseId() => clearField(1);
}

class GetExpenseByIdResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetExpenseByIdResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<ExpenseMessage>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'expense', subBuilder: ExpenseMessage.create)
    ..hasRequiredFields = false
  ;

  GetExpenseByIdResponse._() : super();
  factory GetExpenseByIdResponse({
    ExpenseMessage? expense,
  }) {
    final _result = create();
    if (expense != null) {
      _result.expense = expense;
    }
    return _result;
  }
  factory GetExpenseByIdResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetExpenseByIdResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetExpenseByIdResponse clone() => GetExpenseByIdResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetExpenseByIdResponse copyWith(void Function(GetExpenseByIdResponse) updates) => super.copyWith((message) => updates(message as GetExpenseByIdResponse)) as GetExpenseByIdResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetExpenseByIdResponse create() => GetExpenseByIdResponse._();
  GetExpenseByIdResponse createEmptyInstance() => create();
  static $pb.PbList<GetExpenseByIdResponse> createRepeated() => $pb.PbList<GetExpenseByIdResponse>();
  @$core.pragma('dart2js:noInline')
  static GetExpenseByIdResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetExpenseByIdResponse>(create);
  static GetExpenseByIdResponse? _defaultInstance;

  @$pb.TagNumber(1)
  ExpenseMessage get expense => $_getN(0);
  @$pb.TagNumber(1)
  set expense(ExpenseMessage v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasExpense() => $_has(0);
  @$pb.TagNumber(1)
  void clearExpense() => clearField(1);
  @$pb.TagNumber(1)
  ExpenseMessage ensureExpense() => $_ensure(0);
}

class UpdateExpenseRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateExpenseRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'expenseId')
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..e<ExpenseCategory>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'category', $pb.PbFieldType.OE, defaultOrMaker: ExpenseCategory.EXPENSE_CATEGORY_UNSPECIFIED, valueOf: ExpenseCategory.valueOf, enumValues: ExpenseCategory.values)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'subcategory')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'merchant')
    ..aOM<$36.Timestamp>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionDate', subBuilder: $36.Timestamp.create)
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'paymentMethod')
    ..pPS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'tags')
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'notes')
    ..hasRequiredFields = false
  ;

  UpdateExpenseRequest._() : super();
  factory UpdateExpenseRequest({
    $core.String? expenseId,
    $core.double? amount,
    ExpenseCategory? category,
    $core.String? subcategory,
    $core.String? description,
    $core.String? merchant,
    $36.Timestamp? transactionDate,
    $core.String? paymentMethod,
    $core.Iterable<$core.String>? tags,
    $core.String? notes,
  }) {
    final _result = create();
    if (expenseId != null) {
      _result.expenseId = expenseId;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (category != null) {
      _result.category = category;
    }
    if (subcategory != null) {
      _result.subcategory = subcategory;
    }
    if (description != null) {
      _result.description = description;
    }
    if (merchant != null) {
      _result.merchant = merchant;
    }
    if (transactionDate != null) {
      _result.transactionDate = transactionDate;
    }
    if (paymentMethod != null) {
      _result.paymentMethod = paymentMethod;
    }
    if (tags != null) {
      _result.tags.addAll(tags);
    }
    if (notes != null) {
      _result.notes = notes;
    }
    return _result;
  }
  factory UpdateExpenseRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateExpenseRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateExpenseRequest clone() => UpdateExpenseRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateExpenseRequest copyWith(void Function(UpdateExpenseRequest) updates) => super.copyWith((message) => updates(message as UpdateExpenseRequest)) as UpdateExpenseRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UpdateExpenseRequest create() => UpdateExpenseRequest._();
  UpdateExpenseRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateExpenseRequest> createRepeated() => $pb.PbList<UpdateExpenseRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateExpenseRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateExpenseRequest>(create);
  static UpdateExpenseRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get expenseId => $_getSZ(0);
  @$pb.TagNumber(1)
  set expenseId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasExpenseId() => $_has(0);
  @$pb.TagNumber(1)
  void clearExpenseId() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get amount => $_getN(1);
  @$pb.TagNumber(2)
  set amount($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => clearField(2);

  @$pb.TagNumber(3)
  ExpenseCategory get category => $_getN(2);
  @$pb.TagNumber(3)
  set category(ExpenseCategory v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasCategory() => $_has(2);
  @$pb.TagNumber(3)
  void clearCategory() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get subcategory => $_getSZ(3);
  @$pb.TagNumber(4)
  set subcategory($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasSubcategory() => $_has(3);
  @$pb.TagNumber(4)
  void clearSubcategory() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get description => $_getSZ(4);
  @$pb.TagNumber(5)
  set description($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasDescription() => $_has(4);
  @$pb.TagNumber(5)
  void clearDescription() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get merchant => $_getSZ(5);
  @$pb.TagNumber(6)
  set merchant($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasMerchant() => $_has(5);
  @$pb.TagNumber(6)
  void clearMerchant() => clearField(6);

  @$pb.TagNumber(7)
  $36.Timestamp get transactionDate => $_getN(6);
  @$pb.TagNumber(7)
  set transactionDate($36.Timestamp v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasTransactionDate() => $_has(6);
  @$pb.TagNumber(7)
  void clearTransactionDate() => clearField(7);
  @$pb.TagNumber(7)
  $36.Timestamp ensureTransactionDate() => $_ensure(6);

  @$pb.TagNumber(8)
  $core.String get paymentMethod => $_getSZ(7);
  @$pb.TagNumber(8)
  set paymentMethod($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasPaymentMethod() => $_has(7);
  @$pb.TagNumber(8)
  void clearPaymentMethod() => clearField(8);

  @$pb.TagNumber(9)
  $core.List<$core.String> get tags => $_getList(8);

  @$pb.TagNumber(10)
  $core.String get notes => $_getSZ(9);
  @$pb.TagNumber(10)
  set notes($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasNotes() => $_has(9);
  @$pb.TagNumber(10)
  void clearNotes() => clearField(10);
}

class UpdateExpenseResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateExpenseResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<ExpenseMessage>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'expense', subBuilder: ExpenseMessage.create)
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  UpdateExpenseResponse._() : super();
  factory UpdateExpenseResponse({
    ExpenseMessage? expense,
    $core.bool? success,
    $core.String? message,
  }) {
    final _result = create();
    if (expense != null) {
      _result.expense = expense;
    }
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory UpdateExpenseResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateExpenseResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateExpenseResponse clone() => UpdateExpenseResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateExpenseResponse copyWith(void Function(UpdateExpenseResponse) updates) => super.copyWith((message) => updates(message as UpdateExpenseResponse)) as UpdateExpenseResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UpdateExpenseResponse create() => UpdateExpenseResponse._();
  UpdateExpenseResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateExpenseResponse> createRepeated() => $pb.PbList<UpdateExpenseResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateExpenseResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateExpenseResponse>(create);
  static UpdateExpenseResponse? _defaultInstance;

  @$pb.TagNumber(1)
  ExpenseMessage get expense => $_getN(0);
  @$pb.TagNumber(1)
  set expense(ExpenseMessage v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasExpense() => $_has(0);
  @$pb.TagNumber(1)
  void clearExpense() => clearField(1);
  @$pb.TagNumber(1)
  ExpenseMessage ensureExpense() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => clearField(3);
}

class DeleteExpenseRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DeleteExpenseRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'expenseId')
    ..hasRequiredFields = false
  ;

  DeleteExpenseRequest._() : super();
  factory DeleteExpenseRequest({
    $core.String? expenseId,
  }) {
    final _result = create();
    if (expenseId != null) {
      _result.expenseId = expenseId;
    }
    return _result;
  }
  factory DeleteExpenseRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteExpenseRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteExpenseRequest clone() => DeleteExpenseRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteExpenseRequest copyWith(void Function(DeleteExpenseRequest) updates) => super.copyWith((message) => updates(message as DeleteExpenseRequest)) as DeleteExpenseRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DeleteExpenseRequest create() => DeleteExpenseRequest._();
  DeleteExpenseRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteExpenseRequest> createRepeated() => $pb.PbList<DeleteExpenseRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteExpenseRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteExpenseRequest>(create);
  static DeleteExpenseRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get expenseId => $_getSZ(0);
  @$pb.TagNumber(1)
  set expenseId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasExpenseId() => $_has(0);
  @$pb.TagNumber(1)
  void clearExpenseId() => clearField(1);
}

class DeleteExpenseResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DeleteExpenseResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  DeleteExpenseResponse._() : super();
  factory DeleteExpenseResponse({
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
  factory DeleteExpenseResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteExpenseResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteExpenseResponse clone() => DeleteExpenseResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteExpenseResponse copyWith(void Function(DeleteExpenseResponse) updates) => super.copyWith((message) => updates(message as DeleteExpenseResponse)) as DeleteExpenseResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DeleteExpenseResponse create() => DeleteExpenseResponse._();
  DeleteExpenseResponse createEmptyInstance() => create();
  static $pb.PbList<DeleteExpenseResponse> createRepeated() => $pb.PbList<DeleteExpenseResponse>();
  @$core.pragma('dart2js:noInline')
  static DeleteExpenseResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteExpenseResponse>(create);
  static DeleteExpenseResponse? _defaultInstance;

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

class CreateBudgetRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateBudgetRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..e<ExpenseCategory>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'category', $pb.PbFieldType.OE, defaultOrMaker: ExpenseCategory.EXPENSE_CATEGORY_UNSPECIFIED, valueOf: ExpenseCategory.valueOf, enumValues: ExpenseCategory.values)
    ..e<BudgetPeriod>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'period', $pb.PbFieldType.OE, defaultOrMaker: BudgetPeriod.BUDGET_PERIOD_UNSPECIFIED, valueOf: BudgetPeriod.valueOf, enumValues: BudgetPeriod.values)
    ..aOM<$36.Timestamp>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'startDate', subBuilder: $36.Timestamp.create)
    ..aOM<$36.Timestamp>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'endDate', subBuilder: $36.Timestamp.create)
    ..aOB(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'enableAlerts')
    ..a<$core.double>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'alertThreshold', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  CreateBudgetRequest._() : super();
  factory CreateBudgetRequest({
    $core.String? name,
    $core.double? amount,
    $core.String? currency,
    ExpenseCategory? category,
    BudgetPeriod? period,
    $36.Timestamp? startDate,
    $36.Timestamp? endDate,
    $core.bool? enableAlerts,
    $core.double? alertThreshold,
  }) {
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (category != null) {
      _result.category = category;
    }
    if (period != null) {
      _result.period = period;
    }
    if (startDate != null) {
      _result.startDate = startDate;
    }
    if (endDate != null) {
      _result.endDate = endDate;
    }
    if (enableAlerts != null) {
      _result.enableAlerts = enableAlerts;
    }
    if (alertThreshold != null) {
      _result.alertThreshold = alertThreshold;
    }
    return _result;
  }
  factory CreateBudgetRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateBudgetRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateBudgetRequest clone() => CreateBudgetRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateBudgetRequest copyWith(void Function(CreateBudgetRequest) updates) => super.copyWith((message) => updates(message as CreateBudgetRequest)) as CreateBudgetRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateBudgetRequest create() => CreateBudgetRequest._();
  CreateBudgetRequest createEmptyInstance() => create();
  static $pb.PbList<CreateBudgetRequest> createRepeated() => $pb.PbList<CreateBudgetRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateBudgetRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateBudgetRequest>(create);
  static CreateBudgetRequest? _defaultInstance;

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
  $core.String get currency => $_getSZ(2);
  @$pb.TagNumber(3)
  set currency($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCurrency() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrency() => clearField(3);

  @$pb.TagNumber(4)
  ExpenseCategory get category => $_getN(3);
  @$pb.TagNumber(4)
  set category(ExpenseCategory v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasCategory() => $_has(3);
  @$pb.TagNumber(4)
  void clearCategory() => clearField(4);

  @$pb.TagNumber(5)
  BudgetPeriod get period => $_getN(4);
  @$pb.TagNumber(5)
  set period(BudgetPeriod v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasPeriod() => $_has(4);
  @$pb.TagNumber(5)
  void clearPeriod() => clearField(5);

  @$pb.TagNumber(6)
  $36.Timestamp get startDate => $_getN(5);
  @$pb.TagNumber(6)
  set startDate($36.Timestamp v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasStartDate() => $_has(5);
  @$pb.TagNumber(6)
  void clearStartDate() => clearField(6);
  @$pb.TagNumber(6)
  $36.Timestamp ensureStartDate() => $_ensure(5);

  @$pb.TagNumber(7)
  $36.Timestamp get endDate => $_getN(6);
  @$pb.TagNumber(7)
  set endDate($36.Timestamp v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasEndDate() => $_has(6);
  @$pb.TagNumber(7)
  void clearEndDate() => clearField(7);
  @$pb.TagNumber(7)
  $36.Timestamp ensureEndDate() => $_ensure(6);

  @$pb.TagNumber(8)
  $core.bool get enableAlerts => $_getBF(7);
  @$pb.TagNumber(8)
  set enableAlerts($core.bool v) { $_setBool(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasEnableAlerts() => $_has(7);
  @$pb.TagNumber(8)
  void clearEnableAlerts() => clearField(8);

  @$pb.TagNumber(9)
  $core.double get alertThreshold => $_getN(8);
  @$pb.TagNumber(9)
  set alertThreshold($core.double v) { $_setDouble(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasAlertThreshold() => $_has(8);
  @$pb.TagNumber(9)
  void clearAlertThreshold() => clearField(9);
}

class CreateBudgetResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateBudgetResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<BudgetMessage>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'budget', subBuilder: BudgetMessage.create)
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  CreateBudgetResponse._() : super();
  factory CreateBudgetResponse({
    BudgetMessage? budget,
    $core.bool? success,
    $core.String? message,
  }) {
    final _result = create();
    if (budget != null) {
      _result.budget = budget;
    }
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory CreateBudgetResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateBudgetResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateBudgetResponse clone() => CreateBudgetResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateBudgetResponse copyWith(void Function(CreateBudgetResponse) updates) => super.copyWith((message) => updates(message as CreateBudgetResponse)) as CreateBudgetResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateBudgetResponse create() => CreateBudgetResponse._();
  CreateBudgetResponse createEmptyInstance() => create();
  static $pb.PbList<CreateBudgetResponse> createRepeated() => $pb.PbList<CreateBudgetResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateBudgetResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateBudgetResponse>(create);
  static CreateBudgetResponse? _defaultInstance;

  @$pb.TagNumber(1)
  BudgetMessage get budget => $_getN(0);
  @$pb.TagNumber(1)
  set budget(BudgetMessage v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasBudget() => $_has(0);
  @$pb.TagNumber(1)
  void clearBudget() => clearField(1);
  @$pb.TagNumber(1)
  BudgetMessage ensureBudget() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => clearField(3);
}

class GetBudgetsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetBudgetsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'perPage', $pb.PbFieldType.O3)
    ..e<BudgetStatus>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: BudgetStatus.BUDGET_STATUS_UNSPECIFIED, valueOf: BudgetStatus.valueOf, enumValues: BudgetStatus.values)
    ..e<ExpenseCategory>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'category', $pb.PbFieldType.OE, defaultOrMaker: ExpenseCategory.EXPENSE_CATEGORY_UNSPECIFIED, valueOf: ExpenseCategory.valueOf, enumValues: ExpenseCategory.values)
    ..hasRequiredFields = false
  ;

  GetBudgetsRequest._() : super();
  factory GetBudgetsRequest({
    $core.int? page,
    $core.int? perPage,
    BudgetStatus? status,
    ExpenseCategory? category,
  }) {
    final _result = create();
    if (page != null) {
      _result.page = page;
    }
    if (perPage != null) {
      _result.perPage = perPage;
    }
    if (status != null) {
      _result.status = status;
    }
    if (category != null) {
      _result.category = category;
    }
    return _result;
  }
  factory GetBudgetsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetBudgetsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetBudgetsRequest clone() => GetBudgetsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetBudgetsRequest copyWith(void Function(GetBudgetsRequest) updates) => super.copyWith((message) => updates(message as GetBudgetsRequest)) as GetBudgetsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetBudgetsRequest create() => GetBudgetsRequest._();
  GetBudgetsRequest createEmptyInstance() => create();
  static $pb.PbList<GetBudgetsRequest> createRepeated() => $pb.PbList<GetBudgetsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetBudgetsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetBudgetsRequest>(create);
  static GetBudgetsRequest? _defaultInstance;

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

  @$pb.TagNumber(3)
  BudgetStatus get status => $_getN(2);
  @$pb.TagNumber(3)
  set status(BudgetStatus v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasStatus() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatus() => clearField(3);

  @$pb.TagNumber(4)
  ExpenseCategory get category => $_getN(3);
  @$pb.TagNumber(4)
  set category(ExpenseCategory v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasCategory() => $_has(3);
  @$pb.TagNumber(4)
  void clearCategory() => clearField(4);
}

class GetBudgetsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetBudgetsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<BudgetMessage>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'budgets', $pb.PbFieldType.PM, subBuilder: BudgetMessage.create)
    ..aOM<PaginationMetadata>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pagination', subBuilder: PaginationMetadata.create)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalBudgetAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalSpentAmount', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  GetBudgetsResponse._() : super();
  factory GetBudgetsResponse({
    $core.Iterable<BudgetMessage>? budgets,
    PaginationMetadata? pagination,
    $core.double? totalBudgetAmount,
    $core.double? totalSpentAmount,
  }) {
    final _result = create();
    if (budgets != null) {
      _result.budgets.addAll(budgets);
    }
    if (pagination != null) {
      _result.pagination = pagination;
    }
    if (totalBudgetAmount != null) {
      _result.totalBudgetAmount = totalBudgetAmount;
    }
    if (totalSpentAmount != null) {
      _result.totalSpentAmount = totalSpentAmount;
    }
    return _result;
  }
  factory GetBudgetsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetBudgetsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetBudgetsResponse clone() => GetBudgetsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetBudgetsResponse copyWith(void Function(GetBudgetsResponse) updates) => super.copyWith((message) => updates(message as GetBudgetsResponse)) as GetBudgetsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetBudgetsResponse create() => GetBudgetsResponse._();
  GetBudgetsResponse createEmptyInstance() => create();
  static $pb.PbList<GetBudgetsResponse> createRepeated() => $pb.PbList<GetBudgetsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetBudgetsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetBudgetsResponse>(create);
  static GetBudgetsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<BudgetMessage> get budgets => $_getList(0);

  @$pb.TagNumber(2)
  PaginationMetadata get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination(PaginationMetadata v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => clearField(2);
  @$pb.TagNumber(2)
  PaginationMetadata ensurePagination() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.double get totalBudgetAmount => $_getN(2);
  @$pb.TagNumber(3)
  set totalBudgetAmount($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTotalBudgetAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalBudgetAmount() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get totalSpentAmount => $_getN(3);
  @$pb.TagNumber(4)
  set totalSpentAmount($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTotalSpentAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalSpentAmount() => clearField(4);
}

class GetBudgetByIdRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetBudgetByIdRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'budgetId')
    ..hasRequiredFields = false
  ;

  GetBudgetByIdRequest._() : super();
  factory GetBudgetByIdRequest({
    $core.String? budgetId,
  }) {
    final _result = create();
    if (budgetId != null) {
      _result.budgetId = budgetId;
    }
    return _result;
  }
  factory GetBudgetByIdRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetBudgetByIdRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetBudgetByIdRequest clone() => GetBudgetByIdRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetBudgetByIdRequest copyWith(void Function(GetBudgetByIdRequest) updates) => super.copyWith((message) => updates(message as GetBudgetByIdRequest)) as GetBudgetByIdRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetBudgetByIdRequest create() => GetBudgetByIdRequest._();
  GetBudgetByIdRequest createEmptyInstance() => create();
  static $pb.PbList<GetBudgetByIdRequest> createRepeated() => $pb.PbList<GetBudgetByIdRequest>();
  @$core.pragma('dart2js:noInline')
  static GetBudgetByIdRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetBudgetByIdRequest>(create);
  static GetBudgetByIdRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get budgetId => $_getSZ(0);
  @$pb.TagNumber(1)
  set budgetId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasBudgetId() => $_has(0);
  @$pb.TagNumber(1)
  void clearBudgetId() => clearField(1);
}

class GetBudgetByIdResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetBudgetByIdResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<BudgetMessage>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'budget', subBuilder: BudgetMessage.create)
    ..pc<ExpenseMessage>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recentExpenses', $pb.PbFieldType.PM, subBuilder: ExpenseMessage.create)
    ..hasRequiredFields = false
  ;

  GetBudgetByIdResponse._() : super();
  factory GetBudgetByIdResponse({
    BudgetMessage? budget,
    $core.Iterable<ExpenseMessage>? recentExpenses,
  }) {
    final _result = create();
    if (budget != null) {
      _result.budget = budget;
    }
    if (recentExpenses != null) {
      _result.recentExpenses.addAll(recentExpenses);
    }
    return _result;
  }
  factory GetBudgetByIdResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetBudgetByIdResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetBudgetByIdResponse clone() => GetBudgetByIdResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetBudgetByIdResponse copyWith(void Function(GetBudgetByIdResponse) updates) => super.copyWith((message) => updates(message as GetBudgetByIdResponse)) as GetBudgetByIdResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetBudgetByIdResponse create() => GetBudgetByIdResponse._();
  GetBudgetByIdResponse createEmptyInstance() => create();
  static $pb.PbList<GetBudgetByIdResponse> createRepeated() => $pb.PbList<GetBudgetByIdResponse>();
  @$core.pragma('dart2js:noInline')
  static GetBudgetByIdResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetBudgetByIdResponse>(create);
  static GetBudgetByIdResponse? _defaultInstance;

  @$pb.TagNumber(1)
  BudgetMessage get budget => $_getN(0);
  @$pb.TagNumber(1)
  set budget(BudgetMessage v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasBudget() => $_has(0);
  @$pb.TagNumber(1)
  void clearBudget() => clearField(1);
  @$pb.TagNumber(1)
  BudgetMessage ensureBudget() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.List<ExpenseMessage> get recentExpenses => $_getList(1);
}

class UpdateBudgetRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateBudgetRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'budgetId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..e<BudgetPeriod>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'period', $pb.PbFieldType.OE, defaultOrMaker: BudgetPeriod.BUDGET_PERIOD_UNSPECIFIED, valueOf: BudgetPeriod.valueOf, enumValues: BudgetPeriod.values)
    ..aOM<$36.Timestamp>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'startDate', subBuilder: $36.Timestamp.create)
    ..aOM<$36.Timestamp>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'endDate', subBuilder: $36.Timestamp.create)
    ..aOB(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'enableAlerts')
    ..a<$core.double>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'alertThreshold', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  UpdateBudgetRequest._() : super();
  factory UpdateBudgetRequest({
    $core.String? budgetId,
    $core.String? name,
    $core.double? amount,
    BudgetPeriod? period,
    $36.Timestamp? startDate,
    $36.Timestamp? endDate,
    $core.bool? enableAlerts,
    $core.double? alertThreshold,
  }) {
    final _result = create();
    if (budgetId != null) {
      _result.budgetId = budgetId;
    }
    if (name != null) {
      _result.name = name;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (period != null) {
      _result.period = period;
    }
    if (startDate != null) {
      _result.startDate = startDate;
    }
    if (endDate != null) {
      _result.endDate = endDate;
    }
    if (enableAlerts != null) {
      _result.enableAlerts = enableAlerts;
    }
    if (alertThreshold != null) {
      _result.alertThreshold = alertThreshold;
    }
    return _result;
  }
  factory UpdateBudgetRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateBudgetRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateBudgetRequest clone() => UpdateBudgetRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateBudgetRequest copyWith(void Function(UpdateBudgetRequest) updates) => super.copyWith((message) => updates(message as UpdateBudgetRequest)) as UpdateBudgetRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UpdateBudgetRequest create() => UpdateBudgetRequest._();
  UpdateBudgetRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateBudgetRequest> createRepeated() => $pb.PbList<UpdateBudgetRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateBudgetRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateBudgetRequest>(create);
  static UpdateBudgetRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get budgetId => $_getSZ(0);
  @$pb.TagNumber(1)
  set budgetId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasBudgetId() => $_has(0);
  @$pb.TagNumber(1)
  void clearBudgetId() => clearField(1);

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
  BudgetPeriod get period => $_getN(3);
  @$pb.TagNumber(4)
  set period(BudgetPeriod v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasPeriod() => $_has(3);
  @$pb.TagNumber(4)
  void clearPeriod() => clearField(4);

  @$pb.TagNumber(5)
  $36.Timestamp get startDate => $_getN(4);
  @$pb.TagNumber(5)
  set startDate($36.Timestamp v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasStartDate() => $_has(4);
  @$pb.TagNumber(5)
  void clearStartDate() => clearField(5);
  @$pb.TagNumber(5)
  $36.Timestamp ensureStartDate() => $_ensure(4);

  @$pb.TagNumber(6)
  $36.Timestamp get endDate => $_getN(5);
  @$pb.TagNumber(6)
  set endDate($36.Timestamp v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasEndDate() => $_has(5);
  @$pb.TagNumber(6)
  void clearEndDate() => clearField(6);
  @$pb.TagNumber(6)
  $36.Timestamp ensureEndDate() => $_ensure(5);

  @$pb.TagNumber(7)
  $core.bool get enableAlerts => $_getBF(6);
  @$pb.TagNumber(7)
  set enableAlerts($core.bool v) { $_setBool(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasEnableAlerts() => $_has(6);
  @$pb.TagNumber(7)
  void clearEnableAlerts() => clearField(7);

  @$pb.TagNumber(8)
  $core.double get alertThreshold => $_getN(7);
  @$pb.TagNumber(8)
  set alertThreshold($core.double v) { $_setDouble(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasAlertThreshold() => $_has(7);
  @$pb.TagNumber(8)
  void clearAlertThreshold() => clearField(8);
}

class UpdateBudgetResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateBudgetResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<BudgetMessage>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'budget', subBuilder: BudgetMessage.create)
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  UpdateBudgetResponse._() : super();
  factory UpdateBudgetResponse({
    BudgetMessage? budget,
    $core.bool? success,
    $core.String? message,
  }) {
    final _result = create();
    if (budget != null) {
      _result.budget = budget;
    }
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory UpdateBudgetResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateBudgetResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateBudgetResponse clone() => UpdateBudgetResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateBudgetResponse copyWith(void Function(UpdateBudgetResponse) updates) => super.copyWith((message) => updates(message as UpdateBudgetResponse)) as UpdateBudgetResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UpdateBudgetResponse create() => UpdateBudgetResponse._();
  UpdateBudgetResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateBudgetResponse> createRepeated() => $pb.PbList<UpdateBudgetResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateBudgetResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateBudgetResponse>(create);
  static UpdateBudgetResponse? _defaultInstance;

  @$pb.TagNumber(1)
  BudgetMessage get budget => $_getN(0);
  @$pb.TagNumber(1)
  set budget(BudgetMessage v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasBudget() => $_has(0);
  @$pb.TagNumber(1)
  void clearBudget() => clearField(1);
  @$pb.TagNumber(1)
  BudgetMessage ensureBudget() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => clearField(3);
}

class DeleteBudgetRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DeleteBudgetRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'budgetId')
    ..hasRequiredFields = false
  ;

  DeleteBudgetRequest._() : super();
  factory DeleteBudgetRequest({
    $core.String? budgetId,
  }) {
    final _result = create();
    if (budgetId != null) {
      _result.budgetId = budgetId;
    }
    return _result;
  }
  factory DeleteBudgetRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteBudgetRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteBudgetRequest clone() => DeleteBudgetRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteBudgetRequest copyWith(void Function(DeleteBudgetRequest) updates) => super.copyWith((message) => updates(message as DeleteBudgetRequest)) as DeleteBudgetRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DeleteBudgetRequest create() => DeleteBudgetRequest._();
  DeleteBudgetRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteBudgetRequest> createRepeated() => $pb.PbList<DeleteBudgetRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteBudgetRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteBudgetRequest>(create);
  static DeleteBudgetRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get budgetId => $_getSZ(0);
  @$pb.TagNumber(1)
  set budgetId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasBudgetId() => $_has(0);
  @$pb.TagNumber(1)
  void clearBudgetId() => clearField(1);
}

class DeleteBudgetResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DeleteBudgetResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  DeleteBudgetResponse._() : super();
  factory DeleteBudgetResponse({
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
  factory DeleteBudgetResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteBudgetResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteBudgetResponse clone() => DeleteBudgetResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteBudgetResponse copyWith(void Function(DeleteBudgetResponse) updates) => super.copyWith((message) => updates(message as DeleteBudgetResponse)) as DeleteBudgetResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DeleteBudgetResponse create() => DeleteBudgetResponse._();
  DeleteBudgetResponse createEmptyInstance() => create();
  static $pb.PbList<DeleteBudgetResponse> createRepeated() => $pb.PbList<DeleteBudgetResponse>();
  @$core.pragma('dart2js:noInline')
  static DeleteBudgetResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteBudgetResponse>(create);
  static DeleteBudgetResponse? _defaultInstance;

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

class GetSpendingAnalyticsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetSpendingAnalyticsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'period')
    ..aOM<$36.Timestamp>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'startDate', subBuilder: $36.Timestamp.create)
    ..aOM<$36.Timestamp>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'endDate', subBuilder: $36.Timestamp.create)
    ..e<ExpenseCategory>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'category', $pb.PbFieldType.OE, defaultOrMaker: ExpenseCategory.EXPENSE_CATEGORY_UNSPECIFIED, valueOf: ExpenseCategory.valueOf, enumValues: ExpenseCategory.values)
    ..hasRequiredFields = false
  ;

  GetSpendingAnalyticsRequest._() : super();
  factory GetSpendingAnalyticsRequest({
    $core.String? period,
    $36.Timestamp? startDate,
    $36.Timestamp? endDate,
    ExpenseCategory? category,
  }) {
    final _result = create();
    if (period != null) {
      _result.period = period;
    }
    if (startDate != null) {
      _result.startDate = startDate;
    }
    if (endDate != null) {
      _result.endDate = endDate;
    }
    if (category != null) {
      _result.category = category;
    }
    return _result;
  }
  factory GetSpendingAnalyticsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetSpendingAnalyticsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetSpendingAnalyticsRequest clone() => GetSpendingAnalyticsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetSpendingAnalyticsRequest copyWith(void Function(GetSpendingAnalyticsRequest) updates) => super.copyWith((message) => updates(message as GetSpendingAnalyticsRequest)) as GetSpendingAnalyticsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetSpendingAnalyticsRequest create() => GetSpendingAnalyticsRequest._();
  GetSpendingAnalyticsRequest createEmptyInstance() => create();
  static $pb.PbList<GetSpendingAnalyticsRequest> createRepeated() => $pb.PbList<GetSpendingAnalyticsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetSpendingAnalyticsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetSpendingAnalyticsRequest>(create);
  static GetSpendingAnalyticsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get period => $_getSZ(0);
  @$pb.TagNumber(1)
  set period($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPeriod() => $_has(0);
  @$pb.TagNumber(1)
  void clearPeriod() => clearField(1);

  @$pb.TagNumber(2)
  $36.Timestamp get startDate => $_getN(1);
  @$pb.TagNumber(2)
  set startDate($36.Timestamp v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasStartDate() => $_has(1);
  @$pb.TagNumber(2)
  void clearStartDate() => clearField(2);
  @$pb.TagNumber(2)
  $36.Timestamp ensureStartDate() => $_ensure(1);

  @$pb.TagNumber(3)
  $36.Timestamp get endDate => $_getN(2);
  @$pb.TagNumber(3)
  set endDate($36.Timestamp v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasEndDate() => $_has(2);
  @$pb.TagNumber(3)
  void clearEndDate() => clearField(3);
  @$pb.TagNumber(3)
  $36.Timestamp ensureEndDate() => $_ensure(2);

  @$pb.TagNumber(4)
  ExpenseCategory get category => $_getN(3);
  @$pb.TagNumber(4)
  set category(ExpenseCategory v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasCategory() => $_has(3);
  @$pb.TagNumber(4)
  void clearCategory() => clearField(4);
}

class GetSpendingAnalyticsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetSpendingAnalyticsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<SpendingAnalytics>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'analytics', subBuilder: SpendingAnalytics.create)
    ..hasRequiredFields = false
  ;

  GetSpendingAnalyticsResponse._() : super();
  factory GetSpendingAnalyticsResponse({
    SpendingAnalytics? analytics,
  }) {
    final _result = create();
    if (analytics != null) {
      _result.analytics = analytics;
    }
    return _result;
  }
  factory GetSpendingAnalyticsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetSpendingAnalyticsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetSpendingAnalyticsResponse clone() => GetSpendingAnalyticsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetSpendingAnalyticsResponse copyWith(void Function(GetSpendingAnalyticsResponse) updates) => super.copyWith((message) => updates(message as GetSpendingAnalyticsResponse)) as GetSpendingAnalyticsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetSpendingAnalyticsResponse create() => GetSpendingAnalyticsResponse._();
  GetSpendingAnalyticsResponse createEmptyInstance() => create();
  static $pb.PbList<GetSpendingAnalyticsResponse> createRepeated() => $pb.PbList<GetSpendingAnalyticsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetSpendingAnalyticsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetSpendingAnalyticsResponse>(create);
  static GetSpendingAnalyticsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  SpendingAnalytics get analytics => $_getN(0);
  @$pb.TagNumber(1)
  set analytics(SpendingAnalytics v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasAnalytics() => $_has(0);
  @$pb.TagNumber(1)
  void clearAnalytics() => clearField(1);
  @$pb.TagNumber(1)
  SpendingAnalytics ensureAnalytics() => $_ensure(0);
}

class GetCategoryBreakdownRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetCategoryBreakdownRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<$36.Timestamp>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'startDate', subBuilder: $36.Timestamp.create)
    ..aOM<$36.Timestamp>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'endDate', subBuilder: $36.Timestamp.create)
    ..hasRequiredFields = false
  ;

  GetCategoryBreakdownRequest._() : super();
  factory GetCategoryBreakdownRequest({
    $36.Timestamp? startDate,
    $36.Timestamp? endDate,
  }) {
    final _result = create();
    if (startDate != null) {
      _result.startDate = startDate;
    }
    if (endDate != null) {
      _result.endDate = endDate;
    }
    return _result;
  }
  factory GetCategoryBreakdownRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCategoryBreakdownRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCategoryBreakdownRequest clone() => GetCategoryBreakdownRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCategoryBreakdownRequest copyWith(void Function(GetCategoryBreakdownRequest) updates) => super.copyWith((message) => updates(message as GetCategoryBreakdownRequest)) as GetCategoryBreakdownRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetCategoryBreakdownRequest create() => GetCategoryBreakdownRequest._();
  GetCategoryBreakdownRequest createEmptyInstance() => create();
  static $pb.PbList<GetCategoryBreakdownRequest> createRepeated() => $pb.PbList<GetCategoryBreakdownRequest>();
  @$core.pragma('dart2js:noInline')
  static GetCategoryBreakdownRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetCategoryBreakdownRequest>(create);
  static GetCategoryBreakdownRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $36.Timestamp get startDate => $_getN(0);
  @$pb.TagNumber(1)
  set startDate($36.Timestamp v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasStartDate() => $_has(0);
  @$pb.TagNumber(1)
  void clearStartDate() => clearField(1);
  @$pb.TagNumber(1)
  $36.Timestamp ensureStartDate() => $_ensure(0);

  @$pb.TagNumber(2)
  $36.Timestamp get endDate => $_getN(1);
  @$pb.TagNumber(2)
  set endDate($36.Timestamp v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasEndDate() => $_has(1);
  @$pb.TagNumber(2)
  void clearEndDate() => clearField(2);
  @$pb.TagNumber(2)
  $36.Timestamp ensureEndDate() => $_ensure(1);
}

class GetCategoryBreakdownResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetCategoryBreakdownResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<CategorySpending>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'categories', $pb.PbFieldType.PM, subBuilder: CategorySpending.create)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalSpent', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  GetCategoryBreakdownResponse._() : super();
  factory GetCategoryBreakdownResponse({
    $core.Iterable<CategorySpending>? categories,
    $core.double? totalSpent,
  }) {
    final _result = create();
    if (categories != null) {
      _result.categories.addAll(categories);
    }
    if (totalSpent != null) {
      _result.totalSpent = totalSpent;
    }
    return _result;
  }
  factory GetCategoryBreakdownResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCategoryBreakdownResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCategoryBreakdownResponse clone() => GetCategoryBreakdownResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCategoryBreakdownResponse copyWith(void Function(GetCategoryBreakdownResponse) updates) => super.copyWith((message) => updates(message as GetCategoryBreakdownResponse)) as GetCategoryBreakdownResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetCategoryBreakdownResponse create() => GetCategoryBreakdownResponse._();
  GetCategoryBreakdownResponse createEmptyInstance() => create();
  static $pb.PbList<GetCategoryBreakdownResponse> createRepeated() => $pb.PbList<GetCategoryBreakdownResponse>();
  @$core.pragma('dart2js:noInline')
  static GetCategoryBreakdownResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetCategoryBreakdownResponse>(create);
  static GetCategoryBreakdownResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<CategorySpending> get categories => $_getList(0);

  @$pb.TagNumber(2)
  $core.double get totalSpent => $_getN(1);
  @$pb.TagNumber(2)
  set totalSpent($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotalSpent() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalSpent() => clearField(2);
}

class GetBudgetProgressRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetBudgetProgressRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..e<BudgetPeriod>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'period', $pb.PbFieldType.OE, defaultOrMaker: BudgetPeriod.BUDGET_PERIOD_UNSPECIFIED, valueOf: BudgetPeriod.valueOf, enumValues: BudgetPeriod.values)
    ..hasRequiredFields = false
  ;

  GetBudgetProgressRequest._() : super();
  factory GetBudgetProgressRequest({
    BudgetPeriod? period,
  }) {
    final _result = create();
    if (period != null) {
      _result.period = period;
    }
    return _result;
  }
  factory GetBudgetProgressRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetBudgetProgressRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetBudgetProgressRequest clone() => GetBudgetProgressRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetBudgetProgressRequest copyWith(void Function(GetBudgetProgressRequest) updates) => super.copyWith((message) => updates(message as GetBudgetProgressRequest)) as GetBudgetProgressRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetBudgetProgressRequest create() => GetBudgetProgressRequest._();
  GetBudgetProgressRequest createEmptyInstance() => create();
  static $pb.PbList<GetBudgetProgressRequest> createRepeated() => $pb.PbList<GetBudgetProgressRequest>();
  @$core.pragma('dart2js:noInline')
  static GetBudgetProgressRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetBudgetProgressRequest>(create);
  static GetBudgetProgressRequest? _defaultInstance;

  @$pb.TagNumber(1)
  BudgetPeriod get period => $_getN(0);
  @$pb.TagNumber(1)
  set period(BudgetPeriod v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasPeriod() => $_has(0);
  @$pb.TagNumber(1)
  void clearPeriod() => clearField(1);
}

class GetBudgetProgressResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetBudgetProgressResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<BudgetProgressItem>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'budgets', $pb.PbFieldType.PM, subBuilder: BudgetProgressItem.create)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalBudget', $pb.PbFieldType.OD)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalSpent', $pb.PbFieldType.OD)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'overallPercentage', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  GetBudgetProgressResponse._() : super();
  factory GetBudgetProgressResponse({
    $core.Iterable<BudgetProgressItem>? budgets,
    $core.double? totalBudget,
    $core.double? totalSpent,
    $core.double? overallPercentage,
  }) {
    final _result = create();
    if (budgets != null) {
      _result.budgets.addAll(budgets);
    }
    if (totalBudget != null) {
      _result.totalBudget = totalBudget;
    }
    if (totalSpent != null) {
      _result.totalSpent = totalSpent;
    }
    if (overallPercentage != null) {
      _result.overallPercentage = overallPercentage;
    }
    return _result;
  }
  factory GetBudgetProgressResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetBudgetProgressResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetBudgetProgressResponse clone() => GetBudgetProgressResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetBudgetProgressResponse copyWith(void Function(GetBudgetProgressResponse) updates) => super.copyWith((message) => updates(message as GetBudgetProgressResponse)) as GetBudgetProgressResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetBudgetProgressResponse create() => GetBudgetProgressResponse._();
  GetBudgetProgressResponse createEmptyInstance() => create();
  static $pb.PbList<GetBudgetProgressResponse> createRepeated() => $pb.PbList<GetBudgetProgressResponse>();
  @$core.pragma('dart2js:noInline')
  static GetBudgetProgressResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetBudgetProgressResponse>(create);
  static GetBudgetProgressResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<BudgetProgressItem> get budgets => $_getList(0);

  @$pb.TagNumber(2)
  $core.double get totalBudget => $_getN(1);
  @$pb.TagNumber(2)
  set totalBudget($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotalBudget() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalBudget() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get totalSpent => $_getN(2);
  @$pb.TagNumber(3)
  set totalSpent($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTotalSpent() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalSpent() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get overallPercentage => $_getN(3);
  @$pb.TagNumber(4)
  set overallPercentage($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasOverallPercentage() => $_has(3);
  @$pb.TagNumber(4)
  void clearOverallPercentage() => clearField(4);
}

class GetSpendingTrendsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetSpendingTrendsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'periodType')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'periodsCount', $pb.PbFieldType.O3)
    ..aOM<$36.Timestamp>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'endDate', subBuilder: $36.Timestamp.create)
    ..hasRequiredFields = false
  ;

  GetSpendingTrendsRequest._() : super();
  factory GetSpendingTrendsRequest({
    $core.String? periodType,
    $core.int? periodsCount,
    $36.Timestamp? endDate,
  }) {
    final _result = create();
    if (periodType != null) {
      _result.periodType = periodType;
    }
    if (periodsCount != null) {
      _result.periodsCount = periodsCount;
    }
    if (endDate != null) {
      _result.endDate = endDate;
    }
    return _result;
  }
  factory GetSpendingTrendsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetSpendingTrendsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetSpendingTrendsRequest clone() => GetSpendingTrendsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetSpendingTrendsRequest copyWith(void Function(GetSpendingTrendsRequest) updates) => super.copyWith((message) => updates(message as GetSpendingTrendsRequest)) as GetSpendingTrendsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetSpendingTrendsRequest create() => GetSpendingTrendsRequest._();
  GetSpendingTrendsRequest createEmptyInstance() => create();
  static $pb.PbList<GetSpendingTrendsRequest> createRepeated() => $pb.PbList<GetSpendingTrendsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetSpendingTrendsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetSpendingTrendsRequest>(create);
  static GetSpendingTrendsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get periodType => $_getSZ(0);
  @$pb.TagNumber(1)
  set periodType($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPeriodType() => $_has(0);
  @$pb.TagNumber(1)
  void clearPeriodType() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get periodsCount => $_getIZ(1);
  @$pb.TagNumber(2)
  set periodsCount($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPeriodsCount() => $_has(1);
  @$pb.TagNumber(2)
  void clearPeriodsCount() => clearField(2);

  @$pb.TagNumber(3)
  $36.Timestamp get endDate => $_getN(2);
  @$pb.TagNumber(3)
  set endDate($36.Timestamp v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasEndDate() => $_has(2);
  @$pb.TagNumber(3)
  void clearEndDate() => clearField(3);
  @$pb.TagNumber(3)
  $36.Timestamp ensureEndDate() => $_ensure(2);
}

class GetSpendingTrendsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetSpendingTrendsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<SpendingTrend>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'trends', $pb.PbFieldType.PM, subBuilder: SpendingTrend.create)
    ..hasRequiredFields = false
  ;

  GetSpendingTrendsResponse._() : super();
  factory GetSpendingTrendsResponse({
    $core.Iterable<SpendingTrend>? trends,
  }) {
    final _result = create();
    if (trends != null) {
      _result.trends.addAll(trends);
    }
    return _result;
  }
  factory GetSpendingTrendsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetSpendingTrendsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetSpendingTrendsResponse clone() => GetSpendingTrendsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetSpendingTrendsResponse copyWith(void Function(GetSpendingTrendsResponse) updates) => super.copyWith((message) => updates(message as GetSpendingTrendsResponse)) as GetSpendingTrendsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetSpendingTrendsResponse create() => GetSpendingTrendsResponse._();
  GetSpendingTrendsResponse createEmptyInstance() => create();
  static $pb.PbList<GetSpendingTrendsResponse> createRepeated() => $pb.PbList<GetSpendingTrendsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetSpendingTrendsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetSpendingTrendsResponse>(create);
  static GetSpendingTrendsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<SpendingTrend> get trends => $_getList(0);
}

class GetBudgetAlertsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetBudgetAlertsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'unreadOnly')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetBudgetAlertsRequest._() : super();
  factory GetBudgetAlertsRequest({
    $core.bool? unreadOnly,
    $core.int? limit,
  }) {
    final _result = create();
    if (unreadOnly != null) {
      _result.unreadOnly = unreadOnly;
    }
    if (limit != null) {
      _result.limit = limit;
    }
    return _result;
  }
  factory GetBudgetAlertsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetBudgetAlertsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetBudgetAlertsRequest clone() => GetBudgetAlertsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetBudgetAlertsRequest copyWith(void Function(GetBudgetAlertsRequest) updates) => super.copyWith((message) => updates(message as GetBudgetAlertsRequest)) as GetBudgetAlertsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetBudgetAlertsRequest create() => GetBudgetAlertsRequest._();
  GetBudgetAlertsRequest createEmptyInstance() => create();
  static $pb.PbList<GetBudgetAlertsRequest> createRepeated() => $pb.PbList<GetBudgetAlertsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetBudgetAlertsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetBudgetAlertsRequest>(create);
  static GetBudgetAlertsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get unreadOnly => $_getBF(0);
  @$pb.TagNumber(1)
  set unreadOnly($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUnreadOnly() => $_has(0);
  @$pb.TagNumber(1)
  void clearUnreadOnly() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get limit => $_getIZ(1);
  @$pb.TagNumber(2)
  set limit($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearLimit() => clearField(2);
}

class GetBudgetAlertsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetBudgetAlertsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<BudgetAlertMessage>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'alerts', $pb.PbFieldType.PM, subBuilder: BudgetAlertMessage.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'unreadCount', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetBudgetAlertsResponse._() : super();
  factory GetBudgetAlertsResponse({
    $core.Iterable<BudgetAlertMessage>? alerts,
    $core.int? unreadCount,
  }) {
    final _result = create();
    if (alerts != null) {
      _result.alerts.addAll(alerts);
    }
    if (unreadCount != null) {
      _result.unreadCount = unreadCount;
    }
    return _result;
  }
  factory GetBudgetAlertsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetBudgetAlertsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetBudgetAlertsResponse clone() => GetBudgetAlertsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetBudgetAlertsResponse copyWith(void Function(GetBudgetAlertsResponse) updates) => super.copyWith((message) => updates(message as GetBudgetAlertsResponse)) as GetBudgetAlertsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetBudgetAlertsResponse create() => GetBudgetAlertsResponse._();
  GetBudgetAlertsResponse createEmptyInstance() => create();
  static $pb.PbList<GetBudgetAlertsResponse> createRepeated() => $pb.PbList<GetBudgetAlertsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetBudgetAlertsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetBudgetAlertsResponse>(create);
  static GetBudgetAlertsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<BudgetAlertMessage> get alerts => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get unreadCount => $_getIZ(1);
  @$pb.TagNumber(2)
  set unreadCount($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUnreadCount() => $_has(1);
  @$pb.TagNumber(2)
  void clearUnreadCount() => clearField(2);
}

class MarkAlertAsReadRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MarkAlertAsReadRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'alertId')
    ..hasRequiredFields = false
  ;

  MarkAlertAsReadRequest._() : super();
  factory MarkAlertAsReadRequest({
    $core.String? alertId,
  }) {
    final _result = create();
    if (alertId != null) {
      _result.alertId = alertId;
    }
    return _result;
  }
  factory MarkAlertAsReadRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MarkAlertAsReadRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MarkAlertAsReadRequest clone() => MarkAlertAsReadRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MarkAlertAsReadRequest copyWith(void Function(MarkAlertAsReadRequest) updates) => super.copyWith((message) => updates(message as MarkAlertAsReadRequest)) as MarkAlertAsReadRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MarkAlertAsReadRequest create() => MarkAlertAsReadRequest._();
  MarkAlertAsReadRequest createEmptyInstance() => create();
  static $pb.PbList<MarkAlertAsReadRequest> createRepeated() => $pb.PbList<MarkAlertAsReadRequest>();
  @$core.pragma('dart2js:noInline')
  static MarkAlertAsReadRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MarkAlertAsReadRequest>(create);
  static MarkAlertAsReadRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get alertId => $_getSZ(0);
  @$pb.TagNumber(1)
  set alertId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAlertId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAlertId() => clearField(1);
}

class MarkAlertAsReadResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MarkAlertAsReadResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..hasRequiredFields = false
  ;

  MarkAlertAsReadResponse._() : super();
  factory MarkAlertAsReadResponse({
    $core.bool? success,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    return _result;
  }
  factory MarkAlertAsReadResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MarkAlertAsReadResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MarkAlertAsReadResponse clone() => MarkAlertAsReadResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MarkAlertAsReadResponse copyWith(void Function(MarkAlertAsReadResponse) updates) => super.copyWith((message) => updates(message as MarkAlertAsReadResponse)) as MarkAlertAsReadResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MarkAlertAsReadResponse create() => MarkAlertAsReadResponse._();
  MarkAlertAsReadResponse createEmptyInstance() => create();
  static $pb.PbList<MarkAlertAsReadResponse> createRepeated() => $pb.PbList<MarkAlertAsReadResponse>();
  @$core.pragma('dart2js:noInline')
  static MarkAlertAsReadResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MarkAlertAsReadResponse>(create);
  static MarkAlertAsReadResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);
}

class PaginationMetadata extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PaginationMetadata', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currentPage', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'perPage', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalPages', $pb.PbFieldType.O3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalItems', $pb.PbFieldType.O3)
    ..aOB(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hasNext')
    ..aOB(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hasPrev')
    ..hasRequiredFields = false
  ;

  PaginationMetadata._() : super();
  factory PaginationMetadata({
    $core.int? currentPage,
    $core.int? perPage,
    $core.int? totalPages,
    $core.int? totalItems,
    $core.bool? hasNext,
    $core.bool? hasPrev,
  }) {
    final _result = create();
    if (currentPage != null) {
      _result.currentPage = currentPage;
    }
    if (perPage != null) {
      _result.perPage = perPage;
    }
    if (totalPages != null) {
      _result.totalPages = totalPages;
    }
    if (totalItems != null) {
      _result.totalItems = totalItems;
    }
    if (hasNext != null) {
      _result.hasNext = hasNext;
    }
    if (hasPrev != null) {
      _result.hasPrev = hasPrev;
    }
    return _result;
  }
  factory PaginationMetadata.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PaginationMetadata.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PaginationMetadata clone() => PaginationMetadata()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PaginationMetadata copyWith(void Function(PaginationMetadata) updates) => super.copyWith((message) => updates(message as PaginationMetadata)) as PaginationMetadata; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PaginationMetadata create() => PaginationMetadata._();
  PaginationMetadata createEmptyInstance() => create();
  static $pb.PbList<PaginationMetadata> createRepeated() => $pb.PbList<PaginationMetadata>();
  @$core.pragma('dart2js:noInline')
  static PaginationMetadata getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PaginationMetadata>(create);
  static PaginationMetadata? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get currentPage => $_getIZ(0);
  @$pb.TagNumber(1)
  set currentPage($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCurrentPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearCurrentPage() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get perPage => $_getIZ(1);
  @$pb.TagNumber(2)
  set perPage($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPerPage() => $_has(1);
  @$pb.TagNumber(2)
  void clearPerPage() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get totalPages => $_getIZ(2);
  @$pb.TagNumber(3)
  set totalPages($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTotalPages() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalPages() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get totalItems => $_getIZ(3);
  @$pb.TagNumber(4)
  set totalItems($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTotalItems() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalItems() => clearField(4);

  @$pb.TagNumber(5)
  $core.bool get hasNext => $_getBF(4);
  @$pb.TagNumber(5)
  set hasNext($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasHasNext() => $_has(4);
  @$pb.TagNumber(5)
  void clearHasNext() => clearField(5);

  @$pb.TagNumber(6)
  $core.bool get hasPrev => $_getBF(5);
  @$pb.TagNumber(6)
  set hasPrev($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasHasPrev() => $_has(5);
  @$pb.TagNumber(6)
  void clearHasPrev() => clearField(6);
}

class GetAISpendingInsightsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetAISpendingInsightsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<$36.Timestamp>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'startDate', subBuilder: $36.Timestamp.create)
    ..aOM<$36.Timestamp>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'endDate', subBuilder: $36.Timestamp.create)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'focusArea')
    ..hasRequiredFields = false
  ;

  GetAISpendingInsightsRequest._() : super();
  factory GetAISpendingInsightsRequest({
    $36.Timestamp? startDate,
    $36.Timestamp? endDate,
    $core.String? focusArea,
  }) {
    final _result = create();
    if (startDate != null) {
      _result.startDate = startDate;
    }
    if (endDate != null) {
      _result.endDate = endDate;
    }
    if (focusArea != null) {
      _result.focusArea = focusArea;
    }
    return _result;
  }
  factory GetAISpendingInsightsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAISpendingInsightsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAISpendingInsightsRequest clone() => GetAISpendingInsightsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAISpendingInsightsRequest copyWith(void Function(GetAISpendingInsightsRequest) updates) => super.copyWith((message) => updates(message as GetAISpendingInsightsRequest)) as GetAISpendingInsightsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetAISpendingInsightsRequest create() => GetAISpendingInsightsRequest._();
  GetAISpendingInsightsRequest createEmptyInstance() => create();
  static $pb.PbList<GetAISpendingInsightsRequest> createRepeated() => $pb.PbList<GetAISpendingInsightsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetAISpendingInsightsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAISpendingInsightsRequest>(create);
  static GetAISpendingInsightsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $36.Timestamp get startDate => $_getN(0);
  @$pb.TagNumber(1)
  set startDate($36.Timestamp v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasStartDate() => $_has(0);
  @$pb.TagNumber(1)
  void clearStartDate() => clearField(1);
  @$pb.TagNumber(1)
  $36.Timestamp ensureStartDate() => $_ensure(0);

  @$pb.TagNumber(2)
  $36.Timestamp get endDate => $_getN(1);
  @$pb.TagNumber(2)
  set endDate($36.Timestamp v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasEndDate() => $_has(1);
  @$pb.TagNumber(2)
  void clearEndDate() => clearField(2);
  @$pb.TagNumber(2)
  $36.Timestamp ensureEndDate() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.String get focusArea => $_getSZ(2);
  @$pb.TagNumber(3)
  set focusArea($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasFocusArea() => $_has(2);
  @$pb.TagNumber(3)
  void clearFocusArea() => clearField(3);
}

class GetAISpendingInsightsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetAISpendingInsightsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'summary')
    ..pc<AIInsight>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'insights', $pb.PbFieldType.PM, subBuilder: AIInsight.create)
    ..pc<AIRecommendation>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recommendations', $pb.PbFieldType.PM, subBuilder: AIRecommendation.create)
    ..pc<AnomalyDetection>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'anomalies', $pb.PbFieldType.PM, subBuilder: AnomalyDetection.create)
    ..hasRequiredFields = false
  ;

  GetAISpendingInsightsResponse._() : super();
  factory GetAISpendingInsightsResponse({
    $core.bool? success,
    $core.String? summary,
    $core.Iterable<AIInsight>? insights,
    $core.Iterable<AIRecommendation>? recommendations,
    $core.Iterable<AnomalyDetection>? anomalies,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (summary != null) {
      _result.summary = summary;
    }
    if (insights != null) {
      _result.insights.addAll(insights);
    }
    if (recommendations != null) {
      _result.recommendations.addAll(recommendations);
    }
    if (anomalies != null) {
      _result.anomalies.addAll(anomalies);
    }
    return _result;
  }
  factory GetAISpendingInsightsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAISpendingInsightsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAISpendingInsightsResponse clone() => GetAISpendingInsightsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAISpendingInsightsResponse copyWith(void Function(GetAISpendingInsightsResponse) updates) => super.copyWith((message) => updates(message as GetAISpendingInsightsResponse)) as GetAISpendingInsightsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetAISpendingInsightsResponse create() => GetAISpendingInsightsResponse._();
  GetAISpendingInsightsResponse createEmptyInstance() => create();
  static $pb.PbList<GetAISpendingInsightsResponse> createRepeated() => $pb.PbList<GetAISpendingInsightsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetAISpendingInsightsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAISpendingInsightsResponse>(create);
  static GetAISpendingInsightsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get summary => $_getSZ(1);
  @$pb.TagNumber(2)
  set summary($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSummary() => $_has(1);
  @$pb.TagNumber(2)
  void clearSummary() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<AIInsight> get insights => $_getList(2);

  @$pb.TagNumber(4)
  $core.List<AIRecommendation> get recommendations => $_getList(3);

  @$pb.TagNumber(5)
  $core.List<AnomalyDetection> get anomalies => $_getList(4);
}

class AIInsight extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AIInsight', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'title')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'insightType')
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'impactAmount', $pb.PbFieldType.OD)
    ..pPS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'supportingData')
    ..hasRequiredFields = false
  ;

  AIInsight._() : super();
  factory AIInsight({
    $core.String? title,
    $core.String? description,
    $core.String? insightType,
    $core.double? impactAmount,
    $core.Iterable<$core.String>? supportingData,
  }) {
    final _result = create();
    if (title != null) {
      _result.title = title;
    }
    if (description != null) {
      _result.description = description;
    }
    if (insightType != null) {
      _result.insightType = insightType;
    }
    if (impactAmount != null) {
      _result.impactAmount = impactAmount;
    }
    if (supportingData != null) {
      _result.supportingData.addAll(supportingData);
    }
    return _result;
  }
  factory AIInsight.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AIInsight.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AIInsight clone() => AIInsight()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AIInsight copyWith(void Function(AIInsight) updates) => super.copyWith((message) => updates(message as AIInsight)) as AIInsight; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AIInsight create() => AIInsight._();
  AIInsight createEmptyInstance() => create();
  static $pb.PbList<AIInsight> createRepeated() => $pb.PbList<AIInsight>();
  @$core.pragma('dart2js:noInline')
  static AIInsight getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AIInsight>(create);
  static AIInsight? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get title => $_getSZ(0);
  @$pb.TagNumber(1)
  set title($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTitle() => $_has(0);
  @$pb.TagNumber(1)
  void clearTitle() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get description => $_getSZ(1);
  @$pb.TagNumber(2)
  set description($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasDescription() => $_has(1);
  @$pb.TagNumber(2)
  void clearDescription() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get insightType => $_getSZ(2);
  @$pb.TagNumber(3)
  set insightType($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasInsightType() => $_has(2);
  @$pb.TagNumber(3)
  void clearInsightType() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get impactAmount => $_getN(3);
  @$pb.TagNumber(4)
  set impactAmount($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasImpactAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearImpactAmount() => clearField(4);

  @$pb.TagNumber(5)
  $core.List<$core.String> get supportingData => $_getList(4);
}

class AIRecommendation extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AIRecommendation', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'title')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'action')
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'potentialSavings', $pb.PbFieldType.OD)
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'priority')
    ..e<ExpenseCategory>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'affectedCategory', $pb.PbFieldType.OE, defaultOrMaker: ExpenseCategory.EXPENSE_CATEGORY_UNSPECIFIED, valueOf: ExpenseCategory.valueOf, enumValues: ExpenseCategory.values)
    ..hasRequiredFields = false
  ;

  AIRecommendation._() : super();
  factory AIRecommendation({
    $core.String? title,
    $core.String? description,
    $core.String? action,
    $core.double? potentialSavings,
    $core.String? priority,
    ExpenseCategory? affectedCategory,
  }) {
    final _result = create();
    if (title != null) {
      _result.title = title;
    }
    if (description != null) {
      _result.description = description;
    }
    if (action != null) {
      _result.action = action;
    }
    if (potentialSavings != null) {
      _result.potentialSavings = potentialSavings;
    }
    if (priority != null) {
      _result.priority = priority;
    }
    if (affectedCategory != null) {
      _result.affectedCategory = affectedCategory;
    }
    return _result;
  }
  factory AIRecommendation.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AIRecommendation.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AIRecommendation clone() => AIRecommendation()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AIRecommendation copyWith(void Function(AIRecommendation) updates) => super.copyWith((message) => updates(message as AIRecommendation)) as AIRecommendation; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AIRecommendation create() => AIRecommendation._();
  AIRecommendation createEmptyInstance() => create();
  static $pb.PbList<AIRecommendation> createRepeated() => $pb.PbList<AIRecommendation>();
  @$core.pragma('dart2js:noInline')
  static AIRecommendation getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AIRecommendation>(create);
  static AIRecommendation? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get title => $_getSZ(0);
  @$pb.TagNumber(1)
  set title($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTitle() => $_has(0);
  @$pb.TagNumber(1)
  void clearTitle() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get description => $_getSZ(1);
  @$pb.TagNumber(2)
  set description($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasDescription() => $_has(1);
  @$pb.TagNumber(2)
  void clearDescription() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get action => $_getSZ(2);
  @$pb.TagNumber(3)
  set action($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAction() => $_has(2);
  @$pb.TagNumber(3)
  void clearAction() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get potentialSavings => $_getN(3);
  @$pb.TagNumber(4)
  set potentialSavings($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPotentialSavings() => $_has(3);
  @$pb.TagNumber(4)
  void clearPotentialSavings() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get priority => $_getSZ(4);
  @$pb.TagNumber(5)
  set priority($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasPriority() => $_has(4);
  @$pb.TagNumber(5)
  void clearPriority() => clearField(5);

  @$pb.TagNumber(6)
  ExpenseCategory get affectedCategory => $_getN(5);
  @$pb.TagNumber(6)
  set affectedCategory(ExpenseCategory v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasAffectedCategory() => $_has(5);
  @$pb.TagNumber(6)
  void clearAffectedCategory() => clearField(6);
}

class AnomalyDetection extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AnomalyDetection', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'anomalyType')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..aOM<$36.Timestamp>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'detectedDate', subBuilder: $36.Timestamp.create)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..e<ExpenseCategory>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'category', $pb.PbFieldType.OE, defaultOrMaker: ExpenseCategory.EXPENSE_CATEGORY_UNSPECIFIED, valueOf: ExpenseCategory.valueOf, enumValues: ExpenseCategory.values)
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'severity')
    ..hasRequiredFields = false
  ;

  AnomalyDetection._() : super();
  factory AnomalyDetection({
    $core.String? anomalyType,
    $core.String? description,
    $36.Timestamp? detectedDate,
    $core.double? amount,
    ExpenseCategory? category,
    $core.String? severity,
  }) {
    final _result = create();
    if (anomalyType != null) {
      _result.anomalyType = anomalyType;
    }
    if (description != null) {
      _result.description = description;
    }
    if (detectedDate != null) {
      _result.detectedDate = detectedDate;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (category != null) {
      _result.category = category;
    }
    if (severity != null) {
      _result.severity = severity;
    }
    return _result;
  }
  factory AnomalyDetection.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AnomalyDetection.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AnomalyDetection clone() => AnomalyDetection()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AnomalyDetection copyWith(void Function(AnomalyDetection) updates) => super.copyWith((message) => updates(message as AnomalyDetection)) as AnomalyDetection; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AnomalyDetection create() => AnomalyDetection._();
  AnomalyDetection createEmptyInstance() => create();
  static $pb.PbList<AnomalyDetection> createRepeated() => $pb.PbList<AnomalyDetection>();
  @$core.pragma('dart2js:noInline')
  static AnomalyDetection getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AnomalyDetection>(create);
  static AnomalyDetection? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get anomalyType => $_getSZ(0);
  @$pb.TagNumber(1)
  set anomalyType($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAnomalyType() => $_has(0);
  @$pb.TagNumber(1)
  void clearAnomalyType() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get description => $_getSZ(1);
  @$pb.TagNumber(2)
  set description($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasDescription() => $_has(1);
  @$pb.TagNumber(2)
  void clearDescription() => clearField(2);

  @$pb.TagNumber(3)
  $36.Timestamp get detectedDate => $_getN(2);
  @$pb.TagNumber(3)
  set detectedDate($36.Timestamp v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasDetectedDate() => $_has(2);
  @$pb.TagNumber(3)
  void clearDetectedDate() => clearField(3);
  @$pb.TagNumber(3)
  $36.Timestamp ensureDetectedDate() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.double get amount => $_getN(3);
  @$pb.TagNumber(4)
  set amount($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearAmount() => clearField(4);

  @$pb.TagNumber(5)
  ExpenseCategory get category => $_getN(4);
  @$pb.TagNumber(5)
  set category(ExpenseCategory v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasCategory() => $_has(4);
  @$pb.TagNumber(5)
  void clearCategory() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get severity => $_getSZ(5);
  @$pb.TagNumber(6)
  set severity($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasSeverity() => $_has(5);
  @$pb.TagNumber(6)
  void clearSeverity() => clearField(6);
}

class GetAIBudgetingRecommendationsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetAIBudgetingRecommendationsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.double>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'monthlyIncome', $pb.PbFieldType.OD)
    ..pPS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'financialGoals')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'riskTolerance')
    ..hasRequiredFields = false
  ;

  GetAIBudgetingRecommendationsRequest._() : super();
  factory GetAIBudgetingRecommendationsRequest({
    $core.double? monthlyIncome,
    $core.Iterable<$core.String>? financialGoals,
    $core.String? riskTolerance,
  }) {
    final _result = create();
    if (monthlyIncome != null) {
      _result.monthlyIncome = monthlyIncome;
    }
    if (financialGoals != null) {
      _result.financialGoals.addAll(financialGoals);
    }
    if (riskTolerance != null) {
      _result.riskTolerance = riskTolerance;
    }
    return _result;
  }
  factory GetAIBudgetingRecommendationsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAIBudgetingRecommendationsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAIBudgetingRecommendationsRequest clone() => GetAIBudgetingRecommendationsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAIBudgetingRecommendationsRequest copyWith(void Function(GetAIBudgetingRecommendationsRequest) updates) => super.copyWith((message) => updates(message as GetAIBudgetingRecommendationsRequest)) as GetAIBudgetingRecommendationsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetAIBudgetingRecommendationsRequest create() => GetAIBudgetingRecommendationsRequest._();
  GetAIBudgetingRecommendationsRequest createEmptyInstance() => create();
  static $pb.PbList<GetAIBudgetingRecommendationsRequest> createRepeated() => $pb.PbList<GetAIBudgetingRecommendationsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetAIBudgetingRecommendationsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAIBudgetingRecommendationsRequest>(create);
  static GetAIBudgetingRecommendationsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get monthlyIncome => $_getN(0);
  @$pb.TagNumber(1)
  set monthlyIncome($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMonthlyIncome() => $_has(0);
  @$pb.TagNumber(1)
  void clearMonthlyIncome() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.String> get financialGoals => $_getList(1);

  @$pb.TagNumber(3)
  $core.String get riskTolerance => $_getSZ(2);
  @$pb.TagNumber(3)
  set riskTolerance($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasRiskTolerance() => $_has(2);
  @$pb.TagNumber(3)
  void clearRiskTolerance() => clearField(3);
}

class GetAIBudgetingRecommendationsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetAIBudgetingRecommendationsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'summary')
    ..pc<BudgetRecommendation>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'budgetRecommendations', $pb.PbFieldType.PM, subBuilder: BudgetRecommendation.create)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recommendedSavingsRate', $pb.PbFieldType.OD)
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'rationale')
    ..hasRequiredFields = false
  ;

  GetAIBudgetingRecommendationsResponse._() : super();
  factory GetAIBudgetingRecommendationsResponse({
    $core.bool? success,
    $core.String? summary,
    $core.Iterable<BudgetRecommendation>? budgetRecommendations,
    $core.double? recommendedSavingsRate,
    $core.String? rationale,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (summary != null) {
      _result.summary = summary;
    }
    if (budgetRecommendations != null) {
      _result.budgetRecommendations.addAll(budgetRecommendations);
    }
    if (recommendedSavingsRate != null) {
      _result.recommendedSavingsRate = recommendedSavingsRate;
    }
    if (rationale != null) {
      _result.rationale = rationale;
    }
    return _result;
  }
  factory GetAIBudgetingRecommendationsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAIBudgetingRecommendationsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAIBudgetingRecommendationsResponse clone() => GetAIBudgetingRecommendationsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAIBudgetingRecommendationsResponse copyWith(void Function(GetAIBudgetingRecommendationsResponse) updates) => super.copyWith((message) => updates(message as GetAIBudgetingRecommendationsResponse)) as GetAIBudgetingRecommendationsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetAIBudgetingRecommendationsResponse create() => GetAIBudgetingRecommendationsResponse._();
  GetAIBudgetingRecommendationsResponse createEmptyInstance() => create();
  static $pb.PbList<GetAIBudgetingRecommendationsResponse> createRepeated() => $pb.PbList<GetAIBudgetingRecommendationsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetAIBudgetingRecommendationsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAIBudgetingRecommendationsResponse>(create);
  static GetAIBudgetingRecommendationsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get summary => $_getSZ(1);
  @$pb.TagNumber(2)
  set summary($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSummary() => $_has(1);
  @$pb.TagNumber(2)
  void clearSummary() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<BudgetRecommendation> get budgetRecommendations => $_getList(2);

  @$pb.TagNumber(4)
  $core.double get recommendedSavingsRate => $_getN(3);
  @$pb.TagNumber(4)
  set recommendedSavingsRate($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasRecommendedSavingsRate() => $_has(3);
  @$pb.TagNumber(4)
  void clearRecommendedSavingsRate() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get rationale => $_getSZ(4);
  @$pb.TagNumber(5)
  set rationale($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasRationale() => $_has(4);
  @$pb.TagNumber(5)
  void clearRationale() => clearField(5);
}

class BudgetRecommendation extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'BudgetRecommendation', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..e<ExpenseCategory>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'category', $pb.PbFieldType.OE, defaultOrMaker: ExpenseCategory.EXPENSE_CATEGORY_UNSPECIFIED, valueOf: ExpenseCategory.valueOf, enumValues: ExpenseCategory.values)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'categoryName')
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recommendedAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currentAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'difference', $pb.PbFieldType.OD)
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reasoning')
    ..e<BudgetPeriod>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recommendedPeriod', $pb.PbFieldType.OE, defaultOrMaker: BudgetPeriod.BUDGET_PERIOD_UNSPECIFIED, valueOf: BudgetPeriod.valueOf, enumValues: BudgetPeriod.values)
    ..hasRequiredFields = false
  ;

  BudgetRecommendation._() : super();
  factory BudgetRecommendation({
    ExpenseCategory? category,
    $core.String? categoryName,
    $core.double? recommendedAmount,
    $core.double? currentAmount,
    $core.double? difference,
    $core.String? reasoning,
    BudgetPeriod? recommendedPeriod,
  }) {
    final _result = create();
    if (category != null) {
      _result.category = category;
    }
    if (categoryName != null) {
      _result.categoryName = categoryName;
    }
    if (recommendedAmount != null) {
      _result.recommendedAmount = recommendedAmount;
    }
    if (currentAmount != null) {
      _result.currentAmount = currentAmount;
    }
    if (difference != null) {
      _result.difference = difference;
    }
    if (reasoning != null) {
      _result.reasoning = reasoning;
    }
    if (recommendedPeriod != null) {
      _result.recommendedPeriod = recommendedPeriod;
    }
    return _result;
  }
  factory BudgetRecommendation.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BudgetRecommendation.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BudgetRecommendation clone() => BudgetRecommendation()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BudgetRecommendation copyWith(void Function(BudgetRecommendation) updates) => super.copyWith((message) => updates(message as BudgetRecommendation)) as BudgetRecommendation; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static BudgetRecommendation create() => BudgetRecommendation._();
  BudgetRecommendation createEmptyInstance() => create();
  static $pb.PbList<BudgetRecommendation> createRepeated() => $pb.PbList<BudgetRecommendation>();
  @$core.pragma('dart2js:noInline')
  static BudgetRecommendation getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BudgetRecommendation>(create);
  static BudgetRecommendation? _defaultInstance;

  @$pb.TagNumber(1)
  ExpenseCategory get category => $_getN(0);
  @$pb.TagNumber(1)
  set category(ExpenseCategory v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasCategory() => $_has(0);
  @$pb.TagNumber(1)
  void clearCategory() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get categoryName => $_getSZ(1);
  @$pb.TagNumber(2)
  set categoryName($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCategoryName() => $_has(1);
  @$pb.TagNumber(2)
  void clearCategoryName() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get recommendedAmount => $_getN(2);
  @$pb.TagNumber(3)
  set recommendedAmount($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasRecommendedAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearRecommendedAmount() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get currentAmount => $_getN(3);
  @$pb.TagNumber(4)
  set currentAmount($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCurrentAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearCurrentAmount() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get difference => $_getN(4);
  @$pb.TagNumber(5)
  set difference($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasDifference() => $_has(4);
  @$pb.TagNumber(5)
  void clearDifference() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get reasoning => $_getSZ(5);
  @$pb.TagNumber(6)
  set reasoning($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasReasoning() => $_has(5);
  @$pb.TagNumber(6)
  void clearReasoning() => clearField(6);

  @$pb.TagNumber(7)
  BudgetPeriod get recommendedPeriod => $_getN(6);
  @$pb.TagNumber(7)
  set recommendedPeriod(BudgetPeriod v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasRecommendedPeriod() => $_has(6);
  @$pb.TagNumber(7)
  void clearRecommendedPeriod() => clearField(7);
}

class AutoCategorizeExpenseRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AutoCategorizeExpenseRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'merchant')
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'notes')
    ..hasRequiredFields = false
  ;

  AutoCategorizeExpenseRequest._() : super();
  factory AutoCategorizeExpenseRequest({
    $core.String? description,
    $core.String? merchant,
    $core.double? amount,
    $core.String? notes,
  }) {
    final _result = create();
    if (description != null) {
      _result.description = description;
    }
    if (merchant != null) {
      _result.merchant = merchant;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (notes != null) {
      _result.notes = notes;
    }
    return _result;
  }
  factory AutoCategorizeExpenseRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AutoCategorizeExpenseRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AutoCategorizeExpenseRequest clone() => AutoCategorizeExpenseRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AutoCategorizeExpenseRequest copyWith(void Function(AutoCategorizeExpenseRequest) updates) => super.copyWith((message) => updates(message as AutoCategorizeExpenseRequest)) as AutoCategorizeExpenseRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AutoCategorizeExpenseRequest create() => AutoCategorizeExpenseRequest._();
  AutoCategorizeExpenseRequest createEmptyInstance() => create();
  static $pb.PbList<AutoCategorizeExpenseRequest> createRepeated() => $pb.PbList<AutoCategorizeExpenseRequest>();
  @$core.pragma('dart2js:noInline')
  static AutoCategorizeExpenseRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AutoCategorizeExpenseRequest>(create);
  static AutoCategorizeExpenseRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get description => $_getSZ(0);
  @$pb.TagNumber(1)
  set description($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDescription() => $_has(0);
  @$pb.TagNumber(1)
  void clearDescription() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get merchant => $_getSZ(1);
  @$pb.TagNumber(2)
  set merchant($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMerchant() => $_has(1);
  @$pb.TagNumber(2)
  void clearMerchant() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get amount => $_getN(2);
  @$pb.TagNumber(3)
  set amount($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get notes => $_getSZ(3);
  @$pb.TagNumber(4)
  set notes($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasNotes() => $_has(3);
  @$pb.TagNumber(4)
  void clearNotes() => clearField(4);
}

class AutoCategorizeExpenseResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AutoCategorizeExpenseResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..e<ExpenseCategory>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'suggestedCategory', $pb.PbFieldType.OE, defaultOrMaker: ExpenseCategory.EXPENSE_CATEGORY_UNSPECIFIED, valueOf: ExpenseCategory.valueOf, enumValues: ExpenseCategory.values)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'categoryName')
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'confidenceScore', $pb.PbFieldType.OD)
    ..pc<CategorySuggestion>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'alternativeCategories', $pb.PbFieldType.PM, subBuilder: CategorySuggestion.create)
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reasoning')
    ..hasRequiredFields = false
  ;

  AutoCategorizeExpenseResponse._() : super();
  factory AutoCategorizeExpenseResponse({
    $core.bool? success,
    ExpenseCategory? suggestedCategory,
    $core.String? categoryName,
    $core.double? confidenceScore,
    $core.Iterable<CategorySuggestion>? alternativeCategories,
    $core.String? reasoning,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (suggestedCategory != null) {
      _result.suggestedCategory = suggestedCategory;
    }
    if (categoryName != null) {
      _result.categoryName = categoryName;
    }
    if (confidenceScore != null) {
      _result.confidenceScore = confidenceScore;
    }
    if (alternativeCategories != null) {
      _result.alternativeCategories.addAll(alternativeCategories);
    }
    if (reasoning != null) {
      _result.reasoning = reasoning;
    }
    return _result;
  }
  factory AutoCategorizeExpenseResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AutoCategorizeExpenseResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AutoCategorizeExpenseResponse clone() => AutoCategorizeExpenseResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AutoCategorizeExpenseResponse copyWith(void Function(AutoCategorizeExpenseResponse) updates) => super.copyWith((message) => updates(message as AutoCategorizeExpenseResponse)) as AutoCategorizeExpenseResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AutoCategorizeExpenseResponse create() => AutoCategorizeExpenseResponse._();
  AutoCategorizeExpenseResponse createEmptyInstance() => create();
  static $pb.PbList<AutoCategorizeExpenseResponse> createRepeated() => $pb.PbList<AutoCategorizeExpenseResponse>();
  @$core.pragma('dart2js:noInline')
  static AutoCategorizeExpenseResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AutoCategorizeExpenseResponse>(create);
  static AutoCategorizeExpenseResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  ExpenseCategory get suggestedCategory => $_getN(1);
  @$pb.TagNumber(2)
  set suggestedCategory(ExpenseCategory v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasSuggestedCategory() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuggestedCategory() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get categoryName => $_getSZ(2);
  @$pb.TagNumber(3)
  set categoryName($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCategoryName() => $_has(2);
  @$pb.TagNumber(3)
  void clearCategoryName() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get confidenceScore => $_getN(3);
  @$pb.TagNumber(4)
  set confidenceScore($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasConfidenceScore() => $_has(3);
  @$pb.TagNumber(4)
  void clearConfidenceScore() => clearField(4);

  @$pb.TagNumber(5)
  $core.List<CategorySuggestion> get alternativeCategories => $_getList(4);

  @$pb.TagNumber(6)
  $core.String get reasoning => $_getSZ(5);
  @$pb.TagNumber(6)
  set reasoning($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasReasoning() => $_has(5);
  @$pb.TagNumber(6)
  void clearReasoning() => clearField(6);
}

class CategorySuggestion extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CategorySuggestion', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..e<ExpenseCategory>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'category', $pb.PbFieldType.OE, defaultOrMaker: ExpenseCategory.EXPENSE_CATEGORY_UNSPECIFIED, valueOf: ExpenseCategory.valueOf, enumValues: ExpenseCategory.values)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'categoryName')
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'confidenceScore', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  CategorySuggestion._() : super();
  factory CategorySuggestion({
    ExpenseCategory? category,
    $core.String? categoryName,
    $core.double? confidenceScore,
  }) {
    final _result = create();
    if (category != null) {
      _result.category = category;
    }
    if (categoryName != null) {
      _result.categoryName = categoryName;
    }
    if (confidenceScore != null) {
      _result.confidenceScore = confidenceScore;
    }
    return _result;
  }
  factory CategorySuggestion.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CategorySuggestion.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CategorySuggestion clone() => CategorySuggestion()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CategorySuggestion copyWith(void Function(CategorySuggestion) updates) => super.copyWith((message) => updates(message as CategorySuggestion)) as CategorySuggestion; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CategorySuggestion create() => CategorySuggestion._();
  CategorySuggestion createEmptyInstance() => create();
  static $pb.PbList<CategorySuggestion> createRepeated() => $pb.PbList<CategorySuggestion>();
  @$core.pragma('dart2js:noInline')
  static CategorySuggestion getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CategorySuggestion>(create);
  static CategorySuggestion? _defaultInstance;

  @$pb.TagNumber(1)
  ExpenseCategory get category => $_getN(0);
  @$pb.TagNumber(1)
  set category(ExpenseCategory v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasCategory() => $_has(0);
  @$pb.TagNumber(1)
  void clearCategory() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get categoryName => $_getSZ(1);
  @$pb.TagNumber(2)
  set categoryName($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCategoryName() => $_has(1);
  @$pb.TagNumber(2)
  void clearCategoryName() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get confidenceScore => $_getN(2);
  @$pb.TagNumber(3)
  set confidenceScore($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasConfidenceScore() => $_has(2);
  @$pb.TagNumber(3)
  void clearConfidenceScore() => clearField(3);
}

class GetAIFinancialAdviceRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetAIFinancialAdviceRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'query')
    ..pPS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'contextAreas')
    ..hasRequiredFields = false
  ;

  GetAIFinancialAdviceRequest._() : super();
  factory GetAIFinancialAdviceRequest({
    $core.String? query,
    $core.Iterable<$core.String>? contextAreas,
  }) {
    final _result = create();
    if (query != null) {
      _result.query = query;
    }
    if (contextAreas != null) {
      _result.contextAreas.addAll(contextAreas);
    }
    return _result;
  }
  factory GetAIFinancialAdviceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAIFinancialAdviceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAIFinancialAdviceRequest clone() => GetAIFinancialAdviceRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAIFinancialAdviceRequest copyWith(void Function(GetAIFinancialAdviceRequest) updates) => super.copyWith((message) => updates(message as GetAIFinancialAdviceRequest)) as GetAIFinancialAdviceRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetAIFinancialAdviceRequest create() => GetAIFinancialAdviceRequest._();
  GetAIFinancialAdviceRequest createEmptyInstance() => create();
  static $pb.PbList<GetAIFinancialAdviceRequest> createRepeated() => $pb.PbList<GetAIFinancialAdviceRequest>();
  @$core.pragma('dart2js:noInline')
  static GetAIFinancialAdviceRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAIFinancialAdviceRequest>(create);
  static GetAIFinancialAdviceRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get query => $_getSZ(0);
  @$pb.TagNumber(1)
  set query($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasQuery() => $_has(0);
  @$pb.TagNumber(1)
  void clearQuery() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.String> get contextAreas => $_getList(1);
}

class GetAIFinancialAdviceResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetAIFinancialAdviceResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'query')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'advice')
    ..pc<ActionStep>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'actionSteps', $pb.PbFieldType.PM, subBuilder: ActionStep.create)
    ..pPS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'relevantResources')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'disclaimer')
    ..hasRequiredFields = false
  ;

  GetAIFinancialAdviceResponse._() : super();
  factory GetAIFinancialAdviceResponse({
    $core.bool? success,
    $core.String? query,
    $core.String? advice,
    $core.Iterable<ActionStep>? actionSteps,
    $core.Iterable<$core.String>? relevantResources,
    $core.String? disclaimer,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (query != null) {
      _result.query = query;
    }
    if (advice != null) {
      _result.advice = advice;
    }
    if (actionSteps != null) {
      _result.actionSteps.addAll(actionSteps);
    }
    if (relevantResources != null) {
      _result.relevantResources.addAll(relevantResources);
    }
    if (disclaimer != null) {
      _result.disclaimer = disclaimer;
    }
    return _result;
  }
  factory GetAIFinancialAdviceResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAIFinancialAdviceResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAIFinancialAdviceResponse clone() => GetAIFinancialAdviceResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAIFinancialAdviceResponse copyWith(void Function(GetAIFinancialAdviceResponse) updates) => super.copyWith((message) => updates(message as GetAIFinancialAdviceResponse)) as GetAIFinancialAdviceResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetAIFinancialAdviceResponse create() => GetAIFinancialAdviceResponse._();
  GetAIFinancialAdviceResponse createEmptyInstance() => create();
  static $pb.PbList<GetAIFinancialAdviceResponse> createRepeated() => $pb.PbList<GetAIFinancialAdviceResponse>();
  @$core.pragma('dart2js:noInline')
  static GetAIFinancialAdviceResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAIFinancialAdviceResponse>(create);
  static GetAIFinancialAdviceResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get query => $_getSZ(1);
  @$pb.TagNumber(2)
  set query($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasQuery() => $_has(1);
  @$pb.TagNumber(2)
  void clearQuery() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get advice => $_getSZ(2);
  @$pb.TagNumber(3)
  set advice($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAdvice() => $_has(2);
  @$pb.TagNumber(3)
  void clearAdvice() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<ActionStep> get actionSteps => $_getList(3);

  @$pb.TagNumber(5)
  $core.List<$core.String> get relevantResources => $_getList(4);

  @$pb.TagNumber(6)
  $core.String get disclaimer => $_getSZ(5);
  @$pb.TagNumber(6)
  set disclaimer($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasDisclaimer() => $_has(5);
  @$pb.TagNumber(6)
  void clearDisclaimer() => clearField(6);
}

class ActionStep extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ActionStep', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'stepNumber', $pb.PbFieldType.O3)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'title')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'estimatedImpact')
    ..aOB(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isCompleted')
    ..hasRequiredFields = false
  ;

  ActionStep._() : super();
  factory ActionStep({
    $core.int? stepNumber,
    $core.String? title,
    $core.String? description,
    $core.String? estimatedImpact,
    $core.bool? isCompleted,
  }) {
    final _result = create();
    if (stepNumber != null) {
      _result.stepNumber = stepNumber;
    }
    if (title != null) {
      _result.title = title;
    }
    if (description != null) {
      _result.description = description;
    }
    if (estimatedImpact != null) {
      _result.estimatedImpact = estimatedImpact;
    }
    if (isCompleted != null) {
      _result.isCompleted = isCompleted;
    }
    return _result;
  }
  factory ActionStep.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ActionStep.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ActionStep clone() => ActionStep()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ActionStep copyWith(void Function(ActionStep) updates) => super.copyWith((message) => updates(message as ActionStep)) as ActionStep; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ActionStep create() => ActionStep._();
  ActionStep createEmptyInstance() => create();
  static $pb.PbList<ActionStep> createRepeated() => $pb.PbList<ActionStep>();
  @$core.pragma('dart2js:noInline')
  static ActionStep getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ActionStep>(create);
  static ActionStep? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get stepNumber => $_getIZ(0);
  @$pb.TagNumber(1)
  set stepNumber($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStepNumber() => $_has(0);
  @$pb.TagNumber(1)
  void clearStepNumber() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get title => $_getSZ(1);
  @$pb.TagNumber(2)
  set title($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTitle() => $_has(1);
  @$pb.TagNumber(2)
  void clearTitle() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get estimatedImpact => $_getSZ(3);
  @$pb.TagNumber(4)
  set estimatedImpact($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasEstimatedImpact() => $_has(3);
  @$pb.TagNumber(4)
  void clearEstimatedImpact() => clearField(4);

  @$pb.TagNumber(5)
  $core.bool get isCompleted => $_getBF(4);
  @$pb.TagNumber(5)
  set isCompleted($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasIsCompleted() => $_has(4);
  @$pb.TagNumber(5)
  void clearIsCompleted() => clearField(5);
}

class IncomeSource extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'IncomeSource', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..a<$fixnum.Int64>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..e<IncomeCategory>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'category', $pb.PbFieldType.OE, defaultOrMaker: IncomeCategory.INCOME_CATEGORY_UNSPECIFIED, valueOf: IncomeCategory.valueOf, enumValues: IncomeCategory.values)
    ..aOB(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isRecurring')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recurrencePattern')
    ..aOM<$36.Timestamp>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lastReceived', subBuilder: $36.Timestamp.create)
    ..aOM<$36.Timestamp>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'nextExpected', subBuilder: $36.Timestamp.create)
    ..aOB(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isActive')
    ..aOM<$36.Timestamp>(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $36.Timestamp.create)
    ..aOM<$36.Timestamp>(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedAt', subBuilder: $36.Timestamp.create)
    ..hasRequiredFields = false
  ;

  IncomeSource._() : super();
  factory IncomeSource({
    $core.String? id,
    $fixnum.Int64? userId,
    $core.String? name,
    $core.double? amount,
    $core.String? currency,
    IncomeCategory? category,
    $core.bool? isRecurring,
    $core.String? recurrencePattern,
    $36.Timestamp? lastReceived,
    $36.Timestamp? nextExpected,
    $core.bool? isActive,
    $36.Timestamp? createdAt,
    $36.Timestamp? updatedAt,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    if (name != null) {
      _result.name = name;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (category != null) {
      _result.category = category;
    }
    if (isRecurring != null) {
      _result.isRecurring = isRecurring;
    }
    if (recurrencePattern != null) {
      _result.recurrencePattern = recurrencePattern;
    }
    if (lastReceived != null) {
      _result.lastReceived = lastReceived;
    }
    if (nextExpected != null) {
      _result.nextExpected = nextExpected;
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
  factory IncomeSource.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory IncomeSource.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  IncomeSource clone() => IncomeSource()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  IncomeSource copyWith(void Function(IncomeSource) updates) => super.copyWith((message) => updates(message as IncomeSource)) as IncomeSource; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static IncomeSource create() => IncomeSource._();
  IncomeSource createEmptyInstance() => create();
  static $pb.PbList<IncomeSource> createRepeated() => $pb.PbList<IncomeSource>();
  @$core.pragma('dart2js:noInline')
  static IncomeSource getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<IncomeSource>(create);
  static IncomeSource? _defaultInstance;

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
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(3)
  set name($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => clearField(3);

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
  IncomeCategory get category => $_getN(5);
  @$pb.TagNumber(6)
  set category(IncomeCategory v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasCategory() => $_has(5);
  @$pb.TagNumber(6)
  void clearCategory() => clearField(6);

  @$pb.TagNumber(7)
  $core.bool get isRecurring => $_getBF(6);
  @$pb.TagNumber(7)
  set isRecurring($core.bool v) { $_setBool(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasIsRecurring() => $_has(6);
  @$pb.TagNumber(7)
  void clearIsRecurring() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get recurrencePattern => $_getSZ(7);
  @$pb.TagNumber(8)
  set recurrencePattern($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasRecurrencePattern() => $_has(7);
  @$pb.TagNumber(8)
  void clearRecurrencePattern() => clearField(8);

  @$pb.TagNumber(9)
  $36.Timestamp get lastReceived => $_getN(8);
  @$pb.TagNumber(9)
  set lastReceived($36.Timestamp v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasLastReceived() => $_has(8);
  @$pb.TagNumber(9)
  void clearLastReceived() => clearField(9);
  @$pb.TagNumber(9)
  $36.Timestamp ensureLastReceived() => $_ensure(8);

  @$pb.TagNumber(10)
  $36.Timestamp get nextExpected => $_getN(9);
  @$pb.TagNumber(10)
  set nextExpected($36.Timestamp v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasNextExpected() => $_has(9);
  @$pb.TagNumber(10)
  void clearNextExpected() => clearField(10);
  @$pb.TagNumber(10)
  $36.Timestamp ensureNextExpected() => $_ensure(9);

  @$pb.TagNumber(11)
  $core.bool get isActive => $_getBF(10);
  @$pb.TagNumber(11)
  set isActive($core.bool v) { $_setBool(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasIsActive() => $_has(10);
  @$pb.TagNumber(11)
  void clearIsActive() => clearField(11);

  @$pb.TagNumber(12)
  $36.Timestamp get createdAt => $_getN(11);
  @$pb.TagNumber(12)
  set createdAt($36.Timestamp v) { setField(12, v); }
  @$pb.TagNumber(12)
  $core.bool hasCreatedAt() => $_has(11);
  @$pb.TagNumber(12)
  void clearCreatedAt() => clearField(12);
  @$pb.TagNumber(12)
  $36.Timestamp ensureCreatedAt() => $_ensure(11);

  @$pb.TagNumber(13)
  $36.Timestamp get updatedAt => $_getN(12);
  @$pb.TagNumber(13)
  set updatedAt($36.Timestamp v) { setField(13, v); }
  @$pb.TagNumber(13)
  $core.bool hasUpdatedAt() => $_has(12);
  @$pb.TagNumber(13)
  void clearUpdatedAt() => clearField(13);
  @$pb.TagNumber(13)
  $36.Timestamp ensureUpdatedAt() => $_ensure(12);
}

class IncomeBreakdown extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'IncomeBreakdown', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<IncomeCategoryData>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'categories', $pb.PbFieldType.PM, subBuilder: IncomeCategoryData.create)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalIncome', $pb.PbFieldType.OD)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'period')
    ..hasRequiredFields = false
  ;

  IncomeBreakdown._() : super();
  factory IncomeBreakdown({
    $core.Iterable<IncomeCategoryData>? categories,
    $core.double? totalIncome,
    $core.String? period,
  }) {
    final _result = create();
    if (categories != null) {
      _result.categories.addAll(categories);
    }
    if (totalIncome != null) {
      _result.totalIncome = totalIncome;
    }
    if (period != null) {
      _result.period = period;
    }
    return _result;
  }
  factory IncomeBreakdown.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory IncomeBreakdown.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  IncomeBreakdown clone() => IncomeBreakdown()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  IncomeBreakdown copyWith(void Function(IncomeBreakdown) updates) => super.copyWith((message) => updates(message as IncomeBreakdown)) as IncomeBreakdown; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static IncomeBreakdown create() => IncomeBreakdown._();
  IncomeBreakdown createEmptyInstance() => create();
  static $pb.PbList<IncomeBreakdown> createRepeated() => $pb.PbList<IncomeBreakdown>();
  @$core.pragma('dart2js:noInline')
  static IncomeBreakdown getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<IncomeBreakdown>(create);
  static IncomeBreakdown? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<IncomeCategoryData> get categories => $_getList(0);

  @$pb.TagNumber(2)
  $core.double get totalIncome => $_getN(1);
  @$pb.TagNumber(2)
  set totalIncome($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotalIncome() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalIncome() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get period => $_getSZ(2);
  @$pb.TagNumber(3)
  set period($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPeriod() => $_has(2);
  @$pb.TagNumber(3)
  void clearPeriod() => clearField(3);
}

class IncomeCategoryData extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'IncomeCategoryData', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..e<IncomeCategory>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'category', $pb.PbFieldType.OE, defaultOrMaker: IncomeCategory.INCOME_CATEGORY_UNSPECIFIED, valueOf: IncomeCategory.valueOf, enumValues: IncomeCategory.values)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'categoryName')
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'percentage', $pb.PbFieldType.OD)
    ..a<$core.int>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sourceCount', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  IncomeCategoryData._() : super();
  factory IncomeCategoryData({
    IncomeCategory? category,
    $core.String? categoryName,
    $core.double? amount,
    $core.double? percentage,
    $core.int? sourceCount,
  }) {
    final _result = create();
    if (category != null) {
      _result.category = category;
    }
    if (categoryName != null) {
      _result.categoryName = categoryName;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (percentage != null) {
      _result.percentage = percentage;
    }
    if (sourceCount != null) {
      _result.sourceCount = sourceCount;
    }
    return _result;
  }
  factory IncomeCategoryData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory IncomeCategoryData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  IncomeCategoryData clone() => IncomeCategoryData()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  IncomeCategoryData copyWith(void Function(IncomeCategoryData) updates) => super.copyWith((message) => updates(message as IncomeCategoryData)) as IncomeCategoryData; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static IncomeCategoryData create() => IncomeCategoryData._();
  IncomeCategoryData createEmptyInstance() => create();
  static $pb.PbList<IncomeCategoryData> createRepeated() => $pb.PbList<IncomeCategoryData>();
  @$core.pragma('dart2js:noInline')
  static IncomeCategoryData getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<IncomeCategoryData>(create);
  static IncomeCategoryData? _defaultInstance;

  @$pb.TagNumber(1)
  IncomeCategory get category => $_getN(0);
  @$pb.TagNumber(1)
  set category(IncomeCategory v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasCategory() => $_has(0);
  @$pb.TagNumber(1)
  void clearCategory() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get categoryName => $_getSZ(1);
  @$pb.TagNumber(2)
  set categoryName($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCategoryName() => $_has(1);
  @$pb.TagNumber(2)
  void clearCategoryName() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get amount => $_getN(2);
  @$pb.TagNumber(3)
  set amount($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get percentage => $_getN(3);
  @$pb.TagNumber(4)
  set percentage($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPercentage() => $_has(3);
  @$pb.TagNumber(4)
  void clearPercentage() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get sourceCount => $_getIZ(4);
  @$pb.TagNumber(5)
  set sourceCount($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasSourceCount() => $_has(4);
  @$pb.TagNumber(5)
  void clearSourceCount() => clearField(5);
}

class Investment extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Investment', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..a<$fixnum.Int64>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..e<InvestmentType>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'investmentType', $pb.PbFieldType.OE, defaultOrMaker: InvestmentType.INVESTMENT_TYPE_UNSPECIFIED, valueOf: InvestmentType.valueOf, enumValues: InvestmentType.values)
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currentValue', $pb.PbFieldType.OD)
    ..a<$core.double>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'initialInvestment', $pb.PbFieldType.OD)
    ..a<$core.double>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'gainLoss', $pb.PbFieldType.OD)
    ..a<$core.double>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'gainLossPercentage', $pb.PbFieldType.OD)
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOM<$36.Timestamp>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'purchaseDate', subBuilder: $36.Timestamp.create)
    ..aOM<$36.Timestamp>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lastUpdated', subBuilder: $36.Timestamp.create)
    ..aOS(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'tickerSymbol')
    ..a<$core.int>(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'quantity', $pb.PbFieldType.O3)
    ..a<$core.double>(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currentPrice', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  Investment._() : super();
  factory Investment({
    $core.String? id,
    $fixnum.Int64? userId,
    $core.String? name,
    InvestmentType? investmentType,
    $core.double? currentValue,
    $core.double? initialInvestment,
    $core.double? gainLoss,
    $core.double? gainLossPercentage,
    $core.String? currency,
    $36.Timestamp? purchaseDate,
    $36.Timestamp? lastUpdated,
    $core.String? tickerSymbol,
    $core.int? quantity,
    $core.double? currentPrice,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    if (name != null) {
      _result.name = name;
    }
    if (investmentType != null) {
      _result.investmentType = investmentType;
    }
    if (currentValue != null) {
      _result.currentValue = currentValue;
    }
    if (initialInvestment != null) {
      _result.initialInvestment = initialInvestment;
    }
    if (gainLoss != null) {
      _result.gainLoss = gainLoss;
    }
    if (gainLossPercentage != null) {
      _result.gainLossPercentage = gainLossPercentage;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (purchaseDate != null) {
      _result.purchaseDate = purchaseDate;
    }
    if (lastUpdated != null) {
      _result.lastUpdated = lastUpdated;
    }
    if (tickerSymbol != null) {
      _result.tickerSymbol = tickerSymbol;
    }
    if (quantity != null) {
      _result.quantity = quantity;
    }
    if (currentPrice != null) {
      _result.currentPrice = currentPrice;
    }
    return _result;
  }
  factory Investment.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Investment.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Investment clone() => Investment()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Investment copyWith(void Function(Investment) updates) => super.copyWith((message) => updates(message as Investment)) as Investment; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Investment create() => Investment._();
  Investment createEmptyInstance() => create();
  static $pb.PbList<Investment> createRepeated() => $pb.PbList<Investment>();
  @$core.pragma('dart2js:noInline')
  static Investment getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Investment>(create);
  static Investment? _defaultInstance;

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
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(3)
  set name($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => clearField(3);

  @$pb.TagNumber(4)
  InvestmentType get investmentType => $_getN(3);
  @$pb.TagNumber(4)
  set investmentType(InvestmentType v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasInvestmentType() => $_has(3);
  @$pb.TagNumber(4)
  void clearInvestmentType() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get currentValue => $_getN(4);
  @$pb.TagNumber(5)
  set currentValue($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasCurrentValue() => $_has(4);
  @$pb.TagNumber(5)
  void clearCurrentValue() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get initialInvestment => $_getN(5);
  @$pb.TagNumber(6)
  set initialInvestment($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasInitialInvestment() => $_has(5);
  @$pb.TagNumber(6)
  void clearInitialInvestment() => clearField(6);

  @$pb.TagNumber(7)
  $core.double get gainLoss => $_getN(6);
  @$pb.TagNumber(7)
  set gainLoss($core.double v) { $_setDouble(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasGainLoss() => $_has(6);
  @$pb.TagNumber(7)
  void clearGainLoss() => clearField(7);

  @$pb.TagNumber(8)
  $core.double get gainLossPercentage => $_getN(7);
  @$pb.TagNumber(8)
  set gainLossPercentage($core.double v) { $_setDouble(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasGainLossPercentage() => $_has(7);
  @$pb.TagNumber(8)
  void clearGainLossPercentage() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get currency => $_getSZ(8);
  @$pb.TagNumber(9)
  set currency($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasCurrency() => $_has(8);
  @$pb.TagNumber(9)
  void clearCurrency() => clearField(9);

  @$pb.TagNumber(10)
  $36.Timestamp get purchaseDate => $_getN(9);
  @$pb.TagNumber(10)
  set purchaseDate($36.Timestamp v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasPurchaseDate() => $_has(9);
  @$pb.TagNumber(10)
  void clearPurchaseDate() => clearField(10);
  @$pb.TagNumber(10)
  $36.Timestamp ensurePurchaseDate() => $_ensure(9);

  @$pb.TagNumber(11)
  $36.Timestamp get lastUpdated => $_getN(10);
  @$pb.TagNumber(11)
  set lastUpdated($36.Timestamp v) { setField(11, v); }
  @$pb.TagNumber(11)
  $core.bool hasLastUpdated() => $_has(10);
  @$pb.TagNumber(11)
  void clearLastUpdated() => clearField(11);
  @$pb.TagNumber(11)
  $36.Timestamp ensureLastUpdated() => $_ensure(10);

  @$pb.TagNumber(12)
  $core.String get tickerSymbol => $_getSZ(11);
  @$pb.TagNumber(12)
  set tickerSymbol($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasTickerSymbol() => $_has(11);
  @$pb.TagNumber(12)
  void clearTickerSymbol() => clearField(12);

  @$pb.TagNumber(13)
  $core.int get quantity => $_getIZ(12);
  @$pb.TagNumber(13)
  set quantity($core.int v) { $_setSignedInt32(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasQuantity() => $_has(12);
  @$pb.TagNumber(13)
  void clearQuantity() => clearField(13);

  @$pb.TagNumber(14)
  $core.double get currentPrice => $_getN(13);
  @$pb.TagNumber(14)
  set currentPrice($core.double v) { $_setDouble(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasCurrentPrice() => $_has(13);
  @$pb.TagNumber(14)
  void clearCurrentPrice() => clearField(14);
}

class InvestmentPortfolio extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'InvestmentPortfolio', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<InvestmentTypeData>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'investments', $pb.PbFieldType.PM, subBuilder: InvestmentTypeData.create)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalValue', $pb.PbFieldType.OD)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalInvested', $pb.PbFieldType.OD)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalGainLoss', $pb.PbFieldType.OD)
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalGainLossPercentage', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  InvestmentPortfolio._() : super();
  factory InvestmentPortfolio({
    $core.Iterable<InvestmentTypeData>? investments,
    $core.double? totalValue,
    $core.double? totalInvested,
    $core.double? totalGainLoss,
    $core.double? totalGainLossPercentage,
  }) {
    final _result = create();
    if (investments != null) {
      _result.investments.addAll(investments);
    }
    if (totalValue != null) {
      _result.totalValue = totalValue;
    }
    if (totalInvested != null) {
      _result.totalInvested = totalInvested;
    }
    if (totalGainLoss != null) {
      _result.totalGainLoss = totalGainLoss;
    }
    if (totalGainLossPercentage != null) {
      _result.totalGainLossPercentage = totalGainLossPercentage;
    }
    return _result;
  }
  factory InvestmentPortfolio.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InvestmentPortfolio.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InvestmentPortfolio clone() => InvestmentPortfolio()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InvestmentPortfolio copyWith(void Function(InvestmentPortfolio) updates) => super.copyWith((message) => updates(message as InvestmentPortfolio)) as InvestmentPortfolio; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static InvestmentPortfolio create() => InvestmentPortfolio._();
  InvestmentPortfolio createEmptyInstance() => create();
  static $pb.PbList<InvestmentPortfolio> createRepeated() => $pb.PbList<InvestmentPortfolio>();
  @$core.pragma('dart2js:noInline')
  static InvestmentPortfolio getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InvestmentPortfolio>(create);
  static InvestmentPortfolio? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<InvestmentTypeData> get investments => $_getList(0);

  @$pb.TagNumber(2)
  $core.double get totalValue => $_getN(1);
  @$pb.TagNumber(2)
  set totalValue($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotalValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalValue() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get totalInvested => $_getN(2);
  @$pb.TagNumber(3)
  set totalInvested($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTotalInvested() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalInvested() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get totalGainLoss => $_getN(3);
  @$pb.TagNumber(4)
  set totalGainLoss($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTotalGainLoss() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalGainLoss() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get totalGainLossPercentage => $_getN(4);
  @$pb.TagNumber(5)
  set totalGainLossPercentage($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTotalGainLossPercentage() => $_has(4);
  @$pb.TagNumber(5)
  void clearTotalGainLossPercentage() => clearField(5);
}

class InvestmentTypeData extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'InvestmentTypeData', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..e<InvestmentType>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'investmentType', $pb.PbFieldType.OE, defaultOrMaker: InvestmentType.INVESTMENT_TYPE_UNSPECIFIED, valueOf: InvestmentType.valueOf, enumValues: InvestmentType.values)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'typeName')
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currentValue', $pb.PbFieldType.OD)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'gainLoss', $pb.PbFieldType.OD)
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'gainLossPercentage', $pb.PbFieldType.OD)
    ..a<$core.int>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'assetCount', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  InvestmentTypeData._() : super();
  factory InvestmentTypeData({
    InvestmentType? investmentType,
    $core.String? typeName,
    $core.double? currentValue,
    $core.double? gainLoss,
    $core.double? gainLossPercentage,
    $core.int? assetCount,
  }) {
    final _result = create();
    if (investmentType != null) {
      _result.investmentType = investmentType;
    }
    if (typeName != null) {
      _result.typeName = typeName;
    }
    if (currentValue != null) {
      _result.currentValue = currentValue;
    }
    if (gainLoss != null) {
      _result.gainLoss = gainLoss;
    }
    if (gainLossPercentage != null) {
      _result.gainLossPercentage = gainLossPercentage;
    }
    if (assetCount != null) {
      _result.assetCount = assetCount;
    }
    return _result;
  }
  factory InvestmentTypeData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InvestmentTypeData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InvestmentTypeData clone() => InvestmentTypeData()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InvestmentTypeData copyWith(void Function(InvestmentTypeData) updates) => super.copyWith((message) => updates(message as InvestmentTypeData)) as InvestmentTypeData; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static InvestmentTypeData create() => InvestmentTypeData._();
  InvestmentTypeData createEmptyInstance() => create();
  static $pb.PbList<InvestmentTypeData> createRepeated() => $pb.PbList<InvestmentTypeData>();
  @$core.pragma('dart2js:noInline')
  static InvestmentTypeData getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InvestmentTypeData>(create);
  static InvestmentTypeData? _defaultInstance;

  @$pb.TagNumber(1)
  InvestmentType get investmentType => $_getN(0);
  @$pb.TagNumber(1)
  set investmentType(InvestmentType v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasInvestmentType() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvestmentType() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get typeName => $_getSZ(1);
  @$pb.TagNumber(2)
  set typeName($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTypeName() => $_has(1);
  @$pb.TagNumber(2)
  void clearTypeName() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get currentValue => $_getN(2);
  @$pb.TagNumber(3)
  set currentValue($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCurrentValue() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrentValue() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get gainLoss => $_getN(3);
  @$pb.TagNumber(4)
  set gainLoss($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasGainLoss() => $_has(3);
  @$pb.TagNumber(4)
  void clearGainLoss() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get gainLossPercentage => $_getN(4);
  @$pb.TagNumber(5)
  set gainLossPercentage($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasGainLossPercentage() => $_has(4);
  @$pb.TagNumber(5)
  void clearGainLossPercentage() => clearField(5);

  @$pb.TagNumber(6)
  $core.int get assetCount => $_getIZ(5);
  @$pb.TagNumber(6)
  set assetCount($core.int v) { $_setSignedInt32(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasAssetCount() => $_has(5);
  @$pb.TagNumber(6)
  void clearAssetCount() => clearField(6);
}

class FinancialGoal extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'FinancialGoal', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..a<$fixnum.Int64>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..e<GoalType>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'goalType', $pb.PbFieldType.OE, defaultOrMaker: GoalType.GOAL_TYPE_UNSPECIFIED, valueOf: GoalType.valueOf, enumValues: GoalType.values)
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'targetAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currentAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'monthlyContribution', $pb.PbFieldType.OD)
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOM<$36.Timestamp>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'targetDate', subBuilder: $36.Timestamp.create)
    ..e<GoalStatus>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: GoalStatus.GOAL_STATUS_UNSPECIFIED, valueOf: GoalStatus.valueOf, enumValues: GoalStatus.values)
    ..a<$core.double>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'percentageComplete', $pb.PbFieldType.OD)
    ..a<$core.int>(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'monthsRemaining', $pb.PbFieldType.O3)
    ..aOS(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'icon')
    ..aOS(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'color')
    ..aOM<$36.Timestamp>(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $36.Timestamp.create)
    ..aOM<$36.Timestamp>(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedAt', subBuilder: $36.Timestamp.create)
    ..hasRequiredFields = false
  ;

  FinancialGoal._() : super();
  factory FinancialGoal({
    $core.String? id,
    $fixnum.Int64? userId,
    $core.String? name,
    GoalType? goalType,
    $core.double? targetAmount,
    $core.double? currentAmount,
    $core.double? monthlyContribution,
    $core.String? currency,
    $36.Timestamp? targetDate,
    GoalStatus? status,
    $core.double? percentageComplete,
    $core.int? monthsRemaining,
    $core.String? icon,
    $core.String? color,
    $36.Timestamp? createdAt,
    $36.Timestamp? updatedAt,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    if (name != null) {
      _result.name = name;
    }
    if (goalType != null) {
      _result.goalType = goalType;
    }
    if (targetAmount != null) {
      _result.targetAmount = targetAmount;
    }
    if (currentAmount != null) {
      _result.currentAmount = currentAmount;
    }
    if (monthlyContribution != null) {
      _result.monthlyContribution = monthlyContribution;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (targetDate != null) {
      _result.targetDate = targetDate;
    }
    if (status != null) {
      _result.status = status;
    }
    if (percentageComplete != null) {
      _result.percentageComplete = percentageComplete;
    }
    if (monthsRemaining != null) {
      _result.monthsRemaining = monthsRemaining;
    }
    if (icon != null) {
      _result.icon = icon;
    }
    if (color != null) {
      _result.color = color;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      _result.updatedAt = updatedAt;
    }
    return _result;
  }
  factory FinancialGoal.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FinancialGoal.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FinancialGoal clone() => FinancialGoal()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FinancialGoal copyWith(void Function(FinancialGoal) updates) => super.copyWith((message) => updates(message as FinancialGoal)) as FinancialGoal; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FinancialGoal create() => FinancialGoal._();
  FinancialGoal createEmptyInstance() => create();
  static $pb.PbList<FinancialGoal> createRepeated() => $pb.PbList<FinancialGoal>();
  @$core.pragma('dart2js:noInline')
  static FinancialGoal getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FinancialGoal>(create);
  static FinancialGoal? _defaultInstance;

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
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(3)
  set name($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => clearField(3);

  @$pb.TagNumber(4)
  GoalType get goalType => $_getN(3);
  @$pb.TagNumber(4)
  set goalType(GoalType v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasGoalType() => $_has(3);
  @$pb.TagNumber(4)
  void clearGoalType() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get targetAmount => $_getN(4);
  @$pb.TagNumber(5)
  set targetAmount($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTargetAmount() => $_has(4);
  @$pb.TagNumber(5)
  void clearTargetAmount() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get currentAmount => $_getN(5);
  @$pb.TagNumber(6)
  set currentAmount($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasCurrentAmount() => $_has(5);
  @$pb.TagNumber(6)
  void clearCurrentAmount() => clearField(6);

  @$pb.TagNumber(7)
  $core.double get monthlyContribution => $_getN(6);
  @$pb.TagNumber(7)
  set monthlyContribution($core.double v) { $_setDouble(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasMonthlyContribution() => $_has(6);
  @$pb.TagNumber(7)
  void clearMonthlyContribution() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get currency => $_getSZ(7);
  @$pb.TagNumber(8)
  set currency($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasCurrency() => $_has(7);
  @$pb.TagNumber(8)
  void clearCurrency() => clearField(8);

  @$pb.TagNumber(9)
  $36.Timestamp get targetDate => $_getN(8);
  @$pb.TagNumber(9)
  set targetDate($36.Timestamp v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasTargetDate() => $_has(8);
  @$pb.TagNumber(9)
  void clearTargetDate() => clearField(9);
  @$pb.TagNumber(9)
  $36.Timestamp ensureTargetDate() => $_ensure(8);

  @$pb.TagNumber(10)
  GoalStatus get status => $_getN(9);
  @$pb.TagNumber(10)
  set status(GoalStatus v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasStatus() => $_has(9);
  @$pb.TagNumber(10)
  void clearStatus() => clearField(10);

  @$pb.TagNumber(11)
  $core.double get percentageComplete => $_getN(10);
  @$pb.TagNumber(11)
  set percentageComplete($core.double v) { $_setDouble(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasPercentageComplete() => $_has(10);
  @$pb.TagNumber(11)
  void clearPercentageComplete() => clearField(11);

  @$pb.TagNumber(12)
  $core.int get monthsRemaining => $_getIZ(11);
  @$pb.TagNumber(12)
  set monthsRemaining($core.int v) { $_setSignedInt32(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasMonthsRemaining() => $_has(11);
  @$pb.TagNumber(12)
  void clearMonthsRemaining() => clearField(12);

  @$pb.TagNumber(13)
  $core.String get icon => $_getSZ(12);
  @$pb.TagNumber(13)
  set icon($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasIcon() => $_has(12);
  @$pb.TagNumber(13)
  void clearIcon() => clearField(13);

  @$pb.TagNumber(14)
  $core.String get color => $_getSZ(13);
  @$pb.TagNumber(14)
  set color($core.String v) { $_setString(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasColor() => $_has(13);
  @$pb.TagNumber(14)
  void clearColor() => clearField(14);

  @$pb.TagNumber(15)
  $36.Timestamp get createdAt => $_getN(14);
  @$pb.TagNumber(15)
  set createdAt($36.Timestamp v) { setField(15, v); }
  @$pb.TagNumber(15)
  $core.bool hasCreatedAt() => $_has(14);
  @$pb.TagNumber(15)
  void clearCreatedAt() => clearField(15);
  @$pb.TagNumber(15)
  $36.Timestamp ensureCreatedAt() => $_ensure(14);

  @$pb.TagNumber(16)
  $36.Timestamp get updatedAt => $_getN(15);
  @$pb.TagNumber(16)
  set updatedAt($36.Timestamp v) { setField(16, v); }
  @$pb.TagNumber(16)
  $core.bool hasUpdatedAt() => $_has(15);
  @$pb.TagNumber(16)
  void clearUpdatedAt() => clearField(16);
  @$pb.TagNumber(16)
  $36.Timestamp ensureUpdatedAt() => $_ensure(15);
}

class FinancialGoalsList extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'FinancialGoalsList', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<FinancialGoal>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'goals', $pb.PbFieldType.PM, subBuilder: FinancialGoal.create)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalTarget', $pb.PbFieldType.OD)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalSaved', $pb.PbFieldType.OD)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'activeGoalsCount', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  FinancialGoalsList._() : super();
  factory FinancialGoalsList({
    $core.Iterable<FinancialGoal>? goals,
    $core.double? totalTarget,
    $core.double? totalSaved,
    $core.int? activeGoalsCount,
  }) {
    final _result = create();
    if (goals != null) {
      _result.goals.addAll(goals);
    }
    if (totalTarget != null) {
      _result.totalTarget = totalTarget;
    }
    if (totalSaved != null) {
      _result.totalSaved = totalSaved;
    }
    if (activeGoalsCount != null) {
      _result.activeGoalsCount = activeGoalsCount;
    }
    return _result;
  }
  factory FinancialGoalsList.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FinancialGoalsList.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FinancialGoalsList clone() => FinancialGoalsList()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FinancialGoalsList copyWith(void Function(FinancialGoalsList) updates) => super.copyWith((message) => updates(message as FinancialGoalsList)) as FinancialGoalsList; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FinancialGoalsList create() => FinancialGoalsList._();
  FinancialGoalsList createEmptyInstance() => create();
  static $pb.PbList<FinancialGoalsList> createRepeated() => $pb.PbList<FinancialGoalsList>();
  @$core.pragma('dart2js:noInline')
  static FinancialGoalsList getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FinancialGoalsList>(create);
  static FinancialGoalsList? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<FinancialGoal> get goals => $_getList(0);

  @$pb.TagNumber(2)
  $core.double get totalTarget => $_getN(1);
  @$pb.TagNumber(2)
  set totalTarget($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotalTarget() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalTarget() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get totalSaved => $_getN(2);
  @$pb.TagNumber(3)
  set totalSaved($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTotalSaved() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalSaved() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get activeGoalsCount => $_getIZ(3);
  @$pb.TagNumber(4)
  set activeGoalsCount($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasActiveGoalsCount() => $_has(3);
  @$pb.TagNumber(4)
  void clearActiveGoalsCount() => clearField(4);
}

class SavingsGoal extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SavingsGoal', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..a<$fixnum.Int64>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'targetAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currentAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'percentageComplete', $pb.PbFieldType.OD)
    ..aOM<$36.Timestamp>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'targetDate', subBuilder: $36.Timestamp.create)
    ..aOM<$36.Timestamp>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $36.Timestamp.create)
    ..aOM<$36.Timestamp>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedAt', subBuilder: $36.Timestamp.create)
    ..hasRequiredFields = false
  ;

  SavingsGoal._() : super();
  factory SavingsGoal({
    $core.String? id,
    $fixnum.Int64? userId,
    $core.String? name,
    $core.double? targetAmount,
    $core.double? currentAmount,
    $core.double? percentageComplete,
    $36.Timestamp? targetDate,
    $36.Timestamp? createdAt,
    $36.Timestamp? updatedAt,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    if (name != null) {
      _result.name = name;
    }
    if (targetAmount != null) {
      _result.targetAmount = targetAmount;
    }
    if (currentAmount != null) {
      _result.currentAmount = currentAmount;
    }
    if (percentageComplete != null) {
      _result.percentageComplete = percentageComplete;
    }
    if (targetDate != null) {
      _result.targetDate = targetDate;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      _result.updatedAt = updatedAt;
    }
    return _result;
  }
  factory SavingsGoal.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SavingsGoal.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SavingsGoal clone() => SavingsGoal()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SavingsGoal copyWith(void Function(SavingsGoal) updates) => super.copyWith((message) => updates(message as SavingsGoal)) as SavingsGoal; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SavingsGoal create() => SavingsGoal._();
  SavingsGoal createEmptyInstance() => create();
  static $pb.PbList<SavingsGoal> createRepeated() => $pb.PbList<SavingsGoal>();
  @$core.pragma('dart2js:noInline')
  static SavingsGoal getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SavingsGoal>(create);
  static SavingsGoal? _defaultInstance;

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
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(3)
  set name($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get targetAmount => $_getN(3);
  @$pb.TagNumber(4)
  set targetAmount($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTargetAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearTargetAmount() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get currentAmount => $_getN(4);
  @$pb.TagNumber(5)
  set currentAmount($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasCurrentAmount() => $_has(4);
  @$pb.TagNumber(5)
  void clearCurrentAmount() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get percentageComplete => $_getN(5);
  @$pb.TagNumber(6)
  set percentageComplete($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasPercentageComplete() => $_has(5);
  @$pb.TagNumber(6)
  void clearPercentageComplete() => clearField(6);

  @$pb.TagNumber(7)
  $36.Timestamp get targetDate => $_getN(6);
  @$pb.TagNumber(7)
  set targetDate($36.Timestamp v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasTargetDate() => $_has(6);
  @$pb.TagNumber(7)
  void clearTargetDate() => clearField(7);
  @$pb.TagNumber(7)
  $36.Timestamp ensureTargetDate() => $_ensure(6);

  @$pb.TagNumber(8)
  $36.Timestamp get createdAt => $_getN(7);
  @$pb.TagNumber(8)
  set createdAt($36.Timestamp v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasCreatedAt() => $_has(7);
  @$pb.TagNumber(8)
  void clearCreatedAt() => clearField(8);
  @$pb.TagNumber(8)
  $36.Timestamp ensureCreatedAt() => $_ensure(7);

  @$pb.TagNumber(9)
  $36.Timestamp get updatedAt => $_getN(8);
  @$pb.TagNumber(9)
  set updatedAt($36.Timestamp v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasUpdatedAt() => $_has(8);
  @$pb.TagNumber(9)
  void clearUpdatedAt() => clearField(9);
  @$pb.TagNumber(9)
  $36.Timestamp ensureUpdatedAt() => $_ensure(8);
}

class RecurringBill extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RecurringBill', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..a<$fixnum.Int64>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..e<ExpenseCategory>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'category', $pb.PbFieldType.OE, defaultOrMaker: ExpenseCategory.EXPENSE_CATEGORY_UNSPECIFIED, valueOf: ExpenseCategory.valueOf, enumValues: ExpenseCategory.values)
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recurrencePattern')
    ..aOM<$36.Timestamp>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'nextDueDate', subBuilder: $36.Timestamp.create)
    ..aOM<$36.Timestamp>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lastPaidDate', subBuilder: $36.Timestamp.create)
    ..e<BillStatus>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: BillStatus.BILL_STATUS_UNSPECIFIED, valueOf: BillStatus.valueOf, enumValues: BillStatus.values)
    ..a<$core.int>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'daysUntilDue', $pb.PbFieldType.O3)
    ..aOS(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'merchant')
    ..aOS(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'icon')
    ..aOB(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'autoPayEnabled')
    ..aOM<$36.Timestamp>(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $36.Timestamp.create)
    ..aOM<$36.Timestamp>(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedAt', subBuilder: $36.Timestamp.create)
    ..hasRequiredFields = false
  ;

  RecurringBill._() : super();
  factory RecurringBill({
    $core.String? id,
    $fixnum.Int64? userId,
    $core.String? name,
    $core.double? amount,
    $core.String? currency,
    ExpenseCategory? category,
    $core.String? recurrencePattern,
    $36.Timestamp? nextDueDate,
    $36.Timestamp? lastPaidDate,
    BillStatus? status,
    $core.int? daysUntilDue,
    $core.String? merchant,
    $core.String? icon,
    $core.bool? autoPayEnabled,
    $36.Timestamp? createdAt,
    $36.Timestamp? updatedAt,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    if (name != null) {
      _result.name = name;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (category != null) {
      _result.category = category;
    }
    if (recurrencePattern != null) {
      _result.recurrencePattern = recurrencePattern;
    }
    if (nextDueDate != null) {
      _result.nextDueDate = nextDueDate;
    }
    if (lastPaidDate != null) {
      _result.lastPaidDate = lastPaidDate;
    }
    if (status != null) {
      _result.status = status;
    }
    if (daysUntilDue != null) {
      _result.daysUntilDue = daysUntilDue;
    }
    if (merchant != null) {
      _result.merchant = merchant;
    }
    if (icon != null) {
      _result.icon = icon;
    }
    if (autoPayEnabled != null) {
      _result.autoPayEnabled = autoPayEnabled;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      _result.updatedAt = updatedAt;
    }
    return _result;
  }
  factory RecurringBill.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RecurringBill.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RecurringBill clone() => RecurringBill()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RecurringBill copyWith(void Function(RecurringBill) updates) => super.copyWith((message) => updates(message as RecurringBill)) as RecurringBill; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RecurringBill create() => RecurringBill._();
  RecurringBill createEmptyInstance() => create();
  static $pb.PbList<RecurringBill> createRepeated() => $pb.PbList<RecurringBill>();
  @$core.pragma('dart2js:noInline')
  static RecurringBill getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RecurringBill>(create);
  static RecurringBill? _defaultInstance;

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
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(3)
  set name($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => clearField(3);

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
  ExpenseCategory get category => $_getN(5);
  @$pb.TagNumber(6)
  set category(ExpenseCategory v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasCategory() => $_has(5);
  @$pb.TagNumber(6)
  void clearCategory() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get recurrencePattern => $_getSZ(6);
  @$pb.TagNumber(7)
  set recurrencePattern($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasRecurrencePattern() => $_has(6);
  @$pb.TagNumber(7)
  void clearRecurrencePattern() => clearField(7);

  @$pb.TagNumber(8)
  $36.Timestamp get nextDueDate => $_getN(7);
  @$pb.TagNumber(8)
  set nextDueDate($36.Timestamp v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasNextDueDate() => $_has(7);
  @$pb.TagNumber(8)
  void clearNextDueDate() => clearField(8);
  @$pb.TagNumber(8)
  $36.Timestamp ensureNextDueDate() => $_ensure(7);

  @$pb.TagNumber(9)
  $36.Timestamp get lastPaidDate => $_getN(8);
  @$pb.TagNumber(9)
  set lastPaidDate($36.Timestamp v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasLastPaidDate() => $_has(8);
  @$pb.TagNumber(9)
  void clearLastPaidDate() => clearField(9);
  @$pb.TagNumber(9)
  $36.Timestamp ensureLastPaidDate() => $_ensure(8);

  @$pb.TagNumber(10)
  BillStatus get status => $_getN(9);
  @$pb.TagNumber(10)
  set status(BillStatus v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasStatus() => $_has(9);
  @$pb.TagNumber(10)
  void clearStatus() => clearField(10);

  @$pb.TagNumber(11)
  $core.int get daysUntilDue => $_getIZ(10);
  @$pb.TagNumber(11)
  set daysUntilDue($core.int v) { $_setSignedInt32(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasDaysUntilDue() => $_has(10);
  @$pb.TagNumber(11)
  void clearDaysUntilDue() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get merchant => $_getSZ(11);
  @$pb.TagNumber(12)
  set merchant($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasMerchant() => $_has(11);
  @$pb.TagNumber(12)
  void clearMerchant() => clearField(12);

  @$pb.TagNumber(13)
  $core.String get icon => $_getSZ(12);
  @$pb.TagNumber(13)
  set icon($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasIcon() => $_has(12);
  @$pb.TagNumber(13)
  void clearIcon() => clearField(13);

  @$pb.TagNumber(14)
  $core.bool get autoPayEnabled => $_getBF(13);
  @$pb.TagNumber(14)
  set autoPayEnabled($core.bool v) { $_setBool(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasAutoPayEnabled() => $_has(13);
  @$pb.TagNumber(14)
  void clearAutoPayEnabled() => clearField(14);

  @$pb.TagNumber(15)
  $36.Timestamp get createdAt => $_getN(14);
  @$pb.TagNumber(15)
  set createdAt($36.Timestamp v) { setField(15, v); }
  @$pb.TagNumber(15)
  $core.bool hasCreatedAt() => $_has(14);
  @$pb.TagNumber(15)
  void clearCreatedAt() => clearField(15);
  @$pb.TagNumber(15)
  $36.Timestamp ensureCreatedAt() => $_ensure(14);

  @$pb.TagNumber(16)
  $36.Timestamp get updatedAt => $_getN(15);
  @$pb.TagNumber(16)
  set updatedAt($36.Timestamp v) { setField(16, v); }
  @$pb.TagNumber(16)
  $core.bool hasUpdatedAt() => $_has(15);
  @$pb.TagNumber(16)
  void clearUpdatedAt() => clearField(16);
  @$pb.TagNumber(16)
  $36.Timestamp ensureUpdatedAt() => $_ensure(15);
}

class UpcomingBillsList extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpcomingBillsList', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<RecurringBill>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bills', $pb.PbFieldType.PM, subBuilder: RecurringBill.create)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalUpcoming', $pb.PbFieldType.OD)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'billsCount', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  UpcomingBillsList._() : super();
  factory UpcomingBillsList({
    $core.Iterable<RecurringBill>? bills,
    $core.double? totalUpcoming,
    $core.int? billsCount,
  }) {
    final _result = create();
    if (bills != null) {
      _result.bills.addAll(bills);
    }
    if (totalUpcoming != null) {
      _result.totalUpcoming = totalUpcoming;
    }
    if (billsCount != null) {
      _result.billsCount = billsCount;
    }
    return _result;
  }
  factory UpcomingBillsList.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpcomingBillsList.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpcomingBillsList clone() => UpcomingBillsList()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpcomingBillsList copyWith(void Function(UpcomingBillsList) updates) => super.copyWith((message) => updates(message as UpcomingBillsList)) as UpcomingBillsList; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UpcomingBillsList create() => UpcomingBillsList._();
  UpcomingBillsList createEmptyInstance() => create();
  static $pb.PbList<UpcomingBillsList> createRepeated() => $pb.PbList<UpcomingBillsList>();
  @$core.pragma('dart2js:noInline')
  static UpcomingBillsList getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpcomingBillsList>(create);
  static UpcomingBillsList? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<RecurringBill> get bills => $_getList(0);

  @$pb.TagNumber(2)
  $core.double get totalUpcoming => $_getN(1);
  @$pb.TagNumber(2)
  set totalUpcoming($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotalUpcoming() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalUpcoming() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get billsCount => $_getIZ(2);
  @$pb.TagNumber(3)
  set billsCount($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasBillsCount() => $_has(2);
  @$pb.TagNumber(3)
  void clearBillsCount() => clearField(3);
}

class CreateIncomeSourceRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateIncomeSourceRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..e<IncomeCategory>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'category', $pb.PbFieldType.OE, defaultOrMaker: IncomeCategory.INCOME_CATEGORY_UNSPECIFIED, valueOf: IncomeCategory.valueOf, enumValues: IncomeCategory.values)
    ..aOB(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isRecurring')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recurrencePattern')
    ..aOM<$36.Timestamp>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lastReceived', subBuilder: $36.Timestamp.create)
    ..aOM<$36.Timestamp>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'nextExpected', subBuilder: $36.Timestamp.create)
    ..hasRequiredFields = false
  ;

  CreateIncomeSourceRequest._() : super();
  factory CreateIncomeSourceRequest({
    $core.String? name,
    $core.double? amount,
    $core.String? currency,
    IncomeCategory? category,
    $core.bool? isRecurring,
    $core.String? recurrencePattern,
    $36.Timestamp? lastReceived,
    $36.Timestamp? nextExpected,
  }) {
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (category != null) {
      _result.category = category;
    }
    if (isRecurring != null) {
      _result.isRecurring = isRecurring;
    }
    if (recurrencePattern != null) {
      _result.recurrencePattern = recurrencePattern;
    }
    if (lastReceived != null) {
      _result.lastReceived = lastReceived;
    }
    if (nextExpected != null) {
      _result.nextExpected = nextExpected;
    }
    return _result;
  }
  factory CreateIncomeSourceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateIncomeSourceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateIncomeSourceRequest clone() => CreateIncomeSourceRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateIncomeSourceRequest copyWith(void Function(CreateIncomeSourceRequest) updates) => super.copyWith((message) => updates(message as CreateIncomeSourceRequest)) as CreateIncomeSourceRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateIncomeSourceRequest create() => CreateIncomeSourceRequest._();
  CreateIncomeSourceRequest createEmptyInstance() => create();
  static $pb.PbList<CreateIncomeSourceRequest> createRepeated() => $pb.PbList<CreateIncomeSourceRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateIncomeSourceRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateIncomeSourceRequest>(create);
  static CreateIncomeSourceRequest? _defaultInstance;

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
  $core.String get currency => $_getSZ(2);
  @$pb.TagNumber(3)
  set currency($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCurrency() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrency() => clearField(3);

  @$pb.TagNumber(4)
  IncomeCategory get category => $_getN(3);
  @$pb.TagNumber(4)
  set category(IncomeCategory v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasCategory() => $_has(3);
  @$pb.TagNumber(4)
  void clearCategory() => clearField(4);

  @$pb.TagNumber(5)
  $core.bool get isRecurring => $_getBF(4);
  @$pb.TagNumber(5)
  set isRecurring($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasIsRecurring() => $_has(4);
  @$pb.TagNumber(5)
  void clearIsRecurring() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get recurrencePattern => $_getSZ(5);
  @$pb.TagNumber(6)
  set recurrencePattern($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasRecurrencePattern() => $_has(5);
  @$pb.TagNumber(6)
  void clearRecurrencePattern() => clearField(6);

  @$pb.TagNumber(7)
  $36.Timestamp get lastReceived => $_getN(6);
  @$pb.TagNumber(7)
  set lastReceived($36.Timestamp v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasLastReceived() => $_has(6);
  @$pb.TagNumber(7)
  void clearLastReceived() => clearField(7);
  @$pb.TagNumber(7)
  $36.Timestamp ensureLastReceived() => $_ensure(6);

  @$pb.TagNumber(8)
  $36.Timestamp get nextExpected => $_getN(7);
  @$pb.TagNumber(8)
  set nextExpected($36.Timestamp v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasNextExpected() => $_has(7);
  @$pb.TagNumber(8)
  void clearNextExpected() => clearField(8);
  @$pb.TagNumber(8)
  $36.Timestamp ensureNextExpected() => $_ensure(7);
}

class CreateIncomeSourceResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateIncomeSourceResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<IncomeSource>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'incomeSource', subBuilder: IncomeSource.create)
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  CreateIncomeSourceResponse._() : super();
  factory CreateIncomeSourceResponse({
    IncomeSource? incomeSource,
    $core.bool? success,
    $core.String? message,
  }) {
    final _result = create();
    if (incomeSource != null) {
      _result.incomeSource = incomeSource;
    }
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory CreateIncomeSourceResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateIncomeSourceResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateIncomeSourceResponse clone() => CreateIncomeSourceResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateIncomeSourceResponse copyWith(void Function(CreateIncomeSourceResponse) updates) => super.copyWith((message) => updates(message as CreateIncomeSourceResponse)) as CreateIncomeSourceResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateIncomeSourceResponse create() => CreateIncomeSourceResponse._();
  CreateIncomeSourceResponse createEmptyInstance() => create();
  static $pb.PbList<CreateIncomeSourceResponse> createRepeated() => $pb.PbList<CreateIncomeSourceResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateIncomeSourceResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateIncomeSourceResponse>(create);
  static CreateIncomeSourceResponse? _defaultInstance;

  @$pb.TagNumber(1)
  IncomeSource get incomeSource => $_getN(0);
  @$pb.TagNumber(1)
  set incomeSource(IncomeSource v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasIncomeSource() => $_has(0);
  @$pb.TagNumber(1)
  void clearIncomeSource() => clearField(1);
  @$pb.TagNumber(1)
  IncomeSource ensureIncomeSource() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => clearField(3);
}

class GetIncomeSourcesRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetIncomeSourcesRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'activeOnly')
    ..hasRequiredFields = false
  ;

  GetIncomeSourcesRequest._() : super();
  factory GetIncomeSourcesRequest({
    $core.bool? activeOnly,
  }) {
    final _result = create();
    if (activeOnly != null) {
      _result.activeOnly = activeOnly;
    }
    return _result;
  }
  factory GetIncomeSourcesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetIncomeSourcesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetIncomeSourcesRequest clone() => GetIncomeSourcesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetIncomeSourcesRequest copyWith(void Function(GetIncomeSourcesRequest) updates) => super.copyWith((message) => updates(message as GetIncomeSourcesRequest)) as GetIncomeSourcesRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetIncomeSourcesRequest create() => GetIncomeSourcesRequest._();
  GetIncomeSourcesRequest createEmptyInstance() => create();
  static $pb.PbList<GetIncomeSourcesRequest> createRepeated() => $pb.PbList<GetIncomeSourcesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetIncomeSourcesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetIncomeSourcesRequest>(create);
  static GetIncomeSourcesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get activeOnly => $_getBF(0);
  @$pb.TagNumber(1)
  set activeOnly($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasActiveOnly() => $_has(0);
  @$pb.TagNumber(1)
  void clearActiveOnly() => clearField(1);
}

class GetIncomeSourcesResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetIncomeSourcesResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<IncomeSource>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'incomeSources', $pb.PbFieldType.PM, subBuilder: IncomeSource.create)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalMonthlyIncome', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  GetIncomeSourcesResponse._() : super();
  factory GetIncomeSourcesResponse({
    $core.Iterable<IncomeSource>? incomeSources,
    $core.double? totalMonthlyIncome,
  }) {
    final _result = create();
    if (incomeSources != null) {
      _result.incomeSources.addAll(incomeSources);
    }
    if (totalMonthlyIncome != null) {
      _result.totalMonthlyIncome = totalMonthlyIncome;
    }
    return _result;
  }
  factory GetIncomeSourcesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetIncomeSourcesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetIncomeSourcesResponse clone() => GetIncomeSourcesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetIncomeSourcesResponse copyWith(void Function(GetIncomeSourcesResponse) updates) => super.copyWith((message) => updates(message as GetIncomeSourcesResponse)) as GetIncomeSourcesResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetIncomeSourcesResponse create() => GetIncomeSourcesResponse._();
  GetIncomeSourcesResponse createEmptyInstance() => create();
  static $pb.PbList<GetIncomeSourcesResponse> createRepeated() => $pb.PbList<GetIncomeSourcesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetIncomeSourcesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetIncomeSourcesResponse>(create);
  static GetIncomeSourcesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<IncomeSource> get incomeSources => $_getList(0);

  @$pb.TagNumber(2)
  $core.double get totalMonthlyIncome => $_getN(1);
  @$pb.TagNumber(2)
  set totalMonthlyIncome($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotalMonthlyIncome() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalMonthlyIncome() => clearField(2);
}

class GetIncomeBreakdownRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetIncomeBreakdownRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<$36.Timestamp>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'startDate', subBuilder: $36.Timestamp.create)
    ..aOM<$36.Timestamp>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'endDate', subBuilder: $36.Timestamp.create)
    ..hasRequiredFields = false
  ;

  GetIncomeBreakdownRequest._() : super();
  factory GetIncomeBreakdownRequest({
    $36.Timestamp? startDate,
    $36.Timestamp? endDate,
  }) {
    final _result = create();
    if (startDate != null) {
      _result.startDate = startDate;
    }
    if (endDate != null) {
      _result.endDate = endDate;
    }
    return _result;
  }
  factory GetIncomeBreakdownRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetIncomeBreakdownRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetIncomeBreakdownRequest clone() => GetIncomeBreakdownRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetIncomeBreakdownRequest copyWith(void Function(GetIncomeBreakdownRequest) updates) => super.copyWith((message) => updates(message as GetIncomeBreakdownRequest)) as GetIncomeBreakdownRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetIncomeBreakdownRequest create() => GetIncomeBreakdownRequest._();
  GetIncomeBreakdownRequest createEmptyInstance() => create();
  static $pb.PbList<GetIncomeBreakdownRequest> createRepeated() => $pb.PbList<GetIncomeBreakdownRequest>();
  @$core.pragma('dart2js:noInline')
  static GetIncomeBreakdownRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetIncomeBreakdownRequest>(create);
  static GetIncomeBreakdownRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $36.Timestamp get startDate => $_getN(0);
  @$pb.TagNumber(1)
  set startDate($36.Timestamp v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasStartDate() => $_has(0);
  @$pb.TagNumber(1)
  void clearStartDate() => clearField(1);
  @$pb.TagNumber(1)
  $36.Timestamp ensureStartDate() => $_ensure(0);

  @$pb.TagNumber(2)
  $36.Timestamp get endDate => $_getN(1);
  @$pb.TagNumber(2)
  set endDate($36.Timestamp v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasEndDate() => $_has(1);
  @$pb.TagNumber(2)
  void clearEndDate() => clearField(2);
  @$pb.TagNumber(2)
  $36.Timestamp ensureEndDate() => $_ensure(1);
}

class GetIncomeBreakdownResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetIncomeBreakdownResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<IncomeBreakdown>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'breakdown', subBuilder: IncomeBreakdown.create)
    ..hasRequiredFields = false
  ;

  GetIncomeBreakdownResponse._() : super();
  factory GetIncomeBreakdownResponse({
    IncomeBreakdown? breakdown,
  }) {
    final _result = create();
    if (breakdown != null) {
      _result.breakdown = breakdown;
    }
    return _result;
  }
  factory GetIncomeBreakdownResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetIncomeBreakdownResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetIncomeBreakdownResponse clone() => GetIncomeBreakdownResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetIncomeBreakdownResponse copyWith(void Function(GetIncomeBreakdownResponse) updates) => super.copyWith((message) => updates(message as GetIncomeBreakdownResponse)) as GetIncomeBreakdownResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetIncomeBreakdownResponse create() => GetIncomeBreakdownResponse._();
  GetIncomeBreakdownResponse createEmptyInstance() => create();
  static $pb.PbList<GetIncomeBreakdownResponse> createRepeated() => $pb.PbList<GetIncomeBreakdownResponse>();
  @$core.pragma('dart2js:noInline')
  static GetIncomeBreakdownResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetIncomeBreakdownResponse>(create);
  static GetIncomeBreakdownResponse? _defaultInstance;

  @$pb.TagNumber(1)
  IncomeBreakdown get breakdown => $_getN(0);
  @$pb.TagNumber(1)
  set breakdown(IncomeBreakdown v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasBreakdown() => $_has(0);
  @$pb.TagNumber(1)
  void clearBreakdown() => clearField(1);
  @$pb.TagNumber(1)
  IncomeBreakdown ensureBreakdown() => $_ensure(0);
}

class GetInvestmentPortfolioRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInvestmentPortfolioRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GetInvestmentPortfolioRequest._() : super();
  factory GetInvestmentPortfolioRequest() => create();
  factory GetInvestmentPortfolioRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInvestmentPortfolioRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInvestmentPortfolioRequest clone() => GetInvestmentPortfolioRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInvestmentPortfolioRequest copyWith(void Function(GetInvestmentPortfolioRequest) updates) => super.copyWith((message) => updates(message as GetInvestmentPortfolioRequest)) as GetInvestmentPortfolioRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetInvestmentPortfolioRequest create() => GetInvestmentPortfolioRequest._();
  GetInvestmentPortfolioRequest createEmptyInstance() => create();
  static $pb.PbList<GetInvestmentPortfolioRequest> createRepeated() => $pb.PbList<GetInvestmentPortfolioRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInvestmentPortfolioRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInvestmentPortfolioRequest>(create);
  static GetInvestmentPortfolioRequest? _defaultInstance;
}

class GetInvestmentPortfolioResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInvestmentPortfolioResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<InvestmentPortfolio>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'portfolio', subBuilder: InvestmentPortfolio.create)
    ..pc<Investment>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'individualInvestments', $pb.PbFieldType.PM, subBuilder: Investment.create)
    ..hasRequiredFields = false
  ;

  GetInvestmentPortfolioResponse._() : super();
  factory GetInvestmentPortfolioResponse({
    InvestmentPortfolio? portfolio,
    $core.Iterable<Investment>? individualInvestments,
  }) {
    final _result = create();
    if (portfolio != null) {
      _result.portfolio = portfolio;
    }
    if (individualInvestments != null) {
      _result.individualInvestments.addAll(individualInvestments);
    }
    return _result;
  }
  factory GetInvestmentPortfolioResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInvestmentPortfolioResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInvestmentPortfolioResponse clone() => GetInvestmentPortfolioResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInvestmentPortfolioResponse copyWith(void Function(GetInvestmentPortfolioResponse) updates) => super.copyWith((message) => updates(message as GetInvestmentPortfolioResponse)) as GetInvestmentPortfolioResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetInvestmentPortfolioResponse create() => GetInvestmentPortfolioResponse._();
  GetInvestmentPortfolioResponse createEmptyInstance() => create();
  static $pb.PbList<GetInvestmentPortfolioResponse> createRepeated() => $pb.PbList<GetInvestmentPortfolioResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInvestmentPortfolioResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInvestmentPortfolioResponse>(create);
  static GetInvestmentPortfolioResponse? _defaultInstance;

  @$pb.TagNumber(1)
  InvestmentPortfolio get portfolio => $_getN(0);
  @$pb.TagNumber(1)
  set portfolio(InvestmentPortfolio v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasPortfolio() => $_has(0);
  @$pb.TagNumber(1)
  void clearPortfolio() => clearField(1);
  @$pb.TagNumber(1)
  InvestmentPortfolio ensurePortfolio() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.List<Investment> get individualInvestments => $_getList(1);
}

class CreateInvestmentRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateInvestmentRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..e<InvestmentType>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'investmentType', $pb.PbFieldType.OE, defaultOrMaker: InvestmentType.INVESTMENT_TYPE_UNSPECIFIED, valueOf: InvestmentType.valueOf, enumValues: InvestmentType.values)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'initialInvestment', $pb.PbFieldType.OD)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOM<$36.Timestamp>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'purchaseDate', subBuilder: $36.Timestamp.create)
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'tickerSymbol')
    ..a<$core.int>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'quantity', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  CreateInvestmentRequest._() : super();
  factory CreateInvestmentRequest({
    $core.String? name,
    InvestmentType? investmentType,
    $core.double? initialInvestment,
    $core.String? currency,
    $36.Timestamp? purchaseDate,
    $core.String? tickerSymbol,
    $core.int? quantity,
  }) {
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    if (investmentType != null) {
      _result.investmentType = investmentType;
    }
    if (initialInvestment != null) {
      _result.initialInvestment = initialInvestment;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (purchaseDate != null) {
      _result.purchaseDate = purchaseDate;
    }
    if (tickerSymbol != null) {
      _result.tickerSymbol = tickerSymbol;
    }
    if (quantity != null) {
      _result.quantity = quantity;
    }
    return _result;
  }
  factory CreateInvestmentRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateInvestmentRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateInvestmentRequest clone() => CreateInvestmentRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateInvestmentRequest copyWith(void Function(CreateInvestmentRequest) updates) => super.copyWith((message) => updates(message as CreateInvestmentRequest)) as CreateInvestmentRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateInvestmentRequest create() => CreateInvestmentRequest._();
  CreateInvestmentRequest createEmptyInstance() => create();
  static $pb.PbList<CreateInvestmentRequest> createRepeated() => $pb.PbList<CreateInvestmentRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateInvestmentRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateInvestmentRequest>(create);
  static CreateInvestmentRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  InvestmentType get investmentType => $_getN(1);
  @$pb.TagNumber(2)
  set investmentType(InvestmentType v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasInvestmentType() => $_has(1);
  @$pb.TagNumber(2)
  void clearInvestmentType() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get initialInvestment => $_getN(2);
  @$pb.TagNumber(3)
  set initialInvestment($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasInitialInvestment() => $_has(2);
  @$pb.TagNumber(3)
  void clearInitialInvestment() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get currency => $_getSZ(3);
  @$pb.TagNumber(4)
  set currency($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCurrency() => $_has(3);
  @$pb.TagNumber(4)
  void clearCurrency() => clearField(4);

  @$pb.TagNumber(5)
  $36.Timestamp get purchaseDate => $_getN(4);
  @$pb.TagNumber(5)
  set purchaseDate($36.Timestamp v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasPurchaseDate() => $_has(4);
  @$pb.TagNumber(5)
  void clearPurchaseDate() => clearField(5);
  @$pb.TagNumber(5)
  $36.Timestamp ensurePurchaseDate() => $_ensure(4);

  @$pb.TagNumber(6)
  $core.String get tickerSymbol => $_getSZ(5);
  @$pb.TagNumber(6)
  set tickerSymbol($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasTickerSymbol() => $_has(5);
  @$pb.TagNumber(6)
  void clearTickerSymbol() => clearField(6);

  @$pb.TagNumber(7)
  $core.int get quantity => $_getIZ(6);
  @$pb.TagNumber(7)
  set quantity($core.int v) { $_setSignedInt32(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasQuantity() => $_has(6);
  @$pb.TagNumber(7)
  void clearQuantity() => clearField(7);
}

class CreateInvestmentResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateInvestmentResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<Investment>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'investment', subBuilder: Investment.create)
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  CreateInvestmentResponse._() : super();
  factory CreateInvestmentResponse({
    Investment? investment,
    $core.bool? success,
    $core.String? message,
  }) {
    final _result = create();
    if (investment != null) {
      _result.investment = investment;
    }
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory CreateInvestmentResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateInvestmentResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateInvestmentResponse clone() => CreateInvestmentResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateInvestmentResponse copyWith(void Function(CreateInvestmentResponse) updates) => super.copyWith((message) => updates(message as CreateInvestmentResponse)) as CreateInvestmentResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateInvestmentResponse create() => CreateInvestmentResponse._();
  CreateInvestmentResponse createEmptyInstance() => create();
  static $pb.PbList<CreateInvestmentResponse> createRepeated() => $pb.PbList<CreateInvestmentResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateInvestmentResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateInvestmentResponse>(create);
  static CreateInvestmentResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Investment get investment => $_getN(0);
  @$pb.TagNumber(1)
  set investment(Investment v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasInvestment() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvestment() => clearField(1);
  @$pb.TagNumber(1)
  Investment ensureInvestment() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => clearField(3);
}

class CreateFinancialGoalRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateFinancialGoalRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..e<GoalType>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'goalType', $pb.PbFieldType.OE, defaultOrMaker: GoalType.GOAL_TYPE_UNSPECIFIED, valueOf: GoalType.valueOf, enumValues: GoalType.values)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'targetAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currentAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'monthlyContribution', $pb.PbFieldType.OD)
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOM<$36.Timestamp>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'targetDate', subBuilder: $36.Timestamp.create)
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'icon')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'color')
    ..hasRequiredFields = false
  ;

  CreateFinancialGoalRequest._() : super();
  factory CreateFinancialGoalRequest({
    $core.String? name,
    GoalType? goalType,
    $core.double? targetAmount,
    $core.double? currentAmount,
    $core.double? monthlyContribution,
    $core.String? currency,
    $36.Timestamp? targetDate,
    $core.String? icon,
    $core.String? color,
  }) {
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    if (goalType != null) {
      _result.goalType = goalType;
    }
    if (targetAmount != null) {
      _result.targetAmount = targetAmount;
    }
    if (currentAmount != null) {
      _result.currentAmount = currentAmount;
    }
    if (monthlyContribution != null) {
      _result.monthlyContribution = monthlyContribution;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (targetDate != null) {
      _result.targetDate = targetDate;
    }
    if (icon != null) {
      _result.icon = icon;
    }
    if (color != null) {
      _result.color = color;
    }
    return _result;
  }
  factory CreateFinancialGoalRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateFinancialGoalRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateFinancialGoalRequest clone() => CreateFinancialGoalRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateFinancialGoalRequest copyWith(void Function(CreateFinancialGoalRequest) updates) => super.copyWith((message) => updates(message as CreateFinancialGoalRequest)) as CreateFinancialGoalRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateFinancialGoalRequest create() => CreateFinancialGoalRequest._();
  CreateFinancialGoalRequest createEmptyInstance() => create();
  static $pb.PbList<CreateFinancialGoalRequest> createRepeated() => $pb.PbList<CreateFinancialGoalRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateFinancialGoalRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateFinancialGoalRequest>(create);
  static CreateFinancialGoalRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  GoalType get goalType => $_getN(1);
  @$pb.TagNumber(2)
  set goalType(GoalType v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasGoalType() => $_has(1);
  @$pb.TagNumber(2)
  void clearGoalType() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get targetAmount => $_getN(2);
  @$pb.TagNumber(3)
  set targetAmount($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTargetAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearTargetAmount() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get currentAmount => $_getN(3);
  @$pb.TagNumber(4)
  set currentAmount($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCurrentAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearCurrentAmount() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get monthlyContribution => $_getN(4);
  @$pb.TagNumber(5)
  set monthlyContribution($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasMonthlyContribution() => $_has(4);
  @$pb.TagNumber(5)
  void clearMonthlyContribution() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get currency => $_getSZ(5);
  @$pb.TagNumber(6)
  set currency($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasCurrency() => $_has(5);
  @$pb.TagNumber(6)
  void clearCurrency() => clearField(6);

  @$pb.TagNumber(7)
  $36.Timestamp get targetDate => $_getN(6);
  @$pb.TagNumber(7)
  set targetDate($36.Timestamp v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasTargetDate() => $_has(6);
  @$pb.TagNumber(7)
  void clearTargetDate() => clearField(7);
  @$pb.TagNumber(7)
  $36.Timestamp ensureTargetDate() => $_ensure(6);

  @$pb.TagNumber(8)
  $core.String get icon => $_getSZ(7);
  @$pb.TagNumber(8)
  set icon($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasIcon() => $_has(7);
  @$pb.TagNumber(8)
  void clearIcon() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get color => $_getSZ(8);
  @$pb.TagNumber(9)
  set color($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasColor() => $_has(8);
  @$pb.TagNumber(9)
  void clearColor() => clearField(9);
}

class CreateFinancialGoalResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateFinancialGoalResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<FinancialGoal>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'goal', subBuilder: FinancialGoal.create)
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  CreateFinancialGoalResponse._() : super();
  factory CreateFinancialGoalResponse({
    FinancialGoal? goal,
    $core.bool? success,
    $core.String? message,
  }) {
    final _result = create();
    if (goal != null) {
      _result.goal = goal;
    }
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory CreateFinancialGoalResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateFinancialGoalResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateFinancialGoalResponse clone() => CreateFinancialGoalResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateFinancialGoalResponse copyWith(void Function(CreateFinancialGoalResponse) updates) => super.copyWith((message) => updates(message as CreateFinancialGoalResponse)) as CreateFinancialGoalResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateFinancialGoalResponse create() => CreateFinancialGoalResponse._();
  CreateFinancialGoalResponse createEmptyInstance() => create();
  static $pb.PbList<CreateFinancialGoalResponse> createRepeated() => $pb.PbList<CreateFinancialGoalResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateFinancialGoalResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateFinancialGoalResponse>(create);
  static CreateFinancialGoalResponse? _defaultInstance;

  @$pb.TagNumber(1)
  FinancialGoal get goal => $_getN(0);
  @$pb.TagNumber(1)
  set goal(FinancialGoal v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasGoal() => $_has(0);
  @$pb.TagNumber(1)
  void clearGoal() => clearField(1);
  @$pb.TagNumber(1)
  FinancialGoal ensureGoal() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => clearField(3);
}

class GetFinancialGoalsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetFinancialGoalsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..e<GoalStatus>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: GoalStatus.GOAL_STATUS_UNSPECIFIED, valueOf: GoalStatus.valueOf, enumValues: GoalStatus.values)
    ..hasRequiredFields = false
  ;

  GetFinancialGoalsRequest._() : super();
  factory GetFinancialGoalsRequest({
    GoalStatus? status,
  }) {
    final _result = create();
    if (status != null) {
      _result.status = status;
    }
    return _result;
  }
  factory GetFinancialGoalsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetFinancialGoalsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetFinancialGoalsRequest clone() => GetFinancialGoalsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetFinancialGoalsRequest copyWith(void Function(GetFinancialGoalsRequest) updates) => super.copyWith((message) => updates(message as GetFinancialGoalsRequest)) as GetFinancialGoalsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetFinancialGoalsRequest create() => GetFinancialGoalsRequest._();
  GetFinancialGoalsRequest createEmptyInstance() => create();
  static $pb.PbList<GetFinancialGoalsRequest> createRepeated() => $pb.PbList<GetFinancialGoalsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetFinancialGoalsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetFinancialGoalsRequest>(create);
  static GetFinancialGoalsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  GoalStatus get status => $_getN(0);
  @$pb.TagNumber(1)
  set status(GoalStatus v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => clearField(1);
}

class GetFinancialGoalsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetFinancialGoalsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<FinancialGoalsList>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'goalsList', subBuilder: FinancialGoalsList.create)
    ..hasRequiredFields = false
  ;

  GetFinancialGoalsResponse._() : super();
  factory GetFinancialGoalsResponse({
    FinancialGoalsList? goalsList,
  }) {
    final _result = create();
    if (goalsList != null) {
      _result.goalsList = goalsList;
    }
    return _result;
  }
  factory GetFinancialGoalsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetFinancialGoalsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetFinancialGoalsResponse clone() => GetFinancialGoalsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetFinancialGoalsResponse copyWith(void Function(GetFinancialGoalsResponse) updates) => super.copyWith((message) => updates(message as GetFinancialGoalsResponse)) as GetFinancialGoalsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetFinancialGoalsResponse create() => GetFinancialGoalsResponse._();
  GetFinancialGoalsResponse createEmptyInstance() => create();
  static $pb.PbList<GetFinancialGoalsResponse> createRepeated() => $pb.PbList<GetFinancialGoalsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetFinancialGoalsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetFinancialGoalsResponse>(create);
  static GetFinancialGoalsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  FinancialGoalsList get goalsList => $_getN(0);
  @$pb.TagNumber(1)
  set goalsList(FinancialGoalsList v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasGoalsList() => $_has(0);
  @$pb.TagNumber(1)
  void clearGoalsList() => clearField(1);
  @$pb.TagNumber(1)
  FinancialGoalsList ensureGoalsList() => $_ensure(0);
}

class UpdateFinancialGoalProgressRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateFinancialGoalProgressRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'goalId')
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amountToAdd', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  UpdateFinancialGoalProgressRequest._() : super();
  factory UpdateFinancialGoalProgressRequest({
    $core.String? goalId,
    $core.double? amountToAdd,
  }) {
    final _result = create();
    if (goalId != null) {
      _result.goalId = goalId;
    }
    if (amountToAdd != null) {
      _result.amountToAdd = amountToAdd;
    }
    return _result;
  }
  factory UpdateFinancialGoalProgressRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateFinancialGoalProgressRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateFinancialGoalProgressRequest clone() => UpdateFinancialGoalProgressRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateFinancialGoalProgressRequest copyWith(void Function(UpdateFinancialGoalProgressRequest) updates) => super.copyWith((message) => updates(message as UpdateFinancialGoalProgressRequest)) as UpdateFinancialGoalProgressRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UpdateFinancialGoalProgressRequest create() => UpdateFinancialGoalProgressRequest._();
  UpdateFinancialGoalProgressRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateFinancialGoalProgressRequest> createRepeated() => $pb.PbList<UpdateFinancialGoalProgressRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateFinancialGoalProgressRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateFinancialGoalProgressRequest>(create);
  static UpdateFinancialGoalProgressRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get goalId => $_getSZ(0);
  @$pb.TagNumber(1)
  set goalId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasGoalId() => $_has(0);
  @$pb.TagNumber(1)
  void clearGoalId() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get amountToAdd => $_getN(1);
  @$pb.TagNumber(2)
  set amountToAdd($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAmountToAdd() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmountToAdd() => clearField(2);
}

class UpdateFinancialGoalProgressResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateFinancialGoalProgressResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<FinancialGoal>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'goal', subBuilder: FinancialGoal.create)
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  UpdateFinancialGoalProgressResponse._() : super();
  factory UpdateFinancialGoalProgressResponse({
    FinancialGoal? goal,
    $core.bool? success,
    $core.String? message,
  }) {
    final _result = create();
    if (goal != null) {
      _result.goal = goal;
    }
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory UpdateFinancialGoalProgressResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateFinancialGoalProgressResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateFinancialGoalProgressResponse clone() => UpdateFinancialGoalProgressResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateFinancialGoalProgressResponse copyWith(void Function(UpdateFinancialGoalProgressResponse) updates) => super.copyWith((message) => updates(message as UpdateFinancialGoalProgressResponse)) as UpdateFinancialGoalProgressResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UpdateFinancialGoalProgressResponse create() => UpdateFinancialGoalProgressResponse._();
  UpdateFinancialGoalProgressResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateFinancialGoalProgressResponse> createRepeated() => $pb.PbList<UpdateFinancialGoalProgressResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateFinancialGoalProgressResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateFinancialGoalProgressResponse>(create);
  static UpdateFinancialGoalProgressResponse? _defaultInstance;

  @$pb.TagNumber(1)
  FinancialGoal get goal => $_getN(0);
  @$pb.TagNumber(1)
  set goal(FinancialGoal v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasGoal() => $_has(0);
  @$pb.TagNumber(1)
  void clearGoal() => clearField(1);
  @$pb.TagNumber(1)
  FinancialGoal ensureGoal() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => clearField(3);
}

class GetSavingsGoalRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetSavingsGoalRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GetSavingsGoalRequest._() : super();
  factory GetSavingsGoalRequest() => create();
  factory GetSavingsGoalRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetSavingsGoalRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetSavingsGoalRequest clone() => GetSavingsGoalRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetSavingsGoalRequest copyWith(void Function(GetSavingsGoalRequest) updates) => super.copyWith((message) => updates(message as GetSavingsGoalRequest)) as GetSavingsGoalRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetSavingsGoalRequest create() => GetSavingsGoalRequest._();
  GetSavingsGoalRequest createEmptyInstance() => create();
  static $pb.PbList<GetSavingsGoalRequest> createRepeated() => $pb.PbList<GetSavingsGoalRequest>();
  @$core.pragma('dart2js:noInline')
  static GetSavingsGoalRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetSavingsGoalRequest>(create);
  static GetSavingsGoalRequest? _defaultInstance;
}

class GetSavingsGoalResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetSavingsGoalResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<SavingsGoal>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'savingsGoal', subBuilder: SavingsGoal.create)
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hasGoal')
    ..hasRequiredFields = false
  ;

  GetSavingsGoalResponse._() : super();
  factory GetSavingsGoalResponse({
    SavingsGoal? savingsGoal,
    $core.bool? hasGoal,
  }) {
    final _result = create();
    if (savingsGoal != null) {
      _result.savingsGoal = savingsGoal;
    }
    if (hasGoal != null) {
      _result.hasGoal = hasGoal;
    }
    return _result;
  }
  factory GetSavingsGoalResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetSavingsGoalResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetSavingsGoalResponse clone() => GetSavingsGoalResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetSavingsGoalResponse copyWith(void Function(GetSavingsGoalResponse) updates) => super.copyWith((message) => updates(message as GetSavingsGoalResponse)) as GetSavingsGoalResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetSavingsGoalResponse create() => GetSavingsGoalResponse._();
  GetSavingsGoalResponse createEmptyInstance() => create();
  static $pb.PbList<GetSavingsGoalResponse> createRepeated() => $pb.PbList<GetSavingsGoalResponse>();
  @$core.pragma('dart2js:noInline')
  static GetSavingsGoalResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetSavingsGoalResponse>(create);
  static GetSavingsGoalResponse? _defaultInstance;

  @$pb.TagNumber(1)
  SavingsGoal get savingsGoal => $_getN(0);
  @$pb.TagNumber(1)
  set savingsGoal(SavingsGoal v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasSavingsGoal() => $_has(0);
  @$pb.TagNumber(1)
  void clearSavingsGoal() => clearField(1);
  @$pb.TagNumber(1)
  SavingsGoal ensureSavingsGoal() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.bool get hasGoal => $_getBF(1);
  @$pb.TagNumber(2)
  set hasGoal($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasHasGoal() => $_has(1);
  @$pb.TagNumber(2)
  void clearHasGoal() => clearField(2);
}

class CreateOrUpdateSavingsGoalRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateOrUpdateSavingsGoalRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'targetAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currentAmount', $pb.PbFieldType.OD)
    ..aOM<$36.Timestamp>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'targetDate', subBuilder: $36.Timestamp.create)
    ..hasRequiredFields = false
  ;

  CreateOrUpdateSavingsGoalRequest._() : super();
  factory CreateOrUpdateSavingsGoalRequest({
    $core.String? name,
    $core.double? targetAmount,
    $core.double? currentAmount,
    $36.Timestamp? targetDate,
  }) {
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    if (targetAmount != null) {
      _result.targetAmount = targetAmount;
    }
    if (currentAmount != null) {
      _result.currentAmount = currentAmount;
    }
    if (targetDate != null) {
      _result.targetDate = targetDate;
    }
    return _result;
  }
  factory CreateOrUpdateSavingsGoalRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateOrUpdateSavingsGoalRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateOrUpdateSavingsGoalRequest clone() => CreateOrUpdateSavingsGoalRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateOrUpdateSavingsGoalRequest copyWith(void Function(CreateOrUpdateSavingsGoalRequest) updates) => super.copyWith((message) => updates(message as CreateOrUpdateSavingsGoalRequest)) as CreateOrUpdateSavingsGoalRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateOrUpdateSavingsGoalRequest create() => CreateOrUpdateSavingsGoalRequest._();
  CreateOrUpdateSavingsGoalRequest createEmptyInstance() => create();
  static $pb.PbList<CreateOrUpdateSavingsGoalRequest> createRepeated() => $pb.PbList<CreateOrUpdateSavingsGoalRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateOrUpdateSavingsGoalRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateOrUpdateSavingsGoalRequest>(create);
  static CreateOrUpdateSavingsGoalRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get targetAmount => $_getN(1);
  @$pb.TagNumber(2)
  set targetAmount($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTargetAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearTargetAmount() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get currentAmount => $_getN(2);
  @$pb.TagNumber(3)
  set currentAmount($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCurrentAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrentAmount() => clearField(3);

  @$pb.TagNumber(4)
  $36.Timestamp get targetDate => $_getN(3);
  @$pb.TagNumber(4)
  set targetDate($36.Timestamp v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasTargetDate() => $_has(3);
  @$pb.TagNumber(4)
  void clearTargetDate() => clearField(4);
  @$pb.TagNumber(4)
  $36.Timestamp ensureTargetDate() => $_ensure(3);
}

class CreateOrUpdateSavingsGoalResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateOrUpdateSavingsGoalResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<SavingsGoal>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'savingsGoal', subBuilder: SavingsGoal.create)
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  CreateOrUpdateSavingsGoalResponse._() : super();
  factory CreateOrUpdateSavingsGoalResponse({
    SavingsGoal? savingsGoal,
    $core.bool? success,
    $core.String? message,
  }) {
    final _result = create();
    if (savingsGoal != null) {
      _result.savingsGoal = savingsGoal;
    }
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory CreateOrUpdateSavingsGoalResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateOrUpdateSavingsGoalResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateOrUpdateSavingsGoalResponse clone() => CreateOrUpdateSavingsGoalResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateOrUpdateSavingsGoalResponse copyWith(void Function(CreateOrUpdateSavingsGoalResponse) updates) => super.copyWith((message) => updates(message as CreateOrUpdateSavingsGoalResponse)) as CreateOrUpdateSavingsGoalResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateOrUpdateSavingsGoalResponse create() => CreateOrUpdateSavingsGoalResponse._();
  CreateOrUpdateSavingsGoalResponse createEmptyInstance() => create();
  static $pb.PbList<CreateOrUpdateSavingsGoalResponse> createRepeated() => $pb.PbList<CreateOrUpdateSavingsGoalResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateOrUpdateSavingsGoalResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateOrUpdateSavingsGoalResponse>(create);
  static CreateOrUpdateSavingsGoalResponse? _defaultInstance;

  @$pb.TagNumber(1)
  SavingsGoal get savingsGoal => $_getN(0);
  @$pb.TagNumber(1)
  set savingsGoal(SavingsGoal v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasSavingsGoal() => $_has(0);
  @$pb.TagNumber(1)
  void clearSavingsGoal() => clearField(1);
  @$pb.TagNumber(1)
  SavingsGoal ensureSavingsGoal() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => clearField(3);
}

class CreateRecurringBillRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateRecurringBillRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..e<ExpenseCategory>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'category', $pb.PbFieldType.OE, defaultOrMaker: ExpenseCategory.EXPENSE_CATEGORY_UNSPECIFIED, valueOf: ExpenseCategory.valueOf, enumValues: ExpenseCategory.values)
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recurrencePattern')
    ..aOM<$36.Timestamp>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'nextDueDate', subBuilder: $36.Timestamp.create)
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'merchant')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'icon')
    ..aOB(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'autoPayEnabled')
    ..hasRequiredFields = false
  ;

  CreateRecurringBillRequest._() : super();
  factory CreateRecurringBillRequest({
    $core.String? name,
    $core.double? amount,
    $core.String? currency,
    ExpenseCategory? category,
    $core.String? recurrencePattern,
    $36.Timestamp? nextDueDate,
    $core.String? merchant,
    $core.String? icon,
    $core.bool? autoPayEnabled,
  }) {
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (category != null) {
      _result.category = category;
    }
    if (recurrencePattern != null) {
      _result.recurrencePattern = recurrencePattern;
    }
    if (nextDueDate != null) {
      _result.nextDueDate = nextDueDate;
    }
    if (merchant != null) {
      _result.merchant = merchant;
    }
    if (icon != null) {
      _result.icon = icon;
    }
    if (autoPayEnabled != null) {
      _result.autoPayEnabled = autoPayEnabled;
    }
    return _result;
  }
  factory CreateRecurringBillRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateRecurringBillRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateRecurringBillRequest clone() => CreateRecurringBillRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateRecurringBillRequest copyWith(void Function(CreateRecurringBillRequest) updates) => super.copyWith((message) => updates(message as CreateRecurringBillRequest)) as CreateRecurringBillRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateRecurringBillRequest create() => CreateRecurringBillRequest._();
  CreateRecurringBillRequest createEmptyInstance() => create();
  static $pb.PbList<CreateRecurringBillRequest> createRepeated() => $pb.PbList<CreateRecurringBillRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateRecurringBillRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateRecurringBillRequest>(create);
  static CreateRecurringBillRequest? _defaultInstance;

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
  $core.String get currency => $_getSZ(2);
  @$pb.TagNumber(3)
  set currency($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCurrency() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrency() => clearField(3);

  @$pb.TagNumber(4)
  ExpenseCategory get category => $_getN(3);
  @$pb.TagNumber(4)
  set category(ExpenseCategory v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasCategory() => $_has(3);
  @$pb.TagNumber(4)
  void clearCategory() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get recurrencePattern => $_getSZ(4);
  @$pb.TagNumber(5)
  set recurrencePattern($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasRecurrencePattern() => $_has(4);
  @$pb.TagNumber(5)
  void clearRecurrencePattern() => clearField(5);

  @$pb.TagNumber(6)
  $36.Timestamp get nextDueDate => $_getN(5);
  @$pb.TagNumber(6)
  set nextDueDate($36.Timestamp v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasNextDueDate() => $_has(5);
  @$pb.TagNumber(6)
  void clearNextDueDate() => clearField(6);
  @$pb.TagNumber(6)
  $36.Timestamp ensureNextDueDate() => $_ensure(5);

  @$pb.TagNumber(7)
  $core.String get merchant => $_getSZ(6);
  @$pb.TagNumber(7)
  set merchant($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasMerchant() => $_has(6);
  @$pb.TagNumber(7)
  void clearMerchant() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get icon => $_getSZ(7);
  @$pb.TagNumber(8)
  set icon($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasIcon() => $_has(7);
  @$pb.TagNumber(8)
  void clearIcon() => clearField(8);

  @$pb.TagNumber(9)
  $core.bool get autoPayEnabled => $_getBF(8);
  @$pb.TagNumber(9)
  set autoPayEnabled($core.bool v) { $_setBool(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasAutoPayEnabled() => $_has(8);
  @$pb.TagNumber(9)
  void clearAutoPayEnabled() => clearField(9);
}

class CreateRecurringBillResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateRecurringBillResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<RecurringBill>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bill', subBuilder: RecurringBill.create)
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  CreateRecurringBillResponse._() : super();
  factory CreateRecurringBillResponse({
    RecurringBill? bill,
    $core.bool? success,
    $core.String? message,
  }) {
    final _result = create();
    if (bill != null) {
      _result.bill = bill;
    }
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory CreateRecurringBillResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateRecurringBillResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateRecurringBillResponse clone() => CreateRecurringBillResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateRecurringBillResponse copyWith(void Function(CreateRecurringBillResponse) updates) => super.copyWith((message) => updates(message as CreateRecurringBillResponse)) as CreateRecurringBillResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateRecurringBillResponse create() => CreateRecurringBillResponse._();
  CreateRecurringBillResponse createEmptyInstance() => create();
  static $pb.PbList<CreateRecurringBillResponse> createRepeated() => $pb.PbList<CreateRecurringBillResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateRecurringBillResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateRecurringBillResponse>(create);
  static CreateRecurringBillResponse? _defaultInstance;

  @$pb.TagNumber(1)
  RecurringBill get bill => $_getN(0);
  @$pb.TagNumber(1)
  set bill(RecurringBill v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasBill() => $_has(0);
  @$pb.TagNumber(1)
  void clearBill() => clearField(1);
  @$pb.TagNumber(1)
  RecurringBill ensureBill() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => clearField(3);
}

class GetUpcomingBillsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetUpcomingBillsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'daysAhead', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetUpcomingBillsRequest._() : super();
  factory GetUpcomingBillsRequest({
    $core.int? daysAhead,
  }) {
    final _result = create();
    if (daysAhead != null) {
      _result.daysAhead = daysAhead;
    }
    return _result;
  }
  factory GetUpcomingBillsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUpcomingBillsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUpcomingBillsRequest clone() => GetUpcomingBillsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUpcomingBillsRequest copyWith(void Function(GetUpcomingBillsRequest) updates) => super.copyWith((message) => updates(message as GetUpcomingBillsRequest)) as GetUpcomingBillsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetUpcomingBillsRequest create() => GetUpcomingBillsRequest._();
  GetUpcomingBillsRequest createEmptyInstance() => create();
  static $pb.PbList<GetUpcomingBillsRequest> createRepeated() => $pb.PbList<GetUpcomingBillsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetUpcomingBillsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetUpcomingBillsRequest>(create);
  static GetUpcomingBillsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get daysAhead => $_getIZ(0);
  @$pb.TagNumber(1)
  set daysAhead($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDaysAhead() => $_has(0);
  @$pb.TagNumber(1)
  void clearDaysAhead() => clearField(1);
}

class GetUpcomingBillsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetUpcomingBillsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<UpcomingBillsList>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'billsList', subBuilder: UpcomingBillsList.create)
    ..hasRequiredFields = false
  ;

  GetUpcomingBillsResponse._() : super();
  factory GetUpcomingBillsResponse({
    UpcomingBillsList? billsList,
  }) {
    final _result = create();
    if (billsList != null) {
      _result.billsList = billsList;
    }
    return _result;
  }
  factory GetUpcomingBillsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUpcomingBillsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUpcomingBillsResponse clone() => GetUpcomingBillsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUpcomingBillsResponse copyWith(void Function(GetUpcomingBillsResponse) updates) => super.copyWith((message) => updates(message as GetUpcomingBillsResponse)) as GetUpcomingBillsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetUpcomingBillsResponse create() => GetUpcomingBillsResponse._();
  GetUpcomingBillsResponse createEmptyInstance() => create();
  static $pb.PbList<GetUpcomingBillsResponse> createRepeated() => $pb.PbList<GetUpcomingBillsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetUpcomingBillsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetUpcomingBillsResponse>(create);
  static GetUpcomingBillsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  UpcomingBillsList get billsList => $_getN(0);
  @$pb.TagNumber(1)
  set billsList(UpcomingBillsList v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasBillsList() => $_has(0);
  @$pb.TagNumber(1)
  void clearBillsList() => clearField(1);
  @$pb.TagNumber(1)
  UpcomingBillsList ensureBillsList() => $_ensure(0);
}

class TrackedIncomeTransaction extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TrackedIncomeTransaction', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..a<$fixnum.Int64>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sourceType')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sourceId')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sourceReference')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'category')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..a<$fixnum.Int64>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'senderId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'senderName')
    ..aOM<$36.Timestamp>(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionDate', subBuilder: $36.Timestamp.create)
    ..aOS(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'metadata')
    ..aOM<$36.Timestamp>(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $36.Timestamp.create)
    ..hasRequiredFields = false
  ;

  TrackedIncomeTransaction._() : super();
  factory TrackedIncomeTransaction({
    $core.String? id,
    $fixnum.Int64? userId,
    $core.double? amount,
    $core.String? currency,
    $core.String? sourceType,
    $core.String? sourceId,
    $core.String? sourceReference,
    $core.String? category,
    $core.String? description,
    $fixnum.Int64? senderId,
    $core.String? senderName,
    $36.Timestamp? transactionDate,
    $core.String? metadata,
    $36.Timestamp? createdAt,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (sourceType != null) {
      _result.sourceType = sourceType;
    }
    if (sourceId != null) {
      _result.sourceId = sourceId;
    }
    if (sourceReference != null) {
      _result.sourceReference = sourceReference;
    }
    if (category != null) {
      _result.category = category;
    }
    if (description != null) {
      _result.description = description;
    }
    if (senderId != null) {
      _result.senderId = senderId;
    }
    if (senderName != null) {
      _result.senderName = senderName;
    }
    if (transactionDate != null) {
      _result.transactionDate = transactionDate;
    }
    if (metadata != null) {
      _result.metadata = metadata;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    return _result;
  }
  factory TrackedIncomeTransaction.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TrackedIncomeTransaction.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TrackedIncomeTransaction clone() => TrackedIncomeTransaction()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TrackedIncomeTransaction copyWith(void Function(TrackedIncomeTransaction) updates) => super.copyWith((message) => updates(message as TrackedIncomeTransaction)) as TrackedIncomeTransaction; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TrackedIncomeTransaction create() => TrackedIncomeTransaction._();
  TrackedIncomeTransaction createEmptyInstance() => create();
  static $pb.PbList<TrackedIncomeTransaction> createRepeated() => $pb.PbList<TrackedIncomeTransaction>();
  @$core.pragma('dart2js:noInline')
  static TrackedIncomeTransaction getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TrackedIncomeTransaction>(create);
  static TrackedIncomeTransaction? _defaultInstance;

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
  $core.double get amount => $_getN(2);
  @$pb.TagNumber(3)
  set amount($core.double v) { $_setDouble(2, v); }
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
  $core.String get sourceType => $_getSZ(4);
  @$pb.TagNumber(5)
  set sourceType($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasSourceType() => $_has(4);
  @$pb.TagNumber(5)
  void clearSourceType() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get sourceId => $_getSZ(5);
  @$pb.TagNumber(6)
  set sourceId($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasSourceId() => $_has(5);
  @$pb.TagNumber(6)
  void clearSourceId() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get sourceReference => $_getSZ(6);
  @$pb.TagNumber(7)
  set sourceReference($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasSourceReference() => $_has(6);
  @$pb.TagNumber(7)
  void clearSourceReference() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get category => $_getSZ(7);
  @$pb.TagNumber(8)
  set category($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasCategory() => $_has(7);
  @$pb.TagNumber(8)
  void clearCategory() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get description => $_getSZ(8);
  @$pb.TagNumber(9)
  set description($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasDescription() => $_has(8);
  @$pb.TagNumber(9)
  void clearDescription() => clearField(9);

  @$pb.TagNumber(10)
  $fixnum.Int64 get senderId => $_getI64(9);
  @$pb.TagNumber(10)
  set senderId($fixnum.Int64 v) { $_setInt64(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasSenderId() => $_has(9);
  @$pb.TagNumber(10)
  void clearSenderId() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get senderName => $_getSZ(10);
  @$pb.TagNumber(11)
  set senderName($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasSenderName() => $_has(10);
  @$pb.TagNumber(11)
  void clearSenderName() => clearField(11);

  @$pb.TagNumber(12)
  $36.Timestamp get transactionDate => $_getN(11);
  @$pb.TagNumber(12)
  set transactionDate($36.Timestamp v) { setField(12, v); }
  @$pb.TagNumber(12)
  $core.bool hasTransactionDate() => $_has(11);
  @$pb.TagNumber(12)
  void clearTransactionDate() => clearField(12);
  @$pb.TagNumber(12)
  $36.Timestamp ensureTransactionDate() => $_ensure(11);

  @$pb.TagNumber(13)
  $core.String get metadata => $_getSZ(12);
  @$pb.TagNumber(13)
  set metadata($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasMetadata() => $_has(12);
  @$pb.TagNumber(13)
  void clearMetadata() => clearField(13);

  @$pb.TagNumber(14)
  $36.Timestamp get createdAt => $_getN(13);
  @$pb.TagNumber(14)
  set createdAt($36.Timestamp v) { setField(14, v); }
  @$pb.TagNumber(14)
  $core.bool hasCreatedAt() => $_has(13);
  @$pb.TagNumber(14)
  void clearCreatedAt() => clearField(14);
  @$pb.TagNumber(14)
  $36.Timestamp ensureCreatedAt() => $_ensure(13);
}

class TrackedExpenditureTransaction extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TrackedExpenditureTransaction', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..a<$fixnum.Int64>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'expenseType')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'expenseId')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'expenseReference')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'category')
    ..a<$fixnum.Int64>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recipientId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recipientName')
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'merchant')
    ..aOS(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..aOM<$36.Timestamp>(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionDate', subBuilder: $36.Timestamp.create)
    ..aOS(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'metadata')
    ..aOM<$36.Timestamp>(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $36.Timestamp.create)
    ..hasRequiredFields = false
  ;

  TrackedExpenditureTransaction._() : super();
  factory TrackedExpenditureTransaction({
    $core.String? id,
    $fixnum.Int64? userId,
    $core.double? amount,
    $core.String? currency,
    $core.String? expenseType,
    $core.String? expenseId,
    $core.String? expenseReference,
    $core.String? category,
    $fixnum.Int64? recipientId,
    $core.String? recipientName,
    $core.String? merchant,
    $core.String? description,
    $36.Timestamp? transactionDate,
    $core.String? metadata,
    $36.Timestamp? createdAt,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (expenseType != null) {
      _result.expenseType = expenseType;
    }
    if (expenseId != null) {
      _result.expenseId = expenseId;
    }
    if (expenseReference != null) {
      _result.expenseReference = expenseReference;
    }
    if (category != null) {
      _result.category = category;
    }
    if (recipientId != null) {
      _result.recipientId = recipientId;
    }
    if (recipientName != null) {
      _result.recipientName = recipientName;
    }
    if (merchant != null) {
      _result.merchant = merchant;
    }
    if (description != null) {
      _result.description = description;
    }
    if (transactionDate != null) {
      _result.transactionDate = transactionDate;
    }
    if (metadata != null) {
      _result.metadata = metadata;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    return _result;
  }
  factory TrackedExpenditureTransaction.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TrackedExpenditureTransaction.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TrackedExpenditureTransaction clone() => TrackedExpenditureTransaction()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TrackedExpenditureTransaction copyWith(void Function(TrackedExpenditureTransaction) updates) => super.copyWith((message) => updates(message as TrackedExpenditureTransaction)) as TrackedExpenditureTransaction; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TrackedExpenditureTransaction create() => TrackedExpenditureTransaction._();
  TrackedExpenditureTransaction createEmptyInstance() => create();
  static $pb.PbList<TrackedExpenditureTransaction> createRepeated() => $pb.PbList<TrackedExpenditureTransaction>();
  @$core.pragma('dart2js:noInline')
  static TrackedExpenditureTransaction getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TrackedExpenditureTransaction>(create);
  static TrackedExpenditureTransaction? _defaultInstance;

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
  $core.double get amount => $_getN(2);
  @$pb.TagNumber(3)
  set amount($core.double v) { $_setDouble(2, v); }
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
  $core.String get expenseType => $_getSZ(4);
  @$pb.TagNumber(5)
  set expenseType($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasExpenseType() => $_has(4);
  @$pb.TagNumber(5)
  void clearExpenseType() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get expenseId => $_getSZ(5);
  @$pb.TagNumber(6)
  set expenseId($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasExpenseId() => $_has(5);
  @$pb.TagNumber(6)
  void clearExpenseId() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get expenseReference => $_getSZ(6);
  @$pb.TagNumber(7)
  set expenseReference($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasExpenseReference() => $_has(6);
  @$pb.TagNumber(7)
  void clearExpenseReference() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get category => $_getSZ(7);
  @$pb.TagNumber(8)
  set category($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasCategory() => $_has(7);
  @$pb.TagNumber(8)
  void clearCategory() => clearField(8);

  @$pb.TagNumber(9)
  $fixnum.Int64 get recipientId => $_getI64(8);
  @$pb.TagNumber(9)
  set recipientId($fixnum.Int64 v) { $_setInt64(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasRecipientId() => $_has(8);
  @$pb.TagNumber(9)
  void clearRecipientId() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get recipientName => $_getSZ(9);
  @$pb.TagNumber(10)
  set recipientName($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasRecipientName() => $_has(9);
  @$pb.TagNumber(10)
  void clearRecipientName() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get merchant => $_getSZ(10);
  @$pb.TagNumber(11)
  set merchant($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasMerchant() => $_has(10);
  @$pb.TagNumber(11)
  void clearMerchant() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get description => $_getSZ(11);
  @$pb.TagNumber(12)
  set description($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasDescription() => $_has(11);
  @$pb.TagNumber(12)
  void clearDescription() => clearField(12);

  @$pb.TagNumber(13)
  $36.Timestamp get transactionDate => $_getN(12);
  @$pb.TagNumber(13)
  set transactionDate($36.Timestamp v) { setField(13, v); }
  @$pb.TagNumber(13)
  $core.bool hasTransactionDate() => $_has(12);
  @$pb.TagNumber(13)
  void clearTransactionDate() => clearField(13);
  @$pb.TagNumber(13)
  $36.Timestamp ensureTransactionDate() => $_ensure(12);

  @$pb.TagNumber(14)
  $core.String get metadata => $_getSZ(13);
  @$pb.TagNumber(14)
  set metadata($core.String v) { $_setString(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasMetadata() => $_has(13);
  @$pb.TagNumber(14)
  void clearMetadata() => clearField(14);

  @$pb.TagNumber(15)
  $36.Timestamp get createdAt => $_getN(14);
  @$pb.TagNumber(15)
  set createdAt($36.Timestamp v) { setField(15, v); }
  @$pb.TagNumber(15)
  $core.bool hasCreatedAt() => $_has(14);
  @$pb.TagNumber(15)
  void clearCreatedAt() => clearField(15);
  @$pb.TagNumber(15)
  $36.Timestamp ensureCreatedAt() => $_ensure(14);
}

class GetTrackedIncomeRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetTrackedIncomeRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<$36.Timestamp>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'startDate', subBuilder: $36.Timestamp.create)
    ..aOM<$36.Timestamp>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'endDate', subBuilder: $36.Timestamp.create)
    ..hasRequiredFields = false
  ;

  GetTrackedIncomeRequest._() : super();
  factory GetTrackedIncomeRequest({
    $36.Timestamp? startDate,
    $36.Timestamp? endDate,
  }) {
    final _result = create();
    if (startDate != null) {
      _result.startDate = startDate;
    }
    if (endDate != null) {
      _result.endDate = endDate;
    }
    return _result;
  }
  factory GetTrackedIncomeRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTrackedIncomeRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetTrackedIncomeRequest clone() => GetTrackedIncomeRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetTrackedIncomeRequest copyWith(void Function(GetTrackedIncomeRequest) updates) => super.copyWith((message) => updates(message as GetTrackedIncomeRequest)) as GetTrackedIncomeRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetTrackedIncomeRequest create() => GetTrackedIncomeRequest._();
  GetTrackedIncomeRequest createEmptyInstance() => create();
  static $pb.PbList<GetTrackedIncomeRequest> createRepeated() => $pb.PbList<GetTrackedIncomeRequest>();
  @$core.pragma('dart2js:noInline')
  static GetTrackedIncomeRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetTrackedIncomeRequest>(create);
  static GetTrackedIncomeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $36.Timestamp get startDate => $_getN(0);
  @$pb.TagNumber(1)
  set startDate($36.Timestamp v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasStartDate() => $_has(0);
  @$pb.TagNumber(1)
  void clearStartDate() => clearField(1);
  @$pb.TagNumber(1)
  $36.Timestamp ensureStartDate() => $_ensure(0);

  @$pb.TagNumber(2)
  $36.Timestamp get endDate => $_getN(1);
  @$pb.TagNumber(2)
  set endDate($36.Timestamp v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasEndDate() => $_has(1);
  @$pb.TagNumber(2)
  void clearEndDate() => clearField(2);
  @$pb.TagNumber(2)
  $36.Timestamp ensureEndDate() => $_ensure(1);
}

class GetTrackedIncomeResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetTrackedIncomeResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.double>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalIncome', $pb.PbFieldType.OD)
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..hasRequiredFields = false
  ;

  GetTrackedIncomeResponse._() : super();
  factory GetTrackedIncomeResponse({
    $core.double? totalIncome,
    $core.bool? success,
  }) {
    final _result = create();
    if (totalIncome != null) {
      _result.totalIncome = totalIncome;
    }
    if (success != null) {
      _result.success = success;
    }
    return _result;
  }
  factory GetTrackedIncomeResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTrackedIncomeResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetTrackedIncomeResponse clone() => GetTrackedIncomeResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetTrackedIncomeResponse copyWith(void Function(GetTrackedIncomeResponse) updates) => super.copyWith((message) => updates(message as GetTrackedIncomeResponse)) as GetTrackedIncomeResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetTrackedIncomeResponse create() => GetTrackedIncomeResponse._();
  GetTrackedIncomeResponse createEmptyInstance() => create();
  static $pb.PbList<GetTrackedIncomeResponse> createRepeated() => $pb.PbList<GetTrackedIncomeResponse>();
  @$core.pragma('dart2js:noInline')
  static GetTrackedIncomeResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetTrackedIncomeResponse>(create);
  static GetTrackedIncomeResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get totalIncome => $_getN(0);
  @$pb.TagNumber(1)
  set totalIncome($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTotalIncome() => $_has(0);
  @$pb.TagNumber(1)
  void clearTotalIncome() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => clearField(2);
}

class GetTrackedExpenditureRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetTrackedExpenditureRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<$36.Timestamp>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'startDate', subBuilder: $36.Timestamp.create)
    ..aOM<$36.Timestamp>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'endDate', subBuilder: $36.Timestamp.create)
    ..hasRequiredFields = false
  ;

  GetTrackedExpenditureRequest._() : super();
  factory GetTrackedExpenditureRequest({
    $36.Timestamp? startDate,
    $36.Timestamp? endDate,
  }) {
    final _result = create();
    if (startDate != null) {
      _result.startDate = startDate;
    }
    if (endDate != null) {
      _result.endDate = endDate;
    }
    return _result;
  }
  factory GetTrackedExpenditureRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTrackedExpenditureRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetTrackedExpenditureRequest clone() => GetTrackedExpenditureRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetTrackedExpenditureRequest copyWith(void Function(GetTrackedExpenditureRequest) updates) => super.copyWith((message) => updates(message as GetTrackedExpenditureRequest)) as GetTrackedExpenditureRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetTrackedExpenditureRequest create() => GetTrackedExpenditureRequest._();
  GetTrackedExpenditureRequest createEmptyInstance() => create();
  static $pb.PbList<GetTrackedExpenditureRequest> createRepeated() => $pb.PbList<GetTrackedExpenditureRequest>();
  @$core.pragma('dart2js:noInline')
  static GetTrackedExpenditureRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetTrackedExpenditureRequest>(create);
  static GetTrackedExpenditureRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $36.Timestamp get startDate => $_getN(0);
  @$pb.TagNumber(1)
  set startDate($36.Timestamp v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasStartDate() => $_has(0);
  @$pb.TagNumber(1)
  void clearStartDate() => clearField(1);
  @$pb.TagNumber(1)
  $36.Timestamp ensureStartDate() => $_ensure(0);

  @$pb.TagNumber(2)
  $36.Timestamp get endDate => $_getN(1);
  @$pb.TagNumber(2)
  set endDate($36.Timestamp v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasEndDate() => $_has(1);
  @$pb.TagNumber(2)
  void clearEndDate() => clearField(2);
  @$pb.TagNumber(2)
  $36.Timestamp ensureEndDate() => $_ensure(1);
}

class GetTrackedExpenditureResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetTrackedExpenditureResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.double>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalExpenditure', $pb.PbFieldType.OD)
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..hasRequiredFields = false
  ;

  GetTrackedExpenditureResponse._() : super();
  factory GetTrackedExpenditureResponse({
    $core.double? totalExpenditure,
    $core.bool? success,
  }) {
    final _result = create();
    if (totalExpenditure != null) {
      _result.totalExpenditure = totalExpenditure;
    }
    if (success != null) {
      _result.success = success;
    }
    return _result;
  }
  factory GetTrackedExpenditureResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTrackedExpenditureResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetTrackedExpenditureResponse clone() => GetTrackedExpenditureResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetTrackedExpenditureResponse copyWith(void Function(GetTrackedExpenditureResponse) updates) => super.copyWith((message) => updates(message as GetTrackedExpenditureResponse)) as GetTrackedExpenditureResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetTrackedExpenditureResponse create() => GetTrackedExpenditureResponse._();
  GetTrackedExpenditureResponse createEmptyInstance() => create();
  static $pb.PbList<GetTrackedExpenditureResponse> createRepeated() => $pb.PbList<GetTrackedExpenditureResponse>();
  @$core.pragma('dart2js:noInline')
  static GetTrackedExpenditureResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetTrackedExpenditureResponse>(create);
  static GetTrackedExpenditureResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get totalExpenditure => $_getN(0);
  @$pb.TagNumber(1)
  set totalExpenditure($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTotalExpenditure() => $_has(0);
  @$pb.TagNumber(1)
  void clearTotalExpenditure() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => clearField(2);
}

class GetTrackedIncomeBreakdownRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetTrackedIncomeBreakdownRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<$36.Timestamp>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'startDate', subBuilder: $36.Timestamp.create)
    ..aOM<$36.Timestamp>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'endDate', subBuilder: $36.Timestamp.create)
    ..hasRequiredFields = false
  ;

  GetTrackedIncomeBreakdownRequest._() : super();
  factory GetTrackedIncomeBreakdownRequest({
    $36.Timestamp? startDate,
    $36.Timestamp? endDate,
  }) {
    final _result = create();
    if (startDate != null) {
      _result.startDate = startDate;
    }
    if (endDate != null) {
      _result.endDate = endDate;
    }
    return _result;
  }
  factory GetTrackedIncomeBreakdownRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTrackedIncomeBreakdownRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetTrackedIncomeBreakdownRequest clone() => GetTrackedIncomeBreakdownRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetTrackedIncomeBreakdownRequest copyWith(void Function(GetTrackedIncomeBreakdownRequest) updates) => super.copyWith((message) => updates(message as GetTrackedIncomeBreakdownRequest)) as GetTrackedIncomeBreakdownRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetTrackedIncomeBreakdownRequest create() => GetTrackedIncomeBreakdownRequest._();
  GetTrackedIncomeBreakdownRequest createEmptyInstance() => create();
  static $pb.PbList<GetTrackedIncomeBreakdownRequest> createRepeated() => $pb.PbList<GetTrackedIncomeBreakdownRequest>();
  @$core.pragma('dart2js:noInline')
  static GetTrackedIncomeBreakdownRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetTrackedIncomeBreakdownRequest>(create);
  static GetTrackedIncomeBreakdownRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $36.Timestamp get startDate => $_getN(0);
  @$pb.TagNumber(1)
  set startDate($36.Timestamp v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasStartDate() => $_has(0);
  @$pb.TagNumber(1)
  void clearStartDate() => clearField(1);
  @$pb.TagNumber(1)
  $36.Timestamp ensureStartDate() => $_ensure(0);

  @$pb.TagNumber(2)
  $36.Timestamp get endDate => $_getN(1);
  @$pb.TagNumber(2)
  set endDate($36.Timestamp v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasEndDate() => $_has(1);
  @$pb.TagNumber(2)
  void clearEndDate() => clearField(2);
  @$pb.TagNumber(2)
  $36.Timestamp ensureEndDate() => $_ensure(1);
}

class GetTrackedIncomeBreakdownResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetTrackedIncomeBreakdownResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..m<$core.String, $core.double>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'breakdownBySource', entryClassName: 'GetTrackedIncomeBreakdownResponse.BreakdownBySourceEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OD, packageName: const $pb.PackageName('pb'))
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalIncome', $pb.PbFieldType.OD)
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..hasRequiredFields = false
  ;

  GetTrackedIncomeBreakdownResponse._() : super();
  factory GetTrackedIncomeBreakdownResponse({
    $core.Map<$core.String, $core.double>? breakdownBySource,
    $core.double? totalIncome,
    $core.bool? success,
  }) {
    final _result = create();
    if (breakdownBySource != null) {
      _result.breakdownBySource.addAll(breakdownBySource);
    }
    if (totalIncome != null) {
      _result.totalIncome = totalIncome;
    }
    if (success != null) {
      _result.success = success;
    }
    return _result;
  }
  factory GetTrackedIncomeBreakdownResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTrackedIncomeBreakdownResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetTrackedIncomeBreakdownResponse clone() => GetTrackedIncomeBreakdownResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetTrackedIncomeBreakdownResponse copyWith(void Function(GetTrackedIncomeBreakdownResponse) updates) => super.copyWith((message) => updates(message as GetTrackedIncomeBreakdownResponse)) as GetTrackedIncomeBreakdownResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetTrackedIncomeBreakdownResponse create() => GetTrackedIncomeBreakdownResponse._();
  GetTrackedIncomeBreakdownResponse createEmptyInstance() => create();
  static $pb.PbList<GetTrackedIncomeBreakdownResponse> createRepeated() => $pb.PbList<GetTrackedIncomeBreakdownResponse>();
  @$core.pragma('dart2js:noInline')
  static GetTrackedIncomeBreakdownResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetTrackedIncomeBreakdownResponse>(create);
  static GetTrackedIncomeBreakdownResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.Map<$core.String, $core.double> get breakdownBySource => $_getMap(0);

  @$pb.TagNumber(2)
  $core.double get totalIncome => $_getN(1);
  @$pb.TagNumber(2)
  set totalIncome($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotalIncome() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalIncome() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get success => $_getBF(2);
  @$pb.TagNumber(3)
  set success($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSuccess() => $_has(2);
  @$pb.TagNumber(3)
  void clearSuccess() => clearField(3);
}

class GetTrackedExpenditureBreakdownRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetTrackedExpenditureBreakdownRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<$36.Timestamp>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'startDate', subBuilder: $36.Timestamp.create)
    ..aOM<$36.Timestamp>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'endDate', subBuilder: $36.Timestamp.create)
    ..hasRequiredFields = false
  ;

  GetTrackedExpenditureBreakdownRequest._() : super();
  factory GetTrackedExpenditureBreakdownRequest({
    $36.Timestamp? startDate,
    $36.Timestamp? endDate,
  }) {
    final _result = create();
    if (startDate != null) {
      _result.startDate = startDate;
    }
    if (endDate != null) {
      _result.endDate = endDate;
    }
    return _result;
  }
  factory GetTrackedExpenditureBreakdownRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTrackedExpenditureBreakdownRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetTrackedExpenditureBreakdownRequest clone() => GetTrackedExpenditureBreakdownRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetTrackedExpenditureBreakdownRequest copyWith(void Function(GetTrackedExpenditureBreakdownRequest) updates) => super.copyWith((message) => updates(message as GetTrackedExpenditureBreakdownRequest)) as GetTrackedExpenditureBreakdownRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetTrackedExpenditureBreakdownRequest create() => GetTrackedExpenditureBreakdownRequest._();
  GetTrackedExpenditureBreakdownRequest createEmptyInstance() => create();
  static $pb.PbList<GetTrackedExpenditureBreakdownRequest> createRepeated() => $pb.PbList<GetTrackedExpenditureBreakdownRequest>();
  @$core.pragma('dart2js:noInline')
  static GetTrackedExpenditureBreakdownRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetTrackedExpenditureBreakdownRequest>(create);
  static GetTrackedExpenditureBreakdownRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $36.Timestamp get startDate => $_getN(0);
  @$pb.TagNumber(1)
  set startDate($36.Timestamp v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasStartDate() => $_has(0);
  @$pb.TagNumber(1)
  void clearStartDate() => clearField(1);
  @$pb.TagNumber(1)
  $36.Timestamp ensureStartDate() => $_ensure(0);

  @$pb.TagNumber(2)
  $36.Timestamp get endDate => $_getN(1);
  @$pb.TagNumber(2)
  set endDate($36.Timestamp v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasEndDate() => $_has(1);
  @$pb.TagNumber(2)
  void clearEndDate() => clearField(2);
  @$pb.TagNumber(2)
  $36.Timestamp ensureEndDate() => $_ensure(1);
}

class GetTrackedExpenditureBreakdownResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetTrackedExpenditureBreakdownResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..m<$core.String, $core.double>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'breakdownByType', entryClassName: 'GetTrackedExpenditureBreakdownResponse.BreakdownByTypeEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OD, packageName: const $pb.PackageName('pb'))
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalExpenditure', $pb.PbFieldType.OD)
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..hasRequiredFields = false
  ;

  GetTrackedExpenditureBreakdownResponse._() : super();
  factory GetTrackedExpenditureBreakdownResponse({
    $core.Map<$core.String, $core.double>? breakdownByType,
    $core.double? totalExpenditure,
    $core.bool? success,
  }) {
    final _result = create();
    if (breakdownByType != null) {
      _result.breakdownByType.addAll(breakdownByType);
    }
    if (totalExpenditure != null) {
      _result.totalExpenditure = totalExpenditure;
    }
    if (success != null) {
      _result.success = success;
    }
    return _result;
  }
  factory GetTrackedExpenditureBreakdownResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTrackedExpenditureBreakdownResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetTrackedExpenditureBreakdownResponse clone() => GetTrackedExpenditureBreakdownResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetTrackedExpenditureBreakdownResponse copyWith(void Function(GetTrackedExpenditureBreakdownResponse) updates) => super.copyWith((message) => updates(message as GetTrackedExpenditureBreakdownResponse)) as GetTrackedExpenditureBreakdownResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetTrackedExpenditureBreakdownResponse create() => GetTrackedExpenditureBreakdownResponse._();
  GetTrackedExpenditureBreakdownResponse createEmptyInstance() => create();
  static $pb.PbList<GetTrackedExpenditureBreakdownResponse> createRepeated() => $pb.PbList<GetTrackedExpenditureBreakdownResponse>();
  @$core.pragma('dart2js:noInline')
  static GetTrackedExpenditureBreakdownResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetTrackedExpenditureBreakdownResponse>(create);
  static GetTrackedExpenditureBreakdownResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.Map<$core.String, $core.double> get breakdownByType => $_getMap(0);

  @$pb.TagNumber(2)
  $core.double get totalExpenditure => $_getN(1);
  @$pb.TagNumber(2)
  set totalExpenditure($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotalExpenditure() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalExpenditure() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get success => $_getBF(2);
  @$pb.TagNumber(3)
  set success($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSuccess() => $_has(2);
  @$pb.TagNumber(3)
  void clearSuccess() => clearField(3);
}

class GetTrackedIncomeTransactionsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetTrackedIncomeTransactionsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<$36.Timestamp>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'startDate', subBuilder: $36.Timestamp.create)
    ..aOM<$36.Timestamp>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'endDate', subBuilder: $36.Timestamp.create)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetTrackedIncomeTransactionsRequest._() : super();
  factory GetTrackedIncomeTransactionsRequest({
    $36.Timestamp? startDate,
    $36.Timestamp? endDate,
    $core.int? limit,
  }) {
    final _result = create();
    if (startDate != null) {
      _result.startDate = startDate;
    }
    if (endDate != null) {
      _result.endDate = endDate;
    }
    if (limit != null) {
      _result.limit = limit;
    }
    return _result;
  }
  factory GetTrackedIncomeTransactionsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTrackedIncomeTransactionsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetTrackedIncomeTransactionsRequest clone() => GetTrackedIncomeTransactionsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetTrackedIncomeTransactionsRequest copyWith(void Function(GetTrackedIncomeTransactionsRequest) updates) => super.copyWith((message) => updates(message as GetTrackedIncomeTransactionsRequest)) as GetTrackedIncomeTransactionsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetTrackedIncomeTransactionsRequest create() => GetTrackedIncomeTransactionsRequest._();
  GetTrackedIncomeTransactionsRequest createEmptyInstance() => create();
  static $pb.PbList<GetTrackedIncomeTransactionsRequest> createRepeated() => $pb.PbList<GetTrackedIncomeTransactionsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetTrackedIncomeTransactionsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetTrackedIncomeTransactionsRequest>(create);
  static GetTrackedIncomeTransactionsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $36.Timestamp get startDate => $_getN(0);
  @$pb.TagNumber(1)
  set startDate($36.Timestamp v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasStartDate() => $_has(0);
  @$pb.TagNumber(1)
  void clearStartDate() => clearField(1);
  @$pb.TagNumber(1)
  $36.Timestamp ensureStartDate() => $_ensure(0);

  @$pb.TagNumber(2)
  $36.Timestamp get endDate => $_getN(1);
  @$pb.TagNumber(2)
  set endDate($36.Timestamp v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasEndDate() => $_has(1);
  @$pb.TagNumber(2)
  void clearEndDate() => clearField(2);
  @$pb.TagNumber(2)
  $36.Timestamp ensureEndDate() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.int get limit => $_getIZ(2);
  @$pb.TagNumber(3)
  set limit($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasLimit() => $_has(2);
  @$pb.TagNumber(3)
  void clearLimit() => clearField(3);
}

class GetTrackedIncomeTransactionsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetTrackedIncomeTransactionsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<TrackedIncomeTransaction>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactions', $pb.PbFieldType.PM, subBuilder: TrackedIncomeTransaction.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalCount', $pb.PbFieldType.O3)
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..hasRequiredFields = false
  ;

  GetTrackedIncomeTransactionsResponse._() : super();
  factory GetTrackedIncomeTransactionsResponse({
    $core.Iterable<TrackedIncomeTransaction>? transactions,
    $core.int? totalCount,
    $core.bool? success,
  }) {
    final _result = create();
    if (transactions != null) {
      _result.transactions.addAll(transactions);
    }
    if (totalCount != null) {
      _result.totalCount = totalCount;
    }
    if (success != null) {
      _result.success = success;
    }
    return _result;
  }
  factory GetTrackedIncomeTransactionsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTrackedIncomeTransactionsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetTrackedIncomeTransactionsResponse clone() => GetTrackedIncomeTransactionsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetTrackedIncomeTransactionsResponse copyWith(void Function(GetTrackedIncomeTransactionsResponse) updates) => super.copyWith((message) => updates(message as GetTrackedIncomeTransactionsResponse)) as GetTrackedIncomeTransactionsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetTrackedIncomeTransactionsResponse create() => GetTrackedIncomeTransactionsResponse._();
  GetTrackedIncomeTransactionsResponse createEmptyInstance() => create();
  static $pb.PbList<GetTrackedIncomeTransactionsResponse> createRepeated() => $pb.PbList<GetTrackedIncomeTransactionsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetTrackedIncomeTransactionsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetTrackedIncomeTransactionsResponse>(create);
  static GetTrackedIncomeTransactionsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<TrackedIncomeTransaction> get transactions => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get totalCount => $_getIZ(1);
  @$pb.TagNumber(2)
  set totalCount($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotalCount() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalCount() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get success => $_getBF(2);
  @$pb.TagNumber(3)
  set success($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSuccess() => $_has(2);
  @$pb.TagNumber(3)
  void clearSuccess() => clearField(3);
}

class GetTrackedExpenditureTransactionsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetTrackedExpenditureTransactionsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<$36.Timestamp>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'startDate', subBuilder: $36.Timestamp.create)
    ..aOM<$36.Timestamp>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'endDate', subBuilder: $36.Timestamp.create)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetTrackedExpenditureTransactionsRequest._() : super();
  factory GetTrackedExpenditureTransactionsRequest({
    $36.Timestamp? startDate,
    $36.Timestamp? endDate,
    $core.int? limit,
  }) {
    final _result = create();
    if (startDate != null) {
      _result.startDate = startDate;
    }
    if (endDate != null) {
      _result.endDate = endDate;
    }
    if (limit != null) {
      _result.limit = limit;
    }
    return _result;
  }
  factory GetTrackedExpenditureTransactionsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTrackedExpenditureTransactionsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetTrackedExpenditureTransactionsRequest clone() => GetTrackedExpenditureTransactionsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetTrackedExpenditureTransactionsRequest copyWith(void Function(GetTrackedExpenditureTransactionsRequest) updates) => super.copyWith((message) => updates(message as GetTrackedExpenditureTransactionsRequest)) as GetTrackedExpenditureTransactionsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetTrackedExpenditureTransactionsRequest create() => GetTrackedExpenditureTransactionsRequest._();
  GetTrackedExpenditureTransactionsRequest createEmptyInstance() => create();
  static $pb.PbList<GetTrackedExpenditureTransactionsRequest> createRepeated() => $pb.PbList<GetTrackedExpenditureTransactionsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetTrackedExpenditureTransactionsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetTrackedExpenditureTransactionsRequest>(create);
  static GetTrackedExpenditureTransactionsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $36.Timestamp get startDate => $_getN(0);
  @$pb.TagNumber(1)
  set startDate($36.Timestamp v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasStartDate() => $_has(0);
  @$pb.TagNumber(1)
  void clearStartDate() => clearField(1);
  @$pb.TagNumber(1)
  $36.Timestamp ensureStartDate() => $_ensure(0);

  @$pb.TagNumber(2)
  $36.Timestamp get endDate => $_getN(1);
  @$pb.TagNumber(2)
  set endDate($36.Timestamp v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasEndDate() => $_has(1);
  @$pb.TagNumber(2)
  void clearEndDate() => clearField(2);
  @$pb.TagNumber(2)
  $36.Timestamp ensureEndDate() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.int get limit => $_getIZ(2);
  @$pb.TagNumber(3)
  set limit($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasLimit() => $_has(2);
  @$pb.TagNumber(3)
  void clearLimit() => clearField(3);
}

class GetTrackedExpenditureTransactionsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetTrackedExpenditureTransactionsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<TrackedExpenditureTransaction>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactions', $pb.PbFieldType.PM, subBuilder: TrackedExpenditureTransaction.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalCount', $pb.PbFieldType.O3)
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..hasRequiredFields = false
  ;

  GetTrackedExpenditureTransactionsResponse._() : super();
  factory GetTrackedExpenditureTransactionsResponse({
    $core.Iterable<TrackedExpenditureTransaction>? transactions,
    $core.int? totalCount,
    $core.bool? success,
  }) {
    final _result = create();
    if (transactions != null) {
      _result.transactions.addAll(transactions);
    }
    if (totalCount != null) {
      _result.totalCount = totalCount;
    }
    if (success != null) {
      _result.success = success;
    }
    return _result;
  }
  factory GetTrackedExpenditureTransactionsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTrackedExpenditureTransactionsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetTrackedExpenditureTransactionsResponse clone() => GetTrackedExpenditureTransactionsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetTrackedExpenditureTransactionsResponse copyWith(void Function(GetTrackedExpenditureTransactionsResponse) updates) => super.copyWith((message) => updates(message as GetTrackedExpenditureTransactionsResponse)) as GetTrackedExpenditureTransactionsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetTrackedExpenditureTransactionsResponse create() => GetTrackedExpenditureTransactionsResponse._();
  GetTrackedExpenditureTransactionsResponse createEmptyInstance() => create();
  static $pb.PbList<GetTrackedExpenditureTransactionsResponse> createRepeated() => $pb.PbList<GetTrackedExpenditureTransactionsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetTrackedExpenditureTransactionsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetTrackedExpenditureTransactionsResponse>(create);
  static GetTrackedExpenditureTransactionsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<TrackedExpenditureTransaction> get transactions => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get totalCount => $_getIZ(1);
  @$pb.TagNumber(2)
  set totalCount($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotalCount() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalCount() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get success => $_getBF(2);
  @$pb.TagNumber(3)
  set success($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSuccess() => $_has(2);
  @$pb.TagNumber(3)
  void clearSuccess() => clearField(3);
}

class GetComprehensiveFinancialSummaryRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetComprehensiveFinancialSummaryRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<$36.Timestamp>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'startDate', subBuilder: $36.Timestamp.create)
    ..aOM<$36.Timestamp>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'endDate', subBuilder: $36.Timestamp.create)
    ..hasRequiredFields = false
  ;

  GetComprehensiveFinancialSummaryRequest._() : super();
  factory GetComprehensiveFinancialSummaryRequest({
    $36.Timestamp? startDate,
    $36.Timestamp? endDate,
  }) {
    final _result = create();
    if (startDate != null) {
      _result.startDate = startDate;
    }
    if (endDate != null) {
      _result.endDate = endDate;
    }
    return _result;
  }
  factory GetComprehensiveFinancialSummaryRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetComprehensiveFinancialSummaryRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetComprehensiveFinancialSummaryRequest clone() => GetComprehensiveFinancialSummaryRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetComprehensiveFinancialSummaryRequest copyWith(void Function(GetComprehensiveFinancialSummaryRequest) updates) => super.copyWith((message) => updates(message as GetComprehensiveFinancialSummaryRequest)) as GetComprehensiveFinancialSummaryRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetComprehensiveFinancialSummaryRequest create() => GetComprehensiveFinancialSummaryRequest._();
  GetComprehensiveFinancialSummaryRequest createEmptyInstance() => create();
  static $pb.PbList<GetComprehensiveFinancialSummaryRequest> createRepeated() => $pb.PbList<GetComprehensiveFinancialSummaryRequest>();
  @$core.pragma('dart2js:noInline')
  static GetComprehensiveFinancialSummaryRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetComprehensiveFinancialSummaryRequest>(create);
  static GetComprehensiveFinancialSummaryRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $36.Timestamp get startDate => $_getN(0);
  @$pb.TagNumber(1)
  set startDate($36.Timestamp v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasStartDate() => $_has(0);
  @$pb.TagNumber(1)
  void clearStartDate() => clearField(1);
  @$pb.TagNumber(1)
  $36.Timestamp ensureStartDate() => $_ensure(0);

  @$pb.TagNumber(2)
  $36.Timestamp get endDate => $_getN(1);
  @$pb.TagNumber(2)
  set endDate($36.Timestamp v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasEndDate() => $_has(1);
  @$pb.TagNumber(2)
  void clearEndDate() => clearField(2);
  @$pb.TagNumber(2)
  $36.Timestamp ensureEndDate() => $_ensure(1);
}

class GetComprehensiveFinancialSummaryResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetComprehensiveFinancialSummaryResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<ComprehensiveFinancialSummary>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'summary', subBuilder: ComprehensiveFinancialSummary.create)
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..hasRequiredFields = false
  ;

  GetComprehensiveFinancialSummaryResponse._() : super();
  factory GetComprehensiveFinancialSummaryResponse({
    ComprehensiveFinancialSummary? summary,
    $core.bool? success,
  }) {
    final _result = create();
    if (summary != null) {
      _result.summary = summary;
    }
    if (success != null) {
      _result.success = success;
    }
    return _result;
  }
  factory GetComprehensiveFinancialSummaryResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetComprehensiveFinancialSummaryResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetComprehensiveFinancialSummaryResponse clone() => GetComprehensiveFinancialSummaryResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetComprehensiveFinancialSummaryResponse copyWith(void Function(GetComprehensiveFinancialSummaryResponse) updates) => super.copyWith((message) => updates(message as GetComprehensiveFinancialSummaryResponse)) as GetComprehensiveFinancialSummaryResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetComprehensiveFinancialSummaryResponse create() => GetComprehensiveFinancialSummaryResponse._();
  GetComprehensiveFinancialSummaryResponse createEmptyInstance() => create();
  static $pb.PbList<GetComprehensiveFinancialSummaryResponse> createRepeated() => $pb.PbList<GetComprehensiveFinancialSummaryResponse>();
  @$core.pragma('dart2js:noInline')
  static GetComprehensiveFinancialSummaryResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetComprehensiveFinancialSummaryResponse>(create);
  static GetComprehensiveFinancialSummaryResponse? _defaultInstance;

  @$pb.TagNumber(1)
  ComprehensiveFinancialSummary get summary => $_getN(0);
  @$pb.TagNumber(1)
  set summary(ComprehensiveFinancialSummary v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasSummary() => $_has(0);
  @$pb.TagNumber(1)
  void clearSummary() => clearField(1);
  @$pb.TagNumber(1)
  ComprehensiveFinancialSummary ensureSummary() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => clearField(2);
}

class ComprehensiveFinancialSummary extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ComprehensiveFinancialSummary', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<ComprehensivePeriod>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'period', subBuilder: ComprehensivePeriod.create)
    ..aOM<ComprehensiveIncomeData>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'income', subBuilder: ComprehensiveIncomeData.create)
    ..aOM<ComprehensiveExpenditureData>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'expenditure', subBuilder: ComprehensiveExpenditureData.create)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'netIncome', $pb.PbFieldType.OD)
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'savingsRate', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  ComprehensiveFinancialSummary._() : super();
  factory ComprehensiveFinancialSummary({
    ComprehensivePeriod? period,
    ComprehensiveIncomeData? income,
    ComprehensiveExpenditureData? expenditure,
    $core.double? netIncome,
    $core.double? savingsRate,
  }) {
    final _result = create();
    if (period != null) {
      _result.period = period;
    }
    if (income != null) {
      _result.income = income;
    }
    if (expenditure != null) {
      _result.expenditure = expenditure;
    }
    if (netIncome != null) {
      _result.netIncome = netIncome;
    }
    if (savingsRate != null) {
      _result.savingsRate = savingsRate;
    }
    return _result;
  }
  factory ComprehensiveFinancialSummary.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ComprehensiveFinancialSummary.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ComprehensiveFinancialSummary clone() => ComprehensiveFinancialSummary()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ComprehensiveFinancialSummary copyWith(void Function(ComprehensiveFinancialSummary) updates) => super.copyWith((message) => updates(message as ComprehensiveFinancialSummary)) as ComprehensiveFinancialSummary; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ComprehensiveFinancialSummary create() => ComprehensiveFinancialSummary._();
  ComprehensiveFinancialSummary createEmptyInstance() => create();
  static $pb.PbList<ComprehensiveFinancialSummary> createRepeated() => $pb.PbList<ComprehensiveFinancialSummary>();
  @$core.pragma('dart2js:noInline')
  static ComprehensiveFinancialSummary getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ComprehensiveFinancialSummary>(create);
  static ComprehensiveFinancialSummary? _defaultInstance;

  @$pb.TagNumber(1)
  ComprehensivePeriod get period => $_getN(0);
  @$pb.TagNumber(1)
  set period(ComprehensivePeriod v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasPeriod() => $_has(0);
  @$pb.TagNumber(1)
  void clearPeriod() => clearField(1);
  @$pb.TagNumber(1)
  ComprehensivePeriod ensurePeriod() => $_ensure(0);

  @$pb.TagNumber(2)
  ComprehensiveIncomeData get income => $_getN(1);
  @$pb.TagNumber(2)
  set income(ComprehensiveIncomeData v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasIncome() => $_has(1);
  @$pb.TagNumber(2)
  void clearIncome() => clearField(2);
  @$pb.TagNumber(2)
  ComprehensiveIncomeData ensureIncome() => $_ensure(1);

  @$pb.TagNumber(3)
  ComprehensiveExpenditureData get expenditure => $_getN(2);
  @$pb.TagNumber(3)
  set expenditure(ComprehensiveExpenditureData v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasExpenditure() => $_has(2);
  @$pb.TagNumber(3)
  void clearExpenditure() => clearField(3);
  @$pb.TagNumber(3)
  ComprehensiveExpenditureData ensureExpenditure() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.double get netIncome => $_getN(3);
  @$pb.TagNumber(4)
  set netIncome($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasNetIncome() => $_has(3);
  @$pb.TagNumber(4)
  void clearNetIncome() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get savingsRate => $_getN(4);
  @$pb.TagNumber(5)
  set savingsRate($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasSavingsRate() => $_has(4);
  @$pb.TagNumber(5)
  void clearSavingsRate() => clearField(5);
}

class ComprehensivePeriod extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ComprehensivePeriod', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<$36.Timestamp>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'startDate', subBuilder: $36.Timestamp.create)
    ..aOM<$36.Timestamp>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'endDate', subBuilder: $36.Timestamp.create)
    ..hasRequiredFields = false
  ;

  ComprehensivePeriod._() : super();
  factory ComprehensivePeriod({
    $36.Timestamp? startDate,
    $36.Timestamp? endDate,
  }) {
    final _result = create();
    if (startDate != null) {
      _result.startDate = startDate;
    }
    if (endDate != null) {
      _result.endDate = endDate;
    }
    return _result;
  }
  factory ComprehensivePeriod.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ComprehensivePeriod.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ComprehensivePeriod clone() => ComprehensivePeriod()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ComprehensivePeriod copyWith(void Function(ComprehensivePeriod) updates) => super.copyWith((message) => updates(message as ComprehensivePeriod)) as ComprehensivePeriod; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ComprehensivePeriod create() => ComprehensivePeriod._();
  ComprehensivePeriod createEmptyInstance() => create();
  static $pb.PbList<ComprehensivePeriod> createRepeated() => $pb.PbList<ComprehensivePeriod>();
  @$core.pragma('dart2js:noInline')
  static ComprehensivePeriod getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ComprehensivePeriod>(create);
  static ComprehensivePeriod? _defaultInstance;

  @$pb.TagNumber(1)
  $36.Timestamp get startDate => $_getN(0);
  @$pb.TagNumber(1)
  set startDate($36.Timestamp v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasStartDate() => $_has(0);
  @$pb.TagNumber(1)
  void clearStartDate() => clearField(1);
  @$pb.TagNumber(1)
  $36.Timestamp ensureStartDate() => $_ensure(0);

  @$pb.TagNumber(2)
  $36.Timestamp get endDate => $_getN(1);
  @$pb.TagNumber(2)
  set endDate($36.Timestamp v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasEndDate() => $_has(1);
  @$pb.TagNumber(2)
  void clearEndDate() => clearField(2);
  @$pb.TagNumber(2)
  $36.Timestamp ensureEndDate() => $_ensure(1);
}

class ComprehensiveIncomeData extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ComprehensiveIncomeData', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.double>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'manualIncome', $pb.PbFieldType.OD)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'trackedIncome', $pb.PbFieldType.OD)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalIncome', $pb.PbFieldType.OD)
    ..m<$core.String, $core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'incomeBreakdown', entryClassName: 'ComprehensiveIncomeData.IncomeBreakdownEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OD, packageName: const $pb.PackageName('pb'))
    ..hasRequiredFields = false
  ;

  ComprehensiveIncomeData._() : super();
  factory ComprehensiveIncomeData({
    $core.double? manualIncome,
    $core.double? trackedIncome,
    $core.double? totalIncome,
    $core.Map<$core.String, $core.double>? incomeBreakdown,
  }) {
    final _result = create();
    if (manualIncome != null) {
      _result.manualIncome = manualIncome;
    }
    if (trackedIncome != null) {
      _result.trackedIncome = trackedIncome;
    }
    if (totalIncome != null) {
      _result.totalIncome = totalIncome;
    }
    if (incomeBreakdown != null) {
      _result.incomeBreakdown.addAll(incomeBreakdown);
    }
    return _result;
  }
  factory ComprehensiveIncomeData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ComprehensiveIncomeData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ComprehensiveIncomeData clone() => ComprehensiveIncomeData()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ComprehensiveIncomeData copyWith(void Function(ComprehensiveIncomeData) updates) => super.copyWith((message) => updates(message as ComprehensiveIncomeData)) as ComprehensiveIncomeData; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ComprehensiveIncomeData create() => ComprehensiveIncomeData._();
  ComprehensiveIncomeData createEmptyInstance() => create();
  static $pb.PbList<ComprehensiveIncomeData> createRepeated() => $pb.PbList<ComprehensiveIncomeData>();
  @$core.pragma('dart2js:noInline')
  static ComprehensiveIncomeData getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ComprehensiveIncomeData>(create);
  static ComprehensiveIncomeData? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get manualIncome => $_getN(0);
  @$pb.TagNumber(1)
  set manualIncome($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasManualIncome() => $_has(0);
  @$pb.TagNumber(1)
  void clearManualIncome() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get trackedIncome => $_getN(1);
  @$pb.TagNumber(2)
  set trackedIncome($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTrackedIncome() => $_has(1);
  @$pb.TagNumber(2)
  void clearTrackedIncome() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get totalIncome => $_getN(2);
  @$pb.TagNumber(3)
  set totalIncome($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTotalIncome() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalIncome() => clearField(3);

  @$pb.TagNumber(4)
  $core.Map<$core.String, $core.double> get incomeBreakdown => $_getMap(3);
}

class ComprehensiveExpenditureData extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ComprehensiveExpenditureData', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.double>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'manualExpenses', $pb.PbFieldType.OD)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'trackedExpenditure', $pb.PbFieldType.OD)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalExpenditure', $pb.PbFieldType.OD)
    ..m<$core.String, $core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'expenditureBreakdown', entryClassName: 'ComprehensiveExpenditureData.ExpenditureBreakdownEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OD, packageName: const $pb.PackageName('pb'))
    ..hasRequiredFields = false
  ;

  ComprehensiveExpenditureData._() : super();
  factory ComprehensiveExpenditureData({
    $core.double? manualExpenses,
    $core.double? trackedExpenditure,
    $core.double? totalExpenditure,
    $core.Map<$core.String, $core.double>? expenditureBreakdown,
  }) {
    final _result = create();
    if (manualExpenses != null) {
      _result.manualExpenses = manualExpenses;
    }
    if (trackedExpenditure != null) {
      _result.trackedExpenditure = trackedExpenditure;
    }
    if (totalExpenditure != null) {
      _result.totalExpenditure = totalExpenditure;
    }
    if (expenditureBreakdown != null) {
      _result.expenditureBreakdown.addAll(expenditureBreakdown);
    }
    return _result;
  }
  factory ComprehensiveExpenditureData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ComprehensiveExpenditureData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ComprehensiveExpenditureData clone() => ComprehensiveExpenditureData()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ComprehensiveExpenditureData copyWith(void Function(ComprehensiveExpenditureData) updates) => super.copyWith((message) => updates(message as ComprehensiveExpenditureData)) as ComprehensiveExpenditureData; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ComprehensiveExpenditureData create() => ComprehensiveExpenditureData._();
  ComprehensiveExpenditureData createEmptyInstance() => create();
  static $pb.PbList<ComprehensiveExpenditureData> createRepeated() => $pb.PbList<ComprehensiveExpenditureData>();
  @$core.pragma('dart2js:noInline')
  static ComprehensiveExpenditureData getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ComprehensiveExpenditureData>(create);
  static ComprehensiveExpenditureData? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get manualExpenses => $_getN(0);
  @$pb.TagNumber(1)
  set manualExpenses($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasManualExpenses() => $_has(0);
  @$pb.TagNumber(1)
  void clearManualExpenses() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get trackedExpenditure => $_getN(1);
  @$pb.TagNumber(2)
  set trackedExpenditure($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTrackedExpenditure() => $_has(1);
  @$pb.TagNumber(2)
  void clearTrackedExpenditure() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get totalExpenditure => $_getN(2);
  @$pb.TagNumber(3)
  set totalExpenditure($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTotalExpenditure() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalExpenditure() => clearField(3);

  @$pb.TagNumber(4)
  $core.Map<$core.String, $core.double> get expenditureBreakdown => $_getMap(3);
}

